---
title: Troubleshoot Hyper-V Virtual Machine Startup, State, and Access Failures
description: Helps resolve issues related to Hyper-V VMs that fail to start, become stuck in transitional states, or become inaccessible in clustered and standalone environments.
ms.date: 09/01/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhugh, v-lianna
ms.custom:
- sap:virtualization and hyper-v\virtual machine state
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Troubleshoot Hyper-V virtual machine startup, state, and access failures in clustered and standalone environments

This article provides a detailed troubleshooting guide to help you resolve issues related to Hyper-V virtual machines (VMs) that fail to start, become stuck in transitional states (such as starting, stopping, saved, or paused), or become inaccessible in both clustered and standalone environments. Common causes include VM configuration file corruption, storage or network problems, process lockups, checkpoint or automatic virtual hard disk (AVHDX) issues, and permission or driver errors. Timely identifying and resolving these problems is essential to minimizing VM downtime, preventing business disruption, and avoiding data loss in production environments.

When dealing with Hyper-V VM issues, you might encounter various symptoms, including:

## End-user and technical symptoms

- VMs fail to start or power on in Hyper-V Manager or Failover Cluster Manager.
- VMs are stuck in states like "starting," "stopping," "saved-critical," "paused," or "restoring."
- VMs are missing or invisible in Hyper-V Manager or the output of `Get-VM`.
- VM states are displayed as "running critical," "stopping," or "online pending."
- VM consoles are inaccessible, and remote desktop connections are unavailable.
- VMs fail to migrate successfully between cluster nodes.
- Hyper-V Manager or Failover Cluster Manager can't change VM states or report their status.
- The virtual machine management service (VMMS) or VMM services are stuck in a "Stopping" state.
- Storage volumes, such as Cluster Shared Volumes (CSVs), appear as RAW or offline, and VHDX files are inaccessible or locked.

## Error messages, event logs, and codes

- Error messages:

  - > A virtual machine or container with the specified identifier already exists in Hyper-V.
  - > Failed to start worker process: Catastrophic failure 0x8000FFFF.
  - > Virtual machine failed to generate VHD tree: The system cannot find the file specified (0x80070002).
  - > The process cannot access the file because it is being used by another process.
  - > Failed to perform the Cleaning up stale reference point(s) operation. The virtual machine is currently performing: Turning Off.
  - > The file or directory is corrupted and unreadable. (0x80070570)

- Event IDs: 21502, 1069, 1205, 5120, 1135, 225, 15500, 1793, 1795, 7034, 7031, 7036, 16300, 14102, 4092, 18012, 18016, 20848, 20864, 12620, 12240, 153, 20848, 18524, 1146, 1230.
- Cluster resources are stuck in "online pending" or "failed" states.
- VMs are unavailable after patching, host restarts, or storage and network events.

Hyper-V VM failures might originate from several root causes, which are categorized as follows, along with their respective resolutions:

- [Cause 1: Configuration and metadata corruption](#cause-1-configuration-and-metadata-corruption)
- [Cause 2: Storage and file system issues](#cause-2-storage-and-file-system-issues)
- [Cause 3: Process and service lockups](#cause-3-process-and-service-lockups)
- [Cause 4: Permissions, security, and driver problems](#cause-4-permissions-security-and-driver-problems)
- [Cause 5: Cluster, network, and failover issues](#cause-5-cluster-network-and-failover-issues)

## Initial checks before proceeding

To resolve these issues, perform the initial checks using the following steps:

1. Identify error messages, event IDs, and affected VMs using Hyper-V Manager, Failover Cluster Manager, or PowerShell.
2. Review system logs, Hyper-V logs, and cluster event logs for relevant entries.

## Cause 1: Configuration and metadata corruption

- Corrupt or missing VM configuration files (for example, `.VMCX` and `.XML`) prevent Hyper-V from recognizing or starting the VM, often after failed migrations, storage issues, or abrupt shutdowns.
- Checkpoint (AVHDX) chain corruption or missing differencing disks prevent the VM from starting.
- Orphaned checkpoints, incomplete merges, or invalid entries in configuration files block VM operations.
- Duplicate VM GUIDs or object entries, particularly with System Center Virtual Machine Manager (SCVMM), can cause "already exists" errors and prevent VM imports or starts.

To resolve this issue, see [File system and storage checks](#resolution-file-system-and-storage-checks).

## Cause 2: Storage and file system issues

- CSVs or volumes are offline, RAW, or inaccessible due to storage subsystem failures, disk corruption, or drive letter conflicts.
- VHD or VHDX files are locked or in use by another process, such as a backup or antivirus program.
- Missing or corrupt VM runtime state files (VMRS) impede VM operations.
- BitLocker-locked disks prevent VMs from starting after patching or rebooting.

### Resolution: File system and storage checks

1. Verify storage volumes:

    - Use Disk Management or `diskpart` to ensure volumes are online and properly assigned.
    - If volumes are RAW or missing, reassign drive letters and repair disk corruption using `chkdsk`:

      ```console
      chkdsk <drive_letter>: /f /r</drive_letter>
      ```

2. Check VM configuration and disk file presence:

    - Confirm the existence of `.VMCX`, `.VMRS`, `.VHDX`, and `.AVHDX` files in the VM folder.
    - For missing or corrupt configuration files, rebuild the VM using existing VHDX files or restore from a backup.
    - For missing or corrupt AVHDX files:

      ```powershell
      Set-VHD -Path <vhdx path> -ParentPath <parent vhdx path> -IgnoreIDMismatch</parent></vhdx>
      ```

    - If BitLocker is enabled, unlock the disk:

      ```console
      manage-bde -unlock D: -RecoveryPassword <yourrecoverypassword></yourrecoverypassword>
      ```

    - For locked or in-use files, use Process Explorer to identify and terminate the locking process, or reboot the host to release the lock.

## Cause 3: Process and service lockups

- Stale VM Worker Process (VMWP) or VMMS processes are stuck due to storage or network issues or deadlocks.
- Failed attempts to terminate VM processes via Task Manager, `taskkill`, or Process Explorer persist due to kernel or resource locks.

### Resolution: Process and service recovery

1. If the VM is stuck in transitional states:

    - End the VM process:

      ```console
      taskkill /PID <pid> /F</pid>
      ```

    - Restart VMMS or the host if processes remain stuck.
2. Remove saved states or checkpoints:

   ```powershell
   Get-VMSnapshot <vmname> | Remove-VMSavedState<br>Remove-VMSavedState <vmname></vmname></vmname>
   ```

## Cause 4: Permissions, security, and driver problems

- Permissions issues restrict the Hyper-V service account from accessing VM files or folders.
- Antivirus or third-party filter drivers interfere with Hyper-V, blocking file access or causing merge failures.
- Outdated or misconfigured storage or network drivers lead to connectivity loss or failover events.

### Resolution: Permission and security configuration

1. Ensure the Hyper-V service account has full control over VM files and folders.
2. Apply antivirus exclusions as per Microsoft's Hyper-V documentation.
3. Identify and unload problematic filter drivers:

   ```console
   fltmc
   fltmc unload <drivername></drivername>
   ```

## Cause 5: Cluster, network, and failover issues

- CSV or network communication failures, such as cluster node isolation, result in mass VM failovers or reboots.
- Improper cluster configurations or inconsistent patching across nodes cause instability.
- Live migration or failover failures occur due to insufficient memory, incompatible settings, or node misconfigurations.

### Resolution 1: Cluster and network remediation

1. Validate the cluster health and configuration using the cluster validation wizard or:

   ```powershell
   Test-Cluster
   ```

2. Resolve network issues by reviewing event IDs (for example, 5120 and 1135) and adjusting parameters:

   ```powershell
   (Get-Cluster).SameSubnetThreshold = <value></value>
   ```

3. Ensure consistent patching and proper network/storage configurations across nodes.

### Resolution 2: VM configuration repairs and rebuilds

1. For corrupt configuration files, edit the `.VMCX` file or create a new VM with existing disks.
2. Address saved state or checkpoint issues by removing invalid checkpoints or reattaching disks.

## Escalation and bug reference

If known bugs or product defects are involved (for example, UEFI firmware bugs or cluster communication issues), review vendor advisories and apply the recommended updates or fixes.

## Data collection

Gather the following logs and diagnostic information to assist with troubleshooting:

- Hyper-V event logs:

  ```powershell
  Get-WinEvent -LogName Microsoft-Windows-Hyper-V-VMMS-Admin | Export-Csv -Path <unc path></unc>
  ```

- Cluster logs:

  ```powershell
  Get-ClusterLog -UseLocalTime -Destination <folder></folder>
  ```

- Process dumps for stuck services:

  ```console
  procdump -ma <pid> <output_path></output_path></pid>
  ```

## References

- [Hyper-V performance tuning guide](/windows-server/virtualization/hyper-v)
- [Failover cluster troubleshooting](/sql/sql-server/failover-clusters/windows/failover-cluster-troubleshooting)
