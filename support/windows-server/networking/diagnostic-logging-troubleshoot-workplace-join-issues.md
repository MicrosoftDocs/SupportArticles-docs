---
title: Diagnostic logging for troubleshooting Workplace Join issues
description: Describes how to troubleshoot Workplace Join issues by collecting and reviewing log information through Event Viewer.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: willfid, aadcontent, rkiran, kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Diagnostic logging for troubleshooting Workplace Join issues

This article describes how to collect diagnostic logs for troubleshooting Workplace Join issues.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3045377

## Enable Workplace Join Debug logging by using Event Viewer

To enable administrative logging in Windows 7 and later versions of Windows, follow these steps:

1. Start Event Viewer.
2. Go to one of the following locations, as appropriate for your operating system:
   - Windows 7: Applications and Services Logs\\Microsoft-WorkPlace Join
   - Windows 8.x: Applications and Service Logs\\Microsoft\Windows\\Workplace Join\\Admin
   - Windows 10: Applications and Service Logs\\Microsoft\\Windows\\Workplace Join\\Admin

3. Right-click the administrative log, and then click either the Enable Log or Disable Log value, as needed.

To enable Debug logging in Windows 7 only, follow these steps:

1. Start Event Viewer.
2. Click **View**, and then click **Show Analytic and Debug Logs**.
3. Browse to the following location in Windows 7:

    Applications and Services Logs\\Microsoft-WorkPlace Join

4. Right-click the Debug log, and then select either the Enable Log or Disable Log  value, as needed.

## Network Capture

Start Network Capture, and then reproduce the issue.

## Enable Capi2 logging

For information about how to enable Capi2 logging, go to the following website:

[Enable CAPI2 event logging to troubleshoot PKI and SSL certificate issues](https://www.thebestcsharpprogrammerintheworld.com/2013/09/09/enable-capi2-event-logging-to-troubleshoot-pki-and-ssl-certificate-issues/)

This enables verbose logging in **Applications and Services Logs/Microsoft/Windows/Capi2** in Event Viewer.

## SSL certificate troubleshooting

To verify the Revocation Status against the certification authority (CA) database, run the following command:

```console
Certutil.exe -isvalid <Serialnumber> 
```

> [!NOTE]
> The \<Serialnumber> placeholder is the serial number of the certificate that you want to verify, in hexadecimal format.

## Verify that a certificate was issued by a specific CA

You can use the Certutil.exe tool to determine whether a certificate was issued by a specific CA. To verify the certificate, you must have the certificate that you want to verify and the CA certificate that you want to verify *against* as parameters. Use the following command syntax:

```console
Certutil.exe -verify CertFile CaCertFile 
```

This command requires that both the CA certificate and the issued certificate be PKCS#10 export files, not PKCS#7 certificate chains. When the command is run, it also verifies the revocation status of the end certificate. An error is returned if the certificate file doesn't contain CDP information, or if the URLs indicated in the CDP extension are unavailable.

> [!NOTE]
> If you don't include the CACertFile parameter, the Certutil tool will construct a certificate chain by using all available certificates that are installed on the computer.

### Validate the validity and Revocation Status of a certificate

You can manually validate all aspects of a certificate's validity, including the AIA and CDP extensions for a specific certificate, by using the following Certutil syntax:

```console
Certutil.exe -verify -urlfetch CertFile.crt 
```

To run this command, you must have an exported version of the certificate in a DER-encoded format. Certutil will verify only the basic certificate location pointer and the CRL(s) for the AIA and CDP locations. The Windows Server 2003 version of Certutil.exe in the Windows Server 2003 administration tools pack supports this functionality.
