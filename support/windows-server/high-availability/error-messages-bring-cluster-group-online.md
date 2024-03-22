---
title: Error messages when a cluster group online
description: Describes how to resolve the error messages when you try to bring a cluster group online after a cluster stops.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Clustering and High Availability\Cannot bring a resource online, csstroubleshoot
---
# Error messages occur if you try to bring a cluster group online after a cluster stops

This article describes how to resolve the error messages when you try to bring a cluster group online after a cluster stops.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 313882

## Symptoms

After you manually turn off a cluster, or after a cluster fails, a group and all of its resources may fail over if the cluster suffers a loss of a node. However, the group may also go into an offline state. If you try to bring either the group or the resource online, you may receive the following error message:  
>An error occurred attempting to bring the '**GroupName**' group online:
>
> The cluster node is not the owner of the resource.
>
>Error ID: 5015 (00001397).  

If you try to bring an individual resource in the group online, you may receive either of the following error messages:  
>An error occurred attempting to bring the '**ResourceName**' resource online:
>
>The cluster resource cannot be brought online. The owner node cannot run this resource.
>
>Error ID: 5071 (000013df).  

-or-
>No possible owners are specified for this resource. This means that this resource cannot be brought online on any node in the cluster.

## Cause

If you use the Move Group functionality to manually move a group from one node to another, or if the cluster fails, a Possible Owners list is built for the entire group and for all of the resources in the group. The behavior that is described in the "Summary" section of this article can occur if one of the resources in the group that does not come online does not have an online node listed in the Possible Owners list.

## Resolution

To work around this behavior, bring the node that was taken offline back online. Move the group back to the node that you just brought online, and then check the Possible Owners list of each resource to verify that the node on which the group did not come online is listed.

If you can't bring the node online because the node truly failed, add the proper node to the Possible Owners list:

1. In Cluster Administrator, open the General properties of each resource and review the Possible Owners list.

    After you find the resource that has a blank Possible Owners list and a dimmed Modify button, note the name of this resource
2. Open a command prompt, and type the following command. **name of resource** is the name of the resource that you noted in step 1:

    cluster res **name of resource** /listowners  
A list of possible owners of the resource is displayed. This list indicates that the only possible owner is the node that is down.
3. From the command prompt, run the following command to add the other node to the Possible Owners list, where **missing node** is the node that is down:  
    cluster res **name of resource** /addowner: **missing node**  

4. In Cluster Administrator, bring the group that was previously in the offline state online again.  

> [!NOTE]
> After the group comes online, if you have problems reviewing the resources in Cluster Administrator, quit Cluster Administrator, and then reconnect to the cluster.

## Status

This behavior is by design.  

## More information

The Possible Owners list isn't useful on a cluster that has fewer than three nodes. The Cluster service builds a list of possible owners for a group. The location on which the group that contains that resource is hosted is affected if you change the Possible Owners list for a resource. Internally, an ordered list is maintained for the location on which the group is hosted. If you remove a possible owner for a resource, you remove that node from the Possible Owners list.
