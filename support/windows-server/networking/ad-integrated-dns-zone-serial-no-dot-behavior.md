---
title: AD-integrated DNS zone serial No. behavior
description: Describes Active Directory-integrated Domain Name System (DNS) zone serial number behaviors.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
---
# Active Directory-integrated DNS zone serial number behavior

This article describes Active Directory-integrated Domain Name System (DNS) zone serial number behaviors.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 282826

## Summary

When a DNS server receives an update directly (either from the administrator, or through dynamic updates), it always increases the serial number of the zone.

When a DNS server receives an update through Active Directory replication:

- If the serial number of the replicated record is higher than the serial number in the SOA record of the local copy of the zone, the local zone serial number is set to the serial number in the replicated record.

    > [!NOTE]
    > Each DNS record in the zone has a copy of the zone serial number at the time when the record was last modified.
- If the serial number of the replicated record is the same or lower than the local serial number, and if the local DNS server is configured not to allow zone transfer of the zone, the local zone serial number is not changed.
- If the serial number of the replicated record is the same or lower than the local zone serial number, if the DNS server is configured to allow a zone transfer of the zone, and if the local zone serial number has not been changed since the last zone transfer occurred to a remote DNS server, then the local zone serial number will be incremented. Otherwise that is if a copy of the zone with the current local zone serial number has not been transferred to a remote DNS server, the local zone serial number is not changed.

## More information

In a scenario where a third-party DNS server is configured as secondary for an Active Directory-integrated zone, the first (preferred) primary server becomes unavailable, and the secondary server attempts a zone transfer from another primary server for the zone, then the secondary DNS server (by using IXFR) may not notice that the zone was updated if the serial number of the zone is lower on the latter primary server. In this scenario, the secondary successfully performs zone transfer after the primary's serial number becomes greater than the serial number in the SOA record in the zone on the secondary server.

> [!NOTE]
> The multiple-master replication behavior of an Active Directory-integrated Domain Name System (DNS) zone can cause inconsistencies with serial numbers of the zone across multiple DNS servers. It is not possible to retrieve information (pull or source) from multiple Active Directory-integrated primary DNS servers to a secondary DNS server for the same Active Directory-integrated zone. This was possible and frequently done with conventional single-master DNS. However, because serial numbers are maintained separately on each Active Directory-integrated DNS server, the mechanism for determining whether the secondary DNS server has the most-recent copy may will fail.
