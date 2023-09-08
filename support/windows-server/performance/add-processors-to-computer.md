---
title: Add processors to a computer
description: Describes how to add processors to a computer.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: joscon, kaushika
ms.custom: sap:slow-performance, csstroubleshoot
ms.technology: windows-server-performance
---
# How to add processors to a computer

This article discusses how to add more processors to a computer.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 888729

## Supported processors

The following list contains information about the number of processors that are supported in the various versions of Windows Server 2003, Windows Server 2008, Windows Server 2008 R2, Windows Vista, Windows 7 and in Windows XP Professional x64 Edition:

| Client SKUs| Maximum Physical Processors Supported |
|---|---|
|Windows XP Professional x64 Edition|2|
|| |
|Windows Vista Starter|1|
|Windows Vista Home Basic|1|
|Windows Vista Home Premium|1|
|Windows Vista Enterprise Edition|2|
|Windows Vista Business Edition|2|
|Windows Vista Ultimate Edition|2|
|| |
|Windows 7 Starter Edition|1|
|Windows 7 Home Basic Edition|1|
|Windows 7 Home Premium Edition|1|
|Windows 7 Professional Edition|2|
|Windows 7 Enterprise Edition|2|
|Windows 7 Ultimate Edition|2|
  
| Server SKUs| Maximum Physical Processors Supported |
|---|---|
|Windows Server 2003 Web Edition|2|
|Windows Server 2003 Standard Edition|4|
|Windows Server 2003 Enterprise Edition|8|
|Windows Server 2003 Datacenter Edition|32|
|Windows Server 2003 Standard x64 Edition|4|
|Windows Server 2003 Enterprise x64 Edition|8|
|Windows Server 2003 Datacenter x64 Edition|64|
|| |
|Windows Server 2008 Foundation Edition|1|
|Windows Server 2008 Web Edition|4|
|Windows Server 2008 Standard Edition|4|
|Windows Server 2008 Enterprise Edition|8|
|Windows Server 2008 Datacenter Edition|64|
|Windows Server 2008 Itanium Edition|64|
|| |
|Windows Server 2008 R2 Foundation x64 Edition|1|
|Windows Server 2008 R2 Standard x64 Edition|4|
|Windows Server 2008 R2 Web x64 Edition|4|
|Windows Server 2008 R2 HPC x64 Edition|4|
|Windows Server 2008 R2 Enterprise x64 Edition|8|
|Windows Server 2008 R2 Datacenter x64 Edition|64|
|Windows Server 2008 R2 Itanium Edition|64|
  
## Add processors to a computer

To add more processors to a computer that has only one processor, the following conditions must be true:

- The computer has a motherboard that can support multiple processors.
- The processors that you want to add to the computer use the same speed and the same stepping.
- Any BIOS updates or driver updates to the motherboard that you want to apply are installed on the computer before you add the additional processors.

> [!NOTE]
> Before you add a processor to the computer, make sure that the computer is turned off.

If these conditions are true, you can add the processor or processors. When you restart the computer, Plug and Play detects and installs the processor or processors.

All versions of Windows Server 2003, Windows Server 2008, Windows Server 2008 R2, Windows Vista, Windows 7 and of Windows XP Professional x64 Edition use the Advanced Configuration and Power Interface (ACPI) Advanced Programmable Interrupt Controller (APIC) hardware abstraction layer (HAL).

> [!NOTE]
> The HAL option in Device Manager may change from ACPI APIC Uniprocessor HAL to ACPI APIC Multiprocessor HAL. This change does not indicate a change in HAL type. Instead, this indicates a change in the kernel.

After you add an additional processor to the computer, the computer detects the processor the next time that you start the computer. If the processor is not detected when you restart the computer, you must investigate possible hardware issues. For example, the processor may not be detected if one or more of the following conditions are true:

- The processor is incorrectly seated.
- The processor is damaged.
- The motherboard does not support the processor.
- The operating system is already supporting its maximum number of processors.

For more information about the processor and memory capabilities of x64-based versions of Windows Server 2003 and of Windows XP Professional x64 Edition, click the following article number to view the article in the Microsoft Knowledge Base: [888732](https://support.microsoft.com/help/888732) Processor and memory capabilities of Windows XP Professional x64 Edition and of the x64-based versions of Windows Server 2003  

## Technical support for Windows x64 editions

Your hardware manufacturer provides technical support and assistance for Microsoft Windows x64 editions. Your hardware manufacturer provides support because a Windows x64 edition was included with your hardware. Your hardware manufacturer might have customized the Windows x64 edition installation with unique components. Unique components might include specific device drivers or might include optional settings to maximize the performance of the hardware. Microsoft will provide reasonable-effort assistance if you need technical help with your Windows x64 edition. However, you might have to contact your manufacturer directly. Your manufacturer is best qualified to support the software that your manufacturer installed on the hardware.
