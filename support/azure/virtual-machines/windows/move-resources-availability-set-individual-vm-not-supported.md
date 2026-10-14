---
title: Azure VM resource move isnt supported in an availability set
description: Troubleshoot an Azure VM resource move failure for a single virtual machine in an availability set. Learn supported migration options and next steps.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/03/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine resource move isn't supported in an availability set

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains how to troubleshoot an Azure virtual machine (VM) resource move failure when you try to move a single VM out of an availability set without its full dependency set. Use the supported migration options to choose an appropriate next step.

## Symptoms

A move validation fails if you try to move one virtual machine that belongs to an availability set.

Common patterns include the following error messages.

```output
Virtual machines in an availability set can't be moved individually.
```

```output
MoveNotSupportedForResourceType
```

## Cause

An availability set is a placement construct that groups multiple VMs together for fault domain and update domain distribution. Azure Resource Manager (ARM) doesn't support moving an individual VM out of that grouped topology through a standard move operation.

## Resolution

### Step 1: Verify that the VM belongs to an availability set

Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to check whether the VM belongs to an availability set.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>"
$vm.AvailabilitySetReference
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm show --resource-group "<rg-name>" --name "<vm-name>" \
  --query "availabilitySet.id"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Virtual machines**, and then select your VM.
1. On the **Overview** page, check the **Availability set** field. If a value is displayed, the VM belongs to an availability set.

For more information, see [Availability sets overview](/azure/virtual-machines/availability-set-overview).

---

### Step 2: Choose a supported VM migration path

Use one of the following supported methods:

- Move the full supported dependency set together, if the platform allows it.
- Recreate the VM outside the availability set in the destination.
- Rebuild the availability set topology in the destination, and migrate the workload there.

### Step 3: Verify the target high-availability design

Before the cutover, determine whether the destination should use:

- An availability set
- Availability zones
- Another resiliency pattern

## References

- [Move blocked by availability set and zone constraints](move-resources-availability-set-zonal-constraint.md)
- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Support for Availability sets](virtual-machines-availability-set-supportability.md)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
