package basai.user.controller;

import basai.user.model.User;
import basai.user.model.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/users/all")
public class GetAllUsersServlet extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String tab = request.getParameter("tab");
        if (tab == null || tab.isEmpty()){
            tab = "all";
        }

        UserDAO userDAO = new UserDAO();
        ArrayList<User> users;

        switch (tab.toLowerCase()) {
            case "renters": users = userDAO.getUsersByRole("renter"); break;
            case "owners":  users = userDAO.getUsersByRole("owner");  break;
            case "admins":  users = userDAO.getUsersByRole("admin");  break;
            default:        users = userDAO.getAllUsers();             break;
        }

        request.setAttribute("users", users);
        request.setAttribute("activeTab", tab);
        request.getRequestDispatcher("/views/admin/users.jsp").forward(request, response);
    }
}