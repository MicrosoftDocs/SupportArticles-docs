---
title: Troubleshoot Windows Server Storage Sense
description: Resolves issues in Storage Sense, a feature to automatically free up disk space by removing unnecessary files.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:Backup, Recovery, Disk, and Storage\Storage Sense
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Server Storage Sense

## Introduction

Storage Sense is a built-in feature in Windows 11, Windows 10, and Windows Server editions that help you automatically free up disk space by removing unnecessary files. The feature is commonly used to manage local files and stale cloud content, clean up download folders, and manage user profiles in both physical and virtual desktop infrastructure (VDI) environments. However, users might encounter scenarios in which Storage Sense doesn't function as intended because of configuration issues, product bugs, unsupported environments, or external software interference. This article consolidates real-world support experience to provide comprehensive, step-by-step solutions for administrators and support staff.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting:

- Identify the Windows version or SKU (for example, Enterprise, Multi-Session, Server, IoT).
- Determine whether Storage Sense is expected to be available for the OS and SKU.
- Check whether the latest Windows updates (including known hotfixes, such as KB5050092) are installed.
- Check **Group Policy** > **Registry** for the correct configuration (especially for folder cleanup thresholds).
- Verify the Storage Sense settings in Windows **Settings** > **System** > **Storage**.
- Verify that the Storage Sense "scheduled task" exists, and check its state in Task Scheduler.
- Look for relevant error messages in Task Scheduler and Event Viewer.
- Determine whether recent third-party software (antivirus, DLP, backup) exists, and check the updating file access times.
- Check which folders and drives are targeted for cleanup. Also check for open handles.
- Determine whether the issue is file-specific, folder-specific, or profile-specific.
- Review recent system, network, and storage topology changes.
- Determine whether the issue affects a single user, subset, or all users.
- [Optional] Try to manually run Storage Sense, and review storage space changes.

## Common issues and solutions

The following sections detail the most common failure modes and provide step-by-step solutions.

### Storage Sense is missing, not running, or not available

#### Cause

- Feature absent by design (for example, Windows 11 Multi-Session, version 23H2 or 22H2).
- Unsupported SKU or version.
- Known bug (for example, KB5050092 pre-fix environments).
- Scheduled task is removed or unregistered.

#### Resolution

1. Check OS and SKU support: Check whether Storage Sense should be present (consult Microsoft documentation).
1. Apply OS updates:
    - For missing or inactive Storage Sense, install the latest Windows Cumulative Updates.
    - For Multi-Session, version 23H2 or 22H2, apply KB5050092 or later (KB5051989).
1. Check Task Scheduler: If the Storage Sense task is unregistered or missing, this condition might be by design or caused by a bug (reference KB5050092).

#### Workaround

If a feature is missing, use PowerShell or third-party tools and scripts for cleanup.

### Storage Sense runs but doesn't delete files as expected

#### Cause

- Incorrect Group Policy Object or registry settings or targeting.
- Files and folders not in scope for Storage Sense (for example, subfolders in Downloads, nonsystem drives).
- Antivirus or security tools update the "LastAccessTime" file.
- Files are protected: Files are open, in use, hidden, or system-marked.

#### Resolution

1. GPO and registry:
    1. Make sure that policies are applied and registry keys are correct:
        - HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\StorageSense
        - For example, ConfigStorageSenseDownloadsCleanupThreshold DWORD for the Downloads folder.
    1. To check the policy, use gpupdate /force and gpresult /h result.html.
1. Policy Scope:
    Only files that are in the root folder of Downloads are cleaned. Subfolders and customs folders require scripts.
1. Folder and attribute check:
    1. Use PowerShell:

        ```powershell
        Get-ChildItem \<DownloadsPath> | Where-Object { $_.LastAccessTime -lt (Get-Date).AddDays(-30) }
        ```
        
    1. Make sure that files aren't hidden or are system files or in use.
1. Exclude from antivirus scans:
    1. Exclude downloads or relevant folders from routine scanning.
    1. If not possible, use "LastWriteTime" in custom scripts as the date attribute for deletion.
1. Manual Run:
    To verify the configuration, try a manual Storage Sense run through Windows Settings.

### A Storage Sense scheduled task fails ("Class Not Registered" or other errors)

#### Cause

- OS or feature update bug (for example, removal of SettingSyncStateReporter)
- Scheduled task removed or mismatched

#### Resolution

1. Known benign failures: Errors such as "Class not registered (0x80040154)" can typically be ignored if Storage Sense works manually.
1. Update Windows: Await cumulative updates that fix the issue or reference hotfixes.
1. Re-create task: Not required or possible on affected SKUs. Instead, rely on awaiting product update.

### Files and folders not deleted because of attribute or environmental factors

#### Cause

- Files are hidden or system marked (Storage Sense skips these files).
- Locked or open files (through user sessions or third-party tools).
- Antivirus, backup, DLP, Teams, Sync applications update timestamps.

#### Resolution

1. Unlock or release files:
    1. Use Sysinternals Handle.exe or Process Explorer to identify open handles and close them.
    1. To release persistent locks, restart the system.
1. File attributes: Make sure that files aren't hidden or system marked (remove the attributes by using PowerShell or Windows Explorer).
1. Environmental exclusions: Exclude the target directory from scans, especially for antivirus.
1. Custom Script for Folders: Use PowerShell to clean up folders and files:

   ```powershell
   Get-ChildItem "C:\Downloads" -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-30) } | Remove-Item -Recurse -Force
   ```

### User profile container or storage quota errors

#### Cause

- User profile containers reach allocated quota.
- File system or share has a nearly full volume.
- Disk error code (for example, 0xC000CF13), "Not enough space available" in user profile folder.

#### Resolution

1. Increase Quota: Adjust the profile or container size through your profile solution or VHD/VHDX management tools.
1. Disk Management: Use Disk Management (diskmgmt.msc) to check and extend volumes.

### Network or file share inaccessibility post change

#### Cause

- DNS cache holding onto old IP for file share after network or storage migration.
- NLB or DirectAccess misconfiguration.

#### Resolution

1. Flush DNS cache: 
    - ipconfig /flushdns
1. Verify resolution:
    - nslookup \<fileshare>
    - ipconfig /displaydns
1. Restart client: As a last resort, restart the client to refresh the cache.

### Storage system, journal full, or storage device missing

#### Cause

- USN journal full or hits allocation limits (event log/stacks show journal or cluster errors).
- Disk/LUN not detected after Storage ID change or topology update.

#### Resolution

1. Clear USN Journal:
    - fsutil usn deleteJournal /D \<DriveLetter>:
1. Run Chkdsk:
    - chkdsk /f \<DriveLetter>:
1. For device issues:
    1. Rescan disks in Device Manager.
    1. Coordinate with storage vendor for array or device remapping.
    1. Restart if the issue remains unresolved.

### Permission denied errors on folders or VM disks

#### Cause

- Incorrect or missing SYSTEM or user permissions.
- Password or credential changes not synced.

#### Resolution

1. Check Permissions:**
    - Get-Acl \<path> in PowerShell to verify SYSTEM or full control.
1. Adjust ACLs:** Use **Properties** > **Security** tab or icacls command.
1. Sync credentials: Perform a password change as necessary. Then, verify again.

### Security vulnerability in storage components

#### Cause

- A CVE affects storage (as referenced in cases).
- Awaiting update deployment.

#### Resolution

Apply security updates: Track and install the relevant Windows updates that address the CVE.

## Common issues quick reference table

| Symptom | Root cause | Resolution |
| --- | --- | --- |
| Storage Sense missing on Multi-Session | By-design removal, product bug | Install KB5050092 / KB5051989 if applicable |
| Storage Sense task "Class not registered" | OS component removal/known benign error | Ignore, apply updates, manual run if needed |
| Files not deleted in Downloads | AV touches files, policy not set, only files not folders | Exclude from AV, review GPO/reg, script for folders |
| Cloud files not dehydrating | Attribute (hidden/system), recent access | Unset attributes, check access logs, use non-hidden |
| File share inaccessible after IP change | DNS cache outdated | ipconfig /flushdns; restart if unresolved |
| Profile or folder reports "not enough space" | Quota exceeded, share is full | Increase quota, extend share, clean up space |
| USN journal or storage journal full | Lifetime limit hit | fsutil usn deleteJournal /D \<drive>; chkdsk |
| Hyper-V "access denied" attaching disk | Missing permissions on config directory | Reset SYSTEM/user permissions on the folder |
| Storage not detected after LUN/storage change | Storage IDs mismatch, device hidden | Rescan in Device Manager, reboot, storage vendor support |
| Storage Sense doesn't clean nonsystem drives | Unsupported in current design | Use custom scripts for nonsystem drives |

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue.

- **Policy/Registry Export:**
    - gpresult /h gp.html
    - Reg export commands for relevant keys
- **Task Scheduler Snapshots**
    - Status and history for Storage Sense task
- **PowerShell for File Metadata:**
    - Get-ChildItem \<path> | select Name, LastAccessTime, Attributes
- **Sysinternals Utilities:**
    - Handle.exe, Process Monitor (Procmon), Process Explorer
- **Disk Tools:**
    - diskmgmt.msc
    - chkdsk /f \<drive>
    - fsutil usn deleteJournal /D \<drive>
- **Event/System Logs:**
    - Storage Sense: C:\Windows\System32\LogFiles\setupcln\setupact.log
    - Event Viewer: Application, System, Hyper-V, FailoverClustering logs
- **Network:**
    - ipconfig /displaydns, ipconfig /flushdns, nslookup \<host>
- **Profile Quota:**
    - Management tools, PowerShell, or solution-specific utilities

- **Command-line reference table**

| Scenario | Sample commands |
| --- | --- |
| GP Verification | gpresult /h gp.html |
| Registry Export | reg export \<key> \<file> |
| File Metadata | Get-ChildItem \<path> / dir /ta |
| Disk Health | chkdsk /f \<drive> |
| USN Journal | fsutil usn deleteJournal /D \<drive> |
| Task Scheduler | Open Task Scheduler app |
| DNS Issues | ipconfig /flushdns / nslookup |

## References

- [Microsoft Storage Sense documentation](https://support.microsoft.com/windows/manage-drive-space-with-storage-sense-654f6ada-7bfc-45e5-966b-e24aded96ad5)
- [Known issue KB5050092](https://support.microsoft.com/help/5050092)
- [USN Journal documentation](/windows/win32/fileio/change-journal-records)
- [OneDrive Files On-Demand](https://support.microsoft.com/office/learn-about-onedrive-files-on-demand-0e6860d3-d9f3-4971-b321-7092438fb38e)
- [Sysinternals utilities](/sysinternals/)
- [Group Policy Central Store guidance](../../windows-client/group-policy/create-and-manage-central-store.md)
