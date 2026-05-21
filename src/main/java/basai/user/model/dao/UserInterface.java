package basai.user.model.dao;

import basai.user.model.User;

import java.util.ArrayList;

public interface UserInterface {
    boolean registerUser(User user);
    User loginUser(String email, String password);
    ArrayList<User> getAllUsers();
    ArrayList<User> getUsersByRole(String role);
    User getUserById(int user_id);
    boolean updateUser(User user);
    boolean deleteUser(User user);
}
