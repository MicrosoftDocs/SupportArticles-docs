---
title: OS compatibility with DNSSEC enabled root servers
description: DNSSEC was recently enabled on root servers on the Internet between January and May 2010. Several blogs and press articles have reported potential DNS outages because of DNSSEC being recently enabled on root hint DNS servers on the internet. This document describes the impact and compatibility story for Windows client and server operating systems as well computers hosting the Microsoft DNS Server role.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, BBenson
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Windows client and server operating system compatibility with DNSSEC enabled root servers

This article describes the impact and compatibility story with DNSSEC enabled root servers for Windows client and server operating systems as well computers hosting the DNS Server role.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2028240

## Summary

ICANN and VeriSign have configured DNS Servers hosting the root zone to use DNSSEC.

This article summarizes the impact of enabling DNSSEC on root zone DNS Servers to Windows Clients and Servers.

|OS Version and Role|Impact|
|---|---|
|<br/>Windows 2000 Professional<br/>Windows 2000 Server<br/>Windows XP<br/>Windows Server 2003<br/>Windows Server 2003 R2<br/>Windows Vista<br/>Windows Server 2008<br/><br/>|No configuration change is required.<br/><br/>DNSSEC is a DNS Server technology. Windows DNS Clients are not impacted by DNSSEC.<br/><br/>DNSSEC is only enabled by DNS Servers that request DNSSEC. These Microsoft DNS Server versions aren't DNSSEC aware and should not be impacted by the enabling of DNSSEC on DNS Root Zones.|
|Windows 7 and Windows Server 2008 R2 with DNSSEC disabled<br/>|<br/>No configuration change is required.<br/><br/>DNSSEC is a DNS Server technology. Windows DNS Clients are not impacted by DNSSEC<br/><br/>DNSSEC is only enabled by DNS Servers that request DNSSEC. DNSSEC isn't enabled Windows Server 2008 R2 DNS Servers by default. Such DNS Servers should not be impacted by the enabling of DNSSEC on DNS Root Zones.<br/><br/>|
|<br/>Windows Server 2008 R2 DNS Servers with DNSSEC enabled<br/><br/>|<br/>No additional configuration change is required by the enabling of DNSSEC on root zone DNS Servers.<br/><br/>DNSSEC-enabled Windows Server 2008 R2 DNS Servers have been tested and verified by Microsoft to interoperate with DNSSEC enabled root zone servers on the internet.<br/><br/>If you wish to deploy DNSSEC, see the Microsoft [DNSSEC Deployment Guide](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn593684(v=ws.11)) for requirements to deploy DNSSEC including large UDP packet support needed by UDP-formatted EDNS frames used by DNSSEC.<br/><br/>|
  
## More information

Several blog posts and press articles have suggested that the enabling of DNSSEC on DNS Servers hosting the Root Zone would cause DNS queries for internet names to fail.

Such articles and the deployment of DNSSEC itself have led Microsoft customers to inquire whether the DNSSEC transition on Root Zones would affect the ability of Windows clients and servers, including those hosting the Microsoft DNS Server role, to experience name resolution issues.

Impact on Microsoft Windows Clients  

Windows DNS clients don't require additional configuration as a result of DNSSEC being enabled on root zone DNS Servers.

Impact on Microsoft DNS Servers  

Per [this website](http://www.root-dnssec.org/2010/05/05/status-update/) DNSSEC was originally enabled on 2010.01.27 and has been systematically enabled on additional root zone servers during the months of February, March, and April 2010. At the point when twelve of the thirteen root servers had been transitioned to the DURZ, no harmful effected had been identified. Had the enabling of DNSSEC on root zone DNS Servers caused a problem, it would have been observed long before the enabling of DNSSEC on the last of 13 root zones on May 5, 2010. As of 2010.05.07, no verifiable problems have been identified the enabling of DNSSEC on root zones.

More importantly, such claims fail to consider that DNSSEC is only enabled by callers (DNS Servers) that request DNSSEC. Enabling DNSSEC on a target server, such as those hosting root zones, does not change anything in the DNS response to callers that do not request DNSSEC. This change paves the way for more EDNS use in the future, specifically for DNSSEC. Servers and clients who send DNS requests to the root servers do not have to make any changes.

Pre-Windows Server 2008 R2 DNS Servers are incapable of requesting DNSSEC functionality and require no configuration change to interoperate with DNSSEC-enabled DNS Servers hosting the Root or any other DNSSEC enabled DNS zone.

Windows Server 2008 R2 DNS Servers are DNSSEC capable but the feature is turned off by default. Such DNS Servers require no additional configuration change to interoperate with DNSSEC enabled servers and should experience no failures due to the enabling of DNSSEC on root zone servers.

Windows Server2008 R2 DNS Servers configured to use DNSSEC have been tested by Microsoft development and test teams and found to be fully interoperable with DNSSEC-enabled Root Zone servers. Administrators should be aware that the enabling of DNSSEC on Microsoft and third-party products implicitly enables the use of [EDNS](https://wikipedia.org/wiki/Alternative_DNS_root#eDNS), a DNS extension that may generate large (greater than 512 byte) UDP-formatted frames to communicate data over the network.

There are known issues with network infrastructure devices such as routers and firewalls dropping, fragmenting, or changing the arrival order of greater than 512-byte UDP formatted network packets generated by Kerberos or EDNS. Each case can cause DNS queries to fail. Ensure that your network infrastructure is capable of passing large UDP formatted network packets.

Per RFC 4035, UDP packet sizes up to 1220 bytes MUST be supported and packets up to 4000 bytes _SHOULD_ be supported. Windows Server 2008 R2 uses a default packet size of 4000 bytes by default.

[OARC's DNS Reply Size Test Server](https://www.dns-oarc.net/oarc/services/replysizetest) documents the use of a reply size test using DIG. This functionality can be replicated using the NSLOOKUP syntax:

`>nslookup [-d2] -type=txt rs.dns-oarc.net. \<your DNS Server IP> <- where "[-d2]" is an optional verbose logging parameter`

In summary, there's no real need for EDNS if you're not using DNSSEC. Microsoft suggests that you leave EDNS disabled. However if administrators want to enable it, they should do so on a few machines first and test it out to make sure all Internet names are resolvable.

Related Links

- [Information about DNSSEC for the Root Zone](https://www.root-dnssec.org/2010/05/05/status-update/)
- [DNSSSEC unlikely to break Internet on May 5](https://www.theregister.co.uk/2010/04/13/dnssec/) (author: Bill Detwiler, TechRepublic)
- [Warning: Why your Internet might fail on May 5th](https://www.itnews.com.au/news/173412,warning-why-your-internet-might-fail-on-may-5.aspx) (author: Brett Winterford, ITNews for Australian Business)
- [Will DNSSEC kill your internet?](https://www.theregister.co.uk/2010/04/13/dnssec/) (author: Kevin Murphy, The Registry)
- [OARC's DNS Reply Size Test Server](https://www.dns-oarc.net/oarc/services/replysizetest)
- [The story of the Mysteriously Malfunctioning Mail Router (Aka EDNS and Exchange escapades)](/archive/blogs/instan/the-story-of-the-mysteriously-malfunctioning-mail-router-aka-edns-and-exchange-escapedes)
- [Microsoft DNSSEC Deployment Guide](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn593684(v=ws.11))
