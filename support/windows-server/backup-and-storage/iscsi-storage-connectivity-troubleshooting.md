---
title: iSCSI Storage Connectivity Troubleshooting Guidance
description: Resolves issues that occur in SAN-based and iSCSI storage environments in Windows Server.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw
ms.custom:
- sap:Backup, Recovery, Disk, and Storage\iSCSI
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# iSCSI storage connectivity troubleshooting guidance

## Summary

SAN-based and iSCSI storage environments in Windows Server (2025, 2022, 2019, and 2016) are essential for clustering, high-availability, virtualization, and large-scale file services. However, these environments can experience various issues, from connectivity dropouts and disk corruption to performance degradation and cluster failures. Causes range from misconfiguration and driver-firmware mismatches to underlying network instability, hardware faults, and operating system or storage subsystem bugs. This article provides a step-by-step approach to diagnose and resolve common iSCSI, disk, and cluster-related failures to help you maintain high service availability, data integrity, and operational efficiency.

## Known issues

### After you restart Windows Server 2022, the list of favorite target IPs for the iSCSI configuration is incorrect

This issue is a display issue that might occur even if the back-end configuration is correct. Microsoft is aware of the issue.

### Backups become unresponsive on Windows Server 2025 ReFS drives

To fix this issue, install the latest Windows Update. The [December 9, 2025—KB5072033 (OS Build 26100.7462)](https://support.microsoft.com/topic/december-9-2025-kb5072033-os-build-26100-7462-fca31d8d-5fe8-4b5e-9591-6641ef1d26a1) update and later updates contain the fix for this issue.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting:

- **Networking**
  - Are iSCSI, management, and client networks segregated and correctly routed?
  - Are maximum transmission units (MTUs), virtual LANs (VLANs), Jumbo Frames, and Flow Control/ROCE/PFC consistently configured?
- **Firmware and driver updates**
  - Are network adapters, storage controllers, and storage array firmware current and vendor-supported?
- **Storage infrastructure**
  - Are all iSCSI, multipath I/O (MPIO), and iSCSI target device drivers and tools up to date?
  - Are all storage area network (SAN) zoning and logical unit number (LUN) masking correct?
- **Windows configuration**
  - Does the appropriate MPIO policy exist? Verify that disks and LUNs are visible and healthy in Disk Management.
  - Are cluster and quorum configurations validated (Test-Cluster, validation reports)?
  - Are antivirus exclusions set for storage and cluster paths?
  - Is the correct Group Policy policy enabled for disk and volume access?
- **Backup and restore**
  - Does the VSS and backup configuration comply with storage guidelines?
  - Are shadow copies and snapshots managed and not excessive?
- **Documentation and change log**
  - Are all infrastructure changes that occurred before the incident (updates, configuration edits, firmware, hardware swaps, and so on) documented?

## Common issues and solutions

The following sections describe the most common issues, and provide step-by-step solutions for them.

> [!IMPORTANT]  
> To use these solutions, make sure that you install the following Windows PowerShell modules:
>
> - NetAdapter
> - Hyper-V
> - iSCSI
> - MPIO
> - Storage
> - Microsoft.PowerShell.Utility

### iSCSI disks disconnect, failover doesn't work correctly, or disks are "surprise removed"

#### Symptoms

- After a restart, drives or volumes are offline or marked as RAW.
- Event ID 157: "Disk X has been surprise removed"
- iSCSI events and errors: Event IDs 9, 20, 27, 39, 153, "Target did not respond," "Initiator failed to connect," "IO operation at logical block address was retried."

#### Causes

- Network instability.
- MPIO configuration errors.
- Network adapters or Load Balancing/Failover (LBFO) NIC teams aren't ready when iSCSI services start. Therefore, ports can't bind correctly.

  > [!IMPORTANT]  
  > LBFO NIC teaming is deprecated for Windows Server Hyper-V deployments as of Windows Server 2022. Use switch embedded teaming (SET) instead. For more information, see the [Features no longer in development](/windows-server/get-started/removed-deprecated-features-windows-server) section of "Features removed or no longer developed in Windows Server."

- Mismatched VLAN/MTU/Jumbo settings, improper failover scripts.
- Outdated firmware or drivers.
- Resource exhaustion on the storage area network (SAN) or network attached storage (NAS) array.

#### Resolution

1. To review the health of the network, follow these steps:
   1. Restart the affected computer or virtual machine (VM), and then verify that the network adapter is ready.
   1. If you configured switch logs or port counters for this computer, verify that there aren't any anomalies in the data.
   1. To gather information about the network status, go to the PowerShell Command Prompt window, and then run the [`Get-NetAdapter`](/powershell/module/netadapter/get-netadapter), [`Get-NetAdapterStatistics`](/powershell/module/netadapter/get-netadapterstatistics), [`Get-VMSwitch`](/powershell/module/hyper-v/get-vmswitch), and [`Get-VMSwitchTeam`](/powershell/module/hyper-v/get-vmswitchteam) cmdlets.
   1. Make sure that MTUs and Jumbo Frames are consistent end to end.
   1. Resolve any issues that you find. For more detailed information about how to troubleshoot specific connectivity issues, see [Windows Server networking troubleshooting documentation](../networking/networking-overview.md). If you need more detailed troubleshooting data, open a Windows Command Prompt window, and collect a network trace by running the following command:

      ```console
      Netsh trace start scenario=netconnection capture=yes tracefile=c:\os.etl
      ```

1. On the affected computer, update network adapter, storage, and firmware drivers to the latest vendor-supported versions.
1. To verify the health of the SAN or NAS, contact the vendor for more information about logs and event triggers.
1. Make sure that applications and scripts don't rely on disk numbers. Path failovers can change the numbers.

1. To review disk mappings and properties, use the [`Get-Disk`](/powershell/module/storage/get-disk), [`Get-PhysicalDisk`](/powershell/module/storage/get-physicaldisk), [`Out-GridView`](/powershell/module/microsoft.powershell.utility/out-gridview) cmdlets.

1. To review the iSCSI and MPIO configuration, follow these steps:
   1. To gather information about the path and session status, go to the PowerShell command prompt, and then run the [`Get-IscsiConnection`](/powershell/module/iscsi/get-iscsiconnection), [`Get-IscsiSession`](/powershell/module/iscsi/get-iscsisession), and [`Get-MSDSMAutomaticClaimSettings`](/powershell/module/mpio/get-msdsmautomaticclaimsettings) cmdlets.
   1. To review specific persistent connections, go to the PowerShell command prompt, and then run the following cmdlet:

      ```powershell
      Connect-IscsiTarget -NodeAddress <Target> -TargetPortalAddress <IPAddress> -TargetPortalPortNumber 3260 -IsPersistent $true
      ```

   1. If any of the storage IP addresses are incorrect, follow these steps:
      1. In the search bar of the affected computer, enter _iSCSI Initiator_, and then select **iSCSI Initiator** in the search results.
      1. Select **Favorite Targets**, select the target that you want to reconfigure, and then select **Remove**.
      1. To add the target, select **Add**, and then provide the configuration information for the new target.
   1. If the affected computer is part of a cluster, make sure that the computer routes iSCSI traffic through dedicated network adapters. Don't use the same adapters as production or cluster network traffic.

1. To clean up an outdated configuration, follow these steps:
   1. In iSCSI Initiator, select **Discovery**, and then select **Refresh**. If the list contains a target that's incorrect or not used, select it, and then select **Remove**.
   1. At the PowerShell command prompt, run the following cmdlet:

      ```powershell
      Get-IscsiSession | Remove-IscsiSession
      ```

1. To change the disk and iSCSI timeout values, follow this step:
   [!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]
   - In the `HKLM\SYSTEM\CurrentControlSet\Services\disk` subkey, set the `TimeOutValue` value to a larger number, such as **179**.

1. If you suspect that storage device itself is causing issues, contact your storage vendor.

### Volumes change to RAW, file system is corrupted, or metadata is corrupted

#### Symptoms

- A file share becomes inaccessible.
- A copy or backup operation fails.
- Message: "The file system detected a checksum error" or "Device... has a bad block."
- An NTFS, RECORD, or ReFS volume unexpectedly becomes RAW.

#### Causes

- Improper shutdown or storage disconnects
- Physical disk or controller hardware failure
- Partition table or volume boundary errors
- Service dependencies not set (after a restart, file shares are missing)

#### Resolution

To check for and fix volume issues, follow these steps:

1. Back up the affected volume.
1. To detect and repair corruption, run the appropriate disk utility:

   - For an NTFS volume, run the following commands at a Windows command prompt:

     ```console
     chkdsk /f <Drive>:
     chkdsk /r <Drive>:
     ```

     > [!NOTE]  
     > In these commands, \<Drive> represents the letter of the drive where the affected volume resides.

   - For an ReFS volume, run the following commands at a Windows command prompt:

     ```console
     refsutil salvage -QA <Drive> <LogFolder> <RecoveredDataFolder> -x
     refsutil salvage -FA <Drive> <LogFolder> <RecoveredDataFolder> -x
     ```

     > [!NOTE]  
     >
     > - \<Drive> specifies the ReFS volume to process in the format "E:" or the path to the volume mount point.
     > - \<LogFolder> specifies the location to store temporary information and logs. This folder must reside on a volume that doesn't reside on \<Drive>.
     > - \<RecoveredDataFolder> specifies the location that identified files are copied to. This folder must reside on a volume that doesn't reside on \<Drive>.
     > - The `-FA` switch starts a deeper scan than the `-QA` switch does. The deeper scan might take much longer to finish.

1. If the disk appears to be RAW or unformatted, try one or more of the following methods:
   - Attach the disk to a computer that runs a later version of Windows Server.
   - If you're using Windows Server 2019 or a later version to connect to the disk, use `rfsutil` to back up and recover data.
   - Use other file recovery tools to back up and recover data.

1. To verify and fix partition tables, run one of the following tools:

   - The [Disk Management console](disk-management-snap-in-basic-dynamic-disks.md) (in the search bar, type **diskmgmt.msc**, and then select **Disk Management** in the search results).
   - [diskpart](/windows-server/administration/windows-commands/diskpart) (use at a Windows command prompt).

1. To check for underlying disk issues, use vendor diagnostics tools to review disk information (including SMART data). If it's necessary, replace the disk.

1. To set service dependencies, run the following command at a Windows command prompt:

   ```console
   sc configuration LanmanServer depend= MSiSCSI
   ```

   > [!NOTE]  
   > You can also use the Services console (services.msc) to set dependencies. Make sure that critical services are set to **Automatic (Delayed Start)**.

1. If this issue affects virtual machines (VMs), check the VM configuration or the Hyper-V configuration. Make sure that the drives aren't listed as removable.

1. To recover file shares, manually restart the LanmanServer service. You can use the Services console or the command line.

1. If the previous steps don't resolve the issue, restore the volumes to a point before the corruption occurred.

### Cluster resource, ownership, or quorum issues

#### Symptoms

- Cluster disks go offline or don't come online.
- You see the following message: "Cluster Disk X contains an invalid mount point."
- Event IDs 98 or 55 occur.
- Failover Cluster Manager shows failed resources, lost quorum, or invalid signatures.

#### Cause

- The cluster quorum configuration is incorrect.
- Disk or signature conflicts (duplicate VHDs, snapshots attached) exist.
- Permissions for cluster-related files (MachineKeys) are missing certificate/key pairs.
- Storage vendor persistent reservation (PR) has a mismatch or stale entries.

#### Resolution

1. Make sure the cluster and disk resources are functioning correctly. At a Windows PowerShell command prompt, run the following cmdlets:

   ```powershell
   Test-Cluster
   Get-ClusterLog -Destination <Path>
   ```

1. If disk-related resources appear to be "stuck, remove and then restore them to cluster storage.
   - Adjust CrossSubnetDelay and CrossSubnetThreshold for better tolerance to transient network issues.
1. Review the quorum configuration. If it's necessary, reassign the quorum.
1. Review the certificates and certificate store.
   - Check the certificate store's access control list. The SYSTEM account and the ADMINISTRATORS group must have full control on the C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys folder.
   - If it's necessary, import the required certificates again by running commands that resemble the following example at a Windows command prompt:

      ```console
      certutil -store -service clussvc\my
      ```

1. Review disk ownership and signature information:
   - Detach conflicting or double-mapped VHDs.
   - Verify that all signatures are unique.
   - To clear persistent reservations (PRs), contact your storage vendor
1. Make sure that the **Network access: Restrict anonymous access to Named Pipes and Shares** Group Policy setting doesn't block access to shares.

### MOF provider, WMI provider, or iSCSI or Storage PowerShell command issues

If iSCSI or Storage PowerShell commands aren't working, you might have an issue that affects Windows Management interface (WMI) or Managed Object Format (MOF). To troubleshoot WMI and MOF, follow these steps:

1. Open an administrative Command Prompt window, and then run the following commands.

   ```console
   mofcomp iscsirem.mof
   mofcomp iscsidsc.mof
   mofcomp iscsihba.mof
   mofcomp iscsiprf.mof
   mofcomp iscsiwmiv2.mof
   mofcomp storagewmi.mof
   ```

   For more information, see [WMI Command-line Tools](/windows/win32/wmisdk/wmi-command-line-tools).

1. Restart the WMI service and the iSCSI service.
1. If the issues recur or continue, rebuild or reimage the computer.

### Performance and latency issues

#### Symptoms

- You experience slow performance. For example, the **Avg. Disk sec/Write** field shows unusually high values (such as 500 ms).
- Backups and queries are slow.
- Frequent IO retries occur.
- Shadow copies are excessive (more than 1,000).
- Disks appear to be "full" regardless of free space.

#### Cause

- Disk fragmentation on HDDs, or lack of TRIM on SSDs.
- Network or switch misconfiguration or packet loss.
- Disks that go offline (because they run out of available disk space).
- Excessively long disk queues, accumulated shadow copies (more than 4,000 copies), or storport driver issues. These conditions can increase latency.
- Nonoptimized commands or insufficient available threads. These conditions can slow down backup or file copy operations.

#### Resolution

To troubleshoot performance and latency issues, follow these steps:

1. Use Performance Monitor (Perfmon) to review the length and latency of disk queues.

1. Make sure that the operating system is up to date. The [December 9, 2025—KB5072033 (OS Build 26100.7462)](https://support.microsoft.com/topic/december-9-2025-kb5072033-os-build-26100-7462-fca31d8d-5fe8-4b5e-9591-6641ef1d26a1) update and later updates contain a fix for an issue that affects backup performance in Windows Server 2025.

1. For large data copy and backup operations, use [`robocopy`](/windows-server/administration/windows-commands/robocopy). As shown in the following example, `robocopy` includes multi-threading and logging options.

   ```console
   robocopy <src> <dst> /E /COPYALL /SECFIX /R:1 /W:1 /Z /MT:16 /LOG+:copylog.txt /NFL /NDL
   ```

1. Make sure that MTUs and Jumbo Frames are consistent from end to end. To make sure that an MTU is correctly configured, open a Windows Command Prompt window, and run the following command:

   ```console
   netsh interface ipv4 set subinterface "\<Name>" mtu=9000 store=persistent
   ```

1. To clean up excessive shadow copies, go to a Windows command prompt, and run the following command:

   ```console
   vssadmin delete shadows /all
   ```

1. To clean up orphaned devices, go to a Windows command prompt window, and run the following commands:

   ```console
   devnodeclean /n
   devnodeclean
   ```

1. Check the sizes of any virtual hard disks (VHD or VHDX). If it's appropriate, resize them.

1. Review the antivirus exclusion configuration, and fix it if it's necessary.

1. If you have HDD devices, defragment them.

1. If you have SSD devices, run the following command at the PowerShell command prompt:

   ```powershell
   Optimize-Volume -DriveLetter X -ReTrim -Verbose
   ```

1. Review the drivers, firmware, and related policies for all storage devices and controllers, and network adapters.

## Common issues quick reference table

| Symptom | Root cause | Resolution |
| --- | --- | --- |
| Disk surprise removed (157) | Storage/network instability | Check network configuration and MPIO settings, update drivers |
| Disk RAW/Inaccessible | File system or partition issue | Run chkdsk and refsutil, adjust partitions, back up data |
| "The device has a bad block" (7) | Hardware fault | Replace disk/controller, run vendor diagnostics |
| iSCSI failed to connect (20,27) | Config/network/target issue | Review target IP addresses, reset sessions, fix mappings |
| Cluster disk/ownership errors | Quorum/mount/permissions issue | Verify cluster configuration, fix permissions, vendor PR |
| Performance/Backup slowness | Fragmentation, VSS, driver | Trim disks, clean up shadow copies, update drivers |
| File shares disappear after restart | Service dependencies not set | `sc configuration`, set Delayed Start, review logs |
| iSCSI Initiator UI shows old IP | Known issue | Ignore (no functional effect) |
| Incorrect disk mapping | Wrong IP address/session/favorite target | Remove and then restore correct targets, use persistent sessions |
| Shadow copies (more than 1,000) | Performance drain | `vssadministrator delete shadows /all` |
| MOF/WMI errors | WMI/MOF provider corruption | Recompile MOF files, verify repository |

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue:

- **Event Viewer:** Export the System, Application, and Storage logs.
  - Filter for the following events: Event IDs 9, 20, 27, 39, 43, 55, 98, 129, 153, 157, 507 (and others, if relevant)
- **Cluster:** Record the results of the following PowerShell cmdlets:

  ```powershell
  Get-ClusterLog -Destination \<path>
  Test-Cluster
  ``

- **Disk/physical mapping:** Record the results of the following commands:

  ```powershell
  Get-WmiObject -Class win32_diskdrive | select \*
  Get-Disk, Get-PhysicalDisk
  ```

- **Network traces:** Collect network traces. Use a tool such as WireShark, or run the following command at a Windows command prompt:

  ```powershell
  netsh trace start scenario=netconnection capture=yes tracefile=<Path>
  ```

- **Performance:** Collect the following performance information.

  - Collect disk statistics and related network statistics by using Perfmon or logman.
  - Collect storport ("drivers_storage") traces by using logman.

- **Service configuration:** Record the results of the following Windows command:

  ```console
  sc qc \<Service>, sc config \<Service> depend= MSiSCSI
  ```

- **Screenshots:** Create screenshots that show any unusual or anomalous values in the UI (such as Disk Management, iSCSI Initiator "Favorites," and so on).
- **Advanced:** Collect logs from the refsutil tool.

## References

- [iSCSI Target Server overview](/windows-server/storage/iscsi/iscsi-target-server)
- [Failover Clustering in Windows Server and Azure Local](/windows-server/failover-clustering/failover-clustering-overview)
- [The Microsoft iSCSI Initiator may fail to log in to Favorite Targets after the Initiator Name is changed in Windows](iscsi-initiator-not-login-to-favorite-targets.md)
- [Storage Module](/powershell/module/storage/)
- [NetAdapter Module](/powershell/module/netadapter/)
- [Hyper-V Module](/powershell/module/hyper-v/)
- [iSCSI Module](/powershell/module/iscsi/)
- [MPIO Module](/powershell/module/mpio/)
- [Microsoft.PowerShell.Utility Module](/powershell/module/microsoft.powershell.utility)
