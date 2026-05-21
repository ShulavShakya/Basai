package basai.room.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Room {

    public enum FurnishingStatus {
        Furnished, Unfurnished, SemiFurnished
    }

    public enum AvailabilityStatus {
        Available, Rented
    }

    public enum RoomType{
         SINGLE, DOUBLE, ONE_BHK, TWO_BHK, STUDIO
    }
    private int roomId;
    private int ownerId;
    private String title;
    private String description;
    private BigDecimal rentPrice;
    private String photo1;
    private String photo2;
    private String photo3;
    private String photo4;
    private String photo5;
    private String city;
    private String address;
    private RoomType roomType;
    private FurnishingStatus furnishingStatus;
    private AvailabilityStatus availabilityStatus;
    private String facilities;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getRentPrice() {
        return rentPrice;
    }

    public void setRentPrice(BigDecimal rentPrice) {
        this.rentPrice = rentPrice;
    }

    public String getPhoto1() {
        return photo1;
    }

    public void setPhoto1(String photo1) {
        this.photo1 = photo1;
    }

    public String getPhoto2() {
        return photo2;
    }

    public void setPhoto2(String photo2) {
        this.photo2 = photo2;
    }

    public String getPhoto3() {
        return photo3;
    }

    public void setPhoto3(String photo3) {
        this.photo3 = photo3;
    }

    public String getPhoto4() {
        return photo4;
    }

    public void setPhoto4(String photo4) {
        this.photo4 = photo4;
    }

    public String getPhoto5() {
        return photo5;
    }

    public void setPhoto5(String photo5) {
        this.photo5 = photo5;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public RoomType getRoomType() {
        return roomType;
    }

    public void setRoomType(RoomType roomType) {
        this.roomType = roomType;
    }

    public FurnishingStatus getFurnishingStatus() {
        return furnishingStatus;
    }

    public void setFurnishingStatus(FurnishingStatus furnishingStatus) {
        this.furnishingStatus = furnishingStatus;
    }

    public AvailabilityStatus getAvailabilityStatus() {
        return availabilityStatus;
    }

    public void setAvailabilityStatus(AvailabilityStatus availabilityStatus) {
        this.availabilityStatus = availabilityStatus;
    }

    public String getFacilities() {
        return facilities;
    }

    public void setFacilities(String facilities) {
        this.facilities = facilities;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Room(int roomId,  int ownerId, String title, String description, BigDecimal rentPrice, String photo1, String photo2, String photo3, String photo4, String photo5, String city, String address, RoomType roomType, FurnishingStatus furnishingStatus, AvailabilityStatus availabilityStatus, String facilities, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.roomId = roomId;
        this.ownerId = ownerId;
        this.title = title;
        this.description = description;
        this.rentPrice = rentPrice;
        this.photo1 = photo1;
        this.photo2 = photo2;
        this.photo3 = photo3;
        this.city = city;
        this.address = address;
        this.roomType = roomType;
        this.furnishingStatus = furnishingStatus;
        this.availabilityStatus = availabilityStatus;
        this.facilities = facilities;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
}

