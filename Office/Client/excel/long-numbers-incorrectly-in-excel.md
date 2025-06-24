---
title: Long numbers are displayed incorrectly in Excel
description: Describes how to show long numbers in Excel cells.
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
  - Excel 2010
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
ms.date: 05/26/2025
---

# Long numbers are displayed incorrectly in Excel

## Symptoms

After you enter a long number (such as a credit card number) in an Excel cell, the number isn't displayed correctly in Excel. For example,

:::image type="content" source="media/long-numbers-incorrectly-in-excel/example-for-long-number-not-showing-correctly-in-excel.png" alt-text="An example for a long number that's not shown correctly in Excel.":::

> [!NOTE]
> Default number format in Excel is General therefore you can display up to 11 digits in a cell.

## Workaround

To work around this issue, use one of the following methods.

### Method 1: Format the cell as text

To do this, follow these steps:

1. Right-click target cell, and then click **Format Cells**.

    :::image type="content" source="media/long-numbers-incorrectly-in-excel/format-cells.png" alt-text="Format a cell as text by selecting the Format Cells.":::

2. On the **Number** tab, select **Text**, and then click **OK**.

    :::image type="content" source="media/long-numbers-incorrectly-in-excel/text-option-under-number.png" alt-text="Select the Text under the Number tab in the Format Cells dialog box." border="false":::

3. Then type a long number. (Be sure to set the cell format before you type the number)

    :::image type="content" source="media/long-numbers-incorrectly-in-excel/a-long-number.png" alt-text="Type a long number.":::
4. If you don't want to see the warning arrows, click the small arrow, and then click **Ignore Error**.

   :::image type="content" source="media/long-numbers-incorrectly-in-excel/ignore-error.png" alt-text="Select Ignore Error if you don't want to see the warning arrows.":::

   :::image type="content" source="media/long-numbers-incorrectly-in-excel/result-of-method-1.png" alt-text="The result of method 1.":::

### Method 2: Use a single quotation mark

When you enter a long number, type a single quotation mark (**'**) first in the cell, and then type the long number.

For example, type **'1234567890123456789** and the quotation mark won't be displayed after you press ENTER.

:::image type="content" source="media/long-numbers-incorrectly-in-excel/type-quotation-mark.png" alt-text="Add a single-quotation mark before typing a long number.":::

## Related articles

[Format numbers as text in Excel for Mac](https://support.microsoft.com/office/format-numbers-as-text-in-excel-for-mac-dfbe20dc-e7b1-44b2-80fe-2072d074e2a3)

Your opinion is important to us! Don't hesitate to tell us what you think of this article using the comment field located at the bottom of the document. This will allow us to improve the content. Thank you in advance!
