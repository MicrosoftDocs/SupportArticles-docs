---
title: Duplex printing options can't be set
description: Resolves an issue that prevents the settings for duplex printing options from being changed through applications.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, naokioh, juesaigo
ms.custom: sap:errors-and-troubleshooting:-print-output-or-print-failures, csstroubleshoot
---
# Two-sided (duplex) printing options cannot be set for applications in Windows 8.1 and Windows 8

This article provides workarounds for an issue where two-sided (duplex) printing options can't be set for applications.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3022505

## Symptoms

When this issue occurs, the printed documents do not respect the settings that you deployed in the duplex printing options.

## Cause

This issue occurs because the duplex printing options currently use the Device charm setting.

## Workaround

To work around this issue, follow these steps to change the duplex printing options.

### Windows 8

1. Open the item that you want to print.
2. Swipe in from the right edge of the screen, tap Devices, and then tap Print. If you are using a mouse, point to the lower-right corner of the screen, move up the mouse pointer, click Devices, and then click Print.
3. Select a printer from the list. You can now see a preview of the item.
4. When **Duplex printing** is displayed in this pane, you can change the settings. Otherwise, tap or click **More settings**. When **Duplex printing** is displayed, you can change the settings.
5. Tap or click Print to print the item.

> [!NOTE]
> If the Duplex printing option is never displayed in step 4, the printer device may be unable to use duplex printing options. You can retry, by using another printer and starting from step 3.

### Windows 8.1

1. Open the item that you want to print.
2. Swipe in from the right edge of the screen, tap **Devices**, and then tap **Print**. If you are using a mouse, point to the lower-right corner of the screen, move up the mouse pointer, click **Devices**, and then click **Print**.
3. Select a printer from the list. You can now see a preview of the item.
4. When **Duplex printing** is displayed in this pane, you can change the settings. Otherwise, tap or click **More settings**. When **Duplex printing** is displayed, you can change the settings.
5. To set duplex printing as the default setting for the selected printer, select the **Use these settings in all applications** option.
6. Tap or click **Print** to print the item.

> [!NOTE]
> If the Duplex printing option is never displayed in step 4, the printer device may be unable to use duplex printing options. You can retry by using another printer and starting from step 3.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.  

## More information

To learn more about how to print more detail, see [How to print](https://windows.microsoft.com/windows-8/how-to-print) in Windows 8.1.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
