---
title: Active Directory Replication Error 8451
description: provides a resolution for Active Directory Replication Error 8451 "The replication operation encountered a database error".
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, toddmax
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Active Directory Replication Error 8451: "The replication operation encountered a database error"

This article provides a resolution for Active Directory Replication Error 8451: "The replication operation encountered a database error".  

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2645996

>[!NOTE]
>**Home users**: This article is intended only for technical support agents and IT professionals. If you're looking for help to resolve a problem, please [ask the Microsoft Community](https://answers.microsoft.com/en-us).

## Symptoms

This article describes the symptoms and causes of situations in which Active Directory Domain Services (AD DS) operations fail and generate error 8451: "The replication operation encountered a database error." This article also provides a resolution for this problem.  
You might experience one of more of the following symptoms:  

- You see one or more on-screen error messages, logged events, or diagnostic output that identifies a database error. Possible formats for that error include the following.

    |Decimal code|Hexadecimal code|Text code|Error message|
    |---|---|---|---|
    |8451|0x2103|ERROR_DS_DRA_DB_ERROR|The replication operation encountered a database error.|
    |-1018|0xfffffc06|JET_errReadVerifyFailure|Checksum error on a database page.|
    |-1047|0xfffffbe9|JET_errInvalidBufferSize|Data buffer doesn't match column size.|
    |-1075|0xfffffbc|JET_errOutOfLongValueID|Long-value ID counter has reached maximum value (do an offline defragmentation to reclaim free and unused LongValueIDs).|
    |-1206|0xfffffb4a|JET_errDatabaseCorrupted|Non database file or corrupted db.|
    |-1414|0xfffffa7a|JET_errSecondaryIndexCorrupted|Secondary index is corrupt. The database must be defragmented.|
    |-1526|0xfffffa0a|JET_errLVCorrupted|Corruption encountered in long-value tree.|
    |-1601|0xfffff9bf|JET_errRecordNotFound|The key was not found.|
    |-1603|0xfffff9b|JET_errNoCurrentRecord|Currency not on a record.|

- Dcpromo.exe fails and generates error 8451.  
    The user interface displays the following message:  
    >The operation failed because:
    >
    >Active Directory Domain Services could not replicate the directory partition
    \<DN path of failing partition> from the remote Active Directory Domain Controller
    \<helper DC>.\<dns domain name>.\<top level domain>.
    >
    >The replication operation encountered a database error.  

    The Dcpromo.log file contains the following information:  
    >\<date> \<time> [INFO] NstdInstall for contoso.com returned 8451  
    \<date> \<time> [INFO] DsRolepInstallDs returned 8451  
    \<date> \<time> [ERROR] Failed to install to Directory Service (8451)  
    \<date> \<time> [INFO] Starting service NETLOGON
- Repadmin.exe reports that the replication attempt has failed with status 8451. Repadmin.exe commands that commonly cite the 8451 status include but are not limited to:  

  - `Repadmin /kcc`
  - `Repadmin /rehost`
  - `Repadmin /replicate`
  - `Repadmin /replsum`
  - `Repadmin /showrepl`
  - `Repadmin /showreps`
  - `Repadmin /showutdvec`
  - `Repadmin /syncall`

    For detailed information about how to use Repadmin to troubleshoot replication problems, see [Monitoring and Troubleshooting Active Directory Replication Using Repadmin](https://go.microsoft.com/fwlink/?LinkId=122830).

    The following sample shows output from the `repadmin /showreps` command that indicates that inbound replication from CONTOSO-DC2 to CONTOSO-DC1 failed and generated the "replication access was denied" message.  
    >Default-First-Site-Name\CONTOSO-DC1  
    DSA Options: IS_GC  
    Site Options: (none)  
    DSA object GUID: b6dc8589-7e00-4a5d-b688-045aef63ec01  
    DSA invocationID: b6dc8589-7e00-4a5d-b688-045aef63ec01  
    ==== INBOUND NEIGHBORS ======================================  
    DC=contoso,DC=com  
    Default-First-Site-Name\CONTOSO-DC2 via RPC  
    DSA object GUID: 74fbe06c-932c-46b5-831b-af9e31f496b2  
    Last attempt @ \<date> \<time> failed, result 8451 (0x2103):  
    The replication operation encountered a database error.  
    consecutive failure(s).  
    Last success @ \<date> \<time>.  

- Event Viewer lists one or more events that cite the 8451 error. The following table lists the event sources and Event IDs of common events that cite the 8451 error (in event source + event ID order).

    |Event source|Event ID|Event message|
    |---|---|---|
    |Microsoft-Windows-ActiveDirectory_DomainService|1039 with extended error 8451|Internal event: Active Directory Domain Services could not process the following object.|
    |Microsoft-Windows-ActiveDirectory_DomainService|1084 with extended error 8451|Internal event: Active Directory could not update the following object with changes received from the following source domain controller. It is because an error occurred during the application of the changes to Active Directory on the domain controller.|
    |Microsoft-Windows-ActiveDirectory_DomainService|1308 with extended error 8451|The Knowledge Consistency Checker (KCC) has detected that successive attempt to replicate with the following directory service failed.|
    |Microsoft-Windows-ActiveDirectory_DomainService|1699 with extended error 8451|The local domain controller failed to retrieve the changes requested for the following directory partition. As a result, it was unable to send the change requests to the domain controller at the following network address.|
    |NTDS Replication|2108 with extended error 8451 with secondary error value-1075|This event contains REPAIR PROCEDURES for the 1084 event that has previously been logged. This message indicates a specific issue with the consistency of the Active Directory database on this replication destination. A database error occurred while applying replicated changes to the following object. The database had unexpected contents, preventing the change from being made. Object:  CN=`justintu@contoso.com`,OU=marketing,OU=5thWard,OU=Houston,DC=Contoso,DC=com Object GUID:  2843919c-345c-4f57-bc1a-4ed5acbcf9e2 Source domain controller:  173ee10f-4c28-4acd-a2d7-61af8d4d3010._msdcs.Contoso.com User Action If none of these actions succeed and the replication error continues, you should demote this domain controller and promote it again. Additional Data Primary Error value:  8451 The replication operation encountered a database error. Secondary Error value: -1075|
    |NTDS Replication|2108 with extended error 8451 with secondary error value-1526|This event contains REPAIR PROCEDURES for the 1084 event that has previously been logged. This message indicates a specific issue with the consistency of the Active Directory database on this replication destination. A database error occurred while applying replicated changes to the following object. The database had unexpected contents, preventing the change from being made. Object:  CN=`justintu@contoso.com`,OU=marketing,OU=5thWard,OU=Houston,DC=Contoso,DC=com Object GUID:  2843919c-345c-4f57-bc1a-4ed5acbcf9e2 Source domain controller:  173ee10f-4c28-4acd-a2d7-61af8d4d3010._msdcs.Contoso.com User Action If none of these actions succeed and the replication error continues, you should demote this domain controller and promote it again. Additional Data Primary Error value:  8451 The replication operation encountered a database error. Secondary Error value: -1526|
    |NTDS Replication|2108 with extended error 8451 with secondary error value  -1414|This event contains REPAIR PROCEDURES for the 1084 event that has previously been logged. This message indicates a specific issue with the consistency of the Active Directory database on this replication destination. A database error occurred while applying replicated changes to the following object. The database had unexpected contents, preventing the change from being made. Object:  CN=`justintu@contoso.com`,OU=marketing,OU=5thWard,OU=Houston,DC=Contoso,DC=com Object GUID:  2843919c-345c-4f57-bc1a-4ed5acbcf9e2 Source domain controller:  173ee10f-4c28-4acd-a2d7-61af8d4d3010._msdcs.Contoso.com User Action If none of these actions succeed and the replication error continues, you should demote this domain controller and promote it again. Additional Data Primary Error value:  8451 The replication operation encountered a database error. Secondary Error value: -1414|
    |NTDS General|1039 with extended error 8451.|Internal event: Active Directory could not process the following object.|
    |NTDS KCC|1925 with extended error 8451|The attempt to establish a replication link for the following writable directory partition failed.|
    |NTDS Replication|1084 with extended error 8451|Internal event: Active Directory could not update the following object with changes received from the following source domain controller. It is because an error occurred during the application of the changes to Active Directory on the domain controller.|
    |NTDS Replication|1699 with extended error 8451|The local domain controller failed to retrieve the changes requested for the following directory partition. As a result, it was unable to send the change requests to the domain controller at the following network address.|

- When you increase the NTDS diagnosing logging level on the domain controller, Event Viewer lists additional events that are related to the 8451 error. The following table lists the event sources and Event IDs of events that frequently accompany other events that contain the 8451 error.

    |Event source|Event ID|Event message|
    |---|---|---|
    |Internal Processing|1481 with error-1601|Internal error: The operation on the object failed. Additional Data: Error value: 2 000020EF: NameErr: DSID-032500E8, problem 2001 (NO_OBJECT), data -1601, best match of: "|
    |Internal Processing|1173 with error-1075|Internal event: Active Directory has encountered the following exception and associated parameters. Exception: e0010004 Parameter: 0 Additional Data Error value: -1075 Internal ID: 205086d|
    |Internal Processing|1173 with error-1526|Internal event: Active Directory has encountered the following exception and associated parameters. Exception: e0010004 Parameter: 0 Additional Data Error value: -1526 Internal ID: 205036b|
    |Internal Processing|1173 with error-1603|Internal event: Active Directory has encountered the following exception and associated parameters. Exception: e0010004 Parameter: 0 Additional Data Error value: -1603 Internal ID: 2050344|
    |NTDS ISAM|474 with error-1018|The database page read from the file 'E:\NTDS\Data\ntds.dit' at offset 3846455296 (0x00000000e5444000) for 8192 (0x00002000) bytes failed verification due to a page checksum mismatch.  The expected checksum was 323677604 (0x134aeda4) and the actual checksum was 2081515684 (0x7c1168a4).  The read operation will fail with error -1018 (0xfffffc06).  If this condition persists, restore the database from a previous backup.  This problem is likely due to faulty hardware. Contact your hardware vendor for further assistance diagnosing the problem.|
    |NTDS ISAM|488|NTDS (396) NTDSA: Data inconsistency detected in table datatable of database C:\WINDOWS\NTDS\ntds.dit (4621,7905).|

- When you run the Dcdiag.exe utility, it produces output that resembles as:  

    >Starting test: Replications
    >
    >\* Replications Check  
    [Replications Check,\<DC Name>] A recent replication attempt
    failed:  
    From \<source DC> to \<destination DC>  
    Naming Context: \<DN path of failing naming context>  
    The replication generated an error (8451):  
    The replication operation encountered a database error  

- In Active Directory Sites and Services, when you right-click the connection object of a source DC and select **Replicate now**, the command fails and generates a message that resembles as:  

    >The following error occurred during the attempt to synchronize naming context <%directory partition name%> from Domain Controller \<Source DC> to Domain Controller \<Destination DC>:  
    "The replication operation encountered a database error."  
    The operation will not continue.

### How to decode error codes

You can use Microsoft Exchange Server Error Code Lookup to decode the error codes that are described in this article. Decoding the error codes that relate to the 8451 error and accompanying errors produces the following information:  
>C:\>err 8451  
for decimal 8451 / hex 0x2103 :  
ERROR_DS_DRA_DB_ERROR  &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; winerror.h  
The replication operation encountered a database error.  
2 matches found for "8451"  
>
>C:\>err -1414  
for decimal -1414 / hex 0xfffffa7a :  
JET_errSecondaryIndexCorrupted &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;esent98.h  
/*Secondary index is corrupt. The database must be
defragmented*/  
1 matches found for "-1414"  
>
>C:\>err -1526  
for decimal -1526 / hex 0xfffffa0a :  
JET_errLVCorrupted &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;esent98.h  
/_Corruption encountered in long-value tree_/  
1 matches found for "-1526"  
>
>C:\>err  -1603  
for decimal -1603 / hex 0xfffff9bd :  
JET_errNoCurrentRecord &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;esent98.h  
/_Currency not on a record_/  
1 matches found for "-1603"  
>
>C:\>err -1075  
for decimal -1075 / hex 0xfffffbcd :  
JET_errOutOfLongValueIDs &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;esent98.h  
/*Long-value ID counter has reached maximum value.
(perform offline defrag to reclaim free/unused  
LongValueIDs)*/  
1 matches found for "-1075"  
>
>C:\>err -1601  
for decimal -1601 / hex 0xfffff9bf :  
JET_errRecordNotFound &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;esent98.h  
/_The key was not found_/  
1 matches found for "-1601"  
>
>C:\>err -1047  
for decimal -1047 / hex 0xfffffbe9 :  
JET_errInvalidBufferSize &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;esent98.h  
/_Data buffer doesn't match column size_/  
1 matches found for "-1047"  
>
>C:\>err -1018  
for decimal -1018 / hex 0xfffffc06 :  
JET_errReadVerifyFailure &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;ese.h  
/_Checksum error on a database page_/  
JET_errReadVerifyFailure &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;esent98.h  
/\* Checksum error on a database page */  
2 matches found for "-1018"  
>
>C:\>err -1206  
for decimal -1206 / hex 0xfffffb4a :  
JET_errDatabaseCorrupted &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;esent98.h  
/_Non database file or corrupted db_/  
1 matches found for "-1206"

## Cause

The status 8451: "The replication operation encountered a database error" has multiple root causes, including the following ones:  

- The Active Directory database or Active Directory database index might be corrupted. It may be caused by the following reasons:
  - Failing hardware:
    - Disk
    - Controller
    - Controller cache
  - Outdated drivers:
    - Controller
  - Outdated firmware:
    - Computer BIOS
    - Controller
    - Disk
  - Sudden power loss.
  - Lingering objects.
  - The long-value ID counter has reached its maximum value:
    - The ESE column types `JET_coltypLongText`and `JET_coltypLongBinary` are called long value column types. These columns are large string and large binary objects that may be stored in separate B+ trees away from the primary index. When long values are stored separately from the primary record, they are internally keyed on a long value ID (LID).
  - Invalid security descriptor in the **msExchSecurityDescriptor** attribute.

## Resolution

> [!Important]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

### How to resolve a single occurrence of the problem

If the error occurs on only one domain controller and appears to be an isolated problem, the best and quickest resolution is to do offline defragmentation of the database on the affected server. For information about how to do it, see [How to perform offline defragmentation of the Active Directory database](https://support.microsoft.com/help/232122/how-to-perform-offline-defragmentation-of-the-active-directory-databas).  

If offline defragmentation does not correct the issue, demote and then repromote the affected domain controller. For information about how to do it, see [Demoting Domain Controllers and Domains](/windows-server/identity/ad-ds/deploy/demoting-domain-controllers-and-domains--level-200-).

### How to resolve a recurring problem

If the problem recurs, collect some diagnostic data.  

1. Enable NTDS diagnostic logging for Replication Events and Internal Processing at a level of 5.

    To increase NTDS diagnostic logging, change the following REG_DWORD values in the registry of the destination domain controller under the following registry subkey:  
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics`  

    Set the value of the following entries to **5**:  
   - Replication Events
   - Internal Processing  

    > [!Note]
    > Level-5 logging is extremely verbose. The values of both keys should be restored to the default of **0** after the problem is resolved. Filtering the Directory Services event log should be done to isolate and identify these events.  

    For more information about the standard terminology that is used to describe Microsoft software updates, see the following Knowledge Base article:

2. Review the event logs for the new events that were generated from the increased logging for error values that will give a definitive view of the original 8451 error. For example, an Internal Processing Event ID 1173 that has an error value of **-1526** would indicate that we have a corruption in long-value tree.
3. Based on the additional information from the increased logging, refer to the following table for a potential resolution.

    |Decimal code|Hex code|Text code|Error message|Potential resolutions|
    |---|---|---|---|---|
    |-1018|0xfffffc06|JET_errReadVerifyFailure|Checksum error on a database page|Check hardware, firmware, and drivers. Restore from backup.Demote/promote.|
    |-1047|0xfffffbe9|JET_errInvalidBufferSize|Data buffer doesn't match column size|832851 Inbound Replication Fails on Domain Controllers with Event ID: 1699, Error 8451 or jet error -1601  **Note:** This hotfix is no longer available.|
    |-1075|0xfffffbcd|JET_errOutOfLongValueIDs|Long-value ID counter has reached maximum value. (do offline defragmentation to reclaim free or unused```LongValueIDs```)|Do offline defragmentation.|
    |-1206|0xfffffb4a|JET_errDatabaseCorrupted|Non-database file or corrupted db|Check hardware, firmware, and drivers.Run the **[Esentutl](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh875546%28v=ws.11%29)/k** command. Run the [Ntdsutil](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc753343%28v=ws.11%29) file integrity and semantic database analysis  (SDA) commands, and then do offline defragmentation.Otherwise restore from backup or demote/promote.|
    |-1414|0xfffffa7a|JET_errSecondaryIndexCorrupted|Secondary index is corrupt. The database must be defragmented.|Do offline defragmentation.|
    |-1526|0xfffffa0a|JET_errLVCorrupted|Corruption encountered in long-value tree|Check hardware, firmware, and drivers.Run the `Esentutl /k` command. Run the Ntdsutil** file integrity and SDA commands, and then do offline defragmentation. Otherwise, restore from backup or demote  and promote.|
    |-1601|0xfffff9bf|JET_errRecordNotFound|The key was not found|Check hardware, firmware, and drivers.Run the `Esentutl /k` command. Run the **Ntdsutil** file integrity and SDA commands, and then do offline defragmentation​​​​​​​.​​​​​​​Otherwise restore from backup or demote and promote.|
    |-1603|0xfffff9bd|JET_errNoCurrentRecord|Currency not on a record|Check hardware, firmware, and drivers.Run the `Esentutl /`k command. Run the **Ntdsutil** file integrity and SDA commands, and then do offline defragmentation​​​​​​​.​​​​​​​Otherwise restore from backup or demote and promote.|
    |8451|0x2103|ERROR_DS_DRA_DB_ERROR|The replication operation encountered a database error|Check hardware, firmware, and drivers.Run the `Esentutl /k` command. Run the **Ntdsutil** file integrity and SDA commands, and then do offline defragmentation. Otherwise restore from backup or demote/promote.|

4. If all these methods fail, restore the domain controller from a backup, or demote it and then repromote.

## More information

Verify the vertical jet database stack from the bottom up (proceeding up to the next layer only after the underlying layer is graded as "good"), the same as you do for TCP.  

|Layer|Ntdsutil command|Esentutl command|
|---|---|---|
|(1) Physical consistency|no equivalent| `Esentutl /k` |
|(2) Extensible Storage Engine (ESE) logical consistency| **Ntdsutil**, **files**, **integrity**| **Esentutl /g** |
|(3) Application logical consistency| **Ntdsutil**, **semantic database analysis** + **Ntdsutil**, **compact**|no equivalent for SDA  + **Esentutl /d** |

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
