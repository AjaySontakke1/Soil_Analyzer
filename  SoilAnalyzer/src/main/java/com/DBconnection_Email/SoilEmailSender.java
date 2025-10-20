package com.DBconnection_Email;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class SoilEmailSender {
    public static void sendEmail(String toEmail, String subject, String htmlContent) throws Exception {
        final String fromEmail = "ajsontakke2@gmail.com";
        final String password = "vwgq neky dtuj xcwh"; // use app password

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(fromEmail, "Soil Analyzer Team"));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
        msg.setSubject(subject);
        msg.setContent(htmlContent, "text/html; charset=utf-8");
        Transport.send(msg);
    }
}
