package basai.booking.controller;

import basai.booking.model.dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/owner/bookings/delete")
public class DeleteBookingServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingIdParam = request.getParameter("bookingId");

        if (bookingIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/owner/bookings");
            return;
        }

        int bookingId = Integer.parseInt(bookingIdParam);
        bookingDAO.deleteBooking(bookingId);

        // Redirect back — adjust path if coming from renter view
        String referer = request.getParameter("redirectTo");
        if (referer != null && !referer.isBlank()) {
            response.sendRedirect(request.getContextPath() + referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/owner/bookings");
        }
    }
}