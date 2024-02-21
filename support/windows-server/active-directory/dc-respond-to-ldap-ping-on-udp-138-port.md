---
title: Make DCs to reply to LDAP Ping on UDP 138 port
description: Provides the methods to make domain controllers to reply to LDAP Ping.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:ldap-configuration-and-interoperability, csstroubleshoot
---
# How Domain Controllers respond to LDAP Ping on UDP 138 port

This article describes how to make domain controllers to reply to LDAP Ping.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3088277

## Symptoms

Consider the following scenario: 

- LMHOSTS file on Windows Server does not contain client hostname.
- WINS server is not configured on Windows Server, or WINS server does not resolve client hostname.
- Windows Server and client are in another network segment.

In this scenario, Windows Server 2008 or later OS doesn't respond to LDAP Ping (UDP 138 port) from client machine.

## More information

In Windows Server 2003 or older, Windows Server operating systems reply to LDAP Ping on UDP 138 port from client, the behavior however changed since Windows Server 2008.

To make Windows Server 2008 or later to reply to LDAP Ping, configure either of the following settings.

(A) Add LMHOSTS

1. Move to %windir%\system32\drivers\etc folder

2. Add IP address and hostname of client to LMHOSTS file.

(B) Add WINS server

Configure TCP/IP to use WINS server that can resolve client hostname to Windows Server.

[Configure TCP/IP to use WINS](/previous-versions/windows/it-pro/windows-server-2003/cc757386(v=ws.10)) 

(C) Place Windows Servers and client machines in the same segment.

Windows Server resolves client hostname by using NetBIOS broadcast if Windows Server and clients are on the same subnet.

Note: DNS is the primary method of resolving name queries in Active Directory starting with Windows Server 2000 and including Windows Server 2003, Windows Server 2008, Windows Server 2012, Windows Server 2012 R2, Windows Server 2016 and beyond.

## References

For more information on DCLOCATOR, see: 

- [Domain Controller Locator](https://technet.microsoft.com/library/cc961830.aspx) 
- [Domain Controller Location Process](https://technet.microsoft.com/library/cc978011.aspx) 
- [Domain Locator Across a Forest Trust](https://blogs.technet.com/b/askds/archive/2008/09/24/domain-locator-across-a-forest-trust.aspx) 
- [How DNS support for Active Directory works](https://technet.microsoft.com/library/cc759550%28v=ws.10%29.aspx)
