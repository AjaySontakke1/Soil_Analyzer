package com.servelate;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Random;
import com.DBconnection_Email.Forgotpassword_EmailSender;
import com.DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/ForgotPassword")
public class ForgotPasswordServlet extends HttpServlet {
	public static String generatepassword() {
		String str = "ABCDEFGHIJKLMNPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz123456789@#$^&*";
		StringBuilder password = new StringBuilder();
		Random rnd = new Random();
		for (int i = 0; i < 9; i++) {
			int index = rnd.nextInt(str.length());
			password.append(str.charAt(index));
		}
		return password.toString();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String mail = req.getParameter("email");
		UserDAO dao = new UserDAO();
		try {
			if (dao.checkEmailExists(mail)) {
				String password = generatepassword();
				if (dao.resetpassword(mail, password)) {
					try {
						Forgotpassword_EmailSender.sendMail(mail,password);
						req.setAttribute("msg", "Your new Password Send on your Email");
					} catch (Exception e) {
						e.printStackTrace();
						req.setAttribute("msg", "Email Service is not Available but password is reset "
								+ "Succefully Contact admin for detail");
					}

				}
				else {
					req.setAttribute("msg", "Faild to reset password Try Again");
				}
				req.getRequestDispatcher("login.jsp").forward(req, resp);
			} else {
				req.setAttribute("msg", "Email not exist,please check email");
				req.getRequestDispatcher("forgotpassword.jsp").forward(req, resp);
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}
	}
}
