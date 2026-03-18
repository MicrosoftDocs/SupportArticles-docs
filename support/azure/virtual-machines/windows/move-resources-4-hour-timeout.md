---
title: Move operation times out after four hours
description: Troubleshoot the ResourceMoveTimedOut error when an Azure resource move operation exceeds the four-hour limit.
services: virtual-machines
author: scotro
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 03/18/2026
ms.author: scotro
ms.reviewer: jarrettr
ms.custom: sap:Cannot create a VM
---

# Move operation times out after four hours

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Symptoms

When you move Azure resources to another resource group or subscription, the operation fails after approximately four hours with an error similar to:

```json
{
  "statusCode": "Conflict",
  "statusMessage": "{\"error\":{\"code\":\"ResourceMoveTimedOut\",\"message\":\"Moving resources did not finish within allowed time '04:00:00'. Provisioning state of the resource groups will be rolled back.\"}}"
}
```

## Cause

Azure Resource Manager enforces a maximum duration of four hours for any move operation. During a move, both the source and destination resource groups are locked — write and delete operations are blocked until the move completes or times out.

When the four-hour limit is reached, ARM rolls back the provisioning state of both resource groups and releases all locks. The move is marked as failed.

Most move operations complete in less than 30 minutes. A timeout typically indicates that one resource provider involved in the move did not complete its notification within the allowed window.

> [!NOTE]
> While the source and destination resource groups are locked, the resources themselves are still operational. For example, a virtual machine continues to run and an application using a SQL database continues to read and write data. Only management-plane write/delete operations are blocked.

## Resolution

### Step 1: Check whether the move actually completed

Even after a timeout error, the underlying resources may have moved successfully. ARM may report a timeout while the operation continued to completion in the background.

Verify resource locations in the Azure portal:
1. Navigate to the **destination resource group**.
2. Confirm whether the resources appear there.
3. Also check the **source resource group** to see if the resources are still present.

If resources appear in the destination, the move succeeded despite the timeout message. No further action is needed.

### Step 2: Check for resources missing from either group

If resources appear in neither the source nor the destination, or if the move status remains in a failed state after the timeout, check both resource groups carefully using the Azure portal or the following Azure CLI command:

```azurecli
az resource list --resource-group <source-rg> --output table
az resource list --resource-group <destination-rg> --output table
```

If resources are missing from both groups, contact [Azure Support](https://azure.microsoft.com/support/create-ticket/).

### Step 3: Retry the move with a smaller batch

If the move actually failed and the resources are still in the source, reduce the number of resources in your move request and retry. Moving fewer resources at a time reduces the chance of hitting the four-hour limit.

Azure portal allows a maximum of 800 resources per move request, but for complex VMs with many dependencies, consider batching into smaller groups.

## Prevent future timeouts

- **Move during low-activity periods.** If any dependent services (such as storage accounts or databases) are processing large amounts of data during the move, linked notification steps take longer.
- **Avoid moving shared resources.** Virtual networks and other resources shared by many VMs increase the notification chain that must complete within the four-hour window.
- **Use Azure Resource Mover for cross-region moves.** For cross-region scenarios, use [Azure Resource Mover](/azure/resource-mover/overview) instead of the standard move API, as it handles the complexity with more granular progress tracking.

## Next steps

- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Move resources - 800 resource limit](move-resources-800-limit.md)
- [Move fails with MissingMoveDependentResources](move-resources-missing-dependencies.md)
