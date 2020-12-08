---
title: 
description: Describes an issue in which you receive a .
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# "BlInitializeLibrary failed XXX" error when you install or start an operating system on a 64-bit UEFI-based computer

_Original product version:_ &nbsp; Windows 10, version 1809, all editions, Windows Server 2019, all editions, Windows Server version 1709, Windows Server version 1803, Windows 10, version 1709, all editions, Windows 10, version 1703, all editions, Windows 10, version 1511, all editions, Windows 10, version 1607, all editions, Windows Server 2016 Standard, Windows Server 2016 Essentials, Windows Server 2016 Datacenter, Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Essentials, Windows Server 2012 R2 Standard  
_Original KB number:_ &nbsp; 4020050

## Symptoms

When you try to install or start an operating system on a 64-bit UEFI-based computer, the system does not start, and you receive the following error message:
BlInitializeLibrary failed XXX

**Note** The error code could also be "0xc000009a" or "0xc0000001." 

## Cause

This problem occurs because the boot firmware on the computer generates lots of memory fragmentation. **Note** Not all "BlInitializeLibrary failed XXX" errors are caused by this issue.

## Workaround

We recommend that you do not let boot firmware create large amounts of fragmentation. Large memory fragmentation degrades the overall startup performance and causes problems. 

## More information

At the pre-boot stage, Windows Boot Manager sets the maximum number of global memory descriptor for a 64-bit UEFI system at 512. If the boot firmware creates a large amount of memory fragmentation, the memory descriptor count may exceed the set limit. This causes the "BlInitializeLibrary failed XXX" error. **Note**  This design applies only to the current operating system releases, including Windows 10, Windows Server 2016, and Windows Server 2012 R2. We do not guarantee that this design will apply to future versions.
