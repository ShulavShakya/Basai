package basai.utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection getConnection() throws Exception {
        Class.forName(ConfigLoader.getProperty("db.driver"));

        return DriverManager.getConnection(
                ConfigLoader.getProperty("db.url"),
                ConfigLoader.getProperty("db.username"),
                ConfigLoader.getProperty("db.password")
        );
    }
}