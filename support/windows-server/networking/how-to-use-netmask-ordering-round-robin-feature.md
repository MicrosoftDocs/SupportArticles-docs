---
title: Description of the netmask ordering feature and the round robin feature
description: Describes the netmask ordering feature and the round robin feature in Windows Server 2003 DNS. Describes how to use these features together. You can do this to randomize the results that are returned from a netmask ordered server.
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
# Description of the netmask ordering feature and the round robin feature in Windows Server 2003 DNS

This article describes the netmask ordering feature and the round robin feature and how to use these features together.

_Applies to:_ &nbsp; Window Server 2003  
_Original KB number:_ &nbsp; 842197

## Summary

This article describes the netmask ordering feature and the round robin feature in Windows Server 2003 domain name system (DNS). Additionally, this article describes how to use these features together. You can do this to randomize the results that are returned from a netmask ordered server.

> [!NOTE]
> The round robin feature of DNS makes it possible for DNS to return the IP addresses of a name in a different order every time.

## More information

The netmask ordering feature is used to return addresses for type A DNS queries to prioritize local resources to the client. For example, if the following conditions are true, the results of a query for a name are returned to the client based on Internet protocol (IP) address proximity:  

- You have eight type A records for the same DNS name.
- Each of your eight type A records has a separate address.

In the initial release of Microsoft Windows 2000 Server, this proximity is calculated based on the native class of address that is assigned to the client. If the client is assigned a native class A address, the responses that are sent to the client are prioritized by entries that match the client class A network membership. This is also true of native class B and native class C addresses.

The round robin feature is used to randomize the results of a similar type of query to provide basic load-balancing functionality. In the earlier example, eight type A records with the same name and different IP addresses cause a different answer to be prioritized to the top with each query. Because a new IP address is prioritized to the top with each query, clients aren't repeatedly routed to the same server.

The initial release of Windows 2000 Server can't natively use the netmask ordering feature and the round robin feature at the same time. If the netmask ordering feature is turned on, the answers are always provided to the clients in the same order. In Windows Server 2003, this behavior changed to permit the use of both the subnet-based netmask ordering feature and the round robin feature. The use of both the netmask ordering feature and the round robin feature provides proximity awareness and load-balancing.

In many current network environments, it's uncommon to have a subnet mask that is native to the actual address. Therefore, netmask-ordering that is based on the native class of an IP address is unreliable in predicting whether a network is local. Windows Server 2003 bases proximity on Class C regardless of the native address class.

For example, a company is assigned a 126.45.x.x subnet. It's unlikely that an 8-bit subnet mask will be used to define this subnet in their internal network. Additionally, the company owns only part of the class A subnet. Because this range will likely be divided into class B or smaller networks, netmask ordering may not return results that are close to the client. This is true if the network configuration is different from the network configuration that is implied by the native class of address. Because Windows Server 2003 bases proximity on Class C, close resources are more discoverable.

You can use the `Dnscmd /Config /LocalNetPriorityNetMask 0x000000FF Dnscmd.exe` command to restore Windows Server 2003 settings to the default settings.

Although the default setting in Windows Server 2003 is to base proximity on Class C, you can change this setting. You can define what part of the mask is relative for netmask ordering based on your environment. When you issue the /LocalNetPriorityNetMask switch, you can specify the bits that are significant to the netmask ordering operation. You can use the `Dnscmd /Config /LocalNetPriorityNetMask 0x0000FFFF` command to use class B (or 16 bit) for netmask ordering.

The following table lists other netmask ordering settings:

| Netmask| LocalPriorityNet |
|---|---|
|255.255.255.0|0x000000ff|
|255.255.0.0|0x0000ffff|
|255.0.0.0|0x00ffffff|

If only 6 bits are used for the host, the mask is 255.255.255.192. In CIDR notation, classless interdomain routing, this would be a /26 mask. You can use the `Dnscmd /Config /LocalNetPriorityNetMask 0x0000003F Dnscmd.exe` command to configure a subnetted class C address.

The significant bits set what part of the address is the host space. Because the binary equivalent of 0x3 is 11 and the binary equivalent of 0xF is 1111, 6 bits are set as part of the host address. If 7 bits (255.255.255.128 or /25) are required, the value would be 0x0000007F because the binary equivalent of 0x7F is 0111 1111. If only 5 bits (255.255.255.224 or /27) are required, the value would be 0x0000001F because the binary equivalent of0x1F is 0001 1111.

The `Dnscmd /Config /LocalNetPriorityNetMask 0xFFFFFFFF` command configures Windows Server 2003 to use round-robining and netmask ordering based on the client native IP address class.
