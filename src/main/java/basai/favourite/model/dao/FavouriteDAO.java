package basai.favourite.model.dao;

import basai.favourite.model.Favourite;
import basai.favourite.model.dto.FavouriteDTO;
import basai.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FavouriteDAO implements FavouriteInterface {

    @Override
    public void addFavourite(Favourite favourite) {
        String sql = "INSERT IGNORE INTO favourites (renter_id, room_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, favourite.getRenterId());
            ps.setInt(2, favourite.getRoomId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public FavouriteDTO getFavouriteById(int favouriteId) {
        String sql = "SELECT * FROM favourites WHERE favourite_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, favouriteId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new FavouriteDTO(
                        rs.getInt("favourite_id"),
                        rs.getInt("renter_id"),
                        rs.getInt("room_id"),
                        rs.getTimestamp("saved_at").toLocalDateTime()
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public ArrayList<FavouriteDTO> getFavouritesByRenter(int renterId) {
        String sql = "SELECT * FROM favourites WHERE renter_id = ? ORDER BY saved_at DESC";
        ArrayList<FavouriteDTO> favourites = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, renterId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                FavouriteDTO favourite =  new FavouriteDTO(
                        rs.getInt("favourite_id"),
                        rs.getInt("renter_id"),
                        rs.getInt("room_id"),
                        rs.getTimestamp("saved_at").toLocalDateTime()
                );
                favourites.add(favourite);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return favourites;
    }

    @Override
    public List<Integer> getFavouriteRoomIds(int renterId) {
        List<Integer> ids = new ArrayList<>();
        String sql = "SELECT room_id FROM favourites WHERE renter_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, renterId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ids.add(rs.getInt("room_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ids;
    }

    @Override
    public boolean isFavourite(int renterId, int roomId) {
        String sql = "SELECT 1 FROM favourites WHERE renter_id = ? AND room_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, renterId);
            ps.setInt(2, roomId);
            return ps.executeQuery().next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void deleteFavouriteByRenterAndRoom(int renterId, int roomId) {
        String sql = "DELETE FROM favourites WHERE renter_id = ? AND room_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, renterId);
            ps.setInt(2, roomId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}