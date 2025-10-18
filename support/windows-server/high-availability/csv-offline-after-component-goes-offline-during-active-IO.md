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

A change in cluster behavior causes I/O operations to fail when metadata limits are reached, instead of hanging indefinitely. This prevents stuck I/O conditions but can cause Cluster Shared Volumes (CSV) to enter a Failed state if a node or storage component goes offline during active I/O.

The cluster remains functional and retries to bring the CSV online every 15 minutes. However, Virtual Machines (VMs) managed by Virtual Machine Management Service (VMMS) stop retrying after 30 minutes and must be manually started after storage recovery.

Applies to
Windows Server 2025 Failover Clustering
Cluster Shared Volumes (CSV)
Storage Spaces Direct (S2D)

## Symptoms

When a cluster node or storage component becomes unavailable while I/O continues:

- I/O operations fail once metadata record limits are reached.
- The associated CSV enters a Failed state.
- The cluster periodically retries to bring the volume online (every 15 minutes by default).
- Virtual Machines using the affected volume do not automatically recover after 30 minutes.

## Cause

This behavior occurs because metadata records are reserved for repair operations.

When these records are exhausted during a node loss event, I/O operations fail and the CSV is temporarily taken offline to prevent indefinite hangs.

## Resolution

Recovery depends on how the missing storage is restored.

### Scenario 1 - Returning Missing Storage (Automatic Recovery)

If the offline node or missing storage is restored:

1. The cluster automatically retries to bring the CSV online (every 15 minutes by default).
1. Once the storage is back, the volume comes online automatically.
1. Repair starts and the volume becomes available.

No manual steps are required.

### Scenario 2 - Adding New Storage (Manual Recovery)

If the missing storage cannot be restored and new storage is added, manual recovery steps are required to bring failed virtual disks and CSVs back online.

> [!IMPORTANT]  
> This process will temporarily take all volumes in the pool offline.
Run the following steps as a cluster administrator on a node with full access to the storage pool.

#### Manual Recovery Steps

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

This is the intended behavior change in Windows Server 2025 to prevent indefinite I/O hangs.

A PowerShell helper script is planned to simplify Scenario 2 recovery steps and may be included in future releases or documented separately.
