---
title: Excel cannot complete this task with available resources error in Excel 2010
description: Provides information about this error and various steps you can take to resolve it depending on the scenario.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: jenl
ms.custom: 
  - CSSTroubleshoot
  - CI 171649
search.appverid: 
  - MET150
appliesto: 
  - Excel 2010
ms.date: 03/31/2022
---

# "Excel cannot complete this task with available resources" error occurs in Excel 2010

## Symptoms

You receive the following error message:

> Excel cannot complete this task with available resources. Choose less data or close other applications.

The error occurs when you:

- Open or save an Excel workbook   
- Open an Excel workbook that references a relative name from another workbook 
- Use a defined name in a formula in an Excel workbook   
- Define or delete a name in an Excel workbook   

## Resolution

**Note:** Before continuing on to the Resolution methods, ensure you have the latest Office updates installed: [Keep Windows up to date with the latest Updates](https://www.update.microsoft.com/microsoftupdate/v6/vistadefault.aspx).

After you have installed the available updates, check to see if you still have the issue. Continue to the Resolution Methods if you're still having problems.

We recommend that you follow the provided methods in this article in order. However, if you had previously tried one of the methods to fix this error and it did not help, you can jump to another method quickly from this list:

- Method 1: Check whether you exceed limits
- Method 2: Make sure only one instance of Excel is active
- Method 3: Close all applications
- Method 4: Test Excel in safe mode
- Method 5: Turn off the preview pane in Windows Explorer (Windows 7 only)
- Method 6: Save as an Excel workbook file if you use relative names
- Method 7: Change defined names to reference cells directly

### Method 1: Check whether you exceed limits
 
The error can occur if you exceed certain Excel 2010 limits, such as running too many calculations in the workbook. Some of these limits are as follows: 
 
- The maximum worksheet size limit is 1,048,576 rows by 16,384 columns.    
- The total number of characters that a cell can contain is 32,767 characters.    
- The maximum selected range in a calculation is 2,048.    
- The maximum nested level of functions in a calculation is 64.    

For a full list of Excel 2010 specifications and limitations, read the information in this Office website article:

[Excel 2010 specifications and limits](https://office.microsoft.com/excel-help/excel-specifications-and-limits-hp010342495.aspx?ctt=1) 

If you have checked and the worksheet or workbook is not exceeding Excel limitations, go to the next method.

### Method 2: Make sure only one instance of Excel is active
 
The error can occur if multiple instances of Excel are running. This usually happens if you have more than one Excel workbook opened at a time. We recommend that you close out all instances of Excel and then reopen your Excel workbook to test. If you are not sure if you have multiple instances of Excel running, follow these steps to check: 
 
1. Open Task Manager. To do this, take any of the following actions:  
   - Press CTRL + ALT + Delete, and then click **Start Task Manager**.    
   - Press CTRL + Shift + Esc.    
   - Right-click an empty area of the taskbar, and then select **Start Task Manager**.    
     
2. As soon as you are in Task Manager, click the **Applications** tab.    
3. Click the **Task** bar to sort the applications alphabetically.    

If you see more than one line with Microsoft Excel, you are running multiple instances of it. We recommend that you go back to Excel, save your workbook and close it. Repeat this process until Excel no longer appears in Task Manager.

Once all instances of Excel are closed, open the Excel workbook and test. If the error continues to occur, go to the next method.

### Method 3: Close all applications

 The error may occur if other applications are active and using computer memory while you are trying to use, open, or save the Excel workbook. We recommend that you close and exit all applications except for the Excel workbook.

You can close applications manually or you can follow the "clean-boot" steps provided in one of the following articles: 
 
- [How to perform a clean boot in Windows 7 or Windows Vista](https://support.microsoft.com/help/929135)    
- [How to perform a clean boot in Windows XP](https://support.microsoft.com/help/310353)    

Once all applications are closed, open the Excel workbook and test. If the error continues to occur, go to the next method.


### Method 4: Test Excel in safe mode
 The error can occur if you have too many Excel add-in programs running. To test whether an add-in is causing the problem, start Excel in safe mode: 
 
1. Click **Start**:::image type="icon" source="media/excel-cannot-complete-task-with-available/start-button.png":::.    
2. In Windows 7, type excel /s in the **Search programs and files** box and press **Enter**.
 In Windows Vista, type excel /s in the **Start Search** box and press **Enter**.
3. Check the title. It should read Book1 - Microsoft Excel (Safe Mode).    
4. Click **File**, and then select **Open**.    
5. Locate the Excel workbook to test and open it.    
 Open the Excel workbook and test. If the error no longer occurs, you may have too many add-in programs or a specific add-in may cause this error. We recommend that you follow the steps in this Microsoft online article to unload add-in programs:

   [Load or unload add-in programs](https://office.microsoft.com/excel-help/load-or-unload-add-in-programs-hp010096834.aspx) 

If the error continues to occur, go to the next method.


### Method 5: Turn off the preview pane in Windows Explorer (Windows 7 only)
 The preview pane is used to see the contents of most files in Windows Explorer. For example, if you click a picture, video, or text file, you can preview its contents without opening the file. By default, the preview pane is turned off in Windows 7. However, if it is turned on, it may cause a conflict with the Excel workbook you try to open leading to this error. We recommend that you turn off the preview pane and test opening your Excel workbook. To do this: 
 
1. Click **Start**:::image type="icon" source="media/excel-cannot-complete-task-with-available/start-button.png":::, and then click **Computer**.    
2. Click **Organize**.    
3. Select **Layout**, and then click to clear **Preview pane**.    
4. Open the Excel workbook and test.    

If the error continues to occur, go to the next method.

### Method 6: Save as an Excel workbook file if you use relative names
 The error can occur when you create a workbook that contains a relative name and then fill a range of cells referencing this relative name in a new workbook. For example, you create the workbook that contains a relative name, then, in another workbook, you press Ctrl + Enter to fill a range of cells with a reference to the relative name. You save the second workbook as an "Excel 97-2003 Workbook (*.xls)" file and then close both workbooks.

To work around this issue, follow one of these options:

**Option 1**
 
1. Open the Excel workbook that contains the relative name first.    
2. Next, open the Excel workbook that contains the reference to the relative name.    

**Option 2**

Save both workbooks as Excel (.xlsx) workbook files. To do this: 
 
1. Click **File**, and then click **Save As**.    
2. Select Excel Workbook (*.xlsx) in the **Save as type** box and save the file.    
 
 If the error continues to occur, go to the next method.

### Method 7: Change defined names to reference cells directly
 You may have used a defined name to represent a cell, range of cells, formula, or constant value. The error can occur if you define names that indirectly refer to other nested names that are more than 20 levels deep and you do one of the following: 
 
- You add or use a name that exceeds the level of indirection in the formula    
- You delete a name that is referenced by more than 20 levels of defined names    
 

To resolve the problem, change the defined names so that they reference the given cells more directly.

If the error continues to occur, go to the "References" section of this article.


##  References

If the information in this knowledge base article did not help resolve the error in Excel 2010, select one of the following options:

- More Microsoft online articles:
[Perform a search to find more online articles about this specific error.](https://support.microsoft.com)

- Help from the Microsoft Community online:
[Visit the Microsoft Community and post your question about this error.](https://answers.microsoft.com/)

- Contact Microsoft support:
[Find the phone number to contact Microsoft Support.](https://support.microsoft.com/contactus)