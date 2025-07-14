---
title: Display more digits in trendline equation coefficients
description: Describes how to display more digits in trendline equation coefficients in Excel.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - Editing\Formulae
  - CSSTroubleshoot
appliesto: 
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
  - Microsoft Office Excel 2002
ms.date: 05/26/2025
---

# Display more digits in trendline equation coefficients in Excel

## Summary

When you add a trendline to a chart, and then display the equation and R-squared value for the trendline, the equation shows only the first five digits of each coefficient. For some purposes, this may not be a sufficient number of significant figures. This article explains how to display more digits in the coefficients.

### Display more digits

The trendline equation and R-squared value are initially displayed as rounded to five digits. To display a greater number of digits, use one of the following methods:

#### Method 1: Microsoft Office Excel 2007

1. Open the worksheet that contains the chart.
2. Right-click the trendline equation or the R-squared text, and then click **Format Trendline Label**.
3. Click **Number**.
4. In the **Category** list, click **Number**, and then change the **Decimal places** setting to 30 or less.
5. Click **Close**.

#### Method 2: Microsoft Office Excel 2003 and earlier versions of Excel

1. Open the worksheet that contains the chart.
2. Double-click the trendline equation or R-squared text.
3. On the Number tab, click Number in the Category list, and then change the **Decimal places** setting to 30 or less.
4. Click OK.

> [!NOTE]
> Even though you can set the number of decimal places to 30 for the Number category, Excel only displays values to a maximum of 15 digits of precision. Additional digits are displayed as zero.
