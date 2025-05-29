---
title: 'VHD is not supported when you create a virtual machine in Azure'
description: This article helps correct VHD errors when running a virtual machine in Microsoft Azure.
services: virtual-machines
documentationCenter: ''
author: genlin
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.tgt_pltfrm: na
ms.workload: infrastructure
ms.date: 06/29/2020
ms.author: genli
ms.custom: sap:VM Admin - Windows (Guest OS)
---
# VHD is not supported when you create a virtual machine in Azure

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

This article helps correct VHD errors when running Virtual Machine in Windows or Linux.

## Symptoms

When you create a virtual machine in Microsoft Azure by using an uploaded VHD, the deployment fails and returns the following error message:

```
New-AzureRmVM : Long running operation failed with status 'Failed'.
ErrorCode: InvalidVhd
ErrorMessage: The specified cookie value in VHD footer indicates that disk 'diskname' with blob https://xxxxxx.blob.core.windows.net/vhds/samplename.vhd is not a supported VHD. Disk is expected to have cookie value 'conectix'.
```

## Cause

This problem occurs for one of the following reasons:

- The VHD does not comply with the 1-MB alignment (offset). The supported disk size should be 1 MB * N. For example, the disk should be 102,401 MB.
- The VHD has unallocated spaces. The unallocated spaces may not contain metadata or data, but their presence can complicate the conversion to a fixed disk and cause errors.
- The VHD is corrupted or not supported.

## Resolution

> [!NOTE]
> To perform the following fix, perform these steps prior to uploading the VHD into Azure.

To resolve this problem, resize the disk to comply with 1-MB alignment:

- To resolve the problem in Windows, use the [Resize-VHD PowerShell cmdlet](/powershell/module/hyper-v/resize-vhd). Note that **Resize-VHD** is not an Azure PowerShell cmdlet.

  1. [Install the Hyper-V role on Windows Server](/windows-server/virtualization/hyper-v/get-started/install-the-hyper-v-role-on-windows-server)
  1. [Convert the virtual disk to a fixed size VHD](/azure/virtual-machines/windows/prepare-for-upload-vhd-image#convert-the-virtual-disk-to-a-fixed-size-vhd)

- To resolve the problem in Linux, use the [qemu-img command](/azure/virtual-machines/linux/create-upload-generic).

For more information about how to create and upload a VHD for creating Azure VM, see the following articles:

- [Upload and create a Linux VM from custom disk image by using the Azure CLI 1.0](/azure/virtual-machines/linux/upload-vhd)
- [Create and upload a Windows Server VHD to Azure](/azure/virtual-machines/windows/upload-generalized-managed)

Continuing problems may indicate a corrupted VHD. In this situation, we recommend that you rebuild the VHD from scratch.

For more information, see the following article:

- [About VHD](/azure/virtual-machines/managed-disks-overview)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
