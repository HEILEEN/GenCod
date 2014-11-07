package app.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class DbConnection {
	private Connection con;
	
	public DbConnection(DbParams pr) throws Exception {
		Constructor(pr);
	}
	
	public void Constructor(DbParams pr) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		Class.forName(pr.getDriver()).newInstance();
		con = DriverManager.getConnection(pr.getCadena(), pr.getUser(), pr.getPass());
	}
	
	public Connection getConnection(){
		return con;
	}
	
	public ResultSet Select(String sql) throws SQLException{
		return Select(sql, null);
	}
	
	public ResultSet Select(String sql, Object[] params) throws SQLException{
		PreparedStatement s = con.prepareStatement(sql);
		
		if(params != null && params.length > 0 ){
			for(int i=0; i<params.length; i++)
				s.setObject(i+1, params[i]);
		}
		
		s.executeQuery();
		
		return s.getResultSet();
	}
	
	public int Update(String sql) throws SQLException{
		return Update(sql, null);
	}
	
	public int Update(String sql, Object[] params) throws SQLException{
		PreparedStatement s = con.prepareStatement(sql);
		
		if(params != null && params.length > 0 ){
			for(int i=0; i<params.length; i++)
				s.setObject(i, params[i]);
		}
	
		return s.executeUpdate();
	}
	
	public ResultSetMetaData getTableMetaData(String tableName) throws SQLException{
		ResultSet rs = Select("SELECT * FROM " + tableName);
		return rs.getMetaData();
	}
	
	public void close() throws SQLException{
		if( this.con != null )
			con.close();
	}
}
