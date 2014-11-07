package app.db;

import java.util.Map;

public class DbParams {
	private String driver;
	private String cadena;
	private String user;
	private String pass;
	
	public DbParams(Map<String, String> params){
		if( params.size() > 3 ){			
			setDriver(params.get("jdbc_driver"));
			setCadena(params.get("jdbc_string"));
			setUser(params.get("jdbc_user"));
			setPass(params.get("jdbc_pass"));
		}
	}
		
	public DbParams(String driver, String cadena, String user, String pass){
		Constructor(driver, cadena, user, pass);
	}
	
	public void Constructor(String driver, String cadena, String user, String pass){
		setDriver(driver);
		setCadena(cadena);
		setUser(user);
		setPass(pass);
	}

	public void setDriver(String driver) {
		this.driver = driver;
	}

	public String getDriver() {
		return driver;
	}

	public void setCadena(String cadena) {
		this.cadena = cadena;
	}

	public String getCadena() {
		return cadena;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getUser() {
		return user;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getPass() {
		return pass;
	}
}
