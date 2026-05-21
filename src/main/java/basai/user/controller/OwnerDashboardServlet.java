package basai.user.controller;

import basai.booking.model.dao.BookingDAO;
import basai.booking.model.dto.BookingDTO;
import basai.room.model.dao.RoomDAO;
import basai.room.model.dto.RoomDTO;
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

@WebServlet("/owner/dashboard")
public class OwnerDashboardServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"owner".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        int ownerId = user.getUser_id();

        // --- Rooms ---
        ArrayList<RoomDTO> allRooms = roomDAO.getRoomsByOwner(ownerId);
        long activeCount = allRooms.stream()
                .filter(r -> "Available".equalsIgnoreCase(r.getAvailabilityStatus().name()))
                .count();

        ArrayList<RoomDTO> recentRooms = allRooms.stream()
                .limit(3)
                .collect(Collectors.toCollection(ArrayList::new));

        ArrayList<BookingDTO> allBookings = bookingDAO.getBookingsByOwner(ownerId);

        long pendingCount = allBookings.stream()
                .filter(b -> "Pending".equalsIgnoreCase(b.getStatus().name()))
                .count();

        long approvedCount = allBookings.stream()
                .filter(b -> "Approved".equalsIgnoreCase(b.getStatus().name()))
                .count();

        ArrayList<BookingDTO> recentBookings = allBookings.stream()
                .limit(3)
                .collect(Collectors.toCollection(ArrayList::new));

        request.setAttribute("totalListings",    allRooms.size());
        request.setAttribute("activeListings",   activeCount);
        request.setAttribute("bookingRequests",  pendingCount);
        request.setAttribute("approvedBookings", approvedCount);
        request.setAttribute("recentRooms",      recentRooms);
        request.setAttribute("recentBookings",   recentBookings);

        request.getRequestDispatcher("/views/owner/dashboard.jsp")
                .forward(request, response);
    }
}