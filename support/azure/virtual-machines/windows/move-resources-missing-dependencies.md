---
title: Move fails with MissingMoveDependentResources error
description: Troubleshoot the MissingMoveDependentResources error code when you move Azure VM resources across resource groups or subscriptions, and fix dependencies before you retry.
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

# Move fails with MissingMoveDependentResources error

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article helps you troubleshoot the `MissingMoveDependentResources` error code that occurs when you move Microsoft Azure virtual machine (VM) resources to another resource group or subscription. The error indicates that the move request doesn't include all dependent resources. To resolve this issue, identify the missing resources that are listed in the error details, and include them in the move operation.

## Symptoms

When you try to move Azure virtual machine resources to another resource group or subscription, the operation fails and returns an error message that resembles the following message:

```json
{
  "code": "MissingMoveDependentResources",
  "target": "Microsoft.Network/networkInterfaces",
  "message": "The move resources request does not contain all the dependent resources. Please check details for missing resource Ids.",
  "details": [
    {
      "code": "0",
      "message": "/subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Network/publicIPAddresses/<ip-name>"
    },
    ...
  ]
}
```

The `details` array lists the resource IDs that you must include in the move request.

## Cause

When you move a resource, Azure Resource Manager requires that all dependent (linked) resources must satisfy either of the following conditions:

- They already exist in the destination resource group or subscription
- They're included in the same move request

VM resources have a chain of dependencies. For example, to move a VM, you must also move:

- The VM's managed disks
- The VM's network adapter
- The virtual network that the network adapter is attached to
- All other network adapters that are attached to the same virtual network
- Any public IP addresses that's associated with those network adapters
- Any network security groups (NSGs) that are associated with the network adapters or subnets

This chain can extend to additional resource types, depending on your configuration.

| Resource provider | Resource types that might be required |
|---|---|
| Microsoft.Compute | virtualMachines, disks |
| Microsoft.Network | networkInterfaces, publicIPAddresses, networkSecurityGroups, virtualNetworks |
| Microsoft.Storage | storageAccounts (if using unmanaged disks or boot diagnostics) |

If you don't include any dependent resource in the move request, the operation fails before it starts.

## Resolution

To resolve the issue, follow these steps:

1. **Collect the full error message:** The `details` array contains the complete list of missing resource IDs. To review all entries, copy the raw error text to a text editor.

1. **Parse the missing resource IDs:** Each entry in `details` contains a full resource ID in the format:
   `/subscriptions/<sub>/resourceGroups/<rg>/providers/<type>/<name>`

   To build your list of missing resources, extract the resource type and name from each entry.

1. **Add all missing resources to your move request:** In the [Azure portal](https://portal.azure.com), return to the **Move resources** blade, and add each missing resource to the selection before you retry.

   If you're using Azure PowerShell or Azure CLI, add the missing resource IDs to the `-ResourceId` parameter array.

   **Azure PowerShell example:**

   ```powershell
   $resourceIds = @(
     "/subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.Compute/virtualMachines/<vm-name>",
     "/subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.Compute/disks/<disk-name>",
     "/subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.Network/networkInterfaces/<nic-name>",
     "/subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.Network/virtualNetworks/<vnet-name>",
     "/subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.Network/publicIPAddresses/<ip-name>",
     "/subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.Network/networkSecurityGroups/<nsg-name>"
   )
   Move-AzResource -DestinationResourceGroupName "<destination-rg>" -ResourceId $resourceIds
   ```

1. **Retry the move:** After yo add all missing resources, retry the move operation.

> [!NOTE]
> The error message might list a resource in a resource group other than the one that you expect. In this case, the difference might occur because that resource is shared across multiple VMs or resource groups. You must include all resources in the dependency chain regardless of their current location.

## Check which resources support move operations

Not all Azure resource types support the move operation. Before you process the move, verify that all resources in your move request are supported.

See [Move operation support for resources](/azure/azure-resource-manager/management/move-support-resources) for a complete list.

> [!NOTE]
> For a detailed explanation of this error code, see [What does the error code "MissingMoveDependentResources" mean?](/azure/azure-resource-manager/management/move-resource-group-and-subscription#what-does-the-error-code-missingmovedependentresources-mean)

## References

- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Move virtual machines move limitations](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)
- [Move resources - 800 resource limit](move-resources-800-limit.md)
- [Resource is not in a Succeeded state](move-resources-not-succeeded-state.md)
