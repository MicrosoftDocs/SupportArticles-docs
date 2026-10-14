---
title: Azure resource move fails - 800 resource limit exceeded
description: Resolve Azure resource move failures caused by the 800-resource limit in Azure Resource Manager by using proven batching and recovery steps.
services: virtual-machines
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/03/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:Cannot create a VM
ai-usage: ai-assisted
---
# Azure resource move fails because the 800-resource limit is exceeded

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Summary

When an Azure resource move includes more than 800 resources in a single operation, it fails because of the platform limit. To complete the move successfully, divide the resources into smaller batches.

## Symptoms

When you try to move a large number of Azure resources to a different resource group or subscription in a single operation, the move fails immediately. You also receive an error message that states you included too many resources, or the operation times out.

## Cause

Azure Resource Manager (ARM) enforces a limit of 800 resources per move operation. If a single move request contains more than 800 resources, ARM generates an error immediately. Move operations that have 800 or fewer resources can also fail if they time out.

This limit applies at the subscription level. For more information, see [Subscription limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#subscription-limits).

## Resolution

Break the move into multiple smaller operations, each containing fewer than 800 resources. Consider the following methods.

### Option 1: Move resources in batches

Divide your resources into groups of fewer than 800, and run separate move operations for each group. Ensure that dependent resources, such as a virtual machine (VM) and its network adapter, are included in the same batch.

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to move resources in batches.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the source resource group.
1. Select the resources that you want to move (up to 800 per batch).
1. Select **Move** > **Move to another resource group** or **Move to another subscription**.
1. Select the destination, and then select **OK**.
1. Repeat for each batch.

# [Azure PowerShell](#tab/powershell)

Run this command. 

```azurepowershell
$resources = Get-AzResource -ResourceGroupName "<source-resource-group>"
$batch = $resources | Select-Object -First 800
Move-AzResource -DestinationResourceGroupName "<destination-resource-group>" `
  -ResourceId $batch.ResourceId
```

# [Azure CLI](#tab/cli)

Run this command. 

```azurecli
ids=$(az resource list --resource-group <source-resource-group> --query "[].id" -o tsv | head -800)
az resource move \
  --destination-group <destination-resource-group> \
  --ids $ids
```

---

### Option 2: Take a snapshot and re-create

If breaking the move into batches isn't practical, take snapshots of the VM disks, move the snapshots to the destination subscription, and re-create the VMs.

> [!NOTE]
> You can only move *full* snapshots between resource groups, subscriptions, or regions. *Incremental* snapshots aren't supported for cross-subscription or cross-region moves. For more information, see [Move operation support for Microsoft.Compute resources](/azure/azure-resource-manager/management/move-support-resources#microsoftcompute).

Follow these steps to move a VM by taking a snapshot and re-creating the VM:

1. Take a snapshot. For more information, see [Create a snapshot of a virtual hard disk](/azure/virtual-machines/snapshot-copy-managed-disk?tabs=portal).
1. Move the snapshot. For more information, see [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).
1. Create a VM from the snapshot (PowerShell). For more information, see [Create a virtual machine from a snapshot with PowerShell](/azure/virtual-machines/scripts/virtual-machines-linux-powershell-sample-create-vm-from-snapshot).
1. Create a VM from the snapshot (Azure CLI). For more information, see [Create a virtual machine from a snapshot with CLI](/azure/virtual-machines/scripts/create-vm-from-snapshot).

## References

- [Move Azure resources to a new resource group or subscription — FAQ](/azure/azure-resource-manager/management/move-resource-group-and-subscription#frequently-asked-questions)
- [Subscription and service limits, quotas, and constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits#subscription-limits)
