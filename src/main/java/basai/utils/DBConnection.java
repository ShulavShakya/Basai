package basai.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBConnection {

    // Add to DBConnection.java temporarily
    public static void testQuery() {
        try (Connection conn = getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT user_id, email, role FROM users");
            ResultSet rs = ps.executeQuery();
            System.out.println("=== DB TEST ===");
            while (rs.next()) {
                System.out.println("Row: " + rs.getInt("user_id") + " | " + rs.getString("email") + " | " + rs.getString("role"));
            }
            System.out.println("=== END DB TEST ===");
        } catch (Exception e) {
            System.out.println("DB TEST ERROR: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/basai";
    private static final String DB_User = "root";
    private static final String DB_Password = "12345678";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(DB_URL, DB_User, DB_Password);
    }
}
