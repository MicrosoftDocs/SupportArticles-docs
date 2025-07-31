---
title: Can't Scan From a Scanning Device Connected Through USB
description: Provides a workaround to an issue in which you can't scan from a scanning device connected through USB to a USB-zero-client-connected station.
ms.date: 07/25/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:system performance\system reliability (crash,errors,bug check or blue screen,unexpected reboot)
- pcy:WinComm Performance
---
# Can't scan from a scanning device connected through USB to a USB-zero-client-connected station

## Symptoms

Consider the following scenario:

- You have a server that is running Windows Multipoint Server 2011.
- A scanning device is connected through USB to a USB-zero-client-connected station.
- You select **Scan from device or camera** from a scan application such as Microsoft Paint.

In this scenario, you receive an error message that resembles the following:

> Unable to retrieve picture from device. Verify the device is properly connected and try again.

Additionally, Windows Multipoint Server might restart unexpectedly from a Stop 0x3B error if the scanning device is connected directly to a USB port on the server. In this case, an event similar to the following is logged in Event Viewer under **Windows Logs** > **System**:

```output
Event ID: 1001
Level: Error
Description: The computer has rebooted from a bugcheck. The bugcheck was: 0x0000003b (0x00000000c0000005, 0xfffff8800247e447, 0xfffff88004385cc0, 0x0000000000000000). A dump was saved in: C:\Windows\MEMORY.DMP. Report Id: 030614-19375-01..
```

## Workaround

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

To have us fix this problem for you, go to the "Fix it for me" section. If you prefer to fix this problem yourself, go to the "Let me fix it myself" section.

To work around this problem, use Registry Editor to remove `WmsImageFilter` from the `UpperFilters` registry key. To do this, follow these steps:

1. Open Registry Editor.
2. Locate and select the following registry subkey

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{6BDD1FC6-810F-11D0-BEC7-08002BE2092F}`
3. In the right pane, right-click the multi-string value named `UpperFilters`, and then select **Modify…**.
4. Locate `WmsImageFilter` in the box under **Value Data**, and then remove it from the list.
5. Select **OK** to save the changes, and then close Registry Editor.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products.
