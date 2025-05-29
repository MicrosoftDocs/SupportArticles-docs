---
title: Chart trendline formula is inaccurate in Excel
description: This article documents an issue with the trendline function of an Excel chart when you manually enter X values.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Editing\Charts
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Excel 2010
  - Microsoft Office Excel 2007
ms.reviewer: 
ms.date: 05/26/2025
---
# Chart trendline formula is inaccurate in Excel

## Symptoms

The equation that is displayed for a trendline on an XY Scatter chart in Microsoft Excel is incorrect. Microsoft Excel plots the incorrect trendline when you manually substitute values for the “x” variable.

:::image type="content" source="./media/inaccurate-chart-trendline-formula/format-trendline.png" alt-text="Screenshot of Trendline Options on the Format Trendline window.":::

- **Trendline equation** is a formula that finds a line that best fits the data points.
- **R-squared value** measures the trendline reliability - the nearer R2 is to 1, the better the trendline fits the data.

> [!NOTE]
> The trendline formula is used for an XY Scatter chart. This chart plots both the X axis and Y axis as values. Line, Column, and Bar charts plot only the Y axis as values. In these chart types, the X axis is plotted as only a linear series, regardless of what the labels actually are. Therefore, the trendline is inaccurate if it's displayed on these types of charts. This behavior is by design.

## Cause

Microsoft Excel plots trendlines incorrectly because the displayed equation may provide inaccurate results when you manually enter X values. For appearance, each X value is rounded off to the number of significant digits that are displayed in the chart. This behavior allows the equation to occupy less space in the chart area. However, the accuracy of the chart is reduced. It can cause a trend to appear to be incorrect.

## Workaround

To work around this behavior, increase the digits in the trendline equation by increasing the number of decimal places that are displayed:

1. In the chart, select the trendline equation.
1. On the **Format** menu, click **Selected Data Labels**.
1. Select the **Number** tab, and then select **Number** in the **Category** list.
1. In the **Decimal places** box, increase the number of decimal places to 30 so that you can see all the decimal places.
1. Select **OK**.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
