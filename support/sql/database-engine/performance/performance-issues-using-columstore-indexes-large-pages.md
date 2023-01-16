---
title: Interoperability of indexes with page memory model
description: This article provides resolutions for the performance issue when you use Columnstore Index feature and large page memory model in SQL Server.
ms.date: 11/07/2022
ms.custom: sap:Administration and Management
ms.prod: sql
---
# Performance may be slow when columnstore indexes are used with large page memory

This article helps you resolve the performance issue when you use `Columnstore Index` feature and large page memory model in SQL Server.

_Original product version:_ &nbsp; SQL Server 2012, SQL Server 2014, SQL Server 2016, SQL Server 2017, SQL Server 2019  
_Original KB number:_ &nbsp; 3210239

## Symptoms

Consider the following scenario:

- In an instance of SQL Server, you use [trace flag 834](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf834) as a startup flag. You do this operation to enable large page allocations by the SQL Server memory manager in order to improve performance of the 64-bit instance.

- You use the `Columnstore Index` feature.

In this scenario, you experience one or more of the following performance issues:

- A non-yielding Scheduler error and associated memory dumps in the SQL Server Error log.
- Columnstore queries trigger severe performance issues.
- A SQL Server instance triggers access violations when you execute columnstore queries.
- You encounter the following error when you run `sp_createstats`:

    > There is insufficient system memory in resource pool 'default' to run this query

## Resolution

To resolve this issue, remove trace flag 834 (-T834) from SQL Server startup parameters on SQL Server instances that use columnstore indexes. In these environments, Microsoft doesn't recommend using a `large page` memory model and encourages customers to revert to a `conventional` or `lock pages` memory model.

> [!NOTE]
> Starting with SQL Server 2019, trace flag (TF) 876 is available to enable the large page memory model for columnstore. See [DBCC TRACEON - Trace Flags (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql).

## More information

- [SQL Server memory models](/archive/blogs/sql_pfe_blog/sql-server-memory-models-part-i)
- [SQL Server and large pages explained](/archive/blogs/psssql/sql-server-and-large-pages-explained)
- [Tuning options for SQL Server when running in high performance workloads](https://support.microsoft.com/help/920093)
