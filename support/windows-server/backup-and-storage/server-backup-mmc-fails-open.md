---
title: Server Backup MMC fails to open
description: Provides a solution to an error that occurs when you launch the Windows Server Backup on Windows Server 2008.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: adityah, kaushika
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
---
# Windows Server Backup MMC fails to open

This article provides a solution to an error that occurs when you launch the Windows Server Backup on Windows Server 2008.

_Applies to:_ &nbsp; Windows Server 2008  
_Original KB number:_ &nbsp; 2000779

## Symptoms

When launching the Windows Server Backup on Windows Server 2008, the MMC opens with following message:

> A fatal error occurred during a Windows Server Backup snap-in operation.  
Error details: The system cannot find the path specified.  
Close Windows Server Backup and then restart it.

## Cause

The Scheduled backup policy folder in task scheduler is missing or broken. On startup the wbadmin.msc snap-in queries, the scheduled tasks resulting in an error when they are missing or otherwise broken.

## Resolution  

Remove the scheduled tasks that the MMC snap-in is trying to read. Once removed new schedules can be created.

To remove any scheduled tasks, open an elevated command prompt and run the following command:

```console
wbadmin disable backup
```

> [!NOTE]
> If you stop the scheduled backups, the disks where you stored the backups cannot be used again to store backups until they are reformatted (so that all existing backups are deleted).  
