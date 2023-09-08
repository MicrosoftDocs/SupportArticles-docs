---
title: Error when you do a system state backup
description: Describes why you receive an error when you try to do a system state backup in Windows Server 2008. You can configure a registry entry to change this behavior.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-jomcc, prambrav
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
ms.technology: windows-server-backup-and-storage
---
# Error message when you try to do a system state backup in Windows Server 2008 and Windows Server 2008 R2

This article provides a solution to an error that occurs when you try to do a system state backup to a volume on which the system state file stays.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 944530

## Symptoms

When you try to do a system state backup to a volume on which the system state file stays, you receive an error, as mentioned below:

In Windows Server 2008, you receive the following error:
> ERROR - The location for backup is a critical volume.

In Windows Server 2008 R2, you receive the following error:
> ERROR - The backup storage location is invalid. You cannot use a volume that is included in the backup as a storage location.

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

## Cause

This behavior occurs because system state backups to critical volumes are blocked in Windows Server 2008 and Windows Server 2008 R2.

## Resolution

You can change the default behavior of Windows Server 2008 and Windows Server 2008 R2 by adding a registry entry. You must also verify that the following prerequisites are met before you do a system state backup to a critical volume.

### Prerequisites to do system state backups to critical volumes

- Make sure that the target volume has no shadow copy before the backup starts.
- If a system state backup is stored on a source volume, backup settings should be configured for full backups. By default, settings are configured for full backups.
- Periodically check that no other user or program maintains a shadow copy on the target volume.
- Don't keep volume level backups and system state backups in the same location.
- The volume used to store the system state backup needs twice the amount of free space as the size of the system state backup until the backup completes.

Notes

1. Any writes on target volume with shadow copies will increase the diff area size. If the diff area is bounded, it may cause deletion of shadow copies.

2. Incremental backups leave shadow copies behind, it will cause side effect as point 1.

3. Backup stores different versions as shadow copies, it will cause side effect as point 1.

### Registry entry to enable system state backups to critical volumes

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft can't guarantee that these problems can be solved. Modify the registry at your own risk.

To enable the system state backup files to be targeted to critical volumes, you must set the value of the `AllowSSBToAnyVolume` registry entry under the following registry subkey:  
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wbengine\SystemStateBackup\`

Set the value of this entry as follows:
> Name:AllowSSBToAnyVolume  
Data type:DWORD  
Value data:1

> [!NOTE]
> When this value is set to 1, system state backups to any volume are enabled. To revert to the default behavior, set the value to 0.

## More information

The restriction to target the system state backup to any volume is a new feature in Windows Server 2008 and Windows Server 2008 R2.

If all the previous prerequisites aren't met, you may see shadow-copy loss when you do a backup. In worst condition, backup itself may fail because of the snapshot from which backup was taken is becoming lost while writing the backup.

## Steps to reproduce the behavior

1. Install Windows Server 2008 or Windows Server 2008 R2.
2. Install the Windows Server Backup feature from the Server Manager snap-in.
3. Do a system state backup by typing the following command at a command prompt:  
    `wbadmin start systemstatebackup -backuptarget: Drive_Letter:`
    > [!NOTE]
    > In this command, **Drive_Letter** represents a critical volume. Examples of a critical volume include the boot volume and the system volume. Typically, this critical volume is drive C.

## References

- [Backup and Recovery Overview for Windows Server 2008](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770593(v=ws.10))

- [Backup and Recovery Overview for Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd979562(v=ws.10))
