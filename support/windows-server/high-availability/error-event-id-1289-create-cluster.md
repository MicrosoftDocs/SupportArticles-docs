---
title: Error message and event ID 1289 when you try to create a cluster
description: Fixes a problem that occurs when you try to create a cluster on a set of computers that have the Failover Clustering feature installed.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ahmedb, dewitth
ms.custom: sap:initial-cluster-creation-or-adding-node, csstroubleshoot
---
# You receive an error message, and event ID 1289 is logged when you try to create a cluster

This article helps to fix a problem that occurs when you try to create a cluster on a set of computers that have the Failover Clustering feature installed.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 973838

## Symptoms

Consider the following scenario:

- You install the Failover Clustering feature on a set of Windows Server 2008-based computers.
- You try to create a failover cluster on these computers by using the Failover Cluster Management Microsoft Management Console (MMC) snap-in or by using the Cluster.exe tool.  

In this scenario, the cluster creation fails, and you receive the following error message:  
>An error occurred while creating the cluster. An error occurred creating cluster 'clustername'. The service has not been started.  

Additionally, the following event is logged in the System log:

## Cause

To eliminate single points of failure that are related to network communication, failover clustering uses the Microsoft Failover Cluster Virtual Miniport driver. Additionally, this driver generates a physical address during startup. However, any of the following situations would make cluster creation fail:

- No physical adapter has a universally administered MAC address.
- Cluster configuration is not fully cleaned up after a sequence of repeated installation and removal of the Failover Clustering feature.

## Resolution

To resolve this problem, follow these steps to reinstall the Failover Clustering feature:

1. On each computer that you want to make a cluster node, use the Server Manager console to remove the Failover Clustering feature.
2. Restart each computer from which you have removed the Failover Clustering feature.
3. Add the Failover Clustering feature on all these computers again.
4. Run cluster validation against these computers.
5. Try creating a cluster.  

If the problem is not resolved after you reinstall the Failover Clustering feature, follow these steps, and then run the reinstallation again.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

1. Open Registry Editor.
2. Locate the following registry subkey:  
 **HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}**  

3. Under this subkey, find the subkey that holds a **DriverDesc** string value entry whose value is "Microsoft Failover Cluster Virtual Adapter."
4. Under the subkey that you found in step 3, add the following string value registry entry:  
Name: DatalinkAddress  
 Value data: 02-AA-BB-CC-DD-01
5. Restart the computer.
6. Repeat step 1 through step 5 on other computers on which you experience this problem. When you do this on other computers, replace the value data of the registry with different values in order to set a unique value for each node. For example, set the value on the second node to 02-AA-BB-CC-DD-02, and set value on the third node to 02-AA-BB-CC-DD-03. If you notice this behavior on distinct clusters, make sure that you use an address for each node that is unique across all clusters.
7. Try creating the cluster again.
