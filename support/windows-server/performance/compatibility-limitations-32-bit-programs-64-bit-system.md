---
title: Overview of the compatibility considerations for 32-bit programs on 64-bit versions of Windows
description: Discusses the compatibility considerations and limitations for 32-bit programs that are running on 64-bit versions of Windows .
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:applications, csstroubleshoot
---
# Overview of the compatibility considerations for 32-bit programs on 64-bit versions of Windows

This article discusses the compatibility considerations and limitations for 32-bit programs that are running on 64-bit versions of Windows.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 896456

## Summary

The 64-bit versions of Windows use the Microsoft Windows-32-on-Windows-64 (WOW64) subsystem to run 32-bit programs without modifications. The 64-bit versions of Windows don't provide support for 16-bit binaries or 32-bit drivers. Programs that depend on 16-bit binaries or 32-bit drivers can't run on the 64-bit versions of Windows unless the program manufacturer provides an update for the program.

There may be considerations that affect a program's compatibility or performance. You can determine whether a program will have compatibility or performance issues by testing the program on one of the 64-bit versions of Windows.

This article describes some of the compatibility considerations for running 32-bit programs on the 64-bit versions of Windows. This article doesn't compare the 32-bit and 64-bit versions of Windows, or different 64-bit operating systems. This article assumes that you understand the difference between 32-bit binaries and 64-bit binaries.

## Introduction

The x64-based versions of Microsoft Windows are optimized to run native 64-bit programs. Additionally, the x64-based versions of Windows use the WOW64 subsystem to run 32-bit programs.

## Running 32-bit programs

The WOW64 subsystem enables 32-bit programs to run without modification on the x64-based versions of Windows. The WOW64 subsystem does this by creating a 32-bit environment on the x64-based versions of Windows. For more information about the WOW64 subsystem, see the "Running 32-bit Applications" topic in the 64-Bit Windows section of the Microsoft Platform SDK documentation. To view this document, visit the following Microsoft Web site: [Running 32-bit Applications](/windows/win32/winprog64/running-32-bit-applications).  

## Program performance considerations

The WOW64 subsystem creates a 32-bit environment on the x64-based versions of Windows. Some 32-bit programs may run slower on these operating systems than they would on 32-bit versions of Windows. Alternatively, some 32-bit programs that require lots of memories may exhibit increased performance on the x64-based versions of Windows. This performance increase occurs because the x64-based versions of Windows supports more physical memory than the 32-bit versions of Windows.

For more information about the differences in memory management between the 64-bit and 32-bit versions of Windows, see the "Virtual Address Space" topic in the About Memory Management section of the Microsoft Platform SDK documentation. To view this document, visit the following Microsoft Web site: [Virtual Address Space](/windows/win32/memory/virtual-address-space)  

## Restrictions of the WOW64 subsystem

The WOW64 subsystem doesn't support the following programs:

- Programs that are compiled for 16-bit operating systems
- Kernel-mode programs that are compiled for 32-bit operating systems

### 16-bit programs

The x64-based versions of Windows doesn't support 16-bit programs or 16-bit program components. The software emulation that is required to run 16-bit programs on the x64-based version of Windows would significantly decrease the performance of those programs.

A 16-bit installer is frequently used to install and configure a 32-bit program. Additionally, some 32-bit programs require 16-bit components to run correctly. Although 32-bit programs that require 16-bit components might run correctly after they're installed, you can't use the 16-bit installer to install a 32-bit program. Programs that require 16-bit components can't run on x64-based versions of Windows.

If a 32-bit program that requires 16-bit components tries to run a 16-bit file or component, the 32-bit program will log an error message in the System log. The operating system will then let the 32-bit program handle the error.

To determine whether a program requires a 16-bit component, install and run the program. If the program generates an error message, contact the manufacturer of the program for an update that is compatible with the x64-based versions of Windows.

### 32-bit drivers

The x64-based versions of Windows doesn't support 32-bit drivers. All hardware device drivers and program drivers must be compiled specifically for the x64-based version of Windows.

If a 32-bit program tries to install a 32-bit driver on a computer that is running an x64-based version of Windows, the installation of the driver fails. When this behavior occurs, the x64-based version of Windows reports an error to the 32-bit program.

If a 32-bit program tries to register a 32-bit driver for automatic startup on a computer that is running an x64-based version of Windows, the bootstrap loader on the computer recognizes that the 32-bit driver isn't supported. The x64-based version of Windows doesn't start the 32-bit driver, but does start the other registered drivers.

To determine whether a program requires a 32-bit driver, install and run the program. If the program generates an error message, contact the manufacturer of the program for an update that is compatible with the x64-based versions of Windows.

## Additional considerations

### Registry and file redirection

The WOW64 subsystem isolates 32-bit binaries from 64-bit binaries by redirecting registry calls and some file system calls. The WOW64 subsystem isolates the binaries to prevent a 32-bit binary from accidentally accessing data from a 64-bit binary. For example, a 32-bit binary that runs a .dll file from the %systemroot%\System32 folder might accidentally try to access a 64-bit .dll file that isn't compatible with the 32-bit binary. To prevent this, the WOW64 subsystem redirects the access from the %systemroot%\System32 folder to the %systemroot%\SysWOW64 folder. This redirection prevents compatibility errors because it requires the .dll file to be specifically designed to work with 32-bit programs.

For more information about file system and registry redirection, see the "Running 32-bit Applications" topic in the 64-Bit Windows section of the Microsoft Platform SDK documentation. To view this document, visit the following Microsoft Web site: [Running 32-bit Applications](/windows/win32/winprog64/running-32-bit-applications)  
The WOW64 subsystem redirects 32-bit binary calls without requiring changes to the 32-bit binaries. However, you may see evidence of this redirection when you perform some tasks. For example, if you type a command-line script at a 64-bit command prompt, the command prompt may not be able to access 32-bit programs in the Program Files folder. The WOW64 subsystem redirects and installs 32-bit programs in the Program Files (x86) folder. To access the correct folder, you must change the command-line script. Alternatively, you must type the command-line script at a 32-bit command prompt. The 32-bit command prompt automatically redirects file system calls to the correct 32-bit directory.

To start a 32-bit command prompt, follow these steps:

- Click **Start**, click **Run**, type **%windir%\SysWoW64\cmd.exe**, and then click **OK**.

### Version check

Some 32-bit programs examine the version information of the operating system. Many 32-bit programs that perform this check don't recognize the x64-based versions of Windows as compatible operating systems. When this behavior occurs, the 32-bit program will generate a version check error, and then close. If this behavior occurs, contact the manufacturer of the 32-bit program for an update that is compatible with the x64-based versions of Windows.

### The Microsoft .NET Framework

A program that is compiled with the Microsoft .NET Framework will run as a 32-bit program in the WOW64 subsystem if the following conditions are true:

- The program has the ILONLY bit set in the header information.
- The program was compiled with the Microsoft .NET Framework 1.1. If the program doesn't have the ILONLY bit set in the header information, or if the program was compiled with the Microsoft .NET Framework version 2.0, the program will run as a native 64-bit program.

### OpenGL

The x64-based versions of Windows don't include an OpenGL graphics driver. Contact the manufacturer of the device for a driver that is compatible with the x64-based versions of Windows.

### Microsoft Management Console (MMC)

The x64-based versions of Windows use the 64-bit version of Microsoft Management Console (MMC) to run various snap-ins. However, you may occasionally require the 32-bit version of MMC to run snap-ins in the WOW64 subsystem. For more information about the behavior of MMC on the x64-based versions Windows, see the "Running 32-bit and 64-bit Snap-ins in 64-bit Windows" topic in the Using MMC 2.0 section of the Microsoft Platform SDK documentation. To view this document, visit the following Microsoft Web site: [Running 32-bit and 64-bit Snap-ins in 64-bit Windows](/previous-versions/windows/desktop/mmc/running-32-bit-and-64-bit-snap-ins-in-64-bit-windows)  

## x64 Considerations

The x64-based versions of Windows support 32-bit instructions and 64-bit instructions. The WOW64 subsystem can run 32-bit programs in native 64-bit mode by switching the native mode of the processor. Separate hardware or software layers are not required. You may not experience decreased performance when you run a 32-bit program on the x64-based versions of Windows.

For more information about the performance of an x64-based processor, contact the manufacturer of the processor or visit the manufacturer's Web site. The information and the solution in this document represents the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but are not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, with regard to any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.  

## References

For more information about the AMD64 processor, visit the following Advanced Micro Devices Web site: [AMD Website](https://www.amd.com/)  
 Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.  

For more information about developing programs for the Itanium-based versions of Windows Server 2003 and of Windows XP, visit the following Microsoft Web site: [Introduction to Developing Applications for the 64-bit Itanium-based Version of Windows](/previous-versions/windows/server-2003/ms952405(v=msdn.10))  

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.
