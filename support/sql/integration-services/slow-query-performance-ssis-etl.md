---
title: Troubleshoot Slow Queries in SSIS or ETL Jobs
description: Troubleshoot slow queries in SQL Server Integration Services (SSIS) and extract, transform, and load (ETL) jobs by comparing plans and performance data.
ms.date: 11/17/2026
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.reviewer: jopilov
ai-usage: ai-assisted
---

# Troubleshoot slow query performance in SSIS or ETL jobs

## Summary

This article helps you troubleshoot slow query performance in SQL Server Integration Services (SSIS) packages and extract, transform, and load (ETL) jobs that run against SQL Server. It describes the symptoms of slow SSIS and ETL jobs, explains how to tell whether SQL Server or another component causes the delay, and lists causes and resolutions for slow queries, `INSERT` statements, and `DELETE` statements. Use this article to find the slow step in a batch or bulk data processing job, collect the execution plan, and reduce job run time.

## Symptoms

SSIS packages and ETL jobs might take a long time to finish, or they might fail. These problems often occur when the jobs run complex joins or large Data Manipulation Language (DML) queries. Long run times are common in these workloads.

Before you start troubleshooting such issues, consider the following questions:

- Did you check which SQL statement in the Batch, ETL, or Bulk Data Processing job is slow?
- Have you enabled a performance monitor tool such as Microsoft or a third-party tool to monitor the session status in the SQL Batch, ETL, or Bulk Data Processing job?
- When did the issue occur? Before that, was there any change in the data volume or the Batch, ETL, or Bulk Data Processing T-SQL statement?
- Was there an SQL Server or OS patch or upgrade? Was there a change or migration in the server hardware?

## Causes and resolutions

The following sections explain the typical causes, solutions, and troubleshooting steps for the slow SSIS or ETL jobs.

### Performance issue isn't blocked on the SQL Server

An SSIS job might contain many data flow tasks, and it might try to download source files from the FTP server and then insert the data into SQL. Perform the following steps to check if the SSIS job is blocked on the SQL Server.

1. Use the `sys.sysprocesses` and `sys.dm_exec_sql_text` functions to check if there are active SSIS related queries. If there are active queries, the program name must resemble the following screenshot:

   :::image type="content" source="media/slow-query-performance-ssis-etl/ssis-package-spid.png" alt-text="Find active SSIS related queries.":::

   The program name might be different when you run the package with a different version of SSIS or a different method. If you can't filter by the program name, use query text to search. For example:

   ```sql
   SELECT text,* FROM sys.dm_exec_requests
   CROSS APPLY sys.dm_exec_sql_text(sql_handle)
   WHERE session_id>50 and text like '%Employees%'
   ```

1. If you didn't find the queries by using step 1, use the [Process Monitor](/sysinternals/downloads/procmon) tool to identify if any operations are blocked on the Files layer, as the SSIS package can load data from flat files. If the process is SSIS, you can use *DTExec.exe* to filter the process name. For more information about running packages from the command line, see [dtexec utility](/sql/integration-services/packages/dtexec-utility).

1. Work with an SSIS engineer to enable the [SSIS package logging](/sql/integration-services/performance/integration-services-ssis-logging). Logging helps you identify the steps that take a long time and contribute most to the delay.

### Can't complete complex query

If the query finishes, collect the actual execution plan, and treat it as a normal slow query tuning. 

If the query doesn't finish, use the following steps to find the actual execution plan of the running query (2016 SP1 and later). For a detailed walkthrough, see [Troubleshoot queries that seem to run endlessly in SQL Server](/troubleshoot/sql/database-engine/performance/troubleshoot-never-ending-query).

1. In the query window that runs the slow query, set `SET STATISTICS XML` to `ON` before the query, as shown in the following code snippet. Let the query run for a longer period.

    ```sql
    SET STATISTICS XML ON
    --your query body
    SET STATISTICS XML OFF
    ```

1. Run the following statement to collect the lightweight query plan. Replace the `spid` (server process ID) with your executing query window's `spid`:

    ```sql
    SELECT * FROM sys.dm_exec_query_statistics_xml(spid)
    SELECT text, * FROM sys.dm_exec_query_statistics_xml(spid)
    CROSS APPLY sys.dm_exec_sql_text(sql_handle)
    ```

1. Select the `query_plan`, and you can provide the plan in the flight query's execution plan graph.

    :::image type="content" source="media/slow-query-performance-ssis-etl/queryplan-sqlplan.png" alt-text="Save the query plan.":::

1. Find the major resource consumer in the query plan. If you have a historical query plan, such as one captured by the [Query Store](/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store) feature, compare the plans to find out why the plan changed.

### Insert statement performance

The insert operation is a common reason for slow query performance. The following reasons could cause the insert operation to slow down:

- Inserting a large batch causes a log flush, which increases the waiting period.
- Each insert is against a clustered-index primary key (defined as an identity column), which causes a hotspot. The symptom is a `PAGELATCH` contention (specific to inserts from multiple connections). For more information, see [Resolve last-page insert PAGELATCH_EX contention in SQL Server](/troubleshoot/sql/database-engine/performance/resolve-pagelatch-ex-contention).
- Inserts are slower against a heap.
- The I/O subsystem is slow.

Use the following tips to troubleshoot slow inserts:

- If the underlying table has too many indexes, consider disabling or dropping indexes as explained in [Slow inserts in SQL Server](https://techcommunity.microsoft.com/t5/sql-server-support-blog/meditation-slow-inserts-in-sql-server/ba-p/333984).
- To use the `INSERT` statement with `SELECT`, check if the select operation's performance is good.

### Delete statement performance

The following reasons could cause the delete operation to slow down query performance:

- Delete operations are blocked.
- The I/O subsystem is slow.

Use the following tips to troubleshoot slow deletes:

- Check if there are `DELETE CASCADE` statements. If yes, check the delete execution plan, or consider disabling the `DELETE CASCADE` operation for the table. For cascade options, see [ALTER TABLE table_constraint (Transact-SQL)](/sql/t-sql/statements/alter-table-table-constraint-transact-sql?view=sql-server-ver15&preserve-view=true).
- Tune the performance of `SELECT` in the `DELETE` statement. For example, you can rewrite the delete operation as a `SELECT` statement in the following query and modify the select query performance.

    ```sql
    DELETE P
      FROM Product P
      LEFT JOIN OrderItem I ON P.Id = I.ProductId
     WHERE I.Id IS NULL
    ```

### ETL job performance was faster before and slower now

If the ETL jobs become slow, the following factors could be the reason:

- The data volume disk might have changed. For example, there could be a change in the speed or load on the volume disk.
- There could be a change in the configuration of SQL or OS. For example, the `MAXDOP` setting might have changed. Also, there might be an upgrade in the SQL Server version or application. An upgrade of the compatibility level can introduce CE changes.
- The hardware components' performance, such as disk I/O, CPUs, or memory could have changed.

Use the following tips to troubleshoot this scenario:

- Recreate the previous scenario where performance was fast by using the same hardware and job configuration. Use [SQL LogScout](https://github.com/microsoft/SQL_LogScout) to collect data from the fast and slow scenarios so you can compare them and identify slow queries. If SSIS jobs are involved, request SSISDB reports from both scenarios to compare package duration.
- After identifying the slow query, see [Can't complete complex query](#cant-complete-complex-query), [Delete statement performance](#delete-statement-performance), and [Insert statement performance](#insert-statement-performance) to troubleshoot query performance.

### SSIS related settings

If the bottleneck isn't on the SQL server, see [SSIS: Capturing PerfMon Counters During Package Execution](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/ssis-capturing-perfmon-counters-during-package-execution/ba-p/371346) and check if anything can be improved from the SSIS.

## Related content

- [SSIS performance counters](/sql/integration-services/performance/performance-counters)
- [Troubleshooting tools for package execution](/sql/integration-services/troubleshooting/troubleshooting-tools-for-package-execution)