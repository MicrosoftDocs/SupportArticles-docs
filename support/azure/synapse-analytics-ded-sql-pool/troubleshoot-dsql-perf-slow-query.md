---
title: Troubleshoot slow queries on a dedicated SQL pool
description: Describes the troubleshooting steps and mitigations for the common performance issues of queries run on an Azure Synapse Analytics dedicated SQL pool. 
ms.date: 09/06/2022
author: scott-epperly
ms.author: haiyingyu
ms.reviewer: scepperl
---

# Troubleshoot a slow query on a dedicated SQL Pool

_Applies to:_ &nbsp; Azure Synapse Analytics

This article helps you identify the reasons and apply mitigations for common performance issues with queries on an Azure Synapse Analytics dedicated SQL pool.

Follow the steps to troubleshoot the issue or execute the steps in the notebook via Azure Data Studio. The first three steps walk you through collecting telemetry, which describes the lifecycle of a query. The references at the end of the article help you analyze potential opportunities found in the data collected.

[!INCLUDE [Install Azure Data Studio note](../../includes/azure/install-azure-data-studio-note.md)]

> [!div class="nextstepaction"]
> [Open Notebook in Azure Data Studio](azuredatastudio://microsoft.notebook/open?url=https://raw.githubusercontent.com/microsoft/synapse-support/main/dedicated-sql-pool/dsql-tshoot-perf-slow-query.ipynb)

> [!IMPORTANT]
> Most of the reported performance issues are caused by:
>
> - Outdated statistics
> - Unhealthy clustered columnstore indexes (CCIs)
>
> To save troubleshooting time, make sure that the statistics are [created and up-to-date](/azure/synapse-analytics/sql/develop-tables-statistics#update-statistics) and [CCIs have been rebuilt](dsql-perf-cci-health.md).

## Step 1: Identify the request_id (aka QID)

The `request_id` of the slow query is required to research potential reasons for a slow query. Use the following script as a starting point for identifying the query you want to troubleshoot. Once the slow query is identified, note down the `request_id` value.

```sql
-- Monitor active queries
SELECT *
FROM sys.dm_pdw_exec_requests
WHERE [status] NOT IN ('Completed','Failed','Cancelled')
AND session_id <> session_id()
-- AND [label] = '<YourLabel>'
-- AND resource_allocation_percentage is not NULL
ORDER BY submit_time DESC;

-- Find top 10 longest running queries
SELECT TOP 10 *
FROM sys.dm_pdw_exec_requests
ORDER BY total_elapsed_time DESC;
```

To better target the slow queries, use the following tips when you run the script:

- Sort by either `submit_time DESC` or `total_elapsed_time DESC` to have the longest-running queries present at the top of the result set.
- Use `OPTION(LABEL='<YourLabel>')` in your queries and then filter the `label` column to identify them.
- Consider filtering out any QIDs that don't have a value for `resource_allocation_percentage` when you know the target statement is contained in a batch.

  **Note:** Be cautious with this filter as it may also filter out some queries that are being blocked by other sessions.

## Step 2: Determine where the query is taking time

Run the following script to find the step that may cause the performance issue of the query. Update the variables in the script with the values described in the following table. Change the `@ShowActiveOnly` value to 0 to get the full picture of the distributed plan. Take note of the `StepIndex`, `Phase`, and `Description` values of the slow step identified from the result set.

| Parameter | Description |
| -- | ---- |
| `@QID` | The `request_id` value obtained in [Step 1](#step-1-identify-the-request_id-aka-qid) |
| `@ShowActiveOnly` | 0 - Show all steps for the query<br/>1 - Show only the currently active step |

```sql
DECLARE @QID VARCHAR(16) = '<request_id>', @ShowActiveOnly BIT = 1; 
-- Retrieve session_id of QID
DECLARE @session_id VARCHAR(16) = (SELECT session_id FROM sys.dm_pdw_exec_requests WHERE request_id = @QID);
-- Blocked by Compilation or Resource Allocation (Concurrency)
SELECT @session_id AS session_id, @QID AS request_id, -1 AS [StepIndex], 'Compilation' AS [Phase],
   'Blocked waiting on '
       + MAX(CASE WHEN waiting.type = 'CompilationConcurrencyResourceType' THEN 'Compilation Concurrency'
                  WHEN waiting.type LIKE 'Shared-%' THEN ''
                  ELSE 'Resource Allocation (Concurrency)' END)
       + MAX(CASE WHEN waiting.type LIKE 'Shared-%' THEN ' for ' + REPLACE(waiting.type, 'Shared-', '')
             ELSE '' END) AS [Description],
   MAX(waiting.request_time) AS [StartTime], GETDATE() AS [EndTime],
   DATEDIFF(ms, MAX(waiting.request_time), GETDATE())/1000.0 AS [Duration],
   NULL AS [Status], NULL AS [EstimatedRowCount], NULL AS [ActualRowCount], NULL AS [TSQL]
FROM sys.dm_pdw_waits waiting
WHERE waiting.session_id = @session_id
   AND ([type] LIKE 'Shared-%' OR
      [type] in ('ConcurrencyResourceType', 'UserConcurrencyResourceType', 'CompilationConcurrencyResourceType'))
   AND [state] = 'Queued'
GROUP BY session_id 
-- Blocked by another query
UNION ALL
SELECT @session_id AS session_id, @QID AS request_id, -1 AS [StepIndex], 'Compilation' AS [Phase],
   'Blocked by ' + blocking.session_id + ':' + blocking.request_id + ' when requesting ' + waiting.type + ' on '
   + QUOTENAME(waiting.object_type) + waiting.object_name AS [Description],
   waiting.request_time AS [StartTime], GETDATE() AS [EndTime],
   DATEDIFF(ms, waiting.request_time, GETDATE())/1000.0 AS [Duration],
   NULL AS [Status], NULL AS [EstimatedRowCount], NULL AS [ActualRowCount],
   COALESCE(blocking_exec_request.command, blocking_exec_request.command2) AS [TSQL]
FROM sys.dm_pdw_waits waiting
   INNER JOIN sys.dm_pdw_waits blocking
      ON waiting.object_type = blocking.object_type
      AND waiting.object_name = blocking.object_name
   INNER JOIN sys.dm_pdw_exec_requests blocking_exec_request
      ON blocking.request_id = blocking_exec_request.request_id
WHERE waiting.session_id = @session_id AND waiting.state = 'Queued'
   AND blocking.state = 'Granted' AND waiting.type != 'Shared' 
-- Request Steps
UNION ALL
SELECT @session_id AS session_id, @QID AS request_id, step_index AS [StepIndex],
       'Execution' AS [Phase], operation_type + ' (' + location_type + ')' AS [Description],
       start_time AS [StartTime], end_time AS [EndTime],
       total_elapsed_time/1000.0 AS [Duration], [status] AS [Status],
       CASE WHEN estimated_rows > -1 THEN estimated_rows END AS [EstimatedRowCount],
       CASE WHEN row_count > -1 THEN row_count END AS [ActualRowCount],
       command AS [TSQL]
FROM sys.dm_pdw_request_steps
WHERE request_id = @QID
   AND [status] = CASE @ShowActiveOnly WHEN 1 THEN 'Running' ELSE [status] END
ORDER BY StepIndex;
```

## Step 3: Review step details

Run the following script to review the details of the step identified in the previous step. Update the variables in the script with the values described in the following table. Change the `@ShowActiveOnly` value to 0 to compare all distribution timings. Take note of the `wait_type` value for the distribution that may cause the performance issue.

| Parameter | Description |
| -- | ---- |
| `@QID` | The `request_id` value obtained in [Step 1](#step-1-identify-the-request_id-aka-qid) |
| `@StepIndex` | The `StepIndex` value identified in [Step 2](#step-2-determine-where-the-query-is-taking-time) |
| `@ShowActiveOnly` | 0 - Show all distributions for the given `StepIndex` value<br/>1 - Show only the currently active distributions for the given `StepIndex` value |

```sql
DECLARE @QID VARCHAR(16) = '<request_id>', @StepIndex INT = <StepIndex>, @ShowActiveOnly BIT = 1;
WITH dists
AS (SELECT request_id, step_index, 'sys.dm_pdw_sql_requests' AS source_dmv,
       distribution_id, pdw_node_id, spid, 'NativeSQL' AS [type], [status],
       start_time, end_time, total_elapsed_time, row_count
    FROM sys.dm_pdw_sql_requests
    WHERE request_id = @QID AND step_index = @StepIndex
    UNION ALL
    SELECT request_id, step_index, 'sys.dm_pdw_dms_workers' AS source_dmv,
       distribution_id, pdw_node_id, sql_spid AS spid, [type],
       [status], start_time, end_time, total_elapsed_time, rows_processed as row_count
    FROM sys.dm_pdw_dms_workers
    WHERE request_id = @QID AND step_index = @StepIndex
   )
SELECT sr.step_index, sr.distribution_id, sr.pdw_node_id, sr.spid,
       sr.type, sr.status, sr.start_time, sr.end_time,
       sr.total_elapsed_time, sr.row_count, owt.wait_type, owt.wait_time
FROM dists sr
   LEFT JOIN sys.dm_pdw_nodes_exec_requests owt
      ON sr.pdw_node_id = owt.pdw_node_id
         AND sr.spid = owt.session_id
         AND ((sr.source_dmv = 'sys.dm_pdw_sql_requests'
                 AND sr.status = 'Running') -- sys.dm_pdw_sql_requests status
              OR (sr.source_dmv = 'sys.dm_pdw_dms_requests'
                     AND sr.status not LIKE 'Step[CE]%')) -- sys.dm_pdw_dms_workers final statuses
WHERE sr.request_id = @QID
      AND ((sr.source_dmv = 'sys.dm_pdw_sql_requests' AND sr.status =
               CASE WHEN @ShowActiveOnly = 1 THEN 'Running' ELSE sr.status END)
           OR (sr.source_dmv = 'sys.dm_pdw_dms_workers' AND sr.status NOT LIKE
                  CASE WHEN @ShowActiveOnly = 1 THEN 'Step[CE]%' ELSE '' END))
      AND sr.step_index = @StepIndex
ORDER BY distribution_id
```

## Step 4: Diagnose and mitigate

### Compilation phase issues

- According to the `Description` values obtained in [Step 2](#step-2-determine-where-the-query-is-taking-time), check the relevant section for more information from the following table.

    |Description | Common Cause |
    |-----|------------|
    |`Compilation Concurrency`|[Blocked: Compilation Concurrency](#blocked-compilation-concurrency)|
    |`Resource Allocation (Concurrency)`|[Blocked: resource allocation](#blocked-resource-allocation)|

- If the query is in "Running" status identified in [Step 1](#step-1-identify-the-request_id-aka-qid), but there's no step information in [Step 2](#step-2-determine-where-the-query-is-taking-time), check the cause that best fits your scenario to get more information from the following table.

    |Scenario | Common Cause |
    |-----|------------|
    |Statement contains complex join-filter logic or performs joins in `WHERE` clause|[Complex query or older JOIN syntax](#complex-query-or-older-join-syntax)|
    |Statement is a long-running `DROP TABLE` or `TRUNCATE TABLE` statement|[Long-running DROP TABLE or TRUNCATE TABLE](#long-running-drop-table-or-truncate-table)|
    |CCIs have high percentage of deleted or open rows (see [Optimizing clustered columnstore indexes](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-index#optimizing-clustered-columnstore-indexes))|[Unhealthy CCIs (generally)](#unhealthy-ccis-generally)|

- Analyze the result set in [Step 1](#step-1-identify-the-request_id-aka-qid) for one or more `CREATE STATISTICS` statements executed immediately after the slow query submission. Check the cause that best fits your scenario from the following table.

    | Scenario | Common Cause |
    |----------|--------------|
    | Statistics created unexpectedly | [Delay from auto-create statistics](#delay-from-auto-create-statistics) |
    | Statistics creation failed after 5 minutes | [Auto-create statistics timeouts](#auto-create-statistics-timeouts) |

<details><summary id="blocked-compilation-concurrency"><b>Blocked: Compilation Concurrency</b></summary>

Concurrency Compilation blocks rarely occur. However, if you encounter this type of block, it signifies that a large volume of queries were submitted in a short time and have been queued to begin compilation.

**Mitigations**

Reduce the number of queries submitted concurrently.

<br/>
</details>

<details><summary id="blocked-resource-allocation"><b>Blocked: resource allocation</b></summary>

Being blocked for resource allocation means that your query is waiting to execute based on:

- The amount of memory granted based on the resource class or workload group assignment associated with the user.
- The amount of available memory on the system or workload group.
- (Optional) The workload group/classifier importance.

**Mitigations**

- Wait for the blocking session to complete.
- Evaluate the [resource class choice](/azure/synapse-analytics/sql-data-warehouse/resource-classes-for-workload-management#example-code-for-finding-the-best-resource-class). For more information, see [concurrency limits](/azure/synapse-analytics/sql-data-warehouse/memory-concurrency-limits).
- Evaluate if it's preferable to [Kill the blocking session](/sql/t-sql/language-elements/kill-transact-sql).

</details>

<details><summary id="complex-query-or-older-join-syntax"><b>Complex query or older JOIN syntax</b></summary>

You may encounter a situation where the default query optimizer methods are proven ineffective as the compilation phase takes a long time. It may occur if the query:

- Involves a high number of joins and/or subqueries (complex query).
- Utilizes joiners in the `FROM` clause (not ANSI-92 style joins).

Though these scenarios are atypical, you have options to attempt to override the default behavior to reduce the time it takes for the query optimizer to choose a plan.

**Mitigations**

- Use ANSI-92 style joins.
- Add query hints: `OPTION(FORCE ORDER, USE HINT ('FORCE_LEGACY_CARDINALITY_ESTIMATION'))`. For more information, see [FORCE ORDER](/sql/t-sql/queries/hints-transact-sql-query#force-order) and [Cardinality Estimation (SQL Server)](/sql/relational-databases/performance/cardinality-estimation-sql-server).
- Break the query into multiple, less complex steps.

</details>

<details><summary id="long-running-drop-table-or-truncate-table"><b>Long-running DROP TABLE or TRUNCATE TABLE</b></summary>

For execution time efficiencies, the `DROP TABLE` and `TRUNCATE TABLE` statements will defer storage cleanup to a background process. However, if your workload performs a high number of `DROP`/`TRUNCATE TABLE` statements in a short time frame, it's possible that metadata becomes crowded and causes subsequent `DROP`/`TRUNCATE TABLE` statements to execute slowly.

**Mitigations**

Identify a maintenance window, stop all workloads, and run [DBCC SHRINKDATABASE](/sql/t-sql/database-console-commands/dbcc-shrinkdatabase-transact-sql) to force an immediate cleanup of previously dropped or truncated tables.

<br/>
</details>

<details><summary id="unhealthy-ccis-generally"><b>Unhealthy CCIs (generally)</b></summary>

Poor clustered columnstore index (CCI) health requires extra metadata, which can cause the query optimizer to take more time to determine an optimal plan. To avoid this situation, ensure that all of your CCIs are in good health.

**Mitigations**

[Assess and correct clustered columnstore index health in a dedicated SQL pool](dsql-perf-cci-health.md).

<br/>
</details>

<details><summary id="delay-from-auto-create-statistics"><b>Delay from auto-create statistics</b></summary>

The [automatic create statistics option](/azure/synapse-analytics/sql/develop-tables-statistics#automatic-creation-of-statistics), `AUTO_CREATE_STATISTICS` is `ON` by default to help ensure the query optimizer can make good distributed plan decisions. However, the auto-creation process itself can make an initial query take longer than subsequent executions of the same.

**Mitigations**

If the first execution of query consistently requires statistics to be created, you'll need to [manually create statistics](/azure/synapse-analytics/sql/develop-tables-statistics#examples-create-statistics) prior to the execution of the query.

<br/>
</details>

<details><summary id="auto-create-statistics-timeouts"><b>Auto-create statistics timeouts</b></summary>

The [automatic create statistics option](/azure/synapse-analytics/sql/develop-tables-statistics#automatic-creation-of-statistics), `AUTO_CREATE_STATISTICS` is `ON` by default to help ensure the query optimizer can make good distributed plan decisions. The auto-creation of statistics occurs in response to a SELECT statement and has a 5-minute threshold to complete.  If the size of data and/or the number of statistics to be created require longer than the 5-minute threshold, the auto-creation of statistics will be abandoned so that the query can continue execution.  The failure to create the statistics can negatively impact the query optimizer's ability to generate an efficient distributed execution plan, resulting in poor query performance.

**Mitigations**

Manually [create the statistics](/azure/synapse-analytics/sql/develop-tables-statistics#examples-create-statistics) instead of relying on the auto-create feature for the identified tables/columns.

</details>

### Execution phase issues

- Use the following table to analyze the result set in [Step 2](#step-2-determine-where-the-query-is-taking-time). Determine your scenario and check the common cause for detailed information and the possible mitigation steps.

   | Scenario | Common Cause |
   |-----------|-----|
   | `EstimatedRowCount`/`ActualRowCount` < 25% | [Inaccurate estimates](#inaccurate-estimates) |
   | The `Description` value indicates `BroadcastMoveOperation` and the query references a replicated table. | [Uncached replicated tables](#uncached-replicated-tables) |
   | 1. `@ShowActiveOnly` = 0 <br/> 2. High or unexpected number of steps (`step_index`) is observed. <br/> 3. Data types of joiner columns aren't identical between tables. | [Mismatched data type/size](#mismatched-data-type-size) |
   | 1. The `Description` value indicates `HadoopBroadcastOperation`, `HadoopRoundRobinOperation` or `HadoopShuffleOperation`. <br/> 2. The `total_elapsed_time` value of a given `step_index` is inconsistent between executions. | [Ad hoc external table queries](#ad-hoc-external-table-queries) |

- Check the `total_elapsed_time` value obtained in [Step 3](#step-3-review-step-details). If it's significantly higher in a few distributions in a given step, follow the these steps:
   
   1. Check the data distribution for every table referenced in the `TSQL` field for associated `step_id` by running the following command against each:

       ```sql
       DBCC PDW_SHOWSPACEUSED(<table>);
       ```
   1. If \<minimum rows value>/\<maximum rows value> > 0.1, go to [Data skew (stored)](#data-skew-stored).
   1. Otherwise, go to [In-flight data skew](#in-flight-data-skew).

<details><summary id="inaccurate-estimates"><b>Inaccurate estimates</b></summary>

Have your statistics up-to-date to ensure that the query optimizer generates an optimal plan. When the estimated row count is significantly less than the actual counts, the statistics need to be maintained.

**Mitigations**

[Create/Update statistics](/azure/synapse-analytics/sql/develop-tables-statistics#update-statistics).

<br/>
</details>

<details><summary id="uncached-replicated-tables"><b>Uncached replicated tables</b></summary>

If you have created replicated tables, and you fail to warm the replicated table cache properly, unexpected poor performance will result due to extra data movements or the creation of a suboptimal distributed plan.

**Mitigations**

- [Warm the replicated cache](/azure/synapse-analytics/sql-data-warehouse/design-guidance-for-replicated-tables#rebuild-a-replicated-table-after-a-batch-load) after DML operations.
- If there are frequent DML operations, change the distribution of the table to `ROUND_ROBIN`.

</details>

<details><summary id="mismatched-data-type-size"><b>Mismatched data type/size</b></summary>

When joining tables, make sure that the data type and size of the joining columns match. Otherwise, it will result in unnecessary data movements that will decrease the availability of CPU, IO, and network traffic to the remainder of the workload.

**Mitigations**

Rebuild the tables to correct the related table columns that don't have identical data type and size.

<br/>
</details>

<details><summary id="ad-hoc-external-table-queries"><b>Ad hoc external table queries</b></summary>

Queries against external tables are designed with the intention of bulk loading data into the dedicated SQL pool. Ad hoc queries against external tables may suffer variable durations due to external factors, such as concurrent storage container activities.

**Mitigations**

[Load data into the dedicated SQL pool first](/azure/synapse-analytics/sql/best-practices-dedicated-sql-pool#load-then-query-external-tables) and then query the loaded data.

<br/>
</details>

<details><summary id="data-skew-stored"><b>Data skew (stored)</b></summary>

Data skew means the data isn't distributed evenly across the distributions. Each step of the distributed plan requires all distributions to complete before moving to the next step. When your data is skewed, the full potential of the processing resources, such as CPU and IO, can't be achieved, resulting in slower execution times.

**Mitigations**

Review our [guidance for distributed tables](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-distribute) to assist your choice of a more appropriate distribution column.

<br/>
</details>

<details><summary id="in-flight-data-skew"><b>In-flight data skew</b></summary>

In-flight data skew is a variant of the [data skew (stored)](#data-skew-stored) issue. But, it's not the distribution of data on disk that is skewed. The nature of the distributed plan for particular filters or grouped data causes a `ShuffleMoveOperation` type operation. This operation produces a skewed output to be consumed downstream.

**Mitigations**

- Make sure that statistics are [created and up-to-date](/azure/synapse-analytics/sql/develop-tables-statistics#update-statistics).
- Change the order of your `GROUP BY` columns to lead with a higher-cardinality column.
- Create multi-column statistics if joins cover multiple columns.
- Add query hint `OPTION(FORCE_ORDER)` to your query.
- Refactor the query.

</details>

### Wait type issues

If none of the above common issues apply to your query, the [Step 3](#step-3-review-step-details) data affords the opportunity to determine which wait types (in `wait_type` and `wait_time`) are interfering with query processing for the longest-running step. There are a large number of wait types, and they're grouped into related categories due to similar mitigations. Follow these steps to locate the wait category of your query step:

1. Identify the `wait_type` in [Step 3](#step-3-review-step-details) that is taking the most time.
1. Locate the wait type in [wait categories mapping table](/sql/relational-databases/system-catalog-views/sys-query-store-wait-stats-transact-sql#wait-categories-mapping-table) and identify the wait category it included in.
1. Expand the section related to the wait category from the following list for recommended mitigations.

<details><summary><b>Compilation</b></summary>

Follow these steps to mitigate wait type issues of the Compilation category:

1. Rebuild indexes for all objects involved in the problematic query.
1. Update statistics on all objects involved in the problematic query.
1. Test the problematic query again to validate whether the issue persists.

If the issue persists, then:

1. Create a _.sql_ file with:

    ```sql
    SET QUERY_DIAGNOSTICS ON; <Your_SQL>; SET QUERY_DIAGNOSTICS OFF;
    ```

1. Open a Command Prompt window and run the following command:

    ```cmd
    sqlcmd −S <servername>.database.windows.net −d <databasename> −U <username> −G −I −i .\<sql_file_name>.sql −y0 −o .\<output_file_name>.txt
    ```

1. Open <output_file_name>.txt in a text editor. Locate and copy paste the distribution-level execution plans (lines that begin with `<ShowPlanXML>`) from the longest-running step identified in [Step 2](#step-2-determine-where-the-query-is-taking-time) into separate text files with a _.sqlplan_ extension.

    **Note:** Each step of the distributed plan will typically have recorded 60 distribution-level execution plans. Make sure that you're preparing and comparing execution plans from the same distributed plan step.
1. The [Step 3](#step-3-review-step-details) query frequently reveals a few distributions that take much longer than others. In [SQL Server Management Studio](/sql/ssms/download-sql-server-management-studio-ssms), compare the distribution-level execution plans (from the _.sqlplan_ files created) of a long-running distribution to a fast-running distribution to analyze potential causes for differences.

</details>

<details><summary><b>Lock, Worker Thread</b></summary>

- Consider changing tables that undergo frequent, small changes to utilize a row store index instead of CCI.
- Batch up your changes and update the target with more rows on a less frequent basis.

</details>

<details><summary><b>Buffer IO, Other Disk IO, Tran Log IO</b></summary>

**Unhealthy CCIs**

Unhealthy CCIs contribute to increased IO, CPU, and memory allocation, which, in turn, negatively impacts the query performance. To mitigate this issue, try one of the following methods:

- [Assess and correct clustered columnstore index health in a dedicated SQL pool](dsql-perf-cci-health.md).
- Run and review the output of the query listed at [Optimizing clustered columnstore indexes](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-index#optimizing-clustered-columnstore-indexes) to get a baseline.
- Follow the steps to [rebuild indexes](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-index#rebuild-indexes-to-improve-segment-quality) to improve segment quality, targeting the tables involved in the example problem query.

**Outdated statistics**

Outdated statistics can cause the generation of an unoptimized distributed plan, which involves more data movement than necessary. Unnecessary data movement increases the workload not only on your data at rest but also on the `tempdb`. Because IO is a shared resource across all queries, performance impacts can be felt by the entire workload.

To remedy this situation, ensure all [statistics are up-to-date](/azure/synapse-analytics/sql/develop-tables-statistics#update-statistics), and a maintenance plan is in place to keep them updated for user workloads.

**Heavy IO workloads**

Your overall workload may be reading large amounts of data. Synapse dedicated SQL pools scale resources in accordance with the DWU. In order to achieve better performance, consider either or both:

- Utilizing a larger [resource class](/azure/synapse-analytics/sql-data-warehouse/resource-classes-for-workload-management) for your queries.
- [Increase compute resources](/azure/synapse-analytics/sql-data-warehouse/quickstart-scale-compute-portal).

</details>

<details><summary><b>CPU, Parallelism</b></summary>

| Scenario | Mitigation |
|----------|------------|
| Poor CCI Health| [Assess and correct clustered columnstore index health in a dedicated SQL pool](dsql-perf-cci-health.md) |
| User queries contain transformations | Move all formatting and other transformation logic into ETL processes so the formatted versions are stored |
| Workload improperly prioritized | Implement [workload isolation](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-workload-isolation) |
| Insufficient DWU for workload | Consider [increasing compute resources](/azure/synapse-analytics/sql-data-warehouse/quickstart-scale-compute-portal) |

<br/>
</details>

<details><summary><b>Network IO</b></summary>

If the issue occurs during a `RETURN` operation in [Step 2](#step-2-determine-where-the-query-is-taking-time),

- Reduce the number of concurrent parallel processes.
- Scale out the most impacted process to another client.

For all other data movement operations, it's probable that the network issues appear to be internal to the dedicated SQL pool. To attempt to quickly mitigate this issue, follow these steps:

1. Scale your dedicated SQL pool to DW100c
1. Scale back to your desired DWU level

</details>

<details><summary><b>SQL CLR</b></summary>

Avoid frequent use of the `FORMAT()` function by implementing an alternate way of transforming the data (for example, `CONVERT()` with style).

<br/>
</details>
