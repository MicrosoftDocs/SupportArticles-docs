---
title: Azure resource move fails - tenant not authorized to access linked subscription
description: Azure resource move fails with LinkedAuthorizationFailed when subscriptions are in different tenants. Learn the supported fixes to complete your move.
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
# Azure resource move fails because current tenant isn't authorized for linked subscription

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Summary

A Microsoft Azure resource move might fail and generate a `LinkedAuthorizationFailed` error if the source and destination subscriptions are in different Microsoft Entra ID tenants. This article explains why cross-tenant moves aren't supported, and shows how to fix the issue by aligning tenants or re-creating resources in the destination subscription.

## Symptoms

When you try to move a VM, image, or disk from one subscription to another, the operation fails and returns an error message that resembles the following message:

```output
Resource move policy validation failed.
(Code: ResourceMovePolicyValidationFailed)
The client has permission to perform action 'Microsoft.Compute/virtualMachines/write' on scope '/subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Compute/images/<image-name>', however the current tenant '<tenant-id>' is not authorized to access linked subscription '<subscription-id>'.
(Code: LinkedAuthorizationFailed, Target: Microsoft.Compute/images/<image-name>)
```

## Cause

This error occurs if the source and destination subscriptions belong to different Microsoft Entra ID tenants. Moving resources between subscriptions that are in different tenants isn't supported. The identity (service principal or user) that performs the move must have access in the same tenant as both subscriptions.

This error can affect:

- VMs
- Managed images
- Managed disks
- Other Azure Compute Gallery and network resources

## Resolution

### Option 1: Move both subscriptions to the same tenant

If you control both subscriptions, transfer them to the same Microsoft Entra ID tenant before you try the move. For more information, see [Transfer an Azure subscription to a different Microsoft Entra ID directory](/azure/role-based-access-control/transfer-subscription).

### Option 2: Re-create the resource in the destination subscription

If you have to perform a cross-tenant move, and you can't consolidate the subscriptions, re-create the resource in the destination subscription:

1. **For VMs:** Take a managed disk snapshot in the source subscription. Share the snapshot with the destination tenant by using [cross-tenant shared access](/azure/virtual-machines/snapshot-copy-managed-disk). Create a new VM from the snapshot in the destination subscription.

1. **For managed images:** Export the image to a storage account that the destination tenant can access. Then, re-create the image.

### Option 3: Use Compute Gallery for cross-tenant image sharing

For images, use [Compute Gallery with cross-tenant sharing](/azure/virtual-machines/shared-image-galleries) to share the image directly with the destination tenant without moving the original resource.

## References

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Virtual machine move limitations](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)
- [Transfer an Azure subscription to a different Microsoft Entra ID directory](/azure/role-based-access-control/transfer-subscription)
