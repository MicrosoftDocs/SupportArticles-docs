---
title: Decreased query performance after upgrade from SQL Server 2012 or earlier to 2014 or later
description: Provides troubleshooting steps for an issue where a query runs slower after upgrade from SQL Server 2012 or earlier versions to 2014 or later versions
ms.date: 07/20/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.reviewer: jopilov
author: pijocoder
ms.author: jopilov
---

# Decreased query performance after upgrade from SQL Server 2012 or earlier to 2014 or later

After you upgrade SQL Server from 2012 or an earlier version to 2014 or a later version, you may encounter the following issue: most of the original queries run well, but a few of your queries run slower than in the previous version. Though there are many possible causes and contributing factors, one relatively common cause is the changes in the [Cardinality Estimation](/sql/relational-databases/performance/cardinality-estimation-sql-server) (CE) model after the upgrade. Significant changes were introduced to the CE models starting in SQL Server 2014.

This article provides troubleshooting steps and resolutions for query performance issues that occur when using the default CE but don't occur when using the legacy CE.

> [!NOTE]
> If all the queries run slower after the upgrade, the troubleshooting steps introduced in this article are likely not applicable to your situation.

## Troubleshooting: Identify if CE changes are the problem and find out the reason

#### Step 1: Identify if the default CE is used

1. Choose a query that runs slower after the upgrade.
1. Run the query and [collect the execution plan](/sql/relational-databases/performance/display-an-actual-execution-plan#to-include-an-execution-plan-for-a-query-during-execution).
1. From the execution plan Properties window, check **CardinalityEstimationModelVersion**.
    :::image type="content" source="media/decreased-query-perf-after-upgrade/query-plan-ce-version.png" alt-text="Find CE model version from the execution plan Properties window.":::
1. A value of 70 indicates the legacy CE, and a value of 120 or higher indicates the use of the default CE.

If the legacy CE is used, the CE changes aren't the cause of the performance issue. If the default CE is used, go to the next step.

#### Step 2: Identify if Query Optimizer can generate a better plan by using the legacy CE

Run the query [with the legacy CE](#query-level-use-query-hint-or-querytraceon-option). If it performs better than using the default CE, go to the next step. If performance doesn't improve, the CE changes aren't the cause.

#### Step 3: Find out why the query performs better with the legacy CE

Test the various CE-related [query-hints](/sql/t-sql/queries/hints-transact-sql-query#use_hint) for your query. For SQL Server 2014, use the corresponding trace flags [4137](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf4137), [9472](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf9472), and [4139](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf4139) to test the query. Determine which hints or trace flags positively impact the performance based on these tests.

## Resolution

To resolve the issue, try one of the following methods:

- Optimize the query.

  Understandably, it's not always possible to rewrite queries, but especially when there are only a few queries that can be rewritten, this approach should be the first choice. Optimally written queries perform better regardless of CE versions.
- Use query hints identified in [Step 3](#step-3-find-out-why-the-query-performs-better-with-the-legacy-ce).

  This targeted approach allows other workloads to benefit from the default CE assumptions and improvements. Additionally, it's a more robust option than creating a plan guide. And it doesn't require [Query Store](/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store) (QDS), unlike forcing a plan (the most robust option).
- Force a good plan.

  This is a favorable option and can be used to target specific queries. Forcing a plan could be done by using a [plan guide](/sql/relational-databases/performance/plan-guides) or QDS. QDS is generally easier to use.
- Use [database-scoped configuration](#database-level-set-scoped-configuration-or-compatibility-level) to force the legacy CE.

  This is a less preferred approach as it is a database-wide setting and applies to all queries against this database. Still, it's sometimes necessary when a targeted approach isn't feasible. It's certainly the easiest option to implement.
- Use trace flag 9841 to force legacy CE globally. To do this, use [DBCC TRACEON](#server-level-use-trace-flag) or set the trace flag as a [start-up parameter](/sql/tools/configuration-manager/sql-server-properties-startup-parameters-tab#optional-parameters).

  This is the least-targeted approach and should only be used as a temporary mitigation when you're unable to apply any of the other options.

## Options to enable Legacy CE

### Query level: Use Query Hint or QUERYTRACEON option

- For SQL Server 2016 SP1 and later versions, use hint `FORCE_LEGACY_CARDINALITY_ESTIMATION` for your query, for example:

   ```sql
   SELECT * FROM Table1
   WHERE Col1 = 10
   OPTION (USE HINT ('FORCE_LEGACY_CARDINALITY_ESTIMATION'));
   ```

- Enable trace flag 9481 to force a legacy CE plan. Here's an example:

   ```sql
   SELECT * FROM Table1
   WHERE Col1 = 10
   OPTION (QUERYTRACEON 9481)
   ```

### Database level: Set scoped configuration or compatibility level

- For SQL Server 2016 and later versions, alter database scoped configuration:

   ```sql
    --Force a specific database to use legacy CE
    ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = ON;

    -- Validate what databases use legacy CE
    SELECT name, value
        FROM sys.database_scoped_configurations 
    WHERE name = 'LEGACY_CARDINALITY_ESTIMATION';
   ```

- Alter the compatibility level for the database. It's the only database-level option available for SQL Server 2014. Note that this change impacts more than just the CE. To determine the impact of compatibility level changes, go to [ALTER DATABASE compatibility level (Transact-SQL)](/sql/t-sql/statements/alter-database-transact-sql-compatibility-level#differences-between-compatibility-levels) and examine the "Differences" tables in it.

   ```sql
   ALTER DATABASE <YourDatabase>
   SET COMPATIBILITY_LEVEL = 110  -- set it to SQL Server 2012 level
   ```

> [!NOTE]
> This change will affect all queries executing within the context of the database for which configuration is changed unless an overriding trace flag or query hint is used. Queries that perform better due to default CE may regress.

### Server level: Use trace flag

Use trace flag 9481 to force server-wide legacy CE:

```sql
--Turn on 
DBCC TRACEON(9481, -1)
--Validate
DBCC TRACESTATUS
```

> [!NOTE]
> This change will affect all queries executing within the context of the SQL Server instance unless an overriding trace flag or query hint is used. Queries that perform better due to default CE may regress.

## Frequently asked questions

#### Q1: I'm interested in upgrading to a more recent version of SQL Server, and I'm concerned about cardinality estimator performance regressions. What upgrade planning is recommended for minimizing issues?

For pre-existing databases running at lower compatibility levels, the recommended workflow for upgrading the query processor to a higher compatibility level is detailed in [Change the Database Compatibility Mode and Use the Query Store and Query Store Usage Scenarios](/sql/database-engine/install-windows/change-the-database-compatibility-mode-and-use-the-query-store). The methodology introduced in the article applies for moves to 130 or higher for SQL Server and Azure SQL Database.

#### Q2: I don't have time to test for CE changes. What can I do in this case?

For pre-existing applications and workloads, we don't recommend moving to the default CE until sufficient regression testing has been performed. If you still have doubts, we recommend that you still upgrade SQL Server and move to the latest available compatibility level. As a precaution, also enable trace flag 9481 for SQL Server 2014 or configure the [LEGACY_CARDINALITY_ESTIMATION database scoped configuration](#database-level-set-scoped-configuration-or-compatibility-level) `ON` for SQL Server 2016 and later versions until you have an opportunity to test.

#### Q3: Are there any disadvantages of using the legacy CE permanently?

Future cardinality estimator-related improvements and fixes are centered around more recent versions. Version 70 is an acceptable intermediate state. However, after careful testing, we recommend eventually moving to a more recent CE version to benefit from the most recent CE fixes. There's a high probability of query plan changes when moving from the legacy CE, so test before making changes to production systems. The changes can improve query performance in many cases, but in some cases, query performance may degrade.

> [!IMPORTANT]
> The default CE is the main code path that will receive future investment and deeper testing coverage over the long-term, so don't plan on using the legacy CE indefinitely.

#### Q4: I have thousands of databases and don't want to manually turn on LEGACY_CARDINALITY_ESTIMATION for each. Is there an alternative method?

For SQL Server 2014, enable trace flag 9481 to use the legacy CE for all databases irrespective of the compatibility level. For SQL Server 2016 and later versions, execute the following query to iterate through databases. The setting will be enabled even when the database is restored or attached in another server.

```sql
SELECT [name], 0 AS [isdone]
INTO #tmpDatabases
FROM master.sys.databases WITH (NOLOCK)
WHERE database_id > 4 AND source_database_id IS NULL AND is_read_only = 0

DECLARE @dbname sysname, @sqlcmd NVARCHAR(500);

WHILE (SELECT COUNT([name]) FROM #tmpDatabases WHERE isdone = 0) > 0
BEGIN
    SELECT TOP 1 @dbname = [name] FROM #tmpDatabases WHERE isdone = 0

    SET @sqlcmd = 'USE ' + QUOTENAME(@dbname) + '; 
        IF (SELECT [value] FROM sys.database_scoped_configurations WHERE [name] = ''LEGACY_CARDINALITY_ESTIMATION'') = 0
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = ON;'
 
    BEGIN TRY
        EXECUTE sp_executesql @sqlcmd
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState, ERROR_MESSAGE() AS ErrorMessage;
    END CATCH

    UPDATE #tmpDatabases
    SET isdone = 1
    WHERE [name] = @dbname
END;
```

For Azure SQL Database, you can create a support ticket to have this trace flag enabled at the subscription level but not the server level.

#### Q5: Will running with the legacy CE prevent me from getting access to new features?

Even with LEGACY_CARDINALITY_ESTIMATION enabled, you'll still get access to the latest functionality included with the version of SQL Server and the associated database compatibility level. For example, a database with LEGACY_CARDINALITY_ESTIMATION enabled running at database compatibility level 140 on SQL Server 2017 can still benefit from the [adaptive query processing](/sql/relational-databases/performance/adaptive-query-processing) feature family.  

#### Q6: When will the legacy CE go out of support?

We don't have plans to stop supporting the legacy CE at this point. However, future cardinality estimator-related improvements and fixes are centered around more recent versions of the CE.

#### Q7: I only have a few queries regressing with the default CE, but most query performance is the same or even improved. What should I do?

A more granular alternative to the server-scoped trace flag 9481 or the LEGACY_CARDINALITY_ESTIMATION database scoped configuration is the use of the query-scoped USE HINT construct. For more information, see [USE HINT query hint argument in SQL Server 2016](https://support.microsoft.com/help/3189813/update-introduces-use-hint-query-hint-argument-in-sql-server-2016) and [USE HINT](/sql/t-sql/queries/hints-transact-sql-query#use_hint).

> [!NOTE]
> There's also a `QUERYTRACEON` option with trace flag 9481, but you should consider using the `USE HINT` instead, as it's cleaner semantically and doesn't require special permissions.

`USE HINT FORCE_LEGACY_CARDINALITY_ESTIMATION` enables you to set the query optimizer CE model to version 70, regardless of the compatibility level of the database. See [Query level: Use Query Hint or QUERYTRACEON option](#query-level-use-query-hint-or-querytraceon-option).

Alternatively, if there's only one query that is problematic with the default CE, you could force a legacy CE plan stored in Query Store or use `FORCE_LEGACY_CARDINALITY_ESTIMATION` in conjunction with a plan guide.

#### Q8: If query performance regressed due to a plan change related to significant over or under-estimates when using the default CE, will the issue be fixed in the product?

CE is a complex problem, and the algorithms rely on the less-than-perfect data available for estimates, such as statistics for tables and indexes. There's no information for some out-of-model constructs like table-valued functions (TVFs) and models based on many assumptions (such as correlation or independence of the predicates and columns, uniform data distribution, containment, and so on).

Given the unlimited combinations of customer schema, data, and workloads, it's almost impossible to pick models that work for all cases. While some changes in the default CE may contain bugs (like any other software can) and can be fixed, other problems are caused by a model change.

Changes in [CE versions](/sql/relational-databases/performance/cardinality-estimation-sql-server#versions-of-the-ce), especially going from 70 to 120, include many different choices for models used. For example, when estimating filters, assume some level of correlation between the predicates because, in practice, such correlation frequently exists, and CE model 70 would underestimate results in such cases. While those changes were tested for many workloads and improved many queries, for some other queries, the legacy CE was a better match, and thus with the default CE, performance regressions may be observed.

Unfortunately, it's not considered to be a bug. In such situations, use a workaround such as tuning the query, just like you needed to do with the legacy CE if query performance isn't acceptable, or forcing a previous CE model or a specific execution plan.

#### Q9: Is there any resource to learn details about the cardinality changes in the default CE and the query performance impact?

See [Optimizing Your Query Plans with the SQL Server 2014 Cardinality Estimator](https://download.microsoft.com/download/D/2/0/D20E1C5F-72EA-4505-9F26-FEF9550EFD44/Optimizing%20Your%20Query%20Plans%20with%20the%20SQL%20Server%202014%20Cardinality%20Estimator.docx) for details and read the "What Changed in SQL Server 2014?" section.
