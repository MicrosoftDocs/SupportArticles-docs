---
title: Windows stop error - 0x0000007E system thread exception not handled
description: This article provides steps to resolve issues where the guest OS encounters a problem and wishes to restart your Azure VM. The message will state that "A system thread exception wasn't handled".
services: virtual-machines
documentationcenter: ''
author: mibufo
tags: azure-resource-manager
ms.service: virtual-machines
ms.collection: windows
ms.workload: infrastructure-services
ms.tgt_pltfrm: na
ms.topic: troubleshooting
ms.date: 11/04/2020
---

# Windows stop error - 0x0000007E system thread exception not handled

This article provides steps to resolve issues where the guest operating system (guest OS) encounters a problem and attempts to restart your Azure virtual machine (VM). The error message that's displayed says, "A system thread exception wasn't handled."

## Symptoms

When you use [boot diagnostics](./boot-diagnostics.md) to view a screenshot of the VM output, you'll see that Windows needs to restart with either the "SYSTEM THREAD EXCEPTION NOT HANDLED" stop code or the "0x0000007E" error code.

:::image type="content" source="media/windows-stop-error-system-thread-exception-not-handled/system-thread-exception-not-handled.png" alt-text="Screenshot shows Your PC ran into a problem and needs to restart. We'll restart for you message and SYSTEM THREAD EXCEPTION NOT HANDLED stop code." border="false":::

## Cause

The cause can't be determined until a memory dump file is analyzed. Continue to collect the memory dump file.

## Solution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To resolve this problem, you first need to gather the memory dump file for the crash and then send the file to Microsoft support. To collect the dump file, follow the instructions in the next two sections.

### Attach the OS disk to a new repair VM

1. To prepare a repair VM, follow steps 1-3 of the [VM repair commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md).
1. Connect to the repair VM by using Remote Desktop Connection.

### Locate the dump file and submit a support ticket

1. On the repair VM, go to the Windows folder on the attached OS disk. For example, if the drive letter that's assigned to the attached OS disk is labeled *F*, go to `F:\Windows`.
1. Look for the *memory.dmp* file, and then [submit a support ticket](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) with the memory dump file attached.
1. If you're having trouble locating the *memory.dmp* file, follow the guide to [generate a crash dump file using non-maskable interrupt (NMI) calls](/windows/client-management/generate-kernel-or-complete-crash-dump).

For more information about NMI calls, see the [NMI calls in Azure Serial Console](./serial-console-windows.md#use-the-serial-console-for-nmi-calls) user guide.

## Next steps

> [!div class="nextstepaction"]
> [Troubleshoot Azure Virtual Machine boot errors](./boot-error-troubleshoot.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
