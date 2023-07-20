---
title: Transaction log grows due to long-running transactions and CDC
titleSuffix: SQL Server & Azure SQL
description: This article helps you to monitor and identify the issue of continuous transaction log growth caused by long-running transactions in a database with Change Data Capture (CDC) enabled on SQL Server, Azure SQL Database, and Azure SQL Managed Instance.
ms.date: 07/20/2023
ms.custom: sap:Change data capture
ms.reviewer: mathoma
author: croblesm
ms.author: roblescarlos
---
# Transaction log grows due to long-running transactions when you use Change Data Capture - SQL Server & Azure SQL

This article helps you to monitor and identify the issue of continuous transaction log growth caused by long-running transactions in a database with Change Data Capture (CDC) enabled on SQL Server, Azure SQL Database, and Azure SQL Managed Instance.

## Symptoms

Consider the following scenario:

- You enable [Change Data Capture](/sql/relational-databases/track-changes/about-change-data-capture-sql-server) on a database.
- The source of change data for CDC is the transaction log. As inserts, updates, and deletes are applied to tracked source tables, entries that describe those changes are added to the log.
- The transaction log on the database grows due to long-running transactions.
- When you query [sys.databases](/sql/relational-databases/system-catalog-views/sys-databases-transact-sql) for the given database, the `log_reuse_wait_desc` column shows `REPLICATION`.

In this scenario, the database transaction log file grows gradually, leading to excessive transaction log space consumption. Once the transaction log size reaches the max defined limit, writes to the database fail.

## Cause

On a CDC-enabled database, capture job latency holds up log truncation to ensure changes can be captured from the transaction log to the CDC change tables, preventing loss of change data.

## Workaround

You can use Transact-SQL (T-SQL) to specify the transaction log threshold and the time interval to monitor the transaction log. If necessary, you can terminate transactions by setting `@kill_oldest_tran = 1`.

To monitor the transaction log, use the following T-SQL query:

```sql
DECLARE 
    -- Log Transactions that generated Txlog over this size
    @transaction_log_bytes_used INT = 5242880,    -- 5MB (UPDATE)
    -- Log full threshold
    @log_full_threshold INT = 30,                 -- Percent (UPDATE)
    -- Kill Oldest Tran (0 = FALSE or 1 = TRUE)
    @kill_oldest_tran BIT = 0,                    --(UPDATE)
    -- Log Transactions over this duration
    @active_tran_time_minutes INT = 15,           --(UPDATE)
    -- This variable specifies the loop delay, format is Hours:minutes:seconds
    @delay VARCHAR(9) = '00:10:00',
    @runtime DATETIME,
    @starttime DATETIME,
    @msg NVARCHAR(100),
    @oldest_tran_id BIGINT,
    @oldest_tran_session_id INT,
    @oldest_tran_begin_time DATETIME,
    @killstr NVARCHAR(100)

IF OBJECT_ID('tblDiagLongTransactions') IS NULL
BEGIN
    CREATE TABLE tblDiagLongTransactions 
    (
        [datacollectiontime] [datetime] NOT NULL,
        [transaction_id] [bigint] NOT NULL,
        [name] [nvarchar](32) NOT NULL,
        [transaction_begin_time] [datetime] NOT NULL,
        [transaction_type] [int] NOT NULL,
        [transaction_state] [int] NOT NULL,
        [session_id] [int] NOT NULL,
        [is_user_transaction] [bit] NOT NULL,
        [database_transaction_log_bytes_used] [bigint] NOT NULL,
        [login_time] [datetime] NOT NULL,
        [last_request_start_time] [datetime] NOT NULL,
        [last_request_end_time] [datetime] NULL,
        [transaction_isolation_level] [smallint] NOT NULL,
        [host_name] [nvarchar](128) NULL,
        [nt_user_name] [nvarchar](128) NULL,
        [command] [nvarchar](32) NULL,
        [status] [nvarchar](30) NULL,
        [cpu_time] [int] NULL,
        [total_elapsed_time] [int] NULL,
        [Transaction_time_in_mins] [int] NULL,
        [logical_reads] [bigint] NULL,
        [wait_time] [int] NULL,
        [wait_type] [nvarchar](60) NULL,
        [wait_resource] [nvarchar](256) NULL,
        [blocking_session_id] [smallint] NULL,
        [program_name] [nvarchar](128) NULL,
        [granted_query_memory] [int] NULL,
        [writes] [bigint] NULL,
        [Request Reads] [bigint] NULL,
        [Session Reads] [bigint] NOT NULL,
        [Session Logical Reads] [bigint] NOT NULL,
        [statement_text] [nvarchar](max) NULL,
        [batch_text] [nvarchar](max) NULL,
        [objectid] [int] NULL,
        [query_hash] BINARY(8),
        [query_plan_hash] BINARY(8),
        [mostrecentsqltext] [nvarchar](max) NULL
    ) ON [PRIMARY]
END

WHILE (1=1)
BEGIN
    -- Check if the database log used space is over the threshold

    SET @runtime = GETDATE()
    INSERT INTO tblDiagLongTransactions
    SELECT DISTINCT 
        @runtime AS datacollectiontime,
        atr.transaction_id,
        atr.name,
        transaction_begin_time,
        transaction_type,
        transaction_state,
        dsr.session_id,
        dsr.is_user_transaction,
        dtr.database_transaction_log_bytes_used,
        s.login_time,
        s.last_request_start_time,
        s.last_request_end_time,
        s.transaction_isolation_level,
        s.host_name,
        s.nt_user_name,
        r.command,
        r.status,
        r.cpu_time,
        r.total_elapsed_time,
        DATEDIFF(mi, transaction_begin_time, getdate()) AS 'Transaction_time_in_mins',
        r.logical_reads,
        r.wait_time,
        r.wait_type,
        r.wait_resource,
        r.blocking_session_id,
        s.program_name,
        r.granted_query_memory,
        r.writes,
        r.reads AS [Request Reads],
        s.reads AS [Session Reads],
        s.logical_reads AS [Session Logical Reads],
        (REPLACE(REPLACE(REPLACE(REPLACE(SUBSTRING(qt.text, r.statement_start_offset / 2 + 1,
            (CASE WHEN r.statement_end_offset = -1 THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
                ELSE r.statement_end_offset
            END - r.statement_start_offset) / 2), ' ', ''), CHAR(13), ''), CHAR(10), ''), CHAR(9), '')) AS statement_text,
        SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(qt.text, ' ', ''), CHAR(13), ''), CHAR(10), ''), CHAR(9), ''), 1, 256) AS batch_text,
        qt.objectid,
        query_hash,
        query_plan_hash,
        mqt.text
    FROM sys.dm_tran_active_transactions atr
    INNER JOIN sys.dm_tran_database_transactions dtr ON atr.transaction_id = dtr.transaction_id
    INNER JOIN sys.dm_tran_session_transactions dsr ON atr.transaction_id = dsr.transaction_id
    LEFT OUTER JOIN sys.dm_exec_sessions s ON dsr.session_id = s.session_id
    LEFT OUTER JOIN sys.dm_exec_connections conn ON s.session_id = dsr.session_id
    LEFT OUTER JOIN sys.dm_exec_requests r ON r.session_id = s.session_id
    OUTER APPLY sys.dm_exec_sql_text(r.sql_handle) AS qt
    OUTER APPLY sys.dm_exec_sql_text(conn.most_recent_sql_handle) AS mqt
    WHERE s.session_id != @@spid
        AND atr.transaction_type != 2
        AND (database_transaction_log_bytes_used > @transaction_log_bytes_used
            OR datediff(minute, transaction_begin_time, getdate()) > @active_tran_time_minutes)
    
    -- Check Log full threshold
    IF @kill_oldest_tran = 1
    BEGIN
        IF EXISTS (
            SELECT 1 FROM sys.dm_db_log_space_usage
            WHERE used_log_space_in_percent >= @log_full_threshold
        )
        BEGIN
            SELECT TOP 1
                @oldest_tran_id = atr.transaction_id,
                @oldest_tran_begin_time = transaction_begin_time,
                @oldest_tran_session_id = dsr.session_id
            FROM sys.dm_tran_active_transactions atr
            LEFT OUTER JOIN sys.dm_tran_database_transactions dtr ON atr.transaction_id = dtr.transaction_id
            LEFT OUTER JOIN sys.dm_tran_session_transactions dsr ON atr.transaction_id = dsr.transaction_id
            LEFT OUTER JOIN sys.dm_exec_sessions s ON dsr.session_id = s.session_id
            WHERE dsr.session_id != @@spid
                AND is_user_transaction = 1
            ORDER BY transaction_begin_time DESC

            SELECT @oldest_tran_id AS TranID, @oldest_tran_begin_time AS TranbeginTime, @oldest_tran_session_id AS SessionID
            SET @killstr = 'KILL ' + CAST(@oldest_tran_session_id AS VARCHAR(100))
            PRINT @killstr
            
            -- Kill oldest tran
            EXEC (@killstr)
            -- Checkpoint
            CHECKPOINT
        END
    END

    -- Change the polling interval as required
    WAITFOR DELAY @delay

END
```
