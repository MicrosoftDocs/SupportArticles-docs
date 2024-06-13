---
title: Windows stop error - 0x00000074 Bad System Config Info
description: This article provides steps to resolve issues where Windows cannot boot and needs to restart due to bad system configuration information in an Azure Virtual Machine (VM).
services: virtual-machines, azure-resource-manager
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.service: virtual-machines
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting
ms.date: 06/13/202
ms.author: genli
ms.custom: sap:My VM is not booting
---

# Windows stop error - 0x00000074 Bad System Config Info

This article provides steps to resolve issues where Windows cannot boot and needs to restart due to bad system configuration information in an Azure Virtual Machine (VM).

## Symptom

When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of the VM, you'll see that the screenshot displays the Windows stop code **#0x00000074** or **BAD_SYSTEM_CONFIG_INFO**.

> Your PC ran into a problem and needs to restart. You can restart.
> For more information about this issue and possible fixes, visit <https://windows.com/stopcode>
> If you call a support person, give them this info:
> Stop code: BAD_SYSTEM_CONFIG_INFO

  :::image type="content" source="media/windows-stop-error-bad-system-config-info/stop-code.png" alt-text="Screenshot of the Windows stop code BAD_SYSTEM_CONFIG_INFO." border="false":::

## Cause

The **BAD_SYSTEM_CONFIG_INFO** stop code occurs if the **SYSTEM** registry hive appears to be corrupted. This error can be caused by any of these reasons:

- The registry hive wasn't closed properly.
- The registry hive is corrupt.
- There are missing registry keys or values.

## Solution

### Process overview

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

1. Create and Access a Repair VM.
1. Check for hive corruption.
1. Enable serial console and memory dump collection.
1. Rebuild the VM.

   > [!NOTE]
   > When encountering this error, the Guest operating system (OS) is not operational. You'll troubleshoot in offline mode to resolve this issue.

### Create and access a Repair VM

1. Use steps 1-3 of the [VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md) to prepare a Repair VM.
1. Check for hive corruption.
1. Use Remote Desktop Connection to connect to the Repair VM.
1. Copy the `<VOLUME LETTER OF BROKEN OS DISK>:\windows\system32\config` folder and save it in either your healthy disk partition, or in another safe location. Back up this folder as a precaution, since you will edit critical registry files.

   > [!NOTE]
   > Make a copy of the `<VOLUME LETTER OF BROKEN OS DISK>:\windows\system32\config` folder as a backup in case you need to roll back any changes you make to the registry.

### Check for hive corruption

The instructions below will help you determine if the cause was due to hive corruption, or if the hive wasn't closed correctly. If the hive wasn't closed correctly, then you'll be able to unlock the file and fix your VM.

1. On your repair VM, open the **Registry Editor** application. Type "REGEDIT" in the Windows search bar to find it.
1. In Registry Editor, select **HKEY_LOCAL_MACHINE** to highlight it, then select **File > Load Hive…** from the menu.
1. Browse to `<VOLUME LETTER OF BROKEN OS DISK>:\windows\system32\config\SYSTEM` and select **Open**.
1. When prompted to enter a name, enter **BROKENSYSTEM**.

   1. If the hive fails to open, or if it is empty, then the hive is corrupted. If the hive has been corrupted, [open a support ticket](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade).

      :::image type="content" source="media/windows-stop-error-bad-system-config-info/load-hive-error.png" alt-text="Screenshot shows an error occurs stating that the Registry Editor can't load the hive.":::

   1. If the hive opens normally, then the hive wasn't closed properly. Continue to step 5.

1. To fix a hive that wasn't closed properly, highlight **BROKENSYSTEM** then select **File > Unload Hive…** to unlock the file.

### Enable the serial console and memory dump collection

**Recommended**: Before you rebuild the VM, enable the Serial Console and memory dump collection by following these steps:

[!INCLUDE [Enable Serial Console and Memory Dump Collection](../../../includes/azure/enable-serial-console-memory-dump-collection.md)]

### Rebuild the VM

Use [step 5 of the VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to rebuild the VM.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
