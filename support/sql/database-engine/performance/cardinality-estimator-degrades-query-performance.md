---
title: Join containment assumption in the New Cardinality Estimator degrades query performance
description: This article helps you resolve performance problems that occur in SQL Server 2014 and later versions when you compile your queries using the new cardinality estimator.
ms.date: 08/12/2022
ms.custom: sap:Performance
---
# Join containment assumption in the New Cardinality Estimator degrades query performance

This article helps you resolve performance problems that can occur in SQL Server 2014 and later versions when you compile your queries using the new cardinality estimator.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 3189675

## Symptoms

Consider the following scenario:

- You're using SQL Server 2014 or a later version.
- You run a query that contains joins and non-join filter predicates.
- You compile the query by using the new [Cardinality Estimation (SQL Server)](/sql/relational-databases/performance/cardinality-estimation-sql-server) (New CE).

In this scenario, you experience query performance degradation.

This problem doesn't occur if you compile the query by using the Legacy CE.

## Cause

From SQL Server 2014, the New Cardinality Estimator (New CE) was introduced for database compatibility level 120 and greater. The New CE changes several assumptions from the legacy CE in the model that is used by the Query Optimizer when it estimates cardinality for different operators and predicates.

One of these changes is related to join containment assumption.

The Legacy CE model assumes that users always query for data that exists. This means that, for a join predicate that involves an equijoin operation for two tables, the joined columns exist on both sides of the join. In the presence of additional non-join filter predicates against the join table, the Legacy CE assumes some level of correlation for the join predicates and non-join filter predicates. This implied correlation is called Simple Containment.

Alternatively, the New CE uses Base Containment as the correlation. The New CE model assumes that users might query for data that doesn't exist. This means that the filter predicates on separate tables may not be correlated with each other. Therefore, we use a probabilistic approach.

For many practical scenarios, using the Base Containment assumption creates better estimates. This, in turn, creates more efficient query plan choices. However, in some situations, using the Simple Containment assumption may provide better results. If this occurs, you may experience less efficient query plan choice when you use the New CE instead of the Legacy CE.

For more information on how to troubleshoot issues related to New CE, see [Decreased query performance after upgrade from SQL Server 2012 or earlier to 2014 or later](decreased-query-perf-after-upgrade.md).

## Resolution

In SQL Server 2014 and later versions, you can use [trace flag 9476](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf9476) to force SQL Server to use the Simple Containment assumption instead of the default Base Containment assumption. If you can modify the application query, the better option is to use the query hint `ASSUME_JOIN_PREDICATE_DEPENDS_ON_FILTERS` after SQL Server 2016 (13.x) SP1. For more information, see [USE HINT](/sql/t-sql/queries/hints-transact-sql-query#use_hint). For example:

```sql
SELECT * FROM Table1 t1
JOIN Table2 t2
ON t1.Col1 = t2.Col1
WHERE Col1 = 10
OPTION (USE HINT ('ASSUME_JOIN_PREDICATE_DEPENDS_ON_FILTERS'));
```

Enabling this trace flag or using the query hint may improve query plan choice without having to fully revert to the Legacy CE model if the following conditions are true:

- You experience a suboptimal query plan choice that causes an overall degraded performance for queries that contain joins and non-join filter predicates.
- You can verify a significant inaccuracy in a "join cardinality" estimation (that is, the actual versus estimated number of rows that differ significantly).
- This inaccuracy doesn't exist when you compile queries by using the Legacy CE.

You can enable this trace flag globally, at the session level, or at the query level.

> [!NOTE]
> Using trace flags incorrectly can degrade your workload performance. For more information, see [Hints (Transact-SQL) - Query](/sql/t-sql/queries/hints-transact-sql-query).
