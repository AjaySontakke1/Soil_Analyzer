package com.DBconnection_Email;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import static com.DBconnection_Email.DBinfo.*;
public class DBconnection {
	public static Connection conn=null;
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn=DriverManager.getConnection(URL, USERNAME, PASSWORD);
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
    	
    }
	public static Connection getConnection() {
		return conn;
	}
    
    
}
