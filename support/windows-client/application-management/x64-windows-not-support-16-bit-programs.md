---
title: 64-bit versions of Windows don't support 16-bit components, 16-bit processes, or 16-bit applications
description: Discusses the lack of support for 16-bit components, 16-bit processes, or 16-bit applications in x64-based versions Windows Server 2003 and Windows XP Professional x64 Edition.
ms.data: 09/08/2020
author: Deland-Han
ms.author: Deland-Han
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: 1st Party Applications
ms.technology: ApplicationCompatibility
---
# 64-bit versions of Windows don't support 16-bit components, 16-bit processes, or 16-bit applications

This article discusses the lack of support for 16-bit components, 16-bit processes, or 16-bit applications in x64-based versions Windows Server 2003 and Windows XP Professional x64 Edition.

_Original product version:_ &nbsp;Window 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp;896458

## Summary

The x64-based versions of the Microsoft Windows Server 2003 operating systems and Microsoft Windows XP Professional x64 Edition don't support 16-bit programs, 16-bit processes, or 16-bit components. However, these 64-bit versions of Windows may recognize some 16-bit installers and automatically convert the 16-bit installer to a 32-bit installer.

## More information

To run a 16-bit program or a 32-bit program that uses 16-bit processes or 16-bit components, you must install the program on a 32-bit version of Windows. To run such a program, you can install a 32-bit version of Windows in a dual-boot configuration with the 64-bit version of Windows. Then, you can restart your computer to the 32-bit version of Windows and install the 16-bit program or 32-bit program that uses 16-bit processes or 16-bit components.

> [!NOTE]
> The 32-bit version of Windows must be installed on a separate disk volume or separate physical hard disk to function correctly. If you install a 32-bit version of Windows and a 64-bit version of Windows on the same disk volume, your computer may stop responding.

For more information about dual-boot configurations with 64-bit versions of Windows, click the following article number to view the article in the Microsoft Knowledge Base:

[896455](https://support.microsoft.com/help/896455) Programs become unstable or do not start after you install a 64-bit version of Windows on the same partition as a 32-bit version of Windows  

> [!NOTE]
> You should upgrade critical 32-bit programs to a 64-bit version to take full advantage of the 64-bit hardware and the 64-bit version of Windows.

### Technical support for Windows x64 editions

Your hardware manufacturer provides technical support and assistance for Microsoft Windows x64 editions. Your hardware manufacturer provides support because a Windows x64 edition was included with your hardware. Your hardware manufacturer might have customized the Windows x64 edition installation with unique components. Unique components might include specific device drivers or might include optional settings to maximize the performance of the hardware. Microsoft will provide reasonable-effort assistance if you need technical help with your Windows x64 edition. However, you might have to contact your manufacturer directly. Your manufacturer is best qualified to support the software that your manufacturer installed on the hardware.

For product information about Microsoft Windows XP Professional x64 Edition, visit the following Microsoft Web site: [https://www.microsoft.com/windowsxp/64bit/default.mspx](https://www.microsoft.com/windowsxp/64bit/default.mspx)

For product information about Microsoft Windows Server 2003 x64 editions, visit the following Microsoft Web site: [https://www.microsoft.com/windowsserver2003/64bit/x64/editions.mspx](https://www.microsoft.com/windowsserver2003/64bit/x64/editions.mspx)
