---
title: Can't upgrade Azure VM to contain more than 64 vCPUs
description: Describes an issue in which you cannot upgrade an Azure VM to a size that contains more than 64 vCPUs.
ms.date: 04/15/2024
ms.reviewer: 
ms.service: azure-virtual-machines
ms.custom: sap:Windows Update, Guest Patching and OS Upgrades
---
# Can't upgrade an Azure VM to a size that contains more than 64 vCPUs

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

_Original KB number:_ &nbsp; 4131519

[!INCLUDE [CentOS End Of Life](../../../includes/centos-end-of-life-note.md)]

## Symptoms

You may experience errors when you try to upgrade your VM to a size that contains more than 64 vCPU's, such as Standard_F72s_v2.

## Cause

This issue occurs if the operating system that runs on the VM doesn't support more than 64 vCPU's.  

More than 64 vCPU's require one of the following supported guest operating systems: Windows Server 2016, Ubuntu 16.04 LTS, SLES 12 SP2, Red Hat Enterprise Linux, CentOS 7.3, or Oracle Linux 7.3 with LIS 4.2.1.

For more information, see [Compute optimized virtual machine sizes](/azure/virtual-machines/windows/sizes-compute).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
