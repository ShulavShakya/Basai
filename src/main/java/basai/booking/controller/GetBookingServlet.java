package basai.booking.controller;

import basai.booking.model.dao.BookingDAO;
import basai.booking.model.dto.BookingDTO;
import basai.user.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/bookings")
public class GetBookingServlet extends HttpServlet {
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String role = (String) session.getAttribute("role");

        if (user == null || role == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        ArrayList<BookingDTO> bookings;

        switch (role){
            case "renter":
                bookings = bookingDAO.getBookingsByRenter(user.getUser_id());
                request.setAttribute("bookings", bookings);
                request.getRequestDispatcher("/views/renter/bookings.jsp")
                        .forward(request, response);
                break;

            case "owner":
                bookings = bookingDAO.getBookingsByOwner(user.getUser_id());
                request.setAttribute("bookings", bookings);
                request.getRequestDispatcher("/views/owner/bookingRequests.jsp")
                        .forward(request, response);
                break;

            default: response.sendRedirect(request.getContextPath() + "/login.jsp");

        }
    }
}
