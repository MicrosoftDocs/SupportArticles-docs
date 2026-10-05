---
title: Azure resource move fails - resource has a plan with a different subscription
description: Learn how to resolve an Azure resource move failure when moving a VM with a Marketplace plan between subscriptions and re-create the VM successfully.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/11/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:Cannot create a VM
ai-usage: ai-assisted
---
# Azure resource move fails because an Azure Marketplace plan is tied to another subscription

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Summary

This article helps you troubleshoot an Azure resource move failure when moving a virtual machine (VM) created from an Azure Marketplace image to another subscription. Learn how to resolve the error when the image has a plan tied to the original subscription.

## Symptoms

When you try to move a VM to a different subscription, the operation fails and returns an error message that resembles the following message.

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

You can't move VMs that you created from Marketplace images that include a *plan* (a billing agreement specific to a subscription) directly across subscriptions. The plan is tied to the originating subscription.

## Resolution

To move the VM to a new subscription, copy the VM's disks, and re-create the VM in the destination subscription. Include the same Marketplace plan as for the original VM.

> [!IMPORTANT]
> Verify that the Marketplace offer is still available before you delete the original VM. If the offer is retired, you can't re-create the VM in either the old or new subscription.

### Step 1: Get the plan information from the existing VM

Use Azure CLI or Azure PowerShell to retrieve the Marketplace plan information for the existing VM.

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm show --resource-group "<resource-group-name>" --name "<vm-name>" --query plan
```

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<resource-group-name>" -Name "<vm-name>"
$vm.Plan
```

# [Azure portal](#tab/portal)

You can't query VM Marketplace plan metadata (publisher, product, and plan name) in the [Azure portal](https://portal.azure.com). To get plan details, use Azure PowerShell or Azure CLI.

---

### Step 2: Verify that the offer is available in the destination subscription

Use Azure CLI or Azure PowerShell to verify that the Marketplace offer is available in the destination subscription.

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm image list-skus --publisher "<publisher>" --offer "<offer>" --location "<location>"
```

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzVMImageSku -Location "<location>" -PublisherName "<publisher>" -Offer "<offer>"
```

# [Azure portal](#tab/portal)

The Azure portal doesn't provide a way to verify Marketplace offer and SKU availability in a destination subscription. To check offer availability, use Azure PowerShell or Azure CLI.

---

### Step 3: Copy or move the OS disk

Either clone the OS disk to the destination subscription or move the original disk after you delete the VM from the source subscription.

### Step 4: Accept Marketplace terms in the destination subscription

Use Azure CLI or Azure PowerShell to accept the Marketplace terms in the destination subscription.

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm image terms accept --publisher "<publisher>" --offer "<offer>" --plan "<sku>"
```

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Set-AzMarketplaceTerms -Publisher "<publisher>" -Product "<offer>" -Name "<sku>" -Accept
```

# [Azure portal](#tab/portal)

You can't programmatically accept Marketplace image terms in a destination subscription through the Azure portal. To accept terms by using a command-line interface, use Azure PowerShell or Azure CLI.

---

Alternatively, create a temporary VM in the destination subscription by using the same Marketplace plan through the [Azure portal](https://portal.azure.com). This action accepts the terms. You can then delete the temporary VM.

### Step 5: Re-create the VM from the disk

In the destination subscription, create a new VM from the copied OS disk. Specify the original Marketplace plan information to match the plan that you accepted.

For more information, see [Create a VM from a specialized disk](/azure/virtual-machines/windows/create-vm-specialized).

## References

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Virtual machine move limitations](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)
- [Deploy a VM with Marketplace image plan information](/azure/virtual-machines/marketplace-images)
