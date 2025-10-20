package com.servelate;

import java.io.IOException;
import java.sql.SQLException;

import com.sun.net.httpserver.Request;
import com.DAO.UserDAO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("/LoginServlet")
public class LoginServlate extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username=req.getParameter("username");
		String password=req.getParameter("password");
		try {
			String role =new UserDAO().checkLogin(username, password);
			if(role!=null) {
				HttpSession session=req.getSession();
				session.setAttribute("username", username);
				session.setAttribute("role", role);
				if("admin".equals(role)) {
					resp.sendRedirect("adminDashboard.jsp");
				}
				else {
					resp.sendRedirect("index.jsp");
				}
			}
			else {
				req.setAttribute("error", "Invalid Username or Password!");
                RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
                rd.forward(req, resp);
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}

}
