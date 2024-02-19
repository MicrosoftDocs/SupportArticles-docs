---
title: Back up and restore Hyper-V VM with BMR and data backup
description: Describes behavior that occurs when you use Windows Server Backup on your VM data and bare metal recovery (BMR). Specifically, only critical volumes are backed up, and the VM enters an inconsistent state and fails to start. A resolution is provided.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:backup-and-restore-of-virtual-machines, csstroubleshoot
---
# Back up and restore a Hyper-V VM by using BMR and data backup

This article provides a resolution to an issue where only critical volumes are backed up when you use Windows Server Backup on your virtual machine (VM) data and bare metal recovery (BMR).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3171712

## Symptoms

Consider the following scenario:

- You have a Hyper-V host that's running Microsoft Windows Server 2012 R2.
- The Hyper-V Virtual Machines data resides somewhere other than on the system drive.
- You back up VM data and BMR by using Windows Server Backup (WSB).

When the VM fails to load in this scenario, and you try to restore the BMR in the Windows Recovery environment (WinRE), the system data and the Hyper-V VM are restored. However, the VM is not left in a consistent state and may fail to start.

## Cause

When you create a system restore (BMR) by using Windows Server Backup (WSB), it only backs up critical volumes. Therefore, all the files, data, and Hyper-V VM files that reside on other volumes are not backed up, and you achieve only a partial data backup. This is the expected behavior.

## Resolution

To resolve this issue, follow these steps:

1. Boot into the WinRE, and make sure that the **Only Restore System Drives** option is selected.
2. After the BMR is restored, restore the Hyper-V-specific backup by using Windows Server Backup.  

This two-step process makes sure that the VMs and the data are fully restored.

## More information

As a best practice, make backups of all the volumes along with the BMR. Also restore the BMR *plus* non-critical volumes for seamless operations.

For more information about BMR, see [Bare Metal Restore](/archive/blogs/askcore/bare-metal-restore).
