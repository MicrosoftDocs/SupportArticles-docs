---
title: SQL query slowdown after database maintenance or reconfigure
description: SQL Server query performance drops after database maintenance or reconfigure operations that clear the plan cache. Learn how to diagnose and minimize the impact.
ms.date: 04/15/2026
ms.reviewer: jopilov, v-shaywood
ms.custom: sap:Queries, stored procedures, views, functions, triggers (T-SQL)\Slow performance, unresponsive or times out
---

# Decreased query performance after database maintenance or reconfigure operations

## Summary

In Microsoft SQL Server, query performance might suddenly decrease after you perform certain database maintenance operations, regular transaction operations, or server reconfigure operations. This problem occurs because these operations clear the entire [plan cache](/sql/relational-databases/query-processing-architecture-guide#execution-plan-caching-and-reuse) for the SQL Server instance.

When the plan cache is cleared, all subsequent queries must recompile. The spike in recompilations temporarily increases CPU usage and reduces query throughput until the plan cache is repopulated. This article describes the operations that cause plan cache clearing, how to identify when the problem occurs, and which Performance Monitor counters and SQL Profiler events to monitor.

> [!NOTE]
> This automatic procedure cache clearing behavior doesn't occur in SQL Server 2008 and later versions for most scenarios.

## Symptoms

You notice a sudden decrease in query performance. The SQL Server error log contains messages that resemble the following example:

```output
SQL Server has encountered <N> occurrence(s) of cachestore flush for the 'Object Plans' cachestore (part of plan cache) due to some database maintenance or reconfigure operations.
SQL Server has encountered <N> occurrence(s) of cachestore flush for the 'SQL Plans' cachestore (part of plan cache) due to some database maintenance or reconfigure operations.
SQL Server has encountered <N> occurrence(s) of cachestore flush for the 'Bound Trees' cachestore (part of plan cache) due to some database maintenance or reconfigure operations.
```

If you run [DBCC FREEPROCCACHE](/sql/t-sql/database-console-commands/dbcc-freeproccache-transact-sql) or [DBCC FREESYSTEMCACHE](/sql/t-sql/database-console-commands/dbcc-freesystemcache-transact-sql) to flush the plan cache, you see messages that resemble the following example:

```output
SQL Server has encountered <N> occurrence(s) of cachestore flush for the 'SQL Plans' cachestore (part of plan cache) due to 'DBCC FREEPROCCACHE' or 'DBCC FREESYSTEMCACHE' operations.
SQL Server has encountered <N> occurrence(s) of cachestore flush for the 'Bound Trees' cachestore (part of plan cache) due to 'DBCC FREEPROCCACHE' or 'DBCC FREESYSTEMCACHE' operations.
```

## Cause

This behavior is by design. Certain database maintenance or reconfigure operations clear the entire procedure cache. All subsequent queries must then generate new execution plans. This action temporarily increases CPU usage and decreases query performance until the cache is repopulated.

### Database-level operations that clear the plan cache

The entire plan cache is cleared when you perform any of the following database-level operations:

- Set the [AUTO_CLOSE](/sql/t-sql/statements/alter-database-transact-sql-set-options#auto_close--on--off-) database option to `ON`. If no user connection references or uses the database, the background task tries to close and shut down the database automatically.

- Run several queries against a database that has default options, and then drop the database.

- Drop a [database snapshot](/sql/relational-databases/databases/database-snapshots-sql-server) for a source database.

- Rebuild the transaction log for a database.

- Restore a database backup.

- Detach a database by using [sp_detach_db](/sql/relational-databases/system-stored-procedures/sp-detach-db-transact-sql).

- Change the database state to `OFFLINE` or `ONLINE`.

- Specify one of the following options in an [ALTER DATABASE](/sql/t-sql/statements/alter-database-transact-sql-set-options#set-options) statement:

  - `OFFLINE`
  - `ONLINE`
  - `MODIFY_NAME`
  - `COLLATE`
  - `MODIFY FILEGROUP DEFAULT`
  - `MODIFY FILEGROUP READ_WRITE`
  - `MODIFY FILEGROUP READ_ONLY`
  - `READ_ONLY`
  - `READ_WRITE`

### Server-level options that clear the plan cache

If you change any of the following server options by using the [sp_configure](/sql/relational-databases/system-stored-procedures/sp-configure-transact-sql) and `RECONFIGURE` statements, you clear the entire procedure cache:

- `access check cache bucket count`
- `access check cache quota`
- `clr enabled`
- `cost threshold for parallelism`
- `cross db ownership chaining`
- `index create memory`
- `max degree of parallelism`
- `max server memory`
- `max text repl size`
- `max worker threads`
- `min memory per query`
- `min server memory`
- `query governor cost limit`
- `query wait`
- `remote query timeout`
- `user options`

> [!NOTE]
> The procedure cache isn't cleared if the actual value doesn't change or if you set the new value for `max server memory` to `0`.

## Solution

### Verify that plan cache clearing is causing performance problems

Use the following methods to verify that a sudden query performance decrease is caused by plan cache clearing.

#### Check Performance Monitor counters

To identify the problem, monitor the following SQL Server performance counters:

- **Performance object:** `Process`, **Counter:** `% Processor Time`, **Instance:** `sqlservr`

  This counter value increases because of increased CPU activity from recompilations after the plan cache is cleared.

- **Performance object:** `SQLServer:Plan Cache`, **Counter:** `Cache Object Counts`, **Instance:** `_Total`

  and

  **Performance object:** `SQLServer:Plan Cache`, **Counter:** `Cache Pages`, **Instance:** `_Total`

  The values of these counters suddenly decrease when the plan cache is cleared.

- **Performance object:** `SQLServer:SQL Statistics`, **Counter:** `SQL Compilations/sec`

  This counter value significantly increases after the plan cache is cleared.

> [!NOTE]
> For a named instance of SQL Server, the performance object is named `MSSQL$<InstanceName>:Plan Cache` and `MSSQL$<InstanceName>:SQL Statistics`.

#### Check a SQL Profiler trace

If you capture a SQL Profiler trace by using the `SP:CacheRemove` event, this event is generated together with the following `TextData` column value when the plan cache is cleared:

```output
Entire Procedure Cache Flushed
```

### Best practices to minimize performance impact

- **Check error logs for cache flush patterns.** To identify which operations are triggering plan cache clearings, review the SQL Server error log for cachestore flush messages.

- **Minimize unnecessary database configuration changes.** Avoid frequent cache flushes by reducing the number of `RECONFIGURE` or `ALTER DATABASE` operations that clear the plan cache.

- **Schedule planned operations during maintenance windows.** To reduce the effect on query performance, schedule operations such as database restores or `ALTER DATABASE` changes during low-usage periods.

- **Clear only specific plans instead of the entire cache.** Instead of flushing all cached plans, remove only the problematic plan by specifying its plan handle:

  ```sql
  DBCC FREEPROCCACHE (<PlanHandle>);
  ```

  For more information, see [DBCC FREEPROCCACHE (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-freeproccache-transact-sql).

- **Use database-scoped cache clearing (SQL Server 2016 and later).** Instead of clearing the plan cache for the entire instance, use [ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE](/sql/t-sql/statements/alter-database-scoped-configuration-transact-sql) to clear plans for a single database.

## Related content

- [DBCC DROPCLEANBUFFERS (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-dropcleanbuffers-transact-sql)
- [Troubleshoot high-CPU-usage issues in SQL Server](/sql/database-engine/performance/troubleshoot-high-cpu-usage-issues.md)
