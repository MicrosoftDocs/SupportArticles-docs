---
title: Azure VM resource move fails because proximity placement group constraints are incompatible
description: Troubleshoot Azure VM move failures caused by proximity placement group constraints. Follow these steps to verify destination support and resolve placement issues.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/14/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Fix Azure virtual machine move errors from proximity placement groups

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article helps you troubleshoot Azure VM move failures caused by proximity placement group constraints. Use the resolution steps to verify destination support, choose a migration pattern, and confirm latency after the move.

## Symptoms

Move validation fails for VMs that are associated with a proximity placement group, or VM placement behavior changes after a move and affects latency-sensitive workloads.

The following error messages indicate proximity placement group constraints.

```output
MoveNotSupportedForResourceType
```

```output
The requested VM placement cannot be satisfied.
```

## Cause

Proximity placement groups optimize colocation and low latency by constraining placement. Not all move paths automatically preserve proximity placement group associations. Destination capacity or constraints can block equivalent placement.

## Resolution

### Step 1: Detect proximity placement group association

Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to detect proximity placement group association.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>"
$vm.ProximityPlacementGroup
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm show --resource-group "<rg-name>" --name "<vm-name>" \
  --query "proximityPlacementGroup.id"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Virtual machines**, and then select your VM.
1. On the **Overview** page, check the **Proximity placement group** field. If a value is displayed, the VM is associated with a proximity placement group.

For more information, see [Proximity placement groups](/azure/virtual-machines/co-location).

---

### Step 2: Verify destination support and capacity

Verify that the destination region and scope support the required VM sizes and proximity placement groups-based placement.

### Step 3: Choose migration pattern

- If supported - Include proximity placement groups dependencies in the move plan.
- If not supported - Perform staged migration and re-create proximity placement groups-aligned deployment at the destination.

### Step 4: Verify latency and performance

After the move, run workload latency checks to verify that the placement objective is met.

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Move blocked by unavailable VM size at destination](move-resources-resize-blocked-disk-constraints.md)
- [Proximity placement groups](/azure/virtual-machines/co-location)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
