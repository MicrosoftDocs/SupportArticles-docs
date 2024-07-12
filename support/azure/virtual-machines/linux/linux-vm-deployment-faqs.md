---
title: FAQs about Linux virtual machine deployment
description: Answers frequently asked questions about Linux virtual machine deployment.
ms.service: virtual-machines
ms.date: 06/24/2024
ms.custom: sap:Cannot create a VM, linux-related-content
ms.reviewer: srijangupta, scotro, jarrettr
---
# Linux virtual machine deployment FAQs

**Applies to:** :heavy_check_mark: Linux VMs

## How do I activate my monthly credit for Visual studio Enterprise (BizSpark)

To activate your monthly credit, see [Microsoft Azure Offer Details](https://azure.microsoft.com/offers/ms-azr-0064p/).

## Why can I not install the GPU driver for an Ubuntu NV VM?

Currently, Linux GPU support is only available on Azure NC VMs running Ubuntu Server 16.04 LTS. For more information, see [Set up GPU drivers for N-series VMs running Linux](/azure/virtual-machines/linux/n-series-driver-setup).

## My drivers are missing for my Linux N-Series VM

For instructions to install drivers for Linux-based VMs, see [GPU accelerated](/azure/virtual-machines/sizes-gpu#supported-operating-systems-and-drivers).

## I can't find a GPU instance within my N-Series VM

To take advantage of the GPU capabilities of Azure N-series VMs, you must install graphics drivers on each VM after deployment. For more information about driver setup, see [GPU accelerated](/azure/virtual-machines/sizes-gpu#supported-operating-systems-and-drivers).

## Are N-Series VMs available in my region?

You can check the availability from the [Products available by region table](https://azure.microsoft.com/regions/services), and pricing from [N-Series](https://azure.microsoft.com/pricing/details/virtual-machines/series/#n-series).

## I'm not able to see VM Size family that I want when resizing my VM

When a VM is running, it is deployed to a physical server. The physical servers in Azure regions are grouped in clusters of common physical hardware. Resizing a VM that requires the VM to be moved to different hardware clusters is different depending on which deployment model was used to deploy the VM.

- VMs deployed in Classic deployment model, the cloud service deployment must be removed and redeployed to change the VMs to a size in another size family.

- VMs deployed in Resource Manager deployment model, you must stop all VMs in the availability set before changing the size of any VM in the availability set.

## The listed VM size is not supported while deploying in Availability Set

Choose a size that is supported on the availability set's cluster. It is recommended when creating an availability set to choose the largest VM size you think you need, and have that be your first deployment to the Availability set.

## What Linux distributions/versions are supported on Azure?

You can find the list at Linux on [Azure-Endorsed Distributions](/azure/virtual-machines/linux/endorsed-distros).

## Can I add an existing Classic VM to an availability set?

Yes. You can add an existing classic VM to a new or existing Availability Set. For more information see [Add an existing virtual machine to an availability set](/previous-versions/azure/virtual-machines/windows/classic/configure-availability-classic#addmachine).

[!INCLUDE [classic-vm-deprecation](../../../includes/azure/classic-vm-deprecation.md)]

## Next steps

- [Supportability of adding Azure VMs to an existing availability set](../windows/virtual-machines-availability-set-supportability.md)
- [Redeploy Linux virtual machine to new Azure node](redeploy-to-new-node-linux.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]