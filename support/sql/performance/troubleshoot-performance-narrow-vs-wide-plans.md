---
title: Troubleshoot performance issues with narrow and wide plans in SQL Server
description: Provides information to understand and troubleshoot UPDATEs that use wide or narrow query plans
ms.date: 10/22/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.prod: sql
ms.reviewer: jopilov, shaunbe
author: liwei-yin
ms.author: liweiyin
---

# Troubleshoot UPDATE performance issues with narrow and wide plans in SQL Server

## Symptoms

An UPDATE statement may be faster in some cases and slower in others. There are many factors that can lead to such a variance including the number of rows updated, the resource usage on the system (blocking, CPU, memory, I/O). But one specific reason that this article will cover is a choice of query plan made by SQL Server.


## What are a narrow and wide query plans?

When you execute an UPDATE against a clustered index column, SQL Server updates not only the clustered index itself, but also all the non-clustered indexes because the non-clustered indexes contain the cluster index key. 

SQL Server has two options to do the update:

1. Do the non-clustered index update along with the clustered index key update. This straightforward approach is easy to understand: update the clustered index, and then all non-clustered indexes at the same time. SQL Server would update one row, then move to next row until all is complete. This is called **narrow plan** update or also called Per-Row Update. However, this operation is relatively expensive because the order of non-clustered index data that will be updated may not be in the order of clustered index data. If many index pages are involved in the update, when the data is on disk, a large number of random I/O requests may occur.

1. To optimize performance and reduce random I/O SQL Server may choose a wide plan. It doesn't do the non-clustered indexes along with Clustered index together. Instead, it sorts all non-clustered index data in memory first and then updates all indexes by that order. This is called a **wide plan** (also called Per-Index Update)

Here's a screenshot of Narrow and Wide Plans:

:::image type="content" source="media/understand-wide-narrow-plans/narrow_wide_plans_initial.png" alt-text="narrow and wide plans illustrated":::

## When does SQL Server choose a wide Plan?

There are two criteria that must be met for SQL Server to choose a wide plan:

 - The number of rows impacted is greater than 250.
 - The size of leaf-level of the non-clustered indexes (index page count * 8 KB) is at least 1/1000 of the max server memory setting.


## Examples:

The following examples illustrate how narrow and wide plans work


Environment: SQL Server 2019 CU11, Max Server Memory = 1500 MB

Mytable1 has 41,501 rows, one clustered index on the column c1, and five non-clustered indexes on rest of the columns respectively.

```sql
  CREATE TABLE mytable1(c1 INT, c2 CHAR(30),c3 CHAR(20),c4 CHAR(30),c5 CHAR(30))
  GO
  WITH cte
  AS
  (
  	SELECT ROW_NUMBER() OVER(ORDER BY c1.object_id) id FROM sys.columns CROSS JOIN sys.columns c1
  )
  INSERT mytable1
  SELECT TOP 41000 id, REPLICATE('a',30),REPLICATE('a',20),REPLICATE('a',30),REPLICATE('a',30) 
  FROM cte
  GO
  
  INSERT mytable1
  SELECT TOP 250 50000, c2,c3,c4,c5 
  FROM mytable1
  GO
  
  INSERT mytable1
  SELECT TOP 251 50001, c2,c3,c4,c5 
  FROM mytable1
  GO
  
  CREATE CLUSTERED INDEX ic1 ON mytable1(c1)
  CREATE INDEX ic2 ON mytable1(c2)
  CREATE INDEX ic3 ON mytable1(c3)
  CREATE INDEX ic4 ON mytable1(c4)
  CREATE INDEX ic5 ON mytable1(c5)
```



Let's run following three T-SQL update statements and compare the query plans:

-  `UPDATE mytable1 SET c1=c1 WHERE c1=1     OPTION(RECOMPILE)`  where   1 row is updated
- `UPDATE mytable1 SET c1=c1 WHERE c1=50000 OPTION(RECOMPILE)`  where   250 rows are updated.
- `UPDATE mytable1 SET c1=c1 WHERE c1=50001 OPTION(RECOMPILE)`  where   251 rows are updated.

We can examine the results based on the **first criterion**, the affected number of rows threshold of 250.

As expected, the query optimizer chooses a narrow plan for the first two queries because the number of impacted rows is less than 250. A wide plan is used for the third query because the impacted row count is 251, which is greater than 250.

:::image type="content" source="media/understand-wide-narrow-plans/narrow_first2_wide_third.png" alt-text="wide and narrow plans based on size of index":::


Also, we can examine the results based on the **second criterion**, the memory of leaf index size is at least 1/1000 of the max server memory setting.

A wide plan is selected for the third UPDATE query. But notice something interesting - index ic3 (on column c3) isn't seen in the plan. That's because the second criterion isn't met - leaf pages index size in comparison to max memory setting.

:::image type="content" source="media/understand-wide-narrow-plans/wide_plan_missing_third_index.png" alt-text="wide plan not using index due to size":::


The data type of Column c2, c4 and c4 is char(30), while the data type of Column c3 is char(20). The size of each row of index ic3 is less than others, so the number of leaf pages is less than others.
  `CREATE TABLE mytable1(c1 INT, c2 CHAR(30),c3 CHAR(20),c4 CHAR(30),c5 CHAR(30))`

With the help of **sys.dm_db_database_page_allocations** DMF one can calculate the number of pages for each index. For indexes ic2, ic4 and ic5 each have 214 pages, and 209 of them are leaf pages (results can vary slightly). The memory consumed by leaf pages is 209x8 = 1,672 KB. Therefore, the ratio is 1672/(1500 x 1024) = 0.00108854101, which is greater than 1/1000. However, the ic3 only has 161 pages, 159 of them are leaf pages. The ratio is 159 x 8/(1500 x 1024) = 0.000828125, which is less than 1/1000 (0.001).

If you insert more rows or reduce the max server memory to meet the criterion, the plan will change. Let's lower the Max Server Memory setting a bit to 1200 to make the index leaf-level size greater than 1/1000. In this case 159 x 8/(1200 x 1024) = 0.00103515625 > 1/1000. After this change, the ic3 appears in the plan.

```sql
 SP_CONFIGURE 'max server memory',1200
 GO
 RECONFIGURE
 GO
 UPDATE mytable1 SET c1=c1 WHERE c1=50001 OPTION(RECOMPILE)--251 rows are updated.
```

:::image type="content" source="media/understand-wide-narrow-plans/wide_plan_uses_all_indexes_after_memory_change.png" alt-text="wide plan uses all indexes when memory threshold reached":::

### Is a wide plan faster than narrow plan? 

The answer is It depends on whether the data and index pages are cached in the buffer pool or not.

#### Data cached in the buffer pool

If the data is already in buffer pool, then the query with wide plan doesn't offer an additional performance benefit. That is because the wide plan is designed to improve the I/O performance (physical reads not logical reads).

Here is an example using another table


```sql
  CREATE TABLE mytable2(C1 INT, C2 INT,C3 INT ,C4 INT ,C5 INT)
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
  UPDATE STATISTICS  mytable2 WITH FULLSCAN
```

To illustrate, let's look at another example:

Environment: 
- SQL Server 2019 CU11
- Max Server Memory: 30000 MB
- The data size is 64 MB, while index size is around 127 MB.
- Database files are in two different physical disks.
  I:\sql19\dbWideplan.mdf
  H:\sql19\dbWideplan.ldf

Execute the following two queries.

```t-sql
update mytable2 set c1=c1 where c2<260 option(querytraceon 8790)-- trace flag 8790 will force Wide plan
update mytable2 set c1=c1 where c2<260 option(querytraceon 2338)-- trace flag 2338 will force Narrow plan
```

For more information, see Trace flag [8790](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf8790) and trace flag [2338](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf2338) 

The query with wide plan takes 0.136 second, while the query with narrow plan only takes 0.112 second.  The two durations are very close because the data is already in buffer before the UPDATE was executed and renders the Per-Index update (wide plan) less beneficial.


:::image type="content" source="media/understand-wide-narrow-plans/wide_narrow_plan_data_in_buffer_pool.png" alt-text="wide and narrow plans when data is cache in buffer pool":::

#### Data isn't cached in the buffer pool

When you do the test, make sure yours is the only workload in SQL Server, and the disks are dedicated to SQL Server.

Run following queries.

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
WAITFOR DELAY '00:00:02' --WAIT FOR 1~2 SECONDS
UPDATE mytable2 SET c1=c1 WHERE c2 < 260 OPTION (QUERYTRACEON 2338) --force Narrow plan
```

The query with Wide plan takes 3.554 seconds, while the query with Narrow Plan takes 6.701 seconds. The wide plan query runs faster this time.

:::image type="content" source="media/understand-wide-narrow-plans/wide_plan_data_not_in_bpool.png" alt-text="wide plan when data is not cached in buffer pool":::


:::image type="content" source="media/understand-wide-narrow-plans/narrow_plan_data_not_in_bpool.png" alt-text="narrow plan when data is not cached in buffer pool":::


## Is the wide plan query always faster than narrow query plan when data isn't in buffer? 

The answer is "not always". To illustrate, let's try something that isn't common: 

```sql
  SELECT c1,c1 AS c2, c1 AS C3,c1 AS c4, c1 AS C5 INTO mytable3 FROM mytable2
  GO
  CREATE CLUSTERED INDEX IC1 ON mytable3(C1)
  CREATE  INDEX IC2 ON mytable3(C2)
  CREATE  INDEX IC3 ON mytable3(C3)
  CREATE  INDEX IC4 ON mytable3(C4)
  CREATE  INDEX IC5 ON mytable3(C5)
  GO
```

The mytable3 is as same as mytable2, except the data. Mytable3 has all five columns with same value, which makes the order of non-clustered indexes follow the order of clustered index. This sorting of the data will minimize the advantage of wide plan.

```sql
CHECKPOINT 
GO
DBCC DROPCLEANBUFFERS
go
UPDATE mytable3 SET c1=c1 WHERE c2<12 OPTION(QUERYTRACEON 8790)-- tf 8790 will force Wide plan

CHECKPOINT 
GO
DBCC DROPCLEANBUFFERS
GO
UPDATE mytable3 SET c1=c1 WHERE c2<12 OPTION(QUERYTRACEON 2338)-- tf 2338 will force Narrow plan
```

The duration of both queries is reduced significantly! The wide plan takes 0.304 seconds, which is a bit slower than the Narrow plan this time.

:::image type="content" source="media/understand-wide-narrow-plans/wide_and_narrow_plan_which_is_faster.png" alt-text="comparing performance when wide and narrow used":::

## Scenarios where wide plan is applied

Here are the other scenarios where the wide plan is also applied: 

### The clustered index column also has unique/primary key, wide plan used if multiple rows are updated

```sql
CREATE TABLE mytable4(c1 INT primary key ,c2 INT,c3 INT,c4 INT)
GO
CREATE INDEX ic2 ON mytable4(c2)
CREATE INDEX ic3 ON mytable4(c3)
CREATE INDEX ic4 ON mytable4(c4)
GO
INSERT mytable4 VALUES(0,0,0,0)
INSERT mytable4 VALUES(1,1,1,1)
```

:::image type="content" source="media/understand-wide-narrow-plans/wide_plan_cluster_index_unique.png" alt-text="wide plan used when cluster index unique":::

For more details, review this blog post [Maintaining Unique Indexes](/archive/blogs/craigfr/maintaining-unique-indexes)

### Cluster index column is also specified in partition scheme

```sql
CREATE TABLE mytable5(c1 INT, c2 INT, c3 INT, c4 INT)
go
IF EXISTS(SELECT* FROM sys.partition_schemes WHERE name='PS1')
	DROP PARTITION SCHEME PS1
go
IF EXISTS(SELECT* FROM sys.partition_functions WHERE name='PF1')
	DROP PARTITION FUNCTION PF1
go
CREATE PARTITION FUNCTION PF1(INT)  AS 
  RANGE right FOR VALUES 
  (2000)   
go
CREATE PARTITION SCHEME PS1  AS 
  PARTITION PF1  all TO 
  (   [PRIMARY] ) 
go 
CREATE CLUSTERED INDEX c1 ON mytable5(c1)  ON PS1(c1)
CREATE INDEX c2 ON mytable5(c2)
CREATE INDEX c3 ON mytable5(c3)
CREATE INDEX c4 ON mytable5(c4)
go
UPDATE mytable5 SET c1=c1 WHERE  c1=1 
```

:::image type="content" source="media/understand-wide-narrow-plans/wide_plan_clustered_column_in_partition_scheme.png" alt-text="wide plan used when clustered column in partition scheme":::

###  Clustered index column isn't part of the partition scheme, the wide plan used if partition scheme column is updated 

Here's an example 

```sql
CREATE TABLE mytable6(c1 INT,c2 INT , c3 INT,c4 INT)
go
if exists(select* from sys.partition_schemes WHERE name='PS2')
	DROP PARTITION SCHEME PS2
go
IF EXISTS (SELECT * FROM sys.partition_functions WHERE name='PF2')
	DROP PARTITION FUNCTION PF2
go
CREATE PARTITION FUNCTION PF2(int) AS 
  RANGE right FOR VALUES 
  (2000)   
go
CREATE PARTITION SCHEME PS2 AS 
  PARTITION PF2 all TO 
  ([PRIMARY]) 
go 
CREATE CLUSTERED INDEX c1 on mytable6(c1) on PS2(c2) -- on c2 column
CREATE INDEX c3 on mytable6(c3)
CREATE INDEX c4 on mytable6(c4)
```

:::image type="content" source="media/understand-wide-narrow-plans/wide_plan_part_scheme_column_update.png" alt-text="wide plan part used when partition scheme column updated":::

## Conclusion:

1. SQL Server chooses a wide plan Update when the following criteria are met at the same time:
   - The impacted number of rows is greater than 250.
   - The memory of leaf index is at least 1/1000 of the max server memory setting.
1. Wide Plans boost performance at the expense of consuming additional memory.
1. If the expected query plan isn't used, it may be due to the stale statistics (not reporting correct data size), Max Server Memory setting or other unrelated issues like parameter sensitive plans.
1. The duration of UPDATEs using a wide plan depends on several factors and in some cases it may take longer than narrow plans.
1. Trace flag [8790](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf8790) will force Wide plan;trace flag [2338](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf2338) will force Narrow plan

