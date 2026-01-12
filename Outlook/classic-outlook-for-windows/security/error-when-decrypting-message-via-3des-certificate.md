---
title: Error when decrypting message via 3DES certificate
description: Discusses a problem that occurs in Outlook when you try to decrypt a message by using a 3DES certificate but the default algorithm encryption is set to AES256. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Data Protection and Security\Digitally-encrypted email messages
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae, gbratton
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Your Digital ID name cannot be found error when decrypting a message by using a 3DES certificate

_Original KB number:_ &nbsp; 4459215

## Symptoms

When you open an encrypted email message in Microsoft Outlook by using a certificate that has only 3DES encryption capabilities, you receive the following error message:

> Your Digital ID name cannot be found by the underlying security system

## Cause

Starting in Outlook build 16.0.8518.1000, Microsoft upgraded the default fallback algorithm from 3DES to AES256. In the problem that is mentioned in the Symptoms section, the encrypted email message would be sent by a user who is using this Outlook build or a later build.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To resolve this problem, we recommend that you encrypt messages by using a certificate that has AES256 encryption capabilities or greater.

If you must use the 3DES encryption algorithm, you can add the following registry values on the sender's computer:

`HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Security`

DWORD = **UseAlternateDefaultEncryptionAlg**  
Value = **1**

String = **DefaultEncryptionAlgOID**  
Value = **1.2.840.113549.3.7**

> [!NOTE]
> The provided string value shows the OID for the 3DES encryption algorithm.

## More information

The certificate that the sender used to encrypt the email message does not contain the `SMIMECapabilities` attribute. This means that Outlook was not able to determine the capabilities of the recipient in advance. Therefore, it chose a commonly accepted secure algorithm.

For more information, see the **2.5.2 SMIME Capabilities Attribute** section of Internet Engineering Task Force (IETF) RFC 5751:
