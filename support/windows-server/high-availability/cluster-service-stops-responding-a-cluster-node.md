---
title: Cluster Service Stops Responding
description: Provides a resolution for the issue that Cluster Service stops responding on a Cluster Node when you restart the Active Node.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:cluster-service-fails-to-start, csstroubleshoot
---
# Cluster Service Stops Responding on a Cluster Node When You Restart the Active Node

This article provides a resolution for the issue that Cluster Service stops responding on a Cluster Node when you restart the Active Node.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 822050

## Symptoms

When you restart the active node of a server cluster that consists of two or more nodes, you experience all the following symptoms:  

- If you are running Cluster Administrator on the remaining nodes, you receive the following error message when you try to connect to the cluster:  
    >Cluster '**ClusterName**' is no longer available.

- If you try to start Cluster Administrator, Cluster Administrator stops responding, and you may receive the following error message:  
    >An error occurred trying to open the cluster at '**ServerName**':
    >
    >The interface is unknown.
    >
    >Error ID: 1717 (000006b5).

- When you view the contents of **C:\Winnt\\** Cluster.log, you see information similar to:  

    >[FM] OnlineGroup: Failed on resource e3f4af72-6454-4199-b9af-fa6f57032a65. Status 70  
    Microsoft Clustering Service suffered an unexpected fatal error  
    at line 701 of source module D:\nt\private\cluster\service\fm\group.c. The error code was 70.  

- When the restarted cluster node starts successfully, the Cluster Administrator program that is running on the other nodes responds as you expect.

## Cause

This issue occurs if you pause one node of a server cluster and then you restart the active cluster node. When the active node restarts, the paused node tries to bring resource groups online. Because this node is paused, the node cannot make additional connections, and it cannot bring the Quorum disk group online. Error code 70 corresponds to the following error message:  
>The remote server has been paused or is in the process of being started.

> [!NOTE]
> These results will also occur in clusters that have more than two nodes. Even though a non-paused node exists in a working state when the active node is restarted, if the paused node is the first node that is contacted to take ownership of the quorum disk. The non-paused node does not have the opportunity to arbitrate for the quorum disk.

## Resolution

To resolve this issue, resume the paused cluster node before you restart the active cluster node.

> [!NOTE]
> Before you resume a paused cluster node, you must first determine if a cluster node is paused.  

1. Click **Start**, click **Run**, type cmd in the **Open** box, and then click **OK**.
2. At the command prompt, type cluster node, and then press ENTER. Output is similar to:

    > [!NOTE]
    > The following sample output is based on a two-node cluster configuration. If you have more than two nodes, the additional nodes will also appear in the list.  

    >Node &emsp;&emsp;&emsp;Node ID&emsp; Status  
    >\-------------- --------- ---------------------  
    >CLUSTER-1 &emsp;&emsp;&emsp;1 &emsp;&emsp;Paused  
    >CLUSTER-2 &emsp;&emsp;&emsp;2&emsp;&emsp; Up  

    > [!NOTE]
    > If the only cluster node that is not paused is in the process of restarting, you receive the following error message:  
    System error 1753 has occurred.
    There are no more endpoints available from the endpoint mapper.

3. At the command prompt, type cluster node **node_name** /resume (where **node_name** is the name of the cluster node) and then press ENTER.

    For example, type cluster node **cluster-1** /resume, and then press ENTER. Information appears that is similar to:

    >Resuming node 'cluster-1'...
    >
    >Node &emsp;&emsp;&emsp;&emsp;Node ID &emsp;&emsp;Status  
    >\-------------- &emsp;--------- &emsp;&emsp;---------------------  
    >CLUSTER-1 &emsp;&emsp;&emsp;&emsp;1 &emsp;&emsp;&emsp;Up
