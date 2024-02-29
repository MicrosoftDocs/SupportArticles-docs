---
title: Bug check 0x124 after a Windows in-place upgrade on Apple devices
description: Helps resolve bug check 0x124 after performing an in-place upgrade of Windows 10 by using Boot Camp Assistant on Apple devices.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jasone, clfish, v-lianna
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot, ikb2lmc
---
# Bug check 0x124 after an in-place upgrade of Windows 10 by using Boot Camp on Apple devices

This article helps resolve bug check 0x124 that occurs after performing an in-place upgrade of Windows 10 by using [Boot Camp Assistant](https://support.microsoft.com/topic/how-to-install-windows-10-on-mac-4cbe5c9c-cd37-87e1-043c-27e8f764b12d) on Apple devices. 

You have an Apple device (such as an iMac or  MacBook Pro) that runs Boot Camp Assistant to dual-boot Windows and macOS. After you perform an in-place upgrade to Windows 10, version 1709 via Microsoft System Center Configuration Manager (SCCM), you receive [bug check 0x124 WHEA_UNCORRECTABLE_ERROR](/windows-hardware/drivers/debugger/bug-check-0x124---whea-uncorrectable-error), and Windows fails to boot.

## USB-C adapters prevent Windows from booting

This issue occurs if the device has a secondary display or USB device connected via a USB-C adapter.

> [!NOTE]
> If you connect only the USB-C adapter without any device connected, Windows fails to boot, and macOS reports a kernel panic with the following error message:
> CATERR detected! No MCA data found.

To work around this issue, disconnect the USB-C adapter.

## Disable the USB selective suspend setting

To resolve this issue, follow these steps:

1.	Open Control Panel and select **Hardware and Sound** > **Power Options**.
2.	For the selected plan, select **Change plan settings** > **Change advanced power settings**.
3.	Expand **USB settings** > **USB selective suspend setting**, change the **Setting** to **Disabled**, and then select **OK**.
4.	Turn off the Apple device and reconnect the USB-C adapter. Then, restart the device to check whether the issue is fixed.

## Disable other power management settings

If the above method doesn't work, try to disable the other power management setting as follows:

1.	Open Device Manager and expand **Universal Serial Bus controllers**.
2.	Right-click a USB device entry and select **Properties**.
3.	On the **Power Management** tab, clear the **Allow the computer to turn off this device to save power** checkbox.

If the issue still exists, repeat steps 2 and 3 to determine the specific USB device that causes the issue. Then, disable the **Allow the computer to turn off this device to save power** setting on the device.
 
For more information, see [MacBook Pro 2017 bootcamp Windows 10 freezes when connecting Apple USB C AV digital adapter](https://discussions.apple.com/thread/8171221). 

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
