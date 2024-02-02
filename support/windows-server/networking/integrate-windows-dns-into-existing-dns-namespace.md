---
title: Integrating Windows DNS into an existing DNS namespace
description: Describes how to integrate Windows DNS into an organization that already has a DNS namespace implemented in which the DNS server that is authoritative for the zone with the name of the Active Directory domain doesn't support RFC 2136 (dynamic updates).
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
---
# Integrating Windows DNS into an existing DNS namespace

This article describes how to integrate Windows DNS into an organization that already has a DNS namespace implemented in which the DNS server that is authoritative for the zone with the name of the Active Directory domain doesn't support RFC 2136 (dynamic updates).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 255913

## Summary

One feature of Windows Domain Name System (DNS) is its support for dynamic host updates (documented in RFC 2136). To take advantage of this feature, Windows DNS can be deployed in environments that have no other DNS servers, as well as in environments that already have non-dynamic DNS servers implemented (such as BIND 4.9.7 and earlier, and so on). When you're deploying Windows DNS in an environment that already has BIND servers implemented, you have several integration options:

- Migrate zones from non-dynamic authoritative DNS servers to servers running Windows DNS.
- Delegate child DNS domains under a parent DNS domain. For Active Directory domain names that don't have the same name as the root of a zone, delegate the subdomain to Windows DNS. For example, if the name of the Active Directory domain is `dev.reskit.com` and the zone that contains this name is `reskit.com`, delegate `dev.reskit.com` to a Windows-based server running DNS.
- Delegate each of the subdomains used by the domain controller (DC) locator records (SRV records) to a Windows-based server. These subdomains are `_msdcs.reskit.com`, `_sites.reskit.com`, `_tcp.reskit.com`, and `_udp.reskit.com`. This option would be used where Active Directory domain names (for example, `reskit.com`) that are the same as the name of the root of a zone (for example, `reskit.com`), can't be delegated directly to a Windows-based server running DNS. Optionally, clients may be members of the Active Directory domain called `reskit.com`, but can register in the DNS zone called `dynamic.reskit.com`.  

This article documents the fourth option listed above, how to integrate Windows DNS into an organization that already has a DNS namespace implemented in which the DNS server that is authoritative for the zone with the name of the Active Directory domain doesn't support RFC 2136 (dynamic updates). This article also discusses a scenario in which domain members use a primary DNS suffix different from the name of the Active Directory domain to allow dynamic registration of DNS records by Windows-based computers when the DNS server authoritative for the zone with the name of the Active Directory domain doesn't support dynamic DNS updates.  

## More information

To integrate Windows DNS into an existing namespace based on non-dynamic DNS servers, you can delegate the subdomains used by the locator records (SRV records) so that dynamic updates (as per RFC 2136) may be used. Follow these steps:  

1. On the non-dynamic DNS server that is authoritative for the zone with the name of the Active Directory domain, delegate the following zones to a Windows 2000-based server running DNS:

    _udp. **DNSDomainName**  
    _tcp. **DNSDomainName**  
    _sites. **DNSDomainName**  
    _msdcs. **DNSDomainName**  

    For example, if the root zone is called `reskit.com`, delegate `_udp.reskit.com`, `_tcp.reskit.com`, `_sites.reskit.com`, and `_msdcs.reskit.com` to the Windows-based server.  

    You must delegate also two additional subdomains:

    ForestDnsZones. **ForestDNSName**  
    DomainDnsZones. **DNSDomainName**  

2. On the Windows-based server, create the forward zones delegated in step 1, and enable the zones for dynamic update.

    To create the new zones:

      1. Start DNS Manager on the Windows server.  

      2. Expand the appropriate DNS server within DNS Manager.
      3. Right-click the Forward Lookup Zones folder, and then click New Zone.
      4. When the New Zone Wizard starts, click Next, select "Primary Zone" and maybe select Store the zone in Active Directory check box, and then click Next.
      5. For AD-integrated zones, select where the zone data should go, either to all DNS servers in the domain or forest, or to all DCS in the domain (only option in Windows 2000).
      6. Type the name of the zone in the name box. For example, type _msdcs.reskit.com.
      7. Click Next. After reviewing the wizard's summary, click Finish.

    To enable the zone to accept dynamic updates:

    1. Using DNS Manager on the Windows server running DNS, right-click the new zone, click Properties, and then click the General tab.
    2. In the Allow Dynamic Updates box, click Only Secure Updates (recommended) or Yes. The Only Secure Updates option is only available after the server has been promoted to a domain controller. Repeat this process until all four of the zones described in step 1 have been created and allowed dynamic updates. This allows domain controller locator records to be dynamically registered and de-registered in DNS.

3. Additionally, a single zone or several zones may be created and configured to allow clients and servers to dynamically register themselves with the Windows server. For example, a zone called `dynamic.reskit.com` could be used to register all clients and servers on a network via dynamic updates. To configure such a zone:
      1. On the non-dynamic DNS server that is authoritative for the parent zone (for example, `reskit.com`), delegate a new zone to the Windows-based server running DNS. For example, delegate the `dynamic.reskit.com`. zone to the Windows server.
      2. On the Windows server, create a forward lookup zone for the zone delegated above (`dynamic.reskit.com`).
      3. On the Windows server, enable the zone(s) for dynamic updates.
4. When Windows domain controllers start up, the Netlogon service attempts to register several SRV records in the authoritative zone. Because the zones in which the SRV records are to be registered have been delegated (in steps 1 and 2) to a Windows server where they can be dynamically updated, these registrations will succeed. Additionally, a DC will attempt to register the A record(s) listed in its Netlogon.dns file in the root zone (for example `reskit.com`). In this case, because the root zone is located on a non-dynamic DNS server, these updates won't succeed. The following event will be generated in the system log on the DC:

    > Event Type: Warning  
    Event Source: NETLOGON  
    Event Category: None  
    Event ID: 5773  
    Date: *\<DateTime>*  
    Time: *\<DateTime>*  
    User: N/A  
    Computer: DC  
    Description:  
    The DNS server for this DC does not support dynamic DNS. Add the DNS records from the file %SystemRoot%\System32\Config\netlogon.dns to the DNS server serving the domain referenced in that file.

    To correct this behavior:

    1. Every Windows DC has a Netlogon.dns file located in its %SystemRoot%\System32\Config folder. This file contains a list of DNS records that the DC will attempt to register when the Netlogon service starts. It's a good idea to make a copy of this file before making the following changes so that you'll have a list of the original records that the DC tries to register with the DNS server. Note that each DC will have different records because these records are specific to each network adapter on each DC. Examine the Netlogon.dns file to identify all A records in the file. You can identify A records by the record type following the "IN" class descriptor. For example, the following two entries are A records:

        `reskit.com`. 600 IN A 10.10.10.10  
        `gc._msdcs.reskit.com`. 600 IN A 10.10.10.10  

        The number of A records in the Netlogon.dns file depends on the number of adapters the DC has, the number of IP addresses that each adapter has been configured with, and the role of the DC. DCs register:

       - One A record per each of its IP addresses for the name of the domain.
       - If the DC is also a global catalog (GC) server, it registers gc._msdcs. **DnsForestName** for each of its IP addresses.

    2. Because the non-dynamic DNS server won't accept the domain controller's attempts to dynamically register the A records, the A records have to be manually configured on the authoritative DNS server (in the example in this article, the DNS server authoritative for the zone `reskit.com`). Addition of the A record corresponding to the name of the domain (for example, `reskit.com`) isn't required for the Windows deployment and may be needed only if third-party LDAP clients that don't support SRV DNS records are searching for the Windows DCs.

        On the Windows server, create the GC server-specific A records that were identified in step A, in the appropriate zone. For example, create an A record for the GC server in the _msdcs.reskit.com zone.

        On the non-dynamic DNS server that is authoritative for the root of the zone, create A records in the root zone (for example, `reskit.com`) for the non-GC server-specific A records that were identified in step A. For example, create an A record for `reskit.com` in the `reskit.com` zone.

    3. The following registry key should be used to disable the DC from attempting to register the A records seen in the Netlogon.dns file. Set the REG_DWORD RegisterDnsARecords value to 0 (zero) under:

        `HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`

5. To correct this behavior: Once you have an Active Directory forest and domain in place, you should integrate Active Directory with the DNS domains that the Windows server running DNS is responsible for. Also, you should reconfigure zones that have been configured to accept dynamic updates to accept only secure dynamic updates.  
