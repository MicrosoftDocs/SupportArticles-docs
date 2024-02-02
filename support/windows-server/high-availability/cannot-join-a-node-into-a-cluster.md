---
title: Unable to join a node into a cluster
description: Resolves an issue where users are unable to join a node into a cluster if UDP port 3343 is blocked.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-yuluo
ms.custom: sap:initial-cluster-creation-or-adding-node, csstroubleshoot
ms.subservice: high-availability
---
# You are unable to join a node into a cluster if UDP port 3343 is blocked

This article provides a solution to an issue where users are unable to join a node into a cluster if UDP port 3343 is blocked.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2455128

## Symptoms

Consider the following scenario:

- On a computer that is running Windows Server 2008 or Windows Server 2008 R2.
- You attempt to join the node into a cluster.

In this scenario, you may not be able to join the node into the cluster and you may receive the following error in system event log:

> Log Name:      System  
Source:        Microsoft-Windows-FailoverClustering  
Date:          \<date>  
Event ID:      1572  
Task Category: Cluster Virtual Adapter  
Level:         Critical  
Keywords:  
User:          SYSTEM  
Computer:      \<computer>  
Description:  
Node \<computer> failed to join the cluster because it could not send and receive failure detection network messages with other cluster nodes. Please run the Validate a Configuration wizard to ensure network settings. Also verify the Windows Firewall 'Failover Clusters' rules.  

## Cause

Cluster nodes communicate over User Datagram Protocol (UDP) port 3343. The issue may occur because the UDP port 3343 is not opened.

## Resolution

To fix the issue, open the required UDP port 3343 on the cluster.

## More information  

This is a sample cluster log. The UDP port 3343 on the cluster is blocked:

> 00001344.0000043c::2010/07/27-12:54:42.832 INFO  [CORE] Node 88f462ac-eb7c-4b57-aaf2-7a989aa38806: Cookie Cache 88f462ac-eb7c-4b57-aaf2-7a989aa38806  
00001344.0000043c::2010/07/27-12:54:42.832 DBG   [CHANNEL 10.100.20.27:~3343~] Not closing handle because it is invalid.  
00001344.0000043c::2010/07/27-12:54:42.832 WARN  cxl::ConnectWorker::operator (): GracefulClose(1226)' because of 'channel to remote endpoint 10.100.20.27:~3343~ is closed'  
00001344.00001b8c::2010/07/27-12:54:43.815 INFO  [JPM] Node 3: Selected partition 904(1 2 4 5) as a target for join  
00001344.00001b8c::2010/07/27-12:54:43.815 WARN  [JPM] Node 3: No connection to node(s) (2). Cannot join yet  
00001344.0000043c::2010/07/27-12:54:44.813 INFO  [JPM] Node 3: Selected partition 904(1 2 4 5) as a target for join  
00001344.0000043c::2010/07/27-12:54:44.813 WARN  [JPM] Node 3: No connection to node(s) (2). Cannot join yet  
00001344.00001b8c::2010/07/27-12:54:45.827 INFO  [JPM] Node 3: Selected partition 904(1 2 4 5) as a target for join  
00001344.00001b8c::2010/07/27-12:54:45.827 WARN  [JPM] Node 3: No connection to node(s) (2). Cannot join yet  
00001344.0000043c::2010/07/27-12:54:46.825 INFO  [JPM] Node 3: Selected partition 904(1 2 4 5) as a target for join  
00001344.0000043c::2010/07/27-12:54:46.825 WARN  [JPM] Node 3: No connection to node(s) (2). Cannot join yet

You can confirm the UDP port 3343 by command `netstat -ano`.

For more information, see [Event ID 1572 — Network Connectivity and Configuration](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc773432(v=ws.10)).
