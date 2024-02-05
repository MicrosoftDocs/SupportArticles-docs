---
title: A description of the driver
description: Describes the device driver requirements for x64-based versions of Windows.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, joeswart
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# A description of the driver

This article describes the device driver requirements for x64-based versions of Windows.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 896333

## Summary

x64-based versions of Microsoft Windows Server 2003 and Microsoft Windows XP Professional x64 Edition require 64-bit device drivers for hardware devices and peripherals. The requirement for 64-bit drivers applies to kernel mode components and to user mode components.

## More information

Drivers for devices such as printers, cameras, and scanners are typically user mode components and require 64-bit drivers. Additionally, the drivers that are included in Windows Server 2003 Service Pack 1 aren't the same for x86-based and for x64-based versions of Windows. Therefore, devices where 32-bit Microsoft Windows Server 2003 drivers are available might not have 64-bit drivers available for x64-based versions of Windows.

Itanium-based 64-bit drivers aren't compatible with x64-based versions of Windows because they're compiled specifically for the Itanium operating system. Drivers that are written for Itanium-based computers will not install correctly on x64-based versions of Windows.

To obtain device drivers that aren't included on the installation CD for x64-based versions of Windows, use these methods in the following order:
- Method 1 On the Microsoft Windows Update Web site, search for a driver that is certified by the Windows Hardware Quality Labs (WHQL). To search for a WHQL-certified driver, select **Start**, select **Windows Update**, and then follow the instructions on the Windows Update Web site. Alternatively, you can visit the following Microsoft Web site:  
   [https://update.microsoft.com](https://update.microsoft.com) 

- Method 2 
Obtain a WHQL-certified driver from the device manufacturer's Web site. For information about how to search for a WHQL-certified driver on the device manufacturer's Web site, contact your device manufacturer.
- Method 3 Obtain a beta or non-WHQL-certified driver from the device manufacturer.

> [!IMPORTANT]
> We do not recommend drivers that are not WHQL-certified. Microsoft cannot guarantee the compatibility of device drivers that are not WHQL-certified.Drivers that are not WHQL-certified are known as unsigned drivers. Drivers that are WHQL-certified are known as signed drivers.

> [!NOTE]
> It is the responsibility of the specific hardware or software vendor to make sure that programs and device drivers are compatible with x64-based versions of Windows.

If you experience problems when you try to install a 64-bit driver that isn't included with 64-bit versions of Windows, make sure that the driver's .inf file is correctly decorated.

### Technical support for Windows x64 editions

Your hardware manufacturer provides technical support and assistance for Microsoft Windows x64 editions. Your hardware manufacturer provides support because a Windows x64 edition was included with your hardware. Your hardware manufacturer might have customized the Windows x64 edition installation with unique components. Unique components might include specific device drivers or might include optional settings to maximize the performance of the hardware. Microsoft will provide reasonable-effort assistance if you need technical help with your Windows x64 edition. However, you might have to contact your manufacturer directly. Your manufacturer is best qualified to support the software that your manufacturer installed on the hardware.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
