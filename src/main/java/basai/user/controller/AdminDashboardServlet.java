package basai.user.controller;

import basai.booking.model.dao.BookingDAO;
import basai.booking.model.dto.BookingDTO;
import basai.room.model.dao.RoomDAO;
import basai.room.model.dto.RoomDTO;
import basai.user.model.dao.UserDAO;
import basai.user.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.stream.Collectors;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final RoomDAO roomDAO = new RoomDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        ArrayList<User> allUsers = userDAO.getAllUsers();
        ArrayList<User> recentUsers = allUsers.stream()
                .limit(4)
                .collect(Collectors.toCollection(ArrayList::new));

        ArrayList<RoomDTO> allRooms = roomDAO.getAllRooms();
        ArrayList<RoomDTO> recentRooms = allRooms.stream()
                .limit(4)
                .collect(Collectors.toCollection(ArrayList::new));

        ArrayList<BookingDTO> allBookings = bookingDAO.getAllBookings();
        ArrayList<BookingDTO> recentBookings = allBookings.stream()
                .limit(4)
                .collect(Collectors.toCollection(ArrayList::new));

        long pendingCount = allBookings.stream()
                .filter(b -> b.getStatus() == BookingDTO.Status.Pending)
                .count();

        request.setAttribute("totalUsers",     allUsers.size());
        request.setAttribute("totalListings",  allRooms.size());
        request.setAttribute("totalBookings",  allBookings.size());
        request.setAttribute("pendingCount",   pendingCount);
        request.setAttribute("recentUsers",    recentUsers);
        request.setAttribute("recentRooms",    recentRooms);
        request.setAttribute("recentBookings", recentBookings);

        request.getRequestDispatcher("/views/admin/dashboard.jsp")
                .forward(request, response);
    }
}