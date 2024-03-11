---
title: Assess and correct clustered columnstore index health in a dedicated SQL pool
description: Provides methods of assessment and maintenance for CCIs in an Azure Synapse Analytics dedicated SQL pool.
ms.date: 11/16/2022
author: scott-epperly
ms.author: scepperl
ms.reviewer: scepperl
---

# Assess and correct clustered columnstore index health in a dedicated SQL pool

_Applies to:_ &nbsp; Azure Synapse Analytics

This article introduces a slightly different approach to assessing clustered columnstore index (CCI) health. Follow the steps in the following sections or execute the steps in the notebook via Azure Data Studio.

[!INCLUDE [Install Azure Data Studio note](../../includes/azure/install-azure-data-studio-note.md)]

> [!div class="nextstepaction"]
> [Open Notebook in Azure Data Studio](azuredatastudio://microsoft.notebook/open?url=https://raw.githubusercontent.com/microsoft/synapse-support/main/dedicated-sql-pool/dsql-perf-cci-health.ipynb)

In general, two major factors affect the quality of a CCI:

- **Compact rowgroups and metadata** - The actual rowgroup count is close to the ideal count for the number of rows in the rowgroup.

- **Compressed rowgroups** - Rowgroups are using columnstore compression.

Other conditions, such as small tables, over-partitioned tables, or under-partitioned tables, are arguably of poor quality or health. However, these conditions are better classified as design improvement opportunities that can be assessed in [Step 4](#step-4-check-for-design-improvement-opportunities).

## Step 1: Analyze a summary of your CCI health

Use the following query to get a single row of metrics.

```sql
WITH cci_detail AS (
    SELECT t.object_id,
          rg.partition_number,
          COUNT(*) AS total_rowgroup_count,
          SUM(CASE WHEN rg.state = 1 THEN 1 END) AS open_rowgroup_count,
          CEILING((SUM(rg.[total_rows]) - SUM(rg.deleted_rows))/COUNT(DISTINCT rg.distribution_id)/1048576.) * COUNT(DISTINCT rg.distribution_id) AS [ideal_rowgroup_count],
          SUM(rg.size_in_bytes/1024/1024.) AS size_in_mb,
          SUM(CASE WHEN rg.state = 1 THEN rg.size_in_bytes END /1024/1024.) AS open_size_in_mb
   FROM sys.pdw_nodes_column_store_row_groups rg
   JOIN sys.pdw_nodes_tables nt ON rg.object_id = nt.object_id
       AND rg.pdw_node_id = nt.pdw_node_id
       AND rg.distribution_id = nt.distribution_id
   JOIN sys.pdw_table_mappings mp ON nt.name = mp.physical_name
   JOIN sys.tables t ON mp.object_id = t.object_id
   GROUP BY t.object_id,
            rg.partition_number
)
SELECT COUNT(DISTINCT object_id) AS tables_assessed_count,
       COUNT(*) AS partitions_assessed_count,
       SUM(total_rowgroup_count) AS actual_rowgroup_count,
       SUM(ideal_rowgroup_count) AS ideal_rowgroup_count,
       SUM(open_rowgroup_count) AS uncompressed_rowgroup_count,
       CAST(SUM(size_in_mb) AS DECIMAL(19, 4)) AS actual_size_in_mb,
       CAST(SUM(open_size_in_mb) AS DECIMAL(19, 4)) AS uncompressed_size_in_mb,
       CAST(((SUM(total_rowgroup_count) - SUM(ideal_rowgroup_count)) / SUM(total_rowgroup_count)) * 100. AS DECIMAL(9, 4)) AS excess_pct,
       CAST(((SUM(total_rowgroup_count) - SUM(ideal_rowgroup_count)) / SUM(total_rowgroup_count)) * 1. AS DECIMAL(9, 4)) * SUM(size_in_mb) AS excess_size_in_mb
FROM cci_detail
```

From the result, you can get an overview of the CCI health for your dedicated SQL pool. This information isn't directly actionable but helps you understand the importance of maintenance routines for achieving an ideal state.

| Column name | Description |
| --- | --- |
| `tables_assessed_count` | Count of CCI tables |
| `partitions_assessed_count` | Count of partitions<br/> **Note:** Non-partitioned tables will be counted as 1. |
| `actual_rowgroup_count` | Physical count of rowgroups |
| `ideal_rowgroup_count` | Calculated number of rowgroups that would be ideal for the number of rows |
| `uncompressed_rowgroup_count` | Number of rowgroups that contain uncompressed data. (Also known as: OPEN rows) |
| `actual_size_in_mb` | Physical size of CCI data in MB |
| `uncompressed_size_in_mb` | Physical size of uncompressed data in MB |
| `excess_pct` | Percent of rowgroups that could be further optimized |
| `excess_size_in_mb` | Estimated MB from unoptimized rowgroups |

## Step 2: Analyze detailed CCI information

The following query provides a detailed report of which table partitions are candidates for rebuilding. CCI details are provided in three metrics that help identify and prioritize tables/partitions that would benefit most from maintenance. Set the appropriate threshold values for these metrics in the `WHERE` clause, and then in the `ORDER BY` clause, use the metrics that are of most interest to you. The detailed information can also be useful to determine whether your dedicated SQL pool is being impacted by a large number of small, fragmented tables, which can lead to [delays in compilation](troubleshoot-dsql-perf-slow-query.md#unhealthy-ccis-generally).

> [!NOTE]
> The commented `fnMs_GenerateIndexMaintenanceScript` function is a table-valued function (TVF) that can generate common scripts for maintaining indexes. If you want to get the maintenance scripts in the result, uncomment lines 37 and 39. And before you run the query, use the script in the section [Generate index maintenance scripts](#generate-index-maintenance-scripts) to create the function. When running the maintenance script you get from the result, be sure to use an appropriately-sized [resource class](/azure/synapse-analytics/sql-data-warehouse/resource-classes-for-workload-management), such as largerc or xlargerc.

| Column name | Quality characteristic | Description |
| --- | --- | --- |
| `excess_pct` | Compactness | Percentage of rowgroups that could be further compacted |
| `excess_size_in_mb` | Compactness | Estimated MB from unoptimized rowgroups |
| `OPEN_rowgroup_size_in_mb` | Compression | Actual MB of uncompressed data in the index |

```sql
WITH cci_info AS(
    SELECT t.object_id AS [object_id],
          MAX(schema_name(t.schema_id)) AS [schema_name],
          MAX(t.name) AS [table_name],
          rg.partition_number AS [partition_number],
          COUNT(DISTINCT rg.distribution_id) AS [distribution_count],
          SUM(rg.size_in_bytes/1024/1024) AS [size_in_mb],
          SUM(rg.[total_rows]) AS [row_count_total],
          COUNT(*) AS [total_rowgroup_count],
          CEILING((SUM(rg.[total_rows]) - SUM(rg.[deleted_rows]))/COUNT(DISTINCT rg.distribution_id)/1048576.) * COUNT(DISTINCT rg.distribution_id) AS [ideal_rowgroup_count],
          SUM(CASE WHEN rg.[State] = 1 THEN 1 ELSE 0 END) AS [OPEN_rowgroup_count],
          SUM(CASE WHEN rg.[State] = 1 THEN rg.[total_rows] ELSE 0 END) AS [OPEN_rowgroup_rows],
          CAST(SUM(CASE WHEN rg.[State] = 1 THEN rg.[size_in_bytes]/1024./1024. ELSE 0 END) AS DECIMAL(19, 4)) AS [OPEN_rowgroup_size_in_mb],
          SUM(CASE WHEN rg.[State] = 2 THEN 1 ELSE 0 END) AS [CLOSED_rowgroup_count],
          SUM(CASE WHEN rg.[State] = 2 THEN rg.[total_rows] ELSE 0 END) AS [CLOSED_rowgroup_rows],
          CAST(SUM(CASE WHEN rg.[State] = 2 THEN rg.[size_in_bytes]/1024./1024. ELSE 0 END) AS DECIMAL(19, 4)) AS [CLOSED_size_in_mb],
          SUM(CASE WHEN rg.[State] = 3 THEN 1 ELSE 0 END) AS [COMPRESSED_rowgroup_count],
          SUM(CASE WHEN rg.[State] = 3 THEN rg.[total_rows] ELSE 0 END) AS [COMPRESSED_rowgroup_rows],
          CAST(SUM(CASE WHEN rg.[State] = 3 THEN rg.[size_in_bytes]/1024./1024. ELSE 0 END) AS DECIMAL(19, 4)) AS [COMPRESSED_size_in_mb],
          SUM(CASE WHEN rg.[State] = 3 THEN rg.[deleted_rows] ELSE 0 END) AS [COMPRESSED_rowgroup_rows_DELETED]
   FROM sys.[pdw_nodes_column_store_row_groups] rg
   JOIN sys.[pdw_nodes_tables] nt ON rg.[object_id] = nt.[object_id]
       AND rg.[pdw_node_id] = nt.[pdw_node_id]
       AND rg.[distribution_id] = nt.[distribution_id]
   JOIN sys.[pdw_table_mappings] mp ON nt.[name] = mp.[physical_name]
   JOIN sys.[tables] t ON mp.[object_id] = t.[object_id]
   GROUP BY t.object_id,
            rg.partition_number
)
, calc_excess AS(
    SELECT *,
        CAST(((total_rowgroup_count - ideal_rowgroup_count) / total_rowgroup_count) * 100. AS DECIMAL(9, 4)) AS [excess_pct],
        CAST(((total_rowgroup_count - ideal_rowgroup_count) / total_rowgroup_count) * 1. AS DECIMAL(9, 4)) * size_in_mb AS [excess_size_in_mb]
   FROM cci_info
)
SELECT calc_excess.* 
    -- , script.*
FROM calc_excess
-- CROSS APPLY dbo.fnMs_GenerateIndexMaintenanceScript(object_id, partition_number) AS script
WHERE -- set your own threshold(s) for the following; 0 is the ideal, but usually not practical
  calc_excess.[excess_size_in_mb] > 300
  OR calc_excess.excess_pct > 0.1
  OR calc_excess.OPEN_rowgroup_size_in_mb > 100
ORDER BY calc_excess.[excess_size_in_mb] DESC;
```

## Step 3: What to do when maintenance doesn't make the CCI health better

Performing maintenance on a table/partition may result in one of the following scenarios:

- `excess_pct` or `excess_size_in_mb` is larger than it was before maintenance.
- The maintenance statement fails with insufficient memory.

### Typical causes

- Insufficient resources.
- Insufficient service level (DWU).
- Table is large and not partitioned.

### Recommended mitigations

- Increase resources for the maintenance statements by changing the executing user's resource class or [workload group](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-workload-isolation).
- Temporarily increase the DWU level to perform the maintenance.
- Implement a partitioning strategy for the problematic table and then perform maintenance on the partitions.

## Step 4: Check for design improvement opportunities

Though not comprehensive, the following query can help you identify potential opportunities commonly found to cause performance or maintenance issues concerning CCIs.

| Opportunity title | Description | Recommendations |
|-------------------|-------------|-----------------|
| Small table       | Table contains fewer than 15M rows | Consider changing the index from CCI to: <ul><li>Heap for staging tables</li><li>Standard clustered index (rowstore) for dimension or other small lookups</li></ul> |
| Partitioning opportunity or under-partitioned table | Calculated ideal rowgroup count is greater than 180M (or ~188M rows) | Implement a partitioning strategy or change the existing partitioning strategy to reduce the number of rows per partition to less than 188M (approximately three row groups per partition per distribution) |
| Over-partitioned table | Table contains fewer than 15M rows for the largest partition | Consider: <ul><li>Changing the index from CCI to standard clustered index (rowstore)</li><li>Changing the partition grain to be closer to 60M rows per partition</ul> |

```sql
WITH cci_info AS (
    SELECT t.object_id AS [object_id],
          MAX(SCHEMA_NAME(t.schema_id)) AS [schema_name],
          MAX(t.name) AS [table_name],
          rg.partition_number AS [partition_number],
          SUM(rg.[total_rows]) AS [row_count_total],
          CEILING((SUM(rg.[total_rows]) - SUM(rg.[deleted_rows]))/COUNT(DISTINCT rg.distribution_id)/1048576.) * COUNT(DISTINCT rg.distribution_id) AS [ideal_rowgroup_count]
   FROM sys.[pdw_nodes_column_store_row_groups] rg
   JOIN sys.[pdw_nodes_tables] nt ON rg.[object_id] = nt.[object_id]
       AND rg.[pdw_node_id] = nt.[pdw_node_id]
       AND rg.[distribution_id] = nt.[distribution_id]
   JOIN sys.[pdw_table_mappings] mp ON nt.[name] = mp.[physical_name]
   JOIN sys.[tables] t ON mp.[object_id] = t.[object_id]
   GROUP BY t.object_id,
            rg.partition_number
)
SELECT object_id,
       MAX(SCHEMA_NAME),
       MAX(TABLE_NAME),
       COUNT(*) AS number_of_partitions,
       MAX(row_count_total) AS max_partition_row_count,
       MAX(ideal_rowgroup_count) partition_ideal_row_count,
       CASE
           -- non-partitioned tables
           WHEN COUNT(*) = 1 AND MAX(row_count_total) < 15000000 THEN 'Small table'
           WHEN COUNT(*) = 1 AND MAX(ideal_rowgroup_count) > 180 THEN 'Partitioning opportunity'
           -- partitioned tables
           WHEN COUNT(*) > 1 AND MAX(row_count_total) < 15000000 THEN 'Over-partitioned table'
           WHEN COUNT(*) > 1 AND MAX(ideal_rowgroup_count) > 180 THEN 'Under-partitioned table'
       END AS warning_category
FROM cci_info
GROUP BY object_id
```

## Generate index maintenance scripts

Run the following query to create `dbo.fnMs_GenerateIndexMaintenanceScript` function on your dedicated SQL pool. This function generates scripts to optimize your CCI in three ways. You can use this function to maintain not only CCIs but also clustered (rowstore) indexes.

**Parameters**

| Parameter name | Required | Description |
|---|:-:|---|
| `@object_id` | Y | `object_id` of the table to target |
| `@partition_number` | Y | `partition_number` from `sys.partitions` to target. If the table isn't partitioned, specify 1. |

**Output table**

| Column name | Description |
|---|---|
| `rebuild_script` | Generated `ALTER INDEX ALL ... REBUILD` statement for the given table/partition. Non-partitioned heaps will return `NULL`. |
| `reorganize_script` | Generated `ALTER INDEX ALL ... REORGANIZE` statement for the given table/partition. Non-partitioned heaps will return `NULL`. |
| `partition_switch_script` | Applies only to partitioned tables; will be `NULL` if the table isn't partitioned or if an invalid partition number is specified. If the CCI was created with an `ORDER` clause, it will be rendered. |

```sql
CREATE FUNCTION dbo.fnMs_GenerateIndexMaintenanceScript (@object_id INT, @partition_number INT = 1)
RETURNS TABLE
AS
RETURN(
    WITH base_info AS (
        SELECT
            t.object_id
            , SCHEMA_NAME(t.schema_id) AS [schema_name]
            , t.name AS table_name
            , i.index_type
            , i.index_cols
            , i.index_type_desc
            , tdp.distribution_policy_desc
            , c.name hash_distribution_column_name
        FROM sys.tables t
            JOIN (
                SELECT
                    i.object_id
                    , i.index_id
                    , MAX(i.type) AS index_type
                    , MAX(CASE WHEN i.type = 5 AND ic.column_store_order_ordinal != 0 THEN ' ORDER ' ELSE '' END)
                        + '(' + STRING_AGG(
                        CASE
                            WHEN i.type IN (1, 5) 
                                AND (ic.key_ordinal != 0 OR ic.column_store_order_ordinal != 0)
                                THEN c.name + CASE WHEN ic.is_descending_key = 1 THEN ' DESC' ELSE '' END
                        END
                        , ',') WITHIN GROUP(ORDER BY ic.column_store_order_ordinal, ic.key_ordinal) + ')' AS index_cols
                    , MAX(i.type_desc)
                        + CASE
                            WHEN MAX(i.type) IN (1, 5) THEN ' INDEX'
                            ELSE ''
                        END COLLATE SQL_Latin1_General_CP1_CI_AS AS index_type_desc
                FROM sys.indexes i
                    JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
                    JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
                WHERE i.index_id <= 1
                GROUP BY i.object_id, i.index_id
            ) AS i
                ON t.object_id = i.object_id
            JOIN sys.pdw_table_distribution_properties tdp ON t.object_id = tdp.object_id
            LEFT JOIN sys.pdw_column_distribution_properties cdp ON t.object_id = cdp.object_id AND cdp.distribution_ordinal = 1
            LEFT JOIN sys.columns c ON cdp.object_id = c.object_id AND cdp.column_id = c.column_id
        WHERE t.object_id = @object_id
    )
    , param_data_type AS (
        SELECT
            pp.function_id
            , typ.name AS data_type_name
            , CAST(CASE
                WHEN typ.collation_name IS NOT NULL THEN 1
                WHEN typ.name LIKE '%date%' THEN 1
                WHEN typ.name = 'uniqueidentifier' THEN 1
                ELSE 0
            END AS BIT) AS use_quotes_on_values_flag
        FROM sys.partition_parameters pp
            JOIN sys.types typ ON pp.user_type_id = typ.user_type_id
    )
    , boundary AS (
        SELECT
            t.object_id
            , c.name AS partition_column_name
            , pf.boundary_value_on_right
            , prv.boundary_id
            , prv.boundary_id + CASE WHEN pf.boundary_value_on_right = 1 THEN 1 ELSE 0 END AS [partition_number]
            , CASE
                WHEN pdt.use_quotes_on_values_flag = 1 THEN '''' + CAST(
                    CASE pdt.data_type_name
                        WHEN 'date' THEN CONVERT(char(10), prv.value, 120)
                        WHEN 'smalldatetime' THEN CONVERT(VARCHAR, prv.value, 120)
                        WHEN 'datetime' THEN CONVERT(VARCHAR, prv.value, 121)
                        WHEN 'datetime2' THEN CONVERT(VARCHAR, prv.value, 121)
                        ELSE prv.value
                    END    
                    AS VARCHAR(32)) + ''''
                ELSE CAST(prv.value AS VARCHAR(32))
            END AS boundary_value
        FROM sys.tables t
            JOIN sys.indexes i ON t.object_id = i.object_id AND i.index_id <= 1
            JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id AND ic.partition_ordinal = 1
            JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
            JOIN sys.partition_schemes ps ON i.data_space_id = ps.data_space_id
            JOIN sys.partition_functions pf ON ps.function_id = pf.function_id
            JOIN param_data_type pdt ON pf.function_id = pdt.function_id
            JOIN sys.partition_range_values prv ON pf.function_id = prv.function_id
        WHERE t.object_id = @object_id
    )
    , partition_clause AS (
        SELECT
            object_id
            , COUNT(*) - 1 -- should always be the 2nd to last partition in stage table
                + CASE WHEN MAX([partition_number]) = @partition_number THEN 1 ELSE 0 END -- except when last partition
                AS [source_partition_number]
            , 'WHERE ' + MAX(partition_column_name)
                + CASE WHEN MAX(CAST(boundary_value_on_right AS TINYINT)) = 1 THEN 
                    ' >= ' + MIN(CASE WHEN [partition_number] = @partition_number THEN boundary_value END)
                    ELSE 
                    ' <= ' + MAX(CASE WHEN [partition_number] = @partition_number THEN boundary_value END)
                END
                + ' AND ' + MAX(partition_column_name)
                + CASE WHEN MAX(CAST(boundary_value_on_right AS TINYINT)) = 1 THEN 
                    ' < ' + MAX(boundary_value)
                    ELSE
                    ' > ' + MIN(boundary_value)
                END AS filter_clause
            , ', PARTITION (' + MAX(partition_column_name) + ' RANGE ' 
                + CASE WHEN MAX(CAST(boundary_value_on_right AS TINYINT)) = 1 THEN 'RIGHT' ELSE 'LEFT' END 
                + ' FOR VALUES(' + STRING_AGG(boundary_value, ',') + '))' AS [partition_clause]
        FROM boundary
        WHERE [partition_number] BETWEEN @partition_number - 1 AND @partition_number + 1
        GROUP BY object_id
    )
    SELECT
        CASE WHEN index_type IN (1, 5) THEN 'ALTER INDEX ALL ON [' + [schema_name] + '].[' + [table_name] + '] REBUILD' 
            + CASE WHEN partition_clause.[object_id] IS NOT NULL THEN ' PARTITION = ' + CAST(@partition_number AS VARCHAR(16)) ELSE '' END + ';' END AS [rebuild_script]
        , CASE WHEN index_type IN (1, 5) THEN 'ALTER INDEX ALL ON [' + [schema_name] + '].[' + [table_name] + '] REORGANIZE' 
            + CASE WHEN partition_clause.[object_id] IS NOT NULL THEN ' PARTITION = ' + CAST(@partition_number AS VARCHAR(16)) ELSE '' END
            + CASE WHEN index_type = 5 THEN ' WITH (COMPRESS_ALL_ROW_GROUPS = ON)' ELSE '' END + ';' END AS [reorganize_script]
        , 'CREATE TABLE [' + schema_name + '].[' + table_name + '_p' + CAST(@partition_number AS VARCHAR(16)) + '_tmp] WITH(' + index_type_desc + ISNULL(index_cols, '')
            + ', DISTRIBUTION = ' + distribution_policy_desc + CASE WHEN distribution_policy_desc = 'HASH' THEN '(' + hash_distribution_column_name + ')' ELSE '' END
            + partition_clause.partition_clause + ') AS SELECT * FROM [' + [schema_name] + '].[' + [table_name] + '] ' + filter_clause + CASE WHEN index_type = 5 AND index_cols IS NOT NULL THEN ' OPTION(MAXDOP 1)' ELSE '' END +  ';'
            + ' ALTER TABLE [' + schema_name + '].[' + table_name + '_p' + CAST(@partition_number AS VARCHAR(16)) + '_tmp] SWITCH PARTITION ' + CAST(source_partition_number AS VARCHAR(16))
            + ' TO [' + [schema_name] + '].[' + [table_name] + '] PARTITION ' + CAST(@partition_number AS VARCHAR(16))
            + ' WITH (TRUNCATE_TARGET = ON);'
            + ' DROP TABLE [' + schema_name + '].[' + table_name + '_p' + CAST(@partition_number AS VARCHAR(16)) + '_tmp];' AS [partition_switch_script]
    FROM base_info
        LEFT JOIN partition_clause
            ON base_info.object_id = partition_clause.object_id
);
GO
```

## More information

To gain a more in-depth understanding and acquire extra assessment tools for CCI on the dedicated SQL pool, see:

- [Azure Synapse Toolbox](https://github.com/microsoft/Azure_Synapse_Toolbox)
- [Indexes on dedicated SQL pool tables in Azure Synapse Analytics](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-index)
- [Columnstore indexes: Overview](/sql/relational-databases/indexes/columnstore-indexes-overview?view=azure-sqldw-latest&preserve-view=true)
- [Performance tuning with ordered clustered columnstore index](/azure/synapse-analytics/sql-data-warehouse/performance-tuning-ordered-cci)
- [Columnstore indexes - Design guidance](/sql/relational-databases/indexes/columnstore-indexes-design-guidance)
