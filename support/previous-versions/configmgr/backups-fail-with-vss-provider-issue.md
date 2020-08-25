---
title: ConfigMgr 2007 backups with Win32 Error = 145
description: Fixes an issue in which System Center Configuration Manager 2007 backups fail if the VSS provider is in use by another process.
ms.date: 08/18/2020
ms.prod-support-area-path: markstan
---
# System Center Configuration Manager 2007 backups fail with Win32 Error = 145

This article helps you fix an issue in which Microsoft System Center Configuration Manager 2007 (ConfigMgr 2007) backups fail and you get **Win32 Error = 145** in the Smsbkup.log file.

_Original product version:_ &nbsp; System Center Configuration Manager 2007  
_Original KB number:_ &nbsp; 2387913

## Symptoms

System Center Configuration Manager 2007 backups may fail if other VSS-aware backup software is scheduled to run concurrently. In this scenario, the Smsbkup.log file shows entries similar to the following message:

> Deleting E:\SMSbackup\SiteServer\SMSServer\inboxes\auth\statesys.box\incoming, FAILED, Win32 Error = 145  
> Deleting E:\SMSBackup\SiteServer\SMSServer\inboxes\auth\ddm.box, FAILED, Win32 Error = 145  
> Deleting E:\SCCMBackup\Backup, FAILED, Win32 Error = 145  
> Failed to delete the contents of the backup folder. Error Code = 0x0 SMS_SITE_BACKUP  
> Error: Deleting the existing files in the backup location failed... SMS_SITE_BACKUP  
> SMS site backup failed. Please see previous errors. SMS_SITE_BACKUP  
> SMS site backup service is stopping. SMS_SITE_BACKUP

## Cause

These errors can occur if the Volume Shadow Copy Service (VSS) provider is in use by another process. Configuration Manager backup expects to have exclusive access to these resources when performing a backup.

## Resolution

To prevent these errors, configure Configuration Manager backup to start at a time outside the window for other backup jobs on the server. The schedule for this can be found in the **Configuration Manager Console** under **Site Management** > **Site Code** > **Site Settings** > **Site Maintenance** > **Tasks** > **Backup ConfigMgr Site Server**.
