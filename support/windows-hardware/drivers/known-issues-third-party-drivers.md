---
ms.custom: SourcePlatform=Content
ai-usage: ai-assisted
ms.custom.created: 07/17/2026
author: Ryoichi Iwaida
ms.author: riwaida
ms.service: windows-hardware-driver-quality
ms.topic: troubleshooting
ms.date: 07/17/2026
title: Known issues Third-party drivers fail on USB IPP multi-function printers in Windows 11
description: Windows 11 KB5079473+ can break USB IPP printer scanning/fax detection.
---
# Known issues: Third-party drivers fail on USB IPP multi-function printers in Windows 11

This article describes a known issue affecting device functionality on some USB-connected multi-function printers in Windows 11. The issue occurs on devices running Windows 11 updates starting with [KB5079473](https://support.microsoft.com/help/5079473) or later.

In affected environments, Scanner drivers might fail to install, and non-printing functions such as scanning or faxing might not be recognized by the operating system. Microsoft is investigating the issue and working on a resolution.

## Some functions of USB composite devices may not be recognized

On devices running Windows 11 with updates starting from KB5079473 or later, Scanner drivers might fail to install on certain USB-connected multi-function printers.

This issue affects USB composite devices that support Internet Printing Protocol (IPP) over USB. In affected scenarios, non-printing functions within the composite device, such as scanners or fax interfaces, can enter a disconnected state and are not recognized by Windows 11.

As a result:

*   Scanner functionality might stop working.
*   Fax interfaces might not be available.
*   Third-party drivers (for example, scanner drivers) might fail to install.
*   The multi-function printer might not be fully recognized by the system.

Microsoft is currently investigating this issue and working on a fix.

## Prerequisites

This issue applies to devices that meet the following conditions:

*   The device is running Windows 11.
*   Windows 11 update KB5079473 or later is installed.
*   A USB-connected multi-function printer is in use.
*   The printer supports Internet Printing Protocol (IPP) over USB.

### Troubleshooting steps

There is currently no confirmed workaround for this issue.

However, in some environments, scanner detection has been temporarily restored by removing and reconnecting the affected USB device. To try this method:

1.  Open Settings.
2.  Select Bluetooth & devices > Printers & scanners.
3.  Select the affected multi-function printer, and then remove the device.
4.  Disconnect the USB cable from the device.
5.  Reconnect the USB device to the system.

In some cases, Windows 11 recognizes the scanner device again after the device is reconnected.

### Possible causes

This issue can occur when Windows 11 detects a USB composite device that supports Internet Printing Protocol (IPP) over USB. During device initialization, non-printing interfaces such as scanner or fax functions might become inactive or disconnected, which can prevent the operating system from recognizing those components correctly.