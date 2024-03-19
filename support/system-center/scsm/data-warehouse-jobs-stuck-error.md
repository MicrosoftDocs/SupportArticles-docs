---
title: Data warehouse jobs stuck or fail
description: Describes issues that Service Manager data warehouse jobs, such as MPSyncJob and Transform.common, stuck or fail with error Incorrect syntax near.
ms.date: 03/14/2024
ms.reviewer: khusmeno
---
# Data warehouse jobs stuck or fail with errors

This article helps you fix issues in which Service Manager data warehouse jobs, such as `MPSyncJob` and `Transform.common`, stuck or fail with error **Invalid column name** or **Incorrect syntax**.

_Original product version:_ &nbsp; System Center 2016 Service Manager, System Center 2012 R2 Service Manager  
_Original KB number:_ &nbsp; 4057583

## Symptoms

You experience one or more of the following issues:

- The `MPSyncJob` job is stuck on module **MP Sync SMGroupName: Associate Imported MP Vertex**.
- The `Transform.common` job fails, and you receive the following error message for the `TransformIncidentDim` module:

    > Invalid column name '\<Column Name>'

- In the Operations Manager event log, several events are logged that contain the following error message:

    > Incorrect syntax near ')'  

    **Sample Operations Manager event log events on the data warehouse management server**

    > Source: DataAccessLayer  
    > Event ID: 33333  
    > Level: Warning  
    > Description:
    > Data Access Layer rejected retry on SqlError:  
    > Request: Ral_ExecuteSql -- (statement=exec('IF OBJECT_ID(''[dbo].[IncidentDim]'') IS NULL  
    BEGIN  
    > CREATE TABLE [dbo].[IncidentDim]  
    > ([Column Name]   NVARCH...), (RETURN_VALUE=102)  
    > Class: 15  
    > Number: 102  
    > Message: Incorrect syntax near ')'.

    > Source: Deployment  
    > Event ID: 33403  
    > Level: Warning  
    > Description:  
    > Deployment Execution Infrastructure encountered an error while executing a deployer.  
    >
    > MP element ID: \<MP element ID>  
    > MP name: \<MP name>  
    > MP version: 1.0.0.1  
    > Operation: Install  
    > Error message: System.Data.SqlClient.SqlException: Incorrect syntax near ')'.  
    > Incorrect syntax near ')'.  
    >
    > at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action\`1 wrapCloseInAction)  
    > ...

    > Source: Data Warehouse  
    > Event ID: 33580  
    > Level: Error  
    > Description:  
    > Job Failed. JobName = \<*Job Name*>; JobCategory = Execution; BatchId = \<*Batch ID*>; WorkitemId = \<*Workitem ID*>; ModuleName = \<*Module Name*>; ErrorDetails = \<Errors>Error EventTime="\<*Time*>">Logged:\<*Time*> - Incorrect syntax near &apos;)&apos;.  
    Incorrect syntax near &apos;)&apos;.\</Error>\</Errors>;

    > Source: Data Warehouse  
    > Event ID: 33503  
    > Level: Warning  
    > Description:  
    > An error countered while attempting to execute ETL Module:  
    > ETL process type: Transform  
    > Batch ID: \<Batch ID>  
    > Module name: TransformIncidentDim  
    > Message: Invalid column name '\<Column Name>'.  
    > Transaction count after EXECUTE indicates a mismatching number of BEGIN and COMMIT statements. Previous count = 0, current count = 1.  
    >
    > Stack: at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action\`1 wrapCloseInAction)  
    > ...

    > Source: Data Warehouse  
    > Event ID: 33502  
    > Level: Error  
    > Description:  
    > ETL Module Execution failed:  
    > ETL process type: Transform  
    > Batch ID: \<Batch ID>  
    > Module name: TransformIncidentDim  
    > Message: Invalid column name '\<Column Name>'.  
    > Transaction count after EXECUTE indicates a mismatching number of BEGIN and COMMIT statements. Previous count = 0, current count = 1.  
    >
    > Stack:    at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action\`1 wrapCloseInAction)  
    > ...

    > Source: DataAccessLayer  
    > Event ID: 33333  
    > Level: Warning  
    > Description:  
    > Data Access Layer rejected retry on SqlError:  
    > Request: Ral_ExecuteSql -- (statement=exec('IF OBJECT_ID(''[dbo].[IncidentDim]'') IS NULL  
    > BEGIN  
    > CREATE TABLE [dbo].[IncidentDim]  
    > ([Column Name]   NVARCH...), (RETURN_VALUE=102)  
    > Class: 15  
    > Number: 102  
    > Message: Incorrect syntax near ')'.

    > Source: Data Warehouse  
    > Event ID: 33504  
    > Level: Information  
    > Description:  
    > ETL Module Execution recovered from failure:  
    > ETL process type: Transform  
    > Batch ID: \<Batch ID>  
    > Module name: TransformIncidentDim

    > Source: Deployment  
    > Event ID: 33410  
    > Level: Error  
    > Description:  
    > Deployment Execution Infrastructure has retried the maximum number of times and is giving up on this execution step.  
    > MP Element ID: \<MP Element ID>  
    > MP name: \<MP Name>  
    > MP version: 1.0.0.1  
    > Operation: Install  
    > Error message: Incorrect syntax near ')'.  
    > Incorrect syntax near ')'.

## Cause

The issues occur because Service Manager classes such as the `Incident` class have been extended with a new field that has a default value of a space or multiple spaces instead of **NULL**.

## Resolution

Before you start, run the following SQL query against the `DWStagingAndConfig` or `ServiceManager` database:

```sql
use DWStagingAndConfig -- or Use ServiceManager
select managedtypepropertyname, DefaultValue from ManagedTypeProperty where managedtypepropertyname like '%' and defaultvalue = ''
order by ManagedTypePropertyName
```

If the query returns no results, the following resolution doesn't apply to your system. Otherwise, follow these steps.

### Step 1: Fix the issue in the management pack

1. Use the following query to find the field and the management pack name:

    ```sql
    Select MP.MPName, MTP.ManagedTypePropertyName, MTP.DefaultValue from managementPack as MP
    Join ManagedTypeProperty as MTP on MTP.ManagementPackId = MP.ManagementPackId
    Where MTP.defaultvalue = ''
    ```

2. In the Service Manager console, select **Administration**.
3. In the **Administration** pane, expand **Administration**, and then select **Management Packs**.
4. In the **Management Packs** pane, select the management pack that's identified by the SQL query.
5. In the **Tasks** pane, select **Export** under the name of the management pack.
6. In the **Browse For Folder** dialog box, select a location for the file, and then click  **OK**.

7. Open the XML-formatted management pack file by using Notepad, find the **Property ID=** that matches the value that was returned by the SQL query, and then remove the ***DefaultValue=" "*** portion from the property.

8. Find the **\<ManagementPackPublicKeyToken>** text in the XML file and remove the whole line.

9. Open the management pack in the Service Manager Authoring Tool, and then [seal a Service Manager management pack](/system-center/scsm/seal-mp) by using the same .snk key file that was previously used to seal the pack.

10. In the Service Manager console, [import a management pack](/system-center/scsm/management-packs#import-a-management-pack).
11. In the Service Manager console, select **Data Warehouse**, expand **Data Warehouse**, and then select **Data Warehouse Jobs**.
12. In the **Data Warehouse Jobs** pane, right-click **MPSyncJob**, and then select **Resume** from the **Tasks** list.
13. Periodically refresh the **Data Warehouse Job** pane until the **MPSyncJob** is completed.

### Step 2: Fix the issue in data warehouse

### Method 1: Restore the data warehouse databases
  
Restore the following databases to a date before the change:

- DWStagingAndConfig
- DWRepository
- DWDataMart
- OMDWDataMart
- CMDWDataMart

> [!NOTE]
> Make Sure that the backups are within the period that's specified in **Data Retention settings**. To check Data Retention settings: In the Service Manager console, select **Administration**, and then go to **Administration > Settings**.

After you restore the data warehouse databases, data warehouse uses the updated management pack and the data that's stored on the Service Manager.

#### Method 2: Modify the DWStagingAndConfig database

> [!IMPORTANT]
> If the management pack wasn't created by you, you may need to rebuild the data warehouse with new databases by using this method. Therefore, we recommend that you contact Microsoft support before you continue.

Run the following query:

```sql
Use DWStagingAndConfig  
Select * from DeploySequenceStaging
Select DeployItemName, DeploySequenceId, Outcome, StatusID from DeployItemStaging where StatusId =2 and outcome like '%Incorrect syntax near '')''.%'
-- Click the Sequence field and view the first line.  Confirm that the management pack is one that you created before proceeding

DECLARE @DeploySequenceID [uniqueidentifier]
SET @DeploySequenceID = (Select DeploySequenceID from DWStagingAndConfig.dbo.DeployItemStaging WHERE outcome like '%Incorrect syntax near '')''.%')
Select @DeploySequenceID
DELETE FROM DWStagingAndConfig.dbo.DeploySequenceStaging WHERE DeploySequenceId=@DeploySequenceID
DELETE FROM DWStagingAndConfig.dbo.DeployItemStaging WHERE DeploySequenceId=@DeploySequenceID

DECLARE @BatchID Int
SET @BatchID = (Select Batchid from infra.workitem where STatusID=2  and ( Charindex('Incorrect syntax near '')''.',CAST([ErrorSummary] AS VARCHAR(MAX)))>0 ) )
Update infra.workitem SET statusid = 6 WHERE BatchId = @BatchID
```

## More information

We don't recommend you set default values for fields that are defined in a management pack. If you must set a default value, make sure that it's not a blank space or multiple blank spaces.
