---
title: Troubleshoot tempdb errors on a dedicated SQL pool
description: Provides methods for troubleshooting tempdb data and transaction log full errors on a dedicated SQL pool.
ms.date: 12/23/2022
author: scott-epperly
ms.author: scepperl
ms.reviewer: scepperl
---

# Troubleshoot tempdb errors on a dedicated SQL pool

_Applies to:_ &nbsp; Azure Synapse Analytics

On a dedicated SQL pool, the tempdb database is used for temporary tables and intermediate space for data movements (for example: shuffle moves, trim moves), sorts, loads, memory spills, and other operations. Moreover, an uncommitted transaction in one session that interacts with the tempdb database will prevent the log from flushing all other sessions, causing the log files to fill up. Because the tempdb database is a shared resource, large consumption of the tempdb space may cause other users' queries to fail and can escalate to prevent new connections from being established.

## What to do if I can't connect to the dedicated SQL pool?

If you have no existing connections to identify any problematic connections or queries, the only method for resolving the inability to create a new connection is to **Pause** and **Resume**, or **Scale** the dedicated SQL pool. This action will terminate the user transactions that led to this issue and recreate the tempdb database when the service restarts.

**Note:** Be sure to give the service extra time to undo all running transactions because pause and scale operations may take longer than normal to complete in this scenario.

## Troubleshoot full tempdb data files

### Step 1: Identify the query that fills up the tempdb database

Make sure that you identify the query that fills up the tempdb database while the query is being executed, unless you've implemented a logging component to your ETL framework or auditing of your dedicated SQL pool statements. In most cases, not always, the longest-running query executed during the time frame in which the issue occurred is the cause of the tempdb out of space errors. Run the following query to get a list of long-running queries:

```sql
SELECT TOP 5 *
FROM sys.dm_pdw_exec_requests
WHERE status = 'running'
ORDER BY total_elapsed_time desc;
```

Once you have a reasonably suspicious query, try one of the following options:

- [Kill](/sql/t-sql/language-elements/kill-transact-sql) the statement.
- Attempt to prevent any other workload from further consuming the tempdb space so that the long-runner can complete.

### Step 2: Prevent the recurrence

After you've identified and taken action against the responsible query, consider implementing mitigations to prevent the issue from recurring. The following table shows mitigations for the most common causes of tempdb full errors:

| Cause | Description | Mitigation |
|--------|-------------|------------|
| Poor distributed plan | The distributed plan generated for a given query can inadvertently introduce high frequency data movement as a result of poorly maintained table statistics. | [Update statistics](dsql-perf-stats-accuracy.md) for relevant tables and ensure they're maintained on a regular schedule. |
| Poor clustered columnstore index (CCI) health | It consumes the tempdb space due to memory spills. | [Rebuild CCIs](dsql-perf-cci-health.md) and ensure they're maintained on a regular schedule. |
| Large transactions | Large volume of `CREATE TABLE AS SELECT (CTAS)` or `INSERT SELECT` statements fills up the tempdb during data movement operations. | Break your `CTAS` or `INSERT SELECT` statement into multiple, smaller transactions. |
| Insufficient memory allocation | Queries with insufficient memory allocated (via resource class or workload group) can spill into `tempdb`. | Execute your queries with a larger [resource class](/azure/synapse-analytics/sql-data-warehouse/resource-classes-for-workload-management) or a [workload group](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-workload-isolation) with more resources. |
| End-user external table queries | Queries against external tables aren't optimal for end-user queries because the engine needs to read the entire file into `tempdb` before processing the data. |  [Load the data](/azure/sql-data-warehouse/sql-data-warehouse-best-practices#load-then-query-external-tables) to a permanent table and then direct user queries there. |
| Insufficient overall resources | You may find that your dedicated SQL pool is close to its maximum tempdb capacity during high activity. | Consider scaling up your dedicated SQL pool in combination with any of the mitigations above. |

## Troubleshoot full tempdb transaction log files

The tempdb transaction log typically only fills up when a client/user either:

- Opens an explicit transaction but never issues a `COMMIT` or `ROLLBACK`.
- Sets `IMPLICIT_TRANSACTION = ON` (especially for JDBC clients and tools that use AutoCommit features).

### Step 1: Identify open transactions

The problematic connections may be from clients that have an open transaction but are in an "Idle" status. Run the following query to help identify this scenario:

```sql
SELECT *
FROM sys.dm_pdw_exec_sessions
WHERE is_transactional = 1
AND status = 'Idle';
```

**Note**: Not all connections that are returned as a result of this query are necessarily problematic. Run the query at least twice with more than 15 minutes between executions, and see which connections persist in this state.

### Step 2: Mitigate and prevent the issue

After identifying which clients are holding open transactions, work with the users to change either or both:

- Driver configuration (for example: JDBC AutoCommit setting to `off`, which sets `IMPLICIT_TRANSACTIONS = ON`)
- Ad hoc query behaviors (for example: incorrectly executing `BEGIN TRAN` without `COMMIT`/`ROLLBACK`)

Alternatively, you may consider creating an automated process to periodically detect this scenario and [kill](/sql/t-sql/language-elements/kill-transact-sql) any potentially problematic sessions.

## Resources

- Query the DMV [sys.dm_pdw_errors](/sql/relational-databases/system-dynamic-management-views/sys-dm-pdw-errors-transact-sql?view=azure-sqldw-latest&preserve-view=true) for errors.
