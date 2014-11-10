package app;

import java.io.File;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Enumeration;
import java.util.HashMap;

import app.db.DbConnection;
import app.db.DbParams;
import app.io.ReadConfig;
import app.template.GenTemplate;
import app.template.GenTemplate2;

public class MainClass {
	/*
	 * Parametros a utilizar
	 * 
	 * jdbc_driver
	 * jdbc_string
	 * jdbc_user
	 * jdbc_pass
	 * 
	 * table_name
	 * packages
	 * template_name
	 */
	public MainClass(HashMap<String, String> map, DbConnection db) throws Exception{
		if(map != null && map.size() > 7 ){
			
			if( map.containsKey("table_name")	&& map.containsKey("catalog_name") 		&&
				map.containsKey("template_name")&& map.containsKey("packages")			&& 
				map.containsKey("conn_name")    && map.containsKey("app_name")){
				
				GenTemplate2 go;
				
				String template_dir = "src\\templates\\" + map.get("template_name") ; 
				ReadConfig config = new ReadConfig(template_dir + "\\config.properties");
				Enumeration<Object> keys;
				String key;
				
				keys = config.getKeys();
				while(keys.hasMoreElements()){
					key = (String)keys.nextElement();								
					
					go = new GenTemplate2
					(
						db, 					// Db Connection
						map.get("table_name"), 	// Tables
						map.get("catalog_name"),// Nombre del catalogo al que pertenece la tabla
						template_dir, 			// Template Directory
						key, 					// Template File
						config.get(key), 		// Template Name File
						map.get("packages"), 	// Packages
						map.get("conn_name"),	// Conexion asociada
						map.get("app_name")
					);
				    go.GenerateST(map.get("path_out"));
				}
				
			}
				
		}else{
			throw new Exception("Faltan parametros ... ");
		}
	}
	
	static public HashMap<String, String> mapParams(String[] arg){
		return mapParams(arg, 0, arg.length);
	}
	
	static public HashMap<String, String> mapParams(String[] arg, int ini, int fin){
		HashMap<String, String> map = new HashMap<String, String>();
		String[] p;
		String name;
		String value;
		
		for(int i=ini; i<arg.length && i<fin; i++){
			p 		= arg[i].split("=");
			name 	= "";
			value 	= "";
			
			if(p.length > 0)
				name = p[0];
			
			if(p.length > 1)
			{
				String sep = "";
				for(int j=1; j<p.length; j++){
					value = value + sep + p[j];
					sep = "=";
				}
			}
			
			map.put(name, value);
		}			
		
		return map;
	}
	
	public static void pruebas(){
		
		String alfo = "a,b, c,  d";
		String[] partes = alfo.split(",");
		
		for(String i: partes){
			System.out.println(i.trim());
		}
	}		
}
