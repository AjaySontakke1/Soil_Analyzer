package com.servelate;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import com.Bean.Soil;
import com.DAO.SoilDAO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("username") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		String username = (String) session.getAttribute("username");
		String role = (String) session.getAttribute("role");
		SoilDAO dao = new SoilDAO();
		List<Soil> list;
		try {

			if ("admin".equals(role)) {
				list = dao.getAllSoil();
			} else {
				list = dao.getSoilByUser(username);
			}
			request.setAttribute("soilList", list);
			RequestDispatcher rd = request.getRequestDispatcher("report.jsp");
			rd.forward(request, response);
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
}
