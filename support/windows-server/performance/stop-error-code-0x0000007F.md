---
title: Stop error code 0x0000007F
description: You receive a Stop error 0000007F (Error 0x7F, UNEXPECTED KERNEL MODE TRAP) error message, or your computer unexpectedly restarts.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, imranu
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
---
# You receive a "Stop error code 0x0000007F (UNEXPECTED_KERNEL_MODE_TRAP)" error message, or your computer unexpectedly restarts

This article helps to fix the error "Stop error code 0x0000007F (UNEXPECTED_KERNEL_MODE_TRAP)".  

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 822789

## Symptoms

When you run Symantec AntiVirus Corporate Edition 8.0 and NSI Software's Double-Take, you may experience one or both of the following symptoms:  

- You receive the following Stop error message:  
    >STOP 0x0000007F (0x00000008, 0x00000000, 0x00000000, 0x00000000) (UNEXPECTED_KERNEL_MODE_TRAP)

- Your computer unexpectedly restarts.

## Cause

This issue may occur when your computer lacks sufficient kernel space to process kernel-mode drivers. The programs that are mentioned in the "Symptoms" section of this article install a kernel-mode driver and use a filter driver that registers with the kernel stack.

When Symantec AntiVirus or Norton AntiVirus file system real-time protection examines a file for viruses, it requests file access from the file system. These file input/output (I/O) requests can add to the kernel space that your computer consumes.

## Resolution

To resolve this issue, add the KStackMinFree value to the registry. The KStackMinFree value specifies the minimum kernel space that must be available for Symantec AntiVirus or Norton AntiVirus file system real-time protection to request file I/O from the file system.  

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.  

## More information

For more information about "Stop x0000007F" error messages, click the following article number to view the article in the Microsoft Knowledge Base:

[137539](https://support.microsoft.com/help/137539) General causes of STOP 0x0000007F errors  

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.
