---
title: Troubleshoot deploying Linux virtual machine issues in Azure | Microsoft Docs
description: Troubleshoot deploying Linux virtual machine issues in the Azure Resource Manager deployment model.
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
editor: ''
tags: azure-resource-manager
ms.service: virtual-machines
ms.collection: windows
ms.workload: infrastructure-services
ms.tgt_pltfrm: na
ms.topic: troubleshooting
ms.date: 11/01/2018
ms.author: genli

---
# Troubleshoot deploying Linux virtual machine issues in Azure

To troubleshoot virtual machine (VM) deployment issues in Azure, review the [top issues](#top-issues) for common failures and resolutions.

If you need more help at any point in this article, you can contact the Azure experts on [the MSDN Azure and Stack Overflow forums](https://azure.microsoft.com/support/forums/). Alternatively, you can file an Azure support incident. Go to the [Azure support site](https://azure.microsoft.com/support/options/) and select **Get Support**.

## Top issues
[!INCLUDE [virtual-machines-linux-troubleshoot-deploy-vm-top](../../includes/virtual-machines-linux-troubleshoot-deploy-vm-top.md)]

## The cluster cannot support the requested VM size
\<properties
supportTopicIds="123456789"
resourceTags="windows"
productPesIds="1234, 5678"
/>
- Retry the request using a smaller VM size.
- If the size of the requested VM cannot be changed:
    - Stop all the VMs in the availability set. Click **Resource groups** > your resource group > **Resources** > your availability set > **Virtual Machines** > your virtual machine > **Stop**.
    - After all the VMs stop, create the VM in the desired size.
    - Start the new VM first, and then select each of the stopped VMs and click Start.


## The cluster does not have free resources
\<properties
supportTopicIds="123456789"
resourceTags="windows"
productPesIds="1234, 5678"
/>
- Retry the request later.
- If the new VM can be part of a different availability set
    - Create a VM in a different availability set (in the same region).
    - Add the new VM to the same virtual network.

## How do I activate my monthly credit for Visual studio Enterprise (BizSpark)

To activate your monthly  credit, see this [article](https://azure.microsoft.com/offers/ms-azr-0064p/).

## Why can I not install the GPU driver for an Ubuntu NV VM?

Currently, Linux GPU support is only available on Azure NC VMs running Ubuntu Server 16.04 LTS. For more information, see [Set up GPU drivers for N-series VMs running Linux](/azure/virtual-machines/linux/n-series-driver-setup).

## My drivers are missing for my Linux N-Series VM

Instructions to install drivers for Linux-based VMs are located [here](/azure/virtual-machines/sizes-gpu#supported-operating-systems-and-drivers).

## I can’t find a GPU instance within my N-Series VM

To take advantage of the GPU capabilities of Azure N-series VMs, you must install graphics drivers on each VM after deployment. Driver setup information is available [here](/azure/virtual-machines/sizes-gpu#supported-operating-systems-and-drivers).

## Are N-Series VMs available in my region?

You can check the availability from the [Products available by region table](https://azure.microsoft.com/regions/services), and pricing [here](https://azure.microsoft.com/pricing/details/virtual-machines/series/#n-series).

## I am not able to see VM Size family that I want when resizing my VM.

When a VM is running, it is deployed to a physical server. The physical servers in Azure regions are grouped in clusters of common physical hardware. Resizing a VM that requires the VM to be moved to different hardware clusters is different depending on which deployment model was used to deploy the VM.

- VMs deployed in Classic deployment model, the cloud service deployment must be removed and redeployed to change the VMs to a size in another size family.

- VMs deployed in Resource Manager deployment model, you must stop all VMs in the availability set before changing the size of any VM in the availability set.

## The listed VM size is not supported while deploying in Availability Set.

Choose a size that is supported on the availability set's cluster. It is recommended when creating an availability set to choose the largest VM size you think you need, and have that be your first deployment to the Availability set.

## What Linux distributions/versions are supported on Azure?

You can find the list at Linux on [Azure-Endorsed Distributions](/azure/virtual-machines/linux/endorsed-distros).

## Can I add an existing Classic VM to an availability set?

Yes. You can add an existing classic VM to a new or existing Availability Set. For more information see [Add an existing virtual machine to an availability set](/previous-versions/azure/virtual-machines/windows/classic/configure-availability-classic#addmachine).

[!INCLUDE [classic-vm-deprecation](../../includes/classic-vm-deprecation.md)]

## Next steps
If you need more help at any point in this article, you can contact the Azure experts on [the MSDN Azure and Stack Overflow forums](https://azure.microsoft.com/support/forums/).

Alternatively, you can file an Azure support incident. Go to the [Azure support site](https://azure.microsoft.com/support/options/) and select **Get Support**.
