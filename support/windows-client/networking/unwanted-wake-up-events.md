---
title: Unwanted wake-up events when you enable WOL
description: Explains why unwanted wake-up events may occur when you enable WOL functionality in Windows 7 and in Windows Vista.
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
# Unwanted wake-up events occur when you enable the Wake On LAN feature

This article explains why unwanted wake-up events occur when you enable the Wake On LAN (WOL) functionality in Windows 7 and in Windows Vista, and describes how to configure the computer to wake only in response to a Magic Packet.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 941145

## Introduction

In Windows 7 and in Windows Vista, the WOL feature can wake a remote computer from a power-saving state such as sleep. When you enable WOL, the network adapter continues listening to the network when the computer is asleep. WOL wakes the computer if it receives a special data packet.

One kind of special data packet contains a wake-up pattern. By default, Windows 7 and Windows Vista listen for the following packets when you enable WOL:

- A directed packet to the MAC address of the network adapter
- A NetBIOS name resolution broadcast for the local computer name
- An Address Resolution Protocol (ARP) packet for the IPv4 address of the network adapter
- An IPv6 Neighbor Discovery packet for the network adapter's solicited-node multicast addressA Magic Packet can also wake a remote computer.

A Magic Packet is a standard wake-up frame that targets a specific network interface.

In most cases, a wake-up pattern or a Magic Packet enables remote access to a computer that is in a power-saving state. However, some networking protocols use these packets for other purposes. For example, routers use ARP packets to periodically confirm the presence of a computer. Such protocols do not use these packets to wake computers. However, in some networks, network traffic may wake up a remote computer by mistake. These unwanted wake-up events may occur in especially noisy environments such as enterprise networks. Therefore, by default, WOL is disabled in Windows 7 and in Windows Vista.

## More information

WOL can be an effective way to conserve power while keeping a computer reachable on the network.

However, unwanted wake events may occur after you enable WOL. For example, the computer may wake up soon after it enters a power-saving state. One cause may be that the network environment generates wake-up patterns too frequently. In this situation, we strongly recommend that you configure the computer to wake only in response to Magic Packets. Magic Packets are especially designed to wake up a computer from a power-saving state. Also, because a Magic Packet is specific to the MAC address of a network adapter, a Magic Packet is unlikely to be sent accidentally.

To configure Windows 7 in this manner, follow these steps:

1. Click **Start**, type *Network and Sharing Center* in the **Start Search**  box, and then press Enter.
2. On the **Tasks** bar, click **Change adapter settings**.
3. Right-click the network adapter that you want to configure, and then click **Properties**. For example, right-click **Local Area Connection**, and then click **Properties**.
4. If you are prompted for an administrator password or for confirmation, type the password or provide confirmation.
5. Click **Configure**.
6. If the network adapter supports WOL, click to select the **Allow this device to wake the computer** check box on the **Power Management** tab, select the **Only allow a magic packet to wake the computer** check box, and then click **OK**.

To configure Windows Vista in this manner, follow these steps:

1. Click **Start**, type Network and Sharing Center in the **Start Search**  box, and then press Enter.
2. On the **Tasks** bar, click **Manage network connections**.
3. Right-click the network adapter that you want to configure, and then click **Properties**. For example, right-click **Local Area Connection**, and then click **Properties**.
4. If you are prompted for an administrator password or for confirmation, type the password or provide confirmation.
5. Click **Configure**.
6. If the network adapter supports WOL, select the **Allow this device to wake the computer** check box on the **Power Management** tab, select the **Only allow management stations to wake the computer** check box, and then click **OK**.

You may also have to enable BIOS settings to enable WOL. The specific BIOS settings depend on the manufacturer of the computer.
