---
title: Use the INDIRECT function to create reference in Excel
description: Describes how to use the INDIRECT function to create references in Excel.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: V-RHOWAR
search.appverid: 
- MET150
appliesto:
- Microsoft Office Excel 2003
- Microsoft Office Excel 2007
- Excel 2010
---

# How to use the INDIRECT function to create references in Excel

## Summary

In Microsoft Excel, the INDIRECT worksheet function returns the contents of the specified reference and displays its contents. You can use the INDIRECT worksheet function to create linked references to other workbooks. You can reference each attribute of the reference (workbook name, worksheet name, and cell reference) individually by using the INDIRECT function to create a user-defined dynamic reference with worksheet cell references as inputs.

## More Information

> [!NOTE]
> The INDIRECT function only returns the result of a reference to an open file. If a workbook that the INDIRECT function is indirectly referencing is closed, the function returns a #REF! error.

To create a reference to a workbook using three different cell inputs as references for the workbook, worksheet, and cell link, follow the steps in the following examples.

### Example 1

1. Start Excel.   
2. In Book1, Sheet1, cell A1 type This is a test.   
3. In Microsoft Office Excel 2003 and in earlier versions of Excel, click **New** on the **File** menu, click **Workbook**, and then click **OK**.
In Microsoft Office Excel 2007, click the Microsoft Office Button, Click New, and then click Create. 
In Microsoft Office Excel 2010, click the File Menu, click **New**, and then click **Create**.   
4. In Book2, Sheet1, cell A1 type Book1.   
5. In Book2, Sheet1, cell A2 type Sheet1.
6. In Book2, Sheet1, cell A3 type A1.   
7. Save both workbooks.   
8. In Excel 2003 and in earlier versions of Excel, type the following formula in Book2, Sheet1, cell B1:

   =INDIRECT("'["&A1&".xls]"&A2&"'!"&A3) 

   In Excel 2007, type the following formula:

   =INDIRECT("'["&A1&".xlsx]"&A2&"'!"&A3)

   The formula returns "This is a test."   

### Example 2

In Excel 2003 and in earlier versions of Excel, you can replace the formula in Example 1 with multiple INDIRECT statements, as in the following formula:

=INDIRECT("'["&INDIRECT("A1")&".xls]"&INDIRECT("A2")&"'!"&INDIRECT("A3"))

In Excel 2007 and Excel 2010, type the following formula:

=INDIRECT("'["&INDIRECT("A1")&".xlsx]"&INDIRECT("A2")&"'!"&INDIRECT("A3"))

> [!NOTE]
> The difference in how Excel references the cells. Example 1 references cells A1, A2, and A3 without using quotation marks, while Example 2 references the cells using quotation marks around the references.

The INDIRECT function references cells without using quotation marks. This function evaluates the result of the cell reference. For example, if cell A1 contains the text "B1," and B1 contains the word "TEST," the formula =INDIRECT(A1) returns the result "TEST." 

However, referencing a cell with quotation marks returns the result of the cell contents. In the example in the previous sentence, the formula returns the text string "B1" instead of the contents of cell B1.
