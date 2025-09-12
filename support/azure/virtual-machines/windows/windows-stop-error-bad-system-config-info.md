---
title: Windows stop error - 0x00000074 Bad System Config Info
description: This article provides steps to resolve issues where Windows cannot boot and needs to restart due to bad system configuration information in an Azure Virtual Machine (VM).
services: virtual-machines, azure-resource-manager
documentationcenter: ''
author: JarrettRenshaw
manager: dcscontentpm
tags: azure-resource-manager
ms.service: azure-virtual-machines
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting
ms.date: 08/07/2024
ms.author: jarrettr
ms.custom: sap:My VM is not booting
---
# Windows stop error - 0x00000074 Bad System Config Info

**Applies to:** :heavy_check_mark: Windows VMs

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

1. Fix the hive corruption.
1. Enable serial console and memory dump collection.
1. Rebuild the VM.

   > [!NOTE]
   > When encountering this error, the Guest operating system (OS) is not operational. You'll troubleshoot in offline mode to resolve this issue.

### Fix the hive corruption

[!INCLUDE [Fix the corrupted hive](../../../includes/azure/virtual-machines-windows-fix-corrupted-hive.md)]

### Enable the serial console and memory dump collection

**Recommended**: Before you rebuild the VM, enable the Serial Console and memory dump collection by following these steps:

[!INCLUDE [Enable Serial Console and Memory Dump Collection](../../../includes/azure/enable-serial-console-memory-dump-collection.md)]

### Rebuild the VM

Use [step 5 of the VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to rebuild the VM.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
