---
title: Azure VM cannot RDP - working on features
description: Troubleshoot Azure VM cannot RDP - working on features.
ms.date: 06/13/2024
ms.reviewer: trmaier, v-weizhu
ms.service: virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---

# Azure VM cannot RDP - working on features

## Symptoms

1. When you pull the screenshot of the VM, the screenshot shows the message:

   - Working on features
   - ##% complete
   - Don't turn off your computer

   :::image type="content" source="media/azure-vm-cannot-rdp-working-features/working-on-features-error-message.png" alt-text="Screenshot of the Working on features error message.":::

## Cause

A role or feature was added or removed from Windows.

## Solution

Refresh the screenshot in boot diagnostics a few times to monitor if there's any progress or if the VM is stuck. Only intercede if the machine is indeed stuck otherwise, you could break the role/feature further.

### Process overview

1. [Create and Access a repair VM](#1)
2. [Use DISM to rollback the change](#2)
3. [Enable Serial Console and Memory Dump Collection](#3)
4. [Rebuild the VM](#4)

### Create and access a repair VM<a id="1"></a>

1. Use [steps 1-3 of the VM repair commands](repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to prepare a repair VM.
2. Use Remote Desktop Connection connect to the repair VM.

### Use DISM to roll back the change<a id="2"></a>

1. To determine the changes that the machine is trying to apply, check the `setup.evtx` logs and look for events `ID: 7` as seen in this example:

   (these logs are located at `<drive letter>:\Windows\System32\winevt\Logs\Setup.evtx`)

   ```ps
   Time: 4/27/2020 6:16:51 AM
   ID: 7
   Level:Information
   Source: Microsoft-Windows-Servicing
   Machine: hostname.domain
   Message: Initiating changes to turn on update EnhancedStorage of package Enhanced Storage. Client id: DISM Package Manager Provider.
   ```

2. From this event, you will get the package name and then using DISM tool, you could remove it:

   ```ps
   Dism /Image:<OS Disk letter>:\ /Disable-Feature /FeatureName:<<Feature to remove>>
   ```

   For The example above, the syntax would be:

   ```ps
   Dism /Image:G:\ /Disable-Feature /FeatureName:EnhancedStorage
   ```

### Enable the Serial Console and memory dump collection<a id="3"></a>

**Recommended**: Before you rebuild the VM, enable the Serial Console and memory dump collection by following these steps:

[!INCLUDE [Enable Serial Console and Memory Dump Collection](../../../includes/azure/enable-serial-console-memory-dump-collection.md)]

### Rebuild the VM<a id="4"></a>

Use [step 5 of the VM repair commands](repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to reassemble the VM.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
