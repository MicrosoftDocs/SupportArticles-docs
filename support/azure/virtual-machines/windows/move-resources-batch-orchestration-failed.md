---
title: Azure resource move fails after provider operations succeed with batch orchestration error
description: Troubleshoot Azure resource move failures when provider operations succeed but batch orchestration fails. Follow these steps to diagnose and resolve the error.
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

# Azure resource move fails after provider operations succeed with batch orchestration error

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs :heavy_check_mark: All resource types moved in batches

## Summary

This article explains how to troubleshoot Azure resource move failures that occur after individual provider operations succeed, but the batch orchestration job fails because of coordination problems.

## Symptoms

A move operation fails and returns an error message that resembles the following example:

```output
ResourceMoveFailed: All move in provider succeeded. However, the batch move job failed.
The correlation id is '<correlation-id>'.
```

This error is unusual. The individual resource providers, such as Microsoft.Compute and Microsoft.Network, all complete their move operations. However, the batch orchestration layer fails to coordinate the overall move.

## Cause

This error occurs when one of the3 following conditions is true:

- **Dependency ordering violated** - You move resources out of the correct dependency order. For example, you move a virtual machine (VM) before its network adapter.
- **Metadata synchronization failure** - You relocate resources, but Azure can't synchronize metadata across regions or subscriptions.
- **Post-move validation failed** - You establish resources, but cross-resource validation, such as linking or references, fails.
- **Transient platform issue** - The batch coordinator service encounters a transient error after provider operations finish.
- **Resource reference loop** - Circular dependencies or unresolved references exist between moved resources.
- **Parent-child orchestration** - You move child resources before parent resources, or you don't update parent dependencies.

## Resolution

### Determine which diagnostic path to follow

Use the following table to choose your diagnostic path based on the error details and move complexity.

| Condition | Recommended path |
|---|---|
| Error message names a specific resource | [Step 1](#step-1-identify-which-resources-moved-and-which-failed)-[Step 3](#step-3-handle-partially-moved-state) - Fix that resource blocker, then use Azure Resource Mover |
| Error message is generic (no resource named) | [Step 5](#step-5-use-azure-resource-mover) - Use Azure Resource Mover immediately |
| Fewer than five resources in the move | [Step 1](#step-1-identify-which-resources-moved-and-which-failed)-[Step 3](#step-3-handle-partially-moved-state) for diagnosis, and then use Azure Resource Mover |
| 5-20 resources in the move | [Step 5](#step-5-use-azure-resource-mover) - Use Azure Resource Mover (too complex for manual ordering) |
| More than 20 resources in the move | [Step 5](#step-5-use-azure-resource-mover) - Use Azure Resource Mover (manual ordering can't detect soft or circular dependencies) |
| You didn't map all resource dependencies | [Step 5](#step-5-use-azure-resource-mover) - Azure Resource Mover maps dependencies automatically |

### Step 1: Identify which resources moved and which failed

Use the correlation ID from the error message to identify what happened to each resource.

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to query the activity log for the correlation ID.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Resource groups**, and then select the **source** resource group.
1. Select **Activity log** and filter by the correlation ID from the error message.
1. Review which operations succeeded, failed, or are still in progress.
1. Go to the **destination** resource group and check whether any resources arrived.

For more information, see [Manage resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$correlationId = "<correlation-id-from-error>"

# Check activity log for move operations with this correlation ID
Get-AzActivityLog -StartTime (Get-Date).AddHours(-4) |
  Where-Object { $_.CorrelationId -eq $correlationId } |
  Select-Object EventTimestamp, ResourceId, OperationName, ActivityStatus |
  Format-Table -Wrap
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az monitor activity-log list \
  --correlation-id "<correlation-id-from-error>" \
  --query "[].{Time:eventTimestamp, Resource:resourceId, Op:operationName.value, Status:status.value}" \
  --output table
```

---

### Step 2: Check whether resources are in an inconsistent state

Some resources might be partially moved. You can delete a resource from the source, but not fully create it in the destination.

Use the Azure portal, Azure PowerShell, or Azure CLI to compare the source and destination resource groups.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, open the **source** resource group and note the resources that remain.
1. Open the **destination** resource group and note which resources arrived.
1. Compare the two lists. Resources that appear in both groups, or resources that are missing from both, indicate a partial move.

For more information, see [Manage resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$sourceRg = "<source-rg>"
$destRg = "<destination-rg>"
$destSub = "<destination-sub>"

# Check which resources remain in source
$sourceResources = Get-AzResource -ResourceGroupName $sourceRg

# Check which exist in destination
$destResources = Get-AzResource -ResourceGroupName $destRg -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

Write-Host "Resources still in source: $($sourceResources.Count)"
Write-Host "Resources in destination: $($destResources.Count)"

# Find orphaned or partially moved resources
$sourceResources | ForEach-Object {
  $src = $_
  $inDest = $destResources | Where-Object { $_.Name -eq $src.Name -and $_.ResourceType -eq $src.ResourceType }
  if (-not $inDest) {
    Write-Host "PARTIAL: $($src.Name) [$($src.ResourceType)] is still in source only"
  }
}
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
# List resources in source
az resource list --resource-group "<source-rg>" \
  --query "[].{Name:name, Type:type, State:provisioningState}" --output table

# List resources in destination
az resource list --resource-group "<destination-rg>" \
  --query "[].{Name:name, Type:type, State:provisioningState}" --output table
```

---

Compare the two outputs. Resources that appear in only one group indicate a partial move.

### Step 3: Handle partially moved state

If resources exist in both the source and destination resource groups, choose one of the following options to resolve the inconsistency.

**Option A: Complete the move manually**

Verify that the destination resources are healthy. If they're in a `Succeeded` state, you can safely delete the source copies.

Use the Azure portal, Azure PowerShell, or Azure CLI to check the provisioning state of each resource in the destination resource group.

# [Azure portal](#tab/portal)

Follow these steps:

1. Go to **Resource groups** > destination resource group.
1. Review each resource's **Provisioning state**. If all show `Succeeded`, the move completed.
1. Go to the source resource group and delete the duplicate resources manually.

For more information, see [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).

# [Azure PowerShell](#tab/powershell)

Run these commands.

```azurepowershell
# Verify destination resources are healthy
$destResources | ForEach-Object {
  $resource = Get-AzResource -ResourceId $_.ResourceId -ErrorAction SilentlyContinue
  if ($resource.ProvisioningState -ne "Succeeded") {
    Write-Host "WARNING: $($_.Name) not fully provisioned: $($resource.ProvisioningState)"
  }
}

# If destination resources are good, delete source copies
$sourceResources | ForEach-Object {
  $src = $_
  $destExists = $destResources | Where-Object { $_.Name -eq $src.Name -and $_.ResourceType -eq $src.ResourceType }
  if ($destExists) {
    $destReady = $destExists | Where-Object { $_.ProvisioningState -eq "Succeeded" }
    if ($destReady) {
      Write-Host "Cleaning up source: $($src.Name) [$($src.ResourceType)]"
      Remove-AzResource -ResourceId $src.ResourceId -Force
    } else {
      Write-Host "SKIP: Destination resource exists but is not Succeeded for $($src.Name) [$($src.ResourceType)]"
    }
  }
}
```

# [Azure CLI](#tab/cli)

Run these commands.

```azurecli
# Verify destination resources
az resource list --resource-group "<destination-rg>" \
  --query "[].{Name:name, Type:type, State:provisioningState}" --output table

# If all Succeeded, delete source duplicates
az resource delete --ids "<source-resource-id>"
```

---

**Option B: Roll back to source only**

If the destination resources aren't healthy, delete the incomplete destination copies, and then retry the move by using a smaller batch.

Use Azure PowerShell or Azure CLI to delete the incomplete destination resources.

# [Azure portal](#tab/portal)

Rolling back a partial move by deleting incomplete destination resources and retrying with smaller batches isn't available in the Azure portal. To clean up and retry with scripted batch control, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run this command.

```azurepowershell
# Delete incomplete destination resources
$destResources | ForEach-Object {
  Remove-AzResource -ResourceId $_.ResourceId -Force
}
```

# [Azure CLI](#tab/cli)

Run this command.

```azurecli
# Delete incomplete destination resources
az resource delete --ids "<destination-resource-id>"
```

---

Retry the move with a smaller batch (five resources at a time).

### Step 4: Diagnose with manual inspection

> [!IMPORTANT]
> Use this step for diagnosis only. After you identify the blocker, use Azure Resource Mover in [Step 5](#step-5-use-azure-resource-mover) to perform the move.

Check for the following conditions:

- A specific resource can't move (for example, a VM extension is in failed state). Fix that blocker, and then use Azure Resource Mover.
- The destination resource group has management locks or policies. Remove them, and then use Azure Resource Mover.
- A resource exists in both source and destination (partial move). Decide whether to keep the destination copy or roll back to the source, and then use Azure Resource Mover to finish cleanly.

If you don't find a specific blocker, skip directly to [Step 5](#step-5-use-azure-resource-mover). Azure Resource Mover provides better diagnostics than manual inspection, and detects soft dependencies that manual methods can't find.

> [!WARNING]
> Don't try to manually reorder and move resources by using custom scripts. Azure has more than 200 resource types, each with unique dependency rules. Custom scripts can't detect circular or soft dependencies such as managed identity role assignments. This limitation causes partial failures and a corrupted state.

### Step 5: Use Azure Resource Mover

Always use Azure Resource Mover for multi-resource moves. Azure Resource Mover automatically performs the following tasks:

- Detects all dependency chains
- Validates resources before the move starts
- Respects soft dependencies such as role assignments and service endpoints
- Provides detailed error reporting for each resource
- Rolls back cleanly if any resource fails
- Handles resource type specifics without hard-coding

Use the Azure portal, Azure PowerShell, or Azure CLI to create a move collection and move resources.

# [Azure portal](#tab/portal)

1. In the Azure portal, search for **Azure Resource Mover**.
1. Select **Create move collection** and specify the source and target regions.
1. Add the resources to move. Azure Resource Mover auto-resolves dependencies.
1. Select **Validate** to check for issues before the move starts.
1. Select **Prepare**, and then **Commit** to complete the move.

For more information, see [Move Azure VMs to another region](/azure/resource-mover/tutorial-move-region-virtual-machines).

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
# Create a Resource Mover collection
$collection = New-AzResourceMoverMoveCollection `
  -Name "move-$(Get-Date -Format 'yyyyMMddHHmm')" `
  -ResourceGroupName "resource-mover-rg" `
  -SourceRegion $sourceRegion `
  -TargetRegion $destRegion

# Add resources (auto-resolves dependencies)
$resources = Get-AzResource -ResourceGroupName $sourceRg
foreach ($r in $resources) {
  Add-AzResourceMoverMoveCollectionSourceResource -MoveCollectionName $collection.Name `
    -ResourceGroupName "resource-mover-rg" `
    -SourceId $r.ResourceId
}

# Validate, prepare, and commit
Invoke-AzResourceMoverMoveCollectionValidation -MoveCollectionName $collection.Name `
  -ResourceGroupName "resource-mover-rg"

Invoke-AzResourceMoverMoveCollectionPrepare -MoveCollectionName $collection.Name `
  -ResourceGroupName "resource-mover-rg"

Invoke-AzResourceMoverMoveCollectionCommit -MoveCollectionName $collection.Name `
  -ResourceGroupName "resource-mover-rg"
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
# Create a Resource Mover collection
az resource-mover move-collection create \
  --move-collection-name "move-collection-01" \
  --resource-group "resource-mover-rg" \
  --source-region "<source-region>" \
  --target-region "<target-region>"

# Add resources and initiate the move
az resource-mover move-resource add \
  --move-collection-name "move-collection-01" \
  --resource-group "resource-mover-rg" \
  --source-id "<resource-id>"
```

---

### Step 6: Check network connectivity during the move

Batch move failures can occur when network issues happen during the operation.

Use Azure PowerShell or Azure CLI to check the activity log for move operation errors.

# [Azure portal](#tab/portal)

You can't query activity logs for move operation errors that happen during a batch move in the Azure portal. To filter activity logs for move failures, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzActivityLog -StartTime (Get-Date).AddHours(-1) |
  Where-Object { $_.OperationName.Value -like "*MoveResources*" -and $_.Level -eq "Error" } |
  Select-Object ActivityStatus, OperationName, ResourceType, Message
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az monitor activity-log list \
  --start-time $(date -u -d '1 hour ago' '+%Y-%m-%dT%H:%M:%SZ') \
  --query "[?contains(operationName.value, 'MoveResources') && level=='Error'].{Status:status.value, Op:operationName.value, Message:properties.statusMessage}" \
  --output table
```

---

### Step 7: Retry the move with logging enabled

If the error is transient, retry the move with verbose diagnostics enabled.

Use Azure PowerShell or Azure CLI to retry the move and capture detailed logs.

# [Azure portal](#tab/portal)

You can't retry a move operation with verbose ARM debug logging enabled in the Azure portal. To capture detailed move diagnostics, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$DebugPreference = "Continue"
Move-AzResource -DestinationResourceGroupName $destRg `
  -DestinationSubscriptionId $destSub `
  -ResourceId $resourceIds `
  -Verbose 4>&1 | Tee-Object -FilePath "move-retry.log"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource move --destination-group "<dest-rg>" \
  --ids "<resource-id>" \
  --debug 2>&1 | tee move-retry.log
```

---

### Prevention

Ensure that you take the following preventative measures:

- **Use Azure Resource Mover** - For multi-resource moves, avoid the raw `moveResources` API.
- **Move in batches** - Split large moves into 10-20 resources per operation.
- **Respect dependencies** - Always move parent resources before children.
- **Monitor orchestration** - Use correlation IDs to track which resources moved and which failed.
- **Test first** - Verify by using a small subset before a full production move.

## References

- [Use Azure Resource Mover for complex moves](/azure/resource-mover/tutorial-move-region-virtual-machines)
- [Manage resource dependencies during move](/azure/azure-resource-manager/management/move-resources-overview)
- [Troubleshoot batch operation failures](/azure/azure-resource-manager/troubleshooting)
- [Azure resource move fails with ResourcesBeingMoved because resource group is updating](move-resources-resources-moved-resource-group-update.md)
- [Azure resource move fails with RequestConflict because provisioning state is not terminal](move-resources-request-conflict-provisioning-state-not-terminal.md)
- [Azure resource move fails with InternalServerError or empty BadRequest message](move-resources-internalservererror-empty-badrequest.md)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
