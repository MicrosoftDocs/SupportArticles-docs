---
title: SQL Server dump files are generated when a linked server query that references an LOB data type encounters exceptions
description: This article discusses how to fix an assert dump-related SQL Server issue in which a linked server query references an LOB data type and raises an exception.
author: JamesFerebee
ms.author: jaferebe
ms.reviewer: jopilov, v-jayaramanp
ms.date: 02/15/2024
ms.custom: sap:Database Engine
---

# SQL Server generates an assert dump file when a linked server query using an LOB data type encounters an exception

This article helps you resolve an issue that causes Microsoft SQL Server to generate an asset dump file and the SQL Server service to become unresponsive.

## Symptoms

Consider the following scenario:

- SQL Server generates an assert dump file. This causes the SQL Server service to become unresponsive.
- In the SQL Server error log, you observe the following assert expression: `pilb->m_cRef == 0`. For more information about asserts and how to troubleshoot them, see [MSSQLSERVER_3624 - SQL Server](/sql/relational-databases/errors-events/mssqlserver-3624-database-engine-error).
  
   > 2023-03-14 06:12:44.83 spid54      * Location: memilb.cpp:1836
   > 2023-03-14 06:12:44.83 spid54      * Expression: pilb->m_cRef == 0

- SQL Server becomes unresponsive during the dump file process.

## Cause

The following are some conditions that can affect when the SQL Server dump file is generated:

- A remote query is run by using the `EXEC AT` command. For example:

  ```sql
  DECLARE @test NVARCHAR(MAX) = N'ABC'
  EXEC ('SELECT * FROM Customers.dbo.CustomerInformation WHERE CustomerId = ?', @test) AT [YourRemoteServer];
  ```

- A large object (LOB) argument is passed to the query. For more information about LOB data types, see [Data types (Transact-SQL) - SQL Server](/sql/t-sql/data-types/data-types-transact-sql).

In the previous example, the `NVARCHAR(MAX)` variable is passed as a query parameter. One of the underlying requests that are submitted to the linked server fails.

You can also reproduce the issue by running the following query:

```sql
DECLARE @test NVARCHAR(MAX) = N'msdb' 
EXEC ('---SELECT * FROM sys.databases where name = ?', @test) AT [<server>\<instance>]
```

Avoid by using nonblob (BLOB) data type in your database design or code:

```sql
DECLARE @test NVARCHAR(5) = N'msdb' 
EXEC ('---SELECT * FROM sys.databases where name = ?', @test) AT  [<server>\<instance>]
```

> [!WARNING]
> If you run this code in your environment, you are likely to encounter a dump file that will be an outage. Run at your own risk.

## Status

Microsoft is still investigating this issue to identify a long-term fix. Until a fix is available, you can try the workaround that's provided in the next section.

## Workaround

To work around this issue, change all `LOB` (Large Object) data types to fixed length data types that the input data length supports. For example, convert `NVARCHAR(MAX)` to `NVARCHAR(200))`.
