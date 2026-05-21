package basai.review.model.dao;

import basai.review.model.Review;
import basai.review.model.dto.ReviewDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ReviewDAO implements ReviewInterface {

    @Override
    public void addReview(Review review) {
        String sql = "INSERT INTO reviews (renter_id, room_id, rating, comment, created_at) " +
                "VALUES (?, ?, ?, ?, NOW())";

        try (Connection conn = basai.utils.DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, review.getRenterId());
            ps.setInt(2, review.getRoomId());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getComment());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public ArrayList<ReviewDTO> getReviewsByRoom(int roomId) {
        String sql = """
                    
                SELECT r.*, u.name AS renter_name
                    FROM reviews r
                    JOIN users u ON r.renter_id = u.user_id
                    WHERE r.room_id = ?
                    ORDER BY r.created_at DESC
                    """;
        ArrayList<ReviewDTO> reviews = new ArrayList<>();

        try (Connection conn = basai.utils.DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ReviewDTO review = new ReviewDTO(
                        rs.getInt("review_id"),
                        rs.getInt("renter_id"),
                        rs.getString("renter_name"),
                        rs.getInt("room_id"),
                        rs.getInt("rating"),
                        rs.getString("comment"),
                        rs.getTimestamp("created_at").toLocalDateTime()
                );
                reviews.add(review);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviews;
    }

    @Override
    public void updateReview(Review review) {
        String sql = "UPDATE reviews SET rating = ?, comment = ? WHERE review_id = ?";

        try (Connection conn = basai.utils.DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, review.getRating());
            ps.setString(2, review.getComment());
            ps.setInt(3, review.getReviewId());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteReview(int reviewId) {
        String sql = "DELETE FROM reviews WHERE review_id = ?";

        try (Connection conn = basai.utils.DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, reviewId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public double getAverageRating(int roomId) {
        String sql = "SELECT AVG(rating) AS avg_rating FROM reviews WHERE room_id = ?";

        try (Connection conn = basai.utils.DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDouble("avg_rating");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }

        @Override
    public ReviewDTO getReviewById(int reviewId) {
        String sql = "SELECT * FROM reviews WHERE reviewId = ?";
        ReviewDTO review = null;

        try (Connection conn = basai.utils.DBConnection.
             getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, reviewId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                review = new ReviewDTO(
                        rs.getInt("reviewId"),
                        rs.getInt("roomId"),
                        rs.getInt("renterId"),
                        rs.getInt("rating"),
                        rs.getString("comment"),
                        rs.getTimestamp("createdAt").toLocalDateTime()
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return review;
    }
}