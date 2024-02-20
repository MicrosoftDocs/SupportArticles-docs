---
title: Fail to add additional disk to a scheduled backup
description: Provides a solution to an issue where you receive an error message when you try to add an additional disk to a scheduled backup.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
---
# Error message when you try to add an additional disk to a scheduled backup: The filename, directory name, or volume label syntax is incorrect

This article helps fix an error (The filename, directory name, or volume label syntax is incorrect) that occurs when you add an additional disk to a scheduled backup.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2009365

## Symptoms

When you try to add an additional disk to a scheduled backup by using the Windows Server Backup Schedule Wizard, you may receive the following error message:  
> "The filename, directory name, or volume label syntax is incorrect"

## Cause

This problem may occur if a previously added destination disk is not currently attached to the server. When the wizard completes, the currently listed destination disks are verified. If any of these disks are missing, you receive the error message that is described in the "Symptoms" section.  

## Resolution

To resolve this issue, use one of the following options.
 > [!NOTE]
 > To configure or modify a daily backup schedule, you must be a member of the Administrators group. In addition, you must run the **wbadmin** command from an elevated command prompt. To open an elevated command prompt, click **Start**, right-click **Command Prompt**, and then click **Run as administrator**.  

### Option 1

1. Reattach the missing disk or disks.
2. Make sure that all the disks that are defined as backup destination disks are attached to the server.
3. Try again to add an additional disk to a scheduled backup by using the Windows Server Backup Schedule Wizard.  

> [!NOTE]
> If you are using offsite storage, or if another situation prevents all destination disks from being attached at the same time, go to option 3.

### Option 2

If the missing disk is no longer available, remove it as a destination disk from the backup wizard.
 > [!NOTE]
 If the missing disk is the only destination disk that is defined in the backup schedule, you will receive the following error message when you try to remove it. If this occurs, click **Stop backup**, and then create a new backup schedule.  

>"Error: You cannot remove this backup storage destination unless you add another storage destination or stop the scheduled backup. A schedule backup requires at least one backup storage destination.  

To remove a destination disk from a scheduled backup, follow these steps:  

1. In the Windows Server Backup snap-in, click **Backup Schedule**.

2. Click **Modify backup**, and then click **Next**.
3. Leave the **Backup Configuration** setting unchanged, and then click **Next**.
4. Leave the **Backup Time** setting unchanged, and then click **Next**.
5. Leave the **Destination Type** setting unchanged, and then click **Next.**  
6. Select **Remove current backup destinations**, and then click **Next**.
7. Select the backup destination that is no longer attached, and then click **Next**.  

    > [!NOTE]
    > Typically, the disk will have the name "(Disk offline)."

8. Verify that the configuration is correct, and then click **Finish**.  
  
### Option 3

Add a new disk to the backup schedule by running the **wbadmin** command from an elevated command prompt.  

1. Run the following command from an elevated command prompt to determine the Disk Identifier of the new disk:  
`wbadmin get disks`  

2. Based on the output, locate the disk that will be added to the scheduled backup. Make a note of the Disk Identifier. The output will resemble the following:  

    > Disk name: xxxxxxxxxxx  
    Disk number: x  
    Disk identifier: {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}  
    Total space:xxx.xxGB  
    Used space: xxx.xxGB  

3. Run the following command to add the new disk to the Scheduled backup.  Use t he Disk Identifier from the previous step as the **AddTarget** parameter.  
`WBADMIN ENABLE BACKUP -addtarget:{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}`  

4. When you receive the following prompt, type Y for Yes.

    > "Do you want to enable scheduled backups with the above settings?"  

## More information

For more information, visit the following Microsoft Web sites:

What's New in Windows Server Backup on Windows Server 2008 R2  
[What's New in Windows Server Backup](https://technet.microsoft.com/library/ee344835%28WS.10%29.aspx)  

Webadmin  
[Wbadmin](https://technet.microsoft.com/library/cc754015%28WS.10%29.aspx)
