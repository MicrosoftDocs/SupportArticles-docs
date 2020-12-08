---
title: Authentication failure from non-Windows NTLM or Kerberos servers
description: Fixes an issue in which NTLM and Kerberos servers cannot authenticate Windows 7 and Windows Server 2008 R2-based computers.
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: sabinn
---
# Authentication failure from non-Windows NTLM or Kerberos servers

_Original product version:_ &nbsp; Windows 7 Enterprise, Windows 7 Home Basic, Windows 7 Home Premium, Windows 7 Professional, Windows 7 Starter, Windows 7 Ultimate, Windows Server 2008 R2 Datacenter, Windows Server 2008 R2 Enterprise, Windows Server 2008 R2 Standard, Windows Server 2008 R2 Web Edition  
_Original KB number:_ &nbsp; 976918

## Summary

> [!IMPORTANT]
> This is a rapid publishing article. For more information, refer to the "Disclaimer" section.

This article provides a fix for several authentication failure issues in which NTLM and Kerberos servers cannot authenticate Windows 7 and Windows Server 2008 R2-based computers. This is caused by differences in the way that Channel Binding Tokens are handles. For detailed information, see the "Symptoms," "Cause," and "Resolution" sections of this article.

To download the fix for this issue, click the View and request hotfix downloads link that is located on the upper-left of the screen.

## Symptoms

Windows 7 and Windows Server 2008 R2 support Extended Protection for Integrated Authentication which includes support for Channel Binding Token (CBT) by default.

You may experience one or more of the following symptoms:
1. Windows clients that support channel binding fail to be authenticated by a non-Windows Kerberos server.

2. NTLM authentication failures from Proxy servers.
3. 

NTLM authentication failures from non-Windows NTLM servers.
4. NTLM authentication failures when there is a time difference between the client and DC or workgroup server.


## Cause

Windows 7 and Windows Server 2008 R2 support Extended Protection for Integrated Authentication. This feature enhances the protection and handling of credentials when authenticating network connections using Integrated Windows Authentication (IWA).

This is ON by default. When a client attempts to connect to a server, the authentication request is bound to the Service Principal Name (SPN) used. Also when the authentication takes place inside a Transport Layer Security (TLS) channel, it can be bound to that channel. NTLM and Kerberos provide additional information in their messages to support this functionality.

Also, Windows 7 and Windows 2008 R2 computers disable LMv2.

## Resolution

For failures where non-Windows NTLM or Kerberos servers are failing when receiving CBT, check with the vendor for a version which handles CBT correctly.

For failures where non-Windows NTLM servers or proxy servers require LMv2, check with the vendor for a version which supports NTLMv2.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To control the extended protection behavior, create the following registry subkey: Key Name: HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\LSA

Value Name: SuppressExtendedProtection

Type: DWORD
For Windows clients that support channel binding that are failing to be authenticated by non-Windows Kerberos servers that do not handle the CBT correctly:
1. Set the registry entry value to "0x01." This will configure Kerberos not to emit CBT tokens for unpatched applications.
2. If that does not resolve the problem, then set the registry entry value to "0x03." This will configure Kerberos never to emit CBT tokens.

> [!NOTE]
> There is a known issue with Sun Java which has been addressed to accommodate the option that the acceptor might ignore any channel bindings supplied by the initiator, returning success even if the initiator did pass in channel bindings as per RFC 4121 ([http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=6851973](http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=6851973)).

We recommend that you install the following update from the Sun Java site and re-enable extended protection: [http://java.sun.com/javase/6/webnotes/6u19.html](http://java.sun.com/javase/6/webnotes/6u19.html) 
For Windows clients that support channel binding that are failing to be authenticated by non-Windows NTLM servers that do not handle the CBT correctly:
- Set the registry entry value to "0x01." This will configure NTLM not to emit CBT tokens for unpatched applications.For non-Windows NTLM servers or proxy servers that require LMv2:
- Set to the registry entry value to "0x01." This will configure NTLM to provide LMv2 responses.For the scenario in which the time difference is too great:
1. Fix the client's clock to reflect the time on the domain controller or workgroup server.
2. If that does not resolve the problem, then set the registry entry value to "0x01." This will configure NTLM to provide LMv2 responses that are not subject to time skew.


## More Information

### What is CBT (Channel Binding Token)?

Channel Binding Token (CBT) is a part of Extended Protection for Authentication. CBT is a mechanism to bind an outer TLS secure channel to inner channel authentication such as Kerberos or NTLM.

CBT is a property of the outer secure channel used to bind authentication to the channel.

Extended protection is accomplished by the client communicating the SPN and the CBT to the server in a tamperproof fashion. The server validates the extended protection information in accordance with its policy and rejects authentication attempts for which it does not believe itself to have been the intended target. This way, the two channels become cryptographically bound together.

Extended protection is now supported in Windows XP, Windows Vista, Windows Server 2003 and Windows Server 2008.

For more information about extended protection for authentication in Windows, visit the following Microsoft Web site: [Information about extended protection for authentication in Windows](https://www.microsoft.com/technet/security/advisory/973811.mspx) 

## DISCLAIMER

RAPID PUBLISHING ARTICLES PROVIDE INFORMATION DIRECTLY FROM WITHIN THE MICROSOFT SUPPORT ORGANIZATION. THE INFORMATION CONTAINED HEREIN IS CREATED IN RESPONSE TO EMERGING OR UNIQUE TOPICS, OR IS INTENDED SUPPLEMENT OTHER KNOWLEDGE BASE INFORMATION. 

MICROSOFT AND/OR ITS SUPPLIERS MAKE NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY, RELIABILITY OR ACCURACY OF THE INFORMATION CONTAINED IN THE DOCUMENTS AND RELATED GRAPHICS PUBLISHED ON THIS WEBSITE (THE "MATERIALS") FOR ANY PURPOSE. THE MATERIALS MAY INCLUDE TECHNICAL INACCURACIES OR TYPOGRAPHICAL ERRORS AND MAY BE REVISED AT ANY TIME WITHOUT NOTICE.

TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, MICROSOFT AND/OR ITS SUPPLIERS DISCLAIM AND EXCLUDE ALL REPRESENTATIONS, WARRANTIES, AND CONDITIONS WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING BUT NOT LIMITED TO REPRESENTATIONS, WARRANTIES, OR CONDITIONS OF TITLE, NON INFRINGEMENT, SATISFACTORY CONDITION OR QUALITY, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, WITH RESPECT TO THE MATERIALS.
