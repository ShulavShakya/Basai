package basai.user.controller;

import basai.booking.model.dao.BookingDAO;
import basai.booking.model.dto.BookingDTO;
import basai.favourite.model.dao.FavouriteDAO;
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

@WebServlet("/renter/dashboard")
public class RenterDashboardServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final FavouriteDAO favouriteDAO = new FavouriteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"renter".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        int renterId = user.getUser_id();

        ArrayList<BookingDTO> allBookings = bookingDAO.getBookingsByRenter(renterId);

        long pendingCount  = allBookings.stream()
                .filter(b -> b.getStatus() == BookingDTO.Status.Pending)
                .count();

        long approvedCount = allBookings.stream()
                .filter(b -> b.getStatus() == BookingDTO.Status.Approved)
                .count();

        ArrayList<BookingDTO> recentBookings = allBookings.stream()
                .limit(3)
                .collect(Collectors.toCollection(ArrayList::new));

        int savedCount = favouriteDAO.getFavouritesByRenter(renterId).size();

        request.setAttribute("totalBookings",  allBookings.size());
        request.setAttribute("pendingCount",   pendingCount);
        request.setAttribute("approvedCount",  approvedCount);
        request.setAttribute("savedCount",     savedCount);
        request.setAttribute("recentBookings", recentBookings);

        request.getRequestDispatcher("/views/renter/dashboard.jsp")
                .forward(request, response);
    }
}