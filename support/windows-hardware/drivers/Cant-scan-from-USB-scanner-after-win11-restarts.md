---
title: Can’t scan document from a USB scanner after your Windows 11 device restarts
description: This article discusses the problem that occurs when you restart your Windows 11 device and connect it with a USB scanner, but you're unable to scan document from the connected scanner.
ms.date: 05/03/2022
ms.custom: sap:Print driver
author: Dipesh-Choubisa
ms.author: v-dchoubisa
ms.technology: windows-hardware-print-driver
---
# Can’t scan document from a USB scanner device after Windows 11 restarts

This article discusses the problem that occurs when you restart your Windows 11 device and connect it with a USB scanner, but you're unable to scan document from the connected scanner.

## Symptoms

You've a scanner connected with your Windows 11 device by using USB cable. Consider the scenario where you've unplugged and turned off the scanner, and then reconnected and turned the scanner on after restarting your Windows 11 device.

In this scenario, if you try to scan a document from the scanner, you are unable to scan the document due to the following error:

"You need a WIA driver to use this device. Please install it from the installation CD or manufacturer's website, and try again."

You can verify by referring WIA service log whether this issue is occurring on your device. To verify, find WIA service log into the *C:\Windows\debug\WIA\wiatrace.log* file.

If you see similar error messages to the following example in your WIA service log, then you're encountering this issue.

"[wiaservc.dll] ERROR: USDWrapper::LoadDriver, We encountered an error attempting to load driver for (YourScannerName), error (0x80070057)"

"[wiaservc.dll] ERROR: DeviceListManager::ProcessDeviceArrival, The driver for device (YourScannerName) failed to load (hr = 0x80070057)"

## Cause

This issue occurs because Windows Image Acquisition (WIA) service on Windows 11 might not refresh the device identifier information after the restart, whenever the scanner is disconnected.
This problem is the known issue of WIA service.

## Workaround

To resolve this problem, restart WIA service by following these steps:

1. Open Windows Terminal, PowerShell, or Command Prompt as Administrator.

1. Type `sc.exe stop StiSvc` command, and then press **Enter** to stop WIA service.
    :::image type="content" source="media/cant-scan-from-USB-scanner-after-win11-restarts/cant-scan-stop-wia-service.png" alt-text="Stopping WIA service command":::

1. Type `sc.exe start StiSvc` command, and then press **Enter** to start the service.
    :::image type="content" source="media/cant-scan-from-USB-scanner-after-win11-restarts/cant-scan-restart-wia-service.png" alt-text="Starting WIA service command":::

1. Check if you're able to scan the document. When the service completes restarting, your WIA driver will be able to retrieve document from your USB scanner.
