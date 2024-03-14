---
title: Set page setup attributes for more than one sheet
description: Describes how to set page setup attributes for a group of Excel worksheets.
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
  - Microsoft Excel
ms.date: 03/31/2022
---

# Set page setup attributes for more than one sheet in Excel

## Summary

In Microsoft Excel, page setup attributes, such as margins, sheet orientation, and print titles, are set for each worksheet, individually. This article describes three methods that you can use to set some of these attributes globally.

## More information

To set page setup attributes for a group of Excel worksheets, use one of the following methods.

### Method 1: Change a group of worksheets

To apply page setup attributes to a group of worksheets in a workbook, follow these steps:

1. Press CTRL and then click each worksheet tab in the workbook that you want to affect.
1. On the File menu, click Page Setup.

    > [!NOTE]
    > In Excel 2007, click the dialog box launcher in the Page Setup group in the Page Layout tab.
1. Make the changes that you want in the Page Setup dialog box, and then click OK.

All of the worksheets that you selected have the same page setup attributes.

### Method 2: Use a macro

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.You can programmatically change the page setup attributes in the active workbook and in any other open workbook.
> [!NOTE]
> These macros use the Orientation property of the PageSetup object. You can modify other page setup attributes, by using other PageSetup properties, such as LeftMargin, RightMargin, and so on.

To programmatically change the page orientation of all the sheets in the active workbook, use the steps in the previous example:

1. Start Excel.
2. Enter some data in three worksheets.
3. Press ALT+F11 to start the Visual Basic Editor.
4. On the Insert menu, click Module.
5. Type the following code in the module sheet:

    ```vb
    Sub SetAttributes()
       For Each xWorksheet In ActiveWorkbook.Worksheets
          xWorksheet.PageSetup.Orientation = _
             Worksheets("Sheet1").PageSetup.Orientation
       Next xWorksheet
    End Sub
    ```

6. Press ALT+F11 to switch to Excel.
7. Select Sheet1.
8. On the File menu, click Page Setup.

    > [!NOTE]
    > In Excel 2007, click the dialog box launcher in the Page Setup group in the Page Layout tab.
9. On the Page tab, under Orientation, click Landscape, and then click OK.
10. On the Tools menu, point to Macro, and then click Macros.

    > [!NOTE]
    > In Excel 2007, use the following steps:
    > 1. If the Developer tab is not available, use the following steps:
        > 1. Click the Microsoft Office Button, and then click Excel Options.
        > 1. In the Popular category, click to select the Show Developer tab in the Ribbon check box under Top options for working with Excel, and then click OK.
    > 1. On the Developer tab, click the Macros button in the Code group.
11. Click SetAttributes, and then click Run.

All three worksheets show landscape orientation in Print Preview.
To programmatically change the page setup attributes to all pages in the active workbook based upon the page setup attributes of another open workbook, use the steps in the following example:

> [!NOTE]
> This is a continuation of the following example.

1. On the File menu, click New.
    > [!NOTE]
    > In Excel 2007, click Microsoft Office Button, and then click New.
2. Click Workbook, and then click OK.
    > [!NOTE]
    > In Excel 2003, click Blank workbook under New in the New Workbook task pane. In Excel 2007, under Templates, make sure that Blank and recent is selected, and then double-click Blank Workbook under Blank and recent in the right pane.
3. Enter data into all of the worksheets in the new workbook.
4. Press ALT+F11 to start the Visual Basic editor.
5. Select the first workbook in the Project Explorer, and then click Module1 under the Modules folder.
6. Replace with the following code into the module1 sheet:

    ```vb
    Sub SetWorkbookAttributes()
       For Each xWorksheet In ActiveWorkbook.Worksheets
          xWorksheet.PageSetup.Orientation = _
             ThisWorkbook.Worksheets("Sheet1").PageSetup.Orientation
       Next xWorksheet
    End Sub
    ```

7. Press ALT+F11 to switch back to Excel.
8. On the Tools menu, point to Macro, and then click Macros.
    > [!NOTE]
    > In Excel 2007, on the Developer tab, click Macros in the Code group.
9. Click Book1!SetWorkbookAttributes, and then click Run.

   The page setup orientation is the same as that of sheet 1 in the first workbook.

If you want to change additional page setup properties for worksheets, you can add additional lines within the For Each...Next statement in each Sub procedure. The lines should be identical to the example lines provided here, except that the property (Orientation) can be changed as appropriate (CenterFooter, PaperSize, and so on).
