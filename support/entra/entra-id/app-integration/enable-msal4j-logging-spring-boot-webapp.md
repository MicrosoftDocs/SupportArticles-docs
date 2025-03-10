---
title: Enable MSAL4J logging in a Spring Boot web application in Microsoft Entra ID
description: Describes how to enable MSAL4J logging in a Spring Boot web application in Microsoft Entra.
ms.date: 03/10/2025
ms.author: bachoang
ms.service: entra-id
ms.custom: sap:Microsoft Entra App Integration and Development
---

# Enable MSAL4J logging in a Spring Boot web application

This article provides step-by-step instructions on how to enable [Microsoft Authentication Library for Java](https://github.com/AzureAD/microsoft-authentication-library-for-java) (MSAL4J) logging by using the [Logback framework](https://logback.qos.ch/) in a Spring Boot web application.

## Code sample

The complete code sample and configuration guide for this implementation is available on [GitHub](https://github.com/bachoang/MSAL4J_SpringBoot_Logging/tree/main/msal-b2c-web-sample). 

The sample uses Azure Active Directory B2C.

## Enable MSAL4J logging

1. Add the following dependency to your pom.xml file to include the Logback framework:

    ```xml
    <dependency>
        <groupid>ch.qos.logback</groupid>
        <artifactid>logback-classic</artifactid>
        <version>1.2.3</version>
    </dependency>
    ```

2. In the **Resource** section of the Visual Studio or other IDE tool, create a new file named **logback.xml** in the **src/main/resources** folder and add the following content:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <configuration>
        <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
            <encoder>
                <pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
            </encoder>
        </appender>
        <root level="debug">
            <appender-ref ref="STDOUT" />
        </root>
    </configuration>

    This configuration (also known as Appender) logs messages to the console. You can adjust the logging level to `error`, `warn`, `info`, or `verbose` based on your preference. For more information, see [LogBack: Appenders](https://logback.qos.ch/manual/appenders.html)
    ```
3. Set the logging.config property to the location of the logback.xml file before the main method:

    ```java
    @SpringBootApplication
    public class MsalB2CWebSampleApplication {
    
    	static { System.setProperty("logging.config", "C:\\Users\\<your path>\\src\\main\\resources\\logback.xml");}
    	public static void main(String[] args) {
    		// Console.log("main");
    		// System.console().printf("hello");
    		// System.out.printf("Hello %s!%n", "World");
    		System.out.printf("%s%n", "Hello World");
    		SpringApplication.run(MsalB2CWebSampleApplication.class, args);
    	}
    }
    ```

## Configuration for running the code sample

### HTTP support

The code sample uses HTTP protocol. Follow [Configure the sample to use your Azure AD B2C tenant](https://github.com/bachoang/MSAL4J_SpringBoot_Logging/tree/main/msal-b2c-web-sample#step-2--configure-the-sample-to-use-your-azure-ad-b2c-tenant) to generate a self-signed certificate and place the **keystore.p12** file in the resources folder.

### App registration

Make sure you have 2 different app registrations in your Azure AD B2C tenant. One for the web app and one for the web API. Expose the scope in the web API (refer to this documentation if you are not familiar with how to expose web API scope) and configure the web API scope in the ‘API Permission’ blade for the web app. You should also grant admin consent to all the configured permission in the web app. You can also follow this tutorial for app registrations covered in this blog. Below is the example:

 :::image type="content" source="media/enable-msal4j-logging-spring-boot-webapp/app-reg.png" alt-text="Diagram that shows configured app registration." border="true" lightbox="media/enable-msal4j-logging-spring-boot-webapp/app-reg.png":::

## Logging output example

When the app is configured correctly, the logging output should resemble the following:


 :::image type="content" source="media/enable-msal4j-logging-spring-boot-webapp/log-sample.png" alt-text="Diagram that shows configured app registration." border="true" lightbox="media/enable-msal4j-logging-spring-boot-webapp/log-sample.png":::

