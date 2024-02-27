---
title: Bluetooth and POS peripherals fail to connect
description: This article provides resolutions for the problem where the Human Interface Device Access Service, or HID Input Service fails to start on Windows Embedded for Point of Service.
ms.date: 09/02/2020
ms.subservice: hid-driver
---
# Bluetooth devices and Common POS peripherals fail to connect on Windows Embedded for Point of Service systems

This article helps you resolve the problem where the Human Interface Device Access Service, or HID Input Service fails to start on Windows Embedded for Point of Service.

_Original product version:_ &nbsp; Human Interface Device Access Service, HID Input Service  
_Original KB number:_ &nbsp; 2009753

## Symptoms

The Human Interface Device Access Service, or HID Input Service fails to start on Windows Embedded for Point of Service, the SCM ID 7023 error is seen in the Event Log.

> This missing service can be the root cause of a Windows Embedded for Point of Service failure to enumerate Bluetooth devices. It can also result in the failure of common POS HID devices such as Scanners, Magnetic Strip Readers, and other peripherals that rely on the HID Input Service to connect to a Windows Embedded for Point of Service system.

## Cause

If there is no HID device attached during the Windows Embedded for Point of Service installation, the HIDSERV.DLL file may not install to the system, preventing the HID Service from starting. If HID devices are later added to the Windows Embedded for Point of Service system, or other functionality dependent on the HID Service is required, the failure of the HID Service prevents them from working.

## Resolution

If the HID Input Service or the underlying Bluetooth dependencies are not requirements for the Windows Embedded for Point of Service system, the Service can be disabled to clear up the error reporting in the Event Log.

If the HID Input Service is required, install the missing file following the steps below to start the service.

1. Browse to the `%systemroot%\i386` folder.
2. Double-click the *sp2.cab* file, the compressed files in the *.cab* file will be listed.
3. Copy the *hidserv.dll* file to the `%systemroot%\system32` folder.
4. Restart the HID Input Service, or reboot the computer.
