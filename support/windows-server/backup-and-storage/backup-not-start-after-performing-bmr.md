---
title: Backup doesn't start after you perform BMR
description: Describes a problem that prevents Windows Server Backup from starting after you perform a bare metal recovery. Occurs on a computer that's running Windows Server 2012. Provides a workaround.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, takondo, dajiro, chadbee
ms.custom: sap:data-corruption-and-disk-errors, csstroubleshoot
ms.technology: windows-server-backup-and-storage
---
# Windows Server Backup doesn't start after you perform a BMR in Windows Server 2012

This article provides a solution to a problem that prevents Windows Server Backup from starting after you perform a bare metal recovery (BMR).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2961238

## Symptoms

Consider the following scenario:

- You have a computer that's running Windows Server 2012 or Windows Server 2012 R2.
- You're using a UEFI system with two hard disks, and you have EFI System Partition on your system disk.
- You use Windows Server Backup to perform a complete backup.
- You then use the backup data to perform a BMR.

However, after the recovery operation is completed, the Windows Server Backup service cannot be started.

## Cause

This problem occurs because the Windows Server Backup engine (Wbengine.exe) does not handle cases correctly when the EFI system partition location is changed during the restore.

## Resolution

To resolve this issue, Windows Backup must rebuild the catalog to reflect the latest disk configurations. To trigger this action, follow these steps:

1. Open an administrative command prompt.
2. Run the following command:

    ```console
    wbadmin delete catalog
    ```

3. Restart the Windows Server Backup service, or restart the computer.

The Windows Server Backup service should now run normally.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

Learn more about the [wbadmin delete catalog](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc742154(v=ws.11)) command.
