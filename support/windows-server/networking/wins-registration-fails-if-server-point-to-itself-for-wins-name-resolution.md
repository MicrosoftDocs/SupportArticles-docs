---
title: WINS registration fails if a Windows Server 2016 server points to itself for WINS name resolution
description: Fixes an issue in which WINS registration fails if a Windows Server 2016 server points to self for name resolution.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, jheath
ms.custom: sap:dns, csstroubleshoot
ms.subservice: networking
---
# WINS registration fails if a Windows Server 2016 server points to itself for WINS name resolution

This article helps fix Windows Internet Name Service (WINS) registration failures that occur when a Windows Server 2016 server points to itself for WINS name resolution.

_Applies to:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4032719

## Symptoms

On a Windows Server 2016 server that has the WINS feature enabled, you set the WINS server configuration in the [advanced TCP/IP settings](/previous-versions/tn-archive/dd163570(v=technet.10)) of that server to use itself as the WINS server. In this scenario, the server does not register the expected NetBIOS records (such as 0x20, 1C, and 1B) for the local WINS server.

However, the remote WINS clients register records all applicable WINS record types for other computers that use the WINS server, and you can see the records in the WINS management console. Therefore, remote WINS clients can successfully register and resolve records on Windows Server 2016 servers that host the WINS feature.

Additionally, the server status in the WINS management console doesn't display the server as operational, any DNS server that is configured to perform WINS lookups will fail if WINS is on the same server as the DNS server, and you can't resolve NetBIOS names by using WINS on the server where the WINS server is installed.

## Cause

These are known issues. The WINS feature is functioning as designed on the server, but the server can't register its own local records or query the local server. However, there are no issues when resolving or registering names when using a remote WINS server.

## Resolution

Host the WINS Feature on a separate Windows 2016 server and create the NetBIOS records for the WINS server as static records in the WINS database.

For example, if you need NetBIOS name resolution for domain information and DC1, DC2, APP1, and APP2 records, set up WINS on separate servers (such as WINS1 and WINS2), and point all other servers and clients to use WINS1/WINS2 in their TPCIP configuration. The WINS servers that are hosting the WINS feature shouldn't point to remote WINS servers for WINS name registration or name resolution, to avoid split-name registration problems as described in [Best Practices for WINS Servers](/previous-versions/windows/it-pro/windows-2000-server/cc959209(v=technet.10)). (WINS1 should point to WINS1 as the primary, and WINS2 should point to WINS2 as the primary.)

If you must have the records for the server that is hosting WINS present in the database (such as WINS1[00] or WINS2[20]), they can be statically added from the WINS management console on each server.

> [!NOTE]
> The process of adding static records should be done on each WINS server for their own records by using the WINS management console. Custom names and NetBIOS servers can be added by using the `Netsh WINS Server` command that's described in [Netsh commands for WINS](/previous-versions/windows/it-pro/windows-xp/bb490946(v=technet.10)).

## Workaround

You can consider a non-WINS dependent solution to use [Domain Name System (DNS)](/windows-server/networking/dns/dns-top) instead. [WINS](/windows-server/networking/technologies/wins/wins-top) is a computer name registration and resolution service that maps computer NetBIOS names to IP addresses. If you don't have a WINS server deployed in the network, you can deploy a DNS server instead of a WINS server. A DNS server also provides computer name registration and resolution services, and it includes many additional benefits over a WINS server, such as integration with Active Directory Domain Services.

> [!NOTE]
> If you have already deployed WINS in the network, we recommend that you deploy DNS and then decommission WINS.
