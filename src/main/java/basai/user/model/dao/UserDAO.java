package basai.user.model.dao;

import basai.user.model.User;
import basai.utils.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO implements UserInterface{
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
}
