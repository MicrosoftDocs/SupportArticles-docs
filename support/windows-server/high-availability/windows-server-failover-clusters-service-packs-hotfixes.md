---
title: Update Windows Server failover clusters
description: Describes how to update failover clusters in Windows Server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:replacing-hardware-and-updating-the-operating-system, csstroubleshoot
ms.subservice: high-availability
---
# How to update Windows Server failover clusters

This article describes how to update failover clusters in Windows Server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 174799

## Summary

This article describes how to install service packs or hotfixes on a Windows Server failover cluster. Applying a service pack or hotfix to a server cluster is the same as applying a service pack or hotfix to Windows Server. However, there are special conditions that you should consider to make sure that clients have a high level of access while you perform the installation.

## More information

To install Windows service packs or hotfixes on a Windows Server failover cluster, follow these steps, depending on the version of Windows Server that you're running. Always install the same service packs or hotfixes on each cluster node. Follow these steps unless you're directed otherwise by the instructions for a particular service pack version.

### Windows Server 2012 - 2019

Installing service packs and hotfixes on Windows Server 2012 - 2019 requires a different process. For more information, see [Draining Nodes for Planned Maintenance with Windows Server](https://techcommunity.microsoft.com/t5/failover-clustering/draining-nodes-for-planned-maintenance-with-windows-server-2012/ba-p/371713).

### Install service packs or hotfixes by using Failover Cluster Manager in Windows Server 2008 R2

Membership in the local Administrators group on each clustered server or an equivalent is required to complete this procedure.

1. Check the System log for errors, and make sure that the system is operating correctly.
2. Make sure that you have a current backup and updated emergency repair disk for each system. If there are corrupted files, a power outage, or an incompatibility, you may have to revert to the state of the system before you tried to install the service packs or hotfixes.
3. In the Failover Cluster Manager snap-in, right-click **Node A**, and then click **Pause**.
4. On Node A, expand **Services and Applications**, and then click the service or application.
5. Under **Actions** (on the right side), click **Move this service or application to another node**, and then select the node.

    > [!NOTE]
    > As the service or application moves, its status is displayed in the details pane (the center pane).
6. Follow steps 4 and 5 for each service and application that is configured on the cluster. On a cluster that has more than two nodes, from the options next to Move this service or application to another node, you can select Best possible. This option has no effect if you don't have a Preferred owners list configured for the service or application that you're moving. (In this case, the node will be selected randomly.) If you configured a Preferred owners list, the Best possible option will move the service or application to the first available node on the list.
7. Install the service packs or hotfixes on Node A, and then restart the computer.
8. Check the System log for errors. If you find any errors, troubleshoot them before you continue this process.
9. In the Failover Cluster Manager snap-in, right-click **Node A**, and then click **Resume**.
10. In the Failover Cluster Manager snap-in, right-click **Node B**, and then click **Pause**.
11. Under **Actions** (on the right side), click **Move this service or application to another node**, and then select the node.
    > [!NOTE]
    > As the service or application moves, its status is displayed in the details pane (the center pane).
12. Follow steps 10 and 11 for each service and application that is configured on the cluster.
13. Install the service packs or hotfixes on Node B, and then restart the computer.
14. Check the System log for errors. If you find any errors, troubleshoot them before you continue this process.
15. In Failover Cluster Manager, right-click **Node B**, and then click **Resume**.
16. Right-click each group, click **Move Group**, and then move the groups back to their preferred owner. For more information, see [Test the Failover of a Clustered Service or Application](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754577(v=ws.11)) and [Pause or Resume a Node in a Failover Cluster](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731291(v=ws.11)).

### Install service packs or hotfixes by using Windows PowerShell cmdlets in Windows Server 2008 R2

Membership in the local Administrators group on each clustered server or an equivalent is required to complete this procedure.

1. Check the System log for errors, and make sure that the system is operating correctly.
2. Make sure that you have a current backup and updated emergency repair disk for each system. If there are corrupted files, a power outage, or an incompatibility, you may have to revert to the state of the system before you tried to install the service packs or hotfixes.
3. In the Windows Server 2008 R2, use the **Windows PowerShell Modules** link under **Administrative Tools** to automatically import all the Windows PowerShell modules for the features or roles that you've installed.
4. Use the shortcut in Administrative Tools to start Failover Cluster PowerShell Management. Or, start Windows PowerShell on your computer by right-clicking and then selecting **Run as administrator**.
5. Load the Failover Clusters module by running the following command: `Import-Module FailoverClusters`.
6. Suspend (Pause) activity on failover cluster node A by running the following command: `Suspend-ClusterNode nodeA`.
7. Move a clustered service or application (a resource group) from one node to another by running the following command: `Move-ClusterGroup \<clustered service> -Node nodeB`.

    > [!TIP]
    > You can also use following command to move all groups of the node to the preferred owner of the best possible node: `Get-ClusterNode NodeA | Get-ClusterGroup | Move-Cluster Group`.
8. Install the service pack on Node A, and then restart the computer.
9. Check the System log for errors. If you find any errors, troubleshoot them before you continue this process.
10. Resume activity on node A that was suspended in step 5 by running the following command: `Resume-ClusterNode nodeA`.
11. Suspend (Pause) activity on other failover cluster node by running the following command: `Suspend-ClusterNode nodeB`.
12. Move a clustered service or application (a resource group) from one node to another by running the following command: `Move-ClusterGroup <clustered service> -Node nodeB`.

    > [!NOTE]
    > You can again use following command to move all groups of the node to the preferred owner of the best possible node:  
    `Get-ClusterNode NodeB | Get-ClusterGroup | Move-Cluster Group`.
13. Install the service pack on Node B, and then restart the computer.
14. Check the System log for errors. If you find any errors, troubleshoot them before you continue this process.
15. Resume activity on node B that was suspended in step 10 by running the following command: `Resume-ClusterNode nodeB`.
16. Move the clustered service or application (a resource group) back to their preferred owner by running the following command: `Move-ClusterGroup <CusteredService> -Node <NodeName>`.

For more information, go to the following Microsoft websites:

- [Failover Cluster Cmdlets in Windows PowerShell](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee461009(v=technet.10))
- [Overview of Server Manager Commands](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732757(v=ws.11))
