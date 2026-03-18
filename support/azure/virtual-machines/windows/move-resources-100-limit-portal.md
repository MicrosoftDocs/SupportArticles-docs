---
title: Azure resource move fails - cannot select more than 100 resources in the portal
description: Troubleshoot the issue where resource selections are lost when moving more than 100 resources using the Azure portal.
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
# Resource selections are lost when moving more than 100 resources in the Azure portal

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Symptoms

When you try to move more than 100 resources using the Azure portal:

1. You select all resources on page 1 of the resource list.
2. You navigate to page 2 and select additional resources.
3. When you return to page 1, the resources you selected there are no longer selected.
4. The move fails with an error similar to:

```output
{
  "code": "MissingMoveDependentResources",
  "message": "The move resources request does not contain all the dependent resources."
}
```

## Cause

This is a known limitation of the Azure portal resource move interface. When the resource list spans multiple pages (more than 100 resources per page), navigating between pages clears selections made on previous pages. Only resources selected on the **currently visible page** are retained.

This behavior is by design as of the current portal experience.

## Resolution

Use one of the following workarounds to move more than 100 resources.

### Option 1: Move resources in batches using the portal

1. Select all resources on **page 1** only and complete the move for that batch.
2. After the first move completes, select the next batch of resources and repeat.

> [!NOTE]
> When moving resources between subscriptions, ensure that all dependent resources (such as a VM, its NIC, and its disks) are included in the same batch to avoid missing dependency errors.

### Option 2: Use Azure PowerShell or Azure CLI

Move resources programmatically to avoid the portal pagination limitation.

**PowerShell**
```powershell
$resources = Get-AzResource -ResourceGroupName <source-rg>
Move-AzResource -DestinationResourceGroupName <destination-rg> `
                -DestinationSubscriptionId <destination-sub-id> `
                -ResourceId ($resources.ResourceId)
```

**Azure CLI**
```azurecli
resourceIds=$(az resource list --resource-group <source-rg> --query "[].id" -o tsv | tr '\n' ' ')
az resource move --destination-group <destination-rg> --ids $resourceIds
```

> [!TIP]
> When using CLI or PowerShell, the 800-resource-per-operation limit still applies. Break large moves into operations of fewer than 800 resources each.

## More information

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Move resources with PowerShell](/azure/azure-resource-manager/management/move-resource-group-and-subscription#use-azure-powershell)
