---
title: DNS Server becomes an island
description: Describes an issue where a domain controller points to itself for the _msdcs.ForestDnsName domain.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, dsmith
ms.custom: sap:dns, csstroubleshoot
---
# DNS Server becomes an island when a domain controller points to itself for the _msdcs.ForestDnsName domain

This article provides a solution to an issue where DNS Server becomes an island when a domain controller points to itself for the _msdcs.ForestDnsName domain. For more information, see the [Microsoft Support Lifecycle Policy](/lifecycle/).

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 275278

## Symptoms

You're using a Microsoft Windows 2000-based domain controller that is running the Domain Name System (DNS) Server service. The domain controller is authoritative for the _msdcs.**ForestDnsName** domain. This domain is the forest root. In this scenario, your domain controller may not replicate to Active Directory. When you open the Active Directory Users and Computers snap-in, you notice that the focus of your domain controller is set to a different domain controller. If you run Netdiag.exe, you receive the following error message:

> DNS test . . . . . . . . . . . . . : Passed  
Interface {BA748513-436B-4768-9D8C-8B3C5C8A0DCA}  
DNS Domain:  
DNS Servers: \<IP address1>,\<IP address2>, \<IP address3>  
IP Address: \<IP address1> Expected registration with PDN (primary DNS domain name):  
Hostname: a.b.c.d.  
Authoritative zone: b.c.d.  
Primary DNS server: a.b.c.d. \<IP address1>  
Authoritative NS:\<IP address1>,\<IP address1>.\<IP address1>  
Verify DNS registration:  
Name: a.b.c.d.  
Expected IP: \<IP address1>  
Server \<IP address1>: NO_ERROR  
Server \<IP address2> Error 9003 RCODE_NAME_ERROR  
Server \<IP address3> Error 9003 RCODE_NAME_ERROR  

> [!NOTE]
> Error 9003 RCODE_NAME_ERROR means that the host name a.b.c.d. doesn't exist in the DNS servers that are listed in the error message.

The behavior that is mentioned in the [Symptoms](#symptoms) section can occur under the following circumstances:

- In the forest root, there are several domain controllers that are running the DNS Server service.
- The domain controller that is running the DNS Server service is a primary DNS Server for the _msdcs.**ForestDnsName** domain.
- The domain controller that is running the DNS Server service points to itself as the preferred or alternative DNS server.

## Cause

This behavior may occur because a DNS server for one domain controller may not have the required domain controller locator CNAME record for **DsaGuid**._msdcs.**ForestDnsName** in its zone for another domain controller.

## Resolution

To resolve this behavior, read the following scenario. Then, use either of the following two methods, depending on your server load and network considerations.

In this scenario, two domain controllers that are in the forest root, DC1.**example**.com and DC2.**example**.com, aren't replicating. Both of the domain controllers are running the DNS Server service. Both of the domain controllers are authoritative for the **example**.com domain.

Both of the domain controllers' NetLogon services try to register their DNS records, and find that their preferred DNS servers, which are themselves, are authoritative for the **example**.com zone. Both of the DNS servers register the DNS records with their local DNS Server service. One of these DNS records is a domain controller locator CNAME record for **DsaGuid**._msdcs.**ForestDnsName**. When DC1.**example**.com tries replication with DC2.**example**.com, DC1.**example**.com queries its local DNS server for the CNAME record for DC2 **example**.com, but doesn't find it. So the replication process is unsuccessful.

Two possible methods for resolving this behavior are as follows:

### Method 1

Select a DNS server that is in the forest root, and point all of the other domain controllers in the root domain to it as their primary DNS server. Each domain controller that is in the root domain may also be configured with an alternative DNS server, if the alternative DNS server doesn't point to itself as the alternative DNS server. The domain controller that functions as the primary location for the other domain controllers in the forest root should point to itself for DNS resolution.

> [!NOTE]
> This method may not be appropriate if the primary DNS server is subject to heavy loads, or if the other domain controllers that are in the forest root are geographically dispersed.

#### Example

Domain = **example**.com (first domain in the forest).  
Three domain controllers with the DNS Server service = DC1, DC2, DC3.**example**.com is an Active Directory integrated zone.  
DC1 is designated as the primary location for this configuration.

DC1 is configured to point to itself for DNS server settings in TCP/IP properties.  
DC2 points to DC1 as the primary location and DC3 as an alternative.  
DC3 points to DC1 as the primary location and DC2 as an alternative.

### Method 2

When you install Active Directory on the member server that is in the forest root, you must configure its primary DNS server as a domain controller, or as a DNS server that has the following domain controller locator CNAME record for all the other domain controllers in the root:  
**DsaGuid**._msdcs.**ForestName**.

Install the DNS Server service and enable the integrated Active Directory DNS zone to replicate to the new domain controller. Then the new domain controller may be changed to point to itself as the primary or alternative DNS server.

If there are any IP address changes for the domain controllers that are in the forest root, you may have to follow the steps in Method 1 until no longer required to do so. When you've verified that the IP address changes have replicated to the DNS zone of the new domain controller that is in the forest root, the domain controllers may be configured to point to themselves as the primary or alternative DNS server again.

## More information

You can configure a domain controller to point to itself as a preferred or alternative DNS server. The only reason that the domain controller may not replicate to Active Directory is if that domain controller is also the primary DNS server for the _msdcs.**ForestDnsName** domain.

After the domain controller has registered the **DsaGuid**._msdcs.**ForestDnsName** CNAME record with its local DNS Server service, the domain controller may then be configured to point to itself as the preferred or alternative DNS server. An administrator must know that the domain controller locator CNAME record for another domain controller could accidentally be deleted because of human error. Although the NetLogon service automatically registers this domain controller locator CNAME record, it can only be created on the domain controller. Active Directory replication by this domain controller of the domain controller locator CNAME record for another domain controller may not occur if this domain controller is also the primary DNS server for the_msdcs.**ForestDnsName** domain.

The following example is a scenario in which pointing a domain controller to itself as a preferred DNS server may cause a problem with Active Directory replication.

- DC1.**example**.com is the first domain controller in a forest. It's configured to point to itself as a preferred DNS server that is authoritative for the **example**.com zone.
- Server2 is a Windows 2000-based computer with a local DNS server. Server2 is configured to point to itself as a preferred DNS server. Server2 has a forwarder that is set to DC1.**example**.com.
- Promote Server2 to an additional domain controller, DC2.**example**.com. During promotion, the Active Directory integrated **example**.com zone replicates to DC2.**example**.com.
- Restart DC2.**example**.com. When the DNS Server for DC2.**example**.com starts, that DNS Server loads the **example**.com zone from Active Directory. The DNS Server for DC2.**example**.com then becomes the primary location for the **example**.com zone and the _msdcs.**example**.com zone. The domain controller locator CNAME record that is registered by DC2.**example**.com is added to the local copy of the **example**.com zone. However, the domain controller locator CNAME record that is registered by DC2. **example**.com can't be replicated to DC1.**example**.com. This behavior may occur because DC1.**example**.com queries its local DNS server that is authoritative for the **example**.com zone, but the DNS server for DC1.**example**.com doesn't contain the domain controller locator CNAME record that is registered by DC2.**example**.com.
