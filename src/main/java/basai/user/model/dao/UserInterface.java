package basai.user.model.dao;

import basai.user.model.User;

public interface UserInterface {
    boolean registerUser(User user);
    User loginUser(String email, String password);
}
