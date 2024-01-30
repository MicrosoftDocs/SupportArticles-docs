---
title: Unable to access ClusterStorage folder
description: Describes an issue where you can't access a CSV volume from a passive (non-coordinator) node and receive event ID 5120 or 5142.
ms.date: 11/18/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:partition-and-volume-management, csstroubleshoot
ms.subservice: backup-and-storage
---
# Unable to access ClusterStorage folder on a passive node in a server cluster

This article describes an issue where you can't access a CSV volume from a passive (non-coordinator) node and receive event ID 5120 or 5142.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2008795

## Symptoms

On a Windows Server cluster with Cluster Shared Volume(CSV) feature enabled, a user may be unable to access a CSV volume from a passive (non-coordinator) node. When clicking on a CSV volume, explorer may hang. One or all of the following events may be displayed:
> Event ID: 5120  
Source: Microsoft-Windows-FailoverCluster  
Level: Error  
Description: Cluster Shared Volume "volume_name" is no longer available on this node because of "STATUS_BAD_NETWORK_PATH(c00000be)'. All I/O will temporarily be queued until a path to the volume is re-established.  

> Event ID: 5120  
Source: Microsoft-Windows-FailoverCluster  
Level: Error  
Description: Cluster Shared Volume "volume_name" is no longer available on this node because of 'STATUS_CONNECTION_DISCONNECTED(c000020c)'. All I/O will temporarily be queued until a path to the volume is reestablished.  

> Event ID: 5120  
Source: Microsoft-Windows-FailoverCluster  
Level: Error  
Description: Cluster Shared Volume "volume_name" is no longer available on this node because of 'STATUS_MEDIA_WRITE_PROTECTED(c00000a2)'. All I/O will temporarily be queued until a path to the volume is reestablished.  

> Event ID generated: 5142  
Source: Microsoft-Windows-FailoverCluster  
Description: Cluster Shared Volume "volume_name" ('Cluster Disk #') is no longer accessible from this cluster node because of error 'ERROR_TIMEOUT(1460)'. Please troubleshoot this node's connectivity to the storage device and network connectivity.  

## Cause

When accessing a CSV volume from a passive (non-coordinator) node, the disk I/O to the owning (coordinator) node is routed through a 'preferred' network adapter and requires SMB be enabled on that network adapter. For SMB connections to work on these network adapters, the following protocols must be enabled:

- Client for Microsoft Networks
- File and Printer Sharing for Microsoft Networks

## Resolution

Review each cluster node and verify the following protocols are enabled the network adapters available for Cluster use:

- Client for Microsoft Networks
- File and Printer Sharing for Microsoft Networks

1. Click **Start**, click **Run**, type *ncpa.cpl*, and then click **OK**.
2. Right-click the local area connection that is associated with the network adapter, and then click **Properties**.
3. Verify that the above protocols appear in the **This connection uses the following items** box.  If either is missing, follow these steps:
    1. Click **Install**, click **Client**, and then click **Add**.
    2. Select the missing protocol, click **OK**, and then click **Yes**.  
4. Verify that the check box that appears next to **Client for Microsoft Networks** is selected.

## More information

The Event ID 5120 mentioned above will be logged anytime that there's a problem connecting over the network using SMB to the owning node. If the connection is restored within a few minutes, then there may be no ill effects other than slowness of the VMs because of lack of I/O completing.

The meaning of the event codes listed above are as follows:

- 'STATUS_BAD_NETWORK_PATH(c00000be)' - This error code means that the network path to the SMB2 share that is created by the node that is currently listed as the owner for the CSV can't be located.
- 'STATUS_CONNECTION_DISCONNECTED(c000020c)' - This error code means that a node has lost access to the SMB2 share that is created by the node that is currently listed as the owner for the CSV.
- 'STATUS_MEDIA_WRITE_PROTECTED(c00000a2)' - This error code means that can't write to the volume. Usually this indicates that we've lost the reservation on the disk and we no longer have direct I/O with the disk.

The Event ID 5142 indicates that the non-owning node is disconnected and CSV is no longer queuing the I/O. As a result, the VMs on the node logging the errors will see the storage as disconnected instead of slow in responding.

The preferred network is the network with the lowest cluster network metric value. If the preferred network is unavailable (due to problems or reconfiguration), then the cluster network fault tolerance will cause the network with the next lowest metric to be used.  If that network isn't configured to allow SMB connection, then the above error will be encountered.

The recommendation is for any network that the cluster might use (any network not disabled for cluster use) should be configured as shown above to allow CSV use.

Reference Articles:

[Hyper-V: Using Live Migration with Cluster Shared Volumes in Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd446679(v=ws.10))

[Cluster Shared Volumes Support for Hyper-V](https://technet.microsoft.com/library/dd630633%28WS.10%29.aspx)
