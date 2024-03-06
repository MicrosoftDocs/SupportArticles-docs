---
title: Troubleshoot the Azure Cosmos DB emulator
description: Learn how to troubleshoot problems related to service unavailability, certificate encryption, and versioning when you use the Azure Cosmos DB emulator. 
author: seesharprun
editor: v-jsitser
ms.author: sidandrews
ms.reviewer: ouryba, v-jayaramanp
ms.service: cosmos-db
ms.topic: troubleshooting
ms.date: 01/18/2024
---

# Troubleshoot the Azure Cosmos DB emulator

The Azure Cosmos DB emulator provides an environment that emulates the cloud service for development. Use the tips in this article to help troubleshoot problems that you might experience when you install or use the emulator.

## Troubleshooting checklist

Here's a list of common troubleshooting steps to follow if the Azure Cosmos DB emulator isn't working as expected.

## Reset data

If you installed a new version of the emulator, and you're experiencing errors, make sure that you reset the data. To reset the data, open the Azure Cosmos DB emulator context menu from the system tray, and then select **Reset Data**.

If resetting the data doesn't fix the errors, you can:

- Uninstall the emulator.
- Uninstall older versions of the emulator (if they exist).
- Remove the `%ProgramFiles%\Azure Cosmos DB Emulator` folder.
- Reinstall the emulator.

Alternatively, if resetting the data doesn't work, go to the `%LOCALAPPDATA%\CosmosDBEmulator` location, and then delete the folder.

## Review corrupted Windows performance counters

- If the Azure Cosmos DB emulator stops responding, collect the dump files from the `%LOCALAPPDATA%\CrashDumps` folder, compress the files, and then open a support ticket in [the Azure portal](https://portal.azure.com).

- If `Microsoft.Azure.Cosmos.ComputeServiceStartupEntryPoint.exe` stops responding, this crash could indicate that the performance counters are corrupted. To check the counter status, run the following command:

  ```cmd
  lodctr /R
   ```

## Diagnose connectivity problems

- If you experience a connectivity problem, [collect trace files](#collect-trace-files), compress the files, and then open a support ticket in the [Azure portal](https://portal.azure.com).

- If you receive a "Service Unavailable" message, the emulator might not be initializing the network stack. Check to see whether you have the **Pulse Secure Client** or **Juniper Networks Client** installed because their network filter drivers might be causing the problem. You can also try uninstalling other network filter drivers to fix the problem. Alternatively, start the emulator by using `/DisableRIO` to switch the emulator network communication to regular Winsock.

- If you receive a connectivity error message such as `"Forbidden", "message":"Request is being made with a forbidden encryption in transit protocol or cipher. Check account SSL/TLS minimum allowed protocol setting..."`, this error message might indicate global changes in the OS (for example Insider Preview Build 20170) or changes in the browser settings that enable TLS 1.3 as the default protocol. A similar error message, such as "Microsoft.Azure.Documents.DocumentClientException: Request is being made with a forbidden encryption in transit protocol or cipher. Check account SSL/TLS minimum allowed protocol setting" might be generated if you use the SDK to run a request against the Azure Cosmos DB emulator. This error might also occur because the Azure Cosmos DB emulator supports only the TLS 1.2 protocol. The recommended workaround is to set TLS 1.2 as the default.

  For example:

  1. In **IIS Manager**, go to **Sites** > **Default Web Sites**.
  1. Locate the **Site Bindings** for port **8081**, and edit them to disable TLS 1.3. You can also update the settings for the web browser by using the **Settings** option.

     > [!NOTE]
     > If your computer enters sleep mode or runs any OS updates while the emulator is running, you might see a "Service is currently unavailable" error message.

  1. To reset the emulator data, right-click the icon that appears in the Windows notification tray, and then select **Reset Data**.

## Collect trace files

To collect debugging traces, run the following commands as an administrator in a Command Prompt window:

1. Navigate to the path in which the emulator is installed:

   ```cmd
   cd /d "%ProgramFiles%\Azure Cosmos DB Emulator"
   ```

1. Shut down the emulator, and watch the system tray to make sure that the program is shut down:

   ```cmd
   Microsoft.Azure.Cosmos.Emulator.exe /shutdown
   ```

   > [!NOTE]
   > It might take one minute for the process to finish. You can also select **Exit** in the Azure Cosmos DB emulator user interface.

1. Start logging by running the following command:

   ```cmd
   Microsoft.Azure.Cosmos.Emulator.exe /startwprtraces
   ```

1. Start the emulator:

   ```cmd
   Microsoft.Azure.Cosmos.Emulator.exe
   ```

1. Reproduce the problem. If the data explorer isn't working, you have to wait only a few seconds for the browser to load to be able to detect the error.

1. Stop logging:

   ```cmd
   Microsoft.Azure.Cosmos.Emulator.exe /stopwprtraces
   ```

1. Navigate to the `%ProgramFiles%\Azure Cosmos DB Emulator` path, and locate the *docdbemulator_000001.etl* file.

1. Open a support ticket in the [Azure portal](https://portal.azure.com), and include the .etl file together with any steps that are required to reproduce the problem.

## Install certificates for client applications

Occasionally, you might need to take the exported emulator certificate and use it with a client application. The exact process varies by SDK.

### Export TLS/SLL certificate

Export the emulator certificate to successfully use the emulator endpoint from languages and runtime environments that don't integrate with the Windows Certificate Store. You can export the certificate using Windows Certificate Manager or PowerShell after you run the emulator for the first time.

1. Retrieve the certificate using the friendly name `DocumentDbEmulatorCertificate` and store the certificate in a shell variable named `$cert`.

    ```powershell
    $cert = Get-ChildItem Cert:\LocalMachine\My | where{$_.FriendlyName -eq 'DocumentDbEmulatorCertificate'}
    ```

1. Use [Export-Certificate](/powershell/module/pki/export-certificate) to export the certificate to a temporary file in your home folder.

    ```powershell
    $params = @{
        Cert = $cert
        Type = "CERT"
        FilePath = "$home/tmp-cert.cer"
        NoClobber = $true
    }
    Export-Certificate @params
    ```

    > [!NOTE]
    > In Windows, the home folder is typically `C:\Users\[username]\`, assuming your home drive is `C:`.

1. Use [certutil](/windows-server/administration/windows-commands/certutil) to convert the certificate to a **Base-64 encoded X.509** certificate file.

    ```powershell
    certutil -encode $home/tmp-cert.cer $home/cosmosdbcert.cer
    ```

1. Remove the temporary file.

    ```powershell
    Remove-Item $home/tmp-cert.cer
    ```

### Import certificate for Java applications

When you run Java applications or MongoDB applications that use a Java-based client, installing the certificate into the Java default certificate store is easier than passing the `-Djavax.net.ssl.trustStore=<keystore> -Djavax.net.ssl.trustStorePassword="<password>"` parameters. For example, the included Java Demo application (`https://localhost:8081/_explorer/index.html`) depends on the default certificate store.

Follow the instructions in [Creating, Exporting, and Importing TLS/SSL Certificates](https://docs.oracle.com/cd/E54932_01/doc.705/e54936/cssg_create_ssl_cert.htm) to import the X.509 certificate into the default Java certificate store. Remember that you're working in the *%JAVA_HOME%* directory when running keytool. After the certificate is imported into the certificate store, clients for SQL and Azure Cosmos DB's API for MongoDB can connect to the Azure Cosmos DB emulator.

Alternatively, you can run the following `bash` script to import the certificate:

```bash
#!/bin/bash

# If the emulator was started with /AllowNetworkAccess, replace the following with the actual IP address of it:
EMULATOR_HOST=localhost
EMULATOR_PORT=8081
EMULATOR_CERT_PATH=/tmp/cosmos_emulator.cert
openssl s_client -connect ${EMULATOR_HOST}:${EMULATOR_PORT} </dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > $EMULATOR_CERT_PATH
# Delete the cert if it already exists
sudo $JAVA_HOME/bin/keytool -cacerts -delete -alias cosmos_emulator
# Import the cert
sudo $JAVA_HOME/bin/keytool -cacerts -importcert -alias cosmos_emulator -file $EMULATOR_CERT_PATH
```

Once the `CosmosDBEmulatorCertificate` TLS/SSL certificate is installed, your application should be able to connect to and use the local Azure Cosmos DB emulator.

If you have any issues, see [Debugging SSL/TLS connections](https://docs.oracle.com/javase/7/docs/technotes/guides/security/jsse/ReadDebug.html). In most cases, the certificate might not be installed into the *%JAVA_HOME%/jre/lib/security/cacerts* store. For example, if there's more than one installed version of Java, your application might be using a certificate store different from the one you updated.

### Import certificate for Python applications

When you connect to the emulator from Python applications, TLS verification is disabled. By default, the Python SDK for Azure Cosmos DB for NoSQL doesn't try to use the TLS/SSL certificate when it connects to the local emulator. For more information, see [Azure Cosmos DB for NoSQL client library for Python](/azure/cosmos-db/nosql/quickstart-python).

If you want to use TLS validation, follow the examples in [TLS/SSL wrapper for socket objects](https://docs.python.org/3/library/ssl.html).

### Import certificate for Node.js applications

When you connect to the emulator from Node.js SDKs, TLS verification is disabled. By default, the [Node.js SDK (version 1.10.1 or later)](/azure/cosmos-db/nosql/quickstart-nodejs) for the API for NoSQL doesn't try to use the TLS/SSL certificate when it connects to the local emulator.

If you want to use TLS validation, follow the examples in the [Node.js documentation](https://nodejs.org/api/tls.html#tls_tls_connect_options_callback).

## Rotate certificates

You can force regeneration of the emulator certificates by opening the emulator with the `/ResetDataPath` argument. This action wipes out all the data stored locally by the emulator. For more information about command-line arguments, see [Windows emulator command-line arguments](/azure/cosmos-db/emulator-windows-arguments).

> [!TIP]
> Alternatively, select **Reset Data** from the Azure Cosmos DB emulator's context menu in the Windows system tray.

If you installed the certificates into the Java certificate store or used them elsewhere, you must reimport them using the current certificates. Your application can't connect to the local emulator until you update the certificates.
