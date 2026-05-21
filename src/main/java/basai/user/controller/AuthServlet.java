package basai.user.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;
import basai.user.model.User;
import basai.user.model.dao.UserDAO;

import java.io.File;
import java.io.IOException;

@WebServlet("/user-auth")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize       = 5 * 1024 * 1024,
        maxRequestSize    = 10 * 1024 * 1024
)
public class AuthServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO userDAO = new UserDAO();
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing 'action' parameter");
            return;
        }

        if (action.equals("register")) {
            String name                 = request.getParameter("name");
            String email                = request.getParameter("email");
            String password             = request.getParameter("password");
            String phone                = request.getParameter("phone");
            String dob                  = request.getParameter("dob");
            String occupation           = request.getParameter("occupation");
            String preferredLocation    = request.getParameter("preferredLocation");
            String role                 = request.getParameter("role");

            // Handle file uploads - save filename or path as string
            Part verificationDocPart = request.getPart("verificationDocument");
            if(verificationDocPart.getSize() > 5 * 1024 * 1024){
                request.setAttribute("error", "Verification document exceeds maximum allowed size of 5MB.");
                request.getRequestDispatcher("/views/register.jsp").forward(request, response);
                return;
            }
            String verificationDocFileName = new File(verificationDocPart.getSubmittedFileName()).getName();
            String verificationDocUploadPath = getServletContext().getRealPath("/uploads/verificationDocuments/") + "/";
            File verificationDocUploadDir = new File(verificationDocUploadPath);
            if (!verificationDocUploadDir.exists()) {
                verificationDocUploadDir.mkdirs();
            }
            verificationDocPart.write(verificationDocUploadPath + File.separator + verificationDocFileName);

            Part profilePhotoPart = request.getPart("profilePhoto");
            String profilePhotoFileName = null;

            if(profilePhotoPart != null && profilePhotoPart.getSize() > 0) {

                if (profilePhotoPart.getSize() > 5 * 1024 * 1024) {
                    request.setAttribute("error", "Profile photo exceeds maximum allowed size of 5MB.");
                    request.getRequestDispatcher("/views/register.jsp").forward(request, response);
                    return;
                }
                profilePhotoFileName = new File(profilePhotoPart.getSubmittedFileName()).getName();
                String profilePhotoUploadPath = getServletContext().getRealPath("/uploads/profilePhotos/") + "/";
                File profilePhotoUploadDir = new File(profilePhotoUploadPath);
                if (!profilePhotoUploadDir.exists()) {
                    profilePhotoUploadDir.mkdirs();
                }
                profilePhotoPart.write(profilePhotoUploadPath + File.separator + profilePhotoFileName);
            }

            if (password == null || password.length() < 8) {
                request.setAttribute("error", "Password must be at least 8 characters.");
                request.getRequestDispatcher("/views/register.jsp").forward(request, response);
                return;
            }

            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            User user = new User(name, email, hashedPassword, phone, dob, profilePhotoFileName,
                    occupation, preferredLocation, verificationDocFileName,
                    User.VerificationStatus.Pending, role);

            boolean registered = userDAO.registerUser(user);
            if (registered) {
                response.sendRedirect(request.getContextPath() + "/views/verificationPending.jsp");
            } else {
                System.out.println("Registration failed for email: " + email);
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            }

        } else if (action.equals("login")) {
            System.out.println("Login action triggered");
            String email    = request.getParameter("email");
            String password = request.getParameter("password");

            System.out.println("email: " + email + ", password: " + password);

            User user = userDAO.loginUser(email, password);

            if (user != null) {
                if(user.getVerificationStatus() == User.VerificationStatus.Pending){
                    request.setAttribute("error", "Your account is pending verification. Please wait for an admin to verify your account.");
                    request.getRequestDispatcher("/views/verificationPending.jsp").forward(request, response);
                    return;
                }

                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("role", user.getRole());

                System.out.println(user);

                Cookie emailCookie = new Cookie("userEmail", user.getEmail());
                emailCookie.setMaxAge(24 * 60 * 60);
                emailCookie.setHttpOnly(true);
                response.addCookie(emailCookie);

                switch (user.getRole().toLowerCase()) {
                    case "admin":
                        response.sendRedirect(request.getContextPath() + "/views/admin/dashboard.jsp");
                        break;
                    case "renter":
                        response.sendRedirect(request.getContextPath() + "/views/renter/dashboard.jsp");
                        break;
                    case "owner":
                        response.sendRedirect(request.getContextPath() + "/views/owner/dashboard.jsp");
                        break;
                    default:
                        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
                }
            }
            else {
                System.out.println("Login failed for email: " + email);
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            }
        }
        else if (action.equals("logout")) {
            HttpSession session = request.getSession();
            session.invalidate();

            Cookie emailCookie = new Cookie("userEmail", "");
            emailCookie.setMaxAge(0);
            response.addCookie(emailCookie);

            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}