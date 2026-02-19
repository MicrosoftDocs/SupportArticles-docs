---
title: Troubleshoot Hyper-V Virtual Machine Backup, Checkpoint, and Storage Failures
description: Provides a comprehensive guide to troubleshooting common issues with Hyper-V VM backup, checkpoint management, and storage failures in Windows Server environments.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhuge, v-lianna
ms.custom:
- sap:virtualization and hyper-v\backup and restore of virtual machines
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Troubleshoot Hyper-V virtual machine backup, checkpoint, and storage failures

This article provides a comprehensive guide to troubleshooting common issues encountered with Hyper-V virtual machine (VM) backup, checkpoint management, and storage failures in Windows Server environments (Windows Server 2016, Windows Server 2019, Windows Server 2022, and Windows Server 2025). These issues often arise during backup or restore operations, checkpoint creation or merging, VM startup, and storage connectivity. They can impact both production and disaster recovery workflows in standalone Hyper-V hosts, clustered setups, and environments integrated with third-party backup tools. Timely identifying and resolving these issues is critical to maintaining VM availability, data integrity, and backup reliability.

You might experience:

- Inability to perform backups or restores, leading to potential data loss.
- Unexpected VM downtime or loss of access.
- Orphaned disk files causing storage exhaustion.
- Persistent warning or error states in management consoles.

In addition, you might encounter the following symptoms in affected environments:

- [Backup and restore failures](#backup-and-restore-failures)
- [Checkpoint and snapshot issues](#checkpoint-and-snapshot-issues)
- [VM startup or migration failures](#vm-startup-or-migration-failures)
- [Storage and file system errors](#storage-and-file-system-errors)

The root causes of these issues can be grouped into the following categories, with corresponding resolutions provided:

- [Checkpoint and VSS-related issues](#checkpoint-and-vss-related-issues)
- [File system and storage problems](#file-system-and-storage-problems)
- [Permissions and policy misconfiguration](#permissions-and-policy-misconfiguration)
- [Cluster and configuration issues](#cluster-and-configuration-issues)

> [!NOTE]
> Always back up critical VMs before performing file merges, deletions, or major configuration changes. For further assistance, consult Microsoft Support or your backup vendor.

## Backup and restore failures

- Backups fail to complete or hang indefinitely.
- Restore operations from checkpoints or images fail.
- Error messages from backup software (such as Veeam, Druva, Rubrik, or Veritas) include:

  - > Failed to create VM recovery checkpoint … error code: 32768
  - > Could not create backup checkpoint for virtual machine - Error -0x800423F2
  - > There was a problem recovering your PC
  - > Import failed. … The process cannot access the file because it is being used by another process. (0x80070020)

- Event log entries, such as Event ID 8229 (host) and 12293 (guest), indicate Volume Shadow Copy Service (VSS) writer errors.

## Checkpoint and snapshot issues

- Unable to create new checkpoints or merge existing ones.
- VHDX files accumulate on disk, even when not visible in Hyper-V Manager.
- Errors such as: "The process cannot access the file because it is being used by another process. (0x80070020)".
- Orphaned or hidden checkpoints block backup or VM operations.
- VMs are stuck in saved, paused, or critical states.

## VM startup or migration failures

- VMs fail to start after host reboots, patching, or disk migration.
- Errors such as:

  - > The system cannot find the file specified. (0x2)
  - > An error occurred while attempting to start the selected VM. Unavailable could not initialize and update VM configuration failed.

- VMs aren't visible in Hyper-V Manager or Failover Cluster Manager.
- VM migration, export, or import fails due to missing or corrupted files.

## Storage and file system errors

- Event logs show IDs 9, 39, 129, 3280, 55, 51, or 513 related to storage, disk, or file system corruption.
- Storage volume runs out of space due to large AVHDX files.
- VHD/VHDX files are missing, inaccessible, or corrupted.
- Errors such as:

  - > Cannot connect to virtual machine configuration storage
  - > The virtual machine is not in a valid state to perform the operation.

## Checkpoint and VSS-related issues

- Orphaned or unmerged checkpoints: Caused by incomplete backup operations, hidden/invisible checkpoints, or AVHDX chain corruption.
- VSS writer failures or timeouts: VSS writers in failed or timeout states, often due to overlapping backup jobs or VSS operations.
- Third-party backup integration: Misconfigurations or incompatibilities between Hyper-V and backup tools such as Veeam, Druva, or Veritas.

### Resolution: Checkpoint and AVHDX file management

1. Identify orphaned checkpoints:

    1. Run the following PowerShell cmdlet:

       ```powershell
       Get-VMSnapshot -VMName
       ```

    2. Inspect the VM disk folder for AVHDX files not listed in Hyper-V Manager.

2. Merge orphaned AVHDX files:

    1. Shut down the affected VM.
    2. In Hyper-V Manager, select the VM, and then select **Actions** > **Edit Disk** to open the **Edit Virtual Hard Disk Wizard** window.
    3. On the **Locate Disk** tab, select **Browse** to locate the AVHDX file, and then select **Next**.
    4. On the **Choose Action** tab, select **Merge** > **To the parent virtual hard disk**, and then select **Next** to complete the wizard.

3. Advanced PowerShell merge (if needed):

    ```powershell
    Merge-VHD -Path <AVHDXPath> -DestinationPath <VHDXPath>
    ```

4. Reattach and start the VM:

    1. Verify the VM points to the correct (merged) VHDX file.
    2. Start the VM and confirm functionality.

### Resolution: Backup/restore and VSS writer troubleshooting

1. Restart VSS services:

    ```console
    net stop vss
    net start vss
    net stop swprv
    net start swprv
    ```

2. Check VSS writers:

    Run the `vssadmin list writers` command and resolve failed writers by restarting related services or rebooting the host.

3. Clear stuck checkpoints:

    Use vendor-specific tools, such as `nbhypervtool.exe deleteNbuCheckpoints -vmguid <vmguid>` for Veritas.

4. Stagger backup schedules to avoid overlapping VSS operations.

## File system and storage problems

- Disk or volume corruption: Metadata errors on NTFS/ReFS volumes triggered by failed merges or storage I/O issues.
- Missing or corrupted VM files: Loss or corruption of VHD, AVHDX, or configuration files due to failed merges or hardware issues.
- Storage connectivity problems: Issues with iSCSI, Cluster Shared Volumes (CSV), or Storage Spaces Direct (S2D) leading to unavailability or driver/firmware failures.

### Resolution: File system and storage repair

1. Run disk and file system repairs:

    ```console
    chkdsk <drive:> /f
    ```

    Or for ReFS volumes:  

    ```powershell
    Repair-Volume <drive:>
    ```

2. Restore missing files:

    Recover from the latest backup if files are irrecoverable.
3. Validate storage health:

    - Check iSCSI, CSV, or S2D connectivity and ensure sufficient space.
    - Update storage drivers and firmware.

## Permissions and policy misconfiguration

- Insufficient permissions: Missing **Log on as a Service** rights for NT Virtual Machine accounts or incorrect NTFS permissions.
- Antivirus interference: AV filter drivers blocking access to disk files or interfering with checkpoint/backup operations.
- Group Policy misconfigurations: Changes removing required permissions or service rights.

### Resolution: Permission and policy corrections

1. Assign required rights:

    Ensure the **NT Virtual Machine\\Virtual Machines** account has **Log on as a Service** rights via Group Policy or Local Security Policy.
2. Update NTFS permissions:

   Use `icacls` to verify and grant **Full Control** to VM service accounts.
3. Configure antivirus exclusions by following the [Microsoft antivirus exclusions for Hyper-V hosts](antivirus-exclusions-for-hyper-v-hosts.md).

## Cluster and configuration issues

- Cluster role or metadata corruption: Caused by improper failovers, role removal, or unsynchronized cluster states.
- Configuration version mismatch: VM configuration versions below the required minimum after migrations or upgrades.
- Incorrect VM or storage path settings: Misconfigured paths or mismatched network adapters after a migration.

### Resolution: Cluster and VM configuration fixes

1. Resynchronize cluster metadata:

   - Use Failover Cluster Manager for VM operations.
   - Perform live migrations to force metadata sync and clear warnings.
2. Restore or import missing VMs:

   In Hyper-V Manager, use **Import Virtual Machine** and locate the exported/imported files.
3. Update the VM configuration version:

   In Hyper-V Manager, right-click the VM and select **Upgrade Configuration Version**. Or use the following PowerShell cmdlet:

   ```powershell
   Update-VMVersion
   ```

4. Correct disk or network settings:

   Edit VM settings to ensure correct disk and network adapter assignments.

## Operational and environmental causes

- Improper maintenance: Rebooting cluster nodes without draining roles or placing them in maintenance mode.
- Simultaneous backup conflicts: Overlapping backup jobs causing VSS contention or file corruption.
- Hardware or driver issues: Outdated network/storage drivers or hardware instability.

## Other repairs and checks

1. Clean up saved states. Delete `.vmrs` and `.vmgs` files in the VM folder if stuck in a "Saved" state.
2. Check and fix cluster resource states. Use PowerShell cmdlets like `Get-ClusterResource` to inspect and repair cluster roles.
3. Restart the host to clear stale file locks if needed.

## Data collection

To assist with troubleshooting, collect the following items:

- Event logs: Application, system, and Hyper-V-specific logs.
- PowerShell diagnostic cmdlets: `Get-VHDChain`, `Get-VMSnapshot`, `Get-VM`, `Update-VMVersion`, `icacls`, `Merge-VHD`, and `Set-VHD`.
- VSS tools: `vssadmin list writers` and `vssadmin list providers`.
- Diagnostic tools: Process Monitor (Procmon), **Handle.exe**, Process Explorer, and Troubleshooting Support Script (TSS).
- Cluster logs: Failover clustering logs and System Center Virtual Machine Manager (SCVMM) job history.
- Vendor-specific tools for checkpoint/snapshot cleanup.

## References

- [Export and import virtual machines](/windows-server/virtualization/hyper-v/deploy/export-and-import-virtual-machines)
- [Backing up and restoring virtual machines](/windows/win32/hyperv_v2/backing-up-and-restoring-virtual-machines)
- [Antivirus exclusions for Hyper-V hosts](antivirus-exclusions-for-hyper-v-hosts.md)
- [PowerShell Hyper-V cmdlets](/powershell/module/hyper-v/)
