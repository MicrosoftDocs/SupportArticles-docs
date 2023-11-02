---
title: Uploaded VHD is not supported when you create a VM in Azure
description: Resolves an issue in which you receive an error message (Disk is expected to have cookie value conectix) when you try to create a virtual machine using an uploaded VHD.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-deploy
---
# Uploaded VHD is not supported when you create a VM in Azure

This article provides a solution to an issue in which you can't create a virtual machine using an uploaded VHD.

_Original product version:_ &nbsp; Virtual Machine running Windows, Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4053292

## Symptoms

When you create a virtual machine in Microsoft Azure by using an uploaded VHD, the deployment fails and returns the following error message:

> New-AzureRmVM : Long running operation failed with status 'Failed'.
>
> ErrorCode: InvalidVhd
>
> ErrorMessage: The specified cookie value in VHD footer indicates that disk 'diskname' with blob `https://xxxxxx.blob.core.windows.net/vhds/samplename.vhd` is not a supported VHD. Disk is expected to have cookie value 'conectix'.

## Cause  

This problem occurs for one of the following reasons:

- The VHD does not comply with the 1 MB alignment (offset). The supported disk size should be 1 MB * N. For example, the disk should be 102,401 MB.
- The VHD is corrupted or not supported.

## Resolution

To resolve this problem, resize the disk to comply with 1 MB alignment:

- In Windows, use the [Resize-VHD](/powershell/module/hyper-v/resize-vhd?view=win10-ps&preserve-view=true) PowerShell cmdlet.
    > [!NOTE]
    > **Resize-VHD** is not an Azure PowerShell cmdlet.
- In Linux, use the [qemu-img](/azure/virtual-machines/linux/create-upload-generic) command.

For more information about how to create and upload a VHD for creating Azure VM, see the following articles:

[Upload and create a Linux VM from custom disk image by using the Azure CLI 1.0](/azure/virtual-machines/linux/upload-vhd-nodejs)  

[Create and upload a Windows Server VHD to Azure](/azure/virtual-machines/windows/classic/createupload-vhd)

If the problem continues to occur, this may indicate a corrupted VHD. In this situation, we recommend that you rebuild the VHD from scratch. For more information, see the following articles:

- [About Windows VHD](/azure/virtual-machines/windows/about-disks-and-vhds#about-vhds)
- [About Linux VHD](/azure/virtual-machines/linux/about-disks-and-vhds#about-vhds)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
