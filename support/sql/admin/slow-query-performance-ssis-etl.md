---
title: Troubleshoot slow query performance in the SSIS or ETL jobs
description: This article helps you resolve issues that occur because of Slow query performance from SSIS or ETL jobs.
ms.date: 05/02/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.prod: sql
author: yuej
ms.author: v-jayaramanp
---

# Troubleshoot slow query performance in SSIS or ETL jobs

## Symptoms

You may encounter some performance issues from the SQL Server Integration Services (SSIS) or Extract, Transform and Load (ETL) jobs, which are treated as normal. The jobs may fails because of complex joins and huge DML queries. These jobs may take a long time to complete.

Before you start troubleshooting such issues, consider the following questions:

- Did you check which SQL statement in the Batch, ETL, or Bulk Data Processing job is slow?
- Have you enabled a performance monitor tool such as Microsoft or 3rd party to monitor the session status in SQL Server of the Batch, ETL, or Bulk Data Processing job?
- When did the issue occur? Before that, was there any change in the data volume or in the Batch, ETL, or Bulk Data Processing T-SQL statement?
- Was there an SQL Server or OS patch or upgrade? Was there a change or migration in the Server Hardware?

## Causes and resolutions

The following sections list the common reasons, solutions, and troubleshooting steps for the slow SSIS or ETL jobs.

### Not stuck on SQL Server side

The SSIS job may contain many data flow tasks and it may try to download some source files from the FTP server, and then insert the data into SQL. Perform the following steps to check if the SSIS job is stuck on the SQL Server side.

1. Use the `Sys.sysprocesses` and `sys.dm_exec_sql_text` functions to check if there are active SSIS related queries. If there are then the program name should resemble the following screenshot:

:::image type="content" source="media/slow-query-performance-ssis-etl/ssis-package-spid.png" alt-text="Find active SSIS related queries.":::

The program name can be different when you run the package with a different version of SSIS or different methods. If you can't filter by the program name, use query text to search. For example:

    ```sql
    Select program_name, text,* from sys.sysprocesses 
    cross apply sys.dm_exec_sql_text(sql_handle)
    where spid>50 and text like ‘%Employees%’
    ```

1. If you didn't find the queries using step 1, use the Process Monitor to identify if any operations are blocked on the Files layer, since SSIS package can load data from flat files.

1. Contact the Microsoft SSIS support team to collect the SSIS package logs

### Complex select query cannot be completed

If the query can be completed, collect the actual execution plan, treat it as a normal slow query tuning. If the query can’t be completed, use the following steps to find the actual execution plan of the running query (2016 SP1 and above):

1. Manually execute the query, but set statistics XML to ON for the query as shown in the following code snippet. Let the query run for a longer period than the expected period.

    ```sql
    SET STATISTICS XML ON
    --your query body
    SET STATISTICS XML OFF
    ```
1. Then run the following statement to collect the light weighted query plan, replace the spid (Server process ID) with your executing query window’s spid:

    ```sql
    Select * from sys.dm_exec_query_statistics_xml(spid)
    Select text, * from sys.dm_exec_query_statistics_xml(64)
    cross apply sys.dm_exec_sql_text(sql_handle)
    ```

1. Click on the `query_plan`, and save it as *.sqlplan*.

    :::image type="content" source="media/slow-query-performance-ssis-etl/queryplan-sqlplan.png" alt-text="Save the query plan.":::

### Insert performance

There are some factors that slow the query performance, and the Insert performance could be one of the reasons. The following could be reasons why the insert performance slows down the query performance:

- Each Insert in a large batch causes a log flush thereby increasing the wait period.
- Each Insert is against a clustered-index primary key, which is also defined as an identity column. This causes a natural hotspot. The symptom is `PAGELATCH` contention (specific to inserts from multiple connections).
- Inserts are slower against a Heap.
- The I/O subsystem could be slow.

Following are some common troubleshooting tips:

- If there too many indexes in the underlying table, consider disabling or dropping indexes as explained in [slow Inserts in SQL Server](https://techcommunity.microsoft.com/t5/sql-server-support-blog/meditation-slow-inserts-in-sql-server/ba-p/333984).
- To use `INSERT` with `SELECT`, check if the `SELECT` performance is good.

### Delete performance

The following could be reasons why the Delete performance operation slows down the query performance:

- The Delete operations may be blocked
- The I/O subsystem may be slow.

Follow these troubleshooting tips to resolve this scenario:

- Check if there are `cascade delete` operations. If yes, check the delete execution plan, or you can consider to disable the `cascade delete` for the table. For cascade options, see [ALTER TABLE table_constraint (Transact-SQL)](/sql/t-sql/statements/alter-table-table-constraint-transact-sql?view=sql-server-ver15).
- Tune the performance of `SELECT` in the `Delete` statement. For example, the following query is `DELETE`, but you can rewrite it as a `SELECT` and modify the select performance.

    ```sql
    DELETE P
      FROM Product P
      LEFT JOIN OrderItem I ON P.Id = I.ProductId
     WHERE I.Id IS NULL
    ```

### ETL jobs were faster before and are slower now

If the ETL jobs were faster and are slow at present, the following could be some reasons for the slow performance:

- Did data volumes (disk) change? For example, could the change be in the speed, load on the volumes, and so on?
- Did a configuration of SQL or OS change? For example, did the `MAXDOP` setting change? Was there an upgrade in the SQL Server version or application? An upgrade of compatibility level can introduce CE changes.
- Was there a change in the hardware component performance such as - disk I/O, CPUs, Memory and so on?
- If SSIS jobs are involved, can you request SSISDB reports from a slow and fast scenario to compare package duration? If not, can the previous fast scenario be re-created so PSSDIAG (or other similar) data can be collected for comparison and identification of slow queries?
- Do you know which specific query is slow?

### Other SSIS related settings

If the bottleneck is not on the SQL Server side, see [SSIS: Capturing PerfMon Counters During Package Execution](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/ssis-capturing-perfmon-counters-during-package-execution/ba-p/371346) and check if anything can be improved from the SSIS side.
