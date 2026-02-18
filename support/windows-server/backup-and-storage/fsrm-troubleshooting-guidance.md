---
title: FSRM Troubleshooting Guidance
description: Provides troubleshooting methods for issues that affect File Server Resource Manager (FSRM) and Windows file storage components.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:Backup, Recovery, Disk, and Storage\File Server Resource Manager (FSRM)
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# FSRM troubleshooting guidance

## Summary

File Server Resource Manager (FSRM) and Windows file storage components manage quotas and screen file types, and report on file server usage in enterprise environments. These applications can be affected by a variety of issues, including permission problems, configuration errors, and service failures. This article provides troubleshooting guidance for these issues in Windows Server 2016 and later versions.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting:

- **Clarify the issue**
    - Is it a service error, access denial, policy not applying, or something else?
    - Collect error messages, event IDs, and affected paths, drives, and users.
- **Establish the scope**
    - Is the issue affecting all users or only some?
    - Is it isolated to particular volumes, folders, or file types?
- **Verify system health**
    - Are all critical services (FSRM, RPC, and so on) running?
    - Are any disks marked as dirty or offline?
    - Do recent OS errors, disk errors, or application errors appear in Event Viewer?
- **Check configuration**
    - Verify that the correct file system (NTFS) and permissions are configured.
    - Are quotas, screens, and policies correctly applied and visible in FSRM?
    - Is the FSRM role or feature installed and up to date?
- **Try reproduction**
    - Try to reproduce the issue by using test accounts or different scenarios to verify consistency.
- **Record all applied fixes**
    - Maintain a log of actions and commands that are used during troubleshooting.

## Common issues and solutions

The following sections detail the most common failure modes and provide step-by-step solutions.

### FSRM console doesn't load, Access Denied, or Service Start failure

#### Symptoms

- "Access Denied" (0x80070005) error message when you try to open quotas.
- FSRM console stops responding.
- FSRM service doesn't start ("Unexpected error 0xc00cee22" or "XMLReader::parseURL ... quota.xml, 0xc00cee2d").
- Event log error entries referencing permission issues on quota.xml or related files.

#### Resolution

1. Repair file permissions:  

    1. Stop FSRM service: net stop srmsvc
    2. Take ownership and set permissions:

        ```console
        takeown /f "C:\System Volume Information\SRM\quota.xml"
        icacls "C:\System Volume Information\SRM\quota.xml" /grant administrators:F
        attrib -s -h "C:\System Volume Information\SRM\quota.xml"
        ```
        
    3. If the XML is corrupted, rename or delete it (after you back it up), restart FSRM, and then reconfigure the quotas.
2. Repair or reregister the WMI repository:

    ```console
    winmgmt /verifyrepository
    winmgmt /salvagerepository
    net stop winmgmt
    net start winmgmt
    net stop srmsvc
    net start srmsvc
    ```
    
3. Reregister srmsvc.dll:

    ```console
    regsvr32 /i srmsvc.dll
    ```

### Quotas, screens, or template issues

#### Symptoms

- Quotas and file screens don't update or aren't visible.
- Policies don't apply or affect only new users.
- Errors messages that mention "Update-FsrmAutoQuota," or you can't assign quotas or screens to certain volumes.

#### Resolution

1. Check the file system type. FSRM works only together with NTFS. Volumes that use ReFS can't be managed by FSRM. Move data to NTFS to use FSRM functionality.
2. Correct quota templates:
    1. Open FSRM, verify that templates match the intended policy.
    1. Reapply autoapply quotas: Use Set-FsrmAutoQuota -Path ... -Template ... -UpdateDerived.
    1. For bulk soft or hard quota conversion, edit the shared template, and then select **Apply to all derived quota**.
3. Fix PowerShell or COM object issues:
    1. Make sure that scripts use 64-bit PowerShell.
    1. Reinstall or reregister FSRM role or DLLs.
4. File screenshot or blocking:
    1. Export a working file screen from another server, and then re-import.
    1. For files that don't match the intended patterns, rebuild or correctly configure the file screen groups or templates.

### Access Denied, read-only, or file copy errors

#### Symptoms

- "Access Denied" to drives or folders.
- All files that are copied or created are read-only.
- You can't delete or rename files because of long file or path names.
- A PDF or specific file type copy fails, although others types succeed.

#### Resolution

1. Permissions and inheritance:\<FolderPath> /r /d y and icacls \<FolderPath> /grant administrators:F /t. For inheritance: Use PowerShell to set AreAccessRulesProtected to false.
2. Clear the read-only status by using diskpart:

    ```console
    diskpart
    list disk
    select disk <number>
    attributes disk clear readonly
    ```
3. Long paths: Use robocopy or compatible deletion tools. Windows Explorer and default DEL command have legacy path length limits.
4. Zone.Identifier issues (files blocked after download): Unblock all files in a directory:

    dir .\\* | Unblock-File

### Cluster, failover, and file share issues

#### Symptoms

- Nodes don't join cluster, or FSRM doesn't start on secondary node.
- Mount points don't appear, or drive sizes are reported incorrectly.
- Persistent reservation errors and cluster resource placement problems occur.

#### Resolution

1. Cluster Resource or Storage Grouping:    
    - Make sure that cluster IP and name resources are under the cluster core group.
    - Move resources as necessary:

    Move-ClusterResource -Name \<name> -Group "Cluster Group"

2. Offline or corrupted cluster disks: Evict and restore nodes as necessary. Run CHKDSK /F on offline disks.
3. Drive Letter for mount points: Assign a drive letter to the volume if visibility in Explorer is required.

### File screening save and Microsoft Excel issues (.tmp Blocked)

#### Symptoms

- Saving macro-enabled spreadsheets (.xlsm) fails because of .tmp file blocks.
- Event log entry: Access Denied, but not for the .xlsm file itself.

#### Resolution

1. Remove the .tmp extension from the relevant FSRM file screen group for the affected share.
2. After the change, verify that you can successfully save by using a temporary file.

### FSRM service or role installation or startup fails

#### Symptoms

- "CBS_E_SOURCE_MISSING" when you try to install FSRM.
- Service fails and generates .NET or feature dependency errors.

#### Resolution

1. Mount the Windows installation ISO, and provide the SxS path:

   DISM /Online /Enable-Feature /FeatureName:FS-Resource-Manager /All /Source:D:\sources\sxs /LimitAccess
2. Install or repair the required prerequisites (for example, .NET 3.5).

### Disk expansion, repair, or sudden space loss

#### Symptoms

- Can't extend a partition unless unallocated space is immediately adjacent.
- Disk repair (chkdsk/REPAIR-VOLUME) takes excessively long or repeats.
- Sudden disk space loss, high NTFS log or event log consumption.

#### Resolution

1. Partition extension:
    - Delete or back up the adjacent drive E to make space, extend drive D, re-create drive E, restore data.
2. Disk repair:
    - Run: chkdsk /scan, and then run chkdsk /spotfix for offline repairs, if possible.
3. Space loss:
    - Use tools such as WinDirStat to find large file growth.
    - Offload or archive event logs.
    - Enable event forwarding and maintain minimal local log retention.

### Robocopy, backup copy issues (SID, /B, /Z options, access errors)

#### Symptoms

- Robocopy fails and returns Error 1317 (account doesn't exist) when you copy files that have unresolvable SIDs in permissions.
- /B or /ZB options don't work as intended.

#### Resolution

1. To avoid copying owner SIDs, run Robocopy by using /copy:datsu instead of /copy:datsou.
2. Make sure that the running account has backup and restore rights on both the source and destination for /B or /ZB.
3. For /Z (restartable mode), verify that the OS version matches known compatibility and bug lists.

## Common issues quick reference table

| Symptom | Root cause | Fastest fix / Commands | Notes |
|-----|-----|-----|-----|
| FSRM console error: access denied | Permissions on SRM\quota.xml | takeown/icacls/attrib, restart srmsvc | Backup quota.xml |
| Quotas not updating or applied, templates not working | Outdated or mismatched templates | Set-FsrmAutoQuota, edit or reapply template | Use 64-bit PS |
| Can't assign quotas to ReFS volumes | FSRM NTFS-only | Move data to NTFS | ReFS not supported |
| .pdf or .xlsm can't be saved or copied despite access | Zone.Identifier or .tmp blocked | dir .\* | Unblock-File, edit screen group, remove .tmp block |
| FSRM service doesn't start, parse errors in XML | Corrupted quota.xml, unescaped "&" | Replace with "&," takeowner, restart service |  |
| Disk repair/expand fails | Dirty flag, unallocated space issues | chkdsk /spotfix, delete adjacent partition extend, diskpart clear read-only | Plan downtime |
| File screens block unexpected extensions | Template corruption or accidental mislist | Export and import from good server, verify templates | Consistency |
| Cluster failover fails, resource offline | Resource misplacement, PR error | Move-ClusterResource, chkdsk, fix dependencies | Review cluster log |
| Robocopy fails and returns SID errors, /B or /Z options not working | Missing backup or restore rights or invalid SID | Assign rights, Robocopy /copy:datsu, use admin account | Bug in /Z (doc) |
| File or folder stuck as read-only | Disk or registry attribute |dDiskpart attributes, registry StorageDevicePolicies | Check vendor drivers |
| Can't delete or rename because of long path | Windows path limitation | Try Robocopy or third-party tool, enable longpath policy on new OS | OS limitation |

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue.

- **Event Logs:** Application, System, SRMSVC, NTFS Operational, custom FSRM logs.
- **Procmon/Process Monitor Traces:** For file access errors and third-party driver analysis.
- **PowerShell Outputs:**
    - Get-Acl \<folder>
    - Get-FsrmQuota: Select-Object Path, Size, Usage
    - Get-FsrmAutoQuota
- **DISM logs:** For role or feature installation
- **Cluster and diskpart outputs:** If clusters or storage pools are involved
- **FSRM exports:** dirquota template export, and so on
- **Robocopy logs:** /log:\<path>
- **WinDirStat disk usage snapshots**
- **Network traces (if relevant):** For SMB/connectivity issues

**Command-line example:**

```console
# Permissions and ownership
takeown /f "<path>" /r /d y
icacls "<path>" /grant administrators:F /t

# FSRM quota exports
dirquota quota list > quotas.txt

# Unblock alternative data streams
Get-ChildItem -Path <path> -Recurse | Unblock-File
```

## References
- [File Server Resource Manager overview](/windows-server/storage/fsrm/fsrm-overview)
- [FSRM PowerShell module](/powershell/module/fileserverresourcemanager)
- [Windows Server storage spaces prerequisites](/windows-server/storage/storage-spaces/deploy-storage-spaces-direct)
- [WinDirStat download](https://windirstat.net/)
- [Using Robocopy](/windows-server/administration/windows-commands/robocopy)
- [Diskpart tool reference](/windows-server/administration/windows-commands/diskpart)
- [Process Monitor v4.01](/sysinternals/downloads/procmon)
