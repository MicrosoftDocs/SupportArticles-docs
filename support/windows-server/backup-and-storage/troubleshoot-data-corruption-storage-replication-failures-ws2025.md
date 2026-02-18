---
title: Troubleshoot Data Corruption and Storage Replication Failures in Windows Server 2025
description: Discusses how to identify, troubleshoot, and resolve issues that relate to data corruption, disk errors, and storage replication failures in Windows Server 2025.
ms.date: 02/12/2026
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw
ai.usage: ai-assisted
ms.custom:
- sap:backup,recovery,disk,and storage\data corruption and disk errors
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Troubleshoot data corruption and storage replication failures in Windows Server 2025

This article discusses how to identify, troubleshoot, and resolve issues that relate to data corruption, disk errors, and storage replication failures in Windows Server 2025. These issues can affect storage performance, data integrity, and replication reliability in your environment.

## Symptoms

You might experience one or more of the following symptoms in Windows Server 2025:

- The event logs list disk, storage, and replication-related errors. These errors might include the following events:
  - Event ID 7 (device error)
  - Event ID 11 (controller error)
  - Event ID 153 (disk timeout)
  - Event ID 1112 (Storage Replica replication error)

- Files or databases appear to be corrupted, or application storage appears to be corrupted.
- Storage Replica experiences replication failures.
- Storage monitoring tools generate warnings or alerts that indicate degraded performance or reliability.

## Cause

The following factors can cause these issues:

- Physical disk failures, such as bad sectors or mechanical defects
- Data corruption within the storage subsystem
- Underlying storage hardware issues that interfere with replication processes
- Misconfigured storage replication settings, such as inadequate log sizes or incorrect replication mode
- Disk configuration issues that reduce system resilience

## Resolution

> [!IMPORTANT]  
> Before you start troubleshooting storage issues, make sure that you have current backups of all critical data.

To resolve data corruption and storage replication failures in Windows Server 2025, follow these steps.

1. To inspect hardware for failing disks, open a Windows PowerShell command prompt, and then run the following cmdlets:

   ```powershell
   Get-PhysicalDisk | Format-Table -AutoSize
   Get-PhysicalDisk | Get-StorageReliabilityCounter
   ```

   If a disk or controller is defective, replace it promptly to prevent further corruption or replication errors.

1. Make sure that all storage arrays, RAID configurations, and storage area networks (SANs) or network attached storage (NAS) devices are functioning correctly, and use tools such as Performance Monitor (Perfmon) to verify their performance.

1. Make sure that firmware is up to date on all storage controllers.

1. To fix bad disk sectors and recover as much data as possible, open a Windows Command Prompt window, and then run the following command:

   ```console
   chkdsk <Drive>: /F /R
   ```

   > [!NOTE]  
   > In this command, \<Drive> represents the drive to be fixed.

1. If `chkdsk` doesn't recover some part of the data, restore that data from your backup.

1. Review your disk and Storage Replica configuration, and make sure that your system follows best practices. Closely review the following settings:

   - Allocate sufficient space for log files (production workloads should have at least 8 GB available for log files).
   - Allocate sufficient network bandwidth for replication traffic.
   - Verify the volume alignment and cluster size settings.
   - Verify that the replication mode (synchronous or asynchronous) matches your requirements.
   - Make sure that all replication nodes are running Windows Server Datacenter edition.

1. To verify that you restored data consistency and transfer reliability, test storage replication. At a PowerShell command prompt, run the following cmdlets:

   ```powershell
   Get-SRGroup | Format-List *
   Get-SRPartnership | Format-List *
   Test-SRTopology -SourceComputerName Server1 -SourceVolumeName D: -DestinationComputerName Server2 -DestinationVolumeName D:
   ```

1. To verify that your system is stable, monitor the replication status for at least 24 hours.

1. For more troubleshooting information, including specialized troubleshooting for Event ID 153, see [Data corruption and disk errors troubleshooting guidance](troubleshoot-data-corruption-and-disk-errors.md).

1. If issues persist, consider contacting Microsoft Support. To learn about helpful information that you can add to your support request, review [Data collection](#data-collection).

## Data collection

Before you contact Microsoft Support for assistance, gather the following information from your Windows Server 2025 environment:

- Event Viewer logs for disk, storage, and replication errors (System, Application, and Microsoft-Windows-StorageReplica/Admin logs).
- Output from PowerShell cmdlets, such as the following cmdlets:

  ```powershell
  Get-PhysicalDisk | Format-Table -AutoSize
  Get-SRGroup
  Get-SRPartnership
  Get-EventLog -LogName System -Newest 100 | Where-Object {$_.Source -like "*disk*" -or $_.Source -like "*storage*"}
  ```

- Details of your storage configuration, including RAID levels, disk models, firmware versions, and storage controller information.
- Screenshots or exports from monitoring tools that show error codes and performance metrics.
- The steps that you already took to troubleshoot the issue.

## References

- [Check disk for errors in Windows Server](/windows-server/administration/windows-commands/chkdsk)
- [Storage Replica overview in Windows Server](/windows-server/storage/storage-replica/storage-replica-overview)
- [Troubleshoot Storage Spaces issues](/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)
- [Storage Replica known issues](/windows-server/storage/storage-replica/storage-replica-known-issues)
- [Data corruption and disk errors troubleshooting guidance](troubleshoot-data-corruption-and-disk-errors.md)
