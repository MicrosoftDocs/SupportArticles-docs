---
title: ACS reports return no more than 42 days of data
description: Fixes an issue in which Audit Collection Services reports return no more than 42 days of data in System Center Operations Manager.
ms.date: 04/15/2024
---
# System Center Operations Manager ACS reports return no more than 42 days of data

This article helps you fix an issue in which Audit Collection Services (ACS) reports return no more than 42 days of data in System Center Operations Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Operations Manager, System Center 2012 R2 Operations Manager  
_Original KB number:_ &nbsp; 2663919

## Symptoms

When using System Center Operations Manager, the audit database data retention period is set to 100 days but ACS reports return no more than 42 days of data.

## Cause

The ACS collector service uses `DbCreatePartition.sql` to create the partition tables and uses `DbDeletePartition.sql` (`C:\Windows\System32\Security\AdtServer` on the collector server) to delete the partition tables based on the retention period. It also creates the views `AdtServer.dvall`, `AdtServer.dvall5`, and `AdtServer.dvheader`. In `DbCreatePartition.sql` and `DbDeletePartition.sql`, the dvall, dvall5, and dvheader views use a union of only the top 42 partition tables.

## Resolution

To resolve this issue, complete the following steps:

1. First create an ACS data retention period as per your requirements. To update the data retention period, run the following SQL query:

   ```sql
   USE OperationsManagerAC  
   UPDATE dtConfig  
   SET Value = <number of days to retain data + 1>  
   WHERE Id = 6
   ```

   For example, to retain 7 days of data, set **Value = 8**. Data is accumulated at approximately 7.6 MB per day per workstation.

   > [!NOTE]
   >  Microsoft SQL Server 2005 has a limitation that allows only 255 partition tables in a view. Don't set the value more than 255. The higher the value, the longer it can take to fetch the data in the reports, thus performance may be affected.

2. On the collector server, navigate to `C:\Windows\System32\Security\AdtServer`. Edit the `DbCreatePartition.sql` stored procedure in Notepad. Increase the days to 100 (or as per your requirements) by replacing 42 in the fifth line of for `AdtServer.dvall`, `AdtServer.dvall5`, and `AdtServer.dvheader` as shown below:

    ```sql
    /*************************************************
    *
    * Create or update dvAll, the view across all partition views
    *
    **************************************************/

    declare @iIsFirst int
    declare @vchStmt nvarchar(max)
    declare @vchPartitionId nchar(36)
    declare cPartition cursor for
    select top 42 PartitionId from dtPartition order by PartitionCloseTime desc

    /***************************************************
    *
    * Create or update dvAll5, the view across all partition views limited to the first 5 strings
    *
    ****************************************************/

    declare @iIsFirst int
    declare @vchStmt nvarchar(max)
    declare @vchPartitionId nchar(36)
    declare cPartition cursor for
    select top 42 PartitionId from dtPartition order by PartitionCloseTime desc

    /****************************************************
    *
    * Create or update dvHeader, the view across all partition views with no dtstring joins
    *
    *****************************************************/

    declare @iIsFirst int
    declare @vchStmt nvarchar(max)
    declare @vchPartitionId nchar(36)
    declare cPartition cursor for
    select top 42 PartitionId from dtPartition order by PartitionCloseTime desc
    ```

3. On the collector server, navigate to `C:\Windows\System32\Security\AdtServer`. Edit the `DbDeletePartition.sql` stored procedure in Notepad. Increase the days to 100 (or as per your requirements) by replacing 42 in the fifth line of `AdtServer.dvall`, `AdtServer.dvall5`, and `AdtServer.dvheader` as shown below:

    ```sql
    /*****************************************************
    *
    * Create or update dvAll, the view across all partition views
    *
    ******************************************************/

    declare @iIsFirst int
    declare @vchStmt nvarchar(max)
    declare @vchPartitionId nchar(36)
    declare cPartition cursor for
    select top 42 PartitionId from dtPartition order by PartitionCloseTime desc

    /******************************************************
    *
    * Create or update dvAll5, the view across all partition views limited to the first 5 strings
    *
    *******************************************************/

    declare @iIsFirst int
    declare @vchStmt nvarchar(max)
    declare @vchPartitionId nchar(36)
    declare cPartition cursor for
    select top 42 PartitionId from dtPartition order by PartitionCloseTime desc

    /******************************************************
    *
    * Create or update dvHeader, the view across all partition views with no dtstring joins
    *
    *******************************************************/

    declare @iIsFirst int
    declare @vchStmt nvarchar(max)
    declare @vchPartitionId nchar(36)
    declare cPartition cursor for
    select top 42 PartitionId from dtPartition order by PartitionCloseTime desc
    ```

4. Restart the **Operations Manager Audit Collection Service** on the collector server.
