---
title: Troubleshoot Inaccessible or Unresponsive Hyper-V Virtual Machines in Clustered or Standalone Environments
description: Troubleshoot Hyper-V virtual machines (VMs) that don't start, become stuck in transitional states, or become inaccessible in either clustered or standalone environments.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, jeffhugh, v-tappelgate
ms.custom:
- sap:virtualization and hyper-v\virtual machine state
- pcy:WinComm Storage High Avail
ai-usage: ai-assisted
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Troubleshoot inaccessible or unresponsive Hyper-V VMs in clustered or standalone environments

This article provides a detailed guide to help you troubleshoot and fix Hyper-V virtual machines (VMs) that don't start, become "stuck" (stop responding) in transitional states (such as starting, stopping, saved, or paused), or become inaccessible in either clustered or standalone environments. Many of these issues produce similar symptoms even if they have different causes. For example, the same issue that causes a running VM to stop responding might prevent an offline VM from starting. Additionally, the symptoms might appear at different levels of your infrastructure, such as Hyper-V Manager or Failover Cluster Manager.

## Troubleshooting checklist

### Step 1: Identify the scope of the issue

1. Use Hyper-V Manager, Failover Cluster Manager, or Windows PowerShell to identify affected VMs, hosts, and cluster resources. Note any error messages.
1. Make sure that VMs have unique GUIDs.
1. If VMs are stuck in any of the following states, see [VM "hangs" or appears to be "stuck" in a transitional state (such as Starting, Stopping, or Restoring)](#vm-hangs-or-appears-to-be-stuck-in-a-transitional-state-such-as-starting-stopping-or-restoring).
     - Starting
     - Stopping
     - Saved-critical
     - Running critical
     - Paused
     - Restoring
     - Online pending

1. Review system event logs, Hyper-V logs, and cluster event logs. Note any relevant entries, error messages, and Event IDs. The following Event IDs and Event ID combinations indicate common issues. Follow the links to see specific solutions for these issues:

   - [Event ID 32 and Event ID 21502](#event-id-32-failed-to-connect-nic-and-event-id-21502-virtual-machine-xxxxxxx-failed-to-startthe-switch-port-connection-for-network-adapter-xxxxxxx-is-invalid)
   - [Event ID 1069](#event-id-1069-cluster-vm-failed-to-startcant-bring-a-resource-online)
   - [Event ID 1205](#event-id-1205-cant-bring-a-resource-online)
   - [Event ID 1135, Event ID 1795, Event ID 5257, and virtual machines are paused](#event-id-1135-event-id-1795-event-id-5257-and-virtual-machines-are-paused)
   - Event ID 1135. At a general level, Event ID 1135 indicates that one or more cluster nodes were removed from the active failover cluster membership. For more information about how to troubleshoot this issue, see [Troubleshoot cluster issue with Event ID 1135](../high-availability/troubleshoot-cluster-event-id-1135.md).
   - Event ID 5120. At a general level, Event ID 5120 indicates an issue that involves the cluster shared volume (CSV). For more information about how to troubleshoot this issue, see [Event ID 5120 Cluster Shared Volume troubleshooting guidance](../high-availability/event-id-5120-cluster-shared-volume-troubleshooting-guidance.md).

1. Note any recent changes or incidents that affected your infrastructure. Such changes include system or driver updates, and interruptions in power or network connectivity.
1. Note any unusual system activity, such as the following behavior:

   - VMs repeatedly restart.
   - VMs don't live migrate successfully.
   - Clusters fail over or don't fail over correctly.
   - Cluster resources are offline.
1. For the latest known issue and notification information, review the [Windows Server release information](/windows/release-health/windows-server-release-info) pages.
1. For information about updates and known issues that might affect your hardware, contact your hardware vendors and other third-party vendors.

### Step 2: Make sure that the operating system and drivers are up to date

1. Make sure that your disk and network hardware drivers are up to date.
1. Make sure that all servers have the latest Windows Update releases installed.
1. In a clustered environment, make sure that all the nodes in each cluster run the same Windows Server release.

### Step 3: Review the permission and security settings

Make sure that your security infrastructure accommodates Hyper-V. The following technologies can cause issues:

- Antivirus or third-party filter drivers interfere with Hyper-V by blocking file access or causing merge failures.
- BitLocker-locked disks might prevent VMs from starting after updates or restarts. BitLocker also might block access to virtual machine files. This behavior might prevent VMs from starting or responding.

1. Review the permissions of the Hyper-V service account. This account must have full control over VM files and folders.
1. Review [Recommended antivirus exclusions for Hyper-V hosts](antivirus-exclusions-for-hyper-v-hosts.md), and make sure that the correct exclusions are in place.
1. Use [fltmc](/windows-hardware/drivers/ifs/development-and-testing-tools#fltmcexe-command) to identify and unload problematic filter drivers. Open a Windows Command Prompt window, and then run the following command:

   ```console
   fltmc unload <DriverName>
   ```

1. If BitLocker is enabled on the volume, run the following command at a PowerShell command prompt:

     ```powershell
      manage-bde -unlock <DriveLetter>: -RecoveryPassword <RecoveryPassword>
     ```

### Step 4: Review the storage subsystem and the file system

> [!IMPORTANT]  
> This section instructs you to run the `chkdsk /f /r` command. This command requires exclusive access to the target disk, and takes some time to finish.

1. Use Disk Management or the [`diskpart`](/windows-server/administration/windows-commands/diskpart) tool to verify that all disk volumes are online and correctly assigned.
1. If a disk volume is RAW or missing, reassign its drive letter, and then use [`chkdsk`](/windows-server/administration/windows-commands/chkdsk) to repair the volume. Open an administrative Windows Command Prompt window, and then run the following command:

   ```console
     chkdsk <DriveLetter>: /f /r
   ```

   If this command doesn't fix your disk issues, see the following articles for more information:

   - [Data corruption and disk errors troubleshooting guidance](../backup-and-storage/troubleshoot-data-corruption-and-disk-errors.md)
   - [iSCSI storage connectivity troubleshooting guidance](../backup-and-storage/iscsi-storage-connectivity-troubleshooting.md)

1. In the volume that hosts your VM files, review the contents of the VM folder. Make sure that the appropriate VM files (.vmcx (configuration), .vmrs (run-time state), .vhdx (disk), and .avhdx (differencing disk)) exist.

   - If a VM's .vmcx file is missing or corrupted, use the .vhdx file to build a new VM. You can also restore the affected VM from a backup.
     > [!NOTE]  
     > If a configuration file is missing or corrupted, Hyper-V can't recognize or start the VM. Configuration files might be damaged after a migration fails, or after a storage issue or an abrupt shutdown occurs.
   - If a VM's .avhdx file is missing or corrupted, run the following cmdlet at a PowerShell command prompt:

     ```powershell
      Set-VHD -Path <VhdxPath> -ParentPath <ParentVhdxPath> -IgnoreIDMismatch
     ```

### Step 5: Review cluster health

If you're using Hyper-V in a failover cluster, the cluster must be healthy for the VMs to function correctly. Issues in the cluster configuration can cause many different issues, including failures in live migration, unexpected VM restarts, and unexpected failover events.

Validate cluster health and configuration either by using the Cluster Validation wizard or by running the following cmdlet at a PowerShell command prompt:

   ```powershell
   Test-Cluster
   ```

If the cluster isn't functioning correctly, see [High Availability troubleshooting documentation for Windows Server](../high-availability/high-availability-overview.md).

### Step 6: Remove VM saved states or checkpoints

Issues that affect checkpoints (also known as *snapshots*), such as orphaned checkpoints, chain corruption, or incomplete merges, might prevent a VM from functioning or prevent an offline VM from starting.

> [!IMPORTANT]  
> If you remove a VM's checkpoints, the VM might lose any unsaved or transient data.

To remove checkpoints, run the following cmdlets at a PowerShell command prompt:

   ```powershell
   Get-VMSnapshot -VMName "<VMName>" | Remove-VMSavedState
   ```

## Common issues and solutions

### Event ID 32 ("Failed to connect NIC") and Event ID 21502 ("Virtual Machine xxxxxxx failed to start...The switch port connection for "Network Adapter" (xxxxxxx) is invalid")

This combination of events means that the specified VM can't connect to a network.

To fix this issue, open Hyper-V Manager, and go to the settings for that VM. Select the correct virtual network.

### Event ID 1069 (Cluster VM failed to start/can't bring a resource online)

This event indicates that a VM tried to start or fail over, but it couldn't register its configuration with the Virtual Machine Management Server service. Typically, this issue means that the VM's .vmcx file is corrupted.

To fix this issue, use the .vhdx file to build a new VM. You can also restore the affected VM from a backup.

### Event ID 1205 (Can't bring a resource online)

This event indicates that one or more resources might be in a failed state. For more information about how to troubleshoot this issue, see the following articles:

- [Can't bring a clustered resource online troubleshooting guidance](../high-availability/troubleshoot-cannot-bring-resource-online-guidance.md)
- [Considerations for Backing Up Virtual Machines on CSV with the System VSS Provider](/previous-versions/system-center/data-protection-manager-2010/ff634192(v=technet.10))

### Event ID 1135, Event ID 1795, Event ID 5257, and virtual machines are paused

Follow these steps to resolve the issue by restarting the affected VMs:

1. Open the Hyper-V Manager or the Failover Cluster Manager.
1. Identify the VMs that are in a "paused" state.
1. Right-click each affected VM, and then select **Restart**.
1. To make sure that the VMs return to an operational state, monitor their progress.

For more information, see [Unresponsive VMs after cluster failover failure](unresponsive-vms-after-cluster-failover-failure.md).

### VM "hangs" or appears to be "stuck" in a transitional state (such as Starting, Stopping, or Restoring)

> [!IMPORTANT]  
> This procedure instructs you to stop VM processes. When you stop a VM in this manner, the VM might lose any unsaved or transient data.

1. Identify the stuck VM's process ID (PID) either by using Task Manager or by running the following cmdlets at a PowerShell command prompt:

   ```powershell
   Get-Process | Where-Object {$_.Name -like "*vmwp*"}
   ```

1. To end the VM process, run the following command at a PowerShell or Windows command prompt:

   ```powershell
   taskkill /PID <PID> /F
   ```

1. Restart the Virtual Machine Management Service.
1. If the VMs are still stuck after the service restarts, restart the host computer.

## Data collection

To assist with troubleshooting, gather the following logs and diagnostics:

- Hyper-V event logs:

  ```powershell
  Get-WinEvent -LogName Microsoft-Windows-Hyper-V-VMMS-Admin | Export-Csv -Path <UncPath>
  ```

- Cluster logs:

  ```powershell
  Get-ClusterLog -UseLocalTime -Destination <Folder>
  ```

- Process dump files for stuck services or processes:

  ```console
  procdump -ma <PID> <OutputPath>
  ```

## References

- [Data corruption and disk errors troubleshooting guidance](../backup-and-storage/troubleshoot-data-corruption-and-disk-errors.md)
- [iSCSI storage connectivity troubleshooting guidance](../backup-and-storage/iscsi-storage-connectivity-troubleshooting.md)
- [Can't bring a clustered resource online troubleshooting guidance](../high-availability/troubleshoot-cannot-bring-resource-online-guidance.md)
- [Troubleshoot cluster issue with Event ID 1135](../high-availability/troubleshoot-cluster-event-id-1135.md)
- [Event ID 5120 Cluster Shared Volume troubleshooting guidance](../high-availability/event-id-5120-cluster-shared-volume-troubleshooting-guidance.md)
- [Recommended antivirus exclusions for Hyper-V hosts](antivirus-exclusions-for-hyper-v-hosts.md)
- [High Availability troubleshooting documentation for Windows Server](../high-availability/high-availability-overview.md)
- [Considerations for Backing Up Virtual Machines on CSV with the System VSS Provider](/previous-versions/system-center/data-protection-manager-2010/ff634192(v=technet.10))
- [Hyper-V performance tuning guide](/windows-server/virtualization/hyper-v)
- [Failover cluster troubleshooting](/windows-server/failover-clustering/failover-clustering-overview)
