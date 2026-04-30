---
title: Azure resource move fails - resource has a plan with a different subscription
description: Learn how to troubleshoot and resolve the resource move validation error when you move Azure VMs with Marketplace plans between subscriptions.
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
# Azure resource move fails because a resource has a Marketplace plan with a different subscription

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Summary

This article helps you troubleshoot the error that occurs when you move a virtual machine (VM) that's created from an Azure Marketplace image to a different subscription, and that image has a plan attached. The error occurs because the Marketplace plan is tied to the original subscription and can't be moved directly to another subscription.

## Symptoms

When you try to move a VM to a different subscription, the operation fails and returns an error message that resembles the following message:

```output
{
  "code": "ResourceMoveValidationFailed",
  "message": "The resource batch move request has '1' validation errors.",
  "details": [{
    "code": "ResourceMoveValidationFailed",
    "message": "Resource move is not supported for resources that have plan with different subscriptions. Resources are 'Microsoft.Compute/virtualMachines/<vm-name>' and correlation id is <correlation-id>."
  }]
}
```

## Cause

VMs that are created from Azure Marketplace images that include a *plan* (a billing agreement specific to a subscription) can't be moved directly across subscriptions. The plan is tied to the originating subscription.

## Resolution

To move the VM to a new subscription, copy the VM's disks, and re-create the VM in the destination subscription. Include the same Marketplace plan as for the original VM.

> [!IMPORTANT]
> Verify that the Marketplace offer is still available before you delete the original VM. If the offer is retired, you can't re-create the VM in either the old or new subscription.

### Step 1: Get the plan information from the existing VM

**Azure CLI**

```azurecli
az vm show --resource-group <resource-group-name> --name <vm-name> --query plan
```

**Azure PowerShell**

```powershell
$vm = Get-AzVM -ResourceGroupName <resource-group-name> -Name <vm-name>
$vm.Plan
```

### Step 2: Verify that the offer is available in the destination subscription

**Azure CLI**

```azurecli
az vm image list-skus --publisher <publisher> --offer <offer> --location <location>
```

**Azure PowerShell**

```powershell
Get-AzVMImageSku -Location <location> -PublisherName <publisher> -Offer <offer>
```

### Step 3: Copy or move the OS disk

Either clone the OS disk to the destination subscription or move the original disk after you delete the VM from the source subscription.

### Step 4: Accept Marketplace terms in the destination subscription

**Azure CLI**

```azurecli
az vm image terms accept --publisher <publisher> --offer <offer> --plan <sku>
```

**Azure PowerShell**

```powershell
Set-AzMarketplaceTerms -Publisher <publisher> -Product <offer> -Name <sku> -Accept
```

Alternatively, create a temporary VM in the destination subscription by using the same Marketplace plan through the portal. This action accepts the terms. You can then delete the temporary VM.

### Step 5: Re-create the VM from the disk

In the destination subscription, create a new VM from the copied OS disk, specifying the original Marketplace plan information to match the plan that you've accepted.

For more information, see [Create a VM from a specialized disk](/azure/virtual-machines/windows/create-vm-specialized).

## More information

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Virtual machine move limitations](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)
- [Deploy a VM with Marketplace image plan information](/azure/virtual-machines/marketplace-images)
