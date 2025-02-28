---
title: Computer names of specialized virtual machines are missing or blank in Azure
description: Fixes an issue in which computer names of virtual machines that use specialized disks are missing or blank in Azure.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:VM Admin - Windows (Guest OS)
---
# Computer names of specialized virtual machines are missing or blank in Azure

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

_Original KB number:_ &nbsp; 4018140

This article provides information to an issue in which computer names of virtual machines that use specialized disks are missing or blank in Azure.

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

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
