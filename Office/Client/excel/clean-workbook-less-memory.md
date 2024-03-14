---
title: Clean up an Excel workbook so that it uses less memory
description: Identifies areas in Excel workbooks that use lots of memory and describes how you can make your workbook files work more efficiently.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Excel 2016
  - Excel 2013
ms.date: 03/31/2022
---

# How to clean up an Excel workbook so that it uses less memory

## Symptoms

After you upgrade to Office 2013/2016/Microsoft 365, you experience one or more of the following symptoms:

- The computer uses more memory when you open multiple Microsoft Excel 2013 workbooks, save Excel workbooks, or make calculations in Excel workbooks.    
- You can no longer open as many Excel workbooks in the same instance as you could before you upgraded to Excel 2013/2016.     
- When you insert columns in an Excel workbook, you receive an error about available memory.    
- When you are working with an Excel spreadsheet, you receive the following error message:

    ```adoc
    There isn't enough memory to complete this action.
    Try using less data or closing other applications.
    To increase memory availability, consider:
       - Using a 64-bit version of Microsoft Excel.
       - Adding memory to your device.
    ```

:::image type="content" source="media/clean-workbook-less-memory/no-enough-memory-to-complete-this-action-error.png" alt-text="The details of the error about no enough memory to complete this action that occurs when you use an Excel workbook." border="false":::
  
## Cause

Starting in Excel 2013, improvements were made that require more system resources than earlier versions required. This article identifies areas in Excel workbooks that use lots of memory and describes how you can make your workbook files work more efficiently. 

For more information about the changes that we made in Excel 2013, see [Memory Usage in the 32-bit edition of Excel 2013](https://support.microsoft.com/help/3066990).   

## Resolution

To resolve this issue, use the following methods in the order in which they are presented. If the one of these methods does not help, move on to the next method.

> [!NOTE]
> Many Excel workbooks have several issues that can problems. After you eliminate these issues, your workbook will run more smoothly.

### Formatting considerations

Formatting can cause Excel workbooks to become so large that they do not work correctly. Frequently, Excel hangs or crashes because of formatting issues.

#### Method 1: Eliminate excessive formatting

Excessive formatting in an Excel workbook can cause the file to grow and can cause poor performance. Formatting would be considered excessive if you formatted whole columns or rows with color or borders. This problem also occurs when formatting requires data to be copied or imported from webpages or databases. To eliminate excess formatting, use the format cleaner add-in that is available in [Clean excess cell formatting on a worksheet](https://support.office.com/article/clean-excess-cell-formatting-on-a-worksheet-e744c248-6925-4e77-9d49-4874f7474738).

If you continue to experience issues after you eliminate excess formatting, move on to method 2.

#### Method 2: Remove unused styles

You can use styles to standardize the formats that you use throughout workbooks. When cells are copied from one workbook to another, their styles are also copied. These styles continue to make the file grow and may eventually cause the "Too many different cell formats" error message in Excel when you save back to older file versions.

Many utilities are available that remove unused styles. As long as you are using an XML-based Excel workbook (that is, an .xlsx file or an. xlsm file), you can use the style cleaner tool. You can find this tool [here](https://sergeig888.wordpress.com/2011/03/21/net4-0-version-of-the-xlstylestool-is-now-available/).

If you continue to experience issues after you remove any unused styles, move on to method 3.

#### Method 3: Remove shapes

Adding lots of shapes in a spreadsheet also requires lots of memory. A shape is defined as any object that sits on the Excel grid. Some examples are as follows: 
- Charts    
- Drawing shapes    
- Comments    
- Clip art    
- SmartArt    
- Pictures    
- WordArt    
 
Frequently, these objects are copied from webpages or other worksheets and are hidden or are sitting on one another. Frequently, the user is unaware that they are present.

To check for shapes, follow these steps: 

1. On the Home Ribbon, click **Find and Select**, and then click **Selection Pane**.    
2. Click **The Shapes on this Sheet**. Shapes are displayed in the list.    
3. Remove any unwanted shapes. (The eye icon indicates whether the shape is visible.)    
4. Repeat steps 1 through 3 for each worksheet.    
 
 If you continue to experience issues after you remove shapes, you should examine considerations that are not related to formatting. 

#### Method 4: Remove conditional formatting

Conditional formatting can cause the file to grow. This occurs when the conditional formatting in the file is corrupted. You can remove the conditional formatting, as a test to see if the problem is with corruption in the formatting. To remove conditional formatting, follow these steps:
 
1. Save a backup of the file.    
2. On the Home Ribbon, click **Conditional Formatting**.    
3. Clear rules from the whole worksheet.    
4. Follow steps 2 and 3 for each worksheet in the workbook. 
5. Save the workbook by using a different name.    
6. See if the problem is resolved.    

If removing conditional formatting resolves the issue, you can open the original workbook, remove conditional formatting, and then reapply it.

#### Problem remains?

If none of these methods work, you may consider moving to a 64-bit version of Excel, breaking your problem workbook into different workbooks, or contacting Support for additional troubleshooting.

### Calculation considerations

In addition to formatting, calculations can also cause crashing and hanging in Excel.

#### Method 1: Open the workbook in the latest version of Excel

Opening an Excel workbook for the first time in a new version of Excel may take a long time if the workbook contains lots of calculations. To open the workbook for the first time, Excel has to recalculate the workbook and verify the values in the workbook. For more information, see the following articles:

- [Workbook loads slowly the first time that it is opened in Excel](https://support.microsoft.com/help/210162)
- [External links may be updated when you open a workbook that was last saved in an earlier version of Excel](https://support.microsoft.com/help/925893)

If the file continues to open slowly after Excel recalculates the file completely and you save the file, move on to method 2.

#### Method 2: Formulas

Look through your workbook and examine the kinds of formulas that you are using. Some formulas take lots of memory. These include the following array formulas: 

- LOOKUP    
- INDIRECT     
- OFFSETS    
- INDEX    
- MATCH    

It's fine to use them. However, be aware of the ranges that you are referencing.

Formulas that reference whole columns could cause poor performance in .xlsx files. The grid size grew from 65,536 rows to 1,048,576 rows and from 256 (IV) columns to 16,384 (XFD) columns. A popular way to create formulas, although not a best practice, was to reference whole columns. If you were referencing just one column in the old version, you were including only 65,536 cells. In the new version, you're referencing more than 1 million columns.

Assume that you have the following VLOOKUP:

```excel
=VLOOKUP(A1,$D:$M,2,FALSE) 
```

In Excel 2003 and earlier versions, this VLOOKUP was referencing a whole row that included only 655,560 cells (10 columns x 65,536 rows). However, with the new, larger grid, the same formula references almost 10.5 million cells (10 columns x 1,048,576 rows = 10,485,760). 

This is fixed in Office 2016/365 version 1708 16.0.8431.2079 and later. For information on how to update Office, please see [Install Office updates](https://support.office.com/article/install-office-updates-2ab296f3-7f03-43a2-8e50-46de917611c5).

For earlier versions of Office you may need to reconstruct your formulas to reference only those cells that are required for your formulas. 

> [!NOTE]
> Check your defined names to make sure that you don't have other formulas that reference whole columns or rows.

> [!NOTE]
> This scenario will also occur if you use whole rows.

If you continue experience issues after you change your formulas to refer only to cells that are being used, move on to method 3.

#### Method 3: Calculating across workbooks

Limit the formulas that are doing the calculations across workbooks. This is important for two reasons: 

- You are trying to open the file over the network.    
- Excel is trying to calculate large amounts of data.    

Instead of doing calculations across networks, contain the formula in one workbook, and then create a simple link from one workbook to another.

If you continue to experience the issue after you change your formulas to refer only to cells instead of calculating across workbooks, move on to method 4.

#### Method 4: Volatile functions

Limit the use of the volatile functions in a workbook. You do not have to have hundreds of cells that use the TODAY or NOW function. If you have to have the current date and time in your spreadsheet, use the function one time, and then reference the function through a defined name of a link.

If you continue to experience the issue after you limit your volatile formulas, move on to method 5.

#### Method 5: Array formulas

Array formulas are powerful. But they must be used correctly. It is important not to add more cells to your array than you must have. When a cell in your array has a formula that requires calculation, calculation occurs for all cells that are referenced in that formula.

For more information about how arrays work, please see [Excel 2010 Performance: Tips for Optimizing Performance Obstructions](https://msdn.microsoft.com/library/office/ff726673%28v=office.14%29.aspx).

If you continue to experience the issue after you update your array formulas, move on to method 6.

#### Method 6: Defined names

Defined names are used to reference cells and formulas throughout the workbook to add a "friendly name" to your formulas. You should check for any defined names that link to other workbooks or temporary Internet files. Typically, these links are unnecessary and slow down the opening of an Excel workbook.

You can use the [Name Manager tool](https://www.jkp-ads.com/officemarketplacenm-en.asp) to view hidden defined names that you can't see in the Excel interface. This tool enables you to view and delete the defined names that you don't need.

If Excel continues to crash and hang after you remove any unnecessary defined names, move on to method 7.

#### Method 7: Links and hyperlinks

Excel's power is in its ability to bring in live data from other spreadsheets. Take an inventory of the file and the external files to which it is linking. Excel doesn't have a limit on how many Excel workbooks can be linked, although there are several issues that you can encounter. Test the file without the links to determine whether the issue is in this file or in one of the linked files.

#### Moving on

 These are the most common issues that cause hanging and crashing in Excel. If you are still experiencing crashing and hanging in Excel, you should consider opening a support ticket with Microsoft.

## More Information

If none of these methods made a difference, you should consider either moving to a 64-bit version of Excel or breaking your problem workbook into different workbooks.

[How to troubleshoot "available resources" errors in Excel](https://support.microsoft.com/help/2779852)

[Excel: How to troubleshoot crashing and "not responding" issues in an Excel workbook](https://support.microsoft.com/help/2735548)
