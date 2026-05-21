package basai.review.controller;

import basai.review.model.Review;
import basai.review.model.dao.ReviewDAO;
import basai.review.model.dto.ReviewDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/reviews/update")
public class UpdateReviewServlet extends HttpServlet {

    private final ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer renterId = (Integer) request.getSession().getAttribute("userId");
        if (renterId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String reviewIdParam = request.getParameter("reviewId");
        int reviewId;
        try {
            reviewId = Integer.parseInt(reviewIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/renter/bookings");
            return;
        }

        ReviewDTO existing = reviewDAO.getReviewById(reviewId);
        if (existing == null) {
            response.sendRedirect(request.getContextPath() + "/renter/bookings");
            return;
        }

        if (existing.getRenterId() != renterId) {
            response.sendRedirect(request.getContextPath()
                    + "/rooms/detail?roomId=" + existing.getRoomId() + "&error=unauthorized");
            return;
        }

        String ratingParam = request.getParameter("rating");
        int rating;
        try {
            rating = Integer.parseInt(ratingParam);
            if (rating < 1 || rating > 5) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath()
                    + "/rooms/detail?roomId=" + existing.getRoomId() + "&error=invalid_rating");
            return;
        }

        String comment = request.getParameter("comment");
        if (comment != null) comment = comment.trim();

        Review review = new Review(
                reviewId,
                existing.getRenterId(),
                existing.getRoomId(),
                rating,
                comment,
                existing.getCreatedAt()
        );
        reviewDAO.updateReview(review);

        response.sendRedirect(request.getContextPath()
                + "/rooms/detail?roomId=" + existing.getRoomId() + "&success=updated");
    }
}