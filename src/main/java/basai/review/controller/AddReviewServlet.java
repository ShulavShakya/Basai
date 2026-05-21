package basai.review.controller;

import basai.booking.model.dao.BookingDAO;
import basai.booking.model.dto.BookingDTO;
import basai.review.model.Review;
import basai.review.model.dao.ReviewDAO;
import basai.review.model.dto.ReviewDTO;
import basai.user.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/reviews/add")
public class AddReviewServlet extends HttpServlet {

    private final ReviewDAO reviewDAO = new ReviewDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        int renterId =user.getUser_id();

        // ── Parse roomId ─────────────────────────────────────────────
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

        ArrayList<BookingDTO> allBookings = bookingDAO.getAllBookings();
        boolean hasApprovedBooking = allBookings.stream()
                .anyMatch(b -> b.getRenterId() == renterId
                        && b.getRoomId() == roomId
                        && b.getStatus() == BookingDTO.Status.Approved);

        if (!hasApprovedBooking) {
            response.sendRedirect(request.getContextPath()
                    + "/rooms/detail?roomId=" + roomId + "&error=no_booking");
            return;
        }

        request.setAttribute("hasApprovedBooking", hasApprovedBooking);

        ArrayList<ReviewDTO> reviews = reviewDAO.getReviewsByRoom(roomId);
        request.setAttribute("reviews", reviews);

        String ratingParam = request.getParameter("rating");
        int rating;
        try {
            rating = Integer.parseInt(ratingParam);
            if (rating < 1 || rating > 5) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath()
                    + "/rooms/detail?roomId=" + roomId + "&error=invalid_rating");
            return;
        }

        String comment = request.getParameter("comment");
        if (comment != null) comment = comment.trim();

        Review review = new Review(0, renterId, roomId, rating, comment, null);
        reviewDAO.addReview(review);

        response.sendRedirect(request.getContextPath()
                + "/rooms/detail?roomId=" + roomId + "&success=reviewed");
    }
}