pacpackage basai.review.model;

import java.time.LocalDateTime;

public class Review {
    private int reviewId;
    private int renterId;
    private int roomId;
    private int rating;
    private String comment;
    private LocalDateTime createdAt;

    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getRenterId() {
        return renterId;
    }

    public void setRenterId(int renterId) {
        this.renterId = renterId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public Review(int reviewId, int renterId, int roomId, int rating, String comment, LocalDateTime createdAt) {
        this.reviewId = reviewId;
        this.renterId = renterId;
        this.roomId = roomId;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
    }
}
