---
title: Multiple default gateways cause connectivity problems
description: Describes the connectivity issues that occur when multiple default gateways are used in TCP/IP configuration options.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Multiple default gateways can cause connectivity problems

This article describes the connectivity issues that occur when multiple default gateways are used in TCP/IP configuration options.

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 159168

## Summary

When multiple default gateways are used in TCP/IP configuration options on a Windows NT computer, connectivity to computers on remote networks may be lost. On multihomed computers connected to disjointed networks, static routes may be added to the routing table to get connectivity to remote networks.

## More information

Windows NT computers can be configured with multiple default gateways. When a dead gateway is detected by TCP, it can direct IP to switch default gateways to the next gateway in the backup list. This switch can occur when there are multiple gateways configured for the same network adapter or when different default gateway addresses are given on various network cards on a multihomed computer. A switch is triggered when TCP has tried one-half of the TcpMaxDataRetransmissions times to send a packet through the current default gateway.

After the switch, all IP traffic originating from any network adapter on this computer destined for remote networks will be sent to the currently selected gateway. On disjointed networks, this can lead to lost connectivity and subsequent termination of active sessions with computers on remote networks connected through the first gateway. This is because the currently selected gateway may be unaware of other routes managed by the first gateway if those routers do not exchange routing information to each other.

If the switched gateway is unreachable or inactive on the network, it loses connectivity to all remote sites. At this point, a ping to this computer from a remote network will fail to get a positive response. Similarly, any outgoing ping to a remote host from this computer will give a Request timed out error. This behavior is by design and conforms to TCP/IP specifications.

The following illustrations describe situations where multiple gateways are used.

Consider a computer with two network cards, Netcard1 and Netcard2, and the following IP addresses and default gateways:

> Netcard1:  
 IP Address: 11.100.1.1  
 Mask: 255.255.0.0  
 Default Gateway: 11.100.0.1 11.100.0.2
>
> Netcard2:  
 IP Address: 11.200.1.1  
 Mask: 255.255.0.0  
 Default Gateway: 11.200.0.1  

If you want to Telnet to a workstation with an IP address of 130.20.20.100, the IP datagrams will be routed through the 11.100.0.1 gateway. If 11.100.0.1 is detected as unavailable, IP switches to the second gateway 11.100.0.2. When this gateway fails, then use 11.200.0.1, and so on. This applies only to TCP traffic and switching gateways occurs based on the mechanism described earlier. Telnet, FTP, and NetBIOS Session service network traffic use TCP for network communications.

Also consider where the two networks connected to Netcard1 and Netcard2 are disjointed (that is, not connected to each other through any other router). If there's a network (say 22.101.x.x) that is accessible only through Netcard2, the IP datagrams for this network will still be routed through 11.100.0.1 because it's the primary default gateway. To route IP datagrams destined to network 22.101.x.x through 11.200.0.1, a static route needs to be added to the routing table through the ROUTE utility. To add the route, type the following command:

```console
route add 22.101.0.0 MASK 255.255.0.0 11.200.0.1  
```

Another possible solution for the above scenario is to run multiprotocol routing on the multihomed Windows NT computer so it can exchange routing information with other routers on the network running Routing Information Protocol. Multiprotocol routing is available in Windows NT 3.51 Service Pack 2 or later.
