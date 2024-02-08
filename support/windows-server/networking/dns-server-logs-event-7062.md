---
title: DNS server logs event 7062
description: Provides a solution to solve the DNS server logs event 7062.
ms.date: 12/21/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
ms.subservice: networking
---
# DNS Server Logs Event 7062: "DNS Server Encountered a Packet Addressed to Itself"

This article provides a solution to solve the DNS server logs event 7062.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 218814

## Symptoms

After you apply Service Pack 4, the DNS server begins logging Event 7062:

DNS Server encountered a packet addresses to itself -- IP address w.x.y.z. The DNS server should never be sending a packet to itself. This situation usually indicates a configuration error.

Check the following areas for possible self-send configuration errors:

1) Forwarders list (DNS server should not forward to themselves).
2) Master lists of secondary zones.
3) Notify lists of primary zones.
4) Delegations of subzones.

Must not contain NS record for DNS server

Example: -> This DNS server `dns1.microsoft.com` is the primary for the zone `microsoft.com`. -> You have delegated the zone `bar.microsoft.com` to `bardns.bar.microsoft.com` and are NOT running the `bar.microsoft.com` zone on this DNS (`dns1.microsoft.com`). Note, you should make this check (with nslookup of DNS manager) both on this DNS server and on the server(s) you delegated the subzone to. It is possible that the delegation was done correctly, but that the primary DNS for the subzone, has any incorrect NS record pointing back at this server. If this incorrect NS record is cached at this server, then the self-send could result. If found, the subzone DNS server admin should remove the offending NS record.

## Cause

This error is caused by a configuration error or is the result of a delegation of a domain (or subdomain) to a server for which there is no zone file.

## Resolution

To resolve this issue, check for the following conditions:

### Forwarders

DNS can be configured to forward off-site queries to designated servers. Be sure that the DNS server is not configured to forward these off-site queries to itself:

1. Select the server, click DNS, and then click Properties from the menu.
2. Click the Forwarders tab.
3. If the server's own IP address is listed, select it and click Remove.
4. After you make this change, make sure to stop and restart the DNS service.

### Master List of Secondary Zones

A secondary zone is configured with a list of the master or primary server(s). Be sure that the server's own IP address is not listed as one of the IP master(s):

1. Select the secondary zone, click DNS, and then click Properties from the menu.
2. Click the General tab.
3. If the server's own IP address is listed in the IP Master(s) section, select it and click Remove.

### Notify Lists

Microsoft Windows NT DNS Server allows the Administrator to specify (on the primary DNS server) any secondary DNS servers that should be notified immediately of changes to the Zone file. Be sure that the DNS server is not configured to notify itself:

1. Select the primary zone, click DNS, and then click Properties from the menu.
2. Click the Notify tab.
3. If the server's own IP address is listed, select it and click Remove.

### Delegation issue

The delegation issue is defined as having a domain or subdomain delegated to a server that is not authoritative for the domain (in other words, a zone file does not exist for the domain on the server). There are two possible causes:

- Delegating a Child Domain to Itself  
  If a child domain is created on a server and an NS record is added to that domain that resolves to its own IP address, an Event 7062 is generated. The following is an example:

  - DNS server `ns1.domain.com` is the primary DNS server for the `domain.com zone`. A child domain is created named `child.domain.com` and an NS record is added to `child.domain.com` for `ns1.domain.com`. This results in a child domain being delegated to itself. To resolve this issue, remove the NS record from `child.domain.com`. Only add NS records to child domains if you wish to delegate it to another server (that is, to delegate it to `ns2.domain.com`).
  - Domain Delegated to Server with No Zone File

- If another DNS server has delegated a domain (either a forward lookup or reverse lookup domain) to a server and there is no zone file on the server for that domain, an Event 7062 is generated. The following are examples:

  - Your Internet Service Provider (ISP) has assigned you the Class C network of 192.168.1.0 and has delegated the 1.168.192.in-addr.arpa domain for reverse lookups to your DNS server. If there is no zone configured on your DNS server for that domain, event 7062 will be generated every time a query is made for that domain from the server. The DNS server will step through the DNS hierarchy starting at the root servers and eventually receive a response from the ISP's DNS server indicating that the server itself is authoritative for the domain and attempt to query itself. To resolve this issue, either create a primary or secondary zone for that domain, or have the ISP change the delegation.
  - Your ISP has delegated a domain to your caching-only DNS server. Because there are no zone files on a caching-only server, any queries that it makes for hosts that reside in domains for which it has been delegated authority will result in an event 7062 error. To resolve this issue, either create a primary or secondary zone file for that domain, or have the ISP change the delegation.

## More information

Due to the informational nature of this warning, the severity type has been reduced from a "Stop" (red) event to a "Warning" (yellow) event in Windows NT 4.0 Service Pack 5.
