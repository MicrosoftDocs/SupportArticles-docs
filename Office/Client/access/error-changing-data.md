---
title: Errors when you change or delete data in tables
description: Fixes an issue in which you can't update the data in tables that are linked to an Excel workbook in Access.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
  - Microsoft Office Access 2002
search.appverid: MET150
ms.date: 3/31/2022
---
# You cannot change, add, or delete data in tables that are linked to an Excel workbook in Access

_Original KB number:_ &nbsp; 904953

## Symptoms

In Microsoft Office Access 2007 or in Microsoft Office Access 2003 or in Microsoft Access 2002, you cannot change, add, or delete data in tables that are linked to a Microsoft Excel workbook.

Additionally, you may experience this behavior when any one of the following conditions is true:

- You build a query to retrieve data from tables that are linked to an Excel workbook.
- You build a form that accesses data from tables that are linked to an Excel workbook.
- You use DAO or ADO to update tables programmatically that are linked to an Excel workbook.

You receive the following message when you perform a query to update records in a linked Excel workbook:

> Operation must use an updateable query

You receive the following message when you use DAO to programmatically update tables that are linked to an Excel workbook:

> Runtime Error '3027' Cannot update. Database or object is read-only.

When you try to update the linked data in ADO, the message is the same, but the error number may be similar to the following:

> -2147217911 (80040e09)

When you run a query to insert records into an Excel workbook, you receive the following error message even if the Excel workbook is not linked to an Access database:

> Operation must use an updateable query

## Cause

This expected behavior occurs when either of the following conditions is true:

- You are using Office Access 2007.
- You have installed Microsoft Office 2003 Service Pack 2 (SP2) or a later service pack or any Access 2003 updates that were released after Office 2003 SP2.
- You have installed the update for Access 2002 (KB904018) that is dated October 18, 2005.
- You have installed an Access runtime application that includes Microsoft Office 2003 Service Pack 2 (SP2) or a later service pack, any Access 2003 updates that were released after Office 2003 SP2, or the update for Access 2002 (KB904018) that is dated October 18, 2005 or later.

## Workaround

To work around this expected behavior, use one of the following methods.

### Method 1: Use Microsoft Excel

Open the linked Excel workbook in Microsoft Excel, and then make your changes to the workbook. When you have completed the changes, save the changes and then close the workbook.

### Method 2: Use Office Access 2007, Access 2003, or Access 2002

Import the linked Excel workbook into Access, and then make your changes to the data. When you have completed the changes, export the data as an Excel .xls file.

To export the table from Access to Excel, run the following code in Access.

```vb
Public Sub WorkArounds()
On Error GoTo Leave

Dim strSQL, SQL As String
    Dim Db As ADODB.Connection
    Set Db = New ADODB.Connection
    Db.CursorLocation = adUseClient
    Db.Open "PROVIDER=Microsoft.Jet.OLEDB.4.0;Data Source=<AccessPath>"
    'Note: In Office Access 2007, use the following line of code:
    'Db.Open "PROVIDER=Microsoft.ACE.OLEDB.12.0;Data Source=<AccessPath>"
    SQL = "<MyQuery>"
    CopyRecordSetToXL SQL, Db
    Db.Close
    MsgBox "Access has successfully exported the data to excel file.", vbInformation, "Export Successful."
    Exit Sub
Leave:
        MsgBox Err.Description, vbCritical, "Error"
        Exit Sub
End Sub

Private Sub CopyRecordSetToXL(SQL As String, con As ADODB.Connection)
    Dim rs As New ADODB.Recordset
    Dim x
    Dim i As Integer, y As Integer
    Dim xlApp As Excel.Application
    Dim xlwbBook As Excel.Workbook, xlwbAddin As Excel.Workbook
    Dim xlwsSheet As Excel.Worksheet
    Dim rnData As Excel.Range
    Dim stFile As String, stAddin As String
    Dim rng As Range
    stFile = "<ExcelPath>"
    'Instantiate a new session with the COM-Object Excel.exe.
    Set xlApp = New Excel.Application
    Set xlwbBook = xlApp.Workbooks.Open(stFile)
    Set xlwsSheet = xlwbBook.Worksheets("<WorkSheets>")
    xlwsSheet.Activate
    'Getting the first cell to input the data.
    xlwsSheet.Cells.SpecialCells(xlCellTypeLastCell).Select
    y = xlApp.ActiveCell.Column - 1
    xlApp.ActiveCell.Offset(1, -y).Select
    x = xlwsSheet.Application.ActiveCell.Cells.Address
    'Opening the recordset based on the SQL query and saving the data in the Excel worksheet.
    rs.CursorLocation = adUseClient
    If rs.State = adStateOpen Then
        rs.Close
    End If
    rs.Open SQL, con
    If rs.RecordCount > 0 Then
        rs.MoveFirst
        x = Replace(x, "$", "")
        y = Mid(x, 2)
        Set rng = xlwsSheet.Range(x)
        xlwsSheet.Range(x).CopyFromRecordset rs
    End If
    xlwbBook.Close True
    xlApp.Quit
    Set xlwsSheet = Nothing
    Set xlwbBook = Nothing
    Set xlApp = Nothing

End Sub
```

> [!NOTE]
> In this code example, replace the following placeholders:

- \<AccessPath>
- \<ExcelPath>
- \<MyQuery>

  \<MyQuery> is placeholder for the query that you run against the tables in the Access database. The result of the query is exported to the Excel workbook.
- \<WorkSheets>

  \<WorkSheets> is a placeholder for the worksheet in Excel to which you want to export the result. To run this code example, press CTRL+G to open the **Immediate** window, type WorkArounds, and then press ENTER.

## More Information

Because of legal issues, Microsoft has disabled the functionality in Access 2003 and in Access 2002 that let users change the data in linked tables that point to a range in an Excel workbook. However, when you make changes directly in the Excel workbook, the changes appear in the linked table in Access.
