---
title: Transfer data to Excel from Visual Basic
description: Introduces methods for transferring data to Excel from Visual Basic.
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - Extensibility\Macros
  - CSSTroubleshoot
ms.reviewer: grege
search.appverid: 
  - MET150
appliesto: 
  - Excel 2010
  - Office Excel 2007
  - Office Excel 2003
ms.date: 05/26/2025
---

# Methods for transferring data to Excel from Visual Basic

## Summary

This article discusses numerous methods for transferring data to Microsoft Excel from your Microsoft Visual Basic application. This article also presents the advantages and the disadvantages for each method so that you can choose the solution that works best for you.

## More Information

The approach most commonly used to transfer data to an Excel workbook is Automation. Automation gives you the greatest flexibility for specifying the location of your data in the workbook as well as the ability to format the workbook and make various settings at run time. With Automation, you can use several approaches for transferring your data:

- Transfer data cell by cell
- Transfer data in an array to a range of cells
- Transfer data in an ADO recordset to a range of cells using the CopyFromRecordset method
- Create a QueryTable on an Excel worksheet that contains the result of a query on an ODBC or OLEDB data source
- Transfer data to the clipboard and then paste the clipboard contents into an Excel worksheet

There are also methods that you can use to transfer data to Excel that do not necessarily require Automation. If you are running an application server-side, this can be a good approach for taking the bulk of processing the data away from your clients. The following methods can be used to transfer your data without Automation:

- Transfer your data to a tab- or comma-delimited text file that Excel can later parse into cells on a worksheet
- Transfer your data to a worksheet using ADO
- Transfer data to Excel using Dynamic Data Exchange (DDE)

The following sections provide more detail on each of these solutions.

**Note** When you use Microsoft Office Excel 2007, you can use the new Excel 2007 Workbook (*.xlsx) file format when you save the workbooks. To do this, locate the following line of code in the following code examples:

```vb
oBook.SaveAs "C:\Book1.xls"
```
  
Replace this code with with the following line of code:

```vb
oBook.SaveAs "C:\Book1.xlsx"
```
  
Additionally, the Northwind database is not included in Office 2007 by default. However, you can download the Northwind database from Microsoft Office Online.

### Use Automation to transfer data cell by cell

With Automation, you can transfer data to a worksheet one cell at a time:

```vb
Dim oExcel As Object    
Dim oBook As Object    
Dim oSheet As Object 
    
'Start a new workbook in Excel    
Set oExcel = CreateObject("Excel.Application")    
Set oBook = oExcel.Workbooks.Add
      
'Add data to cells of the first worksheet in the new workbook    
Set oSheet = oBook.Worksheets(1)    
oSheet.Range("A1").Value = "Last Name"    
oSheet.Range("B1").Value = "First Name"    
oSheet.Range("A1:B1").Font.Bold = True    
oSheet.Range("A2").Value = "Doe"    
oSheet.Range("B2").Value = "John"     

'Save the Workbook and Quit Excel    
oBook.SaveAs "C:\Book1.xls"    
oExcel.Quit
```
  
Transferring data cell by cell can be a perfectly acceptable approach if the amount of data is small. You have the flexibility to place data anywhere in the workbook and can format the cells conditionally at run time. However, this approach is not recommended if you have a large amount of data to transfer to an Excel workbook. Each Range object that you acquire at run time results in an interface request so that transferring data in this manner can be slow. Additionally, Microsoft Windows 95 and Windows 98 have a 64K limitation on interface requests. If you reach or exceed this 64k limit on interface requests, the Automation server (Excel) might stop responding or you might receive errors indicating low memory.  

Once more, transferring data cell by cell is acceptable only for small amounts of data. If you need to transfer large data sets to Excel, you should consider one of the solutions presented later.

For more sample code for Automating Excel, see [How to automate Microsoft Excel from Visual Basic](https://support.microsoft.com/help/219151).

#### Use automation to transfer an array of data to a range on a worksheet

An array of data can be transferred to a range of multiple cells at once:

```vb
Dim oExcel As Object    
Dim oBook As Object    
Dim oSheet As Object     

'Start a new workbook in Excel    
Set oExcel = CreateObject("Excel.Application")    
Set oBook = oExcel.Workbooks.Add     

'Create an array with 3 columns and 100 rows    
Dim DataArray(1 To 100, 1 To 3) As Variant    
Dim r As Integer    
For r = 1 To 100       
   DataArray(r, 1) = "ORD" & Format(r, "0000")       
   DataArray(r, 2) = Rnd() * 1000       
   DataArray(r, 3) = DataArray(r, 2) * 0.7    
Next     

'Add headers to the worksheet on row 1    
Set oSheet = oBook.Worksheets(1)    
oSheet.Range("A1:C1").Value = Array("Order ID", "Amount", "Tax")     

'Transfer the array to the worksheet starting at cell A2    
oSheet.Range("A2").Resize(100, 3).Value = DataArray        

'Save the Workbook and Quit Excel    
oBook.SaveAs "C:\Book1.xls"    
oExcel.Quit
```
  
If you transfer your data using an array rather than cell by cell, you can realize an enormous performance gain with a large amount of data. Consider this line from the code above that transfers data to 300 cells in the worksheet:

```vb
   oSheet.Range("A2").Resize(100, 3).Value = DataArray
```
  
This line represents two interface requests (one for the Range object that the Range method returns and another for the Range object that the Resize method returns). On the other hand, transferring the data cell by cell would require requests for 300 interfaces to Range objects. Whenever possible, you can benefit from transferring your data in bulk and reducing the number of interface requests you make.

#### Use automation to transfer an ADO recordset to a worksheet range

Excel 2000 introduced the CopyFromRecordset method that allows you to transfer an ADO (or DAO) recordset to a range on a worksheet. The following code illustrates how you could automate Excel 2000, Excel 2002, or Office Excel 2003 and transfer the contents of the Orders table in the Northwind Sample Database using the CopyFromRecordset method.

```vb
'Create a Recordset from all the records in the Orders table    
Dim sNWind As String    
Dim conn As New ADODB.Connection    
Dim rs As ADODB.Recordset    
sNWind = _       
   "C:\Program Files\Microsoft Office\Office\Samples\Northwind.mdb"    conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & _       sNWind & ";"    
conn.CursorLocation = adUseClient    
Set rs = conn.Execute("Orders", , adCmdTable)        

'Create a new workbook in Excel    
Dim oExcel As Object    
Dim oBook As Object    
Dim oSheet As Object    
Set oExcel = CreateObject("Excel.Application")    
Set oBook = oExcel.Workbooks.Add    
Set oSheet = oBook.Worksheets(1)        

'Transfer the data to Excel    
oSheet.Range("A1").CopyFromRecordset rs        

'Save the Workbook and Quit Excel    
oBook.SaveAs "C:\Book1.xls"    
oExcel.Quit        
'Close the connection    
rs.Close    
conn.Close
```
  
**Note** If you use the Office 2007 version of the Northwind database, you must replace the following line of code in the code example:
  
```vb
conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & _ sNWind & ";"
```
  
Replace this line of code with the following line of code:

```vb
conn.Open "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & _ sNWind & ";"
```
  
Excel 97 also provides a CopyFromRecordset method but you can use it only with a DAO recordset. CopyFromRecordset with Excel 97 does not support ADO.

For more information about using ADO and the CopyFromRecordset method, see [How to transfer data from an ADO recordset to Excel with automation](https://support.microsoft.com/help/246335).

#### Use automation to create a QueryTable on a worksheet

A QueryTable object represents a table built from data returned from an external data source. While automating Microsoft Excel, you can create a QueryTable by simply providing a connection string to an OLEDB or an ODBC data source along with an SQL string. Excel assumes the responsibility for generating the recordset and inserting it into the worksheet at the location you specify. Using QueryTables offers several advantages over the CopyFromRecordset method:

- Excel handles the creation of the recordset and its placement into the worksheet.
- The query can be saved with the QueryTable so that it can be refreshed at a later time to obtain an updated recordset.
- When a new QueryTable is added to your worksheet, you can specify that data already existing in cells on the worksheet be shifted to accommodate the new data (see the RefreshStyle property for details).

The following code demonstrates how you could automate Excel 2000, Excel 2002, or Office Excel 2003 to create a new QueryTable in an Excel worksheet using data from the Northwind Sample Database:
  
```vb
'Create a new workbook in Excel    
Dim oExcel As Object    
Dim oBook As Object    
Dim oSheet As Object    
Set oExcel = CreateObject("Excel.Application")    
Set oBook = oExcel.Workbooks.Add    
Set oSheet = oBook.Worksheets(1)        

'Create the QueryTable    
Dim sNWind As String    
sNWind = _       
   "C:\Program Files\Microsoft Office\Office\Samples\Northwind.mdb"    
Dim oQryTable As Object    
Set oQryTable = oSheet.QueryTables.Add( _    
"OLEDB;Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & _       
sNWind & ";", oSheet.Range("A1"), "Select * from Orders")    oQryTable.RefreshStyle = xlInsertEntireRows    
oQryTable.Refresh False        

'Save the Workbook and Quit Excel    
oBook.SaveAs "C:\Book1.xls"    
oExcel.Quit
```

#### Use the clipboard

The Windows Clipboard can also be used as a mechanism for transferring data to a worksheet. To paste data into multiple cells on a worksheet, you can copy a string where columns are delimited by tab characters and rows are delimited by carriage returns. The following code illustrates how Visual Basic can use its Clipboard object to transfer data to Excel:

```vb
'Copy a string to the clipboard    
Dim sData As String    
sData = "FirstName" & vbTab & "LastName" & vbTab & "Birthdate" & vbCr _            & "Bill" & vbTab & "Brown" & vbTab & "2/5/85" & vbCr _            
    & "Joe" & vbTab & "Thomas" & vbTab & "1/1/91"    
Clipboard.Clear     
Clipboard.SetText sData        

'Create a new workbook in Excel    
Dim oExcel As Object    
Dim oBook As Object    
Set oExcel = CreateObject("Excel.Application")    
Set oBook = oExcel.Workbooks.Add         

'Paste the data    
oBook.Worksheets(1).Range("A1").Select    
oBook.Worksheets(1).Paste        

'Save the Workbook and Quit Excel    
oBook.SaveAs "C:\Book1.xls"    
oExcel.Quit
```

#### Create a delimited text file that Excel can parse into rows and columns

Excel can open tab- or comma-delimited files and correctly parse the data into cells. You can take advantage of this feature when you want to transfer a large amount of data to a worksheet while using little, if any, Automation. This might be a good approach for a client-server application because the text file can be generated server-side. You can then open the text file at the client, using Automation where it is appropriate.

The following code illustrates how you can create a comma-delimited text file from an ADO recordset:

```vb
'Create a Recordset from all the records in the Orders table    
Dim sNWind As String    
Dim conn As New ADODB.Connection   
Dim rs As ADODB.Recordset    
Dim sData As String    
sNWind = _       
   "C:\Program Files\Microsoft Office\Office\Samples\Northwind.mdb"    conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & _       sNWind & ";"    
conn.CursorLocation = adUseClient    
Set rs = conn.Execute("Orders", , adCmdTable)        

'Save the recordset as a tab-delimited file    
sData = rs.GetString(adClipString, , vbTab, vbCr, vbNullString)    
Open "C:\Test.txt" For Output As #1    
Print #1, sData    
Close #1         

'Close the connection    
rs.Close    
conn.Close        

'Open the new text file in Excel    
Shell "C:\Program Files\Microsoft Office\Office\Excel.exe " & _       Chr(34) & "C:\Test.txt" & Chr(34), vbMaximizedFocus
```
  
Note If you use the Office 2007 version of the Northwind database, you must replace the following line of code in the code example:

```vb
conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & _       
   sNWind & ";"
```
  
Replace this line of code with the following line of code:

```vb
conn.Open "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & _       
   sNWind & ";"
```
  
If your text file has a .CSV extension, Excel opens the file without displaying the Text Import Wizard and automatically assumes that the file is comma-delimited. Similarly, if your file has a .TXT extension, Excel automatically parse the file using tab delimiters.

In the previous code sample, Excel was launched using the Shell statement and the name of the file was used as a command line argument. No Automation was used in the previous sample. However, if so desired, you could use a minimal amount of Automation to open the text file and save it in the Excel workbook format:

```vb
'Create a new instance of Excel    
Dim oExcel As Object    
Dim oBook As Object    
Dim oSheet As Object    
Set oExcel = CreateObject("Excel.Application")            

'Open the text file   
 Set oBook = oExcel.Workbooks.Open("C:\Test.txt")        

'Save as Excel workbook and Quit Excel    
oBook.SaveAs "C:\Book1.xls", xlWorkbookNormal    
oExcel.Quit
```

#### Transfer data to a worksheet by using ADO

Using the Microsoft Jet OLE DB Provider, you can add records to a table in an existing Excel workbook. A "table" in Excel is merely a range with a defined name. The first row of the range must contain the headers (or field names) and all subsequent rows contain the records. The following steps illustrate how you can create a workbook with an empty table named MyTable.

##### Excel 97, Excel 2000, and Excel 2003

1. Start a new workbook in Excel.
2. Add the following headers to cells A1:B1 of Sheet1:

   A1: FirstName B1: LastName
3. Format cell B1 as right-aligned.
4. Select A1:B1.
5. On the Insert menu, choose Names and then select Define. Enter the name MyTable and click OK.
6. Save the new workbook as C:\Book1.xls and quit Excel.

To add records to MyTable using ADO, you can use code similar to the following:

```vb
'Create a new connection object for Book1.xls    
Dim conn As New ADODB.Connection    
conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;" & _       
    "Data Source=C:\Book1.xls;Extended Properties=Excel 8.0;"    
conn.Execute "Insert into MyTable (FirstName, LastName)" & _       
   " values ('Bill', 'Brown')"    
conn.Execute "Insert into MyTable (FirstName, LastName)" & _       
   " values ('Joe', 'Thomas')"    
conn.Close
```

##### Excel 2007

1. In Excel 2007, start a new workbook.
2. Add the following headers to cells A1:B1 of Sheet1:

   A1: FirstName B1: LastName
3. Format cell B1 as right-aligned.
4. Select A1:B1.
5. On the Ribbon, click the **Formulas** tab, and then click **Define Name**. Type the name MyTable, and then click **OK**.
6. Save the new workbook as C:\Book1.xlsx, and then quit Excel.

To add records to the MyTable table by using ADO, use code that resembles the following code example.

```vb
'Create a new connection object for Book1.xls    
Dim conn As New ADODB.Connection    
conn.Open "Provider=Microsoft.ACE.OLEDB.12.0;" & _       
   "Data Source=C:\Book1.xlsx;Extended Properties=Excel 12.0;"    
conn.Execute "Insert into MyTable (FirstName, LastName)" & _       
   " values ('Scott', 'Brown')"    
conn.Execute "Insert into MyTable (FirstName, LastName)" & _       
   " values ('Jane', 'Dow')"    
conn.Close
```
  
When you add records to the table in this manner, the formatting in the workbook is maintained. In the previous example, new fields added to column B are formatted with right alignment. Each record that is added to a row borrows the format from the row above it.

You should note that when a record is added to a cell or cells in the worksheet, it overwrites any data previously in those cells; in other words, rows in the worksheet are not "pushed down" when new records are added. You should keep this in mind when designing the layout of data on your worksheets.

> [!NOTE]
> The method to update data in an Excel worksheet by using ADO or by using DAO does not work in Visual Basic for Application environment within Access after you install Office 2003 Service Pack 2 (SP2) or after you install the update for Access 2002 that is included in Microsoft Knowledge Base article 904018. The method works well in Visual Basic for Application environment from other Office applications, such as Word, Excel, and Outlook.

For more information, see the following article:

[You cannot change, add, or delete data in tables that are linked to an Excel workbook in Office Access 2003 or in Access 2002](https://support.microsoft.com/help/904953)

For more information about using ADO to access an Excel workbook, see [How To Query and Update Excel Data Using ADO From ASP](/previous-versions/troubleshoot/content-retirement).

#### Use DDE to transfer data to Excel

DDE is an alternative to Automation as a means for communicating with Excel and transferring data; however, with the advent of Automation and COM, DDE is no longer the preferred method for communicating with other applications and should only be used when there is no other solution available to you.

To transfer data to Excel using DDE, you can use the LinkPoke method to poke data to a specific range of cell(s), or you use the LinkExecute method to send commands that Excel will execute.

The following code example illustrates how to establish a DDE conversation with Excel so that you can poke data to cells on a worksheet and execute commands. Using this sample, for a DDE conversation to be successfully established to the LinkTopic Excel|MyBook.xls, a workbook with the name MyBook.xls must already be opened in a running instance of Excel.

> [!NOTE]
> When you use Excel 2007, you can use the new .xlsx file format to save the workbooks. Make sure that you update the file name in the following code example. In this example, Text1 represents a Text Box control on a Visual Basic form:

```vb
'Initiate a DDE communication with Excel    
Text1.LinkMode = 0    
Text1.LinkTopic = "Excel|MyBook.xls"    
Text1.LinkItem = "R1C1:R2C3"    
Text1.LinkMode = 1        

'Poke the text in Text1 to the R1C1:R2C3 in MyBook.xls    
Text1.Text = "one" & vbTab & "two" & vbTab & "three" & vbCr & _                             
             "four" & vbTab & "five" & vbTab & "six"    
Text1.LinkPoke        

'Execute commands to select cell A1 (same as R1C1) and change the font  format 
Text1.LinkExecute "[SELECT(""R1C1"")]"    
Text1.LinkExecute "[FONT.PROPERTIES(""Times New Roman"",""Bold"",10)]"        

'Terminate the DDE communication    
Text1.LinkMode = 0
```

When using LinkPoke with Excel, you specify the range in row-column (R1C1) notation for the LinkItem. If you are poking data to multiple cells, you can use a string where the columns are delimited by tabs and rows are delimited by carriage returns.

When you use LinkExecute to ask Excel to carry out a command, you must give Excel the command in the syntax of the Excel Macro Language (XLM). The XLM documentation is not included with Excel versions 97 and later.  
DDE is not a recommended solution for communicating with Excel. Automation provides the greatest flexibility and gives you more access to the new features that Excel has to offer.
