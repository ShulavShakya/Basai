package basai.room.controller;

import basai.booking.model.dao.BookingDAO;
import basai.booking.model.dto.BookingDTO;
import basai.favourite.model.dao.FavouriteDAO;
import basai.review.model.dao.ReviewDAO;
import basai.review.model.dto.ReviewDTO;
import basai.room.model.dto.RoomDTO;
import basai.room.model.dao.RoomDAO;
import basai.user.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/rooms/detail")
public class GetRoomByIdServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
        RoomDAO roomDAO = new RoomDAO();
        ReviewDAO reviewDAO = new ReviewDAO();
        BookingDAO bookingDAO = new BookingDAO();

        RoomDTO room = roomDAO.getRoomById(roomId);
        ArrayList<ReviewDTO> reviews = reviewDAO.getReviewsByRoom(roomId);
        double avgRating = reviewDAO.getAverageRating(roomId);

        if (room == null) {
            response.sendRedirect(request.getContextPath() + "/rooms/browse");
            return;
        }

        FavouriteDAO favouriteDAO = new FavouriteDAO();

        User user = (User) request.getSession().getAttribute("user");
        int renterId = user.getUser_id();
        boolean isFavourite = favouriteDAO.isFavourite(renterId, room.getRoomId());
        ArrayList<BookingDTO> allBookings = bookingDAO.getAllBookings();
        boolean hasApprovedBooking = allBookings.stream()
                .anyMatch(b -> b.getRenterId() == renterId
                        && b.getRoomId() == roomId
                        && b.getStatus() == BookingDTO.Status.Approved);

        request.setAttribute("hasApprovedBooking", hasApprovedBooking);
        request.setAttribute("isFavourite", isFavourite);
        request.setAttribute("room", room);
        request.setAttribute("reviews", reviews);
        request.setAttribute("avgRating", avgRating);
        request.getRequestDispatcher( "/views/renter/roomDetail.jsp")
                .forward(request, response);
    }
}