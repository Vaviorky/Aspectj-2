package app;

import app.annotations.NotNull;
import app.annotations.NotNullArgs;

public class UserService {

    @NotNull
    private String address;

    @NotNullArgs
    public boolean verify(String username, String pasword) {
        System.out.println("UserService.verify called");
        return false;
    }

    public boolean addUser(String username, String password, String email) {
        System.out.println("UserService.add called");
        return false;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
