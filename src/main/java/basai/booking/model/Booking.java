package basai.booking.model;

import java.math.BigDecimal;
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
    private PaidStatus paidStatus;
    private BigDecimal paidAmount;

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

    public PaidStatus getPaidStatus() {
        return paidStatus;
    }

    public void setPaidStatus(PaidStatus paidStatus) {
        this.paidStatus = paidStatus;
    }

    public BigDecimal getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(BigDecimal paidAmount) {
        this.paidAmount = paidAmount;
    }

    public Booking(int bookingId, int roomId, int renterId, LocalDateTime requestDate, String message, Status status, PaidStatus paidStatus, BigDecimal paidAmount) {
        this.bookingId = bookingId;
        this.roomId = roomId;
        this.renterId = renterId;
        this.requestDate = requestDate;
        this.message = message;
        this.status = status;
        this.paidStatus = paidStatus;
        this.paidAmount = paidAmount;
    }
}