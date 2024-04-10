---
title: DNS Server Cache snooping attacks
description: Provides a solution to an issue where DNS Server vulnerability to DNS Server Cache snooping attacks.
ms.date: 01/12/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc, jwesth
ms.custom: sap:Network Connectivity and File Sharing\DNS, csstroubleshoot
---
# DNS Server vulnerability to DNS Server Cache snooping attacks

This article provides a solution to an issue where DNS Server vulnerability to DNS Server Cache snooping attacks.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2678371

## Symptoms

[What is "DNS cache snooping" and how do I prevent it?](https://simpledns.plus/kb/152-what-is-dns-cache-snooping-and-how-do-i-prevent-it) describes DNS cache snooping as:

> DNS cache snooping is when someone queries a DNS server in order to find out (snoop) if the DNS server has a specific DNS record cached, and thereby deduce if the DNS server's owner (or its users) have recently visited a specific site.  
This may reveal information about the DNS server's owner, such as what vendor, bank, service provider, etc. they use. Especially if this is confirmed (snooped) multiple times over a period.  
This method could even be used to gather statistical information - for example at what time does the DNS server's owner typically access his net bank etc. The cached DNS record's remaining TTL value can provide very accurate data for this.
>
> DNS cache snooping is possible even if the DNS server is not configured to resolve recursively for 3rd parties, as long as it provides records from the cache also to third parties.

Security audits may report that various DNS Server implementations are vulnerable to cache snooping attacks that allow a remote attacker to identify which domains and hosts have [recently] been resolved by a given name server.

Once such cache snooping vulnerability report reads:

> DNS Server Cache Snooping Remote Information Disclosure  
Synopsis:  
The remote DNS server is vulnerable to cache snooping attacks.  
Description:  
The remote DNS server responds to queries for third-party domains that do not have the recursion bit set. This may allow a remote attacker to determine which domains have recently been resolved via this name server, and therefore which hosts have been recently visited. For instance, if an attacker was interested in whether your company utilizes the online services of a particular financial institution, they would be able to use this attack to build a statistical model regarding company usage of that financial institution. Of course, the attack can also be used to find B2B partners, web-surfing patterns, external mail servers, and more. Note: If this is an internal DNS server not accessable to outside networks, attacks would be limited to the internal network. This may include employees, consultants and potentially users on a guest network or WiFi connection if supported.  
Risk factor:  
Medium  
CVSS Base Score:5.0  
CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N  
See also:  
`http://www.rootsecure.net/content/downloads/pdf/dns_cache_snooping.pdf`  
Solution:  
Contact the vendor of the DNS software for a fix.

## Cause

This error is typically reported on DNS Severs that do recursion.

## Resolution

There's no code fix as this is a configuration choice.

There are three options:

1. Leave recursion enabled if the DNS Server stays on a corporate network that cannot be reached by untrusted clients

2. Don't allow public access to DNS Servers doing recursion

3. Disable recursion

## More information

By default, Microsoft DNS Servers are configured to allow recursion.

Name recursion can be disabled globally on a Microsoft DNS Server but can't be disabled on a per-client or per-interface basis.

The majority of Microsoft DNS Servers are coinstalled with the Domain Controller server role. Such servers typically host zones and resolve DNS names for devices | appliances, member clients, member servers, and domain controllers in an Active Directory forest but may also resolve names for larger parts of a corporate network.  Since Microsoft DNS Servers are typically deployed behind firewalls on corporate networks, they're not accessible to untrusted clients. Administrators of servers in this setting should consider whether disabling or limiting DNS recursion is necessary.

Disabling recursion globally isn't a configuration change that should be taken lightly as it means that the DNS server can't resolve any DNS names on zones that aren't held locally. This requires some careful DNS planning. For example, clients cannot typically be pointed directly at such servers.

The decision to disable recursion (or not) must be made based on what role the DNS server is meant to do within the deployment. If the server is meant to recurse names for its clients, recursion cannot be disabled. If the server is meant to return data only out of local zones and is never meant to recurse or forward for clients, then recursion may be disabled.

## Related links

- [Disable Recursion on the DNS Server](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771738(v=ws.11))
- [Disable recursion on the DNS server](/previous-versions/windows/it-pro/windows-server-2003/cc787602(v=ws.10))
- [How DNS query works](/previous-versions/windows/it-pro/windows-server-2003/cc775637(v=ws.10))
- [Recursive and Iterative Queries](/previous-versions/windows/it-pro/windows-2000-server/cc961401(v=technet.10))
- [Recursive Name Resolution](/windows-server/identity/ad-ds/plan/reviewing-dns-concepts#recursive-name-resolution)
