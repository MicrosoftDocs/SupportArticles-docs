---
title: Azure VM move fails - resource not found error referencing VMSS in another subscription
description: Troubleshoot the NotFound error referencing a virtual machine scale set in a different subscription when moving a VM between resource groups.
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
# VM move between resource groups fails with a resource-not-found error

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Symptoms

When you try to move one or more virtual machines from one resource group to another within the same subscription, the move fails with an error similar to the following:

```output
Resource move validation failed. Please see details.
Diagnostic information: timestamp '<timestamp>', subscription id '<subscription-id>', tracking id '<tracking-id>', request correlation id '<correlation-id>'.
(Code: ResourceMoveProviderValidationFailed)
Resource /subscriptions/<different-subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Compute/virtualMachineScaleSets/<vmss-id> not found.
(Code: NotFound, Target: Microsoft.Network/networkInterfaces)
```

The error references a virtual machine scale set (VMSS) or a load balancer in a **different subscription**, even though:

- No VMSS resources are included in the move operation.
- No VMSS exists in the source or destination resource group.

## Cause

This is a known platform issue in which the Azure network resource provider (NRP) incorrectly validates dependencies against a VMSS or load balancer in an unrelated subscription. The root cause is a stale reference in network interface metadata.

## Resolution

This issue requires Microsoft product group intervention. To request investigation:

1. Collect the **correlation ID** from the error message.
2. Note the **subscription ID**, **source resource group**, **destination resource group**, and the **timestamp** of the failed operation.
3. Open a support request with the collected details, or contact your Microsoft support representative.

## More information

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Troubleshoot moving Azure resources](/azure/azure-resource-manager/management/troubleshoot-move)
