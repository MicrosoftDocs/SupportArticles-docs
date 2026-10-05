---
title: Azure resource move fails because tenant not authorized to access linked subscription
description: Resolve LinkedAuthorizationFailed errors when Azure resource moves fail between subscriptions in different tenants. Learn the supported fixes to complete your move.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/18/2026
ms.custom: sap:Cannot create a VM
ai-usage: ai-assisted
---
# Azure resource move fails because current tenant isn't authorized for linked subscription

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Summary

An Azure resource move might fail and generate a `LinkedAuthorizationFailed` error if the source and destination subscriptions are in different Microsoft Entra ID tenants. This article explains why cross-tenant moves aren't supported, and shows how to fix the issue by aligning tenants or re-creating resources in the destination subscription.

## Symptoms

When you try to move a virtual machine (VM), image, or disk from one subscription to another, the operation fails and returns an error message that resembles the following message:

```output
Resource move policy validation failed.
(Code: ResourceMovePolicyValidationFailed)
The client has permission to perform action 'Microsoft.Compute/virtualMachines/write' on scope '/subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Compute/images/<image-name>', however the current tenant '<tenant-id>' is not authorized to access linked subscription '<subscription-id>'.
(Code: LinkedAuthorizationFailed, Target: Microsoft.Compute/images/<image-name>)
```

## Cause

This error occurs if the source and destination subscriptions belong to different Microsoft Entra ID tenants. Moving resources between subscriptions that are in different tenants isn't supported. The identity (service principal or user) that performs the move must have access in the same tenant as both subscriptions.

This error can affect the following items:

- VMs
- Managed images
- Managed disks
- Other Azure Compute Gallery and network resources

## Resolution

### Option 1: Move both subscriptions to the same tenant

If you control both subscriptions, transfer them to the same Microsoft Entra ID tenant before you try the move. For more information, see [Transfer an Azure subscription to a different Microsoft Entra ID directory](/azure/role-based-access-control/transfer-subscription).

### Option 2: Re-create the resource in the destination subscription

If you need to perform a cross-tenant move and you can't consolidate the subscriptions, use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to re-create the resource in the destination subscription.

# [Azure PowerShell](#tab/powershell)

**For VMs** 

Take a managed disk snapshot and create a new VM in the destination. 

Run the following command.

```azurepowershell
$disk = Get-AzDisk -ResourceGroupName "<source-rg>" -DiskName "<os-disk-name>"
$snapshotConfig = New-AzSnapshotConfig -SourceUri $disk.Id -Location $disk.Location -CreateOption Copy
$snapshot = New-AzSnapshot -ResourceGroupName "<source-rg>" -SnapshotName "<snapshot-name>" -Snapshot $snapshotConfig
```

For more information, see [Create a virtual machine from a snapshot with PowerShell](/azure/virtual-machines/scripts/virtual-machines-linux-powershell-sample-create-vm-from-snapshot).

# [Azure CLI](#tab/cli)

**For VMs** 

Take a managed disk snapshot and create a new VM in the destination.

Run the following command.

```azurecli
az snapshot create \
  --resource-group <source-rg> \
  --name <snapshot-name> \
  --source <os-disk-resource-id>
```

For more information, see [Create a virtual machine from a snapshot with CLI](/azure/virtual-machines/scripts/create-vm-from-snapshot).

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the source VM's managed disk.
1. Select **Create snapshot**.
1. Share the snapshot with the destination tenant by using [cross-tenant shared access](/azure/virtual-machines/snapshot-copy-managed-disk).
1. Create a new VM from the snapshot in the destination subscription.

---

### Option 3: Use Compute Gallery for cross-tenant image sharing

For images, use [Azure Compute Gallery with cross-tenant sharing](/azure/virtual-machines/shared-image-galleries) to share the image directly with the destination tenant without moving the original resource.

## References

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Virtual machine move limitations](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)
- [Transfer an Azure subscription to a different Microsoft Entra ID directory](/azure/role-based-access-control/transfer-subscription)
