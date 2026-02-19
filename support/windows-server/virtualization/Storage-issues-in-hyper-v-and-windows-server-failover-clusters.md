---
title: Troubleshoot Storage Issues in Hyper-V and Windows Server Failover Clusters
description: Resolves issues in storage configuration for Windows Server and Hyper-V clustered environments. 
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:Virtualization and Hyper-V\Storage configuration
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot storage issues in Hyper-V and Windows Server failover clusters

## Summary

Storage configuration is a critical component of any Windows Server or Hyper-V clustered environment. Proper setup ensures high availability, reliable performance, data integrity, and minimal downtime of applications and virtual machines. Misconfigurations or environmental changes can trigger a range of issues—from storage resource unavailability, virtual machine (VM) failures, and performance bottlenecks, to more subtle symptoms, such as periodic event log warnings. This article provides guidance for administrators to resolve common storage configuration problems.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting:

- Verify that all hardware (disks, HBAs, switches) is compatible with the OS version.
- Verify that all relevant device drivers, storage firmware, and DSM (Device Specific Module) software are up to date.
- Perform a visual inspection of the physical connections (cables, SFPs, network, and storage cabling).
- All cluster nodes see shared storage (in Disk Management and Failover Cluster Manager).
- Verify that Multipath I/O (MPIO) is correctly installed and configured on all nodes.
- Verify that Hyper-V and failover clustering features are enabled and correctly configured on all nodes.
- Verify that VM and storage paths are accessible from all nodes (test by using file explorer or Get-ClusterSharedVolume on each node).
- Verify that sufficient CSV and volume capacity exists for the planned workloads.
- Verify that no conflicts exist between antivirus, filter drivers, or unsupported third-party software.
- Review event logs for recent critical or warning events related to storage, clustering, or disk.

## Common issues and solutions

The following sections detail the most common failure modes and provide solutions.

### CSV (Cluster Shared Volume) paused state

#### Symptoms

- VMs unresponsive
- Event ID 5120/5142/153, "All I/O will temporarily be queued until a path to the volume is reestablished."

#### Cause and Resolution

- Network bottleneck or misconfiguration (for example, Network adapter teaming mismatch):
    - Align network adapter teaming on ALL nodes (Get-NetLbfoTeam)
    - Verify teaming configuration and re-enable teaming where disabled.
    - Consider offloading CSV and live migration traffic to a dedicated network.
- Network adapter resource exhaustion (Event ID 252 warnings)
    - Increase RAM and network adapter resources as recommended by hardware vendor.
    - Monitor resource allocation and adjust or upgrade network adapters, if recurring.
- Physical disk or HBA failure:
    - Review disk health (Get-PhysicalDisk | Format-Table), Event ID 157.
    - Replace faulty disks/HBAs, reseat or reconnect as necessary.
- Hardware switches or cables fault (for example, abnormal voltage on FC switch):
    - Check storage switch logs and counters.
    - Replace faulty hardware components, reroute cabling.
- Insufficient CSV or volume capacity
    - Expand volume or CSV space.
    - Consider setting up CSV monitoring for proactive alerts.
- Multiple antivirus or unsupported filter drivers:
    - Uninstall all but one antivirus program. Remove unsupported filter drivers (use fltmc for inspection).

### Storage path issues and disk visibility problems

- Symptoms Disks missing in Disk Management, unexpected "read-only"/“offline"/"deallocated" states, Event ID 11/153/129, failover failures

#### Cause and Resolution

- Incorrect/Corrupt MPIO configuration:
    - Confirm all paths in MPIO are Online (use mpclaim -s -d).
    - Update/reinstall MPIO.
    - Switch to vendor DSM if available (especially for enterprise SANs).
- Outdated/incorrect drivers:
    - Update storage drivers, SAN firmware, and DSM/MPIO software.
- Volume not accessible on all nodes:
    - Check permissions and path mapping.
    - Use Get-ClusterSharedVolume on each node to verify path.
    - For CIFS/SMB shares, make sure that cluster and SCVMM accounts have necessary access.
- Disk or path locked by other process:
    - Restart node, use handle.exe or procmon.exe to identify process.
    - If stuck, detach disk from VM, restart node, and reattach.
- Physical or virtual storage pool misconfiguration:
    - Use Get-StoragePool, Get-VirtualDisk, Get-ClusterResource to verify health.
    - Realign pool memberships as needed.

### Disk permission and Access Denied problems

#### Symptoms

- Migration failures
- Backup failures
- Storage migration returns "Access Denied 0x80070005"
- "Account does not have permission to open attachment" error message

#### Cause and Resolution

- Incorrect NTFS permissions
    - Use icacls <Path\To\Disk.vhdx> /grant "NT VIRTUAL MACHINE\<VM_GUID>:(F)" to set correct permissions.
    - Reclaim ownership if locked: Advanced Security > Owner: Administrators > Apply permissions again.
- Cluster/SCVMM accounts missing from SMB/CIFS shares
    - Add both SCVMM service account and cluster name object to file share permissions.
    - For NetApp/SAN-based CIFS, make sure that AD objects have proper rights.
- Locked files from process crash or lost handle
    - Restart server/node to release file lock.
    - Check file handle by using handle.exe, process explorer, Procmon.

### Cluster service instability and known update issues

#### Symptoms

- Cluster service (clussvc) fails
- Event 7031
- Nodes don't join or enter quarantine after updating
- VMs restart unexpectedly

#### Cause and Resolution

- Known product bug (for example, KB5062557 on Windows Server 2019 S2D):
    - Remove problematic update via Windows Update history.
    - Deploy KIR MSI per official advisory.
    - Reference: [IcMPath to OS work item 52578872]
- Misconfigured quorum or CSV mapping:
    - Review and adjust quorum settings and CSV allocations as required.

### Performance degradation and high latency

#### Symptoms

- High storage latency
- poor IOPS
- VM or application slowness
- Recurring timeouts (Event ID 5120, 5142)

#### Cause and Resolution

- Disabled or misconfigured S2D cache settings:
    - Re-enable/optimize using proper registry values (HKLM:\SYSTEM\CurrentControlSet\Services\Spaceport\Parameters).
    - Review cache/SSD tier health (Get-PhysicalDisk).
- Insufficient or unbalanced hardware resources:
    - Add or upgrade NVMe and SSD according to S2D requirements.
    - Monitor and rebalance workloads and repair tasks.

## Common issues quick reference table

| Symptom | Cause | Resolution | Key commands |
| --- | --- | --- | --- |
| CSV Paused, Event 5120/5142 | Network bottleneck, Network adapter teaming, disk fail | Check teaming, Network adapters, capacity, update drivers, check CSV health | Get-NetLbfoTeam, Get-ClusterSharedVolume |
| Event 153/129/11 on disks | Faulty disk/HBA, MPIO config, outdated driver | Replace hardware, update/configure MPIO/DSM, update drivers | mpclaim -s -d, Get-PhysicalDisk |
| Storage inaccessible on nodes | Permissions, network, pool config | Verify permissions, paths from all nodes, pool and virtual disk health | icacls, Get-ClusterSharedVolume, Get-VirtualDisk |
| Access Denied (0x80070005), migration errors | NTFS/Shares permissions, locked files | Correct permissions, reclaim ownership, restart to release locks | icacls, ProcessExplorer/Procmon |
| Cluster service failure, Event 7031, VMs restart | Faulty update (for example, KB5062557), quorum | Uninstall update, apply KIR, verify quorum and cluster service | Update history, KIR MSI |
| High storage latency, persistent timeouts | Disabled S2D cache, hardware exhaustion | Enable/optimize cache, add/upgrade disks, rebalance storage pools | Registry, Get-PhysicalDisk |

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue.

- **Cluster logs:** Get-ClusterLog -UseLocalTime -TimeSpan 60
- **FailoverClustering event logs:** Export relevant logs using Event Viewer.
- **CSV and storage information:**

    ```powershell
    Get-ClusterSharedVolume | fl
    Get-PhysicalDisk | Format-Table FriendlyName, CanPool, OperationalStatus, HealthStatus
    Get-VirtualDisk | Format-Table FriendlyName, HealthStatus
    ```
- **MPIO and disk info:** mpclaim -s -d diskpart > list disk
- **Network Adapter and Team Status:** Get-NetAdapter Get-NetLbfoTeam
- **Permissions:** icacls <Path\To\Disk.vhdx>
- **Procmon trace:** procmon.exe /Quiet /Minimized /Backingfile \<tracefile.pml> (reproduce issue) > procmon.exe /Terminate
- **Handle.exe (Sysinternals):** handle.exe > handles.txt
- **Driver and firmware versions:** Get-WmiObject Win32_PnPSignedDriver | Select-Object DeviceName, Manufacturer, DriverVersion

## References

- [Get-ClusterLog documentation](/powershell/module/failoverclusters/get-clusterlog)
- [Storage Spaces Direct hardware requirements](/en-us/windows-server/storage/storage-spaces/storage-spaces-direct-hardware-requirements)
- [Windows Server storage architectures with Hyper-V](/windows-server/virtualization/hyper-v/storage-architecture)
