---
title: use backup feature to back up and restore data
description: Describes how to use the Backup feature to back up and restore data on your Windows Server 2003-based computer.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: johnf, wellsluo, kaushika
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
ms.subservice: backup-and-storage
---
# How to use the backup feature to back up and restore data

This step-by-step article describes how to use the Backup feature to back up and restore data on your Windows Server 2003-based computer.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 326216

## Summary

This article is intended for users who back up and restore data, and it includes information about how to back up and restore the system configuration and local registry.

To perform the procedures in this article, you must be logged on as a member of the Administrators group or the Backup Operators group.

## Backing up the server

You can manually back up data or use the Backup Wizard, which is included in the Backup feature. You can back up the whole contents of the server, selected portions of the server, or the system state data (the system configuration information).

### To back up selected files or folders

1. Click Start, point to All Programs, point to Accessories, point to System Tools, and then click Backup. The Backup or Restore Wizard starts.
2. Click Advanced Mode.
3. Click the Backup tab.
4. On the Job menu, click New.
5. Expand the drive or folder that contains the items that you want to back up. Click to select the check boxes next to the files, folders, or drives that you want to back up.
6. In the **Backup destination** box, specify the destination for the new job. To do so, do one of the following:

    - If you want to back up files and folders to a file, click File.
    - If you want to back up to tape, click a tape device.

    > [!NOTE]
    > If a tape device is not connected to your computer, File is the only backup media type that is available in the **Backup destination** box.
7. In the **Backup media or file name** box, do one of the following:

    - If you're backing up to a file, specify a path and file name for the backup (.bkf) file. Or, click Browse, specify a file name and location where you want to save the file, and then click Save.
    - If you're backing up to tape, click the tape that you want to use.
8. On the Tools menu, click Options. Specify any additional backup options that you want on the appropriate tabs of the Options page. Click OK.
9. Click Start Backup.
10. If you want to set advanced backup options, such as data verification or hardware compressions, click Advanced. Specify the options that you want, and then click OK.
11. Review the settings on the Backup Job Information page. Specify whether you want this backup to replace the information that is already present on the destination media, or add this backup to the existing information.
12. Click Start Backup.

### To back up the system state (including registry settings)

To back up the system state (including the registry hives system, software, security, the Security Accounts Manager (SAM), and the default user (but not HKEY_CURRENT_USER)), follow these steps:

1. Click Start, point to All Programs, point to Accessories, point to System Tools, and then click Backup. The Backup or Restore Wizard starts.
2. Click Advanced Mode.
3. Click the Backup tab.
4. On the Job menu, click New.
5. Click to select the System State check box.
6. Click to select the check boxes next to any other files, folders, or drives that you want to back up.
7. In the **Backup destination** box, specify the destination for the new job. To do so, do one of the following:

    - If you want to back up files and folders to a file, click File.
    - If you want to back up to tape, click a tape device.

    > [!NOTE]
    > If a tape device is not connected to your computer, File is the only backup media type that is available in the **Backup destination** box.
8. In the **Backup media or file name** box, do one of the following:

    - If you are backing up to a file, specify a path and file name for the backup (.bkf) file. Or, click Browse, specify a file name and location where you want to save the file, and then click Save.
    - If you are backing up to tape, click the tape that you want to use.
9. On the Tools menu, click Options. Specify any additional backup options that you want on the appropriate tabs of the Options page. Click OK.
10. Click Start Backup.
11. If you want to set advanced backup options, such as data verification or hardware compressions, click Advanced. Specify the options that you want, and then click OK.
12. Review the settings on the Backup Job Information page. Specify whether you want this backup to replace the information that is already present on the destination media, or add this backup to the existing information.
13. Click Start Backup.

### To schedule a backup for a later time or date

You may want to run a backup operation when there's low system usage. However, such times may be late at night or on weekends. You can schedule backup jobs to run on a particular day and time.

> [!NOTE]
> To schedule a backup operation, the Task Scheduler service must be running.

1. Click Start, point to All Programs, point to Accessories, point to System Tools, and then click Backup. The Backup or Restore Wizard starts.
2. Click Advanced Mode.
3. Click the Backup tab.
4. On the Job menu, click New.
5. Expand the drive or folder that contains the items that you want to back up. Click to select the check boxes next to the files, folders, or drives that you want to back up.
6. In the **Backup destination** box, specify the destination for the new job. To do so, do one of the following:

    - If you want to back up files and folders to a file, click File.
    - If you want to back up to tape, click a tape device.

    > [!NOTE]
    > If a tape device is not connected to your computer, File is the only backup media type that is available in the **Backup destination** box.
7. In the **Backup media or file name** box, do one of the following:

    - If you're backing up to a file, specify a path and file name for the backup (.bkf) file. Or, click Browse, specify a file name and location where you want to save the file, and then click Save.
    - If you're backing up to tape, click the tape that you want to use.
8. On the Tools menu, click Options. Specify any additional backup options that you want on the appropriate tabs of the Options page. Click OK.
9. Click Start Backup.
10. Click Schedule.

    If a message prompts you to save your current backup selections, click OK. On the Save As page that appears, specify a name and location where you want to save the backup, and then click Save.
11. In the **Job name** box, type a name for the scheduled backup job, and then click Properties.
12. Click the Schedule tab. In the Schedule Task box, click how frequently you want the backup job to run, and then in the **Start time** box, specify a time when you want the backup to run, and then click OK.
13. On the Set Account Information page that appears, type a user name and password of the user whom you want to run the scheduled backup for, and then click OK.
14. Click OK.

    The backup job that you scheduled appears on the calendar on the Schedule Jobs tab. The scheduled backup job automatically starts at the time and data that you specified.
15. Close the Backup Utility page.

### To back up data by using the Backup Wizard

1. Click Start, point to All Programs, point to Accessories, point to System Tools, and then click Backup. The Backup or Restore Wizard starts.
2. Click Advanced Mode.
3. On the Welcome tab, click Backup Wizard (Advanced). The Backup Wizard starts. Click Next.
4. Specify what you want to back up, and then click Next.
5. If you selected **Back up selected files, drives, or network data** in step 4, expand the drive or folder that contains the items that you want to back up, click to select the check boxes next to the drive, folder, or file that you want to back up, and then click Next.
6. Specify the backup type, destination, and name in the appropriate boxes, and then click Next.

    > [!NOTE]
    > If a tape drive isn't connected to your computer, File is the only backup media type that is available in the **Select the backup type** box.
7. Review the settings that appear on the **Completing the Backup Wizard** page. If you want to specify advanced backup options, click Advanced, specify the options that you want, and then click OK.
8. Click Finish.

## Restoring data to the server

If a data loss occurs, you can restore your backup data manually or by using the Restore Wizard, which is included in the Backup feature.

### To restore selected files from a file or tape

1. Click Start, point to All Programs, point to Accessories, point to System Tools, and then click Backup. The Backup or Restore Wizard starts.
2. Click Advanced Mode.
3. Click the **Restore and Manage Media** tab.
4. Click the media that you want to restore, and then click to select the check boxes next to the drives, folders, or files that you want to restore.
5. In the **Restore file to** box, specify the location where you want to restore the files by doing one of the following:

    - If you want to restore the files or folders to the same location in which they were when you backed up the data, click **Original location**, and then go to step 7.
    - If you want to restore the files or folders to a new location, click **Alternate location**.

        This option preserves the folder structure of the backed-up data.
    - If you want to restore the files and folders to a single location, click **Single folder**.  

6. If you selected **Alternate location** or **Single folder**, type the location in which you want the data to be restored, or click Browse and select the location, and then click OK.
7. On the Tools menu, click Options. Click the Restore tab, specify the restore option that you want, and then click OK.
8. Click Start Restore.
9. On the Confirm Restore page that appears, click Advanced if you want to set advanced restore options, and then click OK.
10. Click OK to start the restore operation.

### To restore the system state data (including registry information)

1. Click Start, point to All Programs, point to Accessories, point to System Tools, and then click Backup. The Backup or Restore Wizard starts.
2. Click Advanced Mode.
3. Click the **Restore and Manage Media** tab.
4. In the **Items to restore** box, expand the media that you want to restore, and then click to select the System State check box.
5. Click to select the check boxes next to any other drives, folders, or files that you want to restore.
6. In the **Restore file to** box, specify the location where you want to restore the files by doing one of the following:

    - If you want to restore the files or folders to the same location in which they were when you backed up the data, click **Original location**, and then go to step 8.
    - If you want to restore the files or folders to a new location, click **Alternate location**.
        This option preserves the folder structure of the backed-up data.
    - If you want to restore the files and folders to a single location, click **Single folder**.

    > [!NOTE]
    > If you do not designate an alternate location for the restored data, the restore operation erases the current system state data and replaces it with the information that you are restoring.
7. If you selected **Alternate location** or **Single folder**, type the location in which you want the data to be restored, or click Browse and select the location.
8. Click Start Restore.
9. On the Confirm Restore page that appears, click Advanced if you want to set advanced restore options, and then click OK.
10. Click OK to start the restore operation.

### To restore backed up data by using the Restore Wizard

1. Click Start, point to All Programs, point to Accessories, point to System Tools, and then click Backup. The Backup or Restore Wizard starts.
2. Click Advanced Mode.
3. On the Welcome tab, click Restore Wizard (Advanced). The Restore Wizard starts. Click Next.
4. In the **Items to restore** box, expand the media that you want to restore, click to select the check boxes next to the drives, folders, or files that you want to restore, and then click Next.
5. Review the settings that appear on the **Completing the Restore Wizard** page. If you want to specify advanced backup options, click Advanced, specify the options that you want, and then click OK.
6. Click Finish.

## Troubleshooting

### You can't back up or restore data

You must be a member of the Administrators group or the Backup Operators group on the local computer to back up or restore data.

### You can't schedule a backup operation

The Task Scheduler service must be running before you can schedule a backup. If the Task Scheduler service isn't already running, follow these steps to start it:

1. Click Start, and then click Run.
2. In the Open box, type cmd, and then click OK.
3. At the command prompt, type net start schedule, and then press ENTER.
