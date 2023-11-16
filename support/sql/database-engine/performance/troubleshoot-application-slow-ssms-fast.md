---
title: Query is slower in database application than in SSMS
description: Troubleshoot the performance issue where a query is slower in a database application than in SSMS.
ms.date: 06/20/2022
ms.custom: sap:Performance
ms.reviewer: jopilov
author: PiJoCoder
ms.author: jopilov
---

# Troubleshoot query performance difference between database application and SSMS

When you execute a query in a database application, it runs slower than the same query in an application like SQL Server Management Studio (SSMS), Azure Data Studio, or SQLCMD.

This issue may occur for the following reasons:

- Queries use different parameters or variables.

- Queries are submitted to the server over different networks or there's a difference how the applications process data.

- SET options in the database application and SSMS are different.

To troubleshoot the issue, follow these steps:

## Step 1: Verify the queries are submitted with the same parameters or variables

To compare these queries and make sure they're identical in every way, follow these steps:

1. Open your SSMS and connect it to the Database Engine you're using.

1. Run the following commands to [create an Extended Events session](/sql/t-sql/statements/create-event-session-transact-sql):

    ```sql
    CREATE EVENT SESSION <EventSessionName> ON SERVER
    ADD EVENT sqlserver.existing_connection(SET collect_options_text=(1)),
    ADD EVENT sqlserver.login(SET collect_options_text=(1)
        ACTION(sqlserver.client_app_name)),
    ADD EVENT sqlserver.rpc_completed,
    ADD EVENT sqlserver.sp_statement_completed(
        ACTION(sqlserver.client_app_name)),
    ADD EVENT sqlserver.sql_batch_completed(
        ACTION(sqlserver.client_app_name)),
    ADD EVENT sqlserver.sql_statement_completed(
        ACTION(sqlserver.client_app_name))
    ADD TARGET package0.event_file(SET filename=N'<FilePath>')
    WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 
    SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
    GO
    ```

    > [!NOTE]
    > Replace the placeholders \<EventSessionName> and \<FilePath> with the ones you want to create.

1. Run the following commands to start the session **EventSessionName**:

    ```sql
    ALTER EVENT SESSION <EventSessionName> ON SERVER
    STATE = START
    ```

1. Run your queries to reproduce the issue.

1. Use one of the following methods to analyze the collected data:

    - Open Windows Explorer, find the target *.xel* file, and double-click on it. The file will be opened in another SSMS window that you can use to view and analyze.

    - In **Object Explorer**, expand **Management** > **Extended Events** > **Sessions** > **EventSessionName**, right-click **package0.event_file**, and then select **View Target Data...**.

    - Find the location of the *.xel* files and read this file by using the function [sys.fn_xe_file_target_read_file](/sql/relational-databases/system-functions/sys-fn-xe-file-target-read-file-transact-sql).

1. Compare the **Field** statement by checking the following events:

    - `sp_statement_completed`
    - `sql_batch_completed`
    - `sql_statement_completed`
    - `rpc_completed`

For more information about the identical queries, see the following examples:

- If the stored procedures or functions have different parameter values, the query times may be different:

  - `SpUserProc @p1 = 100`

  - `SpUserProc @p1 = 270`

- The following queries are different. The first query uses Average Density from the histogram for cardinality estimation, while the second query uses the histogram step for cardinality estimation:

  - ```sql
    declare @variable1 = 123
    select * from table where c1 = @variable1
    ```  

  - ```sql
    select * from table where c1 = 123
    ```

For the same reason as above, comparing the execution of a stored procedure to the execution of the equivalent ad-hoc query (using local variables) may be different. Identical statements have to be compared.

## Step 2: Measure the execution time on the server

For accurate comparison of query durations, you can exclude the network latency time or application-specific data processing time. Use one of the following methods to measure only the execution time on the SQL Server:

- Run your query by using [SET STATISTICS TIME](/sql/t-sql/statements/set-statistics-time-transact-sql):

    ```sql
    SET STATISTICS TIME ON
    <YourQuery>
    SET STATISTICS TIME OFF
    ```

- Use the XEvent from [step 1](#step-1-verify-the-queries-are-submitted-with-the-same-parameters-or-variables) to examine the duration or elapsed time of a query (event class `SQL:StmtCompleted`, `SQL:BatchCompleted`, or `RPC:Completed`).

In some cases, the time difference between the queries could be caused by one application running in a different network or the application itself. When you compare the execution on the server, you're comparing how long the queries took to run on the server.

## Step 3: Check SET options for each connection

There are [SET options](/sql/t-sql/statements/set-statements-transact-sql) that are query-plan affecting, which means they can change the choice of query plan. Therefore, if a database application uses different set options from SSMS, each set option can get a different query plan. For example, ARITHABORT, NUMERIC_ROUNDABORT, ROWCOUNT, FORCEPLAN, and ANSI_NULLS. The most common difference observed between SSMS and .NET applications is the [SET ARITHABORT](/sql/t-sql/statements/set-arithabort-transact-sql) option. By default, the option is set to ON in SSMS but set to OFF in most database applications. Based on your application needs, set ARITHABORT to the same setting in both SSMS and application for a valid comparison between the two.

> [!WARNING]
> The default ARITHABORT setting for SQL Server Management Studio is ON. Client applications setting ARITHABORT to OFF might receive different query plans, making it difficult to troubleshoot poorly performing queries. That is, the same query might execute fast in Management Studio but slow in the application. When troubleshooting queries with Management Studio, always match the client ARITHABORT setting.

For a list of all of plan-affecting options, see [Set options](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-plan-attributes-transact-sql#set-options).

To ensure that the SET options in both SSMS and application are the same to be able to perform a valid comparison, follow these steps:

1. Use the collected data in [step 1](#step-1-verify-the-queries-are-submitted-with-the-same-parameters-or-variables).

1. Compare the set options by checking the events `login` and `existing_connection`, specifically the `options_text` and options columns.
