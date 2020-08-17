---
title: Chart trendline formula is inaccurate in Excel
description: This article documents an issue with the trendline function of an Excel chart when you manually enter X values.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: troubleshoot
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Excel 2010
- Microsoft Office Excel 2007
ms.reviewer: 
---
# Chart trendline formula is inaccurate in Excel

This article documents an inaccurate issue with the trendline function in Excel.

_Original KB number:_ &nbsp; 211967

## Symptoms

The equation displayed for a trendline on an xy (scatter) chart is incorrect. When you manually substitute values for the x variable, Microsoft Excel then plots the trendline incorrectly.

:::image type="content" source="./media/inaccurate-chart-trendline-formula/format-trendline.png" alt-text="format trendline":::

- Trendline equation is a formula that finds a line that best fits the data points.
- R-squared value measures the trendline reliability - the nearer R2 is to 1, the better the trendline fits the data.

> [!NOTE]
> The trendline formula should only be used when your chart is an XY Scatter chart. This chart plots both the X axis and the Y axis as values. Line, Column, and Bar charts plot only the Y axis as values. The X axis is plotted only as a linear series in these chart types, regardless of what the labels actually are. Therefore, the trendline will be inaccurate if displayed on these types of charts. This behavior is by design.

## Cause

Microsoft Excel plots trendlines correctly. However, the equation that is displayed may give incorrect results when you manually type x values. For appearance, each x value is rounded in the number of significant digits that are displayed in the chart. This behavior allows the equation to occupy less space in the chart area. However, the accuracy of the chart is significantly reduced, which can cause a trend to appear to be incorrect.

## Workaround

To work around this behavior, increase the digits in the trendline equation by increasing the number of decimal places that are displayed. To do this, follow these steps:

1. In the chart, select the trendline equation.
1. On the **Format** menu, click **Selected Data Labels**.
1. Click the **Number** tab, and then click **Number** in the **Category** list.
1. In the **Decimal places** box, increase the number of decimal places to 30 so that you can see all the decimal places.
1. Click **OK**.
