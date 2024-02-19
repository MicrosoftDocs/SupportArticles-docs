---
title: Authentication failure from non-Windows NTLM or Kerberos servers
description: Fixes an issue in which NTLM and Kerberos servers can't authenticate Windows 7 and Windows Server 2008 R2-based computers.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, sabinn
ms.custom: sap:kerberos-authentication, csstroubleshoot
---
# Authentication failure from non-Windows NTLM or Kerberos servers

This article provides a solution to several authentication failure issues in which NTLM and Kerberos servers can't authenticate Windows 7 and Windows Server 2008 R2-based computers. This is caused by differences in the way that Channel Binding Tokens are handles.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 976918

## Symptoms

Windows 7 and Windows Server 2008 R2 support Extended Protection for Integrated Authentication that includes support for Channel Binding Token (CBT) by default.

You may experience one or more of the following symptoms:

- Windows clients that support channel binding fail to be authenticated by a non-Windows Kerberos server.
- NTLM authentication failures from Proxy servers.
- NTLM authentication failures from non-Windows NTLM servers.
- NTLM authentication failures when there's a time difference between the client and DC or workgroup server.

## Cause

Windows 7 and Windows Server 2008 R2 support Extended Protection for Integrated Authentication. This feature enhances the protection and handling of credentials when authenticating network connections using Integrated Windows Authentication (IWA).

This is ON by default. When a client attempts to connect to a server, the authentication request is bound to the Service Principal Name (SPN) used. Also when the authentication takes place inside a Transport Layer Security (TLS) channel, it can be bound to that channel. NTLM and Kerberos provide additional information in their messages to support this functionality.

Also, Windows 7 and Windows 2008 R2 computers disable LMv2.

## Resolution

For failures where non-Windows NTLM or Kerberos servers are failing when receiving CBT, check with the vendor for a version that handles CBT correctly.

For failures where non-Windows NTLM servers or proxy servers require LMv2, check with the vendor for a version that supports NTLMv2.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows ](https://support.microsoft.com/help/322756).

To control the extended protection behavior, create the following registry subkey:

- Key name: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\LSA`
- Value name: SuppressExtendedProtection
- Type: DWORD

For Windows clients that support channel binding that are failing to be authenticated by non-Windows Kerberos servers that do not handle the CBT correctly:

1. Set the registry entry value to 0x01. This will configure Kerberos not to emit CBT tokens for unpatched applications.
2. If that does not resolve the problem, then set the registry entry value to 0x03. This will configure Kerberos never to emit CBT tokens.

> [!NOTE]
> There is a known issue with Sun Java which has been addressed to accommodate the option that the acceptor might ignore any channel bindings supplied by the initiator, returning success even if the initiator did pass in channel bindings as per RFC 4121. For more information, see [ignore incoming channel binding if acceptor does not set one](https://bugs.java.com/bugdatabase/view_bug.do?bug_id=6851973).

We recommend that you install the following update from the Sun Java site and re-enable extended protection: [Changes in 1.6.0_19 (6u19)](https://www.oracle.com/java/technologies/javase/6u19.html).

For Windows clients that support channel binding that are failing to be authenticated by non-Windows NTLM servers that do not handle the CBT correctly, set the registry entry value to 0x01. This will configure NTLM not to emit CBT tokens for unpatched applications.

For non-Windows NTLM servers or proxy servers that require LMv2, set to the registry entry value to 0x01. This will configure NTLM to provide LMv2 responses.

For the scenario in which the time difference is too great:

1. Fix the client's clock to reflect the time on the domain controller or workgroup server.
2. If that does not resolve the problem, then set the registry entry value to 0x01. This will configure NTLM to provide LMv2 responses that are not subject to time skew.

## What is CBT (Channel Binding Token)?

Channel Binding Token (CBT) is a part of Extended Protection for Authentication. CBT is a mechanism to bind an outer TLS secure channel to inner channel authentication such as Kerberos or NTLM.

CBT is a property of the outer secure channel used to bind authentication to the channel.

Extended protection is accomplished by the client communicating the SPN and the CBT to the server in a tamperproof fashion. The server validates the extended protection information in accordance with its policy and rejects authentication attempts for which it does not believe itself to have been the intended target. This way, the two channels become cryptographically bound together.

Extended protection is now supported in Windows XP, Windows Vista, Windows Server 2003, and Windows Server 2008.

## Disclaimer

Rapid publishing articles provide information directly from within the Microsoft support organization. The information contained herein is created in response to emerging or unique topics, or is intended supplement other knowledge base information.

Microsoft and/or its suppliers make no representations or warranties about the suitability, reliability or accuracy of the information contained in the documents and related graphics published on this website (the "materials") for any purpose. The materials may include technical inaccuracies or typographical errors and may be revised at any time without notice.

To the maximum extent permitted by applicable law, Microsoft and/or its suppliers disclaim and exclude all representations, warranties, and conditions whether express, implied or statutory, including but not limited to representations, warranties, or conditions of title, non infringement, satisfactory condition or quality, merchantability and fitness for a particular purpose, with respect to the materials.
