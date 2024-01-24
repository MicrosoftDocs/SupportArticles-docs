---
title: Server backup process fails and 0x80070005 errors are logged in Windows Server 2012 Essentials
description: Describes an issue in which an Error [0x80070005] Access is denied occurs during a server backup process in Windows Server 2012 Essentials. Provides workarounds.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: lavink, kaushika
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
ms.subservice: backup-and-storage
---
# Server backup process fails and "0x80070005" errors are logged in Windows Server 2012 Essentials

This article describes an issue in which an **Error [0x80070005] Access is denied** error occurs during a server backup process in Windows Server 2012 Essentials.

_Applies to:_ &nbsp; Windows Server 2012  
_Original KB number:_ &nbsp; 2747459

## Symptoms

Assume that you try to back up a server that is running Windows Server 2012 Essentials by using the Windows Server Backup feature. However, the backup operation doesn't finish, and the following event is logged in the Application log:

> Event ID: 547  
Description:  
The backup operation that started at '?2012?-?03?-?31T07:00:05.748719600Z' has encountered errors for the volume(s)'F:'. Log of files not successfully backed up 'C:\Windows\Logs\WindowsServerBackup\Backup_Error-31-03-2012_02-00-05.log'.  

If you open the log file that is described in the event, you see logs that resemble the following:

> Error in backup of F:\$Extend\$RmMetadata\$TxfLog\ during write: Error [0x80070005] Access is denied.  
Error in backup of F:\$Extend\$RmMetadata\$TxfLog\$TxfLog.blf during write: Error [0x80070005] Access is denied.  

## Cause

This issue occurs when a drive that uses the NTFS file system is configured for file-level backup. Because the $RmMetaData directory is NTFS internal data and cannot be accessed by other process, this issue occurs.

## Workaround

To work around this issue, use one of the following methods.

### Method 1

Configure the server backup policy on the affected drive as block-level backup. After you do this, the whole volume is selected for backup.

### Method 2

Set a registry key to exclude the files that are mentioned in the event from file-level backups. These files are used by NTFS, and they can safely be ignored.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

1. In Registry Editor, locate the following registry subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\BackupRestore\FilesNotToBackup`  

2. Right-Click **FilesNotToBackup**, point to **New**, and then click **Multi-String Value**.
3. Type *IgnoreNTFS*, and then press Enter.
4. Right-click **IgnoreNTFS**, and then click **Modify**.
5. In the **Value data** box, type *\\$Extend\\\* /s*.
6. Click **OK**, and then close Registry Editor.
7. Restart the server.
