package app;

import app.annotations.NotNullArgs;

public class UserService {

    @NotNullArgs
    public boolean verify(String username, String pasword) {
        System.out.println("UserService.verify called");
        return false;
    }

    public boolean addUser(String username, String password, String email) {
        System.out.println("UserService.add called");
        return false;
    }
}
