---
title: Troubleshoot Windows Server Storage Replica
description: Resolves issues in Storage Replica for Windows Server that provides block-level, synchronous and asynchronous replication for disaster recovery.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:Backup, Recovery, Disk, and Storage\Storage Replica
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Server storage replica

## Summary

Storage Replica (SR) is a robust feature in Windows Server (Datacenter and Standard editions) designed to provide block-level, synchronous and asynchronous replication for disaster recovery and high-availability scenarios. SR support includes single and multi-site clusters and server-to-server replication. Because of its low-level integration with storage, networking, cluster, and authentication infrastructure, SR is sensitive to misconfigurations or environmental issues across a range of layers. This article provides a troubleshooting process that covers symptoms, causes, and solutions for the most common failure scenarios to help administrators quickly diagnose and resolve issues.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting:

- **Verify role and edition**
    - Verify Windows Server edition and SR feature installation on all nodes (Get-WindowsFeature -Name Storage-Replica).
    - Verify licensing (Standard versus Datacenter) and feature compatibility.
- **Verify storage configuration**
    - Make sure that all intended disks (log and data) are visible to all relevant nodes and aren't in use by other services.
    - For clusters, verify that disks are presented as shared storage (not local-only).
- **Check Networking**
    - Open required ports: TCP 445 (SMB), 5445 (SR), 135 (RPC), and 5985 (WinRM).
    - Verify node-to-node and node–to-cluster communication with Test-NetConnection.
- **Review Domain/Permission Requirements**
    - All cluster nodes/servers must be in the same domain or a trusted domain.
    - Verify the SR group accounts have appropriate permissions.
- **Update**
    - Apply all critical and recommended Windows updates and firmware and driver updates for your hardware and HBAs.
- **Cluster and disk prerequisites**
    - SCSI-3 Persistent Reservation support is required. Verify through Failover Cluster Validation reports.
    - Disks must be initialized and formatted (ReFS/NTFS as appropriate). Disks must not use deprecated features (for example, dynamic disks).
- **Verify Storage Replica Topology**
    - Only one-to-one replication is supported. Avoid one-to-many or transitive setups.
- **Collect and review logs**
    - Gather event logs, cluster logs, and SR logs.
    - Run Get-SRGroup, Get-SRPartnership, and Test-SRTopology.

## Common issues and solutions

The following sections detail the most common failure modes and provide step-by-step solutions.

### Storage Replica Partnership doesn't create, shows "Object not found"

#### Symptoms

- Partnership creation fails and returns the following error message: 

   "Unable to create replication group... The requested object could not be found."
- Replication group not visible after creation.

#### Cause

- Missing registry subkey on all nodes:
   HKLM\Cluster\WVR\ConfigStore
- Partnership tried between clusters and servers in different forests and domains.
- Log and data disks not visible or owned by the active node.

#### Resolution

1. On all nodes, make sure that the registry key exists. If not, create it:

    ```console
    HKEY_LOCAL_MACHINE\Cluster\WVR\ConfigStore
    ```
    
2. Clear old SR metadata, if left over from previous attempts:

    ```powershell
    Clear-SRMetadata -AllPartitions -Verify:$false
    Clear-SRMetadata -AllLogs -Verify:$false
    Clear-SRMetadata -AllConfiguration -Verify:$false
    ```
    
3. Verify that both nodes are in the same domain or a trusted domain.
4. Move all involved cluster disks to the node from which the command is run:

    ```powershell
    Move-ClusterGroup -Name "Available Storage" -Node \<NodeName>
    ```
    
5. Retry partnership creation.

### Disks not eligible or "No disks suitable for cluster disks found"

#### Symptoms

- Cluster validation reports error about persistent reservation.
- Can't add disks to the cluster.
- "Element not found" in cluster log or disk wizard.

#### Cause

- Storage doesn't support SCSI-3 Persistent Reservation.
- Disk presented to only one node (not shared storage).
- Physical and logical sector size mismatch between source and target.

#### Resolution

1. Run failover cluster validation:

    ```powershell
    Test-Cluster -Include "Storage Spaces", "Inventory", "Network", "System Configuration"
    ```
    
2. If errors are reported on persistent reservation, make sure that firmware supports SCSI-3 and HBAs are updated. Engage hardware vendor if it's necessary.
3. Present disks to all nodes that require access.
4. Match physical and logical sector sizes by using VHDX creation parameters or by reprovisioning disk on incompatible hosts.

### Orphaned, suspended, or inaccessible storage replica resources

#### Symptoms

- "ReplicationSuspended," "Orphaned," or "WaitingForDestination" for SR resources.
- Volumes remain in raw or inaccessible state.
- Failover or DR groups don't come online after node failure.

#### Cause

- Unexpected cluster node failure or hard shutdown.
- Log and data volume corruption, or incomplete failover transition.
- Orphaned dependencies from incomplete partnership removal.

#### Resolution

1. Try to resume or force move the resource by using Failover Cluster Manager or PowerShell:

    ```powershell
    Sync-SRGroup -Name \<GroupName>
    Move-ClusterGroup -Name \<GroupName> -Node \<AlternateNode>
    ```

2. If the state isn't restored, restart the cluster service on the affected nodes:

    ```powershell
    Restart-Service clussvc
    ```
    
3. If the volume is raw or corrupted, run a file system repair:

    ```console
    chkdsk /f \<DriveLetter>
    ```
    
4. For stuck resources, clear dependencies and metadata:

    ```powershell
    Clear-SRMetadata -AllPartitions -AllLogs -AllConfiguration
    ```
    
5. If DR and primary partnership ownership is unclear or locked, break the partnership fully from the source, and clear all metadata before re-creating.

### Network or permission problems preventing replication

#### Symptoms

- Errors such as: "grant-sraccess: the parameter is incorrect" and "Component server is unavailable."
- Node-to-node connectivity works, but node-to-cluster connectivity fails.

#### Cause

- Required ports closed in firewall or network ACLs.
- Missing or misconfigured Kerberos trust and domain membership.
- Windows services that are required by SR don't run.

#### Resolution

1. Open and verify the required ports between all nodes:
    - TCP 135, 445, 5445, 5985
    - Use Test-NetConnection \<RemoteClusterName> -Port 445
2. Make sure that all nodes and servers are in the same or trusted domains.
3. Verify and start all required services: RPC, Remote Registry, NetBIOS Helper, WMI.
4. Synchronize time zones and clocks.

### Volume and log corruption or metadata issues

#### Symptoms

- "Failed to initialize the replication log path," disk reported as corrupted and unusable.
- Event ID 3012, persistent raw volumes, or failure to bring online.

#### Cause

- Hardware failure or abrupt shutdowns cause log and data corruption.
- Incomplete chkdsk process and repair of the affected volume.

#### Resolution

1. Run chkdsk /f and repair volumes.
2. If issues persist, unmount and mount on another node for backup and re-creation.
3. Recreate log and data partitions, and re-establish SR partnership.

### Unsupported or misconfigured scenarios

#### Symptoms

- One-to-many, cross-domain, or cross-forest replication attempts fail.
- Cluster-to-standalone, or stretch cluster with local disks.

#### Cause

- Only one-to-one replication is supported.
- Stretch clusters require shared disk architecture.

#### Resolution

- Redesign the replication topology to comply with documentation one-to-one, shared disk for cluster scenarios, in a single or trusted domain.

### Known software bugs and post-upgrade failures

#### Symptoms

- S2D disks not attachable after upgrade. 
- "Replication groups do not match" error.
- Disks in detached state after rolling OS upgrade.

#### Cause

- Known bugs in Storage Replica or S2D code.
- Missing feature installation or After-upgrade inconsistency.

#### Resolution

1. Update to the latest cumulative and out-of-band updates.
2. Apply available Known Issue Rollback (KIR) packages.
3. If unrecoverable, rebuild the affected cluster or storage pool according to Microsoft escalation guidance.

**Bugs and ICMs observed**

- May 2025 cumulative update for Storage Replica group creation failure.
- "SPACES 32 BUG" for disk addition in more than seven node clusters (Azure Stack HCI).

## Common issues quick reference table

| Symptom | Root cause | Resolution |
| --- | --- | --- |
| "Unable to create replication group... object not found" | Missing registry key/config | Create HKLM\Cluster\WVR\ConfigStore, clear metadata, reattempt |
| No disks suitable for cluster / cluster validation fails | SCSI reservation, sharing | Update firmware, confirm sharing, allocate as shared, check zoning |
| Volume stuck in "raw" or "orphaned," Event 3012 | Metadata or FS corruption | Run chkdsk, clear SR metadata, recreate partition, reset partnership |
| Disk not eligible - sector size mismatch | 512/4K sector size mismatch | Reprovision disks or VHDs with matching sector size |
| Replication stuck in Suspended/Orphaned | Incomplete failover/crash | Restart cluster service, clear dependencies, move group, repair disk |
| grant-sraccess "parameter incorrect"/network errors | Network/ACL or permissions | Open required ports, check services, confirm domain/trust setup |
| Failover too slow/timeout, thin-provisioned disks | Thin provisioning, large VHD | Increase DeadlockTimeout, use thick provisioning where possible |
| Unsupported scenario errors/NAS | Topology or domain violations | Redesign for one-to-one with shared disks in trusted domains |
| Partnership removal leaves orphaned resource | Dependency/metadata leftover | Run Clear-SRMetadata, manual removal of resources/dependencies |
| "Replication groups do not match" after upgrades | Disk/log size or layout mismatch, bugs | Update clusters, equalize layouts, apply patches, rebuild as needed |

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue.

**General cmdlets**

- Get-SRGroup, Get-SRPartnership, Get-SRReplicationStatus
- Get-ClusterLog -Destination \<path> -TimeSpan 20
- Get-Events, Get-WinEvent -LogName Microsoft-Windows-StorageReplica/Admin
- Test-SRTopology -SourceComputerName <source> -SourceVolume \<vol> -DestinationComputerName \<dest> -DestinationVolume \<vol>
- Clear-SRMetadata
- fsutil fsinfo
- For system/hardware: Get-Disk, Get-Volume, Get-PhysicalDisk
- For network: Test-NetConnection \<dest> -Port 445

**Other**

- Application and system event logs (c:\windows\system32\winevt\logs)
- Diagnostic tool outputs and process monitor traces, as directed
- Cluster validation and precopy reports

## References

- [Storage Replica overview and requirements](/en-us/windows-server/storage/storage-replica/storage-replica-overview)
- [Storage Replica FAQ](/windows-server/storage/storage-replica/storage-replica-frequently-asked-questions)
- [Cluster Shared Volume FAQ](/windows-server/storage/storage-replica/storage-replica-frequently-asked-questions)
- [Known issues and bug fixes](/windows-server/storage/storage-replica/storage-replica-known-issues)
