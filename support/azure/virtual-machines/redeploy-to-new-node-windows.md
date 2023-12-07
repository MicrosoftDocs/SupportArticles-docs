---
title: Redeploy Windows virtual machines in Azure
description: How to redeploy Windows virtual machines in Azure to mitigate RDP connection issues.
services: virtual-machines
documentationcenter: virtual-machines
author: genlin
manager: dcscontentpm
tags: azure-resource-manager,top-support-issue
ms.custom: devx-track-azurepowershell, devx-track-azurecli
ms.service: virtual-machines
ms.subservice: vm-common-errors-issues
ms.collection: windows
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 11/03/2021
ms.author: genli
---
# Redeploy Windows virtual machine to new Azure node

[!INCLUDE [Feedback](../../includes/feedback.md)]

If you have been facing difficulties troubleshooting Remote Desktop (RDP) connection or application access to Windows-based Azure virtual machine (VM), redeploying the VM may help. When you redeploy a VM, Azure will shut down the VM, move the VM to a new node within the Azure infrastructure, and then power it back on, retaining all your configuration options and associated resources. This article shows you how to redeploy a VM using Azure PowerShell or the Azure portal.

If the VM is stuck in a failed state, try [reapplying your VM's state](vm-stuck-in-failed-state.md) before redeploying.

> [!Warning]
> After you redeploy a VM, all the data that you saved on the temporary disk and Ephemeral disk is lost. The dynamic IP addresses associated with virtual network interface are updated.

## Use the Azure CLI

Install the latest [Azure CLI](/cli/azure/install-az-cli2) and log in to your Azure account using [az login](/cli/azure/reference-index).

Redeploy your VM with [az vm redeploy](/cli/azure/vm). The following example redeploys the VM named *myVM* in the resource group named *myResourceGroup*:

```azurecli
az vm redeploy --resource-group myResourceGroup --name myVM 
```

## Using Azure PowerShell

Make sure you have the latest Azure PowerShell 1.x installed on your machine. For more information, see [How to install and configure Azure PowerShell](/powershell/azure/).

The following example deploys the VM named `myVM` in the resource group named `myResourceGroup`:

```powershell
Set-AzVM -Redeploy -ResourceGroupName "myResourceGroup" -Name "myVM"
```

[!INCLUDE [virtual-machines-common-redeploy-to-new-node](../../includes/virtual-machines-common-redeploy-to-new-node.md)]

## Next steps

If you are having issues connecting to your VM, you can find specific help on [troubleshooting RDP connections](troubleshoot-rdp-connection.md) or [detailed RDP troubleshooting steps](detailed-troubleshoot-rdp.md). If you cannot access an application running on your VM, you can also read [application troubleshooting issues](./troubleshoot-app-connection.md).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
