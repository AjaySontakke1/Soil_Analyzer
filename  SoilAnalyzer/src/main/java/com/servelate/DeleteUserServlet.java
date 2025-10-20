package com.servelate;

import java.io.IOException;
import com.DAO.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || !"admin".equals(session.getAttribute("role"))) {
			resp.sendRedirect("login.jsp");
			return;
		}

		try {
			int userId = Integer.parseInt(req.getParameter("id"));
			UserDAO userDAO = new UserDAO();
			boolean isDeleted = userDAO.deleteUser(userId);

			if (isDeleted) {
				session.setAttribute("successMessage", "User deleted successfully!");
			} else {
				session.setAttribute("errorMessage", "Failed to delete user!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("errorMessage", "Error deleting user: " + e.getMessage());
		}

		resp.sendRedirect("ViewUserServlet");
	}
}