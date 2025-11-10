---
title: Windows Server iSCSI Storage Connectivity Troubleshooting Guidance
description: Resolves issues that occur in SAN-based and iSCSI storage environments in Windows Server.
ms.date: 10/08/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:Backup, Recovery, Disk, and Storage\iSCSI
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Windows Server iSCSI storage connectivity troubleshooting guidance

## Summary

SAN-based and iSCSI storage environments in Windows Server (2025, 2022, 2019, and 2016) are essential for clustering, high-availability, virtualization, and large-scale file services. However, these environments can experience various issues, from connectivity dropouts and disk corruption to performance degradation and cluster failures. Causes range from misconfiguration and a driver-firmware mismatch to underlying network instability, hardware faults, and OS storage subsystem bugs. This article provides a step-by-step approach to diagnose and resolve common iSCSI, disk, and cluster-related failures to help administrators maintain high service availability, data integrity, and operational efficiency.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting:

- **Networking**
    - Make sure that iSCSI, management, and client networks are segregated and correctly routed.
    - Are MTU, VLANs, Jumbo Frames, and Flow Control/ROCE/PFC are consistently configured?
- **Firmware/Driver Updates**
    - Are network adapters, storage controllers, and storage array firmware current and vendor-supported?
- **Storage Infrastructure**
    - Are all SCSI, multipath or MPIO, and iSCSI target device drivers and tools up to date?
    - Verify that all SAN zoning and LUN masking are correct.
- **Windows Configuration**
    - Does the appropriate MPIO policy exist? Verify that disks and LUNs are visible and healthy in Disk Management.
    - Are cluster and quorum configurations validated (Test-Cluster, validation reports)?
    - Are antivirus exclusions set for storage and cluster paths?
    - Is the correct Group Policy policy enabled for disk and volume access?
- **Backup/Restore**
    - Does the VSS and backup configuration comply with storage guidelines?
    - Are shadow copies and snapshots managed and not excessive?
- **Documentation/Change Log**
    - Document all infrastructure changes that occurred before the incident (updates, config edits, firmware, hardware swaps, and so on).

## Common issues and solutions

The following sections detail the most common failure modes and provide step-by-step solutions.

### iSCSI disk disconnections, failover issues, surprise removal

#### Symptoms

- Drives or volumes offline or RAW after restart.
- "Disk X has been surprise removed" (Event ID 157).
- iSCSI errors: Event IDs 9, 20, 27, 39, 153, "Target did not respond," "Initiator failed to connect," "IO operation at logical block address was retried."

#### Cause

- Network instability.
- Multi-path configuration errors.
- Mismatched VLAN/MTU/Jumbo settings, improper failover scripts.
- Outdated firmware/drivers.
- Resource exhaustion on SAN/NAS array.

#### Resolution

1. Network and Multipath review:
    - Verify network hardware configuration (MTU, VLAN, Jumbo, Flow Control).
    - Use mpclaim -v and Get-MSDSMAutomaticClaim.
    - Remove duplicate iSCSI sessions and unnecessary paths.
2. Firmware and driver update:
    - Update all storage and network firmware and drivers.
3. Timeout registry tuning:
    - Set disk and iSCSI timeout (HKLM\SYSTEM\CurrentControlSet\Services\disk, TimeOutValue=179).
4. Check SAN Health:
    - Coordinate with vendor to verify logs and event triggers.
5. Application and script adjustments
    - Avoid reliance on disk numbers (can change after path failover).
6. Command tools:
    - Get-Disk, Get-PhysicalDisk, Out-GridView (review mapping)
    - Netsh trace start scenario=netconnection capture=yes tracefile=c:\os.etl
7. Known bugs:
    - For REFS/backup unresponsiveness on Windows Server 2025, apply KB5062660.
    - Review cluster logs for evidence of quorum or heartbeat-related outages.

### 2. Volumes changing to RAW, file system, metadata corruption

#### Symptoms

- NTFS, RECORD, RAW volume, inaccessible share, failed copy or backup.
- "The file system detected a checksum error" or "Device... has a bad block."
- ReFS volume unexpectedly becomes RAW.

#### Cause

- Unclean shutdowns, storage disconnects.
- Physical disk or controller hardware failure.
- Partition table or volume boundary errors.
- Service dependencies not set (file shares missing after restart).

#### Resolution

1. File system repair
    - NTFS: chkdsk X: /f /r (back up data first because "/r" might take a long time and could risk further loss.
    - ReFS: Use refsutil for salvage:

    ```console
    refsutil salvage -QA D: \<log path> \<recovery path> -x
    refsutil salvage -FA D: \<log path> \<recovery path> -x
    ```

    - Adjust partition boundaries with disk management tool if mismatched.
2. **Address Underlying Disk Issues
    - Use vendor diagnostics tool, review SMART data, replace as necessary.
3. Service dependencies
    - Set dependency: sc configuration  LanmanServer depend= MSiSCSI
    - Or set critical services to "Automatic (Delayed Start)" in services.msc
4. Check Hardware/Virtualization Layer
    - Fix drives incorrectly presented as removable in VM configuration or hypervisor layer.
5. Recover file shares
   - Manually restart LanmanServer or use delayed start.

### Cluster resource, ownership, or quorum failures

#### Symptoms

- Cluster disks go offline or don't bring resource online.
- "Cluster Disk X contains an invalid mount point."
- Event IDs 98, 55
- Failover Cluster Manager shows failed resources, lost quorum, invalid signatures

#### Cause

- Incorrect cluster quorum configuration.
- Disk or signature conflicts (duplicate VHDs, snapshots attached).
- Permissions on cluster-related files (MachineKeys), missing cert/key pairs.
- Storage vendor PR (persistent reservation) mismatch or stale entries.

#### Resolution

1. Verify cluster and disk resource. Use:

    ```powershell
    Test-Cluster
    Get-ClusterLog -Destination \<path>
    ```

    - Review and reassign quorum if it's necessary.
2. Correct Permissions
    - On certificate store: SYSTEM and ADMINISTRATORS must have full control on: C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys
    - Re-import required certificates as necessary by using certutil -store -service clussvc\my
3. Handle disk ownership and signature:
    - Detach conflicting or double-mapped VHDs.
    - Verify that all signatures are unique.
    - Involve storage vendor to clear persistent reservations (PRs).
4. Check Group Policy/Security
    - Make sure that Group Policy Object for "Network access: Restrict anonymous access to Named Pipes and Shares" isn't blocking share access.

### Performance and latency issues

#### Symptoms

- High "Avg. Disk sec/Write" (for example, 500 ms)
- Slow backups or queries
- Frequent IO retries
- Excessive shadow copies (more than 1,000).
- Disks appear "full" regardless of free space

#### Cause

- Disk fragmentation, lack of TRIM on SSDs.
- Accumulated VSS or shadow copy snapshots.
- Network or switch misconfiguration or packet loss.
- Full or oversized virtual disks matching physical disk boundary.

#### Resolution

1. Disk and file system optimization
    - SSD: Optimize-Volume -DriveLetter X -ReTrim -Verbose
    - Remove excessive shadow copies: vssadministrator delete shadows /all
2. NFS and iSCSI optimization
    - Verify jumbo frames, set correct MTU:netsh interface ipv4 set subinterface "\<Name>" mtu=9000 store=persistent
3. Disk cleanup
    - Resize VHDs appropriately.
    - Remove orphaned or unused disks by using DevNodeClean:devnodeclean /n (dry run), devnodeclean /r (remove)
4. Firmware, driver and policy review
    - Update HBA, network adapter, and storage driver.
    - Ensure correct antivirus exclusions.

### System, driver, registry, service problems

#### Symptoms

- Storage commands or PowerShell scripts fail and return MetadataError or "Initiator instance does not exist."
- MOF, WMI, provider errors.
- iSCSI Initiator "Favorites" UI lists old IPs after restarts.
- Service doesn't start because of missing permissions or keys.

#### Cause

- MOF file or WMI provider corruption (often triggered by interrupted recompilation).
- OS-level iSCSI subsystem or storage service corruption.
- Known bugs (for example, REFS backup with Veeam on Windows Server 2025, iSCSI UI bug).

#### Resolution

1. MOF file recovery

    - Recompile MOFs:

    ```console
    mofcomp iscsiwmiv2_uninstall.mof
    mofcomp iscsirem.mof
    ...
        
    - Verify WMI and storage provider states and repair as necessary.
2. Permissions and certificate issues
    - Use certutil and file permissions tools and fix missing private keys.
3. Apply relevant hotfixes
    - For Windows Server 2025 REFS with Veeam: [Apply KB5062660](https://support.microsoft.com/help/5062660).
    - For known bugs, monitor for product group guidance.
4. UI and rRegistry updates
    - For iSCSI Initiator Favorites bug, functionality is unaffected. A fix may not be available.

## Common issues quick reference table

| Symptom | Root cause | Resolution |
| --- | --- | --- |
| Disk surprise removed (157) | Storage/network instability | Network configuration, MPIO settings, update drivers |
| Disk RAW/Inaccessible | File system or partition issue | chkdsk, refsutil, adjust partition, backup data |
| "The device has a bad block" (7) | Hardware fault | Replace disk/controller, run vendor diagnostics |
| iSCSI failed to connect (20,27) | Config/network/target issue | Review target IP, reset sessions, fix mappings |
| Cluster disk/ownership errors | Quorum/mount/perm issue | Verify cluster configuration, fix permissions, vendor PR |
| Performance/Backup slowness | Fragmentation, VSS, driver | Disk trim, cleanup shadow copies, update drivers |
| File shares disappear after reboot | Service dep. not set | sc configuration, Delayed Start, review logs |
| iSCSI Initiator UI shows old IP | OS bug | Ignore, no functional impact |
| ReFS/backup hang on 2025 + Veeam | MS bug (KB5062660) | Apply KB5062660 update |
| Incorrect disk mapping | Wrong IP/session/favorite | Remove/add correct targets, use persistent sessions |
| Shadow copies and more than 1,000 | Performance drain | vssadministrator delete shadows /all |
| MOF/WMI errors | WMI/MOF provider corruption | Recompile MOF files, verify repository |

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue.

- **Event Viewer:** Export system, application, and storage logs
    - Filter: Event IDs 9, 20, 27, 39, 43, 55, 98, 129, 153, 157, 507 (and others, if relevant)
- **Cluster:**
    - Get-ClusterLog -Destination \<path>
    - Test-Cluster
- **Disk/Physical Mapping:**
    - Get-WmiObject -Class win32_diskdrive | select \*
    - Get-Disk, Get-PhysicalDisk
- **Network Traces:**
    - netsh trace start scenario=netconnection capture=yes tracefile=\<path>
    - Wireshark .pcap as necessary
- **Performance:**
    - Perfmon, logman for disk/network stats
    - Storport traces: logman create trace drivers_storage
- **Advanced:**
    - refsutil logs for ReFS recovery
    - Output from tools like DevNodeClean, MPIO and iscsicli.exe
- **Service Config:**
    - sc qc \<service>, sc config \<service> depend= MSiSCSI
- **Screenshots:** For UI anomalies (disk management, iSCSI Initiator "Favorites," and so on)

## References

- [Microsoft Docs: iSCSI Initiator](/windows-server/storage/iscsi/iscsi-target-server)
- [Windows Server Failover Clustering](/windows-server/failover-clustering/failover-clustering-overview)
- [KB5062660: Windows Server 2025 REFS Fix](https://support.microsoft.com/help/5062660)
- [Troubleshoot: iSCSI initiator not login to favorite targets](/troubleshoot/windows-server/backup-and-storage/iscsi-initiator-not-login-to-favorite-targets)
- [Microsoft Docs: PowerShell Storage Cmdlets](/powershell/module/storage/)
