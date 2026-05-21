package basai.review.model.dao;

import basai.review.model.Review;
import basai.review.model.dto.ReviewDTO;

import java.util.ArrayList;


public interface ReviewInterface {
    void addReview(Review review);
    ArrayList<ReviewDTO> getReviewsByRoom(int roomId);
    double getAverageRating(int roomId);
    void updateReview(Review review);
    void deleteReview(int reviewId);
    ReviewDTO getReviewById(int reviewId);
}
