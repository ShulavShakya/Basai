package basai.favourite.model;

import java.time.LocalDateTime;

public class Favourite {
    private int favouriteId;
    private int renterId;
    private int roomId;
    private LocalDateTime savedAt;

    public int getFavouriteId() {
        return favouriteId;
    }

    public void setFavouriteId(int favouriteId) {
        this.favouriteId = favouriteId;
    }

    public int getRenterId() {
        return renterId;
    }

    public void setRenterId(int renterId) {
        this.renterId = renterId;
    }

    public LocalDateTime getSavedAt() {
        return savedAt;
    }

    public void setSavedAt(LocalDateTime savedAt) {
        this.savedAt = savedAt;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public Favourite(int favouriteId, int renterId, int roomId, LocalDateTime savedAt) {
        this.favouriteId = favouriteId;
        this.renterId = renterId;
        this.roomId = roomId;
        this.savedAt = savedAt;
    }
}