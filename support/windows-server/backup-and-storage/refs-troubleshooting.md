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

### Before you begin

- **Confirm the environment**: Identify the OS version, ReFS volume version, type of system (standalone, cluster, virtualized), and workload.
- **Review recent changes**: Hardware replacements, OS/service pack or firmware updates, power outages, unclean shutdowns, or storage configuration changes.
- **Check backups**: Ensure recent backups are available before you attempt repairs or changes.

### Gather initial information

- Current ReFS volume status (RAW, online, read-only, and so on)
- Error messages and event log entries (Event IDs 131, 133, 135, 140, 55, and similar)
- Storage pool health, device and Storage Spaces Direct (S2D) pool status, and cluster logs

### Initial action steps

- Verify hardware health and firmware/driver versions.
- Confirm that the version of ReFS is supported by the server OS.
- Boot into Safe Mode if the system is unresponsive.

## Issues and resolutions

### 1. Volume becomes RAW or inaccessible

**Symptoms**

Volume status is RAW; data is inaccessible; repeated mount or repair failures occur; Event IDs 133 or 135 are logged.

**Root causes**

File system corruption due to power loss, failed hardware, an unsupported ReFS version, or unfinished background processes.

**Resolution steps**

1. Open Event Viewer and note any errors on the volume.
2. Use `refsutil salvage` to attempt to mount or recover the volume:
   - Prepare a second disk of equal or larger size.
   - Run:

     ```console
     refsutil salvage -s <source volume> -d <destination folder>
     ```

3. Collect salvage logs for escalation if recovery is incomplete.
4. If salvage fails, check hardware, attempt data recovery with third-party tools, or reformat and restore from backup if backups are available.

> [!TIP]
> If the volume became inaccessible after stop errors that involved `ReFS.sys`, see [Local disk volume is inaccessible after ReFS.sys errors in Windows Server 2022 Standard](windows-server-2022-standard-local-refs-disk-inaccessible-bsod.md).

### 2. Metadata corruption or mount failures

**Symptoms**

The volume fails to mount; Event IDs 134, 137, or 140 are logged; error messages reference invalid metadata pages, checksum failures, or "device is busy."

**Root causes**

Corruption of ReFS metadata, incompatibility from OS upgrades, faults during write operations, or registry options (such as metadata validation) interfering after upgrades.

**Resolution steps**

1. Review event logs and errors.
2. For volumes that previously mounted on older OS versions, ensure the OS is fully patched and that the ReFS utilities match the volume version.
3. Set the following registry value to disable metadata validation if checksum errors occur:

   ```
   HKLM\SYSTEM\CurrentControlSet\Control\FileSystem\
   RefsDisableVolumeIntegrityValidation = 1
   ```

4. Reboot all nodes, and then retry the mount or salvage.
5. If the issue persists, escalate for internal review and possible registry or kernel hotfixes.

### 3. System hangs, high resource or memory usage, or freeze on volume attach

**Symptoms**

The server becomes unresponsive after mount; CPU and memory usage are very high; backup jobs are slow or hung; Event IDs indicate large volume activity.

**Root causes**

Known ReFS issues (especially on Windows Server 2022 and 2025), aggressive memory trimming by third-party backup software, memory pressure on large volumes, or excessive metafile consumption.

**Resolution steps**

1. Install the latest cumulative updates for the OS.
2. If you use third-party backup software, consult vendor documentation on recommended registry settings (for example, set `FileCacheLimitPercent` to an appropriate percentage).
3. Consider disabling aggressive memory trimming via the registry as advised by support.
4. If necessary, detach problematic volumes and test system stability.

> [!TIP]
> For tunable registry parameters that address memory pressure caused by large ReFS metadata streams, see [Fix heavy memory usage in ReFS](fix-heavy-memory-usage-refs.md).

### 4. Incompatibility after OS upgrade or ReFS version mismatch

**Symptoms**

A volume that worked on one OS version doesn't mount after an upgrade or downgrade; files are inaccessible; Event IDs 137 or 133 are logged.

**Root causes**

The ReFS version isn't supported on the current OS, the volume wasn't upgraded or downgraded properly, or an in-place upgrade missed N-1 steps.

**Resolution steps**

1. Run the following command to confirm the volume version:

   ```console
   fsutil fsinfo refsinfo <drive>
   ```

2. If needed, connect the volume to the original OS environment to perform an intermediate upgrade step, or move the disk to a supported system for ReFS version reconciliation.
3. Follow the Microsoft recommended OS upgrade paths and don't skip major versions.
4. Ensure all backup and storage software is compatible with the current OS and ReFS version.

### 5. Backup, VSS, and snapshot failures

**Symptoms**

Backups fail, shadow copies aren't created or deleted, errors occur from VSS writers, or Event IDs 12289 or 8193 are logged.

**Root causes**

Orphaned or corrupted VSS snapshots, unsupported ReFS snapshots, system resource exhaustion, or incompatible backup tools.

**Resolution steps**

1. Run the following command to review snapshots:

   ```console
   vssadmin list shadows
   ```

2. Delete shadow storage associations:

   ```console
   vssadmin delete shadowstorage /for=[drive]
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
- [Resilient File System (ReFS) overview](/windows-server/storage/refs/refs-overview)
- [Fix heavy memory usage in ReFS](fix-heavy-memory-usage-refs.md)
- [Local disk volume is inaccessible after ReFS.sys errors in Windows Server 2022 Standard](windows-server-2022-standard-local-refs-disk-inaccessible-bsod.md)
- [NTFS overview](/windows-server/storage/file-server/ntfs-overview)
- [Volume Shadow Copy Service (VSS)](/windows-server/storage/file-server/volume-shadow-copy-service)
- [Storage Spaces Direct overview](/windows-server/storage/storage-spaces/storage-spaces-direct-overview)
