---
title: Create a SQL Server Database programmatically
description: This article describes how to create a SQL Server Database programmatically by using ADO.NET and Visual C# .NET.
ms.date: 10/26/2020
ms.custom: sap:Language or Compilers\C#
ms.reviewer: malcolms
ms.topic: how-to
---
# Create a SQL Server Database programmatically by using ADO.NET and Visual C# .NET

This article describes how to create a SQL Server Database programmatically by using ADO.NET and Visual C# .NET.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 307283

## Summary

This step-by-step article shows you how to create a Microsoft SQL Server database by using ADO.NET and Visual C# .NET because programmers often need to create Databases programmatically.

- For a Microsoft Visual Basic .NET version of this article, see [How to create a SQL Server database programmatically by using ADO.NET and Visual Basic .NET](https://support.microsoft.com/help/305079/).  

- For a Microsoft Visual C++ .NET version of this article, see [How To Create a SQL Server Database Programmatically by Using ADO.NET and Visual C++ .NET](https://support.microsoft.com/help/307402).  

This article refers to the following Microsoft .NET Framework Class Library namespace: `System.Data.SqlClient`.

## Steps to create a SQL Server Database

To create the database, follow these steps:

1. Create a new Visual C# .NET Windows application.
2. Place a button on Form1. Change the button's Name property to btnCreateDatabase, and then change the `Text` property to Create Database.
3. Use the using statement on the System and `System.Data` namespaces so that you do not have to qualify declarations in those namespaces later in your code. Add the following code to the General Declarations section of Form1:

    ```csharp
    using System;
    using System.Data.SqlClient;
    ```

4. Switch to Form view, and then double-click **Create Database** to add the click event handler. Add the following sample code to the handler:

    ```csharp
     String str;
     SqlConnection myConn = new SqlConnection ("Server=localhost;Integrated security=SSPI;database=master");
    
    str = "CREATE DATABASE MyDatabase ON PRIMARY " +
     "(NAME = MyDatabase_Data, " +
     "FILENAME = 'C:\\MyDatabaseData.mdf', " +
     "SIZE = 2MB, MAXSIZE = 10MB, FILEGROWTH = 10%)" +
     "LOG ON (NAME = MyDatabase_Log, " +
     "FILENAME = 'C:\\MyDatabaseLog.ldf', " +
     "SIZE = 1MB, " +
     "MAXSIZE = 5MB, " +
     "FILEGROWTH = 10%)";
    
    SqlCommand myCommand = new SqlCommand(str, myConn);
    try
    {
        myConn.Open();
        myCommand.ExecuteNonQuery();
        MessageBox.Show("DataBase is Created Successfully", "MyProgram", MessageBoxButtons.OK, MessageBoxIcon.Information);
    }
    catch (System.Exception ex)
    {
        MessageBox.Show(ex.ToString(), "MyProgram", MessageBoxButtons.OK, MessageBoxIcon.Information);
    }
    finally
    {
        if (myConn.State == ConnectionState.Open)
        {
            myConn.Close();
        }
    }
    ```

5. Change the connection string to point to your computer running SQL Server, and then verify that the Database argument is set to Master or is blank.
6. Press **F5** or **CTRL+F5** to run the project, and then click **Create Database**.
7. Use the Server Explorer to verify that the database is created.

> [!NOTE]
> - This code creates a custom database with specific properties.
> - The folder that is going to hold the created .mdf and .ldf files must already exist before you run the code or an exception will be generated.
> - If you want to create a database that is similar to the SQL Server Model database, and you want the database in the default location, then change the *str* variable in the code, as in the following sample code: `str = "CREATE DATABASE MyDatabase"`

## References

- [Create Database](/sql/t-sql/statements/create-database-transact-sql)
- [What's New in ADO.NET](/dotnet/framework/data/adonet/whats-new)
