---
title: Transfer data to an Excel workbook by using Visual C# 2005 or Visual C# .NET
description: Describes some sample steps for how to transfer data to an Excel workbook by using Visual C# 2005 or Visual C# .NET.
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
- Excel 2003
- Excel 2002 
- Excel 2000
---

# How to transfer data to an Excel workbook by using Visual C# 2005 or Visual C# .NET

For a Microsoft Visual Basic 6.0 version of this article, see [247412](https://support.microsoft.com/help/247412).

This step-by-step article describes several methods for transferring data to Microsoft Excel 2002 from a Microsoft Visual C# 2005 or Microsoft Visual C# .NET program. This article also presents the advantages and disadvantages of each method so that you can select the solution that works best for your situation.

## Overview

The technique that is most frequently used to transfer data to an Excel workbook is Automation. With Automation, you can call methods and properties that are specific to Excel tasks. Automation gives you the greatest flexibility for specifying the location of your data in the workbook, formatting the workbook, and making various settings at run-time.

With Automation, you can use several techniques to transfer your data:

- Transfer data cell by cell.   
- Transfer data in an array to a range of cells.   
- Transfer data in an ADO recordset to a range of cells by using the CopyFromRecordset method.   
- Create a QueryTable object on an Excel worksheet that contains the result of a query on an ODBC or OLEDB data source.   
- Transfer data to the clipboard, and then paste the clipboard contents into an Excel worksheet.   
You can also use several methods that do not necessarily require Automation to transfer data to Excel. If you are running a server-side program, this can be a good approach for taking the bulk of data processing away from your clients.

To transfer your data without Automation, you can use the following approaches:

- Transfer your data to a tab-delimited or comma-delimited text file that Excel can later parse into cells on a worksheet.   
- Transfer your data to a worksheet by using ADO.NET.
- Transfer XML data to Excel (version 2002 and 2003) to provide data that is formatted and arranged into rows and columns.   

This article provides a discussion and a code sample for each of these techniques. The "Create the Complete Sample Visual C# 2005 or Visual C# .NET Project" section, later in this article, demonstrates how to create a Visual C# .NET program that executes each technique.

## Techniques

### Use Automation to Transfer Data Cell by Cell

With Automation, you can transfer data to a worksheet one cell at a time: 

```c
// Start a new workbook in Excel.
m_objExcel = new Excel.Application();
m_objBooks = (Excel.Workbooks)m_objExcel.Workbooks;
m_objBook = (Excel._Workbook)(m_objBooks.Add(m_objOpt));

// Add data to cells in the first worksheet in the new workbook.
m_objSheets = (Excel.Sheets)m_objBook.Worksheets;
m_objSheet = (Excel._Worksheet)(m_objSheets.get_Item(1));
m_objRange = m_objSheet.get_Range("A1", m_objOpt);
m_objRange.Value = "Last Name";
m_objRange = m_objSheet.get_Range("B1", m_objOpt);
m_objRange.Value = "First Name";
m_objRange = m_objSheet.get_Range("A2", m_objOpt);
m_objRange.Value = "Doe";
m_objRange = m_objSheet.get_Range("B2", m_objOpt);
m_objRange.Value = "John";

// Apply bold to cells A1:B1.
m_objRange = m_objSheet.get_Range("A1", "B1");
m_objFont = m_objRange.Font;
m_objFont.Bold=true;

// Save the Workbook and quit Excel.
m_objBook.SaveAs(m_strSampleFolder + "Book1.xls", m_objOpt, m_objOpt, 
m_objOpt, m_objOpt, m_objOpt, Excel.XlSaveAsAccessMode.xlNoChange, 
m_objOpt, m_objOpt, m_objOpt, m_objOpt);
m_objBook.Close(false, m_objOpt, m_objOpt);
m_objExcel.Quit();
```

Transferring data cell by cell is an acceptable approach if you have a small quantity of data. You have the flexibility to put data anywhere in the workbook and you can format the cells conditionally at run-time. However, it is not a good idea to use this approach if you have a large quantity of data to transfer to an Excel workbook. Each Range object that you acquire at run-time results in an interface request that means data transfers more slowly. Additionally, Microsoft Windows 95, Microsoft Windows 98, and Microsoft Windows Millennium Edition (Me) have a 64 kilobyte (KB) limitation on interface requests. If you have more than 64 KB of interface requests, the Automation server (Excel) may stop responding, or you may receive error messages that indicate low memory.

Again, transferring data cell by cell is acceptable only for small quantities of data. If you must transfer large data sets to Excel, consider using one of the other approaches that are discussed in this article to transfer data in bulk.

For additional information, and for an example of Automating Excel with Visual C# .NET, click the article number below to view the article in the Microsoft Knowledge Base:

[302084](https://support.microsoft.com/help/302084) HOWTO: Automate Microsoft Excel from Microsoft Visual C# .NET

### Use Automation to Transfer an Array of Data to a Range on a Worksheet

You can transfer an array of data to a range of multiple cells at one time:

```c
// Start a new workbook in Excel.
m_objExcel = new Excel.Application();
m_objBooks = (Excel.Workbooks)m_objExcel.Workbooks;
m_objBook = (Excel._Workbook)(m_objBooks.Add(m_objOpt));
m_objSheets = (Excel.Sheets)m_objBook.Worksheets;
m_objSheet = (Excel._Worksheet)(m_objSheets.get_Item(1));

// Create an array for the headers and add it to cells A1:C1.
object[] objHeaders = {"Order ID", "Amount", "Tax"};
m_objRange = m_objSheet.get_Range("A1", "C1");
m_objRange.Value = objHeaders;
m_objFont = m_objRange.Font;
m_objFont.Bold=true;

// Create an array with 3 columns and 100 rows and add it to
// the worksheet starting at cell A2.
object[,] objData = new Object[100,3];
Random rdm = new Random((int)DateTime.Now.Ticks);
double nOrderAmt, nTax;
for(int r=0;r<100;r++)
{
objData[r,0] = "ORD" + r.ToString("0000");
nOrderAmt = rdm.Next(1000);
objData[r,1] = nOrderAmt.ToString("c");
nTax = nOrderAmt*0.07;
objData[r,2] = nTax.ToString("c");
}
m_objRange = m_objSheet.get_Range("A2", m_objOpt);
m_objRange = m_objRange.get_Resize(100,3);
m_objRange.Value = objData;

// Save the Workbook and quit Excel.
m_objBook.SaveAs(m_strSampleFolder + "Book2.xls", m_objOpt, m_objOpt, 
m_objOpt, m_objOpt, m_objOpt, Excel.XlSaveAsAccessMode.xlNoChange, 
m_objOpt, m_objOpt, m_objOpt, m_objOpt);
m_objBook.Close(false, m_objOpt, m_objOpt);
m_objExcel.Quit();
```

If you transfer your data by using an array instead of cell by cell, you can realize an enormous performance gain with a large quantity of data. Consider the following lines from the aforementioned code that transfer data to 300 cells in the worksheet:

```c
objRange = objSheet.get_Range("A2", m_objOpt);
objRange = objRange.get_Resize(100,3);
objRange.Value = objData;
```

This code represents two interface requests: one for the Range object that the Range method returns, and another for the Range object that the Resize method returns. In contrast, transferring the data cell by cell requires requests for 300 interfaces to Range objects. Whenever possible, you can benefit from transferring your data in bulk and reducing the number of interface requests you make.

For additional information about using arrays to get and set values in ranges with Excel Automation, click the article number below to view the article in the Microsoft Knowledge Base:

[302096 ](https://support.microsoft.com/help/302096) HOWTO: Automate Excel With Visual C# .NET To Fill or Obtain Data In a Range Using Arrays

### Use Automation to Transfer an ADO Recordset to a Worksheet Range

The object models for Excel 2000, Excel 2002 and Excel 2003 provide the CopyFromRecordset method for transferring an ADO recordset to a range on a worksheet. The following code illustrates how to automate Excel to transfer the contents of the Orders table in the Northwind sample database by using the CopyFromRecordset method:

```c
// Create a Recordset from all the records in the Orders table.
ADODB.Connection objConn = new ADODB.Connection();
ADODB._Recordset objRS = null;
objConn.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" +
m_strNorthwind + ";", "", "", 0);
objConn.CursorLocation = ADODB.CursorLocationEnum.adUseClient;
object objRecAff;
objRS = (ADODB._Recordset)objConn.Execute("Orders", out objRecAff, 
(int)ADODB.CommandTypeEnum.adCmdTable);

// Start a new workbook in Excel.
m_objExcel = new Excel.Application();
m_objBooks = (Excel.Workbooks)m_objExcel.Workbooks;
m_objBook = (Excel._Workbook)(m_objBooks.Add(m_objOpt));
m_objSheets = (Excel.Sheets)m_objBook.Worksheets;
m_objSheet = (Excel._Worksheet)(m_objSheets.get_Item(1));

// Get the Fields collection from the recordset and determine
// the number of fields (or columns).
System.Collections.IEnumerator objFields = objRS.Fields.GetEnumerator();
int nFields = objRS.Fields.Count;

// Create an array for the headers and add it to the
// worksheet starting at cell A1.
object[] objHeaders = new object[nFields];
ADODB.Field objField = null;
for(int n=0;n<nFields;n++)
{
objFields.MoveNext();
objField = (ADODB.Field)objFields.Current;
objHeaders[n] = objField.Name;
}
m_objRange = m_objSheet.get_Range("A1", m_objOpt);
m_objRange = m_objRange.get_Resize(1, nFields);
m_objRange.Value = objHeaders;
m_objFont = m_objRange.Font;
m_objFont.Bold=true;

// Transfer the recordset to the worksheet starting at cell A2.
m_objRange = m_objSheet.get_Range("A2", m_objOpt);
m_objRange.CopyFromRecordset(objRS, m_objOpt, m_objOpt);

// Save the Workbook and quit Excel.
m_objBook.SaveAs(m_strSampleFolder + "Book3.xls", m_objOpt, m_objOpt, 
m_objOpt, m_objOpt, m_objOpt, Excel.XlSaveAsAccessMode.xlNoChange, 
m_objOpt, m_objOpt, m_objOpt, m_objOpt);
m_objBook.Close(false, m_objOpt, m_objOpt);
m_objExcel.Quit();

// Close the recordset and connection.
objRS.Close();
objConn.Close();
```

> [!NOTE]
> CopyFromRecordset works only with ADO Recordset objects. You cannot use the DataSet that you create by using ADO.NET with the CopyFromRecordset method. Several examples in the sections that follow demonstrate how to transfer data to Excel with ADO.NET.

### Use Automation to Create a QueryTable Object on a Worksheet

A QueryTable object represents a table that is built from data that is returned from an external data source. When you automate Excel, you can create a QueryTable by providing a connection string to an OLE DB or an ODBC data source and a SQL string. Excel generates the recordset and inserts the recordset into the worksheet at the location that you specify. QueryTable objects offer the following advantages over the CopyFromRecordset method: 

- Excel handles the creation of the recordset and its placement on the worksheet.   
- You can save the query with the QueryTable object and refresh it later to obtain an updated recordset.   
- When a new QueryTable is added to your worksheet, you can specify that data that already exists in cells on the worksheet be shifted to handle the new data (for more information, see the RefreshStyle property).   

The following code demonstrates how to automate Excel 2000, Excel 2002, or Excel 2003 to create a new QueryTable in an Excel worksheet by using data from the Northwind sample database: 

```c
// Start a new workbook in Excel.
m_objExcel = new Excel.Application();
m_objBooks = (Excel.Workbooks)m_objExcel.Workbooks;
m_objBook = (Excel._Workbook)(m_objBooks.Add(m_objOpt));

// Create a QueryTable that starts at cell A1.
m_objSheets = (Excel.Sheets)m_objBook.Worksheets;
m_objSheet = (Excel._Worksheet)(m_objSheets.get_Item(1));
m_objRange = m_objSheet.get_Range("A1", m_objOpt);
m_objQryTables = m_objSheet.QueryTables;
m_objQryTable = (Excel._QueryTable)m_objQryTables.Add(
"OLEDB;Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" +
m_strNorthwind + ";", m_objRange, "Select * From Orders");
m_objQryTable.RefreshStyle = Excel.XlCellInsertionMode.xlInsertEntireRows;
m_objQryTable.Refresh(false);

// Save the workbook and quit Excel.
m_objBook.SaveAs(m_strSampleFolder + "Book4.xls", m_objOpt, m_objOpt, 
m_objOpt, m_objOpt, m_objOpt, Excel.XlSaveAsAccessMode.xlNoChange, m_objOpt, m_objOpt,
m_objOpt, m_objOpt);
m_objBook.Close(false, m_objOpt, m_objOpt);
m_objExcel.Quit();
```

### Use the Windows Clipboard

You can use the Windows Clipboard to transfer data to a worksheet. To paste data into multiple cells on a worksheet, you can copy a string in which columns are delimited by TAB characters, and rows are delimited by carriage returns. The following code illustrates how Visual C# .NET can use the Windows Clipboard to transfer data to Excel:

```c
// Copy a string to the Windows clipboard.
string sData = "FirstName\tLastName\tBirthdate\r\n"  +
"Bill\tBrown\t2/5/85\r\n"  +
"Joe\tThomas\t1/1/91";
System.Windows.Forms.Clipboard.SetDataObject(sData);

// Start a new workbook in Excel.
m_objExcel = new Excel.Application();
m_objBooks = (Excel.Workbooks)m_objExcel.Workbooks;
m_objBook = (Excel._Workbook)(m_objBooks.Add(m_objOpt));

// Paste the data starting at cell A1.
m_objSheets = (Excel.Sheets)m_objBook.Worksheets;
m_objSheet = (Excel._Worksheet)(m_objSheets.get_Item(1));
m_objRange = m_objSheet.get_Range("A1", m_objOpt);
m_objSheet.Paste(m_objRange, false);

// Save the workbook and quit Excel.
m_objBook.SaveAs(m_strSampleFolder + "Book5.xls", m_objOpt, m_objOpt, 
m_objOpt, m_objOpt, m_objOpt, Excel.XlSaveAsAccessMode.xlNoChange, m_objOpt, m_objOpt,
m_objOpt, m_objOpt);
m_objBook.Close(false, m_objOpt, m_objOpt);
m_objExcel.Quit();

```

### Create a Delimited Text File that Excel Can Parse into Rows and Columns

Excel can open tab- or comma-delimited files and correctly parse the data into cells. You can use this feature when you want to transfer a large quantity of data to a worksheet while using little, if any, Automation. This may be a good approach for a client-server program because the text file can be generated server-side. You can then open the text file at the client, using Automation where it is appropriate.

The following code illustrates how to generate a tab-delimited text file from data that is read with ADO.NET:

```c
// Connect to the data source.
System.Data.OleDb.OleDbConnection objConn = new System.Data.OleDb.OleDbConnection( 
"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + m_strNorthwind + ";");
objConn.Open();

// Execute a command to retrieve all records from the Employees table.
System.Data.OleDb.OleDbCommand objCmd = new System.Data.OleDb.OleDbCommand( 
"Select * From Employees", objConn);
System.Data.OleDb.OleDbDataReader objReader;
objReader = objCmd.ExecuteReader();

// Create the FileStream and StreamWriter object to write 
// the recordset contents to file.
System.IO.FileStream fs = new System.IO.FileStream(
m_strSampleFolder + "Book6.txt", System.IO.FileMode.Create);
System.IO.StreamWriter sw = new System.IO.StreamWriter(
fs, System.Text.Encoding.Unicode);

// Write the field names (headers) as the first line in the text file.
sw.WriteLine(objReader.GetName(0) +  "\t" + objReader.GetName(1) +
"\t" + objReader.GetName(2) + "\t" + objReader.GetName(3) +
"\t" + objReader.GetName(4) + "\t" + objReader.GetName(5));

// Write the first six columns in the recordset to a text file as
// tab-delimited.
while(objReader.Read()) 
{
for(int i=0;i<=5;i++)
{
if(!objReader.IsDBNull(i))
{
string s;
s = objReader.GetDataTypeName(i);
if(objReader.GetDataTypeName(i)=="DBTYPE_I4")
{
sw.Write(objReader.GetInt32(i).ToString());
}
else if(objReader.GetDataTypeName(i)=="DBTYPE_DATE")
{
sw.Write(objReader.GetDateTime(i).ToString("d"));
}
else if (objReader.GetDataTypeName(i)=="DBTYPE_WVARCHAR")
{
sw.Write(objReader.GetString(i));
}
}
if(i<5) sw.Write("\t");
}
sw.WriteLine(); 
}
sw.Flush();// Write the buffered data to the filestream.

// Close the FileStream.
fs.Close();

// Close the reader and the connection.
objReader.Close();
objConn.Close(); 

```

The aforementioned code uses no Automation. However, if you want, you can use Automation to open the text file and save the file in the Excel workbook format, similar to this:

```c
// Open the text file in Excel.
m_objExcel = new Excel.Application();
m_objBooks = (Excel.Workbooks)m_objExcel.Workbooks;
m_objBooks.OpenText(m_strSampleFolder + "Book6.txt", Excel.XlPlatform.xlWindows, 1, 
Excel.XlTextParsingType.xlDelimited, Excel.XlTextQualifier.xlTextQualifierDoubleQuote,
false, true, false, false, false, false, m_objOpt, m_objOpt, 
m_objOpt, m_objOpt, m_objOpt);

m_objBook = m_objExcel.ActiveWorkbook;

// Save the text file in the typical workbook format and quit Excel.
m_objBook.SaveAs(m_strSampleFolder + "Book6.xls", Excel.XlFileFormat.xlWorkbookNormal, 
m_objOpt, m_objOpt, m_objOpt, m_objOpt, Excel.XlSaveAsAccessMode.xlNoChange, m_objOpt, m_objOpt,
m_objOpt, m_objOpt);
m_objBook.Close(false, m_objOpt, m_objOpt);
m_objExcel.Quit();
```

### Transfer Data to a Worksheet by Using ADO.NET

You can use the Microsoft Jet OLE DB provider to add records to a table in an existing Excel workbook. A table in Excel is merely a range of cells; the range may have a defined name. Typically, the first row of the range contains the headers (or field names), and all later rows in the range contain the records.

The following code adds two new records to a table in Book7.xls. The table in this case is Sheet1:

```c
// Establish a connection to the data source.
System.Data.OleDb.OleDbConnection objConn = new System.Data.OleDb.OleDbConnection(
"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + m_strSampleFolder +
"Book7.xls;Extended Properties=Excel 8.0;");
objConn.Open();

// Add two records to the table named 'MyTable'.
System.Data.OleDb.OleDbCommand objCmd = new System.Data.OleDb.OleDbCommand();
objCmd.Connection = objConn;
objCmd.CommandText = "Insert into MyTable (FirstName, LastName)" +
" values ('Bill', 'Brown')";
objCmd.ExecuteNonQuery();
objCmd.CommandText = "Insert into MyTable (FirstName, LastName)" +
" values ('Joe', 'Thomas')";
objCmd.ExecuteNonQuery();

// Close the connection.
objConn.Close();
```

When you add records with ADO.NET as shown in this example, the formatting in the workbook is maintained. Each record that is added to a row borrows the format from the row before it. 

For additional information about using ADO.NET, click the article numbers below to view the articles in the Microsoft Knowledge Base:

[306636](https://support.microsoft.com/help/306636) HOW TO: Connect to a Database and Run a Command by Using ADO.NET and Visual C# .NET

[314145](https://support.microsoft.com/help/314145) HOW TO: Populate a DataSet Object from a Database by Using Visual C# .NET 

[307587](https://support.microsoft.com/help/307587) HOW TO: Update a Database from a DataSet Object by Using Visual C# .NET

For additional information about using the Jet OLEDB provider with Excel data sources, click the article numbers below to view the articles in the Microsoft Knowledge Base:

[278973](https://support.microsoft.com/help/278973) SAMPLE: ExcelADO Demonstrates How to Use ADO to Read and Write Data in Excel Workbooks

[257819](https://support.microsoft.com/help/257819) HOWTO: Use ADO with Excel Data from Visual Basic or VBA

### Transfer XML Data (Excel 2002 and Excel 2003)

Excel 2002 and 2003 can open any XML file that is well-formed. You can open XML files directly by using the Open command on the File menu, or programmatically by using either the Open or OpenXML methods of the Workbooks collection. If you create XML files for use in Excel, you can also create style sheets to format the data.

## Create the Complete Sample Visual C# .NET Project

1. Create a new folder named C:\ExcelData. The sample program will store Excel workbooks in this folder.   
2. Create a new workbook for the sample to write to:
   1. Start a new workbook in Excel.   
   2. On Sheet1 of the new workbook, type FirstName in cell A1 and LastName in cell B1.   
   3. Select A1:B1.   
   4. On the Insert menu, point to Name, and then click Define. Type the name MyTable and then click OK.   
   5. Save the workbook as C:\Exceldata\Book7.xls.   
   6. Quit Excel.   
   
3. Start Microsoft Visual Studio 2005 or Microsoft Visual Studio .NET. On the File menu, point to New, and then click Project. Under Visual C# Projects or **Visual C#**, select Windows Application. By default, Form1 is created.   
4. Add a reference to the Excel object library and the ADODB primary interop assembly. To do this, follow these steps:
   1. On the Project menu, click Add Reference.   
   2. On the NET tab, locate ADODB, and then click Select.

    Note In Visual Studio 2005, you do not have to click **Select**.   
   3. On the COM tab, locate Microsoft Excel 10.0 Object Library or Microsoft Excel 11.0 Object Library, and then click Select.

    Note In Visual Studio 2005, you do not have to click **Select**.

    Note If you are using Microsoft Excel 2002 and you have not already done so, Microsoft recommends that you download and then install the Microsoft Office XP Primary Interop Assemblies (PIAs). 

4. In the Add References dialog box, click OK to accept your selections.   
   
5. Add a Combo Box control and a Button control to Form1.   
6. Add event handlers for the Form Load event and the 
 Click events of the Button control: 
   1. In design view for Form1.cs, double-click Form1. 

    The handler for the Form's Load event is created and appears in Form1.cs.   
   2. On the View menu, click Designer to switch to design view.   
   3. Double-click Button1. 

    The handler for the button's Click event is created and appears in Form1.cs.   
   
7. In Form1.cs, replace the following code:

    ```cs
    private void Form1_Load(object sender, System.EventArgs e)
    {
    
    }
    
    private void button1_Click(object sender, System.EventArgs e)
    {
    
    }
    
    ```
    with:

    ```cs
            // Excel object references.
            private Excel.Application m_objExcel =  null;
            private Excel.Workbooks m_objBooks = null;
            private Excel._Workbook m_objBook = null;
            private Excel.Sheets m_objSheets = null;
            private Excel._Worksheet m_objSheet = null;
            private Excel.Range m_objRange =  null;
            private Excel.Font m_objFont = null;
            private Excel.QueryTables m_objQryTables = null;
            private Excel._QueryTable m_objQryTable = null;
    
    // Frequenty-used variable for optional arguments.
            private object m_objOpt = System.Reflection.Missing.Value;
    
    // Paths used by the sample code for accessing and storing data.
            private object m_strSampleFolder = "C:\\ExcelData\\";
            private string m_strNorthwind = "C:\\Program Files\\Microsoft Office\\Office10\\Samples\\Northwind.mdb";
    
    private void Form1_Load(object sender, System.EventArgs e)
            {
                comboBox1.DropDownStyle = ComboBoxStyle.DropDownList;
    
    comboBox1.Items.AddRange(new object[]{
                                                         "Use Automation to Transfer Data Cell by Cell ", 
                                                         "Use Automation to Transfer an Array of Data to a Range on a Worksheet ", 
                                                         "Use Automation to Transfer an ADO Recordset to a Worksheet Range ", 
                                                         "Use Automation to Create a QueryTable on a Worksheet", 
                                                         "Use the Clipboard", 
                                                         "Create a Delimited Text File that Excel Can Parse into Rows and Columns", 
                                                         "Transfer Data to a Worksheet Using ADO.NET "});
                comboBox1.SelectedIndex = 0;
                button1.Text = "Go!";
            }
    
    private void button1_Click(object sender, System.EventArgs e)
            {
                switch (comboBox1.SelectedIndex)
                {
                    case 0 : Automation_CellByCell(); break;
                    case 1 : Automation_UseArray(); break;
                    case 2 : Automation_ADORecordset(); break;
                    case 3 : Automation_QueryTable(); break;
                    case 4 : Use_Clipboard(); break;
                    case 5 : Create_TextFile(); break;
                    case 6 : Use_ADONET(); break;
                }
    
    //Clean-up
                m_objFont = null;
                m_objRange = null;
                m_objSheet = null;
                m_objSheets = null;
                m_objBooks = null;
                m_objBook = null;
                m_objExcel = null;
                GC.Collect();
    
    }
    
    private void Automation_CellByCell()
            {
                // Start a new workbook in Excel.
                m_objExcel = new Excel.Application();
                m_objBooks = (Excel.Workbooks)m_objExcel.Workbooks;
                m_objBook = (Excel._Workbook)(m_objBooks.Add(m_objOpt));
    
    // Add data to cells of the first worksheet in the new workbook.
                m_objSheets = (Excel.Sheets)m_objBook.Worksheets;
                m_objSheet = (Excel._Worksheet)(m_objSheets.get_Item(1));
                m_objRange = m_objSheet.get_Range("A1", m_objOpt);
                m_objRange.set_Value(m_objOpt,"Last Name");
                m_objRange = m_objSheet.get_Range("B1", m_objOpt);
                m_objRange.set_Value(m_objOpt,"First Name");
                m_objRange = m_objSheet.get_Range("A2", m_objOpt);
                m_objRange.set_Value(m_objOpt,"Doe");
                m_objRange = m_objSheet.get_Range("B2", m_objOpt);
                m_objRange.set_Value(m_objOpt,"John");
    
    // Apply bold to cells A1:B1.
                m_objRange = m_objSheet.get_Range("A1", "B1");
                m_objFont = m_objRange.Font;
                m_objFont.Bold=true;
    
    // Save the workbook and quit Excel.
                m_objBook.SaveAs(m_strSampleFolder + "Book1.xls", m_objOpt, m_objOpt, 
                    m_objOpt, m_objOpt, m_objOpt, Excel.XlSaveAsAccessMode.xlNoChange, 
                    m_objOpt, m_objOpt, m_objOpt, m_objOpt, m_objOpt);
                m_objBook.Close(false, m_objOpt, m_objOpt);
                m_objExcel.Quit();
    
    }
    
    private void Automation_UseArray()
            {
                // Start a new workbook in Excel.
                m_objExcel = new Excel.Application();
                m_objBooks = (Excel.Workbooks)m_objExcel.Workbooks;
                m_objBook = (Excel._Workbook)(m_objBooks.Add(m_objOpt));
                m_objSheets = (Excel.Sheets)m_objBook.Worksheets;
                m_objSheet = (Excel._Worksheet)(m_objSheets.get_Item(1));
    
    // Create an array for the headers and add it to cells A1:C1.
                object[] objHeaders = {"Order ID", "Amount", "Tax"};
                m_objRange = m_objSheet.get_Range("A1", "C1");
                m_objRange.set_Value(m_objOpt,objHeaders);
                m_objFont = m_objRange.Font;
                m_objFont.Bold=true;
    
    // Create an array with 3 columns and 100 rows and add it to
                // the worksheet starting at cell A2.
                object[,] objData = new Object[100,3];
                Random rdm = new Random((int)DateTime.Now.Ticks);
                double nOrderAmt, nTax;
                for(int r=0;r<100;r++)
                {
                    objData[r,0] = "ORD" + r.ToString("0000");
                    nOrderAmt = rdm.Next(1000);
                    objData[r,1] = nOrderAmt.ToString("c");
                    nTax = nOrderAmt*0.07;
                    objData[r,2] = nTax.ToString("c");
                }
                m_objRange = m_objSheet.get_Range("A2", m_objOpt);
                m_objRange = m_objRange.get_Resize(100,3);
                m_objRange.set_Value(m_objOpt,"objData");
    
    // Save the workbook and quit Excel.
                m_objBook.SaveAs(m_strSampleFolder + "Book2.xls", m_objOpt, m_objOpt, 
                    m_objOpt, m_objOpt, m_objOpt, Excel.XlSaveAsAccessMode.xlNoChange, 
                    m_objOpt, m_objOpt, m_objOpt, m_objOpt, m_objOpt);
                m_objBook.Close(false, m_objOpt, m_objOpt);
                m_objExcel.Quit();
    
    }
    
    private void Automation_ADORecordset()
            {
                // Create a Recordset from all the records in the Orders table.
                ADODB.Connection objConn = new ADODB.Connection();
                ADODB._Recordset objRS = null;
                objConn.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" +
                    m_strNorthwind + ";", "", "", 0);
                objConn.CursorLocation = ADODB.CursorLocationEnum.adUseClient;
                object objRecAff;
                objRS = (ADODB._Recordset)objConn.Execute("Orders", out objRecAff, 
                    (int)ADODB.CommandTypeEnum.adCmdTable);
    
    // Start a new workbook in Excel.
                m_objExcel = new Excel.Application();
                m_objBooks = (Excel.Workbooks)m_objExcel.Workbooks;
                m_objBook = (Excel._Workbook)(m_objBooks.Add(m_objOpt));
                m_objSheets = (Excel.Sheets)m_objBook.Worksheets;
                m_objSheet = (Excel._Worksheet)(m_objSheets.get_Item(1));
    
    // Get the Fields collection from the recordset and determine
                // the number of fields (or columns).
                System.Collections.IEnumerator objFields = objRS.Fields.GetEnumerator();
                int nFields = objRS.Fields.Count;
    
    // Create an array for the headers and add it to the
                // worksheet starting at cell A1.
                object[] objHeaders = new object[nFields];
                ADODB.Field objField = null;
                for(int n=0;n<nFields;n++)
                {
                    objFields.MoveNext();
                    objField = (ADODB.Field)objFields.Current;
                    objHeaders[n] = objField.Name;
                }
                m_objRange = m_objSheet.get_Range("A1", m_objOpt);
                m_objRange = m_objRange.get_Resize(1, nFields);
                m_objRange.set_Value(m_objOpt,objHeaders);
                m_objFont = m_objRange.Font;
                m_objFont.Bold=true;
    
    // Transfer the recordset to the worksheet starting at cell A2.
                m_objRange = m_objSheet.get_Range("A2", m_objOpt);
                m_objRange.CopyFromRecordset(objRS, m_objOpt, m_objOpt);
    
    // Save the workbook and quit Excel.
                m_objBook.SaveAs(m_strSampleFolder + "Book3.xls", m_objOpt, m_objOpt, 
                    m_objOpt, m_objOpt, m_objOpt, Excel.XlSaveAsAccessMode.xlNoChange, 
                    m_objOpt, m_objOpt, m_objOpt, m_objOpt, m_objOpt);
                m_objBook.Close(false, m_objOpt, m_objOpt);
                m_objExcel.Quit();
    
    //Close the recordset and connection
                objRS.Close();
                objConn.Close();
    
    }
    
    private void Automation_QueryTable()
            {
                // Start a new workbook in Excel.
                m_objExcel = new Excel.Application();
                m_objBooks = (Excel.Workbooks)m_objExcel.Workbooks;
                m_objBook = (Excel._Workbook)(m_objBooks.Add(m_objOpt));
    
    // Create a QueryTable that starts at cell A1.
                m_objSheets = (Excel.Sheets)m_objBook.Worksheets;
                m_objSheet = (Excel._Worksheet)(m_objSheets.get_Item(1));
                m_objRange = m_objSheet.get_Range("A1", m_objOpt);
                m_objQryTables = m_objSheet.QueryTables;
                m_objQryTable = (Excel._QueryTable)m_objQryTables.Add(
                    "OLEDB;Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" +
                    m_strNorthwind + ";", m_objRange, "Select * From Orders");
                m_objQryTable.RefreshStyle = Excel.XlCellInsertionMode.xlInsertEntireRows;
                m_objQryTable.Refresh(false);
    
    // Save the workbook and quit Excel.
                m_objBook.SaveAs(m_strSampleFolder + "Book4.xls", m_objOpt, m_objOpt, 
                    m_objOpt, m_objOpt, m_objOpt, Excel.XlSaveAsAccessMode.xlNoChange, m_objOpt, m_objOpt,
                    m_objOpt, m_objOpt, m_objOpt);
                m_objBook.Close(false, m_objOpt, m_objOpt);
                m_objExcel.Quit();
    
    }
    
    private void Use_Clipboard()
            {
                // Copy a string to the clipboard.
                string sData = "FirstName\tLastName\tBirthdate\r\n"  +
                    "Bill\tBrown\t2/5/85\r\n"  +
                    "Joe\tThomas\t1/1/91";
                System.Windows.Forms.Clipboard.SetDataObject(sData);
    
    // Start a new workbook in Excel.
                m_objExcel = new Excel.Application();
                m_objBooks = (Excel.Workbooks)m_objExcel.Workbooks;
                m_objBook = (Excel._Workbook)(m_objBooks.Add(m_objOpt));
    
    // Paste the data starting at cell A1.
                m_objSheets = (Excel.Sheets)m_objBook.Worksheets;
                m_objSheet = (Excel._Worksheet)(m_objSheets.get_Item(1));
                m_objRange = m_objSheet.get_Range("A1", m_objOpt);
                m_objSheet.Paste(m_objRange, false);
    
    // Save the workbook and quit Excel.
                m_objBook.SaveAs(m_strSampleFolder + "Book5.xls", m_objOpt, m_objOpt, 
                    m_objOpt, m_objOpt, m_objOpt, Excel.XlSaveAsAccessMode.xlNoChange, m_objOpt, m_objOpt,
                    m_objOpt, m_objOpt, m_objOpt);
                m_objBook.Close(false, m_objOpt, m_objOpt);
                m_objExcel.Quit();
    
    }
    
    private void Create_TextFile()
            {
                // Connect to the data source.
                System.Data.OleDb.OleDbConnection objConn = new System.Data.OleDb.OleDbConnection( 
                    "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + m_strNorthwind + ";");
                objConn.Open();
    
    // Execute a command to retrieve all records from the Employees  table.
                System.Data.OleDb.OleDbCommand objCmd = new System.Data.OleDb.OleDbCommand( 
                    "Select * From Employees", objConn);
                System.Data.OleDb.OleDbDataReader objReader;
                objReader = objCmd.ExecuteReader();
    
    // Create the FileStream and StreamWriter object to write 
                // the recordset contents to file.
                System.IO.FileStream fs = new System.IO.FileStream(
                    m_strSampleFolder + "Book6.txt", System.IO.FileMode.Create);
                System.IO.StreamWriter sw = new System.IO.StreamWriter(
                    fs, System.Text.Encoding.Unicode);
    
    // Write the field names (headers) as the first line in the text file.
                sw.WriteLine(objReader.GetName(0) +  "\t" + objReader.GetName(1) +
                    "\t" + objReader.GetName(2) + "\t" + objReader.GetName(3) +
                    "\t" + objReader.GetName(4) + "\t" + objReader.GetName(5));
    
    // Write the first six columns in the recordset to a text file as
                // tab-delimited.
                while(objReader.Read()) 
                {
                    for(int i=0;i<=5;i++)
                    {
                        if(!objReader.IsDBNull(i))
                        {
                            string s;
                            s = objReader.GetDataTypeName(i);
                            if(objReader.GetDataTypeName(i)=="DBTYPE_I4")
                            {
                                sw.Write(objReader.GetInt32(i).ToString());
                            }
                            else if(objReader.GetDataTypeName(i)=="DBTYPE_DATE")
                            {
                                sw.Write(objReader.GetDateTime(i).ToString("d"));
                            }
                            else if (objReader.GetDataTypeName(i)=="DBTYPE_WVARCHAR")
                            {
                                sw.Write(objReader.GetString(i));
                            }
                        }
                        if(i<5) sw.Write("\t");
                    }
                    sw.WriteLine(); 
                }
                sw.Flush();// Write the buffered data to the FileStream.
    
    // Close the FileStream.
                fs.Close();
    
    // Close the reader and the connection.
                objReader.Close();
                objConn.Close(); 
    
    // ==================================================================
                // Optionally, automate Excel to open the text file and save it in the
                // Excel workbook format.
    
    // Open the text file in Excel.
                m_objExcel = new Excel.Application();
                m_objBooks = (Excel.Workbooks)m_objExcel.Workbooks;
                m_objBooks.OpenText(m_strSampleFolder + "Book6.txt", Excel.XlPlatform.xlWindows, 1, 
                    Excel.XlTextParsingType.xlDelimited, Excel.XlTextQualifier.xlTextQualifierDoubleQuote,
                    false, true, false, false, false, false, m_objOpt, m_objOpt, 
                    m_objOpt, m_objOpt, m_objOpt, m_objOpt, m_objOpt);
    
    m_objBook = m_objExcel.ActiveWorkbook;
    
    // Save the text file in the typical workbook format and quit Excel.
                m_objBook.SaveAs(m_strSampleFolder + "Book6.xls", Excel.XlFileFormat.xlWorkbookNormal, 
                    m_objOpt, m_objOpt, m_objOpt, m_objOpt, Excel.XlSaveAsAccessMode.xlNoChange, m_objOpt, m_objOpt,
                    m_objOpt, m_objOpt, m_objOpt);
                m_objBook.Close(false, m_objOpt, m_objOpt);
                m_objExcel.Quit();
    
    }
    
    private void Use_ADONET()
            {
                // Establish a connection to the data source.
                System.Data.OleDb.OleDbConnection objConn = new System.Data.OleDb.OleDbConnection(
                    "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + m_strSampleFolder +
                    "Book7.xls;Extended Properties=Excel 8.0;");
                objConn.Open();
    
    // Add two records to the table named 'MyTable'.
                System.Data.OleDb.OleDbCommand objCmd = new System.Data.OleDb.OleDbCommand();
                objCmd.Connection = objConn;
                objCmd.CommandText = "Insert into MyTable (FirstName, LastName)" +
                    " values ('Bill', 'Brown')";
    
    objCmd.ExecuteNonQuery();
                objCmd.CommandText = "Insert into MyTable (FirstName, LastName)" +
                    " values ('Joe', 'Thomas')";
                objCmd.ExecuteNonQuery();
    
    // Close the connection.
                objConn.Close(); 
    
    } 
    
    }  // End Class
    }// End namespace
    
    ```
    Note You must change the code in Visual Studio 2005. By default, Visual C# adds one form to the project when you create a Windows Forms project. The form is named Form1. The two files that represent the form are named Form1.cs and Form1.designer.cs. You write the code in Form1.cs. The Form1.designer.cs file is where the Windows Forms Designer writes the code that implements all the actions that you performed by dragging and dropping controls from the Toolbox.

    For more information about the Windows Forms Designer in Visual C# 2005, visit the following Microsoft Developer Network (MSDN) Web site:

    [Creating a Project (Visual C#)](https://msdn.microsoft.com/library/ms173077.aspx)Note If you did not install Office to the default folder (C:\Program Files\Microsoft Office), modify the m_strNorthwind constant in the code sample to match your installation path for Northwind.mdb.   
8. Add the following to the Using directives in Form1.cs:

    ```cs
    using System.Reflection;
    using System.Runtime.InteropServices;
    using Excel = Microsoft.Office.Interop.Excel;
    ```

9. Press F5 to build and run the sample.   

## References

For more information, visit the following Microsoft Web site:

[Microsoft Office Development with Visual Studio](https://msdn.microsoft.com/library/aa188489.aspx)