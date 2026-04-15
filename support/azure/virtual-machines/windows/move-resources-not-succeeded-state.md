---
title: Azure resource move fails - resource not in Succeeded state
description: Troubleshoot the MoveCannotProceedWithResourcesNotInSucceededState error when moving Azure VM resources to a new resource group or subscription.
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
# Azure resource move fails because a resource is not in Succeeded state

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Symptoms

When you try to move Azure resources to a different resource group or subscription, the operation fails with the following error:

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

When a resource group contains a virtual network, Azure checks the provisioning state of all resources that depend on it. The move fails if any dependent resource isn't in a `Succeeded` state. This applies even when:

- The resource isn't one of the resources you're moving.
- The resource isn't in the source or destination resource group.

## Resolution

Find the resource that isn't in `Succeeded` state. Restore it to a healthy state by performing a successful operation on it.

### Step 1: Identify the resource

The error message names a resource or resource type. The actual problem resource is often a dependency of the named resource. Check all related resources in both the source and destination resource groups.

In the Azure portal, open each virtual machine or network resource involved in the move. Verify that **Provisioning state** shows **Succeeded**.

### Step 2: Reapply or update the resource

**Reapply a virtual machine (Azure portal)**

1. In the Azure portal, navigate to the virtual machine.
2. In the left menu under **Help**, select **Redeploy + reapply**.
3. Select **Reapply**.

**Update a virtual machine (PowerShell)**

```powershell
$vm = Get-AzVM -ResourceGroupName <resource-group-name> -Name <vm-name>
Update-AzVM -VM $vm -ResourceGroupName <resource-group-name>
```

**Update a virtual machine (Azure CLI)**

```azurecli
az vm update --resource-group <resource-group-name> --name <vm-name>
```

### Step 3: Retry the move

After the resource returns to `Succeeded` state, retry the move operation.

## More information

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Troubleshoot moving Azure resources](/azure/azure-resource-manager/management/troubleshoot-move)
- [Reapply the latest model to VMs in a scale set](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-perform-manual-upgrades)
