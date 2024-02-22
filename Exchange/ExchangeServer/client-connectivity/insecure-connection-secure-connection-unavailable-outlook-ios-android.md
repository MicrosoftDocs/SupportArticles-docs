---
title: Insecure connection error in Outlook for iOS and Android at Exchange logon
description: You receive an Insecure connection or Secure connection unavailable error message when you use Outlook for iOS or Android to sign in Exchange Server. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: mhaque, daweiler, v-six
appliesto: 
  - Outlook for iOS
  - Outlook for Android
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when Outlook for iOS or Android connects to Exchange Server: Insecure connection or Secure connection unavailable

_Original KB number:_ &nbsp;4056392

## Symptoms

When you use Microsoft Outlook for iOS or Outlook for Android to sign in to an instance of Exchange Server that uses an SSL certificate for secure connections, you receive one of the following error messages:

> Insecure connection. Would you like to log in anyway?

> Secure connection unavailable. Would you like to log in anyway?

## Cause

This issue occurs because the SSL certificate is considered unsupported for one of the following reasons:

- The SSL certificate is invalid or expired.
- The SSL certificate is untrusted.

> [!NOTE]
> Outlook for iOS and Outlook for Android use the standard Java trusted certificate authorities (CAs). If your organization's certificate isn't signed by a certificate authority that's part of the standard Java trusted certificate authorities, this error occurs.

## Resolution

You can safely ignore this error message and sign in to Exchange Server. This error message should be displayed only one time.

We recommend that you use an SSL certificate that's officially supported by the Java CA certificate store.

## How to verify that a certificate is trusted by the Java CAs

1. Get the CA of the certificate.
1. Download the latest [Java SE Development Kit](https://www.azul.com/downloads/azure-only/zulu) (JDK). This kit includes the Java trusted CAs.
1. Open a Command Prompt window on a Windows-based computer or open a Terminal window on a macOS-based computer.
1. Use the keytool utility to list the trusted CAs by running the following command:

    ```powershell
     keytool -keystore "<keystore location>" -storepass changeit -list -v
    ```

    > [!NOTE]
    > On a macOS-based computer, the \<keystore location> parameter could be "$JAVA_HOME/jre/lib/security/cacerts."
1. Verify that the CA of the certificate is in the list.

For more information about the keytool utility, see the following articles:

- [Keytool - Key and Certificate Management Tool](https://docs.oracle.com/javase/7/docs/technotes/tools/windows/keytool.html)
- [Working with Certificates and SSL](https://docs.oracle.com/cd/E19830-01/819-4712/ablqw/index.html)
