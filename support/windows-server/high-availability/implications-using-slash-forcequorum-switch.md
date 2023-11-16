---
title: Implications of using /forcequorum switch
description: Describes the implications of starting the Cluster service by using the /forcequorum switch in Windows Server 2008. Discusses server clusters that are configured to use a majority node set quorum model.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, ctimon
ms.custom: sap:initial-cluster-creation-or-adding-node, csstroubleshoot
ms.technology: windows-server-high-availability
---
# The implications of using the /forcequorum switch to start the Cluster service in Windows Server 2008

This article discusses the implications of starting the Cluster service by using the /forcequorum switch

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 947713

## Beta Information

This article discusses a beta release of a Microsoft product. The information in this article is provided as-is and is subject to change without notice.

No formal product support is available from Microsoft for this beta product. For information about how to obtain support for a beta release, see the documentation that is included with the beta product files, or check the Web location where you downloaded the release.  

## Introduction

In Windows Server 2003, server clusters that are configured to use a majority node set (MNS) quorum model can force the Cluster service to start when less than the required minimum number of cluster nodes are participating in the cluster. The following formula is used to determine the minimum number of cluster nodes that are required:  
(\<Total configured cluster nodes>/2) + 1

For example, a 4-node MNS cluster requires a minimum of three nodes to be considered functional ((4/2) + 1 = 3).

To start the Cluster service by using the MNS quorum model method, use the **ForceQuorum** registry key, or use a startup parameter, such as the /forcequorum switch.

> [!NOTE]
> The **ForceQuorum** registry key is located under the following registry subkey:  
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClusSvc\Parameters`

There are special procedures that are required to correctly recover after you use the /forcequorum switch. This article discusses the implications of using the /forcequorum switch to start the Cluster service in Windows Server 2008. In Windows Server 2008-based failover clusters, starting the Cluster service together with a /forcequorum switch has more implications than it did in earlier operating systems.

## More information

In Windows Server 2008-based failover clusters, the cluster configuration information is tracked across all nodes in the cluster and on a witness disk, if one is configured. A Paxos tagging process is used to guarantee consistency of the cluster configuration across all nodes and on the witness disk. The Paxos algorithm is used for guaranteeing consistency across distributed systems. The algorithm is used by the Cluster service to guarantee data consistency when updates to the cluster configuration are propagated across all nodes in the cluster.

In Windows Server 2008-based failover clusters, the Paxos tag consists of three numbers. Each number is separated by a colon. For example, a tag may resemble the following:  
3:3:276  
These numbers represent the NextEpoch number, the LastUpdateEpoch number, and the sequence number. Ideally, the Paxos tag should be the same across all replicas of the cluster configuration. The Epoch numbers are changed every time that the cluster is formed. The sequence number is changed every time that an update is made to the cluster configuration. The synchronization process in a cluster sends out a proposal to all the nodes in the cluster. The proposal consists of a sequence number and a proposal number. A cluster node checks its local copy of the cluster configuration to see whether it has a newer sequence number or a higher proposal number. If the node does not have more current information (higher numbers), the node sends an acceptance back to the proposing node. If most of the nodes in the cluster (a "consensus") send back an acceptance to the proposing node, the data is sent to each cluster node to be incorporated locally.

When a cluster node joins a cluster, the node sends its Paxos tag information as part of the joining process. If the Paxos tag information for the joining node is older than the current cluster configuration, a complete copy of the cluster configuration is pushed to the node as part of the joining process. This copy of the cluster configuration is known as a cluster registry hive. This behavior guarantees that all nodes that are joining a cluster have the most up-to-date configuration information.

The Paxos tag format in a cluster can change only in the following two scenarios:

- When an authoritative restore of the cluster configuration is executed.
- When the Cluster service is started by using the /forcequorum switch. The shorthand for the switch is /fq.

The new Paxos tag formatting uses time stamps. The following is an example of the new formatting:  
2007/12/31-15`35`55.889_4:2007/12/31-15`35`55.889_4:294

This format guarantees that the nodes that run the Cluster service together with this Paxos tag format will have the golden or authoritative copy of the cluster configuration. Any node that joins the cluster will automatically have this copy of the cluster configuration pushed to it during the joining process. Therefore, when you decide to force the Cluster service to start on a specific node in a Windows Server 2008-based failover cluster, it is important to select the node that has the most up-to-date cluster configuration information. Otherwise, some configuration settings may be lost.

## References

For more information about the MNS quorum model, visit the following Microsoft Web site: [https://technet.microsoft.com/library/cc784005(WS.10).aspx](https://technet.microsoft.com/library/cc784005%28ws.10%29.aspx)

For more information about the Paxos algorithm, visit the following Microsoft Web site: [https://research.microsoft.com/users/lamport/pubs/paxos-simple.pdf](https://research.microsoft.com/users/lamport/pubs/paxos-simple.pdf)
