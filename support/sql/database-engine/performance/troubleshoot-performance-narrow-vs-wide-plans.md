---
title: Troubleshoot performance issues with narrow and wide plans in SQL Server
description: Provides information to understand and troubleshoot update statements that use wide or narrow plans.
ms.date: 10/28/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.reviewer: jopilov, shaunbe
author: liwei-yin
ms.author: liweiyin
---

# Troubleshoot UPDATE performance issues with narrow and wide plans in SQL Server

_Applies to:_ &nbsp; SQL Server

An `UPDATE` statement may be faster in some cases and slower in others. There are many factors that can lead to such a variance, including the number of rows updated and the resource usage on the system (blocking, CPU, memory, or I/O). This article will cover one specific reason for the variance: the choice of query plan made by SQL Server.

## What are narrow and wide plans?

When you execute an `UPDATE` statement against a clustered index column, SQL Server updates not only the clustered index itself but also all the non-clustered indexes because the non-clustered indexes contain the cluster index key.

SQL Server has two options to do the update:

- **Narrow plan**: Do the non-clustered index update along with the clustered index key update. This straightforward approach is easy to understand; update the clustered index and then update all non-clustered indexes at the same time. SQL Server will update one row and move to the next until all are complete. This approach is called a narrow plan update or a Per-Row update. However, this operation is relatively expensive because the order of non-clustered index data that will be updated may not be in the order of clustered index data. If many index pages are involved in the update, when the data is on disk, a large number of random I/O requests may occur.

- **Wide plan**: To optimize performance and reduce random I/O, SQL Server may choose a wide plan. It doesn't do the non-clustered indexes update along with the clustered index update together. Instead, it sorts all non-clustered index data in memory first and then updates all indexes in that order. This approach is called a wide plan (also called a Per-Index update).

Here's a screenshot of narrow and wide plans:

:::image type="content" source="media/understand-wide-narrow-plans/narrow-wide-plans-initial.png" alt-text="Screenshot of narrow and wide plans." lightbox="media/understand-wide-narrow-plans/narrow-wide-plans-initial.png":::

## When does SQL Server choose a wide plan?

Two criteria must be met for SQL Server to choose a wide plan:

- The number of rows impacted is greater than 250.
- The size of the leaf-level of the non-clustered indexes (index page count * 8 KB) is at least 1/1000 of the max server memory setting.

## How do narrow and wide plans work?

To understand how narrow and wide plans work, follow these steps in the following environment:

- SQL Server 2019 CU11
- Max server memory = 1,500 MB

1. Run the following script to create a table `mytable1` that has 41,501 rows, one clustered index on column `c1`, and five non-clustered indexes on the rest of the columns, respectively.

    ```sql
    CREATE TABLE mytable1(c1 INT,c2 CHAR(30),c3 CHAR(20),c4 CHAR(30),c5 CHAR(30))
    GO
    WITH cte
    AS
    (
      SELECT ROW_NUMBER() OVER(ORDER BY c1.object_id) id FROM sys.columns CROSS JOIN sys.columns c1
    )
    INSERT mytable1
    SELECT TOP 41000 id,REPLICATE('a',30),REPLICATE('a',20),REPLICATE('a',30),REPLICATE('a',30) 
    FROM cte
    GO
    
    INSERT mytable1
    SELECT TOP 250 50000,c2,c3,c4,c5 
    FROM mytable1
    GO
    
    INSERT mytable1
    SELECT TOP 251 50001,c2,c3,c4,c5 
    FROM mytable1
    GO
    
    CREATE CLUSTERED INDEX ic1 ON mytable1(c1)
    CREATE INDEX ic2 ON mytable1(c2)
    CREATE INDEX ic3 ON mytable1(c3)
    CREATE INDEX ic4 ON mytable1(c4)
    CREATE INDEX ic5 ON mytable1(c5)
    ```

1. Run the following three T-SQL `UPDATE` statements, and compare the query plans:

    - `UPDATE mytable1 SET c1=c1 WHERE c1=1 OPTION(RECOMPILE)` - one row is updated
    - `UPDATE mytable1 SET c1=c1 WHERE c1=50000 OPTION(RECOMPILE)` - 250 rows are updated.
    - `UPDATE mytable1 SET c1=c1 WHERE c1=50001 OPTION(RECOMPILE)` - 251 rows are updated.

1. Examine the results based on the first criterion (the threshold of the affected number of rows is 250).

    The following screenshot shows the results based on the first criterion:

    :::image type="content" source="media/understand-wide-narrow-plans/narrow-first2-wide-third.png" alt-text="Screenshot of the wide and narrow plans based on size of index." lightbox="media/understand-wide-narrow-plans/narrow-first2-wide-third.png":::

    As expected, the query optimizer chooses a narrow plan for the first two queries because the number of impacted rows is less than 250. A wide plan is used for the third query because the impacted row count is 251, which is greater than 250.

1. Examine the results based on the second criterion (the memory of the leaf index size is at least 1/1000 of the max server memory setting).

    The following screenshot shows the results based on the second criterion:

    :::image type="content" source="media/understand-wide-narrow-plans/wide-plan-missing-third-index.png" alt-text="Screenshot of the wide plan not using index due to size." lightbox="media/understand-wide-narrow-plans/wide-plan-missing-third-index.png":::

    A wide plan is selected for the third `UPDATE` query. But the index `ic3` (on column `c3`) isn't seen in the plan. The issue occurs because the second criterion isn't met - leaf pages index size in comparison to the setting max server memory.

    The data type of column `c2`, `c4` and `c4` is `char(30)`, while the data type of column `c3` is `char(20)`. The size of each row of index `ic3` is less than others, so the number of leaf pages is less than others.

    With the help of the dynamic management function (DMF) `sys.dm_db_database_page_allocations`, you can calculate the number of pages for each index. For indexes `ic2`, `ic4`, and `ic5`, each index has 214 pages, and 209 of them are leaf pages (results can vary slightly). The memory consumed by leaf pages is 209 x 8 = 1,672 KB. Therefore, the ratio is 1672/(1500 x 1024) = 0.00108854101, which is greater than 1/1000. However, the `ic3` only has 161 pages; 159 of them are leaf pages. The ratio is 159 x 8/(1500 x 1024) = 0.000828125, which is less than 1/1000 (0.001).

    If you insert more rows or reduce the [max server memory](/sql/database-engine/configure-windows/server-memory-server-configuration-options#max_server_memory) to meet the criterion, the plan will change. To make the index leaf-level size greater than 1/1000, you can lower the max server memory setting a bit to 1,200 by running the following commands:

    ```sql
    sp_configure 'show advanced options', 1;
    GO
    RECONFIGURE;
    GO
    sp_configure 'max server memory', 1200;
    GO
    RECONFIGURE
    GO
    UPDATE mytable1 SET c1=c1 WHERE c1=50001 OPTION(RECOMPILE) --251 rows are updated.
    ```

    In this case, 159 x 8/(1200 x 1024) = 0.00103515625 > 1/1000. After this change, the `ic3` appears in the plan.

    For more information about `show advanced options`, see [Use Transact-SQL](/sql/database-engine/configure-windows/server-memory-server-configuration-options#use-transact-sql).

    The following screenshot shows that the wide plan uses all indexes when the memory threshold is reached:

    :::image type="content" source="media/understand-wide-narrow-plans/wide-plan-uses-all-indexes-after-memory-change.png" alt-text="Screenshot of the wide plan that uses all indexes when memory threshold is reached." lightbox="media/understand-wide-narrow-plans/wide-plan-uses-all-indexes-after-memory-change.png":::

## Is a wide plan faster than a narrow plan?

The answer is that it depends on whether the data and index pages are cached in the buffer pool or not.

### Data is cached in the buffer pool

If the data is already in the buffer pool, the query with the wide plan doesn't necessarily offer extra performance benefits compared to narrow plans because the wide plan is designed to improve the I/O performance (physical reads, not logical reads).

To test if a wide plan is faster than a narrow plan when the data is in a buffer pool, follow these steps in the following environment:

- SQL Server 2019 CU11
- Max server memory: 30,000 MB
- The data size is 64 MB, while the index size is around 127 MB.
- Database files are on two different physical disks:

  - *I:\sql19\dbWideplan.mdf*  
  - *H:\sql19\dbWideplan.ldf*

1. Create another table, `mytable2`, by running the following commands:

    ```sql
    CREATE TABLE mytable2(C1 INT,C2 INT,C3 INT,C4 INT,C5 INT)
    GO
    CREATE CLUSTERED INDEX IC1 ON mytable2(C1)
    CREATE INDEX IC2 ON mytable2(C2)
    CREATE INDEX IC3 ON mytable2(C3)
    CREATE INDEX IC4 ON mytable2(C4)
    CREATE INDEX IC5 ON mytable2(C5)
    GO
    DECLARE @N INT=1
    WHILE @N<1000000
    BEGIN
      DECLARE @N1 INT=RAND()*4500
      DECLARE @N2 INT=RAND()*100000
      DECLARE @N3 INT=RAND()*100000
      DECLARE @N4 INT=RAND()*100000
      DECLARE @N5 INT=RAND()*100000
      INSERT mytable2 VALUES(@N1,@N2,@N3,@N4,@N5)
      SET @N+=1
    END
    GO
    UPDATE STATISTICS mytable2 WITH FULLSCAN
    ```

1. Execute the following two queries to compare the query plans:

    ```sql
    update mytable2 set c1=c1 where c2<260 option(querytraceon 8790) --trace flag 8790 will force Wide plan
    update mytable2 set c1=c1 where c2<260 option(querytraceon 2338) --trace flag 2338 will force Narrow plan
    ```

    For more information, see trace flag [8790](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf8790) and trace flag [2338](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf2338).

    The query with the wide plan takes 0.136 seconds, while the query with the narrow plan only takes 0.112 seconds. The two durations are very close, and the Per-Index update (wide plan) is less beneficial because the data is already in the buffer before the `UPDATE` statement was executed.

    The following screenshot shows wide and narrow plans when data is cached in the buffer pool:

    :::image type="content" source="media/understand-wide-narrow-plans/wide-narrow-plan-data-in-buffer-pool.png" alt-text="Screenshot of wide and narrow plans when data is cached in the buffer pool." lightbox="media/understand-wide-narrow-plans/wide-narrow-plan-data-in-buffer-pool.png":::

### Data isn't cached in the buffer pool

To test if a wide plan is faster than a narrow plan when the data isn't in the buffer pool, run the following queries:

> [!NOTE]
> When you do the test, make sure yours is the only workload in SQL Server, and the disks are dedicated to SQL Server.

```sql
CHECKPOINT
GO
DBCC DROPCLEANBUFFERS
GO
WAITFOR DELAY '00:00:02' --wait for 1~2 seconds
UPDATE mytable2 SET c1=c1 WHERE c2 < 260 OPTION (QUERYTRACEON 8790) --force Wide plan
CHECKPOINT 
GO
DBCC DROPCLEANBUFFERS
GO 
WAITFOR DELAY '00:00:02' --wait for 1~2 SECONDS
UPDATE mytable2 SET c1=c1 WHERE c2 < 260 OPTION (QUERYTRACEON 2338) --force Narrow plan
```

The query with a wide plan takes 3.554 seconds, while the query with a narrow plan takes 6.701 seconds. The wide plan query runs faster this time.

The following screenshot shows the wide plan when data isn't cached in the buffer pool:

:::image type="content" source="media/understand-wide-narrow-plans/wide-plan-data-not-in-bpool.png" alt-text="Screenshot of the wide plan when data isn't cached in the buffer pool." lightbox="media/understand-wide-narrow-plans/wide-plan-data-not-in-bpool.png":::

The following screenshot shows the narrow plan when data isn't cached in the buffer pool:

:::image type="content" source="media/understand-wide-narrow-plans/narrow-plan-data-not-in-bpool.png" alt-text="Screenshot of the narrow plan when data isn't cached in the buffer pool.":::

## Is a wide plan query always faster than a narrow query plan when data isn't in the buffer?

The answer is "not always." To test if the wide plan query is always faster than the narrow query plan when data isn't in the buffer, follow these steps:

1. Create another table, `mytable2`, by running the following commands:

    ```sql
    SELECT c1,c1 AS c2,c1 AS C3,c1 AS c4,c1 AS C5 INTO mytable3 FROM mytable2
    GO
    CREATE CLUSTERED INDEX IC1 ON mytable3(C1)
    CREATE INDEX IC2 ON mytable3(C2)
    CREATE INDEX IC3 ON mytable3(C3)
    CREATE INDEX IC4 ON mytable3(C4)
    CREATE INDEX IC5 ON mytable3(C5)
    GO
    ```

    The `mytable3` is the same as `mytable2`, except for the data. `mytable3` has all five columns with the same value, which makes the order of non-clustered indexes follow the order of the clustered index. This sorting of the data will minimize the advantage of the wide plan.

1. Execute the following commands to compare the query plans:

    ```sql
    CHECKPOINT 
    GO
    DBCC DROPCLEANBUFFERS
    go
    UPDATE mytable3 SET c1=c1 WHERE c2<12 OPTION(QUERYTRACEON 8790) --tf 8790 will force Wide plan
    
    CHECKPOINT 
    GO
    DBCC DROPCLEANBUFFERS
    GO
    UPDATE mytable3 SET c1=c1 WHERE c2<12 OPTION(QUERYTRACEON 2338) --tf 2338 will force Narrow plan
    ```

    The duration of both queries is reduced significantly! The wide plan takes 0.304 seconds, which is a bit slower than the narrow plan this time.

    The following screenshot shows the comparing of performance when wide and narrow are used:

    :::image type="content" source="media/understand-wide-narrow-plans/wide-and-narrow-plan-which-is-faster.png" alt-text="Screenshot that shows the comparing of performance when wide and narrow are used." lightbox="media/understand-wide-narrow-plans/wide-and-narrow-plan-which-is-faster.png":::

## Scenarios where the wide plans are applied

Here are the other scenarios where wide plans are also applied:

### The clustered index column has a unique or primary key, and multiple rows are updated

Here's an example to reproduce the scenario:

```sql
CREATE TABLE mytable4(c1 INT primary key,c2 INT,c3 INT,c4 INT)
GO
CREATE INDEX ic2 ON mytable4(c2)
CREATE INDEX ic3 ON mytable4(c3)
CREATE INDEX ic4 ON mytable4(c4)
GO
INSERT mytable4 VALUES(0,0,0,0)
INSERT mytable4 VALUES(1,1,1,1)
```

The following screenshot shows that the wide plan is used when the cluster index has a unique key:

:::image type="content" source="media/understand-wide-narrow-plans/wide-plan-cluster-index-unique.png" alt-text="Screenshot of the wide plan that is used when the cluster index has a unique key." lightbox="media/understand-wide-narrow-plans/wide-plan-cluster-index-unique.png":::

For more details, review [Maintaining Unique Indexes](/archive/blogs/craigfr/maintaining-unique-indexes).

### Cluster index column is specified in the partition scheme

Here's an example to reproduce the scenario:

```sql
CREATE TABLE mytable5(c1 INT,c2 INT,c3 INT,c4 INT)
GO
IF EXISTS (SELECT * FROM sys.partition_schemes WHERE name='PS1')
    DROP PARTITION SCHEME PS1
GO
IF EXISTS (SELECT * FROM sys.partition_functions WHERE name='PF1')
    DROP PARTITION FUNCTION PF1
GO
CREATE PARTITION FUNCTION PF1(INT) AS 
  RANGE right FOR VALUES 
  (2000)   
GO
CREATE PARTITION SCHEME PS1 AS 
  PARTITION PF1 all TO 
  ([PRIMARY]) 
GO 
CREATE CLUSTERED INDEX c1 ON mytable5(c1) ON PS1(c1)
CREATE INDEX c2 ON mytable5(c2)
CREATE INDEX c3 ON mytable5(c3)
CREATE INDEX c4 ON mytable5(c4)
GO
UPDATE mytable5 SET c1=c1 WHERE c1=1 
```

The following screenshot shows that the wide plan is used when there's a clustered column in the partition scheme:

:::image type="content" source="media/understand-wide-narrow-plans/wide-plan-clustered-column-in-partition-scheme.png" alt-text="Screenshot that shows that the wide plan is used when there's a clustered column in the partition scheme." lightbox="media/understand-wide-narrow-plans/wide-plan-clustered-column-in-partition-scheme.png":::

### Clustered index column isn't part of the partition scheme, and the partition scheme column is updated

Here's an example to reproduce the scenario:

```sql
CREATE TABLE mytable6(c1 INT,c2 INT,c3 INT,c4 INT)
GO
IF EXISTS (SELECT * FROM sys.partition_schemes WHERE name='PS2')
    DROP PARTITION SCHEME PS2
GO
IF EXISTS (SELECT * FROM sys.partition_functions WHERE name='PF2')
    DROP PARTITION FUNCTION PF2
GO
CREATE PARTITION FUNCTION PF2(int) AS 
  RANGE right FOR VALUES 
  (2000)   
GO
CREATE PARTITION SCHEME PS2 AS 
  PARTITION PF2 all TO 
  ([PRIMARY]) 
GO 
CREATE CLUSTERED INDEX c1 ON mytable6(c1) ON PS2(c2) --on c2 column
CREATE INDEX c3 ON mytable6(c3)
CREATE INDEX c4 ON mytable6(c4)
```

The following screenshot shows that the wide plan is used when the partition scheme column is updated:

:::image type="content" source="media/understand-wide-narrow-plans/wide-plan-part-scheme-column-update.png" alt-text="Screenshot of the wide plan that is used when the partition scheme column is updated." lightbox="media/understand-wide-narrow-plans/wide-plan-part-scheme-column-update.png":::

## Conclusion

- SQL Server chooses a wide plan update when the following criteria are met at the same time:

  - The impacted number of rows is greater than 250.
  - The memory of leaf index is at least 1/1000 of the max server memory setting.

- Wide plans boost performance at the expense of consuming extra memory.
- If the expected query plan isn't used, it may be due to stale statistics (not reporting correct data size), max server memory setting, or other unrelated issues like parameter-sensitive plans.
- The duration of `UPDATE` statements using a wide plan depends on several factors, and in some cases, it may take longer than narrow plans.
- Trace flag [8790](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf8790) will force a wide plan; trace flag [2338](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf2338) will force a narrow plan.

