---
title: Azure VM move operation times out after four hours
description: Learn how to fix Azure VM move operation timeouts that exceed four hours, identify partially moved resources, and complete the move successfully.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/11/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine move operation times out after four hours

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary    

This article helps you troubleshoot Azure virtual machine (VM) move operations that exceed the four-hour timeout limit. This article includes guidance to identify partially moved resources, and strategies to complete the move successfully.

## Symptoms

A move operation fails and returns an error message that resembles the following example.

```
ResourceMoveTimedOut: Moving resources did not finish within allowed time '04:00:00'. Provisioning state of the resource group is 'Updating'.
```

The move is canceled even though the operation previously validated individual resources.

## Cause

Azure Resource Manager (ARM) enforces a four-hour timeout on move operations. This limit applies to the entire operation, including the following items:

- Dependency validation
- Resource state transitions
- Lock acquisitions and releases
- Metadata synchronization across Azure regions (for region moves)
- Cleanup of source resources after the move

Timeouts commonly occur with the following conditions:

- Large numbers of dependent resources (100 or more resources)
- Cross-subscription or cross-region moves
- Resources that have complex networking topologies
- Moves that require replication or data transfer

## Resolution

### Step 1: Check what moved before the timeout

Use Azure PowerShell or Azure CLI to query which resources successfully moved before the operation timed out.

# [Azure portal](#tab/portal)

Comparing resources across source and destination resource groups to determine which resources moved before the timeout isn't available in the [Azure portal](https://portal.azure.com). To query and compare both groups, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzResourceMoverMoveCollection -Name "<collection-name>" -ResourceGroupName "<rg-name>" |
  Select-Object -ExpandProperty Resources |
  Where-Object { $_.ProvisioningState -eq "Succeeded" } |
  Select-Object Id, ResourceType
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource list --resource-group "<source-rg>" \
  --query "[].{Name:name, Type:type, State:provisioningState}" --output table

az resource list --resource-group "<destination-rg>" \
  --query "[].{Name:name, Type:type, State:provisioningState}" --output table
```

Compare the two outputs to determine which resources moved successfully.

---

### Step 2: Identify partially moved resources

Resources that are left in an incomplete state require explicit cleanup or a retry. Use Azure PowerShell or Azure CLI to identify and manage these resources.

# [Azure portal](#tab/portal)

Querying for partially moved resources in an intermediate provisioning state isn't available in the Azure portal. To identify resources that are stuck between source and destination, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzResourceMoverMoveCollection -Name "<collection-name>" -ResourceGroupName "<rg-name>" |
  Select-Object -ExpandProperty Resources |
  Where-Object { $_.ProvisioningState -ne "Succeeded" -and $_.ProvisioningState -ne "Failed" } |
  Select-Object Id, ProvisioningState
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource list --resource-group "<source-rg>" \
  --query "[?provisioningState!='Succeeded' && provisioningState!='Failed'].{Name:name, Type:type, State:provisioningState}" --output table
```

---

### Step 3: Move resources in smaller batches

Use Azure PowerShell or Azure CLI to split the move into smaller batches to stay within the timeout period.

#### [Azure portal](#tab/portal)

Moving resources in scripted batches with custom batch sizes isn't available in the Azure portal. To split large moves into smaller groups that stay within the timeout limit, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$resources = @("/subscriptions/.../vms/vm1", "/subscriptions/.../vms/vm2")
$batch1 = $resources[0..4]  # First 5 resources
$batch2 = $resources[5..9]  # Second 5 resources

# Move batch 1
Move-AzResource -DestinationResourceGroupName "<dest-rg>" -ResourceId $batch1

# Move batch 2 after first batch completes
Move-AzResource -DestinationResourceGroupName "<dest-rg>" -ResourceId $batch2
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
# Move batch 1 (first 5 resources)
az resource move --destination-group "<dest-rg>" \
  --ids "/subscriptions/.../vms/vm1" "/subscriptions/.../vms/vm2"

# Move batch 2 after first batch completes
az resource move --destination-group "<dest-rg>" \
  --ids "/subscriptions/.../vms/vm3" "/subscriptions/.../vms/vm4"
```

---

### Step 4: Prioritize dependencies

Move resources in dependency order, starting with networking resources. Then, determine the order of the following items:

- Virtual networks, subnets
- Network security groups, route tables
- Public IPs, load balancers
- Network adapters
- VM

### Step 5: Monitor and extend if possible

For large moves, use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to interact with Azure Resource Mover to handle staging and batching.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for **Azure Resource Mover**.
1. Select **Create move collection**.
1. Add your resources and follow the guided staging workflow.

For more information, see [Azure Resource Mover overview](/azure/resource-mover/overview).

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
New-AzResourceMoverMoveCollection -Name "<collection>" -ResourceGroupName "<rg>" -SourceRegion "<source>" -TargetRegion "<target>"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource-mover move-collection create \
  --move-collection-name "<collection>" \
  --resource-group "<rg>" \
  --source-region "<source>" \
  --target-region "<target>"
```

---

### Prevention

Use the following list to prevent common issues during large resource moves.

- **Batch moves** - Always split large migrations into 20-50 resource chunks.
- **Pre-validate** - Use Resource Mover's validation phase before you commit to a move.
- **Schedule off-peak** - Perform moves during low-activity windows to reduce platform contention.
- **Monitor parallelism** - ARM serializes some operations. Expect four or more hours for 200 or more VMs that have dependencies.

## References

- [Move virtual machines to another subscription or resource group](/azure/azure-resource-manager/management/move-resources-overview)
- [Use Resource Mover for complex multi-region operations](/azure/resource-mover/overview)
- [Understand provisioning states during resource moves](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
