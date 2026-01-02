---
title: Troubleshoot SQL Server Agent Job Failures with Error 258
description: Troubleshoot SQL Server Agent job failures (error 258). Learn how to resolve timeout issues, fix registry problems, and ensure stable job execution.
ms.date: 12/04/2025
ms.custom: sap:SQL Agent (Jobs, Alerts, Operators)\Job failures, job scheduling and monitoring
ms.reviewer: prmadhes, v-shaywood
---

# SQL Server Agent job fails and returns error 258

This article provides troubleshooting guidance for an issue that causes Microsoft SQL Server Agent jobs to fail and generates error code 258.

## Symptoms

The [SQL Server Agent service](/ssms/agent/sql-server-agent#sql-server-agent-components) runs, but scheduled SQL Server Agent jobs don't run. The SQL Server and Agent logs show network and authentication timeouts in addition to failed sign-ins.

The following example shows the error message that's added to the logs:

```output
SQLServer Error: 258, TCP Provider: Timeout error [258]
ODBC Error: 0, Login timeout expired [SQLSTATE HYT00]
SQLServer Error: 258, Unable to complete login process due to delay in prelogin response [SQLSTATE 08001]
Logon to server '<ServerName>' failed (ConnLogJobHistory)
```

## Cause

This issue can be caused by any of the following underlying problems:

- Blocking on [msdb](/sql/relational-databases/databases/msdb-database) system tables that SQL Agent uses. This blocking prevents job metadata read and write operations.  
  - Example system tables include `dbo.sysjobs`, `dbo.sysjobschedulers`, and `dbo.jobsteps`.
- Non response (hangs) in important SQL Server Agent threads or other process-level problems.
- Worker thread exhaustion in SQL Server (no workers available). This exhaustion prevents the Agent from connecting or processing schedules.

## Solution

1. Verify that the SQL Server Agent service is running. Use one of the following PowerShell commands:

    - For default SQL instances:

        ```powershell
        Get-Service -Name "SQLSERVERAGENT"
        ```

    - For named SQL instances:

        ```powershell
        Get-Service -Name "SQLSERVERAGENT$<InstanceName>"
        ```

1. If the SQL Server Agent service isn't running, start it by using one of the following commands:

    - For default SQL instances:

        ```powershell
        Start-Service -Name "SQLSERVERAGENT"
        ```

    - For named SQL instances:

        ```powershell
        Start-Service -Name "SQLSERVERAGENT$<InstanceName>"
        ```

1. If jobs continue to fail after you start the SQL Server Agent service, go to the next step. If jobs are finishing successfully, the issue is resolved and no further action is required.
1. Check the jobs and schedules in `msdb`. Start [SQL Server Management Studio (SSMS)](/ssms/install/install), and run the following query:
  
    ```tsql
    USE msdb;
    GO
    -- List enabled jobs
    SELECT name, enabled, description 
    FROM msdb.dbo.sysjobs 
    WHERE enabled = 1;
    GO
    -- List schedules and next run information
    SELECT 
        s.name AS ScheduleName,
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

    Analyze the query output for any jobs that are enabled but failed. Investigate the job history and job-step outputs for any problematic jobs to identify and fix underlying problems.

1. Detect blocking sessions on `msdb` Agent system tables by running the following query in SSMS:

    ```tsql
    USE msdb;
    GO
    SELECT 
        session_id, 
        blocking_session_id, 
        wait_type, 
        wait_duration_ms, 
        resource_description
    FROM sys.dm_os_waiting_tasks
    WHERE resource_description LIKE '%sysjobs%'
       OR resource_description LIKE '%sysjobschedulers%'
       OR resource_description LIKE '%jobsteps%';
    GO 
    ```

    - To identify the query that's associated with a blocking session, run the following query in SSMS:

        ```tsql
        SELECT 
            wt.session_id,
            wt.blocking_session_id,
            wt.wait_type,
            wt.wait_duration_ms,
            wt.resource_description,
            er.status,
            er.command,
            er.cpu_time,
            er.total_elapsed_time,
            txt.text AS sql_text
        FROM sys.dm_os_waiting_tasks wt
        LEFT JOIN sys.dm_exec_requests er 
               ON wt.session_id = er.session_id
        CROSS APPLY sys.dm_exec_sql_text(er.sql_handle) AS txt
        WHERE wt.resource_description LIKE '%sysjobs%'
           OR wt.resource_description LIKE '%sysjobschedulers%'
           OR wt.resource_description LIKE '%jobsteps%';
        ```

1. Resolve or terminate any blocking sessions that you identified in the previous step. To terminate a session, run the following query in SSMS:

    ```tsql
    Kill <Blocking_Session_ID>
    ```

    After all blocking sessions are resolved or terminated, go to the next step.

1. Check for any worker, thread, or resource health problems by running the following query in SSMS:

    ```tsql
    /* ============================================================
       HEALTH CHECK (Worker, CPU, Memory)
       ============================================================ */
    
    SELECT 
        Section,
        Metric,
        Value,
        ExtraInfo
    FROM (
    
        /* ===============================
           WORKER THREAD STATUS
           =============================== */
        SELECT 
            CAST('WORKER THREAD STATUS' AS VARCHAR(MAX)) AS Section,
            CAST(CONCAT('Scheduler ', scheduler_id) AS VARCHAR(MAX)) AS Metric,
            CAST(CONCAT('Workers: ', active_workers_count, '/', current_workers_count) AS VARCHAR(MAX)) AS Value,
            CAST(CONCAT('WorkQueue=', work_queue_count, ', Idle=', is_idle) AS VARCHAR(MAX)) AS ExtraInfo
        FROM sys.dm_os_schedulers
        WHERE scheduler_id < 255
    
        UNION ALL
    
        /* ===============================
           CPU PRESSURE
           =============================== */
        SELECT
            CAST('CPU PRESSURE' AS VARCHAR(MAX)) AS Section,
            CAST(CONCAT('Scheduler ', scheduler_id) AS VARCHAR(MAX)) AS Metric,
            CAST(CONCAT('RunnableTasks=', runnable_tasks_count) AS VARCHAR(MAX)) AS Value,
            CAST(CONCAT('PendingIO=', pending_disk_io_count) AS VARCHAR(MAX)) AS ExtraInfo
        FROM sys.dm_os_schedulers
        WHERE scheduler_id < 255
    
        UNION ALL
    
        /* ===============================
           MEMORY STATUS (System)
           =============================== */
        SELECT
            CAST('MEMORY STATUS' AS VARCHAR(MAX)) AS Section,
            CAST('SystemMemoryState' AS VARCHAR(MAX)) AS Metric,
            CAST(system_memory_state_desc AS VARCHAR(MAX)) AS Value,
            CAST(CONCAT('TotalMB=', total_physical_memory_kb/1024, 
                        ', AvailableMB=', available_physical_memory_kb/1024) AS VARCHAR(MAX)) AS ExtraInfo
        FROM sys.dm_os_sys_memory
    
        UNION ALL
    
        /* ===============================
           PAGE LIFE EXPECTANCY
           =============================== */
        SELECT
            CAST('PAGE LIFE EXPECTANCY' AS VARCHAR(MAX)) AS Section,
            CAST('PLE' AS VARCHAR(MAX)) AS Metric,
            CAST(cntr_value AS VARCHAR(MAX)) AS Value,
            CAST(NULL AS VARCHAR(MAX)) AS ExtraInfo
        FROM sys.dm_os_performance_counters
        WHERE counter_name = 'Page life expectancy'
          AND object_name LIKE '%Buffer Manager%'
    
    ) AS x
    ORDER BY Section, Metric;
    ```

    Investigate the output of the health check query for any of the following problems as determined by the given symptoms:

    - Worker thread pressure:
        - Worker exhaustion, for example `Workers: 512/512`.
        - `WorkQueue` is greater than zero. This value indicates that tasks are waiting and the system is overloaded.
    - CPU pressure:
        - `RunnableTasks` is greater than zero. This value indicates that a CPU bottleneck exists. A non-zero value can also indicate that the SQL Server scheduler is being monopolized by a thread (a non-yielding scheduler).
    - Memory pressure:
        - `Memory state` is `LOW`. This value indicates that the overall system is low on memory.
        - A low value for `AvailableMB`. This value indicates high memory usage for SQL Server.
        - A `PLE` value of less than 300. This value indicates high memory churn.
1. If you identified any worker, CPU, or memory issues in the previous step, reduce your current workload to resolve the issues. If you didn't identify any issues, go to the next step.
1. Restart the SQL Server Agent by running one of the following PowerShell commands:

    > [!IMPORTANT]
    > Restarting the SQL Server Agent interrupts any currently running jobs.

    - For default SQL Server instances:

        ```powershell
        Restart-Service -Name "SQLSERVERAGENT"
        ```

    - For named SQL Server instances:

        ```powershell
        Restart-Service -Name "SQLAgent$<InstanceName>"
        ```

1. After SQL Server Agent restarts, verify that jobs are now running. Use the [Job Activity Monitor](/ssms/agent/monitor-job-activity#job-activity-monitor).

## Related content

- [SQL Server Agent overview](/ssms/agent/sql-server-agent)
- [View the SQL Server Agent error log](/ssms/agent/view-sql-server-agent-error-log-sql-server-management-studio)
- [Create a SQL Server Agent job](/ssms/agent/create-a-job)
