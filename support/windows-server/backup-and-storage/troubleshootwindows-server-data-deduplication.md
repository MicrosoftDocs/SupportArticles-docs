---
title: Troubleshoot Windows Server Data Deduplication
description:  Provides troubleshooting methods for issues that affect Windows Server data deduplication.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:Backup, Recovery, Disk, and Storage\Deduplication
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Server data deduplication

## Summary

Windows Server data deduplication is a widely used feature for optimizing disk space by removing redundant data blocks and storing only unique information. Although deduplication offers significant storage savings, it also introduces complexity that can cause a variety of failure modes, such as job failures, space reclamation issues, file access problems, high chunkstore usage, and errors in migration scenarios.

This article provides a methodical approach to diagnosing and resolving common data deduplication problems in Windows Server 2022, 2019, and 2016 across NTFS and ReFS file systems.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting:

- **Validate disk space and free space**
   - Make sure that there is at least 10 free free space on deduplicated volumes. Chunk storage should not exceed 80-90 percent usage.
- **Check system resources**
   - Verify that there is sufficient RAM (minimum 1 GB or 1 TB logical data) and adequate CPU, and that memory and CPU thresholds aren’t exceeded.
- **Review deduplication job status**
   - Use PowerShell to check whether jobs are running, stuck, or failing.
- **Examine event logs**
   - Look for relevant deduplication, system, and application log events.
- **Inspect file system health**
   -  Run chkdsk /scan, and repair if necessary (for NTFS).
- **Check the deduplication role or feature state**
   - Verify that the deduplication role is installed and enabled on volumes.
- **Assess recent changes**
   - Review any OS upgrades, server migrations, or new security and backup software deployments.
- **Verify deduplication settings**
    - Make sure that deduplication scheduling, volume support, and memory or core allocations align with best practices.
- **Backup and disaster recovery**
   - Make sure that backups are up to date. Do not repair or migrate servers without working backups.

## Common issues and solutions

The following sections detail the most common failure modes and provide step-by-step solutions.

### Insufficient disk space and chunk store growth

#### Symptoms

- Deduplicated volume is critically low on free space despite file deletions.
- Chunkstore folder (System Volume Information) is excessively large.
- Storage operations (backups, file copies) fail.

#### Resolution

1. Manually run maintenance jobs:

    ```powershell
    Start-DedupJob -Volume <DriveLetter> -Type GarbageCollection -Full
    Start-DedupJob -Volume <DriveLetter> -Type Scrubbing -Full
    ```

2. Remove Orphaned Shadow Copies/Checkpoints:

    ```console
    vssadmin list shadows
    devnodeclean
    ```

3. Consider Expanding the Volume if still low on space.
4. If ReFS/Cluster Size Limitations:
    - Back up, reformat with 64K cluster, and restore data.
5. Investigate file patterns: Use TreeSize or a similar value to find space hogs not visible in user data.
6. If maintenance jobs fail, see section F for file system corruption repair.

### Deduplication job failures and stuck jobs

#### Symptoms

- Deduplication job (Optimization, Garbage Collection, Scrubbing) starts but stays at 0% or aborts.
- Jobs fail with errors such as:
    - “Not enough memory resources are available to complete this operation.”
    - “The operation was cancelled.”
    - Event IDs: 4105, 4106, 4140, 4142, 4185, and so on.

#### Resolution

1. Review job status:

    ```powershell
    Get-DedupJob
    ```

2. Increase available resources:
    - Free up RAM or CPU by stopping unnecessary processes.
    - Increase physical or virtual memory, if possible.
    - Adjust job memory threshold:

        ```powershell
        Set-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\ddpsvc\Settings -Name WlmMemoryOverPercentThreshold -Value 100
        ```

3. Reschedule jobs for offpeak hours to avoid contention.
4. Reduce memory parameter for jobs:

    ```powershell
    Start-DedupJob -Volume <DriveLetter> -Type Optimization -Memory 25
    ```

5. Restart the server if jobs are persistently stuck.
6. Check for scheduling conflicts:
    - Use Get-DedupSchedule and adjust as needed.

### File system corruption and deduplication metadata errors

#### Symptoms

- Event logs show corrupt user data containers, failed chunk store references, or errors such as:
    - "User data container is corrupt in the chunk store" (Event ID: 12837)
    - "Redirection table is too small" (for example, 0x8056530c)
- Maintenance jobs fail repeatedly.
- Deletions don’t reclaim space.

#### Resolution

1. Check and repair the file system:

    ```console
    chkdsk <DriveLetter>: /f /scan
    ```

2. If issues persist:
    - Back up the data by using Windows Server Backup.
    - Create a new volume, restore the backup, and enable deduplication.
3. As a last resort:
    - Migrate the data to new storage by using supported tools (not Robocopy) for deduplicated data.

### File access or migration problems

#### Symptoms

- Files cannot be opened or moved after a Windows upgrade or migration.
- “ERROR_CANT_ACCESS_FILE" (0x80070780) when accessing files after an upgrade.
- Manual file copies made to new servers expand the data (“rehydration”) and exhaust the destination storage.

#### Resolution

1. Reinstall the deduplication feature after an OS upgrade:

    ```powershell
    Install-WindowsFeature -Name FS-Data-Deduplication
    Enable-DedupVolume -Volume <DriveLetter>
    ```

2. Use a supported backup and restore process or direct disk moves for migration:
    - Avoid Robocopy for deduplicated data.
    - Use Windows Backup, attach disks directly to new server, or image entire volumes.
3. If data must Be moved and deduplication must be preserved:
    - Copy in small batches by using File Explorer to allow deduplication jobs to process incrementally.

### Misreporting or incomplete deduplication status

#### Symptoms

- Deduplication status not shown in Server Manager/Admin Center but available in PowerShell.
- No errors—but functional confusion for administrators.

#### Resolution

1. Use PowerShell for an accurate status:

    ```powershell
    Get-DedupVolume
    ```

2. Check S2D and clustered environments:

    - Verify the volume group ownership and status.
    - If you experience a known code defect, escalate to Microsoft Support. Provide a BI document if the business impact is high.

### Low deduplication rate or unexpected space usage

#### Symptoms

- Deduplication rate much lower than anticipated (less than 30 percent).
- Disk usage remains high despite deduplication.

#### Resolution

1. Analyze the data profile:
    - Identify the prevalence of already compressed or encrypted files (.jpg, .zip, .mp4).
    - Deduplication is less effective on such data types.
2. Review deduplication logs for skipped files.
3. Run manual optimization job and monitor space savings.
4. Adjust deduplication configuration for file types and patterns.

### Interaction with third-party software and features

#### Symptoms

- Missing files or file corruption on deduplicated volumes.
- Deduplication repeatedly disables itself.
- Errors connected to endpoint security (e.g., CrowdStrike) or storage vendor deduplication.

#### Resolution

1. Check active file filters:

    ```console
    fltmc
    ```

2. Exclude Deduplication Folders from Security/Antivirus Scans.
3. Consult Vendor Documentation Before Double Deduplication (SAN + Windows).
4. Restore From Backups if Data Corruption Has Occurred.

## Common issues quick reference table

| Symptom | Root cause | Resolution | Key commands and scripts |
| --- | --- | --- | --- |
| Dedup job stuck/fails, Event IDs 4105, 4140, 4142, etc. | Resource limits; job config | Free up memory, adjust job params, reboot, run jobs off-peak | Start-DedupJob, Set-ItemProperty |
| Files inaccessible (0x80070780) after migration/upgrade | Missing/inactive dedup feature | Reinstall dedup role, enable on volume | Install-WindowsFeature, Enable-DedupVolume |
| No space reclaimed after delete | Chunkstore overgrowth, no GC | Manually run GarbageCollection and Scrubbing jobs, expand volume | Start-DedupJob -Type GarbageCollection -Full |
| Excessive chunkstore/spikes in disk usage | High unique data, old data | Run GC, review file patterns, expand disk, consider archiving/migration | Get-DedupMetadata |
| Dedup status not shown in GUI | S2D/Cluster code defect | Use PowerShell for status, escalate with BI if needed | Get-DedupVolume |
| Low deduplication rate | Incompressible/encrypted data | Review data profile, reset expectations, check config | Get-DedupStatus |
| Space not reclaimed; chkdsk finds errors | File system corruption | Repair file system, migrate data, rebuild storage | chkdsk, robocopy, Backup/Restore |
| Unusual backup/snapshot growth | Block-level dedup changes | Reconsider dedup usage on backup targets, adjust backup schedules | — |
| Robocopy rehydrates data during migration | Not dedup-aware | Use Windows Backup or disk moves, enable dedup after copy; avoid Robocopy | Windows Backup, robocopy (w/ warnings) |

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue.

- Deduplication job and status:

    ```powershell
    Get-DedupJob
    Get-DedupStatus | fl \*
    Get-DedupVolume | fl \*
    Get-DedupMetadata <DriveLetter>
    ```
- Job and system event logs:

    ```powershell
    get-winevent -LogName 'Microsoft-Windows-Deduplication/Operational' -MaxEvents 10000 | export-csv dedup_operational.csv
    get-winevent -LogName 'Microsoft-Windows-Deduplication/Diagnostic' -MaxEvents 10000 | export-csv dedup_diag.csv
    get-winevent -LogName 'Microsoft-Windows-Deduplication/Scrubbing' -MaxEvents 10000 | export-csv dedup_scrubbing.csv
    ```
- CHKDSK output:

    ```console
    chkdsk <DriveLetter>: /f /scan
    ```
- Memory and CPU usage:

    ```console
    Get-Process | Sort-Object -Descending WorkingSet | Select-Object -First 20
    ```
- Directory and allocation reports:

    ```console
    dir <volume> /s /a > output.txt
    fsutil volume allocationReport <drive>: output.txt
    ```
- Shadow copy status and devices:

    ```console
    vssadmin list shadows
    devnodeclean /?
    ```
Collect these outputs before and after troubleshooting steps for comparison. Send logs securely to Microsoft, if it's necessary.

## References

- [Microsoft official data deduplication documentation](/windows-server/storage/data-deduplication/overview)
- [Backup and restore with deduplication](/previous-versions/windows/desktop/dedup/backup-and-restore-of-data-deduplication-enabled-volumes)
- [BitLocker and deduplication](/windows-server/storage/storage-spaces/volume-encryption-deduplication)
- [Cluster S2D and deduplication best practices](/windows-server/storage/storage-spaces/overview)
