---
title: Columns and rows are labeled numerically
description: Fixes an issue in which column labels are numeric rather than alphabetic in Excel.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Excel 2000
ms.date: 03/31/2022
---

# Columns and rows are labeled numerically in Excel

## Symptoms

Your column labels are numeric rather than alphabetic. For example, instead of seeing A, B, and C at the top of your worksheet columns, you see 1, 2, 3, and so on.

## Cause

This behavior occurs when the **R1C1 reference style** check box is selected in the Options dialog box.

## Resolution

To change this behavior, follow these steps:

1. Start Microsoft Excel.
2. On the **Tools** menu, click **Options**.
3. Click the **Formulas** tab.
4. Under **Working with formulas**, click to clear the **R1C1 reference style** check box (upper-left corner), and then click OK.

If you select the **R1C1 reference style** check box, Excel changes the reference style of both row and column headings, and cell references from the A1 style to the R1C1 style.

## More information

### A1 Reference Style vs. R1C1 Reference Style

#### The A1 Reference Style

By default, Excel uses the A1 reference style, which refers to columns as letters (A through IV, for a total of 256 columns), and refers to rows as numbers (1 through 65,536). These letters and numbers are called row and column headings. To refer to a cell, type the column letter followed by the row number. For example, D50 refers to the cell at the intersection of column D and row 50. To refer to a range of cells, type the reference for the cell that is in the upper-left corner of the range, type a colon (:), and then type the reference to the cell that is in the lower-right corner of the range.

#### The R1C1 Reference Style

Excel can also use the R1C1 reference style, in which both the rows and the columns on the worksheet are numbered. The R1C1 reference style is useful if you want to compute row and column positions in macros. In the R1C1 style, Excel indicates the location of a cell with an "R" followed by a row number and a "C" followed by a column number.

## References

For more information about this topic, click **Microsoft Excel Help** on the **Help** menu, type about cell and range references in the Office Assistant or the Answer Wizard, and then click **Search** to view the topic.
