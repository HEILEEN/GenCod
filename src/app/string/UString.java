package app.string;

public class UString {
	static public String Ucfirst(String s){
		if( s != null && s.length() > 0 ){
			s = s.substring(0, 1).toUpperCase() + s.substring(1).toLowerCase();
		}
		
		return s;
	}
	
	static public String getJavaName(String s){
		if( s != null && s.length() > 0 ){
			String[] words = s.split("_");
			s = "";
			
			for(int i=0; i<words.length; i++){
				s += Ucfirst(words[i]);
			}
		}
		
		return s;
	}
}
