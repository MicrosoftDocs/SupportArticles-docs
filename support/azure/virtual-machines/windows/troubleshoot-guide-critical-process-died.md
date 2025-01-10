---
title: Windows stop error - #0x000000EF "critical process died"
description: Provides steps to resolve issues where a critical process dies during boot in an Azure VM.
services: virtual-machines
documentationcenter: ''
author: genlin
ms.author: genli
manager: dcscontentpm
tags: azure-resource-manager
ms.service: azure-virtual-machines
ms.collection: windows
ms.workload: infrastructure-services
ms.tgt_pltfrm: na
ms.topic: troubleshooting
ms.date: 08/01/2024
ms.custom: sap:My VM is not booting
---
# Windows Stop Error - #0x000000EF "Critical Process Died"

**Applies to:** :heavy_check_mark: Windows VMs

This article provides steps to resolve issues where a critical process dies during boot in an Azure VM.

## Symptom

When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of the VM, you will see that the screenshot displays the error *#0x000000EF* with the message *Critical Process Died*.

:::image type="content" source="media/troubleshoot-guide-critical-process-died/stop-code-critical-process-died.png" alt-text="Screenshot shows Your PC ran into a problem and needs to restart. We're just collecting some error info, and then you can restart." border="false":::

## Cause

Usually, this is due to a critical system process failing during boot. You can read more about critical process issues at "[Bug Check 0xEF: CRITICAL_PROCESS_DIED](/windows-hardware/drivers/debugger/bug-check-0xef--critical-process-died)".

## Solution

### Process Overview

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

1. Create and Access a Repair VM.
2. Fix any OS Corruption.
3. **Recommended**: Before you rebuild the VM, enable serial console and memory dump collection.
4. Rebuild the VM.

> [!NOTE]
> When encountering this boot error, the Guest OS is not operational. You will be troubleshooting in Offline mode to resolve this issue.

### Create and Access a Repair VM

1. Use [steps 1-3 of the VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md) to prepare a Repair VM.
2. Using Remote Desktop Connection connect to the Repair VM.

### Fix any OS Corruption

1. Open an elevated command prompt.
2. Run the following System File Checker (SFC) command:

   `sfc /scannow /offbootdir=<BOOT DISK DRIVE>:\ /offwindir=<BROKEN DISK DRIVE>:\windows`

   * Where `<BOOT DISK DRIVE>` is the boot partition of the broken VM, and `<BROKEN DISK DRIVE>` is the OS partition of the broken VM. Replace the greater than / less than symbols as well as the text contained within them, e.g. "< text here >", with the appropriate letter.

3. Next, use [step 5 of the VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to reassemble the VM and see if it boots.
4. If the VM is still not booting, then continue to collect the memory dump file.

### Collect the memory dump file

If the issue persists after running SFC, analysis of a memory dump file will be required to determine the cause of the issue. To collect the memory dump file, follow these steps:

#### Step 1: Locate the dump file and submit a support ticket

[!INCLUDE [Collect OS Memory Dump File](../../../includes/azure/collect-os-memory-dump-file.md)]

If you can't find the dump file, go to the next steps to enable the dump log and the serial console, and then reproduce the issue.

#### Step 2: Enable the dump log and the serial console

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

To enable the dump log and the serial console, follow these steps:

[!INCLUDE [Enable Serial Console and Memory Dump Collection](../../../includes/azure/enable-serial-console-memory-dump-collection.md)]


### Recommended: Before you rebuild the VM, enable Serial Console and memory dump collection

To enable Serial Console and memory dump collection, follow these steps:

[!INCLUDE [Enable Serial Console and Memory Dump Collection](../../../includes/azure/enable-serial-console-memory-dump-collection.md)]

### Rebuild the Original VM

Use [step 5 of the VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to reassemble the VM.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
