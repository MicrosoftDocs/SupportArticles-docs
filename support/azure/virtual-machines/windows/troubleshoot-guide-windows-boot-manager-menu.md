---
title: Windows virtual machine cannot boot due to windows boot manager
description: This article provides steps to resolve issues where Windows Boot Manager prevents the booting of an Azure Virtual Machine.
services: virtual-machines
documentationcenter: ''
author: JarrettRenshaw
manager: dcscontentpm
tags: azure-resource-manager
ms.service: azure-virtual-machines
ms.collection: windows
ms.workload: infrastructure-services
ms.tgt_pltfrm: na
ms.topic: troubleshooting
ms.date: 06/13/2024
ms.custom: sap:My VM is not booting
---
# Windows VM cannot boot due to Windows Boot Manager

**Applies to:** :heavy_check_mark: Windows VMs

This article provides steps to resolve issues where Windows Boot Manager prevents the booting of an Azure Virtual Machine (VM).

## Symptom

The VM is stuck waiting upon a user prompt and doesn't boot unless manually instructed to.

When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of the VM, you'll see that the screenshot displays the Windows Boot Manager with the message *Choose an operating system to start, or press TAB to select a tool:*.

:::image type="content" source="media/troubleshoot-guide-windows-boot-manager-menu/choose-os-to-start.png" alt-text="The Windows Boot Manager screen states Choose an operating system to start, or press TAB to select a tool.":::

## Cause

The error is due to a BCD flag *displaybootmenu* in the Windows Boot Manager. When the flag is enabled, Windows Boot Manager prompts the user, during the booting process, to select which loader they wish to run, causing a boot delay. In Azure, this feature can add to the time it takes to boot a VM.

## Solution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

Process Overview:

1. Configure for Faster Boot Time using Serial Console.
2. Create and Access a Repair VM.
3. Configure for Faster Boot Time on a Repair VM.
4. **Recommended**: Before you rebuild the VM, enable serial console and memory dump collection.
5. Rebuild the VM.

### Configure for Faster Boot Time using Serial Console

If you have access to serial console, there are two ways you can achieve faster boot times. Either decrease the *displaybootmenu* wait time, or remove the flag altogether.

1. Follow directions to access [Azure Serial Console for Windows](./serial-console-windows.md) to gain access to the text-based console.

   > [!NOTE]
   > If you're unable to access serial console, skip ahead to [Create and Access a Repair VM](#create-and-access-a-repair-vm).

2. **Option A**: Reduce Waiting Time

   a. Waiting time is set at 30 seconds by default but can be changed to a faster time (e.g. 5 seconds).

   b. Use the following command in serial console to adjust the timeout value:

      `bcdedit /set {bootmgr} timeout 5`

3. **Option B**: Remove the BCD Flag

   a. To prevent the Display Boot Menu prompt altogether, enter the following command:

      `bcdedit /deletevalue {bootmgr} displaybootmenu`

      > [!NOTE]
      > If you were unable to use serial console to configure a faster boot time in the steps above, you can instead continue with the following steps. You'll now be troubleshooting in offline mode to resolve this issue.

### Create and Access a Repair VM

1. Use [steps 1-3 of the VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md) to prepare a Repair VM.
2. Use Remote Desktop Connection connect to the Repair VM.

### Configure for Faster Boot Time on a Repair VM

1. Open an elevated command prompt.
2. Enter the following to enable DisplayBootMenu:

   Use this command for **Generation 1 VMs**:

   `bcdedit /store <VOLUME LETTER WHERE THE BCD FOLDER IS>:\boot\bcd /set {bootmgr} displaybootmenu yes`

   Use this command for **Generation 2 VMs**:

   `bcdedit /store <VOLUME LETTER OF EFI SYSTEM PARTITION>:EFI\Microsoft\boot\bcd /set {bootmgr} displaybootmenu yes`

   Replace any greater than or less than symbols as well as the text within them, e.g. "< text here >".

3. Change the timeout value to 5 seconds:

   Use this command for **Generation 1 VMs**:

   `bcdedit /store <VOLUME LETTER WHERE THE BCD FOLDER IS>:\boot\bcd /set {bootmgr} timeout 5`

   Use this command for **Generation 2 VMs**:

   `bcdedit /store <VOLUME LETTER OF EFI SYSTEM PARTITION>:EFI\Microsoft\boot\bcd /set {bootmgr} timeout 5`

   Replace any greater than or less than symbols as well as the text within them, e.g. "< text here >".

### Recommended: Before you rebuild the VM, enable serial console and memory dump collection

To enable memory dump collection and Serial Console, follow these steps:

[!INCLUDE [Enable Serial Console and Memory Dump Collection](../../../includes/azure/enable-serial-console-memory-dump-collection.md)]

### Rebuild the Original VM

Use [step 5 of the VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to reassemble the VM.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
