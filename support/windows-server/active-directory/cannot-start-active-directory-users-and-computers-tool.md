---
title: You cannot start the Active Directory Users and Computers tool because the server is not operational
description: Provides a solution to an issue where you cannot start the Active Directory Users and Computers tool because the server is not operational.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, RKWON
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# You cannot start the Active Directory Users and Computers tool because the server is not operational

This article provides a solution to an issue where you cannot start the Active Directory Users and Computers tool because the server is not operational.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 323542

## Symptoms

Any of the following symptoms may occur:

- When you try to start the Active Directory Users and Computers tool, you receive the following error message:

    > Naming Information cannot be located because:  
    The Server is not operational.  
    Contact your system administrator to verify that your domain is properly configured and is currently online.

- When you try to start the Active Directory Sites and Services tool, you receive the following error message:

    > Naming Information cannot be located because:  
    The server is not operational.  
    Contact your system administrator to verify that your domain is properly configured and is currently online.

- When you try to start the Active Directory Domains and Trusts tool, you receive the following error message:

    > The configuration information describing this enterprise is not available.  
    The server is not operational.

- Logon processing is very slow.
- If you have multiple domain controllers, you can connect with the Active Directory Users and Computers tool to another domain controller that has port 389 open without receiving an error message. But you cannot access a domain controller until port 389 is opened.

## Cause

These issues may occur if TCP/IP filtering is configured to permit only port 80 for TCP/IP traffic.

## Resolution

Port 389 is used for Lightweight Directory Access Protocol (LDAP) connections. This port is blocked if TCP/IP filtering is configured incorrectly. By default, TCP/IP filtering is configured with the Permit All setting. To verify and correct this setting:

1. Right-click **My Network Places** on the domain controller on which you cannot start Active Directory Users and Computers, and then click **Properties**.
2. Click **Internet Protocol**, and then click **Properties**.
3. Click **Advanced**.
4. Click **Options**.
5. Click **TCP/IP Filtering**, and then click **Properties**.
6. For the TCP/IP Port setting, click **Permit All**.
7. Restart the computer. This opens all TCP ports, including port 389.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.
