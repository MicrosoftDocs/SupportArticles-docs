---
title: NullReferenceException if you use CommandBuilder
description: This article explains why you receive an error message when you use the CommandBuilder object, and provides two methods to resolve this problem.
ms.date: 04/22/2020
ms.reviewer: jayapst
ms.custom: sap:Language or Compilers\Visual Basic .NET (VB.NET)
---
# System.NullReferenceException occurs when you use the CommandBuilder object

This article helps you resolve the `System.NullReferenceException` exception that occurs when you use the `CommandBuilder` object.

_Original product version:_ &nbsp; Visual Basic .NET  
_Original KB number:_ &nbsp; 310367

## Symptoms

If you use the `CommandBuilder` object to explicitly get commands for the `DataAdapter` object as follows:

```vb
da.InsertCommand = cb.GetInsertCommand
```

Then, run the following Visual Basic .NET code:

```vb
cb.DataAdapter = Nothing
```

The commands that you add to the `DataAdapter` are deleted, and you receive the following error message:

> An unhandled exception of type 'System.NullReferenceException' occurred in app_name.exe  
> Additional information: Object reference not set to an instance of an object.

## Cause

`CommandBuilder` deletes the commands that it generates when it is disassociated from a `DataAdapter.CommandBuilder` and `DataAdapter` are linked; when they are unlinked or disassociated, the commands are nulled. This problem does not affect commands that you build from the beginning.

## Resolution

Use one of the following methods to resolve this problem:

- Do not disassociate the `CommandBuilder` from the `DataSet`.
- Build the commands yourself, either in code or through Visual Data Tools.

## Status

This behavior is by design.

## Steps to reproduce the behavior

1. Create a new Visual Basic .NET Windows Application project. Form1 is added to the project by default.

2. Add a Button control to Form1.

3. Switch to Code view, and add the following code to the top of the Code window:

    ```vb
    Imports System.Data.OleDb
    Imports System.Data.SqlClient
    ```

4. Add the following code to the `Click` event of the Button:

    ```vb
    Dim con As New SqlConnection("server=myserver;uid=sa;pwd=mypassword;" & _
                                "database=northwind")
    Dim da As New SqlDataAdapter("Select * From Customers", con)
    Dim cb As New SqlCommandBuilder(da)
    Dim cmdInsert As New SqlCommand( _
            "Insert Into Customer (CustomerID) Value ('AAAAA')", con)
    da.InsertCommand = cmdInsert
    da.UpdateCommand = cb.GetUpdateCommand
    da.DeleteCommand = cb.GetDeleteCommand
    Debug.WriteLine(da.InsertCommand.CommandText)
    Debug.WriteLine(da.DeleteCommand.CommandText)
    cb.DataAdapter = Nothing ' Comment out this line to avoid the error.
    cb = Nothing
    Debug.WriteLine(da.InsertCommand.CommandText)
    Debug.WriteLine(da.DeleteCommand.CommandText)'Error occurs here.
    ```

5. Modify your connection string as appropriate for your environment.
6. Press the F5 to compile and to run the application.
