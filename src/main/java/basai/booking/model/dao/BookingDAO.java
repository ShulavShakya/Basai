package basai.booking.model.dao;

import basai.booking.model.dto.BookingDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BookingDAO implements BookingInterface{
    @Override
    public boolean createBooking(BookingDTO booking) {
        String sql = "INSERT INTO bookings (room_id, renter_id, request_date, message, status, stay_time," +
                "paid_status, paid_amount) VALUES (?, ?, NOW(), ?, ?, ?, ?, ?)";

        try (Connection conn = basai.utils.DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)){

            System.out.println("=== createBooking DEBUG ===");
            System.out.println("roomId:     " + booking.getRoomId());
            System.out.println("renterId:   " + booking.getRenterId());
            System.out.println("message:    " + booking.getMessage());
            System.out.println("status:     " + booking.getStatus());
            System.out.println("stayTime:   " + booking.getStayTime());
            System.out.println("paidStatus: " + booking.getPaidStatus());
            System.out.println("paidAmount: " + booking.getPaidAmount());

            ps.setInt(1, booking.getRoomId());
            ps.setInt(2, booking.getRenterId());
            ps.setString(3, booking.getMessage());
            ps.setString(4, booking.getStatus().name());
            ps.setInt(5, booking.getStayTime());
            ps.setString(6, booking.getPaidStatus().name());
            ps.setInt(7, booking.getPaidAmount());

            int row = ps.executeUpdate();
            return row>0;

        }catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public BookingDTO getBookingById(int bookingId) {
        String sql =  """
            SELECT b.*, r.title AS room_name, r.city AS location, u.name AS renter_name
            FROM bookings b
            JOIN rooms r ON b.room_id = r.room_id
            JOIN users u ON b.renter_id = u.user_id
            WHERE b.booking_id = ?
            """;
        BookingDTO booking = null;

        try (Connection conn = basai.utils.DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)){

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                booking = new BookingDTO(
                        rs.getInt("booking_id"),
                        rs.getInt("room_id"),
                        rs.getString("room_name"),
                        rs.getString("location"),
                        rs.getInt("renter_id"),
                        rs.getString("renter_name"),
                        rs.getTimestamp("request_date").toLocalDateTime(),
                        rs.getString("message"),
                        BookingDTO.Status.valueOf(rs.getString("status")),
                        rs.getInt("stay_time"),
                        BookingDTO.PaidStatus.valueOf(rs.getString("paid_status")),
                        rs.getInt("paid_amount")
                );
            }

        }catch (Exception e){
            e.printStackTrace();
        }
        return booking;
    }

    @Override
    public ArrayList<BookingDTO> getBookingsByRenter(int renterId) {
        String sql = "SELECT b.*, r.title as room_name, r.city as location FROM bookings b JOIN rooms r ON b.room_id = r.room_id WHERE renter_id = ?";
        ArrayList<BookingDTO> bookings = new ArrayList<>();

        try (Connection conn = basai.utils.DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, renterId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BookingDTO booking = new BookingDTO(
                        rs.getInt("booking_id"),
                        rs.getInt("room_id"),
                        rs.getInt("renter_id"),
                        rs.getTimestamp("request_date").toLocalDateTime(),
                        rs.getString("message"),
                        BookingDTO.Status.valueOf(rs.getString("status")),
                        rs.getInt("stay_time"),
                        BookingDTO.PaidStatus.valueOf(rs.getString("paid_status")),
                        rs.getInt("paid_amount"),
                        rs.getString("room_name"),
                        rs.getString("location")
                );
                bookings.add(booking);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookings;
    }

    @Override
    public ArrayList<BookingDTO> getBookingsByOwner(int ownerId) {
        String sql = """
            SELECT b.booking_id, b.room_id, b.renter_id, b.request_date,
                   b.message, b.status, b.stay_time, b.paid_status, b.paid_amount,
                   r.title AS room_name, r.city AS location,
                   u.name AS renter_name
            FROM bookings b
            JOIN rooms r ON b.room_id = r.room_id
            JOIN users u ON b.renter_id = u.user_id
            WHERE r.owner_id = ?
            """;
        ArrayList<BookingDTO> bookings = new ArrayList<>();

        try (Connection conn = basai.utils.DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ownerId);
            System.out.println(">>> running getBookingsByOwner for ownerId: " + ownerId);
            ResultSet rs = ps.executeQuery();
            System.out.println(">>> query executed");

            while (rs.next()) {
                BookingDTO booking = new BookingDTO(
                        rs.getInt("booking_id"),
                        rs.getInt("room_id"),
                        rs.getString("room_name"),
                        rs.getString("location"),
                        rs.getInt("renter_id"),
                        rs.getString("renter_name"),
                        rs.getTimestamp("request_date").toLocalDateTime(),
                        rs.getString("message"),
                        BookingDTO.Status.valueOf(rs.getString("status")),
                        rs.getInt("stay_time"),
                        BookingDTO.PaidStatus.valueOf(rs.getString("paid_status")),
                        rs.getInt("paid_amount")
                );
                bookings.add(booking);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookings;
    }

    @Override
    public ArrayList<BookingDTO> getAllBookings() {

        ArrayList<BookingDTO> bookings = new ArrayList<>();

        String sql = "SELECT * FROM bookings";

        try(Connection conn = basai.utils.DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()){

            while(rs.next()){
                BookingDTO booking = new BookingDTO(
                        rs.getInt("booking_id"),
                        rs.getInt("room_id"),
                        rs.getInt("renter_id"),
                        rs.getTimestamp("request_date").toLocalDateTime(),
                        rs.getString("message"),
                        BookingDTO.Status.valueOf(rs.getString("status")),
                        rs.getInt("stay_time"),
                        BookingDTO.PaidStatus.valueOf(rs.getString("paid_status")),
                        rs.getInt("paid_amount")
                );
                bookings.add(booking);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookings;
    }

    @Override
    public void updateBooking(BookingDTO booking) {
        String sql = "UPDATE bookings SET status = ?, stay_time = ?, paid_status = ?, paid_amount = ? WHERE booking_id = ?";

        try (Connection conn = basai.utils.DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, booking.getStatus().name());
            ps.setInt(2, booking.getStayTime());
            ps.setString(3, booking.getPaidStatus().name());
            ps.setInt(4, booking.getPaidAmount());
            ps.setInt(5, booking.getBookingId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteBooking(int bookingId) {
        String sql = "DELETE FROM bookings WHERE booking_id = ?";

        try (Connection conn = basai.utils.DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
