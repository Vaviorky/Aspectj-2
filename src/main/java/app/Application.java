package app;

import app.loggers.Logger1;
import app.loggers.Logger2;

public class Application {
    public static void main(String[] args) throws Exception {
        UserService userService = new UserService();
        userService.addUser("jk","passjk","jk@gmail.com");
        if (userService.verify("test","passjk")) {
        	System.out.println("credentials verified");
        }

        userService.setAddress(null);

        Logger1 logger1 = new Logger1();
        logger1.logMethodWithString("Test1", "Test2");
        logger1.logMethodWithThrowing();
        logger1.logMethodWithValueReturn(4);

        Logger2 logger2 = new Logger2();
        logger2.getRandomString();
        logger2.getMinimalValue();
        logger2.tryDivideByZero();
    }
}
