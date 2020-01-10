---
title: Automate Excel from Visual Basic .NET to fill or obtain data by using arrays
description: Demonstrates how to automate Microsoft Excel and how to fill a multi-cell range with an array of values. Also illustrates how to retrieve a multi-cell range as an array by using automation.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Microsoft Excel
---

# How to automate Excel from Visual Basic .NET to fill or to obtain data in a range by using arrays

## Summary

This article demonstrates how to automate Microsoft Excel and how to fill a multi-cell range with an array of values. This article also illustrates how to retrieve a multi-cell range as an array by using Automation. 

## More Information

To fill a multi-cell range without populating cells one at a time, you can set the Value property of a Range object to a two-dimensional array. Likewise, a two-dimensional array of values can be retrieved for multiple cells at once by using the Value property. The following steps demonstrate this process for both setting and retrieving data using two-dimensional arrays. 

### Build the Automation Client for Microsoft Excel

1. Start Microsoft Visual Studio .NET.   
2. On the File menu, click New, and then click Project. Select Windows Application from the Visual Basic Project types. By default, Form1 is created.   
3. Add a reference to Microsoft Excel Object Library. To do this, follow these steps:

   1. On the Project menu, click Add Reference.   
   2. On the COM tab, locate Microsoft Excel Object Library, and then click Select. 

   **Note** Microsoft Office 2007 and Microsoft Office 2003 include Primary Interop Assemblies (PIAs). Microsoft Office XP does not include PIAs, but they can be downloaded. 

4. Click OK in the Add References dialog box to accept your selections. If you are prompted to generate wrappers for the libraries that you selected, click Yes.   
   
5. On the View menu, select Toolbox to display the Toolbox. Add two buttons and a check box to Form1.   
6. Set the Name property for the check box to
FillWithStrings.   
7. Double-click Button1. The code window for the Form appears.   
8. Add the following to the top of Form1.vb:

   ```vb
   Imports Microsoft.Office.Interop

   ```

9. In the code window, replace the following code

   ```vb
    Private Sub Button1_Click(ByVal sender As System.Object, _
      ByVal e As System.EventArgs) Handles Button1.Click
   End Sub
   ```
   with: 

   ```vb
    'Keep the application object and the workbook object global, so you can  
    'retrieve the data in Button2_Click that was set in Button1_Click.
    Dim objApp As Excel.Application
    Dim objBook As Excel._Workbook

   Private Sub Button1_Click(ByVal sender As System.Object, _
      ByVal e As System.EventArgs) Handles Button1.Click
        Dim objBooks As Excel.Workbooks
        Dim objSheets As Excel.Sheets
        Dim objSheet As Excel._Worksheet
        Dim range As Excel.Range

   ' Create a new instance of Excel and start a new workbook.
        objApp = New Excel.Application()
        objBooks = objApp.Workbooks
        objBook = objBooks.Add
        objSheets = objBook.Worksheets
        objSheet = objSheets(1)

   'Get the range where the starting cell has the address
        'm_sStartingCell and its dimensions are m_iNumRows x m_iNumCols.
        range = objSheet.Range("A1", Reflection.Missing.Value)
        range = range.Resize(5, 5)

   If (Me.FillWithStrings.Checked = False) Then
            'Create an array.
            Dim saRet(5, 5) As Double

   'Fill the array.
            Dim iRow As Long
            Dim iCol As Long
            For iRow = 0 To 5
                For iCol = 0 To 5

   'Put a counter in the cell.
                    saRet(iRow, iCol) = iRow * iCol
                Next iCol
            Next iRow

   'Set the range value to the array.
            range.Value = saRet

   Else
            'Create an array.
            Dim saRet(5, 5) As String

   'Fill the array.
            Dim iRow As Long
            Dim iCol As Long
            For iRow = 0 To 5
                For iCol = 0 To 5

   'Put the row and column address in the cell.
                    saRet(iRow, iCol) = iRow.ToString() + "|" + iCol.ToString()
                Next iCol
            Next iRow

   'Set the range value to the array.
            range.Value = saRet
        End If

   'Return control of Excel to the user.
        objApp.Visible = True
        objApp.UserControl = True

   'Clean up a little.
        range = Nothing
        objSheet = Nothing
        objSheets = Nothing
        objBooks = Nothing
    End Sub

   ```

10. Return to the design view for Form1, and then double-click Button2.   
11. In the code window, replace the following code

    ```vb
    Private Sub Button2_Click(ByVal sender As System.Object, _
      ByVal e As System.EventArgs) Handles Button2.Click

    End Sub
    ```
 
    with: 

    ```vb
    Private Sub Button2_Click(ByVal sender As System.Object, _
      ByVal e As System.EventArgs) Handles Button2.Click
        Dim objSheets As Excel.Sheets
        Dim objSheet As Excel._Worksheet
        Dim range As Excel.Range

    'Get a reference to the first sheet of the workbook.
        On Error Goto ExcelNotRunning
        objSheets = objBook.Worksheets
        objSheet = objSheets(1)

    ExcelNotRunning:
        If (Not (Err.Number = 0)) Then
            MessageBox.Show("Cannot find the Excel workbook.  Try clicking Button1 to " + _
            "create an Excel workbook with data before running Button2.", _
            "Missing Workbook?")

    'We cannot automate Excel if we cannot find the data we created, 
            'so leave the subroutine.
            Exit Sub
        End If

    'Get a range of data.
        range = objSheet.Range("A1", "E5")

    'Retrieve the data from the range.
        Dim saRet(,) As Object
        saRet = range.Value

    'Determine the dimensions of the array.
        Dim iRows As Long
        Dim iCols As Long
        iRows = saRet.GetUpperBound(0)
        iCols = saRet.GetUpperBound(1)

    'Build a string that contains the data of the array.
        Dim valueString As String
        valueString = "Array Data" + vbCrLf

    Dim rowCounter As Long
        Dim colCounter As Long
        For rowCounter = 1 To iRows
            For colCounter = 1 To iCols

    'Write the next value into the string.
                valueString = String.Concat(valueString, _
                    saRet(rowCounter, colCounter).ToString() + ", ")

    Next colCounter

    'Write in a new line.
            valueString = String.Concat(valueString, vbCrLf)
        Next rowCounter

    'Report the value of the array.
        MessageBox.Show(valueString, "Array Values")

    'Clean up a little.
        range = Nothing
        objSheet = Nothing
        objSheets = Nothing
    End Sub

    ```

### Test the Automation Client

1. Press F5 to build and to run the sample program.   
2. Click Button1. Microsoft Excel is started with a new workbook, and cells A1:E5 of the first worksheet are populated with numeric data from an array.   
3. Click Button2. The program retrieves the data in cells A1:E5 into a new array and displays the results in a message box.   
4. Select FillWithStrings, and then click Button1 to fill cells A1:E5 with the string data.   

## References

For additional information about using arrays to set and retrieve Excel data with earlier versions of Visual Studio, click the article numbers below to view the article in the Microsoft Knowledge Base: 

[247412](https://support.microsoft.com/help/247412) INFO: Methods for Transferring Data to Excel from Visual Basic