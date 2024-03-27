---
title: Troubleshoot stuck data warehouse jobs
description: Provides suggestions for troubleshooting issues that certain data warehouse jobs freeze or hang in System Center 2012 Service Manager and later versions.
ms.date: 03/14/2024
ms.reviewer: khusmeno
---
# Troubleshoot stuck data warehouse jobs in System Center Service Manager

This article helps you troubleshoot issues that certain data warehouse jobs hang in System Center Service Manager.

_Original product version:_ &nbsp; System Center 2016 Service Manager, System Center 2012 R2 Service Manager, System Center 2012 Service Manager  
_Original KB number:_ &nbsp; 4040022

## Summary

This article helps you troubleshoot when the following data warehouse jobs are hung:

- MPSyncJob
- DWMaintenance
- Extract jobs for the Service Manager management group and the data warehouse management group
- Transform.Common
- Load.Common
- Load.CMDWDataMart
- Load.OMDWDataMart

Symptoms of hung data warehouse jobs include the following ones:

- The job has the status of **Running** in the Service Manager console or the PowerShell results. However, the job runs for a long time (for example, more than several hours).
- The start time and end time of the job are inconsistent.
- You don't see data or new data in your reports. Which may indicate that Extract, Transform, and Load (ETL) jobs aren't running.

Problems that aren't covered by this article:

- Errors that occur with individual modules
- `Transform.Common` failures that occur when a specific module fails or times out
- Management pack synchronization failures
- Cube processing issues
- Data integrity issues

## Understand the staging and configuration database

The `DWStagingAndConfig` database is the database to use when you troubleshoot. Here is a list of the tables in the database:

- `Infra.Process`

    Stores information about the jobs, such as `ProcessName` and `ProcessId`.

- `Infra.ProcessModule`

    Stores information about the `ProcessModules`, such as `VertexName` (name of the `ProcessModule`), `ProcessModuleId`, and `ModuleConfig`.

- `Infra.ProcessCategory`

    Stores information about the process categories, such as `ProcessCategoryName` and `IsEnabled`. The value of `IsEnabled` must be **1** for any process in this category to run.

- `Infra.Batch`

    Stores information about all batches, such as `BatchId`, `BatchStartTime`, and `BatchEndTime`.

- `Infra.WorkItem`

    Stores information about all the `WorkItems` of a batch. You can see any errors for failed `WorkItems` of a batch in this table.

- `Infra.Status`

    Stores information about respective `StatusIds`. Here is the data returned from the `Infra.Status` table.

    | StatusId|StatusName|Description|
    |---|---|---|
    |1|Success|Success|
    |2|Failed|Failed|
    |3|Not Started|Not Started|
    |4|Running|Running|
    |5|Stopped|Stopped|
    |6|Completed|Completed|
    |7|Waiting|Waiting|

  The most common reason for a stuck data warehouse job is that the data warehouse management server lost communication with Microsoft SQL Server. It occurs if SQL Server was updated without the Service Manager administrator's knowledge. You can check the Operations Manager event log on the data warehouse management server to determine whether it's the reason.

For other reasons, you can use Windows PowerShell cmdlets and SQL Server statements to troubleshoot. In the following resolution process, all PowerShell cmdlets are executed on the data warehouse management server, and the SQL Server statements are run against the `DWStagingAndConfig` database.

## Preparation

1. Start SQL Server Management Studio, and verify that you can connect to the SQL Server that hosts the `DWStagingAndConfig` database.

    To find the SQL Server instance, check the registry or type the following command:

    ```powershell
    $sql = Get-ItemProperty -path "HKLM:\SOFTWARE\Microsoft\System Center\2010\Common\Database";$sql.StagingSQLInstance
    ```

2. Use the following command to get the list of jobs and their current status:

    ```powershell
    $jobs = Get-SCDWJob;$jobs | ft -autosize
    ```

    If no results are returned or you experience an error, use the following command to load the data warehouse cmdlets module, and then rerun the previous command:

    ```powershell
    import-module (((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\System Center\2010\Common\Setup").InstallDirectory)+ "Microsoft.EnterpriseManagement.Warehouse.Cmdlets.psd1")
    ```

## Disable all job schedules

Use the following command to disable all job schedules and verify that all schedules are disabled (`ScheduleEnabled`=**False**):

```powershell
foreach($job in $jobs){Disable-SCDWJobSchedule -jobname $job.name};Get-SCDWJobSchedule | ft -autosize
```

## Wait until all running jobs complete

Run the following command repeatedly until all jobs that are running complete:

```powershell
Get-SCDWJob
```

If certain jobs seem to run forever, use the next steps to reset the jobs.

> [!NOTE]
> To make sure that you don't interfere with any currently running job, let all jobs finish before going to the next step unless the jobs seem to freeze or run forever.

## Stop the HealthService service

1. Use Service Control Manager (Services.msc) to stop the **Microsoft Monitoring Agent** service (HealthService.exe).

    You can also use the `Net Stop HealthService` command or the `Stop-Service` cmdlet to stop the service.

2. Rename the Health Service State folder.

    Use the following command to find the folder location:

    ```powershell
    $dir = Get-ItemProperty -path "HKLM:\SOFTWARE\Microsoft\System Center\2010\Common\Setup";$dir.installdirectory
    ```

## Set the status of all modules of the stuck jobs to Completed (StatusId = 6)

1. Find the `BatchId` of the stuck job in the result of the `Get-SCDWJob` cmdlet.

    Here is example output:

    |BatchId|Name|Status|CategoryName|StartTime|EndTime|IsEnabled|
    |---|---|---|---|---|---|---|
    |8806|Load.Common|Running|Load|12/2/2016 7:44:00 AM||True|

2. In SQL Server Management Studio, run the following statements:

    ```sql
    UPDATE Infra.WorkItem SET StatusId = 6 WHERE BatchId = '<BatchId>'
    UPDATE Infra.Batch SET StatusId = 6 WHERE BatchId = '<BatchId>'
    ```

3. Rerun `Get-SCDWJob` to verify the status.  

## Create a new batch for the stuck job

1. Run the following SQL Server statement:

    ```sql
    EXEC Infra.CreateBatch '<JobName>'
    ```

2. Rerun `Get-SCDWJob`, verify that the job has a new `BatchId` and the status is **Not Started**.

## Release all locks

1. Run the following SQL Server statement to get the locks:

    ```sql
    SELECT * FROM LockDetails
    ```

2. If the result isn't empty, run the following statement to release the lock:

    ```sql
    EXEC dbo.ReleaseLock
    @ResourceName = '<ResourceName>',
    @LockRequester = '<LockRequester>'
    ```

3. Repeat steps 1 and 2 until all locks are released.  

## Verify the job status

1. Run the following command:

    ```powershell
    Get-SCDWJob
    ```

2. Make sure that you see output similar to the following screenshot:

    :::image type="content" source="media/troubleshoot-stuck-data-warehouse-jobs/job-output.png" alt-text="Output of the command Get-SCDWJob, which you can use to verify the job status." border="false":::

    Verify the affected job has a new BatchId and all jobs have the value of **True** for `IsEnabled`. If any job shows **False** for `IsEnabled`, run the following SQL Server statement:

    ```sql
    UPDATE infra.ProcessCategory SET IsEnabled = 1 WHERE IsEnabled = 0
    ```

## Test whether the affected job runs correctly

Use the following command to start the affected job:

```powershell
Start-SCDWJob -jobname \<JobName>
```

If the job completes successfully, go to the next step.  

## Enable all job schedules and restart the HealthService service

1. Use the following command to enable all job schedules and verify that all schedules are enabled (ScheduleEnabled=True):

    ```powershell
    foreach($job in $jobs){Enable-SCDWJobSchedule -jobname $job.name};Get-SCDWJobSchedule | ft -autosize
    ```

2. Start the **Microsoft Monitoring Agent** service (HealthService.exe).  

## Check the job status

1. Run the following command:

    ```powershell
    Get-SCDWJob
    ```

    The output should be similar to the following screenshot:

    :::image type="content" source="media/troubleshoot-stuck-data-warehouse-jobs/output-checking-job-status.png" alt-text="Output of checking job status by running the command Get-SCDWJob." border="false":::

    > [!NOTE]
    > You may see that some process categories are disabled. This is normal, because `DWMaintenance` and `MPSyncJob` may disable processes for synchronization.

2. Monitor the jobs for a while to make sure that they run correctly.

3. Verify that the issue that you experienced no longer occurs. For report issues, it may take several hours to get the report updated with current results.  
