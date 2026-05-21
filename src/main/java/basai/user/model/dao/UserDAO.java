
package basai.user.model.dao;
import basai.user.model.User;
import org.mindrot.jbcrypt.BCrypt;
import basai.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserDAO implements UserInterface {

    @Override
    public boolean registerUser(User user) {
        if (user.getEmail().trim().isEmpty() || user.getPassword().trim().isEmpty()) {
            return false;
        }

        String sql = "INSERT INTO users(name,email,password,phone,dob,profile_photo,occupation," +
                "preferred_location,verification_document,verification_status,role,created_at) " +
                "VALUES(?,?,?,?,?,?,?,?,?,?,?,NOW())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getDob());
            ps.setString(6, user.getProfilePhoto());
            ps.setString(7, user.getOccupation());
            ps.setString(8, user.getPreferredLocation());
            ps.setString(9, user.getVerificationDocument());
            ps.setString(10, user.getVerificationStatus().name());
            ps.setString(11, user.getRole());

            int row = ps.executeUpdate();
            return row > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public User loginUser(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println(rs.getInt("user_id"));
                System.out.println(rs.getString("email"));
                System.out.println(rs.getString("password"));
                String hashedPassword = rs.getString("password");
                if (BCrypt.checkpw(password, hashedPassword)) {
                    System.out.println("Password match for user: " + email);
                    return new User(
                            rs.getInt("user_id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            hashedPassword,
                            User.VerificationStatus.valueOf(rs.getString("verification_status")),
                            rs.getString("role")
                    );
                }else{
                    System.out.println("Password mismatch for user: " + email);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public ArrayList<User> getAllUsers() {
        ArrayList<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = new User(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("dob"),
                        rs.getString("profile_photo"),
                        rs.getString("occupation"),
                        rs.getString("preferred_location"),
                        rs.getString("verification_document"),
                        User.VerificationStatus.valueOf(rs.getString("verification_status")),
                        rs.getString("role")
                );
                users.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public ArrayList<User> getUsersByRole(String role) {
        ArrayList<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String statusRaw = rs.getString("verification_status");
                String statusNormalized = statusRaw.substring(0, 1).toUpperCase()
                        + statusRaw.substring(1).toLowerCase();

                users.add(new User(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("dob"),
                        rs.getString("profile_photo"),
                        rs.getString("occupation"),
                        rs.getString("preferred_location"),
                        rs.getString("verification_document"),
                        User.VerificationStatus.valueOf(statusNormalized),
                        rs.getString("role")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public User getUserById(int user_id) {
        String sql = "SELECT * FROM users WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, user_id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String statusRaw = rs.getString("verification_status");
                String statusNormalized = statusRaw.substring(0, 1).toUpperCase()
                        + statusRaw.substring(1).toLowerCase();

                return new User(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("dob"),
                        rs.getString("profile_photo"),
                        rs.getString("occupation"),
                        rs.getString("preferred_location"),
                        rs.getString("verification_document"),
                        User.VerificationStatus.valueOf(statusNormalized),
                        rs.getString("role")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET name=?, email=?, password=?, phone=?, dob=?, profile_photo=?, " +
                "occupation=?, preferred_location=?, verification_document=?, role=?, " +
                "verification_status=UPPER(?) WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getDob());
            ps.setString(6, user.getProfilePhoto());
            ps.setString(7, user.getOccupation());
            ps.setString(8, user.getPreferredLocation());
            ps.setString(9, user.getVerificationDocument());
            ps.setString(10, user.getRole());
            ps.setString(11, user.getVerificationStatus().name());
            ps.setInt(12, user.getUser_id());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteUser(User user) {
        String sql = "DELETE FROM users WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, user.getUser_id());
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateVerificationStatus(int userId, User.VerificationStatus status) {
        String sql = "UPDATE users SET verification_status = ? WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status.name());
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}