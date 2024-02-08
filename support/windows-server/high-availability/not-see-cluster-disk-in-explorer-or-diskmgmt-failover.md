---
title: You do not see the cluster disk in explorer or diskmgmt on Failover in a Windows 2008 or Windows 2008 R2 Cluster
description: Provides a resolution to an issue where cluster disk cannot be found in explorer or diskmgmt on failover.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:errors-when-running-the-validation-wizard, csstroubleshoot
---
# You do not see the cluster disk in explorer or diskmgmt on Failover in a Windows 2008 or Windows 2008 R2 Cluster

This article provides a resolution to an issue where cluster disk cannot be found in explorer or diskmgmt on Failover.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2517921

## Symptoms

The file share resource failover from Node A to Node B and the file share disk (example N:) doesn't show up in the explorer or disk management console. We see the following events as the drive letter got swapped during failover and the file share resource won't come online even if the dependencies of the files share (that is disk and IP) were online.

> Log Name: System  
Source: Microsoft-Windows-FailoverClustering  
Event ID: 1588  
Task Category: File Server Resource  
Level: Error  
User: SYSTEM  
Description:  
Cluster file server resource 'AdminData' cannot be brought online. The resource failed to create file share 'NAMEOF FILESHARE RESOURCE$' associated with network name 'NAMEOF FILESHARE RESOURCE'. The error code was '3'. Verify that the folders exist and are accessible. Additionally, confirm the state of the Server service on this cluster node using Server Manager and look for other related events on this cluster node. It may be necessary to restart the network name resource 'NAMEOF FILESHARE RESOURCE' in this clustered service or application.

We also see:

> Log Name: System  
Source: Microsoft-Windows-Kernel-Tm  
Event ID: 1  
Task Category: None  
Level: Information  
Keywords: None  
User: SYSTEM  
Description:  
The Transaction (UOW=%1, Description='%3') was unable to be committed, and instead rolled back; it was due to an error message returned by CLFS while attempting to write a Prepare or Commit record for the Transaction. The CLFS error returned was: %4.

> Log Name: System  
Source: Microsoft-Windows-UserPnp  
Event ID: 20010  
Task Category: (7010)  
Level: Information  
User: SYSTEM  
Computer:  
Description:  
One or more of the Plug and Play service's subsystems has changed state.  
PlugPlay install subsystem enabled: 'true'  
PlugPlay caching subsystem enabled: 'true'

## Cause

This event happens if you have a network drive mapped on the Node B with the same drive letter (that is N:) which was assigned to the cluster disk on the Active node.

It happens if you have the Mapped network drive assigned with the same drive letter, which was held by cluster disk resource on the active node or on the node before failover. If there is the local hard disk with same drive letter, then this issue doesn't happen as the part manager assign the same drive letter by swapping it.

## Resolution

You will be able to see the disk with drive letter N: on Node B in explorer and disk management, once you disconnect the mapped network drive. Even if you don't disconnect the network drive the drive letter would be still accessible with share and also viewable with same drive letter N: under failover cluster MMC.

## References

[Failover Cluster Step-by-Step Guide: Configuring a Two-Node File Server Failover Cluster](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731844(v=ws.10))
