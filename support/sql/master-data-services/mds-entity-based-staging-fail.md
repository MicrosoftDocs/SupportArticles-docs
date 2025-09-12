---
title: MDS entity-based staging may fail
description: This article provides resolutions for the problem where MDS entity-based staging may fail when a duplicate Batch Tag value is used in SQL Server.
ms.date: 05/09/2025
ms.custom: sap:Master Data Services
ms.reviewer: jopilov
---
# MDS entity-based staging may fail when a duplicate Batch Tag value is used in SQL Server

This article helps you resolve the problem where Master Data Services (MDS) entity-based staging may fail when a duplicate Batch Tag value is used in SQL Server.

_Original product version:_ &nbsp; SQL Server    
_Original KB number:_ &nbsp; 2712547

## Symptoms

Consider the following scenario:

- You use the Microsoft SQL Server MDS entity-based staging process to import data into MDS.

- You populate various MDS staging tables (stg.name) with the staging data by using the `BatchTag` column to identify the batch.

- You use the same `BatchTag` value to populate a separate staging table that belongs to a different entity in a different MDS model.

- You run the necessary stored procedures to start the batch processing. Or, you start the staging batch from the Integration Management functional area on the MDS website.

When you start the staging process, you use one of three stored procedures:

- stg.udp_name_Leaf

- stg.udp_name_Consolidated

- stg.udp_name_Relationship

> [!NOTE]
> The \<name> placeholder is the name of the staging table that was specified when the entity was created.

The following examples show how to start the staging process by using the staging stored procedure:

- `exec mds.stg.udp_entityname1 'versionAdescription',0,'batchtag'`

- `exec mds.stg.udp_entityname2 'versionBdescription',0,'batchtag'`

In this scenario, you receive the following error message when you start the staging process:

> MDSERR310029  
The status of the specified batch is not valid.

Additionally, when you check the batch status, you notice that the batch that has the `BatchTag` value remains indefinitely stuck in status Running.

> [!NOTE]
> You can check the batch status from the MDS website by clicking **Integration Management** and then selecting the model to view the status or by querying the `[mdm].[tblStgBatch]` table.

## Cause

This problem occurs because the MDS entity-based staging process checks the `BatchTag` status regardless of the MDS model.

## Resolution

If your batch is stuck in Running status, stop the batch process, and then try to process the batch again. To stop the batch process, run the SQL statement: `Exec [mdm].[udpStagingBatchQueueActivate]`. To resolve this problem, update the BatchTag value in the staging table for the records to a new name. Additionally, make sure that the `importstatus_ID` field is set to *0* for the records.

## More information

For more information about starting the staging process, go to the following website:

- [Staging Stored Procedure (Master Data Services)](/sql/master-data-services/staging-stored-procedure-master-data-services)

- [SQL Server Video Archive](/previous-versions/dn912438(v=msdn.10))

- [Overview: Importing Data from Tables (Master Data Services)](/sql/master-data-services/overview-importing-data-from-tables-master-data-services)

- [Import Statuses (Master Data Services)](/sql/master-data-services/import-statuses-master-data-services)
