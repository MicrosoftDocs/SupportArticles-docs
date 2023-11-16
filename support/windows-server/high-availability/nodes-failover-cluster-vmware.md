---
title: Remove node from active failover cluster membership
description: Addresses the issue of finding nodes removed from active failover cluster membership.
author: Deland-Han
ms.author: delhan
ms.date: 10/16/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-lianna
ms.custom: sap:node-removed-from-the-cluster, csstroubleshoot
ms.technology: windows-server-high-availability
---
# Nodes being removed from failover cluster membership on VMware ESX

This article addresses the issue of finding nodes removed from active failover cluster membership when the nodes are hosted on VMware ESX.

## Symptom

You see the following event in the System Event Log of the Event Viewer when this issue occurs:

:::image type="content" source="media\nodes-failover-cluster-vmware\event-1135.png" alt-text="Screenshot of the details of Event 1135 in Event Viewer.":::

## Resolution

One specific problem is with the VMXNET3 adapters dropping inbound network packets because the inbound buffer is set too low to handle large amounts of traffic. You easily can find out if packets are being drop by using **Performance Monitor** to look at the **Network Interface**\\**Packets Received Discarded** counter.

:::image type="content" source="media\nodes-failover-cluster-vmware\packets-received-discarded.png" alt-text="Screenshot of the Add Counters window in Performance Monitor showing the Packets Received Discarded counter.":::

After you've added this counter, look at the **Average**, **Minimum**, and **Maximum** numbers. If the values are higher than zero, then the receive buffer needs to be adjusted upward for the adapter. This problem is documented in [Large packet loss in the guest OS using VMXNET3 in ESXi (2039495)](https://kb.vmware.com/s/article/2039495).
