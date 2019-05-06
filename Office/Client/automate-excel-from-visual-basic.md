---
title: How to automate Microsoft Excel from Visual Basic
description: Demonstrates how to create and manipulate Excel by using Automation from Visual Basic.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to automate Microsoft Excel from Visual Basic

## Summary

This article demonstrates how to create and manipulate Excel by using Automation from Visual Basic. 

## More Information

There are two ways to control an Automation server: by using either late binding or early binding. With late binding, methods are not bound until run-time and the Automation server is declared as Object. With early binding, your application knows at design-time the exact type of object it will be communicating with, and can declare its objects as a specific type. This sample uses early binding, which is considered better in most cases because it affords greater performance and better type safety.

To early bind to an Automation server, you need to set a reference to that server's type library. In Visual Basic, this is done through the References dialog box found under the Project | References menu. For this sample, you will need to add a reference to the type library for Excel before you can run the code. See the steps below on how to add the reference.

### Building the Automation Sample

1. Start Visual Basic and create a new Standard EXE project. Form1 is created by default.   
2. Click**Project** and then click **References**. The **References**dialog box appears. Scroll down the list until you find **Microsoft Excel object library**, and then select the item to add a reference to Excel. If the correct object library for your version of Excel does not appear in the list, make sure that you have your version of Excel properly installed.

   **Notes**
   - If you are automating Microsoft Office Excel 2007, the type library appears as **Microsoft Excel 12.0 Object Library** in the **References**list.   
   - If you are automating Microsoft Office Excel 2003, the type library appears as **Microsoft Excel 11.0 Object Library** in the **References**list.   
   - If you are automating Microsoft Excel 2002, the type library appears as
**Microsoft Excel 10.0 Object Library** in the **References** list   
   - If you are automating Microsoft Excel 2000, the type library appears as
**Microsoft Excel 9.0 Object Library** in the **References** list.   
   - If you are automating Microsoft Excel 97, the type library appears as
**Microsoft Excel 8.0 Object Library** in the **References** list   
   
3. Click **OK** to close the **References** dialog box.   
4. Add a CommandButton to Form1.   
5. In the code window for Form1, insert the following code:

   ```vb
   Option Explicit

   Private Sub Command1_Click()
      Dim oXL As Excel.Application
      Dim oWB As Excel.Workbook
      Dim oSheet As Excel.Worksheet
      Dim oRng As Excel.Range

   'On Error GoTo Err_Handler

   ' Start Excel and get Application object.
      Set oXL = CreateObject("Excel.Application")
      oXL.Visible = True

   ' Get a new workbook.
      Set oWB = oXL.Workbooks.Add
      Set oSheet = oWB.ActiveSheet

   ' Add table headers going cell by cell.
      oSheet.Cells(1, 1).Value = "First Name"
      oSheet.Cells(1, 2).Value = "Last Name"
      oSheet.Cells(1, 3).Value = "Full Name"
      oSheet.Cells(1, 4).Value = "Salary"

   ' Format A1:D1 as bold, vertical alignment = center.
      With oSheet.Range("A1", "D1")
         .Font.Bold = True
         .VerticalAlignment = xlVAlignCenter
      End With

   ' Create an array to set multiple values at once.
      Dim saNames(5, 2) As String
      saNames(0, 0) = "John"
      saNames(0, 1) = "Smith"
      saNames(1, 0) = "Tom"
      saNames(1, 1) = "Brown"
      saNames(2, 0) = "Sue"
      saNames(2, 1) = "Thomas"
      saNames(3, 0) = "Jane"

   saNames(3, 1) = "Jones"
      saNames(4, 0) = "Adam"
      saNames(4, 1) = "Johnson"

   ' Fill A2:B6 with an array of values (First and Last Names).
      oSheet.Range("A2", "B6").Value = saNames

   ' Fill C2:C6 with a relative formula (=A2 & " " & B2).
      Set oRng = oSheet.Range("C2", "C6")
      oRng.Formula = "=A2 & "" "" & B2"

   ' Fill D2:D6 with a formula(=RAND()*100000) and apply format.
      Set oRng = oSheet.Range("D2", "D6")
      oRng.Formula = "=RAND()*100000"
      oRng.NumberFormat = "$0.00"

   ' AutoFit columns A:D.
      Set oRng = oSheet.Range("A1", "D1")
      oRng.EntireColumn.AutoFit

   ' Manipulate a variable number of columns for Quarterly Sales Data.
      Call DisplayQuarterlySales(oSheet)

   ' Make sure Excel is visible and give the user control
    ' of Microsoft Excel's lifetime.
      oXL.Visible = True
      oXL.UserControl = True

   ' Make sure you release object references.
      Set oRng = Nothing
      Set oSheet = Nothing
      Set oWB = Nothing
      Set oXL = Nothing

   Exit Sub
   Err_Handler:
      MsgBox Err.Description, vbCritical, "Error: " & Err.Number
   End Sub

   Private Sub DisplayQuarterlySales(oWS As Excel.Worksheet)
      Dim oResizeRange As Excel.Range
      Dim oChart As Excel.Chart
      Dim iNumQtrs As Integer
      Dim sMsg As String
      Dim iRet As Integer

   ' Determine how many quarters to display data for.
      For iNumQtrs = 4 To 2 Step -1
         sMsg = "Enter sales data for" & Str(iNumQtrs) & " quarter(s)?"
         iRet = MsgBox(sMsg, vbYesNo Or vbQuestion _
            Or vbMsgBoxSetForeground, "Quarterly Sales")
         If iRet = vbYes Then Exit For
      Next iNumQtrs

   sMsg = "Displaying data for" & Str(iNumQtrs) & " quarter(s)."
      MsgBox sMsg, vbMsgBoxSetForeground, "Quarterly Sales"

   ' Starting at E1, fill headers for the number of columns selected.
      Set oResizeRange = oWS.Range("E1", "E1").Resize(ColumnSize:=iNumQtrs)

   oResizeRange.Formula = "=""Q"" & COLUMN()-4 & CHAR(10) & ""Sales"""

   ' Change the Orientation and WrapText properties for the headers.
      oResizeRange.Orientation = 38
      oResizeRange.WrapText = True

   ' Fill the interior color of the headers.
      oResizeRange.Interior.ColorIndex = 36

   ' Fill the columns with a formula and apply a number format.
      Set oResizeRange = oWS.Range("E2", "E6").Resize(ColumnSize:=iNumQtrs)
      oResizeRange.Formula = "=RAND()*100"
      oResizeRange.NumberFormat = "$0.00"

   ' Apply borders to the Sales data and headers.
      Set oResizeRange = oWS.Range("E1", "E6").Resize(ColumnSize:=iNumQtrs)
      oResizeRange.Borders.Weight = xlThin

   ' Add a Totals formula for the sales data and apply a border.
      Set oResizeRange = oWS.Range("E8", "E8").Resize(ColumnSize:=iNumQtrs)
      oResizeRange.Formula = "=SUM(E2:E6)"
      With oResizeRange.Borders(xlEdgeBottom)
         .LineStyle = xlDouble
         .Weight = xlThick
      End With

   ' Add a Chart for the selected data
      Set oResizeRange = oWS.Range("E2:E6").Resize(ColumnSize:=iNumQtrs)
      Set oChart = oWS.Parent.Charts.Add
      With oChart
         .ChartWizard oResizeRange, xl3DColumn, , xlColumns
         .SeriesCollection(1).XValues = oWS.Range("A2", "A6")
            For iRet = 1 To iNumQtrs
               .SeriesCollection(iRet).Name = "=""Q" & Str(iRet) & """"
            Next iRet
         .Location xlLocationAsObject, oWS.Name
      End With

   ' Move the chart so as not to cover your data.
      With oWS.Shapes("Chart 1")
         .Top = oWS.Rows(10).Top
         .Left = oWS.Columns(2).Left

   End With

   ' Free any references.
      Set oChart = Nothing
      Set oResizeRange = Nothing

   End Sub

   ```

6. Press F5 to run the project.