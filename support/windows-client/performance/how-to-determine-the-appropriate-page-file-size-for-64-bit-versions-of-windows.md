---
title: How to determine the appropriate page file size for 64-bit versions of Windows
description: Learn how to determine the appropriate page file size for 64-bit versions of Windows.
ms.date: 08/23/2022
ms.service: windows-client
ms.topic: troubleshooting
author: Deland-Han
ms.author: delhan
ms.reviewer: dansimp
manager: dcscontentpm
ms.collection: highpri
ms.subservice: performance
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
audience: itpro
localization_priority: medium
---
# How to determine the appropriate page file size for 64-bit versions of Windows

Page file sizing depends on the system crash dump setting requirements and the peak usage or expected peak usage of the system commit charge. Both considerations are unique to each system, even for systems that are identical. This uniqueness means that page file sizing is also unique to each system and can't be generalized.

_Applies to:_ &nbsp; Windows 10

## Determine the appropriate page file size

Use the following considerations for page file sizing for all versions of Windows and Windows Server.

### Crash dump setting

If you want a crash dump file to be created during a system crash, a page file or a dedicated dump file must exist and be large enough to back up the system crash dump setting. Otherwise, a system memory dump file isn't created.

For more information, see [Support for system crash dumps](introduction-to-the-page-file.md#support-for-system-crash-dumps) section.

### Peak system commit charge

The system commit charge can't exceed the system commit limit. This limit is the sum of physical memory (RAM) and all page files combined. If no page files exist, the system commit limit is slightly less than the physical memory that is installed. Peak system-committed memory usage can vary greatly between systems. Therefore, physical memory and page file sizing also vary.

### Quantity of infrequently accessed pages

The purpose of a page file is to back (support) infrequently accessed modified pages so that they can be removed from physical memory. This removal provides more available space for more frequently accessed pages. The "\Memory\Modified Page List Bytes" performance counter measures, in part, the number of infrequently accessed modified pages that are destined for the hard disk. However, not all the memory on the modified page list is written out to disk. Typically, several hundred megabytes of memory remains resident on the modified list. Therefore, consider extending or adding a page file if all the following conditions are true:

- More available physical memory (\\Memory\\Available MBytes) is required.

- The modified page list contains a significant amount of memory.

- The existing page files are fairly full (\\Paging Files(*)\% Usage).

## Support for system crash dumps

A system crash (also known as a "bug check" or a "Stop error") occurs when the system can't run correctly. The dump file that is produced from this event is called a system crash dump. A page file or dedicated dump file is used to write a crash dump file (*Memory.dmp*) to disk. Therefore, a page file or a dedicated dump file must be large enough to support the kind of crash dump selected. Otherwise, the system can't create the crash dump file.

> [!NOTE]
> During startup, system-managed page files are sized respective to the system crash dump settings. This assumes that enough free disk space exists.

|System crash dump setting    |Minimum page file size requirement|
|-----------|-------------------|
|Small memory dump (256 KB)    |1 MB|
|Kernel memory dump    |Depends on kernel virtual memory usage|
|Complete memory dump    |1 x RAM plus 257 MB*|
|Automatic memory dump    |Depends on kernel virtual memory usage. For details, see Automatic memory dump.|

\* 1 MB of header data and device drivers can total 256 MB of secondary crash dump data.

The Automatic memory dump setting is enabled by default. This setting is an alternative to a kind of crash dump. This setting automatically selects the best page file size, depending on the frequency of system crashes.

The Automatic memory dump feature initially selects a small paging file size. It would accommodate the kernel memory most of the time. If the system crashes again within four weeks, the Automatic memory dump feature sets the page file size as either the RAM size or 32 GB, whichever is smaller.

Kernel memory crash dumps require enough page file space or dedicated dump file space to accommodate the kernel mode side of virtual memory usage. If the system crashes again within four weeks of the previous crash, a Complete memory dump is selected at restart. This dump requires a page file or dedicated dump file of at least the size of physical memory (RAM) plus 1 MB for header information plus 256 MB for potential driver data to support all the potential data that is dumped from memory. Again, the system-managed page file will be increased to back this kind of crash dump. If the system is configured to have a page file or a dedicated dump file of a specific size, make sure that the size is sufficient to back the crash dump setting that is listed in the table earlier in this section together with and the peak system commit charge.

### Dedicated dump files

Computers that are running Microsoft Windows or Microsoft Windows Server usually must have a page file to support a system crash dump. System administrators can now create a dedicated dump file instead.

A dedicated dump file is a page file that isn't used for paging. Instead, it is "dedicated" to back a system crash dump file (Memory.dmp) when a system crash occurs. Dedicated dump files can be put on any disk volume that can support a page file. We recommend that you use a dedicated dump file if you want a system crash dump but you don't want a page file. To learn how to create it, see [Overview of memory dump file options for Windows](../../windows-server/performance/memory-dump-file-options.md).

## System-managed page files

By default, page files are system-managed. This system management means that the page files increase and decrease based on many factors, such as the amount of physical memory installed, the process of accommodating the system commit charge, and the process of accommodating a system crash dump.

For example, when the system commit charge is more than 90 percent of the system commit limit, the page file is increased to back it. This surge continues to occur until the page file reaches three times the size of physical memory or 4 GB, whichever is larger. Therefore, it's assumes that the logical disk that is hosting the page file is large enough to accommodate the growth.

The following table lists the minimum and maximum page file sizes of system-managed page files in Windows 10 and Windows 11.

|Minimum page file size    |Maximum page file size|
|---------------|------------------|
|Varies based on page file usage history, amount of RAM (RAM ÷ 8, max 32 GB) and crash dump settings.    |3 × RAM or 4 GB, whichever is larger. This size is then limited to the volume size ÷ 8. However, it can grow to within 1 GB of free space on the volume if necessary for crash dump settings.|

## Performance counters

Several performance counters are related to page files. This section describes the counters and what they measure.

### \Memory\Page/sec and other hard page fault counters

The following performance counters measure hard page faults (which include, but aren't limited to, page file reads):

- \\Memory\\Page\/sec

- \\Memory\\Page Reads\/sec

- \\Memory\\Page Inputs\/sec

The following performance counters measure page file writes:

- \\Memory\\Page Writes\/sec

- \\Memory\\Page Output\/sec

Hard page faults are faults that must be resolved by retrieving the data from disk. Such data can include portions of DLLs, `.exe` files, memory-mapped files, and page files. These faults might or might not be related to a page file or to a low-memory condition. Hard page faults are a standard function of the operating system. They occur when the following items are read:

- Parts of image files (`.dll` and `.exe` files) as they're used
- Memory-mapped files
- A page file

High values for these counters (excessive paging) indicate disk access of generally 4 KB per page fault on x86 and x64 versions of Windows and Windows Server. This disk access might or might not be related to page file activity but may contribute to poor disk performance that can cause system-wide delays if the related disks are overwhelmed.

Therefore, we recommend that you monitor the disk performance of the logical disks that host a page file in correlation with these counters. A system that has a sustained 100 hard page faults per second experiences 400 KB per second disk transfers. Most 7,200-RPM disk drives can handle about 5 MB per second at an IO size of 16 KB or 800 KB per second at an IO size of 4 KB. No performance counter directly measures which logical disk the hard page faults are resolved for.

### \Paging File(*)\% Usage

The \\Paging File(*)\% Usage performance counter measures the percentage of usage of each page file. 100 percent usage of a page file doesn't indicate a performance problem as long as the system commit limit isn't reached by the system commit charge, and if a significant amount of memory isn't waiting to be written to a page file.

> [!NOTE]
> The size of the Modified Page List (\\Memory\\Modified Page List Bytes) is the total of modified data that is waiting to be written to disk.

If the Modified Page List (a list of physical memory pages that are the least frequently accessed) contains lots of memory, and if the % Usage value of all page files is greater than 90, you can make more physical memory available for more frequently access pages by increasing or adding a page file.

> [!NOTE]
> Not all the memory on the modified page list is written out to disk. Typically, several hundred megabytes of memory remains resident on the modified list.

## Multiple page files and disk considerations

If a system is configured to have more than one page files, the page file that responds first is the one that is used. This customized configuration means that page files that are on faster disks are used more frequently. Also, whether you put a page file on a "fast" or "slow" disk is important only if the page file is frequently accessed and if the disk that is hosting the respective page file is overwhelmed. Actual page file usage depends greatly on the amount of modified memory that the system is managing. This dependency means that files that already exist on disk (such as `.txt`, `.doc`, `.dll`, and `.exe`) aren't written to a page file. Only modified data that doesn't already exist on disk (for example, unsaved text in Notepad) is memory that could potentially be backed by a page file. After the unsaved data is saved to disk as a file, it's backed by the disk and not by a page file.
