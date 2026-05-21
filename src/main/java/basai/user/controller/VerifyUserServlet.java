package basai.user.controller;

import basai.user.model.User;
import basai.user.model.dao.UserDAO;
import basai.utils.EmailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/users/verify")
public class VerifyUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String userIdStr = request.getParameter("userId");
        String action    = request.getParameter("action"); // "verify" or "reject"

        if (userIdStr == null || action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
            return;
        }

        try {
            int userId      = Integer.parseInt(userIdStr);
            UserDAO userDAO = new UserDAO();
            boolean success = false;

            if ("verify".equals(action)) {
                success = userDAO.updateVerificationStatus(userId, User.VerificationStatus.Verified);

                if (success) {
                    User user = userDAO.getUserById(userId); // instance method, correct variable
                    if (user != null) {
                        EmailService.sendHtmlEmail(
                                user.getEmail(),
                                "Your Basai Account is Verified ✓",
                                EmailService.buildVerificationEmail(user.getName(), true)
                        );
                    }
                }

            } else if ("reject".equals(action)) {
                success = userDAO.updateVerificationStatus(userId, User.VerificationStatus.Pending);

                if (success) {
                    User user = userDAO.getUserById(userId);
                    if (user != null) {
                        EmailService.sendHtmlEmail(
                                user.getEmail(),
                                "Basai Verification Update",
                                EmailService.buildVerificationEmail(user.getName(), false)
                        );
                    }
                }
            }

            if (success) {
                response.sendRedirect(request.getContextPath() + "/users/all");
            } else {
                request.setAttribute("error", "Failed to update verification status.");
                request.getRequestDispatcher("/views/admin/users.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
        }
    }
}