---
title: Updates are included in Windows Server images from Azure Marketplace
description: Discusses that updates are included in Windows Server images that are available on Azure Marketplace.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-support-statements
ms.collection: windows
---
# Updates are included in Windows Server images from Azure Marketplace

_Original product version:_ &nbsp; Windows Server 2019  
_Original KB number:_ &nbsp; 4046813

## Frequently asked questions

**When were Microsoft images updated to include the .NET Framework 4.7?**

The .NET Framework 4.7 was released in May and was made available on Windows Update as a Recommended update. Because the Windows Server images include both Important and Recommended updates, the images that were released after May included the .NET Framework 4.7.

**Was there any notification of the change?**

The Windows Server images include the latest Important and Recommended updates that were available at the time that the image was created. Because the included updates align with what is available on Windows Update (Important and Recommended updates), there was no notification about changes to the Windows Server images.

For information about the support policy for running Microsoft server software in the Azure virtual machine environment, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).

## More information

Windows Update on Windows 8, Windows Server 2012, and later Windows operating system has a new automatic restart setting. After installing updates, by default Windows Update will force the computer to restart in three days instead of 15 minutes.

For more information, see [Allow configuration of Automatic Updates in Windows 8 and Windows Server 2012](https://support.microsoft.com/help/2885694/allow-configuration-of-automatic-updates-in-windows-8-and-windows-serv).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
