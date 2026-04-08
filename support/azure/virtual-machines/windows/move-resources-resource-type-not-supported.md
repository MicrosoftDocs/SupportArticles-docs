---
title: Azure resource move fails - resource type not supported
description: Troubleshoot the MoveNotSupported error that occurs when a resource type cannot be moved between resource groups or subscriptions.
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
# Azure resource move fails because the resource type is not supported for move

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Symptoms

When you try to move Azure resources to a different resource group or subscription, the operation fails with an error similar to the following:

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

Some Azure resource types don't support being moved between resource groups or subscriptions. The error identifies the specific resource type that can't be moved.

## Resolution

### Step 1: Identify the unsupported resource type

The error message lists each resource type that cannot be moved. Note the resource provider and type (for example, `Microsoft.Network/publicIPAddresses`).

### Step 2: Check the move support reference

Use the official move support table to confirm whether the resource type supports move operations:

[Move operation support for resources](/azure/azure-resource-manager/management/move-support-resources)

For VM-specific restrictions, review:

[Scenarios not supported for virtual machine moves](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations?tabs=azure-cli#scenarios-not-supported)

### Step 3: Remove the unsupported resources and retry

Remove the unsupported resource types from your move selection. Retry the move with only supported resources. Recreate the unsupported resources in the destination resource group or subscription after the move completes.

## More information

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Virtual machine move limitations](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)
