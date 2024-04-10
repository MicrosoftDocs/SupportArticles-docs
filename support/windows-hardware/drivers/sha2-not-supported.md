---
title: SHA2 is not supported
description: This article provides a resolution for the issue where Windows Embedded Handheld 6.5 cannot connect to Office 365 Exchange Online through Exchange ActiveSync after certificate updates are made on a server that includes SHA2 encryption.
ms.date: 08/27/2020
ms.reviewer: saroskar, markrad
ms.subservice: general
---
# Windows Embedded HandHeld 6.5 does not support SHA2

This article helps you resolve the issue where Windows Embedded Handheld (WEHH) 6.5 cannot connect to Office 365 Exchange Online through Exchange ActiveSync after certificate updates are made on a server that includes SHA2 encryption.

_Original product version:_ &nbsp; Windows Embedded Handheld  
_Original KB number:_ &nbsp; 2986556

## Symptoms

WEHH 6.5 cannot connect to Office 365 Exchange Online through Exchange ActiveSync after certificate updates are made on a server that includes SHA2 encryption.

## Cause

This problem occurs because WEHH 6.5 and older Windows Mobile (WM) 6.5 OS versions do not support SHA2.

## Resolution

For devices using WEHH 6.5, SHA2 support is added in AKU 35, released in August 2014. Users should check with their Original Equipment Manufacturers (OEMs) to make sure that their device is running an image built on AKU 35 or later.

## More information

The symptoms are also applicable to WM 6.5 devices. WM6.5 is an older version of WEHH6.5. To see which OS version is running on the device, click **Start**, click **Settings**, click **System**, and then click **About**.

Unlike desktop systems, Microsoft does not provide a prebuilt OS to OEMs. Instead, a developer tool set is provided to OEMs that lets each OEM pick and choose which features they want for their hardware, and build their own OS for that particular device. Therefore, OEMs have full control of the OS image on the device. Because of this, if the customer is an end user of WEHH devices and not the manufacturer, the OEM of the device is a better candidate for support for such devices. End-user support for WEHH devices is always provided through their OEM. Microsoft provides support for these devices only to OEMs.

To include this SHA2 code change, the OEM of the device must build a new OS image for WEHH6.5 devices.
WM 6.5  is currently out of support. Therefore, Microsoft will not be releasing any fixes for this OS. For more information about the support lifecycle for WM6.5, see [Search product lifecycle](https://support.microsoft.com/lifecycle/search).

This SHA2 Design Change is targeted at WEHH6.5. Therefore, devices that run older OS versions, such as WM6.5, must be updated to WEHH6.5 to add SHA2 support. End users of WM/WEHH 6.5 devices should contact their respective OEMs to report this issue and request an OS image update.
