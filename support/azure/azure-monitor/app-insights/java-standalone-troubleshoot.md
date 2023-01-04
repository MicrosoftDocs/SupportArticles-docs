---
title: Troubleshoot Azure Monitor Application Insights for Java
description: This article presents troubleshooting information for the Java agent for Azure Monitor Application Insights.
ms.topic: conceptual
ms.date: 6/22/2022
ms.author: v-dele
author: DennisLee-DennisLee
editor: v-jsitser
ms.reviewer: aaronmax
ms.service: azure-monitor
ms.subservice: application-insights
ms.devlang: java
ms.custom: devx-track-java
#Customer intent: As an Application Insights for Java user, I want to understand how to troubleshoot common issues so I can use it effectively.
---

# Troubleshoot guide: Azure Monitor Application Insights for Java

This article provides troubleshooting information to resolve common issues that might occur when you're instrumenting a Java application with the Java agent for Application Insights. Application Insights is a feature of the Azure Monitor platform service.

## Check the self-diagnostic log file

By default, Application Insights Java 3.x produces a log file named *applicationinsights.log* in the same directory
that holds the *applicationinsights-agent-3.2.11.jar* file.

This log file is the first place to check for hints about any issues you might be experiencing.

If there's still no log file generated, check to make sure that your Java application has write permission to the directory that holds the
*applicationinsights-agent-3.2.11.jar* file.

If there's still no log file generated, check the `stdout` log from your Java application for errors. Application Insights Java 3.x
should log any errors that would prevent it from logging to its normal location to the `stdout` log.

## Troubleshoot connectivity issues

Application Insights SDKs and agents send telemetry to get ingested as REST calls to our ingestion endpoints. You can test connectivity from your web server or application host machine to the ingestion service endpoints by using raw REST clients from PowerShell or curl commands. See [Troubleshoot missing application telemetry in Azure Monitor Application Insights](investigate-missing-telemetry.md).

The connectivity issue may also come from the Application Insights Java agent. In this case:
1) [You can verify the Application Insights configuration of the connection string](/azure/azure-monitor/app/java-standalone-config#connection-string).
2) From Application Insights 3.4.6, you can verify that the Java keystore contains a required certificate. To do this, [enable the self-diagnostics feature at the TRACE level](/azure/azure-monitor/app/java-standalone-config#self-diagnostics). In the Application Insights logs, if you notice `TRACE c.m.applicationinsights.agent - Application Insights root certificate in the Java keystore: false`, then you need to import a root certificate
   in the Java keystore by following [these instructions](https://go.microsoft.com/fwlink/?linkid=2151450).
3) If you use `-Djsse.enableSNIExtension=false`, please try without it. From Application Insights 3.4.5, with`-Djsse.enableSNIExtension=false`, the `WARN  c.m.applicationinsights.agent - System property -Djsse.enableSNIExtension=false is detected. If you have connection issues with Application Insights, please remove this.` message appears in the logs.

## Java virtual machine (JVM) fails to start

If the Java virtual machine (JVM) fails to start, it might return an "Error opening zip file or JAR manifest missing" message. That error means that the agent jar file might have been corrupted during file transfer. Try redownloading the agent jar file.

## Upgrade from the Application Insights Java 2.x SDK

If you're already using the Application Insights Java 2.x SDK in your application, you can keep using it. The Application Insights Java 3.x agent will detect, capture, and correlate any custom telemetry you're sending through the 2.x SDK. It will also prevent duplicate telemetry by suppressing any auto-collection performed by the 2.x SDK. For more information, see [Upgrade from the Java 2.x SDK](/azure/azure-monitor/app/java-standalone-upgrade-from-2x).

## Upgrade from Application Insights Java 3.0 preview

If you're upgrading from the Java 3.0 Preview agent, review all of the [configuration options](/azure/azure-monitor/app/java-standalone-config) carefully. The JSON structure has changed in the 3.0 general availability (GA) release.

These changes include:

- The configuration file name has changed from *ApplicationInsights.json* to *applicationinsights.json*.

- The `instrumentationSettings` node is no longer present. All content in `instrumentationSettings` is moved to the root level.

- Configuration nodes like `sampling`, `jmxMetrics`, `instrumentation`, and `heartbeat` are moved out of `preview` to the root level.

## Some logging is not auto-collected

Logging is only captured if it meets the following criteria:

- It meets the level that's configured for the logging framework.

- It also meets the level that's configured for Application Insights.

For example, if your logging framework is configured to log `WARN` (and above) from package `com.example`, and Application Insights is configured to capture `INFO` (and above), then Application Insights will only capture `WARN` (and above) from package `com.example`.

To make sure that a particular logging statement meets the logging frameworks' configured threshold, confirm that it's showing up in your normal application log (in the file or console).

Also note that if an exception object is passed to the logger, then the log message (and exception object details)
will show up in the Azure portal under the `exceptions` table instead of the `traces` table.
To see the log messages across both the `traces` and `exceptions` tables, run the following Logs (Kusto) query:

```Kusto
union traces, (exceptions | extend message = outerMessage)
| project timestamp, message, itemType
```

For more information, see the [auto-collected logging configuration](/azure/azure-monitor/app/java-standalone-config#auto-collected-logging).

## Import SSL certificates

This section helps you to troubleshoot and possibly fix the exceptions related to Secure Sockets Layer (SSL) certificates when using the Java agent.

There are two different paths for resolving this issue:

- If you're using a default Java keystore
- If you're using a custom Java keystore

If you aren't sure which path to follow, check to see if you have the JVM argument `-Djavax.net.ssl.trustStore=...`.
If you *don't* have this JVM argument, then you're probably using the default Java keystore.
If you *do* have this JVM argument, then you're probably using a custom keystore, and the JVM argument will point you to your custom keystore.

### If you're using the default Java keystore

The default Java keystore typically will already have all of the CA root certificates. However, there might be some exceptions. For example, the ingestion endpoint certificate might be signed by a different root certificate. We recommend following these steps to resolve this issue:

1. Check whether the SSL certificate that was used to sign the Application Insights endpoint is already present in the default keystore. The trusted CA certificates, by default, are stored in *$JAVA_HOME/jre/lib/security/cacerts*. To list certificates in a Java keystore, use the following command:
    > `keytool -list -v -keystore <path-to-keystore-file>`

    You can redirect the output to a temporary file, so it'll be easy to search later:
    > `keytool -list -v -keystore $JAVA_HOME/jre/lib/security/cacerts > temp.txt`

2. Once you have the list of certificates, follow the [steps to download the SSL certificate](#steps-to-download-the-ssl-certificate) that was used to sign the Application Insights endpoint.

    After you have downloaded the certificate, generate an SHA-1 hash on the certificate using the following command:
    > `keytool -printcert -v -file "<downloaded-ssl-certificate>.cer"`

    Copy the SHA-1 value and check to see if this value is present in the *temp.txt* file you saved previously.  If you're not able to find the SHA-1 value in the temporary file, then the downloaded SSL certificate is missing in the default Java keystore.

3. Import the SSL certificate to the default Java keystore using the following command:
    > `keytool -import -file "<certificate-file>" -alias "<some-meaningful-name>" -keystore "<path-to-cacerts-file>"`

    In this case it will look like the following text:

    > `keytool -import -file "<downloaded-ssl-certificate-file>" -alias "<some-meaningful-name>" -keystore $JAVA_HOME/jre/lib/security/cacerts`

### If you're using a custom Java keystore

If you're using a custom Java keystore, you may need to import the SSL certificates for the Application Insights endpoints into that keystore.
We recommend the following two steps to resolve this issue:

1. Follow these [steps to download the SSL certificate](#steps-to-download-the-ssl-certificate) from the Application Insights endpoint.

2. Use the following command to import the SSL certificate to the custom Java keystore:
    > `keytool -importcert -alias <your-ssl-certificate> -file "<your-downloaded-ssl-certificate-name>.cer" -keystore "<your-keystore-name>" -storepass "<your-keystore-password>" -noprompt`

### Steps to download the SSL certificate

1. Open your favorite browser and go to the URL from which you want to download the SSL certificate.

2. Select the **View site information** (lock) icon in the browser, and then select the **Certificate** option.

    :::image type="content" source="media/java-standalone-troubleshoot/certificate-icon-capture.png" alt-text="Screenshot of the Certificate option in site information on a web browser tab.":::

3. Select **Certification Path**, select the root certificate, and then select **View Certificate**. This action will pop up a new certificate menu, and you can download the certificate from the new menu.

    :::image type="content" source="media/java-standalone-troubleshoot/root-certificate.png" alt-text="Screenshot of how to select the root certificate in the Certificate dialog box.":::

4. Go to the **Details** tab, and select **Copy to file**.
5. Select **Next**, select the **Base-64 encoded X.509 (.CER)** format, and then select **Next** again.

    :::image type="content" source="media/java-standalone-troubleshoot/certificate-export-wizard.png" alt-text="Screenshot of the Certificate Export Wizard, with the Bse-64 encoded X.509 certificate file format selected.":::

6. Specify the file where you want to save the SSL certificate. Then select **Next** > **Finish**. You should see a message that says "The export was successful."

> [!WARNING]
> You'll need to repeat these steps to get the new certificate before the current certificate expires. You can find the expiration information on the **Details** tab of the **Certificate** dialog box.
>
> :::image type="content" source="media/java-standalone-troubleshoot/certificate-details.png" alt-text="Screenshot that shows SSL certificate details, including time stamps for the Valid from and Valid to fields.":::

## Understanding UnknownHostException

If you see this exception after upgrading to a Java agent version greater than 3.2.0, upgrading your network to resolve the new endpoint shown in the exception might resolve the exception. The reason for the difference between Application Insights versions is that versions greater than 3.2.0 point to the new ingestion endpoint `v2.1/track` compared to the older `v2/track`. The new ingestion endpoint automatically redirects you to the ingestion endpoint (new endpoint shown in exception) nearest to the storage for your Application Insights resource.

## Missing cipher suites

The Application Insights Java agent will alert you and provide a link to the missing cipher suites if it detects that you don't have any of the cipher suites that are supported by the endpoints it connects to.

### Background on cipher suites

Cipher suites come into play before a client application and server exchange information over an SSL or Transport Layer Security (TLS) connection. The client application initiates an SSL handshake. Part of that process involves notifying the server which cipher suites it supports. The server receives that information and compares the cipher suites supported by the client application with the algorithms it supports. If it finds a match, the server notifies the client application and a secure connection is established. If it doesn't find a match, the server refuses the connection.

#### How to determine client side cipher suites

In this case, the client is the JVM on which your instrumented application is running. Starting from version 3.2.5, Application Insights Java will log a warning message if missing cipher suites could be causing connection failures to one of the service endpoints.

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

The following cipher suites are supported by the Application Insights endpoints:

- TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 
- TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
- TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
- TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256

#### How to determine server side cipher suites

In this case, the server side is the Application Insights ingestion endpoint or the Application Insights Live metrics endpoint. You can use an online tool like [SSLLABS](https://www.ssllabs.com/ssltest/analyze.html) to determine the expected cipher suites based on the endpoint URL.

#### How to add the missing cipher suites

If you're using Java 9 or later, check to make sure the JVM has the `jdk.crypto.cryptoki` module included in the *jmods* folder. Also, if you're building a custom Java runtime using `jlink`, be sure to include the same module.

Otherwise, these cipher suites should already be part of modern Java 8+ distributions. We recommend that you check where you installed your Java distribution from, and investigate why the security providers in that Java distribution's *java.security* configuration file differ from standard Java distributions.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
