package basai.booking.controller;

import basai.booking.model.dto.BookingDTO;
import basai.booking.model.dao.BookingDAO;
import basai.room.model.dao.RoomDAO;
import basai.room.model.dto.RoomDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/owner/bookings/update")
public class UpdateBookingRequest extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"owner".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String bookingIdParam = request.getParameter("bookingId");
        String action = request.getParameter("action");

        if (bookingIdParam == null || action == null) {
            response.sendRedirect(request.getContextPath() + "/bookings");
            return;
        }

        int bookingId = Integer.parseInt(bookingIdParam);

        BookingDTO booking = bookingDAO.getBookingById(bookingId);

        if (booking == null) {
            response.sendRedirect(request.getContextPath() + "/bookings");
            return;
        }

        switch (action) {
            case "approve":
                booking.setStatus(BookingDTO.Status.Approved);
                RoomDTO room = roomDAO.getRoomById(booking.getRoomId());
                if(room != null){
                    room.setAvailabilityStatus(RoomDTO.AvailabilityStatus.Rented);
                    roomDAO.updateRoom(room);
                }
                break;

            case "reject":
                booking.setStatus(BookingDTO.Status.Rejected);
                booking.setAvailabilityStatus(RoomDTO.AvailabilityStatus.Available);
                break;

            default: {
                String status     = request.getParameter("status");
                String stayTime   = request.getParameter("stayTime");
                String paidStatus = request.getParameter("paidStatus");
                String paidAmount = request.getParameter("paidAmount");

                if (status     != null) booking.setStatus(BookingDTO.Status.valueOf(status));
                if (stayTime   != null) booking.setStayTime(Integer.parseInt(stayTime));
                if (paidStatus != null) booking.setPaidStatus(BookingDTO.PaidStatus.valueOf(paidStatus));
                if (paidAmount != null) booking.setPaidAmount(Integer.parseInt(paidAmount));
            }
        }

        bookingDAO.updateBooking(booking);
        response.sendRedirect(request.getContextPath() + "/bookings");
    }
}