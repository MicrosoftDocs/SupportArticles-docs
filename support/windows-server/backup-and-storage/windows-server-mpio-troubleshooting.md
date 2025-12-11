---
title: Windows Server Multipath I/O (MPIO) Troubleshooting guidance
description: Resolves issues in Multipath I/O (MPIO) Hyper-V, clustering, and virtualization environments.
ms.date: 10/08/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:Backup, Recovery, Disk, and Storage\Multipath IO (MPIO) and Storport
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Windows Server Multipath I/O (MPIO) troubleshooting guidance

In modern Windows Server environments (Hyper-V, clustering, and virtualization), Multipath I/O (MPIO) is important for achieving storage high availability and fault tolerance. However, configuration issues, hardware compatibility issues, or interactions with third-party device-specific modules (DSMs) can make disks unavailable and cause performance issues, path loss, and unexpected outages. This article helps you to resolve MPIO storage path issues.

MPIO or disk storage failures cause several problems. You see disk unavailability, degraded performance, or application outages. These issues appear as connectivity loss, path failures, or file system corruption. Problems stem from misconfiguration, hardware faults, driver or firmware incompatibilities, or external factors like storage or network changes.

## Known issues

### After you update firmware, multipath disks are missing

This is a known issue for some storage devices. Contact your storage vendor for support.

### In VMware or virtual environments, Event ID 153 recurs

This behavior reflects a Storport driver issue. Make sure that your drivers are up to date. If the issue continues, contact your vendor for support.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting.

### Prepare to troubleshoot

- Back up all the affected systems and data. Test that you can restore the backup.
- Confirm that you have a maintenance window and change management approval for troubleshooting.
- Document all observed issues, error messages, event IDs, and timing.

### Review the symptoms

- Check the Disk Management and Failover Cluster Manager tools, as well as the settings of any affected virtual machines (VMs). Are disks or volumes missing?
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
   1. In the search bar, type *mpiocpl*, and then in the search results, select **MPIO**.
   1. Select **Discover Multi-Paths**. Review the list of IDs and fix any errors.
   > [!NOTE]  
   > You can also use the Windows PowerShell `Get-MPIOAvailableHW` and `Get-MPIOSetting` cmdlets, or the command line `mpclaim -e` and `mpclaim -r -i -a` commands to perform these steps.
1. To review and update the storage area network (SAN) policy, open a Windows command prompt window and then run the following command:

   ```console
   diskpart san policy=OnlineAll
   ```

1. To update the path configuration, follow these guidelines:
   1. For redundancy, make sure each iSCSI connection uses a different network adapter.
   1. If the system only detects one path, rebuild the iSCSI connections.

### Update drivers and firmware

- Update all storage, network, and multipath drivers to the latest supported versions from your hardware or storage vendor.
- Update storage or SAN controller firmware as recommended.

### Verify the health of the file system and disks

- To check and repair file system errors, run `chkdsk <drive>: /f /r` at a Windows command prompt.
- If chkdsk fails while scanning a RAW volume, attempt to recover the data or restore it from a backup.
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
  > - The value of the PendingTimeout property is measured in milliseconds. The value shown here is higher than the default value.

- For stale ClusterStorage folders, stop cluster service, take ownership and permissions with `takeown` and `icacls`, then delete with `rmdir`.

### Check the state of the MPIO paths

- If only some paths are visible, verify zoning, cabling, and HBA status on both server and the SAN.
- If you observe Event IDs 153, 129, or 140, you might have storage or network bottlenecks. Review your underlying storage or network traffic.
- If MPIO paths are missing or incorrectly configured following a restart, see [After maintenance or a restart, administrative tools don't show disks or paths](#after-maintenance-or-a-restart-administrative-tools-dont-show-disks-or-paths) for instructions.

### Tune Registry and policy settings

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

- If you observe excessive logging (such as unusual growth of the lsass.log file), set the following registry value.

  - Subkey: `HKLM\SYSTEM\CurrentControlSet\Control\Lsa`
  - Value, data, and type: `LogToFile` = `0` (DWORD)
  After you change a registry value, restart the computer.

- To configure MPIO verification settings, run the following cmdlets at a PowerShell command prompt window:

  ```powershell
  Set-MPIOSetting -NewPathVerifyState Enabled
  Set-MPIOSetting -CustomPathRecovery Enabled
  ```

- To configure intervals and timeouts for path verification, confirm appropriate settings together with your hardware vendor. Set the following values in the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mpio\Parameters` subkey:

  - `PathVerifyEnabled` (DWORD): 1 to turn on
  - `PathRecoveryInterval` (DWORD): Time in seconds (default: 30)
  - `PDORemovePeriod` (DWORD): Time in seconds (default: 20)
  After you change a registry value, restart the computer.

### Fix file system corruption or RAW disks

- If your disk is RAW and can't be fixed, delete and recreate the partition, then restore data from backup.
- If your clustered disks have stale reservations, use `Clear-ClusterDiskReservation` at a PowerShell command prompt to clear them.

#### Switch DSM or remove third-party multipath drivers

1. If you're using third-party DSMs, use the Programs and Features control panel to uninstall them.
1. Restart the computer.
1. In the MPIO tool, select **Devices**, and then remove the hardware IDs.
1. Restart the computer again, then in the MPIO tool, re-add the hardware IDs for MSDSM.
1. To make sure that Microsoft DSM claims your disks, run `mpclaim -s -d` at the Windows command prompt.

## Common issues and solutions

The following sections describe the most common issues, and how to fix them.

### Windows Server 2019 or 2022: VM IO performance degrades when Hyper-V uses resilient change tracking (RCT) is in use

If you experience this issue, make sure that your computers are up to date. [October 23, 2025—KB5070884 (OS Build 20348.4297)](https://support.microsoft.com/en-us/topic/october-23-2025-kb5070884-os-build-20348-4297-out-of-band-9c001fdc-f0d2-4636-87bb-494a59da55d0) and subsequent updates contain a fix for this issue.

> [!NOTE]  
> After you install this update, VMs that have been backed up by using a host-level backup application might not be able to start. To fix this issue, delete any .rct and .mrt files that are associated with the affected virtual hard disks. Then try again to start the VMs. If the issue persists, contact Microsoft Support.

### Some cluster disk resources remain in "Online Pending" state

The default `PendingTimeout` value is too low for cluster disks that have quota or File Server Resource Manager (FSRM) changes. As a result, the cluster disks don't come online. To increase this `PendingTimout` value, run the following cmdlets at the PowerShell command prompt:

```powershell
Get-ClusterResource "<Resource_Name>" | Set-ClusterParameter PendingTimeout 300000
```

> [!NOTE]  
>
> - In these commands, \<Resource_Name> is the name of the disk resource.
> - The value of the PendingTimeout property is measured in milliseconds. The value shown here is higher than the default value.

### Cluster disk resources are slow to come online

You might observe cluster disk resources taking three to five minutes to come online. This behavior also generates Event ID 1069 and Event ID 4874.

To fix this issue, follow these steps:

1. Review cluster logs for timeout or resource errors.
1. In Failover Cluster Manager, increase the resource timeout from the default value (three minutes), to five minutes or more.
1. Check for volume snapshots or FSRM quotas that delay bringing resources online.
1. Clear any cluster dependencies or disk policies that might impede access to the disks.

### After maintenance or a restart, administrative tools don't show disks or paths

The Disk Management or Failover Cluster Manager tools don't show all of the disks or paths, and the **Discover** option is unavailable. If you run `mpclaim -s -d` at a Windows command prompt, some LUNs might be missing. You might also observer Event ID 46, Event ID 129, or Event ID 153.

To fix this issue, follow these steps:

1. Check the physical disk connections, switch zoning, and storage connectivity.
1. In Device Manager (enable "show hidden"), remove ghost or hidden devices (or run `devnode clean` at a Windows command prompt).
1. If you're using an unsupported DSM or duplicate DSMs, use the Programs and Features control panel to uninstall them.
1. Restart, reinstall, or re-enable the Multipath-IO feature (to do this, you can run `Install-WindowsFeature Multipath-IO` at a PowerShell command prompt).
1. At a Windows command prompt, run the following commands, in sequence:

    ```console
    mpclaim -e
    mpclaim -s -d
    mpclaim -r -i -a
    ```

1. In the MPIO tool, select **Discover Multi-Paths**, add the missing hardware IDs.

1. To review and update the storage area network (SAN) policy, open a Windows command prompt window and then run the following command:

   ```console
   diskpart san policy=OnlineAll
   ```

1. Use Disk Management or diskpart to bring the missing disks online.

1. To review the "Favorite Targets" list, use the iSCSI Initiator tool (In the search bar, type *iscsiocpl*, and then in the search results, select **iSCI Initiator**, and then select **Favorite Targets**.)

### MPIO is in a degraded state, slow or unresponsive during failover

During a failover, you observe delays that might exceed thirty seconds. You also observe IO error messages, and messages such as "MPIO is in a degraded state." You might observe the following events:

- Event ID 46
- Event ID 129
- Event ID 140
- Event ID 153

To fix this issue, follow these steps:

1. Update all storage, HBA, and multipath drivers and firmware.
1. To set recommended load-balancing policy and failover parameters, run the following cmdlets at a Powershell command prompt:

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

### 4. "Persistent Disk or Path Errors in Event Log"

#### Symptoms

- Recurring Event IDs 153 ("disk retried"), 129 ("reset to device"), 11 ("controller error"), 158 (identical disk GUIDs)
- Application downtime.

#### Resolution

1. Verify that physical and logical paths exist and are healthy.
1. Update storage firmware and drivers.
1. For Event ID 158, reset disk GUIDs on VHDs by using:

    ```powershell
    Set-VHD -Path \<VHD-Path> -ResetDiskIdentifier
    ```

1. For repeated errors with third-party DSMs: Consult storage vendor, or migrate to supported native DSM.

### Duplicate disks or wrong disk order

#### Symptoms

- Duplicate instance of the same disk or LUN
- Disks renumbered after a restart, addition, or removal

#### Resolution

1. Make sure that only one multipath solution is attached (remove unsupported DSMs, restart, and then reinstall or reconfigure MPIO).

1. Disk order in Windows is nondeterministic. For applications, use persistent identifiers (GUID/UUID/WWN) instead of disk number or drive letter.

### Performance and latency issues, high disk IO waits

#### Symptoms

- High latency in database and apps
- Periodic IO spikes
- Low throughput
- Event 833 (SQL)
- Slow backups

#### Resolution

1. Run Perfmon to verify:

    ```console
    logman create counter PerfLog -o C:\PerfLog.blg -f bincirc ...
    ```
    
1. Check for security or antivirus scans on storage volumes (exclude or temporarily disable to test the effect).
1. Update drivers, firmware, and the OS.
1. Use 64K allocation units for data volumes. Distribute disks across multiple controllers, if possible.

### Cluster disk disappears after an expansion or resize

#### Symptoms

- After you increase disk or LUN capacity, the volume isn't visible in cluster or disk manager until the role is cycled.

#### Resolution

1. Bring affected cluster role offline, then online (or move role to another node).
1. Use DiskPart on the owner node to rescan and extend filesystem during maintenance:

    ```console
    diskpart
    rescan
    list vol
    select vol x
    extend filesystem
    exit
    ```

### MPIO path not detected without server restart

#### Symptoms

- After cabling, zoning, or storage configuration change, new paths aren't detected until server is restarted.

#### Resolution

1. Run:

    ```console
    Update-HostStorageCache
    mpclaim -n -d
    ```

1. If the command is unsuccessful, a restart is required.
1. Make sure that MPIO, DSM, and Storport are up to date.

### Persistent issues


#### Symptoms

- Persistent failover problems
- Event 153 or 129, despite all fixes
- Documented "won't fix" scenarios in the OS version

#### Resolution

1. Verify with Microsoft Support or vendor documentation all bug and ICM IDs.
1. Implement documented workarounds.
1. Upgrade to latest supported Windows Server build if a fix is available (for example, from 2019 to 2022 for known MPIO bugs).

## Common issues quick reference table

| Symptom | Root cause | Resolution |
| --- | --- | --- |
| Disk missing in MPIO/Disk Mgmt | Zoning, DSM conflict | Check Device Manager, remove ghost devices, reinstall MPIO, restart |
| Event 153/129/11 | Path loss, driver/firm | Update firmware/drivers, set MPIO policy, check physical connectivity |
| Failover delay, slow cluster resource online | Timeout, configuration  error | Raise resource timeout, fix quotas/snapshots, update drivers |
| Duplicate disks/wrong disk order | Bad DSM/configuration | Remove extra DSM, use persistent identifiers (GUID/WWN) |
| High IO latency, app slow, Event 833 | Driver/antivirus | Exclude storage from AV, update drivers, Perfmon, use 64K clusters |
| Disk GUID duplicate, Event 158 | No MPIO/clone VHDs | Enable MPIO, Set-VHD -ResetDiskIdentifier |
| Cluster disk disappears after expansion | Driver/event miss | Cycle role offline/online, rescan, extend with DiskPart |
| Paths not detected until restart | Storport configuration  bug | Update-HostStorageCache, restart |
| "Requested resource in use," can't bring disk online | Metadata/disk fail | Use CHKDSK, check logs, engage storage team |
| MPIO failover bug (Win 2019/2022) | Known defect | Upgrade OS, reference vendor/MS documentation |

## Data collection

When issues persist after basic troubleshooting, use these steps to gather diagnostic data:

- **Procmon (Process Monitor):** Trace "ACCESS DENIED" registry or file system events
- **PowerShell:**
  - Get-VMNetworkAdapter -VMName \<YourVMName>
  - Import-VM for import verification and error export.
  - Set-VMFirmware -VMName \<VMName> -SystemUUID ([guid]::NewGuid()) for UUID management
- **System and cluster logs:**
  - Windows Event Viewer: Collect logs from Hyper-V VMMS, cluster services, and storage
  - Cluster validation reports
- **Registry Editor:** Audit permissions under HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Worker
- **Command Line:**
  - sfc /scannow
  - DISM /Online /Cleanup-Image /RestoreHealth
  - bcdedit /set hypervisorlaunchtype auto
  - gpupdate /force
- **BIOS/UEFI:** screenshots or settings exports
- **Minidump files** after blue screen
- **Network trace logs** if connectivity issues exist
- **Exported VM configuration files:** if you're troubleshooting import/export
- **Driver versions** for storage, network, and security agents

## References

- [diskpart command](/windows-server/administration/windows-commands/diskpart)

