---
title: Stop code DRIVER_VERIFIER_DMA_VIOLATION (0xE6)
description: Helps to fix the stop error DRIVER_VERIFIER_DMA_VIOLATION (0xE6) when kernel Direct Memory Access (DMA) protection is enabled.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, fredjeng, ryanman, v-lianna, junakaya
ms.custom:
- sap:system performance\system reliability (crash,errors,bug check or blue screen,unexpected reboot)
- pcy:WinComm Performance
---
# Stop code DRIVER_VERIFIER_DMA_VIOLATION when Kernel DMA Protection is enabled

The operating system crashes when the Kernel Direct Memory Access (DMA) Protection feature is enabled in Windows Server 2019 or Windows 10, version 1803 and later, and the following stop error (blue screen error) message is displayed:

> DRIVER_VERIFIER_DMA_VIOLATION (e6)  
An illegal DMA operation was attempted by a driver being verified.  
Arguments:  
Arg1: 0000000000000026, IOMMU detected DMA violation.

> [!NOTE]
> PCI Express devices aren't affected.

This issue occurs when legacy peripheral component interconnect (PCI) devices installed in an external chassis attempt Direct Memory Access. It's a known implementation issue with Kernel DMA Protection.

To work around this issue, disable [Kernel DMA Protection](/windows/security/information-protection/kernel-dma-protection-for-thunderbolt) in BIOS.

To resolve this issue in Windows Server 2019, you can upgrade to Windows Server 2022 and install the [October 10, 2023—KB5031364 (OS Build 20348.2031)](https://support.microsoft.com/en-us/topic/october-10-2023-kb5031364-os-build-20348-2031-7f1d69e7-c468-4566-887a-1902af791bbc) update.
