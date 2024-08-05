---
title: Troubleshoot slow queries due to query optimizer timeout
description: Introduces how Optimizer Timeout can affect query performance and how to optimize the performance.
ms.date: 11/10/2022
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
author: PijoCoder 
ms.author: jopilov
---

# Troubleshoot slow queries affected by query optimizer timeout

_Applies to:_ &nbsp; SQL Server

This article introduces Optimizer Timeout, how it can affect query performance, and how to optimize the performance.

## What is Optimizer Timeout?

SQL Server uses a cost-based _Query Optimizer_ (QO). For information on QO, see [Query processing architecture guide](/sql/relational-databases/query-processing-architecture-guide). A cost-based Query Optimizer selects a query execution plan with the lowest cost after it has built and assessed multiple query plans. One of the objectives of SQL Server Query Optimizer is to spend a reasonable time in query optimization compared to query execution. Optimizing a query should be much faster than executing it. To accomplish this target, QO has a built-in threshold of tasks to consider before it stops the optimization process. When the threshold is reached before QO has considered all the possible plans, it reaches the Optimizer Timeout limit. An Optimizer Timeout event is reported in the query plan as **TimeOut** under **Reason For Early Termination of Statement Optimization**. It's important to understand that this threshold isn't based on clock time but on the number of possibilities considered by the optimizer. In current SQL Server QO versions, over a half million tasks are considered before a timeout is reached.

The Optimizer Timeout is designed into SQL Server, and in many cases, it isn't a factor affecting query performance. However, in some cases, the SQL query plan choice may be negatively affected by the Optimizer Timeout, and slower query performance could result. When you encounter such issues, understanding the Optimizer Timeout mechanism and how complex queries can be affected can help you troubleshoot and improve your query speed.

The result of reaching the Optimizer Timeout threshold is that SQL Server hasn't considered the entire set of possibilities for optimization. That is, it may have missed plans that could produce shorter execution times. QO will stop at the threshold and consider the least-cost query plan at that point, even though there may be better, unexplored options. Keep in mind that the plan selected after an Optimizer Timeout is reached can produce a reasonable execution duration for the query. However, in some cases, the selected plan might result in a query execution that's suboptimal.

## How to detect an Optimizer Timeout?

Here are symptoms that indicate an Optimizer Timeout:

- **Complex query**

  You have a complex query that involves lots of joined tables (for example, eight or more tables are joined).
- **Slow query**

  The query may run slowly or slower than it runs on another SQL Server version or system.
- **Query plan shows StatementOptmEarlyAbortReason=Timeout**

  - The query plan shows `StatementOptmEarlyAbortReason="TimeOut"` in the XML query plan.

    ```xml
    <?xml version="1.0" encoding="utf-16"?>
    <ShowPlanXML xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" Version="1.518" Build="13.0.5201.2" xmlns="http://schemas.microsoft.com/sqlserver/2004/07/showplan">
     <BatchSequence>
      <Batch>
       <Statements>
        <StmtSimple  ..." StatementOptmLevel="FULL" StatementOptmEarlyAbortReason="TimeOut" ......>
        ...
       <Statements>
      <Batch>
    <BatchSequence>
    ```

  - Check the properties of the left-most plan operator in Microsoft SQL Server Management Studio. You can see the value of **Reason For Early Termination of Statement Optimization** is **TimeOut**.

    :::image type="content" source="media/troubleshoot-optimizer-timeout-performance/opitmizer-timeout-in-query-plan-ssms.png" alt-text="Screenshot that shows the optimizer timeout in query plan in SSMS.":::

## What causes an Optimizer Timeout?

There's no simple way to determine what conditions would cause the optimizer threshold to be reached or exceeded. The following sections are some factors that affect how many plans are explored by QO when looking for the best plan.

- In what order should tables be joined?

  Here's an example of the execute options of three-table joins (`Table1`, `Table2`, `Table3`):

  - Join `Table1` with `Table2` and the result with `Table3`
  - Join `Table1` with `Table3` and the result with `Table2`
  - Join `Table2` with `Table3` and the result with `Table1`

  **Note:** The larger the number of tables is, the larger the possibilities are.

- What heap or binary tree (HoBT) access structure to use to retrieve the rows from a table?

  - Clustered index
  - Nonclustered Index1
  - Nonclustered Index2
  - Table heap

- What physical access method to use?

  - Index seek
  - Index scan
  - Table scan

- What physical join operator to use?

  - Nested Loops join (NJ)
  - Hash join (HJ)
  - Merge join (MJ)
  - Adaptive join (starting with SQL Server 2017 (14.x))

  For more information, see [Joins](/sql/relational-databases/performance/joins).

- Execute parts of the query in parallel or serially?

  For more information, see [Parallel query processing](/sql/relational-databases/query-processing-architecture-guide#parallel-query-processing).

While the following factors will reduce the number of access methods considered and thus the possibilities considered:

- Query predicates (filters in the `WHERE` clause)
- Existences of constraints
- Combinations of well-designed and up-to-date statistics

**Note:** The fact that QO reaches the threshold doesn't mean it will end up with a slower query. In most cases, the query will perform well, but in some cases, you may see a slower query execution.

### Example of how the factors are considered

To illustrate, let's take an example of a join between three tables (`t1`, `t2`, and `t3`) and each table has a clustered index and a nonclustered index.

First, consider the physical join types. There are two joins involved here. And, because there are three physical join possibilities (NJ, HJ, and MJ), the query can be performed in 3<sup>2</sup> = 9 ways.

1. NJ - NJ
1. NJ - HJ
1. NJ - MJ
1. HJ - NJ
1. HJ - HJ
1. HJ - MJ
1. MJ - NJ
1. MJ - HJ
1. MJ - MJ

Then, consider the join order, which is calculated using Permutations: P (n, r). The order of the first two tables doesn't matter, so there can be P(3,1) = 3 possibilities:

- Join `t1` with `t2` and then with `t3`
- Join `t1` with `t3` and then with `t2`
- Join `t2` with `t3` and then with `t1`

Next, consider the clustered and nonclustered indexes that could be used for data retrieval. Also, for each index, we have two access methods, seek or scan. That means, for each table, there are 2<sup>2</sup> = 4 choices. We have three tables, so there can be 4<sup>3</sup> = 64 choices.

Finally, considering all these conditions, there can be 9\*3\*64 = 1728 possible plans.

Now, let's assume there are n tables joined in the query, and each table has a clustered index and a nonclustered index. Consider the following factors:

- Join orders: P(n,n-2) = n!/2
- Join types: 3<sup>n-1</sup>
- Different index types with seek and scan methods: 4<sup>n</sup>

Multiply all these above, and we can get the number of possible plans: 2\*n!\*12<sup>n-1</sup>. When n = 4, the number is 82,944. When n = 6, the number is 358,318,080. So, with the increase in the number of tables involved in a query, the number of possible plans increases geometrically. Further, if you include the possibility of parallelism and other factors, you can imagine how many possible plans will be considered. Therefore, a query with lots of joins is more likely to reach the optimizer timeout threshold than one with fewer joins.

Note that the above calculations illustrate the worst-case scenario. As we have pointed out, there are factors that will reduce the number of possibilities, such as filter predicates, statistics, and constraints. For example, a filter predicate and updated statistics will reduce the number of physical access methods because it may be more efficient to use an index seek than a scan. This will also lead to a smaller selection of joins and so on.

## Why do I see an Optimizer Timeout with a simple query?

Nothing with Query Optimizer is simple. There are many possible scenarios, and the degree of complexity is so high that it's hard to grasp all the possibilities. The Query Optimizer may dynamically set the timeout threshold based on the cost of the plan found at a certain stage. For example, if a plan that appears relatively efficient is found, the task limit to search for a better plan may be reduced. Therefore, underestimated [cardinality estimation](/sql/relational-databases/performance/cardinality-estimation-sql-server) (CE) may be one scenario for hitting an Optimizer Timeout early. In this case, the focus of the investigation is CE. It's a rarer case compared with the scenario about running a complex query that's discussed in the previous section, but it's possible.

## Resolutions

An Optimizer Timeout appearing in a query plan doesn't necessarily mean that it's the cause of the poor query performance. In most cases, you may not need to do anything about this situation. The query plan that SQL Server ends up with may be reasonable, and the query you're running may be performing well. You may never know that you've encountered an Optimizer Timeout.

Try the following steps if you find the need to tune and optimize.

### Step 1: Establish a baseline

Check if you can execute the same query with the same data set on a different build of SQL Server, using a different CE configuration, or on a different system (hardware specifications). A guiding principle in performance tuning is "there's no performance problem without a baseline." Therefore it would be important to establish a baseline for the same query.

### Step 2: Look for "hidden" conditions that lead to the Optimizer Timeout

Examine your query in detail to determine its complexity. Upon initial examination, it may not be obvious that the query is complex and involves many joins. A common scenario here is that views or table-valued functions are involved. For example, on the surface, the query may appear to be simple because it joins two views. But when you examine the queries inside the views, you may find that each view joins seven tables. As a result, when the two views are joined, you end up with a 14-table join. If your query uses the following objects, drill down into each object to see what the underlying queries inside it look like:

- [Views](/sql/relational-databases/views/create-views)
- [Table-valued functions (TFVs)](/sql/relational-databases/user-defined-functions/create-user-defined-functions-database-engine#TVF)
- [Subqueries or derived tables](/sql/relational-databases/performance/subqueries)
- [Common table expressions (CTEs)](/sql/t-sql/queries/with-common-table-expression-transact-sql)
- [UNION operators](/sql/t-sql/language-elements/set-operators-union-transact-sql)

For all of these scenarios, the most common resolution would be to rewrite the query and break it up into multiple queries. See [Step 7: Refine the query](#step-7-refine-the-query) for more details.

#### Subqueries or derived tables

The following query is an example that joins two separate sets of queries (derived tables) with 4-5 joins in each. However, after parsing by SQL Server, it will be compiled into a single query with eight tables joined.

```sql
SELECT ...
  FROM 
    ( SELECT ...
        FROM t1 
        JOIN t2 ON ...
        JOIN t3 ON ...
        JOIN t4 ON ...
        WHERE ...
    ) AS derived_table1
INNER JOIN
  ( SELECT ...
      FROM t5 
      JOIN t6 ON ...
      JOIN t7 ON ...
      JOIN t8 ON ...
      WHERE ...
  ) AS derived_table2 
ON derived_table1.Co1 = derived_table2.Co10 
AND derived_table1.Co2 = derived_table2.Co20
```

#### Common table expressions (CTEs)

Using multiple common table expressions (CTEs) isn't an appropriate solution to simplify a query and avoid Optimizer Timeout. Multiple CTEs will only increase the complexity of the query. Therefore, it's counterproductive to use CTEs when solving optimizer timeouts. CTEs look like to break a query logically, but they'll be combined into a single query and optimized as a single large join of tables.

Here's an example of a CTE that will be compiled as a single query with many joins. It may appear that the query against the my_cte is a two-object simple join, but in fact, there are seven other tables joined in the CTE.

```sql
WITH my_cte AS (
  SELECT ...
    FROM t1 
    JOIN t2 ON ...
    JOIN t3 ON ...
    JOIN t4 ON ...
    JOIN t5 ON ...
    JOIN t6 ON ...
    JOIN t7 ON ...
    WHERE ... )

SELECT ...
  FROM my_cte 
  JOIN t8 ON ...
```

#### Views

Make sure that you've checked the view definitions and gotten all tables involved. Similar to CTEs and derived tables, joins can be hidden inside views. For example, a join between two views may ultimately be a single query with eight tables involved:

```sql
CREATE VIEW V1 AS 
  SELECT ...
    FROM t1 
    JOIN t2 ON ...
    JOIN t3 ON ...
    JOIN t4 ON ...
    WHERE ...
GO

CREATE VIEW V2 AS 
  SELECT ...
    FROM t5 
    JOIN t6 ON ...
    JOIN t7 ON ...
    JOIN t8 ON ...
    WHERE ...
GO

SELECT ...
  FROM V1 
  JOIN V2 ON ...
```

#### Table-valued functions (TVFs)

Some joins may be hidden inside TFVs. The following sample shows what appears as a join between two TFVs, and a table may be a nine-table join.

```sql
CREATE FUNCTION tvf1() RETURNS TABLE
AS RETURN
  SELECT ...
    FROM t1 
    JOIN t2 ON ...
    JOIN t3 ON ...
    JOIN t4 ON ...
    WHERE ...
GO 

CREATE FUNCTION tvf2() RETURNS TABLE
AS RETURN
  SELECT ...
    FROM t5
    JOIN t6 ON ...
    JOIN t7 ON ...
    JOIN t8 ON ...
    WHERE ...
GO

SELECT ...
  FROM tvf1() 
  JOIN tvf2() ON ...
  JOIN t9 ON ...
```

#### Union

Union operators combine the results of multiple queries into a single result set. They also combine multiple queries into a single query. Then you may get a single, complex query. The following example will end up with a single query plan that involves 12 tables.

```sql
SELECT ...
  FROM t1 
  JOIN t2 ON ...
  JOIN t3 ON ...
  JOIN t4 ON ...

UNION ALL

SELECT ...
  FROM t5 
  JOIN t6 ON ...
  JOIN t7 ON ...
  JOIN t8 ON ...

UNION ALL

SELECT ...
  FROM t9
  JOIN t10 ON ...
  JOIN t11 ON ...
  JOIN t12 ON ...
```

### Step 3: If you have a baseline query that runs faster, use its query plan

If you determine that a particular baseline plan you get from [Step 1](#step-1-establish-a-baseline) is better for your query through testing, use one of the following options to force QO to select that plan:

- [Query Store (QDS) stored procedure](/sql/relational-databases/system-stored-procedures/sp-query-store-force-plan-transact-sql)
- [Query hint: OPTION (USE PLAN N'\<XML_Plan\>')](/sql/t-sql/queries/hints-transact-sql-query#use-plan)
- [Plan guides](/sql/relational-databases/performance/plan-guides)

### Step 4: Reduce plans choices

To reduce the chance of an Optimizer Timeout, try to reduce the possibilities that QO needs to consider in choosing a plan. This process involves testing the query with different [hint options](/sql/t-sql/queries/hints-transact-sql). As is with most decisions with QO, the choices aren't always deterministic on the surface because there's a large variety of factors to be considered. Therefore, there isn't a single guaranteed successful strategy, and the selected plan may improve or decrease the performance of the selected query.

#### Force a JOIN order

Use `OPTION (FORCE ORDER)` to eliminate the order permutations:

```sql
SELECT ...
  FROM t1
  JOIN t2 ON ...
  JOIN t3 ON ...
  JOIN t4 ON ...
OPTION (FORCE ORDER)
```

#### Reduce the JOIN possibilities

If other alternatives haven't helped, try to reduce the query plan combinations by limiting the choices of physical joins operators with [join hints](/sql/t-sql/queries/hints-transact-sql-query#-loop--merge--hash--join). For example: `OPTION (HASH JOIN, MERGE JOIN)`, `OPTION (HASH JOIN, LOOP JOIN)` or `OPTION (MERGE JOIN)`.

**Note:** You should be careful when using these hints.

In some cases, limiting the optimizer with fewer join choices may cause the best join option not to be available and may actually slow down the query. Also, in some cases, a specific join is required by an optimizer (for example, [row goal](https://support.microsoft.com/topic/kb4051361-optimizer-row-goal-information-in-query-execution-plan-added-in-sql-server-2014-2016-and-2017-ec130d21-1adc-3d3d-95a5-cdb075722269)), and the query may fail to generate a plan if that join isn't an option. Therefore, after you target the join hints for a specific query, check if you find a combination that offers better performance and eliminates the Optimizer Timeout.

Here are two examples of how to use such hints:

- Use `OPTION (HASH JOIN, LOOP JOIN)` to allow only hash and loop joins and avoid merge join in the query:

    ```sql
    SELECT ...
      FROM t1 
      JOIN t2 ON ...
      JOIN t3 ON ...
      JOIN t4 ON ...
      JOIN t5 ON ...
    OPTION (HASH JOIN, LOOP JOIN)
    ```

- Enforce a specific join between two tables:

    ```sql
    SELECT ...
      FROM t1 
      INNER MERGE JOIN t2 ON ...
      JOIN t3 ON ...
      JOIN t4 ON ...
      JOIN t5 ON ...
    ```

### Step 5: Change CE configuration

Try to change the CE configuration by switching between Legacy CE and New CE. Changing the CE configuration can result in the QO picking a different path when SQL Server evaluates and creates query plans. So, even if an Optimizer Timeout issue occurs, it's possible that you end up with a plan that performs more optimally than the one selected using the alternate CE configuration. For more information, see [How to activate the best query plan (Cardinality Estimation)](/sql/relational-databases/performance/cardinality-estimation-sql-server#how-to-activate-the-best-query-plan).

### Step 6: Enable Optimizer fixes

If you haven't enabled Query Optimizer fixes, consider enabling them by using one of the following two methods:

- Server level: use trace flag [T4199](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf4199).
- Database level: use `ALTER DATABASE SCOPED CONFIGURATION ..QUERY_OPTIMIZER_HOTFIXES = ON` or change database compatibility levels for SQL Server 2016 and later versions.

The QO fixes may cause the optimizer to take a different path in plan exploration. Therefore it may choose a more optimal query plan. For more information, see [SQL Server query optimizer hotfix trace flag 4199 servicing model](https://support.microsoft.com/topic/kb974006-sql-server-query-optimizer-hotfix-trace-flag-4199-servicing-model-cd3ebf5c-465c-6dd8-7178-d41fdddccc28).

### Step 7: Refine the query

Consider breaking up the single multi-table query into multiple separate queries by using temporary tables. Breaking up the query is just one of the ways to simplify the task for the optimizer. See the following example:

```sql
SELECT ...
  FROM t1
  JOIN t2 ON ...
  JOIN t3 ON ...
  JOIN t4 ON ...
  JOIN t5 ON ...
  JOIN t6 ON ...
  JOIN t7 ON ...
  JOIN t8 ON ...
```

To optimize the query, try to break down the single query into two queries by inserting part of the join results in a temporary table:

```sql
SELECT ...
  INTO #temp1
  FROM t1 
  JOIN t2 ON ...
  JOIN t3 ON ...
  JOIN t4 ON ...

GO

SELECT ...
  FROM #temp1
  JOIN t5 ON ...
  JOIN t6 ON ...
  JOIN t7 ON ...
  JOIN t8 ON ...
```

