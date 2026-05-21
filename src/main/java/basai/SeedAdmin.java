package basai;

import org.mindrot.jbcrypt.BCrypt;

public class SeedAdmin {
    public static void main(String[] args) {
        String plainPassword = "admin123";
        String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt());
        System.out.println("Hashed password for 'admin123': " + hashedPassword);
    }
}
