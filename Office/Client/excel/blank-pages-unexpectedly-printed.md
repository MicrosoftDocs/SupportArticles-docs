---
title: Blank pages are unexpectedly printed
description: Discusses a problem in which the blank pages are unexpectedly printed in Excel.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - Printing
  - CSSTroubleshoot
ms.reviewer: V-RHOWAR
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Office Excel 2003
  - Microsoft Office Excel 2007
  - Excel 2010
  - Excel 2013
ms.date: 05/26/2025
---

# Blank pages are unexpectedly printed in Excel

## Symptoms

In Microsoft Excel, when you print a worksheet, pages that are completely blank may be unexpectedly printed.

## Cause

This behavior can occur under any of the following conditions:

- The only data on a page is in cells that are formatted in such a way that they're blank.

  Cells that are formatted to appear blank include those with white fonts, zeroes-as-blanks settings, three semicolons (see Example 1 in the "More Information" section), and so forth.   
- A cell on the page contains an error, and errors have been selected to print as blank.   
- There are completely blank pages ahead of any pages that contain data (including the first two conditions stated here), which print as blank.   
- The worksheet contains drawing objects that are located in unexpected areas of the worksheet.   
- The worksheet contains hidden columns with manual page breaks

  These objects may be very small in size, formatted as white, and so forth.

> [!NOTE]
> Pages that contain hidden rows or columns are not printed (if there is no other data on the page), nor are the intervening pages.

## Workaround

To work around this issue, follow these steps:

1. On the File menu, click Print.

   **Note** In Excel 2007, click the **Microsoft Office Button**, and then click **Print**.   
2. Under Print range, select only the page or pages that you want to print.   

## More Information

The following steps must be completed for both of the following examples:

1. Start Excel and create a new workbook.   
2. In cell A1, type Test.   

### Example 1: A Cell Is Formatted as Blank

1. In cell M85, type Test, and then press ENTER.   
2. Select cell M85.   
3. On the Format menu, click Cells.

   **Note** In Excel 2007, click **Format** in the **Cells** group on the **Home** tab, and then click **Format Cells**.   
4. On the Number tab, under Category, click Custom.   
5. In the Type box, delete the selection (press the BACKSPACE key to erase the selection), and then type `;;;` (three semicolons).   
6. Click OK.

   Cell M85 is hidden.   
7. On the File menu, click Print Preview.

   **Note** In Excel 2007, click the **Microsoft Office Button**, point to **Print**, and then click **Print Preview**.

   Notice that not only does page 1 contain data, but it is followed by three blank pages. This includes the page that has the hidden cell and the intervening pages.   

### Example 2: Errors Are Set to Print Blank

1. In cell M85, type the following formula:

   =1/0

   You receive a divide-by-zero error message.   
2. On the File menu, click Page Setup.

   **Note** In Excel 2007, click the **Page Setup** dialog box launcher in the **Page Setup** group on the **Page Layout** tab.   
3. On the Sheet tab, under Print, in the **Cell error as** drop-down box, click **\<blank>**.   
4. Click Print Preview.

   Notice that not only does page 1 contain data, but it's followed by three blank pages.
