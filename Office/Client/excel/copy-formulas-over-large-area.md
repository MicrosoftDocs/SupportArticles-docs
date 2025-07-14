---
title: Not enough memory error when you copy formulas over large area
description: Describes error messages that you may receive when you fill or copy formulas into a large area of a worksheet, or when you add formulas to a large worksheet. Provides steps to work around the source cell limit.
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: PETEREE
ms.custom: 
  - Editing\CopyOrPaste
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel 2013
  - Excel 2010
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
ms.date: 05/26/2025
---

# "Not enough memory" when you copy formulas over large area in Excel

## Symptoms

If you fill or copy formulas into a large area of a worksheet, or you add formulas to a large worksheet, you receive error messages that are similar to the following: 

- Not enough memory.
- Not enough system resources to display completely.

## Cause

Each instance of Microsoft Excel 2007, Excel 2010, and Excel 2013 32-bit is limited to 2 gigabyte (GB) of memory (internal heap space). Each instance is also limited to 32,760 source cells when you perform a smart fill operation. When you copy or fill large sections of a worksheet, one or both of these limitations may affect the result. 

## Workaround

To work around the source cell limit, follow these steps: 

1. Fill only the part of the range that you have to fill.   
2. Select only the last row or last two rows of the filled range, and then fill farther down the sheet.   
3. Repeat step 2 until you have filled the entire range that you have to fill.   
To work around the memory limit, break your work into smaller workbooks, and open them in separate instances of Excel. 

## More Information

Excel uses internal heap space for different types of operations, including the following:

- to track cells and formulas.   
- to provide copy and paste functionality.   
- to track pointers to objects.   

In versions of Excel earlier than Microsoft Excel 2002, the memory limit is 64 MB. In Excel 2002, the limit is increased to 128 MB. In Microsoft Office Excel 2003, the limit is increased to 1 gigabyte (GB). 

Because this is a per-instance limit, this problem may occur if you have two or three large workbooks open, or one very large workbook. If you are working with several workbooks, try to open them in separate instances of Excel.

With smart fill functionality, you can increment relative references and fill lists. By reducing the copy range in any copy or fill operation, you can work around the 32,760 source cell limit.
