---
title: Events 407 and 408 are reported in the DNS server event log
description: Provides a solution to an issue where you are unable to query a Windows 2000-based DNS server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
---
# Events 407 and 408 are reported in the DNS server event log

This article provides a solution to an issue where you are unable to query a Windows 2000-based DNS server.

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 279678

## Symptoms

You are unable to query a Windows 2000-based DNS server, and the following errors are reported in the application event log for the DNS server:

> Event ID: 407  
Source: DNS  
Description: DNS server could not bind a datagram (UDP) socket to **IP_address**. The data is the error.

> Event ID: 408  
Source: DNS  
Description: DNS Server could not open socket for address [IP_address]. Verify that this is a valid IP address on this machine. If it is NOT valid use the Interfaces dialog under Server Properties in the DNS Manager to remove it from the list of IP interfaces. Then stop and restart the DNS server. (If this was the only IP interface on this machine and the DNS server may not have started as a result of this error. In that case remove the DNS\\Parmeters\\ListenAddress value in the services section of the registry and restart.) If this is a valid IP address for this machine, make sure that no other application (e.g. another DNS server) is running that would attempt to use the DNS port.

## Cause

These errors can occur on computers that have both of the following services installed on the same server:

- Network Address Translation (NAT)
- DNS ServerNAT has a DNS proxy setting that enables Dynamic Host Configuration Protocol (DHCP) clients to direct DNS queries to the NAT server. The client DNS queries are then forwarded to the NAT server's configured DNS server. DNS proxy and the DNS Server service cannot coexist on the same host if the host is using the same interface and Internet protocol (IP) address with the default settings.

## Resolution

To resolve this issue, use any of the following methods:

- Use a different server for DNS Server, instead of installing NAT and DNS Server on the same host.
- Do not use the DHCP allocator and DNS proxy functionality in NAT (use the DHCP Server service instead).
- Configure DNS Server so that it does not listen on the IP address of the network adaptor that is functioning as the private interface for NAT. To do this, follow these steps:

    1. Start the DNS snap-in in the Microsoft Management Console (MMC), right-click the DNS server, and then click **Properties**.
    2. Click the **Interfaces** tab, and then in the **Listen on** section, click to select the **Only the following IP addresses** check box.
    3. Click the IP address that you do not want the server to listen on, and then click **Remove**.
    4. Click **OK** and close the DNS snap-in.

> [!NOTE]
> When an IP address is removed from the Interfaces list on the DNS server, the DNS Server service does not respond to DNS queries that are directed to that IP address. DNS queries that need to be resolved by DNS Server must be directed to other interfaces that DNS Server is listening on.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.
