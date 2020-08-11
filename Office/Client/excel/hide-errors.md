---
title: How to create a conditional format to hide errors in Excel
description: Describes how to create conditional formatting on a cell or on a range of cells so that error values are not displayed in the cell(s).
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

# How to create a conditional format to hide errors in Excel

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary

In Microsoft Excel, you can create conditional formatting on a cell or on a range of cells so that error values are not displayed in the cell(s).

## More Information

In versions of Excel that are earlier than Microsoft Excel 97, you could not create a custom conditional format to hide error values that were returned to the cell by the cell formula.

For example, #DIV/0! is returned to cell A1 if you enter the following data in the worksheet:

A1: =B1/C1 B1: 5 C1: 0

To hide the error value, you can change the formula in cell A1 to the following formula:

**=IF(ISERROR(B1/C1),"",B1/C1)**

In these examples, this formula returns the empty string ("").

In Microsoft Office Excel 2007, you can use the IFERROR function to simplify this formula, as follows:

**=IFERROR(B1/C1,"")**

Note that there are other techniques for hiding error values that you can use in versions of Excel that are earlier than Excel 97.

Conditional formatting allows you to use the simpler of the two formulas in cell A1 and still prevent the error value from appearing in cell A1.

To use conditional formatting to hide error values that are returned by formulas in cells, use one of the following sample procedures, as appropriate for the version of Excel that you are running.

### Microsoft Office Excel 2003 and earlier versions of Excel

1. Enter the following data in a worksheet:
 
   A1: =B1/C1 B1: 5 C1: 0

   A2: =nofunction()*B2 B2: 6 C2: 0
   
   > [!NOTE]
   > Cell A1 returns the #DIV/0! error value, and cell A2 returns the #NAME? error value. This occurs because the nofunction() function that is used in cell A2 is not a valid function.

1. Select column A.
1. On the **Format** menu, click **Conditional Formatting**.
1. In the **Conditional Formatting** dialog box, click **Condition 1**, and then click **Formula Is**.
1. In the edit box to the right of **Condition 1**, type the following formula:

   **=ISERROR(A1)**

1. Click the **Format** button. In the
**Format Cells** dialog box, click **Color**, and then click the **White** square.
1. Click **OK** in the **Format Cells** dialog box, and then click **OK** in the **Conditional Formatting** dialog box.

   > [!NOTE]
   > Because you selected column A in step 2, all the cells in column A were formatted with this conditional format. Therefore, any other cells in column A that return error values will not display the error value.

### Microsoft Office Excel 2007

1. Enter the following data in a worksheet: 
 
   A1: =B1/C1 B1: 5 C1: 0

   A2: =nofunction()*B2 B2: 6 C2: 0
   
   > [!NOTE]
   > Cell A1 returns the #DIV/0! error value, and cell A2 returns the #NAME? error value. This occurs because the nofunction() function that is used in cell A2 is not a valid function.

1. Select column A.
1. On the **Home** tab, click the arrow next to **Conditional Formatting** in the **Styles** group,and then click **New Rule**.
1. In the **New Formatting Rule** dialog box, click **Use a formula to determine which cells to format**.
1. In the **Edit the Rule Description** box, type the following formula in the **Format values where this formula is true** field:

   **=ISERROR(A1)**

1. Click the **Format** button.
1. In the **Format Cells** dialog box, click the **Font** tab, and then click the **White** square in the **Color** list.
1. Click **OK**, and then click **OK** in the **New Formatting Rule** dialog box.

   > [!NOTE]
   > Because you selected column A in step 2, all the cells in column A were formatted with this conditional format. Therefore, any other cells in column A that return error values will not display the error value.