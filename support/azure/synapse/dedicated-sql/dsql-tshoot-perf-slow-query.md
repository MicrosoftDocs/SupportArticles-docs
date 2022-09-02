<!--
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.14.1
  kernelspec:
    display_name: SQL
    language: sql
    name: SQL
-->

<!-- #region azdata_cell_guid="5c530759-ab09-4ee1-b9b1-261fd5811aa5" -->
# Troubleshoot a Slow Query on Dedicated SQL Pool

> [!NOTE]
>Before attempting to open this notebook, check that Azure Data Studio is installed on your local machine. To install, go to [Learn how to install Azure Data Studio](/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver16).

> [!div class="nextstepaction"]
> [Open Notebook in Azure Data Studio](azuredatastudio://microsoft.notebook/open?url=https://raw.githubusercontent.com/microsoft/synapse-support/main/dedicated-sql-pool/dsql-tshoot-perf-slow-query.ipynb)



Use this guide to help you identify the common reasons and apply mitigations for a given query's slow execution on an Azure Synapse Analytics dedicated SQL pool.  The first three steps walk you through collecting telemetry which describes the lifecycle of a query.  Use the reference at the end of the article to help you analyze potential opportunities found in the data collected.

> **IMPORTANT**: Though more details will be given below, it's worth noting that the majority of performance issues reported to Microsoft are caused by either:
> 
> 1. Outdated statistics
> 2. Unhealthy clustered columnstore indexes (CCI)
> 
> **Ensuring that statistics are [created and up-to-date](/azure/synapse-analytics/sql/develop-tables-statistics#update-statistics) and [CCIs have been rebuilt](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-index#rebuild-indexes-to-improve-segment-quality) may very well save you hours of troubleshooting.**
<!-- #endregion -->

<!-- #region azdata_cell_guid="3de87de0-1367-4bb9-a81a-6bb08a8ece0b" -->
## Step 1: Identify the request\_id (aka QID)

The request\_id of the slow query is required to research potential reasons for a slow query. Use the below queries as a starting point for identifying the query you wish to research. Once identified, copy the request\_id as it will be required for subsequent steps.  Please note that it is quite likely that you will typically want to modify the query in this step to better target known problem queries.  Some helpful tips for modifying the query are:

* Sort by either `submit_time DESC` or `total_elapsed_time DESC` to have the longest-running queries present at the top of the result set
* Use `OPTION(LABEL='<your-label-here>')` in queries and then modify the query to filter on the [label] column
* Consider filtering out any QIDs which do not have a value for [resource_allocation_percentage] when you know the statement is contained in a batch. **NOTE: be cautious with this filter as it can mask some queries which are being blocked by other sessions.
<!-- #endregion -->

```sql azdata_cell_guid="28348e05-a11e-4dda-8907-4fe080fd2e7d" tags=[] extensions={"notebookviews": {"views": []}}
-- Monitor active queries
SELECT *
FROM sys.dm_pdw_exec_requests
WHERE status not in ('Completed','Failed','Cancelled')
  AND session_id <> session_id()
  --AND [label] = "your-label-here"
  --AND resource_allocation_percentage is not NULL
ORDER BY submit_time DESC;

-- Find top 10 queries longest running queries
-- SELECT TOP 10 *
-- FROM sys.dm_pdw_exec_requests
-- ORDER BY total_elapsed_time DESC;
```

<!-- #region language="sql" azdata_cell_guid="9738e7aa-5f80-456b-85e0-e537879e6bd5" -->
## Step 2: Determine where the query is taking time

Having chosen a \[request\_id\] (aka QID) from Step 1, update the variables on line 1 of the script below accordingly. Change the @ShowActiveOnly variable to 1 to get the full picture of the distributed plan.

| Parameter | Description |
| --- | --- |
| @QID | request\_id obtained in Step 1 |
| @ShowActiveOnly | 0 = Show all steps for the query<br>1 = Show only the currently active step |

Once ran, you may want to pause and review the common issues
<!-- #endregion -->

```sql azdata_cell_guid="feb7b1df-6ecd-4d48-b9b4-dd1e6b9e1769" tags=["hide_input"] extensions={"notebookviews": {"views": []}}
DECLARE @QID varchar(16) = 'QIDXXXXX', @ShowActiveOnly bit = 1;

-- Retrieve session_id of QID
DECLARE @session_id varchar(16) = (SELECT session_id FROM sys.dm_pdw_exec_requests WHERE request_id = @QID);

-- Blocked by Compilation or Resrouce Allocation (Concurrency)
SELECT @session_id AS session_id,
       @QID AS request_id,
       -1 AS [StepIndex],
       'Compilation' AS [Phase],
       'Blocked waiting on ' + max(   CASE
                                          WHEN waiting.type = 'CompilationConcurrencyResourceType' THEN
                                              'Compilation Concurrency'
                                          WHEN waiting.type like 'Shared-%' THEN
                                              ''
                                          ELSE
                                              'Resource Allocation (Concurrency)'
                                      END
                                  ) + max(   CASE
                                                 WHEN waiting.type like 'Shared-%' THEN
                                                     ' for ' + replace(waiting.type, 'Shared-', '')
                                                 ELSE
                                                     ''
                                             END
                                         ) AS [Description],
       max(waiting.request_time) AS [StartTime],
       getdate() AS [EndTime],
       datediff(ms, max(waiting.request_time), getdate()) / 1000.0 AS [Duration],
       NULL AS [Status],
       NULL AS [EstimatedRowCount],
       NULL AS [ActualRowCount],
       NULL AS [TSQL]
FROM sys.dm_pdw_waits waiting
WHERE waiting.session_id = @session_id
      AND (
              TYPE like 'Shared-%'
              OR TYPE in ( 'ConcurrencyResourceType', 'UserConcurrencyResourceType',
                           'CompilationConcurrencyResourceType'
                         )
          )
      AND state = 'Queued'
GROUP BY session_id 
-- Blocked by another query
UNION ALL
SELECT @session_id AS session_id,
       @QID AS request_id,
       -1 AS [StepIndex],
       'Compilation' AS [Phase],
       'Blocked by ' + blocking.session_id + ':' + blocking.request_id + ' when requesting ' + waiting.type + ' on '
       + quotename(waiting.object_type) + waiting.object_name AS [Description],
       waiting.request_time AS [StartTime],
       getdate() AS [EndTime],
       datediff(ms, waiting.request_time, getdate()) / 1000.0 AS [Duration],
       NULL AS [Status],
       NULL AS [EstimatedRowCount],
       NULL AS [ActualRowCount],
       COALESCE(blocking_exec_request.command, blocking_exec_request.command2) AS [TSQL]
FROM sys.dm_pdw_waits waiting
    INNER JOIN sys.dm_pdw_waits blocking
        ON waiting.object_type = blocking.object_type
           AND waiting.object_name = blocking.object_name
    INNER JOIN sys.dm_pdw_exec_requests blocking_exec_request
        ON blocking.request_id = blocking_exec_request.request_id
WHERE waiting.session_id = @session_id
      AND waiting.state = 'Queued'
      AND blocking.state = 'Granted'
      AND waiting.type != 'Shared' 
-- Request Steps
UNION ALL
SELECT @session_id AS session_id,
       @QID AS request_id,
       step_index AS [StepIndex],
       'Execution' AS [Phase],
       operation_type + ' (' + location_type + ')' AS [Description],
       start_time AS [StartTime],
       end_time AS [EndTime],
       total_elapsed_time / 1000.0 AS [Duration],
       status AS [Status],
       CASE
           WHEN estimated_rows > -1 THEN
               estimated_rows
       END AS [EstimatedRowCount],
       CASE
           WHEN ROW_COUNT > -1 THEN
               ROW_COUNT
       END AS [ActualRowCount],
       command AS [TSQL]
FROM sys.dm_pdw_request_steps
WHERE request_id = @QID
      AND status = CASE @ShowActiveOnly
                       WHEN 1 THEN
                           'Running'
                       ELSE
                           status
                   END
ORDER BY StepIndex;
```

<!-- #region language="sql" azdata_cell_guid="ca60e492-d0a3-412a-b478-70be188cfb37" -->
## Step 3: Review step details

Having chosen a \[step\_index\] to review from Step 2, update the variables on line 1 of the script below accordingly. Change the @ShowActiveOnly variable to 1 to compare all distribution timings.

| Parameter | Description |
| --- | --- |
| @QID | request\_id obtained in Step 1 |
| @StepIndex | \[step\_index\] identified in Step 2 |
| @ShowActiveOnly | 0 = Show all distributions for the given \[step\_index\]<br>1 = Show only the currently active distributions for the given \[step\_index\] |
<!-- #endregion -->

```sql azdata_cell_guid="2518a46a-a8e1-4e20-91da-24b1aa094e55" tags=["hide_input"]
DECLARE @QID varchar(16) = 'QIDXXXXX', @StepIndex int = 2, @ShowActiveOnly bit = 1;

WITH dists
AS (SELECT request_id,
           step_index,
           'sys.dm_pdw_sql_requests' AS source_dmv,
           distribution_id,
           pdw_node_id,
           spid,
           'NativeSQL' AS [type],
           status,
           start_time,
           end_time,
           total_elapsed_time
    FROM sys.dm_pdw_sql_requests
    WHERE request_id = @QID
          AND step_index = @StepIndex
    UNION ALL
    SELECT request_id,
           step_index,
           'sys.dm_pdw_dms_workers' AS source_dmv,
           distribution_id,
           pdw_node_id,
           sql_spid AS spid,
           TYPE,
           status,
           start_time,
           end_time,
           total_elapsed_time
    FROM sys.dm_pdw_dms_workers
    WHERE request_id = @QID
          AND step_index = @StepIndex
   )
SELECT sr.step_index,
       sr.distribution_id,
       sr.pdw_node_id,
       sr.spid,
       sr.type,
       sr.status,
       sr.start_time,
       sr.end_time,
       sr.total_elapsed_time,
       owt.wait_type,
       owt.wait_time
FROM dists sr
    LEFT JOIN sys.dm_pdw_nodes_exec_requests owt
        ON sr.pdw_node_id = owt.pdw_node_id
           AND sr.spid = owt.session_id
           AND (
                   sr.source_dmv = 'sys.dm_pdw_sql_requests'
                   AND sr.status = 'Running' -- sys.dm_pdw_sql_requests status

                   OR sr.source_dmv = 'sys.dm_pdw_dms_requests'
                      AND sr.status not like 'Step[CE]%'
               ) -- sys.dm_pdw_dms_workers final statuses

WHERE sr.request_id = @QID
      AND (
              sr.source_dmv = 'sys.dm_pdw_sql_requests'
              AND sr.status = CASE
                                  WHEN @ShowActiveOnly = 1 THEN
                                      'Running'
                                  ELSE
                                      sr.status
                              END
              OR sr.source_dmv = 'sys.dm_pdw_dms_workers'
                 AND sr.status not like CASE
                                            WHEN @ShowActiveOnly = 1 THEN
                                                'Step[CE]%'
                                            ELSE
                                                ''
                                        END
          )
      AND sr.step_index = @StepIndex
ORDER BY distribution_id
```

<!-- #region language="sql" azdata_cell_guid="68940a9b-064f-403f-b63d-92c0ae06e891" -->
## Step 4: Look for common issues

After noting the [Phase] column in Step 2, expand the following sections of common issues to help you idenity potential mitigations:



<!-- #endregion -->

<!-- #region language="sql" azdata_cell_guid="e28356dd-1dbb-420e-b899-6c5bf8daa0c8" -->
### Compilation Phase Issues

<details><summary>Blocked: Compilation Concurrency</summary>
<p>

#### Description

Concurrency Compilation blocks rarely occur.  However, if you encounter this type of block, it signifies that a large volume of queries were submitted in very short order and have been queued to begin compilation.

#### How to identify and mitigate

| Identified By | Mitigations |
|-----------------|-------------|
| \* Indicated by value of "Compilation Concurrency" in \[Description\] field of Step 2 |  \* Reduce number of queries subimitted concurrently |

</p>
</details>

<details><summary>Blocked: Resource Allocation</summary>
<p>

#### Description

Being blocked for Resource Allocation means that your query is waiting its turn in line to execute based on:

1. the amount of memory granted based on the resource class or workload group assignment associated to the user
2. the amount of available memory on the system and/or workload group
3. (optional) workload group/classifier importance

#### How to identify and mitigate

| Identified By | Mitigations |
|-----------------|-------------|
| \* Indicated by value of "Resource Allocation (Concurrency)" in \[Description\] field of Step 2 |  \* Wait for blocking session to complete<br>\* Evaluate [resource class choice](/azure/synapse-analytics/sql-data-warehouse/resource-classes-for-workload-management#example-code-for-finding-the-best-resource-class) (see [concurrency limits](/azure/synapse-analytics/sql-data-warehouse/memory-concurrency-limits) for more information)<br>\* [KILL](/sql/t-sql/language-elements/kill-transact-sql?view=sql-server-ver16) blocking session\_id |

</p>
</details>

<details><summary>Complex query or older JOIN syntax</summary>
<p>

#### Description

Complex queries (meaning the query involves a high number of joins and/or subqueries) or queries which do not utilize an ANSI-92 style JOIN (joiners in FROM clause) can encounter situations where the default query optimizer methods are proven ineffective, causing the compilation phase to take a long time.  Though these scenarios are atypical, you have options to attempt to override the default behavior to reduce the time it takes for the query optimizer to choose a plan.

#### How to identify and mitigate

| Identified By | Mitigations |
|-----------------|-------------|
| \* Statement in 'Running' status in Step 1, but no step information in Step 2<br>\* and Statement contains complex join\\filtering logic or performs joins in WHERE clause | \* Use ANSI-92 style JOINs<br>\* Add query hints: OPTION(FORCE ORDER, USE HINT ('FORCE\_LEGACY\_CARDINALITY\_ESTIMATION'))<br>\* Break query into multiple, less complex steps |

</p>
</details>

<details><summary>Long-running DROP TABLE or TRUNCATE TABLE</summary>
<p>

#### Description

For execution time efficiencies, the DROP TABLE and TRUNCATE TABLE statements will defer storage cleanup to a background process.  However, in the event your workload performs a high number of DROP/TRUNCATE TABLE statements in a short time frame, it's possible that metadata can become congested and cause subsequent DROP/TRUNCATE TABLE statements to execute slowly.

#### How to identify and mitigate

| Identified By | Mitigations |
|-----------------|-------------|
| \* Statement in 'Running' status in Step 1, but no step information in Step 2<br>\* and Statement is a long-running DROP TABLE or TRUNCATE TABLE statement<br>\* and Statement is not being blocked | \* Identify a maintenance window, stop all workload, and run [DBCC SHRINKDATABASE](/sql/t-sql/database-console-commands/dbcc-shrinkdatabase-transact-sql?view=sql-server-ver15) to force immediate cleanup of previously dropped/truncated tables |

</p>
</details>

<details><summary>Unhealthy CCIs (generally)</summary>
<p>

#### Description

Poor clustered columnstore index (CCI) health requires additional metadata which can cause the query optimizer to take additional time to determine an optimal plan.  To avoid this scenario, ensure that all of your CCIs are in good health.

#### How to identify and mitigate

| Identified By | Mitigations |
|-----------------|-------------|
| \* Statement in 'Running' status in Step 1, but no step information in Step 2<br>\* and CCIs have high percentage of deleted or open rows (see [Optimizing clustered columnstore indexes](/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-index#optimizing-clustered-columnstore-indexes)) | \* [Rebuild clustered columnstore indexes](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-memory-optimizations-for-columnstore-compression) |

</p>
</details>

<details><summary>Auto-create Statistics</summary>
<p>

#### Description

The auto-creation of statistics feature is enabled by default to help ensure the query optimizer can make good distributed plan decisions.  However, the auto-creation process itself can make a query appear to take longer than subsequent executions of the same.  Moreover, some development patterns may afford repeated statistics creation attempts if the target object is large.

#### How to identify and mitigate

| Identified By | Mitigations |
|-----------------|-------------|
| \* One or more CREATE STATISTCS statements executed immediately after slow query submission (discoverable in Step 1)<br>* NOTE: the CREATE STATISTICS statement has a timeout of 5m | \* Manually create the statistics instead of relying on the auto-create feature |

</p>
</details>

<!-- #endregion -->

<!-- #region language="sql" azdata_cell_guid="df25d73d-b0d7-4734-83cf-b2cfc48abe7a" -->
<br>

### Execution Phase Issues


<details><summary>Inaccurate estimates</summary>
<p>

#### Description

Having your statistics up-to-date is critical to ensuring the query optimizer can generate an optimal plan.  When the telemetry indicates poor estimated rows when compared to actual counts, it is an indicator that statistics need to be maintained.

#### How to identify and mitigate

| Identified By | Mitigations |
|-----------------|-------------|
| \* In Step 2, \[EstimatedRowCount\] not within 25% of \[ActualRowCount\] | \* [Create/Update statistics](/azure/synapse-analytics/sql/develop-tables-statistics#update-statistics) |

</p>
</details>

<details><summary>Uncached replicated tables</summary>
<p>

#### Description

If you have created replicated tables, failure to properly warm the replicated table cache can result in unexpected poor performance due to additional data movement or the creation of a sub-optimal distributed plan.

#### How to identify and mitigate

| Identified By | Mitigations |
|-----------------|-------------|
| \* \[Description\] indicates BroadcastMoveOperation and TSQL references known replicated table | \* [Warm the replicated cache](/en-us/azure/synapse-analytics/sql-data-warehouse/design-guidance-for-replicated-tables#rebuild-a-replicated-table-after-a-batch-load) after DML<br>\* If frequent DML, change distribution of table to ROUND\_ROBIN |

</p>
</details>

<details><summary>Mismatched data type/size</summary>
<p>

#### Description

When joining tables, it is important to ensure that the data type and size of the joining columns match.  Failure to follow this guidance will result in unnecessary data movement which decreases the availability of CPU, IO, and network traffic to the remainder of the workload.

#### How to identify and mitigate

| Identified By | Mitigations |
|-----------------|-------------|
 | \* High or unexpected number of steps (\[step\_index\]) discovered in Step 2 when @ShowActiveOnly = 0<br>\* and data types of joiner columns are not identical between tables | \* Correct any related table columns which do not have identical data type and size by rebuiling the tables |

</p>
</details>

<details><summary>Inconsistent timings for external table queries</summary>
<p>

#### Description

Queries over external tables were design with the intention of bulk loading data into the dedicated SQL pool.  Ad hoc queries against external tables, though functions, may suffer variable durations due to external factors such as concurrent storage container activities.

#### How to identify and mitigate

| Identified By | Mitigations |
|-----------------|-------------|
| \* \[Description\] in Step 2 is HadoopBroadcastOperation, HadoopRoundRobinOperation, or HadoopShuffleOperation<br>\* and \[total\_elapsed\_time\] of for a given \[step\_index\] in Step 2 is inconsistent between executions | \* [Load data into the dedicated SQL pool first](/azure/synapse-analytics/sql/best-practices-dedicated-sql-pool#load-then-query-external-tables) and then query |

</p>
</details>

<details><summary>Data skew (stored)</summary>
<p>

#### Description

Data skew means the data is not distributed evenly across the distributions.  Each step of the distributed plan requires all distributions complete before moving to the next step.  When your data is skewed, the full potential of the processing resources, such as CPU and IO, cannot be achieved, resulting in slower execution times.

#### How to identify and mitigate

| Identified By | Mitigations |
|-----------------|-------------|
| \* \[total\_elapsed\_time\] in Step 3 is significantly higher in a small number of distributions<br>\* and `DBCC PDW_SHOWSPACEUSED(< TableName >)` for tables involved in the query have (Smallest Distribution) / (Largest Distribution) \> .1 (or 10%) | \* Review our [guidance for distributed tables](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-distribute) to assist your choice of a more appropriate distribution column |

</p>
</details>

<details><summary>In-flight data skew</summary>
<p>

#### Description

In-flight data skew is a variant of the aforementioned data skew issue.  However, in this case, it's not the distribution of data on disk that is skewed.  Instead, the nature of the distributed plan for particular filters or grouped data causes a `ShuffleMoveOperation` which produces a skewed output to be consumed downstream.

#### How to identify and mitigate

| Identified By | Mitigations |
|-----------------|-------------|
| \* \[total\_elapsed\_time\] in Step 3 is significantly higher in a small number of distributions for a particular step and<br>\* Tables involved in the query **do not** indicate storage skew (see Data skew (stored) for more information) | \* Change the order of your GROUP BY columns to lead with a higher cardinality column<br>\* Create multi-column statistic if joins cover multiple columns<br>\* Add query hint `OPTION(FORCE_ORDER)` to your query<br>\* Refactor the query |

</p>
</details>
<!-- #endregion -->

<!-- #region language="sql" azdata_cell_guid="329ffe48-f904-4425-8bf3-4c0e3f0e54ae" -->
<br>

### Wait Type issue indicators

If none of the above common issues apply to your query, the Step 3 data set affords the opportunity to determine which wait types (in \[wait\_type\] and \[wait\_time\]) are interfering with query processing for the longest-running step. Because there are a large number of wait types and the mitigations are similar, we have grouped them into related categories using the [wait categories mapping table](/sql/relational-databases/system-catalog-views/sys-query-store-wait-stats-transact-sql?view=sql-server-ver16#wait-categories-mapping-table) from Query Store. To track this:

1. Identify the \[wait\_type\] in Step 3 which is taking the most time
2. Locate the wait type in [Wait Categories](/sql/relational-databases/system-catalog-views/sys-query-store-wait-stats-transact-sql?view=sql-server-ver16#wait-categories-mapping-table) and note the Wait Category it is part of.
3. Locate and expand the Wait Category below to review mitigation recommendations


<details><summary>Compilation</summary>
<p>

#### Mitigations

1. Rebuild indexes for all objects involved in the problematic query
2. Update statistics on all objects involved in the problematic query
3. Test the problematic query again to validate the issue still persists

If issue persists:

4. Create a .sql file containing the following:

```SQL
SET QUERY_DIAGNOSTICS ON; < your_SQL_here >; SET QUERY_DIAGNOSTICS OFF;
```

5. Open a command shell and run the following command, replacing with appropriate values:

```
sqlcmd −S <servername>.database.windows.net −d <databasename> −U <username> −G −I −i .\<sql_file_name>.sql −y0 −o .\<output_file_name>.txt
```

6. Open <output_file_name>.txt in a text editor to locate and copy/paste the distribution-level execution plans (lines that begin with `<ShowPlanXML>`) from the longest-running step identified in Step 2 into separate text files with a .sqlplan extension
    - NOTE: each step of the distributed plan will have recorded (typically) 60 distribution-level execution plans.  You will need to ensure you are preparing and comparing execution plans from the same distributed plan step.
7. The Step 3 query frequently reveal a small number of distributions which take much longer than others.  Using [SQL Server Management Studio](/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16), compare the distribution-level execution plans (from the .sqlplan files created) of a long-running distribution to a fast-running distribution to analyze potential causes for differences.

</p>
</details>

<details><summary>Lock, Worker Thread</summary>
<p>

#### Mitigations

* Consider changing tables which undergo frequent, small changes to utilize a row store index instead of CCI
* Batch up your changes and update the target with more rows on a less frequent basis 

</p>
</details>


<details><summary>Buffer IO, Other Disk IO, Tran Log IO</summary>
<p>

#### Mitigations

##### Unhealthy CCIs

Unhealthy CCIs contribute to increased IO, CPU, and memory allocation which, in turn, negatively impacts query performance. To mitigate this issue:

* Run and review the output of the query listed at [Optimizing clustered columnstore indexes](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-index#optimizing-clustered-columnstore-indexes) to get a baseline.
* Follow the steps to [Rebuild indexes](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-index#rebuild-indexes-to-improve-segment-quality) to improve segment quality, targeting the tables involved in the example problem query.

##### Outdated Statistics

Outdated statistics can cause the generation of an unoptimized distributed plan which involved more data movement than necessary. Unncessary data movement increased the workload not only on your data at rest, but also on tempdb. Because IO is a shared resource across all queries, performance impacts can be felt by the entire workload. To remedy this condition, 

* ensure all [statistics are up-to-date](/azure/synapse-analytics/sql/develop-tables-statistics#update-statistics) and a maintenance plan is in place to keep them updated for user workloads

##### Heavy IO Workloads

Your overall workload may possibly be reading very large amounts of data. Synapse dedicated SQL pools scale resources in accordance with the DWU. In order to achieve better performance, you may need to consider:

* utilizing a larger [resource class](/azure/synapse-analytics/sql-data-warehouse/resource-classes-for-workload-management) for your queries<br>
* and/or [increase compute resources](/azure/synapse-analytics/sql-data-warehouse/quickstart-scale-compute-portal) 

</p>
</details>


<details><summary>CPU, Parallelism</summary>
<p>

#### Mitigations

##### Poor CCI Health

* [Rebuild clustered columnstore indexes](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-memory-optimizations-for-columnstore-compression) using at least a largerc resource class

##### User queries contain transformations

* Move all formatting and other transformation logic into ETL processes so the formatted versions are stored

##### Workload improperly prioritized

* Implement [Workload Isolation](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-workload-isolation)

##### Insufficient DWU for workload

* Consider [increasing compute resources](/azure/synapse-analytics/sql-data-warehouse/quickstart-scale-compute-portal) 

</p>
</details>


<details><summary>Network IO</summary>
<p>

#### Mitigations

If the issue is occuring during a RETURN operation in Step 2

* Reduce the number of concurrent parallel processes
* Scale out the most impacted process to another client

For all other data movement operations, it's probable that the network issues appear to be internal to the dedicated SQL pool. To attempt to quickly mitigate this issue, we recommend that you:

* Scale your dedicated SQL pool to DW100c and then
* Scale back to your desired DWU level

</p>
</details>


<details><summary>SQL CLR</summary>
<p>

#### Mitigations

* Avoid frequent use of the FORMAT() function by instead implementing an alternate means of transforming the data (example: CONVERT() with style)

</p>
</details>

<!-- #endregion -->
