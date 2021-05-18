---
title: LDAP and Kerberos Server reset TCP sessions
description: Fixes an issue where TCP sessions created to the server ports 88, 389 and 3268 are reset. Sessions using Secure Sockets Layer or Transport Layer Security on ports 636 and 3269 are also affected.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Domain controller scalability or performance (including LDAP)
ms.technology: windows-server-active-directory
---
# LDAP and Kerberos Server may reset TCP sessions immediately after creation

This article provides a solution to an issue where TCP sessions created to the server ports 88, 389 and 3268 are reset. Sessions using Secure Sockets Layer (SSL) or Transport Layer Security (TLS) on ports 636 and 3269 are also affected.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2000061

## Symptoms

You're running the Windows Server roles Active Directory Domain Services (AD DS) or Active Directory Lightweight Directory Services (AD LDS). Sporadically, you experience that TCP sessions created to the server ports 88, 389 and 3268 are reset. Sessions using Secure Sockets Layer (SSL) or Transport Layer Security (TLS) on ports 636 and 3269 are also affected.

In a trace of the network traffic, you see the frame with the TCP RESET (or RST) is sent by the server almost immediately after the session is established using the TCP three-way handshake. The client might be able to send some request data before the RESET is sent, but this request isn't responded to nor is the data acknowledged.

## Cause

There are two problems that might occur:

1. Incorrect idle session monitoring:

    The library that manages the TCP sessions for the LDAP Server and the Kerberos Key Distribution Center (KDC) uses a scavenging thread to monitor for sessions that are inactive, and disconnects these sessions if they're idle too long. The scavenging thread runs every 30 seconds to clean out these sessions.

    The KDC registry entry NewConnectionTimeout controls the idle time, using a default of 10 seconds. However, based on the implementation of the scavenging, the effective interval is 0-30 seconds. Therefore newly created sessions may be disconnected immediately by the server sporadically.

2. Incorrect client port protection:

    The KDC also has a built-in protection against request loops, and blocks client ports 88 and 464. However, the implementation has a bug in the byte ordering, so ports 22528 and 53249 are effectively blocked. Depending on the operating system version of the client and the allowed ephemeral TCP ports, you may or may not encounter this issue.

## Resolution

For the KDC ports, many clients, including the Windows Kerberos client, will perform a retry and then get a full timer tick to work on the session. LDAP applications have a higher chance of considering the connection reset a fatal failure.

If you want to avoid the resets on ports 22528 and 53249, you have to exclude them from the ephemeral ports range. For more information, see [The default dynamic port range for TCP/IP has changed in Windows Vista and in Windows Server 2008](https://support.microsoft.com/help/929851), which also applies to Windows Vista and later versions.

When you set **NewConnectionTimeout** to 40 or higher, you receive a time-out window of 30-90 seconds. When you use 70 or higher, you receive 60-120 seconds for the time-out. For more information about the **NewConnectionTimeout** registry value, see [Kerberos protocol registry entries and KDC configuration keys in Windows](/troubleshoot/windows-server/windows-security/kerberos-protocol-registry-kdc-configuration-keys).
