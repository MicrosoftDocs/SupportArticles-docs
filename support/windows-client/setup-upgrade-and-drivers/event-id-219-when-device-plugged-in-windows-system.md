---
title: Event ID 219 is logged when a device is plugged into a Windows-based system
description: Describes a scenario in which event ID 219 is logged when a device is plugged into a Windows-based system.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# Event ID 219 is logged when a device is plugged into a Windows-based system

This article provides a solution to an issue where event ID 219 is logged when a device is plugged into a Windows-based system.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 974720

## Symptoms

When a device is plugged into a Windows-based system, the following warning event Kernel-PnP ID 219 is logged together with the event DriverFrameworks-Usermode ID 10114 in the System log:

> (Logged events)  
Warning xxxx/xx/xx xx:xx:xx Kernel-PnP 219 (212)  
The driver \\Driver\\WudfRd failed to load for the device xxxx.  
Information xxxx/xx/xx xx:xx:xx: DriverFrameworks-UserMode 10114 Start UMDF reflector  
WUDFPf (part of UMDF) did not load yet. After it does, Windows will start the device again.

## Cause

When a UMDF device was connected, UMDF driver for that device will be loaded. The Windows Driver Foundation - User-mode Driver Framework service, which is necessary for loading UMDF driver, will be started triggered by loading the driver.

However, for some cases, when the system tries to load the driver, Windows Driver Foundation - User-mode Driver Framework has not started yet. So the two events above are logged.

## Resolution

The driver that Windows tries to load will be retried. Unless the events are logged continuously there is no need to do anything, the events are safe to ignore.

You can confirm the driver is loaded successfully in the **System Information**, and you can confirm the devices are running correctly in the **Device Manager**.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
