---
title: Azure virtual machine move and migration FAQ
description: "Get answers to Azure virtual machine move and migration questions across resource groups, subscriptions, regions, and tenants. Learn more."
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

# Azure virtual machine move and migration FAQ

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article answers frequently asked questions (FAQ) about moving Azure virtual machine (VM) resources across resource groups, subscriptions, regions, and tenants. Find answers to common questions about move operations, including supported scenarios, limitations, error troubleshooting, and post-move considerations.

## General move questions

### What can I move by using the Azure resource move operation?

You can move virtual machines and their associated resources between resource groups within the same subscription, or between subscriptions within the same Azure AD tenant. Associated resources include:

- Managed disks.
- Network interface cards (NICs).
- Public IP addresses.
- Network security groups (NSGs).
- Virtual networks.

For a definitive list of which resource types support move, see [Move operation support for resources](/azure/azure-resource-manager/management/move-support-resources).

### What resources must I include when moving a VM?

When moving a VM, include all dependent resources in the same move request, or ensure they already exist in the destination:

- Managed OS disk and all data disks.
- NICs.
- Virtual network the NICs are attached to.
- All other NICs attached to that virtual network (and their VMs and disks).
- Public IP addresses associated with the NICs.
- NSGs associated with the NICs or subnets.

If any dependent resource is missing, the move fails with `MissingMoveDependentResources`. For more information, see [Move fails with MissingMoveDependentResources](move-resources-missing-dependencies.md).

### Can I move a VM without stopping it?

Yes. The Azure resource move operation doesn't require stopping or deallocating the VM. The VM continues to run and serve traffic normally. Both the source and destination resource groups are locked for write and delete operations during the move.

### How long does a move operation take?

Most moves complete within 30 minutes. Azure Resource Manager enforces a maximum of four hours. If the move doesn't complete within four hours, it times out and rolls back. For more information, see [Move operation times out after four hours](move-resources-4-hour-timeout.md).

### Are there limits on how many resources I can move at once?

- **800 resources per move request** - this limit is set by the ARM API.
- **100 resources via the Azure portal** - the portal UI enforces a lower limit. For more than 100 resources, use Azure PowerShell, Azure CLI, or the REST API.

For more information, see [800 resource limit per move operation](move-resources-800-limit.md) and [Cannot move more than 100 resources via portal](move-resources-100-limit-portal.md).

### Can I move a VM to a different virtual network?

Not directly. The Azure move API doesn't support changing a VM's virtual network attachment. To move a VM to a different virtual network, recreate the VM:

1. Create a backup or snapshot of the VM's OS disk.
1. Create a new VM in the target virtual network by using the OS disk copy.

### Can I move resources to a different Azure region?

Not by using the standard resource move API. Cross-region moves require [Azure Resource Mover](/azure/resource-mover/overview), which the Azure Backup and Recovery Services team manages.

### Can I move resources to a subscription in a different Microsoft Entra ID tenant?

No. The source and destination subscriptions must be in the same tenant. Two workarounds exist:

1. Transfer the subscription itself to the destination tenant.
1. Copy the VM disks by using Azure Storage Explorer and recreate the VM in the destination tenant.

For more information, see [Move Azure VM resources to a different tenant](move-vm-to-different-tenant.md).

> [!NOTE]
> For additional frequently asked questions about resource moves, see [Frequently asked questions](/azure/azure-resource-manager/management/move-resource-group-and-subscription?tabs=azure-cli#frequently-asked-questions) in the Azure Resource Manager documentation.

## Pre-move checklist

Before initiating a move, verify the following:

| Check | Details |
|---|---|
| All dependent resources identified | Run `Move-AzResource` with `-WhatIf` or use the portal's dependency check. |
| All resources in Succeeded state | Resources in Failed, Updating, or Creating state block the move. |
| No active locks on resource groups | Temporarily delete or move any `CanNotDelete` or `ReadOnly` locks. |
| Resource types support move | Check [Move operation support for resources](/azure/azure-resource-manager/management/move-support-resources). |
| Destination subscription limits not exceeded | Check core quota and resource count limits in the destination. |
| No Marketplace plan restrictions | Third-party images with plan info might have cross-subscription restrictions. |
| Boot diagnostics storage account exists | A deleted or invalid boot diagnostics storage account blocks the move. |

## Common errors quick reference

| Error code | Article |
|---|---|
| `MoveCannotProceedWithResourcesNotInSucceededState` | [Resource is not in a Succeeded state](move-resources-not-succeeded-state.md) |
| `MissingMoveDependentResources` | [Move fails with MissingMoveDependentResources](move-resources-missing-dependencies.md) |
| `ResourceMoveTimedOut` | [Move operation times out after four hours](move-resources-4-hour-timeout.md) |
| `MoveResourcesHaveInvalidState` | [Move fails due to invalid or deleted storage account](move-resources-invalid-storage-account.md) |
| `ResourceTypeMoveNotSupported` | [Resource type not supported for move](move-resources-resource-type-not-supported.md) |
| `MoveResourcesHavePendingOperations` | [Operation not allowed - system upgrade in progress](move-resources-operation-not-allowed-system-upgrade.md) |

## After the move

### My resources disappeared after the move — where are they?

Check both the source and destination resource groups. Resources appear in only one location if the move partially succeeds. If resources are missing from both, contact [Azure Support](https://azure.microsoft.com/support/create-ticket/).

### The move succeeded but now my VM won't start

VM connectivity or boot problems after a move typically aren't related to the move operation itself. Check:

- NSG rules in the destination resource group.
- Route tables and virtual network configuration in the destination.
- VM-level diagnostics by using boot diagnostics in the [Azure portal](https://portal.azure.com).

### Do I need to update anything after a successful move?

- **Role assignments** aren't moved. Reassign RBAC roles in the destination resource group.
- **Resource locks** don't carry over. Reapply any locks you had on the source.
- **Managed identities** continue to work. System-assigned identities follow the resource automatically.

## Next steps

- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Move operation support for resources](/azure/azure-resource-manager/management/move-support-resources)
- [Azure Resource Mover — cross-region moves](/azure/resource-mover/overview)
