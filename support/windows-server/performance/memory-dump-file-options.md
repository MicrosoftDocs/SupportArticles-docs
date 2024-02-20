---
title: Memory dump file options
description: This article describes an overview of memory dump file options for Windows 7 with Service Pack 1.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
---
# Overview of memory dump file options for Windows

This article describes memory dump file options for Windows.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 254649

## Summary

You can configure the following operating systems to write debugging information:

- Windows 7
- Windows Server 2012 R2

The debugging information can be written to different file formats (also known as memory dump files) when your computer stops unexpectedly because of a **Stop** error (also known as a _blue screen_, system crash, or bug check). You can also configure Windows not to write debugging information to a memory dump file.

Windows can generate any one of the following memory dump file types:

- Complete memory dump
- Kernel memory dump
- Small memory dump (64 KB)
- [Automatic memory dump](/windows-hardware/drivers/debugger/automatic-memory-dump)

## Complete memory dump

A complete memory dump records all the contents of system memory when your computer stops unexpectedly. A complete memory dump may contain data from processes that were running when the memory dump was collected.

If you select the **Complete memory dump** option, you must have a paging file on the boot volume that is sufficient to hold all the physical RAM plus 1 megabyte (MB).

If the following conditions are true, the previous file is overwritten.

- A second problem occurs.
- Another complete memory dump (or kernel memory dump) file is created.

> [!NOTE]
>
> - In Windows 7, the paging file can be on a partition that differs from the partition on which the operating system is installed.
> - In Windows 7, you do not have to use the DedicatedDumpFile registry entry to put a paging file onto another partition.
> - The **Complete memory dump** option is not available on computers that are running a 32-bit operating system and that have 2 gigabytes (GB) or more of RAM. For more information, see [Specify what happens when the system stops unexpectedly](/previous-versions/windows/it-pro/windows-server-2003/cc778968(v=ws.10)).

## Kernel memory dump

A kernel memory dump records only the kernel memory. It speeds up the process of recording information in a log when your computer stops unexpectedly. You must have a pagefile large enough to accommodate your kernel memory. For 32-bit systems, kernel memory is usually between 150 MB and 2 GB.

This dump file doesn't include unallocated memory or any memory that's allocated to User-mode programs. It includes:

- Memory that's allocated to the kernel and hardware abstraction layer (HAL) in Windows 2000 and later.
- Memory that's allocated to Kernel-mode drivers and other Kernel-mode programs.

For most purposes, this dump file is the most useful. It's smaller than the complete memory dump file. But it omits only those parts of memory that are unlikely to have been involved in the problem.

If the following conditions are true, the previous file is overwritten when the **Overwrite any existing file** setting is checked.

- A second problem occurs.
- Another kernel memory dump file (or a complete memory dump file) is created.

## Small memory dump

A small memory dump records the smallest set of useful information that may help identify why your computer stopped unexpectedly. This option requires a paging file of at least 2 MB on the boot volume and specifies that Windows 2000 and later create a new file every time your computer stops unexpectedly. A history of these files is stored in a folder.

This dump file type includes the following information:

- The Stop message and its parameters and other data
- A list of loaded drivers
- The processor context (PRCB) for the processor that stopped
- The process information and kernel context (EPROCESS) for the process that stopped
- The process information and kernel context (ETHREAD) for the thread that stopped
- The Kernel-mode call stack for the thread that stopped

This kind of dump file can be useful when space is limited. However, because of the limited information included, errors that were not directly caused by the thread that was running at the time of the problem may not be discovered by an analysis of this file.

If the following conditions are true, the previous file is preserved.

- A second problem occurs.
- A second small memory dump file is created.

Each additional file is given a distinct name. The date is encoded in the file name. For example, Mini022900-01.dmp is the first memory dump generated on February 29, 2000. A list of all small memory dump files is kept in the `%SystemRoot%\Minidump` folder.

## Configure the dump type

To configure startup and recovery options (including the dump type), follow these steps.

> [!NOTE]
> Because there are several versions of Windows, the following steps may be different on your computer. If they are, see your product documentation to complete these steps.  

1. Click **Start**, and then click **Control Panel**.
2. Click **Performance and Maintenance**, and then click **System**.
3. On the **Advanced** tab, click **Settings** under **Startup and Recovery**.

> [!NOTE]
> You must restart Windows in order for your changes to take effect.

## Tools for the various dump types

You can load complete memory dumps and kernel memory dumps with standard symbolic debuggers, such as I386kd.exe. I386kd.exe is included with the Windows 2000 Support CD-ROM.

Load small memory dumps by using Dumpchk.exe. You can also use Dumpchk.exe to verify that a memory dump file has been created correctly.

## Volume definitions

- Boot volume: The volume that contains the Windows operating system and its support files. The boot volume can be, but doesn't have to be, the same as the system volume.

- System volume: The volume that contains the hardware-specific files that you must have to load Windows. The system volume can be, but doesn't have to be, the same as the boot volume. The Boot.ini, `Ntdetect.com`, and Ntbootdd.sys files are examples of files that are located on the system volume.

## Registry values for startup and recovery

The following registry value is used under `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\CrashControl`.

- CrashDumpEnabled REG_DWORD 0x0 = None
- CrashDumpEnabled REG_DWORD 0x1 = Complete memory dump
- CrashDumpEnabled REG_DWORD 0x2 = Kernel memory dump
- CrashDumpEnabled REG_DWORD 0x3 = Small memory dump (64 KB)
- CrashDumpEnabled REG_DWORD 0x7 = [Automatic memory dump](/windows-hardware/drivers/debugger/automatic-memory-dump)

Additional registry values for CrashControl:

- 0x0 = Disabled
- 0x1 = Enabled

- AutoReboot REG_DWORD 0x1
- DumpFile REG_EXPAND_SZ `%SystemRoot%\Memory.dmp`
- LogEvent REG_DWORD 0x1
- MinidumpDir REG_EXPAND_SZ `%SystemRoot%\Minidump`
- Overwrite REG_DWORD 0x1
- SendAlert REG_DWORD 0x1

> [!NOTE]
> You must restart Windows in order for your changes to take effect.

## Test to make sure that a dump file can be created

For more information about how to configure your computer to generate a dump file for testing purposes, see [Windows feature lets you generate a memory dump file by using the keyboard](https://support.microsoft.com/help/244139).

## Default dump type options

- Windows 7 (All Editions): Kernel memory dump
- Windows Server 2012 R2 (All Editions): Automatic memory.dmp

## Maximum paging file size

Maximum paging file size is limited as follows:

|Limit|x86|x64|IA-64|
|---|---|---|---|
|Maximum size of a paging file|4 gigabytes (non-PAE)<br/>16 terabytes (PAE)|16 terabytes|32 terabytes|
|Maximum number of paging files|16|16|16|
|Total paging file size|64 gigabytes (non-PAE)<br/>256 terabytes (PAE)|256 terabytes|512 terabytes|

## Technical support for x64-based versions of Windows

Your hardware manufacturer provides technical support and assistance for x64-based versions of Windows. Your hardware manufacturer provides support because an x64-based version of Windows was included with your hardware. Your hardware manufacturer might have customized the installation of Windows with unique components. Unique components might include specific device drivers or might include optional settings to maximize the performance of the hardware. Microsoft will provide reasonable-effort assistance if you need technical help with your x64-based version of Windows. However, you might have to contact your manufacturer directly. Your manufacturer is best qualified to support the software that your manufacturer installed on the hardware.
