---
title: (The cluster node already exists) error may appear during cluster setup
description: This article provides the resolution to fix the error that (The cluster node already exists) during cluster setup
ms.date: 09/14/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Initial Cluster Creation or Adding node
ms.technology: HighAvailability
---
# "The cluster node already exists" error may appear during cluster setup

This article provides the resolution to fix the error that "The cluster node already exists" during cluster setup.

_Original product version:_ &nbsp;  Windows Server 2003  
_Original KB number:_ &nbsp; 555216

This article was written by [Yuval Sinay](https://mvp.microsoft.com/PublicProfile/7674?fullName=Yuval%20Sinay), Microsoft MVP.

## Symptoms

During create new cluster via Cluster Administrator or cluster.exe command line, an error "The cluster node already exists" may appear.

## Cause

If the current server is member of exiting cluster, or/and the current resource (most often quorum disk) is available.

## Resolution

The resolution process depends on the current status of the cluster member:
1. If the current server should belong to exiting cluster, verity that quorum disk in online and all cluster resource available for regular use. The server should not be used as a new cluster member.
2. If the current shouldn't belong to exiting cluster or/and the cluster configuration cannot be restored or be fixed, follow the following instructions:

    >[!Note]
    > The following process is irreversible, and may require reinstall the cluster.  
    > 1. Go to Start -> Run. 
    > 2. Write Cmd and press on Enter button.
    > 3. Write cluster node *nodename* /forcecleanup  and press on Enter button.
    > 4. The message Clean up successfully completed. should be appear after a few seconds.

## More information
Clustering Services
 [https://www.microsoft.com/windowsserver2003/technologies/clustering/default.mspx](https://www.microsoft.com/windowsserver2003/technologies/clustering/default.mspx) 

Managing Disk Ownership in a Windows Server 2003 Cluster
 [https://support.microsoft.com/kb/818878](https://support.microsoft.com/help/818878) 

How to configure Microsoft Distributed Transaction Coordinator on a Windows Server 2003 cluster
 [https://support.microsoft.com/kb/301600](https://support.microsoft.com/help/301600)

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]