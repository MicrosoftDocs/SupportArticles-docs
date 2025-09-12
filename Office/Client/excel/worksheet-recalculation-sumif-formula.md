---
title: Recalculation of worksheet that contains SUMIF takes longer to finish
description: Describes an issue where Excel takes a long to complete the recalculation and move the insertion point to the next cell. Occurs when you type a number in a cell in a worksheet that contains a SUMIF formula.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Editing\Formulae
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - Excel 2016
  - Excel 2013
  - Excel 2010
  - Excel 2007
  - Excel 2003
ms.date: 05/26/2025
---

# Recalculation of a worksheet that contains a SUMIF formula takes longer than expected to finish

## Symptoms

When Microsoft Excel recalculates a worksheet that contains a SUMIF formula, the recalculation takes longer to finish than expected.

For example, you type a number into a cell in the worksheet. Then, you press TAB. When Excel recalculates the worksheet, Excel takes longer to move the insertion point to the next cell in the worksheet than expected.

## Cause

This issue may occur if the arguments in a SUMIF formula do not contain the same number of cells.

For example, this issue may occur if you use the following SUMIF formula in the worksheet.

```excel
=SUMIF($C$1:$F$3000,1,$G$1:$G$3000)
```

> [!NOTE]
> The first and third arguments in the formula do not contain the same number of cells (rows and columns).

## Resolution

To resolve this issue, use the same number of cells in the first and third arguments of the SUMIF formula.

For example, to resolve this issue in the formula in the "Cause" section, change the formula as shown in the following example.

```excel
=SUMIF($C$1:$C$3000,1,$G$1:$G$3000)
```

## More Information

For more information about how to use the SUMIF formula, click **Microsoft Excel Help** on the **Help** menu, type SUMIF in the **Search for** box in the Assistance pane, and then click **Start searching** to view the topic.
