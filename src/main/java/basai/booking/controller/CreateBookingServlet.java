package basai.booking.controller;

import basai.user.model.User;
import basai.booking.model.dao.BookingDAO;
import basai.booking.model.dto.BookingDTO;
import basai.room.model.dao.RoomDAO;
import basai.room.model.dto.RoomDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/bookings/submit")
public class CreateBookingServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            System.out.println(">>> session is NULL → redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        int renterId = user.getUser_id();
git
        String roomIdParam = request.getParameter("roomId");
        if (roomIdParam == null || roomIdParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/rooms/browse");
            return;
        }

        int roomId;
        try {
            roomId = Integer.parseInt(roomIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/rooms/browse");
            return;
        }

        RoomDTO room = roomDAO.getRoomById(roomId);
        if (room == null) {
            response.sendRedirect(request.getContextPath() + "/rooms/browse");
            return;
        }

        String stayTimeParam = request.getParameter("stayTime");
        int stayTime;
        try {
            stayTime = Integer.parseInt(stayTimeParam);
            if (stayTime < 1 || stayTime > 60) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Duration must be between 1 and 60 months.");
            request.setAttribute("room", room);
            request.getRequestDispatcher("/views/renter/bookingRequest.jsp")
                    .forward(request, response);
            return;
        }

        String message = request.getParameter("message");
        if (message != null) message = message.trim();

        BookingDTO booking = new BookingDTO(
                0,
                roomId,
                renterId,
                null,
                message,
                BookingDTO.Status.Pending,
                RoomDTO.AvailabilityStatus.Pending,
                stayTime,
                BookingDTO.PaidStatus.Pending,
                0
        );

        System.out.println(">>> About to call bookingDAO.createBooking()");
        boolean created = bookingDAO.createBooking(booking);
        if (!created) {
            request.setAttribute("errorMessage", "Failed to submit booking. Please try again.");
            request.setAttribute("room", room);
            request.getRequestDispatcher("/views/renter/bookingRequest.jsp")
                    .forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/bookings?success=created");
    }
}