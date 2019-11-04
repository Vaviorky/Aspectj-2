package app;

public class Application {
    public static void main(String[] args) {
        UserService userService = new UserService();
        userService.addUser("jk","passjk","jk@gmail.com");
        if (userService.verify(null,"passjk")) {
        	System.out.println("credentials verified");
        }
    }
}
