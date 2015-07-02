package app.template;

public class JavaType {
	private String type;
	private String table;
	private String column;
	private int tipo;
	private int scale;
	
	public JavaType(String type, int tipo){
		this.type 	= type;
		this.table	= null;
		this.column = null;
		this.tipo	= tipo;
	}
	
	public JavaType(String type, int tipo, String table, String column){
		this.type 	= type;
		this.table 	= table;
		this.column	= column;
		this.tipo	= tipo;
	}
	
	public void setScale(int scale){
		this.scale = scale;
	}
	
	public boolean getHashScale(){
		return (scale > 0);
	}
	
	public String getOrmType(){
		
		if(getInteger()){
			return "Integer";
		}else if(getString()){
			return "String";
		}else if(getDouble()){
			return "Double";
		}else if(getLong()){
			return "Long";
		}else if(getDate()){
			return "Date";
		}else{
			return type;
		}
	}
	
	public boolean getIsFK(){
		return (this.table != null && this.column != null);
	}
	
	public boolean getInteger(){
		return (type == "java.lang.Integer");
	}
	
	public boolean getString(){
		return (type == "java.lang.String");
	}
	
	public boolean getDouble(){
		return scale > 0 && 
		       (type == "java.lang.Double" || 
				type == "java.math.BigDecimal");
	}
	
	public boolean getLong(){
		return ((type == "java.lang.Double" || 
			    type == "java.math.BigDecimal")) ||
				type == "java.lang.Long";
	}
	
	public boolean getDate(){
		return  (type == "java.sql.Date") 		||
				(type == "java.sql.Timestamp")	; 
	}
	
	public String getType(){
		return Integer.toString(this.tipo);
	}
	
	public String getTable(){
		return this.table;
	}
	
	public String getColumn(){
		return this.column;
	}
	
	public String toString(){
		return type;
	}
}
