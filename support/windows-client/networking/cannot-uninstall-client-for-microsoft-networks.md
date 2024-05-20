---
title: Error 0x80071779 when removing network components
description: Address an issue in which you receive error 0x80071779 when removing Client for Microsoft Networks.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\TCP/IP Connectivity (TCP Protocol, NLA, WinHTTP), csstroubleshoot
---
# Error 0x80071779 when removing network components in Windows 10

This article helps fix an error 0x80071779 that occurs when you uninstall the **Client for Microsoft Networks** or other network components.

_Applies to:_ &nbsp; Window 10 – all editions  
_Original KB number:_ &nbsp; 4340181

## Symptoms

Starting with Windows 10, version 1803 and newer based device or computer, you can't uninstall the **Client for Microsoft Networks** or other network components. You receive the following error message:

> Could not uninstall the Client for Microsoft Networks feature.  
>
> The error is 0x80071779.

:::image type="content" source="media/cannot-uninstall-client-for-microsoft-networks/error-0x80071779.png" alt-text="Screenshot of the 0x80071779 error message.":::

## Cause

This behavior is by design.

## Resolution

Microsoft doesn't support using this GUI or **netcfg** to uninstall protocols or built-in drivers. Instead, you can unbind the driver from Network Adapters either by using this GUI or the PowerShell cmdlet `Disable-NetAdapterBinding`. This is effectively the same as uninstalling the driver.

## More information

If there are specific drivers that you want to remove but that are currently not part of an optional feature, file a feature request in the [Feedback Hub](https://www.microsoft.com/store/productId/9NBLGGH4R32N).
