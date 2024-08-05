---
title: DataGrid controls display incorrectly in pages
description: This article provides resolutions for the problem that data grid may not appear when you view an .aspx page that contains a DataGrid control.
ms.date: 04/07/2020
ms.custom: sap:General Development
ms.reviewer: joelrewe, anandh
---
# DataGrid control doesn't display correctly in .aspx page

This article helps you resolve the problem that data grid may not appear when you view an .aspx page that contains a DataGrid control. This article refers to the Microsoft .NET Framework Class Library namespace `System.Data.SqlClient`.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 313156

## Symptoms

When you view an .aspx page that contains a `DataGrid` control, the data grid may not appear. Alternately, only the header of the data grid may appear, but the data grid may not contain any data.

## Cause 1: Data grid doesn't appear

The data grid does not appear at all if:

- You do not set the `DataSource` property of the `DataGrid` control. Or

- You do not call the `DataBind` method of the `DataGrid` control or the `DataBind` method of the `Page` object from your code.

## Cause 2: Data grid header appears but data grid is empty

The data grid header appears, but the data grid does not contain any data if:

- The data source does not contain any data. Or

- You don't fill the dataset that is bound to the `DataGrid` with data at run time.

    > [!NOTE]
    > You must write code to explicitly fill the dataset so that the `DataGrid` is populated with data from the database at run time. You can do this when you use the designer to add the DataAdapter object and to generate a dataset at design time.

This problem occurs because the .aspx page retrieves the details of the header fields from the *DataSetName.xsd* file. The *DataSetName.xsd* file is created for each dataset when you generate a dataset at the design time. This file contains the Extensible Markup Language (XML) representation of the dataset. The .aspx page retrieves the header field details from this file. Therefore, the data grid header appears but the data grid is empty.

## Resolution for the cause 1

1. Set the `DataSource` property of the `DataGrid` to point to the appropriate data source. For example:

    ```vb
    DataGrid1.DataSource = dataSet11.Tables("Authors")
    ```

    ```csharp
    DataGrid1.DataSource = dataSet11.Tables["Authors"] ;
    ```

    > [!NOTE]
    > If you programmatically retrieve the data from the data source, assign the data source to the `DataSource` property of the `DataGrid`.

2. If you use the designer to add a `DataAdapter` to the Web form and to generate a dataset, open the `DataGrid` property page, and then select the appropriate `DataSet` or `DataView` object in the `DataSource` property.

3. Call the `DataBind` method of the `DataGrid` control or the `DataBind` method of the Page object. For example:

    ```vb
    'Use one of the following lines.
    'Page.DataBind()
    DataGrid1.DataBind()
    ```

    ```csharp
    //Use one of the following lines.
    //Page.DataBind();
    DataGrid1.DataBind();
    ```

## Resolution for the cause 2

1. Make sure that your data source contains data and that your query returns data.

2. Use a `DataAdapter` to fill the dataset. For example:

    ```vb
    sqlDataAdapter1.Fill(dataSet11, "Authors")
    ```

    ```csharp
    sqlDataAdapter1.Fill(dataSet11,"Authors");

## Status

This behavior is by design.

## More information

Bind the `DataGrid` Web server control to a data source through the `DataSource` property of the `DataGrid` to correctly render the data grid on the page. After you set the data source, you must also explicitly call the `DataBind` method of the `DataGrid` control or the `DataBind` method of the `Page` object from your code.

## Steps to reproduce the behavior - data grid does not appear

1. Create a new ASP.NET Web Application project in Visual Basic .NET or Visual C# .NET.
2. Drag a `DataGrid` control from the toolbox, and drop the control onto the form.
3. In the designer, double-click the .aspx page to open the code-behind window. Add the following code to the top of the code-behind window to add the required namespace references:

    ```vb
    Imports System.Data
    Imports System.Data.SqlClient
    ```

    ```csharp
    using System.Data.SqlClient;
    ```

4. Replace the code in the `Form_Load` event with the following code:

    > [!NOTE]
    > You must change `uid = <username>` and `pwd = <strong password>` to the correct values before you run this code. Be sure that UID has the appropriate permissions to perform this operation on the database.

    ```vb
    Private Sub Page_Load(ByVal sender As System.Object, _
    ByVal e As System.EventArgs) Handles MyBase.Load
         'Write code to access the database.
         Dim myConnection As New SqlConnection("server=(local);database=pubs;uid=<username>;pwd=<strong password>")
         Dim myDataAdapter As New SqlDataAdapter("select * from authors", myConnection)
         Dim myDataSet As New DataSet()
         myConnection.Open()
         myDataAdapter.Fill(myDataSet)'Uncomment the following line to resolve this problem.
         'DataGrid1.DataSource = myDataSet
         DataGrid1.DataBind()
    End Sub
    ```

    ```csharp
    private void Page_Load(object sender, System.EventArgs e)
    {
        //Write code to access the database.
        SqlConnection myConnection = new SqlConnection("server=(local);database=pubs;uid=<username>;pwd=<strong password>");
        SqlDataAdapter myDataAdapter = new SqlDataAdapter("select * from authors", myConnection);
        DataSet myDataSet = new DataSet();
        myConnection.Open();
        myDataAdapter.Fill(myDataSet);

        //Uncomment the following line to resolve this problem.
        //DataGrid1.DataSource = myDataSet;
        DataGrid1.DataBind();
    }
    ```

5. Modify the connection string as appropriate for your environment.
6. Build the project, and then view the .aspx page in the browser. Notice that data grid does not appear.

## Steps to reproduce the behavior - data grid header appears but data grid is empty

1. Create a new ASP.NET Web Application project in Visual Basic .NET or Visual C# .NET.
2. Drag a `DataGrid` control from the toolbox, and drop the control onto the form.
3. Add a `SqlDataAdapter` control to the Web form. Complete the following steps in the DataAdapter Configuration Wizard to set the connection properties:

    1. Select **New Connection** to create a new connection to your SQL Server database. Select the server, type the logon information, and then select the **Pubs database**.
    2. Under **Query type**, select **SQL Statements**, and then select **Next**.
    3. Type the following SQL statement:

        ```sql
        Select * From Authors
        ```

    4. Select **Finish**.
4. Right-click the **DataAdapter**, and then select **Generate dataset**.
5. Set the `DataSource` property of the `DataGrid` to the dataset that is generated.
6. In the designer, double-click the .aspx page to open the code-behind window. Add the following code to the `Page_Load` event:

    ```vb
    DataGrid1.DataBind()
    ```

    ```csharp
    DataGrid1.DataBind();
    ```

7. Build the project, and then view the .aspx page in the browser.

    > [!NOTE]
    > The header of the data grid appears, but the data grid does not contain any data.

## References

For more information about the `DataGrid` control and for samples that use this control, see [DataGrid Class](/dotnet/api/system.web.ui.webcontrols.datagrid?view=netframework-4.8&preserve-view=true).
