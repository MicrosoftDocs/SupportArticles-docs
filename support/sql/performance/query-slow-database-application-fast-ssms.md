---
title: Query is slow in database application but fast in SSMS
description: Provides a resolution for the performance issue where query is slow in database application but fast in SSMS.
ms.date: 06/16/2022
ms.custom: sap:Performance
ms.reviewer: 
ms.prod: sql
---

# Query is slow in database application but fast in SSMS

## Symptoms

When you execute a query in a database application, it runs slower than the same query in an application like SQL Server Management Studio (SSMS).

## Cause

This issue occurs because the queries are different:

- Queries use different parameters or variables.

- Queries are submitted to the server in different ways.

## Resolution

To resolve the issue, follow these steps:

### Step 1: Verify the queries are submitted with the same parameters or variables

To compare these queries and make sure they're identical in every way, follow these steps:

1. Open your SSMS and connect it to the Database Engine you're using.

1. Run the following commands to [create an Extended Events session](/sql/t-sql/statements/create-event-session-transact-sql):

    ```sql
    CREATE EVENT SESSION <EventSessionName> ON SERVER
    
    ADD EVENT sqlserver.existing_connection(SET collect_options_text=(1)),
    
    ADD EVENT sqlserver.login(SET collect_options_text=(1)),
    
    ADD EVENT sqlserver.rpc_completed,
    
    ADD EVENT sqlserver.sp_statement_completed,
    
    ADD EVENT sqlserver.sql_batch_completed,
    
    ADD EVENT sqlserver.sql_statement_completed
    
    ADD TARGET package0.event_file(SET filename=N'<FilePath>')
    
    WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
    
    GO
    ```

1. In **Object Explorer**, expand **Management** > **Extended Events** > **Sessions**.

1. Right-click the **Sessions**, select **Refresh**, and then you can see the session **EventSessionName** you created.

1. Right-click the session **EventSessionName**, select **Start Session** and then the session **EventSessionName** will start to collect data.

1. Use one of the following methods to analyze the collected data:

    - Right-click the session **EventSessionName**, and then select **Watch Live Data**.

    - Under **EventSessionName**, right-click **package0.event_file**, and then select **View Target Data...**.

    - Find the location of the *.xel* files and read this file by using the function [sys.fn_xe_file_target_read_file](/sql/relational-databases/system-functions/sys-fn-xe-file-target-read-file-transact-sql).

1. Compare the statement by checking the following events:

    - `sp_statement_completed`
    - `sql_batch_completed`
    - `sql_statement_completed`
    - `rpc_completed`

    > [!NOTE]
    > For more information about the identical queries, see the following examples:
    >
    > - Stored procedures or functions with different values aren't the same:
    >
    >   - ```sql
    >     SpUserProc @p1 = 100
    >     ```
    >
    >   - ```sql
    >     SpUserProc @p1 = 270
    >     ```
    >
    > - The following queries are different:
    >
    >   - ```sql
    >     declare @variable1 = 123
    > 
    >     select * from table where c1 = @variable1
    >     ```
    >
    >   - ```sql
    >     select * from table where c1 = 123 
    >     ```

For the same reason as above, comparing the execution of a stored procedure to the execution of the equivalent ad-hoc query (using local variables) may be different. Identical statements have to be compared.

### Step 2: Measure the execution time on the server

To exclude the time clients spend fetching results and measure the execution time on the server only, use one of the following methods:

- Method 1. Run the following query:

    ```sql
    SET STATISTICS TIME ON

    <Your query here>

    SET STATISTICS TIME OFF
    ```

- Method 2. Use XEvent or SQL Trace to see the duration and elapsed time of a query (event class `SQL:StmtCompleted`, `SQL:BatchCompleted`, or `RPC:Completed`).

The time difference between the queries could be caused by one application in a different network and there could be a network delay. When you compare the execution on the server, you're comparing how long the queries took to run on the server.

### Step 3: Check SET options for each connection

There are [SET options](/sql/t-sql/statements/set-statements-transact-sql) that are query-plan affecting, which means they can change the choice of query plan. Therefore, if a database application uses different set options from SSMS, each set option can get a different query plan. For example, ARITHABORT, NUMERIC_ROUNDABORT, ROWCOUNT, FORCEPLAN, and ANSI_NULLS. The most common difference observed is [SET ARITHABORT](/sql/t-sql/statements/set-arithabort-transact-sql) is set to ON in SSMS but set to OFF in most database applications. Setting ARITHABORT to OFF can negatively impact query optimization, leading to performance issues. And the following warning message appears after the query runs:

> [!WARNING]
> The default ARITHABORT setting for SQL Server Management Studio is ON. Client applications setting ARITHABORT to OFF might receive different query plans, making it difficult to troubleshoot poorly performing queries. That is, the same query might execute fast in management studio but slow in the application. When troubleshooting queries with Management Studio, always match the client ARITHABORT setting.

For a list of all of plan-affecting options, see [Set Options](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-plan-attributes-transact-sql#set-options).

To ensure that the SET options on both SSMS and application are the same to be able to perform a valid comparison, follow these steps:

1. Use the same XEvent definition above.

1. Compare the set options by checking the events `login` and `existing_connection`, and specifically the `options_text` and options columns.
