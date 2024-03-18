---
title: Create and insert a calendar in Excel
description: Describes how to use a Microsoft Excel worksheet to create a monthly calendar. Sample Visual Basic procedures are included. Procedures help you to customize the calendar to meet your personal requirements.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Excel for Microsoft 365
  - Excel 2019
  - Excel 2016
  - Excel 2013
  - Excel 2010
  - Excel 2007
  - Excel 2003
ms.date: 03/31/2022
---

# Create and insert a calendar in Excel

## Summary

This article contains a sample Microsoft Visual Basic for Applications macro (sub-procedure) that prompts you for the month and year and creates a monthly calendar by using a worksheet. 

## Resolution

> [!NOTE]
> Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

To create the calendar, follow these steps.

### Microsoft Excel 2003

1. Create a workbook.
2. On the **Tools** menu, point to **Macro**, and then select **Visual Basic Editor**.
3. On the **Insert** menu, select **Module**.
4. Paste the Visual Basic for Applications script from the "Sample Visual Basic procedure" section into the module sheet.
5. On the **File** menu, select **Close and Return to Microsoft Excel**.
6. Select the **Sheet1** tab.
7. On the **Tools** menu, point to **Macro**, and then select **Macros**.
8. Select **CalendarMaker**, and then select **Run** to create the calendar.

### Microsoft Excel 2007 or later

1. Create a workbook.
2. On the **Developer** ribbon, select **Visual Basic**.
3. On the **Insert* menu, select **Module**.
4. Paste the Visual Basic for Applications script from the "Sample Visual Basic procedure" section into the module sheet.
5. On the **File** menu, select **Close and Return to Microsoft Excel**.
6. Select the **Sheet1** tab.
7. On the **Developer* ribbon, click **Macros**.
8. Select **CalendarMaker**, and then select **Run* to create the calendar.

> [!NOTE]
> If the Developer ribbon is not visible, open Excel Options to enable it. In Excel 2007, the option is available on the **Popular** menu. In Excel 2010, the option is available on the **Customize Ribbon** menu.

### Sample Visual Basic procedure

```vb
  Sub CalendarMaker()

       ' Unprotect sheet if had previous calendar to prevent error.
       ActiveSheet.Protect DrawingObjects:=False, Contents:=False, _
          Scenarios:=False
       ' Prevent screen flashing while drawing calendar.
       Application.ScreenUpdating = False
       ' Set up error trapping.
       On Error GoTo MyErrorTrap
       ' Clear area a1:g14 including any previous calendar.
       Range("a1:g14").Clear
       ' Use InputBox to get desired month and year and set variable
       ' MyInput.
       MyInput = InputBox("Type in Month and year for Calendar ")
       ' Allow user to end macro with Cancel in InputBox.
       If MyInput = "" Then Exit Sub
       ' Get the date value of the beginning of inputted month.
       StartDay = DateValue(MyInput)
       ' Check if valid date but not the first of the month
       ' -- if so, reset StartDay to first day of month.
       If Day(StartDay) <> 1 Then
           StartDay = DateValue(Month(StartDay) & "/1/" & _
               Year(StartDay))
       End If
       ' Prepare cell for Month and Year as fully spelled out.
       Range("a1").NumberFormat = "mmmm yyyy"
       ' Center the Month and Year label across a1:g1 with appropriate
       ' size, height and bolding.
       With Range("a1:g1")
           .HorizontalAlignment = xlCenterAcrossSelection
           .VerticalAlignment = xlCenter
           .Font.Size = 18
           .Font.Bold = True
           .RowHeight = 35
       End With
       ' Prepare a2:g2 for day of week labels with centering, size,
       ' height and bolding.
       With Range("a2:g2")
           .ColumnWidth = 11
           .VerticalAlignment = xlCenter
           .HorizontalAlignment = xlCenter
           .VerticalAlignment = xlCenter
           .Orientation = xlHorizontal
           .Font.Size = 12
           .Font.Bold = True
           .RowHeight = 20
       End With
       ' Put days of week in a2:g2.
       Range("a2") = "Sunday"
       Range("b2") = "Monday"
       Range("c2") = "Tuesday"
       Range("d2") = "Wednesday"
       Range("e2") = "Thursday"
       Range("f2") = "Friday"
       Range("g2") = "Saturday"
       ' Prepare a3:g7 for dates with left/top alignment, size, height
       ' and bolding.
       With Range("a3:g8")
           .HorizontalAlignment = xlRight
           .VerticalAlignment = xlTop
           .Font.Size = 18
           .Font.Bold = True
           .RowHeight = 21
       End With
       ' Put inputted month and year fully spelling out into "a1".
       Range("a1").Value = Application.Text(MyInput, "mmmm yyyy")
       ' Set variable and get which day of the week the month starts.
       DayofWeek = WeekDay(StartDay)
       ' Set variables to identify the year and month as separate
       ' variables.
       CurYear = Year(StartDay)
       CurMonth = Month(StartDay)
       ' Set variable and calculate the first day of the next month.
       FinalDay = DateSerial(CurYear, CurMonth + 1, 1)
       ' Place a "1" in cell position of the first day of the chosen
       ' month based on DayofWeek.
       Select Case DayofWeek
           Case 1
               Range("a3").Value = 1
           Case 2
               Range("b3").Value = 1
           Case 3
               Range("c3").Value = 1
           Case 4
               Range("d3").Value = 1
           Case 5
               Range("e3").Value = 1
           Case 6
               Range("f3").Value = 1
           Case 7
               Range("g3").Value = 1
       End Select
       ' Loop through range a3:g8 incrementing each cell after the "1"
       ' cell.
       For Each cell In Range("a3:g8")
           RowCell = cell.Row
           ColCell = cell.Column
           ' Do if "1" is in first column.
           If cell.Column = 1 And cell.Row = 3 Then
           ' Do if current cell is not in 1st column.
           ElseIf cell.Column <> 1 Then
               If cell.Offset(0, -1).Value >= 1 Then
                   cell.Value = cell.Offset(0, -1).Value + 1
                   ' Stop when the last day of the month has been
                   ' entered.
                   If cell.Value > (FinalDay - StartDay) Then
                       cell.Value = ""
                       ' Exit loop when calendar has correct number of
                       ' days shown.
                       Exit For
                   End If
               End If
           ' Do only if current cell is not in Row 3 and is in Column 1.
           ElseIf cell.Row > 3 And cell.Column = 1 Then
               cell.Value = cell.Offset(-1, 6).Value + 1
               ' Stop when the last day of the month has been entered.
               If cell.Value > (FinalDay - StartDay) Then
                   cell.Value = ""
                   ' Exit loop when calendar has correct number of days
                   ' shown.
                   Exit For
               End If
           End If
       Next

       ' Create Entry cells, format them centered, wrap text, and border
       ' around days.
       For x = 0 To 5
           Range("A4").Offset(x * 2, 0).EntireRow.Insert
           With Range("A4:G4").Offset(x * 2, 0)
               .RowHeight = 65
               .HorizontalAlignment = xlCenter
               .VerticalAlignment = xlTop
               .WrapText = True
               .Font.Size = 10
               .Font.Bold = False
               ' Unlock these cells to be able to enter text later after
               ' sheet is protected.
               .Locked = False
           End With
           ' Put border around the block of dates.
           With Range("A3").Offset(x * 2, 0).Resize(2, _
           7).Borders(xlLeft)
               .Weight = xlThick
               .ColorIndex = xlAutomatic
           End With

           With Range("A3").Offset(x * 2, 0).Resize(2, _
           7).Borders(xlRight)
               .Weight = xlThick
               .ColorIndex = xlAutomatic
           End With
           Range("A3").Offset(x * 2, 0).Resize(2, 7).BorderAround _
              Weight:=xlThick, ColorIndex:=xlAutomatic
       Next
       If Range("A13").Value = "" Then Range("A13").Offset(0, 0) _
          .Resize(2, 8).EntireRow.Delete
       ' Turn off gridlines.
       ActiveWindow.DisplayGridlines = False
       ' Protect sheet to prevent overwriting the dates.
       ActiveSheet.Protect DrawingObjects:=True, Contents:=True, _
          Scenarios:=True

       ' Resize window to show all of calendar (may have to be adjusted
       ' for video configuration).
       ActiveWindow.WindowState = xlMaximized
       ActiveWindow.ScrollRow = 1

       ' Allow screen to redraw with calendar showing.
       Application.ScreenUpdating = True
       ' Prevent going to error trap unless error found by exiting Sub
       ' here.
       Exit Sub
   ' Error causes msgbox to indicate the problem, provides new input box, 
   ' and resumes at the line that caused the error.
   MyErrorTrap:
       MsgBox "You may not have entered your Month and Year correctly." _
           & Chr(13) & "Spell the Month correctly" _
           & " (or use 3 letter abbreviation)" _
           & Chr(13) & "and 4 digits for the Year"
       MyInput = InputBox("Type in Month and year for Calendar")
       If MyInput = "" Then Exit Sub
       Resume
   End Sub

```

You can add other code to customize the calendar to meet your needs. Insert extra rows for entry on the screen for each day or resize the screen to see the whole calendar based on screen size and resolution.
