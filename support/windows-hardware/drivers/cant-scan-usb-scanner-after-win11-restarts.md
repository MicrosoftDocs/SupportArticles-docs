---
title: Can't scan documents from a USB scanner after Windows 11 restarts
description: This article describes the issue where you can't scan documents from a USB scanner that you connect to Windows 11 device after restarting it.
ms.date: 05/03/2022
ms.custom: sap:Print driver
author: HaiyingYu
ms.author: haiyingyu
ms.technology: windows-hardware-print-driver
---

# Can't scan documents from a USB scanner after Windows 11 restarts

This article describes the issue when you can't scan documents from a USB scanner that you connect to a restarted Windows 11 device.

## Symptoms

Consider the scenario where you have a scanner that connects to your Windows 11 device through a USB cable. You've turned off the scanner and unplugged it, restarted Windows 11, and then reconnected the scanner and turned it on.

In this scenario, when you try to scan a document from the scanner, you're unable to scan due to the following error:

> You need a WIA driver to use this device. Please install it from the installation CD or manufacturer's website, and try again.

To verify if this issue is occurring in your device, refer to the Windows Image Acquisition (WIA) service log file (*wiatrace.log*) in the *C:\Windows\debug\WIA\wiatrace.log* path.

If you're encountering this issue, you'll find error messages in the WIA service log that are similar to the following examples:

> [wiaservc.dll] ERROR: USDWrapper::LoadDriver, We encountered an error attempting to load driver for (YourScannerName), error (0x80070057)
>
> [wiaservc.dll] ERROR: DeviceListManager::ProcessDeviceArrival, The driver for device (YourScannerName) failed to load (hr = 0x80070057)

## Cause

This issue might occur when you disconnect the USB scanner, and the WIA service in Windows 11 doesn't refresh the device identifier information after the restart. It's a known issue of the WIA service.

## Workaround

To resolve this issue, restart the WIA service by following these steps:

1. Open Windows Terminal, PowerShell, or Command Prompt as an administrator.

1. Type the `sc.exe stop StiSvc` command, and then select the **Enter** key to stop the WIA service.

   :::image type="content" source="media/cant-scan-from-USB-scanner-after-win11-restarts/stop-wia-service-command.png" alt-text="Stopping WIA service command.":::

1. Type the `sc.exe start StiSvc` command, and then select the **Enter** key to start the WIA service. When the service completes the restart, the WIA driver will be able to retrieve the document from the USB scanner.

   :::image type="content" source="media/cant-scan-from-USB-scanner-after-win11-restarts/restart-wia-service-command.png" alt-text="Starting WIA service command.":::

1. Check if you're able to scan the document.
