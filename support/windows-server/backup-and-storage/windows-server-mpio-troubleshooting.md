---
title: Multipath I/O (MPIO) Troubleshooting Guidance
description: Discusses how to troubleshoot and fix issues in Hyper-V, clustering, and virtualization environments that use the Windows Multipath I/O (MPIO) feature.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw
ms.custom:
- sap:Backup, Recovery, Disk, and Storage\Multipath IO (MPIO) and Storport
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Multipath I/O (MPIO) troubleshooting guidance

In modern Windows Server environments (Hyper-V, clustering, and virtualization), Multipath I/O (MPIO) helps achieve storage high availability and fault tolerance. However, configuration issues, hardware compatibility issues, or interactions with third-party device-specific modules (DSMs) can make disks unavailable and cause performance issues, path loss, and unexpected outages. This article helps you to resolve MPIO storage path issues.

## Known issues

### After you update firmware, multipath disks are missing

This issue affects some storage devices. Contact your storage vendor for support.

### In VMware or virtual environments, Event ID 153 recurs

This behavior reflects a Storport driver issue. Make sure that your drivers are up to date. If the issue continues, contact your vendor for support.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting.

### Prepare to troubleshoot

- Back up all the affected systems and data. Test that you can restore the backup.
- Verify that you have change management approval and a maintenance window for troubleshooting.
- Document all observed issues, error messages, event IDs, and timing.

### Review the symptoms

- Check the Disk Management and Failover Cluster Manager tools. Additionally, check the settings of any affected virtual machines (VMs). Are disks or volumes missing?
- Are issues isolated to one cluster node, all nodes, or all servers?
- Check Server Manager. Are storage controller and network paths missing?
- If you're using third-party DSMs, check their documentation. Are they certified for your operating system version?
- Check Event Viewer and Device Manager, and run `mpclaim -s -d` at a Windows command prompt. Do you see any MPIO or storage errors? In particular, watch for the following events:

  - Event ID 153: "The IO operation at logical block address... was retried."
  - Event ID 129: "Reset to device... was issued."
  - Event ID 140: "Device specified does not exist."
  - Event ID 51, 55, 98, 1069, 1205, 5120, 5121, 5124. These events describe disk, file system, and cluster errors.

### Check for the most basic possible causes

- Are there recent hardware changes, such as new or replaced cables, host bus adapters (HBA)s, or storage switches and zones?
- Did any devices get firmware or driver updates?
- Did any servers restart recently?
- Are the relevant Windows features, such as MPIO, installed? Are the related services running?

### Verify the MPIO and storage configuration

1. To review the device IDs of the storage hardware, follow these steps:
   1. In the search bar, type *mpiocpl*, and then select **MPIO** in the search results.
   1. Select **Discover Multi-Paths**. Review the list of IDs, and fix any errors.
   > [!NOTE]  
   > You can also use the Windows PowerShell `Get-MPIOAvailableHW` and `Get-MPIOSetting` cmdlets, or the command line `mpclaim -e` and `mpclaim -r -i -a` commands to perform these steps.
1. To review and update the storage area network (SAN) policy, open a Windows Command Prompt window, and then run the following command:

   ```console
   diskpart san policy=OnlineAll
   ```

1. To update the path configuration, follow these guidelines:
   - For redundancy, make sure that each iSCSI connection uses a different network adapter.
   - If the system detects only one path, rebuild the iSCSI connections.

### Update drivers and firmware

- Update all storage, network, and multipath drivers to the latest supported versions from your hardware or storage vendor.
- Update storage or SAN controller firmware as recommended.

### Verify the health of the file system and disks

- To check and repair file system errors, run `chkdsk <drive>: /f /r` at a Windows command prompt.
- If chkdsk fails while scanning a RAW volume, try to recover the data or restore it from a backup.
- If the resilient file system (ReFS) is unstable, consider reformatting the file system to NTFS.

### Check for cluster and CSV disk issues

- To check the status of the disk resources, Use Failover Cluster Manager.
- If your disk resource is stuck in the "Online Pending" state, or if the disk resource can't come online and generates error 1069 or error 1205, the timeout setting might be too short. To increase this value, run the following cmdlets at the PowerShell command prompt:

  ```powershell
  Get-ClusterResource "<Resource_Name>" | Set-ClusterParameter PendingTimeout 300000
  ```

  > [!NOTE]  
  >
  > - In these commands, \<Resource_Name> is the name of the disk resource.
  > - The value of the `PendingTimeout` property is measured in milliseconds. The value that's shown here is greater than the default value.

- For stale ClusterStorage folders, stop the cluster service, use `takeown` to take ownership and `icacls` to reset permissions, and then use `rmdir`to delete.

### Check the state of the MPIO paths

- If only some paths are visible, verify zoning, cabling, and HBA status on both server and the SAN.
- If you observe Event IDs 153, 129, or 140, you might have storage or network bottlenecks. Review your underlying storage or network traffic.
- If MPIO paths are missing or configured incorrectly after a restart, see [After maintenance or a restart, administrative tools don't show disks or paths](#after-maintenance-or-a-restart-administrative-tools-dont-show-disks-or-paths) for instructions.

### Tune Registry and policy settings

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

- If you observe excessive logging (such as unusual growth of the Lsass.log file), set the following registry value:

  - Subkey: `HKLM\SYSTEM\CurrentControlSet\Control\Lsa`
  - Value, data, and type: `LogToFile` = `0` (DWORD)

  After you change a registry value, restart the computer.

- To configure MPIO verification settings, run the following cmdlets at a PowerShell command prompt window:

  ```powershell
  Set-MPIOSetting -NewPathVerifyState Enabled
  Set-MPIOSetting -CustomPathRecovery Enabled
  ```

- To configure intervals and timeouts for path verification, verify the appropriate settings by working with your hardware vendor. Set the following values in the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mpio\Parameters` subkey:

  - `PathVerifyEnabled` (DWORD): 1 to turn on
  - `PathRecoveryInterval` (DWORD): Time in seconds (default: 30)
  - `PDORemovePeriod` (DWORD): Time in seconds (default: 20)
  
  After you change a registry value, restart the computer.

### Fix file system corruption or RAW disks

- If your disk is RAW and can't be fixed, delete and re-create the partition. Then, restore data from backup.
- If your clustered disks have stale reservations, use `Clear-ClusterDiskReservation` at a PowerShell command prompt to clear them.

### Switch DSM or remove third-party multipath drivers

1. If you're using third-party DSMs, use the Programs and Features item in Control Panel to uninstall them.
1. Restart the computer.
1. In the MPIO tool, select **Devices**, and then remove the hardware IDs.
1. Restart the computer again. Then, in the MPIO tool, restore the hardware IDs for MSDSM.
1. To make sure that Microsoft DSM claims your disks, run `mpclaim -s -d` at the Windows command prompt.

## Common issues and solutions

The following sections describe the most common issues, and how to fix them.

### Windows Server 2022 or 2019: VM IO performance degrades when Hyper-V uses resilient change tracking (RCT)

If you experience this issue, make sure that your computers are up to date. The [October 23, 2025—KB5070884 (OS Build 20348.4297)](https://support.microsoft.com/topic/october-23-2025-kb5070884-os-build-20348-4297-out-of-band-9c001fdc-f0d2-4636-87bb-494a59da55d0) update and subsequent updates contain a fix for this issue.

> [!NOTE]  
> After you install this update, VMs that were previously backed up by using a host-level backup application might not be able to start. To fix this issue, delete any .rct and .mrt files that are associated with the affected virtual hard disks. Then, try again to start the VMs. If the issue persists, contact Microsoft Support.

### Some cluster disk resources remain in "Online Pending" state

The default `PendingTimeout` value is too low for cluster disks that have quota or File Server Resource Manager (FSRM) changes. Therefore, the cluster disks don't come online. To increase this `PendingTimout` value, run the following cmdlets at the PowerShell command prompt:

```powershell
Get-ClusterResource "<Resource_Name>" | Set-ClusterParameter PendingTimeout 300000
```

> [!NOTE]  
>
> - In these commands, \<Resource_Name> is the name of the disk resource.
> - The value of the PendingTimeout property is measured in milliseconds. The value shown here's higher than the default value.

### Cluster disk resources are slow to come online

You might observe that cluster disk resources take three to five minutes to come online. This behavior also generates Event ID 1069 and Event ID 4874.

To fix this issue, follow these steps:

1. Review cluster logs for timeout or resource errors.
1. In Failover Cluster Manager, increase the resource timeout from the default value (three minutes), to five minutes or more.
1. Check for volume snapshots or FSRM quotas that delay bringing resources online.
1. Clear any cluster dependencies or disk policies that might impede access to the disks.

### After maintenance or a restart, administrative tools don't show disks or paths

The Disk Management or Failover Cluster Manager tools don't show all of the disks or paths, and the **Discover** option is unavailable. If you run `mpclaim -s -d` at a Windows command prompt, some LUNs might be missing. You might also observe Event ID 46, Event ID 129, or Event ID 153.

To fix this issue, follow these steps:

1. Check the physical disk connections, switch zoning, and storage connectivity.
1. In Device Manager (enable "show hidden"), remove ghost or hidden devices, or run `devnode clean` at a Windows command prompt.
1. If you're using an unsupported DSM or duplicate DSMs, use the Programs and Features item in Control Panel to uninstall them.
1. Restart, reinstall, or re-enable the Multipath-IO feature. To perform this step, run `Install-WindowsFeature Multipath-IO` at a PowerShell command prompt).
1. At a Windows command prompt, run the following commands, in sequence:

    ```console
    mpclaim -e
    mpclaim -s -d
    mpclaim -r -i -a
    ```

1. In the MPIO tool, select **Discover Multi-Paths**, add the missing hardware IDs.

1. To review and update the storage area network (SAN) policy, open a Windows Command Prompt window, and then run the following command:

   ```console
   diskpart san policy=OnlineAll
   ```

1. Use Disk Management or diskpart to bring the missing disks online.

1. To review the "Favorite Targets" list, use the iSCSI Initiator tool (In the search bar, type *iscsiocpl*, select **iSCI Initiator** in the search results, and then select **Favorite Targets**.

### MPIO is in a degraded state, slow or unresponsive during failover

During a failover, you might observe delays that exceed 30 seconds. You also observe IO error messages, and messages such as "MPIO is in a degraded state." You might also observe the following events:

- Event ID 46
- Event ID 129
- Event ID 140
- Event ID 153

To fix this issue, follow these steps:

1. Update all storage, HBA, and multipath drivers and firmware.
1. To set recommended load-balancing policy and failover parameters, run the following cmdlets at a PowerShell command prompt:

    ```powershell
    Set-MSDSMGlobalDefaultLoadBalancePolicy -Policy RR
    Set-MPIOSetting -NotificationState Enabled
    Set-MPIOSetting -NotificationPeriod 30
    Set-MPIOSetting -NewPDORemovePeriod 20
    Set-MPIOSetting -CustomPathRecovery Enabled
    Set-MPIOSetting -NewPathRecoveryInterval 10
    reg add HKLM\SYSTEM\CurrentControlSet\Services\mpio\Parameters /v PathVerifyEnabled /t REG_DWORD /d 1 /f
    ```

    Restart if prompted to do so.

1. On clusters, increase disk resource timeouts to tolerate slow failover.

### Applications experience downtime, and events repeat in the Event Log

The repeating events include the following examples:

- Event ID 153 ("disk retried")
- Event ID 129 ("reset to device")
- Event ID 11 ("controller error")
- Event ID 158 (identical disk GUIDs)

To fix this issue, follow these steps:

1. Verify that physical and logical paths exist and are healthy.
1. Update the storage firmware and drivers.
1. If Event ID 158 recurs, use the following PowerShell cmdlet to reset the disk GUIDs on the VHDs:

    ```powershell
    Set-VHD -Path \<VHD-Path> -ResetDiskIdentifier
    ```

1. If the repeating events refer to third-party DSMs, consult the storage vendor or migrate to a supported native DSM.

### Duplicate disks or changed disk numbering

You might observe this behavior after a restart, or after you add or remove disks. To fix this issue, follow these steps:

1. Make sure that only one multipath solution is attached (remove unsupported DSMs, restart, and then reinstall or reconfigure MPIO).

1. Windows uses nondeterministic disk order. If your application requires a specific disk order, use persistent identifiers (for example a GUID, UUID, or WWN) instead of using a disk number or drive letter.

### High latency, IO spikes, low throughput, slow backups, SQL Event ID 833, or other performance issues

To diagnose and fix these performance issues, follow these steps:

1. Use Performance Monitor (Perfmon) to collect performance data. At the Windows command prompt, run the following command:

   ```console
   logman create counter PerfLog -o C:\PerfLog.blg -f bincirc ...
   ```

1. Check for security or antivirus scans on the storage volumes. You might have to temporarily exclude the volumes or temporarily disable scans to test the effect on performance.
1. Make sure that Windows Server is up to date, and update drivers and firmware.
1. Use 64K allocation units for data volumes.
1. If possible, distribute disks across multiple controllers.

### Cluster disk resource or LUN disappears after you expand or resize it

After you increase disk or LUN capacity, Disk Management or Failover Cluster Manager doesn't display the related volume. The volume reappears if you take the cluster role offline and then online again.

To fix this issue, follow these steps:

1. Take the affected cluster role offline, then bring it online again (or move role to another node).
1. To run maintenance processes that rescan and extend the file system, run the following commands at a Windows command prompt on the node that owns the role:

   ```console
   diskpart
   rescan
   list vol
   select vol x
   extend filesystem
   exit
   ```

### Server has to restart to detect new MPIO paths

After you change cabling, zoning, or storage configuration, the computer that manages storage doesn't detect new paths until it restarts.

To fix this issue, follow these steps:

1. At a PowerShell command prompt on the affected computer, run the following commands:

   ```powershell
   Update-HostStorageCache
   mpclaim -n -d
   ```

   > [!IMPORTANT]  
   > If these commands don't work, restart the computer.

1. Make sure that MPIO, DSM, and Storport are up to date.

## Common issues quick reference

| Symptom | Cause | Resolution |
| --- | --- | --- |
| Disk missing in MPIO properties and Disk Mgmt | Zoning or DSM conflict | Check Device Manager, remove ghost devices, reinstall MPIO, restart |
| Event IDs 153/129/11 | Path loss, driver or firmware issue | Update firmware or drivers, set MPIO policy, check physical connectivity |
| Failover delay, slow cluster resource online | Timeout, configuration  error | Raise resource timeout, fix quotas and snapshots, update drivers |
| Duplicate disks/wrong disk order | Bad DSM or configuration | Remove extra DSM, use persistent identifiers (GUID/WWN) |
| High IO latency, app slow, Event ID 833 | Driver and antivirus (AV) | Exclude storage from AV, update drivers, Perfmon, use 64K clusters |
| Disk GUID duplicate, Event ID 158 | No MPIO or clone VHDs | Enable MPIO, Set-VHD -ResetDiskIdentifier |
| Cluster disk disappears after expansion | Driver or disk issue | Cycle role offline and online, rescan, use `diskpart` to extend |
| Paths not detected until restart | Storport configuration issue | `Update-HostStorageCache`, restart |
| "Requested resource in use," can't bring disk online | Metadata or disk issue | Use `chkdsk`, check logs, engage storage team |

## Data collection

If these procedures don't resolve your issue, contact Microsoft Support. Use the following tools to gather diagnostic data to append to your support request:

- **Windows Troubleshooting Scripts (TSS)**: The TSS scripts automatically collect useful data. For more information and instructions, see the following articles:
  - [Collect data to analyze and troubleshoot clustering and high availability scenarios](../../windows-client/windows-tss/collect-data-analyze-troubleshoot-windows-clustering-scenarios.md?context=%2Ftroubleshoot%2Fwindows-server%2Fcontext%2Fcontext)
  - [Collect data to analyze and troubleshoot Hyper-V scenarios](../../windows-client/windows-tss/collect-data-analyze-troubleshoot-hyperv-scenarios.md?context=%2Ftroubleshoot%2Fwindows-server%2Fcontext%2Fcontext)
- **Process Monitor (Procmon):** For in-depth file, registry, or process analysis, run a command that resembles the following example at the Windows command prompt:

  ```console
  procmon.exe /BackingFile c:\procmon.pml /Quiet /Minimized /Runtime 60
  ```

  > [!NOTE]
  > Before you collect traces for Windows Server 2016 or later versions, make sure that you install the latest cumulative updates.

- **Performance Monitor (Perfmon):** Use the GUI or command line interface. The following example collects data at five-second intervals:

  ```console
  logman create counter PerfLog -o c:\PerfLog.blg -c "\PhysicalDisk(*)\*" -si 00:00:05
  logman start PerfLog
  ```

- **PowerShell:** Use the following cmdlets to gather information:
  - `Get-VMNetworkAdapter -VMName \<YourVMName>`
  - `Import-VM` (for import verification and error export)
- **System and cluster logs:**
  - Windows Event Viewer: Collect logs from Hyper-V VMMS, cluster services, and storage.
  - Cluster validation reports
- **Registry Editor:** Audit the permissions under `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Worker`.
- **BIOS/UEFI:** Export settings, or create screenshots of them.
- **Minidump files** If you observe a stop or bug check error (also known as a bluescreen error), retrieve these files.
- **Network trace logs** If you observe connectivity issues, collect network traces.
- **Exported VM configuration files:** If you're troubleshooting import or export issues, export configuration files for the affected VMs.
- **Driver versions:** Note the current versions that your storage components, network components, and security agents use.
- **Storport traces:** Run commands that resemble the following examples at the Windows command prompt:

  ```console
  logman create trace storport -ow -o c:\storport.etl -p Microsoft-Windows-StorPort 0xff -ets
  logman stop storport -ets
  ```

## References

- [Data corruption and disk errors troubleshooting guidance](troubleshoot-data-corruption-and-disk-errors.md)
- [Information about Event ID 51](event-id-51-information.md)
- [Event ID 158 is logged for identical disk GUIDs](../../windows-client/backup-and-storage/event-id-158-for-identical-disk-guids.md)
- [iSCSI storage connectivity troubleshooting guidance](iscsi-storage-connectivity-troubleshooting.md)
- [Manage MPIO for Hyper-V hosts in the VMM fabric](/system-center/vmm/hyper-v-mpio)
