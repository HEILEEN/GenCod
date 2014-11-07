package app.template.Class;

import app.string.UString;

public class TObject {
	private String connName;
	private String tableName;
	private String objName;
	private String permission;
	private String spackage;
	private int nPk;
	
	public TObject(String name, String connName, String spackage){
		this.tableName = name;
		this.connName = connName;
		this.spackage = spackage;
		
		this.permission = UString.getJavaName(tableName).toUpperCase();
		this.objName = UString.getJavaName(tableName);
	}
	
	public void setNPk(int num){
		this.nPk = num;
	}

	public String getConnName() {
		return connName;
	}

	public String getTableName() {
		return tableName;
	}

	public String getObjName() {
		return objName;
	}

	public String getLoObjName() {
		return objName.toLowerCase();
	}

	public String getPermission() {
		return permission;
	}

	public String getPackage() {
		return spackage;
	}
	
	public boolean getNPk(){
		return (nPk > 1);
	}
}
