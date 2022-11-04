---
title: Troubleshoot slow queries due to query optimizer timeout
description: Provides an explanation on what optimizer timeout is and how it can affect query performance in SQL Server.
ms.date: 10/29/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.prod: sql
author: PijoCoder 
ms.author: jopilov
---

# Troubleshoot slow queries affected by query optimizer timeout

_Applies to:_ &nbsp; SQL Server

This article provides an explanation on what optimizer timeout is and how it can affect query performance in SQL Server.

## What's an Optimizer timeout?


SQL Server uses a cost-based query optimizer (QO). For information on QO, see [Query processing architecture guide](/sql/relational-databases/query-processing-architecture-guide). A cost-based optimizer selects a query execution plan with the lowest cost after it has built and assessed multiple query plans. One of the objectives of the SQL Server query optimizer (QO) is to spend a "reasonable time" in query optimization as compared to query execution; optimizing a query is to be much faster than executing it. To accomplish this, QO has a built-in threshold of tasks to consider before it stops the optimization process. If this threshold is reached before QO has considered most, if not all, possible plans, then it has reached the Optimizer TimeOut limit. An optimizer timeout event is reported in the query plan as `TimeOut` under "Reason For Early Termination of Statement Optimization." It's important to understand that this threshold isn't based on clock time but on number of possibilities considered. In current SQL Server QO versions, over a half million tasks are considered before a time out is reached.

The optimizer timeout is designed into SQL Server and in many cases encountering it isn't a factor affecting query performance. However, in some cases the SQL query plan choice may be negatively affected by the optimizer timeout and slower query performance could result. When you encounter such issues, understanding the optimizer timeout mechanism and how complex queries can be affected, can help you to troubleshoot and improve your query speed.

The result of reaching the optimizer timeout threshold is that SQL Server hasn't considered the entire set of possibilities for optimization. That is, it may have missed plans that could produce shorter execution times. QO will stop at the threshold and consider the least-costly query plan at that point, even though there may be better, unexplored options. Keep in mind that the "good enough" plan selected after a optimizer timeout is reached can produce a reasonable execution duration for the query. However, in some cases the plan found up to this point might result in a query execution that's suboptimal.



### How to detect an optimizer timeout?

Here are symptoms that indicate an optimizer timeout:

- **Complex query:** You have a complex query that involves lots of joined tables (for example, eight or more tables are joined).
- **Slow query:** The query may run slowly or slower than when you compare it to another SQL Server version or another system.
- **Query plan shows StatementOptmEarlyAbortReason=Timeout:** The query plan of the query shows the following information in the XML query plan: `StatementOptmEarlyAbortReason="TimeOut"`. Or, if you verify the properties of the left-most plan operator in Microsoft SQL Server Management Studio, you notice the value of "Reason For Early Termination of Statement Optimization" is “TimeOut.”


The following XML output from a query plan shows the optimizer timeout:

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


The following example shows a graphical representation of a query plan, which displays a "TimeOut" value:

:::image type="content" source="media/optimizer-timeout/opitmizer-timeout-in-query-plan-ssms.png" alt-text="optimizer timeout in query plan when you view in SSMS":::


## What causes an optimizer timeout? 

There's no simple formula to determine what conditions would cause the optimizer threshold to be reached or exceeded. However, the following are some factors that determine how many plans are explored by QO in the process of looking for a "best plan":

### In what order to join tables:

Here's an example of the decision options with three tables (Table1, Table2, Table3)

- join Table1 with Table2 and the result with Table3
- join Table1 with Table3 and the result with Table2
- join Table2 with Table3 and the result with Table1

Note The larger the number of tables, the larger the possibilities are.
 

### What heap or binary tree (HoBT) access structure to use to retrieve the rows from a table?

- Clustered index
- Nonclustered Index1
- Nonclustered Index2
- Table heap


### What physical access method to use?

- Index seek
- Index scan
- Table scan


### What physical join operator to use?

- Nested Loop
- Hash Match
- Merge Join
- Adaptive joins

For more information, see [Joins](/sql/relational-databases/performance/joins)

### Parallel execution or serial execution plan?

The decision here is whether to execute parts of the query in parallel or serially. For more information see [Parallel query processing](/sql/relational-databases/query-processing-architecture-guide)

### Example to illustrate how the factors are considered

To illustrate, take an example of a join between three tables (T1, T2 and T3) and each table has a clustered index and a non-clustered index. There are two joins involved here and because there are three physical join possibilities (NL, HM, MJ), then each of the two joins can be performed in six (2 * 3) ways. Also consider the join order:

- T1 joined to T2 and then to T3
- T1 joined to T3 and then to T2
- T2 joined to T3 and then to T1

Now multiply six ways to three join orders and we have a minimum of 18 possible plans to choose from. Next, consider that either the clustered or non-clustered index could be used for data retrieval (2 possibilities for T1 , 2 for T2 and 2 for T3, which is 2*2*2 =8). Thus we multiply 18 * 8 = 144 possibilities. Further, if you include the possibility of parallelism and other factors like Seek or Scan of the HoBT, then the possible plans increase geometrically. If you're a math wizard you can figure out that when a query involves 10 tables, the possible plan combinations are in the millions or worst-case hundreds of millions. Therefore, you can see that a query with lots of joins is more likely to reach the optimizer timeout threshold than one with fewer joins.

Keep in mind that query predicates (filters in the WHERE clause) and existence of constraints and the combination of well-designed and up-to-date statistics will reduce the number of access methods considered and thus the possibilities considered.

Again, the fact that QO stopped at the threshold does not mean you will end up with a slower query. But in some cases you may see slower query execution. 

## Why do you see an Optimizer Timeout with a simple query?

Nothing with query optimizer (QO) is simple or black and white. There are so many possible scenarios and its complexity so high that it's hard to grasp all of the possibilities. The Query Optimizer may dynamically adjust/set timeout threshold based on the cost of the plan found at a certain stage. For example, if a plan that appears relatively "cheap" is found, then the task limit to search for a better plan may be reduced. Therefore, grossly underestimated cardinality estimation may be one example for hitting an optimizer timeout early. In this case, the focus of investigation is cardinality estimation. This is a rarer case than the scenario that's discussed previously about running a complex query, but it's possible.


## Steps to resolve:


The following are different alternatives that you can explore to help improve the performance of the query. Keep in mind that an optimizer timeout appearing in a query plan, doesn't necessarily mean that it's the reason for query slowness.

### Step 1. Do nothing

In most cases, you may have to do nothing about this. The query plan that SQL Server ends up with may be reasonable and the query you're running may be performing well. You may not ever know that you've encountered an optimizer timeout.


But in the cases where you find the need to tune and optimize, consider the following options:


### Step 2. Establish a baseline

Can you execute this same query with the same data set on a different build of SQL Server, or using a different Cardinality Estimation configuration or on a different system (hardware specs)? A guiding principle in performance tuning is "There's no performance problem without a baseline"; therefore it would be important to establish a base line for the same query.

### Step 3. Look for "hidden" conditions that lead to optimizer timeout

Examine your query in detail to determine its complexity. Upon initial examination, it may not be obvious that the query is complex and involves many joins. A common scenario here's when views or table-valued functions are involved. For example, on the surface, the query may appear to be simple because it joins two views. But when you examine the queries inside the views, you may find that each view joins seven tables and as a result when the two views are joined, you end up with a 14-table join. If your query uses the following objects, drill down into each object to see what the underlying queries inside it look like:

- [Views](/sql/relational-databases/views/create-views)
- [Table Valued Functions (TFVs)](/sql/relational-databases/user-defined-functions/create-user-defined-functions-database-engine)
- [Subqueries or Dervied tables](/sql/relational-databases/performance/subqueries)
- [Common Table Expressions (CTEs)](/sql/t-sql/queries/with-common-table-expression-transact-sql)
- [UNION operators](/sql/t-sql/language-elements/set-operators-union-transact-sql)


For all of these scenarios, the most common resolution would be to re-write the query and break it up into multiple queries. See [Step 9](#step-9-rewrite-the-query) for more details.

#### Subqueries or derived tables

The query below seems like a combination of two separate sets of queries (derived tables) with 4-5 joins in each, and then joined to each other.  However, under once SQL Server parses, it will compile a single query with eight tables joined.

```sql
SELECT 
  ....
FROM 
  (
    SELECT 
      ...
    FROM 
      T1 
      JOIN T2 ON...
      JOIN T3 ON...
      JOIN T4 ON...
    WHERE 
      ) as derived_table1 

  INNER JOIN (
    SELECT 
      ...
    FROM 
      T5 
      JOIN T6 ON...
      JOIN T7 ON...
      JOIN T8 ON...
    WHERE 
      ...
  ) as derived_table2 

  ON derived_table1.Co1 = derived_table2.Co10 
  AND derived_table1.Co2 = derived_table2.Co20

```

For more information, see [Subqueries](/sql/relational-databases/performance/subqueries)

#### Common Table Expressions (CTEs)

Using Multiple Common Table Expressions (CTEs) isn't an appropriate solution to simplify a query and avoid optimizer timeout. Multiple CTEs will only increase the complexity of the query. Therefore, it’s counterproductive to use CTEs when solving optimizer timeouts. CTEs appear to break a query logically, but they're combined into a single query and optimized as a single large join of tables.

Here's an example of a CTE, which is compiled as a single query with many joins. It may appear that the query against the my_cte is two-object simple join, but under the covers there are seven other tables joined in the CTE.

```sql
WITH my_cte AS (
  SELECT 
    ...
  FROM 
    T1 
    JOIN T2 ON...
    JOIN T3 ON...
    JOIN T4 ON...
    JOIN T5 ON...
    JOIN T6 ON...
    JOIN T7 ON...
  WHERE 
    )
 
SELECT 
  ...
FROM 
  my_cte 
  JOIN T8 ON...

```


#### Views

Similar to CTEs and derived tables, joins can be hidden inside views. Be sure to examine your view definitions to understand all tables involved. For example, a join between two views may ultimately be a single query with eight tables involved. Here's an example:

```sql
CREATE VIEW V1 AS 
SELECT 
  ...
FROM 
  T1 
  JOIN T2 ON...
  JOIN T3 ON...
  JOIN T4 ON...
WHERE ...

GO

CREATE VIEW V2 AS 
SELECT 
  ...
FROM 
  T5 
  JOIN T6 ON...
  JOIN T7 ON...
  JOIN T8 ON...
WHERE 
  ...
GO
SELECT ...
FROM 
  V1 
  JOIN V2 ON V1...= V2...

```


#### Table Valued Functions (TVFs)

You can also find many joins buried inside multiple TFVs. What appears as a join between two TFVs and a table may be a nine-table join when you examine the code:

```sql
CREATE FUNCTION Tvf1() RETURNS TABLE AS RETURN 
SELECT 
  ...
FROM 
  T1 
  JOIN T2 ON...
  JOIN T3 ON...
  JOIN T4 ON...
WHERE 
  GO 

CREATE FUNCTION Tvf2() RETURNS TABLE AS RETURN 
SELECT 
  ...
FROM 
  T5 
  JOIN T6 ON...
  JOIN T7 ON...
  JOIN T8 ON...
WHERE 
  ...

GO

SELECT 
FROM Tvf1() 
  JOIN Tvf2() ON...
  JOIN T9
```

#### Union

Union operators combine the results of multiple queries into a single result set. But they also combine the multiple queries into a single query under the covers. This makes for a single, complex query. The following example will end up with a single query plan that involves twelve tables.

```sql
SELECT 
  ...
FROM 
  T1 
  JOIN T2 ON...
  JOIN T3 ON...
  JOIN T4 ON...

UNION ALL

SELECT 
  ...
FROM 
  T5 
  JOIN T6 ON...
  JOIN T7 ON...
  JOIN T8 ON...

UNION ALL

SELECT 
  ...
FROM 
  T9 
  JOIN T10 ON...
  JOIN T11 ON...
  JOIN T12 ON...

```





### Step 4. If you have a baseline query that runs faster, use its query plan

If you determine that a particular baseline plan (Step 2) is better for your query through testing, ask QO to select that plan. For methods to do this, see the following reference articles:

- [How to force a plan by using Query Data Store (QDS)](/sql/relational-databases/system-stored-procedures/sp-query-store-force-plan-transact-sql)

- [Query hints OPTION (USE PLAN `<XML PLAN HERE`>)](/sql/t-sql/queries/hints-transact-sql-query#use-plan)

- [Plan guides](/sql/relational-databases/performance/plan-guides)

 
### Step 5. Reduce plans choices

Try to reduce the possibilities that QO needs to consider in choosing a plan and thefore reducing the chance of an optimizer timeout. This process involves testing the query with different query hint options. As is with most decisions with QO, the choices aren't always deterministic on the surface because there's a large variety of factors considered. Therefore, there isn't a single guaranteed successful strategy. These may improve or worsen the performance of the selected query. For more information, see [Query Hints](/sql/t-sql/queries/hints-transact-sql-query):

#### Force a JOIN order

- Eliminate the order permutations: OPTION (FORCE ORDER)

```sql
SELECT 
  ...
FROM 
  T1 
  JOIN T2 ON...
  JOIN T3 ON...
  JOIN T4 ON...
  JOIN T5 ON...
  JOIN T6 
OPTION (FORCE ORDER)

```


#### Reduce the JOIN possibilities

You can also attempt to reduce the query plan combinations by limiting the choices of physical joins operators. This can be accomplished with [join hints](/sql/t-sql/queries/hints-transact-sql-join) although you must exercise caution. Using query hints to eliminate JOIN options can be a used if other alternatives haven't helped. Here are examples: OPTION (HASH JOIN, MERGE JOIN), OPTION (HASH JOIN, LOOP JOIN) or OPTION (MERGE JOIN). The reason for avoiding these is that in some cases limiting the optimizer with fewer join choices may cause the best join option not to be available and may actually slow the query down. Also in some cases a specific join is required by an optimizer (row goal is an example), and the query may fail to generate a plan if that join isn't an option. Therefore, target join hints for a specific query and see if you find a combination that offers better performance and eliminates the optimizer timeout. Here are two examples of how to use such hints:

Use join hints to use only Hash and Loop joins and avoid Merge join in the query:

```sql
SELECT 
  ...
FROM 
  T1 
  JOIN T2 ON...
  JOIN T3 ON...
  JOIN T4 ON...
  JOIN T5 ON...
  JOIN T6 
OPTION (HASH JOIN, MERGE JOIN)
```

Enforce a specific join between two tables:

```sql
SELECT 
  ...
FROM 
  T1 
  INNER MERGE JOIN T2 ON...
  JOIN T3 ON...
  JOIN T4 ON...
  JOIN T5 ON...
  JOIN T6 
```




### Step 7. Change Cardinality Estimation (CE) configuration

You can attempt to change the Cardinality Estimation configuration by switching from Legacy CE to New CE or from New CE to Legacy CE. Changing the Cardinality Estimation configuration can cause the QO to pick a different path when SQL Server evaluates and creates query plans. So even if an optimizer timeout issue occurs, it's possible that you end up with a plan that performs more optimally than the one selected using the alternate CE configuration. For more information, see how you can assess and choose the best cardinality estimation configuration for your SQL Server sys... .

For more information, see [How to activate the best query plan (Cardinality Estimation)](/sql/relational-databases/performance/cardinality-estimation-sql-server)


### Step 8. Enable Optimizer fixes

If you haven't enabled Query Optimizer fixes via one of the following two methods:

 - Server level by using trace flag [T4199](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf4199) 
 - Database level by using `ALTER DATABASE SCOPED CONFIGURATION ..QUERY_OPTIMIZER_HOTFIXES = ON` or change database compatibility levels for SQL Server 2016 and later

You may consider enabling these fixes. The QO fixes may cause the optimizer to take a different path in plan exploration and therefore possibly end up with a more optimal query plan. For more information, see [SQL Server query optimizer hotfix trace flag 4199 servicing model](https://support.microsoft.com/topic/kb974006-sql-server-query-optimizer-hotfix-trace-flag-4199-servicing-model-cd3ebf5c-465c-6dd8-7178-d41fdddccc28) .

### Step 9. Rewrite the query

Consider breaking up the single multi-table query into multiple separate queries by using temporary tables. Breaking up the query is just one of the ways to simplify the task for the optimizer. See the following example:

```sql 
SELECT 
  ...
FROM 
  t1 
  JOIN t2 ON ....
  JOIN t3 ON ....
  JOIN t4 ON ....
  JOIN t5 ON....
  JOIN t6 ON....
  JOIN t7 ON....
  JOIN t8 ON....
```

To optimize, try to break down the single query into two queries by inserting part of the join results in a temporary table:

```sql
SELECT...
INTO #temp1
  t1 
  JOIN t2 ON ....
  JOIN t3 ON ....
  JOIN t4 ON....
```

```sql
SELECT  ...
FROM #temp1
  JOIN t5 ON....
  JOIN t6 ON....
  JOIN t7 ON....
  JOIN t8 ON....
```
