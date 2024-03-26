---
title: Description of the limitations for working with arrays in Excel
description: Lists the limitations of arrays in Excel. The article also contains examples of array formulas that you can use.
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
  - Excel 2007
  - Excel 2003
  - Excel 2002
ms.date: 03/31/2022
---

# Description of the limitations for working with arrays in Excel

## Summary

In the versions of Microsoft Excel that are listed in the "Applies to" section, the "Calculation Specifications" Help topic lists the limitations for working with an array. This article describes the limitations of arrays in Excel.

## More Information

In Excel, arrays in worksheets are limited by available random access memory, by the total number of array formulas, and by the "entire column" rule.

### Available memory

The Excel versions that are listed in the "Applies to" section do not impose a limit on the size of worksheet arrays. Instead, you are limited only by the available memory on your computer. Therefore, you can create very large arrays that contain hundreds of thousands of cells.

### The "entire column" rule

Although you can create very large arrays in Excel, you cannot create an array that uses a whole column or multiple columns of cells. Because recalculating an array formula that uses a whole column of cells is time consuming, Excel does not allow you to create this kind of array in a formula.

> [!NOTE]
> There are 65,536 cells in a column in Microsoft Office Excel 2003 and in earlier versions of Excel. There are 1,048,576 cells in a column in Microsoft Office Excel 2007.

### Maximum array formulas

In Excel 2003 and in earlier versions of Excel, a single worksheet may contain a maximum of 65,472 array formulas that refer to another worksheet. If you want to use more formulas, split the data into multiple worksheets so that there are fewer than 65,472 references to a single worksheet.

For example, in Sheet1 of a workbook, you can create the following items:

- 65,472 array formulas that refer to Sheet2
- 65,472 array formulas that refer to Sheet3
- 65,472 array formulas that refer to Sheet4

If you try to create more than 65,472 array formulas that refer to a specific worksheet, the array formulas that you enter after array formula number 65,472 may disappear when you enter them.

### Array formula examples

The following is a list of array formula examples. To use these examples, create a new workbook, and then enter each formula as an array formula. To do this, type the formula in the formula bar, and then press CTRL+SHIFT+ENTER to enter the formula.

#### Excel 2007

- A1: =SUM(IF(B1:B1048576=0,1,0))
  
  The formula in cell A1 returns the result 1048576. This result is correct.

- A2: =SUM(IF(B:B=0,1,0))

  The formula in cell A2 returns the result 1048576. This result is correct.

- A3: =SUM(IF(B1:J1048576=0,1,0))

  The formula in cell A3 returns the result 9437184. This result is correct.

  > [!NOTE]
  > The formula may take a long time to calculate the result because the formula is checking more than 1 million cells.

- A4: =SUM(IF(B:J=0,1,0))

  The formula in cell A4 returns the result 9437184. This result is correct.

  > [!NOTE]
  > The formula may take a long time to calculate the result because the formula is checking more than 1 million cells.

- A5: =SUM(IF(B1:DD1048576=0,1,0))

  When you enter this formula in cell A5, you may receive one of the following error messages:
 
  **Excel ran out of resources while attempting to calculate one or more formulas. As a result, these formulas cannot be evaluated.**
  
  To determine the unique number that is associated with the message that you receive, press CTRL+SHIFT+I. The following number appears in the lower-right corner of this message:

  **101758**

  In this case, the size of the worksheet array is too large for the available memory. Therefore, the formula cannot be calculated.

  Additionally, Excel may appear to stop responding for a few minutes. This is because the other formulas that you entered must recalculate their results. 

  After the results are recalculated, Excel responds as expected. The formula in cell A5 returns the value 0 (zero).

#### Excel 2003 and earlier versions of Excel

- A1: =SUM(IF(B1:B65535=0,1,0))

  The formula in cell A1 returns the result 65535. This result is correct.

- A2: =SUM(IF(B:B=0,1,0))

  The formula in cell A2 returns a #NUM! error because the array formula refers to a whole column of cells.

- A3: =SUM(IF(B1:J65535=0,1,0))

  The formula in cell A3 returns the result 589815. This result is correct.

  > [!NOTE]
  > The formula may take a long time to calculate the result because the formula is checking almost 600,000 cells.

- A4: =SUM(IF(B:J=0,1,0))

  Like the formula in cell A2, the formula in cell A4 returns a #NUM! error because the array formula refers to a whole column of cells.

- A5: =SUM(IF(B1:DD65535=0,1,0))

  When you enter the formula in cell A5, you may receive one of the following error messages:

  **Not enough memory. Continue without Undo?**

  **Not enough memory.**

  In this case, the size of the worksheet array is too large for the available memory. Therefore, the formula cannot be calculated.

  Additionally, Excel may appear to stop responding for a few minutes. This is because the other formulas that you entered must recalculate their results.

  After the results are recalculated, Excel responds as expected. The formula in cell A5 returns the value 0 (zero).

Note that none of these formulas work in earlier versions of Excel. This is because the worksheet arrays that are created by the formulas are all larger than the maximum limits in earlier versions of Excel. The following is a list of some of the functions in Excel that use arrays:

- LINEST()
- MDETERM()
-  MINVERSE()
- MMULT()
- SUM(IF())
- SUMPRODUCT()
- TRANSPOSE()
- TREND()

> [!NOTE]
> The following facts about the functions are helpful to remember.
> - If any cells in an array are empty or contain text, MINVERSE returns the **#VALUE!** error value.
> - MINVERSE also returns the **#VALUE!** error value if the array does not have an equal number of rows and columns.
> - MINVERSE returns the **#VALUE!** error if the returned array exceeds 52 columns by 52 rows.
> - The MMULT function returns **#VALUE!** if the output exceeds 5460 cells.
> - The MDETERM function returns **#VALUE!** if the returned array is larger than 73 rows by 73 columns.