---
title: Troubleshoot journal_wrap errors on Sysvol and DFS replica sets
description: Discusses how to troubleshoot journal_wrap errors on Sysvol and DFS replica sets.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dfsr, csstroubleshoot
---
# How to troubleshoot journal_wrap errors on Sysvol and DFS replica sets

This article discusses how to troubleshoot journal_wrap errors on Sysvol and DFS replica sets.

> [!NOTE]
> This article applies to Microsoft Windows 2000. Be aware that support for Windows 2000 ended on July 13, 2010. For more information about the Microsoft Support Lifecycle policy, see the following Microsoft website: [Microsoft Support Lifecycle Policy](/lifecycle)

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 292438

## Summary

The File Replication Service (FRS) is a multithreaded, multi-master replication engine that replaces the LMREPL (LanMan Replication) service in the 3.x and 4.0 versions of Microsoft Windows NT. Windows 2000 domain controllers and servers use FRS to replicate system policy and logon scripts for Windows 2000 and for earlier clients that are located in the System Volume (Sysvol).

FRS can also replicate content between Windows 2000 servers that host the same fault-tolerant Distributed File System (DFS) roots or child-node replicas.

This article describes how FRS uses and relies on the USN change journal for the NTFS file system.  

## More information

The USN journal is a log of fixed size that records all changes that occur on NTFS 5.0-formatted partitions. NTFRS monitors the NTFS USN journal file for closed files in FRS replicated directories as long as FRS is running.

Journal wrap errors occur if a sufficient number of changes that occur while FRS is turned off in such a way that the last USN change that FRS recorded during shutdown no longer exists in the USN journal during startup. The risk is that changes to files and folders for FRS replicated trees may have occurred while the service was turned off, and no record of the change exists in the USN journal. To guard against data inconsistency, FRS asserts into a journal wrap state.

To perform maintenance on FRS replica set members, administrators may stop the FRS service for long periods of time. In this case, administrators may not realize the potential impact. Also, error conditions may cause the FRS service to shut down, and this causes a journal wrap error. In large replica sets, replica members may encounter the following error during an authoritative restore (BURFLAGS=D4):
> journal_wrap_error

To recover, the affected replica member must be reinitialized with a nonauthoritative restore (BURFLAGS=D2) where it will synchronize files from an existing inbound partner. This reinitialization can be time-consuming for large replica sets.

Consider the scenario where computers run versions of the Ntfrs.exe file on the following system versions:  

- Windows 2000 (2195 binary)
- Windows 2000 Service Pack 1 (SP1)
- SP1 Hotfix (WINSE build 5298)

In these scenarios, the nonauthoritative restore process must be invoked manually. To do this, you must set BURFLAGS=D2 in the Windows NT registry.

For Windows 2000 computers that use versions of the Ntfrs.exe file from Windows 2000 Service Pack 2 (SP2) or from Windows 2000 SP2 hotfix (WINSE 11773), the service performs a programmatic nonauthoritative restore when the journal_wrap_error is detected.

By default, versions of the Ntfrs.exe file from Windows 2000 Service Pack 3 (SP3) and from Windows 2000 SP3 hotfix don't perform an automatic nonauthoritative restore (for example, SP3 leaves content in place as 2195 and SP1 left the context in place) when journal wrap errors are detected. SP3 versions of NTFRS may be configured to function like SP2 when the "Enable journal wrap automatic restore" registry entry is set to 1 in the following registry subkey: `HKLM\System\Ccs\Services\Ntfrs\Parameters`  

> [!IMPORTANT]
> We don't recommend that you use this registry setting, and this setting should not be used versions of Windows after the Service Pack 3 version of Windows 2000. The recommended method for performing a nonauthoritative restore on FRS members of DFS or SYSVOL replica sets is to use the FRS BurFlags registry value. For more information about how to use the BurFlags registry value, click the following article number to see the article in the Microsoft Knowledge Base: [290762](https://support.microsoft.com/help/290762) Using the BurFlags registry key to reinitialize File Replication service replica sets

The following are appropriate options to reduce journal wrap errors:

- Put the FRS-replicated content on less busy volumes.
- Keep the FRS service running.
- Avoid making changes to FRS-replicated content while the service is turned off.
- Increase the USN journal size.

FRS is a service that must always be running on Windows domain controllers and members of FRS-replicated DFS sets.

If you increase the USN journal size, and therefore you increase the number of changes that the journal can hold before the journal "wraps," this reduces the possibility that the USN journal wrap will occur. The USN journal size can be changed by setting the following registry key: `HKLM\System\CCS\Services\NTFRS\Parameters\"Ntfs Journal size in MB" (REG_DWORD)`  

Valid settings range from 8 megabytes to 128 megabytes (MB). The default is 32 MB. This setting applies to all volumes that are hosting an FRS replica tree. You have to stop and then restart the NTFRS service for the increases to the USN journal size to occur. However, to decrease the USN journal size, you must reformat all volumes that contain FRS-replicated content.

The number of changes that a given USN journal file can hold can be estimated by using the following formula: **journal size** /((60 bytes + (length of file name)) * 2)
The number "2" in this formula stems from two journal entries for each file change: 1 for open and 1 for close. Divide the journal size by the size per change to determine the approximate number of changes that can occur before the journal wrap error is encountered. If we assume that the file names are in an "8.3" file format, this maps to approximately 200,000 files and/or directories for a 32-MB journal file. The number of changes would be less if long file names are used.

In Windows 2000 Service Pack 2, valid settings range between 8 MB and 128 MB, and the default is 32 MB. In Windows 2000 Service Pack 3, valid settings range between 4 MB and 10,000 MB, and the default is 512 MB. These settings apply to all volumes that host an FRS replica tree.

As a guideline, Microsoft suggests that you configure 128 MB of journal for every 100,000 files that are managed by replication on that volume.

 For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:  

[290762](https://support.microsoft.com/help/290762) Using the BurFlags registry key to reinitialize File Replication service replica sets  
