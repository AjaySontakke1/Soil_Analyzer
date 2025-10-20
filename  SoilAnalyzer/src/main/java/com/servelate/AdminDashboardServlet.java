package com.servelate;
import java.io.IOException;
import java.sql.Connection;
import java.util.*;

import com.Bean.Soil;
import com.DAO.SoilDAO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    HttpSession session = request.getSession(false);
	    if (session == null || !"admin".equals(session.getAttribute("role"))) {
	        response.sendRedirect("login.jsp");
	        return;
	    }

	    String searchUser = request.getParameter("searchUser");
	    String filterLocation = request.getParameter("filterLocation");

	    try {
	        SoilDAO dao = new SoilDAO();
	        List<Soil> soilList;

	        if (searchUser != null && !searchUser.isEmpty()) {
	            soilList = dao.searchByUser(searchUser);
	        } else if (filterLocation != null && !filterLocation.isEmpty()) {
	            soilList = dao.filterByLocation(filterLocation);
	        } else {
	            soilList = dao.getAllSoil();
	        }

	        Map<String, Double> avgMap = dao.getAverageValues();
	        Map<String, Integer> cropCount = dao.getCropFrequency();

	        request.setAttribute("soilList", soilList);
	        request.setAttribute("avgMap", avgMap);
	        request.setAttribute("cropCount", cropCount);

	        RequestDispatcher rd = request.getRequestDispatcher("adminDashboard.jsp");
	        rd.forward(request, response);
	    } catch (Exception e) {
	        throw new ServletException(e);
	    }
	}
}
