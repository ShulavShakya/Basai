package basai.booking.model.dto;

import basai.room.model.dto.RoomDTO;

import java.time.LocalDateTime;

public class BookingDTO {
    public enum Status {
        Pending, Approved, Rejected
    }

    public enum PaidStatus {
        Paid, Pending
    }

    private int bookingId;
    private int roomId;
    private String roomName;
    private String roomLocation;
    private RoomDTO.AvailabilityStatus availabilityStatus;
    private int renterId;
    private String renterName;
    private LocalDateTime requestDate;
    private String message;
    private Status status;
    private int stayTime;
    private PaidStatus paidStatus;
    private int paidAmount;

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getRoomLocation() {
        return roomLocation;
    }

    public void setRoomLocation(String roomLocation) {
        this.roomLocation = roomLocation;
    }

    public RoomDTO.AvailabilityStatus getAvailabilityStatus() {
        return availabilityStatus;
    }

    public void setAvailabilityStatus(RoomDTO.AvailabilityStatus availabilityStatus) {
        this.availabilityStatus = availabilityStatus;
    }

    public int getRenterId() {
        return renterId;
    }

    public void setRenterId(int renterId) {
        this.renterId = renterId;
    }

    public String getRenterName() {
        return renterName;
    }

    public void setRenterName(String renterName) {
        this.renterName = renterName;
    }

    public LocalDateTime getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(LocalDateTime requestDate) {
        this.requestDate = requestDate;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public int getStayTime() {
        return stayTime;
    }

    public void setStayTime(int stayTime) {
        this.stayTime = stayTime;
    }

    public PaidStatus getPaidStatus() {
        return paidStatus;
    }

    public void setPaidStatus(PaidStatus paidStatus) {
        this.paidStatus = paidStatus;
    }

    public int getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(int paidAmount) {
        this.paidAmount = paidAmount;
    }

    public BookingDTO(int bookingId, int roomId, int renterId, LocalDateTime requestDate, String message, Status status, int stayTime, PaidStatus paidStatus, int paidAmount) {
        this.bookingId = bookingId;
        this.roomId = roomId;
        this.renterId = renterId;
        this.requestDate = requestDate;
        this.message = message;
        this.status = status;
        this.stayTime = stayTime;
        this.paidStatus = paidStatus;
        this.paidAmount = paidAmount;
    }

    public BookingDTO(int bookingId, int roomId, int renterId, LocalDateTime requestDate, String message, Status status, RoomDTO.AvailabilityStatus availabilityStatus, int stayTime, PaidStatus paidStatus, int paidAmount) {
        this.bookingId = bookingId;
        this.roomId = roomId;
        this.renterId = renterId;
        this.requestDate = requestDate;
        this.message = message;
        this.status = status;
        this.availabilityStatus = availabilityStatus;
        this.stayTime = stayTime;
        this.paidStatus = paidStatus;
        this.paidAmount = paidAmount;
    }

    public BookingDTO(int bookingId, int roomId, int renterId, LocalDateTime requestDate, String message, Status status, int stayTime, PaidStatus paidStatus, int paidAmount, String roomName, String roomLocation) {
        this.bookingId = bookingId;
        this.roomId = roomId;
        this.renterId = renterId;
        this.requestDate = requestDate;
        this.message = message;
        this.status = status;
        this.stayTime = stayTime;
        this.paidStatus = paidStatus;
        this.paidAmount = paidAmount;
        this.roomName = roomName;
        this.roomLocation = roomLocation;
    }

    public BookingDTO(int bookingId, int roomId, String roomName, String roomLocation, int renterId, String renterName, LocalDateTime requestDate, String message, Status status, int stayTime, PaidStatus paidStatus, int paidAmount) {
        this.bookingId = bookingId;
        this.roomId = roomId;
        this.roomName = roomName;
        this.roomLocation = roomLocation;
        this.renterId = renterId;
        this.renterName = renterName;
        this.requestDate = requestDate;
        this.message = message;
        this.status = status;
        this.stayTime = stayTime;
        this.paidStatus = paidStatus;
        this.paidAmount = paidAmount;
    }
}
