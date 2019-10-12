---
title: How to use macro examples to delete duplicate items in a list in Excel
description: Describes how to create a macro to delete duplicate items in a list in Excel. Provides macro examples to show how to accomplish this task.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Excel 2010
- Microsoft Office Excel 2007
- Microsoft Office Excel 2003
---

# How to use macro examples to delete duplicate items in a list in Excel

## More Information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

### Sample 1: Delete duplicate items in a single list

The following sample macro searches a single list in the range A1:A100 and deletes all duplicate items in the list. This macro requires that you do not have empty cells in the list range. If your list does contain empty cells, sort the data in ascending order so that the empty cells are all at the end of your list. 

```vb
    Sub DelDups_OneList()
    Dim iListCount As Integer
    Dim iCtr As Integer
    
    ' Turn off screen updating to speed up macro.
    Application.ScreenUpdating = False
    
    ' Get count of records to search through.
    iListCount = Sheets("Sheet1").Range("A1:A100").Rows.Count
    Sheets("Sheet1").Range("A1").Select
    ' Loop until end of records.
    Do Until ActiveCell = ""
       ' Loop through records.
       For iCtr = 1 To iListCount
          ' Don't compare against yourself.
          ' To specify a different column, change 1 to the column number.
          If ActiveCell.Row <> Sheets("Sheet1").Cells(iCtr, 1).Row Then
             ' Do comparison of next record.
             If ActiveCell.Value = Sheets("Sheet1").Cells(iCtr, 1).Value Then
                ' If match is true then delete row.
                Sheets("Sheet1").Cells(iCtr, 1).Delete xlShiftUp
                   ' Increment counter to account for deleted row.
                   iCtr = iCtr + 1
             End If
          End If
       Next iCtr
       ' Go to next record.
       ActiveCell.Offset(1, 0).Select
    Loop
    Application.ScreenUpdating = True
    MsgBox "Done!"
    End Sub
```

### Sample 2: Compare two lists and delete duplicate items

The following sample macro compares one (master) list against another list, and deletes duplicate items in the second list that are also in the master list. The first list is on Sheet1 in the range A1:A10. The second list is on Sheet2 in the range A1:A100. To use the macro, select either sheet, and then run the macro. 

```vb
    Sub DelDups_TwoLists()
    Dim iListCount As Integer
    Dim iCtr As Integer
    
    ' Turn off screen updating to speed up macro.
    Application.ScreenUpdating = False
    
    ' Get count of records to search through (list that will be deleted).
    iListCount = Sheets("sheet2").Range("A1:A100").Rows.Count
    
    ' Loop through the "master" list.
    For Each x In Sheets("Sheet1").Range("A1:A10")
       ' Loop through all records in the second list.
       For iCtr = 1 To iListCount
          ' Do comparison of next record.
          ' To specify a different column, change 1 to the column number.
          If x.Value = Sheets("Sheet2").Cells(iCtr, 1).Value Then
             ' If match is true then delete row.
             Sheets("Sheet2").Cells(iCtr, 1).Delete xlShiftUp
             ' Increment counter to account for deleted row.
             iCtr = iCtr + 1
          End If
       Next iCtr
    Next
    Application.ScreenUpdating = True
    MsgBox "Done!"
    End Sub
```