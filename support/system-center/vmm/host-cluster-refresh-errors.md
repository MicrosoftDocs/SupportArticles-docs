---
title: Maintenance Mode causes refresh errors 13926 and 2606
description: When using System Center 2012 Virtual Machine Manager SP1 to put a cluster node into the Maintenance Mode, manual or system refreshes of the cluster fail with either error 13926 or 2606.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# System Center 2012 Virtual Machine Manager SP1 Maintenance Mode causes refresh errors 13926 and 2606

This article describes a behavior where manual or system refreshes of a cluster fail with either error 13926 or 2606 when you put the cluster node into Maintenance Mode.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2800073

## Symptoms

When using System Center 2012 Virtual Machine Manager Service Pack 1 (SP1) to put a cluster node into Maintenance Mode by right-clicking on the host and selecting **Start Maintenance Mode**, manual or system refreshes of the cluster fail with one of the following errors/warnings while the **Start Maintenance Mode** job is still running:

*Warning (13926)*  
*Host cluster \<name> was not fully refreshed because not all of the nodes could be contacted. Highly available storage and virtual network information reported for this cluster might be inaccurate.*  
*Recommended Action*  
*Ensure that all the nodes are online and do not have Not Responding status in Virtual Machine Manager. Then refresh the host cluster again.*  

*Error (2606)*  
*Unable to perform the job because one or more of the selected objects are locked by another job.*  

## Cause

The **Start Maintenance Mode** process locks the host that is being put into the Maintenance Mode, the cluster where the host is located, and all the virtual machines on the host. These objects remain locked while the **Start Maintenance Mode** job is running. Since these objects are locked, manual or system refreshes fail while the job is running.

## Resolution

This behavior is by design. Once the **Start Maintenance Mode** job is complete, both manual and the system refresh of the cluster should complete successfully.
