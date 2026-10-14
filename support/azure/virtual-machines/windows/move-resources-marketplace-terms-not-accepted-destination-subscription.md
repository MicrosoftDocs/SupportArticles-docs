---
title: Azure VM move fails because Marketplace terms arent accepted in the destination subscription
description: Fix Azure VM move failures caused by unaccepted Marketplace terms in the destination subscription so that you can retry the deployment successfully.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/10/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine move fails because Azure Marketplace terms aren't accepted in the destination subscription

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article helps you troubleshoot and resolve Azure virtual machine (VM) move failures that occur if the Azure Marketplace terms for the VM image aren't accepted in the destination subscription.

## Symptoms

A move or re-create operation fails for a VM that originated from a Marketplace image with a purchase plan.

The following error signatures indicate that the Marketplace terms aren't accepted in the destination subscription.

```output
MarketplacePurchaseEligibilityFailed
```

```output
The Marketplace terms for this image haven't been accepted in the destination subscription.
```

## Cause

Marketplace-backed VMs require the destination subscription to accept the image plan terms before the VM can be re-created or attached by using that plan metadata.

## Resolution

### Step 1: Verify that the VM has Marketplace plan metadata

Use Azure PowerShell or Azure CLI to verify that the VM has Marketplace plan metadata.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<source-rg>" -Name "<vm-name>"
$vm.Plan
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm show --resource-group "<source-rg>" --name "<vm-name>" --query "plan"
```

# [Azure portal](#tab/portal)

You can't query VM Marketplace plan metadata (publisher, product, and plan name) in the [Azure portal](https://portal.azure.com). To get plan details, use Azure PowerShell or Azure CLI.

---

### Step 2: Accept the terms in the destination subscription

Use Azure PowerShell or Azure CLI to accept the Marketplace terms in the destination subscription.

# [Azure PowerShell](#tab/powershell)

Run this command.

```azurepowershell
Get-AzMarketplaceTerms -Publisher "<publisher>" -Product "<offer>" -Name "<sku>" |
  Set-AzMarketplaceTerms -Accept
```

# [Azure CLI](#tab/cli)

Run this command.

```azurecli
az vm image terms accept --publisher "<publisher>" --offer "<offer>" --plan "<sku>"
```

# [Azure portal](#tab/portal)

The Azure portal doesn't support accepting Marketplace image terms in a destination subscription. To accept terms programmatically, use Azure PowerShell or Azure CLI.

---

### Step 3: Retry the move or re-create the workflow

After you accept the terms, run the validation or redeployment sequence again.

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Virtual machines with Marketplace plans](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations#virtual-machines-with-marketplace-plans)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
