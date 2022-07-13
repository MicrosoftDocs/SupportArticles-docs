---
title: Troubleshoot query that seems to never complete in SQL Server
description: This article provides a procedure to help you fix high-CPU-usage issues on a server that is running SQL Server.
ms.date: 07/13/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.prod: sql
ms.reviewer: shaunbe
author: pijocoder, shaunbeasley
ms.author: jopilov
---

## What is a never-ending query?

This article describes troubleshooting steps you can take when you have a query that seems to never complete or if you let it complete it may take many hours or days. This scenario strictly covers queries that continue to execute or compile, that is, their CPU continues to increase. It doesn't apply to queries that are blocked or waiting on some resource that is never released (the CPU remains constant). It's important to note that a query, if left to finish its execution, will eventually complete regardless of how long - a few seconds or several days. The term "never-ending" is used to describe the perception of a query not completing, while in fact the query will eventually complete. 

To identify whether a query is continuously executing or stuck on a bottleneck, you can use the following query:

```sql
DECLARE @cntr int = 0

WHILE (@cntr < 3)
BEGIN
	SELECT TOP 10 s.session_id,
					r.status,
					r.wait_time,
					r.wait_type,
					r.wait_resource,
					r.cpu_time,
					r.logical_reads,
					r.reads,
					r.writes,
					r.total_elapsed_time / (1000 * 60) 'Elaps M',
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
		LEFT JOIN sys.dm_tran_session_transactions stran ON stran.session_id =s.session_id
		JOIN sys.dm_tran_active_transactions AS atrn ON stran.transaction_id = atrn.transaction_id 
		WHERE r.session_id != @@SPID
		ORDER BY r.cpu_time DESC
	
	SET @cntr = @cntr + 1
WAITFOR DELAY '00:00:05'
END
```

Examine the sample output. If you observe an output similar to this where CPU is increasing proportionately with the elapsed time and there aren't waits, then the troubleshooting steps in this article apply.


session_id|status| cpu_time | logical_reads |wait_time|wait_type|
|--|--|--|--|--|--|
|56 |running | 7038 |101000 |0 |NULL|
|56 |runnable  | 12040 |301000 |0 |NULL|
|56 |running | 17020 |523000|0 |NULL|

However, if you observe a wait scenario like this, where CPU doesn't change and the session is waiting on a resource, this article isn't applicable.

session_id|status| cpu_time | logical_reads |wait_time|wait_type|
|--|--|--|--|--|--|
|56 |suspended|0 |3|8312 |LCK_M_U|
|56 |suspended|0|3|13318  |LCK_M_U|
|56 |suspended|0|5|18331 |LCK_M_U|

See [Diagnose waits or bottlenecks](#diagnose-waits-or-bottlenecks)

### Long Compilation Time 

On rare occasions, you may observe that the CPU is increasing continuously with the passage of time.  This CPU usage may be driven by an excessively long compilation (parse and compile of a query). In those cases, examine the **transaction_name** output column and look for a value of `sqlsource_transform` in it. This transaction name indicates a compilation.


## SQL Server 2008 - 2014 (Prior to SP2)

### Collect Diagnostic Data

#### Issue is reproducible via SSMS:
1. Capture the estimated query plan XML
2. Review the query plan to see if there are any obvious indications of where the slowness can come from. Typical examples include huge 
	• Table/index scans (look at estimated rows)
	• Nested Loops driven by a huge outer table data set
	• Nested loops with a very large branch in the Inner side of the loop 
	• Tables spools
	• Functions in the SELECT list that take a long time to process each row
	
3. If the query runs fast at any time, you can capture the "fast" executions Actual XML Execution Plan to compare





## SQL Server 2014 SP2 and SQL Server 2016(Prior to SP1)

The Lightweight Query Profiling Infrastructure was introduced in these versions of SQL Server. It allows you to capture actual statistics during the execution of a very slow query. This troubleshooting feature allows you to examine query operators in a query plan at run time and understand where the majority of the time is spent in a query. 
This enables you to identify the slow steps in the query and take action to address it. 

[Lightweight query execution statistics profiling infrastructure v1](https://docs.microsoft.com/en-us/sql/relational-databases/performance/query-profiling-infrastructure?view=sql-server-2017#lightweight-query-execution-statistics-profiling-infrastructure-v1)

1. Enable the query_thread_profile XEvent:

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

1. Start the affected never-ending query from application
1. Run the following command multiple times to examine the query plan operators live. 

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

1. Capture 3-4 snapshots spaced 1 minute apart to give you sufficient data for analysis. Specifically, you can compare the row_count numbers for each operator over time and see which one of the operators is showing significant increase in row count (million or more)
1. In a new query window in SSMS, capture an estimated query plan for the problem query using this command. 

   ```sql
   SET SHOWPLAN_XML ON
   GO
   <problem query here>
   GO
   SET SHOWPLAN_XML OFF
   ```

1. Using the node ID with the highest row count identified by the query in step 3, find the same node in the estimated query plan. This step will help understand which operator in the plan is the main cause for the long execution time.
1. Stop the XEvent.

    ```sql
    ALTER EVENT SESSION [NodePerfStats] ON SERVER STATE = STOP
    ```


## SQL Server 2016 SP1 and later and SQL Server 2017

You can use the [Lightweight query execution statistics profiling infrastructure v2](https://docs.microsoft.com/sql/relational-databases/performance/query-profiling-infrastructure#lightweight-query-execution-statistics-profiling-infrastructure-v2) to capture live query plans with actual values for row count. This allows you to examine query operators in a query plan at run time and understand where the majority of the time is spent in a query.


1. To enable the Lightweight infrastructure on these versions of SQL Server you can use one of two methods
   a. Either enable Trace flag 7412
   
   ```sql
   DBCC TRACEON (7412, -1)
   ```
   b. Or, either enable the query_thread_profile XEvent:

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


1. Start the affected never-ending query from application
1. Use a command similar to this to identify the Session_id of your executing, never-ending query

   ```sql
   SELECT t.text, session_id 
   FROM sys.dm_exec_requests req
   CROSS APPLY sys.dm_exec_sql_text (req.sql_handle) as t
   ```

1. Run the following command 3-4 times spaced 1 minute apart to examine the query plan and actual statistics in the plan. Be sure to save the query plan every time, so you can compare them and establish which query operator is consuming most the CPU time. Specifically, you can compare the row count (Actual Number of Rows) for each operator over time and see which of the operators is showing significant increase in row count (million or more). Replace session_id with the integer value you found in the previous step 3.

    ```sql
    SELECT * FROM sys.dm_exec_query_statistics_xml (<session_id>)
    ```


1. Stop the XEvent if you started one, or disable the trace flag

    ```sql
    ALTER EVENT SESSION [PerfStats_LWP_Plan_v2] ON SERVER STATE = STOP
    -- or
    DBCC TRACEOFF (7412, -1)
    ```

## SQL Server 2019 and later

You can use the [Lightweight query execution statistics profiling infrastructure v3](https://docs.microsoft.com/sql/relational-databases/performance/query-profiling-infrastructure#lightweight-query-execution-statistics-profiling-infrastructure-v3) to capture live query plans with actual values for row count. This allows you to examine query operators in a query plan at run time and understand where the majority of the time is spent in a query. Lightweight profiling is enabled by default on SQL Server 2019.

1. Start the affected never-ending query from your application
1. Use a command similar to this to identify the Session_id of your executing, never-ending query

   ```sql
   SELECT t.text, session_id 
   FROM sys.dm_exec_requests req
   CROSS APPLY sys.dm_exec_sql_text (req.sql_handle) as t
   ```

1. Run the following command 3-4 times to examine the query plan and actual statistics in the plan. Be sure to save the query plan every time, so you can compare them and establish which query operator is consuming the majority of the CPU time. Replace session_id with the integer value you found in the previous step 3.

    ```sql
    SELECT * FROM sys.dm_exec_query_statistics_xml (<session_id>)
    ```

1. Specifically, click on the XML link under the query_plan column. Once the graphical query plan opens in a new window, right click on it and choose Save Execution Plan As... Repeat this 3-4 snapshots spaced 1 minute apart to give you sufficient data for analysis. Specifically, you can compare the row count (Actual Number of Rows) for each operator over time and see which of the operators is showing significant increase in row count (million or more)

>NOTE:
>If you are not getting any output from **sys.dm_exec_query_statistics_xml**, you may check whether the database option LAST_QUERY_PLAN_STATS has been disabled by using `ALTER DATABASE SCOPED CONFIGURATION SET LAST_QUERY_PLAN_STATS = ON`. Run the following command to check this:
>    ```sql
>    SELECT name, value, value_for_secondary, is_value_default 
>    FROM sys.database_scoped_configurations
>    WHERE name = 'LAST_QUERY_PLAN_STATS'
>    ```

## Method to review the collected plans

This section will illustrate how to review the data once collected. It will use the multiple XML query plans (using extension *.sqlplan) collected in SQL Server 2016 SP1 and later.

Follow the instructions to [Compare execution plans](https://docs.microsoft.com/en-us/sql/relational-databases/performance/compare-execution-plans#to-compare-execution-plans)

- Open a previously saved query execution plan file (.sqlplan)
- Right-click in a blank area of the execution plan and select Compare Showplan
- Choose the second query plan file that you would like to compare with
- Look for thick arrows between operators; those indicate large number of rows flowing. Then click on the operator before or after the arrow and compare the number of **actual** rows across two plans
- Then compare the 2nd and 3rd plans to see if the largest flow of rows happens in the same operators

Here's an example: 
   :::image type="content" source="media/troubleshoot-never-ending-query/query-plan-comparison.png" alt-text="Compare query plans in SSMS":::

## Possible Solutions: 

1. Ensure that statistics are updated for the tables used in the query
2. Look for a missing index recommendation in the query plan and apply any
3. Rewrite the query to simplify it (break it apart and select into temp tables, remove TOP to avoid row goal)
4. Try using [query hints](/sql/t-sql/queries/hints-transact-sql-query?view=sql-server-ver16) to produce a better plan
   - Hash/Merge Join hint
   - Force order hint
   - Forceseek hint
   - RECOMPILE 
   - USE PLAN N'<xml_plan>'  if you have a fast query plan that you can force

5. Use Query Store (QDS) to force a good known plan if such a plan exists and if your SQL Server version supports Query Store. 



## Diagnose waits or bottlenecks

This section is included here as a reference in case your issue isn't a long-running CPU driving query. You can use it to troubleshoot queries that are long due to waits:

[!INCLUDE [collect query data and logical reads](../includes/performance/diagnose-waits-or-bottlenecks.md)]