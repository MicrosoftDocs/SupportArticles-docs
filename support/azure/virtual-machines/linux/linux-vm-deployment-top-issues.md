---
title: Azure Linux virtual machine deployment top issues
description: Provides solutions to Azure Linux virtual machine deployment top issues.
ms.service: virtual-machines
ms.date: 06/03/2024
ms.custom: sap:Cannot create a VM, linux-related-content
ms.reviewer: srijangupta, scotro, jarrettr
---
# Azure Linux virtual machine deployment top issues

[!INCLUDE [support-disclaimer](../../../includes/azure/virtual-machines-linux-troubleshoot-deploy-vm-top.md)]

## The cluster cannot support the requested VM size

Retry the request using a smaller VM size. If the size of the requested VM cannot be changed, follow these steps:

1. Stop all the VMs in the availability set by selecting **Resource groups** > your resource group > **Resources** > your availability set > **Virtual Machines** > your virtual machine > **Stop**.
2. After all the VMs stop, create the VM in the desired size.
3. Start the new VM first, and then select each of the stopped VMs and select **Start**.

## The cluster does not have free resources

Retry the request later. If the new VM can be part of a different availability set, follow these steps:

1. Create a VM in a different availability set (in the same region).
1. Add the new VM to the same virtual network.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
