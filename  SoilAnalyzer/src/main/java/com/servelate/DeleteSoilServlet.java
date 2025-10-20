package com.servelate;

import java.io.IOException;
import java.sql.Connection;

import com.DAO.SoilDAO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/DeleteSoilServlet")
public class DeleteSoilServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		if (session == null || !"admin".equals(session.getAttribute("role"))) {
			response.sendRedirect("login.jsp");
			return;
		}

		int id = Integer.parseInt(request.getParameter("id"));

		SoilDAO dao = new SoilDAO();
		try {
			dao.deleteSoil(id);
		} catch (Exception e) {
			throw new ServletException(e);
		}

		response.sendRedirect("AdminDashboardServlet");
	}
}
