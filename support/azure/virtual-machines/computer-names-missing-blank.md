---
title: Computer names of specialized virtual machines are missing or blank in Azure
description: Fixes an issue in which computer names of virtual machines that use specialized disks are missing or blank in Azure.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-common-errors-issues
ms.collection: windows
---
# Computer names of specialized virtual machines are missing or blank in Azure

This article provides information to an issue in which computer names of virtual machines that use specialized disks are missing or blank in Azure.

_Original product version:_ &nbsp; Azure  
_Original KB number:_ &nbsp; 4018140

## Symptoms

When you examine the status of a virtual machine (VM) that uses a specialized disk through the Microsoft Azure portal, Azure PowerShell, or Azure CLI, you notice that the computer name of the VM is blank.  

Additionally, some OS profile properties such as **computerName**, **adminUsername**, and **adminPassword**, are set as read-only.  

## More information

Azure portal reads the computer name information from the **OSProfile** settings section of a VM.  

When you create a VM from an existing or specialized disk, the **OSProfile** settings section isn't included in the template. This is because it's used only during a VM setup for generalized images. Therefore, the computer name field is blank on the portal.

Additionally, you can't change the OS profile for an existing VM, and the properties are set correctly as read-only.  

## Status

Microsoft confirms that this is a limitation in the Azure platform. The effect of this limitation is limited to those who want the properties data to accurately reflect the values that are provided on the portal.  

> [!NOTE]
> Although the computer name field is blank, the VM name that's provided during resource creation is still displayed. Also, the host name is present inside the guest OS and is unchanged after the existing or specialized disk is first configured.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
