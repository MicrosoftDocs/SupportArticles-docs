---
title: Check statistics accuracy on a dedicated SQL pool
description: Provides methods of assessing statistics accuracy on a dedicated SQL pool.
ms.date: 12/16/2022
ms.reviewer: scepperl, v-sidong
---

# Check statistics accuracy on a dedicated SQL pool

_Applies to:_ &nbsp; Azure Synapse Analytics

Updated statistics are critical to the generation of an optimal execution plan. There are two different perspectives you should evaluate as it pertains to determining statistics accuracy:

## Step 1: Verify control node row count accuracy

In the [dedicated SQL pool](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-overview-what-is), the primary engine for creating distributed query plans needs to be kept updated about the number of rows on the compute nodes. Run the following query to identify tables that have disparities between the row counts:

```sql
SELECT objIdsWithStats.[object_id]
    ,actualRowCounts.[schema]
    ,actualRowCounts.logical_table_name
    ,statsRowCounts.stats_row_count
    ,actualRowCounts.actual_row_count
    ,row_count_difference = CASE 
        WHEN actualRowCounts.actual_row_count >= statsRowCounts.stats_row_count
            THEN actualRowCounts.actual_row_count - statsRowCounts.stats_row_count
        ELSE statsRowCounts.stats_row_count - actualRowCounts.actual_row_count
        END
    ,percent_deviation_from_actual = CASE 
        WHEN actualRowCounts.actual_row_count = 0
            THEN statsRowCounts.stats_row_count
        WHEN statsRowCounts.stats_row_count = 0
            THEN actualRowCounts.actual_row_count
        WHEN actualRowCounts.actual_row_count >= statsRowCounts.stats_row_count
            THEN CONVERT(NUMERIC(18, 0), CONVERT(NUMERIC(18, 2), (actualRowCounts.actual_row_count - statsRowCounts.stats_row_count)) / CONVERT(NUMERIC(18, 2), actualRowCounts.actual_row_count) * 100)
        ELSE CONVERT(NUMERIC(18, 0), CONVERT(NUMERIC(18, 2), (statsRowCounts.stats_row_count - actualRowCounts.actual_row_count)) / CONVERT(NUMERIC(18, 2), actualRowCounts.actual_row_count) * 100)
        END
    ,'UPDATE STATISTICS ' + quotename(actualRowCounts.[schema]) + '.' + quotename(actualRowCounts.logical_table_name) + ';' as update_stats_stmt
FROM (
    SELECT DISTINCT object_id
    FROM sys.stats
    WHERE stats_id > 1
    ) objIdsWithStats
LEFT JOIN (
    SELECT object_id
        ,sum(rows) AS stats_row_count
    FROM sys.partitions
    GROUP BY object_id
    ) statsRowCounts ON objIdsWithStats.object_id = statsRowCounts.object_id
LEFT JOIN (
    SELECT sm.name [schema]
        ,tb.name logical_table_name
        ,tb.object_id object_id
        ,SUM(rg.row_count) actual_row_count
    FROM sys.schemas sm
    INNER JOIN sys.tables tb ON sm.schema_id = tb.schema_id
    INNER JOIN sys.pdw_table_mappings mp ON tb.object_id = mp.object_id
    INNER JOIN sys.pdw_nodes_tables nt ON nt.name = mp.physical_name
    INNER JOIN sys.dm_pdw_nodes_db_partition_stats rg ON rg.object_id = nt.object_id
        AND rg.pdw_node_id = nt.pdw_node_id
        AND rg.distribution_id = nt.distribution_id
    INNER JOIN sys.indexes ind on tb.object_id = ind.object_id
    WHERE rg.index_id < 2 -- In case this condition removed the number of rows will gets duplicated based on the number of index.
	AND ind.type_desc IN ('CLUSTERED COLUMNSTORE', 'HEAP') -- Switch between the CCI (Column store) and HEAP, You should at least keep one value or else the total number of rows will gets duplicated based on the number of indexes.
    GROUP BY sm.name
        ,tb.name
        ,tb.object_id
    ) actualRowCounts ON objIdsWithStats.object_id = actualRowCounts.object_id
```

## Step 2: Make sure statistics are up-to-date

Updating data can significantly affect the statistics histograms used to generate effective execution plans. Run the following query to determine whether the last updated date of your statistics aligns with the modification patterns of the table:

```sql
SELECT ob.[object_id],max(sm.[name]) AS [schema_name]
    ,max(tb.[name]) AS [table_name]
    ,st.[stats_id]
    ,max(st.[name]) AS [stats_name]
    ,string_agg(co.[name], ',') AS [stats_column_names]
    ,STATS_DATE(ob.[object_id], st.[stats_id]) AS [stats_last_updated_date]
    ,'UPDATE STATISTICS ' + quotename(max(sm.[name])) + '.' + quotename(max(tb.[name])) + ';' as [update_stats_stmt]
FROM sys.objects ob
JOIN sys.stats st ON ob.[object_id] = st.[object_id]
JOIN sys.stats_columns sc ON st.[stats_id] = sc.[stats_id]
    AND st.[object_id] = sc.[object_id]
JOIN sys.columns co ON sc.[column_id] = co.[column_id]
    AND sc.[object_id] = co.[object_id]
JOIN sys.types ty ON co.[user_type_id] = ty.[user_type_id]
JOIN sys.tables tb ON co.[object_id] = tb.[object_id]
JOIN sys.schemas sm ON tb.[schema_id] = sm.[schema_id]
WHERE st.[stats_id] > 1
GROUP BY ob.[object_id], st.[stats_id]
ORDER BY stats_last_updated_date
```

## Step 3: Update statistics on identified tables

After identifying candidate tables in the previous steps, run the statement(s) generated in the `update_stats_stmt` column of the queries to update the statistics.

> [!NOTE]
> We don't recommend updating individual statistics, even when user-created. By running `UPDATE STATISTICS` without specifying a statistics name, all statistics associated with the table, as well as the control node row count, will be updated. You may consider overriding the default scan percentage by using `WITH FULLSCAN` or `WITH SAMPLE <SamplePercent> PERCENT` to achieve appropriate accuracy for large tables. See [UPDATE STATISTICS (Transact-SQL)](/sql/t-sql/statements/update-statistics-transact-sql) for the full syntax.

For example:

```sql
UPDATE STATISTICS [dbo].[MyAwesomeTable];
```

After updating statistics, rerun the problem query to determine if the statistics updates have improved the execution duration.

## More resources for statistics maintenance

* [Statistics in Synapse SQL](/azure/synapse-analytics/sql/develop-tables-statistics)
* [Best practices for dedicated SQL pools in Azure Synapse Analytics](/azure/synapse-analytics/sql/best-practices-dedicated-sql-pool#maintain-statistics)
