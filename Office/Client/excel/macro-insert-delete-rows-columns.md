---
title: Sample macro to insert and delete rows or columns on multiple sheets
description: Describes a sample macro that you can use to insert or delete rows or columns in multiple worksheets in Microsoft Excel.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Extensibility\Macros
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft Excel
ms.date: 05/26/2025
---

# Sample macro to insert/delete rows or columns on multiple sheets in Excel

## Summary

This article contains a sample Microsoft Visual Basic for Applications macro (Sub procedure) that you can use to insert or delete rows or columns in multiple worksheets in Microsoft Excel.

## More information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.
To insert or delete rows or columns on multiple sheets, either use a For Each...Next statement to loop through all the required sheets or select the rows or columns before you perform the insertion or deletion.

> [!NOTE]
> The following sample macros work only on a contiguous range of columns or rows.

### Sample macro using a loop to insert rows in multiple sheets

```vb
Sub Insert_Rows_Loop()
     Dim CurrentSheet As Object

     ' Loop through all selected sheets.
     For Each CurrentSheet In ActiveWindow.SelectedSheets
        ' Insert 5 rows at top of each sheet.
        CurrentSheet.Range("a1:a5").EntireRow.Insert
     Next CurrentSheet
End Sub
```

### Sample macro to select column and insert new column

The following sample macro selects the entire column before it inserts new columns:

```vb
Sub Select_Insert_Column()
    Dim MyRange as Object
    ' Store the selected range in a variable.
    Set MyRange = Selection
    ' Select the entire column.
    Selection.EntireColumn.Select
    ' Insert Columns in all selected sheets.
    Selection.Insert
    ' Reselect the previously selected cells.
    MyRange.Select
End Sub
```
