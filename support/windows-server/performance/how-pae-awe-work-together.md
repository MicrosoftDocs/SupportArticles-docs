---
title: Large memory support is available in Windows Server 2003 and in Windows 2000
description: Describes PAE and AWE and explains how they work together and also discusses the limitations of using memory beyond the 4-GB range that is inherent to 32-bit operating systems.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:slow-performance, csstroubleshoot
---
# Large memory support is available in Windows Server 2003 and in Windows 2000

This article describes Physical Address Extension (PAE) and Address Windowing Extensions (AWE) and explains how they work together. This article also discusses the limitations of using memory beyond the 4-gigabyte (GB) range that is inherent to 32-bit operating systems.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 283037

## More information

PAE is the added ability of the IA32 processor to address more than 4 GB of physical memory. The following operating systems can use PAE to take advantage of physical memory beyond 4 GB:  

- Microsoft Windows 2000 Advanced Server
- Microsoft Windows 2000 Datacenter Server
- Microsoft Windows Server 2003, Enterprise Edition
- Microsoft Windows Server 2003, Datacenter Edition

To enable PAE, use the /PAE switch in the Boot.ini file.

> [!NOTE]
> In Windows Server 2003, PAE is automatically enabled only if the server is using hot-add memory devices. In this case, you do not have to use the /PAE switch on a system that is configured to use hot-add memory devices. In all other cases, you must use the /PAE switch in the Boot.ini file to take advantage of memory over 4GB.

Typically, a process running under Windows 2000 or Windows Server 2003 can access up to 2 GB of memory address space (assuming the /3GB switch wasn't used) with some of the memory being physical memory and some being virtual memory. The more programs (and, therefore, more processes) that run, the more memory you commit up to the full 2 GB of address space.

When this situation occurs, the paging process increases dramatically and performance may be negatively impacted. The Windows 2000 and Windows Server 2003 memory managers use PAE to provide more physical memory to a program. This reduces the need to swap the memory of the page file and results in increased performance. The program itself isn't aware of the actual memory size. All the memory management and allocation of the PAE memory is handled by the memory manager independently of the programs that run.

The preceding information is valid for programs that run when the /3GB switch is used. A program that requests 3 GB of memory is more likely to be able to have more of its memory remain in physical memory rather than be paged out. This increases the performance of programs that are capable of using the /3GB switch. The exception is when the /3GB switch is used in conjunction with the /PAE switch. In this case, the operating system doesn't use any memory in excess of 16 GB. This behavior is caused by kernel virtual memory space considerations. Thus, if the system restarts with the /3GB entry in the Boot.ini file, and the system has more than 16 GB of physical memory, the additional physical random access memory (RAM) isn't used by the operating system. Restarting the computer without the /3GB switch enables the use of all the physical memory.

AWE is a set of application programming interfaces (APIs) to the memory manager functions that enables programs to address more memory than the 4 GB that is available through standard 32-bit addressing. AWE enables programs to reserve physical memory as non-paged memory and then to dynamically map portions of the non-paged memory to the program's working set of memory. This process enables memory-intensive programs, such as large database systems, to reserve large amounts of physical memory for data without having to be paged in and out of a paging file for usage. Instead, the data is swapped in and out of the working set and reserved memory is in excess of the 4-GB range. Additionally, the range of memory in excess of 4 GB is exposed to the memory manager and the AWE functions by PAE. Without PAE, AWE can't reserve memory in excess of 4 GB.

The following is an example of a Boot.ini file where the PAE switch has been added:

```ini
[boot loader]  
timeout=30  
default=multi(0)disk(0)rdisk(0)partition(2)\WINDOWS  
[operating systems]  
multi(0)disk(0)rdisk(0)partition(2)\WINDOWS="Windows Server 2003, Enterprise" /fastdetect /PAE  
```

> [!WARNING]
> The contents of your Boot.ini file will vary based upon your configuration.  

To summarize, PAE is a function of the Windows 2000 and Windows Server 2003 memory managers that provides more physical memory to a program that requests memory. The program isn't aware that any of the memory that it uses resides in the range greater than 4 GB, just as a program isn't aware that the memory it has requested is actually in the page file.

AWE is an API set that enables programs to reserve large chunks of memory. The reserved memory is non-pageable and is only accessible to that program.  

If you add more memory to the system, it's possible that the BIOS will recognize the full amount of physical RAM that is installed in the server but that Windows will recognize only a part of the RAM. If the server has a redundant memory feature or a memory mirroring feature that is enabled, the full complement of memory may not be visible to Windows. Redundant memory provides the system with a failover memory bank when a memory bank fails. Memory mirroring splits the memory banks into a mirrored set. Both features are enabled or disabled in the BIOS and can't be accessed through Windows. To modify the settings for these features, you may have to refer to the system user manual or the OEM Web site. Alternatively, you may have to contact the hardware vendor.

For example, if you're running a system that has 4 GB of RAM installed and you then add 4 GB of additional RAM, Windows may recognize only 4 GB of physical memory or possibly 6 GB instead of the full 8 GB. The redundant memory feature or the memory mirroring feature may be enabled on the new memory banks without your knowledge. These symptoms are similar to the symptoms that occur when you don't add the /PAE switch to the Boot.ini file.
