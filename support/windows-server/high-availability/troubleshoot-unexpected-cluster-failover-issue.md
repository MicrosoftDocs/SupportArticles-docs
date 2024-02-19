---
title: Guidance for troubleshooting unexpected cluster failover
description: Provides guidance to find the root cause of an unexpected failover in a Windows-based failover cluster.
ms.date: 05/09/2022
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:root-cause-of-an-unexpected-failover, csstroubleshoot
---
# Unexpected cluster failover troubleshooting guidance

A cluster won't trigger a failover unless there's an actual issue with one of the cluster's components (software or hardware). It will perform a basic recovery step, and the affected resource will fail over to another node because of the following possible causes:

- Resource failure

- Networking issue such as node eviction

- Cluster Shared Volume (CSV) disk failure

## Troubleshooting checklist

1. Identify the occurrence timestamp in the System Event Log. Then, search for events about the source *Microsoft-Windows-FailoverClustering* and check for [Event ID 1069, 1146, or 1230](https://techcommunity.microsoft.com/t5/failover-clustering/understanding-how-failover-clustering-recovers-from-unresponsive/ba-p/371847).

2. Match the time zone of the System event log to the GMT time zone in the cluster log.

   > [!NOTE]
   > To quickly find the time zone difference, search for `The current time is`.

3. Navigate to the occurrence timestamp in the cluster log and identify the corresponding line. You may find an error such as:

   - `Resource <name> IsAlive has indicated failure`

   - `IsAlive sanity check failed`

   > [!NOTE]
   > The error can be different depending on the issue.

4. Scroll up in the cluster log and try to identify if there's any other error that might be the actual cause.

5. Scroll down in the cluster log and search for `Group move` or `Move of group` for the affected resource. Take note of the exact timestamp and the destination node.

6. Switch over to the cluster log of the destination's node and check the resource's behavior when it's online. If the resource manages to come online, you'll find the following log:

   - `Resource <name> has come online`

   - `Group move for <name> has completed`

   Otherwise, you'll find the following log:

   `Online for resource <name> failed`

## More information

For more information, see the following articles:

- [Resource Hosting Subsystem (RHS) in Windows Server Failover Clusters](/archive/blogs/askcore/resource-hosting-subsystem-rhs-in-windows-server-2008-failover-clusters)

- [Failover behavior on clusters of three or more nodes](groups-fail-logic-three-more-cluster-node-members.md)
