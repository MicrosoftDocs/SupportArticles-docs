---
title: Some category labels are missing or too small to read on Excel charts
description: Describes a workaround that you can use when the category labels on an Excel chart are missing or are too small to read.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Excel 2007
- Excel 2003
- Excel 2002
- Excel 2000
- Excel 97
---

# Some category labels are missing or are too small to read on Excel charts

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you view a Microsoft Excel chart that contains labels on the Category Axis, one of the following issues may occur:

- Some of the labels may be missing (such as every other label).
- The labels may be too small to read.
- The labels may be run together (overlap).

## Cause

This issue may occur if one or more of the following conditions are true:

- The frequency of the major units on the Category Axis is not set to display every major unit.
- The font size is too small for you to read the labels on the Category Axis of your Excel chart.
- The font size is too large for Excel to display all the labels correctly on the Category Axis of your Excel chart.

## Workaround

To work around this issue, change the major unit and change the font size of the labels for the Category Axis in your Excel chart. To do this, follow these steps, as appropriate for the version of Excel that you are running.

### Microsoft Office Excel 2007

1. Start Excel, and then open the workbook that contains the Excel chart.
2. Right-click the **Category Axis** that is contained in the Excel chart, and then perform one or both of the following actions:

   - Click **Format Axis**, and then follow these steps:
     1. In the **Format Axis** dialog box, click **Axis Options**.
     2. Next to **Major Unit**, click **Fixed**, and then type 1 in the **Fixed** box.
     3. Click **Close**.
   - In the **Font** box, choose a different font size to use for the labels in the Category Axis.

### Microsoft Office Excel 2003 and earlier versions of Excel

1. Start Excel, and then open the workbook that contains the Excel chart.
2. Right-click the **Category Axis** that is contained in the Excel chart, and then click **Format Axis**.
3. In the **Format Axis** dialog box, perform one or both of the following actions, and then click **OK**:

   - On the **Scale** tab, click to clear the **Major unit** check box, and then change the major unit to **1**.
   - On the **Font** tab, select a different font size to use for the labels in the Category Axis.