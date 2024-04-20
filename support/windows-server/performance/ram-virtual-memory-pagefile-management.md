---
title: Virtual memory in 32-bit version of Windows
description: Describes how to effectively manage the memory and improve the performance of your Windows-based computer.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:System Performance\Performance tools (Task Manager, Perfmon, WSRM, and WPA), csstroubleshoot
---
# RAM, virtual memory, pagefile, and memory management in Windows

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2160852

## Summary

This article contains basic information about the virtual memory implementation in 32-bit versions of Windows.

In modern operating systems such as Windows, applications and many system processes always reference memory by using virtual memory addresses. Virtual memory addresses are automatically translated to real (RAM) addresses by the hardware. Only core parts of the operating system kernel bypass this address translation and use real memory addresses directly.

Virtual memory is always being used, even when the memory that is required by all running processes does not exceed the volume of RAM that is installed on the system.

## Processes and address spaces

All processes (for example, application executables) that are running under 32-bit versions of Windows are assigned virtual memory addresses (a _virtual address space_), ranging from 0 to 4,294,967,295 (2*32-1 = 4 GB), regardless of how much RAM is installed on the computer.

In the default Windows configuration, 2 gigabytes (GB) of this virtual address space are designated for the private use of each process, and the other 2 GB is shared between all processes and the operating system. Typically, applications (for example, Notepad, Word, Excel, and Acrobat Reader) use only a fraction of the 2 GB of private address space. The operating system assigns RAM page frames only to those virtual memory pages that are being used.

Physical Address Extension (PAE) is the feature of the Intel 32-bit architecture that expands the physical memory (RAM) address to 36 bits. PAE does not change the size of the virtual address space (which remains at 4 GB), but just the volume of actual RAM that can be addressed by the processor.

The translation between the 32-bit virtual memory address that is used by the code that is running in a process and the 36-bit RAM address is handled automatically and transparently by the computer hardware according to _translation tables_ that are maintained by the operating system. Any virtual memory page (32-bit address) can be associated with any physical RAM page (36-bit address).

The following list describes how much RAM the various Windows versions and editions support (as of May 2010):

|Windows version|RAM|
|---|---|
|Windows NT 4.0|4 GB|
|Windows 2000 Professional|4 GB|
|Windows 2000 Standard Server|4 GB|
|Windows 2000 Advanced Server|8 GB|
|Windows 2000 Datacenter Server|32 GB|
|Windows XP Professional|4 GB|
|Windows Server 2003 Web Edition|2 GB|
|Windows Server 2003 Standard Edition|4 GB|
|Windows Server 2003 Enterprise Edition|32 GB|
|Windows Server 2003 Datacenter Edition|64 GB|
|Windows Vista|4 GB|
|Windows Server 2008 Standard|4 GB|
|Windows Server 2008 Enterprise|64 GB|
|Windows Server 2008 Datacenter|64 GB|
|Windows 7|4 GB|
  
## Pagefile

RAM is a limited resource, whereas for most practical purposes, virtual memory is unlimited. There can be many processes, and each process has its own 2 GB of private virtual address space. When the memory being used by all the existing processes exceeds the available RAM, the operating system moves pages (4-KB pieces) of one or more virtual address spaces to the computer's hard disk. This frees that RAM frame for other uses. In Windows systems, these _paged out_ pages are stored in one or more files (Pagefile.sys files) in the root of a partition. There can be one such file in each disk partition. The location and size of the page file is configured in **System Properties** (click **Advanced**, click **Performance**, and then click the **Settings** button).

Users frequently ask _how big should I make the pagefile?_ There is no single answer to this question because it depends on the amount of installed RAM and on how much virtual memory that workload requires. If there is no other information available, the typical recommendation of 1.5 times the installed RAM is a good starting point. On server systems, you typically want to have sufficient RAM so that there is never a shortage and so that the pagefile is not used. On these systems, it may serve no useful purpose to maintain a large pagefile. On the other hand, if disk space is plentiful, maintaining a large pagefile (for example, 1.5 times the installed RAM) does not cause a problem, and this also eliminates the need to worry over how large to make it.

## Performance, architectural limits, and RAM

On any computer system, as the load increases (the number of users, the volume of work), performance decreases, but in a nonlinear manner. Any increase in load or demand, beyond a certain point, causes a significant decrease in performance. This means that some resource is in critically short supply and has become a bottleneck.

At some point, the resource that is in short supply cannot be increased. This means that an _architectural limit_ has been reached. Some frequently reported architectural limits in Windows include the following:

- 2 GB of shared virtual address space for the system (kernel)
- 2 GB of private virtual address space per process (user mode)
- 660 MB of system PTE storage (Windows Server 2003 and earlier)
- 470 MB of paged pool storage (Windows Server 2003 and earlier)
- 256 MB of nonpaged pool storage (Windows Server 2003 and earlier)

This applies to Windows Server 2003 specifically, but this may also apply to Windows XP and to Windows 2000. However, Windows Vista, Windows Server 2008, and Windows 7 do not all share these architectural limits. The limits on user and kernel memory (numbers 1 and 2 here) are the same, but kernel resources such as PTEs and various memory pools are dynamic. This new functionality enables both paged and nonpaged memory. This also enables PTEs and session pool to grow beyond the limits that were discussed earlier, up to the point where the whole kernel is exhausted.

Frequently found and quoted statements such as the following:

> With a Terminal Server, the 2 GB of shared address space will be completely used before 4 GB of RAM is used.

This may be true in some cases. However, you have to monitor your system to know whether they apply to your particular system or not. In some cases, these statements are conclusions from specific Windows NT 4.0 or Windows 2000 environments and do not necessarily apply to Windows Server 2003. Significant changes were made to Windows Server 2003 to reduce the probability that these architectural limits will in fact be reached in practice. For example, some processes that were in the kernel were moved to non-kernel processes to reduce the memory used in the shared virtual address space.

## Monitoring RAM and virtual memory usage

Performance Monitor is the principle tool for monitoring system performance and for identifying the location of the bottleneck. To start Performance Monitor, click **Start**, click **Control Panel**, click **Administrative Tools**, and then double-click **Performance Monitor**. Here is a summary of some important counters and what they tell you:

- Memory, Committed Bytes: This counter is a measure of the demand for virtual memory.

    This shows how many bytes were allocated by processes and to which the operating system has committed a RAM page frame or a page slot in the pagefile (or perhaps both). As **Committed Bytes** grows greater than the available RAM, paging will increase, and the pagefile size that is being used will also increase. At some point, paging activity starts to significantly affect performance.

- Process, Working Set, _Total: This counter is a measure of the virtual memory in _active_ use.

    This counter shows how much RAM is required so that the virtual memory being used for all processes is in RAM. This value is always a multiple of 4,096, which is the page size that is used in Windows. As demand for virtual memory increases beyond the available RAM, the operating system adjusts how much of a process's virtual memory is in its Working Set to optimize available RAM usage and minimize paging.

- Paging File, %pagefile in use: This counter is a measure of how much of the pagefile is actually being used.

    Use this counter to determine whether the pagefile is an appropriate size. If this counter reaches 100, the pagefile is full, and things will stop working. Depending on the volatility of your workload, you probably want the pagefile large enough so that it is no more than 50-075 percent used. If much of the pagefile is being used, having more than one on different physical disks, may improve performance.

- Memory, Pages/Sec: This counter is one of the most misunderstood measures.

    A high value for this counter does not necessarily imply that your performance bottleneck stems from a shortage of RAM. The operating system uses the paging system for purposes other than swapping pages because of memory over-commitment.

- Memory, Pages Output/Sec: This counter shows how many virtual memory pages were written to the pagefile to free RAM page frames for other purposes each second.

    This is the best counter to monitor if you suspect that paging is your performance bottleneck. Even if Committed Bytes is greater than the installed RAM, if Pages Output/sec is low or zero most of the time, there is no significant performance problem from insufficient RAM.

- Memory, Cache Bytes, Memory, Pool Nonpaged Bytes, Memory, Pool Paged Bytes, Memory, System Code Total Bytes, Memory, System Driver Total Bytes:

    The sum of these counters is a measure of how much of the 2 GB of the shared part of the 4-GB virtual address space is actually being used. Use these to determine whether your system is reaching one of the architectural limits discussed that were discussed earlier.

- Memory, Available MBytes: This counter measures how much RAM is available to satisfy demands for virtual memory (either new allocations, or for restoring a page from the pagefile).

    When RAM is in short supply (for example, Committed Bytes is greater than installed RAM), the operating system will try to keep a certain fraction of installed RAM available for immediate use by copying virtual memory pages that are not in active use to the pagefile. Therefore, this counter will not reach zero and is not necessarily a good indication of whether your system is short of RAM.

## References

[Address Windowing Extensions](/windows/win32/memory/address-windowing-extensions)
