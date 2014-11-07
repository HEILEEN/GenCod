package app.template;

import java.io.File;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;

import org.antlr.stringtemplate.StringTemplate;
/*import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;*/

import app.db.DbConnection;
import app.io.RWFile;
import app.string.UString;

public class GenTemplate {
	private String dir;
	private String name;
	private String catalogo;
	private String connName;	
	private String[] tables;
	private String[] packages;
	private String nameFile;
	private ResultSetMetaData md;
	private DbConnection db;
	private HashMap<String, String> mapa;
	private HashMap<String, Integer> mapaType;
	private HashMap<String, String> mapaPk;
	private HashMap<String, String[]> mapaFk;
	
	public GenTemplate(DbConnection db, String table, String catalogo, String dir, String name, String nameFile, String packages, String connName) throws SQLException{
		this.db = db;
		this.dir = dir;
		this.name = name;
		this.tables = table.split(",");
		this.catalogo = catalogo;
		this.nameFile = nameFile;
		this.connName = connName;
		this.packages = packages.split(",");
	}
	
	public void GenerateST() throws SQLException{
		
		String dSeparator = "\\";
		String plantilla = RWFile.getContents(dir + dSeparator + name);
		
		StringTemplate code = new StringTemplate(plantilla);
		int i = 0;
		String object_number;
		String dTmp = "tmp" + dSeparator;
		String[] keys;
		String[] keysPk;
		
		String dOut = UString.getJavaName(tables[0]);
		(new File(dTmp + dOut)).mkdir();
		(new File(dTmp + dOut + dSeparator + "Model")).mkdir();
		(new File(dTmp + dOut + dSeparator + "Class")).mkdir();
		(new File(dTmp + dOut + dSeparator + "Zul")).mkdir();
		
		for(String table: tables)
		{	
			ResultSet rs = db.Select("SELECT * FROM " + table);
			md = rs.getMetaData();
			
			int num = md.getColumnCount();
			
			keys = new String[num];
			mapa = new HashMap<String, String>();
			mapaType = new HashMap<String, Integer>();
			
			for(int n=1; n<=num; n++){
				mapa.put(md.getColumnName(n), md.getColumnClassName(n));
				mapaType.put(md.getColumnName(n), new Integer(md.getColumnType(n)));
				keys[n-1] = md.getColumnName(n);
			}
			
			DatabaseMetaData rsmd = db.getConnection().getMetaData();			
			rs = rsmd.getImportedKeys(catalogo, null, table);
			
			mapaFk = new HashMap<String, String[]>();
			String pkTableName 	= "PKTABLE_NAME";
			String pkColumnName = "PKCOLUMN_NAME";
			String fkTableName 	= "FKTABLE_NAME";
			String fkColumnName = "FKCOLUMN_NAME";
			String fkName 		= "FK_NAME";
			String[] val;
			String key;
			
			object_number = Integer.toString(i);
			
			while(rs.next()){
				key = rs.getString(fkColumnName);
				
					val = new String[]{  
							mapa.get(key),
							rs.getString(pkTableName),
							rs.getString(pkColumnName),
							rs.getString(fkTableName),
							rs.getString(fkColumnName),
							rs.getString(fkName)						
					};
					
					mapaFk.put(key, val);
					code.setAttribute("object" + object_number + "_lst_fk_atributes_name_l", key);
					code.setAttribute("object" + object_number + "_lst_fk_atributes_name_u", UString.Ucfirst(key));
					code.setAttribute("object" + object_number + "_lst_fk_atributes_type", mapa.get(key));
					code.setAttribute("object" + object_number + "_lst_fk_atributes_table", rs.getString(fkTableName));
					code.setAttribute("object" + object_number + "_lst_fk_atributes_column", rs.getString(fkColumnName));
					code.setAttribute("object" + object_number + "_lst_fk_object_table", UString.getJavaName(fkTableName));
					code.setAttribute("object" + object_number + "_lst_fk_object_column", UString.Ucfirst(fkColumnName));
				//}				
			}
			
			System.out.println(table + ":" + dir + dSeparator + name);
			code.setAttribute("connection_name", connName);
			code.setAttribute("permission" + object_number + "_name", UString.getJavaName(table).toUpperCase());
			code.setAttribute("object" + object_number + "_name", 	UString.getJavaName(table));
			code.setAttribute("package" + object_number + "_name", 	packages[i]);
			code.setAttribute("object" + object_number + "_db_name", table);
				
			String[] fkVal;
			String fkType;
			String fkTable;
			String fkColumn;
			
			for(String Key: keys){
				code.setAttribute("object" + object_number + "_atributes_name_l", Key);
				code.setAttribute("object" + object_number + "_atributes_name_u", UString.Ucfirst(Key));
				
				if(!mapaFk.containsKey(Key)){
					code.setAttribute("object" + object_number + "_atributes_type", new JavaType(mapa.get(Key), mapaType.get(Key).intValue()));
					code.setAttribute("object" + object_number + "_fk_atributes_table", "");
					code.setAttribute("object" + object_number + "_fk_atributes_column", "");
					code.setAttribute("object" + object_number + "_fk_object_table", "");
					code.setAttribute("object" + object_number + "_fk_object_column", "");
				}else{
					fkVal 		= mapaFk.get(Key); 
					fkTable		= fkVal[1];
					fkColumn	= fkVal[2];
					
					code.setAttribute("object" + object_number + "_atributes_type", new JavaType(mapa.get(Key), mapaType.get(Key).intValue(), fkTable, fkColumn));
					code.setAttribute("object" + object_number + "_fk_atributes_table", fkTable);
					code.setAttribute("object" + object_number + "_fk_atributes_column", fkColumn);
					code.setAttribute("object" + object_number + "_fk_object_table", UString.getJavaName(fkTable));
					code.setAttribute("object" + object_number + "_fk_object_column", UString.Ucfirst(fkColumn));
				}
			}
			
			rs = rsmd.getPrimaryKeys(catalogo, null, table);
			String columnName;
			while (rs.next()) {
				columnName = rs.getString("COLUMN_NAME");	
				
				code.setAttribute("object" + object_number + "_pk_atributes_name_l", columnName);
				code.setAttribute("object" + object_number + "_pk_atributes_name_u", UString.Ucfirst(columnName));
				code.setAttribute("object" + object_number + "_pk_atributes_type", mapa.get(columnName));
				code.setAttribute("object" + object_number + "_pk_atributes_jdbctype", mapaType.get(columnName).intValue());
			}
			
			i++;
		}
		
		try {
			StringTemplate name = new StringTemplate(nameFile.replace(dSeparator, "*"));
			name.setAttribute("object0_name", 	UString.getJavaName(tables[0]));
			RWFile.setContents(dTmp + dOut + dSeparator + name.toString().replace("*", dSeparator), code.toString());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}		
}
