---
title: Move operation times out after four hours
description: Troubleshoot the ResourceMoveTimedOut error when an Azure resource move operation exceeds four hours. Follow the steps to verify, recover, and retry.
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

## Summary

The operation to move Microsoft Azure resources to another resource group or subscription can fail if it exceeds the four-hour time limit that's enforced by Azure Resource Manager. This article explains the symptoms, causes, and resolution steps for the `ResourceMoveTimedOut` error.

## Symptoms

When you try to move Azure resources to another resource group or subscription, the operation fails after approximately four hours. Additionally, the operation returns an error message that resembles the following message:

```json
{
  "statusCode": "Conflict",
  "statusMessage": "{\"error\":{\"code\":\"ResourceMoveTimedOut\",\"message\":\"Moving resources did not finish within allowed time '04:00:00'. Provisioning state of the resource groups will be rolled back.\"}}"
}
```

## Cause

Azure Resource Manager enforces a maximum duration of four hours for any move operation. During a move, both the source and destination resource groups are locked. The lock blocks all write and delete operations until the move finishes or times out.

When the four-hour limit is reached, Resource Manager rolls back the provisioning state of both resource groups, and releases all locks. The move is marked as failed.

Most move operations finish in less than 30 minutes. A timeout typically indicates that one resource provider that's involved in the move didn't complete its notification within the allowed window.

> [!NOTE]
> Although the source and destination resource groups are locked, the resources themselves are still operational. For example, a virtual machine continues to run, and an application that uses a SQL database continues to read and write data. Only management-plane write and delete operations are blocked.

## Resolution

### Step 1: Check whether the move actually finished

Even after a timeout error, the underlying resources might move successfully. Resource Manager can report a timeout while the operation continues in the background.

Verify resource locations in the [Azure portal](https://portal.azure.com):

1. Go to the destination resource group.
1. Verify that the resources appear there.
1. Check the source resource group to determine whether the resources are still present.

If resources appear in the destination, the move succeeded despite the timeout message. No further action is needed.

### Step 2: Check for resources missing from either group

If resources don't appear in either the source or the destination, or if the move status remains in a failed state after the timeout, check both resource groups carefully by using the Azure portal or the following Azure CLI commands:

```azurecli
az resource list --resource-group <source-rg> --output table
az resource list --resource-group <destination-rg> --output table
```

If resources are missing from both groups, contact [Azure Support](https://azure.microsoft.com/support/create-ticket/).

You can also check both resource groups by using Azure PowerShell:

```powershell
Get-AzResource -ResourceGroupName <source-rg> | Format-Table
Get-AzResource -ResourceGroupName <destination-rg> | Format-Table
```

> [!NOTE]
> For additional information about long-running move operations, see [My resource move operation has been running for almost an hour. Is there something wrong?](/azure/azure-resource-manager/management/move-resource-group-and-subscription#my-resource-move-operation-which-usually-takes-a-few-minutes-has-been-running-for-almost-an-hour-is-there-something-wrong).

### Step 3: Retry the move with a smaller batch

If the move failed, and the resources are still in the source, reduce the number of resources in your move request, and then retry. Moving fewer resources at a time reduces the chance of reaching the four-hour limit.

The Azure portal allows a maximum of 800 resources per move request. However, for complex virtual machines (VMs) that have many dependencies, consider batching tasks into smaller groups.

## Prevent future timeouts

- **Move during low-activity periods:** If any dependent services (like storage accounts or databases) are processing large amounts of data during the move, linked notification steps take longer.
- **Avoid moving shared resources.** Virtual networks and other resources that are shared by many VMs increase the notification chain that must complete within the four-hour window.
- **Use Azure Resource Mover for cross-region moves.** For cross-region scenarios, use [Azure Resource Mover](/azure/resource-mover/overview) instead of the standard move API because it handles the complexity by using more granular progress tracking.

## References

- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Move resources - 800 resource limit](move-resources-800-limit.md)
- [Move fails with MissingMoveDependentResources](move-resources-missing-dependencies.md)
