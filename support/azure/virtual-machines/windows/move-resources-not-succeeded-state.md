---
title: Azure resource move fails - resource not in Succeeded state
description: Troubleshoot the MoveCannotProceedWithResourcesNotInSucceededState error when you move Azure resources. Learn how to identify and fix resources that aren't in the Succeeded state to complete your move operation.
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
# Azure resource move fails because a resource isn't in the Succeeded state

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Summary

This article helps you troubleshoot the `MoveCannotProceedWithResourcesNotInSucceededState` error that occurs when you move Microsoft Azure virtual machine (VM) resources to another resource group or subscription. The error indicates that one or more resources that are involved in the move aren't in the `Succeeded` state. To resolve this issue, identify the resource that isn't in a `Succeeded` state, and restore it to a healthy state before you retry the move operation.

## Symptoms

When you try to move Azure resources to a different resource group or subscription, the operation fails and returns the following error message:

```output
{
  "code": "ResourceMoveProviderValidationFailed",
  "message": "Resource move validation failed. Please see details.",
  "details": [{
    "code": "MoveCannotProceedWithResourcesNotInSucceededState",
    "target": "Microsoft.Network/networkInterfaces",
    "message": "One of the resources being migrated or its dependency is not in Succeeded state.",
    "details": [{
      "code": "ResourceNotProvisioned",
      "message": "Cannot proceed with operation because resource /subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Compute/virtualMachines/<vm-name> either directly involved in the move or referenced by one of the resources involved in the move is not in Succeeded state. Resource is in Failed state."
    }]
  }]
}
```

## Cause

When a resource group contains a virtual network, Azure checks the provisioning state of all resources that depend on it. The move fails if any dependent resource isn't in a `Succeeded` state. This condition applies even if:

- The resource isn't one of the resources you're moving.
- The resource isn't in the source or destination resource group.

## Resolution

Find the resource that isn't in `Succeeded` state. Restore it to a healthy state by performing a successful operation on it.

### Step 1: Identify the resource

The error message names a resource or resource type. The actual problem resource is often a dependency of the named resource. Check all related resources in both the source and destination resource groups.

In the [Azure portal](https://portal.azure.com), open each VM or network resource that's involved in the move. Verify that the **Provisioning state** property shows a **Succeeded** value.

### Step 2: Reapply or update the resource

**Reapply a VM (Azure portal)**

1. In the Azure portal, go to the VM.
1. In the left menu, under **Help**, select **Redeploy + reapply**.
1. Select **Reapply**.

**Update a VM (Azure PowerShell)**

```powershell
$vm = Get-AzVM -ResourceGroupName <resource-group-name> -Name <vm-name>
Update-AzVM -VM $vm -ResourceGroupName <resource-group-name>
```

**Update a VM (Azure CLI)**

```azurecli
az vm update --resource-group <resource-group-name> --name <vm-name>
```

### Step 3: Retry the move

After the resource returns to the `Succeeded` state, retry the move operation.

## References

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Troubleshoot moving Azure resources](/azure/azure-resource-manager/management/troubleshoot-move)
- [Reapply the latest model to VMs in a scale set](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-perform-manual-upgrades)
