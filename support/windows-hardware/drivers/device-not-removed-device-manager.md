---
title: Device can't be removed in Device Manager
description: This article provides a resolution for the problem where the hot-pluggable PCI Express or ExpressCard device may still appear in Device Manager after you remove the device.
ms.date: 09/02/2020
ms.subservice: network-driver
---
# PCI Express or ExpressCard device appears connected after being hot-unplugged

This article helps you resolve the problem where the hot-pluggable PCI Express or ExpressCard device may still appear in Device Manager after you remove the device.

_Original product version:_ &nbsp; Windows Vista  
_Original KB number:_ &nbsp; 2470260

## Symptoms

If you have a hot-pluggable PCI Express or ExpressCard device installed in a computer running Microsoft Windows Vista, and then remove (hot-unplug) the device, there is no indication that the device has been removed. For example, the device may continue to appear in Device Manager. Choosing the **Scan for hardware changes** action in Device Manager allows the device removal to be detected, in which case the device no longer appears in Device Manager.

## Cause

This problem may occur on Windows Vista if the hot-pluggable PCI Express or ExpressCard device is installed in a slot provided by certain PCI bridges that signal the device-removal event in an unexpected way.

The Windows Vista PCI bus driver (*PCI.SYS*) expects certain PCI Express/ExpressCard hot-plug events to occur together, such as `SlotEventEnableRequest` & `SlotEventLinkStateActive`, or `SlotEventSurpriseDisableRequest` & `SlotEventLinkStateNotActive`. Some PCI Express bridges do not signal these events together at the same time, with the result that the Windows Vista PCI.SYS does not successfully process these PCI hot-unplug events.

## Resolution

This problem is resolved in Windows Vista Service Pack 2 (SP2) and Windows Server 2008 SP2.

## Applies to

- Windows Vista Ultimate
- Windows Vista Enterprise
- Windows Vista Business
- Windows Vista Home Premium
- Windows Vista Home Basic
- Windows Vista Starter
