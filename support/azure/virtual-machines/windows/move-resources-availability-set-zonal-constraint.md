---
title: Azure VM resource move fails because availability set and zone constraints are incompatible
description: Learn how to fix Azure VM resource move failures caused by incompatible availability set or zone constraints. Follow the steps to complete your migration.
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

# Azure virtual machine resource move fails because availability set and zone constraints are incompatible

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article discusses how to troubleshoot move failures if the destination constraints for availability sets or availability zones don't match the source virtual machine (VM) deployment model.

## Symptoms

Move validation or deployment finalization fails if the VM availability topology isn't supported in the destination scope.

Example patterns include the following.

```output
OperationNotAllowed
```

```output
The requested configuration is not supported for availability set or zone placement.
```

## Cause

Availability sets and availability zones follow different placement models. A move can fail if the destination environment doesn't support equivalent topology or if constraints conflict with the target region capabilities.

## Resolution

### Step 1: Identify the source placement model

Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to determine whether the VM uses an availability set or zone assignment.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>"
$vm.AvailabilitySetReference
$vm.Zones
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm show --resource-group "<rg-name>" --name "<vm-name>" \
  --query "{AvailabilitySet:availabilitySet.id, Zones:zones}"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Virtual machines**, and then select your VM.
1. On the **Overview** page, check the **Availability zone** and **Availability set** fields. These values indicate the placement model for the VM.

For more information, see [What are availability zones?](/azure/reliability/availability-zones-overview) and [Availability sets overview](/azure/virtual-machines/availability-set-overview).

---

### Step 2: Verify destination region support for VM topology

Verify that the destination region and resource group can host the same model and SKU.

### Step 3: Choose a supported target availability pattern

If direct parity isn't available:

- Recreate the VM in a compatible topology.
- Adjust the high-availability model for the destination.

### Step 4: Run the VM move or staged migration

Use a supported sequence, and then verify workload resilience after completion.

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Support for Availability sets](virtual-machines-availability-set-supportability.md)
- [Availability options for Azure virtual machines](/azure/virtual-machines/availability)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
