package app;

import app.annotations.NotNull;
import app.annotations.NotNullArgs;
import org.aspectj.lang.Signature;
import org.aspectj.lang.reflect.FieldSignature;
import org.aspectj.lang.reflect.MethodSignature;

import java.lang.reflect.Field;

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
}
