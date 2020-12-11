---
title: Cluster IP address resources fail on both nodes of a two-node multi-site cluster when one node disconnects
description: This article describes the behavior that occurs when one node of a two-node multi-site cluster disconnects from the public cluster network. In this case, the IP address resources on the remaining node fail and that node shuts down.
ms.date: 12/22/2020
author: Teresa-Motiv
ms.author: v-tea
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: node removed from the cluster
ms.technology: high-availability
keywords: multi-site,multisite,cluster,disconnect,cross-subnet,stretched,vlan
---
# Cluster IP address resources fail on both nodes of a two-node multi-site cluster when one node disconnects

This article describes the behavior that occurs when one node of a two-node multi-site cluster disconnects from the public cluster network. In this case, the IP address resources on the remaining node fail and that node shuts down.

_Original product version:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

## Symptoms

Consider the following scenario:

You have a two-node multi-site cluster (one node in each site). The cluster uses a File Share Witness (FSW) resource. The cluster nodes are connected by the following two networks:

- One stretched private VLAN
- One non-stretched public VLAN

In this scenario, one of the nodes disconnects from the public VLAN. The following figure shows the resulting configuration.

 :::image type="content" source=".\media\cluster-ip-resources-fail-2-node-2-site-fsw-cluster\disconnect-nodes-in-different-sites.png" alt-text="Two node cluster across two sites, with disconnected public VLAN":::

Using the diagram as an example, the cluster detects the interruption, and marks the public VLAN NIC on Node 2 as "Failed." As a result, all of the cluster IP address resources on Node 2 shut down, and the cluster generates messages that resemble the following:

> 000005ec.000011e4::2020/09/19-19:41:51.777 DBG   [IM - public-1.0.0] Adding interface states for cross-subnet-route-only interfaces
>  
> 000005ec.000011e4::2020/09/19-19:41:51.777 DBG   [IM - public-1.0.0] Interface 1ee3567e-84f7-459a-a39e-a5c44de643fa has no up cross-subnet routes. Marking it as failed

Because the two sites cannot communicate across the public VLAN, the cluster also marks the public VLAN NIC on Node 1 as "Failed." As a result, all of the cluster IP Address resources on Node 1 also shut down.

> 00001790.000006ac::2020/09/19-19:41:51.780 INFO  [IM] Changing the state of adapters according to result: \<*class mscs::InterfaceResult*>
>  
> 00001790.00001678::2020/09/19-19:41:51.780 DBG   [IM] EventManager::ProcessInterfaceChanged: Ignoring event for Node1- 1.0.0-range that should not be published.
>  
> 00001790.00001678::2020/09/19-19:41:51.780 DBG   [NM] Got interface changed event for adapter Node1 - 1.0.0-range, new state 1
>  
> 000012dc.00001664::2020/09/19-19:41:51.796 WARN  [RES] IP Address \<*Cluster IP Address x.x.x.x*>: WorkerThread: NetInterface 1ee3567e-84f7-459a-a39e-a5c44de643fa has failed. Failing resource.

The end result of this network disconnect is that the cluster groups on both nodes are in a failed state. You have to manually bring them online again.

If the two cluster nodes were in the same site, a similar network disconnect would cause the public VLAN NIC on Node 2 would fail in the same way. However, in that case all the cluster groups on Node 2 would fail over to Node 1.

## Cause

This is the expected response for this scenario. We recommend that you use four nodes for multi-site clusters instead of two nodes. [Azure AzS HCI](https://docs.microsoft.com/azure-stack/hci/overview) clusters require four nodes.

## Resolution

To prevent this behavior, you can change your cluster configuration in the following ways:

- Add at least one cluster node to each site. In this configuration, if one node on a site disconnects, the remaining node continues to communicate with the other site. The cluster resources remain online.
- Add another cluster node at a third site. In this configuration, if one node disconnects, the two remaining nodes remain online and cross-site communication continues.
- Change the private cluster network to a non-stretched VLAN. In this configuration, if one node disconnects, the cluster starts the arbitration algorithm to determine resource and quorum ownership.

If you have the configuration that the "Symptoms" section describes and you have to disconnect a node in a controlled manner (such as for a planned maintenance window), prepare the cluster before you disconnect. Use one of the following approaches:

- Disable all networks except for the public cluster VLAN.
- Shut down all the cluster nodes except one.

When you are ready to resume typical operations, start by enabling the networks (or restarting the nodes).

## More information

- [Windows clustering and geographically separate sites](https://support.microsoft.com/office/windows-clustering-and-geographically-separate-sites-851893e6-0ef9-95a2-6b80-88d6635233fe?ui=en-us&rs=en-us&ad=us)
