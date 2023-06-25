---
title: Error when you use client cursor to add record
description: This article provides resolutions for the problem that occurs when you use client cursor to add record to SQL Server table that has default value in Datetime field.
ms.date: 11/03/2020
ms.custom: sap:MDAC and ADO
---
# Error when you use client cursor to add record to SQL Server table that has default value in Datetime field

This article helps you resolve the problem that occurs when you use client cursor to add record to SQL Server table that has default value in Datetime field.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 279888

## Symptoms

If you use ADO to insert a new record through a client-side recordset into a SQL Server table that has a non-nullable `datetime` field with a default value, you receive the following error message if you do not supply a value for the `datetime` field:

> Run-time error '-2147217887 (80040e21)': Multiple-step operation generated errors. Check each status value.

This error occurs whether you use the OLE DB Provider for SQL Server or the OLE DB Provider for ODBC Drivers. The error message may differ when you use Microsoft Data Access Components (MDAC) version 2.5 Service Pack 1 (SP1) or earlier. This error does not occur with a server-side cursor.

## Cause

This error occurs in the Client Cursor Engine when it attempts to convert the value of type `DBTYPE_DBTIMESTAMP` to `DBTYPE_VARIANT`.

## Resolution

There are several ways to work around this problem:

- Use a server-side cursor for the recordset.
- Remove the default value that is specified for the field in the database.
- Always specify a value for the field when you add a new record.

## Steps to Reproduce Behavior

1. Add a table to SQL Server that contains a datetime field that does not accept nulls and that has a default value. Include at least one additional field. For the sake of this article, the following SQL Server 2000 table is created:

    ```sql
    if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DateTest]')
    and OBJECTPROPERTY(id, N'IsUserTable') = 1)
    drop table [dbo].[DateTest]
    GO
    
    CREATE TABLE [dbo].[DateTest] ([DateId] [int] IDENTITY (1, 1) NOT NULL ,
    [TestDate] [datetime] NOT NULL ,
    [Nonsense] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
    ) ON [PRIMARY]
    GO
    
    ALTER TABLE [dbo].[DateTest] WITH NOCHECK ADD 
    CONSTRAINT [DF_DateTest_TestDate] DEFAULT ('3/1/2001') FOR [TestDate],
     PRIMARY KEY CLUSTERED 
    ([DateId]
    ) ON [PRIMARY] 
    GO
    ```

2. To insert a row into the table, run code that is similar to the following code.

    > [!NOTE]
    > You must change User ID =\<UID> and password =\<strong password> to the correct values before you run this code. Make sure that \<UID> has the appropriate permissions to perform this operation on the database. Also, make sure that you do not supply a value for the `datetime` field.
    
    ```vbnet
     Dim cnn As ADODB.Connection
     Dim rst As ADODB.Recordset
    
    Set cnn = New ADODB.Connection
    cnn.Open "Provider=SQLOLEDB;Data Source=(local);" & _
    "Initial Catalog=test;User Id=<UID>;Password=<strong password>;"
    
    Set rst = New ADODB.Recordset
    With rst
    .CursorLocation = adUseClient
    .Open "SELECT * FROM DateTest", cnn, adOpenStatic, adLockOptimistic
    
    .AddNew
    .Fields("Nonsense").Value = "test data"
    .Update
    End With
    
    Debug.Print rst("TestDate").Value
    ```

    You receive the above-mentioned error message when you examine the Value property of the `datetime` field.
