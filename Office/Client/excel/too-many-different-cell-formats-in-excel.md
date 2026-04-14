---
title: Excel found unreadable content in the file error message in Excel
description: Discusses an Excel error message that states, Excel found unreadable content in the file. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: v-kccross, akeeler, v-lisalozano
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Editing\Cells
  - CSSTroubleshoot
  - CI 11127
appliesto: 
  - Excel for Microsoft 365
  - Excel 2024
  - Excel 2021
  - Excel 2019
  - Excel 2016
ms.date: 04/13/2026
---

# "Excel found unreadable content in the file" error message in Excel

## Symptoms

Files may produce the following error message:

> **Excel found unreadable content in the file.**

The following scenarios are also associated with styles:

- When you open a file, all the formatting is missing.
- The file size grows after you copy and paste between workbooks.
- When you try to paste text, you receive the following error message:

   > **Microsoft Excel can't paste data**

   In this scenario, all menu options to paste and the Ctrl+V keyboard shortcut are ignored and produce no results although the Clipboard is not empty.

## Cause

This problem occurs when the workbook contains more than approximately 64,000 different combinations. A combination is defined as a unique set of formatting elements that are applied to a cell. A combination includes all font formatting (for example: typeface, font size, italic, bold, and underline), borders (for example: location, weight, and color), cell patterns, number formatting, alignment, and cell protection.

> [!NOTE]
> If two or more cells share the same formatting, they use one formatting combination. If there are any differences in formatting between the cells, each cell uses a different combination.

In Excel, style counts may increase when you copy between workbooks because custom styles are copied.

## Resolution

To resolve this problem, use the appropriate method for your situation.

### Method 1

To prevent built-in styles from being duplicated when you copy a workbook, make sure that you have the latest updates for Excel installed from Windows Update.

### Method 2

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
