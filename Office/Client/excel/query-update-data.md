---
title: How To query and update Excel data using ADO from ASP
description: Describes how to query and update information in an Excel spreadsheet using ActiveX Data Objects (ADO) from an Active Server Pages (ASP) page.
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

# How To Query and Update Excel Data Using ADO From ASP

## Summary

This article demonstrates how to query and update information in an Excel spreadsheet using ActiveX Data Objects (ADO) from an Active Server Pages (ASP) page. The article also describes the limitations that are associated with this type of application.

> [!IMPORTANT]
> Though ASP/ADO applications support multi-user access, an Excel spreadsheet does not. Therefore, this method of querying and updating information does not support multi-user concurrent access.

## More Information

To access the data in your Excel spreadsheet for this sample, use the Microsoft ODBC Driver for Excel. Create a table to access the data by creating a Named Range in your Excel spreadsheet.

### Steps to Create Sample Application

- Create the Excel file ADOtest.xls with the following data in sheet1:

  |column1|column2|column3|
  |------------|------------|------------|
  |rr|this|15|
  |bb|test|20|
  |ee|works|25|

  > [!NOTE]
  > If a column in your Excel spreadsheet contains both text and numbers, the Excel ODBC driver cannot correctly interpret which data type the column should be. Please make sure that all the cells in a column are of the same data type. The following three errors can occur if each cell in a column is not of the same type or you have the types mixed between "text" and "general":
  >
  > 1. Microsoft OLE DB Provider for ODBC Drivers error '80040e21' The request properties can not be supported by this ODBC Driver.
  > 2. Microsoft OLE DB Provider for ODBC Drivers error '80004005' The query is not updateable because it contains no searchable columns to use as a hopeful key.
  > 3. Microsoft OLE DB Provider for ODBC Drivers error '80004005' Query based update failed. The row to update could not be found.

- Create a Named Range, myRange1, in your spreadsheet:

  1. Highlight the row(s) and column(s) area where your data resides.
  2. On the Insert menu, point to Name, and click Define.
  3. Enter the name myRange1 for the Named Range name.
  4. Click OK.
  
  The Named Range myRange1 contains the following data:

  |column1|column2|column3|
  |------------|------------|------------|
  |rr|this|15|
  |bb|test|20|
  |ee|works|25|

  > [!NOTE]
  >
  > - ADO assumes that the first row in an Excel query contains the column headings. Therefore, the Named Range must include the column headings. This is different behavior from DAO.
  > - Column headings cannot be a number. The Excel driver cannot interpret them and, instead, returns a cell reference. For example, a column heading of "F1" would be misinterpreted.

- Create an ODBC System Data Source Name (DSN) pointing to the ADOTest.xls file.

  1. From the Control Panel, open the ODBC Administrator.
  2. On the System DSN tab, click Add.
  3. Select Microsoft Excel Driver (*.xls) and click Finish. If this option does not exist, you need to install the Microsoft ODBC driver for Excel from Excel setup.
  4. Choose ADOExcel for the Data Source Name.  
  5. Make sure the Version is set to the correct version of Excel.
  6. Click "Select Workbook...", browse to the ADOTest.xls file, and click OK.
  7. Click the "Options>>" button and clear the "Read Only" check box.
  8. Click OK and then click OK again.

- Set permissions on the ADOTest.xls file.

If your Active Server Page is accessed anonymously, you need to make sure that the Anonymous Account (IUSR_\<MachineName\>) has at least Read/Write (RW) access to the spreadsheet. If you want to delete information from the spreadsheet, you need to grant the permissions accordingly.

If you are authenticating access to your Active Server Page, you need to ensure that all users accessing your application have the appropriate permissions.

If you do not set the appropriate permissions on the spreadsheet, you get an error message similar to the following:

```asciidoc
Microsoft OLE DB Provider for ODBC Drivers error '80004005'

[Microsoft][ODBC Excel Driver] The Microsoft Jet database engine cannot open the file '(unknown)'. It is already opened exclusively by another user, or you need permission to view its data.
```

1. Create a new ASP page and paste in the following code:

   ```vbscript
      <!-- Begin ASP Source Code -->
      <%@ LANGUAGE="VBSCRIPT" %>
      <%
        Set objConn = Server.CreateObject("ADODB.Connection")
        objConn.Open "ADOExcel"

   Set objRS = Server.CreateObject("ADODB.Recordset")
        objRS.ActiveConnection = objConn
        objRS.CursorType = 3                    'Static cursor.
        objRS.LockType = 2                      'Pessimistic Lock.
        objRS.Source = "Select * from myRange1"
        objRS.Open
   %>
   <br>
   <%
      Response.Write("Original Data")

   'Printing out original spreadsheet headings and values.

   'Note that the first recordset does not have a "value" property
      'just a "name" property.  This will spit out the column headings.

   Response.Write("<TABLE><TR>")
      For X = 0 To objRS.Fields.Count - 1
         Response.Write("<TD>" & objRS.Fields.Item(X).Name & "</TD>")
      Next
      Response.Write("</TR>")
      objRS.MoveFirst

   While Not objRS.EOF
         Response.Write("<TR>")
         For X = 0 To objRS.Fields.Count - 1
            Response.write("<TD>" & objRS.Fields.Item(X).Value)
         Next
         objRS.MoveNext
         Response.Write("</TR>")
      Wend
      Response.Write("</TABLE>")

   'The update is made here

   objRS.MoveFirst
      objRS.Fields(0).Value = "change"
      objRS.Fields(1).Value = "look"
      objRS.Fields(2).Value = "30"
      objRS.Update

   'Printing out spreadsheet headings and values after update.

   Response.Write("<br>Data after the update")
      Response.Write("<TABLE><TR>")
      For X = 0 To objRS.Fields.Count - 1
         Response.Write("<TD>" & objRS.Fields.Item(X).Name & "</TD>")
      Next
      Response.Write("</TR>")
      objRS.MoveFirst

   While Not objRS.EOF
         Response.Write("<TR>")
         For X = 0 To objRS.Fields.Count - 1
            Response.write("<TD>" & objRS.Fields.Item(X).Value)
         Next
         objRS.MoveNext
         Response.Write("</TR>")
      Wend
      Response.Write("</TABLE>")

   'ADO Object clean up.

   objRS.Close
      Set objRS = Nothing

   objConn.Close
      Set objConn = Nothing
   %>
   <!-- End ASP Source Code -->
   ```

2. Save and name your Active Server Page and view it in the browser. You will see the following:

   ```asciidoc
   Original Data:

   |column1|column2|column3|
   |------------|------------|------------|
   |rr|this|30|
   |bb|test|20|
   |tt|works|25|

   Data after the update:

   |column1|column2|column3|
   |------------|------------|------------|
   |change|look|30|
   |bb|test|20|
   |tt|works|25|
   ```

> [!NOTE]
> An update was performed on the first row of your Named Range (after the headings).
