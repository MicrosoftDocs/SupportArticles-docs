---
title: Troubleshooting the SQL Server Dump
description: This article helps you to resolve an issue where the SQL Server becomes unresponsive.
ms.date: 02/12/2024
ms.custom: sap:Database Engine
---

# SQL Server becomes unresponsive during SQL Server dump generation

This article helps you resolve an issue when SQL Server becomes unresponsive when a SQL Server dump is generated.

## Symptoms

Consider the following scenario:

- You are generating a SQL Server dump.
- You experience the following error message that mentions the assert expression `pilb->m_cRef == 0`.
- The SQL Server becomes unresponsive during the dump process.

Following are some conditions that can affect when the dump is being generated:

A remote query is executed using the `EXEC AT` syntax:

```sql
DECLARE @test NVARCHAR(MAX) = N'ABC'
EXEC ('SELECT * FROM Customers.dbo.CustomerInformation WHERE CustomerId = ?', @test) AT [YourRemoteServer];
```

A large object (LOB) argument is passed to the query. For more information about a list of LOB data types, see [Data types (Transact-SQL) - SQL Server](/sql/t-sql/data-types/data-types-transact-sql?view=sql-server-ver16).

In the previous example, the NVARCHAR(MAX) variable is passed as a query parameter.

One of the underlying requests submitted to the linked server fails.

