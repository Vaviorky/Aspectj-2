package app.loggers;

import app.annotations.PublicsLogger;

@PublicsLogger
public class Logger2 {
    public String getRandomString() {
        return "Random string";
    }

    public int getMinimalValue() {
        return -1;
    }

    public float tryDivideByZero() {
        return 1/0;
    }
}
