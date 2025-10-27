---
title: CSV Goes Offline after a Node or Storage Component Goes Offline During Active I/O
description: Discusses a change in Cluster Shared Volume behavior where the CSV goes offline in a situation where it's at risk of hanging.
ms.date: 10/31/2025
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.custom:
- sap:clustering and high availability\cluster shared volume (csv)
- pcy:WinComm Storage High Avail
ms.reviewer: kaushika, v-mikiwu, v-appelgatet
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Windows Server 2025</a>
---
# Cluster Shared Volume goes offline after a node or storage component goes offline during active I/O

This article describes a situation where the Cluster Shared Volume (CSV) of a cluster might go offline after other components go offline. The article includes steps for resolving the issue and, if needed, recovering any affected virtual machines.

## Symptoms

This issue starts under the following circumstances:

1. A cluster node or storage component becomes unavailable, but I/O operations continue. For example, a disk array has failed or requires maintenance.
1. As I/O operations continue, metadata records accumulate.
1. When the metadata records reach their allocated limits, I/O operations fail.
1. The associated CSV enters a Failed state.
1. Every 15 minutes (the default setting), the cluster tries to bring the CSV online. If the Virtual Machine Management Service (VMMS) manages virtual machines on the cluster, VMMS periodically tries to start the virtual machines.
1. After 30 minutes, VMMS stops trying to start the virtual machines. Any virtual machines that use the affected CSV can't automatically recover.

## Cause

A recent change in cluster behavior affects how the CSV responds in the situation that's described in the Symptoms section. Previously, when metadata records accumulated to the allocated limits, I/O operations could hang indefinitely. Because of the change, I/O operations fail in this situation instead of hanging. The I/O failure in turn causes the CSV to go offline and enter a Failed state.

## Recovery

You can use one of two methods to recover the cluster. The method to use depends on whether you can restore the previous cluster components, or you have to replace parts of the cluster.

### Method 1: Restore the offline component and automatically repair the cluster

After you restore the offline node or storage, the following steps occur automatically.

1. The next time that the cluster automatically tries to bring the CSV online, it succeeds.
1. Automatic repair processes start, and then the volume becomes available.

> [!IMPORTANT]  
> After the cluster recovers, you might have to manually start any VMMS-managed virtual machines that use the cluster. After the cluster is down for 30 minutes, VMMS stops automatically trying to restart the virtual machines.

### Method 2: Replace the offline component and manually recover the cluster

If you can't restore the missing node or storage, follow these steps to manually recover the cluster.

> [!IMPORTANT]  
> This process temporarily takes all volumes in the pool offline.

Run the following steps as a cluster administrator on a node that has full access to the storage pool.

1. Identify the clustered storage pool.
1. Gather Cluster Virtual Disks and CSVs; identify those that are failed.
1. If available, load previously saved disk/CSV info from file; otherwise, gather and save the info for recovery continuity.
1. Add unpooled disks from the new node to the storage pool (if needed).
1. Retire unhealthy disks on the failed node.
1. Wait for virtual disks with `OperationalStatus = InService` to clear.
1. Move the storage pool resource to the current node.
1. Move failed disk and CSV resources to the current node.
1. Remove all Cluster Virtual Disks and CSVs from cluster management.
1. Remove the storage pool from cluster management.
1. Set the cluster storage pool `-IsReadOnly $false`.
1. Set `IsManualAttach $false` for each virtual disk.
1. Wait for storage jobs related to repair to start (>0% complete).
1. Add the storage pool back to cluster management.
1. Add all non-failed virtual disks back to cluster management and convert them to CSVs if previously configured.
1. Wait for all virtual disks with `OperationalStatus = InService` to clear.
1. Set all virtual disks online and read/write if needed.
1. Verify retired physical disks still showing a virtual disk footprint > 0.
1. Wait for the footprint to reduce.
1. Add the originally failed virtual disks back to cluster management and convert them to CSVs if previously configured.
1. Clean up temporary files used during recovery.

### VMMS Recovery Behavior

Virtual Machine Management Service (VMMS) retries bringing VMs online for 30 minutes.

After this window, VMMS stops retrying, and affected VMs remain in a Failed state.

After the storage volume is successfully recovered, manually start the VMs.

## Status

This behavior is by design in Windows Server 2025. It's intended to prevent indefinite I/O hangs.
