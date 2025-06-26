---
title: Last digits are changed to zeros when you type long numbers in cells of Excel
description: Describes that Excel can store only 15 significant digits in a number. If the number that you type contains more than 15 digits, any digits past the fifteenth digit are changed to zero. Format the number as text to work around this problem.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Editing\Cells
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Excel 2013
  - Excel 2010
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
ms.reviewer: 
ms.date: 05/26/2025
---
# Last digits are changed to zeros when you type long numbers in cells of Excel

## Symptoms

When you type a number that contains more than 15 digits in a cell in Microsoft Excel, Excel changes any digits past the fifteenth place to zeros. For example, you type a credit card ID number in the following format:

> ####-####-####-####

In this situation, Excel changes the last digit to a zero.

## Cause

Excel follows the IEEE 754 specification for how to store and calculate floating-point numbers. Excel therefore stores only 15 significant digits in a number and changes digits after the fifteenth place to zeros

## Workaround

### Add a quotation mark

To prevents digits from being changed to zero, type a single quotation mark before you enter the number.

To do this, select a blank cell, type a single quotation mark ('), and then enter the number. All digits are displayed in the cell. 

:::image type="content" source="./media/last-digits-changed-to-zeros/add-a-quotation-mark.png" alt-text="Type a single quotation mark and enter the number.":::

### Format the cells

To avoid having to type a quotation mark in every affected cell, you can format the cells as text before you enter any data.

1. Select all the affected cells, and then press **Ctrl+1** to open the **Format Cells** dialog box.
2. On the **Number** tab, select **Text** from the **Category** list, and then select **OK**. 

    :::image type="content" source="./media/last-digits-changed-to-zeros/format-cells.png" alt-text="Select Text under the Number tab in the Format Cells dialog box.":::

## More information

This behavior occurs only if the cell is formatted as **Number**, and the number that is entered exceeds 15 digits. For cells that are formatted as text, you can type up to 32,767 characters. Excel displays up to 1,024 characters on the worksheet.

Because custom number formats are designed to work primarily with numbers, you cannot create a custom number format that stores more than 15 digits. For example, you cannot use the following format to store a 16-character credit card ID as a number: 


> ####-####-####-####

However, if you type the number in the cell that is formatted as text, all the characters remain as you type them because Excel stores the number as text and not as a number.  

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
