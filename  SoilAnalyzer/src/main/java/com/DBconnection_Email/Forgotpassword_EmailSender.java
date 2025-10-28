package com.DBconnection_Email;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class Forgotpassword_EmailSender {

	public static void sendMail(String toEmail, String pass) {
		final String fromEmail = "ajsontakke2@gmail.com";
		final String password = "vwgq neky dtuj xcwh"; // app password (not normal password)

		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");

		Session session = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		});

		try {
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(fromEmail, "Soil Analyzer Project"));
			msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
			msg.setSubject("Welcome to Soil Analyzer Web Portal");

			msg.setText("Your Password Reset Succefully.\n"
					+ "You can now log in and start analyzing your soil with new password: " + pass + ".\n\n"
					+ "Regards,\nSoil Analyzer Team");

			Transport.send(msg);
			System.out.println("✅ Email sent successfully to " + toEmail);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
