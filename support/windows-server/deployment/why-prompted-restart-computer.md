---
title: Why may be prompted to restart computer
description: Describes why you may be prompted to restart your computer when you install a Microsoft security update on a computer that is running a version of Microsoft Windows.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, rhensing
ms.custom: sap:servicing, csstroubleshoot
ms.subservice: deployment
---
# Why you may be prompted to restart your computer after you install a security update on a Windows-based computer

This article describes why you may be prompted to restart your Microsoft Windows-based computer after you install a security update.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 887012

## Why you may be prompted to restart your computer

After you install a security update, you may be prompted to restart your computer if one of the following conditions is true:

- The security update updates a DLL that is loaded in one or more processes that are required by Windows. The security update can't be completed while the DLL is loaded. So the security update must stop the process that causes the DLL to be loaded. Stopping the process will unload the DLL that is required to complete the update. However, the process in which the DLL is loaded can't be stopped while Windows is running. For example, the security update that is described in security bulletin MS04-011 updates many DLLs that are loaded in core operating system processes that can't be stopped without shutting down Windows.
- The security update updates an .exe file that is currently running as a process that is required by Windows. The update can't be completed while this process is running. However, you can't force this process to stop unless you shut down Windows. For example, Csrss.exe is a required process in Windows.
- The security update updates a device driver that is currently being used and that is required by Windows. The update can't be completed while this device driver is being used. However, you can't unload this device driver unless you shut down Windows. For example, Disk.sys is a device driver that is required by Windows.
- The security update makes changes to the registry. These changes require that you restart your computer.
- The security update makes changes to registry entries that are read only when you start your computer.

## How to reduce your chances of being prompted to restart your computer

To reduce your chances of being prompted to restart your computer after you install a security update, you can try to end the processes use the files that are being updated by the security update.

To determine whether files that are being updated by a security update are being used by your computer, you can use Process Explorer from Sysinternals to examine how the files are being used and by what processes they're being used. You may be able to stop the services or to end the processes that are using the files. For more information about Process Explorer, see [Windows Sysinternals](/sysinternals/).

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft doesn't guarantee the accuracy of this third-party contact information.  

Except for our own products, Microsoft doesn't support or recommend this product over others in the same area. We provide this information only as a convenience for our customers and, excepting our own products, don't provide warranties of any kind, either express or implied. The warranties that we don't provide include but aren't limited to the implied warranties of merchantability or fitness for a particular purpose.

## How to suppress the message to restart your computer

To suppress the message to restart your computer, use a command-line switch. The command-line switch that you use depends on the installer that is used by the security update. For more information about command-line switches for Windows and IExpress software update packages, see [How does Windows Update work?](/windows/deployment/update/how-windows-update-works)

When you use Windows Installer, a security update that uses the .msi or the .msp file name extension is installed on your computer. For more information about command-line options, see [Command-Line Options](/windows/win32/msi/command-line-options).

> [!IMPORTANT]
> In certain cases, you must restart your computer to fully apply the security update. Your computer may remain vulnerable if the security update isn't fully applied.

## Technical support for x64-based versions of Microsoft Windows

Your hardware manufacturer provides technical support and assistance for x64-based versions of Windows. Your hardware manufacturer provides support because an x64-based version of Windows was included with your hardware. Your hardware manufacturer might have customized the installation of Windows with unique components. Unique components might include specific device drivers or might include optional settings to maximize the performance of the hardware. Microsoft will provide reasonable-effort assistance if you need technical help with your x64-based version of Windows. However, you might have to contact your manufacturer directly. Your manufacturer is best qualified to support the software that your manufacturer installed on the hardware.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

### Applies To

This article applies to all currently supported Microsoft operating systems.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
