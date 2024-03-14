---
title: Formula returns #VALUE! error
description: Fixes an issue in which SUMIF, COUNTIF, and COUNTBLANK functions return #VALUE! error.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Excel for Microsoft 365
  - Microsoft Excel 2016
  - Microsoft Excel 2013
  - Microsoft Excel 2010
  - Microsoft Office Excel 2007
  - Microsoft Excel 2002 Standard Edition
  - Microsoft Excel 2000 Standard Edition
ms.date: 03/31/2022
---

# SUMIF, COUNTIF, and COUNTBLANK functions return "#VALUE!" Error

## Symptoms

A formula that contains the **SUMIF**, **SUMIFS**, **COUNTIF**, **COUNTIFS**, or **COUNTBLANK** functions may return the "#VALUE!" error in Microsoft Excel.

> [!NOTE]
> This behavior also applies to the Dfunctions, such as **DAVERAGE**, **DCOUNT**, **DCOUNTA**, **DGET**, **DMAX**, **DMIN**, **DPRODUCT**, **DSTDEV**, **DSTDEVP**, **DSUM**, **DVAR**, and **DVARP**. **OFFSET** and **INDIRECT** functions also have this behavior.

## Cause

This behavior occurs when the formula that contains the function refers to cells in a closed workbook and the cells are calculated.

> [!NOTE]
> If you open the referenced workbook, the formula works correctly.

## Workaround

To work around this behavior, use a combination of the SUM and IF functions together in an array formula.

### Examples

> [!NOTE]
> You must enter each formula as an array formula. To enter an array formula in Microsoft Excel for Windows, press CTRL+SHIFT+ENTER.

#### SUMIF

Instead of using a formula that is similar to the following:

> =SUMIF([Source]Sheet1!$A$1:$A$8,"a",[Source]Sheet1!$B$1:$B$8)

Use the following formula:

> =SUM(IF([Source]Sheet1!$A$1:$A$8="a",[Source]Sheet1!$B$1:$B$8,0))

#### COUNTIF

Instead of using a formula that is similar to the following:

> =COUNTIF([Source]Sheet1!$A$1:$A$8,"a")

use the following formula:

> =SUM(IF([Source]Sheet1!$A$1:$A$8="a",1,0))

#### COUNTBLANK

Instead of using a formula that is similar to the following:

> =COUNTBLANK([Source]Sheet1!$A$1:$A$8)

use the following formula:

> =SUM(IF([Source]Sheet1!$A$1:$A$8="",1,0))

When to use a **SUM(IF())** array formula, use a logical **AND** or **OR** to replace the SUMIFS or COUNTIFS function.

## Status

This behavior is by design.

## More information

The SUMIF function uses the following syntax:

> =SUMIF(range, criteria, sum_range).

See [How to correct a #VALUE! error](https://support.microsoft.com/office/15e1b616-fbf2-4147-9c0b-0a11a20e409e) for more information.

## Reference

For more information about a wizard that can help you create these functions, click **Microsoft Excel Help** on the **Help** menu, type **summarize values that meet conditions by using the conditional sum wizard** in the Office Assistant or the Answer Wizard, and then click **Search** to view the topic.

For more information about array formulas, click **Microsoft Excel Help** on the **Help** menu, type **about using formulas to calculate values on other worksheets and workbooks** in the Office Assistant or the Answer Wizard, and then click **Search** to view the topic.
