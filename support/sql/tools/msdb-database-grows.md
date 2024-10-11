---
title: MSDB database grows on SQL Server
description: This article provides workarounds for the problem where MSDB database grows on SQL Server with supplementary character collations.
ms.date: 12/28/2020
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: oliviera, sqlblt
ms.custom: sap:SQL Server Management, Query and Data Tools
---
# MSDB database grows on SQL Server with supplementary character collations

_Original product version:_ &nbsp; SQL Server 12 and later versions

## Symptom

Consider the following scenario:

- You installed an instance with a collation using supplementary characters for system database in SQL Server.
- You have configured Management Data Warehouse (MDW) and Data Collection.

In this scenario, when the SQL Server Integration Services (SSIS) packages created by the Data Collection run, you will find the MSDB database grows unexpectedly.

> [!NOTE]
> That kind of collation name ends with _SC, for example, `Latin1_General_100_CI_AS_SC`.

Every 10 seconds, the following 11 warning messages are inserted into the `msdb.dbo.sysssislog` system table:

> Truncation may occur due to retrieving data from database column "task_state" with a length of 20 to data flow column "task_state" with a length of 10.
>
> Truncation may occur due to retrieving data from database column "request_status" with a length of 30 to data flow column "request_status" with a length of 15.
>
> Truncation may occur due to retrieving data from database column "session_status" with a length of 30 to data flow column "session_status" with a length of 15.
>
> Truncation may occur due to retrieving data from database column "host_name" with a length of 40 to data flow column "host_name" with a length of 20.
>
> Truncation may occur due to retrieving data from database column "program_name" with a length of 100 to data flow column "program_name" with a length of 50.
>
> Truncation may occur due to retrieving data from database column "login_name" with a length of 60 to data flow column "login_name" with a length of 30.
>
> Truncation may occur due to retrieving data from database column "wait_type" with a length of 60 to data flow column "wait_type" with a length of 45.
>
> Truncation may occur due to retrieving data from database column "last_wait_type" with a length of 60 to data flow column "last_wait_type" with a length of 45.
>
> Truncation may occur due to retrieving data from database column "wait_resource" with a length of 100 to data flow column "wait_resource" with a length of 50.
>
> Truncation may occur due to retrieving data from database column "resource_description" with a length of 280 to data flow column "resource_description" with a length of 140.
>
> The external columns for ODS - Get snapshot of dm_exec_requests are out of synchronization with the data source columns. The external column "task_state" needs to be updated. The external column "request_status" needs to be updated. The external column "session_status" needs to be updated. The external column "host_name" needs to be updated. The external column "program_name" needs to be updated. The external column "login_name" needs to be updated. The external column "wait_type" needs to be updated. The external column "last_wait_type" needs to be updated. The external column "wait_resource" needs to be updated. The external column "resource_description" needs to be updated.

As a result, the `msdb.dbo.sysssislog` table grows one page (8 KB) every 10 seconds. The impact on the disk space is:

- 2.8 MB per hour (8 KB x 6 x 60)
- 67.5 MB per day (8 KB x 6 x 60 x 24)
- 1.97 GB per month (8 KB x 6 x 60 x 24 x 30)

## Cause

The collations using supplementary characters will change the size of some Dynamic Management View (DMV) columns. The Data Collector tool captures the content of some DMVs, for example `sys.dm_exec_requests`, and adds the results into the MDW database by using SSIS packages. In these SSIS packages, column sizes are predefined based on the size of columns for collations without using supplementary characters. When the packages run, a warning message is returned for each column whose size is bigger than the predefined size and is added to the `msdb.dbo.sysssislog` table.

> [!NOTE]
> These warning messages don't affect the insertion of actual data from the DMV into the data collection table.

## More information

Data collection process collects the metadata for the first result set when calling `sp_syscollector_snapshot_dm_exec_requests`. The following sql script is an example:

```sql
exec [sys].sp_describe_first_result_set N'EXEC [msdb].[dbo].[sp_syscollector_snapshot_dm_exec_requests] 5',NULL,1
```

This call returns different results depending on the collation, using supplementary characters or not:

- Instance with a collation that doesn't use supplementary characters:

    > [!NOTE]
    > For more clarity, only affected rows and columns are shown.

    |Column ordinal|name|Is nullable|System type_id|System type_name|Max length|Collation name|
    |---|---|---|---|---|---|---|
    |11|task_state|1|231|nvarchar(10)|20|SQL_Latin1_General_CP1_CI_AS|
    |12|request_status|1|231|nvarchar(15)|30|SQL_Latin1_General_CP1_CI_AS|
    |13|session_status|1|231|nvarchar(15)|30|SQL_Latin1_General_CP1_CI_AS|
    |...|||||||
    |17|host_name|1|231|nvarchar(20)|40|SQL_Latin1_General_CP1_CI_AS|
    |18|program_name|1|231|nvarchar(50)|100|SQL_Latin1_General_CP1_CI_AS|
    |19|login_name|1|231|nvarchar(30)|60|SQL_Latin1_General_CP1_CI_AS|
    |20|wait_type|1|231|nvarchar(45)|90|SQL_Latin1_General_CP1_CI_AS|
    |21|last_wait_type|1|231|nvarchar(45)|90|SQL_Latin1_General_CP1_CI_AS|
    |22|wait_duration_ms|0|127|bigint|8|NULL|
    |23|wait_resource|1|231|nvarchar(50)|100|SQL_Latin1_General_CP1_CI_AS|
    |24|resource_description|1|231|nvarchar(140)|280|SQL_Latin1_General_CP1_CI_AS|

- Instance with a collation that uses supplementary characters:

    > [!NOTE]
    > For more clarity, only affected rows and columns are shown.

    |Column ordinal|name|Is nullable|System type_id|System type_name|Max length|Collation name|
    |---|---|---|---|---|---|---|
    |11|task_state|1|231|nvarchar(20)|40|SQL_Latin1_General_CP1_CI_AS|
    |12|request_status|1|231|nvarchar(30)|60|SQL_Latin1_General_CP1_CI_AS|
    |13|session_status|1|231|nvarchar(30)|60|SQL_Latin1_General_CP1_CI_AS|
    |...|||||||
    |17|host_name|1|231|nvarchar(20)|40|SQL_Latin1_General_CP1_CI_AS|
    |18|program_name|1|231|nvarchar(100)|200|SQL_Latin1_General_CP1_CI_AS|
    |19|login_name|1|231|nvarchar(60)|120|SQL_Latin1_General_CP1_CI_AS|
    |20|wait_type|1|231|nvarchar(60)|120|SQL_Latin1_General_CP1_CI_AS|
    |21|last_wait_type|1|231|nvarchar(60)|120|SQL_Latin1_General_CP1_CI_AS|
    |23|wait_resource|1|231|nvarchar(50)|100|SQL_Latin1_General_CP1_CI_AS|
    |24|resource_description|1|231|nvarchar(280)|560|SQL_Latin1_General_CP1_CI_AS|

Both instances show the difference on some columns. For example,  the `wait_type` column has a system type name of **nvarchar(45)** with a max length of 90 on a standard collation. However, collations using supplementary characters have a system type name of **nvarchar(60)** with a max length of 120. The size difference causes the warning messages that are logged by the SSIS package.

## Workaround

You can use one of the following workarounds:

> [!IMPORTANT]
> If you use workaround 1 and workaround 2, any existing logins, jobs, or packages will be lost. These workarounds should only be used in a non-production environment.

### Workaround 1

Uninstall and reinstall the SQL Server instance with a collation without using supplementary characters.

### Workaround 2

Rebuild the system databases instance with a collation without using supplementary characters.

### Workaround 3

Create a job to remove the unnecessary warnings from the `msdb.dbo.sysssislog` table. In the following example, the job is scheduled to run every hour. You can define a different schedule as needed by changing the `@freq_subday_interval` value.

For example, you can change the `@freq_subday_interval` value from _1_ to _2_ to run the job every two hours.

```sql
USE [msdb]
GO

/****** Object:  Job [Data Collection Warnings Cleanup]    Script Date: <Datetime> ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: <Datetime> ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Data Collection Warnings Cleanup',
              @enabled=1,
              @notify_level_eventlog=0,
              @notify_level_email=0,
              @notify_level_netsend=0,
              @notify_level_page=0,
              @delete_level=0,
              @description=N'This jobs removes uneccessary Data Colletion Warnings from msdb.dbo.sysssislog table. These warnings are logged when system uses a supplementary characters collation.',
              @category_name=N'[Uncategorized (Local)]',
              @owner_login_name=N'WIN-BINNHII7A8S\Administrator', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Delete warrnings]    Script Date: <Datetime> ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Delete warrnings',
              @step_id=1,
              @cmdexec_success_code=0,
              @on_success_action=1,
              @on_success_step_id=0,
              @on_fail_action=2,
              @on_fail_step_id=0,
              @retry_attempts=0,
              @retry_interval=0,
              @os_run_priority=0, @subsystem=N'TSQL',
              @command=N'set nocount on

declare @system_collation nvarchar(128)
declare @CountWarn1 int, @CountWarn2 int
declare @InfoMsg nvarchar(200)

select @system_collation = cast(SERVERPROPERTY(''collation'') as nvarchar(128))
set @CountWarn1 = 0
set @CountWarn2 = 0

if upper(right(@system_collation,2)) = ''SC''
   begin   -- we have a supplementary characters collation we need to remove unnecessary warnings from msdb.dbo.sysssislog table

   delete
              from msdb.dbo.sysssislog
              where event = ''OnWarning''
              and source like ''Set%Master_Package_Collection''
              and message like ''Truncation may occur%''

       Set @CountWarn1 = @@ROWCOUNT

       delete
              from msdb.dbo.sysssislog
              where event = ''OnWarning''
              and source like ''Set%Master_Package_Collection''
              and message like ''The external columns for ODS - Get snapshot of%''
       Set @CountWarn2 = @@ROWCOUNT

       set @InfoMsg = ''Data Collection warning clean up job deleted ''+ltrim(str(@CountWarn1+@CountWarn2,8))+'' warnings from msdb.dbo.sysssislog table.''

       print @InfoMsg

       end
',
              @database_name=N'master',
              @flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Run every Hour',
              @enabled=1,
              @freq_type=4,
              @freq_interval=1,
              @freq_subday_type=8,
              @freq_subday_interval=1,
              @freq_relative_interval=0,
              @freq_recurrence_factor=0,
              @active_start_date=20201224,
              @active_end_date=99991231,
              @active_start_time=0,
              @active_end_time=235959,
              @schedule_uid=N'684bccd2-7424-4011-85d6-1d81791c53fe'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO
```
