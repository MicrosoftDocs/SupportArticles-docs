---
title: Azure resource move fails - tenant not authorized to access linked subscription
description: Troubleshoot the LinkedAuthorizationFailed error that occurs when moving VM resources between subscriptions in different tenants.
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
# Azure resource move fails - current tenant is not authorized to access linked subscription

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Symptoms

When you try to move a virtual machine, image, or disk from one subscription to another, the operation fails with an error similar to the following:

```output
Resource move policy validation failed.
(Code: ResourceMovePolicyValidationFailed)
The client has permission to perform action 'Microsoft.Compute/virtualMachines/write' on scope '/subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Compute/images/<image-name>', however the current tenant '<tenant-id>' is not authorized to access linked subscription '<subscription-id>'.
(Code: LinkedAuthorizationFailed, Target: Microsoft.Compute/images/<image-name>)
```

## Cause

This error occurs when the source and destination subscriptions belong to **different Azure AD tenants**. Moving resources between subscriptions that are in different tenants isn't supported. The identity (service principal or user) performing the move must have access in the same tenant as both subscriptions.

This error can affect moves of:
- Virtual machines
- Managed images
- Managed disks
- Other compute and network resources

## Resolution

### Option 1: Move both subscriptions to the same tenant

If you control both subscriptions, transfer them to the same Azure AD tenant before attempting the move. See [Transfer an Azure subscription to a different Azure AD directory](/azure/role-based-access-control/transfer-subscription).

### Option 2: Recreate the resource in the destination subscription

If a cross-tenant move is required and the subscriptions can't be consolidated, recreate the resource in the destination subscription:

1. **For virtual machines:** Take a managed disk snapshot in the source subscription. Share the snapshot with the destination tenant using [cross-tenant shared access](/azure/virtual-machines/snapshot-copy-managed-disk). Create a new VM from the snapshot in the destination subscription.

2. **For managed images:** Export the image to a storage account accessible by the destination tenant and recreate the image.

### Option 3: Use Azure Compute Gallery for cross-tenant image sharing

For images specifically, use [Azure Compute Gallery with cross-tenant sharing](/azure/virtual-machines/shared-image-galleries) to share the image directly with the destination tenant without moving the original resource.

## More information

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Virtual machine move limitations](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)
- [Transfer an Azure subscription to a different directory](/azure/role-based-access-control/transfer-subscription)
