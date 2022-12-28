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

On the dedicated SQL pool, the tempdb database is used for temporary tables and intermediate space for data movements (for example: shuffle moves, trim moves), sorts, loads, memory spills, and other operations. Moreover, an uncommitted transaction in one session that interacts with the tempdb database will prevent the log from flushing all other sessions, resulting in the filling of the log files. Because the tempdb database is a shared resource, large consumption of the tempdb space may result in failed queries of other users and can escalate to the prevention of new connections from being established.

## What to do if I can't connect to the dedicated SQL pool?

If you have no existing connection to identify any problematic connection or query, the only method for resolving the inability to create a new connection is to **Pause** and **Resume**, or **Scale** the dedicated SQL pool. This action will kill the user transactions that led to this issue and recreate the tempdb database as part of the service restart.

**Note:** Be sure to give the service extra time to undo all running transactions because pause and scale operations may take longer than normal to complete in this scenario.

## Troubleshoot full tempdb data files

### Step 1: Identify the query that fills up the tempdb database

Make sure that you identify the query that fills up the tempdb database while the query is executing, unless you've implemented a logging component to your ETL framework or auditing of your dedicated SQL pool statements. In most cases, not always, the longest-running query that executed in the timeframe of the issue occurring is the reason for the tempdb out of space errors. Run the following query to get a list of long running queries:

```sql
SELECT TOP 5 *
FROM sys.dm_pdw_exec_requests
WHERE status = 'running'
ORDER BY total_elapsed_time desc;
```

Once you have a reasonable suspected query, try one of the following options:

- [Kill](/sql/t-sql/language-elements/kill-transact-sql) the statement.
- Attempt to prevent any other workload from further consuming the tempdb space so that the long-runner can complete.

### Step 2: Prevent recurrence

After you identify and take action against the responsible query, consider implementing mitigations to prevent the issue from recurring. The following table shows mitigations for the most common causes of tempdb full errors:

| Cause | Description | Mitigation |
|--------|-------------|------------|
| Poor distributed plan | The distributed plan generated for a given query can inadvertently introduce high frequency data movement as a result of poorly maintained table statistics. | [Update statistics](/troubleshoot/azure/synapse-analytics/dedicated-sql/dsql-perf-stats-accuracy) for relevant tables and ensure they're maintained on a regular schedule. |
| Poor clustered columnstore index (CCI) health | It consumes the tempdb space due to memory spills. | [Rebuild CCIs](/troubleshoot/azure/synapse-analytics/dedicated-sql/dsql-perf-cci-health) and ensure they're maintained on a regular schedule. |
| Large transactions | Large volume `CREATE TABLE AS SELECT (CTAS)` or `INSERT SELECT` statements fill the tempdb during data movement operations. | Break your `CTAS` or `INSERT SELECT` statement into multiple, smaller transactions. |
| Insufficient memory allocation | Queries with insufficient memory allocated (via resource class or workload group) can spill into `tempdb`. | Execute your queries with a larger [resource class](/azure/synapse-analytics/sql-data-warehouse/resource-classes-for-workload-management) or a [workload group](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-workload-isolation) with more resources. |
| End-user external table queries | Queries against external tables aren't optimal for end-user queries because the engine will need to read the entire files into `tempdb` before processing the data. |  [Load the data](/azure/sql-data-warehouse/sql-data-warehouse-best-practices#load-then-query-external-tables) to a permanent table and then direct user queries there. |
| Insufficient overall resources | You may find that your dedicated SQL pool is close to maxing out its tempdb capacity during high activity. | Consider scaling up your dedicated SQL pool in combination with any of the mitigations above. |

## Troubleshoot full tempdb transaction log files

The tempdb transaction log typically only fills due to a client/user either:

- Opens an explicit transaction but never issue a `COMMIT` or `ROLLBACK`.
- Has `SET IMPLICIT_TRANSACTION = ON` (typical of JDBC clients and tools using AutoCommit features).

### Step 1: Identify open transactions

The problematic connections may be from clients who have an open transaction but are in an Idle status. Run the following query to help identify this scenario:

```sql
SELECT *
FROM sys.dm_pdw_exec_sessions
WHERE is_transactional = 1
AND status = 'Idle';
```

**Note**: Not all connections that return as a result of this query are necessarily problematic. Run the query at least twice with more than 15 minutes between executions and see which connections persist in this state.

### Step 2: Mitigate and prevent

After identifying which clients are holding open transactions, work with the users to change either or both:

- Driver configuration (for example: JDBC AutoCommit _off_ which sets `IMPLICIT_TRANSACTIONS = ON`)
- Ad hoc query behaviors (for example: executing `BEGIN TRAN` without `COMMIT`/`ROLLBACK`)

Alternatively, you may consider creating an automated process to periodically detect this scenario and [kills](/sql/t-sql/language-elements/kill-transact-sql) any potentially problematic sessions.

## Resources

- Query the DMV [sys.dm_pdw_errors](/sql/relational-databases/system-dynamic-management-views/sys-dm-pdw-errors-transact-sql?view=azure-sqldw-latest&preserve-view=true) for errors.
