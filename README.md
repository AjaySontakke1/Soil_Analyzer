# Soil_Analyzer
# 🌱 Soil Analyzer Project (Java Servlet + MySQL + Aiven + Render)

This project analyzes soil data and provides crop recommendations for farmers.  
It includes features like:
- 🌾 Soil pH, Moisture, Organic content analysis
- ✉️ Email alerts for soil test results
- 🗄️ MySQL (Aiven Cloud) database connection
- ☁️ Hosted on Render using Docker and Tomcat

### 🧰 Tech Stack
- Java (Servlets, JSP)
- Tomcat 10
- MySQL (Aiven)
- Render Cloud Hosting
- HTML, CSS, JSP for frontend

### 👨‍🌾 Usage
Farmers can check soil quality and get crop suggestions via email.

### 📦 Deployment
Docker-based deployment on Render:
```bash
FROM tomcat:10.1-jdk21
RUN rm -rf /usr/local/tomcat/webapps/*
COPY target/SoilAnalyzer.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
