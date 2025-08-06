---
title: Default MTU Sizes for Different Network Topologies
description: Provides information about the default maximum transfer unit (MTU) sizes for different network topologies.
ms.date: 08/06/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:network connectivity and file sharing\tcp/ip connectivity (tcp protocol,nla,winhttp)
- pcy:WinComm Networking
---
# The default MTU sizes for different network topologies

## Summary

The maximum transfer unit (MTU) specifies the maximum transmission size of an interface. A different MTU value might be specified for each interface that TCP/IP uses. The MTU is determined by negotiating with the lower-level driver. However, this value might be overridden.

## More information

Each media type has a maximum frame size. The link layer is responsible for discovering this MTU and reporting the MTU to the protocols above the link layer. The protocol stack might query Network Driver Interface Specification (NDIS) drivers for the local MTU. Upper-layer protocols such as TCP use an interface's MTU to optimize packet sizes for each medium.

If a network adapter driver, such as an asynchronous transfer mode (ATM) driver, uses local area network (LAN) emulation mode, the driver might report that its MTU is larger than expected for that media type. For example, the network adapter might emulate Ethernet but report an MTU of 9,180 bytes. Windows accepts and uses the MTU size that the adapter reports even when the MTU size exceeds the usual MTU size for a particular media type.

The following table summarizes the default MTU sizes for different network media.

|Network MTU (bytes)  |
|---------|
|16 Mbps Token Ring 17914     |
|4 Mbps Token Ring 4464     |
|FDDI 4352     |
|Ethernet 1500     |
|IEEE 802.3/802.2 1492     |
|PPPoE (WAN Miniport) 1480     |
|X.25 576     |
