---
title: Event IDs 13552 and 13555 are logged in the File Replication Service log on a Windows-based domain controller
description: Resolves an issue in which the SYSVOL folder isn't replicated between domain controllers that are running Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008, or Windows Server 2003.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, skushida, v-ivz, shinicht, torumi
ms.custom: sap:active-directory-backup-restore-or-disaster-recovery, csstroubleshoot
---
# Event ID 13552 and 13555 are logged in the File Replication Service log on a Windows-based domain controller

This article helps resolve an issue in which the SYSVOL folder isn't replicated between domain controllers that are running Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008, or Windows Server 2003.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2986364

## Symptoms

This issue can occur in one of the following conditions on a domain controller that is running Windows Server:  

- You change the configuration of system devices or, the configuration of system devices fails.
- Corruption occurs in File Replication Service (FRS) database.  

Event information  

The two events resemble the following:  

> Event 13555:  
 File Replication Service is in an error state  
>
> Event 13552:  
 The File Replication Service is unable to add this computer to the following replica set: "DOMAIN SYSTEM VOLUME (SYSVOL SHARE)"  

These event logs indicate that the SYSVOL folder isn't replicated between domain controllers. Therefore, this issue causes inconsistent Group Policy settings and the incorrect policy result is set on each client computer.

## Cause

This issue occurs because NTFS detects a firmware update as a configuration change in disks and then changes the journal ID. Therefore, a file ID for data in the FRS database doesn't match the file ID for the data in the update sequence number (USN) journal database.

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.  

To work around this issue, on domain controllers that the events are logged follow these steps:

1. Take full or system state backup for each domain controller.
2. Stop the FRS. To do this, at the command prompt on each domain controller, type the following command, and then press ENTER: `net stop ntfrs`  

    > [!NOTE]
    > At this point, select a reference domain controller that can be based on connectivity and physical server resources. This domain controller will be the "reference domain controller" in all subsequent steps.

3. Delete files in the following three folders to initialize the FRS on the reference domain controller.  
Don't delete the three folders. Delete subfolders and files in these three folders:
   - %systemroot%\ntfrs\jet
   - %systemroot%\sysvol\domain\DO_NOT_REMOVE_NtFrs_PreInstall_Directory
   - %systemroot%\sysvol\staging\domainIf these folders and files aren't shown, perform the [additional steps to show the hidden files or folders](#more-information).
4. Force synchronization of FRS on the reference domain controller. To do this, follow these steps:
      1. Open Registry Editor and locate to the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\SERVICES\NTFRS\Parameters\Backup/Restore\Process at Startup`  
      2. Right-click the **BurFlags**  entry, and then click **Modify**.
      3. In the **Value data** box, type D4, and then click **OK**.
      4. Exit Registry Editor.
5. At the command prompt on the reference domain controller, run the following command to restart the FRS: `net start ntfrs`  

    > [!NOTE]
    > Step 6 through step 10 should be done only on other domain controller.

6. Download and install the [PsTools tool](https://technet.microsoft.com/sysinternals/bb897553%28en-us%29.aspx) on other domain controllers. This tool contains the *PsExec* command-line tools that can be used to delete folders under the SYSVOL folder.
7. Delete files in the three folders below to initialize the FRS on other domain controllers.  
Don't delete the three folders. Delete subfolders and files in the following three folders:
   - %systemroot%\ntfrs\jet
   - %systemroot%\sysvol\domain\DO_NOT_REMOVE_NtFrs_PreInstall_Directory
   - %systemroot%\sysvol\staging\domainIf these folders and files aren't shown, perform the [additional steps to show the hidden files or folders](#more-information).
8. Delete the following folders under the "%systemroot%\sysvol\domain" path:
   - %systemroot%\sysvol\domain\policies
   - %systemroot%\sysvol\domain\scripts
   - %systemroot%\sysvol\domain\policies_NTFRS_ **xxxxxxx**  
   - %systemroot%\sysvol\domain\scripts_NTFRS_ **xxxxxxx**  
   - %systemroot%\sysvol\domain\NtFrs_PreExisting__See_Evntlog  
    > [!NOTE]
    > "xxxxxxx" is a placeholder that represents alphanumeric characters. Skip this step if there are not such folders and files.

    Additionally, if the folders and files can't be deleted, follow these steps to delete them by using the PsExec tool.  

    Steps to delete folders and files by using the PsExec tool:

    1. Run command prompt with Administrative rights.
    2. Change current directory to the drive where the PsTools tool setup files are (for example, run cd c:\PsTools).
    3. Run the following command: `Psexec.exe -i -s cmd`.  
    4. At new command prompt, type rd /s to delete the following files and folders under the SYSVOL folder (for example, run rd %systemroot%\sysvol\domain\policies /s):
         - %systemroot%\sysvol\domain\policies
         - %systemroot%\sysvol\domain\scripts
         - %systemroot%\sysvol\domain\policies_NTFRS_ **xxxxxxx**  
         - %systemroot%\sysvol\domain\scripts_NTFRS_ **xxxxxxx**  
         - %systemroot%\sysvol\domain\NtFrs_PreExisting__See_Evntlog  
    > [!NOTE]
    > "xxxxxxx" is a placeholder that represents alphanumeric characters. Skip this step if there are not such folders and files.  

9. Force synchronization of FRS on other domain controllers. To do this, follow these steps:
      1. Open Registry Editor and locate to the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\SERVICES\NTFRS\Parameters\Backup/Restore\Process at Startup`  
      2. Right-click the **BurFlags** entry, and then click **Modify**.
      3. In the **Value data** box, type D2, and then click **OK**.
      4. Exit Registry Editor.
10. At command prompt, run the following command to restart FRS on other domain controllers: `net start ntfrs`  

11. Confirm the replication.  

    - "Error" or "Warning" log entries will now not be recorded in event log. If replication succeeded, event ID 13516 is recorded.
    - Check consistency by comparing files and folders in the SYSVOL folders between all domain controllers.  

12. Restart the FRS on the reference domain controller by running the following command: `net stop ntfrs` && `net start ntfrs`  

   > [!NOTE]
   >  
   > - Domain controller that has "BurFlags = D4" works as reference domain controller until service is restarted. The value of the BurFlags entry is reset by restarting FRS.
   > - For domain controllers that have "BurFlags = D2," the value of the BurFlags entry is also reset automatically by restarting FRS.  

After you complete all steps, check the FRS event log. Event IDs 13553, 13554 and 13516 are recorded within few minutes. These logs indicate SYSVOL replication finishes correctly.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.  

## More information  

Show hidden files and folders in Windows Explorer:

1. In Windows Explorer, on the **Tools** menu, click **Folder Options**.
2. From the **Display** tab, enable the **Show hidden files and folders** option.

    > [!NOTE]
    > In Windows Server 2012 R2, Windows Server 2012, or Windows Server 2008 R2, enable the **Show hidden files, folders, and drives** option in the **View** tab.  
