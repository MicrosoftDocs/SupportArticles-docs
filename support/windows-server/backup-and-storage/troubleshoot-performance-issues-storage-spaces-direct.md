---
title: Troubleshoot Performance Issues in Storage Spaces Direct
description: Helps you identify and fix performance issues related to Storage Spaces Direct (S2D) in Windows Server environments.
ms.date: 12/08/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-appelgatet
ms.custom:
- sap:backup, recovery, disk, and storage\Storage Spaces Direct (S2D)
- pcy:WinComm Storage High Avail
appliesto:
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Troubleshoot performance issues in Storage Spaces Direct

This article helps you identify and fix performance issues related to Storage Spaces Direct (S2D) in Windows Server environments.

## Symptoms

You might notice the following symptoms of performance issues:

- When you access files that're stored in storage spaces, read or write speeds are slower than expected.
- When you perform disk-intensive operations such as transferring large files, you experience delays or lags.
- Task Manager shows high disk queue length or high disk usage.
- Applications take longer than usual to load or respond.

## Causes

Several factors can lead to performance issues for Storage Spaces. The following list includes the most common causes:

- **Incorrect drive configuration**: Using mismatched or incompatible drives within a storage pool can degrade performance.
- **Incorrect storage space type**: Selecting the wrong resiliency option (such as parity instead of simple or mirror) for the workload.
- **Insufficient system resources**: Low memory or CPU availability, which can bottleneck performance.
- **Fragmentation**: Excessive fragmentation within the storage pool can slow down data access.
- **Firmware and driver issues**: Outdated or incompatible drive firmware and drivers.
- **Background tasks**: Resource-intensive background tasks, such as disk scrubbing or repair jobs.

## Resolution

Follow the steps in this section to improve the performance of your storage space.

Before you start troubleshooting performance issues, consider measuring the system's current performance to establish a baseline. You can use tools such as Performance Monitor or Resource Monitor to collect metrics. You can also use third-party tools such as DiskSpd or CrystalDiskMark to run benchmark tests and gather detailed performance metrics.

> [!IMPORTANT]  
> Before you start changing your storage space configuration, make sure that all the storage space's data and configuration settings are backed up.

### Step 1: Collect performance metrics, events, and configuration information

To assist in troubleshooting, collect the following data:

- A detailed description of the storage space configuration, including the resiliency type and drive details.
  - What type of storage space configuration is being used? For example, simple, mirror, or parity?
  - What is the size of the storage pool, and how many drives are included?
  - What is the current firmware and driver version for the drives in the storage pool?
  - Are all drives in the pool of the same type, capacity, and speed?
  - Have there been any recent changes to the system, such as software updates, hardware replacements, or new applications installed?
  - Information about recent system updates or changes.

- Performance metrics, such as disk queue length and throughput. You can use tools such as Performance Monitor or Task Manager to collect this information. You can also review performance history information, as described in [Performance history for Storage Spaces Direct](/windows-server/storage/storage-spaces/performance-history).
- Logs from the Event Viewer, specifically under the **System** and **Storage Spaces** categories.
  - Are there any error messages or warnings in the Event Viewer related to S2D, storage pools, or disk operations?
  - Screenshots or photos of any error messages or alerts.

- The output of the following Windows PowerShell commands:

   ```powershell
  Get-StoragePool | Get-PhysicalDisk | Select-Object DeviceID, MediaType, Size, HealthStatus
  Get-VirtualDisk | Select-Object FriendlyName, ResiliencySettingName, OperationalStatus
  Get-StoragePool | Get-StorageSubSystem | Select-Object FriendlyName, HealthStatus
  ```

### Step 2: Verify the Storage Space configuration

1. Make sure that all the drives in the pool are of the same type (for example, all SSDs or all HDDs) and have similar performance characteristics.
1. Check that the storage space type (simple, mirror, or parity) is appropriate for the workload. For more information about storage space types in S2D, see [Deep Dive: Volumes in Storage Spaces Direct](https://techcommunity.microsoft.com/blog/filecab/deep-dive-volumes-in-storage-spaces-direct/425807).
1. If you make any changes during this step, test the system's performance and compare it to earlier measurements.

### Step 3: Review the Server Manager and the event logs for potential issues

1. In Server Manager (or by using Windows PowerShell) check the health and operational states of the storage pools and other S2D components. For more information, see [Troubleshoot Storage Spaces and Storage Spaces Direct health and operational states](/windows-server/storage/storage-spaces/storage-spaces-states).
1. In Event Viewer, review the logs for Storage Spaces Direct warnings or errors.
1. If you identify any issues (such as failing drives or subsystem errors), address and remediate them as appropriate.
1. If you make any changes during this step, test the system's performance and compare it to earlier measurements.

### Step 4: Make sure that the drivers and firmware for the drives are up to date

1. Verify that all drives have the latest firmware installed.
1. Update the storage controller and drive drivers to the most recent versions that the manufacturer supports.
1. If you make any changes during this step, test the system's performance and compare it to earlier measurements.

### Step 5: Run storage maintenance tasks

1. To optimize the storage pool, run the following cmdlet at a powerShell command prompt:

   ```powershell
   Optimize-StoragePool -FriendlyName <StoragePoolName>
   ```

   > [!NOTE]  
   > In this cmdlet, /<StoragePoolName> is the name of the storage pool. If you need to identify the storage pool name, run `Get-StoragePool`.

1. If the storage pool uses HDD drives, manually defragment the drives.

   > [!WARNING]  
   > Don't use this step if the storage pool uses SSD drives. Defragmentation can reduce lifespan and performance of the drives.

1. Test the system's performance and compare it to earlier measurements.

### Step 6: Identify resource usage issues

1. Use monitoring tools such as Task Manager, Performance Monitor, or Resource Monitor to identify bottlenecks in CPU, memory, or disk usage. For more information about using these tools, see [Scenario guide: Troubleshoot performance problems in Windows](../performance/troubleshoot-performance-problems-in-windows.md).
1. Close any unnecessary applications or processes that consume system resources.
1. If you make any changes during this step, test the system's performance and compare it to earlier measurements.

### Step 7: Rebuild or recreate the storage space

If you followed the earlier steps and the S2D performance hasn't improved sufficiently, consider rebuilding the storage space. Follow these steps:

1. Make sure that all backups are current and available.
1. Delete the existing storage space.
1. Recreate the storage space. Use optimal settings.
1. Restore the data to the new storage space.

## Preventing future performance issues

To avoid future S2D performance issues, consider these guidelines and best practices:

- Make sure that a single storage pool uses drives that have similar performance, capacity, and media type. For more information about hardware requirements, see [Storage Spaces Direct hardware requirements in Windows Server](/windows-server/storage/storage-spaces/storage-spaces-direct-hardware-requirements).
- Regularly update firmware and drivers to the latest manufacturer-recommended versions.
- Monitor storage pool health using the `Get-StoragePool` and `Get-PhysicalDisk` cmdlets.
- To prevent data loss if a drive fails, schedule regular backups.
- Unless you're implementing tiered storage, don't mix SSD and HDD drives in the same storage pool.
