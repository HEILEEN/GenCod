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
			//DbParams pr = new DbParams(map);
			//String p;
			
			if( //map.containsKey("jdbc_driver")	&& map.containsKey("jdbc_string") 		&&
				//map.containsKey("jdbc_user")	&& map.containsKey("jdbc_pass")   		&&
				map.containsKey("table_name")	&& map.containsKey("catalog_name") 		&&
				map.containsKey("template_name")&& map.containsKey("packages")			&& 
				map.containsKey("conn_name")    && map.containsKey("app_name")){
				
				//DbConnection db = new DbConnection(pr);
				//System.out.println(pr.getCadena());
				//db.Select("SELECT * FROM BAS_USER ");
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
				} //*/
				
				/*System.out.println("Product Name: " + db.getConnection().getMetaData().getDatabaseProductName());
				System.out.println("Product Version: " + db.getConnection().getMetaData().getDatabaseProductVersion());
				System.out.println("Nombre del JDBC: " + db.getConnection().getMetaData().getDriverVersion());
				System.out.println("Version del JDBC: " + db.getConnection().getMetaData().getJDBCMajorVersion());
				System.out.println("URL: " + db.getConnection().getMetaData().getURL());*/
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
		/*DbParams pr = new DbParams("com.mysql.jdbc.Driver", "jdbc:mysql://localhost:3306/zkwork", "root", "");
		String sql = "SELECT * FROM ciudadano WHERE cedula IN (?) and nombre like ? ";
		
		try {
			DbConnection db = new DbConnection(pr);
			int[] vals = new int[]{14, 15, 18};
			Object[] params = new Object[]{ vals, "%jor%" };
			
			ResultSet rs = db.Select(sql, params);			
			while(rs.next()){
				System.out.println(rs.getString(1));
				System.out.println(rs.getString(2));
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
		String alfo = "a,b, c,  d";
		String[] partes = alfo.split(",");
		
		for(String i: partes){
			System.out.println(i.trim());
		}
	}
	
	/*public static void main(String[] args){
		System.out.println("\70\71\65"); // octal
		//pruebas();
				
		String[] args_p1;
		String[] args_p2;
		
		/*args_p1 = new String[]{
				"jdbc_driver=com.mysql.jdbc.Driver", 
				"jdbc_string=jdbc:mysql://localhost:3306/zkwork", 
				"jdbc_user=root", 
				"jdbc_pass=", 
				"table_name=ciudadano",
				"catalog_name=",
				"packages=apps.prueba",
				"template_name=CRUD",
				"conn_name=DbCon"
		}; */
		
		/*args_p1 = new String[]{
				"jdbc_driver=oracle.jdbc.OracleDriver", 
				"jdbc_string=jdbc:oracle:thin:@10.0.0.94:1528:kpitallb", 
				"jdbc_user=akcwww", 
				"jdbc_pass=akcwww", 
				"table_name=BAS_TABLAS", 
				"catalog_name=",
				"packages=apps.prueba",
				"template_name=CRUD",
				"conn_name=DbCon",
				"app_name=LabMedidores"
		}; 		
		
		/*args_p2 = new String[]{
				"jdbc_driver=com.mysql.jdbc.Driver", 
				"jdbc_string=jdbc:mysql://localhost:3306/zkwork", 
				"jdbc_user=root", 
				"jdbc_pass=", 
				"table_name=tipo_persona",
				"catalog_name=",
				"packages=apps.prueba",
				"template_name=CRUD",
				"conn_name=DbCon"
		}; */
		
		/*String[] appName = new String[]{"base", "labmedidores", "resetpwd", "actividades", "terminales"};
		String[][] gen = new String[][]{
				{"BAS_TABLAS",		appName[0]}, //0
				{"BAS_APP",			appName[0]},
				{"BAS_ROLEPERM",	appName[0]}, //2
				{"BAS_MODUROPE",	appName[0]},
				{"BAS_MODULO",		appName[0]}, //4
				{"BAS_I18N",		appName[0]},
				{"BAS_USER",		appName[0]}, //6
				{"BAS_USERROLE",	appName[0]}, 
				
				{"LME_TABLAS",		appName[1]}, //6
				{"LME_MARCA",		appName[1]},
				{"LME_MODELO",		appName[1]}, //8
				{"LME_CLIENTE",		appName[1]},
				{"LME_PROPIETARIO",	appName[1]}, //10
				{"LME_MEDIDOR",		appName[1]},
				{"LME_ORDEN",		appName[1]}, //12
				{"LME_ORDEMEDI",	appName[1]},
				{"LME_MEDIANOM",	appName[1]}, //14 //{"LME_MOTIVO",		appName[1]},
				{"LME_MONTADA",		appName[1]}, 
				{"LME_MONTDETA",	appName[1]}, //16
				{"LME_PRUEBA",		appName[1]},
				{"LME_SUBPRUEBA",	appName[1]}, //18
				{"LME_PRUEDETA",	appName[1]},
				{"LME_FORMULA",		appName[1]}, //20
				{"LME_CERTIFICADO",	appName[1]},
				{"LME_CERTARCH",	appName[1]}, //22
				{"LME_CONSULTA",	appName[1]},
				{"LME_PARAMETRO",	appName[1]}, //24
				{"LME_INFORME",		appName[1]}, 
				
				{"RPW_APLICACION",	appName[2]},
				{"RPW_LOGS",		appName[2]}, //26
				{"RPW_USUARIO",		appName[2]},
				{"RPW_USUAAPLI",	appName[2]}, //28
				{"RPW_REGISTRO",	appName[2]}, 
				
				{"ACT_TABLAS",		appName[3]}, //30
				{"ACT_PERSONA",		appName[3]},
				{"ACT_CARGO",		appName[3]}, //32
				{"ACT_DEPENDENCIA",	appName[3]},
				{"ACT_DEPECARG",	appName[3]}, //34
				{"ACT_NOTA",		appName[3]},
				
				{"TER_IDLOG",		appName[4]},
		};
		
		int actual = gen.length - 1;	
		//actual = 7;
		
		//for(int actual=0;actual <gen.length; actual++){
		
			/*args_p2 = new String[]{
					"jdbc_driver=oracle.jdbc.OracleDriver", 
					"jdbc_string=jdbc:oracle:thin:@10.0.0.94:1528:kpitallb", 
					"jdbc_user=akcwww", 
					"jdbc_pass=akcwww", 
					"table_name=" + gen[actual][0], 
					"catalog_name=",
					"packages=" + gen[actual][1],
					"template_name=ExtJS\\CRUD",
					"conn_name=DbCon",
					"app_name=" + gen[actual][1]
			}; //*/
			/*args_p2 = new String[]{
					"jdbc_driver=com.mysql.jdbc.Driver", 
					"jdbc_string=jdbc:mysql://localhost:3306/akcwwwpr", 
					"jdbc_user=root", 
					"jdbc_pass=", 
					"table_name=" + gen[actual][0], 
					"catalog_name=",
					"packages=" + gen[actual][1],
					"template_name=ExtJS\\CRUD2",
					"conn_name=jdbc/MySqlDB",
					"app_name=" + gen[actual][1]
			}; 
			
			try {
				//new MainClass(mapParams(args_p1));
				new MainClass(mapParams(args_p2));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		//}
	}*/
}
