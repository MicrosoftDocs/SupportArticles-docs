---
title: Recurring icon is black when printing a calendar
description: Provides workarounds for an issue in which the background of a recurring icon is black when printing an Outlook calendar.
ms.date: 09/30/2020
ms.custom: sap:Print driver
ms.reviewer: riwaida
ms.subservice: print-driver
---
# The background of a recurring icon is black when printing an Outlook calendar

## Symptoms

When printing an Outlook calendar set to daily view, a recurring icon appears with a black background as shown below:

:::image type="content" source="media/recurring-icon-background-is-black/black-icon.png" alt-text="Screenshot of a recurring icon with black background.":::

## Cause

The splwow64.exe process prevents the print driver from writing data to the client application's buffer space.

## Workaround

There are three workarounds:

- Use a 64-bit version of Outlook.
- Use a printer driver which supports Alpha Blend.
- Use EMF spooling depending on the printer driver support. Here’s how to enable EMF spooling in printer properties:
  - In **Control Panel**, select **Devices and Printers** and right-click the printer icon.
  - Select **Printer properties**, select the **Advanced** tab, select the **Enable advanced printing features** check box and click **OK**.

    :::image type="content" source="media/recurring-icon-background-is-black/printer-properties.png" alt-text="Select the Enable advanced printing features in My printer properties.":::
