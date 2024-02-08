---
title: Failover behavior on clusters of three or more nodes
description: Describes the logic by which groups fail from one node to another when there are three or more cluster node members.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: stevemat, jeffwade, kaushika
ms.custom: sap:root-cause-of-an-unexpected-failover, csstroubleshoot
ms.subservice: high-availability
---
# Failover behavior on clusters of three or more nodes

This article documents the logic by which groups fail from one node to another when there are three or more cluster node members.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 299631

## Summary

The movement of a group can be caused by an administrator who manually moves a group or by a node or resource failure. Where the group moves depends on how the move is initiated and whether the Preferred Owner list is set.

## More information

Information about the Preferred Owner list is covered in the Help file under "Server Clusters," including information about planning and optimizing server clusters. This article documents the following four possible scenarios:

1. There's a node or resource failure and the Preferred Owner List is set.
2. There's a node or resource failure and the Preferred Owner List isn't set.
3. Administrator manually moves group to "Best Possible" and the Preferred Owner List is set.
4. Administrator manually moves group to "Best Possible" and the Preferred Owner List isn't set.

### Scenario 1

If a node or resource fails and the Preferred Owner List has been defined, the Cluster Service fails the Group to the next available node in the Node List. The Node List is composed of the Preferred Owners List followed by the remaining nodes arranged by their Node ID. The Node ID is defined when a node is joined to a cluster or if a node is evicted or and re-added.

You can view the Node ID order by examining the registry under the \HKEY_LOCAL_MACHINE\Cluster\Nodes key.

For example, suppose we have a six node Cluster and that the nodes were installed and joined the Cluster in the following order: NodeA, NodeB, NodeC, NodeD, NodeE, and NodeF. Assume that a Group has NodeA, NodeC, and NodeE listed as the Preferred Owners.

Having this information, the Node List for the Group would then be the following:

1. NodeA - Preferred Owner number one
2. NodeC - Preferred Owner number two
3. NodeE - Preferred Owner number three
4. NodeB - Second installed Node
5. NodeD - Fourth installed Node
6. NodeF - Sixth installed Node

In this scenario, if a Node failure or a failure of a resource was to occur and its restart threshold were hit, the whole Group would fail to the next node down in the Node List. For example, if NodeC contained the resource that failed, the whole Group would fail to NodeE. It wouldn't fail to NodeA even though it's listed first in Preferred Owner List. If NodeE fails, the Group would fail over to NodeB and not to NodeA.

### Scenario 2A

If a resource fails and the Preferred Owner List isn't set, the Group follows a Node List much like it did in Scenario 1. The Node List is built only from the Node ID. Upon a node or resource failure, resources follow a downward path failing to the subsequent node in the Node List. When it reaches the last listed node in the Node List, it starts with the first node in the Node List.  

1. NodeA - First installed Node

2. NodeC - Second installed Node
3. NodeE - Third installed Node

4. NodeB - Fourth installed Node
5. NodeD - Fifth installed Node
6. NodeF - Sixth installed Node

For example, this list has the installation order of the different Cluster nodes. If NodeE were to fail, all groups that it owned would fail over to NodeB and not to NodeF.

### Scenario 2B

If a node fails and the Preferred Owner List isn't set for a group on that node, then an available node will be selected randomly for the group to be moved to. This will distribute the groups among the available nodes.

### Scenario 3

If a Cluster administrator manually chooses **Move group** and selects **Best Possible** and the Preferred Owner List is configured, the Group will always start at the top of the Node List. As in Scenario 1, the Node List is composed of the Preferred Owner List and the installation order.  

1. NodeA - Preferred Owner number one
2. NodeC - Preferred Owner number two
3. NodeE - Preferred Owner number three
4. NodeB - Second installed Node
5. NodeD - Fourth installed Node
6. NodeF - Sixth installed Node  

In this example, when **Best Possible** is selected, the Group always tries to move to NodeA. If the Group is already on NodeA or NodeA isn't available, the Group tries to move to NodeC. If a Group is on NodeD and the Administrator chooses to move it to **Best Possible**, the Group goes to NodeA. If NodeA, NodeC, or NodeE aren't active, either NodeB or NodeF is randomly chosen.

### Scenario 4

If as Cluster administrator, you manually choose **Move group** and you select **Best Possible** and the Preferred Owner List isn't configured, an active node is chosen randomly to host the group. Without the Preferred Owner List configured, it's possible that a Group may move to a Node that is already running several other Groups.

We recommend that you configure the Preferred Owner list on a large node cluster if the load between nodes is significantly different or if the nodes aren't homogeneous.

> [!NOTE]
> The exception to the failover behavior that is mentioned here is with the default Group that holds the Quorum resource that is named the Cluster Group. The Cluster Group does not follow the typical Preferred Owner list behavior. Instead, if the owner of the Quorum resource fails, the new owner will be the previous group that successfully owned the Quorum resource.

The AntiAffinityClassNames public property can also affect where a Group will fail over to.
