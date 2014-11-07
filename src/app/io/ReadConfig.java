package app.io;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Properties;

public class ReadConfig {
	private Properties properties;
	public ReadConfig(String confFile) throws FileNotFoundException, IOException{
		properties = new Properties() ;
		properties.load(new FileInputStream(confFile));
	}
	
	public String get(String propertie_name){
		return properties.getProperty(propertie_name);
	}
	
	public Enumeration<Object> getKeys(){
		return properties.keys();
	}
}
