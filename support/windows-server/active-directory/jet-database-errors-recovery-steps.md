---
title: Jet database errors and recovery steps
description: Introduces Jet database error messages and troubleshooting steps.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jeffbo
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Troubleshoot Jet database errors and recovery steps

This article introduces Jet database error messages and troubleshooting steps.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4042791

## Summary

During operating system startup, domain controller installation/uninstallation, or Active Directory Replication, you may encounter Jet error messages. This article introduces Jet error messages and their solutions.

## Error messages  

### -501 JET_errLogFileCorrupt

#### Cause

Hardware corrupted the I/O at writing, or the hardware [lost flush](#what-is-a-lost-io--lost-flush) caused the log to become unusable. Typically the database (DB) is left in a corrupted state.

#### Resolution

Restore the database from a known good backup, or reinstall the domain controller (DC).
  
### -510 JET_errLogWriteFail / Failure writing to log file

#### Cause

A log write failure occurred. This issue can be caused by any of the following:

- A controller, hard drive, or other hardware stopped responding to disk commands.
- Software, such as antivirus software, created locks on Active Directory log files.

#### Resolution

1. A restart of the server will restore access if this is a hardware issue. If the problem happens frequently, you can upgrade firmware, replace the controller, or replace the disk, in that order.
2. For an issue that is due to software, stop services that create locks on the files in the file system. For example, determine whether antivirus software is causing locks on Active Directory log files. Make sure that the proper files have been added to the antivirus exclusion list. Windows Server 2016 automatically excludes certain files and folders from antivirus scanning, see [List of automatic exclusions](/windows/threat-protection/windows-defender-antivirus/configure-server-exclusions-windows-defender-antivirus#list-of-automatic-exclusions). For Windows Server 2012 R2, see:

    - [Virus scanning recommendations for Enterprise computers that are running currently supported versions of Windows](https://support.microsoft.com/help/822158/virus-scanning-recommendations-for-enterprise-computers)
    - [Event ID 2108 and Event ID 1084 occur during inbound replication of Active Directory in Windows 2000 Server and in Windows Server 2003](replication-event-id-2108-1084.md)
    - [Recommended file and folder exclusions for Microsoft Forefront Client Security, Forefront Endpoint Protection 2010, and Microsoft System Center 2012 Endpoint Protection](https://support.microsoft.com/help/943556/recommended-file-and-folder-exclusions-for-microsoft-forefront-client)

If steps 1 and 2 don't fix the issue, determine whether a non-Microsoft application or service is causing the issue by disabling these. To do this, follow these steps:

1. Press Windows key + R. Enter **MSCONFIG** and then click **OK**. On the **Services** tab, select **Hide all Microsoft Services**. Clear the check box for third-party services.
2. Disable all enabled startup items.
3. Restart the server.

### -528 JET_errMissingLogFile

#### Cause

This can be due to an unexpected shutdown that was caused by a power outage or another unexpected shutdown. Other causes include administrator changes to log files (such as copying an old copy) or corrupted backup/restore software (if immediately after a restore).

#### Resolution

Restore the database from a known-good backup, or reinstall the DC.
  
### -543 JET_errRequiredLogFilesMissing

See -528 / JET_errMissingLogFile (above).

#### Cause

Administrator modified logs or lost I/O flush on shutdown.
  
### -550 JET_errDatabaseDirtyShutdown

#### Cause

Administrator modified logs or lost I/O flush on shutdown.
  
### -551 JET_errConsistentTimeMismatch

#### Cause

Administrator modified logs or lost I/O flush on shutdown.
  
### -567 JET_errDbTimeTooNew

#### Cause

Disk subsystem lost an I/O, probably on a hang or unscheduled shutdown.

#### Resolution

Verify battery backup for disk cache.
  
### -1018 JET_errReadVerifyFailure / Checksum error on a database page

#### Cause

The DB is corrupted due to a hardware failure.

#### Resolution

- Evaluate the disk stack, including the motherboard/controller, firmware, connecting cables, and physical drives, and contact the relevant vendors for known issues. Compare your current configuration against the vendors' reference configurations.
- Evaluate whether the problem can be resolved by the latest firmware updates or was triggered by a recent firmware update.
- If some DCs are logging -1018s while other DCs in the same environment aren't, look for differences in hardware configurations.
- Databases that log this error can't be recovered or repaired by integrity checks or semantic database analysis in NTDSUTIL or ESENTUTL.
- Offline defrags may fix the problem in the unlikely case that the problem is due to an index consistency problem.
- Try an offline defrag. Or, restore a system state backup that predates the corruption. Or force-demote, perform a full metadata cleanup, and repromote. If the -1018 error appears, repeat until the hardware root cause is resolved.

When Jet error -1018s occurs on virtualized DCs that are running on the same virtual host only on computers that are using an on-board raid controller, the error can occur because the uninterruptible power supply (UPS) lacked sufficient power for on-board raid controllers to commit changes to disk following loss of electrical power. The workaround is to configure UPS software to shut down virtualized guests upon loss of electrical power. Servers that have dedicated (not on-board) raid controllers with their own battery backups don't experience the -1018 JET error.  

### -1019 JET_errPageNotInitialized / Blank database page

#### Cause

This is like the -1018 error but is due to a lost page flush.

A [lost flush](#what-is-a-lost-io--lost-flush) can represent a critical USN change. Failure to apply the same change to local DCs or to transitive replication partners could be harmful where a single replication path exists.

#### Resolution

Deploy the OS on server-class hardware and disk subsystem components.

- Install UPS on the host computer.
- Install a disk controller with on-board battery backup.
- Disable the write-back cache on the drive controller.
- Avoid placing NTDS.DIT and LOG files on IDE drives.

Databases that log this error can't be recovered or repaired by integrity checks or semantic database analysis in NTDSUTIL or ESENTUTL.

Offline defrags may resolve the problem in the unlikely case that the problem is due to an index consistency problem.

Try an offline defrag. Or, restore a system state backup that predates the corruption. Or, force demote, perform a full metadata cleanup, and then repromote. Repeat until the hardware root cause is resolved.
  
### -1021 JET_errDiskReadVerificationFailure / The OS returned ERROR_CRC from file IO

Jet error -1021 was new as of Windows Server 2008 R2. Windows versions that are earlier than Windows Server 2008 R2 return -1022 instead.

-1021 identifies a -1018 error that occurred at the disk level. In other words, -1021 indicates that a disk drive returned a bad check sum error and is the specific source of the problem in the disk stack.

#### Cause

The problem may be due to bad blocks on the hard disk that the hard drive may keep track of.

#### Resolution

Removing and reinstalling Active Directory on the domain controller may trigger the storage of data on healthy blocks.
  
### -1022 JET_errDiskIO / Disk IO error

#### Cause

Generic disk error. Disk IO errors mean that the OS encountered a non-specific error in accessing the disk. This error may be logged when controllers return generic errors like "device not working." Some disks and versions of Jet return this error for CRC problems.

#### Resolution

Verify the whole driver stack.
  
### -1206 JET_errDatabaseCorrupted

#### Cause

This error is the same as missing/corrupt log file. This error indicates that a [lost flush](#what-is-a-lost-io--lost-flush) occurred.
  
### -1216 JET_errAttachedDatabaseMismatch

#### Cause

Administrator modified logs or lost I/O flush on shutdown.
  
### -1605 JET_errKeyDuplicate / Illegal duplicate key

#### Cause

Sporadic error. This error can be due to index corruption.

#### Resolution

Remove and reinstall Active Directory on the DC. Run NTDUSITL semantic database analysis. If the issue persists, perform an offline defrag.  

### -1811

#### Cause

Administrator modified logs or lost I/O flush on shutdown.

## Troubleshoot

You can use these methods to troubleshoot Jet database errors:

1. Verify that all Active Directory databases and log files are deployed on suitable hardware.

    Many but not all SATA and IDE drives don't support the write flush command. SAS drives do support it.

    Active Directory databases and log files should use SAS drives on SAS controllers DCs that have a battery backup on any write caching element.
2. If 0xc00002e1 (c00002e1) and 0xc00002e2 (c00002e2) are virtual guest domain controllers that are running on Windows Server 2012 Hyper-V hosts, install corrective fixes from [Loss of consistency with IDE-attached virtual hard disks when a Hyper-V host server experiences an unplanned restart](https://support.microsoft.com/topic/loss-of-consistency-with-ide-attached-virtual-hard-disks-when-a-hyper-v-host-server-experiences-an-unplanned-restart-e0f0bc5b-bf04-2a75-4360-06ae11a13aa6) on hosts and guest DCs as required.
3. Check whether the event that preceded the LSASS 0xc00002e1 (c00002e1) and 0xc00002e2 (c00002e2) boot errors indicates one of the following issues:

    - Unscheduled power outage.
    - System hang.
    - Installation of Windows updates or service pack installs.
    - Addition or removal of disks, volumes, or partitions to the local system.
    - Hard drive failure.
    - NTDS.DIT or one or more log files were copied from another computer or even from a previous point in this DCs life.
    - Unknown

4. Start the computer into Directory Services Restore mode.
5. Best practice: Make a System State backup so that you can roll back any changes that are made during your recovery session.
6. Best practice: Ask the administrator up front to locate the most recent system state backup so that you can factor the existence or nonexistence of System State backups into your recovery plans. Have the admin delegate the location of any backups, if possible.
7. Run NTDSUTIL -> Files -> Info.

    > [!Note]
    > the path to the NTDS.DIT and log files.

8. Verify that the drive that hosts the NTDS.DIT or log files is available on OS startup.
9. Open Windows Explorer and verify that the NTDS.DIT and log files are present at the log file path reported by step 7.

    If the files are present, proceed to step 10.

    If the files are not present, search all available drives and volumes for the NTDS.DIT and log files that belong to this instance of Active Directory.

    > [!Warning]
    > There may be multiple NTDS.DIT and log files present on local drives. Use date and time stamps to locate the correct instance.

    Correct the paths for the database and log file paths as required.
10. Verify file permissions for the OS version in question.

    > [!Note]
    > The OS needs sufficient permissions on Windows Server 2003.

    |Account|Permissions|Inheritance|
    |---|---|---|
    | System| Full Control| This folder, subfolders and files |
    | Administrators| Full Control| This folder, subfolders and files |
    | Creator Owner| Full Control| Subfolders and Files only |
    | Local Service| Create Folders / Append Data| This folder and subfolders |

    - The root of the volume that is hosting the NTDS.DIT and NTDS log files (system requires fully control)
    - The %windir% folder (i.e., c:\\windows or c:\\winnnt) (system requires fully control)
    - The folder that hosts the NTDS.DIT and NTDS log files (see permissions table below)
    - The NTDS Log files themselves (see perms table below)

11. Verify that the correct log files reside in the log file directory:

    NTDSUTIL /FILES will identify the database directory and log file directory if different.
    NTDSUTIL /MH will identify which log files are required in the log file directory.

    Under no circumstances should the database or log files from one DC be copied to another DC to make the second DC functional.
12. Confirm that disk or file compression is not enabled on any volume that is hosting the NTDS.DIT or log file volume.
13. Validate the health of the database in NTDS.DIT from the bottom up.

    Validate Jet database health from the bottom up. Proceed up to the next layer only when the underlying layer completes without error.

    Troubleshooting any error reported by ESE logical or application logical consistency when physical consistency is still failing will lead you down an improper troubleshooting path.

    Equivalent NTDSUTIL and ESENTUTL commands for each later are shown below:

    |Layer|NTDSUTIL command|ESENTUTL equivalent command|
    |---|---|---|
    | 1. Physical consistency| no equivalent| `ESENTUTL /K` |
    | 2. ESE logical consistency| NTDSUTIL FILES INTEGRITY| `ESENTUTL /G` |
    | 3. Application logical consistency <br/>| NTDSUTIL ->Semantic database analysis<br/><br/>+<br/><br/>NTDSUTIL -> Offline Defrag| No equivalent. Run NTDSUTIL -> SDA<br/><br/>+<br/><br/>`ESENTUTL / D` |

14. Look up the user action for the first failing Jet error encountered during step 13. Perform remediation if possible.
15. Repair the Jet database:

    - Some Jet database errors can be repaired by using NTDSUTIL and ESENTUTL.
    - Some Jet database errors cannot be repaired, and any attempt to repair them will fail. In such cases, your only recourse may be to restore a system state backup that predates the corruption, or build a new server. If replica DCs are up-to-date, lead with promoting additional replicas into the domain after attempting to mitigate the root cause for any hardware or software-related errors.

    > [!Note]
    > The Jet error that is returned in NTDS General event 1168 is an application layer error. Don't act on this Jet error unless the Jet Physical consistency and Application logical consistency checks, (tested in that order) pass without error.

## More Information

For more information, see the following Microsoft article:

[Domain controller does not start, c00002e2 error occurs, or "Choose an option" is displayed](domain-controller-not-start-c00002e2-error.md)

### What is a lost IO / Lost Flush

When an application writes data to a disk, the disk indicates the written operation success. However, when the application tries to read the data that it just wrote, the data does not exist. This issue is called as lost I/O, or lost flush.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
