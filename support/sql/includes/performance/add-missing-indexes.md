Missing indexes can lead to slower running queries and high CPU usage.  You can identify missing indexes and create them to help improve this performance impact. 

1. Run the following query to identify queries that cause high CPU usage and that contain at least one missing index in the query plan:

    ```sql
    -- Captures the Total CPU time spent by a query along with the query plan and total executions
    SELECT
        qs_cpu.total_worker_time / 1000 AS total_cpu_time_ms,
        q.[text],
        p.query_plan,
        qs_cpu.execution_count,
        q.dbid,
        q.objectid,
        q.encrypted AS text_encrypted
    FROM
        (SELECT TOP 500 qs.plan_handle,
         qs.total_worker_time,
         qs.execution_count FROM sys.dm_exec_query_stats qs ORDER BY qs.total_worker_time DESC) AS qs_cpu
    CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS q
    CROSS APPLY sys.dm_exec_query_plan(plan_handle) p
    WHERE p.query_plan.exist('declare namespace 
            qplan = "http://schemas.microsoft.com/sqlserver/2004/07/showplan";
            //qplan:MissingIndexes')=1
    ```

1. Review the execution plans for the queries that are identified, and tune the query by making the required changes. The following screenshot shows an example in which SQL Server will point out a missing index for your query. Right-click the Missing index portion of the query plan, and then select **Missing Index Details** to create the index in another window in SQL Server Management Studio.

    :::image type="content" source="../../media/add-missing-indexes/high-cpu-missing-index.png" alt-text="Screenshot of the execution plan with missing index." lightbox="../../media/add-missing-indexes/high-cpu-missing-index.png":::

1. Use the following query to check for missing indexes and apply any recommended indexes that have high improvement measure values. Start with the top 5 or 10 recommendations from the output that have the highest **improvement_measure** value. Those indexes have the most significant positive effect on performance. Decide whether you want to apply these indexes and make sure that performance testing is done for the application. Then, continue to apply missing-index recommendations until you achieve the desired application performance results. For more information on this topic, see [Tune nonclustered indexes with missing index suggestions](/sql/relational-databases/indexes/tune-nonclustered-missing-index-suggestions).

    ```sql
    SELECT CONVERT(VARCHAR(30), GETDATE(), 126) AS runtime,
        mig.index_group_handle,
        mid.index_handle,
        CONVERT(DECIMAL(28, 1), migs.avg_total_user_cost * migs.avg_user_impact * (migs.user_seeks + migs.user_scans)) AS improvement_measure,
        'CREATE INDEX missing_index_' + CONVERT(VARCHAR, mig.index_group_handle) + '_' + CONVERT(VARCHAR, mid.index_handle) + ' ON ' + mid.statement + ' (' + ISNULL(mid.equality_columns,
            '') + CASE WHEN mid.equality_columns IS NOT NULL
    AND mid.inequality_columns IS NOT NULL THEN ','
    ELSE ''
    END + ISNULL(mid.inequality_columns,
            '') + ')' + ISNULL(' INCLUDE (' + mid.included_columns + ')',
            '') AS create_index_statement,
        migs.*,
        mid.database_id,
        mid.[object_id]
    FROM sys.dm_db_missing_index_groups mig
    INNER JOIN sys.dm_db_missing_index_group_stats migs ON migs.group_handle = mig.index_group_handle
    INNER JOIN sys.dm_db_missing_index_details mid ON mig.index_handle = mid.index_handle
    WHERE CONVERT (DECIMAL (28, 1),
                   migs.avg_total_user_cost * migs.avg_user_impact * (migs.user_seeks + migs.user_scans)) > 10
    ORDER BY migs.avg_total_user_cost * migs.avg_user_impact * (migs.user_seeks + migs.user_scans) DESC
    ```
