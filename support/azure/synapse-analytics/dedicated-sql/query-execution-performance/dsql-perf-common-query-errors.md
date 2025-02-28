---
title: Troubleshoot Common Query Execution Errors on an Azure Synapse Dedicated SQL Pool
description: Provides a reference of the most common errors and recommendations for query execution on an Azure Synapse dedicated SQL pool.
author: dialmoth
ms.author: dialmoth
ms.reviewer: goventur, wiassaf, dialmoth
ms.date: 02/05/2025
ms.custom:
  - sap:Query Execution and Performance
---

# Troubleshoot common query errors

_Applies to:_ &nbsp; Azure Synapse Analytics

> [!NOTE]
> Make sure to review the [list of known issues](/azure/synapse-analytics/known-issues) currently active or recently resolved in Azure Synapse Analytics.

Use the following guidance to troubleshoot common failures, errors, and exceptions that occur when executing queries against your Azure Synapse dedicated SQL pool.

## Common errors

| Error | Cause | Mitigation |
|-------|-------|------------|
| `Could not allocate a new page for database 'Distribution_nn' because of insufficient disk space in filegroup 'PRIMARY'.` | Tables with rowstore indexes (not [columnstore](/sql/relational-databases/indexes/columnstore-indexes-overview#key-terms-and-concepts)) and/or heaps have exceeded available space in at least one distribution. | - [Increase max size for the database.](/sql/t-sql/statements/alter-database-transact-sql#b-change-max-size-for-the-database)<br>- [Evaluate tables for skew.](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-distribute#determine-if-the-table-has-data-skew) |
| `Error 8632 - Internal error: An expression services limit has been reached. Look for potentially complex expressions in your query, and try to simplify them.` | The query is too complex for optimization. | Break the query into multiple steps. |
| `Database 'Distribution_nn_Cache' cannot be opened due to inaccessible files or insufficient memory or disk space.` | Indicates a service health issue. | Pause and resume your dedicated SQL pool.|
| `Unable to allocate n KB for columnstore compression because it exceeds the remaining memory from total allocated for current resource class and DWU.` | Insufficient memory for write operation. | - [Increase the user's resource class.](/azure/sql-data-warehouse/resource-classes-for-workload-management#change-a-users-resource-class)<br>- Consider temporarily [increasing the service level objective (SLO)](/azure/synapse-analytics/sql-data-warehouse/quickstart-scale-compute-portal). |
| `Internal error (5123, 50)` | Occurs due to high volume IO operations. | - [Increase the user's resource class.](/azure/sql-data-warehouse/resource-classes-for-workload-management#change-a-users-resource-class)<br>- Reduce number of partitions of the table.<br>- [Rebuild CCI tables.](dsql-perf-cci-health.md)|
| `Failed to execute query. Error: MSDTC on server '{NAME}' is unavailable` | The service that manages global transactions isn't functioning appropriately. | Pause and resume your dedicated SQL pool for immediate mitigation. Contact support if the issue reoccurs.|
| `110806; A distributed query failed: Execution Timeout Expired.  The timeout period elapsed prior to completion of the operation or the server isn't responding` | Internal metadata retrieval timeout. |  Replace query references to [sys.pdw_table_mappings](/sql/relational-databases/system-catalog-views/sys-pdw-table-mappings-transact-sql) with [sys.pdw_permanent_table_mappings](/sql/relational-databases/system-catalog-views/sys-pdw-permanent-table-mappings-transact-sql) as it's more performant. |
| `110806; A distributed query failed: ExecuteNonQuery requires an open and available Connection. The connection's current state is open.` | Internal query failure indicating connectivity issues between compute nodes. | - Retry the query(ies) as this issue will typically self-resolve.<br>- Pause and resume your dedicated SQL pool if the issue persists.<br>- Contact support if the frequency of the issue increases. |
| `110806; A distributed query failed: Operation not allowed.` | Internal query failure typically indicating resource pressure. | - Retry the query(ies) as this issue will typically self-resolve.<br>- Pause and resume your dedicated SQL pool if the issue persists.<br>- [Update statistics](dsql-perf-stats-accuracy.md) and [rebuild CCIs.](dsql-perf-cci-health.md)<br>- Consider [increasing SLO](/azure/synapse-analytics/sql-data-warehouse/quickstart-scale-compute-portal). Contact support if the issue persists after increasing SLO.|
| `110806; A distributed query failed: Could not allocate space for object '<ObjectName' in database 'tempdb' because the 'PRIMARY' filegroup is full.` | A query or series of queries has filled `tempdb` on at least one compute node. | See how to [Troubleshoot tempdb errors on a dedicated SQL pool](dsql-perf-tempdb-errors.md). |
| `110802; An internal DMS error occurred that caused this operation to fail. Details: Please use this Error ID when contacting your Administrator for assistance. EID:(ErrorID)` | Query failure during DMS operation due to insufficient resources. | - [Increase the user's resource class](/azure/sql-data-warehouse/resource-classes-for-workload-management#change-a-users-resource-class) to match the workload.<br>- Review and implement [mitigations to prevent tempdb filling.](dsql-perf-tempdb-errors.md#step-2-prevent-the-recurrence) |
| `110802; An internal DMS error occurred that caused this operation to fail. ... Java exception message: HdfsBridge::createRecordWriter - Unexpected error encountered when creating a record writer: ClassCastException:` | Occurs during `CREATE EXTERNAL TABLE AS SELECT` statement when the `EXTERNAL DATA SOURCE` is created using native data virtualization against an unsupported source.  | Specify `TYPE = Hadoop` when creating the [External Data Source.](/sql/t-sql/statements/create-external-data-source-transact-sql) |
| `110802; An internal DMS error occurred that caused this operation to fail. ... Java exception message: HdfsBridge::CreateRecordReader - Unexpected error encountered creating the record reader: ConnectException: Connection timed out:` | Insufficient memory resources to execute the query. | [Increase the user's resource class](/azure/sql-data-warehouse/resource-classes-for-workload-management#change-a-users-resource-class) to match the workload. |
| `100088: The query processor could not produce a query plan because the target DML table is not hash partitioned` | Unsupported round-robin distributed table DML scenario:<br>- `DELETE` from RR with `PRIMARY` or `UNIQUE` key<br>- `UPDATE` utilizes a ranking function, such as `ROW_NUMBER`, `RANK`, or `DENSE_RANK` for determining rows to update on the target table. | - `DELETE` + PK/UK scenario: `Drop` PK/UK and then remove duplicate rows.<br>- `UPDATE` + ranking function scenario: <ul><li>Change the target table distribution type to `HASH`.</li><li>Perform `DELETE` + `INSERT` instead of `UPDATE`.</li></ul></ul> |
| `35386. Error Message: Unable to allocate 370216 {NAME} for columnstore compression because it exceeds the remaining memory from total allocated for current resource class and DWU` | The query that's modifying or managing a table with a clustered columnstore index doesn't have sufficient memory to complete the task. | - [Increase the user's resource class](/azure/sql-data-warehouse/resource-classes-for-workload-management#change-a-users-resource-class) to match the workload.<br>- Consider [increasing SLO.](/azure/synapse-analytics/sql-data-warehouse/quickstart-scale-compute-portal) |

## Unexpected behaviors

| Observation | Recommendation |
|-------------|----------------|
| Syntax errors | Check the [T-SQL syntax](/azure/sql-data-warehouse/sql-data-warehouse-reference-tsql-statements) reference as there are differences for dedicated SQL pools. |
| Primary keys and unique keys not enforced. | Primary keys and unique constraints don't enforce consistency in Synapse Analytics. However, the query optimizer can take advantage of the key to improve query performance. |
| USE statement fails. | The `USE` statement isn't supported on the dedicated SQL pool. Connect to the Synapse dedicated SQL pool directly in the connection string.|
| Canceled query or execution timeout errors. | - Check the timeout value configured on the client application.<br>- Configure the `QUERY_EXECUTION_TIMEOUT_SEC` parameter in the [CREATE WORKLOAD GROUP](/sql/t-sql/statements/create-workload-group-transact-sql). |
| Inconsistent or unexpected results. | - If your data contains special characters or uses different text encodings, use Unicode data types like `NCHAR` and `NVARCHAR`.<br>- Check if your query uses `GETDATE()` in the `WHERE` clause or `JOIN` operations. Use a variable to store the date, then use it in the variable.<br>- Check if your query uses the `ROW_NUMBER()` function in the `WHERE` clause or `JOIN` operations. Use a temp table to hold the `ROW_NUMBER()` function results, and then join with other tables.<br>- Databases with a non-default collation can affect the behavior of queries and display unexpected results when interacting with non-Microsoft tooling.<br>**Note**: the default database collation can't be changed after the creation of the dedicated SQL pool. For more information about collation support, see [Database collation support for Azure Synapse Analytics Dedicated SQL pool](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-reference-collation-types). |
| Unexpected duplicate rows. | Drop the `PRIMARY KEY` on the table and then check for the duplicates. |
| Queries hang, or there are long-running queries. | Use our article to [Troubleshoot a slow query on a dedicated SQL pool](troubleshoot-dsql-perf-slow-query.md). |
| The estimated query plan isn't eliminating the relevant partitions as expected. |This behavior is by design. The estimated query plan generated by the Control node doesn't take into account the seek predicates, but the individual distribution plans on the compute nodes do. |
| Unable to reference views in a materialized view. | Materialized views don't support querying other views. Check [restrictions for materialized views](/sql/t-sql/statements/create-materialized-view-as-select-transact-sql#remarks). |
| Inconsistent durations when querying external tables. | External tables aren't optimal for end-user queries. Instead, consider [loading data into permanent tables](/azure/sql-data-warehouse/sql-data-warehouse-best-practices#load-then-query-external-tables) for querying or switch the workload to use [serverless pools](/azure/synapse-analytics/sql/on-demand-workspace-overview) for a more consistent experience. |

## Resources

- Query the DMV [sys.dm_pdw_errors](/sql/relational-databases/system-dynamic-management-views/sys-dm-pdw-errors-transact-sql) for errors
- [Troubleshoot dedicated SQL pool (formerly SQL DW) in Azure Synapse Analytics](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-troubleshoot)
- [Troubleshoot a slow query on a dedicated SQL pool](troubleshoot-dsql-perf-slow-query.md)
