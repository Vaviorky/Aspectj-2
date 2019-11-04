package app;

import app.annotations.NotNullArgs;
import org.aspectj.lang.Signature;
import org.aspectj.lang.reflect.MethodSignature;

public aspect Aspect1 {

    pointcut notNullArgs(): call(@NotNullArgs public * *.*(..));

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
                throw new IllegalArgumentException("Method \"" + signature.getMethod().toGenericString() + "\" with annotation @NotNullArgs has null argument. Param name: " + parameterName + ", param type: " + parameterType );
            }
        }
    }
}
