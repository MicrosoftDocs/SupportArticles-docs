---
title: USB IPP Multifunction Printer Drivers Fail in Windows 11
description: Learn why Windows 11 update KB5079473 or later can block third-party scanner drivers and prevent scan and fax detection on USB IPP multifunction printers.
ms.subservice: print
ms.date: 07/22/2026
ms.custom: sap:Print Driver
ms.reviewer: riwaida
ai-usage: ai-assisted
---

# Third-party drivers fail on USB IPP multifunction printers in Windows 11

## Summary

On Windows 11 devices with [KB5079473](https://support.microsoft.com/servicing/os/windows-11/2026/03/march-10-2026-kb5079473-os-builds-26200-8037-and-26100-8037) or later update, third-party drivers can fail on USB-connected multifunction printers that use Internet Printing Protocol (IPP) over USB. Scanner drivers might not install, and Windows might not recognize scanner or fax functions. This article explains the affected scenario and provides a reconnection method that might temporarily restore scanner detection while Microsoft investigates the issue.

## Prerequisites

This issue applies to devices that meet the following conditions:

- The device is running Windows 11.
- Windows 11 update KB5079473 or later is installed.
- A USB-connected multifunction printer is in use.
- The printer supports Internet Printing Protocol (IPP) over USB.

## Symptoms

On devices running Windows 11 with updates starting from KB5079473 or later, scanner drivers might fail to install on certain USB-connected multifunction printers.

This issue affects USB composite devices that support Internet Printing Protocol (IPP) over USB. In affected scenarios, non-printing functions within the composite device, such as scanners or fax interfaces, enter a disconnected state and aren't recognized by Windows 11.

As a result:

- Scanner functionality might stop working.
- Fax interfaces might not be available.
- Third-party drivers (for example, scanner drivers) might fail to install.
- The multifunction printer might not be fully recognized by the system.

## Cause

This problem occurs when Windows 11 detects a USB composite device that supports Internet Printing Protocol (IPP) over USB. During device initialization, non-printing interfaces such as scanner or fax functions might become inactive or disconnected. This condition prevents the operating system from recognizing those components correctly.

## Reconnect the USB device

Currently, there's no confirmed workaround for this problem. Microsoft is investigating the problem and working on a fix.

However, in some environments, removing and reconnecting the affected USB device temporarily restores scanner detection. To try this method:

1. Open **Settings**.
1. Select **Bluetooth & devices** > **Printers & scanners**.
1. Select the affected multifunction printer, and then remove the device.
1. Disconnect the USB cable from the device.
1. Reconnect the USB device to the system.

In some cases, Windows 11 recognizes the scanner device again after the device is reconnected.
