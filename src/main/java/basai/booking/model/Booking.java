package basai.booking.model;

import java.time.LocalDateTime;

public class Booking {
    public enum Status {
        Pending, Approved, Rejected
    }

    public enum PaidStatus {
        Paid, Pending
    }

    private int bookingId;
    private int roomId;
    private int renterId;
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

    public int getRenterId() {
        return renterId;
    }

    public void setRenterId(int renterId) {
        this.renterId = renterId;
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

    public Booking(int bookingId, int roomId, int renterId, LocalDateTime requestDate, String message, Status status, int stayTime, PaidStatus paidStatus, int paidAmount) {
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
}
