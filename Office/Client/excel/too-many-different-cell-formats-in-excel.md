---
title: You receive a Too many different cell formats error message in Excel
description: Discusses that you receive a Too many different cell formats error message in Excel. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Excel for Microsoft 365
  - Excel 2019
  - Excel 2016
  - Excel 2013
  - Excel 2010
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
ms.date: 03/31/2022
---

# You receive a "Too many different cell formats" error message in Excel

## Symptoms

In Microsoft Office Excel 2003, when you format a cell or a range of cells, you receive the following error messages:

> **Too many different cell formats.**

> **Excel encountered an error and had to remove some formatting to avoid corrupting the workbook.**

In Microsoft Excel 2013, Microsoft Excel 2010, or Microsoft Excel 2007, files may produce the following error message:

> **Excel found unreadable content in the file.**

The following scenarios are also associated with styles:

- When you open a file, all the formatting is missing.   
- The file size grows after you copy and paste between workbooks.   
- When you try to paste text, you receive the following error message:

   > **Microsoft Excel can't paste data**

   In this scenario, all menu options to paste and the Ctrl+V keyboard shortcut are ignored and produce no results although the Clipboard is not empty.

## Cause

This problem occurs when the workbook contains more than approximately 4,000 different combinations of cell formats in Excel 2003 or 64,000 different combinations in Excel 2007 and later versions. A combination is defined as a unique set of formatting elements that are applied to a cell. A combination includes all font formatting (for example: typeface, font size, italic, bold, and underline), borders (for example: location, weight, and color), cell patterns, number formatting, alignment, and cell protection.

> [!NOTE]
> If two or more cells share the same formatting, they use one formatting combination. If there are any differences in formatting between the cells, each cell uses a different combination.

In Excel, style counts may increase when you copy between workbooks because custom styles are copied.

A workbook that has more than 4,000 styles may open in Excel 2007 and later versions because of the increased limitation for formatting. However, this can cause an error in Excel 2003.

## Resolution

To resolve this problem, use the appropriate method for your situation.

### Method 1

To prevent built-in styles from being duplicated when you copy a workbook, make sure that you have the latest updates for Excel installed from Windows Update.

### Method 2

The following Knowledge Base articles discuss how to prevent copying custom styles between workbooks in one instance of Excel when you move or copy a worksheet.

> [!NOTE]
> These articles require you to install and add a registry key.

- [Unused styles are copied from one workbook to another workbook in Excel 2007](https://support.microsoft.com/help/2553085)
- [Unused styles are copied from one workbook to another in Excel 2010](https://support.microsoft.com/help/2598127)

### Method 3

To clean up workbooks that already contain several styles, you can use one of the following third-party tools.

- Excel formats (xlsx, xlsm)

  [XLStyles Tool](https://sergeig888.wordpress.com/2011/03/21/net4-0-version-of-the-xlstylestool-is-now-available/)

- Binary Excel formats (xls, xlsb), workbooks protected by a password, and encrypted workbooks  

  [Remove Styles Add-in](https://ro.softpedia-secure-download.com/dl/8cf59470c56d8c59ef33441743129a81/61946f8e/100232879/software/OFFICE%20TOOLS/RemoveStyles.xlam)

> [!NOTE]
> You can also download a copy of XLStyles Tool for Windows 10, Windows 8.1, and Windows 8 from [the Microsoft Store](https://www.microsoft.com/store/apps/xlstylestool/9wzdncrfjptg).

### Method 4

Simplify the formatting of your workbooks. For example, follow these guidelines to simplify formatting:

- Use a standard font. By using the same font for all cells, you can reduce the number of formatting combinations.
- If you use borders in a worksheet, use them consistently.

    > [!NOTE]
    > The borders between cells overlap. For example, if you apply a border to the right side of a cell, you do not have to apply a border to the left side of the adjacent cell to the right.
- If you apply patterns to cells, remove the patterns. To do this, open the **Format Cells** dialog box, click the **Patterns** tab, and then click **No Color**.
- Use styles to standardize the formatting throughout the workbook.

> [!NOTE]
> After you simplify or standardize the formatting in the workbook, save, close, and then reopen the workbook before you apply additional cell formatting.

## More information

In most cases, the current limit of different formatting combinations for a single workbook (4,000 for .xls format and 64,000 for .xlsx format) is sufficient. This problem is likely to occur only when the workbook contains many worksheets that use different formatting, or when many cells are formatted differently.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]
