---
title: Data warehouse jobs fail with event 33502
description: Discusses a problem in System Center 2012 Service Manager in which data warehouse jobs fail and event ID 33502 is logged.
ms.date: 03/14/2024
ms.reviewer: khusmeno
---
# Data warehouse jobs fail and event ID 33502 is logged

This article helps you fix a problem in which data Warehouse jobs fail in Microsoft System Center 2012 Service Manager and event ID 33502 is logged.

_Original product version:_ &nbsp; Microsoft System Center 2012 Service Manager, System Center 2012 R2 Service Manager  
_Original KB number:_ &nbsp; 3137611

## Symptom

Data warehouse jobs fail in Microsoft System Center 2012 Service Manager. When this problem occurs, the following event is logged in the Operations Manager event log on the data warehouse server:

> Log Name: Operations Manager  
> Source: Data Warehouse  
> Event ID: 33502  
> Level: Error  
> Description:  
> ETL Module Execution failed:  
> ETL process type: Transform  
> Batch ID: \<Batch ID>  
> Module name: TransformEntityRelatesToEntityFact  
> Message: ErrorNumber="50000" Message="Unable to acquire applock - another instance of the module must already be running." Severity="18" State="1" ProcedureName="InitializeTransform" LineNumber="52" Task="(null)"

Also, when you run certain data Warehouse-related cmdlets, you frequently see a time-out error recorded for the `TransformEntityRelatesToEntityFact` module that resembles the following:

> Get-SCDWJobModule -JobName transform.common  
> ...  
> 1952 TransformEntityRelatesToEntityFact Failed  
>...

## Cause

This problem can occur if the volume of transform data exceeds the amount that can be processed by the transform modules within the time-out period. It typically occurs after data warehouse jobs were disabled for some time because the volume of data to be transformed can become quickly backlogged. By default, data warehouse transform jobs have a hardcoded 60-minute time-out.

## Resolution 1

If you are currently in a failed state, use Resolution 1 to process the backlog and return the operation to a functioning status. The other two methods are ways to prevent the issue from reoccurring. To do it, wait for the status of all data warehouse jobs to be displayed as **Not Started** or **Failed**, and then follow these steps:

1. On the data warehouse server, stop the **HealthService** service at an elevated command prompt. To do it, run the following command:  

    ```console
    Net Stop HealthService
    ```

    > [!NOTE]
    > Depending on your version of Service Manager, this service name might be displayed as either **Microsoft Monitoring agent** or **System Center Management**.

2. Update the following SQL query to reflect the `ModuleName` value of the module in the `Transform.Common` job that's failing. This example uses `TransformEntityRelatesToEntityFact`.

    > [!NOTE]
    > The simplest way to see the `ModuleName` value for the module that's failing is to open the Service Manager console, select **Data Warehouse**, select **Data Warehouse** again, select **Data Warehouse jobs**, and then select `Transform.Common`. In the bottom-center pane, you can see a list of modules and the current status. After you make the changes, run the query.

    ```sql
    Use DWStagingAndConfig  
    declare  
    @mybatchid INT,  
    @mysourceid INT,  
    @outXML XML,  
    @myProcessCategoryName NVARCHAR(100),  
    @myProcessName NVARCHAR(100),  
    @myModuleName NVARCHAR(100),  
    @sqlString NVARCHAR(150),  
    @paramDef NVARCHAR(100)  
    set @myProcessCategoryName = N'Transform'  
    set @myProcessName = N'Transform.Common'  
    set @myModuleName = N'TransformEntityRelatesToEntityFact'  
    USE DWStagingAndConfig  
    create table #MyTempTable (  
    ProcessCategoryName NVARCHAR(150),  
    ProcessName NVARCHAR(150),  
    BatchId INT,  
    BatchStatus NVARCHAR(150),  
    WorkItemStatus NVARCHAR(150),  
    WorkItems INT  
    )  
    insert #MyTempTable  
    exec Infra.GetBatchDetails @ProcessCategoryName=@myProcessCategoryName, @ProcessName=@myProcessName  
    select @mybatchid = BatchId from #MyTempTable  
    select @mysourceid = sourceid from etl.source where SourceName='SCDW'  
    create table #MyTempTable2 (  
    myWaterMark XML  
    )  
    insert #MyTempTable2  
    exec etl.GetWaterMark @BatchId=@mybatchid, @ModuleName=@myModuleName, @ProcessName=@myProcessCategoryName, @SourceId=@mysourceid  
    select @outXML = myWaterMark from #MyTempTable2  
    create table #MyTempTable3 (  
    myWaterMark XML,  
    BatchId INT,  
    UpdatedRowCount INT,  
    InsertedRowCount INT  
    )  
    USE DWRepository  
    set @paramDef = N'@ioutXML XML'  
    set @sqlString = 'insert #MyTempTable3 exec ' + @myModuleName + 'Proc @WaterMark=@ioutXML'  
    exec sp_executesql @sqlString, @paramDef, @ioutXML=@outXML  
    select @mybatchid = BatchId, @outXML = myWaterMark from #MyTempTable3  
    USE DWStagingAndConfig  
    exec etl.SetWaterMark @BatchId=@mybatchid, @ModuleName=@myModuleName, @ProcessName=@myProcessCategoryName, @SourceId=@mysourceid, @WaterMark=@outXML  
    update infra.workitem set statusid = 6 where batchid = @mybatchid
    update infra.batch set statusid = 6 where batchid = @mybatchid
    exec infra.CreateBatch N'Transform.Common'
    drop table #MyTempTable  
    drop table #MyTempTable2  
    drop table #MyTempTable3
    ```

3. If the script above displays the following message:

    > "Unable to acquire applock - another instance of the module must already be running"

    execute the following query from SQL Server Management Studio then re-execute the SQL query in step 2:

    ```sql
    insert #MyTempTable
    exec Infra.GetBatchDetails @ProcessCategoryName='Transform', @ProcessName='Transform.Common'
    GO
    Update infra.workitem set statusid = 6 where batchid IN (SELECT myBatchID FROM #MyTempTable)
    GO
    Update infra.batch set statusid = 6 where processid = (SELECT ProcessId from infra.process where processname = 'Transform.Common')
    GO
    EXEC infra.CreateBatch 'Transform.Common'
    DROP TABLE #MyTempTable
    ```

4. Restart the **HealthService** service at an elevated command prompt. To do it, run the following command:  

    ```console
    Net Start HealthService
    ```

> [!NOTE]
>
> - You may have to run the SQL query several times until it finishes quickly.
> - Don't log off when you are running the query.
> - Run the query as quickly as possible, because new data that's captured in Service Manager will surge to the data warehouse when the service is restarted.  
> - If it takes you a long time to run the query several times, you may have another surge of data.
> - Use [Resolution 3](#resolution-3) as the long-term solution.

## Resolution 2

If you're using Forefront Identify Manager (FIM), this problem may recur because of the flow of data that reaches Service Manager. To spread the workload for this data, change the `FIM_ScheduleReportingIncrementalSynchronizationJob` schedule from the default value of **every 8 hours** to **every 2 hours**. To do it, follow these steps:

1. In SQL Server Management Studio, connect to the FIM database, expand **SQL Server Agent**, and then select **Jobs**.
2. Right-click `FIM_ScheduleReportingIncrementalSynchronizationJob`, select **Properties**, and then select **Schedules**.
3. Change the **Occurs every** value for `FIM_UpdateReportingIncrementalSynchronizationJobSchedule_1` to **2 hours**.

## Resolution 3

For a more long-term solution, upgrade to Microsoft System Center 2012 R2 Service Manager Update Rollup 4 (UR4) or a later version. Beginning in Update Rollup 4, Service Manager has an adjustable time-out setting. Also, the default data warehouse transform job time-out changes from **60 minutes** to **180 minutes**. If three hours aren't long enough for the `Transform.Common` module to finish, you can increase the value by changing the following registry value:

`HKLM\SOFTWARE\Microsoft\System Center\2010\Common\DAL`  

- `SqlCommandTimeout` = (DWord 32-bit in second)

> [!NOTE]
> If you're using Forefront Identity Manager, you must upgrade to Microsoft Identity Manager 2012 R2 to obtain support for Service Manager 2012 R2.

## More information

For more information, see [How to Change the Default Timeout Period for Data Warehouse Transform Jobs](/previous-versions/dn841367(v=technet.10)).
