---
title: Export a text file with both comma and quote delimiters in Excel
description: Provides the procedure to export a text file with both comma and quote delimiters in Excel
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
  - Office Excel 2007
  - Office Excel 2003
  - Excel 2002
ms.date: 03/31/2022
---

# Procedure to export a text file with both comma and quote delimiters in Excel

## Summary

Microsoft Excel does not have a menu command to automatically export data to a text file so that the text file is exported with both quotation marks and commas as delimiters. For example, there is no command to automatically create a text file that contains the following data:

"Text1","Text2","Text3"

However, you can create this functionality in Excel by using a Microsoft Visual Basic for Applications procedure.

## More information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements. 

You can use the Print # statement in a Visual Basic procedure that is similar to the following to export a text file with both quotation marks and commas as the delimiters. For the procedure to function correctly, select the cells that contain your data before you run it.

Before you work with the following sample code, follow these steps:

1. Open a new workbook.
2. In Microsoft Office Excel 2003 or in Microsoft Excel 2002, point to Macro on the Tools menu, and then click Visual Basic Editor. Alternatively, press ALT+F11.

    In Microsoft Office Excel 2007, click the **Developer** tab, and then click
    **Visual Basic** in the **Code** group. Alternatively, press ALT + F11.

    > [!NOTE]
    > To show the **Developer** tab in the Ribbon, click the **Microsoft Office Button**, click **Excel Options**, click the**Popular** category, click to select the **Show Developer tab in the Ribbon** check box, and then click **OK**.
3. In the Visual Basic Editor, click Module on the Insert menu.
4. Type or paste the following sample code in the module sheet.

    ```vb
    Sub QuoteCommaExport()
       ' Dimension all variables.
       Dim DestFile As String
       Dim FileNum As Integer
       Dim ColumnCount As Long
       Dim RowCount As Long
    
       ' Prompt user for destination file name.
       DestFile = InputBox("Enter the destination filename" _
          & Chr(10) & "(with complete path):", "Quote-Comma Exporter")
    
       ' Obtain next free file handle number.
       FileNum = FreeFile()
     
      ' Turn error checking off.
       On Error Resume Next
    
       ' Attempt to open destination file for output.
       Open DestFile For Output As #FileNum
    
       ' If an error occurs report it and end.
       If Err <> 0 Then
          MsgBox "Cannot open filename " & DestFile
          End
       End If
    
       ' Turn error checking on.
       On Error GoTo 0
    
       ' Loop for each row in selection.
       For RowCount = 1 To Selection.Rows.Count
    
       ' Loop for each column in selection.
          For ColumnCount = 1 To Selection.Columns.Count
    
            ' Write current cell's text to file with quotation marks.
             Print #FileNum, """" & Selection.Cells(RowCount, _
                ColumnCount).Text & """";
    
             ' Check if cell is in last column.
             If ColumnCount = Selection.Columns.Count Then
                ' If so, then write a blank line.
                Print #FileNum,
             Else
                ' Otherwise, write a comma.
                Print #FileNum, ",";
             End If
          ' Start next iteration of ColumnCount loop.
          Next ColumnCount
       ' Start next iteration of RowCount loop.
       Next RowCount
    
       ' Close destination file.
       Close #FileNum
    End Sub
    ```

5. Before you run the macro, select the data that you want to export, and then run the QuoteCommaExport subroutine.   
