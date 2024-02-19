---
title: Cluster service reserves and brings online disks
description: Describes how the Microsoft Cluster service reserves and brings online disks that are managed by cluster service and related drivers.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
---
# How the Cluster service reserves a disk and brings a disk online

This article describes how the Microsoft Cluster service reserves and brings online disks that are managed by cluster service and related drivers.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 309186

## More information

The Cluster service only uses the SCSI protocol to manage disks on the shared bus.

> [!NOTE]
> This does not mean that all disks will be of type SCSI, specifying the hardware interface known as SCSI, but rather that the storage unit must be able to properly interpret and process the SCSI protocol and commands.

The following list of commands is the additional SCSI protocol features that will be used when disks are in a clustered environment.

- `reserve`: This command is issued by a host bus adapter to obtain or maintain ownership of a SCSI device. A device that is reserved refuses all commands from all other host bus adapters except the one that initially reserved it, the initiator.

- `release`: This command is issued by the owning host bus adapter when a disk resource is taken offline; it frees a SCSI device for another host bus adapter to reserve.

- `reset`: This command breaks the reservation on a target device. This command can either be a bus reset (for the entire bus) or, using the storport drivers a targeted reset for a particular device on the bus. The following procedure describes how a server cluster starts and gains control of the shared disks. This scenario assumes that only one node is being turned on at a time:

When the computer is started, the Cluster Disk Driver (Clusdisk.sys) reads the following local registry key to obtain a list of the signatures of the shared disks under cluster management: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClusDisk\Parameters \Signatures`  

After the list is obtained, the cluster service attempts to scan all of the devices on the shared SCSI bus to find matching disk signatures.

When the first node in the cluster starts, the cluster disk driver first marks all LUNs (LUN: logical unit number, a unique identifier used on a SCSI bus to distinguish between devices that share the same bus) matching the Signatures key as offline volumes. Note that this is not the same as taking a cluster resource offline. The volume is marked offline to prevent multiple nodes from having write access to the volumes simultaneously. If the cluster is a shared disk cluster, one of the disks is designated as quorum disk by the cluster service. Quorum disk is the first resource brought online when cluster service attempts to form a cluster.

When the cluster service on the forming node starts, it first tries to bring online the physical device designated as quorum disk. It executes the disk arbitration algorithm on the quorum disk to gain ownership. On successful arbitration, cluster service sends a request to clusdisk to start sending periodic reserves to the disk (to maintain ownership). Then cluster service sends a request to clusdisk to unblock access to the quorum disk and mounts the volumes on the disk. Successful mounting of the volume(s), completes the online procedure and the cluster service then continues with the cluster form process. The request is passed from the cluster disk driver to the Microsoft storage driver stack and finally to the driver specific to the HBA that communicates to the disks. It may also be passed to any multipath software running in the storage stack.

After the storage controller/device driver reports that the device has been successfully reserved, the cluster service ensures that the drive can be read from and written to. Once the disk has passed all of these tests, the disk resource is marked as online and the cluster service then continues to bring all other resources online.

Each node in the cluster renews reservations for any LUNs it owns every three seconds. If the nodes of a cluster lose network communication with each other (for example, if there is no communication over the private or public network), the nodes begin a process known as arbitration to determine ownership of the quorum disk. The node that wins ownership of the quorum disk resources in total communication loss between cluster node will remain functional. Any nodes that cannot communicate and cannot maintain or acquire ownership of the quorum disk will terminate the cluster service and any resources that node was hosting will be moved to another node in the cluster.

1. The node that currently owns the quorum disk is the defending node. The defender assumes that it is defending against any cluster nodes that it cannot communicate with and for which it did not receive a shutdown notification. The defender continually renews its reservation to the quorum by requesting a SCSI reserve be placed on the LUN every three seconds.

2. All other nodes (nodes that do not own the quorum disk and cannot communicate with the node that owns the quorum resource) become challenging nodes.

3. When the challenger detects the loss of all communications, it immediately requests a bus-wide SCSI reset to break any existing reservations.

4. Seven seconds after the SCSI reset requested, the challenger tries to reserve the quorum disk. If the defender node is online and functioning, it will have already reserved the quorum disk as it typically does every three seconds. The challenger detects that it cannot reserve the quorum, and terminates the cluster service. If the defender is not functioning properly, the challenger can successfully reserve the quorum disk. After ten seconds, the challenger brings the quorum online and takes ownership of all resources in the cluster. If the defending node loses ownership of the quorum device, then the cluster service on the defending node terminates immediately.

When a cluster node takes a disk resource offline, it requests that the SCSI reserve be released and then the drive will once again be unavailable to the operating system. Anytime a disk resource is offline in a cluster, the volume that the resource points to (the disk with the matching signature) will be inaccessible to the operating system on any of the cluster nodes.
