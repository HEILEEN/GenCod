package app.template.Class;

import app.string.UString;
import app.template.JavaType;

public class TColumn {
	private String name;
	private String loName;
	private String upName;
	private String fkTable;
	private String fkColumn;
	private String fkObjTable;
	private String fkObjColumn;
	private String fkObjTableLo;
	private String fkObjColumnLo;
	private boolean isNull;
	private int precision;
	private int scale;
	
	private boolean isPk;
	private JavaType type;
	
	public TColumn(String name, int b, int p, int s){
		setName(name, b, p, s);
	}
	
	public void setName(String name, int b, int p, int s){
		this.name = name;
		this.scale = s;
		this.precision = p;
		this.loName = name.toLowerCase();
		this.upName = UString.Ucfirst(name);
		this.isNull = (b == 0) ? false : true;
	}
	
	public boolean getNullable(){
		return isNull;
	}
	
	public int getPrecision(){
		return precision;
	}
	
	public int getScale(){
		return scale;
	}
	
	public boolean getHashScale(){
		return (scale > 0);
	}
	
	public void setType(JavaType type){
		this.type = type;
	}
	
	public void setPrimaryKey(boolean b){
		this.isPk = b;
	}
	
	public void setFk(String fkTable, String fkColumn){
		this.fkTable = fkTable;
		this.fkColumn = fkColumn;
		
		this.fkObjTable = UString.getJavaName(fkTable);
		this.fkObjColumn = UString.getJavaName(fkColumn);
		
		this.fkObjTableLo = UString.getJavaName(fkTable).toLowerCase();
		this.fkObjColumnLo = UString.getJavaName(fkColumn).toLowerCase();
	}
	
	public String getName() {
		return name;
	}
	
	public String getLoName() {
		return loName;
	}
	
	public String getUpName() {
		return upName;
	}
	
	public String getUpperName() {
		return upName.toUpperCase();
	}
	
	public boolean getPk(){
		return isPk;
	}
	
	public boolean getIsFK(){
		return ( fkColumn != null && fkTable != null && fkColumn.length() > 0 && fkTable.length() > 0 );
	}
	
	public String getFkTable() {
		return fkTable;
	}
	
	public String getFkColumn() {
		return fkColumn;
	}
	
	public String getFkObjTable() {
		return fkObjTable;
	}
	
	public String getLoFkObjTable() {
		return fkObjTable.toLowerCase();
	}
	
	public String getFkObjColumn() {
		return fkObjColumn;
	}
	
	public String getFkObjTableLo() {
		return fkObjTableLo;
	}
	
	public String getFkObjColumnLo() {
		return fkObjColumnLo;
	}
	
	public JavaType getType(){
		return this.type;
	}
}
