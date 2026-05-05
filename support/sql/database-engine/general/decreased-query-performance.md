---
title: SQL query slowdown after database maintenance or reconfigure
description: SQL Server query performance drops after database maintenance or reconfigure operations that clear the plan cache. Learn how to diagnose and minimize the impact.
ms.date: 04/15/2026
ms.reviewer: jopilov, v-shaywood
ms.custom: sap:Queries, stored procedures, views, functions, triggers (T-SQL)\Slow performance, unresponsive or times out
---

# Decreased query performance after database maintenance or reconfigure operations

_Original KB number:_ &nbsp; 917828

## Summary

In Microsoft SQL Server, query performance might suddenly decrease after you perform certain database maintenance operations, regular transaction operations, or server reconfigure operations. This problem occurs because these operations clear the entire [plan cache](/sql/relational-databases/query-processing-architecture-guide#execution-plan-caching-and-reuse) for the SQL Server instance.

When the plan cache is cleared, all subsequent queries must recompile. The spike in recompilations temporarily increases CPU usage and reduces query throughput until the plan cache is repopulated. This article describes the operations that cause plan cache clearing, how to identify when the problem occurs, and which Performance Monitor counters and SQL Profiler events to monitor.

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

### Operations that clear the plan cache

The system clears the entire plan cache when you perform any of the following database-level operations:

- Set the [AUTO_CLOSE](/sql/t-sql/statements/alter-database-transact-sql-set-options#auto_close--on--off-) database option to `ON`. If no user connection references or uses the database, the background task tries to close and shut down the database automatically.

- Run several queries against a database that has default options, and then drop the database.

- Drop a [database snapshot](/sql/relational-databases/databases/database-snapshots-sql-server) for a source database.

- Rebuild the transaction log for a database.

- Restore a database backup.

- Detach a database by using [sp_detach_db](/sql/relational-databases/system-stored-procedures/sp-detach-db-transact-sql).

- Change the database state to `OFFLINE` or `ONLINE`.

- Specify certain options in an [ALTER DATABASE](/sql/t-sql/statements/alter-database-transact-sql-set-options#set-options) statement or change server options by using the [sp_configure](/sql/relational-databases/system-stored-procedures/sp-configure-transact-sql) and `RECONFIGURE` statements, as listed in the following table:

  | Command          | Option                            |
  | ---------------- | --------------------------------- |
  | `ALTER DATABASE` | `COLLATE`                         |
  | `ALTER DATABASE` | `MODIFY FILEGROUP DEFAULT`        |
  | `ALTER DATABASE` | `MODIFY FILEGROUP READ_ONLY`      |
  | `ALTER DATABASE` | `MODIFY FILEGROUP READ_WRITE`     |
  | `ALTER DATABASE` | `MODIFY_NAME`                     |
  | `ALTER DATABASE` | `OFFLINE`                         |
  | `ALTER DATABASE` | `ONLINE`                          |
  | `ALTER DATABASE` | `PAGE_VERIFY`                     |
  | `ALTER DATABASE` | `READ_ONLY`                       |
  | `ALTER DATABASE` | `READ_WRITE`                      |
  | `sp_configure`   | `access check cache bucket count` |
  | `sp_configure`   | `access check cache quota`        |
  | `sp_configure`   | `clr enabled`                     |
  | `sp_configure`   | `cost threshold for parallelism`  |
  | `sp_configure`   | `cross db ownership chaining`     |
  | `sp_configure`   | `index create memory`             |
  | `sp_configure`   | `max degree of parallelism`       |
  | `sp_configure`   | `max server memory`               |
  | `sp_configure`   | `max text repl size`              |
  | `sp_configure`   | `max worker threads`              |
  | `sp_configure`   | `min memory per query`            |
  | `sp_configure`   | `min server memory`               |
  | `sp_configure`   | `query governor cost limit`       |
  | `sp_configure`   | `query wait`                      |
  | `sp_configure`   | `remote query timeout`            |
  | `sp_configure`   | `user options`                    |

> [!NOTE]
> The system doesn't clear the procedure cache if the actual value doesn't change or if you set the new value for `max server memory` to `0`.

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

#### Check Extended Events trace

If you capture an Extended Events (XEvent) trace, enable the following events to check for cache removal:

- `sqlserver.sp_cache_remove`
- `sqlserver.query_cache_removal_statistics` (query level)

Examine the `removal_reason` and `remove_method` columns to identify the cause.

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
- [Troubleshoot high-CPU-usage issues in SQL Server](../performance/troubleshoot-high-cpu-usage-issues.md)
