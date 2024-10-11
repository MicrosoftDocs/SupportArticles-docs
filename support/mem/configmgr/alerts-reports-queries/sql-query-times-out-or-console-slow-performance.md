---
title: SQL query times out or the ConfigMgr console is slow
description: Fixes an issue in which you may experience slow Configuration Manager console performance or unusual SQL query timeouts for certain Configuration Manager database queries in environments running SQL Server 2017, SQL Server 2016, or SQL Server 2014.
ms.date: 12/05/2023
ms.reviewer: kaushika, jarrettr
ms.custom: sap:Configuration Manager Database\SQL Settings and Configuration
---
# SQL query times out or console slow on certain Configuration Manager database queries

This article helps you fix an issue in which the Configuration Manager console is slow or the SQL query times out for certain Configuration Manager database queries.

_Original product version:_ &nbsp; SQL Server 2022 on Windows (all editions), SQL Server 2019 on Windows (all editions), SQL Server 2017 on Windows (all editions), SQL Server 2016 Enterprise, SQL Server 2016 Standard, SQL Server 2014 Enterprise, SQL Server 2014 Standard, System Center Configuration Manager  
_Original KB number:_ &nbsp; 3196320

## Symptoms

You experience slow Configuration Manager console performance or unusual SQL query timeouts for certain Configuration Manager database queries in environments running SQL Server 2014, SQL Server 2016, or SQL Server 2017 on Windows.

## Cause

SQL Server Cardinality Estimation (CE) changes in SQL Server 2014, SQL Server 2016, and SQL Server 2017 on Windows may cause performance issues with certain Configuration Manager queries in some environments.

## Resolution

In affected environments, Configuration Manager may run better when the site database is configured at a different SQL Server CE compatibility level. To identify the recommended CE level for your version of SQL Server, refer to the following table:

|SQL Server version|Supported compatibility level values|Recommended compatibility level for Configuration Manager|Recommended level for specific performance issues|
|---|---|---|---|
|SQL Server 2022|150, 140, 130, 120, 110|150|110|
|SQL Server 2019|150, 140, 130, 120, 110|150|110|
|SQL Server 2017|140, 130, 120, 110|140|110|
|SQL Server 2016|130, 120, 110|130|110|
|SQL Server 2014|120, 110|110|110|
  
Starting in Configuration Manager current branch version 1810, when the Configuration Manager database is running on SQL Server 2016 SP1 or later versions, all queries issued by the Admin console and SMS Provider will automatically add the `USE HINT 'FORCE_LEGACY_CARDINALITY_ESTIMATION'` query hint. Therefore, Admin console performance won't be affected when you change the CE Compatibility level to 110 at the database level to resolve performance issues. If you want to override this behavior, to have the Admin console and SMS Provider queries use the current SQL Server CE level instead, set the `UseLegacyCardinality` value to **0** under the following registry subkey on the computer that hosts the SMS Provider:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Providers`

To identify what SQL Server CE compatibility level is in use for the Configuration Manager database, run the following query:

```sql
SELECT name, compatibility_level FROM sys.databases
```

On SQL Server 2014 and SQL Server 2016 RTM, to identify whether using SQL Server 2012 CE (110) may improve Configuration Manager query performance, identify a query that is running slowly and manually test its performance at the SQL Server 2012 CE compatibility level. To do this, run the query in SQL Server Management Studio with `option (querytraceon 9481)` and compare the execution time to its performance without the flag.

Starting with SQL Server 2016 SP1, to accomplish this at the query level, add the `USE HINT 'FORCE_LEGACY_CARDINALITY_ESTIMATION'`[query hint](/sql/t-sql/queries/hints-transact-sql-query) instead of using trace flag 9481.

For more information about using `querytraceon` with trace flag 9481 at the specific-query level, see [Hints (Transact-SQL) - Query](/sql/t-sql/queries/hints-transact-sql-query). For information about using SQL Server Profiler to identify slow queries, see [SQL Server Profiler](/sql/tools/sql-server-profiler/sql-server-profiler).

See the following example of a specific-query test run at the SQL Server 2012 CE level against SQL Server 2014:

```sql
select SMS_DeploymentSummary.ApplicationName,SMS_DeploymentSummary.AssignmentID,SMS_DeploymentSummary.CI_ID,SMS_DeploymentSummary.CollectionID,SMS_DeploymentSummary.CollectionName,SMS_DeploymentSummary.CreationTime,SMS_DeploymentSummary.DeploymentID,SMS_DeploymentSummary.DeploymentIntent,SMS_DeploymentSummary.DeploymentTime,SMS_DeploymentSummary.DesiredConfigType,SMS_DeploymentSummary.EnforcementDeadline,SMS_DeploymentSummary.FeatureType,SMS_DeploymentSummary.ModelName,SMS_DeploymentSummary.ModificationTime,SMS_DeploymentSummary.NumberErrors,SMS_DeploymentSummary.NumberInProgress,SMS_DeploymentSummary.NumberOther,SMS_DeploymentSummary.NumberSuccess,SMS_DeploymentSummary.NumberTargeted,SMS_DeploymentSummary.NumberUnknown,SMS_DeploymentSummary.ObjectTypeID,SMS_DeploymentSummary.PackageID,SMS_DeploymentSummary.PolicyModelID,SMS_DeploymentSummary.ProgramName,SMS_DeploymentSummary.SecuredObjectId,SMS_DeploymentSummary.SoftwareName,SMS_DeploymentSummary.SummarizationTime,SMS_DeploymentSummary.SummaryType from fn_DeploymentSummary(1033) AS SMS_DeploymentSummary where SMS_DeploymentSummary.DeploymentID = N'CS100012' option (querytraceon 9481)
```

> [!NOTE]
> The query above and deployment ID CS100012 are for demonstration purposes only and will vary by environment.

If the above test indicates that performance gains can be achieved, use the following command in SQL Server Management Studio to set the Configuration Manager database to the SQL Server 2012 CE compatibility level:

```sql
ALTER DATABASE <CM_DB>
SET COMPATIBILITY_LEVEL = 110;
GO
```

> [!NOTE]
> In the above example, replace \<CM_DB> with your Configuration Manager site database name. To change the CE compatibility level to a different level, change the value in `SET COMPATIBILITY_LEVEL`.

## More information

When a SQL Server instance is upgraded in-place from any earlier version of SQL Server, pre-existing databases will keep their existing compatibility level if they are at the minimum allowed level for that new version of SQL Server. Upgrading SQL Server with a database at a compatibility level lower than the allowed level automatically sets the database to the lowest compatibility level allowed by the new version of SQL Server.

During upgrades or new installations of Configuration Manager, databases may be automatically configured to use the recommended SQL Server CE compatibility version for that version of SQL Server (as shown in the table that's mentioned in the [Resolution](#resolution) section). If you experience performance degradation after a servicing update, as a result of being reverted back to the default recommended CE level for your version of SQL Server, reassess whether you may have to manually change the CE level back to **110**.

For more information about SQL Server CE compatibility levels, see [ALTER DATABASE (Transact-SQL) Compatibility Level](/sql/t-sql/statements/alter-database-transact-sql-compatibility-level).
