---
title: Evaluate PDW statistics accuracy
description: This article provides a method to test the accuracy of the PDW statistics of a PDW table or all tables in a PDW database based off the total row count.
ms.date: 07/22/2020
ms.custom: sap:Parallel Data Warehouse (APS)
ms.topic: how-to
---
# Evaluate PDW statistics accuracy

This article shows how to evaluate the accuracy of the PDW statistics of a PDW table or all tables in a PDW database based off the total row count.

_Original product version:_ &nbsp; SQL Server 2012 Parallel Data Warehouse (APS), SQL Server 2008 R2 Parallel Data Warehouse  
_Original KB number:_ &nbsp; 3046875

## Summary

This article contains a query to compare the actual row count and the row count in the Parallel Data Warehouse statistics for a specific table or for all tables in the current database. If the row count values differ too greatly, Parallel Data Warehouse does not have accurate statistics for that table. This can cause the Parallel Data Warehouse optimizer to choose operations and data movements that are not efficient and that could cause long query run times.

## More information

Run the following query to show a comparison between the actual row count and the CTL row count that is displayed in the Parallel Data Warehouse statistics:

```sql
SELECT db_name() as [Database],
    pdwtbl.name as [Table],
    Sum(part.rows)/ max(pdwpart.partition_number)/8 AS CMP_ROW_COUNT,
    sum(pdwpart.rows)/max(size.distribution_id)/max(pdwpart.partition_number)/8 AS CTL_ROW_COUNT
FROM sys.pdw_nodes_partitions part
JOIN sys.pdw_nodes_tables tbl
    ON part.object_id = tbl.object_id
    AND part.pdw_node_id = tbl.pdw_node_id
JOIN sys.pdw_distributions size
    on size.pdw_node_id = tbl.pdw_node_id
JOIN sys.pdw_table_mappings map
    ON map.physical_name = tbl.name
JOIN sys.tables pdwtbl
    ON pdwtbl.object_id = map.object_id
JOIN sys.partitions pdwpart
    ON pdwpart.object_id = pdwtbl.object_id
join sys.pdw_table_distribution_properties dist
    on pdwtbl.object_id = dist.object_id
WHERE dist.distribution_policy = 2
-- uncomment the below if you are looking for row counts for a specific table
-- this table will also need to be added below
-- and pdwtbl.name = 'table_name'
GROUP BY pdwtbl.name
UNION ALL
SELECT db_name() as [Database],
    pdwtbl.name,
    Sum(part.rows)/ sum(pdwpart.partition_number) AS CMP_ROW_COUNT,
    sum(pdwpart.rows) /max(pdwpart.partition_number) /(select count(type) from sys.dm_pdw_nodes
    where type = ''' + 'COMPUTE' + ''')
AS CTL_ROW_COUNT
FROM sys.pdw_nodes_partitions part
JOIN sys.pdw_nodes_tables tbl
    ON part.object_id = tbl.object_id
    AND part.pdw_node_id = tbl.pdw_node_id
JOIN sys.pdw_table_mappings map
    ON map.physical_name = tbl.name
JOIN sys.tables pdwtbl
    ON pdwtbl.object_id = map.object_id
JOIN sys.partitions pdwpart
    ON pdwpart.object_id = pdwtbl.object_id
join sys.pdw_table_distribution_properties dist
    on pdwtbl.object_id = dist.object_id
where dist.distribution_policy = 3
-- uncomment the below if you are looking for row counts for a specific table
-- this table will also need to be added below
-- and pdwtbl.name = 'table_name'
GROUP BY pdwtbl.name
```

> [!NOTE]
> - This query evaluates only the row counts and not cardinality. It also requires that Parallel Data Warehouse level statistics exist on at least one column of the table. It does not take into account whether statistics exist on more than one column, or which column the statistics exist for.
> - The default count value in Parallel Data Warehouse is 1,000 rows. If no Parallel Data Warehouse statistics have been created, a value of **1000** is returned for the CTL row count.
