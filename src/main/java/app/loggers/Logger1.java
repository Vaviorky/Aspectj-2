package app.loggers;

import app.annotations.PublicsLogger;
import java.lang.IllegalArgumentException;

@PublicsLogger
public class Logger1 {
    public void logMethodWithString(String aa, String bb) {
        System.out.println("Caaling Logger1.logMethodWithString, aa:" + aa + ", bb: " + bb);
    }

    public void logMethodWithThrowing() {
        throw new IllegalArgumentException();
    }

    public int logMethodWithValueReturn(int i) {
        return i;
    }
}
