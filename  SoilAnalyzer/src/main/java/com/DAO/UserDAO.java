package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Bean.User;
import com.DBconnection_Email.DBconnection;

public class UserDAO {

	public String checkLogin(String username, String password) throws SQLException {
		Connection con = DBconnection.getConnection();
		PreparedStatement ps = con.prepareStatement("SELECT role FROM user WHERE username=? AND password=?");
		ps.setString(1, username);
		ps.setString(2, password);
		ResultSet rs = ps.executeQuery();
		if (rs.next())
			return rs.getString("role");

		return null;
	}

	public boolean registerUser(User user) throws SQLException {
		Connection con = DBconnection.getConnection();
		boolean status = false;
		String query = "INSERT INTO user (username,password,contact,email) VALUES (?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, user.getName());
		ps.setString(2, user.getPassword());
		ps.setString(3, user.getContact());
		ps.setString(4, user.getEmail());

		int rows = ps.executeUpdate();
		if (rows > 0)
			status = true;

		return status;
	}

	public boolean checkEmailExists(String email) throws SQLException {
		Connection con = DBconnection.getConnection();
		boolean exists = false;
		String query = "SELECT * FROM user WHERE email = ?";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, email);
		ResultSet rs = ps.executeQuery();
		exists = rs.next();

		return exists;
	}

	public List<User> retriveuser() {
		List<User> ul = new ArrayList<User>();
		Connection con = DBconnection.getConnection();
		try {
			PreparedStatement ps = con.prepareStatement("select * from user");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				User ub = new User();
				ub.setId(rs.getInt("id"));
				ub.setName(rs.getString("username"));
				ub.setPassword(rs.getString("password"));
				ub.setContact(rs.getString("contact"));
				ub.setEmail(rs.getString("email"));
				ul.add(ub);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ul;
	}

	public boolean deleteUser(int userId) throws SQLException {
		Connection con = DBconnection.getConnection();
		boolean status = false;
		String query = "DELETE FROM user WHERE id = ?";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setInt(1, userId);

		int rows = ps.executeUpdate();
		if (rows > 0)
			status = true;

		return status;
	}
}
