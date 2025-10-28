package com.servelate;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import com.DBconnection_Email.Forgotpassword_EmailSender;
import com.Bean.User;
import com.DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/ResetPassword")
public class ResetPasswordServlate extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");
		String current_password = req.getParameter("password_1");
		String new_password = req.getParameter("password");

		UserDAO dao = new UserDAO();

		try {
			// Fetch user by email
			User ub = dao.retriveuserbymail(email);

			if (dao.checkEmailExists(email)) {
				if (current_password.equals(ub.getPassword())) {

					// Update password
					dao.resetpassword(email, new_password);

					// Send mail (skip if SMTP blocked)

					req.setAttribute("msg", "Password reset successfully! Please login again.");
					req.getRequestDispatcher("login.jsp").forward(req, resp);

				} else {
					req.setAttribute("msg", "❌ Current password is incorrect.");
					req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
				}
			} else {
				req.setAttribute("msg", "❌ Email not found. Please register first.");
				req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			req.setAttribute("msg", "Database error occurred.");
			req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
		}
	}
}
