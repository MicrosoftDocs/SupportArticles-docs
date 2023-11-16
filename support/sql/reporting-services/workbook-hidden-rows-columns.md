---
title: Workbook contains hidden rows and columns
description: This article provides a workaround for the problem where hidden rows or columns are inserted in an Excel workbook when you export reports from SQL Server Reporting Services to Excel.
ms.date: 07/22/2020
ms.custom: sap:Reporting Services
ms.reviewer: kayokon, shink, ramakoni
---
# Workbook contains hidden rows and columns when you export reports from SQL Server Reporting Services to Excel

This article helps you work around the problem where hidden rows or columns are inserted in an Excel workbook when you export reports from SQL Server Reporting Services (SSRS) to Excel.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2777223

## Symptoms

When you export a Microsoft SSRS report to an Excel workbook, there are hidden rows or columns in the workbook. The following image is an example of this problem:

:::image type="content" source="media/workbook-hidden-rows-columns/hidden-rows-example.png" alt-text="Screenshot shows an example of hidden rows, where the 8th row height is too small (hidden row).":::

## Cause

This problem occurs because row heights or column widths are rounded.

Report Definition Language (RDL) enables you to use several measurement units (for example, `inches`, `pixels`, `centimeters`, and `points`) to specify position and size values. However, Excel uses only `points`. Therefore, the SSRS Excel rendering extension converts the height and width of the table, the heights of the rows, and the widths of the columns to `points`. This process may include rounding some values. In this situation, the table height or width and the sum of the row heights or column widths are different. To compensate for the difference, the SSRS Excel rendering extension inserts a small row or column to the workbook.

## Workaround

To work around this issue, specify the measurement unit in `points`.

> [!NOTE]
> You can convert other measurement units to points. For example, you can convert inches to points by using a ratio of 1 inch to 72 points.
