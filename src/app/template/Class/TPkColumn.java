package app.template.Class;

import app.string.UString;
import app.template.JavaType;

public class TPkColumn {
	private String name;
	private String loName;
	private String upName;
	private String type;
	private int jdbctype;
	
	private JavaType jtype;
	
	public TPkColumn(String name, String type, int jdbctype, JavaType jtype){
		this.name		= name;
		this.loName 	= name.toLowerCase();
		this.upName 	= UString.Ucfirst(name);
		this.type 		= type;
		this.jdbctype 	= jdbctype;
		this.jtype		= jtype;
	}
	
	public String getName(){
		return name;
	}
	
	public String getLoName() {
		return loName;
	}
	
	public String getUpName() {
		return upName;
	}
	
	public JavaType getType(){
		return jtype;
	}
	
	public int getJdbcType(){
		return jdbctype;
	}
}
