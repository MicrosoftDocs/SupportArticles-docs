---
title: Enable MSAL4J Logging in a Spring Boot Web Application in Microsoft Entra ID
description: Discusses how to enable MSAL4J logging in a Spring Boot web application in Microsoft Entra.
ms.date: 03/10/2025
ms.author: bachoang
ms.service: entra-id
ms.custom: sap:Microsoft Entra App Integration and Development
---

# Enable MSAL4J logging in a Spring Boot web application

This article provides step-by-step instructions to enable [Microsoft Authentication Library for Java](https://github.com/AzureAD/microsoft-authentication-library-for-java) (MSAL4J) logging by using the [Logback framework](https://logback.qos.ch/) in a Spring Boot web application.

## Code sample

The complete code sample and configuration guide for this implementation are available on [GitHub](https://github.com/bachoang/MSAL4J_SpringBoot_Logging/tree/main/msal-b2c-web-sample).

## Enable MSAL4J logging

1. Add the following dependency to your Pom.xml file to include the Logback framework:

    ```xml
    <dependency>
        <groupid>ch.qos.logback</groupid>
        <artifactid>logback-classic</artifactid>
        <version>1.2.3</version>
    </dependency>
    ```

2. In your app project, create a file in the **src/main/resources** folder, and name the file **Logback.xml**. Then, add the following content:

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
    ```

    This Appender configuration logs messages to the console. You can adjust the logging level to `error`, `warn`, `info`, or `verbose` based on your preference. For more information, see [LogBack: Appenders](https://logback.qos.ch/manual/appenders.html).
3. Set the **logging.config** property to the location of the **Logback.xml** file before the main method:

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

### Enable HTTPs support

This code sample is set up to run on the local server (localhost) by using the HTTPS protocol. Follow the steps in [Configure the sample to use your Azure AD B2C tenant](https://github.com/bachoang/MSAL4J_SpringBoot_Logging/tree/main/msal-b2c-web-sample#step-2--configure-the-sample-to-use-your-azure-ad-b2c-tenant) to generate a self-signed certificate. Put the **keystore.p12** file in the resources folder.

### App registration configuration

To configure app registration in Azure AD B2C, follow these steps: 

1. Create two app registrations in your Azure AD B2C tenant: One for the web application and the other for the web API.
2. Expose the required scope in the web API. For more information, see [Configure web API app scopes](/azure/active-directory-b2c/configure-authentication-sample-web-app-with-api?tabs=visual-studio#step-22-configure-web-api-app-scopes).
3. Configure the web API scope in the **API Permissions** blade for the web application.
4. Grant admin consent to all configured permissions in the web application.

For more information, see [Configure authentication in a sample web app that calls a web API by using Azure AD B2C](/azure/active-directory-b2c/configure-authentication-sample-web-app-with-api).

Example configuration:

 :::image type="content" source="media/enable-msal4j-logging-spring-boot-webapp/app-reg.png" alt-text="Diagram that shows configured app registration." border="true" lightbox="media/enable-msal4j-logging-spring-boot-webapp/app-reg.png":::

## Logging output example

If the app is configured correctly, the logging output should resemble the following output.

 :::image type="content" source="media/enable-msal4j-logging-spring-boot-webapp/log-sample.png" alt-text="Diagram that shows logging output." border="true" lightbox="media/enable-msal4j-logging-spring-boot-webapp/log-sample.png":::

[!INCLUDE [third-party-disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]


