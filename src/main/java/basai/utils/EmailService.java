package basai.utils;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailService {

    private static final String HOST     = "smtp.gmail.com";
    private static final int    PORT     = 587;
    private static final String FROM     = "shakyashulav29@gmail.com";
    private static final String PASSWORD = "tzyz xrqn sflv bmzs";

    private static Session createSession() {
        Properties props = new Properties();
        props.put("mail.smtp.auth",            "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host",            HOST);
        props.put("mail.smtp.port",            PORT);

        return Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        });
    }

    public static boolean sendEmail(String toEmail, String subject, String body) {
        try {
            Message message = new MimeMessage(createSession());
            message.setFrom(new InternetAddress(FROM));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(body);
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean sendHtmlEmail(String toEmail, String subject, String htmlBody) {
        try {
            Message message = new MimeMessage(createSession());
            message.setFrom(new InternetAddress(FROM));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(htmlBody, "text/html; charset=utf-8");
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static String buildVerificationEmail(String name, boolean approved) {
        String color  = approved ? "#27ae60" : "#e74c3c";
        String status = approved ? "Verified ✓" : "Rejected ✗";
        String msg    = approved
                ? "Your account has been verified. You now have full access to Basai."
                : "Your verification was not approved. Please contact support.";

        return """
            <div style="font-family:sans-serif;max-width:480px;margin:auto;padding:32px;
                        border:1px solid #eee;border-radius:12px;">
                <h2 style="color:#1a1a2e;">Basai</h2>
                <hr style="border:none;border-top:1px solid #eee;">
                <h3 style="color:%s;">Account %s</h3>
                <p>Hi <strong>%s</strong>,</p>
                <p>%s</p>
                <a href="http://localhost:8080/Basai"
                   style="display:inline-block;margin-top:16px;padding:10px 24px;
                          background:#1a1a2e;color:#fff;border-radius:8px;text-decoration:none;">
                    Go to Basai
                </a>
                <p style="margin-top:24px;font-size:.8rem;color:#aaa;">
                    © 2024 Basai. All rights reserved.
                </p>
            </div>
        """.formatted(color, status, name, msg);
    }
}