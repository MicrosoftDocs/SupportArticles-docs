---
title: Troubleshooting SSL related issues (Server Certificate)
description: This article provides various troubleshooting scenarios and resolutions related to SSL server certificates.
ms.topic: troubleshooting 
ms.date: 12/03/2024
ms.reviewer: kaushalp, johnhart, v-jayaramanp, zixie
ms.custom: sap:WWW Authentication and Authorization\SSL and SSL Server certificates
---

# Troubleshooting SSL related issues (Server Certificate)

_Applies to:_ &nbsp; Internet Information Services

## Overview

This article helps you troubleshoot Secure Sockets Layer (SSL) issues related to Internet Information Services (IIS) only. It covers server certificates used for server authentication, not client certificates.

If the Client certificates section is set to **Require** and you encounter problems, this article isn't the one you should refer. This article is meant for troubleshooting the SSL Server certificates issue only.

It's important to know that every certificate comprises a public key (used for encryption) and a private key (used for decryption). The private key is known only to the server.

The default port for HTTPS is 443. It's assumed that you're well-versed in SSL Handshake and the Server Authentication process during the SSL handshake.

## Tools used in this troubleshooter

The tools used to troubleshoot the various scenarios are:

- Network Monitor 3.4
- Wireshark

## Scenarios

You see the following error message while browsing a website over HTTPS:

:::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/ie-cannot-display-web-page.png" alt-text="Screenshot of a browser page showing the message, the connection for this site is not secure.":::

The first prerequisite that has to be checked is whether the website is accessible over HTTP. If it's not, there likely is a separate issue that's not covered in this article. Before using this troubleshooter, you must have the website operational on HTTP.

Now, let's assume the website is accessible over HTTP and the previous error message is shown when you try to browse over HTTPS. The error message is shown because the SSL handshake failed. There could be many reasons which are detailed in the next few scenarios.

## Scenario 1

Check if the server certificate has the private key corresponding to it. See the following screenshot of the Certificate dialog:

:::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/cert-dialog-privatekey-correspond-cert.png" alt-text="Two screenshots of the Certificate dialog. One doesn't have a private key. The other shows a message that the private key corresponds to the certificate.":::

### Resolution

If private key is missing, you need to get a certificate that contains the private key, which is essentially a **.PFX** file. Here's a command that you could try to run to associate the private key with the certificate:

```Console
C:\>certutil - repairstore my "906c9825e56a13f1017ea40eca770df4c24cb735"
```

:::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/command-console-certutil-syntax.png" alt-text="Screenshot of the command console showing the certutil syntax.":::

If the association is successful, you would see the following window:

:::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/certutil-repairstore-successful.png" alt-text="Screenshot of the command console showing a message that the command completed successfully.":::

In this example, `906c9825e56a13f1017ea40eca770df4c24cb735` is the thumbprint of the certificate. To get the thumbprint, follow these steps:

 1. Open the certificate.
 1. Select the **Details** tab.
 1. Scroll down to find the thumbprint section.
 1. Select the thumbprint section and select the text under it.
 1. Do a <kbd>Ctrl</kbd>+<kbd>A</kbd> and then <kbd>Ctrl</kbd>+<kbd>C</kbd> to select and copy it.

   :::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/cert-dialog-details-tab-thumbprint.png" alt-text="Screenshot of the Certificate dialog showing the Details tab. The thumbprint value is highlighted.":::

   > [!NOTE]
   > The `certutil` command may not always succeed. If this fails, you need to get a certificate containing the private key from the certification authority (CA).

## Scenario 2

In this scenario, consider that you have a server certificate that contains the private key installed on the website. However, you continue to see the error shown in [scenario 1](#scenario-1). You still can't access the website over HTTPS.

### Resolution

If you have a certificate that contains the private key but you can't access the website, you might also see the following SChannel warning in the system event logs:

```output
Event Type: Error 
Event Source: Schannel 
Event Category: None 
Event ID: 36870 
Date: 2/11/2012 
Time: 12:44:55 AM 
User: N/A 
Computer: 
Description: A fatal error occurred when attempting to access the SSL server credential private key. The error code returned from the cryptographic module is 0x80090016. 
```

This event or error indicates that there was a problem acquiring certificate's private key. To resolve the warning, follow these steps:

1. Verify the permissions on the [MachineKeys](../../../../windows-server/windows-security/default-permissions-machinekeys-folders.md) folder. All the private keys are stored within the **MachineKeys** folder, so make sure you have the necessary permissions.
1. If the permissions are in place and if the issue is still not fixed, there might be a problem with the certificate. It might have been corrupted. You might see an error code of `0x8009001a` in the following SChannel event log:

   ```output
   Event Type: Error 
   Event Source: Schannel 
   Event Category: None 
   Event ID: 36870 
   Date: 2/11/2012 
   Time: 12:44:55 AM 
   User: N/A 
   Computer: 
   A fatal error occurred when attempting to access the SSL server credential private key. The error code returned from the cryptographic module is 0x8009001a. 
   ```

1. Check if the website works with a test certificate.
1. Take a backup of the existing certificate and then replace it with a self-signed certificate.
1. Try accessing the website using HTTPS.

   If it works, the certificate used earlier was corrupted and it has to be replaced with a new working certificate. Sometimes, the problem might not be with the certificate but with the issuer. During the verification of the certificate chain, you might see the error `CERT_E_UNTRUSTEDROOT (0x800b0109)` if the root CA certificate isn't trusted root.

 1. To fix this error, add the CA's certificate to the **Trusted Root CA** store under My computer account on the server. During the verification of the certificate chain, you might also get the error `-2146762480(0x800b0110)`.

 1. To resolve the error, follow these steps to check the usage type of the certificate:

    1. Open the certificate.
    1. Select the **Details** tab.
    1. Select **Edit Properties**.
    1. Under **General** tab, make sure that the **Enable all purposes for this certificate** option is selected and most importantly, the **Server Authentication** should be present in the list.

    :::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/certificate-properties-enable-all-purposes-selected.png" alt-text="Screenshot shows a portion of the Certificate Properties dialog where the enable all purposes for this certificate is selected.":::

## Scenario 3

The first two scenarios help check the integrity of the certificate. After you confirm there are no issues with the certificate, a sizeable problem is solved. But, what if the website is still not accessible over HTTPS? Check the HTTPS bindings of the website and determine which port and IP it's listening on.

### Resolution

1. Run the following command to make sure that no other process is listening on the SSL port used by the website.

   ```Console
   netstat -ano" or "netstat -anob"
   ```

1. If there's another process listening on that port, check why that process is using that port.

1. Try changing the IP-Port combination to check if the website is accessible.

## Scenario 4

By now, you can be sure that you have a proper working certificate installed on the website and there's no other process using the SSL port for this website. However, you might still see the "Page cannot be displayed" error while accessing the website over HTTPS. When a client connects and initiates an SSL negotiation, *HTTP.sys* searches its SSL configuration for the "IP:Port" pair to which the client is connected. The *HTTP.sys* SSL configuration must include a certificate hash and the name of the certificate store before the SSL negotiation will succeed. The problem might be with the `HTTP.SYS SSL Listener`.

The Certificate hash registered with *HTTP.sys* might be NULL or it might contain invalid GUID.

### Resolution

1. Execute the following command:

   ```Console
   netsh http show ssl
   ```

   Here are examples of working and non-working scenarios:

   **Working scenario**

      |Configuration|Setting |
      | --- | --- |
      | IP:port | 0.0.0.0:443 |
      | Certificate Hash | c09b416d6b 8d615db22 64079d15638e96823d |
      | Application ID | {4dc3e181-e14b-4a21-b022-59fc669b0914} |
      | Certificate Store Name | My |
      | Verify Client Certificate Revocation | Enabled |
      | Revocation Freshness Time | 0 |
      | URL Retrieval Timeout | 0 |
      | ...... | ...... |

   **Non-working scenario**

      |Configuration |Setting |
      | --- | --- |
      | IP:port | 0.0.0.0:443 |
      | Certificate Hash |  |
      | Application ID | **{00000000-0000-0000-0000-000000000000}** |
      | CertStoreName | My |
      | Verify Client Certificate Revocation | 0 |
      | Revocation Freshness Time | 0 |
      | URL Retrieval Timeout | 0 |
      | ...... | ...... |

      The Hash value seen in **Working scenario** is the Thumbprint of your SSL certificate. Notice that the GUID is all zero in a non-working scenario. You might see the Hash either has some value or is blank. Even if you remove the certificate from the website, and then run `netsh http show ssl`, the website will still list the GUID as all 0s. If you see the GUID as "{0000...............000}", there's a problem.

  1. Remove this entry by running the following command:

       ```Console
       netsh http delete sslcert ipport=<IP Address>:<Port>
       ```

       For example:

       ```Console
       netsh http delete sslcert ipport=0.0.0.0:443
       ```

   1. To determine whether any IP addresses are listed, open a command prompt, and then run the following command:

       ```Console
       netsh http show iplisten
       ```

      If the command returns a list of IP addresses, remove each IP address in the list by using the following command:

      ```Console
      netsh http delete iplisten ipaddress=<IP Address>
      ```

      > [!NOTE]
      > Restart IIS after this using the `net stop http /y` command.

## Scenario 5

In spite of all this, if you're still unable to browse the website on HTTPS, capture a network trace either from the client or server. Filter the trace by "SSL or TLS" to look at SSL traffic.

Here's a network trace snapshot of a non-working scenario:

:::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/display-filter-trace-snapshot.png" alt-text="Screenshot of the Display Filter window showing the trace snapshot.":::

Here's a network trace snapshot of a working scenario:

:::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/display-filter-window-sucessful-trace.png" alt-text="Screenshot of the Display Filter window showing a snapshot of a successful trace.":::

This is the method of how you look at a network trace. You need to expand the frame details and see what protocol and cipher was chosen by the server. Select "Server Hello" from the description to view those details.

In the non-working scenario, the client was configured to use TLS 1.1 and TLS 1.2 only. However, the IIS web server was configured to support until TLS 1.0, so the handshake failed.

Check the registry keys to determine what protocols are enabled or disabled. Here's the path:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols`

The **Enabled** DWORD should be set to **1**. If it's set to **0**, the protocol is disabled.

For example, SSL 2.0 is disabled by default.

## More information

- [How to set up SSL on IIS](/iis/manage/configuring-security/how-to-set-up-ssl-on-iis)
- [The missing Server Hello in TLS Handshake](https://techcommunity.microsoft.com/t5/iis-support-blog/the-missing-server-hello-in-tls-handshake/ba-p/1574035)
- [Support for SSL/TLS protocols on Windows](/windows/win32/secauthn/protocols-in-tls-ssl--schannel-ssp-)
