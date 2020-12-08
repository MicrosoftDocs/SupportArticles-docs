---
title: Event ID 219 is logged when a device is plugged into a Windows-based system
description: Describes a scenario in which event ID 219 is logged when a device is plugged into a Windows-based system.
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Event ID 219 is logged when a device is plugged into a Windows-based system

_Original product version:_ &nbsp; Windows 10, version 2004, all editions, Windows Server, version 2004, all editions, Windows 10, version 1909, all editions, Windows 10, version 1803, all editions, Windows Server version 1803, Windows Server version 1709, Windows Server version 1803, Windows 10, version 1709, all editions, Windows 8, Windows 8.1, Windows 10, Windows Server 2008 R2 Enterprise, Windows Server 2008 R2 Standard, Windows Server 2008 R2 Datacenter, Windows Server 2012 Datacenter, Windows Server 2012 Standard, Windows Server 2012 R2 Standard, Windows Server 2012 R2 Datacenter, Windows Server 2016  
_Original KB number:_ &nbsp; 974720

## Symptoms

When a device is plugged into a Windows-based system, the following warning event Kernel-PnP ID 219 is logged together with the event DriverFrameworks-Usermode ID 10114 in the System log:  
(Logged events)
Warning xxxx/xx/xx xx:xx:xx Kernel-PnP 219 (212)
The driver \Driver\WudfRd failed to load for the device xxxx.
Information xxxx/xx/xx xx:xx:xx: DriverFrameworks-UserMode 10114 Start UMDF reflector
WUDFPf (part of UMDF) did not load yet. After it does, Windows will start the device again.

```

```

## Cause

When a UMDF device was connected, UMDF driver for that device will be loaded. The Windows Driver Foundation - User-mode Driver Framework service, which is necessary for loading UMDF driver, will be started triggered by loading the driver.

However, for some cases, when the system tries to load the driver, Windows Driver Foundation - User-mode Driver Framework has not started yet. So the two events above are logged. 

## Resolution

The driver that Windows tries to load will be retried. Unless the events are logged continously there is no need to do anything, the events are safe to ignore. 

You can confirm the driver is loaded successfully in the System Information, and you can confirm the devices are running correctly in the Device Manager.
