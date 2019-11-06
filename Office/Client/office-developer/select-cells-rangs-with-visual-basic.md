---
title: How to select cells or ranges by using Visual Basic procedures in Excel.
description: Describes how to select cells or ranges by using Visual Basic procedures in Excel.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Excel for Office 365
- Excel 2019
- Excel 2016
- Excel 2013
- Excel 2010 
---

# How to select cells/ranges by using Visual Basic procedures in Excel

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements. The examples in this article use the Visual Basic methods listed in the following table.

```asciidoc
Method             Arguments
------------------------------------------
Activate           none
Cells              rowIndex, columnIndex
Application.Goto   reference, scroll
Offset             rowOffset, columnOffset
Range              cell1
                   cell1, cell2
Resize             rowSize, columnSize
Select             none
Sheets             index (or sheetName)
Workbooks          index (or bookName)
End                direction
CurrentRegion      none
```

The examples in this article use the properties in the following table.

```asciidoc
Property         Use
---------------------------------------------------------------------
ActiveSheet      to specify the active sheet
ActiveWorkbook   to specify the active workbook
Columns.Count    to count the number of columns in the specified item
Rows.Count       to count the number of rows in the specified item
Selection        to refer to the currently selected range
```

## How to Select a Cell on the Active Worksheet

To select cell D5 on the active worksheet, you can use either of the following examples:

```vb
ActiveSheet.Cells(5, 4).Select
-or-
ActiveSheet.Range("D5").Select
```

## How to Select a Cell on Another Worksheet in the Same Workbook

To select cell E6 on another worksheet in the same workbook, you can use either of the following examples:

```vb
Application.Goto ActiveWorkbook.Sheets("Sheet2").Cells(6, 5)
   -or-
Application.Goto (ActiveWorkbook.Sheets("Sheet2").Range("E6"))
```

Or, you can activate the worksheet, and then use method 1 above to select the cell:

```vb
Sheets("Sheet2").Activate
ActiveSheet.Cells(6, 5).Select
```

## How to Select a Cell on a Worksheet in a Different Workbook

To select cell F7 on a worksheet in a different workbook, you can use either of the following examples:

```vb
Application.Goto Workbooks("BOOK2.XLS").Sheets("Sheet1").Cells(7, 6)
-or-
Application.Goto Workbooks("BOOK2.XLS").Sheets("Sheet1").Range("F7")
```

Or, you can activate the worksheet, and then use method 1 above to select the cell:

```vb
Workbooks("BOOK2.XLS").Sheets("Sheet1").Activate
ActiveSheet.Cells(7, 6).Select
```

## How to Select a Range of Cells on the Active Worksheet

To select the range C2:D10 on the active worksheet, you can use any of the following examples:

```vb
ActiveSheet.Range(Cells(2, 3), Cells(10, 4)).Select
ActiveSheet.Range("C2:D10").Select
ActiveSheet.Range("C2", "D10").Select

or

ActiveSheet.Range(ActiveSheet.Cells(2, 3), ActiveSheet.Cells(10, 4)).Select

or, alternatively, it could be simplified to this:

Range(Cells(2, 3), Cells(10, 4)).Select

```

## How to Select a Range of Cells on Another Worksheet in the Same Workbook

To select the range D3:E11 on another worksheet in the same workbook, you can use either of the following examples:

```vb
Application.Goto ActiveWorkbook.Sheets("Sheet3").Range("D3:E11")
Application.Goto ActiveWorkbook.Sheets("Sheet3").Range("D3", "E11")
```

Or, you can activate the worksheet, and then use method 4 above to select the range:

```vb
Sheets("Sheet3").Activate
ActiveSheet.Range(Cells(3, 4), Cells(11, 5)).Select
```

## How to Select a Range of Cells on a Worksheet in a Different Workbook

To select the range E4:F12 on a worksheet in a different workbook, you can use either of the following examples:

```vb
Application.Goto Workbooks("BOOK2.XLS").Sheets("Sheet1").Range("E4:F12")
Application.Goto _
      Workbooks("BOOK2.XLS").Sheets("Sheet1").Range("E4", "F12")
```

Or, you can activate the worksheet, and then use method 4 above to select the range:

```vb
Workbooks("BOOK2.XLS").Sheets("Sheet1").Activate
   ActiveSheet.Range(Cells(4, 5), Cells(12, 6)).Select
```

## How to Select a Named Range on the Active Worksheet

To select the named range "Test" on the active worksheet, you can use either of the following examples:

```vb
Range("Test").Select
Application.Goto "Test"
```

## How to Select a Named Range on Another Worksheet in the Same Workbook

To select the named range "Test" on another worksheet in the same workbook, you can use the following example:

```vb
Application.Goto Sheets("Sheet1").Range("Test")
```

Or, you can activate the worksheet, and then use method 7 above to select the named range:

```vb
Sheets("Sheet1").Activate
Range("Test").Select
```

## How to Select a Named Range on a Worksheet in a Different Workbook

To select the named range "Test" on a worksheet in a different workbook, you can use the following example:

```vb
Application.Goto _
   Workbooks("BOOK2.XLS").Sheets("Sheet2").Range("Test")
```

Or, you can activate the worksheet, and then use method 7 above to select the named range:

```vb
Workbooks("BOOK2.XLS").Sheets("Sheet2").Activate
Range("Test").Select
```

## How to Select a Cell Relative to the Active Cell

To select a cell that is five rows below and four columns to the left of the active cell, you can use the following example:

```vb
ActiveCell.Offset(5, -4).Select
```

To select a cell that is two rows above and three columns to the right of the active cell, you can use the following example:

```vb
ActiveCell.Offset(-2, 3).Select
```

> [!NOTE]
> An error will occur if you try to select a cell that is "off the worksheet." The first example shown above will return an error if the active cell is in columns A through D, since moving four columns to the left would take the active cell to an invalid cell address.

## How to Select a Cell Relative to Another (Not the Active) Cell

To select a cell that is five rows below and four columns to the right of cell C7, you can use either of the following examples:

```vb
ActiveSheet.Cells(7, 3).Offset(5, 4).Select
ActiveSheet.Range("C7").Offset(5, 4).Select
```

## How to Select a Range of Cells Offset from a Specified Range

To select a range of cells that is the same size as the named range "Test" but that is shifted four rows down and three columns to the right, you can use the following example:

```vb
ActiveSheet.Range("Test").Offset(4, 3).Select
```

If the named range is on another (not the active) worksheet, activate that worksheet first, and then select the range using the following example:

```vb
Sheets("Sheet3").Activate
ActiveSheet.Range("Test").Offset(4, 3).Select
```

## How to Select a Specified Range and Resize the Selection

To select the named range "Database" and then extend the selection by five rows, you can use the following example:

```vb
Range("Database").Select
Selection.Resize(Selection.Rows.Count + 5, _
   Selection.Columns.Count).Select
```

## How to Select a Specified Range, Offset It, and Then Resize It

To select a range four rows below and three columns to the right of the named range "Database" and include two rows and one column more than the named range, you can use the following example:

```vb
Range("Database").Select
Selection.Offset(4, 3).Resize(Selection.Rows.Count + 2, _
   Selection.Columns.Count + 1).Select
```

## How to Select the Union of Two or More Specified Ranges

To select the union (that is, the combined area) of the two named ranges "Test" and "Sample," you can use the following example:

```vb
Application.Union(Range("Test"), Range("Sample")).Select
```

> [!NOTE]
> that both ranges must be on the same worksheet for this example to work. Note also that the Union method does not work across sheets. For example, this line works fine.

```vb
Set y = Application.Union(Range("Sheet1!A1:B2"), Range("Sheet1!C3:D4"))
```

but this line

```vb
Set y = Application.Union(Range("Sheet1!A1:B2"), Range("Sheet2!C3:D4"))
```

returns the error message:

**Union method of application class failed**

## How to Select the Intersection of Two or More Specified Ranges

To select the intersection of the two named ranges "Test" and "Sample," you can use the following example:

```vb
Application.Intersect(Range("Test"), Range("Sample")).Select
```

Note that both ranges must be on the same worksheet for this example to work.

Examples 17-21 in this article refer to the following sample set of data. Each example states the range of cells in the sample data that would be selected.

```asciidoc
A1: Name    B1: Sales    C1: Quantity
A2: a       B2: $10      C2: 5
A3: b       B3:          C3: 10
A4: c       B4: $10      C4: 5
A5:         B5:          C5:
A6: Total   B6: $20      C6: 20
```

## How to Select the Last Cell of a Column of Contiguous Data

To select the last cell in a contiguous column, use the following example:

```vb
ActiveSheet.Range("a1").End(xlDown).Select
```

When this code is used with the sample table, cell A4 will be selected.

## How to Select the Blank Cell at Bottom of a Column of Contiguous Data

To select the cell below a range of contiguous cells, use the following example:

```vb
ActiveSheet.Range("a1").End(xlDown).Offset(1,0).Select
```

When this code is used with the sample table, cell A5 will be selected.

## How to Select an Entire Range of Contiguous Cells in a Column

To select a range of contiguous cells in a column, use one of the following examples:

```vb
ActiveSheet.Range("a1", ActiveSheet.Range("a1").End(xlDown)).Select
   -or-
ActiveSheet.Range("a1:" & ActiveSheet.Range("a1"). _
      End(xlDown).Address).Select
```

When this code is used with the sample table, cells A1 through A4 will be selected.

## How to Select an Entire Range of Non-Contiguous Cells in a Column

To select a range of cells that are non-contiguous, use one of the following examples:

```vb
ActiveSheet.Range("a1",ActiveSheet.Range("a65536").End(xlUp)).Select
   -or-
ActiveSheet.Range("a1:" & ActiveSheet.Range("a65536"). _
   End(xlUp).Address).Select
```

When this code is used with the sample table, it will select cells A1 through A6.

## How to Select a Rectangular Range of Cells

In order to select a rectangular range of cells around a cell, use the CurrentRegion method. The range selected by the CurrentRegion method is an area bounded by any combination of blank rows and blank columns. The following is an example of how to use the CurrentRegion method:

```vb
ActiveSheet.Range("a1").CurrentRegion.Select
```

This code will select cells A1 through C4. Other examples to select the same range of cells are listed below:

```vb
ActiveSheet.Range("a1", _
   ActiveSheet.Range("a1").End(xlDown).End(xlToRight)).Select
   -or-
ActiveSheet.Range("a1:" & _
   ActiveSheet.Range("a1").End(xlDown).End(xlToRight).Address).Select
```

In some instances, you may want to select cells A1 through C6. In this example, the CurrentRegion method will not work because of the blank line on Row 5. The following examples will select all of the cells:

```vb
lastCol = ActiveSheet.Range("a1").End(xlToRight).Column
lastRow = ActiveSheet.Cells(65536, lastCol).End(xlUp).Row
ActiveSheet.Range("a1", ActiveSheet.Cells(lastRow, lastCol)).Select
    -or-
lastCol = ActiveSheet.Range("a1").End(xlToRight).Column
lastRow = ActiveSheet.Cells(65536, lastCol).End(xlUp).Row
ActiveSheet.Range("a1:" & _
   ActiveSheet.Cells(lastRow, lastCol).Address).Select
```

## How to Select Multiple Non-Contiguous Columns of Varying Length

To select multiple non-contiguous columns of varying length, use the following sample table and macro example:

```asciidoc
A1: 1  B1: 1  C1: 1  D1: 1
A2: 2  B2: 2  C2: 2  D2: 2
A3: 3  B3: 3  C3: 3  D3: 3
A4:    B4: 4  C4: 4  D4: 4
A5:    B5: 5  C5: 5  D5:
A6:    B6:    C6: 6  D6:
```

```vb
StartRange = "A1"
EndRange = "C1"
Set a = Range(StartRange, Range(StartRange).End(xlDown))
Set b = Range(EndRange, Range(EndRange).End(xlDown))
Union(a,b).Select
```

When this code is used with the sample table, cells A1:A3 and C1:C6 will be selected.

## Notes on the examples

The ActiveSheet property can usually be omitted, because it is implied if a specific sheet is not named. For example, instead of

```vb
ActiveSheet.Range("D5").Select
```

you can use:

```vb
Range("D5").Select
```

The ActiveWorkbook property can also usually be omitted. Unless a specific workbook is named, the active workbook is implied.

When you use the Application.Goto method, if you want to use two Cells methods within the Range method when the specified range is on another (not the active) worksheet, you must include the Sheets object each time. For example:

```vb
Application.Goto Sheets("Sheet1").Range( _
      Sheets("Sheet1").Range(Sheets("Sheet1").Cells(2, 3), _
      Sheets("Sheet1").Cells(4, 5)))
```

For any item in quotation marks (for example, the named range "Test"), you can also use a variable whose value is a text string. For example, instead of

```vb
ActiveWorkbook.Sheets("Sheet1").Activate
```

you can use

```vb
ActiveWorkbook.Sheets(myVar).Activate
```

where the value of myVar is "Sheet1".
