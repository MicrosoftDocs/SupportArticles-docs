---
title: Applications don't find a new scanning device
description: This article provides workarounds for the error that occurs when an application does not find a scanning device if that scanner is connected after a different scanner is disconnected.
ms.date: 01/29/2021
ms.custom: sap:Developer Tools\Windows Driver Kit (WDK, HLK)\Windows Driver Kit 10\Other Driver\Scanner
ms.reviewer: jesweare
ms.subservice: other-driver
---
# Applications are unable to find a new scanning device after another device is disconnected

This article helps you work around the error that occurs when an application does not find a scanning device if that scanner is connected after a different scanner is disconnected.

_Original product version:_ &nbsp; Windows 10, Windows 8.1  
_Original KB number:_ &nbsp; 4537086

## Symptoms

Consider the following scenario:

1. You connect a Web Services on Devices (WSD) scanning device to a Windows-based computer.
2. You disconnect the WSD scanner.
3. You connect a different scanning device, such as a USB scanner, to the computer.
4. You start an application that uses the new scanner.
In this scenario, the application may not behave correctly. For example, the application may not find the new scanner.
When this issue occurs, the scanner driver may experience a **WIA_ERROR_OFFLINE** error when it calls the `IStiDevice::LockDevice` method.

> [!NOTE]
> This issue is applicable for Windows 10 versions up to 19H2 (namely Windows 10 Version 1909).  The issue is fixed in 20H1 (Windows 10 Version 2004)

## Cause

This issue occurs if an error occurs in the "Windows Image Acquisition (WIA)" service when the service initializes the WSD scanner. If the initialization process succeeds without any errors, this issue does not occur.

## Workaround

To work around this issue, try any of the following methods:

- Uninstall the connected scanner device (for example, by using Device Manager), and then reconnect the scanner.
- Stop the "Windows Image Acquisition (WIA)" service, and then restart the service.
- Restart the computer while the scanner is connected.

## More information

For more information about errors that a WIA scanner application or driver may experience, see [Error Codes](/windows/win32/wia/-wia-error-codes).
