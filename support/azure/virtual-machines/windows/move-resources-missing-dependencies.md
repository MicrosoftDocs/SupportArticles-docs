---
title: Move fails with MissingMoveDependentResources error
description: Troubleshoot the MissingMoveDependentResources error when moving Azure virtual machine resources to another resource group or subscription.
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

## Symptoms

When you try to move Azure virtual machine resources to another resource group or subscription, the operation fails with an error similar to the following message:

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

The `details` array lists the resource IDs that must be included in the move request.

## Cause

Azure Resource Manager requires that when you move a resource, all dependent (linked) resources must either already exist in the destination resource group or subscription, or be included in the same move request.

Virtual machine resources have a chain of dependencies. For example, to move a VM you must also move:

- The VM's managed disk(s)
- The VM's network interface card(s) (NICs)
- The virtual network the NIC is attached to
- All other NICs attached to the same virtual network
- Any public IP addresses associated with those NICs
- Any network security groups (NSGs) associated with the NICs or subnets

This chain can extend to additional resource types depending on your configuration:

| Resource provider | Resource types that may be required |
|---|---|
| Microsoft.Compute | virtualMachines, disks |
| Microsoft.Network | networkInterfaces, publicIPAddresses, networkSecurityGroups, virtualNetworks |
| Microsoft.Storage | storageAccounts (if using unmanaged disks or boot diagnostics) |

If any dependent resource is not included in the move request, the operation fails before it starts.

## Resolution

1. **Collect the full error message.** The `details` array contains the complete list of missing resource IDs. Copy the raw error text to a text editor to review all entries.

2. **Parse the missing resource IDs.** Each entry in `details` contains a full resource ID in the format:
   `/subscriptions/<sub>/resourceGroups/<rg>/providers/<type>/<name>`

   Extract the resource type and name from each entry to build your list of missing resources.

3. **Add all missing resources to your move request.** In the Azure portal, return to the **Move resources** blade, and add each missing resource to the selection before retrying.

   If you are using PowerShell or Azure CLI, add the missing resource IDs to the `-ResourceId` parameter array.

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

4. **Retry the move.** After adding all missing resources, retry the move operation.

> [!NOTE]
> If the error lists a resource in a different resource group than expected, it may be because that resource was shared across multiple VMs or resource groups. All resources in the dependency chain must be included regardless of their current location.

## Check which resources support move operations

Not all Azure resource types support the move operation. Before moving, verify that all resources in your move request are supported.

See [Move operation support for resources](/azure/azure-resource-manager/management/move-support-resources) for a complete list.

> [!NOTE]
> For a detailed explanation of this error code, see [What does the error code "MissingMoveDependentResources" mean?](/azure/azure-resource-manager/management/move-resource-group-and-subscription#what-does-the-error-code-missingmovedependentresources-mean)

## Next steps

- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Move virtual machines move limitations](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)
- [Move resources - 800 resource limit](move-resources-800-limit.md)
- [Resource is not in a Succeeded state](move-resources-not-in-succeeded-state.md)
