---
title: The processor is not supported together with the Windows version error
description: Discusses an issue in which you receive a .
ms.date: 12/03/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Servicing
ms.technology: Depolyment
---
# "The processor is not supported together with the Windows version that you are currently using" error when you scan or download Windows updates

_Original product version:_ &nbsp; Windows 8.1, Windows 7, Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Standard, Windows Server 2012 R2 Foundation, Windows Server 2012 R2 Essentials, Windows Server 2008 R2 Datacenter, Windows Server 2008 R2 Enterprise, Windows Server 2008 R2 Standard, Windows Server 2008 R2 Foundation  
_Original KB number:_ &nbsp; 4012982

## Symptoms

When you try to scan or download updates through Windows Update, you receive the following error message: Unsupported hardware
Your PC uses a processor that is designed for the latest version of Windows. Because the processor is not supported together with the Windows version that you are currently using, your system will miss important security updates.  
 ﻿![error message](./media/processor-not-supported-together-with-windows-version/4016241_en_5.png)  

Additionally, you may see an error message in the Windows Update window that resembles the following:Windows could not search for new updates
An error occurred while checking for new updates for your computer.
Error(s) found:
Code 80240037 Windows Update encountered an unknown error.

## Cause

This error occurs when Windows detects an incompatible processor.

## Resolution

To ensure that Windows is compatible with the processor you are using, please refer to the following documentation: ["Windows Processor Requirements"](https://docs.microsoft.com/windows-hardware/design/minimum/windows-processor-requirements) 

## References

[Lifecycle support policy FAQ -Windows Products](https://support.microsoft.com/help/18581/lifecycle-support-policy-faq-windows-products#!en-us%2Fhelp%2F18581%2Flifecycle-support-policy-faq-windows-products%23b4) 
 [Windows 10 Embracing Silicon Innovation](https://blogs.windows.com/windowsexperience/2016/01/15/windows-10-embracing-silicon-innovation/#WuGVr4Uj39cf8MAE.97)  
 Third-party information disclaimer 

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
