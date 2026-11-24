---
title: Join containment in Cardinality Estimator degrades query performance
description: Resolve slow queries with joins and filters caused by the Cardinality Estimator in SQL Server 2014 and later. Learn how to apply a query hint or trace flag.
ms.date: 11/23/2026
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ai-usage: ai-assisted
---
# Join containment assumption in the Cardinality Estimator degrades query performance

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 3189675

## Summary

The join containment assumption in the Cardinality Estimator (CE) can cause the SQL Server Query Optimizer to choose a suboptimal query plan for queries that contain joins and non-join filter predicates. This article explains why this performance degradation occurs in SQL Server 2014 (12.x) and later versions when queries are compiled by using the CE. It also shows how to apply the Simple Containment assumption by using the `ASSUME_JOIN_PREDICATE_DEPENDS_ON_FILTERS` query hint or trace flag 9476, without reverting to the legacy CE.

## Symptoms of join containment performance degradation

Consider the following scenario:

- You're using SQL Server 2014 (12.x) or a later version.
- You run a query that contains joins and non-join filter predicates.
- You compile the query by using the [Cardinality Estimation (SQL Server)](/sql/relational-databases/performance/cardinality-estimation-sql-server) model.

In this scenario, you experience query performance degradation. To confirm the problem, compare the estimated and actual number of rows for the join in the execution plan. A significant difference indicates a join cardinality estimation inaccuracy.

This problem doesn't occur if you compile the query by using the legacy CE (CE version 70).

## Cause: Base Containment replaces Simple Containment in the new CE

From SQL Server 2014 (12.x), the CE changes several assumptions from the legacy CE (CE version 70) in the model that the Query Optimizer uses to estimate cardinality for different operators and predicates. One of these changes is the join containment assumption.

### Join containment assumption in the legacy CE

The legacy CE model assumes that users always query for data that exists. For a join predicate that involves an equijoin operation between two tables, this assumption means that the joined columns exist on both sides of the join.

When non-join filter predicates are also present against the joined tables, the legacy CE assumes some level of correlation between the join predicates and the non-join filter predicates. This implied correlation is called Simple Containment.

### Join containment assumption in the new CE

The new CE uses Base Containment instead. The new CE model assumes that users might query for data that doesn't exist. As a result, the filter predicates on separate tables might not be correlated with each other. The new CE uses a probabilistic approach: it estimates the join selectivity from the base table histograms, and then factors in the selectivity of the filter predicates.

### Effect of the Base Containment assumption on query plans

In many practical scenarios, the Base Containment assumption produces better estimates, which in turn lead to more efficient query plan choices. However, in some situations, the Simple Containment assumption might provide better results. In those situations, you might experience a less efficient query plan choice when you use the new CE instead of the legacy CE.

For more information about how to troubleshoot issues related to the new CE, see [Decreased query performance after upgrade from SQL Server 2012 or earlier to 2014 or later](decreased-query-perf-after-upgrade.md).

## Resolution: Apply the Simple Containment assumption

In SQL Server 2014 (12.x) and later versions, you can force SQL Server to use the Simple Containment assumption instead of the default Base Containment assumption. Choose the method that fits whether you can modify the application query.

### Use the ASSUME_JOIN_PREDICATE_DEPENDS_ON_FILTERS query hint

If you can modify the application query, the better option is to use the `ASSUME_JOIN_PREDICATE_DEPENDS_ON_FILTERS` query hint starting with SQL Server 2016 (13.x) SP1. This hint is equivalent to trace flag 9476. For more information, see [USE HINT](/sql/t-sql/queries/hints-transact-sql-query#use_hint). For example:

```sql
SELECT * FROM Table1 t1
JOIN Table2 t2
ON t1.Col1 = t2.Col1
WHERE t1.Col1 = 10
OPTION (USE HINT ('ASSUME_JOIN_PREDICATE_DEPENDS_ON_FILTERS'));
```

### Apply the query hint without changing the query by using Query Store hints

If you can't modify the query, for example, because the Transact-SQL is hard-coded in an application, use a Query Store hint in SQL Server 2022 (16.x) and later versions. First, identify the `query_id` of the query in Query Store. Then, run the following command by using that `query_id` (the example uses `39`):

```sql
EXECUTE sys.sp_query_store_set_hints
    @query_id = 39,
    @query_hints = N'OPTION (USE HINT (''ASSUME_JOIN_PREDICATE_DEPENDS_ON_FILTERS''))';
```

> [!NOTE]
> If a Query Store hint already exists for the `query_id`, this command replaces it. Check the existing hints in `sys.query_store_query_hints` first, and include them in the `@query_hints` value if you want to keep them. Query Store hints can also override statement-level hints and plan guides, so test the resulting plan. To confirm that the hint was applied, run the query and check the `QueryStoreStatementHintText` attribute in the execution plan. Also check the `last_query_hint_failure_reason_desc` column in `sys.query_store_query_hints` for failures.

For more information, see [Query Store hints](/sql/relational-databases/performance/query-store-hints).

### Use trace flag 9476

You can use [trace flag 9476](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf9476) to force SQL Server to use the Simple Containment assumption. You can enable this trace flag globally, at the session level, or at the query level. Use the narrowest scope that fixes the problem, and test the change before you use it in production.

To enable the trace flag at the query level, use the `QUERYTRACEON` query hint:

```sql
SELECT * FROM Table1 t1
JOIN Table2 t2
ON t1.Col1 = t2.Col1
WHERE t1.Col1 = 10
OPTION (QUERYTRACEON 9476);
```

To enable the trace flag at the session level, run the following command:

```sql
DBCC TRACEON (9476);
```

To enable the trace flag globally, run the following command. This setting affects all queries on the server. To disable it, run `DBCC TRACEOFF (9476, -1);`.

```sql
DBCC TRACEON (9476, -1);
```

### Conditions for using the hint or trace flag instead of the legacy CE

Enabling this trace flag or using the query hint might improve query plan choice without reverting to the legacy CE model if the following conditions are true:

- You experience a suboptimal query plan choice that causes overall degraded performance for queries that contain joins and non-join filter predicates.
- You can verify a significant inaccuracy in a "join cardinality" estimation (that is, the actual number of rows versus the estimated number of rows differ significantly).
- This inaccuracy doesn't exist when you compile queries by using the legacy CE.

> [!NOTE]
> Using trace flags incorrectly can degrade your workload performance. For more information, see [Hints (Transact-SQL) - Query](/sql/t-sql/queries/hints-transact-sql-query).

## Related content

- [Troubleshoot SQL Server performance after a version upgrade](troubleshoot-performance-version-upgrade.md)
- [sys.sp_query_store_set_hints](/sql/relational-databases/system-stored-procedures/sys-sp-query-store-set-hints-transact-sql)
- [ALTER DATABASE SCOPED CONFIGURATION](/sql/t-sql/statements/alter-database-scoped-configuration-transact-sql)
