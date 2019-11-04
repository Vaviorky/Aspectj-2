package app;

import app.annotations.PublicsLogger;
import app.annotations.NotNull;
import app.annotations.NotNullArgs;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.reflect.FieldSignature;
import org.aspectj.lang.reflect.MethodSignature;
import sun.reflect.generics.reflectiveObjects.NotImplementedException;

import java.lang.reflect.Field;
import java.lang.reflect.Parameter;
import java.util.logging.ConsoleHandler;
import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.Logger;

public aspect Aspect1 {

    pointcut notNullArgs(): call(@NotNullArgs * *.*(..));

    before():notNullArgs() {
        MethodSignature signature = (MethodSignature) thisJoinPoint.getSignature();
        String[] parameterNames = signature.getParameterNames();
        Class[] parameterTypes = signature.getParameterTypes();
        Object[] parameterValues = thisJoinPoint.getArgs();

        for (int i = 0; i < parameterValues.length; i++) {
            Object parameterValue = parameterValues[i];

            if (parameterValue == null) {
                String parameterName = parameterNames[i];
                String parameterType = parameterTypes[i].getTypeName();
                throw new IllegalArgumentException("Method \"" + signature.getMethod().toGenericString() + "\" with annotation @NotNullArgs has null argument. Param name: " + parameterName + ", param type: " + parameterType);
            }
        }
    }

    pointcut notNullFields(): set(@NotNull * *.*);

    before():notNullFields() {
        FieldSignature fieldSignature = (FieldSignature) thisJoinPoint.getSignature();

        String className = fieldSignature.getDeclaringType().getName();

        Object fieldValue = thisJoinPoint.getArgs()[0];

        if (fieldValue == null) {
            throw new NullPointerException("There was attempt to assign null value to field \"" + fieldSignature.getName() + "\" in \" " + className + "\" , which has @NotNull attribute ");
        }
    }

    pointcut logging(): execution(public * *.*(..)) && within(@PublicsLogger *);

    before(): logging() {
        Logger logger = Logger.getLogger(thisJoinPoint.getThis().getClass().getName());
        logger.setLevel(Level.FINEST);

        if (logger.getHandlers().length == 0) {
            ConsoleHandler handler = new ConsoleHandler();
            handler.setLevel(Level.FINEST);
            logger.addHandler(handler);
        }

        MethodSignature signature = (MethodSignature) thisJoinPoint.getSignature();
        String[] parameterNames = signature.getParameterNames();
        Class[] parameterTypes = signature.getParameterTypes();
        String className = signature.getDeclaringType().getName();

        StringBuilder paramsInfo = new StringBuilder();

        for (int i = 0; i < parameterNames.length; i++) {
            paramsInfo.append(parameterTypes[i].getSimpleName()).append(" ").append(parameterNames[i]);

            if (i < parameterNames.length - 1) {
                paramsInfo.append(", ");
            }
        }

        logger.finest("Calling method " + className + "." + signature.getMethod().getName() + "(" + paramsInfo + ")");
    }

    after() throwing(Exception e): logging() {
        Logger logger = Logger.getLogger(thisJoinPoint.getThis().getClass().getName());
        logger.setLevel(Level.FINEST);

        if (logger.getHandlers().length == 0) {
            ConsoleHandler handler = new ConsoleHandler();
            handler.setLevel(Level.FINEST);
            logger.addHandler(handler);
        }

        MethodSignature signature = (MethodSignature) thisJoinPoint.getSignature();
        String className = signature.getDeclaringType().getName();

        logger.finest("Exception occured in " + className + "." + signature.getMethod().getName() + ": " + e);
    }
}
