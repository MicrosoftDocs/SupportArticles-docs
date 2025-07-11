---
title: Open SQL database by VB .NET
description: Introduces how to open SQL Server databases by using SQL Server .NET Data Provider together with Visual Basic .NET.
ms.date: 07/07/2025
ms.topic: how-to
ms.custom: sap:Class Library Namespaces

#customer intent: As a developer, I want to open SQL Server databases by using the SQL Server .NET Data Provider together with Visual Basic .NET so that I can integrate SQL Server with my applications. 
---
# Open SQL Server database by using SQL Server .NET Data Provider with Visual Basic .NET

This article provides information about how to open Microsoft SQL Server databases by using SQL Server .NET Data Provider together with Visual Basic .NET. You can use ADO.NET to open a SQL Server database by using the SQL Server .NET Data Provider. ADO.NET gathers all the classes that are required for data handling.

The `System.Data.SqlClient` namespace describes a collection of classes that are used to programmatically access a SQL Server data source. You can access ADO classes through the `System.Data.OleDb` namespace to provide support for OLE DB databases.

In this article, connections are set up both programmatically and by using the Visual Studio .NET Server Explorer. The code samples in this article use the `SqlConnection`, `SqlCommand`, and `SqlDataReader` ADO.NET objects.

_Original product version:_ Visual Basic .NET

_Original KB number:_ 308656

## Prerequisites

- Microsoft SQL Server
- Visual Basic .NET

> [!NOTE]
> SQL Server and Visual Basic .NET must be installed and running on the same computer. Additionally, the user must be able to use Windows Integrated Security to connect to SQL Server.

This article assumes that you're familiar with the following topics:

- ADO.NET concepts
- SQL Server concepts and Transact-SQL (T-SQL) syntax
- The _Northwind_ sample database

## Create Visual Basic .NET Windows application

1. In Visual Studio .NET, create a Visual Basic Windows Application project that's named _SQLDataAccess_.
2. Open Form1.
3. In the first line of _Form1.vb_, add a reference to the ADO.NET namespace, as follows:

    ```vb
    Imports System.Data.SqlClient
    ```

4. Select **Start**, point to **Programs**, point to Microsoft SQL Server, and then select **SQL Server Service Manager** to make sure that the SQL Server service is running on your computer.
5. Set the **Server** property to the name of your computer, and then set the **Services** property to _MSSQLServer_.
6. If the service isn't running, select **Start**.
7. Close the **SQL Server Service Manager** dialog box.

## Create ADO.NET objects

Modify the `Form1` class as follows:

```vb
Public Class Form1
    Inherits System.Windows.Forms.Form
    'Create ADO.NET objects.
    Private myConn As SqlConnection
    Private myCmd As SqlCommand
    Private myReader As SqlDataReader
    Private results As String
```

The `SqlConnection` object establishes a database connection, the `SqlCommand` object runs a query against the database, and the `SqlDataReader` object retrieves the results of the query.

## Use the SqlConnection object to open SQL Server connection

1. To set up the connection string of the `SqlConnection` object, add the following code to the `Form1_Load` event procedure:

    ```vb
     'Create a Connection object.
     myConn = New SqlConnection("Initial Catalog=Northwind;" & _
     "Data Source=localhost;Integrated Security=SSPI;")
    ```

2. To set up the `Command` object that contains the SQL query, add the following code to the `Form1_Load` event procedure:

    ```vb
    'Create a Command object.
    myCmd = myConn.CreateCommand
    myCmd.CommandText = "SELECT FirstName, LastName FROM Employees"

    'Open the connection.
    myConn.Open()
    ```

`SqlConnection` uses your Windows logon details to connect to the _Northwind_ database on your computer.

## Use the SqlDataReader object to retrieve data from SQL Server

1. Add the following code to the `Form1_Load` event procedure:

    ```vb
    myReader = myCmd.ExecuteReader()
    ```

2. When the `myCmd.ExecuteReader` method runs, `SqlCommand` retrieves two fields from the `Employees` table and creates a `SqlDataReader` object.
3. To display the query results, add the following code to the `Form1_Load` event procedure:

    ```vb
    'Concatenate the query result into a string.
    Do While myReader.Read()
        results = results & myReader.GetString(0) & vbTab & _
        myReader.GetString(1) & vbLf
    Loop
    'Display results.
    MsgBox(results)
    ```

The `myReader.Read` method returns a boolean value that indicates whether there are more records to be read. The results of the SQL query are displayed in a message box.

4. To close the `SqlDataReader` and `SqlConnection` objects, add the following code to the `Form1_Load` event procedure:

    ```vb
    'Close the reader and the database connection.
     myReader.Close()
     myConn.Close()
    ```

5. Save and run the project.

## View database in Server Explorer

1. On the **View** menu, select **Server Explorer**.
2. Right-click **Data Connections**, and then select **Add connection**.
3. In the **Data Link Properties** dialog box, select **localhost** in the **Select or enter a server name** box.
4. To log on to the server, select **Windows NT Integrated Security**.
5. Select **Select the database on the server**, and then select the _Northwind_ database in the list.
6. To validate the connection, select **Test Connection**, and then select **OK**.
7. In the Server Explorer, select to expand the **Data Connections** tree so that the `Employees` table node expands. The properties of individual fields appear in the **Properties** window.

## Use Server Explorer to open SQL Server connection

1. View Form1 in Design view.
2. From the `Employees` table in Server Explorer, drag and drop the **FirstName** and **LastName** database fields onto Form1. This action creates `SqlConnection` and `SqlDataAdapter` objects on the form.
3. On the **View** menu, select **Toolbox**.
4. On the **Data** tab, drag and drop a `DataSet` object (DataSet1) onto the form.
5. In the **Add Dataset** dialog box, select **Untyped dataset**, and then select **OK**.
6. In the `Form1_Load` event procedure, insert a line of code before the `DataReader` and `Connection` objects are closed to end the procedure, as follows:

    ```vb
    SqlDataAdapter1.Fill(DataSet1, "Employees")
    myReader.Close()
    myConn.Close()
    ```

7. On the **Window Forms** tab of the toolbox, drag and drop a DataGrid control onto Form1.
8. In the `Form1_Load` event procedure, add the following code before the `myReader.close()` line to bind the DataGrid to the `DataSet` object that you created earlier:

    ```vb
    DataGrid1.SetDataBinding(DataSet1, "Employees")
    ```

9. Save and run the project.

## Related content

- [ADO.NET](/dotnet/framework/data/adonet/)
- [Accessing data in Visual Basic applications](/dotnet/visual-basic/developing-apps/accessing-data)
