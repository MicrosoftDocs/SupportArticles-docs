---
title: Delete cells by using a For Each Next loop
description: Provides a macro example that illustrates how to delete cells by using a For Each...Next loop.
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
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
  - Microsoft Office Excel 2002
  - Excel 97
ms.date: 03/31/2022
---

# Delete cells by using a "For Each...Next" loop in Excel

## Summary

Microsoft Excel 2002 and later versions of Excel delete cells in a "For Each...Next" loop in a different way than Microsoft Excel 97 and earlier versions of Excel do.

This article describes the differences, and it provides a Visual Basic for Applications macro example that illustrates how to delete cells in a loop.

## More information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

### Sample data

To use the macro in this article, type the following sample data in a worksheet:

```asciidoc
A1: a B1: 1
A2: b B2: 2
A3: x B3: 3
A4: x B4: 4
A5: c B5: 5
A6: x B6: 6
A7: d B7: 7
A8: x B8: 8
A9: x B9: 9
A10: e B10: 10
```

### Sample macro

In a new macro module, type the following macro.

```vb
Sub DeleteCells()

     'Loop through cells A1:A10 and delete cells that contain an "x."
     For Each c in Range("A1:A10")
        If c = "x" Then c.EntireRow.Delete
    Next

End Sub
```

### Behavior of the sample macro in Excel 2002 and in later versions of Excel

When you run the DeleteCells macro in Excel 2002 and in later versions of Excel, only rows 3, 6 and 8 are deleted. Although rows 4 and 9 contain an "x" in column A, the macro does not delete the rows. The results of the macro are as follows:

```asciidoc
A1: a B1: 1
A2: b B2: 2
A3: x B3: 4
A4: c B4: 5
A5: d B5: 7
A6: x B6: 9
A7: e B7: 10
```

When Microsoft Excel deletes row 3, all cells move up one row. For example, cell A3 assumes the contents of cell A4, cell A4 assumes the contents of cell A5, and so forth. After the For Each...Next loop evaluates a cell, it evaluates the next cell; therefore, when cells are shifted, they may be skipped by the loop.

### Behavior of the sample macro in Microsoft Excel 5.0 and Microsoft Excel 7.0

When you run the DeleteCells macro in Excel 5.0 and in Excel 7.0, the macro deletes all rows that contain an "x." The results of the macro are as follows:

```asciidoc
A1: a B1: 1
A2: b B2: 2
A3: c B3: 5
A4: d B4: 7
A5: e B5: 10
```

When row 3 is deleted, all cells move up one row. Then, cell A3 assumes the contents of cell A4, cell A4 assumes the contents of cell A5, and so on.

However, unlike the behavior of the loop in Excel 2002 and in later versions of Excel, when the "For Each...Next" loop evaluates a cell in Excel 5.0 and in Excel 7.0, the loop reevaluates the cell if it is deleted in the loop. Therefore, the cells are not skipped.

### Recommended method for using a loop to delete cells

Use the following macro when you want to use a loop to delete cells:

```vb
Sub DeleteCells2()

     Dim rng As Range
     Dim i As Integer, counter As Integer
    
     'Set the range to evaluate to rng.
     Set rng = Range("A1:A10")
    
     'initialize i to 1
     i = 1
    
     'Loop for a count of 1 to the number of rows
     'in the range that you want to evaluate.
     For counter = 1 To rng.Rows.Count
    
          'If cell i in the range contains an "x",
           'delete the row.
           'Else increment i
            If rng.Cells(i) = "x" Then
                rng.Cells(i).EntireRow.Delete
            Else
                i = i + 1
            End If
    
     Next

End Sub
```

The results of this macro in all versions of Excel are as follows:

```asciidoc
A1: a B1: 1
A2: b B2: 2
A3: c B3: 5
A4: d B4: 7
A5: e B5: 10
```

### Additional method for using a loop to delete cells

This is an alternate method to the method that is shown above. This method produces the same results.

```vb
 Sub DeleteCells3()

     Dim rng As Range, i As Integer

     'Set the range to evaluate to rng.
     Set rng = Range("A1:A10")

     'Loop backwards through the rows
     'in the range that you want to evaluate.
     For i = rng.Rows.Count To 1 Step -1
    
             'If cell i in the range contains an "x", delete the entire row.
             If rng.Cells(i).Value = "x" Then rng.Cells(i).EntireRow.Delete
     Next

End Sub
```
