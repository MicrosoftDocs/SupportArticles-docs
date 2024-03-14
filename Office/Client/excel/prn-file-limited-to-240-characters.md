---
title: Formatted text is limited to 240 characters per line
description: Describes the limit per line when you save a worksheet as a Formatted Text (Space Delimited) (.prn) file.
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

# Formatted text (.prn) is limited to 240 characters per line in Excel

## Symptoms

In Microsoft Excel, when you save a worksheet as a Formatted Text (Space Delimited) (.prn) file, any characters beyond the two-hundred fortieth character are wrapped to the next line.

> [!NOTE]
> If several rows on the same sheet contain text beyond 240 characters, the text begins wrapping at the row after the last row that contains text.

For example, consider the following sheet:

|Cell|Number of Characters|
|-----|------------|
|A1| 40|
|A2 |255|
|A3 |10|
|A4| 21|
|A5| 2|
|A6 |52|
|A7| 255|
|A8| 5|
|A9| 3|
|A20| 13|

The resulting formatted text file contains lines with the following number of characters:

|Line Number| Characters|
|-----------|-------------|
|1 |40|
|2 |240|
|3 |10|
|4 |21|
|5 |2|
|6 |52|
|7 |240|
|8 |5|
|9 |3|
|10-19 |0|
|20 |13|
|21 |0|
|22 |15|
|23-26 |0|
|27 |15|

After the last line (in this example, line 20), the line numbering starts at 1 for the lines that are wrapped. In effect, line 21 corresponds with line 1, line 22 corresponds with line 2, and so on.

## Cause

This behavior occurs because, by design, Formatted Text (Space Delimited) (.prn) files have a limit of 240 characters per line.

## Workaround

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements. To create a space-delimited text file that exceeds the 240-character per line limitation, use a macro similar to the following sample macro.

> [!NOTE]
> Before you run this macro, do the following:
>
> - Select the cells to be included in the text file.
> - Verify that column widths are wide enough to view the largest string in each column. The maximum column width for a single Excel column is 255 characters when formatted with a fixed-width font.
> - Use the Style menu commands to format the worksheet to use a fixed-width font. For example, Courier is a fixed-width font.

The following sample code can be modified to export data delimited with characters other than a space. You must select the range of data to be exported before running this sample macro.

```vb
Sub ExportText()

Dim delimiter As String
   Dim quotes As Integer
   Dim Returned As String

       delimiter = " "

       quotes = MsgBox("Surround Cell Information with Quotes?", vbYesNo)

' Call the WriteFile function passing the delimiter and quotes options.
      Returned = WriteFile(delimiter, quotes)

' Print a message box indicating if the process was completed.
      Select Case Returned
         Case "Canceled"
            MsgBox "The export operation was canceled."
         Case "Exported"
            MsgBox "The information was exported."
      End Select

End Sub

'------------------------------------------------------------

Function WriteFile(delimiter As String, quotes As Integer) As String

  ' Dimension variables to be used in this function.
   Dim CurFile As String
   Dim SaveFileName
   Dim CellText As String
   Dim RowNum As Integer
   Dim ColNum As Integer
   Dim FNum As Integer
   Dim TotalRows As Double
   Dim TotalCols As Double

   ' Show Save As dialog box with the .TXT file name as the default.
   ' Test to see what kind of system this macro is being run on.
   If Left(Application.OperatingSystem, 3) = "Win" Then
      SaveFileName = Application.GetSaveAsFilename(CurFile, _
      "Text Delimited (*.txt), *.txt", , "Text Delimited Exporter")
   Else
       SaveFileName = Application.GetSaveAsFilename(CurFile, _
      "TEXT", , "Text Delimited Exporter")
   End If

   ' Check to see if Cancel was clicked.
      If SaveFileName = False Then
         WriteFile = "Canceled"
         Exit Function
      End If
   ' Obtain the next free file number.
      FNum = FreeFile()

   ' Open the selected file name for data output.
      Open SaveFileName For Output As #FNum

   ' Store the total number of rows and columns to variables.
      TotalRows = Selection.Rows.Count
      TotalCols = Selection.Columns.Count

   ' Loop through every cell, from left to right and top to bottom.
      For RowNum = 1 To TotalRows
         For ColNum = 1 To TotalCols
            With Selection.Cells(RowNum, ColNum)
            Dim ColWidth as Integer
            ColWidth=Application.RoundUp(.ColumnWidth, 0)
            ' Store the current cells contents to a variable.
            Select Case .HorizontalAlignment
               Case xlRight
                  CellText = Space(Abs(ColWidth - Len(.Text))) & .Text
               Case xlCenter
                  CellText = Space(Abs(ColWidth - Len(.Text))/2) & .Text & _
                             Space(Abs(ColWidth - Len(.Text))/2)
               Case Else
                  CellText = .Text & Space(Abs(ColWidth - Len(.Text)))
            End Select
            End With
   ' Write the contents to the file.
   ' With or without quotation marks around the cell information.
            Select Case quotes
               Case vbYes
                  CellText = Chr(34) & CellText & Chr(34) & delimiter
               Case vbNo
                  CellText = CellText & delimiter
            End Select
            Print #FNum, CellText;

   ' Update the status bar with the progress.
            Application.StatusBar = Format((((RowNum - 1) * TotalCols) _
               + ColNum) / (TotalRows * TotalCols), "0%") & " Completed."

   ' Loop to the next column.
         Next ColNum
   ' Add a linefeed character at the end of each row.
         If RowNum <> TotalRows Then Print #FNum, ""
   ' Loop to the next row.
      Next RowNum

   ' Close the .prn file.
      Close #FNum

   ' Reset the status bar.
      Application.StatusBar = False
      WriteFile = "Exported"
   End Function
```

> [!NOTE]
> The output file that this routine creates is, by definition, different from a Formatted Text(*.prn) file. By definition, the formatted text file cannot contain more than 240 characters per line. In addition, the formatted text file also contains printer font information. This sample macro does not. This solution is designed to give flexibility when you export to text files.
