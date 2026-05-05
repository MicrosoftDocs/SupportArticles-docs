---
title: Azure resource move fails - can't select more than 100 resources in the Azure portal
description: Fix Azure portal resource move failures when you select more than 100 resources. Learn workarounds in portal, PowerShell, or CLI to move successfully.
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
# Resource selections are lost when you move more than 100 resources in the Azure portal

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Summary

When you try to move more than 100 resources by using the [Azure portal](https://portal.azure.com), the portal retains only the resources that you select on the currently visible page. Navigating between pages clears the selections that you made on previous pages. This behavior can cause missing dependency errors if you try to move resources across multiple pages without reselecting all required resources on each page.

## Symptoms

Imagine the following scenario:

- You use the Azure portal to move more than 100 resources.
- You select all the resources on page 1 of the resource list.
- You go to page 2, and select extra resources.
- You return to page 1, and see that the portal no longer shows the resources that you selected.

In this scenario, the move fails and returns an error message that resembles the following example:

```output
{
  "code": "MissingMoveDependentResources",
  "message": "The move resources request does not contain all the dependent resources."
}
```

## Cause

This issue is a known limitation of the Azure portal resource move interface. If the resource list spans multiple pages (more than 100 resources per page), navigating between pages clears selections that you made on previous pages. The portal retains only resources that you select on the currently visible page.

This behavior is by design as of the current portal experience.

## Workaround

To move more than 100 resources, use one of the following workarounds.

### Workaround 1: Move resources in batches by using the portal

1. Select all resources on page 1 only, and complete the move for that batch.
1. After the first move finishes, select the next batch of resources, and repeat.

> [!NOTE]
> When you move resources between subscriptions, make sure that you include all dependent resources, such as a virtual machine (VM), its network interface card (NIC), and its disks, in the same batch. This approach helps you avoid missing dependency errors.

### Workaround 2: Use Azure PowerShell or Azure CLI

To avoid the portal pagination limitation, move resources programmatically.

**Azure PowerShell**

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
> When you use CLI or PowerShell, the 800-resource-per-operation limit still applies. Break large moves into operations of fewer than 800 resources each.

## References

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Move resources with PowerShell](/azure/azure-resource-manager/management/move-resource-group-and-subscription#use-azure-powershell)
