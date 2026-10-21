---
title: Kernel-PnP Event ID 219 is logged together with UMDF Event ID 10118 during Windows startup
description: Describes why Kernel-PnP event ID 219 might be logged with UMDF event ID 10118 during Windows startup and when no action is required.
ms.date: 10/20/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:Windows Device and Driver Management\Issues with drivers or updates for peripheral devices
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Kernel-PnP Event ID 219 is logged together with UMDF Event ID 10118 during Windows startup

This article explains why Kernel-PnP event ID 219 might be logged together with User-Mode Driver Framework (UMDF) event ID 10118 during Windows startup and when these events can be safely ignored.

_Original KB number:_ &nbsp; 974720

## Symptoms

During Windows startup, when Windows tries to start a device that uses a UMDF driver, the following Kernel-PnP warning event might be logged in the System log:

> Warning xxxx/xx/xx xx:xx:xx Kernel-PnP 219 (212)  
> The driver \\Driver\\WudfRd failed to load for the device xxxx.

This warning might be accompanied by the following DriverFrameworks-UserMode informational event:

> Information xxxx/xx/xx xx:xx:xx DriverFrameworks-UserMode 10118 Startup of the UMDF reflector  
> UMDF reflector is unable to connect to service control manager (SCM). This is expected during boot, when SCM has not started yet. Will retry when it starts.

## Cause

The UMDF reflector is the kernel-mode component that enables a device to use a UMDF driver. During Windows startup, the reflector might try to connect to the Service Control Manager (SCM) before SCM has started.

In this situation, the reflector logs informational event ID 10118 to indicate that the connection isn't yet available and will be retried when SCM starts. Kernel-PnP event ID 219 might also be logged because the device couldn't be started at that time.

## Resolution

For this startup timing condition, no action is required. The UMDF reflector retries the connection when SCM starts, allowing Windows to retry starting the device.

If the events occur only during startup and the device subsequently starts and works correctly, you can safely ignore them.

You can check the driver's status in **System Information** and confirm that the device is working correctly in **Device Manager**.

If the events continue after startup or the device doesn't work correctly, investigate the device or driver issue. Don't assume that every Kernel-PnP event ID 219 is caused by this startup timing condition.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
