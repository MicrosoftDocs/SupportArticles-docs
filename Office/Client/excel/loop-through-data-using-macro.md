---
title: Loop through a list of data on a worksheet by using macros
description: Discusses how to write VBA macro code to go through a list of data on a worksheet in Excel.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: mikestow
ms.custom: 
  - Extensibility\Macros
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
  - Excel 2010
ms.date: 05/26/2025
---

# How to loop through a list of data on a worksheet by using macros in Excel

## Summary

When you write a Microsoft Visual Basic for Applications (VBA) macro, you may have to loop through a list of data on a worksheet. There are several methods for performing this task. The "More Information" section of this article contains information about the methods that you can use to search the following types of lists: 

- A list that contains a known, constant number of rows.   
- A dynamic list, or a list with an unknown number of rows.   
- A list that contains a specific record.   

## More Information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements. The following code samples assume that the list has a header row that starts in cell A1 and data that starts in cell A2.
 
### To Search a List with a Constant, Known Number of Rows

This code moves down column A to the end of the list: 

```vb
   Sub Test1()
      Dim x As Integer
      ' Set numrows = number of rows of data.
      NumRows = Range("A2", Range("A2").End(xldown)).Rows.Count
      ' Select cell a1.
      Range("A2").Select
      ' Establish "For" loop to loop "numrows" number of times.
      For x = 1 To NumRows
         ' Insert your code here.
         ' Selects cell down 1 row from active cell.
         ActiveCell.Offset(1, 0).Select
      Next
   End Sub
```

### To Search a Dynamic List or a List with an Unknown Number of Rows

This code moves down column A to the end of the list. (This code assumes that each cell in column A contains an entry until the end.)
 
```vb
   Sub Test2()
      ' Select cell A2, *first line of data*.
      Range("A2").Select
      ' Set Do loop to stop when an empty cell is reached.
      Do Until IsEmpty(ActiveCell)
         ' Insert your code here.
         ' Step down 1 row from present location.
         ActiveCell.Offset(1, 0).Select
      Loop
   End Sub
```


**Note**  If there are empty cells in column A throughout the data, modify this code to account for this condition. Make sure that the empty cells are a consistent distance apart. For example, if every other cell in column A is empty (for example, this situation may occur if every 'record' uses two rows, with the second row indented one cell), this loop can be modified as follows: 

```vb
     ' Set Do loop to stop when two consecutive empty cells are reached.
     Do Until IsEmpty(ActiveCell) and IsEmpty(ActiveCell.Offset(1, 0))
        ' Insert your code here.
        '
       ' Step down 2 rows from present location.
       ActiveCell.Offset(2, 0).Select
     Loop
 ```

### To Search a List for a Specific Record

This code moves down column A to the end of the list:

```vb
   Sub Test3()
      Dim x As String
      Dim found As Boolean
      ' Select first line of data.
      Range("A2").Select
      ' Set search variable value.
      x = "test"
      ' Set Boolean variable "found" to false.
      found = False
      ' Set Do loop to stop at empty cell.
      Do Until IsEmpty(ActiveCell)
         ' Check active cell for search value.
         If ActiveCell.Value = x Then
            found = TRUE
            Exit Do
         End If
         ' Step down 1 row from present location.
         ActiveCell.Offset(1, 0).Select
      Loop
   ' Check for found.
      If found = True Then
         Msgbox "Value found in cell " & ActiveCell.Address
      Else
         Msgbox "Value not found"
      End If
   End Sub
```
