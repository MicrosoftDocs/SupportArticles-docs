---
title: Guidance for troubleshooting ReFS volumes
description: Provides guidance to help IT administrators investigate and resolve issues with Resilient File System (ReFS) volumes on Windows Server.
ms.date: 06/04/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting-general
ms.reviewer: kaushika, v-appelgatet
ms.custom:
- sap:backup, recovery, disk, and storage\refs
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# ReFS volumes troubleshooting guidance

This article provides guidance to help IT administrators and support personnel investigate and resolve issues with Resilient File System (ReFS) volumes on Windows Server.

## Introduction

The Resilient File System (ReFS) is designed to maximize data availability, scalability, and integrity for modern workloads such as backup repositories, large file servers, virtualization environments, and Storage Spaces. In rare circumstances—such as underlying hardware failures, unexpected power loss, or incompatibilities introduced by OS or firmware changes—an administrator might need to diagnose and recover a volume. This guide helps IT administrators and support personnel investigate and resolve ReFS issues if they arise.

## Troubleshooting checklist

Follow these steps to document the current state of your environment and start to isolate the cause of your issue.

> [!NOTE]  
> If Windows Server is not responding, restart the system in [Safe mode](../performance/troubleshoot-startup-problems#how-to-start-the-computer-in-safe-mode).

1. Make sure that recent backups are available before you attempt repairs or changes.

   > [!NOTE]  
   > If a recent backup is not available, consider cloning the volume or using [Microsoft Disk2VHD](https://aka.ms/disk2vhd) to create a virtual hard disk copy.

1. Document the following information:

   - Operating system version
   - ReFS volume version
   - Firmware and driver versions for the storage hardware
   - System type (for example, standalone, cluster, or virtualized)
   - Workload that the volume supports

     > [!IMPORTANT]  
     > Verify that the operating system version that you're using supports the ReFS volume version.

1. Review the recent history of the environment for changes or unusual incidents, such as the following events:

   - Hardware replacements
   - Operating system or firmware updates
   - Changes to the storage configuration
   - Power outages or other unclean shutdowns

1. Review the current system health, including the following information:

   - Hardware and device health
   - Storage pool health
   - Storage Spaces Direct (S2D) pool status (if appropriate)
   - ReFS volume status (RAW, online, read-only, and so on)

1. Collect the following error and event information:

   - Error messages

   - Cluster logs from all nodes. To collect logs, run the following command on one of the cluster nodes:

     ```powershell
      Get-ClusterLog -UseLocalTime -Destination <folder path></folder>
     ```

   - Microsoft-Windows-DeviceSetupManager/Admin event log. In particular, look for event IDs 131, 133, 135, or 140
   - System log. In particular, look for event ID 55.

## Common issues and solutions

### Volume is RAW or inaccessible (Event IDs 133 or 135)

#### Symptoms

- Volume status is RAW
- Data on the volume is inaccessible
- You encounter repeated mount or repair failures
- The event log lists event IDs 133 or 135

#### Cause

This issue typically indicates that the file system is corrupted. Any of the following conditions or occurrences can cause this corruption:

- Power loss
- Hardware failure
- Unsupported ReFS version
- Background processes didn't finish

#### Resolution

> [!TIP]  
> If the volume became inaccessible after stop errors that involved `ReFS.sys`, see [Local disk volume is inaccessible after ReFS.sys errors in Windows Server 2022 Standard](windows-server-2022-standard-local-refs-disk-inaccessible-bsod.md).

1. Prepare a second disk that's the same size as the corrupted volume, or larger.

1. Open a Command Prompt window on the system where the volume is mounted.
1. To attempt to mount or recover the volume, run the following command:

   ```cmd
   refsutil salvage -s <SourceVolume> -d <DestinationFolder>
   ```

   > [!NOTE]  
   >
   > - In this command, \<SourceVolume> represents the drive letter of the corrupted volume, and \<DestinationFolder> represents the path to a folder on the second disk.
   > - For more information about this command and its available options, see [`refsutil salvage`](/windows-server/administration/windows-commands/refsutil-salvage).

1. If the salvage process fails or doesn't finish, try the following actions:

   - Review the logs from the salvage process.
   - Check the storage hardware for faults
   - Use third-party tools to try to recover the data
   - If recent backups are available, reformat the volume and restore the data
   - Contact Microsoft Support for assistance. Attach the salvage process logs and event log information to the support request.

### Metadata corruption or mount failures (Event IDs 134, 135, or 140)

#### Symptoms

- The volume doesn't mount
- The event log lists event IDs 134, 137, or 140
- Error messages indicate that there are invalid metadata pages or checksum failures, or that the "device is busy."

#### Cause

This issue typically indicates that one of the following conditions occurred:

- ReFS metadata is corrupted
- Faults occurred during write operations
- An operating system upgrade is installed that's not compatible with the ReFS version
- An operating system upgrade is installed that changed registry entries that affect ReFS operations (such as metadata validation).

#### Resolution

1. If the volume was previously mounted on an older version of Windows Server and is now mounted on a newer version, make sure that the operating system is up to date and that the versions of the ReFS utilities match the version of the volume.

1. If checksum errors occurred, follow these steps (in a clustered system, follow these steps on all nodes):

   1. On the system where the volume is mounted, open Registry Editor and locate the `HKLM\SYSTEM\CurrentControlSet\Control\FileSystem\` subkey.

   1. To disable metadata validation, set the `RefsDisableVolumeIntegrityValidation` value to **1**

   1. Restart the system (in a clustered system, restart all nodes).

1. Try again to mount the volume.

1. If you still can't mount the volume, try to salvage the volume as described in [Volume is RAW or inaccessible (Event IDs 133 or 135)].(#volume-is-raw-or-inaccessible-event-ids-133-or-135).

1. If the issue persists, you might need registry or kernel hotfixes. Escalate as needed to review this option, and contact Microsoft Support for assistance.

### After the volume mounts, the system freezes or experiences high resource or memory usage

#### Symptoms

After you mount the ReFS volume on a computer, you encounter the following symptoms:

- The computer becomes unresponsive
- The computer's CPU and memory usage are very high
- Backup jobs are slow or hang
- Events in the event log indicate high activity on the volume

#### Cause

Causes for this issue include the following conditions:

- Known ReFS issues (especially on Windows Server 2022 and 2025)
- Aggressive memory trimming by third-party backup software
- Memory pressure on large volumes
- Excessive metafile consumption

#### Resolution

1. Install the latest cumulative updates for Windows Server.

1. If you use third-party backup software, consult your vendor documentation for recommended registry settings (for example, set `FileCacheLimitPercent` to an appropriate percentage).

1. If the earlier steps don't help, try detaching the affected volume, and then test the stability of the system.

1. Consider setting registry values that disable aggressive memory trimming. Consult Microsoft Support for assistance.

   > [!TIP]  
   > For tunable registry parameters that address memory pressure caused by large ReFS metadata streams, see [Fix heavy memory usage in ReFS](fix-heavy-memory-usage-refs.md).

### After an operating system upgrade or downgrade, ReFS isn't compatible with the operating system

Incompatibility after OS upgrade or ReFS version mismatch

#### Symptoms

After you upgrade or downgrade Windows Server on a computer where the ReFS volume is mounted, you see the following symptoms:

- The volume doesn't mount
- Data on the volume is inaccessible
- The event log lists event IDs 133 or 137

#### Cause

This issue typically indicates that the ReFS version isn't supported on the current operating system version. The volume or the operating system might not have been upgrade or downgraded correctly. Or an in-place upgrade might have missed a prerequisite step.

#### Resolution

> [!IMPORTANT]  
> When you upgrade or downgrade the ReFS volume or the operating system it's mounted on, follow the Microsoft-recommended upgrade paths and don't skip major versions.

1. On the system where the volume is mounted, open an administrative Command Prompt window.

1. To check the version of the ReFS volume, run the following command:

   ```cmd
   fsutil fsinfo refsinfo <Drive>
   ```

   > [!NOTE]  
   > In this command, \<Drive> is the drive letter of the ReFS volume.

1. If the ReFS volume's version doesn't support the operating system version, try one of the following actions:

   - Connect the volume temporarily to a computer that runs the original operating system version, install all applicable updates, and then try again to upgrade.
   - Connect the volume to a computer that runs a version of Windows Server that the ReFS version supports.

1. After you upgrade, make sure that all backup and storage software is compatible with the current operating system version and the current ReFS version.

### 5. Backup, VSS, and snapshot issues (Event IDs 12289 or 8193)

#### Symptoms

- Backups fail
- Shadow copies aren't created or deleted
- VSS writers generate errors
- The event log lists event IDs 12289 or 8193

#### Cause

This issue typically indicates that one of the following conditions occurred:

- VSS snapshots are orphaned or corrupted
- ReFS snapshots are unsupported
- System resources are exhausted
- The backup tools aren't compatible with ReFS

#### Resolution

1. Run the following command to review snapshots:

   ```console
   vssadmin list shadows
   ```

2. Delete shadow storage associations:

   ```console
   vssadmin delete shadowstorage /for=[Drive]
   ```

3. Uninstall or disable third-party antivirus or backup agents that might conflict with VSS.
4. Review VSS writer status and restart the Volume Shadow Copy service.
5. For persistent issues, perform full OS and backup agent updates, or recreate the volume if it's irreparably damaged.

### 6. I/O errors, disk hardware failures, and pool degradation

**Symptoms**

Event IDs 7, 153, or 51 are logged; I/O errors appear in the event log; storage pool is degraded; or virtual disks are offline.

**Root causes**

Underlying disk, cable, controller, or firmware issues, or unplanned power cycles.

**Resolution steps**

1. Review logs for recurring hardware errors.
2. Run hardware diagnostics and SMART tests on all physical disks.
3. Replace failed disks promptly.
4. Ensure firmware, BIOS, and all drivers are current and compatible with the OS and S2D requirements.

### 7. File system or disk fragmentation issues and file system limitation errors

**Symptoms**

Errors 665 or 1450 occur during writes or backups, database consistency checks fail, the file system grows rapidly, or disk fragmentation is high.

**Root causes**

Fragmentation, extensive use of sparse files or large databases on NTFS with 4-KB clusters, or unsupported snapshot workloads.

**Resolution steps**

1. Take the disk offline and defragment it, or consider switching to ReFS if high-fragmentation workloads persist.
2. For NTFS, use 64-KB cluster sizes for large or sparse-file databases.
3. Monitor database maintenance tasks (such as DBCC CHECKDB) for I/O limits.

### 8. Mount point or volume policy issues after upgrade or migration

**Symptoms**

A disk appears offline after upgrade; mount points aren't claimed; the message "Offline (The disk is offline due to a policy established by an administrator)" is displayed.

**Root causes**

OfflineShared policy or disk signature changes during upgrade events.

**Resolution steps**

1. Run `diskpart` and check the SAN policy.
2. Set the policy to `OnlineAll` as needed and bring disks online.
3. For critical production clusters, document disk policies before upgrades or migrations.
4. Implement post-upgrade scripts to restore expected disk states.

## Data collection

For effective troubleshooting and escalation, collect the following information:

- System and application event logs (focus on storage, ReFS, NTFS, and VSS).
- Output from `refsutil`, `chkdsk`, `diskpart`, and `fsutil`.
- Registry dump of relevant FileSystem and ReFS keys.
- Hardware diagnostics, SMART data, and controller/firmware versions.
- Memory dumps if hangs, freezes, or bug checks occur.
- Backup software logs and configuration files.
- Storage Spaces Direct (S2D) logs, cluster logs, and CSV health.
- Performance logs (disk queue, IOPS, latency, memory consumption).
- Sysinternals utilities logs (for example, Procmon if permission issues are suspected).

## Quick reference

| Issue | Common errors or symptoms | Resolution summary |
|---|---|---|
| Volume appears as RAW or inaccessible | RAW in Disk Management, Event ID 133/135, "Data not available" | Run `refsutil salvage`, use a new disk for copy, check hardware |
| Metadata corruption or mount failure | Event ID 134/137/140, checksum failed, object exists | Disable metadata validation in the registry, reboot, retry salvage |
| System hangs or high memory | Server freeze, 100% RAM/CPU, backup software interactions | Apply latest cumulative updates, adjust `FileCacheLimitPercent`, registry tuning |
| OS upgrade affects ReFS volume | "Can't mount," version error, Event ID 137 | Confirm OS/ReFS compatibility, upgrade or downgrade accordingly |
| Backup and VSS failures | Event ID 12289/8193, orphaned VSS, shadow copies not deleted | Use `vssadmin`, remove third-party AV/backup, repair or update VSS services |
| I/O errors or storage pool degradation | Event ID 7/153/51, disk offline, virtual disk failed | Perform hardware diagnostics, replace faulty components, check drivers and firmware |
| NTFS or file system limitation (error 665, 1450) | Errors 665/1450, DBCC failures, heavy fragmentation | Defrag offline, use 64-KB clusters for NTFS, move to ReFS if needed |
| Policy or mount point issues after upgrade | Disks offline, SAN policy errors, unclaimed or unknown disks | Correct SAN policy via `diskpart`, document and automate disk state scripts |

## Additional resources

- [refsutil](/windows-server/administration/windows-commands/refsutil)
- [fsutil](/windows-server/administration/windows-commands/fsutil)
- [vssadmin](/windows-server/administration/windows-commands/vssadmin)
- [Resilient File System (ReFS) overview](/windows-server/storage/refs/refs-overview)
- [Fix heavy memory usage in ReFS](fix-heavy-memory-usage-refs.md)
- [Local disk volume is inaccessible after ReFS.sys errors in Windows Server 2022 Standard](windows-server-2022-standard-local-refs-disk-inaccessible-bsod.md)
- [NTFS overview](/windows-server/storage/file-server/ntfs-overview)
- [Volume Shadow Copy Service (VSS)](/windows-server/storage/file-server/volume-shadow-copy-service)
- [Storage Spaces Direct overview](/windows-server/storage/storage-spaces/storage-spaces-direct-overview)
