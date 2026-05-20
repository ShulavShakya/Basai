package basai.room.model.dao;

import basai.room.model.Room;
import basai.room.model.dto.RoomDTO;

import java.sql.*;
import java.util.ArrayList;

public class RoomDAO implements RoomInterface {
    @Override
    public boolean addRoom(RoomDTO room) {
        String sql = "INSERT INTO rooms (room_id, owner_id, title, description, rent_price, photo_1, photo_2, photo_3, photo_4, photo_5, " +
                "city, address, room_type, furnishing_status, availability_status, facilities, " +
                "created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";

        try (Connection conn = basai.utils.DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, room.getRoomId());
            ps.setInt(2, room.getOwnerId());
            ps.setString(3, room.getTitle());
            ps.setString(4, room.getDescription());
            ps.setBigDecimal(5, room.getRentPrice());
            ps.setString(6, room.getPhoto1());
            ps.setString(7, room.getPhoto2());
            ps.setString(8, room.getPhoto3());
            ps.setString(9, room.getPhoto4());
            ps.setString(10, room.getPhoto5());
            ps.setString(11, room.getCity());
            ps.setString(12, room.getAddress());
            ps.setString(13, room.getRoomType().name());
            ps.setString(14, room.getFurnishingStatus().name());
            ps.setString(15, room.getAvailabilityStatus().name());
            ps.setString(16, room.getFacilities());

            int row = ps.executeUpdate();
            return row > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public ArrayList<RoomDTO> getAllRooms() {
        String sql = "SELECT r.*, u.name AS owner_name FROM rooms r JOIN users u ON r.owner_id = u.user_id";
        ArrayList<RoomDTO> rooms = new ArrayList<>();

        try (Connection conn = basai.utils.DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                RoomDTO room = new RoomDTO(
                        rs.getInt("room_id"),
                        rs.getInt("owner_id"),
                        rs.getString("owner_name"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getBigDecimal("rent_price"),
                        rs.getString("photo_1"),
                        rs.getString("photo_2"),
                        rs.getString("photo_3"),
                        rs.getString("photo_4"),
                        rs.getString("photo_5"),
                        rs.getString("city"),
                        rs.getString("address"),
                        RoomDTO.RoomType.valueOf(rs.getString("room_type").trim().toUpperCase()),
                        RoomDTO.FurnishingStatus.valueOf(rs.getString("furnishing_status")),
                        RoomDTO.AvailabilityStatus.valueOf(rs.getString("availability_status")),
                        rs.getString("facilities"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getTimestamp("updated_at").toLocalDateTime()
                );
                rooms.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rooms;
    }

    @Override
    public RoomDTO getRoomById(int roomId) {
        String sql = "SELECT r.*, u.name AS owner_name FROM rooms r JOIN users u ON r.owner_id = u.user_id WHERE r.room_id = ?";


        try(Connection conn = basai.utils.DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();


            if (rs.next()) {
                return new RoomDTO(
                        rs.getInt("room_id"),
                        rs.getInt("owner_id"),
                        rs.getString("owner_name"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getBigDecimal("rent_price"),
                        rs.getString("photo_1"),
                        rs.getString("photo_2"),
                        rs.getString("photo_3"),
                        rs.getString("photo_4"),
                        rs.getString("photo_5"),
                        rs.getString("city"),
                        rs.getString("address"),
                        RoomDTO.RoomType.valueOf(rs.getString("room_type")),
                        RoomDTO.FurnishingStatus.valueOf(rs.getString("furnishing_status")),
                        RoomDTO.AvailabilityStatus.valueOf(rs.getString("availability_status")),
                        rs.getString("facilities"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getTimestamp("updated_at").toLocalDateTime()
                );
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updateRoom(Room room) {
        String sql = "UPDATE rooms SET owner_id=?, title=?, description=?, rent_price=?, photo_1=?, " +
                "photo_2=?, photo_3=?, city=?, address=?, room_type=?, furnishing_status=?, " +
                "availability_status=?, facilities=?, updatedAt=NOW() WHERE room_id=?";

        try (Connection conn = basai.utils.DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)){

            ps.setInt(1, room.getOwnerId());
            ps.setString(2, room.getTitle());
            ps.setString(3, room.getDescription());
            ps.setBigDecimal(4, room.getRentPrice());
            ps.setString(5, room.getPhoto1());
            ps.setString(6, room.getPhoto2());
            ps.setString(7, room.getPhoto3());
            ps.setString(8, room.getCity());
            ps.setString(9, room.getAddress());
            ps.setString(10, room.getRoomType().name());
            ps.setString(11, room.getFurnishingStatus().name());
            ps.setString(12, room.getAvailabilityStatus().name());
            ps.setString(13, room.getFacilities());
            ps.setInt(14, room.getRoomId());

            int row = ps.executeUpdate();
            return row>0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}