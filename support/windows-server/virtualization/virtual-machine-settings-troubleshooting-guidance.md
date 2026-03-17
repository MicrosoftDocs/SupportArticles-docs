---
title: Guidance for troubleshooting virtual machine settings issues
description: Discusses how to troubleshoot issues that affect virtual machine (VM) settings in Hyper-V environments.
ms.reviewer: kaushika, jeffhugh, v-appelgatet
ms.date: 03/23/2026
ai-usage: ai-assisted
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.custom: 
 - sap:Virtualization and Hyper-V\Configuration of virtual machine settings
---
# Virtual machine settings troubleshooting guidance

## Summary

Use this guide to troubleshoot issues that affect virtual machine (VM) settings in Hyper-V environments. VM settings affect not only how VMs function, but also how effectively you can manage them. This article includes a structured troubleshooting checklist, solutions for common issues, and data collection guidance to help you resolve VM settings problems efficiently.

This article applies to the following scenarios:

- Hyper-V hosts that run on Windows Server
- Standalone and clustered Hyper-V deployments
- Management tools that include Hyper-V Manager, Failover Cluster Manager, System Center Virtual Machine Manager (SCVMM), or Windows PowerShell

If you're experiencing a VM settings issue, start by following the [Troubleshooting checklist](#troubleshooting-checklist). The checklist helps you isolate the cause of the issue and resolve the most common problems before you try more advanced troubleshooting steps.

## Troubleshooting checklist

Before you start deep-dive troubleshooting, follow this checklist to help isolate what's causing the issue. The steps in this checklist might also help you fix the most common underlying issues.

### Step 1: Gather information and review the symptoms

- **Check the change and maintenance history**. Check for any recent changes or operational events, including the following events:
  - Operating system updates
  - Driver or firmware changes
  - Configuration changes
  - Third-party software installations or updates
  - Scheduled maintenance
  - Cluster failover tasks
  - Storage migrations that affect VMs

- **Check host and VM versions:** Make sure that the following components are up to date, and the versions are compatible with one another:
  - Operating system of the Hyper-V host
  - VM configuration
  - Integration services

- **Gather and review log data**. Review log entries for relevant events or messages. For recommendations about which data to collect, see [Data collection](#data-collection). As a starting point, review the following information:
  - System event log
  - Hyper-V event log (In Event Viewer, go to **Applications and Services Logs** > **Microsoft** > **Windows** > **Hyper-V**)
  - Any process dump files that you collected
  - Any network trace data that you collected

### Step 2: Check the health of the VMs and the underlying infrastructure

- Make sure that the VMs and the infrastructure are up to date, including the following components:

  - Windows (operating system and drivers) and Hyper-V
  - Storage hardware, firmware, and drivers
  - Host firmware

- To check the health of the VMs, use Hyper-V Manager. If any of the VMs are "stuck" or unresponsive, finish this checklist. Then, if you need further troubleshooting assistance, see [Troubleshoot inaccessible or unresponsive Hyper-V VMs in clustered or standalone environments](hyper-v-start-state-access-failures-clustered-standalone.md).

- To check the health of the failover clusters and cluster resources, use Failover Cluster Manager. If you find issues in the cluster infrastructure, finish this checklist. Then, see [High Availability troubleshooting documentation for Windows Server](../high-availability/high-availability-overview.md) to identify appropriate troubleshooting assistance.

- To check the health of the storage subsystem, run `chkdsk` in scan mode. Open a Windows Command Prompt window as an administrator, and then run the following command:

  ```console
  chkdsk /scan
  ```

  If `chkdsk` identifies issues, see [Data corruption and disk errors troubleshooting guidance](../backup-and-storage/troubleshoot-data-corruption-and-disk-errors.md).

### Step 3: Check resource availability

For both the Hyper-V hosts and the guest VMs, use Task Manager and Performance Monitor (PerfMon) or other monitoring tools to assess the resource loads in the physical memory, CPU, storage, and network resource categories. Make sure that resources are consistently available. For more information about resource usage and Hyper-V, see [Performance Tuning Hyper-V Servers](/windows-server/administration/performance-tuning/role/hyper-v-server/).

### Step 4: Check permissions

To access VM settings, make sure that you belong to the Hyper-V Administrators group.

> [!NOTE]  
> If you're running Hyper-V on a single computer (such as in a testing environment), membership in the local Administrators group is sufficient to configure VMs.

### Step 5: Compare results across multiple consoles and tools

Try using different methods to access VM settings, and compare the results. Use the following tools:

- Hyper-V Manager
- Failover Cluster Manager
- System Center Virtual Machine Manager (SCVMM)
- Windows PowerShell

## Common issues and solutions

This section addresses the following common issues that involve VM settings:

- [Confidential Hyper-V VMs that run on Windows Server 2022 might intermittently stop responding or restart unexpectedly](#confidential-hyper-v-vms-that-run-on-windows-server-2022-might-intermittently-stop-responding-or-restart-unexpectedly)
- [VM settings window opens slowly or freezes](#vm-settings-window-opens-slowly-or-stops-responding)
- [VMs don't migrate or quick-migrate](#vms-dont-migrate-or-quick-migrate)
- [Can't expand or edit virtual disks (.vhd or .vhdx format)](#cant-expand-or-edit-virtual-disks-vhd-or-vhdx-format)
- [Can't connect to VM console (0x80004005 or other connection errors)](#cant-connect-to-vm-console-0x80004005-or-other-connection-errors)
- [High usage of host CPU or memory, or resource contention](#high-usage-of-host-cpu-or-memory-or-resource-contention)
- [Can't save, change, or locate a VM configuration file](#cant-save-change-or-locate-a-vm-configuration-file)
- [Cluster resource doesn't come online](#cluster-resource-doesnt-come-online)

For more information about each of these issues, see the following sections.

### Confidential Hyper-V VMs that run on Windows Server 2022 might intermittently stop responding or restart unexpectedly

To fix this issue, install the latest Windows update. The [May 23, 2025—KB5061906 (OS Build 20348.3695) Out-of-band](https://support.microsoft.com/topic/may-23-2025-kb5061906-os-build-20348-3695-out-of-band-4ad7e163-1b8d-4774-bb98-d376cae6ea81) update and later updates include the fix for this issue.

### VM settings window opens slowly or stops responding

#### Symptoms

- The VM settings console takes several minutes to open, or stops responding (freezes) entirely.
- Other management tasks, such as live migration or host refresh, run slowly or stop.

#### Possible causes

- The storage subsystem has an excessive number of attached disks or logical unit numbers (LUNs).
- One or more disks or LUNs failed.
- Storage drivers or firmware are outdated.
- Disks aren't set up correctly (for example, VMware-based disks on Windows-based hosts).
- A bottleneck of I/O tasks exists in the storage subsystem.

#### Resolution

1. Make sure to finish at least [Step 2](#step-2-check-the-health-of-the-vms-and-the-underlying-infrastructure) of the troubleshooting checklist. That step addresses some of the possible causes of this issue.

1. Use storage management tools to remove failed or unneeded disks.
1. Check all hosts for placeholder or "dummy" disks, and remove them from the hosts.
1. Where feasible, reduce the number of attached disks or LUNs.
1. Check that all disks are set up correctly for Windows-based hosts.
1. Restart the host.

If the issue persists, collect the data that's described in [Data collection](#data-collection), and then contact Microsoft Support.

> [!NOTE]  
> You might be able to temporarily mitigate a persistent issue of this kind by restarting the affected host.

### VMs don't migrate or quick-migrate

#### Symptoms

- The migration doesn't finish. In some cases, the migration stops at 66 percent complete.
- After the VM migrates to its destination host, it doesn't come online.
- Error entries in the event logs indicate that a cluster disk or resource is unavailable, or a processor is incompatible.

#### Possible cause

Missing or corrupted VM configuration files can interfere with migrations.

> [!IMPORTANT]  
> Several factors can cause migration issues. For more detailed information about troubleshooting live migration, see [Troubleshoot live migration issues](troubleshoot-live-migration-issues.md). That article includes detailed solutions for common resource and compatibility issues.

#### Resolution

To fix this issue, follow these steps:

1. Check the health of the affected VMs. Identify any VMs that have issues that are related to their configuration files.
1. For each affected VM, re-create the VM configuration file, and reattach the .vhd or .vhdx file.

### Can't expand or edit virtual disks (.vhd or .vhdx format)

#### Symptoms

- In Hyper-V Manager, the **Disk expansion** option for the affected disk is unavailable (grayed out).
- You receive the following error message:
  - `Edit is not available because checkpoints exist for this virtual machine.`
- After you merge checkpoints, .avhd or .avhdx files for the affected disk persist.

#### Causes

- Existing checkpoints (also known as snapshots) didn't merge correctly.
- Something interrupted the background disk merge tasks, or the tasks didn't finish.
- The .avhd or .avhdx files are corrupted.
- You tried to edit the virtual disk while the VM is in the running or saved state.

#### Resolution

- Before you try to edit the disk, make sure that you power off the VM.

- Merge all the pending checkpoints. You might have to power off and then power on the affected VM to force the checkpoints to merge.  

  If merge tasks are "stuck," see [Can't create, merge, or delete checkpoints](hyper-v-snapshots-checkpoints-differencing-disks.md#cant-create-merge-or-delete-checkpoints). That article provides detailed instructions for how to deal with checkpoint issues.

### Can't connect to VM console (0x80004005 or other connection errors)

#### Symptoms

- You encounter either or both of the following error messages:
  - `An authentication error has occurred (0x80004005)`
  - `Cannot connect to the virtual machine. Try to connect again...`
- The VM console doesn't respond or disconnects repeatedly.

#### Possible causes

- The host and the management client use incompatible Transport Layer Security (TLS) handshakes or cipher suites.
- Delegated credentials or registry settings aren't set up correctly.
- Firewall settings or network permissions are blocking port 2179 on the host or on intermediate network devices.
- The credentials or certificates are outdated or incompatible.

#### Resolution

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

1. Make sure that the management client (such as Hyper-V Virtual Machine Connection, vmconnect.exe) is healthy and set up correctly.
1. Make sure that the required protocols and protocol versions (such as TLS 1.2) are enabled and that they match on the host and the client.

1. Use Registry Editor to review the registry entries under the `HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\Schannel` subkey. For more information about the registry settings that support TLS, see [Transport Layer Security (TLS) registry settings](/windows-server/security/tls/tls-registry-settings).
   If the settings aren't correct, import the correct Schannel registry entries from a host that's working correctly.
1. Review your Group Policy settings, and make sure that the **Restrict delegation of credentials to remote servers** Group Policy object (GPO) setting is set to **Disabled**.
1. If the issue persists, collect traces by using tools such as [Process Monitor](/sysinternals/downloads/procmon) or Wireshark, and export relevant events from the event logs. If you have to contact Microsoft Support, review [Data collection](#data-collection) for more details.

### High usage of host CPU or memory, or resource contention

#### Symptoms

- VM performance is slow.
- VMs have high latency.
- VMs can't start, and they generate insufficient memory error messages.
- After you make changes or install updates, resource usage remains consistently high on Hyper-V hosts.
- Integration services generate protocol mismatch error messages.

#### Possible causes

- Memory or CPU resources are overcommitted.
- Dynamic memory or Non-Uniform Memory Access (NUMA) aren't set up correctly.
- The integration services are out of date.
- Background processes such as third-party backup or antivirus agents consume more resources than expected.

#### Resolutions

1. Make sure that integration services are up to date for all VMs.
1. Review and optimize the Hyper-V dynamic memory and buffer configuration. For more information, see the following articles:
   - [Hyper-V Dynamic Memory Overview](/windows-server/virtualization/hyper-v/dynamic-memory)
   - [Hyper-V Virtual NUMA Overview](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn282282(v=ws.11))
1. To avoid overcommitting resources, review the available host resources, and optimize the allocations for VMs. For more information, see [Virtual Machine Resource Controls](/windows-server/virtualization/hyper-v/manage/manage-hyper-v-cpugroups).
1. Restart the host.
1. After you make changes, monitor resource usage. If issues persist, you might have to continue to tune allocations. Use tools such as Task Manager, Process Monitor, or Performance Monitor (Perfmon).

### Can't save, change, or locate a VM configuration file

#### Symptoms

- In the VM management console, you can't edit CPU, memory, network, or disk settings. The VM settings are unavailable (grayed out).
- The VM doesn't start, and you receive the following error message: "No boot entries are configured for this VM."
- The information about the VM on the GUI management console doesn't match the information that PowerShell cmdlets generate.
- In File Explorer on the host, you can't find the VM configuration file, or the configuration file references the wrong path.

#### Possible causes

- After you delete or migrate storage, the configuration file is missing or corrupted.
- Permissions aren't set up correctly for the file share or cluster resource that stores the configuration file.
- The host operating system is out of date.

#### Resolutions

> [!NOTE]  
> If your GUI management client is slow or unresponsive, use PowerShell cmdlets to manage VMs.

1. Make sure that the operating systems on all hosts (or cluster nodes, in a clustered deployment) are up to date.
1. In File Explorer, check that the configuration file exists in the configuration file folder. The default folder is `C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Machines`. This folder should contain a .vmcx file that you can match to the ID of the affected VM.
1. Make sure that your management client uses the correct file paths for the VM files.
1. Make sure that your management client and the VMs have permissions to modify the configuration files. To review and set permissions, you can use the [icacls](/windows-server/administration/windows-commands/icacls) command.

### Cluster resource doesn't come online

#### Symptoms

- In a clustered Hyper-V environment, you restart the cluster hosts. Afterwards, one or more cluster resources don't come online.
- Error entries in the event logs indicate issues that relate to cluster resources or state transitions.

#### Possible causes and resolutions

This issue has many possible causes. For more detailed troubleshooting information, see [Can't bring a clustered resource online troubleshooting guidance](/troubleshoot/windows-server/high-availability/troubleshoot-cannot-bring-resource-online-guidance).

## Data collection

If you need additional assistance, collect the following data, and then contact [Microsoft Support](https://support.microsoft.com/contactus).

### General data

- Version information (and build information, if applicable) for your infrastructure, including the following components: 
  - Windows Server
  - Hyper-V
  - Integration services
  - Storage devices, firmware, and drivers

- Screenshots of unexpected behavior or error messages.
- Trace or dump file data, including data files from ProcDump, ProcMon, PerfMon, or `livekd`.

### Data for Hyper-V related issues

Use Microsoft's troubleshooting scripts (TSS) to automatically gather information for troubleshooting. For instructions, see [Collect data to analyze and troubleshoot Hyper-V scenarios](../../windows-client/windows-tss/collect-data-analyze-troubleshoot-hyperv-scenarios.md?context=/troubleshoot/windows-server/context/context).

Additionally, gather the following information:

- Relevant events from the System and Application logs, and events from the Hyper-V log. The Hyper-V log is available in Event Viewer at **Applications and Services** > **Microsoft** > **Windows** > **Hyper-V**. You can export this information from Event Viewer.

- VM configuration information. Use Hyper-V Manager or PowerShell to export this information.

### Data for cluster-related issues

Use Microsoft troubleshooting scripts (TSS) to automatically gather information for troubleshooting. For instructions, see [Collect data to analyze and troubleshoot clustering and high availability scenarios](../../windows-client/windows-tss/collect-data-analyze-troubleshoot-windows-clustering-scenarios.md?context=/troubleshoot/windows-server/context/context).

Additionally, gather the following information:

- Cluster logs from all nodes. To collect logs, run the following command on one of the cluster nodes:

  ```powershell
  Get-ClusterLog -UseLocalTime -Destination <folder path>
  ```

- Relevant event logs from the FailoverClustering and DNS Server event log channels.
- Details of the CNO object in Active Directory, including security permissions.

## References

- [Hyper-V virtualization in Windows Server and Windows](/windows-server/virtualization/hyper-v/overview)
- [Hyper-V Dynamic Memory Overview](/windows-server/virtualization/hyper-v/dynamic-memory)
- [Hyper-V Virtual NUMA Overview](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn282282(v=ws.11))
- [Plan for Hyper-V networking in Windows Server](/windows-server/virtualization/hyper-v/plan/plan-hyper-v-networking-in-windows-server)
- [Process Monitor v4.01](/sysinternals/downloads/procmon)
- [Export and import virtual machines](/windows-server/virtualization/hyper-v/deploy/export-and-import-virtual-machines)
- [Storage Spaces overview in Windows Server](/windows-server/storage/storage-spaces/overview)
- [Transport Layer Security (TLS) registry settings](/windows-server/security/tls/tls-registry-settings)
- [Can't bring a clustered resource online troubleshooting guidance](/troubleshoot/windows-server/high-availability/troubleshoot-cannot-bring-resource-online-guidance)
