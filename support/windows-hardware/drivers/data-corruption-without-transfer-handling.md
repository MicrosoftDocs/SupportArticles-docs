---
title: Data corruption without special transfer handling
description: This article provides resolutions for the problem where data corruption may occur without special handling of the transfer.
ms.date: 09/02/2020
ms.custom: sap:Storage Driver
ms.reviewer: RonH
ms.subservice: storage-driver
---
# Data corruption without special handling of the transfer

This article helps you resolve the problem where data corruption may occur without special handling of the transfer.

_Original product version:_ &nbsp; Direct Memory Access  
_Original KB number:_ &nbsp; 2714876

## Symptoms

On PAE enabled x86 Windows versions that support access to memory above 4 GB, device drivers which intermix 32-bit Direct Memory Access (DMA) device reads with writes to the virtual address of the same transfer buffer may lead to data corruption without special handling of the transfer.

## Cause

PAE enabled x86 Windows versions that support access to memory above 4 GB implement special handling for devices that report being incapable of using more than 32-bit DMA addresses. This special handling is implemented in the Hardware Abstraction Layer (HAL) of the operating system using Map Registers that are sometimes referred to as bounce buffers.

When a device driver begins a DMA operation to a 32-bit only capable device, `DmaOperations` function `HalGetScatterGatherList` must determine whether any of the physical addresses describing the transfer reside above 4 GB. The HAL will then substitute the transfer buffer physical addresses residing above 4 GB with Map Register residing below 4 GB, which the device is capable of addressing.

If substitutions were performed, the Scatter Gather List (SGL) generated will be composed of physical addresses, some of which differ from the original Memory Descriptor List (MDL) describing the transfer. When the driver indicates that the DMA transfer is complete, the HAL determines whether it used map registers to support the transfer. If it did, and if the operation was a read from the device to system memory, the HAL will copy the contents of any Map Register used to the original data buffer. Data written directly to the transfer buffer virtual addresses by the driver prior to the requests completion will thus be overwritten by the contents of the HAL substituted Map Registers upon completion of the request.

If the data contained in the Map Registers does not match what the driver has written directly to the transfer buffer, then the data in the transfer buffer may be inconsistent.

## Resolution

Device drivers that require intermixing 32-bit DMA read operations with writes to the virtual addresses of a transfer buffer must use `DmaOperations` function `HalBuildMdlFromScatterGatherList`.

If Map Register substitutions were done by the HAL, `HalBuildMdlFromScatterGatherList` will create a new MDL that is composed of the non-substituted transfer buffer physical address and the physical addresses of the substituted HAL Map Registers. The virtual address mapping of the new MDL may be obtained by calling `MmGetSystemAddressForMdlSafe`. If `HalBuildMdlFromScatterGatherList` returns the original MDL, then no Map Register substitutions were performed.

New MDLs created by `HalBuildMdlFromScatterGatherList` must be unmapped and freed by calls to `MmUnmapLockedPages` and [IoFreeMdl function](/windows-hardware/drivers/ddi/wdm/nf-wdm-iofreemdl).

## More information

- [Map Registers](/windows-hardware/drivers/kernel/map-registers)

- [Operating Systems and PAE Support](/previous-versions/windows/hardware/design/dn613969(v=vs.85))

- [Physical Address Extension - PAE Memory and Windows](/previous-versions/windows/hardware/design/dn613975(v=vs.85))

- [Physical Address Extension](/windows/win32/memory/physical-address-extension)

- [DMA Programming Techniques](/windows-hardware/drivers/kernel/dma-programming-techniques)

- [The system memory that is reported in the System Information dialog box in Windows Vista is less than you expect if 4 GB of RAM is installed](https://support.microsoft.com/help/929605)
