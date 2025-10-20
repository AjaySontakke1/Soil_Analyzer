package com.servelate;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

import com.Bean.Soil;
import com.DAO.SoilDAO;
import com.DBconnection_Email.DBconnection;
import com.DBconnection_Email.SoilEmailSender;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("/SoilServlet")
public class SoilServlate extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("username") == null) {
			resp.sendRedirect("login.jsp");
			return;

		}
		Soil soil = new Soil();
		String username = ((String) session.getAttribute("username"));
		double ph = (Double.parseDouble(req.getParameter("ph")));
		double moisture = (Double.parseDouble(req.getParameter("moisture")));
		double organic = (Double.parseDouble(req.getParameter("organic")));
		String Location = req.getParameter("location");
		String email = req.getParameter("email");
		
		soil.setUsername(username);
		soil.setPh(ph);
		soil.setMoisture(moisture);
		soil.setOrganic(organic);
		soil.setLocation(Location);
		soil.setEmail(email);
		

		// Analysis test
		StringBuilder analysis = new StringBuilder();
		if (ph < 5.5)
			analysis.append("Soil is acidic – add lime.<br>");
		else if (ph > 8.0)
			analysis.append("Soil is alkaline – add gypsum or compost.<br>");
		else
			analysis.append("Soil pH is suitable for most crops.<br>");

		if (moisture < 30)
			analysis.append("Low moisture – irrigation required.<br>");
		else if (moisture > 80)
			analysis.append("Too wet – ensure proper drainage.<br>");
		else
			analysis.append("Moisture level is good.<br>");

		if (organic < 2)
			analysis.append("Low organic matter – add compost or manure.<br>");
		else
			analysis.append("Organic matter is healthy.<br>");

		// Crop recommendation
		List<String> crops = new ArrayList<>();
		if (ph >= 5.5 && ph <= 7.5 && moisture >= 40 && moisture <= 70) {
			crops = Arrays.asList("Wheat", "Rice", "Maize");
		} else if (ph < 5.5 && moisture > 50) {
			crops = Arrays.asList("Tea", "Pineapple", "Potato");
		} else if (ph > 7.5 && moisture < 50) {
			crops = Arrays.asList("Barley", "Cotton", "Millets");
		} else {
			crops = Arrays.asList("General crops with soil treatment");
		}

		// Predefined crop info map
		Map<String, String> cropInfo = new HashMap<>();
		cropInfo.put("Wheat", "Wheat: neutral pH (6-7), moderate moisture, cool climate.");
		cropInfo.put("Rice", "Rice: acidic-neutral (5.5-6.5), high moisture, flooded fields.");
		cropInfo.put("Maize", "Maize: well-drained fertile soil, moderate rainfall.");
		cropInfo.put("Tea", "Tea: acidic soil (pH < 5.5), high rainfall, drained slopes.");
		cropInfo.put("Pineapple", "Pineapple: acidic soil, tropical humidity.");
		cropInfo.put("Potato", "Potato: slightly acidic (pH 5-6), well-drained sandy soil.");
		cropInfo.put("Barley", "Barley: alkaline soil (pH > 7.5), drier climates.");
		cropInfo.put("Cotton", "Cotton: alkaline soils, warm climate, moderate moisture.");
		cropInfo.put("Millets", "Millets: drought-resistant, sandy/alkaline soils.");

		Map<String, String> selectedCropInfo = new LinkedHashMap<>();
		for (String c : crops)
			selectedCropInfo.put(c, cropInfo.getOrDefault(c, "Info not available."));

		soil.setCropRecommendation(String.join(", ", crops));
		SoilDAO dao=new SoilDAO();
		try {
			dao.insertSoil(soil);
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		 // Optional: send email
        if (email != null && !email.isEmpty()) {
            try {
                String subject = "Soil Analysis Report";
                String html = "<h3>Soil Analysis</h3>" + analysis.toString() +
                              "<h4>Recommended Crops</h4><p>" + soil.getCropRecommendation() + "</p>";
                SoilEmailSender.sendEmail(email, subject, html);
            } catch (Exception e) {
                // don't fail the request if email fails; show message in logs
                System.out.println("Email not sent: " + e.getMessage());
            }
        }
     // forward to result page
        req.setAttribute("analysisResult", analysis.toString());
        req.setAttribute("selectedCrops", selectedCropInfo);
        req.setAttribute("ph", ph);
        req.setAttribute("moisture", moisture);
        req.setAttribute("organic", organic);
        RequestDispatcher rd = req.getRequestDispatcher("result.jsp");
        rd.forward(req, resp);
	}
}
