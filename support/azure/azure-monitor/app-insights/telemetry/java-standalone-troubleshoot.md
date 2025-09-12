---
title: Troubleshoot Azure Monitor Application Insights for Java
description: This article presents troubleshooting information for the Java agent for Azure Monitor Application Insights.
ms.date: 02/20/2025
editor: v-jsitser
ms.reviewer: aaronmax, jeanbisutti, trstalna, toddfous, heya, v-leedennis
ms.service: azure-monitor
ms.devlang: java
ms.custom: sap:Missing or Incorrect data after enabling Application Insights in Azure Portal, devx-track-java
#Customer intent: As an Application Insights for Java user, I want to understand how to troubleshoot common issues so I can use it effectively.
---

# Troubleshoot guide: Azure Monitor Application Insights for Java

This article provides troubleshooting information to resolve common issues that might occur when you're instrumenting a Java application by using the Java agent for Application Insights. Application Insights is a feature of the Azure Monitor platform service.

[!INCLUDE [Azure Help Support](../../../../includes/azure/application-insights-sdk-support.md)]

## Check the self-diagnostic log file

By default, Application Insights Java 3._x_ produces a log file that's named *applicationinsights.log* in the same directory
that holds the *applicationinsights-agent-3.2.11.jar* file.

This log file is the first place to check for hints about any issues that you might be experiencing.

If Application Insights doesn't generate a log file, check to make sure that your Java application has the Write permission to the directory that holds the
*applicationinsights-agent-3.2.11.jar* file.

If Application Insights still doesn't generate a log file, check the `stdout` log from your Java application for errors. Application Insights Java 3._x_
should log any errors that would prevent it from logging to its usual location in the `stdout` log.

## Troubleshoot connectivity issues

Application Insights SDKs and agents send telemetry to be ingested as REST calls at our ingestion endpoints. To test connectivity from your web server or application host computer to the ingestion service endpoints, use raw REST clients from PowerShell or run [curl commands](https://curl.se/). See [Troubleshoot missing application telemetry in Azure Monitor Application Insights](../investigate-missing-telemetry.md).

If the Application Insights Java agent causes the connectivity issue, consider the following options:

- [Verify the connection string for the Application Insights configuration](/azure/azure-monitor/app/java-standalone-config#connection-string).

- Use Application Insights Java version 3.4.6 or a later version to verify that the Java keystore contains a required certificate. To do this, [enable the self-diagnostics feature](/azure/azure-monitor/app/java-standalone-config#self-diagnostics) at the `TRACE` level. In the Application Insights logs, do you see the following entry?

  > TRACE c.m.applicationinsights.agent - Application Insights root certificate in the Java keystore: false

  If you see this entry, refer to [Import SSL certificates](#import-ssl-certificates) to import a root certificate in the Java keystore.

- If you use the `-Djsse.enableSNIExtension=false` option, try to run the agent without that option. From Application Insights Java version 3.4.5, if you specify `-Djsse.enableSNIExtension=false`, the following error entry appears in the logs:

  > WARN  c.m.applicationinsights.agent - System property -Djsse.enableSNIExtension=false is detected. If you have connection issues with Application Insights, please remove this.

- If none of the previous options are helpful, you can use [troubleshooting tools](https://github.com/microsoft/ApplicationInsights-Java/wiki/Diagnose-connection-to-the-Application-Insights-backend-(3.x)#additional-tests).

## Java virtual machine (JVM) fails to start

If the Java virtual machine (JVM) doesn't start, it might return an "Error opening zip file or JAR manifest missing" message. To troubleshoot this problem, see the following table.

| Problem | Action |
|--|--|
| The Java archive (JAR) file for the agent isn't found. | Make sure that you specify a valid agent JAR path in the `-javaagent` JVM argument. |
| The agent JAR file might have been corrupted during file transfer. | Try to download the agent JAR file again. |

## Tomcat Java apps take several minutes to start

If you [enabled Application Insights to monitor your Tomcat application](/azure/azure-monitor/app/java-standalone-arguments#tomcat-8-linux), there might be a several-minute delay in the time that it takes to start the application. This delay is caused because Tomcat tries to scan the Application Insights JAR files during application startup. To speed up the application start time, you can exclude the Application Insights JAR files from the list of scanned files. Scanning these JAR files isn't necessary.

## Upgrade from the Application Insights Java 2._x_ SDK

If you're already using the Application Insights Java 2._x_ SDK in your application, you can keep using it. The Application Insights Java 3._x_ agent detects, captures, and correlates any custom telemetry that you send through the 2._x_ SDK. It also prevents duplicate telemetry by suppressing any auto-collection that the 2._x_ SDK does. For more information, see [Upgrade from the Java 2._x_ SDK](/azure/azure-monitor/app/java-standalone-upgrade-from-2x).

## Upgrade from Application Insights Java 3.0 preview

If you're upgrading from the Java 3.0 Preview agent, review all the [configuration options](/azure/azure-monitor/app/java-standalone-config) carefully. The JSON structure is changed in the 3.0 general availability (GA) release.

These changes include:

- The configuration file name changed from *ApplicationInsights.json* to *applicationinsights.json*.

- The `instrumentationSettings` node is no longer present. All content in `instrumentationSettings` is moved to the root level.

- Configuration nodes such as `sampling`, `jmxMetrics`, `instrumentation`, and `heartbeat` are moved out of `preview` to the root level.

## Some logging isn't auto-collected

Logging is captured only if it meets the following criteria:

- It meets the level that's configured for the logging framework.

- It meets the level that's configured for Application Insights.

For example, if your logging framework is configured to log `WARN` (and above) from the `com.example` package, and Application Insights is configured to capture `INFO` (and above), then Application Insights only captures `WARN` (and above) from the `com.example` package.

To make sure that a particular logging statement meets the logging frameworks' configured threshold, verify that it appears in your usual application log (in the file or console).

Also notice that if an exception object is passed to the logger, the log message (and exception object details)
appears in the Azure portal in the `exceptions` table instead of the `traces` table.
To see the log messages across both the `traces` and `exceptions` tables, run the following Logs (Kusto) query:

```Kusto
union traces, (exceptions | extend message = outerMessage)
| project timestamp, message, itemType
```

For more information, see the [auto-collected logging configuration](/azure/azure-monitor/app/java-standalone-config#auto-collected-logging).

## Import SSL certificates

This section helps you to troubleshoot and possibly fix the exceptions that are related to Secure Sockets Layer (SSL) certificates when you use the Java agent.

There are two different paths for resolving this issue:

- If you're using a default Java keystore
- If you're using a custom Java keystore

If you aren't sure which path to follow, check to see whether you have the JVM argument, `-Djavax.net.ssl.trustStore=...`.
If you don't have this JVM argument, then you're probably using the default Java keystore.
If you do have this JVM argument, then you're probably using a custom keystore, and the JVM argument points you to your custom keystore.

### If you're using the default Java keystore

The default Java keystore typically already has all the CA root certificates. However, there might be some exceptions. For example, a different root certificate might sign the ingestion endpoint certificate. We recommend that you follow these steps to resolve this issue:

1. Check whether the SSL certificate that was used to sign the Application Insights endpoint is already present in the default keystore. By default, the trusted CA certificates are stored in *$JAVA_HOME/jre/lib/security/cacerts*. To list certificates in a Java keystore, use the following command:
    > `keytool -list -v -keystore <path-to-keystore-file>`

    You can redirect the output to a temporary file so that it's easy to search on later:
    > `keytool -list -v -keystore $JAVA_HOME/jre/lib/security/cacerts > temp.txt`

2. After you have the list of certificates, follow the [steps to download the SSL certificate](#steps-to-download-the-ssl-certificate) that was used to sign the Application Insights endpoint.

    After you download the certificate, generate an SHA-1 hash on the certificate by using the following command:
    > `keytool -printcert -v -file "<downloaded-ssl-certificate>.cer"`

    Copy the SHA-1 value, and check whether this value is present in the *temp.txt* file that you saved previously. If you can't find the SHA-1 value in the temporary file, then the downloaded SSL certificate is missing in the default Java keystore.

3. Import the SSL certificate to the default Java keystore by using the following command:
    > `keytool -import -file "<certificate-file>" -alias "<some-meaningful-name>" -keystore "<path-to-cacerts-file>"`

    In this example, the command reads as follows:

    > `keytool -import -file "<downloaded-ssl-certificate-file>" -alias "<some-meaningful-name>" -keystore $JAVA_HOME/jre/lib/security/cacerts`

### If you're using a custom Java keystore

If you're using a custom Java keystore, you might have to import the SSL certificates for the Application Insights endpoints into that keystore.
We recommend the following two steps to resolve this issue:

1. Follow [these steps to download the SSL certificate](#steps-to-download-the-ssl-certificate) from the Application Insights endpoint.

2. Run the following command to import the SSL certificate to the custom Java keystore:
    > `keytool -importcert -alias <your-ssl-certificate> -file "<your-downloaded-ssl-certificate-name>.cer" -keystore "<your-keystore-name>" -storepass "<your-keystore-password>" -noprompt`

### Steps to download the SSL certificate

> [!NOTE]
> The following SSL certificate download instructions were validated on the following browsers:
>
> - Google Chrome
> - Microsoft Edge

1. Open the <https://westeurope-5.in.applicationinsights.azure.com/api/ping> URL address in a web browser.

2. In the browser's address bar, select the **View site information** icon (a lock symbol that's next to the address).

3. Select **Connection is secure**.

4. Select the **Show certificate** icon.

5. In the **Certificate Viewer** dialog box, select the **Details** tab.

6. In the **Certificate Hierarchy** list, select the certificate that you want to download. (The CA root certificate, the intermediate certificate, and the leaf SSL certificate are shown.)

7. Select the **Export** button.

8. In the **Save As** dialog box, browse to the directory to which you want to save the certificate (.crt) file, and then select **Save**.

9. To exit the **Certificate Viewer** dialog box, select the **Close** (X) button.

> [!WARNING]
> You'll have to repeat these steps to get the new certificate before the current certificate expires. You can find the expiration information on the **Details** tab of the **Certificate Viewer** dialog box.
>
> After you select the certificate in the **Certificate Hierarchy** list, find the **Validity** node in the **Certificate Fields** list. Select **Not Before** within that node, and then examine the date and time that's shown in the **Field Value** box. This time stamp indicates when the new certificate becomes valid. Similarly, select **Not After** within the **Validity** node to learn when the new certificate expires.

## Understanding UnknownHostException

If you see this exception after you upgrade to a Java agent version that's later than 3.2.0, you might be able to fix the exception by upgrading your network to resolve the new endpoint that's shown in the exception. The reason for the difference between Application Insights versions is that versions that are later than 3.2.0 point to the new ingestion endpoint `v2.1/track`, as compared to the older `v2/track`. The new ingestion endpoint automatically redirects you to the ingestion endpoint (new endpoint that's shown in exception) that's nearest to the storage for your Application Insights resource.

## Missing cipher suites

If the Application Insights Java agent detects that you don't have any of the cipher suites that are supported by the endpoints that it connects to, the agent alerts you and provides a link to the missing cipher suites.

### Background on cipher suites

Cipher suites come into play before a client application and server exchange information over an SSL or Transport Layer Security (TLS) connection. The client application initiates an SSL handshake. Part of that process involves notifying the server about which cipher suites it supports. The server receives that information, and compares the cipher suites that are supported by the client application with the algorithms it supports. If the server finds a match, it notifies the client application, and a secure connection is established. If it doesn't find a match, the server refuses the connection.

#### How to determine client side cipher suites

In this case, the client is the JVM on which your instrumented application is running. Starting in version 3.2.5, Application Insights Java logs a warning message if missing cipher suites could be causing connection failures to one of the service endpoints.

If you're using an earlier version of Application Insights Java, compile and run the following Java program to get the list of supported cipher suites in your JVM:

```java
import javax.net.ssl.SSLServerSocketFactory;

public class Ciphers {
    public static void main(String[] args) {
        SSLServerSocketFactory ssf = (SSLServerSocketFactory) SSLServerSocketFactory.getDefault();
        String[] defaultCiphers = ssf.getDefaultCipherSuites();
        System.out.println("Default\tCipher");
        for (int i = 0; i < defaultCiphers.length; ++i) {
            System.out.print('*');
            System.out.print('\t');
            System.out.println(defaultCiphers[i]);
        }
    }
}
```

The Application Insights endpoints support the following cipher suites:

- TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 
- TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
- TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
- TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256

#### How to determine server side cipher suites

In this case, the server side is the Application Insights ingestion endpoint or the Application Insights Live metrics endpoint. You can use an online tool such as [SSLLABS](https://www.ssllabs.com/ssltest/analyze.html) to determine the expected cipher suites that are based on the endpoint URL.

#### How to add the missing cipher suites

If you're using Java 9 or a later version, check to make sure that the JVM includes the `jdk.crypto.cryptoki` module in the *jmods* folder. Also, if you're building a custom Java runtime by using `jlink`, make sure that you include the same module.

Otherwise, these cipher suites should already be part of modern Java 8+ distributions. We recommend that you check the source of your installed Java distribution to investigate why the security providers in that Java distribution's *java.security* configuration file differ from standard Java distributions.

## Slow startup time in Application Insights 

### Java 8

Java 8 has a known issue that's related to the JAR file signature verification of Java agents. This issue can increase the startup time in Application Insights. To fix this issue, you can apply one of the following options:

- If your application is based on Spring Boot, [programmatically attach the Application Insights Java agent to the JVM](/azure/azure-monitor/app/java-spring-boot#enabling-programmatically).

- Use Java version 11 or a later version.

### Java higher than version 8

To fix this issue with the Application Insights Java agent, try one of the following methods:

- Use an Azure configuration with more CPU power.
- Disable some instrumentations described in [Suppress specific autocollected telemetry](/azure/azure-monitor/app/java-standalone-config#suppress-specific-autocollected-telemetry).
- Try this experimental feature: [Startup time improvement for a limited number of CPU cores](https://github.com/microsoft/ApplicationInsights-Java/wiki/Start-up-time-improvement-with-a-limited-number-of-CPU-cores-(experimental)). If you experience any issues while using this feature, send us a feedback.

You can also try the [monitoring solutions for Java native](/azure/azure-monitor/app/opentelemetry-enable?tabs=java-native) also applicable to a JVM-based application:

- With Spring Boot, the Microsoft distribution of the OpenTelemetry starter.
- With Quarkus, the Quarkus Opentelemetry Exporter for Microsoft Azure.


## Understand duplicated operation IDs

Application logic can result in an operation ID being reused by multiple telemetry items, as shown in [this example](/azure/azure-monitor/app/distributed-trace-data#example). The duplication might also come from incoming requests. To identify this, do the following operations:

* Enable the capture of the `traceparent` and `request-id` headers in the **applicationinsigths.json** file as follows:

    ```json
      {
        "preview": {
          "captureHttpServerHeaders": {
            "requestHeaders": [
              "traceparent",
              "request-id"
            ]
          }
        }
      }
    ```
* Enable [self-diagnostics](/azure/azure-monitor/app/java-standalone-config#self-diagnostics) at the DEBUG level and restart the application.

    In the following log example, the operation ID comes from an incoming request, not Application Insights:

    ```output
    {"ver":1,"name":"Request",...,"ai.operation.id":"4e757357805f4eb18705abd24326b550)","ai.operation.parentId":"973487efc3db7d03"},"data":{"baseType":"RequestData","baseData":{...,"properties":{"http.request.header.traceparent":"00-4e757357805f4eb18705abd24326b550-973487efc3db7d03-01", ...}}}}
    ```

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
