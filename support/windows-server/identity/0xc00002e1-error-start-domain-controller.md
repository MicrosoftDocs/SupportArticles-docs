---
title: 0xc00002e1 error when you start your Windows-based domain controller
description: Explains how to recover from a corrupted Active Directory database or from a similar problem that prevents your computer from starting in normal mode.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: duanecr, kaushika
ms.custom: sap:active-directory-database-issues-and-domain-controller-boot-failures, csstroubleshoot
ms.subservice: active-directory
---
# Error when you start your Windows-based domain controller: Directory Services cannot start

This article explains how to recover from a corrupted Active Directory database or from a similar problem that prevents your computer from starting in normal mode.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 258062

## Summary

This article leads you through a series of steps that may help you diagnose the cause of the **Directory Services cannot start** system error. These steps may include:  

- Verifying that the Active Directory directory service files exist.
- Verifying that the file system permissions are correct.
- Checking the integrity of the Active Directory database.
- Performing a semantic database analysis.
- Repairing the Active Directory database.
- Removing and recreating the Active Directory database.

This article also tells you how to use Ntdsutil or Esentutl to perform a lossy repair of the Active Directory database. Because a lossy repair deletes data and may introduce new problems, only perform a lossy repair if it's the only available option.

## Symptoms

When you start your domain controller, the screen may go blank, and you may receive the following error message:

>LSASS.EXE - System Error, security accounts manager initialization failed because of the following error: Directory Services cannot start. Error status 0xc00002e1.
>
> Please click OK to shutdown this system and reboot into directory services restore mode, check the event log for more detailed information.

Additionally, the following event ID messages may appear in the event log:

> Event ID: 700  
Description: "NTDS (260) Online defragmentation is beginning a pass on database NTDS.DIT."  
Event ID: 701  
Description: "NTDS (268) Online defragmentation has completed a full pass on database 'C:\WINNT\NTDS\ntds.dit'."  
Event ID: 101  
Description: "NTDS (260) the database engine stopped."  
Event ID: 1004  
Description: "The directory was shut down successfully."  
Event ID: 1168  
Description: "Error: 1032 (fffffbf8) has occurred. (internal ID 4042b). Please contact Microsoft product support services for assistance."  
Event ID: 1103  
Description: "The windows directory services database could not be initialized and returned error 1032. Unrecoverable error, the directory can't continue."

## Cause

This problem occurs because one or more of the following conditions are true:

- The NTFS file system permissions on the root of the drive are too restrictive.
- The NTFS file system permissions on the NTDS folder are too restrictive.
- The drive letter of the volume that contains the Active Directory database has changed.
- The Active Directory database (Ntds.dit) is corrupted.
- The NTDS folder is compressed.

## Resolution

To resolve this problem, follow these steps:

1. Restart the domain controller.
2. When the BIOS information appears, press F8.
3. Select **Directory Services Restore Mode**, and then press ENTER.
4. Log on by using the Directory Services Restore Mode password.
5. Click **Start**, select **Run**, type _cmd_ in the **Open** box, and then click **OK**.
6. At the command prompt, type _ntdsutil files info_.

    Output that is similar to the following appears:

    > Drive Information:
    >
    > C:\ NTFS (Fixed Drive  ) free(533.3 Mb) total(4.1 Gb)
    >
    > DS Path Information:
    >
    > Database   : C:\WINDOWS\NTDS\ntds.dit - 10.1 Mb
    > Backup dir : C:\WINDOWS\NTDS\dsadata.bak
    > Working dir: C:\WINDOWS\NTDS
    > Log dir    : C:\WINDOWS\NTDS - 42.1 Mb total
    > temp.edb - 2.1 Mb
    > res2.log - 10.0 Mb
    > res1.log - 10.0 Mb
    > edb00001.log - 10.0 Mb
    > edb.log - 10.0 Mb

    > [!NOTE]
    > The file locations that are included in this output are also found in the following registry subkey:  
    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters`

    The following entries in this key contain the file locations:

    - Database Backup path
    - Database Log files path
    - DSA Working Directory
7. Verify that the files that are listed in the output in step 6 exist.
8. Verify that the folders in the Ntdsutil output have the correct permissions. The correct permissions are specified in the following tables.

    **Windows Server 2003**

    | Account| Permissions| Inheritance |
    |---|---|---|
    |System|Full Control|This folder, subfolders, and files|
    |Administrators|Full Control|This folder, subfolders, and files|
    |Creator Owner|Full Control|Subfolders and Files only|
    |Local Service|Create Folders / Append Data|This folder and subfolders|

    **Windows 2000**

    | Account| Permissions| Inheritance |
    |---|---|---|
    |Administrators|Full Control|This folder, subfolders, and files|
    |System|Full Control|This folder, subfolders, and files|

    > [!NOTE]
    > Additionally, the System account requires Full Control permissions on the following folders:
    >
    > - The root of the drive that contains the Ntds folder
    > - The %WINDIR% folder
    >
    > In Windows Server 2003, the default location of the %WINDIR% folder is C:\WINDOWS. In Windows 2000, the default location of the %WINDIR% folder is C:\WINNT.
9. Check the integrity of the Active Directory database. To do this, type _ntdsutil files integrity_ at the command prompt.

    If the integrity check indicates no errors, restart the domain controller in normal mode. If the integrity check doesn't finish without errors, continue to the following steps.
10. Perform a semantic database analysis. To do this, type the following command at the command prompt, including the quotation marks:

    ```console
    ntdsutil "sem d a" go
    ```

11. If the semantic database analysis indicates no errors, continue to the following steps. If the analysis reports any errors, type the following command at the command prompt, including the quotation marks:

    ```console
    ntdsutil "sem d a" "go f"
    ```

12. Follow the steps in the following Microsoft Knowledge Base article to perform an offline defragmentation of the Active Directory database:

    [232122](https://support.microsoft.com/help/232122) Performing offline defragmentation of the Active Directory database
13. If the problem still exists after the offline defragmentation, and there are other functional domain controllers in the same domain, remove Active Directory from the server, and then reinstall Active Directory. To do this, follow the steps in the "Workaround" section in the following Microsoft Knowledge Base article:

    [332199](https://support.microsoft.com/help/332199) Domain controllers do not demote gracefully when you use the Active Directory Installation Wizard to force demotion in Windows Server 2003 and in Windows 2000 Server

    > [!NOTE]
    > If your domain controller is running Microsoft Small Business Server, you cannot perform this step, because Small Business Server cannot be added to an existing domain as an additional domain controller (replica). If you have a system state backup that is newer than the tombstone lifetime, restore that system state backup instead of removing Active Directory from the server. By default, the tombstone lifetime is 60 days.

14. If no system state backup is available, and there are no other healthy domain controllers in the domain, we recommend that you rebuild the domain by removing Active Directory and then reinstalling Active Directory on the server, creating a new domain. You can use the old domain name again or use a new domain name. You can also rebuild the domain by reformatting and reinstalling Windows on the server. However, removing Active Directory is quicker, and effectively removes the corrupted Active Directory database.

    If no system state backup is available, there are no other healthy domain controllers in the domain, and you must have the domain controller working immediately, perform a lossy repair by using either Ntdsutil or Esentutl.

    > [!NOTE]
    > Microsoft doesn't support domain controllers after Ntdsutil or Esentutl is used to recover from Active Directory database corruption. If you perform this kind of repair, you must rebuild the domain controller for Active Directory to be in a supported configuration. The repair command in Ntdsutil uses the Esentutl utility to perform a lossy repair of the database. This kind of repair fixes corruption by deleting data from the database. Only use this kind of repair as a last resort.

    Although the domain controller may start and may appear to function correctly after the repair, its state is unsupported because the data that is deleted from the database can cause any number of problems that may not surface until later. There's no way to determine what data was deleted when the database was repaired. As soon as possible after the repair, you must rebuild the domain to return Active Directory to a supported configuration. If you only use the offline defragmentation or semantic database analysis methods that are referenced in this article, you don't have to rebuild the domain controller afterward.
15. Before you perform a lossy repair, contact Microsoft Product Support Services to confirm that you've reviewed all possible recovery options and to verify that the database truly is in an unrecoverable state. For a complete list of Microsoft Product Support Services phone numbers and information about support costs, visit the following Microsoft Web site:

    [Contact Microsoft Support](https://support.microsoft.com/contactus/)

    On a Windows 2000 Server-based domain controller, use Ntdsutil to recover the Active Directory database. To do this, type _ntdsutil files repair_ at a command prompt in Directory Service Restore Mode.

    To perform a lossy repair of a Windows Server 2003-based domain controller, use the Esentutl.exe tool to recover the Active Directory database. To do this, type _esentutl /p_ at a command prompt on the Windows Server 2003-based domain controller.
16. After the repair operation is complete, rename the .log files in the NTDS folder by using a different extension such as .bak, and try to start the domain controller in normal mode.
17. If you can start the domain controller in normal mode after the repair, migrate relevant Active Directory objects to a new forest as soon as possible. Because this lossy repair method fixes corruption by deleting data, it can cause later problems that are extremely difficult to troubleshoot. At the first opportunity after the repair, you must rebuild the domain to bring Active Directory back to a supported configuration.

    You can migrate users, computers, and groups by using the Active Directory Migration Tool (ADMT), Ldifde, or a non-Microsoft migration tool. ADMT can migrate user accounts, computer accounts, and security groups with or without the security identifier (SID) history. ADMT also migrates user profiles. To use ADMT in a Small Business Server environment, review the "Migrating from Small Business Server 2000 or Windows 2000 Server" white paper. To obtain this white paper, visit the following Microsoft Web site:

    [Migrating from Small Business Server 2000 or Windows 2000 Server to Windows Small Business Server 2003](https://technet.microsoft.com/library/cc719892.aspx)

    You can use Ldifde to export and import many types of objects from the damaged domain to the new domain. These objects include user accounts, computer accounts, security groups, organization units, Active Directory sites, subnets, and site links. Ldifde can't migrate the SID history. Ldifde is part of Windows 2000 Server and Windows Server 2003.

    For more information about how to use Ldifde, click the following article number to view the article in the Microsoft Knowledge Base:

    [237677](https://support.microsoft.com/help/237677) Using Ldifde to import and export directory objects to Active Directory

    You can use the Group Policy Management Console (GPMC) to export the file system and the Active Directory part of the group policy object from the damaged domain to the new domain.

    To obtain the GPMC, visit the following Microsoft Web site:

    [Cloud Computing Services](https://www.microsoft.com/windowsserver2008/en/us/security-policy.aspx)

    For information about how to migrate group policy objects by using the GPMC, review the "Migrate GPOs across domains with GPMC" white paper. To obtain this white paper, visit the following Microsoft Web site:

    [Migrating GPOs Across Domains](https://technet.microsoft.com/library/cc785343%28ws.10%29.aspx)

18. After the recovery, evaluate your current backup plan to make sure that you have scheduled system state backups frequently enough. Schedule system state backups at least every day, or after every significant change. System state backups must contain the required level of fault tolerance. For example, don't store backups on the same drive as the computer that you're backing up. Whenever possible, use more than one domain controller to avoid a single point of failure. Store backups in an off-site location so that site disaster (fire, theft, flood, computer theft) doesn't affect your ability to recover. The following Microsoft Web sites can help you develop a backup plan.

    - Windows Server 2003: [Creating a Backup and Recovery Plan](https://technet.microsoft.com/library/cc739288%28ws.10%29.aspx)
    - Windows 2000: [Chapter 14 - Data Backup and Recovery](https://technet.microsoft.com/library/bb727106.aspx)
    - Windows Small Business Server: [Windows Server Essentials (Small Business Server)](https://technet.microsoft.com/library/cc514417.aspx)
