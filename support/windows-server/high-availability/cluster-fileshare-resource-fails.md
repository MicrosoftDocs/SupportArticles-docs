---
title: Cluster fileshare resource fails
description: Clustered Fileshare resource fails on one or more node(s) of a failover cluster. This article provides a solution to this issue.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:cannot-bring-a-resource-online, csstroubleshoot
ms.subservice: high-availability
---
# Cluster fileshare resource fails on a failover cluster node and the cluster log contains "status 5. Tolerating..."

This article provides a solution to an issue where cluster fileshare resource fails on a failover cluster node.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2867302

## Symptoms

Consider the following scenario:

- In Windows Server 2008, 2008 R2 or 2012 you set up a Windows failover cluster with a highly available file server.
- The cluster nodes are configured with a disjointed namespace in which the computer's primary DNS suffice does not match the DNS domain of which it is a member.

In this scenario, you may notice that the highly available file server works fine on some of the cluster nodes but consistently fails on others. In examining the cluster log, you see something similar to the following entries with the first entry referring to "*status 5. Tolerating...*":

> 00001b6c.000008c8::*\<DateTime>* WARN [RES] File Server <FileServer-(yoel-cluster)(Cluster Disk 6)>: Failed in NetShareGetInfo(yoel-cluster, share2), status 5. Tolerating...  
00001b6c.000008c8::*\<DateTime>* ERR [RES] File Server <FileServer-(yoel-cluster)(Cluster Disk 6)>: Not a single share among 1 configured shares is online  
00001b6c.000008c8::*\<DateTime>* ERR [RES] File Server <FileServer-(yoel-cluster)(Cluster Disk 6)>: File system check failed, number of shares verified: 1, last share status: 5.  
00001b6c.000008c8::*\<DateTime>* ERR [RES] File Server <FileServer-(yoel-cluster)(Cluster Disk 6)>: Fileshares failed health check during online, status 5.

## Cause

One or more nodes of the failover cluster may contain mismatched entries in the DNS suffix search list.

## Resolution

To resolve the issue, verify all cluster nodes are configured with the same DNS suffix search list and the entries are listed in the same order. The DNS suffix search list can be modified using the following steps:

1. Open the properties page for the network adapter.
2. Open the properties page for Internet Protocol Version 4 (TCP/IPv4).
3. Select the Advanced button under the General tab.
4. Select the DNS tab.

## More information

For additional information on the setup and use of a disjointed namespace, refer to the following link:

[Create a Disjoint Namespace](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731929(v=ws.10))
