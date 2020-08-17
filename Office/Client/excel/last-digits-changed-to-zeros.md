---
title: Last digits are changed to zeros when you type long numbers in cells of Excel
description: Describes that Excel can store only 15 significant digits in a number. If the number that you type contains more than 15 digits, any digits past the fifteenth digit are changed to zero. Format the number as text to work around this problem.
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
- Excel 2013
- Excel 2010
- Microsoft Office Excel 2007
- Microsoft Office Excel 2003
ms.reviewer:
---
# Last digits are changed to zeros when you type long numbers in cells of Excel

This article documents a workaround for an issue in which the last digits are changed to zeros if the number that you type contains more than 15 digits.

_Original KB number:_ &nbsp; 269370

## Symptoms

When you type a number that contains more than 15 digits in a cell, Microsoft Excel changes any digits past the fifteenth place to zeros. For example, if you type a credit card ID number in the following format:

> ####-####-####-####

Excel changes the last digit to a zero.

## Cause

Excel follows the IEEE 754 specification on how to store and calculate floating-point numbers. Excel therefore stores only 15 significant digits in a number and changes digits after the fifteenth place to zeros

## Workaround

### Stop Last Number From Changing To 0 With Adding Single Quotation Mark

For stopping number from changing to zero, you can add single quotation mark before entering the numbers in cell.

Select a blank cell and enter ' into it, and then enter the numbers, and you can see all numbers are exactly displayed in the cell. See the following screenshot:

:::image type="content" source="./media/last-digits-changed-to-zeros/example.png" alt-text="example":::

### Stop Last Number From Changing To 0 With Format Cells

Advanced to adding single quotation one by one to stop number from changing to zero, you also can format the cells as text formatting before you enter numbers.

1. Select the cells that you want to enter numbers longer than 15 digits, and then press **Ctrl** + **1** to display the **Format Cells** dialog.
1. In the popping **Format Cells** dialog, under **Number** tab, and select **Text** from the **Category** list. See screenshot:

    :::image type="content" source="./media/last-digits-changed-to-zeros/format-cells.png" alt-text="Format cells":::

1. Then select **OK**, and when you enter numbers in the selected cells, the number won’t be changed to zero any longer.

## More information

This behavior occurs only when the cells are formatted as numbers and exceeds 15 digits. Cells that are formatted as text, you can type up to 32,767 characters, of which Excel displays up to 1,024 characters on the worksheet.

Because custom number formats are designed to work primarily with numbers, you cannot create a custom number format that stores more than 15 digits. For example, you cannot use the following format to store a 16-character credit card ID as a number:

> ####-####-####-####

If you type the number 1111222233334444 in a cell that uses the ####-####-####-#### format, Excel displays 1111-2222-3333-4440 in the cell. The actual number that you are attempting to store is 1,111,222,233,334,444, which is over one quadrillion, as this number is so large Excel drops the last (least significant) digit, and puts a zero in its place.

If you type the number in the cell that is formatted as text, all the characters remain as you type them because Excel does not attempt to store the credit card ID as a number, whereas leaves it as text.
