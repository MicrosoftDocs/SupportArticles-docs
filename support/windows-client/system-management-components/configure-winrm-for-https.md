---
title: How to configure WINRM for HTTPS
description: This article describes how to configure WINRM to listen to HTTPS by loading a certificate and running commands.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, austinm
ms.custom: sap:winrm, csstroubleshoot
ms.subservice: system-mgmgt-components
---
# How to configure WINRM for HTTPS

This article provides a solution to configuring WINRM for HTTPS.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2019527

## Summary

By default WinRM uses Kerberos for authentication so Windows never sends the password to the system requesting validation. To get a list of your authentication settings, type the following command:

```console
winrm get winrm/config
```

The purpose of configuring WinRM for HTTPS is to encrypt the data being sent across the wire.

WinRM HTTPS requires a local computer Server Authentication certificate with a CN matching the hostname to be installed. The certificate mustn't be expired, revoked, or self-signed.

To install or view certificates for the local computer:

1. Select **Start** and then select **Run** (or using keyboard combination press Windows key+R)。
2. Type *MMC* and then press Enter.
3. Select **File** from menu options and then select **Add or Remove Snap-ins**.
4. Select **Certificates** and select **Add**.
5. Go through the wizard selecting **Computer account**.
6. Install or view the certificates under **Certificates (Local computer)** > **Personal** > **Certificates**.

If you don't have a Server Authenticating certificate, consult your certificate administrator. If you have a microsoft Certificate server, you may be able to request a certificate using the web certificate template from `HTTPS://<MyDomainCertificateServer>/certsrv`.

Once the certificate is installed type the following to configure WINRM to listen on HTTPS:

```console
winrm quickconfig -transport:https
```

If you don't have an appropriate certificate, you can run the following command with the authentication methods configured for WinRM. However, the data won't be encrypted.

```console
winrm quickconfig
```

## More information

By default, on Windows 7 and later versions, WinRM HTTP uses port 5985 and WinRM HTTPS uses port 5986. On earlier versions of Windows, WinRM HTTP uses port 80 and WinRM HTTPS uses port 443.

To confirm WinRM is listening on HTTPS, type the following command:

```console
winrm enumerate winrm/config/listener
```

To confirm a computer certificate has been installed, use the Certificates MMC add-in or type the following command:

```console
Winrm get http://schemas.microsoft.com/wbem/wsman/1/config
```

If you get the following error message:  

> Error number: -2144108267 0x80338115  
ProviderFault  
WSManFault  
Message = Cannot create a WinRM listener on HTTPS because this machine does not have an appropriate certificate.

To be used for SSL, a certificate must have a CN matching the hostname, be appropriate for Server Authentication, and not be expired, revoked, or self-signed.

Open the certificates MMC add-in and confirm the following attributes are correct:

- The date of the computer falls between the **Valid from:** to the **To:** date on the **General** tab.
- Host name matches the **Issued to:** on the **General** tab, or it matches one of the **Subject Alternative Name** exactly as displayed on the **Details** tab.
- That the **Enhanced Key Usage** on the **Details** tab contains **Server authentication**.
- On the **Certification Path** tab that the **Current Status** is **This certificate is OK**.

If you have more than one local computer account server certificate installed, confirm the Certificate Thumbprint displayed by `Winrm enumerate winrm/config/listener` is the same Thumbprint on the **Details** tab of the certificate.
