---
title: Remove VMware virtual machine (VM) protection references from DPMDB
description: Provides a SQL script to remove VMware VM protection references from the DPM database.
ms.date: 06/21/2021
ms.reviewer: v-jysur; jarrettr; sudesai, v-six
---
# SQL script to remove VMware VM protection references from DPMDB

> [!IMPORTANT]
> Only use this SQL script to resolve the issue when you [upgrade from DPM 2012 R2 to DPM 2016 with VMware VM protection](upgrade-dpm-vmware-vm-protection.md).

```sql
SET XACT_ABORT ON
BEGIN TRANSACTION
IF EXISTS( SELECT Ds.DataSourceID FROM tbl_IM_DataSource Ds JOIN tbl_PRM_LogicalReplica Lr ON Ds.DataSourceId = Lr.DataSourceId WHERE Ds.AppId = '18BEE66C-826F-4499-A663-9805C8688AD3') 
PRINT 'VMware DataSource in Active/Inactive protected state'
ELSE IF EXISTS ( SELECT DataSourceID FROM tbl_IM_DataSource WHERE CloudProtectionStatus!=0 AND AppId='18BEE66C-826F-4499-A663-9805C8688AD3')
PRINT 'VMware DataSource in Cloud are Active/Inactive protected state'
ELSE
                PRINT 'All VMware datasource protections are removed'
    SELECT serverID INTO #serverIdTable FROM dbo.tbl_AM_Server WHERE NOT ProxyServerId IS NULL
    DECLARE @serverId nvarchar(100)

    WHILE exists (SELECT * FROM #serverIdTable)
    BEGIN
        SELECT @serverId = (SELECT TOP 1 ServerId FROM #serverIdTable)
        PRINT @serverId

        --Remove Entries in different tables that belong to @serverId
        DELETE FROM dbo.tbl_RM_RecoveryTrail WHERE ServerId=@serverId
        DELETE FROM dbo.tbl_AM_InstalledAgent WHERE ServerId=@serverId
        DELETE FROM dbo.tbl_AM_ServerTimeZone WHERE ServerId=@serverId
        DELETE FROM dbo.tbl_IM_ProtectedObject WHERE ServerId=@serverId
        DELETE FROM dbo.tbl_AM_ServerProperties WHERE ServerId=@serverId
        DELETE FROM dbo.tbl_IM_PendingVMwareCustomAttr WHERE ServerId=@serverId
        DELETE FROM dbo.tbl_PRM_DatasourceBitmapVolumeMap WHERE ServerID=@serverId
        --To this point it is fine
        DELETE #serverIdTable WHERE serverId=@serverId
    END
    DROP TABLE #serverIdTable


    SELECT serverID INTO #serverIdTable2 FROM dbo.tbl_AM_Server WHERE NOT ProxyServerId IS NULL
    DECLARE @serverId2 nvarchar(100)

    WHILE exists (SELECT * FROM #serverIdTable2)
    BEGIN
        SELECT @serverId2 = (SELECT TOP 1 ServerId FROM #serverIdTable2)
        PRINT @serverId2
            SELECT DatasourceID INTO #datasourceIdTable FROM dbo.tbl_IM_DataSource WHERE ServerId=@serverId2
            DECLARE @datasourceId nvarchar(100)
           WHILE exists ( SELECT * FROM #datasourceIdTable )
            BEGIN
                SELECT @datasourceId = ( SELECT TOP 1 DatasourceId FROM #datasourceIdTable)
                DELETE FROM dbo.tbl_IM_DatasourceCapability WHERE DatasourceId=@datasourceId
                DELETE FROM dbo.tbl_IM_VMWareProperties WHERE DatasourceId=@datasourceId
                DELETE FROM dbo.tbl_RM_ShadowCopyTrail WHERE DatasourceId=@datasourceId
                DELETE #datasourceIdTable WHERE DataSourceId=@datasourceId
            END
            DROP TABLE #datasourceIdTable
            DELETE FROM dbo.tbl_RM_ReplicaTrail WHERE ServerId=@serverId2
            DELETE FROM dbo.tbl_IM_DataSource WHERE ServerID=@serverId2
            DELETE #serverIdTable2 WHERE serverId=@serverId2
        END
        DROP TABLE #serverIdTable2

        SELECT serverID INTO #serverIdTable3 FROM dbo.tbl_AM_Server WHERE NOT ProxyServerId IS NULL
        DECLARE @serverId3 nvarchar(100)

        WHILE exists (SELECT * FROM #serverIdTable3)
        BEGIN
            SELECT @serverId3 = (SELECT TOP 1 ServerId FROM #serverIdTable3)
            PRINT @serverId3
            --find Job definitions
            SELECT JobDefinitionID INTO #jobDefinitionIdTable FROM dbo.tbl_JM_JobDefinition WHERE ServerId=@serverId3
            DECLARE @jobDefinitionId nvarchar(100)
            WHILE exists ( SELECT * FROM #jobDefinitionIdTable)
            BEGIN
                SELECT @jobDefinitionId = ( SELECT TOP 1 JobDefinitionId FROM #jobDefinitionIdTable)
                --Delete from JobTrail but before that we need to delete from TaskTrail.
                --Find jobId associated with job definition and remove them
                SELECT JobId INTO #jobIdTable FROM dbo.tbl_JM_JobTrail WHERE JobDefinitionId=@jobDefinitionId
                DECLARE @jobId nvarchar(100)
                WHILE exists ( SELECT * FROM #jobIdTable)
                BEGIN
                    SELECT @jobId = ( SELECT TOP 1 JobId FROM #jobIdTable)
                    DELETE FROM dbo.tbl_TE_TaskTrail WHERE JobID=@jobId
                    DELETE #jobIdTable WHERE JobId=@jobId
                END
                DROP TABLE #jobIdTable
                --Remove Task Definition and schedule associated with JobDefinitionId
                DELETE FROM dbo.tbl_JM_TaskDefinition WHERE JobDefinitionId=@jobDefinitionId
                DELETE FROM dbo.tbl_JM_JobTrail WHERE JobDefinitionId=@jobDefinitionId
                DELETE FROM dbo.tbl_SCH_ScheduleDefinition WHERE JobDefinitionId=@jobDefinitionId
                DELETE #jobDefinitionIdTable WHERE JobDefinitionId=@jobDefinitionId
            END
            DROP TABLE #jobDefinitionIdTable

            DELETE FROM dbo.tbl_JM_JobDefinition WHERE ServerId=@serverId3
            DELETE FROM dbo.tbl_AM_Server where ServerId=@serverId3
            DELETE #serverIdTable3 WHERE serverId=@serverId3
        END
        DROP TABLE #serverIdTable3

        SELECT DatasourceID INTO #datasourceIdTable2 FROM dbo.tbl_IM_DataSource WHERE AppId='18BEE66C-826F-4499-A663-9805C8688AD3'
        DECLARE @datasourceId2 nvarchar(100)
        WHILE exists ( SELECT * FROM #datasourceIdTable2 )
        BEGIN
            SELECT @datasourceId2 = ( SELECT TOP 1 DatasourceId FROM #datasourceIdTable2)
            DELETE FROM dbo.tbl_IM_DatasourceCapability WHERE DatasourceId=@datasourceId2
            DELETE FROM dbo.tbl_IM_VMWareProperties WHERE DatasourceId=@datasourceId2
            DELETE FROM dbo.tbl_IM_ProtectedObject WHERE DatasourceId=@datasourceId2
            DELETE #datasourceIdTable2 WHERE DataSourceId=@datasourceId2
        END
        DROP TABLE #datasourceIdTable2
       
        Delete from tbl_IM_DataSource where AppId='18BEE66C-826F-4499-A663-9805C8688AD3'   

COMMIT;
```
