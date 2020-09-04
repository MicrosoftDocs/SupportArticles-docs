---
title: Overview of the compatibility considerations for 32-bit programs on 64-bit versions of Windows Server 2003 and Windows XP
description: Discusses the compatibility considerations and limitations for 32-bit programs that are running on 64-bit versions of Windows Server 2003 and Windows XP.
ms.date: 08/19/2020
author: delhan
ms.author: Deland-Han
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Applications
ms.technology: Performance
---
# Overview of the compatibility considerations for 32-bit programs on 64-bit versions of Windows Server 2003 and Windows XP

This article discusses the compatibility considerations and limitations for 32-bit programs that are running on 64-bit versions of Windows Server 2003 and Windows XP.

_Original product version:_ &nbsp;Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp;896456

## Summary

The 64-bit versions of Microsoft Windows Server 2003 and of Microsoft Windows XP use the Microsoft Windows-32-on-Windows-64 (WOW64) subsystem to run 32-bit programs without modifications. The 64-bit versions of Windows Server 2003 and of Windows XP don't provide support for 16-bit binaries or 32-bit drivers. Programs that depend on 16-bit binaries or 32-bit drivers can't run on the 64-bit versions of Windows Server 2003 or of Windows XP unless the program manufacturer provides an update for the program.

There may be considerations that affect a program's compatibility or performance. You can determine whether a program will have compatibility or performance issues by testing the program on one of the 64-bit versions of Windows Server 2003 or of Windows XP.

This article describes some of the compatibility considerations for running 32-bit programs on the 64-bit versions of Windows Server 2003 and of Windows XP. This article doesn't compare the 32-bit and 64-bit versions of Windows Server 2003 and of Windows XP, or different 64-bit operating systems. This article assumes that you understand the difference between 32-bit binaries and 64-bit binaries.

Although the compatibility considerations described in this article apply to the 64-bit versions of Windows Server 2003 and of Windows XP, this article is primarily written for the Microsoft Windows Server 2003 Service Pack 1 (SP1) release. Any major functionality differences that exist between Windows Server 2003 SP1 and earlier 64-bit versions of Windows Server 2003 are specifically noted.

[back to the top](#summary) 

## Introduction

The x64-based versions of Microsoft Windows Server 2003 and of Microsoft Windows XP Professional x64 Edition are optimized to run native 64-bit programs. Additionally, the x64-based versions of Windows Server 2003 and Windows XP Professional x64 Edition use the WOW64 subsystem to run 32-bit programs.

[back to the top](#summary) 

## Running 32-bit programs

The WOW64 subsystem enables 32-bit programs to run without modification on the x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition. The WOW64 subsystem does this by creating a 32-bit environment on the x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition. For more information about the WOW64 subsystem, see the "Running 32-bit Applications" topic in the 64-Bit Windows section of the Microsoft Platform SDK documentation. To view this document, visit the following Microsoft Web site: [https://msdn2.microsoft.com/library/aa384249.aspx](https://msdn2.microsoft.com/library/aa384249.aspx) 

 [back to the top](#summary) 

## Program performance considerations

The WOW64 subsystem creates a 32-bit environment on the x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition. Some 32-bit programs may run slower on these operating systems than they would on 32-bit versions of Windows Server 2003 and of Windows XP. For example, a 32-bit program might run slower on Windows XP Professional x64 Edition than it would on Microsoft Windows XP Professional. Alternatively, some 32-bit programs that require lots of memory may exhibit increased performance on the x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition. This performance increase occurs because the x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition support more physical memory than the 32-bit versions of Windows Server 2003 and of Windows XP Professional.

For more information about the differences in memory management between the 64-bit and 32-bit versions of Windows, see the "Virtual Address Space" topic in the About Memory Management section of the Microsoft Platform SDK documentation. To view this document, visit the following Microsoft Web site: [https://msdn2.microsoft.com/library/aa366912.aspx](https://msdn2.microsoft.com/library/aa366912.aspx) 

 [back to the top](#summary) 

## Restrictions of the WOW64 subsystem

The WOW64 subsystem doesn't support the following programs:

- Programs that are compiled for 16-bit operating systems
- Kernel-mode programs that are compiled for 32-bit operating systems

[back to the top](#summary) 

### 16-bit programs

The x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition don't support 16-bit programs or 16-bit program components. The software emulation that is required to run 16-bit programs on the x64-based version of Windows Server 2003 or of Windows XP Professional x64 Edition would significantly decrease the performance of those programs.

A 16-bit installer is frequently used to install and configure a 32-bit program. Additionally, some 32-bit programs require 16-bit components to run correctly. Although 32-bit programs that require 16-bit components might run correctly after they're installed, you can't use the 16-bit installer to install a 32-bit program. Programs that require 16-bit components can't run on x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition.

If a 32-bit program that requires 16-bit components tries to run a 16-bit file or component, the 32-bit program will log an error message in the System log. The operating system will then let the 32-bit program handle the error.

To determine whether a program requires a 16-bit component, install and run the program. If the program generates an error message, contact the manufacturer of the program for an update that is compatible with the x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition.

[back to the top](#summary) 

### 32-bit drivers

The x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition don't support 32-bit drivers. All hardware device drivers and program drivers must be compiled specifically for the x64-based version of Windows Server 2003 and of Windows XP Professional x64 Edition.

If a 32-bit program tries to install a 32-bit driver on a computer that is running an x64-based version of Windows Server 2003 SP1 or of Windows XP Professional x64 Edition, the installation of the driver fails. When this behavior occurs, the x64-based version of Windows Server 2003 SP1 or of Windows XP Professional x64 Edition reports an error to the 32-bit program.

If a 32-bit program tries to register a 32-bit driver for automatic startup on a computer that is running an x64-based version of Windows Server 2003 or of Windows XP Professional x64 Edition, the bootstrap loader on the computer recognizes that the 32-bit driver isn't supported. The x64-based version of Windows Server 2003 or of Windows XP Professional x64 Edition doesn't start the 32-bit driver, but does start the other registered drivers.

To determine whether a program requires a 32-bit driver, install and run the program. If the program generates an error message, contact the manufacturer of the program for an update that is compatible with the x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition.

[back to the top](#summary) 

## Additional considerations

### Registry and file redirection

The WOW64 subsystem isolates 32-bit binaries from 64-bit binaries by redirecting registry calls and some file system calls. The WOW64 subsystem isolates the binaries to prevent a 32-bit binary from accidentally accessing data from a 64-bit binary. For example, a 32-bit binary that runs a .dll file from the %systemroot%\System32 folder might accidentally try to access a 64-bit .dll file that isn't compatible with the 32-bit binary. To prevent this, the WOW64 subsystem redirects the access from the %systemroot%\System32 folder to the %systemroot%\SysWOW64 folder. This redirection prevents compatibility errors because it requires the .dll file to be specifically designed to work with 32-bit programs.

For more information about file system and registry redirection, see the "Running 32-bit Applications" topic in the 64-Bit Windows section of the Microsoft Platform SDK documentation. To view this document, visit the following Microsoft Web site: [https://msdn2.microsoft.com/library/aa384249.aspx](https://msdn2.microsoft.com/library/aa384249.aspx) 
The WOW64 subsystem redirects 32-bit binary calls without requiring changes to the 32-bit binaries. However, you may see evidence of this redirection when you perform some tasks. For example, if you type a command-line script at a 64-bit command prompt, the command prompt may not be able to access 32-bit programs in the Program Files folder. The WOW64 subsystem redirects and installs 32-bit programs in the Program Files (x86) folder. To access the correct folder, you must change the command-line script. Alternatively, you must type the command-line script at a 32-bit command prompt. The 32-bit command prompt automatically redirects file system calls to the correct 32-bit directory.

To start a 32-bit command prompt, follow these steps:

- Click **Start**, click **Run**, type **%windir%** \SysWoW64\cmd.exe, and then click **OK**.

[back to the top](#summary) 

### Version check

Some 32-bit programs examine the version information of the operating system. Many 32-bit programs that perform this check don't recognize the x64-based versions of Windows Server 2003 or of Windows XP Professional x64 Edition as compatible operating systems. When this behavior occurs, the 32-bit program will generate a version check error, and then close. If this behavior occurs, contact the manufacturer of the 32-bit program for an update that is compatible with the x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition.

[back to the top](#summary) 

### The Microsoft .NET Framework

A program that is compiled with the Microsoft .NET Framework will run as a 32-bit program in the WOW64 subsystem if the following conditions are true:

- The program has the ILONLY bit set in the header information.
- The program was compiled with the Microsoft .NET Framework 1.1. If the program doesn't have the ILONLY bit set in the header information, or if the program was compiled with the Microsoft .NET Framework version 2.0, the program will run as a native 64-bit program.

[back to the top](#summary) 

### OpenGL

The x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition don't include an OpenGL graphics driver. Contact the manufacturer of the device for a driver that is compatible with the x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition.

[back to the top](#summary) 

### Microsoft Management Console (MMC)

The x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition use the 64-bit version of Microsoft Management Console (MMC) to run various snap-ins. However, you may occasionally require the 32-bit version of MMC to run snap-ins in the WOW64 subsystem. For more information about the behavior of MMC on the x64-based versions Windows Server 2003 and of Windows XP Professional x64 Edition, see the "Running 32-bit and 64-bit Snap-ins in 64-bit Windows" topic in the Using MMC 2.0 section of the Microsoft Platform SDK documentation. To view this document, visit the following Microsoft Web site: [https://msdn2.microsoft.com/library/aa815172.aspx](https://msdn2.microsoft.com/library/aa815172.aspx) 

 [back to the top](#summary) 

## Itanium considerations

The following sections briefly describe the considerations and the limitations that are specific to 32-bit programs that run on the Itanium-based versions of Microsoft Windows Server 2003 and of Microsoft Windows XP.


### Intel Architecture 32-bit Execution Layer (IA-32 EL)

The Itanium-based versions of Microsoft Windows Server 2003 with Service Pack 1 (SP1) and of Microsoft Windows XP use the Intel Architecture 32-bit Execution Layer (IA-32 EL) to support 32-bit programs. In earlier Itanium-based versions of Microsoft Windows Server 2003 and of Windows XP, these programs are supported by the WOW64 subsystem. The WOW64 subsystem uses special hardware in the CPU to run x86 instructions for 32-bit programs. However, the IA-32 EL translates x86 instructions for 32-bit programs into comparable instructions for the Itanium-based version of Windows Server 2003 and Windows XP. The IA-32 EL translates the x86 instructions for 32-bit programs in native 64-bit mode, and then lets the WOW64 subsystem run 32-bit programs on the Itanium-based CPU hardware.

Running a 32-bit program on the Itanium-based CPU hardware can increase the performance of the 32-bit program. You may experience increased performance even though some overhead occurs when the IA-32 EL translates instructions between the 32-bit and 64-bit instruction sets. The IA-32 EL also offers many features to enhance the performance of the 32-bit program. For example, the IA-32 EL can cache the instructions that have already been translated. This will increase the performance of a 32-bit program that is currently running.

For more information about the IA-32 EL, visit the following Intel Web site:

[http://www.intel.com/cd/software/products/asmo-na/eng/219773.htm](http://www.intel.com/cd/software/products/asmo-na/eng/219773.htm) 

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.  

[back to the top](#summary) 

### Memory management

On the Itanium-based versions of Microsoft Windows Server 2003 and of Windows XP, the following memory manager features aren't supported for 32-bit programs:

- Scatter/gather Input/Output (IO)
 For more information, click the following article number to view the article in the Microsoft Knowledge Base: [160606](https://support.microsoft.com/help/160606) Performance Enhancements for SQL Server Under Windows NT  

- Address Windowing Extensions (AWE)
- Notifications of memory page modifications32-bit programs that require these features cannot run on the Itanium-based versions of Windows Server 2003 and of Windows XP. You must run a 64-bit version of the program.

If a 32-bit program that requires these memory management features generates an error, contact the manufacturer of the program for an update that is compatible with the Itanium-based versions of Windows Server 2003 and of Windows XP.

[back to the top](#summary) 

### Graphics support

The following table shows the graphics solutions that are supported for 32-bit binaries that run on the Itanium-based versions of Windows Server 2003 and of Windows XP.

| Graphics Solution| Software Accelerated| Hardware Accelerated |
|---|---|---|
|DDraw|Yes|No|
|D3D3|No|No|
|D3D5|No|No|
|D3D6|No|No|
|D3D7|No|No|
|D3D8|No|No|
|D3D9|No|No|
|OpenGL|Yes|Yes|

In instances where graphics hardware acceleration is not supported, binaries that require graphics hardware acceleration will not run as 32-bit binaries on the Itanium-based versions of Windows Server 2003 and of Windows XP. Additionally, 32-bit binaries that extensively use graphics will experience decreased performance when hardware acceleration is not supported.

If a 32-bit program requires DirectX hardware acceleration, contact the manufacturer of the program for an update that is compatible with the Itanium-based versions of Windows Server 2003 and of Windows XP.

[back to the top](#summary) 

## x64 Considerations

The x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition support 32-bit instructions and 64-bit instructions. The WOW64 subsystem can run 32-bit programs in native 64-bit mode by switching the native mode of the processor. Separate hardware or software layers are not required. You may not experience decreased performance when you run a 32-bit program on the x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition.

For more information about the performance of an x64-based processor, contact the manufacturer of the processor or visit the manufacturer's Web site. The information and the solution in this document represents the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but are not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, with regard to any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions. 

[back to the top](#summary) 

## References

For more information about the AMD64 processor, visit the following Advanced Micro Devices Web site: [https://www.amd.com/en/](https://www.amd.com/en/) 
 Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.  

For more information about developing programs for the Itanium-based versions of Windows Server 2003 and of Windows XP, visit the following Microsoft Web site: [https://msdn2.microsoft.com/library/ms952405.aspx](https://msdn2.microsoft.com/library/ms952405.aspx) 

For more information about other issues related to developing programs for the 64-bit versions of Windows Server 2003 and of Windows XP, visit the following Microsoft Web site: [https://msdn.microsoft.com/](https://msdn.microsoft.com/) 

 [back to the top](#summary) 

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.
