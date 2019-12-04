---
title: Office 365 TLS Deprecation Report shows Outlook clients are using TLS 1.0/1.1
description: TLS Deprecation Report shows Outlook clients are using TLS 1.0/1.1 when running Outlook on Windows 10.
author: TobyTu
ms.author: bhava
manager: dcscontentpm
audience: ITPro
ms.topic: article
ms.service: o365-proplus-itpro
localization_priority: Normal
ms.custom:
- CI 110061
- CSSTroubleshoot
ms.reviewer: mhaque, bhava
appliesto:
- Outlook for Office 365
search.appverid:
- MET150
---

# Office 365 TLS Deprecation Report shows Outlook clients are using TLS 1.0/1.1

## Symptoms

Assume that you are running Microsoft Outlook for Office 365 (Monthly channel) on Windows 10, and the default Transport Layer Security (TLS) settings for the operating system are enabled. When you check the TLS Deprecation Report that is downloaded from [Microsoft Service Trust Portal](https://servicetrust.microsoft.com/AdminPage/TlsDeprecationReport/Download), the report shows that the Outlook clients are still connecting over TLS 1.0 and 1.1 randomly.

## Cause

This is an expected behavior because Office 365 still supports TLS 1.0 and 1.1. In the scenario that is described in the “Symptoms” section, Windows 10 supports TLS 1.2 by default, and Outlook for Office 365 can communicate over TLS 1.2. There's no guarantee that the same version of TLS will be chosen for data exchange every time. The choice depends on the protocol negotiation that occurs when Outlook and Exchange Online establish the TLS connection.

## More information

The TLS Handshake Protocol is responsible for the authentication and key exchange that is required to establish or resume secure sessions. When it establishes a secure session, the Handshake Protocol manages the Cipher Suite negotiation. The client and server make contact and determine which is the highest supported version of TLS that is shared between them.

As of June 2020, Office 365 will begin deprecating TLS 1.0 and 1.1 in worldwide environments for commercial customers and in GCC environments for GCC customers. Therefore, this behavior will persist until Office 365 no longer supports TLS 1.0 or 1.1. If you want to enforce TLS 1.2 from the client side, follow these steps to disable TLS 1.0 and 1.1 at the system level:
> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, back up the registry for restoration in case problems occur. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Select **Start**, select **Run**, type **regedit** in the **Open** box, and then select **OK**.
2. Locate the following subkey:
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols`.
3. Select the key that is named **TLS 1.0**. (Create a **TLS 1.0** key if it does not exist).
4. Under **TLS 1.0**, create a key that is named Client.
5. Create a DWORD (32 bit) entry that is named **Enabled**, and then set the value to **0**.
Repeat steps 1 to 5 to disable an existing or new TLS 1.1 key.
