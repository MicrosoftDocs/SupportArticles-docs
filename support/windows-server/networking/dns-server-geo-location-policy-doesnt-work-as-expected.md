---
title: DNS server geo-location policy doesn't work as expected
description: Describes an issue where DNS resolution policy doesn't produce the results that might be expected.
ms.date: 1/26/2023
author: v-tappelgate
ms.author: v-tappelgate
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: <sap/see CI>
ms.technology: networking
keywords: resolution policy, default zone scope, zone scope, geo-location, DNS zone policy
---

# DNS server geo-location policy doesn't work as expected

_Applies to:_ &nbsp; Windows Server 2019, all editions Windows Server 2019 Datacenter: Azure Edition - Preview


## Symptoms

Consider an organzation that uses an AD-integrated zone (default zone scope) called contoso.com for their internal workstations and servers. The organization wants to implement a geo-location DNS structure for their branches, so the clients in a specific site can access intranet services from their local subnets.

The configuration of the DNS zone resembles the following:

| Subnet | IPv4 Address space | Zone scope name |
| --- | --- | --- |
|NorthAmericaSubnet |192.168.3.0/24 |NorthAmericaZoneScope |
|CentralAmericaSubnet |192.168.6.0/24 |CentralAmericaZoneScope|
|SouthAmericaSubnet |192.168.7.0/24 |SouthAmericaZoneScope |

The organization uses the following Windows PowerShell cmdlets to register host address (A) records:

```powershell
Add-DnsServerResourceRecord -ZoneName "contoso.com" -A -Name "www" -IPv4Address "192.168.3.40" -ZoneScope "NorthAmericaZoneScope"
Add-DnsServerResourceRecord -ZoneName "contoso.com" -A -Name "www" -IPv4Address "192.168.6.40" -ZoneScope "CentralAmericaZoneScope"
Add-DnsServerResourceRecord -ZoneName "contoso.com" -A -Name "www" -IPv4Address "192.168.7.40" -ZoneScope "SouthAmericaZoneScope"
```

The organization uses the following PowerShell cmdlets to define the policies:

```powershell
Add-DnsServerQueryResolutionPolicy -Name "NorthAmericaPolicy" -Action ALLOW -ClientSubnet "eq,NorthAmericaSubnet" -ZoneScope "NorthAmericaZoneScope,1" -ZoneName "contoso.com"
Add-DnsServerQueryResolutionPolicy -Name "CentralAmericaPolicy" -Action ALLOW -ClientSubnet "eq,CentralAmericaSubnet" -ZoneScope "CentralAmericaZoneScope,1" -ZoneName "contoso.com"
Add-DnsServerQueryResolutionPolicy -Name "SouthAmericaPolicy" -Action ALLOW -ClientSubnet "eq,SouthAmericaSubnet" -ZoneScope "SouthAmericaZoneScope,1" -ZoneName "contoso.com"
```

The desired outcome is that a client attempts to locate a requested resource first in the local zone scope, then in the default zone scope. However, after the organization configures these policies, clients from the defined subnets can't successfully resolve records that're hosted in the default zone scope (contoso.com). For example, clients cannot resolve **hostA.contoso.com**. The DNS server returns a "Server Failure" message to such requests.

## Cause

In this case, incoming authoritative queries are evaluated against the appropriate set of zone-level policies based on their order of precedence. It seems intuitive to assume that any query that fails to match a policy is automatically serviced from the default zone scope. However, this is not the case. Instead, any non-matching query results in a name resolution failure.

In other words, if the DNS server receives a name resolution query for **hostA.contoso.com** from a client that's specified in a client subnet policy, the DNS server only looks at the related zone scope.

## Resolution

To configure the policies so that the DNS server checks the default zone scope as well as the local zone scope, use a more precise [DnsServerQueryResolutionPolicy](/powershell/module/dnsserver/add-dnsserverqueryresolutionpolicy) statement, such as the following:

```powershell
Add-DnsServerQueryResolutionPolicy -Name "NorthAmericaPolicy" -Action ALLOW -ClientSubnet "eq,NorthAmericaSubnet" -ZoneScope "NorthAmericaZoneScope,1" -ZoneName "contoso.com" -FQDN "www.contoso.com"
```

> [!NOTE]  
> You have to create a **DnsServerQueryResolutionPolicy** statement for each record that the appropriate zone scope contains.
