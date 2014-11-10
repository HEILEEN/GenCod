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
import app.template.Class.TColumn;
import app.template.Class.TObject;
import app.template.Class.TPkColumn;

public class GenTemplate2 {
	private String dir;
	private String name;
	private String AppName;
	private String catalogo;
	private String connName;	
	private String[] tables;
	private String[] packages;
	private String nameFile;
	private ResultSetMetaData md;
	private DbConnection db;
	private HashMap<String, String> mapa;
	private HashMap<String, Integer> mapaType;
	private HashMap<String, TPkColumn> mapaPk;
	private HashMap<String, Integer> mapaNull;
	private HashMap<String, Integer> mapaPress;
	private HashMap<String, Integer> mapaScale;
	private HashMap<String, String[]> mapaFk;
	
	public GenTemplate2(DbConnection db, String table, String catalogo, String dir, String name, String nameFile, String packages, String connName, String AppName) throws SQLException{
		this.db = db;
		this.dir = dir;
		this.name = name;
		this.tables = table.split(",");
		this.AppName = AppName;
		this.catalogo = catalogo;
		this.nameFile = nameFile;
		this.connName = connName;
		this.packages = packages.split(",");
	}
	
	public void GenerateST(String pOut) throws SQLException{
		
		String dSeparator = "\\";
		String plantilla = RWFile.getContents(dir + dSeparator + name);
		String comments = "" +
				" /**                          "+ "\n" +
				"  *                           "+ "\n" +
				"  * @modifico\tCONFIANZA"+ "\n" +
				"  * @version\t1.0 "+ "\n" +
				"  * @Fecha\t\t30/10/2014 "+ "\n" +
				"  * @since\t\t1.0            "+ "\n" +
				"  * @app\t\t" +AppName+ "  "+ "\n" +
				"  */                          ";
		
		StringTemplate code = new StringTemplate(plantilla);
		int i = 0;
		String object_number;
		String dTmp = (pOut != null) ? pOut : "C:" + dSeparator + "temp" + dSeparator + AppName.toLowerCase() + dSeparator;
		String[] keys;
		String[] keysPk;
		
		String dOut = UString.getJavaName(tables[0]);
		(new File(dTmp)).mkdir();
		(new File(dTmp + dOut)).mkdir();
		(new File(dTmp + dOut + dSeparator + "Repository")).mkdir();
		(new File(dTmp + dOut + dSeparator + "Controller")).mkdir();
		(new File(dTmp + dOut + dSeparator + "Service")).mkdir();
		
		for(String table: tables)
		{	
			ResultSet rs = db.Select("SELECT * FROM " + table);
			md = rs.getMetaData();
			
			int num = md.getColumnCount();
			
			keys = new String[num];
			mapa = new HashMap<String, String>();
			mapaType = new HashMap<String, Integer>();
			mapaPk = new HashMap<String, TPkColumn>();
			mapaNull = new HashMap<String, Integer>();
			mapaPress = new HashMap<String, Integer>();
			mapaScale = new HashMap<String, Integer>();
			
			int x = 0;
			for(int c = 1; c<=x; c++)
				System.out.println("Columna (" + c + "): " + md.getColumnName(c));
			
			for(int n=1; n<=num; n++){
				mapa.put(md.getColumnName(n), md.getColumnClassName(n));
				mapaType.put(md.getColumnName(n), new Integer(md.getColumnType(n)));
				mapaNull.put(md.getColumnName(n), new Integer(md.isNullable(n)));
				mapaPress.put(md.getColumnName(n), new Integer(md.getPrecision(n)));
				mapaScale.put(md.getColumnName(n), new Integer(md.getScale(n)));
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

			String[] fkVal;
			String fkType;
			String fkTable;
			String fkColumn;
			int tPk = 0;
			
			rs = rsmd.getPrimaryKeys(catalogo, null, table);
			String columnName;
			while (rs.next()) {
				columnName = rs.getString("COLUMN_NAME");	
				
				TPkColumn pk = new TPkColumn(columnName, mapa.get(columnName), mapaType.get(columnName).intValue(),
						new JavaType(mapa.get(columnName), mapaType.get(columnName).intValue()));
				code.setAttribute("ColumnsPk" + object_number, pk );
				
				mapaPk.put(columnName.toLowerCase(), pk);
				//System.out.println("PK: " + columnName);
				tPk++;
			}
			
			TObject o = new TObject(table, connName, packages[i]);
			o.setNPk(tPk);
			code.setAttribute("Table" + object_number, o);
			code.setAttribute("comments", comments);
			code.setAttribute("AppName", AppName);
			code.setAttribute("ConnName", connName);
			JavaType jt;
				
			for(String Key: keys){
				
				TColumn c = new TColumn(Key, mapaNull.get(Key), mapaPress.get(Key), mapaScale.get(Key));
				c.setPrimaryKey(mapaPk.containsKey(Key.toLowerCase()));
				
				if(!mapaFk.containsKey(Key)){
					jt = new JavaType(mapa.get(Key), mapaType.get(Key).intValue());
					jt.setScale(mapaScale.get(Key));
					c.setType(jt);					
				}else{
					fkVal 		= mapaFk.get(Key); 
					fkTable		= fkVal[1];
					fkColumn	= fkVal[2];
					
					jt = new JavaType(mapa.get(Key), mapaType.get(Key).intValue(), fkTable, fkColumn);
					jt.setScale(mapaScale.get(Key));
					c.setType(jt);
					c.setFk(fkTable, fkColumn);
				}
				
				code.setAttribute("Columns" + object_number, c);
			}

			i++;
		}
		
		try {
			StringTemplate name = new StringTemplate(nameFile.replace(dSeparator, "*"));
			for(String table: tables)
				name.setAttribute("Object0", 	UString.getJavaName(table));
			RWFile.setContents(dTmp + dOut + dSeparator + name.toString().replace("*", dSeparator), code.toString());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}	
}
