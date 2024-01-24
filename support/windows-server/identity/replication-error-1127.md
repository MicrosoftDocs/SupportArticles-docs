---
title: Active Directory Replication Error 1127
description: Describes an issue where AD operations fail with Win32 error 1127 (While accessing the hard disk, a disk operation failed even after retries).
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
ms.subservice: active-directory
---
# Active Directory Replication Error 1127: While accessing the hard disk, a disk operation failed even after retries

This article describes an issue where Active Directory Replications fail with Win32 error 1127: "While accessing the hard disk, a disk operation failed even after retries."

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2025726

## Symptoms

This article describes symptoms, cause, and resolution steps for cases where AD operations fail with Win32 error 1127: "While accessing the hard disk, a disk operation failed even after retries."

1. The DCPROMO promotion of a new domain controller fails with error 1127: While accessing the hard disk, a disk operation failed even after retries

    The on-screen error displayed in DCPROMO is:

    > Dialog title text: Active Directory Installation Wizard  
    > Message text:  
    >
    > The operation failed because:  
    Active Directory could not replicate the directory partition \<DN path of failing partition> from the remote domain controller \<fully qualified computer name of helper DC>.  
    "While accessing the hard disk, a disk operation failed even after retries." DCPROMO.LOG contains the following text:  
    [INFO] Replicating the \<partition name> directory partition  
    [INFO] Error - Active Directory could not replicate the directory partition \<partition DN> from the remote domain controller \<helper DC>. (1127)  
    [INFO] NtdsInstall for \<DNS domain> returned 1127  
    [INFO] DsRolepInstallDs returned 1127 [ERROR] Failed to install to Directory Service (1127)  

2. DCDIAG reports that the Active Directory Replications test has failed with error status (1127): While accessing the hard disk, a disk operation failed even after retries

    Sample error text from DCDIAG is shown below:

     > Testing server: \<site>\<DC name>  
         Starting test: Replications  
             * Replications Check  
             [Replications Check,\<DC name>] A recent replication attempt failed:  
                From \<source DC> to \<destination DC>  
                Naming Context: DC=\<DN path>  
                The replication generated an error (1127):  
                While accessing the hard disk, a disk operation failed even after retries.  
                The failure occurred at \<date> \<time>.  
                The last success occurred at (never)| \<date>.  

3. REPADMIN.EXE reports that the last replication attempt has failed with status 1127

    REPADMIN commands that commonly cite the 1127 status include but aren't limited to:

    - REPADMIN /REPLSUM
    - REPADMIN /SHOWREPL
    - REPADMIN /SHOWREPS
    - REPADMIN /SYNCALL

4. The "replicate now" command in Active Directory Sites and Services (DSSITE.MSC) fails with the on-screen error "While accessing the hard disk, a disk operation failed even after retries"  

    > Dialog title: Replicate Now  
    Message text: The following error occurred during the attempt to synchronize naming context \<DNS name of directory partition> from domain controller \<source DC>  
    to domain controller \<destination DC>:  
    While accessing the hard disk, a disk operation failed even after retries.  
    This operation will not continue.  

5. Events in the Directory Services event log cite the error status 1127

    Events that commonly cite the 1127 status include but aren't limited to:

    |Event Source and Event ID|Message String |
    |---|---|
    |NTDS KCC 1926|The attempt to establish a replication link to a read-only directory partition with the following parameters failed |
    |NTDS Replication 1084|Internal event: Active Directory could not update the following object with changes received from the following source domain controller. This is because an error occurred during the application of the changes to Active Directory on the domain controller.  |
    |NTDS Replication 1699| The local domain controller failed to retrieve the changes requested for the following directory partition. As a result, it was unable to send the change requests to the domain controller at the following network address.  |
    |NTDS Replication 2108| This event contains REPAIR PROCEDURES for the 1084 event that has previously been logged. This message indicates a specific issue with the consistency of the Active Directory database on this replication destination. A database error occurred while applying replicated changes to the following object. The database had unexpected contents, preventing the change from being made.|

6. NTDS Replication event 2108 may be logged in the Directory Services Event log citing the object, source DC, and jet error that is triggering the logging of the 1127 status in on-screen errors, logged events, and diagnostic tool output.

    Jet errors known to appear in NTDS Replication event 2108 with status 1127 include but aren't limited to:

    | **Jet Error (decimal)**| **Symbolic Error**| **Error string** |
    |---|---|---|
    |-510|JET_errLogWriteFail|Failure writing to log file|
    |-1018|JET_errReadVerifyFailure|Checksum error on a database page|
    |-1019|JET_errPageNotInitialized|Blank database page|
    |-1021|JET_errDiskReadVerificationFailure|The OS returned ERROR_CRC from file IO |
    |-1022|JET_errDiskIO|Disk IO error|
    |-1605|JET_errKeyDuplicate|Illegal duplicate key|

7. NTDS ISAM events may be logged in the Directory Services event log indicating the existence of jet errors related to the 1127 status appearing in other on-screen errors, logged events and diagnostic tool output

    |Event source + event ID|Event text |
    |---|---|
    |NTDS ISAM 474|The database page read from the file \<drive:\path\ntds.dit> at  offset \<decimal offset> (\<hex offset>) for \<decimal page size> (\<hex page size>) bytes failed verification to a page checksum mismatch.... The read operation will fail with error \<decimal jet error> (\<hex jet error>). ).  If this condition persists then please restore the database from a previous backup.  This problem is likely due to faulty hardware. Please contact your hardware vendor for further assistance diagnosing the problem. |
    |NTDS ISAM 475|The database page read from the file \<drive:\path\ntds.dit> at  offset \<decimal offset> (\<hex offset>) for \<decimal page size> (\<hex page size>) bytes failed verification to a page number mismatch.... The read operation will fail with error \<decimal jet error> (\<hex jet error>). ). If this condition persists then please restore the database from a previous backup.  This problem is likely due to faulty hardware. Please contact your hardware vendor for further assistance diagnosing the problem. |

## Cause

Active Directory is unable to write to the Active Directory database or log files. Root causes include:

1. Software on the local machine is interfering with Active Directory's ability to write changes to the Active Directory database and/ or log files
2. A defect exists in the disk subsystem including the motherboard/ driver controller, firmware, driver, physical drives.

## Resolution

1. **Locate NTDS replication event 1084 events in the Directory Services Event Log**  

    For DCs logging the 1127 status, open the Directory Service Event log and focus on NTDS Replication event 1084.

    NTDS Replication Event 1084 indicates that Active Directory could not write updates to an object in its local copy of Active Directory.

    Metadata in the Event 1084 identifies (1.) the DN path (and thus the objects host partition) that could not be updated, (2.) the objectGUID for the object in question and (3.) the fully qualified CNAME record of the source DC that is sending the update

2. **Locate the NTDS Replication Event 2108 logged immediately following each NTDS Replication 1084 event and identify the jet error logged in the 2108 event.**  

    NTDS Replication event 2108 is the "User Action" for the NTDS Replication 1084 event.

    For every NTDS replication 1084 event logged, there should be a corresponding NTDS replication 2108 event logged in the Directory Services event log that cites (1.) the same object DN path and (2.) objectguid and (3.) source DC logged in the preceding NTDS Replication 1084 event AND  a jet error that defines / scopes the cause and your recovery plan to resolve the error condition.

3. **Execute the action plan for the Jet error logged in your NTDS Replication Event 2108:**  

    If the Jet error logged in your NTDS replication events is listed in the table below, execute the user action, otherwise, skip to step #4:  

    | **Jet Error (decimal)**| **Symbolic Error + Error String**| **User Action** |
    |---|---|---|
    | -510| JET_errLogWriteFail /<br/>Failure writing to log file| A log write failure occurred on the destination DC.<br/><br/>Check disk, partition, and file system health on the destination DC.<br/><br/>Check for software that may be creating locks on Active Directory log files such as antivirus software on the destination DC.<br/><br/>See if problem persists following reboot or try clean boot<br/><br/>Method 1: Stop services that create locks on files in the file system and focusing specifically on antivirus software.<br/><br/>Method 2: Press F8 during OS boot and chose "Safe Mode with Networking". <br/><br/>Method 3: Disable non-boot related third party services. Reboot.<br/><br/> Windows key + R -> MSCONFIG -> Services tab - > Hide all Microsoft <br/>   Services -> Disable checkbox for 3rd-party services<br/><br/>  Windows key + R -> MSCONFIG -> Startup tab - > Hide all Microsoft<br/>  Services -> click "Disable all" |
    | -1018| JET_errReadVerifyFailure /<br/>Checksum error on a database page| DB is corrupt<br/><br/>Error caused by a hardware failure.<br/><br/>Evaluate the disk stack including motherboard / controller, firmware, connecting cables and physical drives and contact the relevant vendors for known issues. Compare current configuration against vendors reference configuration.<br/><br/>Evaluate whether problem can be resolved by latest firmware updates or was triggered by recent firmware update.<br/><br/>If some DCs are logging -1018s while other DCs in same environment are not, look for differences in hardware configuration.<br/><br/>Databases logging this error can't be recovered or repaired by integrity checks or semantic database analysis in NTDSUTIL or ESENTUTL.<br/><br/>Offline defragsmayresolve the problem in the unlikely case that problem is caused by an index consistency problem.<br/><br/>Try an offline defrag, otherwise, restore a system state backup that pre-dates the corruption, OR force demote, perform a full metadata cleanup, and re-promote. If the -1018 error appears, repeat until hardware root cause is resolved.<br/><br/>One customer reported jet error -1018s on virtualized DCs running on the same virtual host only on computers using an on-board raid controller. Current thinking is that the UPS lacked sufficient power for on-board raid controllers to commit changes to disk following loss of electrical power. Workaround was to configure UPS software to shut down virtualized guests on loss of electrical power. Servers with dedicated (not on-board) raid controllers with their own battery backups didn't experience the -1018 jet error. |
    | -1019| JET_errPageNotInitialized /<br/>Blank database page| Similar to -1018 error but caused by a lost page flush.<br/><br/>A lost flush can represent a critical USN change. Failure to apply same to local DC or transitive replication partners could be harmful where a single replication path exists.<br/><br/>Deploy OS on server class hardware and disk subsystem components<br/><br/>Install UPS on host computer.<br/><br/>Install disk controller with on-board battery backup.<br/><br/>Disable write-back cache on drive controller.<br/><br/>Avoid placing NTDS.DIT and LOG files on IDE drives<br/><br/>Databases logging this error can't be recovered or repaired by integrity checks or semantic database analysis in NTDSUTIL or ESENTUTL.<br/><br/>Offline defrags may resolve the problem in the unlikely case that problem is caused by index consistency problem.<br/><br/>Try an offline defrag, otherwise, restore a system state backup that pre-dates the corruption, OR force demote, perform a full metadata cleanup, and re-promote. Repeat until hardware root cause is resolved. |
    | -1021| JET_errDiskReadVerificationFailure / The OS returned ERROR_CRC from file IO| Jet error -1021 is new to Windows Server 2008 R2.<br/><br/>Pre-Windows Server 2008 R2 operating systems return -1022 for this case.<br/><br/>-1021 identifies that a -1018 error occurred at the disk level. Restated, -1021 indicates that a disk drive returned a bad check sum error and is the specific source of the problem in the disk stack.<br/><br/>Problem may be caused by bad blocks on the hard drive that the hard drive may keep track of.<br/><br/>Demoting and re-promoting the domain controller may trigger the storage of data on healthy blocks. |
    | -1022| JET_errDiskIO / Disk IO error| Generic disk error<br/><br/>Disk IO errors mean that the OS encountered a non-specific error accessing the disk. This error may be logged when controllers return generic errors like "device not working". Some disks and versions of jet return this error for CRC problems.<br/><br/>Verify whole driver stack. |
    | -1605| JET_errKeyDuplicate / Illegal duplicate key| Sporadic error.<br/>Demote and repromote.<br/>May be caused by index corruption. <br/> Run NTDUSITL semantic database analysis. If still unresolved, perform an offline defrag.  |

4. **If the Jet error in the NTDS replication event is NOT in table above, validate the vertical Jet database stack**  

    If the 2108 event logs a jet error NOT cited in the table, use the [Microsoft Exchange Server Error Code Look-up](https://www.microsoft.com/download/details.aspx?id=100432) utility to resolve the jet error to its symbolic and friendly error string using the syntax "err \<jet error>". It is critical that you add the leading "-" prefix character when resolving jet errors using ERR.EXE. (for example, "c:\\>err -1018").

    The event message text in NTDS Replication event 2108 contains a partial user action for the NTDS Replication 1084 event.

    The NTDS Replication 2108 user action is documented in the linked KB article MSKB [837932](https://support.microsoft.com/help/837932). If the user action for your event isn't cited in the table above, execute a modified version of the action plan in MSKB [837932](https://support.microsoft.com/help/837932)  by validating the vertical jet database stack from the bottom up (proceeding up to the next layer only when the underlying layer checks out "good"), just like you do with TCP.

    | **Layer**| **NTDSUTIL command**| **ESENTTUL command** |
    |---|---|---|
    | **(1.) Physical consistency**| no equivalent| ESENTUTL /K |
    | **(2.) ESE Logical consistency**| NTDSUTIL FILES INTEGRITY| ESENTUTL /G |
    | **(3.) Application logical consistency**| NTDSUTIL ->Semantic database analysis<br/><br/>+<br/><br/>NTDSUTIL -> Offline Defrag| no equivalent for SDA<br/><br/><br/>+<br/><br/>ESENTUTL / D |

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
