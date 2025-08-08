---
title: Troubleshoot queries that seem to never complete in SQL Server
description: Provides steps to help you identify and resolve issues where a query runs for a long time in SQL Server.
ms.date: 08/08/2025
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.reviewer: shaunbe, v-jayaramanp, jopilov
author: pijocoder
ms.author: jopilov
---

# Troubleshoot queries that seem to never end in SQL Server

This article describes the troubleshooting steps for the issue where you have a query that seems to never complete, or getting it to complete may take many hours or days.

## What is a never-ending query?

This document focuses on queries that continue to execute or compile, that is, their CPU continues to increase. It doesn't apply to queries that are blocked or waiting on some resource that is never released. In those cases the CPU remains constant or changes slightly.

> [!IMPORTANT]
> If a query is left to finish its execution, it will eventually complete. It could take just a few seconds, or it could take several days.

The term never-ending is used to describe the perception of a query not completing when in fact, the query will eventually complete.

## Cause

Common causes for long-running (never ending) queries include:

1. **Nested Loop joins on very large tables**  Queries that process lots of rows of data and typically join multiple tables. One common example is a query that involves Nested Loop (NL) joins. Due to the nature of NL joins a query that joins tables with lots of rows might run for a long time. There are some cases (TOP, FAST - row goal), where no other type of join can be used by a query but NL joins. Therefore, even if a Hash match or a Merge Join might be faster, the optimizer can't use them due to the nature of row goal.
1. **Out-of-date statistics:** Queries that pick a plan based on outdated statistics might be suboptimal and take a long time to run.
1. **Endless loops:** T-SQL queries that use WHILE loops might sometimes be incorrectly written. The result may be code that never leaves the loop and runs endlessly. These queries are truly never-ending and run until they're killed manually.
1. **Complex queries with many joins and large tables:** Queries that involve many joined tables would typically result in complex query plans that might take a long time to execute. Especially common are analytical queries that don't filter rows out and involve a large number of tables.
1. **Missing indexes:** Queries can be made to run faster when appropriate indexes are used on tables. Indexes allow for a subset of the data to be selected or to get to the data faster.

## Step 1. Identify a never-ending query

First find out if there's a never-ending query on the system. Also, to identify whether a query is taking a long time you need to understand whether it has

- long execution time
- long wait time (stuck on a bottleneck)
- long compilation time

Follow these steps:

### 1.1 Identify if there's a never-ending query

Run the following diagnostic query on your SQL Server instance where the never-ending query is active:

```sql
DECLARE @cntr int = 0

WHILE (@cntr < 3)
BEGIN
    SELECT TOP 10 s.session_id,
                    r.status,
                    CAST(r.cpu_time / (1000 * 60.0) AS DECIMAL(10,2)) AS cpu_time_minutes,
                    CAST(r.total_elapsed_time / (1000 * 60.0) AS DECIMAL(10,2)) AS elapsed_minutes,
                    r.logical_reads,
                    r.wait_time,
                    r.wait_type,
                    r.wait_resource,
                    r.reads,
                    r.writes,
                    SUBSTRING(st.TEXT, (r.statement_start_offset / 2) + 1,
                    ((CASE r.statement_end_offset
                        WHEN -1 THEN DATALENGTH(st.TEXT)
                        ELSE r.statement_end_offset
                    END - r.statement_start_offset) / 2) + 1) AS statement_text,
                    COALESCE(QUOTENAME(DB_NAME(st.dbid)) + N'.' + QUOTENAME(OBJECT_SCHEMA_NAME(st.objectid, st.dbid)) 
                    + N'.' + QUOTENAME(OBJECT_NAME(st.objectid, st.dbid)), '') AS command_text,
                    r.command,
                    s.login_name,
                    s.host_name,
                    s.program_name,
                    s.last_request_end_time,
                    s.login_time,
                    r.open_transaction_count,
                    atrn.name as transaction_name,
                    atrn.transaction_id,
                    atrn.transaction_state
        FROM sys.dm_exec_sessions AS s
        JOIN sys.dm_exec_requests AS r ON r.session_id = s.session_id 
                CROSS APPLY sys.Dm_exec_sql_text(r.sql_handle) AS st
        LEFT JOIN (sys.dm_tran_session_transactions AS stran 
                JOIN sys.dm_tran_active_transactions AS atrn
                ON stran.transaction_id = atrn.transaction_id)
        ON stran.session_id =s.session_id
        WHERE r.session_id != @@SPID
        ORDER BY r.cpu_time DESC
    
    SET @cntr = @cntr + 1
WAITFOR DELAY '00:00:05'
END
```

### 1.2 Examine the output to identify why query is taking long

There are a few scenarios that can lead to a query not completing for a long time: long execution , long wait, long compilation. For more information on this topic, see [Running vs. Waiting: why are queries slow?](troubleshoot-slow-running-queries.md#running-vs-waiting-why-are-queries-slow)

#### Long execution time

The troubleshooting steps in this article are applicable when you notice an output similar to the following one where the CPU is increasing proportionately to the elapsed time, without significant wait times.

session_id|status| cpu_time_minutes | elapsed_time_minutes|logical_reads |wait_time_minutes|wait_type|
|--|--|--|--|--|--|--|
|56 |running | 64.40 |23.50|0 |0.00|NULL|

An increasing CPU time for the query under investigation with a status of `running` or `runnable` and minimal or zero wait time, and no wait_type all mean that this query is continuously executing. In other words, it's reading rows, joining, processing results, calculating, formatting which all examples of CPU-bound actions. Changes in `logical_reads` aren't relevant in this case as some CPU-bound T-SQL requests might not do any logical reads at all (for example performing computations or a `WHILE` loop). If you observe a query of this category that means you need to focus on reducing it's execution time. Typically, reducing execution time involves reducing the rows the query needs to process throughout its life by applying indexes, rewriting the query, updating statistics. For more information, see the [Resolution](#step-4-resolution) section.

#### Long wait time

This article isn't applicable if you observe a wait scenario similar to the following one where the CPU doesn't change or changes slightly, and the session is waiting on a resource.

session_id|status| cpu_time_minutes | elapsed_time_minutes|logical_reads |wait_time_minutes|wait_type|
|--|--|--|--|--|--|--|
|56 |suspended | 0.03 |4.20|50 |4.10|LCK_M_U|

The wait type indicates that the session is waiting on a resource. The long elapsed time associated with similar wait time indicates that the session has been waiting for most its life on this resource. Тhe low CPU time indicates little processing, mostly waiting.

For more information, on how to diagnose waits, see [Diagnose waits or bottlenecks](#diagnose-waits-or-bottlenecks).

#### Long compilation time

On rare occasions, you might observe that the CPU is increasing continuously over time but that's not driven by query execution. Instead, it could be caused by an excessively long compilation (the parsing and compiling of a query). In those cases, check the **transaction_name** output column and look for a value of `sqlsource_transform`. This transaction name indicates a compilation.

## Step 2. Collect diagnostic logs

Once you have established that there's a never-ending query on the system, you can collect query plan data for the long-running query to troubleshoot further. Use one of the methods below, depending on the SQL Server version you have to do this collection.

### Manual steps to collect diagnostic logs

# [SQL Server 2008 - SQL Server 2014 (prior to SP2)](#tab/2008-2014)

To collect diagnostic data by using [SQL Server Management Studio](/sql/ssms/sql-server-management-studio-ssms) (SSMS), follow these steps:

1. Capture the [estimated query execution plan](/sql/relational-databases/performance/display-the-estimated-execution-plan) XML.

1. Review the query plan to see if there are any obvious indications of where the slowness can come from. Typical examples include:

    - Table or index scans (look at estimated rows).
    - Nested loops driven by a huge outer table data set.
    - Nested loops with a large branch in the inner side of the loop.
    - Table spools.
    - Functions in the `SELECT` list that take a long time to process each row.

1. If the query runs fast at any time, you can capture the "fast" executions [Actual XML Execution Plan](/sql/relational-databases/performance/display-an-actual-execution-plan) to compare.

# [SQL Server 2014 (after SP2) and SQL Server 2016 (prior to SP1)](#tab/2014-2016)

[The lightweight Query Profiling Infrastructure](/sql/relational-databases/performance/query-profiling-infrastructure#lwp) was introduced in these versions of SQL Server. It allows you to capture actual statistics during the execution of a slow query. This troubleshooting feature allows you to examine query operators in a query plan at run time and understand where most of the time is spent in a query.

To identify the slow steps in the query by using [Lightweight query execution statistics profiling infrastructure v1](/sql/relational-databases/performance/query-profiling-infrastructure#lightweight-query-execution-statistics-profiling-infrastructure-v1), follow these steps:

1. Run the following commands to enable the `query_thread_profile` XEvent:

    ```sql
    CREATE EVENT SESSION [NodePerfStats] ON SERVER
    ADD EVENT sqlserver.query_thread_profile(
      ACTION(sqlos.scheduler_id,sqlserver.database_id,sqlserver.is_system,
        sqlserver.plan_handle,sqlserver.query_hash_signed,sqlserver.query_plan_hash_signed,
        sqlserver.server_instance_name,sqlserver.session_id,sqlserver.session_nt_username,
        sqlserver.sql_text))
    ADD TARGET package0.ring_buffer(SET max_memory=(25600))
    WITH (MAX_MEMORY=4096 KB,
      EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,
      MAX_DISPATCH_LATENCY=30 SECONDS,
      MAX_EVENT_SIZE=0 KB,
      MEMORY_PARTITION_MODE=NONE,
      TRACK_CAUSALITY=OFF,
      STARTUP_STATE=OFF);
    
    ALTER EVENT SESSION [NodePerfStats] ON SERVER STATE = START
    ```

1. Start the affected never-ending query from application.

1. Run the following command multiple times a minute or so apart to check the run-time execution statistics for the query plan operators:

    ```sql
    SELECT CONVERT (varchar(30), getdate(), 126) as runtime,
                qp.session_id,
                convert(nvarchar(48), qp.physical_operator_name) as physical_operator_name,
                qp.row_count,
                qp.estimate_row_count,
                qp.node_id,
                req.cpu_time,
                req.total_elapsed_time,
                substring
                (REPLACE
                (REPLACE
                    (SUBSTRING
                    (SQLText.text
                    , (req.statement_start_offset/2) + 1
                    , (
                        (CASE statement_END_offset
                            WHEN -1
                            THEN DATALENGTH(SQLText.text)  
                            ELSE req.statement_END_offset
                            END
                            - req.statement_start_offset)/2) + 1)
                , CHAR(10), ' '), CHAR(13), ' '), 1, 512)  AS active_statement_text
    FROM sys.dm_exec_query_profiles qp 
    RIGHT OUTER JOIN sys.dm_exec_requests req
        ON qp.session_id = req.session_id
    LEFT OUTER JOIN sys.dm_exec_sessions sess
        on req.session_id = sess.session_id
    LEFT OUTER JOIN sys.dm_exec_connections conn on conn.session_id = req.session_id
    OUTER APPLY sys.dm_exec_sql_text (ISNULL (req.sql_handle, conn.most_recent_sql_handle)) as SQLText
    WHERE req.session_id <> @@SPID 
        AND sess.is_user_process = 1 
    ORDER BY qp.session_id asc, row_count desc 
    --this is to prevent massive grants
    OPTION (max_grant_percent = 3, MAXDOP 1)
    ```

1. Capture three or four snapshots spaced one minute apart to give you sufficient data for analysis. Specifically, you can compare the `row_count` numbers for each operator over time and see which shows a significant increase in row count (million or more).

1. In a new query window in SSMS, capture an estimated query plan for the problem query by running the following commands:

   ```sql
   SET SHOWPLAN_XML ON
   GO
   <problem query here>
   GO
   SET SHOWPLAN_XML OFF
   ```

1. Using the node ID with the highest row count identified by the query in step 3, find the same node in the estimated query plan. This step helps understand which operator in the plan is the main cause of the long execution time.

1. Stop the XEvent by running the following command:

    ```sql
    ALTER EVENT SESSION [NodePerfStats] ON SERVER STATE = STOP
    ```

# [SQL Server 2016 (after SP1) and SQL Server 2017](#tab/2016-2017)

You can use the [Lightweight query execution statistics profiling infrastructure v2](/sql/relational-databases/performance/query-profiling-infrastructure#lightweight-query-execution-statistics-profiling-infrastructure-v2) to capture live query plans with actual values for row count. This profiling infrastructure allows you to examine query operators in a query plan at run time and understand where most of the time is spent in a query.

To identify the slow steps in the query, follow these steps:

1. To enable the lightweight infrastructure on these versions of SQL Server, use one of the following methods:

   - Enable [trace flag](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql) 7412 by running the following command:

       ```sql
       DBCC TRACEON (7412, -1)
       ```

   - Alternatively, enable the `query_thread_profile` XEvent by running the following commands:

        ```sql
        CREATE EVENT SESSION [PerfStats_LWP_Plan_v2] ON SERVER
        ADD EVENT sqlserver.query_plan_profile(
         ACTION(sqlos.scheduler_id,sqlserver.database_id,sqlserver.is_system,
           sqlserver.plan_handle,sqlserver.query_hash_signed,sqlserver.query_plan_hash_signed,
           sqlserver.server_instance_name,sqlserver.session_id,sqlserver.session_nt_username,
           sqlserver.sql_text))
        ADD TARGET package0.ring_buffer(SET max_memory=(25600))
        WITH (MAX_MEMORY=4096 KB,
         EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,
         MAX_DISPATCH_LATENCY=30 SECONDS,
         MAX_EVENT_SIZE=0 KB,
         MEMORY_PARTITION_MODE=NONE,
         TRACK_CAUSALITY=OFF,
         STARTUP_STATE=OFF);
        
        ALTER EVENT SESSION [PerfStats_LWP_Plan_v2] ON SERVER STATE = START
        ```

1. Start the affected never-ending query from the application.

1. Use a command similar to the following one to identify the `Session_id` of your never-ending query that is running:

   ```sql
   SELECT t.text, session_id 
   FROM sys.dm_exec_requests req
   CROSS APPLY sys.dm_exec_sql_text (req.sql_handle) as t
   ```

1. Run the following command three or four times spaced one minute apart to examine the query plan and actual statistics in the plan. Be sure to save the query plan every time, so you can compare them and establish which query operator is consuming most of the CPU time. Specifically, you can compare the row count (Actual Number of Rows) for each operator over time and see which of the operators is showing a significant increase in row count (million or more). Replace `<session_id>` with the integer value you found in the previous step 3.

    ```sql
    SELECT * FROM sys.dm_exec_query_statistics_xml (<session_id>)
    ```

1. Stop the XEvent if you started one, or disable the trace flag:

    ```sql
    ALTER EVENT SESSION [PerfStats_LWP_Plan_v2] ON SERVER STATE = STOP
    -- or
    DBCC TRACEOFF (7412, -1)
    ```

# [SQL Server 2019 and later versions](#tab/2019)

You can use the [Lightweight query execution statistics profiling infrastructure v3](/sql/relational-databases/performance/query-profiling-infrastructure#lightweight-query-execution-statistics-profiling-infrastructure-v3) to capture live query plans with actual values for row count. This profiling infrastructure allows you to examine query operators in a query plan at run time and understand where most of the time is spent in a query. Lightweight profiling is enabled by default on SQL Server 2019.

To identify the slow steps in the query, follow these steps:

1. Start the affected never-ending query from your application.

1. Use a command similar to the following one to identify the `Session_id` of your never-ending query that is running:

   ```sql
   SELECT t.text, session_id 
   FROM sys.dm_exec_requests req
   CROSS APPLY sys.dm_exec_sql_text (req.sql_handle) as t
   ```

1. Run the following command three or four times to examine the query plan and actual statistics in the plan. Be sure to save the query plan every time, so you can compare them and establish which query operator is consuming most of the CPU time. Replace `<session_id>` with the integer value you found in the previous step 3.

    ```sql
    SELECT * FROM sys.dm_exec_query_statistics_xml (<session_id>)
    ```

1. Specifically, select the XML link under the **query_plan** column. Once the graphical query plan opens in a new window, right-click on it and select **Save Execution Plan As...**. Repeat the steps to capture three or four snapshots spaced one minute apart to give you sufficient data for analysis. Specifically, you can compare the row count (actual number of rows) for each operator over time and see which of the operators is showing a significant increase in row count (million or more).

    > [!NOTE]
    > If you aren't getting any output from `sys.dm_exec_query_statistics_xml`, you can check whether the database option `LAST_QUERY_PLAN_STATS` has been disabled by running the following command:
    >
    > ```sql
    > SELECT name, value, value_for_secondary, is_value_default 
    > FROM sys.database_scoped_configurations
    > WHERE name = 'LAST_QUERY_PLAN_STATS'
    > ```
    >
    > You can enable the last query plan statistics at the database level by running `ALTER DATABASE SCOPED CONFIGURATION SET LAST_QUERY_PLAN_STATS = ON`.

---

### Use SQL LogScout to capture never-ending queries

You can use [SQL LogScout](https://github.com/microsoft/SQL_LogScout/releases) to capture logs while a never-ending query is running. To that, use the [never ending query scenario](https://github.com/microsoft/SQL_LogScout?tab=readme-ov-file#15-never-ending-query). Here's a command you can use to run:

```powershell
.\SQL_LogScout.ps1 -Scenario "NeverEndingQuery" -ServerName "."
```

Note, that this log capture requires that the long query has consumed at least 60 seconds of CPU, in order to capture logs.

SQL LogScout captures, among other things, at least three query plans for each high-CPU consuming query. You can find file names titled similar to this `servername_datetime_NeverEnding_statistics_QueryPlansXml_Startup_sessionId_#.sqlplan`. You can use these files in the next step when you review plans to identify the reason for long query execution.

## Step 3. Review the collected plans

This section illustrates how to review the collected data. It uses the multiple XML query plans (using extension **.sqlplan*) collected in SQL Server 2016 SP1 and later builds and versions.

Follow these steps to [compare execution plans](/sql/relational-databases/performance/compare-execution-plans#to-compare-execution-plans):

1. Open a previously saved query execution plan file (*.sqlplan*).

1. Right-click in a blank area of the execution plan and select **Compare Showplan**.

1. Choose the second query plan file that you would like to compare.

1. Look for thick arrows that indicate a large number of rows flowing between operators. Then select the operator before or after the arrow, and compare the number of **actual** rows across two plans.

1. Compare the second and third plans to see if the largest flow of rows happens in the same operators.

   Here's an example:

   :::image type="content" source="media/troubleshoot-never-ending-query/query-plan-comparison.png" alt-text="Compare query plans in SSMS." lightbox="media/troubleshoot-never-ending-query/query-plan-comparison.png":::

## Step 4. Resolution

1. Ensure that statistics are updated for the tables used in the query.

1. Look for a missing index recommendation in the query plan and apply any.

1. Rewrite the query to simplify it:

   - Use more selective `WHERE` predicates to reduce the data processed up-front.
   - Break it apart.
   - Select some parts into temp tables, and join them later.
   - Remove `TOP`, `EXISTS`, and `FAST` (T-SQL) in the queries that run for a long time due to [optimizer row goal](https://techcommunity.microsoft.com/t5/sql-server-blog/more-showplan-enhancements-8211-row-goal/ba-p/385839). Alternatively, you can use the `DISABLE_OPTIMIZER_ROWGOAL` [hint](/sql/t-sql/queries/hints-transact-sql-query#use_hint). For more information, see [Row Goals Gone Rogue](/archive/blogs/bartd/row-goals-gone-rogue).
   - Avoid using Common Table Expressions (CTEs) in such cases as they combine statements into a single large query.

1. Try using [query hints](/sql/t-sql/queries/hints-transact-sql-query) to produce a better plan:

   - `HASH JOIN` or `MERGE JOIN` hint
   - `FORCE ORDER` hint
   - `FORCESEEK` hint
   - `RECOMPILE`
   - USE `PLAN N'<xml_plan>'` if you have a fast query plan that you can force

1. Use Query Store (QDS) to force a good known plan if such a plan exists and if your SQL Server version supports Query Store.

## Diagnose waits or bottlenecks

This section is included here as a reference in case your issue isn't a long-running CPU driving query. You can use it to troubleshoot queries that are long due to waits.

[!INCLUDE [collect query data and logical reads](../../includes/performance/diagnose-waits-or-bottlenecks.md)]
