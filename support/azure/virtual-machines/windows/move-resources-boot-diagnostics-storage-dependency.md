---
title: Azure VM resource move fails because boot diagnostics storage dependencies are unresolved
description: Resolve Azure VM move failures caused by boot diagnostics storage dependencies. Follow these steps to restore serial console and screenshot diagnostics.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/04/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine resource move fails because boot diagnostics storage dependencies are unresolved

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains how to troubleshoot Azure virtual machine (VM) resource move operations that fail because of unresolved boot diagnostics storage dependencies. It also provides guidance about how to align the boot diagnostics configuration with the destination environment to ensure successful moves and continued diagnostics functionality.

## Symptoms

A move validation fails because the VM references diagnostics storage resources that aren't included or supported in the destination. In other cases, the move finishes, but serial console or screenshot diagnostics stop working.

## Cause

Boot diagnostics can depend on managed storage configuration, storage account access, and networking settings that the selected move path doesn't preserve.

## Resolution

### Step 1: Check the current boot diagnostics configuration

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to check whether the VM uses managed boot diagnostics or a custom storage account.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the VM.
1. In the menu, in **Help**, select **Boot diagnostics**.
1. Review whether the VM uses managed storage or a custom storage account.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzVM -ResourceGroupName "<resource-group-name>" -Name "<vm-name>" `
  | Select-Object -ExpandProperty DiagnosticsProfile `
  | ConvertTo-Json -Depth 3
```

If `storageUri` is empty or null, the VM uses managed boot diagnostics. If `storageUri` contains a storage account URI, the VM uses a custom storage account.

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm show \
  --resource-group <resource-group-name> \
  --name <vm-name> \
  --query "diagnosticsProfile.bootDiagnostics"
```

---

If `storageUri` is empty or null, the VM uses managed boot diagnostics. If `storageUri` contains a storage account URI, the VM uses a custom storage account.

### Step 2: Identify storage dependencies

Check whether the VM uses:

- Managed boot diagnostics
- A custom storage account for boot diagnostics

### Step 3: Align diagnostics strategy with destination

Use the Azure portal, Azure PowerShell, or Azure CLI to align the boot diagnostics configuration before or after the move.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to the VM.
1. Select **Boot diagnostics** > **Settings**.
1. Select **Enable with managed storage account** to switch to managed boot diagnostics before the move.

# [Azure PowerShell](#tab/powershell)

To switch to managed boot diagnostics before the move, run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<resource-group-name>" -Name "<vm-name>"
Set-AzVMBootDiagnostic -VM $vm -Enable
Update-AzVM -ResourceGroupName "<resource-group-name>" -VM $vm
```

# [Azure CLI](#tab/cli)

To switch to managed boot diagnostics before the move, run the following command.

```azurecli
az vm boot-diagnostics enable \
  --resource-group <resource-group-name> \
  --name <vm-name>
```

---

### Step 4: Verify serial console and screenshot capture

After the move finishes, verify that diagnostics capture and serial console access work correctly.

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Move blocked by destination Azure Policy](move-resources-destination-policy-deny.md)
- [Boot diagnostics for Azure virtual machines](/azure/virtual-machines/boot-diagnostics)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
