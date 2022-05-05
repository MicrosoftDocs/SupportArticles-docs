---
title: Can’t scan document from a USB scanner after your Windows 11 device restarts
description: This article discusses the problem that occurs when you restart your Windows 11 device and connect it with a USB scanner, but you're unable to scan document from the connected scanner.
ms.date: 05/03/2022
ms.custom: sap:Print driver
author: Dipesh-Choubisa
ms.author: v-dchoubisa
ms.technology: windows-hardware-print-driver
---
# Can’t scan a document from the USB scanner after restarting Windows 11 device

This article helps you workaround the problem when you're unable to scan documents from the connected scanner after restarting your Windows 11 device and connecting it with a USB scanner.

## Symptoms

Consider the scenario where you've a scanner connected with your Windows 11 device through a USB cable. You've unplugged and turned off the scanner, restarted Windows 11 device, and then reconnected the scanner and turned it on.

In this scenario, when you try to scan a document from the scanner, you're unable to scan due to the following error:

"You need a WIA driver to use this device. Please install it from the installation CD or manufacturer's website, and try again."

To verify if this issue is occurring in your device, refer to the Windows Image Acquisition (WIA) service log in *C:\Windows\debug\WIA\wiatrace.Log* file.

If you're encountering this issue, you'll find error messages in the WIA service log that are similar to the following examples.

"[wiaservc.dll] ERROR: USDWrapper::LoadDriver, We encountered an error attempting to load driver for (YourScannerName), error (0x80070057)"

"[wiaservc.dll] ERROR: DeviceListManager::ProcessDeviceArrival, The driver for device (YourScannerName) failed to load (hr = 0x80070057)"

## Cause

This issue may occur when you disconnect the USB scanner, and the WIA service in Window 11 does not refresh the device identifier information after the restart. It is a known issue of the WIA service.

## Workaround

To resolve this problem, restart WIA service by following these steps:

1. Open Windows Terminal, PowerShell, or Command Prompt as an Administrator.

1. Type `sc.exe stop StiSvc` command, and then press **Enter** to stop the WIA service.
    :::image type="content" source="media/cant-scan-from-USB-scanner-after-win11-restarts/cant-scan-stop-wia-service.png" alt-text="Stopping WIA service command":::

1. Type `sc.exe start StiSvc` command, and then press **Enter** to start the WIA service.
    :::image type="content" source="media/cant-scan-from-USB-scanner-after-win11-restarts/cant-scan-restart-wia-service.png" alt-text="Starting WIA service command":::

1. Check if you're able to scan the document. When the service completes the restart, the WIA driver will be able to retrieve the document from your USB scanner.
