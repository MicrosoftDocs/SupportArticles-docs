---
title: Troubleshooting SSL related issues (Server Certificate)
description: This article provides various troubleshooting scenarios and resolutions related to SSL server certificates.
ms.topic: troubleshooting 
ms.date: 04/09/2012
ms.reviewer: kaushalp, johnhart, v-jayaramanp
---

# Troubleshooting SSL related issues (Server Certificate)

_Applies to:_ &nbsp; Internet Information Services 6.0, Internet Information Services 7.0 and later versions

## Overview

This article helps you troubleshoot Secure Sockets Layer (SSL) issues related to Internet Information Services (IIS) only. It covers server certificates that are meant for server authentication, and doesn't cover client certificates.

If the Client certificates section is set to "Require" and then you encounter problems, then this isn't the article you should refer. This article is meant for troubleshooting the SSL Server certificates issue only.

It's important to know that every certificate comprises a public key (used for encryption) and a private key (used for decryption). The private key is known only to the server.

The default port for HTTPS is 443. It's assumed that you're well-versed in SSL Handshake and the Server Authentication process during the SSL handshake.

## Tools used in this troubleshooter

The tools used to troubleshoot the various scenarios are:

- SSLDiag
- Network Monitor 3.4 or Wireshark

## Scenarios

You see the following error message while browsing a website over HTTPS:

:::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/ie-cannot-display-web-page.png" alt-text="Screenshot of a browser page showing the message, Internet Explorer cannot display the webpage.":::

The first pre-requisite that has to be checked is whether the website is accessible over HTTP. If it's not, there likely is a separate issue that's not covered in this article. Before using this troubleshooter, you must have the website operational on HTTP.

Now, let's assume the website is accessible over HTTP and the previous error message is shown when you try to browse over HTTPS. The error message is shown because the SSL handshake failed. There could be many reasons which are detailed in the next few scenarios.

## Scenario 1

Check if the server certificate has the private key corresponding to it. See the following screenshot of the Certificate dialog:

:::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/cert-dialog-privatekey-correspond-cert.png" alt-text="Two screenshots of the Certificate dialog. One doesn't have a private key. The other shows a message that the private key corresponds to the certificate.":::

### Resolution

If private key is missing, then you need to get a certificate that contains the private key, which is essentially a .PFX file. Here's a command that you could try to run to associate the private key with the certificate::

```Console
C:\>certutil - repairstore my "[U+200E] 1a 1f 94 8b 21 a2 99 36 77 a8 8e b2 3f 42 8c 7e 47 e3 d1 33"
```

:::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/command-console-certutil-syntax.png" alt-text="Screenshot of the command console showing the certutil syntax.":::

If the association is successful, then you would see the following window:

:::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/certutil-repairstore-successful.png" alt-text="Screenshot of the command console showing a message that the command completed successfully.":::

In this example, `1a 1f 94 8b 21 a2 99 36 77 a8 8e b2 3f 42 8c 7e 47 e3 d1 33` is the thumbprint of the certificate. To get the thumbprint:

 1. Open the certificate.
 1. Select the **Details** tab.
 1. Scroll down to find the thumbprint section.
 1. Select the thumbprint section and click on the text below.
 1. Do a <kbd>Ctrl</kbd>+<kbd>A</kbd> and then <kbd>Ctrl</kbd>+<kbd>C</kbd> to select and copy it.

   :::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/cert-dialog-details-tab-thumbprint.png" alt-text="Screenshot of the Certificate dialog showing the Details tab. The thumbprint value is highlighted.":::

   > [!NOTE]
   > The `certutil` command may not always succeed. If this fails, then you need to get a certificate containing the private key from the certification authority (CA).

## Scenario 2

In this scenario, consider that you have a server certificate that contains the private key installed on the website. However, you continue to see the error shown in [scenario 1](#scenario-1). You still can't access the website over HTTPS.

### Resolution

1. Download and install [SSL Diagnostics](https://www.iis.net/downloads/community/2009/09/ssl-diagnostics-tool-for-iis-7) tool on the server.
1. If you have a certificate that contains the private key and you're still unable to access the website, then try running this tool or check the system event logs for SChannel related warnings or errors.

    While running the SSLDiag tool, you may see the following error message:

    > You have a private key that corresponds to this certificate but CryptAcquireCertificatePrivateKey failed.

    :::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/ssl-diagnostics-failure-message.png" alt-text="Screenshot of the SSL Diagnostics window. The failure message is highlighted.":::

    Additionally, the following SChannel warning will appear in the system event logs:

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

    This event or error indicates that there was a problem acquiring certificate's private key. So, try the following steps to resolve the warning:

  1. First, verify the permissions on the [MachineKeys](../../../../windows-server/windows-security/default-permissions-machinekeys-folders.md) folder. All the private keys are stored within the MachineKeys folder, so make sure you have the necessary permissions.
  1. If the permissions are in place and if the issue is still not fixed, then there might be a problem with the certificate. It might have been corrupted. You may see an error code of 0x8009001a in the following SChannel event log:

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
 1. Try accessing the website using HTTPS. If it works, then the certificate used earlier was corrupted and it has to be replaced with a new working certificate. Sometimes, the problem may not be with the certificate but with the issuer. You may see the following error in SSLDiag:

    :::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/ssl-diagnostics-window-error-message.png" alt-text="Screenshot of the SSL Diagnostics window, the error message is highlighted.":::

    `CertVerifyCertificateChainPolicy` will fail with `CERT_E_UNTRUSTEDROOT (0x800b0109)`, if the root CA certificate isn't trusted root.

 1. To fix this error, add the CA's certificate to the "Trusted Root CA" store under My computer account on the server. You may also get the following error:

    > CertVerifyCertificateChainPolicy returned error -2146762480(0x800b0110).

 1. To resolve the error, check the usage type of the certificate by doing the following steps:

    1. Open the certificate.
    1. Select the **Details** tab.
    1. Select **Edit Properties…**.
    1. Under **General** tab, make sure that the **Enable all purposes for this certificate** option is selected and most importantly, the **Server Authentication** should be present in the list.

    :::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/certificate-properties-enable-all-purposes-selected.png" alt-text="Screenshot shows a portion of the Certificate Properties dialog where the enable all purposes for this certificate is selected.":::

## Scenario 3

The first two scenarios helps check the integrity of the certificate. After you confirm there are no issues with the certificate, a sizeable problem is solved. But, what if the website is still not accessible over HTTPS? Check the HTTPS bindings of the website and determine which port and IP it's listening on.

### Resolution

1. Run the following command to make sure that no other process is listening on the SSL port used by the website.

   ```Console
   netstat -ano" or "netstat -anob
   ```

1. If there's another process listening on that port, then check why that process is using that port.

1. Try changing the IP-Port combination to check if the website is accessible.

## Scenario 4

By now you can be sure that you have a proper working certificate installed on the website and there's no other process using the SSL port for this website. However, you might still see the "Page cannot be displayed" error while accessing the website over HTTPS. When a client connects and initiates an SSL negotiation, *HTTP.sys* searches its SSL configuration for the "IP:Port" pair to which the client is connected. The *HTTP.sys* SSL configuration must include a certificate hash and the name of the certificate store before the SSL negotiation will succeed. The problem may be with the `HTTP.SYS SSL Listener`.

The Certificate hash registered with *HTTP.sys* may be NULL or it may contain invalid GUID.

### Resolution

1. Execute the following command:

   ```Console
   IIS 6: "httpcfg.exe query ssl"
   IIS 7/7.5: "netsh http show ssl"
   ```

     > [!NOTE]
     > [HttpCfg](/windows/win32/http/httpcfg-exe) is part of Windows Support tools and is present on the installation disk.

   Following is a sample of a working and non-working scenario:

   **Working scenario**

      |Configuration |Setting |
      | --- | --- |
      | IP | 0.0.0.0:443 |
      | Hash |  |
      | Guid | **{00000000-0000-0000-0000-000000000000}** |
      | CertStoreName | MY |
      | CertCheckMode | 0 |
      | RevocationFreshnessTime | 0 |
      | UrlRetrievalTimeout | 0 |
      | SslCtlIdentifier | 0 |
      | SslCtlStoreName | 0 |
      | Flags | 0 |

   **Non-working scenario**

      |Configuration|Setting |
      | --- | --- |
      | IP | 0.0.0.0:443 |
      | Hash | c09b416d6b 8d615db22 64079d15638e96823d |
      | Guid | {4dc3e181-e14b-4a21-b022-59fc669b0914} |
      | CertStoreName | MY |
      | CertCheckMode | 0 |
      | RevocationFreshnessTime | 0 |
      | UrlRetrievalTimeout | 0 |
      | SslCtlIdentifier | 0 |
      | SslCtlStoreName | 0 |
      | Flags | 0 |

      The Hash value seen in **Working scenario** is the Thumbprint of your SSL certificate. Notice, that the GUID is all zero in a non-working scenario. You may see the Hash either having some value or blank. Even if you remove the certificate from the website, and then run `httpcfg query ssl`, the website will still list GUID as all 0s. If you see the GUID as "{0000...............000}", then there's a problem.

  1. Remove this entry by running the following command:

       ```Console
       httpcfg delete ssl -i "IP:Port Number"
       ```

       For example:

       ```Console
       httpcfg delete ssl -i 0.0.0.0:443
       ```

   1. To determine whether any IP addresses are listed, open a command prompt, and then run the following commands:

       ```Console
       IIS 6: httpcfg query iplisten
       ```

       ```Console
       IIS 7/7.5: netsh http show iplisten
       ```

      If the IP Listen list is empty, the command returns the following string:

       ```output
       HttpQueryServiceConfiguration completed with 1168.
       ```

      If the command returns a list of IP addresses, remove each IP address in the list by using the following command:

      ```Console
      httpcfg delete iplisten -i x.x.x.x
      ```

      > [!NOTE]
      > Restart IIS after this using the `net stop http /y` command.

## Scenario 5

In spite of all this, if you're still unable to browse the website on HTTPS, capture a network trace either from the client or server. Filter the trace by "SSL or TLS" to look at SSL traffic.

Following is a network trace snapshot of a non-working scenario:

:::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/display-filter-trace-snapshot.png" alt-text="Screenshot of the Display Filter window showing the trace snapshot.":::

Following is a network trace snapshot of a working scenario:

:::image type="content" source="media/troubleshooting-ssl-related-issues-server-certificate/display-filter-window-sucessful-trace.png" alt-text="Screenshot of the Display Filter window showing a snapshot of a successful trace.":::

This is the method of how you look at a network trace. You need to expand the frame details and see what protocol and cipher was chosen by the server. Select "Server Hello" from the description to view those details.

In the non-working scenario, the client was configured to use TLS 1.1 and TLS 1.2 only. However, the web server was IIS 6, which can support until TLS 1.0 and hence the handshake failed.

Check the registry keys to determine what protocols are enabled or disabled. Here's the path:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols`

The "Enabled" DWORD should be set to "1". If it's set to 0, then the protocol is disabled.

For example, SSL 2.0 is disabled by default.

## Scenario 6

If everything has been verified and if you're still running into issues accessing the website over HTTPS, then it most likely is some update, which is causing the SSL handshake to fail.

Microsoft has released an update to the implementation of SSL in Windows:

```output
MS12-006: Vulnerability in SSL/TLS could allow information disclosure: January 10, 2012
```

There is potential for this update to impact customers using Internet Explorer or using an application that uses Internet Explorer to perform HTTPS requests.

There were actually two changes made to address information disclosure vulnerability in SSL 3.0 / TLS 1.0. The MS12-006 update implements a new behavior in *schannel.dll*, which sends an extra record while using a common SSL chained-block cipher, when clients request that behavior. The other change was in *Wininet.dll*, part of the December Cumulative Update for Internet Explorer (MS11-099), so that Internet Explorer will request the new behavior.

If a problem exists, it may manifest as a failure to connect to a server, or an incomplete request. Internet Explorer 9 and higher is able to display an "Internet Explorer cannot display the webpage" error. Prior versions of Internet Explorer may display a blank page.

[Fiddler](https://www.telerik.com/fiddler) doesn't use the extra record when it captures and forwards HTTPS requests to the server. Therefore, if Fiddler is used to capture HTTPS traffic, the requests will succeed.

**Registry keys**

As documented in [MS12-006: Vulnerability in SSL/TLS could allow information disclosure: January 10, 2012](https://support.microsoft.com/kb/2643584), there is a SendExtraRecord registry value, which can:

- Globally disable the new SSL behavior,
- Globally enable it, or
- (By default) enable it for SChannel clients that choose the new behavior.

For Internet Explorer and for clients that consume Internet Explorer components, there is a registry key in the FeatureControl section, FEATURE\_SCH\_SEND\_AUX\_RECORD\_KB\_2618444, which determines whether *iexplore.exe* or any other named application chooses the new behavior. By default, this is enabled for Internet Explorer, and disabled for other applications.

## More information

- [How to set up SSL on IIS](/iis/manage/configuring-security/how-to-set-up-ssl-on-iis)
- [The missing Server Hello in TLS Handshake](https://techcommunity.microsoft.com/t5/iis-support-blog/the-missing-server-hello-in-tls-handshake/ba-p/1574035)
- [Support for SSL/TLS protocols on Windows](/windows/win32/secauthn/protocols-in-tls-ssl--schannel-ssp-)
