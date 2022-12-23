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

On the dedicated SQL pool, tempdb is used for temporary tables and intermediate space for data movement (for example: shuffle moves, trim moves, etc.), sorts, loads, memory spills, and other operations.  Moreover, an uncommitted transaction in one session that interacts with tempdb will prevent the log from flushing all other sessions, resulting in the filling of the log files.  Since tempdb is a shared resource, large consumers of tempdb space may affect other users in the form of failed queries and can escalate to the prevention of new connections from being established.

## What to do if you can't connect to the dedicated SQL pool

If you have no existing connection to identify any problematic connection/query, the only method for resolving the inability to create a new connection is to __Pause__ \ __Resume__ or __Scale__ the dedicated SQL pool.  This action won't only kill the user transaction(s) that led to this issue but will also recreate tempdb as part of the service restart.

Be sure to give the service extra time to undo all running transactions; pause and scale operations may take longer than normal to complete under this scenario.

## Troubleshoot full tempdb data files

### Step 1: Identify query filling up tempdb

Identification of the query that is causing tempdb to fill must be done while the query is still executing.  Alternatively, this analysis can be done if you've implemented a logging component to your ETL framework or auditing of your dedicated SQL pool statements.  Though not always the case, you most often find that the longest-running query that executed in the timeframe of the issue occurring is the reason for the tempdb out of space errors:

```
select top 5 *
from sys.dm_pdw_exec_requests
where status = 'running'
order by total_elapsed_time desc;
```

Once you have a reasonable suspect query, choose whether to proceed to:

- [kill](/sql/t-sql/language-elements/kill-transact-sql) the statement
- attempt to prevent any other workload from further consuming tempdb space so that the long-runner can complete.

### Step 2: Prevent reoccurrence

Having identified and taken action against the responsible query, consider implementing the following mitigations for the most common reasons of tempdb full errors to prevent the issue from reoccurring:

| Reason | Description | Mitigation |
|--------|-------------|------------|
| Poor distributed plan | The distributed plan generated for a given query can inadvertently introduce high data movement as a result of poorly maintained table statistics. | [Update statistics](/troubleshoot/azure/synapse-analytics/dedicated-sql/dsql-perf-stats-accuracy) for relevant tables and ensure they're maintained on a regular schedule. |
| Poor clustered columnstore index (CCI) health | Consumes tempdb space due to memory spills. | [Rebuild CCIs](/troubleshoot/azure/synapse-analytics/dedicated-sql/dsql-perf-cci-health) and ensure they're maintained on a regular schedule. |
| Large transactions | Large volume `CREATE TABLE AS SELECT (CTAS)` or `INSERT SELECT` statements fill tempdb during data movement operations. | Break your `CTAS` or `INSERT SELECT` statement into multiple, smaller transactions. |
| Insufficient memory allocation | Queries with insufficient memory allocated (via resource class/workload group) can spill into `tempdb`. | Execute your queries with a larger [resource class](/azure/synapse-analytics/sql-data-warehouse/resource-classes-for-workload-management) or a [workload group](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-workload-isolation) with more resources. |
| End-user external table queries | Directly issuing queries against external tables aren't optimal for end user queries as the engine will need to read the entire files into `tempdb` before processing the data. |  [Load the data](/azure/sql-data-warehouse/sql-data-warehouse-best-practices#load-then-query-external-tables) to a permanent table and then direct user queries there. 
| Insufficient overall resources | You may find that your dedicated SQL pool is close to maxing out its tempdb capacity during high activity. | Consider scaling up your dedicated SQL pool in combination with any of the aforementioned mitigations. |

## Troubleshoot full tempdb transaction log files

The tempdb transaction log typically only fills due to a client/user either:

* opening an explicit transaction open and never issuing a `COMMIT` or `ROLLBACK`
* has SET IMPLICIT_TRANSACTION = ON (typical of JDBC clients and tools using AutoCommit features)

### Step 1: Identify open transactions

Your first task will be to identify potentially problematic transactions.  These connections will be from clients who have an open transaction but are in an Idle status.  The following query can help to identify this scenario:

```
select *
from sys.dm_pdw_exec_sessions
where is_transactional = 1
and status = 'Idle';
```

**Note**: not all connections that return as a result of this query are necessarily problematic.  It would be wise to run the query at least twice with at least 15 minutes between executions and noting which connections persist in this state.

### Step 2: Mitigation and Prevention

After identifying clients that are holding open transactions, work with the users to change:

* driver configuration (for example: JDBC AutoCommit off which sets `IMPLICIT_TRANSACTIONS = ON`) and/or 
* ad hoc query behaviors (for example: executing `BEGIN TRAN` without `COMMIT`/`ROLLBACK`)

Alternatively, you may consider creating an automated process to periodically detect this scenario and [kills](/sql/t-sql/language-elements/kill-transact-sql) any potentially problematic sessions.

## Resources

- Query the DMV [sys.dm_pdw_errors](/sql/relational-databases/system-dynamic-management-views/sys-dm-pdw-errors-transact-sql?view=azure-sqldw-latest) for errors.
