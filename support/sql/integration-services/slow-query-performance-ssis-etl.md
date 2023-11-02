---
title: Troubleshoot slow query performance in SSIS or ETL jobs
description: This article helps resolve issues that occur because of Slow query performance by the SSIS or ETL jobs.
ms.date: 05/10/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
author: Yue0119
ms.author: yuej
ms.reviewer: v-jayaramanp
---

# Troubleshoot slow query performance in SSIS or ETL jobs

This article helps you to troubleshoot problems related to slow query performance. It also provides various causes and resolutions.

## Symptoms

You might encounter performance issues from the SQL server integration services (SSIS) or extract, transform and load (ETL) jobs. The jobs might fail because of complex joins and huge Data Manipulation Language (DML) queries and might take a long time to complete. These performance issues are normal.

Before you start troubleshooting such issues, consider the following questions:

- Did you check which SQL statement in the Batch, ETL, or Bulk Data Processing job is slow?
- Have you enabled a performance monitor tool such as Microsoft or a third-party tool to monitor the session status in the SQL Batch, ETL, or Bulk Data Processing job?
- When did the issue occur? Before that, was there any change in the data volume or the Batch, ETL, or Bulk Data Processing T-SQL statement?
- Was there an SQL Server or OS patch or upgrade? Was there a change or migration in the server hardware?

## Causes and resolutions

The following sections explain the typical reasons, solutions, and troubleshooting steps for the slow SSIS or ETL jobs.

### Performance issue isn't blocked on the SQL Server

The SSIS job might contain many data flow tasks, and it might try to download source files from the FTP server and then insert the data into SQL. Perform the following steps to check if the SSIS job is blocked on the SQL Server.

1. Use the `sys.sysprocesses` and `sys.dm_exec_sql_text` functions to check if there are active SSIS related queries. If there are active queries, then the program name must resemble the following screenshot:

   :::image type="content" source="media/slow-query-performance-ssis-etl/ssis-package-spid.png" alt-text="Find active SSIS related queries.":::

   The program name might be different when you run the package with a different version of SSIS or a different method. If you can't filter by the program name, use query text to search. For example:

   ```sql
   SELECT text,* FROM sys.dm_exec_requests
   CROSS APPLY sys.dm_exec_sql_text(sql_handle)
   WHERE session_id>50 and text like '%Employees%'
   ```

1. If you didn't find the queries using step 1, use the Process Monitor tool to identify if any operations are blocked on the Files layer, as the SSIS package can load data from flat files. If the process is SSIS, you can use *DTExec.exe* to filter the process name.

1. Contact an SSIS engineer to enable the SSIS package logging for identifying the steps that take a long time and contribute to major delay.

### Can't complete complex query

If you complete the query, collect the actual execution plan, and treat it as a normal slow query tuning. If you can't complete the query, use the following steps to find the actual execution plan of the running query (2016 SP1 and above):

1. Run the following statement `SET STATISTICS XML` to `ON` for it, as shown in the following code snippet. Let the query run for a longer period.

    ```sql
    SET STATISTICS XML ON
    --your query body
    SET STATISTICS XML OFF
    ```

1. Run the following statement to collect the lightweight query plan; replace the `spid` (Server process ID) with your executing query window's `spid`:

    ```sql
    SELECT * FROM sys.dm_exec_query_statistics_xml(spid)
    SELECT text, * FROM sys.dm_exec_query_statistics_xml(spid)
    CROSS APPLY sys.dm_exec_sql_text(sql_handle)
    ```

1. Click the `query_plan`, and you'll be able to provide the plan in the flight query's execution plan graph.

    :::image type="content" source="media/slow-query-performance-ssis-etl/queryplan-sqlplan.png" alt-text="Save the query plan.":::

1. Find the major resource consumer in the query plan. If you have a historical query plan such as the Query Store feature of SQL, compare and check why the plan changed.

### Insert statement performance

The insert operation is one of the reasons to slow the query performance. The following reasons could be causing the insert operation to slow down:

- Inserting a large batch causes a log flush, which increases the waiting period.
- Each insert is against a clustered-index primary key (defined as an identity column), which causes a hotspot. The symptom is a `PAGELATCH` contention (specific to inserts from multiple connections).
- Inserts are slower against a Heap.
- The I/O subsystem could be slow.

Following are some common troubleshooting tips:

- If too many indexes are in the underlying table, consider disabling or dropping indexes as explained in [Slow inserts in SQL Server](https://techcommunity.microsoft.com/t5/sql-server-support-blog/meditation-slow-inserts-in-sql-server/ba-p/333984).
- To use the `INSERT` statement with `SELECT`, check if the select operation's performance is good.

### Delete statement performance

The following reasons could be why the delete operation slows down the query performance:

- Delete operations are blocked.
- The I/O subsystem might be slow.

Following are some troubleshooting tips to resolve this scenario:

- Check if there are `DELETE CASCADE` statements. If yes, check the delete execution plan, or you can consider disabling the `DELETE CASCADE` operation for the table. For cascade options, see [ALTER TABLE table_constraint (Transact-SQL)](/sql/t-sql/statements/alter-table-table-constraint-transact-sql?view=sql-server-ver15&preserve-view=true).
- Tune the performance of `SELECT` in the `DELETE` statement. For example, you can rewrite the delete operation as a `SELECT` statement in the following query and modify the select query performance.

    ```sql
    DELETE P
      FROM Product P
      LEFT JOIN OrderItem I ON P.Id = I.ProductId
     WHERE I.Id IS NULL
    ```

### ETL job performance was faster before and slower now

If the ETL jobs have become slow, the following factors could be the reason:

- The data volume disk might have changed. For example, there could be a change in the speed or load on the volume disk.
- There could be a change in the configuration of SQL or OS. For example, the `MAXDOP` setting might have changed. Also, there might have been an upgrade in the SQL Server version or application. An upgrade of the compatibility level can introduce CE changes.
- The hardware components' performance, such as disk I/O, CPUs, or memory could have changed.

Following are some common troubleshooting tips:

- Recreate the previous scenario where the performance was fast by providing the same hardware and job configuration. This step is required to help PSSDIAG (or similar utility) collect data for comparing and identifying slow queries. If SSIS jobs are involved, you can request SSISDB reports from a slow and fast scenario to compare package duration.
- After identifying the slow query, see [Can't complete complex query](#cant-complete-complex-query), [Delete statement performance](#delete-statement-performance), and [Insert statement performance](#insert-statement-performance) to troubleshoot query performance.

### SSIS related settings

If the bottleneck isn't on the SQL server, see [SSIS: Capturing PerfMon Counters During Package Execution](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/ssis-capturing-perfmon-counters-during-package-execution/ba-p/371346) and check if anything can be improved from the SSIS.
