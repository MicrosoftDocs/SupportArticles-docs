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

## Summary

In modern Windows Server environments (Hyper-V, clustering, and virtualization), Multipath I/O (MPIO) is important for achieving storage high availability and fault tolerance. However, failures in configuration, hardware compatibility, or interactions with third-party DSMs (Device Specific Modules) can make disks unavailable and cause performance issues, path loss, and unexpected outages. This article provides troubleshooting help for administrators to resolve MPIO and storage path issues. 

## Troubleshooting checklist

Use this checklist for systematic troubleshooting.

**Preparation**

- Verify a current and tested backup of all involved systems.
- Confirm maintenance window and change management approval.
- Review recent storage and network changes or firmware and driver updates.
- Document all observed issues, error messages, event IDs, and timing.

**Initial Triage**

- Are disks or volumes missing in Disk Management, Failover Cluster Manager, or virtual machine (VM) settings?
- Are any MPIO or storage errors reported? (Check: mpclaim -s -d, Device Manager, Event Viewer.)
- Are you using third-party DSMs? Are they certified for your OS version?
- Recent hardware changes: New or replaced cables, HBAs, storage switches and zones, server restarts.
- Are storage controller and network paths visible in the system management console?
- Are relevant Windows features (for example, Multipath-IO) installed and enabled?

**Deeper checks**

- Review Windows Event Viewer (system, storage, failover clustering logs).
- Use PowerShell, DiskPart, and sysinternals tools to inspect and manipulate the disk and volume status.
- Are problems isolated to one node, all nodes, or all servers?

## Common issues and solutions

The following sections detail the most common failure modes and provide step-by-step solutions.

### Disks or paths missing in MPIO or OS (including after maintenance or restart)

#### Symptoms

- Disk missing in Disk Management or cluster
- "mpclaim -s -d" missing LUNs
- "Discover" option unavailable (greyed out)
- Event log IDs 46, 153, 129

#### Resolution

1. Check physical and storage connectivity and switch zoning
2. Remove ghost or hidden devices in Device Manager (enable "show hidden") or run devnode clean
3. Uninstall unsupported or duplicate DSMs (Control Panel > Programs and Features)
4. Restart, reinstall, or re-enable the Multipath-IO feature (Install-WindowsFeature Multipath-IO)
5. Run:

    ```console
    mpclaim -e
    mpclaim -s -d
    mpclaim -r -i -a
    ```

    Add missing hardware IDs in **MPIO Properties** > **Discover Multi-Paths**.
6. Open DiskPart:

    ```console
    diskpart
    san policy=OnlineAll
    exit
    ```
    
7. Bring missing disks online in Disk Management or through DiskPart.

### Multipath Failover Delays or Path Flapping

#### Symptoms

- 30+ seconds delay or unresponsiveness during failover
- IO errors
- "MPIO is in a degraded state"

- Event IDs 140, 46, 153, 129

#### Resolution

1. Update all storage, HBA, and multipath drivers and firmware.
2. Set recommended load-balancing policy and failover parameters:

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
3. On clusters, increase disk resource timeouts to tolerate slow failover.

### Cluster disk online pending or resource failure

#### Symptoms

- Cluster disk stuck "Online Pending"
- Event IDs 1069, 4874
- Disk takes three to five minutes to come online

#### Resolution

1. Review cluster logs for timeout or resource errors.
2. Increase resource timeout in Failover Cluster Manager (default is three minutes, try five minutes or more).
3. Check for volume snapshots or FSRM quotas that delay bringing resources online.
4. Clear any cluster dependencies or disk policies that are impeding access.

### 4. **Persistent Disk or Path Errors in Event Log**

#### Symptoms

- Recurring Event IDs 153 ("disk retried"), 129 ("reset to device"), 11 ("controller error"), 158 (identical disk GUIDs)
- Application downtime.

#### Resolution

1. Verify that physical and logical paths exist and are healthy.
2. Update storage firmware and drivers.
3. For Event ID 158, reset disk GUIDs on VHDs by using:

    ```powershell
    Set-VHD -Path \<VHD-Path> -ResetDiskIdentifier
    ```

4. For repeated errors with third-party DSMs: Consult storage vendor, or migrate to supported native DSM.

### Duplicate disks or wrong disk order

#### Symptoms

- Duplicate instance of the same disk or LUN
- Disks renumbered after a restart, addition, or removal

#### Resolution

1. Make sure that only one multipath solution is attached (remove unsupported DSMs, restart, and then reinstall or reconfigure MPIO).

2. Disk order in Windows is nondeterministic. For applications, use persistent identifiers (GUID/UUID/WWN) instead of disk number or drive letter.

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
    
2. Check for security or antivirus scans on storage volumes (exclude or temporarily disable to test the effect).
3. Update drivers, firmware, and the OS.
4. Use 64K allocation units for data volumes. Distribute disks across multiple controllers, if possible.

### Cluster disk disappears after an expansion or resize

#### Symptoms

- After you increase disk or LUN capacity, the volume isn't visible in cluster or disk manager until the role is cycled.

#### Resolution

1. Bring affected cluster role offline, then online (or move role to another node).
2. Use DiskPart on the owner node to rescan and extend filesystem during maintenance:

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

2. If the command is unsuccessful, a restart is required.
3. Make sure that MPIO, DSM, and Storport are up to date.

### Known bug and ICM or product defect scenarios

#### Symptoms

- Persistent failover problems
- Event 153 or 129, despite all fixes
- Documented "won’t fix" scenarios in the OS version

#### Resolution

1. Verify with Microsoft Support or vendor documentation all bug and ICM IDs.
2. Implement documented workarounds.
3. Upgrade to latest supported Windows Server build if a fix is available (for example, from 2019 to 2022 for known MPIO bugs).

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

- [Troubleshoot disk issues](/windows-server/administration/windows-commands/diskpart)
- [Event ID reference](/windows/win32/eventlog/event-identifiers)
