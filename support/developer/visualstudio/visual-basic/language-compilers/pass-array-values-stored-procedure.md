---
title: Pass array of values into stored procedure
description: This article describes how to pass array of values into SQL Server stored procedure using XML and Visual Basic .NET.
ms.date: 10/26/2020
ms.custom: sap:Language or Compilers\Visual Basic .NET (VB.NET)
ms.topic: how-to
---
# Pass array of values into SQL Server stored procedure using XML and Visual Basic .NET

This article shows how to pass array of values into SQL Server stored procedure using XML and Visual Basic .NET.

_Original product version:_ &nbsp; Visual Basic  
_Original KB number:_ &nbsp; 555266

## Symptoms

You are required to pass array of values into SQL Server stored procedure to use it as a list for an `IN` clause.

## CAUSE

Current version of Microsoft SQL Server does not have any support of array datatype that would allow passing array of values as a parameter of the stored procedure or SQL statement. Often developers are required to pass an array of the values to select records based on a provided list in an `IN` clause. In some cases list of the parameters passed to the stored procedure as a comma-delimited string and this delimited string cannot be used directly as a parameter of the IN clause and has to be transformed into the form that is acceptable for using inside of `IN` clause.

## Resolution

One of the solutions to this problem is to pass array of the values to the stored procedure as an XML string parameter and use `OPENXML rowset` provider inside of the stored procedure to select values from the provided XML. Using of the `OPENXML` provider in conjunction with the Transact-SQL statements provides flexible and simple way to manipulate data in a database based on a passed array of values.

## Create the project  

> [!NOTE]
> This sample does not contain code for the exception handling that would be required in a production-level application.

We will use Orders table from the `Northwind` SQL Server database. Use the following strong to create a stored procedure in a `Northwind` database.

```sql
IF EXISTS (SELECT name
    FROM sysobjects
    WHERE name = N'sp_SelectOrders'
    AND type = 'P')
    DROP PROCEDURE sp_SelectOrders
GO

CREATE PROC sp_SelectOrders @in_values nText AS

DECLARE @hDoc int

--Prepare input values as an XML documnet
exec sp_xml_preparedocument @hDoc OUTPUT, @in_values

--Select data from the table based on values in XML
SELECT * FROM Orders WHERE CustomerID IN (
 SELECT CustomerID FROM OPENXML (@hdoc, '/NewDataSet/Customers', 1)
 WITH (CustomerID NCHAR(5)))

EXEC sp_xml_removedocument @hDoc

GO
```

Start Visual Studio .NET and create Console Application. By-default *Module1.vb* file will be created.

Replace the strong inside of the *Module1.vb* file with the following one. To simplify and example, sample strong selects the list of all the customers from the Customers table, prepares array of values as an XML string just for half of the customers (to demonstrate limited selection) and then runs stored procedure to select list of the orders from the Orders table for the selected customers.

> [!NOTE]
> You would need to modify connection string in a sample strong to use it in your environment

```vbnet
Imports System.Data.SqlClient
Imports System.Xml
Imports System.Text

Module Module1

PublicSub Main()

    Dim loCustomers As DataSet
    Dim loOrders As DataTable
    
    Try
    
        'Get list of the customers from the database
        loCustomers = GetCustomers()
        
        Console.WriteLine("Total customers: " & loCustomers.Tables(0).Rows.Count.ToString)
        
        If Not loCustomers Is Nothing Then
            loOrders = GetOrders(loCustomers)
            Console.WriteLine("Total orders: " & loOrders.Rows.Count.ToString)
        EndIf
        
        Catch ex As Exception
            Console.WriteLine(ex.Message)
        Finally
        
        If Not loCustomers Is Nothing Then
            loCustomers.Dispose()
            loCustomers = Nothing
        EndIf
        
        If Not loOrders Is Nothing Then
            loOrders.Dispose()
            loOrders = Nothing
        EndIf
    
    EndTry

EndSub

Private Function GetOrders(ByVal loCustomers As DataSet) As DataTable

    Dim loOrders As DataSet
    Dim loParameter As SqlParameter
    Dim loCol As DataColumn
    
    Try
    
        'Prepare XML output from the Customers DataSet as a string
        ForEach loCol In loCustomers.Tables("Customers").Columns
            loCol.ColumnMapping = System.Data.MappingType.Attribute
        Next
        
        'Pass XML into the stored procedure as a parameter
        loParameter = New SqlParameter("@in_values", System.Data.SqlDbType.NText)
        loParameter.Value = loCustomers.GetXml
        
        'Get list of the orders from the database
        loOrders = GetDataFromDb("sp_SelectOrders", CommandType.StoredProcedure, "Customers", loParameter)'Return list of the orders as a DataTable
        If (Not loOrders Is Nothing) AndAlso loOrders.Tables.Count = 1 Then
            Return loOrders.Tables(0)
        EndIf
    
    Catch ex As Exception
        Throw ex
    EndTry

EndFunction

Private Function GetCustomers() As DataSet

    Dim loCustomers As DataSet
    Dim i As Int32
    
    Try
    
    'Get list of the customers from the database
    loCustomers = GetDataFromDb("SELECT CustomerID FROM Customers", CommandType.Text, "Customers")'Remove half of the customers for the demo purposes to show that we select info just for some of them
    If Not loCustomers Is Nothing Then
    
    If loCustomers.Tables.Contains("Customers") Then
            With loCustomers.Tables("Customers")
        
        i = .Rows.Count \ 2
        DoWhile .Rows.Count > i
            .Rows.RemoveAt(0)
        Loop
        
        'Accept changes to remove the rows completely from the DataTable
        .AcceptChanges()
        EndWith
        Else
            ThrowNew ApplicationException("Customers table does not exist")
        EndIf
    
    EndIf
    
    'Return list of the customers as a DataSet
    Return loCustomers
    
    Catch ex As Exception
        Throw ex
    EndTry

EndFunction

Private Function GetDataFromDb(ByVal lcSQL AsString, ByVal loCommandType As CommandType, _
ByVal lcTableName AsString, ByValParamArray loParameters() As SqlParameter) As DataSet

    Dim loResult As DataSet
    Dim loConnection As SqlConnection
    Dim loCommand As SqlCommand
    Dim loAdapter As SqlDataAdapter
    Dim i As Int32
    Dim loParameter As SqlParameter
    
    Try
    
        'Create and open connection to the Northwind database
        loConnection = New SqlConnection("Persist Security Info=False;Integrated Security=SSPI;database=northwind;server=(local);Connect Timeout=30")
        loConnection.Open()'Prepare command and to select data from the database
        loCommand = New SqlCommand(lcSQL, loConnection)
        loCommand.CommandType = loCommandType
        
        IfNot loParameters IsNothingThen
        ForEach loParameter In loParameters
        loCommand.Parameters.Add(loParameter)
        Next
        EndIf
        
        loAdapter = New SqlDataAdapter(loCommand)
        
        loResult = New DataSet
        loAdapter.Fill(loResult, lcTableName)'Return list of the customers as a DataSet
        Return loResult
    
    Catch ex As Exception
        Throw ex
    Finally
    
        'Clean resources
        If Not loAdapter Is Nothing Then
            loAdapter.Dispose()
            loAdapter = Nothing
        EndIf
        
        If Not loCommand Is Nothing Then
            loCommand.Dispose()
            loCommand = Nothing
        EndIf
        
        If Not loConnection Is Nothing Then
        
            If loConnection.State = ConnectionState.Open Then
                loConnection.Close()
            EndIf
            
            loConnection.Dispose()
            loConnection = Nothing
        
        EndIf
    EndTry

  EndFunction

EndModule
```

Press **F5** to compile and run application. Console will display the results.
