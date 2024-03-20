---
title: Redeploy Linux Virtual Machines in Azure
description: How to redeploy Linux virtual machines in Azure to mitigate SSH connection issues.
services: virtual-machines
documentationcenter: virtual-machines
author: genlin
manager: dcscontentpm
tags: azure-resource-manager,top-support-issue
ms.custom: devx-track-azurecli, linux-related-content
ms.service: virtual-machines
ms.subservice: vm-common-errors-issues
ms.collection: linux
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-linux
ms.workload: infrastructure
ms.date: 11/03/2021
ms.author: genli
---

# Redeploy Linux virtual machine to new Azure node

If you face difficulties troubleshooting SSH or application access to a Linux virtual machine (VM) in Azure, redeploying the VM may help. When you redeploy a VM, it moves the VM to a new node within the Azure infrastructure and then powers it back on. All your configuration options and associated resources are retained. This article shows you how to redeploy a VM using Azure CLI or the Azure portal.

> [!Warning]
> After you redeploy a VM, all the data that you saved on the temporary disk and Ephemeral disk is lost. The dynamic IP addresses associated with virtual network interface are updated.

## Use the Azure CLI

Install the latest [Azure CLI](/cli/azure/install-az-cli2) and log in to your Azure account using [az login](/cli/azure/reference-index).

Redeploy your VM with [az vm redeploy](/cli/azure/vm). The following example redeploys the VM named *myVM* in the resource group named *myResourceGroup*:

```azurecli
az vm redeploy --resource-group myResourceGroup --name myVM 
```

## Use the Azure classic CLI

[!INCLUDE [classic-vm-deprecation](../../../includes/azure/classic-vm-deprecation.md)]

Install the [latest Azure classic CLI](/cli/azure/install-classic-cli) and log in to your Azure account. Make sure that you are in Resource Manager mode (`azure config mode arm`).

The following example redeploys the VM named *myVM* in the resource group named *myResourceGroup*:

```console
azure vm redeploy --resource-group myResourceGroup --vm-name myVM 
```

[!INCLUDE [virtual-machines-common-redeploy-to-new-node](../../../includes/azure/virtual-machines-common-redeploy-to-new-node.md)]

## Next steps

If you are having issues connecting to your VM, you can find specific help on [troubleshooting SSH connections](troubleshoot-ssh-connection.md) or [detailed SSH troubleshooting steps](detailed-troubleshoot-ssh-connection.md). If you cannot access an application running on your VM, you can also read [application troubleshooting issues](../virtual-machines/windows/troubleshoot-app-connection.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
