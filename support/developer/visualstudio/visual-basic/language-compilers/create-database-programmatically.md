---
title: Create SQL Server database programmatically
description: This article describes how to use ADO.NET and Visual Basic .NET to programmatically create a Microsoft SQL Server database.
ms.date: 10/10/2020
ms.custom: sap:Language or Compilers\Visual Basic .NET (VB.NET)
ms.topic: how-to
---
# Create SQL Server database programmatically by using ADO.NET and Visual Basic .NET  

This article describes how to use ADO.NET and Visual Basic .NET to programmatically create a Microsoft SQL Server database.

_Original product version:_ &nbsp; ADO.NET, Visual Basic .NET  
_Original KB number:_ &nbsp; 305079

## Summary

Programmers often need to create databases programmatically. This article describes how to use ADO.NET and Visual Basic .NET to programmatically create a SQL Server database.

## Steps to create the sample

1. Create a new Visual Basic .NET Windows Application project. Form1 is added to the project by default.
2. Place a Command button on Form1, and change its `Name` property to `btnCreateDatabase` and its `Text` property to `Create Database`.
3. Copy and paste the following line of code into Form1's "general declaration" section:

    ```csharp
    Imports System.Data.SqlClient
    ```

4. Copy and paste the following code after the region "Windows Form Designer generated code":

    ```vbnet
    Private Sub btnCreateDatabase_Click(ByVal sender As System.Object, _
    ByVal e As System.EventArgs) Handles btnCreateDatabase.Click
    Dim str As String

    Dim myConn As SqlConnection = New SqlConnection("Server=(local)\netsdk;" & _
    "uid=sa;pwd=;database=master")

    str = "CREATE DATABASE MyDatabase ON PRIMARY " & _
    "(NAME = MyDatabase_Data, " & _
    " FILENAME = 'D:\MyFolder\MyDatabaseData.mdf', " & _
    " SIZE = 2MB, " & _
    " MAXSIZE = 10MB, " & _
    " FILEGROWTH = 10%)" & _
    " LOG ON " & _
    "(NAME = MyDatabase_Log, " & _
    " FILENAME = 'D:\MyFolder\MyDatabaseLog.ldf', " & _
    " SIZE = 1MB, " & _
    " MAXSIZE = 5MB, " & _
    " FILEGROWTH = 10%)"

    Dim myCommand As SqlCommand = New SqlCommand(str, myConn)

    Try
    myConn.Open()
    myCommand.ExecuteNonQuery()
    MessageBox.Show("Database is created successfully", _
    "MyProgram", MessageBoxButtons.OK, _
    MessageBoxIcon.Information)
    Catch ex As Exception
    MessageBox.Show(ex.ToString())
    Finally
    If (myConn.State = ConnectionState.Open) Then
    myConn.Close()
    End If
    End Try

    End Sub
    ```

5. Change the connection string to point to your SQL Server, and make sure that the Database argument is set to **Master** or **blank**.
6. Press **F5** or **CTRL+F5** to run the project, and then click **Create Database**.

## Additional notes

- This code creates a custom database with specific properties.
- The folder that will hold the created .mdf and .ldf files must already exist before you run the code or an exception will be generated.
- If you want to create a database that is similar to SQL Server's Model database and in the default location, then change the str variable in the code:

    ```vbnet
    str = "CREATE DATABASE MyDatabase"
    ```

## References

- [How To Create a SQL Server Database Programmatically by Using ADO.NET and Visual C++ .NET](https://support.microsoft.com/help/307402)

- [How To Create a SQL Server Database Programmatically by Using ADO.NET and Visual C# .NET](https://support.microsoft.com/help/307283)
