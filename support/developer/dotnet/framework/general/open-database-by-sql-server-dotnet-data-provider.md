---
title: Open SQL database by VB .NET
description: Introduces how to open SQL Server databases by using SQL Server .NET Data Provider with Visual Basic .NET.
ms.date: 07/07/2025
ms.topic: how-to
ms.custom: sap:Class Library Namespaces

#customer intent: As a developer, I want to open SQL Server databases using the SQL Server .NET Data Provider with Visual Basic .NET so that I can integrate SQL Server with to my applications. 
---
# Open SQL Server database by using SQL Server .NET Data Provider with Visual Basic .NET

This article provides information about how to open SQL Server databases by using SQL Server .NET Data Provider with Visual Basic .NET. You can use ADO.NET to open a SQL Server database using the SQL Server .NET Data Provider. ADO.NET gathers all of the classes that are required for data handling.

The `System.Data.SqlClient` namespace describes a collection of classes that are used to programmatically access a SQL Server data source. You can access ADO classes through the `System.Data.OleDb` namespace to provide support for OLE DB databases.

In this article, connections are set up both programmatically and using the Visual Studio .NET Server Explorer. The code samples in this article use the `SqlConnection`, `SqlCommand`, and `SqlDataReader` ADO.NET objects.

_Original product version:_ Visual Basic .NET

_Original KB number:_ 308656

## Prerequisites

- Microsoft SQL Server
- Visual Basic .NET

> [!NOTE]
> SQL Server and Visual Basic .NET must be installed and running on the same computer. In addition, the user must be able to use Windows Integrated Security to connect to SQL Server.

This article assumes that you're familiar with the following topics:

- ADO.NET concepts
- SQL Server concepts and Transact-SQL (T-SQL) syntax
- _Northwind_ sample database

## Create Visual Basic .NET Windows application

1. Start Visual Studio .NET, and create a new Visual Basic Windows Application project named _SQLDataAccess_.
2. Open Form1. In the first line of _Form1.vb_, add a reference to the ADO.NET namespace as follows:

    ```vb
    Imports System.Data.SqlClient
    ```

3. From the Windows **Start** menu, point to **Programs**, point to Microsoft SQL Server, and then click **SQL Server Service Manager** to ensure that the SQL Server service is running on your computer.
4. Set the **Server** property to the name of your computer, and then set the **Services** property to _MSSQLServer_.
5. If the service isn't running, click **Start**.
6. Close the **SQL Server Service Manager** dialog box.

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

2. To set up the `Command` object, which contains the SQL query, add the following code to the `Form1_Load` event procedure:

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

2. When the `myCmd.ExecuteReader` method is executed, `SqlCommand` retrieves two fields from the `Employees` table and creates a `SqlDataReader` object.
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

    The `myReader.Read` method returns a boolean value, which indicates whether there are more records to be read. The results of the SQL query are displayed in a message box.

4. To close the `SqlDataReader` and `SqlConnection` objects, add the following code to the `Form1_Load` event procedure:

    ```vb
    'Close the reader and the database connection.
     myReader.Close()
     myConn.Close()
    ```

5. Save and run the project.

## View database in Server Explorer

1. On the **View** menu, click Server Explorer.
2. Right-click **Data Connections**, and then click **Add connection**.
3. In the **Data Link Properties** dialog box, click localhost in the **Select or enter a server name** box.
4. Click **Windows NT Integrated Security** to log on to the server.
5. Click **Select the database on the server**, and then select _Northwind_ database from the list.
6. Click **Test Connection** to validate the connection, and then click **OK**.
7. In the Server Explorer, click to expand the **Data Connections** tree so that the `Employees` table node expands. The properties of individual fields appear in the **Properties** window.

## Use Server Explorer to open SQL Server connection

1. View Form1 in Design view.
2. Drag the **FirstName** and **LastName** database fields from `Employees` table in Server Explorer, and drop these fields onto Form1. A `SqlConnection` and `SqlDataAdapter` object are created on the form.
3. From the **View** menu, click **Toolbox**.
4. On the **Data** tab, drag a `DataSet` object (DataSet1), and drop it onto the form.
5. In the **Add Dataset** dialog box, click **Untyped dataset**, and then click **OK**.
6. Insert a line of code before the `DataReader` and `Connection` objects are closed in the `Form1_Load` event procedure. The end of the procedure should appear as follows:

    ```vb
    SqlDataAdapter1.Fill(DataSet1, "Employees")
    myReader.Close()
    myConn.Close()
    ```

7. On the **Window Forms** tab of the toolbox, drag a DataGrid control, and drop it onto Form1.
8. To bind the DataGrid to the `DataSet` object that you created earlier, add the following code to the `Form1_Load` event procedure before the `myReader.close()` line of code:

    ```vb
    DataGrid1.SetDataBinding(DataSet1, "Employees")
    ```

9. Save and run the project.

## Related content

- [ADO.NET](/dotnet/framework/data/adonet/)
- [Accessing data in Visual Basic applications](/dotnet/visual-basic/developing-apps/accessing-data)
