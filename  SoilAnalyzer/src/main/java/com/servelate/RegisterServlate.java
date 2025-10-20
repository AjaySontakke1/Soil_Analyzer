package com.servelate;

import java.io.IOException;
import java.sql.SQLException;

import com.Bean.User;
import com.DAO.UserDAO;
import com.DBconnection_Email.Email_Sender;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
@SuppressWarnings("serial")
@WebServlet("/RegisterServlet")
public class RegisterServlate  extends HttpServlet{

	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        
	        String name = request.getParameter("name");
	        String email = request.getParameter("email");
	        String password = request.getParameter("password");
	        String contact = request.getParameter("contact");

	        User user = new User();
	        user.setName(name);
	        user.setEmail(email);
	        user.setPassword(password);
	        user.setContact(contact);

	        UserDAO dao = new UserDAO();

	        try {
				if (dao.checkEmailExists(email)) {
				    request.setAttribute("msg", "Email already registered!");
				    request.getRequestDispatcher("register.jsp").forward(request, response);
				} else if (dao.registerUser(user)) {
					// Send email
				    Email_Sender.sendMail(email, name);
				    request.setAttribute("msg", "Registration successful! Please login.");
				    request.getRequestDispatcher("login.jsp").forward(request, response);
				} else {
				    request.setAttribute("msg", "Registration failed. Try again.");
				    request.getRequestDispatcher("register.jsp").forward(request, response);
				}
			} catch (SQLException | ServletException | IOException e) {
				
				e.printStackTrace();
			}
	    }
	
}
