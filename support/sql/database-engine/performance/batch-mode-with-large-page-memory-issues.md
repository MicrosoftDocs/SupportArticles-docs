---
title: Interoperability issues between batch mode processing and large page memory model
description: This article helps you resolve the performance and stability issues that arise from the use of batch mode processing on columnstore and rowstore with large page memory model in SQL Server.
ms.date: 11/07/2022
ms.custom: sap:Administration and Management
---
# Interoperability issues between batch mode processing and large page memory model

This article helps you resolve the performance and stability issues that arise from the use of batch mode processing on columnstore and rowstore with large page memory model in SQL Server

_Original product version:_ &nbsp; SQL Server 2012, SQL Server 2014, SQL Server 2016, SQL Server 2017, SQL Server 2019, SQL Server 2022  
_Original KB number:_ &nbsp; 3210239

## Symptoms

- In an instance of SQL Server, you use [trace flag 834](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf834) as a startup flag. You do this operation to enable large page allocations by the SQL Server memory manager in order to improve performance of the 64-bit instance.

- You use the [columnstore indexes](/sql/relational-databases/indexes/columnstore-indexes-overview) or [batch mode processing on rowstore](/sql/relational-databases/performance/intelligent-query-processing-details#batch-mode-on-rowstore).

In this scenario, you experience one or more of the following issues:

- A non-yielding Scheduler error and associated memory dumps in the SQL Server Error log
- Queries that use batch mode processing may run into severe performance issues
- Access violation exceptions and associated memory dumps in the SQL Server Error log
- You may encounter the following error when you run `sp_createstats`:

   ```output
   There is insufficient system memory in resource pool 'default' to run this query
   ```

## Workaround

To mitigate these issues, you can use one or more of following steps:

1. Disable the large page memory model by removing [trace flag 834](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf834) (-T834) from SQL Server startup parameters on SQL Server instance. This step causes SQL Server to stop using a `large page` memory model and revert to a `conventional` or `lock pages` memory model.

1. If you don't use columnstore indexes in your SQL Server and you run into the described symptoms, you can disable batch mode on rowstore at the database level by using `ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ON_ROWSTORE = OFF`. For more information, see [ALTER DATABASE SCOPED CONFIGURATION](/sql/t-sql/statements/alter-database-scoped-configuration-transact-sql#batch_mode_on_rowstore---on--off-)

## More information

- [SQL Server memory models](/archive/blogs/sql_pfe_blog/sql-server-memory-models-part-i)
- [SQL Server and large pages explained](/archive/blogs/psssql/sql-server-and-large-pages-explained)
- [Tuning options for SQL Server when running in high performance workloads](https://support.microsoft.com/help/920093)
