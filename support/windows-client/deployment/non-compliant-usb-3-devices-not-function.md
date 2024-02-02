---
title: Non-compliant USB 3.0 devices don't function
description: Resolves an issue where some non-compliant USB 3.0 devices don't function when connected to USB 3.0 ports.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:devices-and-drivers, csstroubleshoot
---
# Some non-compliant USB 3.0 devices may not function when connected to USB 3.0 ports in Windows 8

This article provides a solution to an issue where some non-compliant USB 3.0 devices don't function when connected to USB 3.0 ports in Windows 8.

_Applies to:_ &nbsp; Windows 8  
_Original KB number:_ &nbsp; 2792990

## Symptoms

When you connect a USB 3.0 device to a Windows 8 system, the USB device may not be properly recognized and the following Device Status message may be displayed in Device Manager:

> This device cannot start. (Code 10)
>
> The USB device returned an invalid serial number string descriptor.

## Cause

This issue is due to an error in the hardware. The serial number contained in the device is invalid per the USB Mass Storage Specification.

## Resolution

Connect the USB 3.0 device to a USB 2.0 port on the system or contact the manufacturer of the USB 3.0 device for further assistance. Devices that have a Windows 8 logo are guaranteed to be compliant and compatible with Windows 8. To ensure device compatibility, look for the Windows 8 logo when purchasing a device.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
