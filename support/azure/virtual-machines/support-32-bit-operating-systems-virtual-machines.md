---
title: Support for 32-bit operating systems in Azure virtual machines
description: Information about operating systems that are supported on Azure virtual machines
services: virtual-machines, azure-resource-manager
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: top-support-issue, azure-resource-manager
ms.service: virtual-machines
ms.subservice: vm-support-statements
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting
ms.date: 04/25/2023
ms.author: genli
---

# Support for 32-bit operating systems in Azure virtual machines

Microsoft Azure now allows users to bring in their 32-bit Windows operating systems over to Azure. Only Specialized VHDs are supported and Generalized images won't work in Azure. As some of these operating systems have already reached their end of life supportability agreement, Microsoft might not offer additional support for them. Support is also not offered for Linux-based, or Berkeley Software Distribution (BSD)-based operating systems that run on a Microsoft Azure virtual machine (VM).

> [!NOTE]
> - Azure platform has a memory address space limitation imposed on VMs running 32-bit operating systems where only 1GB of memory might be made available to the VM (*especially on client SKUs like Windows 7 or Windows 10*), and the rest of the memory for the VM will show as reserved within the guest VM. This is a known issue and we currently do not have an ETA for a fix. We recommend moving to 64-bit operating system versions.
> - Linux and Windows VM Guest Agent doesn't support 32-bit operating systems. VM extensions such as Azure Backup and Azure Monitor Agent don't work on 32-bit operating systems because they require VM Guest Agent.

## More information

For more information about operating systems that are supported on Azure virtual machines, go to the following Microsoft Knowledge Base articles:

* [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines)
* [Support for Linux and open source technology in Azure](https://support.microsoft.com/help/2941892/support-for-linux-and-open-source-technology-in-azure)

## References

* [Learn more about free Extended Security Updates for Windows Server 2008/R2 in Azure](https://www.microsoft.com/cloud-platform/windows-server-2008)
* [Learn more about support for Windows Server 2008 SP2 32-bit specialized images in Azure](/windows-server/get-started/uploading-specialized-ws08-image-to-azure)
* [Learn more about support for migration of Windows Server 2008 images to Azure using Azure Site Recovery](/azure/site-recovery/migrate-tutorial-windows-server-2008)
* [Learn more about Azure Extension supported operating systems](https://support.microsoft.com/help/4078134/azure-extension-supported-operating-systems)
* [Learn more about running Windows Server 2003 on Microsoft Azure](https://support.microsoft.com/help/3206074/running-windows-server-2003-on-microsoft-azure)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
