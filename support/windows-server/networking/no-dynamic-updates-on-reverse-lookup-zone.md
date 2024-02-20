---
title: No dynamic update on classless reverse lookup zone
description: Dynamic update does not work with classless in - addr.arpa zones. If you need to dynamically update PTR resource records, do not use classless zones.
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
# No dynamic updates on a classless reverse lookup zone

This article provides workarounds for an issue where Domain Name System (DNS) dynamic updates of Pointer (PTR) records can't be performed on a classless reverse lookup zone.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 253575

## Symptoms

Domain Name System (DNS) dynamic updates of Pointer (PTR) records cannot be performed on a classless reverse lookup zone.

## Workaround

To create PTR records in a reverse lookup zone, follow these steps on the parent and child DNS servers:

### On the parent DNS server

1. Create a non-subnetted reverse lookup zone. For example, if you have subnetted your 192.168.1.0 network into two subnets, 192.168.1.0-127 and 192.168.1.128-255, and you want to create reverse lookup zones for the first subnet, create a reverse lookup zone for 192.168.1.0. The zone name is 1.168.192.in-addr.arpa.
2. Right-click the new zone, and then click **New Delegation**.
3. Click **Next**. In the **Delegated Domain** box, type *0/25*, where 0 is the subnet address and 25 is the number of bits used for subnetting.
4. Click **Next**. Add the child DNS server's name and address when you are prompted, click **OK**, and then click **Finish**.
5. Right-click the parent zone (not the delegated zone), and then click **New Alias**.
6. Type the alias (the last octet of the IP address). For example, type *1* for a host with an IP address of 192.168.1.1.
7. In the Fully Qualified Domain Name box, type the CNAME value. For example, type *1.0/25.1.168.192.in-addr.arpa*, and then click **OK**.
8. Repeat steps 6 through 8 for every host that needs to be added.

### On the child DNS server

1. On the child DNS server, create a subnetted reverse lookup zone. For example, 0/25.1.168.192.in-addr.arpa.
2. Create PTR records for every host under the new zone. In the Host IP Number box, type the last octet of the IP address. In the **Host Name** box, type the fully qualified domain name of the host.

> [!NOTE]
> This example is for a subnetted class C network. For networks that use other class addresses, make the appropriate changes. For more information about subnetted reverse lookup zones, see [How to configure a subnetted reverse lookup zone](configure-subnetted-reverse-lookup-zone.md).

## Status

This behavior is by design. It is not possible to perform dynamic updates of DNS records on a classless reverse lookup zone.

For more information, see [Configuring and Delegating a Classless In-addr .arpa Reverse Lookup Zone](/previous-versions/windows/it-pro/windows-2000-server/cc961414(v=technet.10)#configuring-a-standard-reverse-lookup-zone).

> [!NOTE]
> Dynamic update does not work with classless in - addr.arpa zones. If you need to dynamically update PTR resource records, do not use classless zones.

For Windows Server 2008 R2, see [Adding a resource record to a reverse lookup zone](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc816632(v=ws.10)).
