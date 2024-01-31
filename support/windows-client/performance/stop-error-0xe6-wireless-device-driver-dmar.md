---
title: Stop error 0xE6 after repeatedly disabling and enabling a wireless device driver if DMAr is enabled
description: Describes a memory leak that occurs when you stress test a wireless driver if DMAr is enabled.
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, v-gale
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
ms.subservice: performance
---
# Stop error 0xE6: DRIVER_VERIFIER_DMA_VIOLATION after repeatedly disabling and enabling a wireless device driver if DMAr is enabled

This article helps to fix the Stop error 0xE6: DRIVER_VERIFIER_DMA_VIOLATION that occurs after you repeatedly disable and enable a wireless device driver.

_Applies to:_ &nbsp; Windows 10, version 2004, Windows 10, version 1909, Windows 10, version 1903  
_Original KB number:_ &nbsp; 4576784

## Symptoms

You are stress testing or troubleshooting a wireless device driver for an OEM version of Windows 10. The driver uses direct memory access remapping (DMAr).

As part of your testing, you repeatedly disable and enable the wireless driver (for example, in Device Manager). After several such cycles, you notice that the system operations slow down. After 30 minutes of continuously disabling and enabling the driver, the device runs out of memory and stops responding completely.  

If you try to use the [Driver Verifier](/windows-hardware/drivers/devtest/driver-verifier) tool to analyze the problem, the Windows 10 device experiences a Stop error (also known as a bugcheck or blue screen error). The error code is [0xE6: DRIVER_VERIFIER_DMA_VIOLATION](/windows-hardware/drivers/debugger/bug-check-0xe6--driver-verifier-dma-violation).

## Cause

This problem occurs because the DMA adapter allocates memory that is not deallocated correctly when DMA remapping is enabled.

## Workaround

> [!Important]
> You should use this workaround only in a test environment.

To work around this issue, disable DMA remapping by following these steps:  

1. Restart the computer, and access the BIOS settings by pressing F10 (or whatever key is designated by the manufacturer) during startup.
2. Select **Advanced** > **System Options**, and then clear the **DMA Protection** setting.

## Status

This is a known problem. Microsoft is developing a fix that is scheduled to be included in a future Windows release.

## More information

- [Enabling DMA remapping for device drivers](/windows-hardware/drivers/pci/enabling-dma-remapping-for-device-drivers)
- [DEVPKEY_Device_DmaRemappingPolicy](/windows-hardware/drivers/install/devpkey-device-dmaremappingpolicy)
- [KB 244617: Using Driver Verifier to identify issues with Windows drivers for advanced users](https://support.microsoft.com/help/244617/using-driver-verifier-to-identify-issues-with-windows-drivers-for-adva)
- [Bug Check 0xE6: DRIVER_VERIFIER_DMA_VIOLATION](/windows-hardware/drivers/debugger/bug-check-0xe6--driver-verifier-dma-violation)
