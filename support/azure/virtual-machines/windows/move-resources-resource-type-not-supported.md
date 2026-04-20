---
title: Azure resource move fails - resource type not supported
description: Troubleshoot the MoveNotSupported error when an Azure resource type can't be moved across resource groups or subscriptions. Learn how to fix your move request now.
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
# Azure resource move fails because the resource type isn't supported for move

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Summary

When you move Microsoft Azure resources to a different resource group or subscription, the operation might fail because one or more resource types in the move request don't support move operations. This article helps you troubleshoot this error, identify which resource types can't be moved, and adjust your move operation accordingly.

## Symptoms

When you try to move Azure resources to a different resource group or subscription, the operation fails and returns an error message that resembles the following message:

```output
{
  "code": "CannotMoveResource",
  "target": "Microsoft.Network/publicIPAddresses",
  "message": "Cannot move one or more resources in the request. Please check details for information about each resource.",
  "details": [{
    "code": "MoveNotSupported",
    "message": "Move for resource type publicIPAddresses is not supported. Move request contains resource /subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Network/publicIPAddresses/<ip-name> of that type."
  }]
}
```

## Cause

Some Azure resource types don't support moves between resource groups or subscriptions. The error message identifies the specific resource type that can't be moved.

## Resolution

### Step 1: Identify the unsupported resource type

The error message lists each resource type that can't be moved. Note the resource provider and type, like `Microsoft.Network/publicIPAddresses`.

### Step 2: Check the move support reference

Use the official move support table to verify that the resource type supports move operations: [Move operation support for resources](/azure/azure-resource-manager/management/move-support-resources).

For virtual machine (VM)-specific restrictions, see [Scenarios not supported for virtual machine moves](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations?tabs=azure-cli#scenarios-not-supported).

### Step 3: Remove the unsupported resources and retry

Remove the unsupported resource types from your move selection. Retry the move by using only supported resources. Re-create the unsupported resources in the destination resource group or subscription after the move finishes.

## More information

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Virtual machine move limitations](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)
