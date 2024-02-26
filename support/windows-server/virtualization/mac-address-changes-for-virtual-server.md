---
title: Fails to connect to virtual server after failover
description: Helps solve an issue where users in a different subnet are unable to connect to the virtual server after a failover from one cluster node to another.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, stevemat, davidg, johnmar
ms.custom: sap:high-availability-virtual-machines, csstroubleshoot
---
# MAC address changes for virtual server during a failover with clustering

This article provides a solution to an issue where users in a different subnet are unable to connect to the virtual server after a failover from one cluster node to another.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 244331

## Symptoms

After a failover from one cluster node to another, users in a different subnet may be unable to connect to the virtual server.

## Cause

Server Clusters and Failover Clustering perform a gratuitous Address Resolution Protocol (ARP) request when a failover occurs. However, some devices (such as switches) may not forward the gratuitous ARP request to other devices. This causes devices on the other side of the switch or router to have the incorrect MAC address for the virtual server that has failed over. Often, this situation corrects itself after a router or switch sees the failure and updates its ARP cache by performing a broadcast. Most routers and switches are configured not to forward ARP traffic between subnets to prevent ARP storms from occurring.

## Resolution

Gratuitous ARP requests must be forwarded across networks so that all devices receive the updated MAC-to-IP address mappings. Contact your hardware manufacturer for information about how to change your switch or router's configuration so that gratuitous ARP requests are passed to all networks.

## More information

In a cluster, each computer (or cluster node) has a network adapter attached to the corporate network, and each cluster node has its own IP address, network name (NetBIOS name), and MAC address. The virtual server has an IP address and network name, but uses the MAC address of the cluster node that is the current owner of the virtual server resources.

When a failover occurs, the cluster server of the node that is receiving IP resources sends a gratuitous ARP request so that all devices (computers, routers, and switches) are updated, and a new MAC address is assigned to an existing IP address. If a switch or router does not pass the updated MAC-to-IP address mappings, other network devices contain the old MAC address for the cluster node that is down.

For additional information, click the article numbers below to view the articles in the Microsoft Knowledge Base:

[168567](https://support.microsoft.com/help/168567) Clustering Information on IP Address Failover
