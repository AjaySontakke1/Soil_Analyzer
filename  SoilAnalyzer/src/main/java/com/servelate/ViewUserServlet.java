package com.servelate;

import java.io.IOException;
import java.util.*;
import com.Bean.User;
import com.DAO.UserDAO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("/ViewUserServlet")
public class ViewUserServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || !"admin".equals(session.getAttribute("role"))) {
			resp.sendRedirect("login.jsp");
			return;
		}
		List<User> user_list = new UserDAO().retriveuser();
		req.setAttribute("UserList", user_list);
	    RequestDispatcher rs=req.getRequestDispatcher("viewuser.jsp");
	    rs.forward(req, resp);
	}

	
}
