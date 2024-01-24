---
title: LDAP and Kerberos Server not respond to UDP requests or reset TCP sessions
description: Fixes an issue where TCP sessions created to the server ports 88, 464, 389 and 3268 are reset. Sessions using Secure Sockets Layer or Transport Layer Security on ports 636 and 3269 are also affected.
ms.date: 09/07/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:domain-controller-scalability-or-performance-including-ldap, csstroubleshoot
ms.subservice: active-directory
---
# LDAP and Kerberos Server may not respond to UDP requests or reset TCP sessions immediately after creation

This article provides a solution to an issue where Transmission Control Protocol (TCP) sessions created to the server ports 88, 464, 389 and 3268 are reset. Sessions using Secure Sockets Layer (SSL) or Transport Layer Security (TLS) on ports 636 and 3269 are also affected.

You may also notice requests on User Datagram Protocol (UDP) ports 88 and 464 don't get a response.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012  
_Original KB number:_ &nbsp; 2000061

You're running the Windows Server roles Active Directory Domain Services (AD DS) or Active Directory Lightweight Directory Services (AD LDS). Sporadically, you experience a situation where TCP sessions created to the server ports 88, 464, 389 and 3268 are reset. Sessions using Secure Sockets Layer (SSL) or Transport Layer Security (TLS) on ports 636 and 3269 are also affected.

In a trace of the network traffic, you can see the frame with the TCP RESET (or RST) is sent by the server almost immediately after the session is established using the TCP three-way handshake. The client might be able to send some request data before the RESET is sent, but this request isn't responded to nor is the data acknowledged.

In the case of UDP, you can see requests on ports 88 and 464 don't get a response.

## Incorrect idle session monitoring

The library that manages the TCP sessions for the LDAP Server and the Kerberos Key Distribution Center (KDC) uses a scavenging thread to monitor sessions that are inactive, and disconnects these sessions if they're idle for too long. The scavenging thread runs every 30 seconds to clean out these sessions.

The KDC registry entry `NewConnectionTimeout` controls the idle time, using a default of 10 seconds. However, based on the implementation of the scavenging, the effective interval is 0-30 seconds. Therefore newly created sessions may be disconnected immediately by the server sporadically.

## Reset NewConnectionTimeout

For the KDC ports, many clients, including the Windows Kerberos client, will perform a retry and then get a full timer tick to work on the session. LDAP applications have a higher chance of considering the connection reset a fatal failure.

When you set `NewConnectionTimeout` to 40 or higher, you receive a time-out window of 30-90 seconds. When you use 70 or higher, you receive 60-120 seconds for the time-out. For more information about the `NewConnectionTimeout` registry value, see [Kerberos protocol registry entries and KDC configuration keys in Windows](../windows-security/kerberos-protocol-registry-kdc-configuration-keys.md).

## KDC might not respond to certain UDP Kerberos authentication requests

You're running the Windows Server role AD DS. The client sends a Kerberos authentication or password change request from source port 22528/UDP or 53249/UDP, but the KDC might not respond.

> [!NOTE]
> The Microsoft Kerberos client uses TCP Kerberos authentication by default since Windows Vista. Therefore, this issue likely occurs only with third-party products that use UDP for Kerberos requests.

The KDC has a built-in protection against request loops and blocks Kerberos authentication requests on source ports 88/UDP and 464/UDP. However, the implementation has a bug in byte ordering, so source ports 22528/UDP and 53249/UDP are blocked.

You have to exclude 22528/UDP and 53249/UDP from the ephemeral port range of UDP on the client.

