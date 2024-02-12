---
title: Stop code DRIVER_VERIFIER_DMA_VIOLATION (0xE6)
description: Helps to fix the stop error DRIVER_VERIFIER_DMA_VIOLATION (0xE6) when kernel Direct Memory Access (DMA) protection is enabled.
ms.date: 09/24/2021
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, fredjeng, ryanman, v-lianna
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
---
# Stop code DRIVER_VERIFIER_DMA_VIOLATION when Kernel DMA Protection is enabled

The operating system crashes when the Kernel Direct Memory Access (DMA) Protection feature is enabled in Windows Server 2019 or Windows 10 build 1803 and later, and the following stop error (blue screen error) message is displayed:

> DRIVER_VERIFIER_DMA_VIOLATION (e6)  
An illegal DMA operation was attempted by a driver being verified.  
Arguments:  
Arg1: 0000000000000026, IOMMU detected DMA violation.

> [!NOTE]
> PCI Express devices aren't affected.

This issue occurs when legacy peripheral component interconnect (PCI) devices installed in an external chassis attempt Direct Memory Access. It's a known implementation issue with Kernel DMA Protection.

To work around this issue, disable Kernel DMA Protection in BIOS.

For more information, see [Kernel DMA Protection](/windows/security/information-protection/kernel-dma-protection-for-thunderbolt).

## Status

Microsoft is aware of this issue. A resolution will be provided in an upcoming release.
