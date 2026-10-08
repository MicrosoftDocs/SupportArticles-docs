---
title: Azure VM resource move fails because reservation or capacity association assumptions don't hold at destination
description: Troubleshoot Azure VM move failures caused by reservation or capacity mismatches at the destination, and use this guide to validate capacity pre-move.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/15/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine resource move fails because reservation or capacity association assumptions don't hold at destination

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains how to troubleshoot Azure virtual machine (VM) resource move failures that occur when reservation or capacity association assumptions don't hold at the destination. It provides steps to capture current sizing and capacity assumptions, validate destination capacity, and build fallback options to ensure successful post-move deployment.

## Symptoms

A move validates initially, but deployment or workload readiness fails because the destination doesn't provide the expected compute capacity or reservation-aligned footprint.

## Cause

Reserved capacity, capacity planning, and placement assumptions don't move as resource metadata in a manner that guarantees destination availability. This condition can cause allocation failures or unsupported sizing after migration.

## Resolution

### Step 1: Capture current sizing and capacity assumptions

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to capture the current sizing and capacity assumptions for the VM.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the VM.
1. Select **Size** to review the current VM size and family.
1. Note the availability zone and any placement constraints.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzVM -ResourceGroupName "<resource-group-name>" -Name "<vm-name>" |
  Select-Object Name, @{N='Size';E={$_.HardwareProfile.VmSize}}, Location, Zones
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm show \
  --resource-group <resource-group-name> \
  --name <vm-name> \
  --query "{name:name, size:hardwareProfile.vmSize, location:location, zones:zones}" \
  --output table
```

---

### Step 2: Verify destination capacity explicitly

Before the move, use the Azure portal, Azure PowerShell, or Azure CLI to verify that the destination region or zone has available capacity for the VM family and deployment pattern.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to the destination subscription.
1. Search for **Quotas** and select **Compute**.
1. Filter by the target region and VM family to check available capacity.

# [Azure PowerShell](#tab/powershell)

Run this command.

```azurepowershell
Get-AzVMUsage -Location "<destination-region>" |
  Where-Object { $_.Name.Value -like "*<vm-family>*" } |
  Format-Table @{N='Name';E={$_.Name.LocalizedValue}}, CurrentValue, Limit
```

# [Azure CLI](#tab/cli)

Run this command.

```azurecli
az vm list-usage \
  --location <destination-region> \
  --query "[?contains(localName, '<vm-family>')].{name:localName, current:currentValue, limit:limit}" \
  --output table
```

---

### Step 3: Build fallback options

Prepare one or more of the following alternatives:

- Secondary compatible size
- Alternative zone
- Staged redeployment window

### Step 4: Verify workload startup after move

Verify allocation, startup, and application capacity behavior after the move.

## References

- [Move blocked by unavailable virtual machine size at destination](move-resources-resize-blocked-disk-constraints.md)
- [Move blocked by availability set and zone constraints](move-resources-availability-set-zonal-constraint.md)
- [On-demand capacity reservation overview](/azure/virtual-machines/capacity-reservation-overview)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
