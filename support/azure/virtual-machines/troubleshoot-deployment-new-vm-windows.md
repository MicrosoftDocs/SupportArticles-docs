---
title: Troubleshoot Windows VM deployment in Azure
description: Troubleshoot Resource Manager deployment issues when you create a new Windows virtual machine in Azure
services: virtual-machines, azure-resource-manager
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: top-support-issue, azure-resource-manager
ms.service: virtual-machines
ms.subservice: vm-deploy
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting
ms.date: 06/15/2018
ms.author: genli
ms.custom: H1Hack27Feb2017

---
# Troubleshoot deployment issues when creating a new Windows VM in Azure

[!INCLUDE [virtual-machines-troubleshoot-deployment-new-vm-opening](../../includes/virtual-machines-troubleshoot-deployment-new-vm-opening-include.md)]

[!INCLUDE [support-disclaimer](../../includes/support-disclaimer.md)]

## Collect activity logs

To start troubleshooting, collect the activity logs to identify the error associated with the issue. The following links contain detailed information on the process to follow.

[View deployment operations](/azure/azure-resource-manager/templates/deployment-history)

[View activity logs to manage Azure resources](/azure/azure-resource-manager/management/view-activity-logs)

[!INCLUDE [virtual-machines-troubleshoot-deployment-new-vm-issue1](../../includes/virtual-machines-troubleshoot-deployment-new-vm-issue1-include.md)]

[!INCLUDE [virtual-machines-windows-troubleshoot-deployment-new-vm-table](../../includes/virtual-machines-windows-troubleshoot-deployment-new-vm-table.md)]

**Y:** If the OS is Windows generalized, and it is uploaded and/or captured with the generalized setting, then there won't be any errors. Similarly, if the OS is Windows specialized, and it is uploaded and/or captured with the specialized setting, then there won't be any errors.

**Upload Errors:**

**N<sup>1</sup>:** If the OS is Windows generalized, and it is uploaded as specialized, you will get a provisioning timeout error with the VM stuck at the OOBE screen.

**N<sup>2</sup>:** If the OS is Windows specialized, and it is uploaded as generalized, you will get a provisioning failure error with the VM stuck at the OOBE screen because the new VM is running with the original computer name, username and password.

**Resolution**

To resolve both these errors, use [Add-AzVhd to upload the original VHD](/powershell/module/az.compute/add-azvhd), available on-premises, with the same setting as that for the OS (generalized/specialized). To upload as generalized, remember to run sysprep first.

**Capture Errors:**

**N<sup>3</sup>:** If the OS is Windows generalized, and it is captured as specialized, you will get a provisioning timeout error because the original VM is not usable as it is marked as generalized.

**N<sup>4</sup>:** If the OS is Windows specialized, and it is captured as generalized, you will get a provisioning failure error because the new VM is running with the original computer name, username, and password. Also, the original VM is not usable because it is marked as specialized.

**Resolution**

To resolve both these errors, delete the current image from the portal, and [recapture it from the current VHDs](/azure/virtual-machines/windows/create-vm-specialized) with the same setting as that for the OS (generalized/specialized).

## Issue: Custom/gallery/marketplace image; allocation failure

This error arises in situations when the new VM request is pinned to a cluster that either cannot support the VM size being requested, or does not have available free space to accommodate the request.

**Cause 1:** The cluster cannot support the requested VM size.

**Resolution 1:**

* Retry the request using a smaller VM size.
* If the size of the requested VM cannot be changed:
  * Stop all the VMs in the availability set.
    Click **Resource groups** > *your resource group* > **Resources** > *your availability set* > **Virtual Machines** > *your virtual machine* > **Stop**.
  * After all the VMs stop, create the new VM in the desired size.
  * Start the new VM first, and then select each of the stopped VMs and click **Start**.

**Cause 2:** The cluster does not have free resources.

**Resolution 2:**

* Retry the request at a later time.
* If the new VM can be part of a different availability set
  * Create a new VM in a different availability set (in the same region).
  * Add the new VM to the same virtual network.

## Top issues

[!INCLUDE [support-disclaimer](../../includes/virtual-machines-windows-troubleshoot-deploy-vm-top.md)]

### The cluster cannot support the requested VM size

* Retry the request using a smaller VM size.
* If the size of the requested VM cannot be changed:
  * Stop all the VMs in the availability set. Click **Resource groups** > your resource group > **Resources** > your availability set > **Virtual Machines** > your virtual machine > **Stop**.
  * After all the VMs stop, create the VM in the desired size.
  * Start the new VM first, and then select each of the stopped VMs and click Start.

### The cluster does not have free resources

* Retry the request later.
* If the new VM can be part of a different availability set
  * Create a VM in a different availability set (in the same region).
  * Add the new VM to the same virtual network.

## FAQ

### How can I use and deploy a windows client image into Azure?

You can use Windows 7, Windows 8, or Windows 10 in Azure for dev/test scenarios if you have an appropriate Visual Studio (formerly MSDN) subscription. This [article](/azure/virtual-machines/windows/client-images) outlines the eligibility requirements for running Windows client in Azure and uses of the Azure Gallery images.

### How can I deploy a virtual machine using the Hybrid Use Benefit (HUB)?

There are a couple of different ways to deploy Windows virtual machines with the Azure Hybrid Use Benefit.

For an Enterprise Agreement subscription:

* Deploy VMs from specific Marketplace images that are pre-configured with Azure Hybrid Use Benefit.

For Enterprise agreement:

* Upload a custom VM and deploy using a Resource Manager template or Azure PowerShell.

For more information, see the following resources:

* [Azure Hybrid Use Benefit overview](https://azure.microsoft.com/pricing/hybrid-use-benefit/)
* [Downloadable FAQ](https://download.microsoft.com/download/4/2/1/4211AC94-D607-4A45-B472-4B30EDF437DE/Windows_Server_Azure_Hybrid_Use_FAQ_EN_US.pdf)
* [Azure Hybrid Use Benefit for Windows Server and Windows Client](/azure/virtual-machines/windows/hybrid-use-benefit-licensing).
* [How can I use the Hybrid Use Benefit in Azure](/archive/blogs/azureedu/how-can-i-use-the-hybrid-use-benefit-in-azure)

### How do I activate my monthly credit for Visual studio Enterprise (BizSpark)

To activate your monthly  credit, see this [article](https://azure.microsoft.com/offers/ms-azr-0064p/).

### How to add Enterprise Dev/Test to my Enterprise Agreement (EA) to get access to Window client images?

The ability to create subscriptions based on the Enterprise Dev/Test offer is restricted to Account Owners who have been given permission to do so by an Enterprise Administrator. The Account Owner creates subscriptions via the Azure Account Portal, and then should add active Visual Studio subscribers as co-administrators. So that they can manage and use the resources needed for development and testing. For more information, see [Enterprise Dev/Test](https://azure.microsoft.com/offers/ms-azr-0148p/).

### My drivers are missing for my Windows N-Series VM

Instructions to install drivers for Windows-based VMs are located [here](/azure/virtual-machines/sizes-gpu#supported-operating-systems-and-drivers).

### I can't find a GPU instance within my N-Series VM

To take advantage of the GPU capabilities of Azure N-series VMs, you must install graphics drivers on each VM after deployment. Driver setup information is available [here](/azure/virtual-machines/sizes-gpu#supported-operating-systems-and-drivers).

### Are N-Series VMs available in my region?

You can check the availability from the [Products available by region table](https://azure.microsoft.com/regions/services), and pricing [here](https://azure.microsoft.com/pricing/details/virtual-machines/series/#n-series).

### What client images can I use and deploy in Azure, and how to I get them?

You can use Windows 7, Windows 8, or Windows 10 in Azure for dev/test scenarios provided you have an appropriate Visual Studio (formerly MSDN) subscription.

* Windows 10 images are available from the Azure Gallery within [eligible dev/test offers](/azure/virtual-machines/windows/client-images#eligible-offers).
* Visual Studio subscribers within any type of offer can also [adequately prepare and create](/azure/virtual-machines/windows/prepare-for-upload-vhd-image) a 64-bit Windows 7, Windows 8, or Windows 10 image and then [upload to Azure](/azure/virtual-machines/windows/upload-generalized-managed). The use remains limited to dev/test by active Visual Studio subscribers.

This [article](/azure/virtual-machines/windows/client-images) outlines the eligibility requirements for running Windows client in Azure and use of the Azure Gallery images.

### I am not able to see VM Size family that I want when resizing my VM

When a VM is running, it is deployed to a physical server. The physical servers in Azure regions are grouped in clusters of common physical hardware. Resizing a VM that requires the VM to be moved to different hardware clusters is different depending on which deployment model was used to deploy the VM.

* VMs deployed in Classic deployment model, the cloud service deployment must be removed and redeployed to change the VMs to a size in another size family.

[!INCLUDE [classic-vm-deprecation](../../includes/classic-vm-deprecation.md)]

* VMs deployed in Resource Manager deployment model, you must stop all VMs in the availability set before changing the size of any VM in the availability set.

### The listed VM size is not supported while deploying in Availability Set

Choose a size that is supported on the availability set's cluster. It is recommended when creating an availability set to choose the largest VM size you think you need, and have that be your first deployment to the Availability set.

### Can I add an existing Classic VM to an availability set?

Yes. You can add an existing classic VM to a new or existing Availability Set. For more information see [Add an existing virtual machine to an availability set](/previous-versions/azure/virtual-machines/windows/classic/configure-availability-classic#addmachine).

## Additional Information

If you encounter issues when you start a stopped Windows VM or resize an existing Windows VM in Azure, see [Troubleshoot Resource Manager deployment issues with restarting or resizing an existing Windows Virtual Machine in Azure](restart-resize-error-troubleshooting.md).

## Next steps

* [Supportability of adding Azure VMs to an existing availability set](virtual-machines-availability-set-supportability.md)
* [Redeploy Windows virtual machine to new Azure node](redeploy-to-new-node-windows.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
