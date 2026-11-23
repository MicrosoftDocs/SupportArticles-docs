---
title: Azure VM resource move fails because Azure Ultra Disk or Azure Premium SSD v2 isn't supported at destination
description: Learn why an Azure VM resource move fails when Ultra Disk or Premium SSD v2 isn't supported in the destination region or zone. Follow the steps to resolve it.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/18/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine resource move fails because Azure Ultra Disk or Azure Premium SSD v2 isn't supported at destination

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

An Azure VM resource move fails when Ultra Disk or Premium SSD v2 isn't supported in the destination region or zone. This article explains how to verify destination support and choose a mitigation.

## Symptoms

Move validation fails for VMs that use Ultra Disk-managed or Premium SSD v2-managed disks.

The following examples show the kind of error message you might encounter:

```output
OperationNotAllowed
```

```output
The selected disk SKU isn't supported in the destination region or zone.
```

## Cause

Storage support varies by region, zone, and VM series. Even if the VM size is available, the destination might not support the attached disk capabilities.

## Resolution

### Step 1: Identify the disk SKUs in use

Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to identify the disk SKUs in use by the VM.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>"
$vm.StorageProfile.DataDisks | Select-Object Name, ManagedDisk
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm show --resource-group "<rg-name>" --name "<vm-name>" \
  --query "storageProfile.dataDisks[].{Name:name, DiskId:managedDisk.id}"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Virtual machines**, and then select the VM.
1. In the menu, in **Settings**, select **Disks**.
1. Review the **SKU** column for each data disk. Check whether any disk uses **Ultra Disk** or **Premium SSD v2**.

---

For more information, see [Azure managed disk types](/azure/virtual-machines/disks-types).

### Step 2: Verify destination support for Ultra Disk and Premium SSD v2

Verify that the destination supports the following features:

- Ultra Disk
- Premium SSD v2
- Required VM series support for the attached storage type

### Step 3: Choose a mitigation option

If support is missing, consider the following options:

- Resize to a compatible storage tier before move.
- Choose a different destination.
- Rebuild the workload that includes supported storage at destination.

## References

- [Move blocked by unavailable VM size at destination](move-resources-resize-blocked-disk-constraints.md)
- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Azure managed disk types](/azure/virtual-machines/disks-types)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
