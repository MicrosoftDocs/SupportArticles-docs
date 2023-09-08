---
title: Upgrade compatibility level degrades performance
description: This article provides resolutions for the problem that occurs when you upgrade database compatibility level from 120 to 130.
ms.date: 09/11/2020
ms.custom: sap:Performance
---
# Performance degradation when you upgrade database compatibility level from 120 to 130

This article helps you resolve the problem that occurs when you upgrade database compatibility level from 120 to 130.

_Original product version:_ &nbsp; SQL Server 2016, SQL Server 2017 on Windows (all editions)  
_Original KB number:_ &nbsp; 3212023

## Summary

Consider the following scenario:

- You run a spatial query by using a filter with a function such as `STIntersects` in SQL Server 2016 or in SQL Server 2017 on Windows.
- The database compatibility level is 120.
- The query uses a parallel execution plan.
- You upgrade the database compatibility level to 130, and the execution plan has changed from parallel to serial.

In this scenario, you experience performance degradation if the query returns a large result set.

## Resolution

To address this issue, try one of the following methods:

- Revert your database compatibility level to 120. When you do this, you will not be able to benefit from some of the functionality that's available in SQL Server 2016 or in SQL Server 2017 on Windows under database compatibility level 130. However, you will still be able to realize many improvements that are not bound to the database compatibility level, for example, an overall performance improvement of query operations with spatial data types.

  For a list of SQL Server 2016 enhancements that require database compatibility level 130, see [ALTER DATABASE (Transact-SQL) Compatibility Level](/sql/t-sql/statements/alter-database-transact-sql-compatibility-level).

- Force the plan that's generated with database compatibility level 120 if it provides better performance. You can force this plan while running with database compatibility level 130 by using the `USE PLAN` query hint. For more information about using hints, see [Hints (Transact-SQL) - Query](/sql/t-sql/queries/hints-transact-sql-query).

  Alternatively, use Query Store to identify and fix specific plan choices. For more information about using Query Store for this purpose, see [Query Store Usage Scenarios](/sql/relational-databases/performance/query-store-usage-scenarios).

## More information

SQL Server database compatibility levels 120 and 130 use different approaches to estimating cardinality of predicates, where a scalar user-defined function or a particular T-SQL function (such as STIntersects) is compared to a constant.

Although the cost model that's used by database compatibility level 130 generates performance gains for many workloads as compared to level 120, for some queries (depending on the data and functions used) performance of query plans may actually decrease at level 130.

## Applies to

- SQL Server 2017 on Windows (all editions)
- SQL Server 2016 Service Pack 1
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Web
