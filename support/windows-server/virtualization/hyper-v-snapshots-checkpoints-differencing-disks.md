---
title: Troubleshoot Hyper-V Snapshots, Checkpoints, and Differencing Disks (AVHDX)
description: Provides troubleshooting methods for issues that affect Hyper-V snapshots, checkpoints, and differencing disks.
ms.date: 10/08/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:Virtualization and Hyper-V\Snapshots, checkpoints, and differencing disks
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
 
# Troubleshoot Hyper-V snapshots, checkpoints, and differencing disks (AVHDX)

## Summary

Hyper-V checkpoints (snapshots) are critical features in Windows Server virtualization. They enable administrators to capture virtual machine VM states for backup, replication, and disaster recovery. However, checkpoint and snapshot management can be complicated by interactions with third-party backup solutions, storage limitations, misconfiguration, or system-level failures. Issues that occur in checkpoint operations can cause failed backups, VM outages, data loss, storage exhaustion, broken VM chains, and hindered disaster recovery. This article provides a systematic approach for diagnosing and resolving checkpoint and snapshot-related issues in Hyper-V, including standalone and clustered environments.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting:

- **Verify backup and restore status**
  - Check whether recent third-party backups finished successfully.
  - Verify that backup applications report merging or cleanup of their checkpoints.
- **Review storage utilization**
  - Check for storage exhaustion on volumes that store .vhdx, .avhdx, .mrt, or .rct files.
  - Make sure that sufficient free space exists for merges (ideally, space equal to the disk size).
- **Examine VM state**
  - Verify that the VM isn't in the "saved," "creating checkpoint," or "stopping" state.
  - Verify the availability of all expected disk files.
- **Inspect existing checkpoints**
  - In Hyper-V Manager or through PowerShell, enumerate checkpoints:

    ```powershell
    Get-VMSnapshot -VMName <VMName>
    ```

- **Check permissions and security**
  - Verify that the NT VIRTUAL MACHINE\Virtual Machines group has "Log on as a Service" and NTFS folder permissions.
  - Review antivirus exclusions for Hyper-V-related files and folders.
- **Check for orphaned differencing files**
  - Look for .avhd, .avhdx, .mrt, and .rct files that aren't reflected in Hyper-V Manager.
- **Assess cluster/failover health**(if applicable)
  - Verify cluster disk and CSV (Cluster Shared Volume) status.
- **Collect error information**
  - Gather exact error messages, event log entries, and screenshot or key event times.
- **Document all changes**
  - Note any recent configuration, OS, or storage changes.

## Common issues and solutions

The following sections detail the most common failure modes and provide step-by-step solutions.

### Can't create, merge, or delete checkpoints

#### Cause

- Orphaned or stale checkpoints (usually from backup software)
- Checkpoint chain corruption or broken parent/child disk relationships
- Locks on files by backup or antivirus processes
- Insufficient disk space
- Unsupported scenario (for example, pass-through or shared VHDX or synthetic fibre channel)

#### Resolution

**Checkpoints visible but can't delete or merge**

1. Right-click the checkpoint, and select **Delete** or press Del in Hyper-V Manager. If this action is unsuccessful, run the following PowerShell command:

   ```powershell
   Get-VMSnapshot -VMName <VMName> | Remove-VMSnapshot
   ```

1. Shut down the VMm and retry the deletion (the shutdown triggers an auto-merge, if possible).
1. If the merge fails, use Hyper-V Manager: Select **Edit Disk** > **.avhdx** > **Merge** > **To parent virtual disk** (repeat for a chain).

**Checkpoints not visible (orphaned or aged snapshots)**

1. Shut down the VM.
1. Use PowerShell to inspect VHD chains:

   ```powershell
   Get-VMHardDiskDrive -VMName <VMName> | ForEach-Object { Get-VHD -Path $_.Path | Select-Object Path, ParentPath, VHDType }
   ```

1. Identify and merge any .avhdx files that aren't visible in the Manager.

   ```powershell
   Merge-VHD -Path <path-to-avhdx> -DestinationPath <parent-vhdx>
   ```

1. Update VM configuration to point to the merged .vhdx file in Hyper-V Manager, if it's necessary.

**Orphaned, broken, or missing checkpoint or disk diles**

If a base or differencing disk is missing: Restore it from backup, if possible. Otherwise, create a new VM, and attach the remaining healthy .vhdx file.

**Excessive number of checkpoints (more than 50)**

1. Schedule downtime.
1. Merge checkpoints sequentially (from youngest to oldest).

For more information, see [How to merge checkpoints that have multiple differencing disks](merge-checkpoints-with-many-differencing-disks.md)

**Pass-through, shared VHD, or synthetic fibre channel**

- Checkpoints aren't supported.
- Remove or convert pass-through or shared disks to .vhdx or use a third-party backup for these workloads.

### Checkpoint or backup-related performance of cleanup failures

#### Cause

- Third-party backup integration failures
- Antivirus exclusion misconfiguration
- Disk locks or service or permission misconfigurations

#### Resolution

**Incomplete checkpoint merges (after backup)**

1. Make sure that backup software is configured to clean up after completion.
1. Exclude Hyper-V files, folders, and processes from antivirus scanning.
1. Restart the VM or host if checkpoints still don't merge.

**File locks or sharing violations**

1. Use Resource Monitor or ProcMon to identify the process that locks the file.
1. Restart backup, Hyper-V, and VSS services.

**Permission rights issues**

1. Add NT VIRTUAL MACHINE\Virtual Machines to "Log on as a service."
   - GPMC: Computer Configuration > Windows Settings > Security Settings > Local Policies > User Rights Assignment
1. Apply permissions:

   ```console
   icacls <PathToVMFolder> /grant "NT VIRTUAL MACHINE\<VMGuid>:F" /T
   ```

1. Run `gpupdate /force` after changes.

### Clustered and high availability scenarios

**Disk integration or cluster node issues**

1. Check CSV and cluster resource status.
1. Analyze logs for storage, cluster, or node failures.
1. Run relevant PowerShell commands:

   ```powershell
   get-clusterstoragespacesdirect
   get-storagepool
   get-physicaldisk
   get-virtualdisk
   get-storagetier
   mountvol
   ```

**Cluster configuration version issues**

1. Make sure that VMs use current configuration versions for live migration.
1. Update through **Hyper-V Manager** > **VM** > **Upgrade Configuration Version**.

### Checkpoint Chain corruption

#### Cause

1. Manual deletions or failed merges
1. Storage or host failures mid-merge

#### Resolution

1. Back up all files before you try any fixes.
1. To merge all differencing disks, one by one, from child to parent, use the VM "Edit Disk" tool in Hyper-V Manager.
1. If the VM still doesn't start, create a new VM, and attach the final merged disk.

## Common issues quick reference table

| Symptom | Root cause | Resolution |
| --- | --- | --- |
| Can't delete or merge checkpoints | Orphaned, invisible, or backup-created checkpoints | Shutdown, use PowerShell "Edit Disk" for manual merge |
| No space to merge, VM doesn't start | Storage exhaustion, unmerged checkpoints | Free up storage, attach USB/NAS, perform merge and export |
| Error 0x80070032 or disk chain corruption | Broken chain, merge interrupted, disk mismatch | Identify correct merge order, repair chain, or create new VM |
| File lock or sharing violation (0x80070020) | Backup, AV, or other process has disk open | Use ProcMon to identify lock, restart VSS/Hyper-V/backups, antivirus exclusions |
| VM stuck at "creating checkpoint" / not responding | SnapshotTask/VMDeltaSync stuck, HVMM service blocked | Restart host, kill stuck processes, analyze dump files |
| Can't expand disk (option greyed out) | Active differencing or child disk exists | Merge all checkpoints, make sure that parent is selected in settings |
| "Catastrophic failure" deleting checkpoint | Invalid permissions, configuration corruption, backup lock | Fix permissions, remove checkpoint through a new VM, if it's necessary |
| Pass-through/shared VHD/fibre channel=fail | Not supported by design for checkpointing | Convert disk type or use backup vendor's procedure |

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue.

- **Event Viewer logs:**
  - Application, System, Microsoft-Windows-Hyper-V-VMMS/Admin
- **Cluster Logs:**

  ```console
  cluster log /g
  ```

- **VM and disk chains:**

  ```powershell
  Get-VM -ComputerName <host> -Name <VMName>
  Get-VMSnapshot -VMName <VMName>
  Get-VHD -Path <full-path>
  ```

- **Manual Disk/VM Inspection:**
  - Explorer listing of VM folder (with file sizes, last modified date)
- **Procmon or Resource Monitor Traces:**
  - Filter for .avhdx, .vhdx, vmwp.exe, backup process
- **VSS and Shadow Copy:**
  - vssadmin list writers
  - DevNodeClean logs (if shadow copy or ghost VSS devices are suspected)
- **Screenshots:**
  - Hyper-V Manager, error messages, properties dialog boxes

## References

- [How to merge checkpoints that have multiple differencing disks](merge-checkpoints-with-many-differencing-disks.md)
- [Backup recovery checkpoint issues](cannot-delete-recovery-checkpoint-vm.md)
- [Common antivirus exclusions for Hyper-V](/defender-endpoint/configure-server-exclusions-microsoft-defender-antivirus)
- [Log on as a service](/windows/security/threat-protection/security-policy-settings/log-on-as-a-service)
