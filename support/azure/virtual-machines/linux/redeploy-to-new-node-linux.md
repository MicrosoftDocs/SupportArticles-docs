---
title: Redeploy Linux Virtual Machines in Azure
description: How to redeploy Linux virtual machines in Azure to mitigate SSH connection issues.
services: virtual-machines
documentationcenter: virtual-machines
author: genlin
manager: dcscontentpm
tags: azure-resource-manager,top-support-issue
ms.custom: sap:VM Admin - Linux (Guest OS), devx-track-azurecli, linux-related-content
ms.service: azure-virtual-machines
ms.collection: linux
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-linux
ms.workload: infrastructure
ms.date: 07/22/2024
ms.author: genli
---

# Redeploy Linux virtual machine to new Azure node

**Applies to:** :heavy_check_mark: Linux VMs

If you face difficulties troubleshooting SSH or application access to a Linux virtual machine (VM) in Azure, redeploying the VM may help. When you redeploy a VM, it moves the VM to a new node within the Azure infrastructure and then powers it back on. All your configuration options and associated resources are retained. This article shows you how to redeploy a VM using Azure CLI or the Azure portal.

> [!Warning]
> After you redeploy a VM, all the data that you saved on the temporary disk and Ephemeral disk is lost. The dynamic IP addresses associated with virtual network interface are updated.

## Use the Azure CLI

Install the latest [Azure CLI](/cli/azure/install-az-cli2) and log in to your Azure account using [az login](/cli/azure/reference-index).

Redeploy your VM with [az vm redeploy](/cli/azure/vm). The following example redeploys the VM named *myVM* in the resource group named *myResourceGroup*:

```azurecli
az vm redeploy --resource-group myResourceGroup --name myVM 
```

[!INCLUDE [virtual-machines-common-redeploy-to-new-node](../../../includes/azure/virtual-machines-common-redeploy-to-new-node.md)]

## Next steps

If you are having issues connecting to your VM, you can find specific help on [troubleshooting SSH connections](troubleshoot-ssh-connection.md) or [detailed SSH troubleshooting steps](detailed-troubleshoot-ssh-connection.md). If you cannot access an application running on your VM, you can also read [application troubleshooting issues](../windows/troubleshoot-app-connection.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
