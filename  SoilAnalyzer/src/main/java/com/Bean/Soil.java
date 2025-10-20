package com.Bean;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

@SuppressWarnings("serial")
public class Soil implements Serializable{

	    private int id;
	    private String username;
	    private double ph;
	    private double moisture;
	    private double organic;
	    private String location;
	    private String cropRecommendation;
	    private String email;
	    private Timestamp testDate;
	    
		public Soil() {
			
		}
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getUsername() {
			return username;
		}
		public void setUsername(String username) {
			this.username = username;
		}
		public double getPh() {
			return ph;
		}
		public void setPh(double ph) {
			this.ph = ph;
		}
		public double getMoisture() {
			return moisture;
		}
		public void setMoisture(double moisture) {
			this.moisture = moisture;
		}
		public double getOrganic() {
			return organic;
		}
		public void setOrganic(double organic) {
			this.organic = organic;
		}
		public String getLocation() {
			return location;
		}
		public void setLocation(String location) {
			this.location = location;
		}
		public String getCropRecommendation() {
			return cropRecommendation;
		}
		public void setCropRecommendation(String cropRecommendation) {
			this.cropRecommendation = cropRecommendation;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public Timestamp getTestDate() {
			return testDate;
		}
		public void setTestDate(Timestamp timestamp) {
			this.testDate = timestamp;
		}
		
}
