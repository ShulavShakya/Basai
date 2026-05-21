package basai.booking.model.dao;

import basai.booking.model.dto.BookingDTO;

import java.util.ArrayList;


public interface BookingInterface {
    boolean createBooking(BookingDTO booking);
    BookingDTO getBookingById(int bookingId);
    ArrayList<BookingDTO> getBookingsByRenter(int renterId);
    ArrayList<BookingDTO> getBookingsByOwner(int renterId);
    ArrayList<BookingDTO> getAllBookings();
    void updateBooking(BookingDTO booking);
    void deleteBooking(int bookingId);
}
