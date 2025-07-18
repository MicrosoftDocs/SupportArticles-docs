---
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-virtual-machines
ms.topic: include
ms.date: 12/18/2023
ms.reviewer: jarrettr
---
##### Part 1: Attach the OS disk to a recovery VM

1. Take a snapshot of the OS disk of the affected VM to create a backup. For more information, see [Create a snapshot of a virtual hard disk](/azure/virtual-machines/snapshot-copy-managed-disk).

1. [Attach the OS disk to a recovery VM](../../azure/virtual-machines/windows/troubleshoot-recovery-disks-portal-windows.md).

1. Use remote desktop protocol (RDP) to connect remotely to the recovery VM.

1. If the OS disk of the affected VM is encrypted, turn off encryption before you go to the next step. For more information, see [Decrypt the encrypted OS disk](../../azure/virtual-machines/windows/troubleshoot-bitlocker-boot-error.md#decrypt-the-encrypted-os-disk).

##### Part 2: Locate the dump file and submit a support ticket

1. On the recovery VM, go to the *Windows* folder on the attached OS disk. For example, if the drive letter that's assigned to the attached OS disk is *F*, go to *F:\\Windows*.

1. Locate the *Memory.dmp* file, and then [submit a support ticket](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) and attach the dump file.
