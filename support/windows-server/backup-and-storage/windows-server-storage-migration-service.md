---
title: Troubleshoot Windows Server Storage Migration service
description: Resolves issues in Windows Storage Migration (Robocopy, Storage Migration Service [SMS], and other tools) and Hyper-V Storage Migration. 
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:Backup, Recovery, Disk, and Storage\Storage migration
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Server Storage Migration service

## Summary

Windows Storage Migration includes tools such as Robocopy, Storage Migration Service [SMS], and Hyper-V Storage Migration. These tools are essential for administrators to move data, share drives, and server identities between environments or hardware. Migration failures can manifest as data loss, security risks, unexpected downtime, or complex permission issues. This article provides a diagnostic process and actionable solutions based on real-world cases to help you efficiently resolve the most common and challenging troubleshooting scenarios in storage migration operations across Windows Server environments.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting:

1. **Preparation**
    - Verify that all planned destination drives are sized appropriately and formatted as NTFS or ReFS.
    - Verify that hardware and OS compatibility across source and destination.
    - Have a tested and recent backup or snapshot available.
2. **Permissions**
    - Verify that the migration accounts have administrative rights on both source and target.
    - Make sure that SMS accounts are domain-joined and, if it's required, are a local administrator on the server.
    - Verify that NTFS and share permissions are correctly set for all folders and files to be migrated.
3. **Network**
    - Test the connectivity between source and destination (ping, Test-WSMan, Test-NetConnection).
    - Make sure that all necessary ports are open (especially for WMI, RPC, SMB).
    - Check VPN and firewall rules if crossing subnets or geographical sites.
4. **Services and Features**
    - Verify that required Windows features and roles (for example, iSCSI, SMS, file server, clustering) are installed and running.
    - For Hyper-V, make sure that services and cluster roles are healthy.
5. **Source and Destination Health**
    - To detect errors, run chkdsk and fsutil on source and destination volumes.
    - Verify that disks aren't at or near capacity, and that the file system is healthy.
    - Remove unnecessary shadow copies before migration.
6. **Backup and Safety**
    - Export registry keys for share settings.
    - Back up permissions and document account SIDs, if possible.
    - Document migration tool switches and environmental variables.

## Common issues and solutions

The following sections detail the most common failure modes and provide step-by-step solutions.

### Permission or Access Denied errors

#### Symptoms

- "Access denied" or "insufficient permissions" in logs or UI.
- Event IDs: 5000, 1069, 45062.
- Migrated files are inaccessible or missing inherited permissions.

#### Resolution

1. NTFS ACLs: To preserve permissions, use Robocopy together with /COPYALL or /SEC:

    ```console
    robocopy <Source> <Destination> /MIR /COPYALL /SEC /R:3 /W:5 /LOG:robocopy.log
    ```
        
    Run as an account that has full (preferably SYSTEM) permissions on both servers.
2. Share Permissions:
    1. On the source, export the share registry:

    ```console
    reg export "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Shares" shares.reg
    ```
        
    1. On the destination, **import** and restart or restart LanmanServer service.
    1. After migration, use GUI or PowerShell to verify permissions.
3. Account/SID Issues:
    1. Align built-in administrator account names, and make sure that matching SIDs.
    1. Use PowerShell to list accounts and SIDs:

    ```powershell
   Get-LocalUser | Where-Object { $_.Enabled -eq $true } | fl Name,SID
    ```
       
    1. If it's necessary, assign permissions after migration by using icacls or PowerShell.

### Failed or Stuck Migration Jobs (SMS/Robocopy/Hyper-V)

#### Symptoms

- "Couldn't transfer some devices."
- Jobs stop responding at certain percentages or log "insufficient resources."
- SMS inventory scan repeatedly fails ("partially succeeded," error code 0x800705AA).

#### Resolution

1. Check Account and Service Permissions:
    1. Verify SMS runs as an account with full control.
    1. For stuck Robocopy jobs, run with SYSTEM permissions or elevate prompt.
2. File System and Path Checks:
    1. Enable long path support:

    ```console
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f
        ```     

    Restart required.
    1. Use Get-ChildItem -Path <Path> -Recurse | Where-Object { $_.Name -match "[<>:/\\|?\*]" } in PowerShell to detect invalid file/folder names.
3. Tool/Feature Limitations:
    1. SMS doesn't support migrating domain-joined to workgroup servers or across untrusted domains.
    1. If migration is unsupported, consider robocopy or manual intervention.
4. Process/Locking Issues:
    1. Stop services or processes (like SyncShareState/antivirus) that may be locking files.
    1. On cluster disks, clear reservations:

    ```powershell
    Clear-ClusterDiskReservation -Disk \<DiskNumber>
    ```
        
5. Resource Shortages:
    1. Free up system resources: check CPU/memory usage, close open files, increase storage array queue depth if Event 153.
    1. For Hyper-V: Detach shared VHDs before moving, stop VM for moving shared disks.

### File/Folder Discrepancies (Size, Visibility, or Incomplete Copy)

#### Symptoms

- "Size on disk" differs between source and destination.
- Some files don't appear after migration.
- Robocopy log notes files as "updated" when unchanged.
- Event IDs: None or general user confusion.

#### Resolution

1. Sector Size/Allocation Unit Differences:
    1. Understand that NTFS allocates space differently on 512- vs. 4K-sector disks; file "size on disk" varies, but data remains intact.
    1. Verify that with fsutil or disk properties.
2. Hidden or protected folders: System Volume Information, $RECYCLE.BIN, and similar folders are re-created automatically. Ignore errors for these folders. Files may be hidden because of attributes. View them in File Explorer (select **Show hidden files**) or:

    ```powershell
    Get-ChildItem -Path \<Path> -Force
    ```
        
3. Transfer-of-Changes confusion:
    1. Robocopy /MIR performs a mirror. Use /M for archive attribute. For incremental only, use /XO, /XC, /XN and reference logs.
    1. Review migration tool documentation for logic on differential sync.

### Cluster Disk or Hyper-V Migration Failures

#### Symptoms

- Disk resource fails to come online (Error 995).
- Hyper-V: "The disk cannot be moved because it is marked as shareable."
- "OnlineThread: Error 995 bringing resource online"

#### Resolution

1. Shadow copies or backup interference:**
    1. Remove all shadow copies that are created by third-party backup tools.
    1. Use vssadmin (vssadmin list shadows) or the vendor's own tools for cleanup.
2. Cluster/CSV Configuration:
    1. Remove and restore the disk to the cluster, as necessary.
    1. Always stop VMs and unmount disks before moving.
    1. After migration, reconfigure roles, dependencies, and permissions.
3. Shareable Attribute:
    1. Detach shared VHDs from all VMs.
    1. Move/copy the disk to new storage.
    1. Reattach after move is complete.

### Path, long path, and invalid characters errors

#### Symptoms

- Errors such as "Path cannot be found," "Path contains invalid characters," "Path is too long."
- Actual migration failures for specific files or folders.

#### Resolution

1. Fix Paths and Characters: Enable long path support, and remove or rename files that have invalid characters in the file name.
2. Script Solutions:
    1. Run a test script to enumerate all files and folders before the migration attempt.
    1. Use dedicated tools for batch renaming or removal.

### Unexpected file timestamp or access time changes

#### Symptoms

- LastWriteTime updates after migration on Windows 11 but not Windows 10.
- User confusion about post-migration file modification dates.

#### Resolution

Understand MOTW implementation: Windows 11 (June 2024 and later) applies Mark-of-the-Web to files from untrusted networks, changing timestamps. To prevent this issue, add network paths to Trusted Sites/Local Intranet.

## Common issues quick reference table

| Symptom | Event ID / Message | Root cause | Resolution |
| --- | --- | --- | --- |
| Access Denied / Permissions fail | 5000, 45062 | NTFS/Share permissions, wrong account | Use /COPYALL, align SIDs, export/import registry shares, adjust permissions |
| Inventory scan fails (SMS) | 2506, 2513, 7004, 0x800705AA | Account, network, long path, firewall | Grant permissions, open ports, enable long paths, clear locks |
| Robocopy logs "updated" files wrongly | N/A | Incorrect switches, incompatible sources | Review switches, match source/dest filesystems, filter logs |
| Disk won't come online in cluster | 995, 1069 | Shadow copies, reservations | Remove shadow copies, clear reservations, repair cluster config |
| Hyper-V shared disk moves fail | "Disk can't be moved..." | Shareable disk attribute | Detach from VMs, manual move/copy, reattach |
| Stuck or slow migration | N/A | Locked files, resource limits | Stop open processes/services, increase queue depth, upgrade HW |
| Path too long/invalid character errors | "Path is too long" etc. | Invalid char, &gt;260 chars | Clean up names/paths, enable long path support |
| LastWriteTime changed after migration | N/A | MOTW in Windows 11 | Add share to Trusted Sites, user education |
| System folders fail to migrate | "Couldn't transfer some devices", CSV log | By design | Ignore, expected behavior |

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue.

- **Robocopy logs** (/LOG+:\<path>//unilog+:\<path>) – full and differential copies
- **SMS logs:** C:\ProgramData\Microsoft\StorageMigrationService\Logs\\*
- **Event Viewer (System/Application/StorageMigrationService) logs** – filtered to relevant times and Event IDs
- **Cluster logs:** Get-ClusterLog on all nodes
- **Disk/scanning utilities:**
    - fsutil fsinfo for sector and allocation unit details.
    - du.exe or WinDirStat for directory size breakdown
- **PowerShell outputs:**
    - Get-ChildItem with filters for path and attribute issues
    - icacls output for critical paths
- **Snapshots of registry for share settings:**
    - Exported as .reg file

## References

- [Storage Migration Service documentation](/windows-server/storage/storage-migration-service/overview)
- [Robocopy reference](/windows-server/administration/windows-commands/robocopy)
- [Share permissions migration](/answers/questions/1193948/how-to-migrate-file-server-data-with-permissions-u)
- [Cluster-shared volume documentation](/windows-server/failover-clustering/failover-cluster-csvs)
- [Known issues in SMS](/windows-server/storage/storage-migration-service/known-issues)
