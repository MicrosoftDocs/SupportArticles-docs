---
title: The default size of Windows Server images in Azure is changed from 128 GB to 30 GB
description: Provides a workaround to an issue in which the default size of Windows Server images in Azure is changed from 128 GB to 30 GB.
ms.date: 07/21/2020
ms.prod-support-area-path: 
ms.reviewer: scotro
ms.service: virtual-machines
ms.collection: windows
---
# The default size of Windows Server images in Azure is changed from 128 GB to 30 GB

This article provides a workaround to an issue in which the default size of Windows Server images in Azure is changed from 128 GB to 30 GB.

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4018933

## Symptoms

When you deploy a Windows Server virtual machine (VM) in Microsoft Azure, the default size of the OS disk is 30 GB instead of 128 GB, as expected. This behavior occurs regardless of whether the disk is managed or unmanaged.

## Cause

Microsoft Azure recently updated the initial size of a virtual hard disk (VHD) to 30 GB for all existing Windows Server images. This change was connected to the public release of Microsoft Azure Managed Disks. Before the release, the default OS disk size was 128 GB.

Microsoft Azure is planning to roll back this change in an update that is currently under deployment.

## Workaround

If you have to expand the OS disk of the VM, follow the steps in this article:
[How to expand the OS drive of a Virtual Machine in an Azure Resource Group](https://docs.microsoft.com/azure/virtual-machines/windows/expand-os-disk)

When you enable Azure Disk Encryption on your Azure VM, the process shrinks your existing OS partition a small amount to implement the System Reserved partition. The System Reserved partition is put at the end of the OS disk. When you resize the OS disk, the free space is added after the System Reserved partition.

When you try to expand the OS partition, you are forced you to create another partition. This is because you have the System Reserved partition between the OS partition and the free space. You cannot move the System Reserved partition to the end of the disk by using the Windows built-in tools. To resolve this issue, deploy a new VM that provides the required post-encryption disk space, and then migrate your workflow. 

## More information

The price of Azure Managed Disks is based on the size of the disk. The minimum size is 32 GB. For managed disks, disk size is an important factor in the cost of running the VM. 

For more information, see this article: [Managed Disks Pricing](https://azure.microsoft.com/pricing/details/managed-disks/)
