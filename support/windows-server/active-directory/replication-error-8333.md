---
title: AD Replication error 8333 Directory Object Not Found
description: Describes an issue where AD operations fail with error 8333 (Directory object not found (ERROR_DS_OBJ_NOT_FOUND)).
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Troubleshooting AD Replication error 8333: Directory Object Not Found

This article describes an issue where Active Directory Replications fail with error 8333: Directory object not found (ERROR_DS_OBJ_NOT_FOUND).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2703708

> [!NOTE]
**Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com/en-us).

## Symptoms

This article describes the symptoms, cause, and resolution steps when Active Directory replication fails with error 8333: Directory object not found (ERROR_DS_OBJ_NOT_FOUND).

1. Possible formats for the error include:

    | Decimal| Hex| Symbolic| Error string |
    |---|---|---|---|
    | 8333| 0x208d| ERROR_DS_OBJ_NOT_FOUND| Directory object not found. |

2. The following events could be logged  

    | Event Source| Event ID| Event String |
    |---|---|---|
    | NTDS Replication| 2108| This event contains REPAIR PROCEDURES for the 1084 event that has previously been logged. This message indicates a specific issue with the consistency of the Active Directory database on this replication destination. A database error occurred while applying replicated changes to the following object. The database had unexpected contents, preventing the change from being made. Object: OU=TestOU,DC=contoso,DC=com Object GUID: *\<GUID>* Source domain controller: A52b57e3-92b9-4264-822b-72963eaf1030._msdcs.contoso.com Additional Data Primary Error value: 8333 Directory object not found. Secondary Error value: -1601 JET_errRecordNotFound, The key was not found |
    | <br/>NTDS General| 2031| The DS Service Configuration object is not found. It might have been accidentally deleted. The Active Directory will be able to operate normally, but you will not be able to set certain service parameters, such as LDAP limits, default query policies, and SPN mappings. DS Service Configuration object: CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=contoso,DC=com Error: 8333 (Directory object not found.) User Action: Try to restore the DS Service Configuration object. |

3. There may be output from `repadmin /replsum`  

    > DC-1-03 03h:14m:11s 1 / 52 1 (8333) Directory object not found.  
     DC-2-01 03h:13m:39s 1 / 26 3 (8333) Directory object not found.  
     DC-3-09 03h:08m:45s 2 / 103 1 (8333) Directory object not found.  
     DC-4-03 03h:05m:52s 1 / 13 7 (8333) Directory object not found.  

4. DCPromo may fail while promoting a new domain controller and you'll see the following errors in the DCPROMO log  

     > *\<DateTime>* [INFO] Creating new domain users, groups, and computer objects  
     *\<DateTime>* [INFO] Error - Active Directory is missing critical information after installation and cannot continue. If this is a replica domain controller, rejoin this server to the domain. (8333)  
     *\<DateTime>* [INFO] NtdsInstall for `contoso.com` returned 8333  
     *\<DateTime>* [INFO] DsRolepInstallDs returned 8333  
     *\<DateTime>* [ERROR] Failed to install to Directory Service (8333)  

    > [!NOTE]
    > Error 8333 translates to ERROR_DS_OBJ_NOT_FOUND or "Directory object not found."

5. While trying to rehost a partition on the Global catalog

    `repadmin /rehost \<dc-name>\<partition to rehost>\<good source>`

    `repadmin /rehost failed with DsReplicaAdd failed with status 8333 (0x208d)`  

## Cause

The error status 8333 "Directory Object Not Found" has multiple root causes including:

1. Database corruption with additional associated errors logged in the event log of the source domain controller:  

    | **Source**| **Event ID**| **Description** |
    |---|---|---|
    |NTDS Replication| 2108|This event contains REPAIR PROCEDURES for the 1084 event that has previously been logged. This message indicates a specific issue with the consistency of the Active Directory Domain Services database on this replication destination. A database error occurred while applying replicated changes to the following object. The database had unexpected contents, preventing the change from being made.Object: CN=chduffey,OU=IT,OU=Corp,DC=contoso,DC=com<br/>Object GUID: *\<GUID>*<br/>Source domain controller: c4efaf4e-d652-4630-8623-afec5ebc8532._msdcs.contso.comAdditional Data<br/>Primary Error value: 8333 Directory Object Not Found.|
    |NTDS General| 1168| Error -1073741790(c0000022) has occurred (Internal ID 3000b3a). Please contact Microsoft Product Support Services for assistance.|
    | Microsoft-Windows-<br/>ActiveDirectory_DomainService| 1084|Internal event: Active Directory could not update the following object with changes received from the following source domain controller. This is because an error occurred during the application of the changes to Active Directory on the domain controller.|
    | NTDS Replication| 1699|The local domain controller failed to retrieve the changes requested for the following directory partition. As a result, it was unable to send the change requests to the domain controller at the following network address. 8446 The replication operation failed to allocate memory|

    Additionally you may see replication status code:

    | **Code**| **Sources**| **Additional Information** |
    |---|---|---|
    | 8451|Repadmin, DcPromo, as subcode in Database Corruption Events|Refer to the troubleshooting guide for 8451 in the first instance if this error is identified.<br/><br/> [2645996](https://support.microsoft.com/help/2645996) |

2. Lingering Objects with associated errors logged:  

    | Source|Event ID|Description|
    |---|---|---|
    |NTDS Replication|1988|Active Directory Replication encountered the existence of objects in the following partition that have been deleted from the local domain controllers (DCs) Active Directory database. Not all direct or transitive replication partners replicated in the deletion before the tombstone lifetime number of days passed. Objects that have been deleted and garbage collected from an Active Directory partition but still exist in the writable partitions of other DCs in the same domain, or read-only partitions of global catalog servers in other domains in the forest are known as "lingering objects".|
    |NTDS Replication|1388|Another domain controller (DC) has attempted to replicate into this DC an object that's not present in the local Active Directory database. The object may have been deleted and already garbage collected (a tombstone lifetime or more has past since the object was deleted) on this DC. The attribute set included in the update request isn't sufficient to create the object. The object will be re-requested with a full attribute set and re-created on this DC.|

    Additionally you may see the following replication status codes:

    |Source|Sources|Description|
    |---|---|---|
    |8606|Repadmin, DCPromo, sub code in NTDS Replication events|Refer to the troubleshooting guide for 8606 in the first instance if this error is identified. [2028495](https://support.microsoft.com/help/2028495) |
    |1722|Repadmin, DCPromo, sub code in NTDS Replication events|Refer to the troubleshooting guide for 1722 in the first instance if this error is identified. [2102154](https://support.microsoft.com/help/2102154) |

3. Conflict Objects  
4. Third-Party process

    1. Antivirus  
    2. Directory synchronization software  

## Resolution

Investigation of the 8333 "Directory Object Not Found" error message should begin on the source domain controller in the replication partnership. Referring to each of the possible causes of the issue from the "cause" section of this document, a support professional should begin their investigation on the source of the source/destination replication partnership.

1. **Check for indications of Active Directory (JET) Database corruption:**  

    1. Review the Directory Services event log on the source and destination replication partners for JET database corruption events. Possible events include:

        | **Source**| **Event ID**| **Description** |
        |---|---|---|
        |NTDS Replication| 2108|This event contains REPAIR PROCEDURES for the 1084 event that has previously been logged. This message indicates a specific issue with the consistency of the Active Directory Domain Services database on this replication destination. A database error occurred while applying replicated changes to the following object. The database had unexpected contents, preventing the change from being made.Object: CN=chduffey,OU=IT,OU=Corp,DC=contoso,DC=com<br/>Object GUID: *\<GUID>*<br/>Source domain controller: c4efaf4e-d652-4630-8623-afec5ebc8532._msdcs.contso.comAdditional Data<br/>Primary Error value: 8333 Directory Object Not Found.|
        |NTDS General| 1168| Error -1073741790(c0000022) has occurred (Internal ID 3000b3a). Please contact Microsoft Product Support Services for assistance.|
        | Microsoft-Windows-<br/>ActiveDirectory_DomainService| 1084|Internal event: Active Directory could not update the following object with changes received from the following source domain controller. This is because an error occurred during the application of the changes to Active Directory on the domain controller.|
        | NTDS Replication| 1699|The local domain controller failed to retrieve the changes requested for the following directory partition. As a result, it was unable to send the change requests to the domain controller at the following network address. 8446 The replication operation failed to allocate memory|

        Additionally you may see replication status code:

        | **Code**| **Sources**| **Additional Information** |
        |---|---|---|
        | 8451|Repadmin, DcPromo, as subcode in Database Corruption Events|Refer to the troubleshooting guide for 8451 in the first instance if this error is identified.<br/><br/> [2645996](https://support.microsoft.com/help/2645996) |

    2. Enable advanced directory services replication logging:  
       > [!Important]
       > This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
         [322756](https://support.microsoft.com/help/322756/how-to-back-up-and-restore-the-registry-in-windows) How to back up and restore the registry in Windows  

        To increase NTDS diagnostic logging, change the following REG_DWORD values in the registry of the destination domain controller under the following registry key:  
        `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics`  
        Set the value of the following subkeys to 5:  
        5 Replication Events  
        9 Internal Processing  
        Note Level 5 logging is extremely verbose and the values of both subkeys should be set back to the default of 0 after the problem is resolved. Filtering the Directory Services event log should be performed to isolate and identify these events.  

    3. Review the event logs for the new events that were generated from the increased logging for error values that will give a definitive view of the Database Corruption.

    4. If database corruption has been detected, ensure that recent backups exist of each domain in the forest.

    5. Restart the domain controller reporting the database corruption in directory services restore mode. (Press F8 while the server is restarting or if this isn't possible open msconfig.exe and choose "Active Directory Repair" in the "boot" options.).

    6. To perform an inspection of the database in Directory Services Restore Mode:

        1. Open a command prompt  
        2. Type "ntdsutil"  
        3. Type "activate instance ntds"  
        4. Type "Semantic database analysis"  
        5. Type "go"  

        If errors are detected they'll be displayed to the console and written to a log file in the current working directory.  

    7. If database corruption errors are detected, you're advised to contact Microsoft Support Services.

    8. As a last option. You can demote the domain controller, and promote it again to replace the database and replicate the contents from another server in the domain.

        > [!Note]
        > If an Active Directory database has been corrupted in your environment, it's important to consider the source of the corruption to avoid issues in the future. Some of the known causes of such corruption are:
        >
        > 1. Failing Hardware: Hard Disk or controller  
        > 2. Caching: Hard Disk controller  
        > 3. Out-dated Drivers: Hard Disk controller  
        > 4. Out-dated Firmware: BIOS, Hard Disk controller, Hard Disk  
        > 5. Sudden power Loss  

2. Check for the existence of and remove Lingering Objects on all domain controllers in the forest.  
There are multiple approaches to check for Lingering Objects including:

    1. Check for the existence of the following Directory Services events on domain controllers in the forest:

        | Source|Event ID|Description|
        |---|---|---|
        |NTDS Replication|1988|Active Directory Replication encountered the existence of objects in the following partition that have been deleted from the local domain controllers (DCs) Active Directory database. Not all direct or transitive replication partners replicated in the deletion before the tombstone lifetime number of days passed. Objects that have been deleted and garbage collected from an Active Directory partition but still exist in the writable partitions of other DCs in the same domain, or read-only partitions of global catalog servers in other domains in the forest are known as "lingering objects".|
        |NTDS Replication|1388|Another domain controller (DC) has attempted to replicate into this DC an object that's not present in the local Active Directory database. The object may have been deleted and already garbage collected (a tombstone lifetime or more has past since the object was deleted) on this DC. The attribute set included in the update request isn't sufficient to create the object. The object will be re-requested with a full attribute set and re-created on this DC.|

        Additionally you may see the following replication status codes:

        | **Code**| **Sources**| **Additional Information** |
        |---|---|---|
        | 8451|Repadmin, DcPromo, as subcode in Database Corruption Events|Refer to the troubleshooting guide for 8451 in the first instance if this error is identified.<br/><br/> [2645996](https://support.microsoft.com/help/2645996) |

    2. Use repldiag.exe to examine the forest for lingering objects.

        Repldiag may be downloaded from codeplex.com. To perform the lingering object check-in advisory mode, use the syntax:

        `repldiag /RemoveLingeringObjects/AdvisoryMode`

        Directory Service event 1942 will be logged on each domain controller and will indicate the number of lingering objects that were detected in each directory partition.

        The work being performed by repldiag may also be performed with the built-in directory services replication tool: Repadmin.exe.

        For support professionals preferring to use repadmin.exe, the partial command will be `Repadmin /removelingeringobjects`. Repldiag.exe provides an advantage over Repadmin.exe in that it can be used to search all directory partitions, on all servers in the forest with a single command.

        If Lingering objects are detected:

        1. Perform a system state backup of two domain controllers in each domain in the forest.  
        2. Use repldiag.exe to perform clean-up of lingering objects:  
        repldiag /RemoveLingeringObjects  
        3. Each domain controller will log a directory services event 1942 for each directory services partition to indicate if lingering objects have been removed.  

    For an alternate approach to the removal of lingering objects, you can use the built-in tool Repadmin.exe with the `/removelingeringobjects` switch. This approach requires multiple commands, repldiag provides an aggregate of the commands Repadmin.exe would use.

3. Check for the existence of and remove conflict objects:  
    a. Search the relevant directory partitions for CNF-managed objects and the object that the conflict-mangled object conflicted with the following syntax:

    `repadmin /showattr localhost "dc=parent,dc=com" /subtree /filter:"((&(objectClass=*)(cn=*\0acnf:*)))" /atts:objectclass,whencreated,whenchanged`

    In this example "dc=parent,dc=com" is the distinguished name for the `parent.com` domain.

    In most circumstances the 8333 error will indicate which directory partition(s) should be evaluated for conflict objects. It's recommended that the configuration partition is checked in all instances:

    `repadmin /showattr localhost "cn=configuration,dc=parent,dc=com" /subtree /filter:"((&(objectClass=*)(cn=*\0acnf:*)))" /atts:objectclass,whencreated,whenchanged`

    b. Review the attributes, attribute values and if present, subordinate objects to determine which object should remain and which should be deleted

    c. Ensure you have an up-to-date backup of the directory

    d. Delete the conflict mangled object/container or the object it conflicted with using LDP.EXE, ADSIEDIT or one of the Active Directory management tools.

4. Perform testing of the replication partners with third-party components removed.  
Multiple third-party products have been found to cause this issue including:
    1. Anti-Virus software  
    2. Directory Synchronization

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

## More information

Lingering Objects:  

[Clean that Active Directory forest of lingering objects](https://blogs.technet.com/b/glennl/archive/2007/07/26/clean-that-active-directory-forest-of-lingering-objects.aspx)  

Database Corruption:  

[Event ID 1539—Database integrity](https://technet.microsoft.com/library/dd941847%28v=ws.10%29.aspx)
