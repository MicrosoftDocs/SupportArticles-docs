---
title: Memory dump file options
description: This article describes an overview of memory dump file options for Windows.
ms.date: 04/30/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, khirschb, xinpli
ms.custom:
- sap:system performance\system reliability (crash,errors,bug check or blue screen,unexpected reboot)
- pcy:WinComm Performance
---
# Overview of memory dump file options for Windows

This article describes memory dump file options for Windows.

_Original KB number:_ &nbsp; 254649

## Summary

Debugging information can be written to different file formats (also known as memory dump files) when your computer stops unexpectedly because of a **Stop** error (also known as a _blue screen_, system crash, or bug check). You can also configure Windows not to write debugging information to a memory dump file.

Windows can generate any one of the following memory dump file types:

- Complete memory dump
- Kernel memory dump
- Small memory dump (64 KB)
- [Active memory dump](/windows-hardware/drivers/debugger/active-memory-dump)

## Complete memory dump

A complete memory dump records all the contents of system memory when your computer stops unexpectedly. A complete memory dump may contain data from processes that were running when the memory dump was collected.

If you select the **Complete memory dump** option, you must have a paging file on the boot volume that is sufficient to hold all the physical RAM plus 257 megabyte (MB).

If the following conditions are true, the previous file is overwritten.

- A second problem occurs.
- Another complete memory dump (or kernel memory dump) file is created.

## Kernel memory dump

A kernel memory dump records only the kernel memory. It speeds up the process of recording information in a log when your computer stops unexpectedly. You must have a pagefile large enough to accommodate your kernel memory. For 32-bit systems, kernel memory is usually between 150 MB and 2 GB.

This dump file doesn't include unallocated memory or any memory that's allocated to User-mode programs. It includes:

- Memory that's allocated to the kernel and hardware abstraction layer (HAL) in the latest supported Windows version.
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

## Active memory dump

For more information, see [Active memory dump](/windows-hardware/drivers/debugger/active-memory-dump).

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

You can load complete memory dumps and kernel memory dumps with the [Windows debugger](/windows-hardware/drivers/debugger/).

## Registry values for startup and recovery

The following registry value is used under `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\CrashControl`.

- CrashDumpEnabled REG_DWORD 0x0 = None
- CrashDumpEnabled REG_DWORD 0x1 = Complete memory dump
- CrashDumpEnabled REG_DWORD 0x2 = Kernel memory dump
- CrashDumpEnabled REG_DWORD 0x3 = Small memory dump (64 KB)
- CrashDumpEnabled REG_DWORD 0x7 = [Automatic memory dump](/windows-hardware/drivers/debugger/automatic-memory-dump)
- CrashDumpEnabled REG_DWORD 0x1 and FilterPages REG_DWORD 0x1 = Active memory dump

Additional registry values for CrashControl:

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

## Maximum paging file size

> [!NOTE]
> In Windows Server 2025, you might see inaccurate free disk space due to the 32-bit integer overflow. You can use the [Get-WmiObject](/powershell/module/microsoft.powershell.management/get-wmiobject) PowerShell cmdlet to see the accurate number. This might further block the ability to set the desired paging file size. As a workaround, you can set the paging file by the registry value `HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PagingFiles`.

For more information, see [How to determine the appropriate page file size for 64-bit versions of Windows](../../windows-client/performance/how-to-determine-the-appropriate-page-file-size-for-64-bit-versions-of-windows.md).
