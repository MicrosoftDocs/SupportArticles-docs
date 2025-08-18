---
title: Troubleshoot Queries That Seem Never to End in SQL Server
description: Provides steps to help you identify and resolve issues in which a query runs for a long time in SQL Server.
ms.date: 08/08/2025
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.reviewer: shaunbe, v-jayaramanp, jopilov
author: pijocoder
ms.author: jopilov
ms.topic: troubleshooting-problem-resolution
---

# Troubleshoot queries that seem to run endlessly in SQL Server

This article provides troubleshooting guidance for issues in which a Microsoft SQL Server query takes an excessive amount of time to end (hours or days).

## Symptoms

This article focuses on queries that seem to run or compile without end. That is, their CPU usage continues to increase. This article doesn't apply to queries that are blocked or waiting on a resource that's never released. In those cases, the CPU usage remains constant or changes only slightly.

> [!IMPORTANT]
> If a query is left to continue running, it might eventually finish. This process could take just a few seconds or several days.
> The term "never-ending" is used here to describe the perception of a query that doesn't finish.

## Cause

Common causes of long-running (never-ending) queries include:

- **Nested Loop (NL) joins on very large tables:** Because of the nature of NL joins, a query that joins tables that have lots of rows might run for a long time. In some cases, including `TOP`, `FAST`, and other row goals, the query must use NL joins. Therefore, even if a hash match or a Merge join might be faster, the optimizer can't use either process because of the row goal.
- **Out-of-date statistics:** Queries that pick a plan based on outdated statistics might be suboptimal and take a long time to run.
- **Endless loops:** T-SQL queries that use WHILE loops might be incorrectly written. The resulting code never leaves the loop and runs endlessly. These queries are truly never-ending. They run until they're killed manually.
- **Complex queries that have many joins and large tables:** Queries that involve many joined tables would typically have complex query plans that might take a long time to run. This scenario is common in analytical queries that don't filter out rows and that involve a large number of tables.
- **Missing indexes:** Queries can be accelerated if appropriate indexes are used on tables. Indexes enable the selection of a subset of the data to provide faster access.

## Resolution

### Step 1. Discover never-ending queries

Look for a never-ending query that's running on the system. You have to determine whether a query has a long execution time, a long wait time (stuck on a bottleneck), or a long compilation time.

#### 1.1  Run a diagnostic

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

#### 1.2 Examine the output

There are several scenarios that can cause a query to run for a long time: long execution, long wait, and long compilation. For more information about why a query might run slowly, see [Running vs. Waiting: why are queries slow?](troubleshoot-slow-running-queries.md#running-vs-waiting-why-are-queries-slow)

#### Long execution time

The troubleshooting steps in this article are applicable when you receive an output similar to the following, where the CPU time is increasing proportionately to the elapsed time without significant wait times.

|session_id|status| cpu_time_minutes | elapsed_time_minutes|logical_reads |wait_time_minutes|wait_type|
|--|--|--|--|--|--|--|
|56 |running | 64.40 |23.50|0 |0.00|NULL|

The query is continuously running if it has:

- An increasing CPU time
- A status of `running` or `runnable`
- Minimal or zero wait time
- No wait_type

In this situation, the query is reading rows, joining, processing results, calculating, or formatting. These activities are all CPU-bound actions.

> [!NOTE]
> Changes in `logical_reads` aren't relevant in this case because some CPU-bound T-SQL requests, such as performing computations or a `WHILE` loop, might not do any logical reads at all.

If the slow query meets these criteria, focus on reducing its runtime. Typically, reducing runtime involves reducing the number of rows that the query has to process throughout its life by applying indexes, rewriting the query, or updating statistics. For more information, see the [Resolution](#step-4-resolution) section.

#### Long wait time

This article isn't applicable for long wait scenarios. In a wait scenario, you might receive an output that resembles the following example in which the CPU usage doesn't change or changes slightly because the session is waiting on a resource:

|session_id|status| cpu_time_minutes | elapsed_time_minutes|logical_reads |wait_time_minutes|wait_type|
|--|--|--|--|--|--|--|
|56 |suspended | 0.03 |4.20|50 |4.10|LCK_M_U|

The wait type indicates that the session is waiting on a resource. A long elapsed time and a long wait time indicate that the session is waiting for most its life for this resource. Тhe short CPU time indicates that little time was spent actually processing the query.

To troubleshoot queries that are long because of waits, see the following article:

[!INCLUDE [collect query data and logical reads](../../includes/performance/diagnose-waits-or-bottlenecks.md)]

#### Long compilation time

On rare occasions, you might observe that the CPU usage increases continuously over time but isn't driven by the query run. Instead, an excessively long compilation (the parsing and compiling of a query) might be the cause. In these cases, check the `transaction_name` output column for a value of `sqlsource_transform`. This transaction name indicates a compilation.

### 2. Collect diagnostic logs manually

After you determine that a never-ending query exists on the system, you can collect the query's plan data to troubleshoot further. To collect the data, use one of the following methods, depending on your version of SQL Server.

#### [SQL Server 2008 - SQL Server 2014 (earlier than SP2)](#tab/2008-2014)

To collect diagnostic data by using [SQL Server Management Studio](/sql/ssms/sql-server-management-studio-ssms) (SSMS), follow these steps:

1. Capture the [estimated query execution plan](/sql/relational-databases/performance/display-the-estimated-execution-plan) XML.

1. Review the query plan to learn whether the data shows obvious indications of what's causing the slowness. Examples of typical indications include:

    - Table or index scans (look at estimated rows)
    - Nested loops driven by a huge outer table data set
    - Nested loops that have a large branch in the inner side of the loop
    - Table spools
    - Functions in the `SELECT` list that take a long time to process each row

1. If the query runs quicker at any time, you can capture the "fast" runs ([actual XML execution plan](/sql/relational-databases/performance/display-an-actual-execution-plan)) to compare results.

#### [SQL Server 2014 (later than SP2) and SQL Server 2016 (earlier than SP1)](#tab/2014-2016)

[The lightweight Query Profiling Infrastructure](/sql/relational-databases/performance/query-profiling-infrastructure#lwp) was introduced in Microsoft SQL Server 2014. It lets you capture actual statistics while a slow query runs. This troubleshooting feature enables you to examine query operators in a query plan at runtime and understand where most of the time is spent in a query.

To identify the slow steps in the query nu using [Lightweight query execution statistics profiling infrastructure v1](/sql/relational-databases/performance/query-profiling-infrastructure#lightweight-query-execution-statistics-profiling-infrastructure-v1), follow these steps:

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

1. Start the affected never-ending query from the application.

1. Run the following command multiple times, about one minute apart, to check the runtime execution statistics for the query plan operators:

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

1. Capture three or four snapshots, one minute apart, to obtain sufficient data for analysis. Specifically, you can compare the `row_count` numbers for each operator over time to learn which amounts indicate a significant increase in row count (by a million or more).

1. In a new query window in SSMS, capture an estimated query plan for the problem query by running the following commands:

   ```sql
   SET SHOWPLAN_XML ON
   GO
   <problem query here>
   GO
   SET SHOWPLAN_XML OFF
   ```

1. Find the same node in the estimated query plan by using the node ID that has the highest row count, as determined by the query that you ran in step 3. This step helps identify which operator in the plan is the main cause of the long execution time.

1. Stop the XEvent by running the following command:

    ```sql
    ALTER EVENT SESSION [NodePerfStats] ON SERVER STATE = STOP
    ```

#### [SQL Server 2016 (later than SP1) and SQL Server 2017](#tab/2016-2017)

You can use the [Lightweight query execution statistics profiling infrastructure v2](/sql/relational-databases/performance/query-profiling-infrastructure#lightweight-query-execution-statistics-profiling-infrastructure-v2) to capture live query plans that include actual row counts. This profiling infrastructure lets you examine query operators in a query plan at runtime and learn where most of the time is spent in a query.

To identify the slow steps in the query, follow these steps:

1. To enable the lightweight infrastructure, use one of the following methods:

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

1. To identify the `Session_id` of your never-ending query that's running, run a command that resembles the following command:

   ```sql
   SELECT t.text, session_id 
   FROM sys.dm_exec_requests req
   CROSS APPLY sys.dm_exec_sql_text (req.sql_handle) as t
   ```

1. To examine the query plan and actual statistics in the plan, run the following command three or four times, one minute apart. Make sure that you save the query plan every time so that you can compare the plans and learn which query operators are consuming most of the CPU time. Specifically, you can compare the row count (actual number of rows) for each operator over time to see which operators are showing a significant increase in row count (by a million or more). Replace `<session_id>` with the integer value that you found in the previous step.

    ```sql
    SELECT * FROM sys.dm_exec_query_statistics_xml (<session_id>)
    ```

1. Stop the XEvent if you started one, or disable the trace flag:

    ```sql
    ALTER EVENT SESSION [PerfStats_LWP_Plan_v2] ON SERVER STATE = STOP
    -- or
    DBCC TRACEOFF (7412, -1)
    ```

#### [SQL Server 2019 and later versions](#tab/2019)

You can use the [Lightweight query execution statistics profiling infrastructure v3](/sql/relational-databases/performance/query-profiling-infrastructure#lightweight-query-execution-statistics-profiling-infrastructure-v3) to capture live query plans that include actual row counts. This profiling infrastructure lets you examine query operators in a query plan at runtime and understand where most of the time is spent in a query. Lightweight profiling is enabled by default in Microsoft SQL Server 2019.

To identify the slow steps in the query, follow these steps:

1. Start the affected never-ending query from your application.

1. To identify the `Session_id` of your never-ending query that's running, run a command that resembles the following command:

   ```sql
   SELECT t.text, session_id 
   FROM sys.dm_exec_requests req
   CROSS APPLY sys.dm_exec_sql_text (req.sql_handle) as t
   ```

1. Run the following command to examine the query plan and actual statistics in the plan. Be sure to save the query plan every time so that you can compare them and learn which query operator is consuming most of the CPU time. Replace `<session_id>` with the integer value you found in the previous step.

    ```sql
    SELECT * FROM sys.dm_exec_query_statistics_xml (<session_id>)
    ```

1. Select the XML link in the `query_plan` column. After the graphical query plan opens in a new window, right-click it, and then select **Save Execution Plan As...**. Repeat these steps to capture three or four snapshots, one minute apart, to obtain sufficient data for analysis. Specifically, you can compare the row count (actual number of rows) for each operator over time to learn which operators are showing a significant increase in row count (by million or more).

    > [!NOTE]
    > If you aren't getting any output from `sys.dm_exec_query_statistics_xml`, you can check whether the database option `LAST_QUERY_PLAN_STATS` is disabled by running the following command:
    >
    > ```sql
    > SELECT name, value, value_for_secondary, is_value_default 
    > FROM sys.database_scoped_configurations
    > WHERE name = 'LAST_QUERY_PLAN_STATS'
    > ```
    >
    > You can enable the last query plan statistics at the database level by running `ALTER DATABASE SCOPED CONFIGURATION SET LAST_QUERY_PLAN_STATS = ON`.

---

#### Use SQL LogScout to capture never-ending queries

You can use [SQL LogScout](https://github.com/microsoft/SQL_LogScout/releases) to capture logs while a never-ending query is running. Use the [never ending query scenario](https://github.com/microsoft/SQL_LogScout?tab=readme-ov-file#15-never-ending-query) with the following command:

```powershell
.\SQL_LogScout.ps1 -Scenario "NeverEndingQuery" -ServerName "."
```

> [!NOTE]
> This log capture process requires the long query to consume at least 60 seconds of CPU time.

SQL LogScout captures at least three query plans for each high-CPU-consuming query. You can find file names that resemble `servername_datetime_NeverEnding_statistics_QueryPlansXml_Startup_sessionId_#.sqlplan`. You can use these files in the next step when you review plans to identify the reason for long query execution.

### Step 3. Review the collected plans

This section discusses how to review the collected data. It uses the multiple XML query plans (using extension `.sqlplan`) that are collected in Microsoft SQL Server 2016 SP1 and later builds and versions.

[Compare execution plans](/sql/relational-databases/performance/compare-execution-plans#to-compare-execution-plans) by following these steps:

1. Open a previously saved query execution plan file (`.sqlplan`).

1. Right-click in a blank area of the execution plan, and select **Compare Showplan**.

1. Choose the second query plan file that you would like to compare.

1. Look for thick arrows that indicate a large number of rows flowing between operators. Then, select the operator before or after the arrow, and compare the number of **actual** rows across the two plans.

1. Compare the second and third plans to learn whether the largest flow of rows occurs in the same operators.

   For example:

   :::image type="content" source="media/troubleshoot-never-ending-query/query-plan-comparison.png" alt-text="Screenshot that shows comparing query plans in SSMS." lightbox="media/troubleshoot-never-ending-query/query-plan-comparison.png":::

### Step 4. Resolution

1. Make sure that statistics are updated for the tables that are used in the query.

1. Look for missing index recommendations in the query plan, and apply any that you find.

1. Simplify the query:

   - Use more selective `WHERE` predicates to reduce the data that's processed up-front.
   - Break it apart.
   - Select some parts into temp tables, and join them later.
   - Remove `TOP`, `EXISTS`, and `FAST` (T-SQL) in the queries that run for a long time because of an [optimizer row goal](https://techcommunity.microsoft.com/t5/sql-server-blog/more-showplan-enhancements-8211-row-goal/ba-p/385839).
      - Alternatively, use the `DISABLE_OPTIMIZER_ROWGOAL` [hint](/sql/t-sql/queries/hints-transact-sql-query#use_hint). For more information, see [Row Goals Gone Rogue](/archive/blogs/bartd/row-goals-gone-rogue).
   - Avoid using Common Table Expressions (CTEs) in such cases because they combine statements into a single large query.

1. Try using [query hints](/sql/t-sql/queries/hints-transact-sql-query) to produce a better plan:

   - `HASH JOIN` or `MERGE JOIN` hint
   - `FORCE ORDER` hint
   - `FORCESEEK` hint
   - `RECOMPILE`
   - USE `PLAN N'<xml_plan>'` (if you have a fast query plan that you can force)

1. Use Query Store (QDS) to force a good known plan if such a plan exists and if your SQL Server version supports Query Store.
