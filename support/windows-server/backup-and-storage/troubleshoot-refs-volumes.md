---
title: Guidance for troubleshooting ReFS volumes
description: Describes how to investigate and resolve Resilient File System (ReFS) issues in Windows Server.
ms.date: 06/04/2026
ms.reviewer: kaushika, v-appelgatet
ms.custom:
- sap:backup, recovery, disk, and storage\refs
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# ReFS volume troubleshooting guidance

## Summary

This article helps you investigate and resolve issues that affect Resilient File System (ReFS) volumes in Windows Server. Use the troubleshooting checklist to document your environment and isolate the cause of the issue, then refer to the relevant section for guidance on common issues and their resolutions.

## Troubleshooting checklist

Follow these steps to document the current state of your environment and start to isolate the cause of your issue.

> [!NOTE]  
> If Windows Server isn't responding, restart the system in [safe mode](../performance/troubleshoot-startup-problems.md#how-to-start-the-computer-in-safe-mode).

1. Make sure that recent backups are available before you try to make repairs or changes.

   > [!NOTE]  
   > If a recent backup isn't available, consider the options to clone the volume or use [Microsoft Disk2VHD](https://aka.ms/disk2vhd) to create a virtual hard disk copy.

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

   - Cluster logs from all nodes. To collect logs, run the following cmdlet on one of the cluster nodes:

     ```powershell
      Get-ClusterLog -UseLocalTime -Destination <folder path>
     ```

   - Microsoft-Windows-DeviceSetupManager/Admin event log. In particular, look for event IDs 131, 133, 135, or 140
   - System log. In particular, look for event ID 55.

## Common issues and solutions

| Common collections of symptoms | See section |
| --- | --- |
| <ul><li>Volume status is RAW</li><li>Data on the volume is inaccessible</li><li>Repeated mount or repair failures</li><li>Events: event IDs 133 or 135</li></ul> | [Volume is RAW or inaccessible (Event IDs 133 or 135)](#volume-is-raw-or-inaccessible-event-ids-133-or-135) |
| <ul><li>The volume doesn't mount</li><li>Events: event IDs 134, 137, or 140</li><li>Error messages: invalid metadata pages or checksum failures, or that the "device is busy."</li></ul> | [Metadata corruption or mount failures (Event IDs 134, 137, or 140)](#metadata-corruption-or-mount-failures-event-ids-134-137-or-140) |
| After the volume mounts:<ul><li>The computer becomes unresponsive</li><li>CPU and memory usage are very high</li><li>Backup jobs are slow or stop responding (hang)</li><li>Events: high activity on the volume</li></ul> | [After the volume mounts, the system freezes or experiences high resource or memory usage](#after-the-volume-mounts-the-system-freezes-or-experiences-high-resource-or-memory-usage) |
| After you upgrade or downgrade:<ul><li>The volume doesn't mount</li><li>Data on the volume is inaccessible</li><li>Events: event IDs 133 or 137</li></ul> | [After an operating system upgrade or downgrade, ReFS isn't compatible with the operating system](#after-an-operating-system-upgrade-or-downgrade-refs-isnt-compatible-with-the-operating-system) |
| <ul><li>Backups fail</li><li>Shadow copies aren't created or deleted</li><li>VSS writers generate errors</li><li>Events: event IDs 12289 or 8193</li></ul> | [Backup, VSS, and snapshot issues (Event IDs 12289 or 8193)](#backup-vss-and-snapshot-issues-event-ids-12289-or-8193) |
| <ul><li>Events: I/O errors, and event IDs 7, 51, or 153</li><li>The storage pool is degraded</li><li>Virtual disks that are hosted on the ReFS volume are offline</li></ul> | [I/O errors, disk hardware failures, and pool degradation](#io-errors-disk-hardware-failures-and-pool-degradation) |
| After you upgrade or migrate:<ul><li>A disk appears to be offline</li><li>Mount points aren't claimed</li><li>Message: "Offline (The disk is offline due to a policy established by an administrator)."</li></ul> | [After an operating system upgrade or migration, you experience mount point or volume policy issues](#after-an-operating-system-upgrade-or-migration-you-experience-mount-point-or-volume-policy-issues) |

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
- Background processes that don't finish

#### Resolution

> [!TIP]  
> If the volume becomes inaccessible after stop errors that involved `ReFS.sys`, see [Local disk volume is inaccessible after ReFS.sys errors in Windows Server 2022 Standard](windows-server-2022-standard-local-refs-disk-inaccessible-bsod.md).

1. Prepare a second disk that's the same size as the corrupted volume, or larger.

1. Open a Command Prompt window on the system on which the volume is mounted.
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
   - Check the storage hardware for faults.
   - Use third-party utilities to try to recover the data.
   - If recent backups are available, reformat the volume, and restore the data.
   - Contact Microsoft Support for assistance. Attach the salvage process logs and event log information to the support request.

### Metadata corruption or mount failures (Event IDs 134, 137, or 140)

#### Symptoms

- The volume doesn't mount.
- The event log lists event IDs 134, 137, or 140.
- Error messages indicate that there are invalid metadata pages or checksum failures, or that the "device is busy."

#### Cause

This issue typically indicates that one of the following conditions occurred:

- ReFS metadata is corrupted.
- Faults occurred during write operations.
- An operating system upgrade is installed that's not compatible with the ReFS version.
- An operating system upgrade is installed that changed registry entries that affect ReFS operations (such as metadata validation).

#### Resolution

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

1. If the volume was previously mounted on an older version of Windows Server, and is now mounted on a newer version, make sure that the operating system is up to date and that the versions of the ReFS utilities match the version of the volume.

1. If checksum errors occurred, follow these steps (in a clustered system, follow these steps on all nodes):

   1. On the system on which the volume is mounted, open Registry Editor, and locate the `HKLM\SYSTEM\CurrentControlSet\Control\FileSystem\` subkey.

   1. To disable metadata validation, set the `RefsDisableVolumeIntegrityValidation` value to **1**.

   1. Restart the system (in a clustered system, restart all nodes).

1. Try again to mount the volume.

1. If you still can't mount the volume, try to salvage the volume as described in [Volume is RAW or inaccessible (Event IDs 133 or 135)](#volume-is-raw-or-inaccessible-event-ids-133-or-135).

1. If the issue persists, you might need registry or kernel hotfixes. Escalate as necessary to review this option, and contact Microsoft Support for assistance.

### After the volume mounts, the system stops responding or experiences high resource or memory usage

#### Symptoms

After you mount the ReFS volume on a computer, you encounter the following symptoms:

- The computer becomes unresponsive.
- The computer's CPU and memory usage are very high.
- Backup jobs are slow or stop responding (hang).
- Events in the event log indicate high activity on the volume.

#### Cause

Causes for this issue include the following conditions:

- Known ReFS issues (especially in Windows Server 2022 and 2025)
- Aggressive memory trimming by third-party backup software
- Memory pressure on large volumes
- Excessive metafile consumption

#### Resolution

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

1. Install the latest cumulative updates for Windows Server.

1. If you use third-party backup software, consult your vendor documentation for recommended registry settings (for example, set `FileCacheLimitPercent` to an appropriate percentage).

1. If the previous steps don't help, try to detach the affected volume, and then test the stability of the system.

1. Consider setting registry values that disable aggressive memory trimming. Consult Microsoft Support for assistance.

   > [!TIP]  
   > For tunable registry parameters that address memory pressure that's caused by large ReFS metadata streams, see [Fix heavy memory usage in ReFS](fix-heavy-memory-usage-refs.md).

### After an operating system upgrade or downgrade, ReFS isn't compatible with the operating system

#### Symptoms

After you upgrade or downgrade Windows Server on a computer on which the ReFS volume is mounted, you encounter the following symptoms:

- The volume doesn't mount.
- Data on the volume is inaccessible.
- The event log lists event ID 133 or 137.

#### Cause

This issue typically indicates one of the following conditions:

- The ReFS version isn't supported on the current operating system version.
- The volume or the operating system wasn't upgraded or downgraded correctly.
- An in-place upgrade missed a prerequisite step.

#### Resolution

> [!IMPORTANT]  
> When you upgrade or downgrade the ReFS volume or the operating system that it's mounted on, follow the Microsoft-recommended upgrade paths, and don't skip major versions.

1. In the system on which the volume is mounted, open an administrative Command Prompt window.

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

### Backup, VSS, and snapshot issues (Event IDs 12289 or 8193)

#### Symptoms

- Backups fail.
- Shadow copies aren't created or deleted.
- VSS writers generate errors.
- The event log lists event ID 12289 or 8193.

#### Cause

This issue typically indicates that one of the following conditions exists:

- VSS snapshots are orphaned or corrupted.
- ReFS snapshots are unsupported.
- System resources are exhausted.
- The backup tools aren't compatible with ReFS.

#### Resolution

1. Make sure that the operating system, ReFS volume, and backup agents are all up to date and are compatible with one another.

1. To get a list of the available snapshots, open a Command Prompt window on the computer that the volume is mounted on, and then run the following command:

   ```cmd
   vssadmin list shadows
   ```

1. To delete the current shadow storage associations, run the following command at the command prompt:

   ```cmd
   vssadmin delete shadowstorage /for=[<Drive>]
   ```

   > [!NOTE]  
   > In this command, \<Drive> represents the drive letter of the affected volume.

1. Uninstall or disable third-party antivirus or backup agents that might conflict with VSS.

1. To review VSS writer status, run the following command at the command prompt:

   ```cmd
   vssadmin list writers
   ```

   This command generates output that resembles the following excerpt:

   ```output
   Writer name: 'Task Scheduler Writer'
   Writer Id: {d61d61c8-d73a-4eee-8cdd-f6f9786b7124}
   Writer Instance Id: {1bddd48e-5052-49db-9b07-b96f96727e6b}
   State: [1] Stable
   Last error: No error
   ```

   If any of the `State` values aren't `[1] Stable`, restart the Volume Shadow Copy service.

1. If the volume is irreparably damaged, re-create it.

### I/O errors, disk hardware failures, and pool degradation

#### Symptoms

- The event log lists I/O errors, and event ID 7, 51, or 153.
- The storage pool is degraded.
- Virtual disks that are hosted on the ReFS volume are offline.

#### Cause

This issue typically indicates that one of the following conditions occurred:

- An unplanned power interruption
- A disk, cable, controller, or firmware issue

#### Resolution

1. To identify problematic hardware, review the event logs for recurring hardware errors.

1. Run hardware diagnostics and Self-Monitoring, Analysis, and Reporting Technology (SMART) tests on all physical disks.

1. If any disks failed, replace them promptly.

1. Make sure that firmware, BIOS, and all drivers are up to date and compatible with the operating system and S2D requirements.

### After an operating system upgrade or migration, you experience mount point or volume policy issues

#### Symptoms

After you upgrade Windows Server on a computer on which the ReFS volume is mounted (or migrate to a new Windows Server-based computer), you encounter the following symptoms:

- A disk appears to be offline.
- Mount points aren't claimed.
- You see the message, "Offline (The disk is offline due to a policy established by an administrator)."

#### Cause

The disk signature or the storage area network (SAN) policy changed during the upgrade process.

#### Resolution

> [!IMPORTANT]  
> Before you upgrade or migrate critical production clusters, document the SAN policies.

1. To start the `diskpart` utility, open a Command Prompt window on the computer that the volume is mounted on, and then run the `diskpart` command.

1. At the `diskpart` prompt, select the ReFS volume, and then run the `san` command to view the current policy settings.

1. As necessary, run `san policy=OnlineAll` to reset the policy, and then bring the affected disks online.

1. Consider the option to create post-upgrade scripts that can restore disks to their expected state after an upgrade.

## Data collection

For effective troubleshooting and escalation to Microsoft Support, collect the following information:

- Log information:
  - System and application event logs (focus on storage, ReFS, NTFS, and VSS event sources)
  - Backup software logs and configuration files
  - Performance logs (disk queue, IOPS, latency, memory consumption)
  - Storage Spaces Direct (S2D) logs, cluster logs, and cluster shared volume (CSV) health
  - Logs that are generated by any troubleshooting utilities (such as Procmon or other Sysinternals utilities)
- Status and diagnostic reports
  - Output from `chkdsk /f /scan` and `fsutil fsinfo` commands
  - Output from `refsutil` and `diskpart` operations on the ReFS volume
  - Output from `vssadmin` operations such as `vssadmin list shadows` and `vssadmin list providers`
  - Hardware diagnostics and SMART data
- Other information:
  - Version information for the operating system, the ReFS volume, controllers, and firmware
  - Memory dump files (if system volumes or software stop responding or stop errors occur)
  - Relevant `FileSystem` and `ReFS` values from the registry of the affected computer, exported to a .reg file

## References

- [Resilient File System (ReFS) overview](/windows-server/storage/refs/refs-overview)
- [Fix heavy memory usage in ReFS](fix-heavy-memory-usage-refs.md)
- [Local disk volume is inaccessible after ReFS.sys errors in Windows Server 2022 Standard](windows-server-2022-standard-local-refs-disk-inaccessible-bsod.md)
- [NTFS overview](/windows-server/storage/file-server/ntfs-overview)
- [Volume Shadow Copy Service (VSS)](/windows-server/storage/file-server/volume-shadow-copy-service)
- [Storage Spaces Direct overview](/windows-server/storage/storage-spaces/storage-spaces-direct-overview)
- [`refsutil`](/windows-server/administration/windows-commands/refsutil)
- [`fsutil`](/windows-server/administration/windows-commands/fsutil)
- [`vssadmin`](/windows-server/administration/windows-commands/vssadmin)
- [`vssadmin delete shadowstorage`](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc785461(v=ws.10))
- [`diskpart`](/windows-server/administration/windows-commands/diskpart)
