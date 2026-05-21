package basai.review.controller;

import basai.review.model.dao.ReviewDAO;
import basai.review.model.dto.ReviewDTO;
import basai.user.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/reviews/delete")
public class DeleteReviewServlet extends HttpServlet {

    private final ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        int renterId = user.getUser_id();

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

        String role = (String) request.getSession().getAttribute("role");
        boolean isOwner = existing.getRenterId() == renterId;
        boolean isAdmin = "admin".equals(role);

        if (!isOwner && !isAdmin) {
            response.sendRedirect(request.getContextPath()
                    + "/rooms/detail?roomId=" + existing.getRoomId() + "&error=unauthorized");
            return;
        }

        reviewDAO.deleteReview(reviewId);

        response.sendRedirect(request.getContextPath()
                + "/rooms/detail?roomId=" + existing.getRoomId() + "&success=deleted");
    }
}