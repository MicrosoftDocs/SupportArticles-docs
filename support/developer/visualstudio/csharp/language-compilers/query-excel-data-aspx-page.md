---
title: Query excel data with an ASP.NET page
description: Describes how to display data from an Excel worksheet through an ASP.NET (.aspx) page by using Visual C# .NET. Includes an ASP.NET example.
ms.date: 04/13/2020
ms.reviewer: michmo
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Query and display excel data by using ASP.NET, ADO.NET, and Visual C# .NET  

This article demonstrates how to query and display data from an Excel worksheet through an ASP.NET (.aspx) page by using Visual C# .NET.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 306572

## Create a sample Excel worksheet

1. Start Microsoft Excel, and then create a new worksheet.
2. Add the following information to the new worksheet to create an Excel database:

    |Row number|A|B|
    |---|---|---|
    |1|FirstName|LastName|
    |2|Scott|Bishop|
    |3|Katie|Jordan|

    > [!NOTE]
    > Although the data starts with cell A1 in this example, you can add this data to any adjacent cells within the worksheet.

3. Highlight the rows and columns where the data is.
4. On the **Insert** menu, point to **Name**, and then click **Define**.
5. In the **Names in workbook** text box, type _myRange1_, and then click **OK**.
6. On the **File** menu, click **Save**. In the **Save in** list, select the Web server root (which is typically `C:\InetPub\Wwwroot\`). In the **File name** text box, type _ExcelData.xls_. Click **OK**.
7. On the **File** menu, click **Exit**.

## Create an ASP.NET sample by using Visual C# .NET

This code sample demonstrates how to query and display information in an Excel worksheet. The following code uses the worksheet that you created in the previous section.

1. Open Microsoft Visual Studio .NET. The Visual Studio .NET Integrated Development Environment (IDE) is displayed.
2. On the **File** menu, point to **New**, and then click **Project**.
3. In the **New Project** dialog box, under **Project Types**, click **Visual C# Projects**. Under **Templates**, click **ASP.NET Web Application**.
4. In the **New Project** dialog box, locate the **Name** and **Location** text boxes.

    > [!NOTE]
    >
    > - The **Name** text box is not available (it appears grayed out or dimmed). The **Location** text box contains the text (or similar) `http://localhost/WebApplication1`.
    > - Replace the text in the **Location** text box with `http://localhost/ExcelCSTest`, and then click **OK**. A new project is created, which includes a Web Form named _WebForm1.aspx_.

5. In the Visual Studio .NET IDE, locate the **Solution Explorer** window. If you can't find it, click **Solution Explorer** on the **View** menu.
6. In **Solution Explorer**, right-click _WebForm1.aspx_, and then click **View Designer** to display the designer for the appearance of the page. The designer allows you to add controls and manipulate the appearance of the page.
7. Locate the toolbox. Depending on your IDE Option settings, the toolbox can appear as a window or a button (which often appears on the left side of the IDE). If you can't find the toolbox, click **Toolbox** on the **View** menu.

    If the toolbox appears as a button, move the pointer over the button so that the contents of the toolbox are displayed.

8. When the designer view of a Web Form is active, the toolbox is divided into sections, including the **Web Forms**, **Components**, **HTML**, and other sections. Click the **Web Forms** section.
9. In the **Web Forms** section of the toolbox, click **DataGrid**, and then drag it onto the designer for _WebForm1_.
10. Right-click _WebForm1.aspx_, and then click **View Code** to display the code-behind page source.
11. Add the following statements to the top of the code-behind page, above the namespace section:

    ```csharp
    using System.Data.OleDb;
    using System.Data;
    ```

12. Highlight the following code, right-click the code, and then click **Copy**. In _WebForm1.aspx.cs_, paste the code into the `Page_Load` event:

    ```csharp
    // Create connection string variable. Modify the "Data Source"
    // parameter as appropriate for your environment.
    String sConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;" +
    "Data Source=" + Server.MapPath("../ExcelData.xls") + ";" +
    "Extended Properties=Excel 8.0;";

    // Create connection object by using the preceding connection string.
    OleDbConnection objConn = new OleDbConnection(sConnectionString);

    // Open connection with the database.
    objConn.Open();

    // The code to follow uses a SQL SELECT command to display the data from the worksheet.
    // Create new OleDbCommand to return data from worksheet.
    OleDbCommand objCmdSelect =new OleDbCommand("SELECT * FROM myRange1", objConn);

    // Create new OleDbDataAdapter that is used to build a DataSet
    // based on the preceding SQL SELECT statement.
    OleDbDataAdapter objAdapter1 = new OleDbDataAdapter();

    // Pass the Select command to the adapter.
    objAdapter1.SelectCommand = objCmdSelect;

    // Create new DataSet to hold information from the worksheet.
    DataSet objDataset1 = new DataSet();

    // Fill the DataSet with the information from the worksheet.
    objAdapter1.Fill(objDataset1, "XLData");

    // Bind data to DataGrid control.
    DataGrid1.DataSource = objDataset1.Tables[0].DefaultView;
    DataGrid1.DataBind();

    // Clean up objects.
    objConn.Close();
    ```

13. On the **File** menu, click **Save All** to save the project files.
14. On the **Build** menu, click **Build** to build the project. This step prepares the code in the code-behind page so that it can be executed.
15. In Solution Explorer, right-click **WebForm1.aspx**, and then click **View** in Browser to run the code.

## Additional code explanation

The code sample in this article uses the Microsoft Jet OLE DB Provider to access the Excel worksheet. This code uses the following connection string to connect to the worksheet:

```csharp
// Create connection string variable. Modify the "Data Source"
// parameter as appropriate for your environment.
String sConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;" +
"Data Source=" + Server.MapPath("../ExcelData.xls") + ";" +
"Extended Properties=Excel 8.0;";
```

As the comments indicate, you must modify the path information for the specific Excel worksheet. In addition, you must also set the value of the `Extended Properties` parameter to properly connect to the file.

> [!NOTE]
> The connection string uses the `Server.MapPath` function. This function takes a path that is relative to Microsoft Internet Information Services (IIS) to a file and returns a hard disk path to that file. For example, in the [Create sample Excel worksheet](#create-a-sample-excel-worksheet) section, you create _ExcelData.xls_ in the Web root directory, which is typically located at `C:\Inetpub\Wwwroot`. This also creates a subfolder named _ExcelCSTest_ within the _Wwwroot_ folder and a file named _WebForm1_.aspx within the _ExcelCSTest_folder.

In this example, the file path on the hard disk is like `C:\Inetpub\Wwwroot\ExcelCSTest`. _Wwwroot_ contains _ExcelData.xls_, _ExcelCSTest_ contains _WebForm1.aspx_.

The IIS path to the files is like `C:\Web Root\ExcelCSTest`. And _Web Root_ contains _ExcelData.xls_, _ExcelCSTest_ contains _WebForm1.aspx_.

In this case, the relative path from the _WebForm1.aspx_ page to the _ExcelData.xls_ file is _../ExcelData.xls_. The _../_ characters inform IIS to go up one folder level. So the code `Server.MapPath("../ExcelData.xls")` returns the following string:

```console
C:\Inetpub\Wwwroot\ExcelData.xls
```

You aren't required to use `Server.MapPath`. You can also hard code this information to a specific path, or you can use any method to supply the location of the Excel file on the hard disk.

## References

For more information about using ADO.NET, see [How To Populate a DataSet Object from a Database by Using Visual C# .NET](https://support.microsoft.com/help/314145)

> [!NOTE]
> The example companies, organizations, products, domain names, e-mail addresses, logos, people, places, and events depicted herein are fictitious. No association with any real company, organization, product, domain name, email address, logo, person, places, or events is intended or should be inferred.
