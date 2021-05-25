---
title: Troubleshoot Linux VM deployment| Microsoft Docs
description: Troubleshoot Resource Manager deployment issues when you create a new Linux virtual machine in Azure
services: virtual-machines, azure-resource-manager
documentationcenter: ''
author: DavidCBerry13
manager: dcscontentpm
editor: ''
tags: top-support-issue, azure-resource-manager
ms.service: virtual-machines
ms.collection: linux
ms.workload: na
ms.tgt_pltfrm: vm-linux
ms.topic: troubleshooting
ms.date: 09/09/2016
ms.author: daberry

---
# Troubleshoot deployment issues when creating a new Linux VM in Azure

[!INCLUDE [virtual-machines-troubleshoot-deployment-new-vm-opening](../../includes/virtual-machines-troubleshoot-deployment-new-vm-opening-include.md)]

[!INCLUDE [support-disclaimer](../../includes/support-disclaimer.md)]

## Collect activity logs

To start troubleshooting, collect the activity logs to identify the error associated with the issue. The following links contain detailed information on the process to follow.

[View deployment operations](/azure/azure-resource-manager/templates/deployment-history)

[View activity logs to manage Azure resources](/azure/azure-resource-manager/management/view-activity-logs)

[!INCLUDE [virtual-machines-troubleshoot-deployment-new-vm-issue1](../../includes/virtual-machines-troubleshoot-deployment-new-vm-issue1-include.md)]

[!INCLUDE [virtual-machines-linux-troubleshoot-deployment-new-vm-table](../../includes/virtual-machines-linux-troubleshoot-deployment-new-vm-table.md)]

**Y:** If the OS is Linux generalized, and it is uploaded and/or captured with the generalized setting, then there won’t be any errors. Similarly, if the OS is Linux specialized, and it is uploaded and/or captured with the specialized setting, then there won’t be any errors.

**Upload Errors:**

**N<sup>1</sup>:** If the OS is Linux generalized, and it is uploaded as specialized, you will get a provisioning timeout error because the VM is stuck at the provisioning stage.

**N<sup>2</sup>:** If the OS is Linux specialized, and it is uploaded as generalized, you will get a provisioning failure error because the new VM is running with the original computer name, username and password.

**Resolution:**

To resolve both these errors, upload the original VHD, available on premises, with the same setting as that for the OS (generalized/specialized). To upload as generalized, remember to run -deprovision first.

**Capture Errors:**

**N<sup>3</sup>:** If the OS is Linux generalized, and it is captured as specialized, you will get a provisioning timeout error because the original VM is not usable as it is marked as generalized.

**N<sup>4</sup>:** If the OS is Linux specialized, and it is captured as generalized, you will get a provisioning failure error because the new VM is running with the original computer name, username and password. Also, the original VM is not usable because it is marked as specialized.

**Resolution:**

To resolve both these errors, delete the current image from the portal, and [recapture it from the current VHDs](/azure/virtual-machines/linux/capture-image) with the same setting as that for the OS (generalized/specialized).

## Issue: Custom/ gallery/ marketplace image; allocation failure

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

[!INCLUDE [support-disclaimer](../../includes/virtual-machines-linux-troubleshoot-deploy-vm-top.md)]

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

### How do I activate my monthly credit for Visual studio Enterprise (BizSpark)

To activate your monthly  credit, see this [article](https://azure.microsoft.com/offers/ms-azr-0064p/).

### Why can I not install the GPU driver for an Ubuntu NV VM?

Currently, Linux GPU support is only available on Azure NC VMs running Ubuntu Server 16.04 LTS. For more information, see [Set up GPU drivers for N-series VMs running Linux](/azure/virtual-machines/linux/n-series-driver-setup).

### My drivers are missing for my Linux N-Series VM

Instructions to install drivers for Linux-based VMs are located [here](/azure/virtual-machines/sizes-gpu#supported-operating-systems-and-drivers).

### I can’t find a GPU instance within my N-Series VM

To take advantage of the GPU capabilities of Azure N-series VMs, you must install graphics drivers on each VM after deployment. Driver setup information is available [here](/azure/virtual-machines/sizes-gpu#supported-operating-systems-and-drivers).

### Are N-Series VMs available in my region?

You can check the availability from the [Products available by region table](https://azure.microsoft.com/regions/services), and pricing [here](https://azure.microsoft.com/pricing/details/virtual-machines/series/#n-series).

### I''m not able to see VM Size family that I want when resizing my VM

When a VM is running, it is deployed to a physical server. The physical servers in Azure regions are grouped in clusters of common physical hardware. Resizing a VM that requires the VM to be moved to different hardware clusters is different depending on which deployment model was used to deploy the VM.

* VMs deployed in Classic deployment model, the cloud service deployment must be removed and redeployed to change the VMs to a size in another size family.

* VMs deployed in Resource Manager deployment model, you must stop all VMs in the availability set before changing the size of any VM in the availability set.

### The listed VM size is not supported while deploying in Availability Set

Choose a size that is supported on the availability set's cluster. It is recommended when creating an availability set to choose the largest VM size you think you need, and have that be your first deployment to the Availability set.

### What Linux distributions/versions are supported on Azure?

You can find the list at Linux on [Azure-Endorsed Distributions](/azure/virtual-machines/linux/endorsed-distros).

### Can I add an existing Classic VM to an availability set?

Yes. You can add an existing classic VM to a new or existing Availability Set. For more information see [Add an existing virtual machine to an availability set](/previous-versions/azure/virtual-machines/windows/classic/configure-availability-classic#addmachine).

[!INCLUDE [classic-vm-deprecation](../../includes/classic-vm-deprecation.md)]

## Next steps

* [Supportability of adding Azure VMs to an existing availability set](/azure/virtual-machines/virtual-machines-availability-set-supportability)
* [Redeploy Linux virtual machine to new Azure node](/azure/virtual-machines/redeploy-to-new-node-linux)
