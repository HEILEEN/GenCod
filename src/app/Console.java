package app;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Vector;

import app.db.DbConnection;
import app.db.DbParams;

public class Console {

	private String[] params;
	private Properties defaultProperties;
	private Properties properties;
	private DbConnection db;
	private HashMap<String, String> lastMapa;
	
	public Console(Properties properties) throws Exception{
		this.defaultProperties = (Properties)properties.clone();
		this.properties = properties;
		
		changeConfig( properties.getProperty("project"), null );
	}

	public String[] getParams() {
		return params;
	}

	public void setParams(String[] params) {
		this.params = params;
	}
	
	public void printConfig(boolean b){
		Vector<String> configNames = new Vector<String>();			
		configNames.add( "app_name" );
		configNames.add( "packages" ); 
		configNames.add( "jdbc_driver" );
		configNames.add( "jdbc_string" );
		configNames.add( "jdbc_user" );
		configNames.add( "jdbc_pass" );
		configNames.add( "database" );
		configNames.add( "catalog_name" ); 
		configNames.add( "conn_name" );
		configNames.add( "project" );
		configNames.add( "path_out" );
		configNames.add( "table_name" ); 
		configNames.add( "template_name" );
				
		System.out.println(" Config options: ");		
		
		String key;
		String space = ""; for( int i=0; i<50; i++ ) space += " ";
		
		Enumeration<Object> keysEnum = this.properties.keys();
		Vector<String> keyList = new Vector<String>();		
		
		while (keysEnum.hasMoreElements()) {
			key = (String) keysEnum.nextElement();
			
			if( !configNames.contains( key ) )
				keyList.add( key );
		}
		Collections.sort(keyList);
		
		System.out.println("-- ACTIVES: \n");
		for( Object okey : configNames ){
			key = (String)okey;
			System.out.println(" \t*" + key + ": " + space.substring(0, space.length() - key.length()) + this.properties.getProperty(key));
		}
		
		if( b ){
			System.out.println("\n\n -- INACTIVES: \n");
			for( Object okey : keyList ){
				key = (String)okey;
				System.out.println(" \t*" + key + ": " + space.substring(0, space.length() - key.length()) + this.properties.getProperty(key));
			}
		}
	}
	
	public void changeConfig(String config, String database) throws Exception{
		String key;
		
		if( "default".equals(config) ){
			this.properties = (Properties)this.defaultProperties.clone();
		}else{			
			this.properties = (Properties)this.defaultProperties.clone();
			this.properties.setProperty("project", config);
			
			for( Object okey : this.properties.keySet() ){
				key = (String)okey;
				
				if( key.startsWith(config+".") ){
					this.properties.put(key.replace(config+".", ""), this.defaultProperties.getProperty(key));
				}
			}
		}
		
		String dbkey = (database != null) ? database : this.defaultProperties.getProperty("database");
		for( Object okey : this.defaultProperties.keySet() ){
			key = (String)okey;
			
			if( key.startsWith(dbkey+".") ){
				this.properties.put(key.replace(dbkey+".", ""), this.defaultProperties.getProperty(key));
			}
		}
						
		printConfig(false);
		
		if( db != null )
			db.close();
		
		DbParams pr = new DbParams(propToMap(properties));
		this.db = new DbConnection(pr);
	}
	
	private void setConfig() throws Exception {
		if( params.length <= 1 || (params.length == 2 && "all".equals( params[1] )) ){
			printConfig( (params.length == 2) );
			return;
		}
		
		String database = ( params.length > 2 ) ? params[2] : null;
		
		changeConfig(params[1], database);
	}
	
	public List<String> listarTablas(String filter) throws Exception{
		DatabaseMetaData md = db.getConnection().getMetaData();
		ResultSet rs = md.getTables(this.properties.getProperty("catalog_name", null), null, filter, null);
		List<String> tablas = new ArrayList<String>();
		
		while (rs.next()) {
			tablas.add( rs.getString(3).toUpperCase() );
		}
		
		return tablas;
	}
	
	public void listar() throws Exception{
		String filter = "%";
		
		if( params.length > 1 ){
			filter = params[1];
		}
		
		for ( String tabla : listarTablas(filter) ) {
			System.out.println( tabla );
		}
	}
	
	public void generate() throws Exception{
		HashMap<String, String> mapa = MainClass.mapParams(params, 1, params.length);
		
		if( mapa.containsKey("last") && this.lastMapa != null ){
			mapa = this.lastMapa;
		}
		this.lastMapa = mapa;
		
		mapa = mergePropertiesMap(mapa, properties);
		String[] tables;
		
		if( mapa.containsKey("tables") ){			
			String[] tmpTables = mapa.get("tables").split(",");
			List<String> resTables;
			List<String> lista = new ArrayList<String>();
			
			for( String table : tmpTables ){
				if( table.contains("%") ){
					resTables = listarTablas(table);
					
					for( String subTable : resTables ){
						lista.add( subTable );
					}
				}else{
					lista.add( table );
				}
			}
			
			tables = lista.toArray(new String[]{});
		}else{
			tables = new String[]{ mapa.get("table_name") };
		}
		
		try {
			String gtablas = "";
			for( int i=0; i<tables.length;i++ ){
				gtablas += " " + tables[i];
			}
			System.out.println("TABLAS: " + gtablas);
			
			for( int i=0; i<tables.length;i++ ){
				mapa.put("table_name", tables[i]);
				new MainClass(mapa, this.db);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public HashMap<String, String> mergePropertiesMap(HashMap<String, String> mapa, Properties properties){
		HashMap<String, String> merge = null;
		
		if( mapa != null && properties != null ){
			merge = new HashMap<String, String>();
			
			for( Object key : properties.keySet() ){
				merge.put((String)key, (String)properties.get(key));
			}
			
			merge.putAll( mapa );
		}
		
		return merge;
	}
	
	public Map<String, String> propToMap(Properties properties){
		Map<String, String> map = null;
		
		if( properties != null ){
			map = new HashMap<String,String>();
			
			for( Object key : properties.keySet() ){
				map.put( (String)key, properties.getProperty((String)key) );
			}
		}
		
		return map;
	}
	
	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		Properties properties = new Properties();
		try {
		    properties.load(new FileInputStream("default.properties"));
		} catch (IOException e) {
			System.out.println("Error al cargar el archivo de configuracion.");
			return;
		}
		
		CMD cmd;
		String[] cmds;
		Console console = new Console(properties);;
		
		while(true){
			System.out.print("$ ");
			cmds = in.readLine().split(" ");			
			console.setParams(cmds);
			
			try{
				cmd = CMD.valueOf( cmds[0] );
			}catch (Exception e) {
				System.out.println("Error al procesar el comando: " + cmds[0]);
				continue;
			}
			
			switch ( cmd ) {
				case generate: console.generate(); break; 
				case list: console.listar(); break; 
				case setconfig: console.setConfig(); break;
				case help: console.help(); break;
				case exit: return;
			}
		}
		
	}

	private void help() {
		System.out.println("         -- HELP -- \n");
		System.out.println(" generate  [tables=[TABLE%],[TABLE%]] ");
		System.out.println(" list      [TABLE%] ");
		System.out.println(" setconfig [CONFIG] [DATABASE] ");
		System.out.println(" exit \n");
	}

	static enum CMD { generate, list, setconfig, help, exit }
	static InputStreamReader converter = new InputStreamReader(System.in);
	static BufferedReader in = new BufferedReader(converter);
}
