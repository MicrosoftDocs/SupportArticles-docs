---
title: Offline defragmentation of Active Directory database
description: Describes how to How to perform offline defragmentation of the Active Directory database.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-backup-restore-or-disaster-recovery, csstroubleshoot
---
# Perform offline defragmentation of the Active Directory database

This article describes how to perform offline defragmentation of the Active Directory database.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 232122

## Summary

Active Directory automatically performs online defragmentation of the database at certain intervals as part of the Garbage Collection process. (By default, this occurs every 12 hours.) Online defragmentation does not reduce the size of the database file (Ntds.dit) but instead optimizes data storage in the database and reclaims space in the directory for new objects.

Performing an offline defragmentation creates a new version of the database file without internal fragmentation. It also re-creates all indexes. Depending on how fragmented the original database file was, the new file may be much smaller.

## Perform offline defragmentation of Active Directory database

To perform offline defragmentation of the Active Directory database, follow these steps:

1. Back up Active Directory. Windows Server Backup natively supports backing up Active Directory while online. This occurs automatically when you select the option to back up everything on the computer in the Backup Wizard, or independently by selecting to back up the **System State** in the wizard.

2. Take one of the following actions:
   - Stop the **Active Directory Domain Services** or LDS instance.
   - Start msconfig, and go to the boot pane. Select the OS installation that you want to configure. Select **Safe Boot**  in the **Boot options** section, and also select the **Active Directory repair**  item. After you click **OK**, the tool asks you to restart. Restart the computer.

3. Log on to the administrator account by using the password that is defined for the local administrator account in the Directory Service Restore Mode SAM.  

4. Open a **Command Prompt**  window.

5. NTDSUTIL uses the TEMP and TMP environment variables to create a temporary database during defragmentation. If the free space on your standard volume used is less than the size of the compacted database, you receive the following error:

    > file maintenance: compact to d:\compactDB  
    Initiating DEFRAGMENTATION mode...  
         Source Database: D:\windows\NTDS\ntds.dit  
         Target Database: d:\compactDB\ntds.dit  
    >
    > Defragmentation  Status (% complete)  
    >
    > 0    10   20   30   40   50   60   70   80   90  100
    >
    > |----|----|----|----|----|----|----|----|----|----|
    >
    > ..........................Operation terminated with error -1808( JET_errDiskFull, No space left on disk).

    In this case, set the environment variables TMP and TEMP to a volume that has enough free space for the task. For example, use the following settings:

    ```console
    Md d:\temp
    Set tmp=d:\temp
    Set temp=d:\temp
    ```

    > [!NOTE]
    > This problem can also occur during an integrity check of the database.

6. Run NTDSUTIL.

7. Type activate instance ntds  to select the Active Directory database instance. Use the LDS instance name if you want to compact an LDS database.
8. Type files, and then press Enter.
9. Type info, and then press Enter. This displays current information about the path and size of the Active Directory database and its log files. Note the path.
10. Establish a location that has sufficient drive space for the compacted database to be stored.
11. Type `compact to <drive>:\<directory>`, and then press Enter. In this command, the placeholders \<drive> and \<directory> represent the path of the location that you established in the previous step.

    > [!NOTE]
    > You must specify a directory path. If the path contains any spaces, the whole path must be enclosed in quotation marks. For example, type *compact to "c:\new folder"*.

12. A new database that is named *Ntds.dit* or *AdamNtds.dit* is created in the path that you specified.
13. Type quit, and then press Enter. Type quit again to return to the command prompt.
14. If defragmentation succeeds without errors, follow the Ntdsutil.exe on-screen instructions. Delete all the log files in the log directory by typing the following command `del drive :\ pathToLogFiles \*.log`.

    Copy the new Ntds.dit or AdamNtds.dit file over the old database file in the current database path that you noted in step 5.

    > [!NOTE]
    > You do not have delete the Edb.chk file.
15. If you stopped Active Directory Domain Services or LDS instance, you can restart it now.
16. If you are working in the Active Directory Restore mode, start msconfig and go to the boot pane. Select the operating system installation that you want to configure. Click to clear **Safe Boot** in the **Boot options** section. When you click **OK**, the tool asks you to restart. Restart the computer.
