---
title: Decreased performance when you run a clause
description: Provides workarounds for the problem in which you encounter decreased performance for SQL Server. This issue occurs when you run TOP, MAX, or MIN aggregating clause on columns.
ms.date: 09/25/2020
ms.custom: sap:Performance
ms.reviewer: ramakoni
---
# Decreased performance for SQL Server when you run a TOP, MAX, or MIN aggregating clause on columns other than the partitioning column

This article helps you work around the problem in which you encounter decreased performance for SQL Server when you run `TOP`, `MAX` or `MIN` aggregating clause on columns.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2965553

## Symptoms

Assume that you have partitioned tables in Microsoft SQL Server. When you run a `TOP`, `MAX` or `MIN` aggregating clause on columns of the tables, you may experience decreased performance.

> [!NOTE]
> This issue only does not occur on the partitioning column.

## Workaround

To work around this issue, craft a query that collects the TOP N elements of each partition. Then, find the TOP N elements from that collection of elements.

For example, you have a table T1 that has four partitions, and the partition function is `PF1`. The table is partitioned on column `PCOL` and has index `idx_c1` on `T1.c1`. You may encounter the performance issue when you run the following query:

```sql
SELECT TOP 3 T1.c1, T1.c2

FROM dbo.T1

ORDER BY T1.c1
```

To work around this issue, follow these steps:

1. Find the top three elements of a given partition \<**partition_number**>:

    ```sql
    SELECT TOP 3 T1.c1, T1.c2
     FROM dbo.T1
     WHERE $PARTITION.PF1(PCOL) = < **partition_number** > AS A(c1, c2)
     ORDER BY T1.c1;
    ```

2. Find the top three elements of all four partitions:

    ```sql
    SELECT TOP 3 A.c1, A.c2
    FROM (VALUES((1),(2),(3),(4)) AS P( partition_number )
     CROSS APPLY ( SELECT TOP 3 (T1.c1, T2.c2) 
     FROM dbo.T1
     WHERE $PARTITION.PF1(T1.PCOL) = P.partition_number 
     ORDER BY T1.c1 ) AS A
    ORDER BY A.c1
    ```

3. Unfortunately, if the table is repartitioned, you have to rewrite these queries in order to use the new number of partitions. However, you can also obtain the number of partitions from `sys.partitions`. Therefore, instead of using a constant list of partitions, you can use the following SQL Script:

    ```sql
    SELECT TOP 3 A.c1, A.c2
    FROM sys.partitions AS P
     CROSS APPLY ( SELECT TOP 3 T1.c1, T2.c2)
     FROM dbo.T1
     WHERE $PARTITION.PF1(T1.col1) = P.partition_number 
     ORDER BY T1.c1 ) AS A
     WHERE P.object_id = OBJECT_ID('dbo.T1') 
     AND P.index_id = INDEXPROPERTY( OBJECTID('dbo.T1'), 'idx_c1', 'INDEXID')
     ORDER BY a;
    ```

    > [!NOTE]
    >  This article uses TOP N with an order by clause as the example. `MAX` and `MIN` clauses have similar issues. Therefore, they can be worked around by turning them into TOP 1 queries, with the order set to either ascending or descending.

## More information

When you query for the TOP N rows of an indexed column on a non-partitioned table, generally the query has good performance. This is because the query plan scans an index to determine what the top n elements are.

However, for a partitioned table, this is currently not the case, as the indexes may also be partitioned. This means that you cannot merely query the indexes to determine the top N elements. Those elements may be distributed across all partitions. For example, consider the following case in which you have a table "a" with two partitions P0 and P1 that are partitioned around 0:

|Partition|Key|Value|
|---|---|---|
|P0|-2|1|
|P0|-1|1|
|P0|0|12|
|P1|1|1|
|P1|2|1|
|P1|3|15|
  
Because each index is partitioned, SQL Server cannot scan the index all at the same time to determine the maximum value. Instead, it scans each element of the table to determine the max value. In a table that has millions of rows, this process can be inefficient.
