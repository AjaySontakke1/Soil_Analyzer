package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import com.Bean.Soil;
import com.DBconnection_Email.DBconnection;

public class SoilDAO {

//inserting data into soil table
	public void insertSoil(Soil soil) throws SQLException {
		Connection con = DBconnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
				"INSERT INTO soil_data (username, ph, moisture, organic, location, cropRecommendation, email) VALUES (?, ?, ?, ?, ?, ?, ?)");
		ps.setString(1, soil.getUsername());
		ps.setDouble(2, soil.getPh());
		ps.setDouble(3, soil.getMoisture());
		ps.setDouble(4, soil.getOrganic());
		ps.setString(5, soil.getLocation());
		ps.setString(6, soil.getCropRecommendation());
		ps.setString(7, soil.getEmail());
		ps.executeUpdate();

	}

//get the all soil data from table in list
	public ArrayList<Soil> getAllSoil() throws SQLException {
		Connection con = DBconnection.getConnection();
		ArrayList<Soil> list = new ArrayList<>();
		String sql = "SELECT * FROM soil_data";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Soil s = new Soil();
				s.setId(rs.getInt("id"));
				s.setUsername(rs.getString("username"));
				s.setPh(rs.getDouble("ph"));
				s.setMoisture(rs.getDouble("moisture"));
				s.setOrganic(rs.getDouble("organic"));
				s.setLocation(rs.getString("location"));
				s.setCropRecommendation(rs.getString("cropRecommendation"));
				s.setEmail(rs.getString("email"));
				s.setTestDate(rs.getTimestamp("test_date"));
				list.add(s);
			}
		}
		return list;
	}

	// get soil data from user by username

	public List<Soil> getSoilByUser(String username) throws SQLException {
		Connection con = DBconnection.getConnection();
		List<Soil> list = new ArrayList<>();
		String sql = "SELECT * FROM soil_data WHERE username=?";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Soil s = new Soil();
				s.setId(rs.getInt("id"));
				s.setUsername(rs.getString("username"));
				s.setPh(rs.getDouble("ph"));
				s.setMoisture(rs.getDouble("moisture"));
				s.setOrganic(rs.getDouble("organic"));
				s.setLocation(rs.getString("location"));
				s.setCropRecommendation(rs.getString("cropRecommendation"));
				s.setEmail(rs.getString("email"));
				s.setTestDate(rs.getTimestamp("test_date"));
				list.add(s);
			}
		}
		return list;
	}

//	 delete soil data
	public void deleteSoil(int id) throws SQLException {
		Connection con = DBconnection.getConnection();
		String sql = "DELETE FROM soil_data WHERE id=?";
		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, id);
			ps.executeUpdate();
		}
	}

	public Map<String, Double> getAverageValues() throws SQLException {
		Connection con = DBconnection.getConnection();
		Map<String, Double> avg = new HashMap<>();
		String sql = "SELECT AVG(ph) AS avg_ph, AVG(moisture) AS avg_moisture, AVG(organic) AS avg_organic FROM soil_data";
		try (PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
			if (rs.next()) {
				avg.put("ph", rs.getDouble("avg_ph"));
				avg.put("moisture", rs.getDouble("avg_moisture"));
				avg.put("organic", rs.getDouble("avg_organic"));
			}
		}
		return avg;
	}

	public Map<String, Integer> getCropFrequency() throws SQLException {
		Connection con = DBconnection.getConnection();
		Map<String, Integer> cropCount = new LinkedHashMap<>();
		String sql = "SELECT cropRecommendation FROM soil_data";
		try (PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				String rec = rs.getString("cropRecommendation");
				if (rec == null)
					continue;
				String[] crops = rec.split(",");
				for (String crop : crops) {
					crop = crop.trim();
					if (crop.isEmpty())
						continue;
					cropCount.put(crop, cropCount.getOrDefault(crop, 0) + 1);
				}
			}
		}
		return cropCount;
	}

	// 🔍 Search soil data by username (partial match)
	public List<Soil> searchByUser(String keyword) throws SQLException {
		List<Soil> list = new ArrayList<>();
		String sql = "SELECT * FROM soil_data WHERE username LIKE ?";
		Connection con = DBconnection.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, "%" + keyword + "%");
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Soil s = new Soil();
			s.setId(rs.getInt("id"));
			s.setUsername(rs.getString("username"));
			s.setPh(rs.getDouble("ph"));
			s.setMoisture(rs.getDouble("moisture"));
			s.setOrganic(rs.getDouble("organic"));
			s.setLocation(rs.getString("location"));
			s.setCropRecommendation(rs.getString("cropRecommendation"));
			s.setEmail(rs.getString("email"));
			s.setTestDate(rs.getTimestamp("test_date"));
			list.add(s);
		}

		return list;
	}

	// 📍 Filter soil data by location
	public List<Soil> filterByLocation(String location) throws SQLException {
		List<Soil> list = new ArrayList<>();
		String sql = "SELECT * FROM soil_data WHERE location LIKE ?";
		Connection con = DBconnection.getConnection();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, "%" + location + "%");
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Soil s = new Soil();
			s.setId(rs.getInt("id"));
			s.setUsername(rs.getString("username"));
			s.setPh(rs.getDouble("ph"));
			s.setMoisture(rs.getDouble("moisture"));
			s.setOrganic(rs.getDouble("organic"));
			s.setLocation(rs.getString("location"));
			s.setCropRecommendation(rs.getString("cropRecommendation"));
			s.setEmail(rs.getString("email"));
			s.setTestDate(rs.getTimestamp("test_date"));
			list.add(s);
		}

		return list;
	}

}
