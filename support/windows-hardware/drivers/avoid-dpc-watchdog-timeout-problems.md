---
title: Avoiding DPC Watchdog timeout problems
description: This article provides resolutions for the DPC Watchdog timeout problems in StorPort Miniports.
ms.date: 09/04/2020
ms.custom: sap:Storage Driver
ms.subservice: storage-driver
---
# Avoiding DPC Watchdog timeout problems in StorPort Miniports

This article helps you resolve the DPC Watchdog timeout problems in StorPort Miniports.

_Original product version:_ &nbsp; Windows DPC Watchdog  
_Original KB number:_ &nbsp; 2569413

## Symptoms

The system stops responding; for example, the keyboard and mouse don't work. If a kernel debugger is attached to the system, the debugger may show an assertion.

## Cause

`StorPort.sys` handles I/O completions in a routine that runs at `DISPATCH_LEVEL` and that serially calls the I/O completion routines of all IRPs that have completed. If I/O completion routines singly or together take too much time, the keyboard and/or mouse may stop responding. It is also possible that the Windows DPC Watchdog timer routine will decide that the StorPort routine has taken excessive time to finish.

## Resolution

A kernel driver in the storage stack can reduce the problem's likelihood by efficient coding of the driver's I/O completion routine. If it is still not possible to do all necessary processing in the completion routine in enough time, the routine can create a work element for the I/O work, queue up the element to a work queue and return `STATUS_MORE_PROCESSING_REQUIRED`; a worker thread of the driver should then find the work element, do the work and do `IoCallerDriver` for the IRP to ensure the IRP's further I/O processing.

For more information about  handling IRPs, see [Different ways of handling IRPs - Cheat sheet](/windows-hardware/drivers/kernel/different-ways-of-handling-irps-cheat-sheet)   - (part 1 of 2)

## More information

In a kernel dump or in a live kernel debugging session, **storport!RaidUnitCompleteRequest** may appear in the execution stack running on a CPU.
