---
title: Troubleshoot SQL Agent Job Failures with Error 258
description: Troubleshoot SQL Agent job failures with error 258. Learn how to resolve timeout issues, fix registry problems, and ensure stable job execution.
ms.date: 12/04/2025
ms.custom: sap:SQL Agent (Jobs, Alerts, Operators)\Job failures, job scheduling and monitoring
ms.reviewer: prmadhes, v-shaywood
---

# SQL Agent job fails with error 258

This article provides troubleshooting guidance for an issue where SQL Agent jobs fail with error code 258.

## Symptoms

The SQL Agent service runs, but scheduled SQL Agent jobs don't execute. The SQL Server and Agent logs show network and authentication timeouts as well as failed sign-ins.

The following example shows the error message that's added to the logs:

```output
SQLServer Error: 258, TCP Provider: Timeout error [258]
ODBC Error: 0, Login timeout expired [SQLSTATE HYT00]
SQLServer Error: 258, Unable to complete login process due to delay in prelogin response [SQLSTATE 08001]
Logon to server '<ServerName>' failed (ConnLogJobHistory)
```

## Cause

This issue can be caused by any of the following underlying problems:

- Blocking on `msdb` system tables used by Agent, which prevents job metadata reads and writes.
  - Example system tables: `dbo.sysjobs`, `dbo.sysjobschedulers`, and `dbo.jobsteps`.
- Hangs inside important SQL Server Agent threads or other process-level problems.
- Worker thread exhaustion in SQL Server (no workers available), making the Agent unable to connect or process schedules.

## Solution

1. Confirm that the SQL Server Agent service is running by using the following PowerShell command:

    ```powershell
    Get-Service -Name "SQLSERVERAGENT"
    ```

1. If the SQL Server Agent service isn't running, start it.
1. Check the jobs and schedules in `msdb` by opening [SQL Server Management Studio (SSMS)](/ssms/install/install) and running the following query:
  
    ```tsql
    USE msdb;
    GO
    
    -- List enabled jobs
    SELECT name, enabled, description FROM msdb.dbo.sysjobs WHERE enabled = 1;
    GO
    
    -- Show job schedules and next run
    SELECT s.name AS ScheduleName,
            j.name AS JobName,
            s.enabled AS ScheduleEnabled,
            s.active_start_date,
            s.active_end_time
    FROM msdb.dbo.sysjobs j
    JOIN msdb.dbo.sysjobschedules js ON j.job_id = js.job_id
    JOIN msdb.dbo.sysschedules s ON js.schedule_id = s.schedule_id
    WHERE j.enabled = 1;
    GO
    ```

    Analyze the query output for any jobs which are enabled but have failed. Investigate the job history and job-step outputs for any problematic jobs to identify and fix underlying issues.

1. Detect blocking on `msdb` Agent system tables by running the following query in SSMS:

    ```tsql
    USE msdb;
    GO
    
    SELECT session_id, blocking_session_id, wait_type, wait_duration_ms, resource_description
    FROM sys.dm_os_waiting_tasks
    WHERE resource_description LIKE '%sysjobs%'
       OR resource_description LIKE '%sysjobschedulers%'
       OR resource_description LIKE '%jobsteps%';
    GO
    ```

1. If blocking sessions are found, investigate the blocking query using `sys.dm_exec_requests` and `sys.dm_exec_sql_text`. Then, resolve or kill the blocking session.
1. Check the `system_health` Extended Events session for any worker, thread, or resource issues by running the following query in SSMS:

    ```tsql
    SELECT CAST(xet.target_data as xml) AS target_data
    FROM sys.dm_xe_session_targets xet
    JOIN sys.dm_xe_sessions xe
    ON xe.address = xet.event_session_address
    WHERE xe.name = 'system_health'
    ```

   Inspect the query results for `QUERY_PROCESSING`, `RESOURCE`, and `SYSTEM` components. Look for thread exhaustion, memory pressure, or CPU issues. If you identify any issues resolve them by following the guidance provided in [Troubleshooting SQL Agent Issues](/to-do). <!--Fill in this link one the doc is published -->


1. If you can't resolve blocking, hangs, or worker exhaustion, restart the SQL Server Agent by running the following commands in PowerShell:

    ```powershell
    Restart-Service -Name "SQLSERVERAGENT" -Force
    net stop "SQL Server Agent (MSSQLSERVER)"
    net start "SQL Server Agent (MSSQLSERVER)"
    ```

   > [!IMPORTANT]
   > Restarting the SQL Server Agent interrupts any currently running jobs.

   After the SQL Server Agent restarts, verify that jobs are now being executed by using the [Job Activity Monitor](/ssms/agent/monitor-job-activity#job-activity-monitor).

## Related content

- [SQL Server Agent overview](/ssms/agent/sql-server-agent)
- [View the SQL Server Agent error log](/ssms/agent/view-sql-server-agent-error-log-sql-server-management-studio)
- [Create a SQL Server Agent job](/ssms/agent/create-a-job)
