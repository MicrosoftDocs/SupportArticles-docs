---
title: Automating Disk Cleanup tool
description: Introduces how to run the Disk Cleanup tool (Cleanmgr.exe) by using command-line switches.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, keithpe
ms.prod-support-area-path: Partition and volume management
ms.technology: windows-server-backup-and-storage
---
# Automating Disk Cleanup tool in Windows

This article describes how to run the Disk Cleanup tool (Cleanmgr.exe) by using command-line switches. Cleanmgr.exe is designed to clear unnecessary files from your computer's hard disk. You can configure Cleanmgr.exe with command-line switches to clean up the files you want. You can then schedule the task to run at a specific time by using the Scheduled Tasks tool.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 253597

## More information

You can start the Disk Cleanup tool by running Cleanmgr.exe, or by selecting **Start** > **Programs** > **Accessories** > **System Tools** > **Disk Cleanup**. Disk Cleanup supports the following command-line switches:

- `/d <driveletter>`: - This switch selects the drive that you want Disk Cleanup to clean. The `/d` switch isn't used with `/sagerun:n`.
- `/sageset:n` - This switch displays the Disk Cleanup Settings dialog box and creates a registry key to store the settings you select. The **n** value is stored in the registry and allows you to specify different tasks for Disk Cleanup to run. The **n** value can be any integer value from 0 to 65535. To get all the available options when you use the `/sageset` switch, you may need to specify the drive letter that contains the Windows installation.
- `/sagerun:n` - This switch runs the specified tasks that are assigned to the **n** value by using the `/sageset` switch. All drives in the computer will be enumerated, and the selected profile will be run against each drive.

  For example, in Scheduled Tasks, you could run the following command after running the `cleanmgr /sageset:11` command:  
  `cleanmgr /sagerun:11`.

  This command runs Disk Cleanup with the options that were specified with the `cleanmgr /sageset:11` command.

The available options for Disk Cleanup that you can specify by using the `/sageset` and `/sagerun` switches include:

- Temporary Setup Files - These files shouldn't be needed anymore. They were originally created by a Setup program that's no longer running.
- Downloaded Program Files - They are ActiveX controls and Java programs that are downloaded automatically from the Internet when you view certain pages. They're temporarily stored in the Downloaded Program Files folder on your hard disk. This option includes a **View Files** button that allows you to see the files that would be removed. The button opens the *C:\Winnt\Downloaded Program Files* folder.
- Temporary Internet Files - The Temporary Internet Files folder contains Web pages that are stored on your hard disk for quick viewing. Your personalized settings for Web pages are left intact. This option includes a **View Files** button that displays the files to be deleted. The button opens the *C:\Documents and Settings\Username\Local Settings\Temporary Internet Files\Content.IE5* folder.
- Old Chkdsk Files - When Chkdsk checks your disk for errors, it might save lost file fragments as files in your disk's root folder. These files are unnecessary and can be removed.
- Recycle Bin - The Recycle Bin contains files you've deleted from your computer. These files aren't permanently removed until you empty the Recycle Bin. This option includes a **View Files** button that opens the Recycle Bin.
- Temporary Files - Programs sometimes store temporary information in a Temp folder. Before a program quits, it usually deletes this information. You can safely delete temporary files that haven't been modified in over a week.
- Temporary Offline Files - Temporary offline files are local copies of recently used network files that are automatically cached for you. You can use them when you're disconnected from the network. There's a **View Files** button that opens the Offline Files folder.
- Offline Files - Temporary files are local copies of network files that you specifically made available offline. You can use them when you're disconnected from the network. There's a **View Files** button that opens the Offline Files folder.
- Compress Old Files - Windows can compress files that you haven't used in a while. Compressing the files saves disk space while still enabling you to use them. No files are deleted. Because files are compressed at different rates, the displayed amount of disk space you'll gain is approximate. You can use the **Options** button to specify the number of days to wait before an unused file is compressed.
- Catalog Files for the Content Indexer - The Indexing service speeds up and improves file searches by maintaining an index of the files on the disk. These files are left over from a previous indexing operation and can be deleted safely.

If you select the drive that contains the Windows installation, all of these options are available on the **Disk Cleanup** tab. If you select any other drive, only the Recycle Bin and **Catalog files for content index** options are available on the **Disk Cleanup** tab.

The **More Options** tab contains options for cleaning up Windows components or installed programs. You can use the **Windows Components** option to create free space by removing optional Windows components that you don't use. Selecting the **Clean Up** button for this option starts the Windows Components Wizard. You can use the **Installed Programs** option to free more disk space by removing programs that you don't use. Selecting this **Clean Up** button starts the **Change or Remove Programs** option in the Add/Remove Programs tool.

### Additional information

For a Microsoft Windows XP version of this article, see [How to Automate the Disk Cleanup Tool in Windows XP](https://support.microsoft.com/help/315246).

> [!NOTE]
> Disk Cleanup option on drive's general properties and cleanmgr.exe is not present in  Windows Server 2008 R2 by default. For more information on how to have **Disk Cleanup** button or cleanmgr.exe on Windows Server 2008 R2, see [Disk Cleanup option on drive’s general properties and cleanmgr.exe is not present in Windows Server 2008 R2 by default](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff630161(v=ws.10)).
