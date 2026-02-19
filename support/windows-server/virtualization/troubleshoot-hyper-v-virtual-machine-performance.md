---
title: Troubleshoot Hyper-V Virtual Machine Performance
description: Resolves issues in the Hyper-V virtualization component in Windows Server environments.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:Virtualization and Hyper-V\Virtual machine performance
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Hyper-V virtual machine performance

## Summary

Hyper-V is a core component for virtualization in Windows Server environments. It enables the management of multiple virtual machines (VMs) on a single or clustered host infrastructure. However, administrators frequently encounter various VM startup failures and performance issues that can impede business operations. Such problems can be caused by hardware limitations, configuration changes, updates, networking, storage, and software or file system corruption. Rapid and comprehensive troubleshooting is essential to minimize downtime and preserve data integrity. This article is designed to help administrators resolve Hyper-V VM issues, addresses common failure modes and their resolutions, and provide best practices for data collection and cause analysis.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting:

- **Check the error messages and event logs**
   - Note the exact wording, event IDs, and timing.
- **Assess available host resources**
   - CPU, memory, storage, and network availability.
- **Review what changed recently**
   - Updates, configuration, hardware, or firmware changes.
- **Verify VM and host configuration**
   - Startup RAM, CPU count, disk and network settings.
- **Check for storage connectivity and availability**
   - Disk health, cluster state, network storage paths.
- **Test VM login and domain trust**
   - For domain-attached systems, make sure that trust isn't broken.
- **Review failover clustering and quorum:**
   - Node status, cluster logs, and network configuration.
- **Check for antivirus and security interference**
   - Recent AV/EDR changes or scan activity.
- **Verify registry and file and folder permissions**
   - Check especially for Hyper-V process-related subkeys and folders.
- **Check for known bugs or hotfixes**
   - Review Microsoft documentation and recent release notes.

## Common issues and solutions

The following sections detail the most common failure modes and provide step-by-step solutions.

### VM doesn't start, insufficient memory and resources

#### Symptoms

- Error: "Failed to initialize memory: Insufficient memory (0x8007000E)."
- Error: "Virtual machine failed to start due to insufficient memory."
- Hosts or VMs are unresponsive after updates or restart.

#### Resolution

1. Review host memory usage in Hyper-V Manager or Task Manager.
2. Reduce the VM startup memory value (**Hyper-V Manager** > **VM** > **Settings** > **Memory**).
3. Increase physical RAM on the host.
4. If using dynamic memory, set reasonable minimums and maximums to avoid overallocation.
5. Restart the VM.

### VM fails and returns "The data is invalid" (0x8007000D) or certificate or registry errors

#### Symptoms

- Error: "The data is invalid. (0x8007000D)"
- Event logs: ACCESS DENIED when accessing registry keys.
- VMs don't start after a recent update (for example, KB5051979).

#### Resolution

1. Use ProcMon to identify ACCESS DENIED registry events for vmwp.exe.
2. Correct permissions on the relevant keys (for example, HKU\.DEFAULT\Software\Policies\[Vendor]\SystemCertificates\CA):    - Open regedit as administrator.
    - Right-click > "Permissions" > add or adjust the necessary users and groups.
3. Validate and repair digital signatures on key DLLs using Sysinternals sigcheck.
4. Make sure that required antivirus/EDR exclusions are available for Hyper-V directories.
5. Check disk and network adapter configuration—remove and re-add if necessary.
6. Restart the host and test VM startup.

### VM shows reduced CPU and memory after upgrade

#### Symptoms

- Device Manager shows CPUs, but Task Manager/MSinfo shows fewer than assigned.
- Major performance drop after updating the VM or Hyper-V host.
- Only affects VMs upgraded from older OS versions.

#### Resolution

1. Remove any numproc value from BCD:

    ```console
    bcdedit /deletevalue {default} numproc
    ```

2. Set registry subkeys for speculative execution fix:

    ```plaintext
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 72 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f
    ```

3. Retart the VM.
4. Verify CPU and memory recognition through Task Manager and PowerShell.

### Disk or file system corruption, can't start, delete, or attach disks

#### Symptoms

- Error: "Failed to open because of error. The file or directory is corrupted and unreadable."
- Error: 0x80070570 when deleting a file.
- Event IDs: 8, 153, 129 for disk failures or resets.

#### Resolution

1. Try file system repair:

    ```console
    chkdsk [drive]: /f
    ```

2. Back up all critical data before repair if possible.
3. For VM config/VHD corruption:
    - Create a new VM, and attach the existing (repaired) VHD/VHDX.
    - Start from recovery media, if it's necessary, and repair Windows (use sfc /scannow, startrec /fixstart).
4. Update any outdated storage or network drivers and firmware.
5. Verify the cluster quorum and storage path.

### Cluster and CSV issues: Paused state, restarts, unexpected failover

#### Symptoms

- Event ID 5120 (Cluster Shared Volume paused state)
- Event ID 1135 (Node removal from cluster)
- Cluster logs of resource failures, missed heartbeats
- VMs unexpectedly restart or fail over

#### Resolution

1. Update all storage and network adapter drivers and firmware on all cluster nodes.
2. Check and adjust cluster quorum settings as necessary.
3. Remove any third-party antivirus/EDR or exclude cluster, Hyper-V, and storage directories according to Microsoft guidance.
4. Investigate recent hardware and network changes (switch modules, cables, firewalls).
5. Rebalance VM workloads across cluster nodes.
6. Use the following commands to generate and collect cluster logs:

    ```powershell
    Set-ClusterLog -UseLocalTime -Level 5 -Destination C:\temp
    ```

7. Work with storage and network vendors if hardware issues or repeated error IDs are found in logs.

### Domain trust and aAuthentication or login failures

#### Symptoms

- Error: "The trust relationship between this workstation and the primary domain failed."
- Can't log in through Hyper-V Manager, but RDP works.
- VMs are stuck at "Please wait" or can't log in.

#### Resolution

1. Remove the VM from the domain, and then rejoin it.
2. Check and correct the computer account status in Active Directory.
3. For sign-in errors, clean up old profiles or check for GPO or profile corruption.
4. Make sure that domain controllers are healthy and reachable from VM/hypervisor.

### Performance issues: slow VM, high latency, app stops responding

#### Symptoms

- Jobs or backups take two-to-three times longer than usual.
- Disk idle time is low, average disk latency greater than 25ms.
- Event logs show repeated entries of  "I/O request took XXXXX ms to complete."
- VM is unresponsive, especially during heavy I/O.

#### Resolution

1. Run disk and network performance monitoring:

    ```console
    logman create counter PerfLog-Short-Interval -f bincirc -si 00:00:01 -o c:\Temp\ percentComputerName percent_PerfLog-Short-Interval.blg -c \Memory\\* \Network Interface(\*)\\* \Processor(\*)\\* \PhysicalDisk(\*)\\* \LogicalDisk(\*)\\*
    logman start PerfLog-Short-Interval
    logman stop PerfLog-Short-Interval
    ```

2. Identify storage and network bottlenecks. Update drivers and firmware.
3. Distribute heavy workloads across separate hosts and storage arrays.
4. Work with application vendors if issue appears in only specific workloads.
5. Check for and eliminate network misconfiguration (disable or enable VMQ, RSS, and so on).
6. Restart VMs or hosts as necessary to clear hardware or driver lockups.

## Common issues quick reference table

| Symptom | Root cause | Resolution |
| --- | --- | --- |
| "Insufficient memory" / (0x8007000E) | Host lacks free RAM, oversubscription | Add RAM to host or reduce VM startup memory |
| "The data is invalid" (0x8007000D); VMwp.exe ACCESS DENIED in logs | Registry or certificate permission errors | Fix registry permissions, validate signatures, set AV exclusions |
| Only some CPUs recognized, perf drops less than 50 percent after upgrade | start configuration or registry limit | Remove BCD numproc, add registry FeatureSettingsOverride/Mask, restart |
| File system errors, for example, 0x2; chkdsk errors; can't delete file | Corrupt NTFS metadata or VM files | Run chkdsk /f, back up, attach VHD to new VM, repair or restore |
| CSV paused (Event 5120); Node removal (Event 1135); restarts | Network, driver, or storage issues, AV | Update drivers and firmware, check cluster config, remove or adjust AV |
| "Domain trust failed"; Hyper-V Manager login only fails | Broken trust relationship or AD/GPO issue | Rejoin domain, check AD account, clear cached credentials |
| Performance drops (Disk idle less than 95 percent, latency greater than 25ms, Event 9, 153, and so on) | Storage/network bottleneck or cache configuration | Update firmware, move VMs, adjust workload balance, review cache |

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue.

- **Event logs:** C:\Windows\System32\winevt\logs\system.evtx, application.evtx
- **Cluster logs:** Use Set-ClusterLog to export diagnostic information
- **Performance logs:** Use Perfmon/logman
- **Storage/network driver and firmware inventory:** Pull by using device manager or Get-WmiObject Win32_PnPSignedDriver
- **Registry exports:** Use regedit to save and analyze suspect keys (for example, under Memory Management)
- **Screenshots:** Of errors, settings dialogs, device manager, and so on
- **Active Directory logs:** For domain trust and authentication issues

## References

- [Hyper-V troubleshooting](/windows-server/virtualization/hyper-v/)
