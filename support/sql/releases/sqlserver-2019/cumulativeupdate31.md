---
title: Cumulative update 31 for SQL Server 2019 (KB5049296)
description: This article contains the summary, known issues, improvements, fixes, and other information for SQL Server 2019 cumulative update 31 (KB5049296).
ms.date: 05/30/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5049296
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5049296 - Cumulative Update 31 for SQL Server 2019

_Release Date:_ &nbsp; February 13, 2025  
_Version:_ &nbsp; 15.0.4420.2

## Summary

This article describes Cumulative Update package 31 (CU31) for Microsoft SQL Server 2019. This update contains 10 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 30, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4420.2**, file version: **2019.150.4420.2**
- Analysis Services - Product version: **15.0.35.51**, file version: **2018.150.35.51**

## Known issues in this update

### Issue one: Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

### Issue two: Patching a read-scale availability group (Windows or Linux) causes the availability group on the patched replica to be removed

If you use the read-scale availability group (AG) feature in SQL Server on Windows or Linux, do **not** install this CU.

This CU introduced [a fix to support AG names longer than 64 characters](#3548672). However, when the patch is installed on an instance that has the read-scale AG configured, the AG metadata is dropped. This issue affects read-scale AGs in both [Windows](/sql/database-engine/availability-groups/windows/read-scale-availability-groups) and [Linux](/sql/linux/sql-server-linux-availability-group-configure-rs), which means that the `CLUSTER_TYPE` of the AG is either `NONE` or `EXTERNAL`.

When the AG is dropped after patching, you'll see the error message in the [SQL Server error log](/sql/tools/configuration-manager/viewing-the-sql-server-error-log) similar to the following one:

```output
<DateTime>     Error: 19433, Severity: 16, State: 1.
<DateTime>     Always On: AG integrity check failed to find AG name to ID map entry with matching group ID for AG '<AGName>' (expected: '<AGName>'; found '<GUID Value>').
<DateTime>     Always On: The local replica of availability group '<AGName>' is being removed. The instance of SQL Server failed to validate the integrity of the availability group configuration in the Windows Server Failover Clustering (WSFC) store.  This is expected if the availability group has been removed from another instance of SQL Server. This is an informational message only. No user action is required.
```

After the patch is installed, the metadata is removed and you must re-create the AG on the patched replica. If the AG replicas have mismatched SQL Server versions (for example, the primary replica is running SQL Server 2019 CU30 and the secondary replica is running SQL Server 2019 CU31), you can't re-create the AG on the replica with the missing metadata (the secondary replica). In order to add the AG again, you must uninstall the patch on the secondary replica first and then add the AG again.

This issue is fixed in [SQL Server 2019 CU32](cumulativeupdate32.md#3907024).

#### Example

You can use steps that are similar to the following ones, but you need to update them for the given environment, including the `CLUSTER_TYPE`. The VM1 in the given example is the primary replica of the AG 'readscaleag' and VM2 is the secondary replica that has the patch applied but already uninstalled. Before running the script, both replicas VM1 and VM2 are running SQL Server 2019 CU30 and the AG metadata is missing on VM2. To run this script, use [SQLCMD mode](/sql/tools/sqlcmd/edit-sqlcmd-scripts-query-editor).

```sql
-- You must run this query in SQLCMD mode
:setvar PrimaryServer "VM1\SQL19"
:setvar SecondaryServer "VM2\SQL19"
:setvar AvailabilityGroupName "readscaleag"
:setvar EndpointURL "TCP://VM2.Contoso.lab:5022"
:setvar DatabaseName "testReadScaleAGDb"
:setvar ClusterType "NONE"

-- Connect to primary server
:CONNECT $(PrimaryServer)

-- Remove replica on secondary server
ALTER AVAILABILITY GROUP $(AvailabilityGroupName) REMOVE REPLICA ON N'$(SecondaryServer)';
GO

-- Connect to primary server again
:CONNECT $(PrimaryServer)

USE [master];
GO

-- Add replica on secondary server
ALTER AVAILABILITY GROUP $(AvailabilityGroupName)
ADD REPLICA ON N'$(SecondaryServer)' WITH (
    ENDPOINT_URL = N'$(EndpointURL)', 
    FAILOVER_MODE = MANUAL, 
    AVAILABILITY_MODE = ASYNCHRONOUS_COMMIT, 
    BACKUP_PRIORITY = 50, 
    SECONDARY_ROLE(ALLOW_CONNECTIONS = NO)
);
GO

-- Connect to secondary server
:CONNECT $(SecondaryServer)

-- Join availability group with cluster type none
ALTER AVAILABILITY GROUP $(AvailabilityGroupName) JOIN WITH (CLUSTER_TYPE = N'$(ClusterType)');
GO

-- Connect to secondary server again
:CONNECT $(SecondaryServer)

-- Set database to availability group
-- Wait for the replica to start communicating
BEGIN TRY
    DECLARE @conn BIT;
    DECLARE @count INT;
    DECLARE @replica_id UNIQUEIDENTIFIER;
    DECLARE @group_id UNIQUEIDENTIFIER;
    
    SET @conn = 0;
    SET @count = 30; -- wait for 5 minutes 

    IF (SERVERPROPERTY('IsHadrEnabled') = 1)
        AND (ISNULL((SELECT member_state 
                     FROM master.sys.dm_hadr_cluster_members 
                     WHERE UPPER(member_name COLLATE Latin1_General_CI_AS) = UPPER(CAST(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') AS NVARCHAR(256)) COLLATE Latin1_General_CI_AS)), 0) <> 0)
        AND (ISNULL((SELECT state 
                     FROM master.sys.database_mirroring_endpoints), 1) = 0)
    BEGIN
        SELECT @group_id = ags.group_id 
        FROM master.sys.availability_groups AS ags 
        WHERE name = N'$(AvailabilityGroupName)';

        SELECT @replica_id = replicas.replica_id 
        FROM master.sys.availability_replicas AS replicas 
        WHERE UPPER(replicas.replica_server_name COLLATE Latin1_General_CI_AS) = UPPER(@@SERVERNAME COLLATE Latin1_General_CI_AS) 
          AND group_id = @group_id;

        WHILE @conn <> 1 AND @count > 0
        BEGIN
            SET @conn = ISNULL((SELECT connected_state 
                                FROM master.sys.dm_hadr_availability_replica_states AS states 
                                WHERE states.replica_id = @replica_id), 1);
            IF @conn = 1
            BEGIN
                -- exit loop when the replica is connected, or if the query cannot find the replica status
                BREAK;
            END

            WAITFOR DELAY '00:00:10';
            SET @count = @count - 1;
        END
    END
END TRY
BEGIN CATCH
    -- If the wait loop fails, do not stop execution of the alter database statement
END CATCH

ALTER DATABASE $(DatabaseName) SET HADR AVAILABILITY GROUP = $(AvailabilityGroupName);
GO
GO
```

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description| Fix area | Component | Platform |
|------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|-------------------------------------------|----------|
| <a id=3666818>[3666818](#3666818) </a> | Fixes an issue with the business rule item for the domain-based attribute (DBA) option when you use Master Data Services.| Master Data Services | Master Data Services| Windows|
| <a id=3548672>[3548672](#3548672) </a> | Fixes various assertion failures (for example, Location: HadrWsfcUtil.cpp:2662; Expression: *pcwchId >= cwchRequired) that you might encounter when creating an availability group (AG) with a `CLUSTER_TYPE` of `NONE` and an AG name longer than 64 characters.| SQL Server Engine| High Availability and Disaster Recovery | All|
| <a id=3794235>[3794235](#3794235) </a> | Fixes a race condition that you encounter during flush operations when configuring `control.alternatewritethrough = 1`, which causes extended waits for some transactions.| SQL Server Engine | Linux| Linux|
| <a id=3791616>[3791616](#3791616) </a> | Fixes an issue in Database Mail in which the information logged into the `sysmail_log` system table and `sysmail_event_log` view in the **msdb** database might be stored and displayed as "???" (for example, when querying objects in SSMS). This issue might happen when the reported message (typically an error condition) contains non-ASCII characters and is more common on localized versions of SQL Server (for example, Japanese), not specific to the language of the SQL Server instance or its collation.| SQL Server Engine| Management Services |All |
| <a id=3677986>[3677986](#3677986) </a> | [FIX: Scalar UDF Inlining issues in SQL Server 2022 and 2019 (KB4538581)](https://support.microsoft.com/help/4538581)| SQL Server Engine| Programmability | All|
| <a id=2431765>[2431765](#2431765) </a> | Adds the following error 18749 when you use the `MaxCmdsInTran` parameter for the Log Reader Agent and change data capture (CDC) is enabled on the database: </br></br>MaxCmdsInTran parameter for log reader cannot be set with CDC enabled on the db </br></br>Additionally, the Log Reader Agent fails if the `MaxCmdsInTran` parameter is set and CDC is enabled.| SQL Server Engine| Replication | All|
| <a id=3739570>[3739570](#3739570) </a> | Fixes an issue in which the second article might not have updates correctly replicated if accelerated database recovery (ADR) is enabled on the database using replication with two articles for a single table. | SQL Server Engine| Replication | Windows|
| <a id=3801166>[3801166](#3801166) </a> | Fixes an issue in which the manual change tracking cleanup stored procedure incorrectly sets the invalid cleanup version to negative when the `TableName` parameter isn't passed.| SQL Server Engine| Replication | All|
| <a id=3221735>[3221735](#3221735) </a> | Fixes an issue in which updating permissions on the newly added column fails if you previously denied permissions on an existing column. | SQL Server Engine| Security Infrastructure | All|
| <a id=3800645>[3800645](#3800645) </a> | Data Quality Services (DQS) is only supported in SQL Server Enterprise and Developer editions. Before the fix, the operation is completed successfully when you try to install DQS in the Standard or Web edition. Moreover, this DQS will automatically be selected for installation when setting up a Windows Server Failover Cluster. Once installed, this DQS can't be configured. After applying this fix, SQL Server Setup won't allow DQS to be installed in SQL Server Standard or Web edition.</br></br>**Note**: This fix applies to new installations only. For more information, see [Installing Updates from the Command Prompt](/sql/database-engine/install-windows/installing-updates-from-the-command-prompt). | SQL Setup| Patching| Windows|

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2019 now](https://www.microsoft.com/download/details.aspx?id=100809)

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2019 CU release.
> - If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU31 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5049296)

> [!NOTE]
>
> - [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202019) contains this SQL Server 2019 CU and previously released SQL Server 2019 CU releases.
> - This CU is also available through Windows Server Update Services (WSUS).
> - We recommend that you always install the latest cumulative update that is available.

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2019 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2019 Release Notes](/sql/linux/sql-server-linux-release-notes-2019).

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update for Big Data Clusters (BDC)</b></summary>

To upgrade Microsoft SQL Server 2019 Big Data Clusters (BDC) on Linux to the latest CU, see the [Big Data Clusters Deployment Guidance](/sql/big-data-cluster/deployment-guidance).

Starting in SQL Server 2019 CU1, you can perform in-place upgrades for Big Data Clusters from the production supported releases (SQL Server 2019 GDR1). For more information, see [How to upgrade SQL Server Big Data Clusters](/sql/big-data-cluster/deployment-upgrade).

For more information, see the [Big Data Clusters release notes](/sql/big-data-cluster/release-notes-big-data-cluster).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2019-KB5049296-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5049296-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5049296-x64.exe| D73C16D0C8C42448F7351008EF5B10A43C54F42363F58731B2E5CBD49F24BDBA |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Asplatformhost.dll | 2018.150.35.51 | 292912 | 25-Jan-2025 | 12:56 | x64 |
| Mashupcompression.dll | 2.87.142.0 | 140672 | 25-Jan-2025 | 12:56 | x64 |
| Microsoft.analysisservices.minterop.dll | 15.0.35.51 | 758344 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 175680 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 199728 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 202296 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 198704 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 215088 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 197680 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 193584 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 252464 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 174120 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 197160 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.tabular.dll | 15.0.35.51 | 1098840 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.tabular.json.dll | 15.0.35.51 | 567344 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 54856 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 59440 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 59992 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 58968 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 62024 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 58304 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 58440 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 67656 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 53696 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 58440 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17968 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17968 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17968 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17968 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17992 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17968 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17976 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 19032 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17968 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17968 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.edm.netfx35.dll | 5.7.0.62516 | 660872 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.mashup.dll | 2.87.142.0 | 191352 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.mashup.oledb.dll | 2.87.142.0 | 30592 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.mashup.preview.dll | 2.87.142.0 | 76672 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.mashup.providercommon.dll | 2.87.142.0 | 103808 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 37760 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 41864 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 41856 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 41856 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 32120 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 41856 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 41864 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 45952 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 37752 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 41864 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.odata.netfx35.dll | 5.7.0.62516 | 1454464 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.odata.query.netfx35.dll | 5.7.0.62516 | 181120 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.sapclient.dll | 1.0.0.25 | 929592 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 34616 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 34624 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 34624 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 34616 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 35128 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 37672 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 46888 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 33064 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 34600 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.hostintegration.connectors.dll | 2.87.142.0 | 5283720 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.container.exe | 2.87.142.0 | 23432 | 25-Jan-2025 | 12:56 | x64 |
| Microsoft.mashup.container.netfx40.exe | 2.87.142.0 | 22912 | 25-Jan-2025 | 12:56 | x64 |
| Microsoft.mashup.container.netfx45.exe | 2.87.142.0 | 22912 | 25-Jan-2025 | 12:56 | x64 |
| Microsoft.mashup.eventsource.dll | 2.87.142.0 | 149384 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oauth.dll | 2.87.142.0 | 78720 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 14712 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 15240 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 15240 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 15232 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 15232 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 15224 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 14728 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 15744 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 14720 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 14728 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oledbinterop.dll | 2.87.142.0 | 199560 | 25-Jan-2025 | 12:56 | x64 |
| Microsoft.mashup.oledbprovider.dll | 2.87.142.0 | 64888 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13176 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13192 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13192 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13192 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13176 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13184 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13176 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13184 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13192 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13192 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.scriptdom.dll | 2.40.4554.261 | 2371808 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.shims.dll | 2.87.142.0 | 27528 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashup.storage.xmlserializers.dll | 1.0.0.0 | 140168 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashupengine.dll | 2.87.142.0 | 14835080 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 566136 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 676728 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 672640 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 652152 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 701312 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 660352 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 639872 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 881536 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 553848 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 648064 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.odata.core.netfx35.dll | 6.15.0.0 | 1437560 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.odata.edm.netfx35.dll | 6.15.0.0 | 778632 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.powerbi.adomdclient.dll | 15.1.61.21 | 1109368 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.spatial.netfx35.dll | 6.15.0.0 | 126344 | 25-Jan-2025 | 12:56 | x86 |
| Msmdctr.dll | 2018.150.35.51 | 38472 | 25-Jan-2025 | 12:56 | x64 |
| Msmdlocal.dll | 2018.150.35.51 | 47784504 | 25-Jan-2025 | 12:56 | x86 |
| Msmdlocal.dll | 2018.150.35.51 | 66261560 | 25-Jan-2025 | 12:56 | x64 |
| Msmdpump.dll | 2018.150.35.51 | 10187312 | 25-Jan-2025 | 12:56 | x64 |
| Msmdredir.dll | 2018.150.35.51 | 7957576 | 25-Jan-2025 | 12:56 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 16944 | 25-Jan-2025 | 12:56 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 16952 | 25-Jan-2025 | 12:56 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 17456 | 25-Jan-2025 | 12:56 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 16944 | 25-Jan-2025 | 12:56 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 17464 | 25-Jan-2025 | 12:56 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 17480 | 25-Jan-2025 | 12:56 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 17464 | 25-Jan-2025 | 12:56 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 18488 | 25-Jan-2025 | 12:56 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 16960 | 25-Jan-2025 | 12:56 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 16944 | 25-Jan-2025 | 12:56 | x86 |
| Msmdsrv.exe | 2018.150.35.51 | 65799240 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 833592 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 1628208 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 1454144 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 1643056 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 1608752 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 1001520 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 992808 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 1537080 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 1521712 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 811056 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 1596472 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 832568 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 1624624 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 1451064 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 1637936 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 1604656 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 998968 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 991280 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 1532976 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 1518136 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 810040 | 25-Jan-2025 | 12:56 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 1591848 | 25-Jan-2025 | 12:56 | x64 |
| Msmgdsrv.dll | 2018.150.35.51 | 8280112 | 25-Jan-2025 | 12:56 | x86 |
| Msmgdsrv.dll | 2018.150.35.51 | 10186288 | 25-Jan-2025 | 12:56 | x64 |
| Msolap.dll | 2018.150.35.51 | 8607168 | 25-Jan-2025 | 12:56 | x86 |
| Msolap.dll | 2018.150.35.51 | 11013184 | 25-Jan-2025 | 12:56 | x64 |
| Msolui.dll | 2018.150.35.51 | 286256 | 25-Jan-2025 | 12:56 | x86 |
| Msolui.dll | 2018.150.35.51 | 306624 | 25-Jan-2025 | 12:56 | x64 |
| Powerbiextensions.dll | 2.87.142.0 | 8853888 | 25-Jan-2025 | 12:56 | x86 |
| Private\_odbc32.dll | 10.0.14832.1000 | 728448 | 25-Jan-2025 | 12:56 | x64 |
| Sqlboot.dll | 2019.150.4420.2 | 215120 | 25-Jan-2025 | 12:56 | x64 |
| Sqlceip.exe | 15.0.4420.2 | 297016 | 25-Jan-2025 | 12:56 | x86 |
| Sqldumper.exe | 2019.150.4420.2 | 321552 | 25-Jan-2025 | 12:56 | x86 |
| Sqldumper.exe | 2019.150.4420.2 | 378920 | 25-Jan-2025 | 12:56 | x64 |
| System.spatial.netfx35.dll | 5.7.0.62516 | 117640 | 25-Jan-2025 | 12:56 | x86 |
| Tbb.dll | 2019.0.2019.410 | 442688 | 25-Jan-2025 | 12:56 | x64 |
| Tbbmalloc.dll | 2019.0.2019.410 | 270144 | 25-Jan-2025 | 12:56 | x64 |
| Tmapi.dll | 2018.150.35.51 | 6178352 | 25-Jan-2025 | 12:56 | x64 |
| Tmcachemgr.dll | 2018.150.35.51 | 4917808 | 25-Jan-2025 | 12:56 | x64 |
| Tmpersistence.dll | 2018.150.35.51 | 1184816 | 25-Jan-2025 | 12:56 | x64 |
| Tmtransactions.dll | 2018.150.35.51 | 6807088 | 25-Jan-2025 | 12:56 | x64 |
| Xmsrv.dll | 2018.150.35.51 | 26025544 | 25-Jan-2025 | 12:56 | x64 |
| Xmsrv.dll | 2018.150.35.51 | 35460152 | 25-Jan-2025 | 12:56 | x86 |

SQL Server 2019 Database Services Common Core

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Batchparser.dll | 2019.150.4420.2 | 165928 | 25-Jan-2025 | 12:58 | x86 |
| Batchparser.dll | 2019.150.4420.2 | 182296 | 25-Jan-2025 | 12:58 | x64 |
| Instapi150.dll | 2019.150.4420.2 | 75808 | 25-Jan-2025 | 12:58 | x86 |
| Instapi150.dll | 2019.150.4420.2 | 88104 | 25-Jan-2025 | 12:58 | x64 |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4420.2 | 104488 | 25-Jan-2025 | 12:58 | x64 |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4420.2 | 88080 | 25-Jan-2025 | 12:58 | x86 |
| Microsoft.sqlserver.rmo.dll | 15.0.4420.2 | 550952 | 25-Jan-2025 | 12:58 | x86 |
| Msasxpress.dll | 2018.150.35.51 | 27184 | 25-Jan-2025 | 12:49 | x86 |
| Msasxpress.dll | 2018.150.35.51 | 32304 | 25-Jan-2025 | 12:49 | x64 |
| Pbsvcacctsync.dll | 2019.150.4420.2 | 75840 | 25-Jan-2025 | 12:58 | x86 |
| Pbsvcacctsync.dll | 2019.150.4420.2 | 92216 | 25-Jan-2025 | 12:58 | x64 |
| Sqldumper.exe | 2019.150.4420.2 | 321552 | 25-Jan-2025 | 12:58 | x86 |
| Sqldumper.exe | 2019.150.4420.2 | 378920 | 25-Jan-2025 | 12:58 | x64 |
| Sqlftacct.dll | 2019.150.4420.2 | 59432 | 25-Jan-2025 | 12:58 | x86 |
| Sqlftacct.dll | 2019.150.4420.2 | 79936 | 25-Jan-2025 | 12:58 | x64 |
| Sqlmanager.dll | 2019.150.4420.2 | 743464 | 25-Jan-2025 | 12:58 | x86 |
| Sqlmanager.dll | 2019.150.4420.2 | 878648 | 25-Jan-2025 | 12:58 | x64 |
| Sqlmgmprovider.dll | 2019.150.4420.2 | 378920 | 25-Jan-2025 | 12:58 | x86 |
| Sqlmgmprovider.dll | 2019.150.4420.2 | 432192 | 25-Jan-2025 | 12:58 | x64 |
| Sqlsvcsync.dll | 2019.150.4420.2 | 276560 | 25-Jan-2025 | 12:58 | x86 |
| Sqlsvcsync.dll | 2019.150.4420.2 | 358464 | 25-Jan-2025 | 12:58 | x64 |
| Svrenumapi150.dll | 2019.150.4420.2 | 1161256 | 25-Jan-2025 | 12:58 | x64 |
| Svrenumapi150.dll | 2019.150.4420.2 | 911440 | 25-Jan-2025 | 12:58 | x86 |

SQL Server 2019 Data Quality

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Microsoft.ssdqs.core.dll | 15.0.4420.2 | 600128 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.ssdqs.core.dll | 15.0.4420.2 | 600136 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.ssdqs.infra.dll | 15.0.4420.2 | 1857576 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.ssdqs.infra.dll | 15.0.4420.2 | 1857616 | 25-Jan-2025 | 12:56 | x86 |
| Dqsinstaller.exe | 15.0.4420.2 | 2770984 | 25-Jan-2025 | 12:56 | x86 |

SQL Server 2019 sql_dreplay_client

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Dreplayclient.exe | 2019.150.4420.2 | 137256 | 25-Jan-2025 | 12:56 | x86 |
| Dreplaycommon.dll | 2019.150.4420.2 | 667728 | 25-Jan-2025 | 12:56 | x86 |
| Dreplayutil.dll | 2019.150.4420.2 | 305192 | 25-Jan-2025 | 12:56 | x86 |
| Instapi150.dll | 2019.150.4420.2 | 88104 | 25-Jan-2025 | 12:56 | x64 |
| Sqlresourceloader.dll | 2019.150.4420.2 | 38952 | 25-Jan-2025 | 12:56 | x86 |

SQL Server 2019 sql_dreplay_controller

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Dreplaycommon.dll | 2019.150.4420.2 | 667728 | 25-Jan-2025 | 12:56 | x86 |
| Dreplaycontroller.exe | 2019.150.4420.2 | 366632 | 25-Jan-2025 | 12:56 | x86 |
| Instapi150.dll | 2019.150.4420.2 | 88104 | 25-Jan-2025 | 12:48 | x64 |
| Sqlresourceloader.dll | 2019.150.4420.2 | 38952 | 25-Jan-2025 | 12:56 | x86 |

SQL Server 2019 Database Services Core Instance

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Aetm-enclave-simulator.dll | 2019.150.4420.2 | 4658232 | 25-Jan-2025 | 13:49 | x64 |
| Aetm-enclave.dll | 2019.150.4420.2 | 4612656 | 25-Jan-2025 | 13:49 | x64 |
| Aetm-sgx-enclave-simulator.dll | 2019.150.4420.2 | 4932528 | 25-Jan-2025 | 13:49 | x64 |
| Aetm-sgx-enclave.dll | 2019.150.4420.2 | 4873160 | 25-Jan-2025 | 13:49 | x64 |
| Azureattest.dll | 10.0.18965.1000 | 255056 | 25-Jan-2025 | 12:56 | x64 |
| Azureattestmanager.dll | 10.0.18965.1000 | 97528 | 25-Jan-2025 | 12:56 | x64 |
| Batchparser.dll | 2019.150.4420.2 | 182296 | 25-Jan-2025 | 13:49 | x64 |
| C1.dll | 19.16.27034.0 | 2438520 | 25-Jan-2025 | 13:49 | x64 |
| C2.dll | 19.16.27034.0 | 7239032 | 25-Jan-2025 | 13:49 | x64 |
| Cl.exe | 19.16.27034.0 | 424360 | 25-Jan-2025 | 13:49 | x64 |
| Clui.dll | 19.16.27034.0 | 541048 | 25-Jan-2025 | 13:49 | x64 |
| Databasemailengine.dll | 15.0.4420.2 | 79944 | 25-Jan-2025 | 13:49 | x86 |
| Datacollectorcontroller.dll | 2019.150.4420.2 | 280656 | 25-Jan-2025 | 13:49 | x64 |
| Dcexec.exe | 2019.150.4420.2 | 88128 | 25-Jan-2025 | 13:49 | x64 |
| Fssres.dll | 2019.150.4420.2 | 96296 | 25-Jan-2025 | 13:49 | x64 |
| Hadrres.dll | 2019.150.4420.2 | 206880 | 25-Jan-2025 | 13:49 | x64 |
| Hkcompile.dll | 2019.150.4420.2 | 1292328 | 25-Jan-2025 | 13:49 | x64 |
| Hkengine.dll | 2019.150.4420.2 | 5793872 | 25-Jan-2025 | 13:49 | x64 |
| Hkruntime.dll | 2019.150.4420.2 | 182312 | 25-Jan-2025 | 13:49 | x64 |
| Hktempdb.dll | 2019.150.4420.2 | 63528 | 25-Jan-2025 | 13:49 | x64 |
| Link.exe | 14.16.27034.0 | 1707936 | 25-Jan-2025 | 13:49 | x64 |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4420.2 | 235600 | 25-Jan-2025 | 13:49 | x86 |
| Microsoft.sqlserver.types.dll | 2019.150.4420.2 | 391240 | 25-Jan-2025 | 13:49 | x86 |
| Microsoft.sqlserver.xe.core.dll | 2019.150.4420.2 | 83992 | 25-Jan-2025 | 13:49 | x64 |
| Microsoft.sqlserver.xevent.configuration.dll | 2019.150.4420.2 | 178216 | 25-Jan-2025 | 13:49 | x64 |
| Microsoft.sqlserver.xevent.dll | 2019.150.4420.2 | 194616 | 25-Jan-2025 | 13:49 | x64 |
| Microsoft.sqlserver.xevent.linq.dll | 2019.150.4420.2 | 325672 | 25-Jan-2025 | 13:49 | x64 |
| Microsoft.sqlserver.xevent.targets.dll | 2019.150.4420.2 | 92200 | 25-Jan-2025 | 13:49 | x64 |
| Msobj140.dll | 14.16.27034.0 | 134008 | 25-Jan-2025 | 13:49 | x64 |
| Mspdb140.dll | 14.16.27034.0 | 632184 | 25-Jan-2025 | 13:49 | x64 |
| Mspdbcore.dll | 14.16.27034.0 | 632184 | 25-Jan-2025 | 13:49 | x64 |
| Msvcp140.dll | 14.16.27034.0 | 628200 | 25-Jan-2025 | 13:49 | x64 |
| Qds.dll | 2019.150.4420.2 | 1189960 | 25-Jan-2025 | 13:49 | x64 |
| Rsfxft.dll | 2019.150.4420.2 | 51264 | 25-Jan-2025 | 13:49 | x64 |
| Secforwarder.dll | 2019.150.4420.2 | 79944 | 25-Jan-2025 | 13:49 | x64 |
| Sqagtres.dll | 2019.150.4420.2 | 88144 | 25-Jan-2025 | 13:49 | x64 |
| Sqlaamss.dll | 2019.150.4420.2 | 108624 | 25-Jan-2025 | 13:49 | x64 |
| Sqlaccess.dll | 2019.150.4420.2 | 493608 | 25-Jan-2025 | 13:49 | x64 |
| Sqlagent.exe | 2019.150.4420.2 | 731176 | 25-Jan-2025 | 13:49 | x64 |
| Sqlagentctr150.dll | 2019.150.4420.2 | 71720 | 25-Jan-2025 | 13:49 | x86 |
| Sqlagentctr150.dll | 2019.150.4420.2 | 79944 | 25-Jan-2025 | 13:49 | x64 |
| Sqlboot.dll | 2019.150.4420.2 | 215120 | 25-Jan-2025 | 13:49 | x64 |
| Sqlceip.exe | 15.0.4420.2 | 297016 | 25-Jan-2025 | 13:49 | x86 |
| Sqlcmdss.dll | 2019.150.4420.2 | 88128 | 25-Jan-2025 | 13:49 | x64 |
| Sqlctr150.dll | 2019.150.4420.2 | 116776 | 25-Jan-2025 | 13:49 | x86 |
| Sqlctr150.dll | 2019.150.4420.2 | 145448 | 25-Jan-2025 | 13:49 | x64 |
| Sqldk.dll | 2019.150.4420.2 | 3180624 | 25-Jan-2025 | 13:49 | x64 |
| Sqldtsss.dll | 2019.150.4420.2 | 108624 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 1599568 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 3512392 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 3704872 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 4175944 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 4290600 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 3422248 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 3590184 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 4167752 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 4020264 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 4073536 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 2226248 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 2177096 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 3881024 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 3553304 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 4028456 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 3831880 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 3827752 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 3622952 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 3512352 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 1542224 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 3917896 | 25-Jan-2025 | 13:49 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 4040784 | 25-Jan-2025 | 13:49 | x64 |
| Sqllang.dll | 2019.150.4420.2 | 40097872 | 25-Jan-2025 | 13:49 | x64 |
| Sqlmin.dll | 2019.150.4420.2 | 40666192 | 25-Jan-2025 | 13:49 | x64 |
| Sqlolapss.dll | 2019.150.4420.2 | 108608 | 25-Jan-2025 | 13:49 | x64 |
| Sqlos.dll | 2019.150.4420.2 | 43048 | 25-Jan-2025 | 13:49 | x64 |
| Sqlpowershellss.dll | 2019.150.4420.2 | 84032 | 25-Jan-2025 | 13:49 | x64 |
| Sqlrepss.dll | 2019.150.4420.2 | 88128 | 25-Jan-2025 | 13:49 | x64 |
| Sqlresourceloader.dll | 2019.150.4420.2 | 51280 | 25-Jan-2025 | 13:49 | x64 |
| Sqlscm.dll | 2019.150.4420.2 | 88128 | 25-Jan-2025 | 13:49 | x64 |
| Sqlscriptdowngrade.dll | 2019.150.4420.2 | 38992 | 25-Jan-2025 | 13:49 | x64 |
| Sqlscriptupgrade.dll | 2019.150.4420.2 | 5810216 | 25-Jan-2025 | 13:49 | x64 |
| Sqlserverspatial150.dll | 2019.150.4420.2 | 673872 | 25-Jan-2025 | 13:49 | x64 |
| Sqlservr.exe | 2019.150.4420.2 | 628816 | 25-Jan-2025 | 13:49 | x64 |
| Sqlsvc.dll | 2019.150.4420.2 | 182328 | 25-Jan-2025 | 13:49 | x64 |
| Sqltses.dll | 2019.150.4420.2 | 9119784 | 25-Jan-2025 | 13:49 | x64 |
| Sqsrvres.dll | 2019.150.4420.2 | 280632 | 25-Jan-2025 | 13:49 | x64 |
| Stretchcodegen.exe | 15.0.4420.2 | 59448 | 25-Jan-2025 | 13:49 | x86 |
| Svl.dll | 2019.150.4420.2 | 161864 | 25-Jan-2025 | 13:49 | x64 |
| Vcruntime140.dll | 14.16.27034.0 | 85992 | 25-Jan-2025 | 13:49 | x64 |
| Xe.dll | 2019.150.4420.2 | 718912 | 25-Jan-2025 | 13:49 | x64 |
| Xpadsi.exe | 2019.150.4420.2 | 116760 | 25-Jan-2025 | 13:49 | x64 |
| Xplog70.dll | 2019.150.4420.2 | 92216 | 25-Jan-2025 | 13:49 | x64 |
| Xpqueue.dll | 2019.150.4420.2 | 92240 | 25-Jan-2025 | 13:49 | x64 |
| Xprepl.dll | 2019.150.4420.2 | 120896 | 25-Jan-2025 | 13:49 | x64 |
| Xpstar.dll | 2019.150.4420.2 | 473128 | 25-Jan-2025 | 13:49 | x64 |

SQL Server 2019 Database Services Core Shared

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Batchparser.dll | 2019.150.4420.2 | 182296 | 25-Jan-2025 | 12:56 | x64 |
| Batchparser.dll | 2019.150.4420.2 | 165928 | 25-Jan-2025 | 12:56 | x86 |
| Commanddest.dll | 2019.150.4420.2 | 264232 | 25-Jan-2025 | 12:56 | x64 |
| Datacollectortasks.dll | 2019.150.4420.2 | 227368 | 25-Jan-2025 | 12:56 | x64 |
| Distrib.exe | 2019.150.4420.2 | 243784 | 25-Jan-2025 | 12:56 | x64 |
| Dteparse.dll | 2019.150.4420.2 | 124984 | 25-Jan-2025 | 12:56 | x64 |
| Dteparsemgd.dll | 2019.150.4420.2 | 133176 | 25-Jan-2025 | 12:56 | x64 |
| Dtepkg.dll | 2019.150.4420.2 | 149544 | 25-Jan-2025 | 12:56 | x64 |
| Dtexec.exe | 2019.150.4420.2 | 73784 | 25-Jan-2025 | 12:56 | x64 |
| Dts.dll | 2019.150.4420.2 | 3143760 | 25-Jan-2025 | 12:56 | x64 |
| Dtscomexpreval.dll | 2019.150.4420.2 | 501840 | 25-Jan-2025 | 12:56 | x64 |
| Dtsconn.dll | 2019.150.4420.2 | 522320 | 25-Jan-2025 | 12:56 | x64 |
| Dtshost.exe | 2019.150.4420.2 | 107560 | 25-Jan-2025 | 12:56 | x64 |
| Dtsmsg150.dll | 2019.150.4420.2 | 567352 | 25-Jan-2025 | 12:56 | x64 |
| Dtspipeline.dll | 2019.150.4420.2 | 1329192 | 25-Jan-2025 | 12:56 | x64 |
| Dtswizard.exe | 15.0.4420.2 | 886848 | 25-Jan-2025 | 12:56 | x64 |
| Dtuparse.dll | 2019.150.4420.2 | 100424 | 25-Jan-2025 | 12:56 | x64 |
| Dtutil.exe | 2019.150.4420.2 | 151080 | 25-Jan-2025 | 12:56 | x64 |
| Exceldest.dll | 2019.150.4420.2 | 280616 | 25-Jan-2025 | 12:56 | x64 |
| Excelsrc.dll | 2019.150.4420.2 | 309320 | 25-Jan-2025 | 12:56 | x64 |
| Execpackagetask.dll | 2019.150.4420.2 | 186408 | 25-Jan-2025 | 12:56 | x64 |
| Flatfiledest.dll | 2019.150.4420.2 | 411688 | 25-Jan-2025 | 12:56 | x64 |
| Flatfilesrc.dll | 2019.150.4420.2 | 428072 | 25-Jan-2025 | 12:56 | x64 |
| Logread.exe | 2019.150.4420.2 | 722984 | 25-Jan-2025 | 12:56 | x64 |
| Mergetxt.dll | 2019.150.4420.2 | 75840 | 25-Jan-2025 | 12:56 | x64 |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4420.2 | 59432 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4420.2 | 43072 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.maintenanceplantasks.dll | 15.0.4420.2 | 391232 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.replication.dll | 2019.150.4420.2 | 1697856 | 25-Jan-2025 | 12:56 | x64 |
| Microsoft.sqlserver.replication.dll | 2019.150.4420.2 | 1640504 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.rmo.dll | 15.0.4420.2 | 550952 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.xevent.configuration.dll | 2019.150.4420.2 | 178216 | 25-Jan-2025 | 12:56 | x64 |
| Microsoft.sqlserver.xevent.dll | 2019.150.4420.2 | 194616 | 25-Jan-2025 | 12:56 | x64 |
| Msdtssrvrutil.dll | 2019.150.4420.2 | 112680 | 25-Jan-2025 | 12:56 | x64 |
| Msgprox.dll | 2019.150.4420.2 | 301136 | 25-Jan-2025 | 12:56 | x64 |
| Msoledbsql.dll | 2018.187.4.0 | 2750472 | 25-Jan-2025 | 12:56 | x64 |
| Msoledbsql.dll | 2018.187.4.0 | 153608 | 25-Jan-2025 | 12:56 | x64 |
| Msxmlsql.dll | 2019.150.4420.2 | 1497128 | 25-Jan-2025 | 12:56 | x64 |
| Oledbdest.dll | 2019.150.4420.2 | 280616 | 25-Jan-2025 | 12:56 | x64 |
| Oledbsrc.dll | 2019.150.4420.2 | 313408 | 25-Jan-2025 | 12:56 | x64 |
| Osql.exe | 2019.150.4420.2 | 92184 | 25-Jan-2025 | 12:56 | x64 |
| Qrdrsvc.exe | 2019.150.4420.2 | 501824 | 25-Jan-2025 | 12:56 | x64 |
| Rawdest.dll | 2019.150.4420.2 | 227368 | 25-Jan-2025 | 12:56 | x64 |
| Rawsource.dll | 2019.150.4420.2 | 210984 | 25-Jan-2025 | 12:56 | x64 |
| Rdistcom.dll | 2019.150.4420.2 | 915520 | 25-Jan-2025 | 12:56 | x64 |
| Recordsetdest.dll | 2019.150.4420.2 | 202776 | 25-Jan-2025 | 12:56 | x64 |
| Repldp.dll | 2019.150.4420.2 | 313424 | 25-Jan-2025 | 12:56 | x64 |
| Replerrx.dll | 2019.150.4420.2 | 182336 | 25-Jan-2025 | 12:56 | x64 |
| Replisapi.dll | 2019.150.4420.2 | 395328 | 25-Jan-2025 | 12:56 | x64 |
| Replmerg.exe | 2019.150.4420.2 | 563264 | 25-Jan-2025 | 12:56 | x64 |
| Replprov.dll | 2019.150.4420.2 | 862288 | 25-Jan-2025 | 12:56 | x64 |
| Replrec.dll | 2019.150.4420.2 | 1034304 | 25-Jan-2025 | 12:56 | x64 |
| Replsub.dll | 2019.150.4420.2 | 473168 | 25-Jan-2025 | 12:56 | x64 |
| Replsync.dll | 2019.150.4420.2 | 165952 | 25-Jan-2025 | 12:56 | x64 |
| Spresolv.dll | 2019.150.4420.2 | 276544 | 25-Jan-2025 | 12:56 | x64 |
| Sqlcmd.exe | 2019.150.4420.2 | 264232 | 25-Jan-2025 | 12:56 | x64 |
| Sqldiag.exe | 2019.150.4420.2 | 1140776 | 25-Jan-2025 | 12:56 | x64 |
| Sqldistx.dll | 2019.150.4420.2 | 251968 | 25-Jan-2025 | 12:56 | x64 |
| Sqllogship.exe | 15.0.4420.2 | 104520 | 25-Jan-2025 | 12:56 | x64 |
| Sqlmergx.dll | 2019.150.4420.2 | 399440 | 25-Jan-2025 | 12:56 | x64 |
| Sqlnclirda11.dll | 2011.110.5069.66 | 3478208 | 25-Jan-2025 | 12:56 | x64 |
| Sqlresourceloader.dll | 2019.150.4420.2 | 51280 | 25-Jan-2025 | 12:56 | x64 |
| Sqlresourceloader.dll | 2019.150.4420.2 | 38952 | 25-Jan-2025 | 12:56 | x86 |
| Sqlscm.dll | 2019.150.4420.2 | 88128 | 25-Jan-2025 | 12:56 | x64 |
| Sqlscm.dll | 2019.150.4420.2 | 79928 | 25-Jan-2025 | 12:56 | x86 |
| Sqlsvc.dll | 2019.150.4420.2 | 182328 | 25-Jan-2025 | 12:56 | x64 |
| Sqlsvc.dll | 2019.150.4420.2 | 149544 | 25-Jan-2025 | 12:56 | x86 |
| Sqltaskconnections.dll | 2019.150.4420.2 | 202832 | 25-Jan-2025 | 12:56 | x64 |
| Ssradd.dll | 2019.150.4420.2 | 84032 | 25-Jan-2025 | 12:56 | x64 |
| Ssravg.dll | 2019.150.4420.2 | 84048 | 25-Jan-2025 | 12:56 | x64 |
| Ssrdown.dll | 2019.150.4420.2 | 75848 | 25-Jan-2025 | 12:56 | x64 |
| Ssrmax.dll | 2019.150.4420.2 | 84040 | 25-Jan-2025 | 12:56 | x64 |
| Ssrmin.dll | 2019.150.4420.2 | 84040 | 25-Jan-2025 | 12:56 | x64 |
| Ssrpub.dll | 2019.150.4420.2 | 79944 | 25-Jan-2025 | 12:56 | x64 |
| Ssrup.dll | 2019.150.4420.2 | 75848 | 25-Jan-2025 | 12:56 | x64 |
| Txagg.dll | 2019.150.4420.2 | 391232 | 25-Jan-2025 | 12:56 | x64 |
| Txbdd.dll | 2019.150.4420.2 | 190504 | 25-Jan-2025 | 12:56 | x64 |
| Txdatacollector.dll | 2019.150.4420.2 | 485416 | 25-Jan-2025 | 12:56 | x64 |
| Txdataconvert.dll | 2019.150.4420.2 | 317480 | 25-Jan-2025 | 12:56 | x64 |
| Txderived.dll | 2019.150.4420.2 | 641064 | 25-Jan-2025 | 12:56 | x64 |
| Txlookup.dll | 2019.150.4420.2 | 542776 | 25-Jan-2025 | 12:56 | x64 |
| Txmerge.dll | 2019.150.4420.2 | 247864 | 25-Jan-2025 | 12:56 | x64 |
| Txmergejoin.dll | 2019.150.4420.2 | 309304 | 25-Jan-2025 | 12:56 | x64 |
| Txmulticast.dll | 2019.150.4420.2 | 145480 | 25-Jan-2025 | 12:56 | x64 |
| Txrowcount.dll | 2019.150.4420.2 | 141376 | 25-Jan-2025 | 12:56 | x64 |
| Txsort.dll | 2019.150.4420.2 | 288832 | 25-Jan-2025 | 12:56 | x64 |
| Txsplit.dll | 2019.150.4420.2 | 624680 | 25-Jan-2025 | 12:56 | x64 |
| Txunionall.dll | 2019.150.4420.2 | 198696 | 25-Jan-2025 | 12:56 | x64 |
| Xe.dll | 2019.150.4420.2 | 718912 | 25-Jan-2025 | 12:56 | x64 |
| Xmlsub.dll | 2019.150.4420.2 | 297040 | 25-Jan-2025 | 12:56 | x64 |

SQL Server 2019 sql_extensibility

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Commonlauncher.dll | 2019.150.4420.2 | 96328 | 25-Jan-2025 | 12:56 | x64 |
| Exthost.exe | 2019.150.4420.2 | 239664 | 25-Jan-2025 | 12:56 | x64 |
| Launchpad.exe | 2019.150.4420.2 | 1230888 | 25-Jan-2025 | 12:56 | x64 |
| Sqlsatellite.dll | 2019.150.4420.2 | 1026088 | 25-Jan-2025 | 12:56 | x64 |

SQL Server 2019 Full-Text Engine

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Fd.dll | 2019.150.4420.2 | 686160 | 25-Jan-2025 | 12:56 | x64 |
| Fdhost.exe | 2019.150.4420.2 | 129064 | 25-Jan-2025 | 12:56 | x64 |
| Fdlauncher.exe | 2019.150.4420.2 | 79936 | 25-Jan-2025 | 12:56 | x64 |
| Sqlft150ph.dll | 2019.150.4420.2 | 92216 | 25-Jan-2025 | 12:56 | x64 |

SQL Server 2019 sql_inst_mr

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Imrdll.dll | 15.0.4420.2 | 30784 | 25-Jan-2025 | 12:56 | x86 |

SQL Server 2019 Integration Services

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Commanddest.dll | 2019.150.4420.2 | 264232 | 25-Jan-2025 | 12:56 | x64 |
| Commanddest.dll | 2019.150.4420.2 | 227392 | 25-Jan-2025 | 12:56 | x86 |
| Dteparse.dll | 2019.150.4420.2 | 112696 | 25-Jan-2025 | 12:56 | x86 |
| Dteparse.dll | 2019.150.4420.2 | 124984 | 25-Jan-2025 | 12:56 | x64 |
| Dteparsemgd.dll | 2019.150.4420.2 | 116776 | 25-Jan-2025 | 12:56 | x86 |
| Dteparsemgd.dll | 2019.150.4420.2 | 133176 | 25-Jan-2025 | 12:56 | x64 |
| Dtepkg.dll | 2019.150.4420.2 | 133160 | 25-Jan-2025 | 12:56 | x86 |
| Dtepkg.dll | 2019.150.4420.2 | 149544 | 25-Jan-2025 | 12:56 | x64 |
| Dtexec.exe | 2019.150.4420.2 | 65064 | 25-Jan-2025 | 12:56 | x86 |
| Dtexec.exe | 2019.150.4420.2 | 73784 | 25-Jan-2025 | 12:56 | x64 |
| Dts.dll | 2019.150.4420.2 | 2762768 | 25-Jan-2025 | 12:56 | x86 |
| Dts.dll | 2019.150.4420.2 | 3143760 | 25-Jan-2025 | 12:56 | x64 |
| Dtscomexpreval.dll | 2019.150.4420.2 | 444480 | 25-Jan-2025 | 12:56 | x86 |
| Dtscomexpreval.dll | 2019.150.4420.2 | 501840 | 25-Jan-2025 | 12:56 | x64 |
| Dtsconn.dll | 2019.150.4420.2 | 432192 | 25-Jan-2025 | 12:56 | x86 |
| Dtsconn.dll | 2019.150.4420.2 | 522320 | 25-Jan-2025 | 12:56 | x64 |
| Dtsdebughost.exe | 2019.150.4420.2 | 94784 | 25-Jan-2025 | 12:56 | x86 |
| Dtsdebughost.exe | 2019.150.4420.2 | 113224 | 25-Jan-2025 | 12:56 | x64 |
| Dtshost.exe | 2019.150.4420.2 | 89640 | 25-Jan-2025 | 12:56 | x86 |
| Dtshost.exe | 2019.150.4420.2 | 107560 | 25-Jan-2025 | 12:56 | x64 |
| Dtsmsg150.dll | 2019.150.4420.2 | 555088 | 25-Jan-2025 | 12:56 | x86 |
| Dtsmsg150.dll | 2019.150.4420.2 | 567352 | 25-Jan-2025 | 12:56 | x64 |
| Dtspipeline.dll | 2019.150.4420.2 | 1120296 | 25-Jan-2025 | 12:56 | x86 |
| Dtspipeline.dll | 2019.150.4420.2 | 1329192 | 25-Jan-2025 | 12:56 | x64 |
| Dtswizard.exe | 15.0.4420.2 | 890936 | 25-Jan-2025 | 12:56 | x86 |
| Dtswizard.exe | 15.0.4420.2 | 886848 | 25-Jan-2025 | 12:56 | x64 |
| Dtuparse.dll | 2019.150.4420.2 | 88104 | 25-Jan-2025 | 12:56 | x86 |
| Dtuparse.dll | 2019.150.4420.2 | 100424 | 25-Jan-2025 | 12:56 | x64 |
| Dtutil.exe | 2019.150.4420.2 | 130616 | 25-Jan-2025 | 12:56 | x86 |
| Dtutil.exe | 2019.150.4420.2 | 151080 | 25-Jan-2025 | 12:56 | x64 |
| Exceldest.dll | 2019.150.4420.2 | 235560 | 25-Jan-2025 | 12:56 | x86 |
| Exceldest.dll | 2019.150.4420.2 | 280616 | 25-Jan-2025 | 12:56 | x64 |
| Excelsrc.dll | 2019.150.4420.2 | 260160 | 25-Jan-2025 | 12:56 | x86 |
| Excelsrc.dll | 2019.150.4420.2 | 309320 | 25-Jan-2025 | 12:56 | x64 |
| Execpackagetask.dll | 2019.150.4420.2 | 149544 | 25-Jan-2025 | 12:56 | x86 |
| Execpackagetask.dll | 2019.150.4420.2 | 186408 | 25-Jan-2025 | 12:56 | x64 |
| Flatfiledest.dll | 2019.150.4420.2 | 358480 | 25-Jan-2025 | 12:56 | x86 |
| Flatfiledest.dll | 2019.150.4420.2 | 411688 | 25-Jan-2025 | 12:56 | x64 |
| Flatfilesrc.dll | 2019.150.4420.2 | 370768 | 25-Jan-2025 | 12:56 | x86 |
| Flatfilesrc.dll | 2019.150.4420.2 | 428072 | 25-Jan-2025 | 12:56 | x64 |
| Isdbupgradewizard.exe | 15.0.4420.2 | 120888 | 25-Jan-2025 | 12:56 | x86 |
| Isdbupgradewizard.exe | 15.0.4420.2 | 120896 | 25-Jan-2025 | 12:56 | x86 |
| Isserverexec.exe | 15.0.4420.2 | 145480 | 25-Jan-2025 | 12:56 | x64 |
| Isserverexec.exe | 15.0.4420.2 | 149584 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.astasks.dll | 15.0.4420.2 | 116808 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4420.2 | 59432 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4420.2 | 59432 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4420.2 | 510008 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4420.2 | 510016 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4420.2 | 43072 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4420.2 | 43088 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.maintenanceplantasks.dll | 15.0.4420.2 | 391232 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.management.integrationservicesenum.dll | 15.0.4420.2 | 59432 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.management.integrationservicesenum.dll | 15.0.4420.2 | 59472 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.scripttask.dll | 15.0.4420.2 | 141392 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.scripttask.dll | 15.0.4420.2 | 141352 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.xevent.configuration.dll | 2019.150.4420.2 | 157768 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.xevent.configuration.dll | 2019.150.4420.2 | 178216 | 25-Jan-2025 | 12:56 | x64 |
| Microsoft.sqlserver.xevent.dll | 2019.150.4420.2 | 174144 | 25-Jan-2025 | 12:56 | x86 |
| Microsoft.sqlserver.xevent.dll | 2019.150.4420.2 | 194616 | 25-Jan-2025 | 12:56 | x64 |
| Msdtssrvr.exe | 15.0.4420.2 | 219208 | 25-Jan-2025 | 12:56 | x64 |
| Msdtssrvrutil.dll | 2019.150.4420.2 | 100408 | 25-Jan-2025 | 12:56 | x86 |
| Msdtssrvrutil.dll | 2019.150.4420.2 | 112680 | 25-Jan-2025 | 12:56 | x64 |
| Msmdpp.dll | 2018.150.35.51 | 10062896 | 25-Jan-2025 | 12:56 | x64 |
| Odbcdest.dll | 2019.150.4420.2 | 321608 | 25-Jan-2025 | 12:56 | x86 |
| Odbcdest.dll | 2019.150.4420.2 | 370752 | 25-Jan-2025 | 12:56 | x64 |
| Odbcsrc.dll | 2019.150.4420.2 | 329784 | 25-Jan-2025 | 12:56 | x86 |
| Odbcsrc.dll | 2019.150.4420.2 | 383016 | 25-Jan-2025 | 12:56 | x64 |
| Oledbdest.dll | 2019.150.4420.2 | 239656 | 25-Jan-2025 | 12:56 | x86 |
| Oledbdest.dll | 2019.150.4420.2 | 280616 | 25-Jan-2025 | 12:56 | x64 |
| Oledbsrc.dll | 2019.150.4420.2 | 264232 | 25-Jan-2025 | 12:56 | x86 |
| Oledbsrc.dll | 2019.150.4420.2 | 313408 | 25-Jan-2025 | 12:56 | x64 |
| Rawdest.dll | 2019.150.4420.2 | 227368 | 25-Jan-2025 | 12:56 | x64 |
| Rawdest.dll | 2019.150.4420.2 | 190544 | 25-Jan-2025 | 12:56 | x86 |
| Rawsource.dll | 2019.150.4420.2 | 210984 | 25-Jan-2025 | 12:56 | x64 |
| Rawsource.dll | 2019.150.4420.2 | 178248 | 25-Jan-2025 | 12:56 | x86 |
| Recordsetdest.dll | 2019.150.4420.2 | 202776 | 25-Jan-2025 | 12:56 | x64 |
| Recordsetdest.dll | 2019.150.4420.2 | 174160 | 25-Jan-2025 | 12:56 | x86 |
| Sqlceip.exe | 15.0.4420.2 | 297016 | 25-Jan-2025 | 12:56 | x86 |
| Sqldest.dll | 2019.150.4420.2 | 239696 | 25-Jan-2025 | 12:56 | x86 |
| Sqldest.dll | 2019.150.4420.2 | 276520 | 25-Jan-2025 | 12:56 | x64 |
| Sqltaskconnections.dll | 2019.150.4420.2 | 170024 | 25-Jan-2025 | 12:56 | x86 |
| Sqltaskconnections.dll | 2019.150.4420.2 | 202832 | 25-Jan-2025 | 12:56 | x64 |
| Txagg.dll | 2019.150.4420.2 | 329784 | 25-Jan-2025 | 12:56 | x86 |
| Txagg.dll | 2019.150.4420.2 | 391232 | 25-Jan-2025 | 12:56 | x64 |
| Txbdd.dll | 2019.150.4420.2 | 153672 | 25-Jan-2025 | 12:56 | x86 |
| Txbdd.dll | 2019.150.4420.2 | 190504 | 25-Jan-2025 | 12:56 | x64 |
| Txbestmatch.dll | 2019.150.4420.2 | 546856 | 25-Jan-2025 | 12:56 | x86 |
| Txbestmatch.dll | 2019.150.4420.2 | 653352 | 25-Jan-2025 | 12:56 | x64 |
| Txcache.dll | 2019.150.4420.2 | 165960 | 25-Jan-2025 | 12:56 | x86 |
| Txcache.dll | 2019.150.4420.2 | 198688 | 25-Jan-2025 | 12:56 | x64 |
| Txcharmap.dll | 2019.150.4420.2 | 272440 | 25-Jan-2025 | 12:56 | x86 |
| Txcharmap.dll | 2019.150.4420.2 | 313408 | 25-Jan-2025 | 12:56 | x64 |
| Txcopymap.dll | 2019.150.4420.2 | 165928 | 25-Jan-2025 | 12:56 | x86 |
| Txcopymap.dll | 2019.150.4420.2 | 198736 | 25-Jan-2025 | 12:56 | x64 |
| Txdataconvert.dll | 2019.150.4420.2 | 276552 | 25-Jan-2025 | 12:56 | x86 |
| Txdataconvert.dll | 2019.150.4420.2 | 317480 | 25-Jan-2025 | 12:56 | x64 |
| Txderived.dll | 2019.150.4420.2 | 559160 | 25-Jan-2025 | 12:56 | x86 |
| Txderived.dll | 2019.150.4420.2 | 641064 | 25-Jan-2025 | 12:56 | x64 |
| Txfileextractor.dll | 2019.150.4420.2 | 182312 | 25-Jan-2025 | 12:56 | x86 |
| Txfileextractor.dll | 2019.150.4420.2 | 219176 | 25-Jan-2025 | 12:56 | x64 |
| Txfileinserter.dll | 2019.150.4420.2 | 182344 | 25-Jan-2025 | 12:56 | x86 |
| Txfileinserter.dll | 2019.150.4420.2 | 215080 | 25-Jan-2025 | 12:56 | x64 |
| Txgroupdups.dll | 2019.150.4420.2 | 256040 | 25-Jan-2025 | 12:56 | x86 |
| Txgroupdups.dll | 2019.150.4420.2 | 313368 | 25-Jan-2025 | 12:56 | x64 |
| Txlineage.dll | 2019.150.4420.2 | 129088 | 25-Jan-2025 | 12:56 | x86 |
| Txlineage.dll | 2019.150.4420.2 | 153672 | 25-Jan-2025 | 12:56 | x64 |
| Txlookup.dll | 2019.150.4420.2 | 469048 | 25-Jan-2025 | 12:56 | x86 |
| Txlookup.dll | 2019.150.4420.2 | 542776 | 25-Jan-2025 | 12:56 | x64 |
| Txmerge.dll | 2019.150.4420.2 | 202824 | 25-Jan-2025 | 12:56 | x86 |
| Txmerge.dll | 2019.150.4420.2 | 247864 | 25-Jan-2025 | 12:56 | x64 |
| Txmergejoin.dll | 2019.150.4420.2 | 247872 | 25-Jan-2025 | 12:56 | x86 |
| Txmergejoin.dll | 2019.150.4420.2 | 309304 | 25-Jan-2025 | 12:56 | x64 |
| Txmulticast.dll | 2019.150.4420.2 | 116800 | 25-Jan-2025 | 12:56 | x86 |
| Txmulticast.dll | 2019.150.4420.2 | 145480 | 25-Jan-2025 | 12:56 | x64 |
| Txpivot.dll | 2019.150.4420.2 | 206888 | 25-Jan-2025 | 12:56 | x86 |
| Txpivot.dll | 2019.150.4420.2 | 239656 | 25-Jan-2025 | 12:56 | x64 |
| Txrowcount.dll | 2019.150.4420.2 | 112712 | 25-Jan-2025 | 12:56 | x86 |
| Txrowcount.dll | 2019.150.4420.2 | 141376 | 25-Jan-2025 | 12:56 | x64 |
| Txsampling.dll | 2019.150.4420.2 | 157760 | 25-Jan-2025 | 12:56 | x86 |
| Txsampling.dll | 2019.150.4420.2 | 194640 | 25-Jan-2025 | 12:56 | x64 |
| Txscd.dll | 2019.150.4420.2 | 198712 | 25-Jan-2025 | 12:56 | x86 |
| Txscd.dll | 2019.150.4420.2 | 235584 | 25-Jan-2025 | 12:56 | x64 |
| Txsort.dll | 2019.150.4420.2 | 231464 | 25-Jan-2025 | 12:56 | x86 |
| Txsort.dll | 2019.150.4420.2 | 288832 | 25-Jan-2025 | 12:56 | x64 |
| Txsplit.dll | 2019.150.4420.2 | 550952 | 25-Jan-2025 | 12:56 | x86 |
| Txsplit.dll | 2019.150.4420.2 | 624680 | 25-Jan-2025 | 12:56 | x64 |
| Txtermextraction.dll | 2019.150.4420.2 | 8644648 | 25-Jan-2025 | 12:56 | x86 |
| Txtermextraction.dll | 2019.150.4420.2 | 8701992 | 25-Jan-2025 | 12:56 | x64 |
| Txtermlookup.dll | 2019.150.4420.2 | 4139064 | 25-Jan-2025 | 12:56 | x86 |
| Txtermlookup.dll | 2019.150.4420.2 | 4184104 | 25-Jan-2025 | 12:56 | x64 |
| Txunionall.dll | 2019.150.4420.2 | 161856 | 25-Jan-2025 | 12:56 | x86 |
| Txunionall.dll | 2019.150.4420.2 | 198696 | 25-Jan-2025 | 12:56 | x64 |
| Txunpivot.dll | 2019.150.4420.2 | 182328 | 25-Jan-2025 | 12:56 | x86 |
| Txunpivot.dll | 2019.150.4420.2 | 215104 | 25-Jan-2025 | 12:56 | x64 |
| Xe.dll | 2019.150.4420.2 | 632872 | 25-Jan-2025 | 12:56 | x86 |
| Xe.dll | 2019.150.4420.2 | 718912 | 25-Jan-2025 | 12:56 | x64 |

SQL Server 2019 sql_polybase_core_inst

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Dms.dll | 15.0.1978.0 | 559696 | 25-Jan-2025 | 13:27 | x86 |
| Dmsnative.dll | 2018.150.1978.0 | 152624 | 25-Jan-2025 | 13:27 | x64 |
| Dwengineservice.dll | 15.0.1978.0 | 45120 | 25-Jan-2025 | 13:27 | x86 |
| Eng\_polybase\_odbcdrivermongo\_2321\_mongodbodbc\_sb64\_dll.64 | 2.3.21.1023 | 18691056 | 25-Jan-2025 | 13:27 | x64 |
| Eng\_polybase\_odbcdrivermongo\_2321\_saslsspi\_dll.64 | 1.0.2.1003 | 147504 | 25-Jan-2025 | 13:27 | x64 |
| Eng\_polybase\_odbcdrivermongo\_238\_mongodbodbc\_sb64\_dll.64 | 2.3.8.1008 | 17142672 | 25-Jan-2025 | 13:27 | x64 |
| Eng\_polybase\_odbcdrivermongo\_238\_saslsspi\_dll.64 | 1.0.2.1003 | 146304 | 25-Jan-2025 | 13:27 | x64 |
| Eng\_polybase\_odbcdriveroracle\_802\_mscurl28\_dll.64 | 8.0.2.304 | 2532096 | 25-Jan-2025 | 13:27 | x64 |
| Eng\_polybase\_odbcdriveroracle\_802\_msora28\_dll.64 | 8.0.2.2592 | 2425088 | 25-Jan-2025 | 13:27 | x64 |
| Eng\_polybase\_odbcdriveroracle\_802\_msora28r\_dll.64 | 8.0.2.2592 | 151808 | 25-Jan-2025 | 13:27 | x64 |
| Eng\_polybase\_odbcdriveroracle\_802\_msssl28\_dll.64 | 8.0.2.244 | 2416384 | 25-Jan-2025 | 13:27 | x64 |
| Eng\_polybase\_odbcdriveroracle\_802\_mstls28\_dll.64 | 8.0.2.216 | 2953472 | 25-Jan-2025 | 13:27 | x64 |
| Icudt58.dll | 58.2.0.0 | 27109768 | 25-Jan-2025 | 13:27 | x64 |
| Icudt58.dll | 58.3.0.0 | 27110344 | 25-Jan-2025 | 13:27 | x64 |
| Icudt58.dll | 58.2.0.0 | 27109832 | 25-Jan-2025 | 13:27 | x64 |
| Icudt58.dll | 58.3.0.0 | 27110344 | 25-Jan-2025 | 13:27 | x64 |
| Icuin58.dll | 58.2.0.0 | 2431880 | 25-Jan-2025 | 13:27 | x64 |
| Icuin58.dll | 58.3.0.0 | 2551752 | 25-Jan-2025 | 13:27 | x64 |
| Icuin58.dll | 58.2.0.0 | 2425288 | 25-Jan-2025 | 13:27 | x64 |
| Icuin58.dll | 58.3.0.0 | 2562504 | 25-Jan-2025 | 13:27 | x64 |
| Icuuc42.dll | 8.0.2.124 | 15491840 | 25-Jan-2025 | 13:27 | x64 |
| Icuuc58.dll | 58.2.0.0 | 1783688 | 25-Jan-2025 | 13:27 | x64 |
| Icuuc58.dll | 58.3.0.0 | 1888712 | 25-Jan-2025 | 13:27 | x64 |
| Icuuc58.dll | 58.2.0.0 | 1775048 | 25-Jan-2025 | 13:27 | x64 |
| Icuuc58.dll | 58.3.0.0 | 1924040 | 25-Jan-2025 | 13:27 | x64 |
| Instapi150.dll | 2019.150.4420.2 | 88104 | 25-Jan-2025 | 13:27 | x64 |
| Libcrypto-1\_1-x64.dll | 1.1.0.10 | 2620304 | 25-Jan-2025 | 13:27 | x64 |
| Libcrypto | 1.1.1.4 | 2953680 | 25-Jan-2025 | 13:27 | x64 |
| Libcrypto | 1.1.1.14 | 4085336 | 25-Jan-2025 | 13:27 | x64 |
| Libcrypto | 1.1.1.11 | 4321232 | 25-Jan-2025 | 13:27 | x64 |
| Libsasl.dll | 2.1.26.0 | 292224 | 25-Jan-2025 | 13:27 | x64 |
| Libsasl.dll | 2.1.26.0 | 521664 | 25-Jan-2025 | 13:27 | x64 |
| Libssl-1\_1-x64.dll | 1.1.0.10 | 648080 | 25-Jan-2025 | 13:27 | x64 |
| Libssl | 1.1.1.14 | 1195600 | 25-Jan-2025 | 13:27 | x64 |
| Libssl | 1.1.1.4 | 798160 | 25-Jan-2025 | 13:27 | x64 |
| Libssl | 1.1.1.11 | 1322960 | 25-Jan-2025 | 13:27 | x64 |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll | 15.0.1978.0 | 67664 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.catalog.dll | 15.0.1978.0 | 293456 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.common.dll | 15.0.1978.0 | 1957944 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.configuration.dll | 15.0.1978.0 | 169544 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll | 15.0.1978.0 | 649824 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll | 15.0.1978.0 | 246352 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll | 15.0.1978.0 | 139312 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1978.0 | 79968 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll | 15.0.1978.0 | 51280 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.distributor.dll | 15.0.1978.0 | 88632 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.engine.dll | 15.0.1978.0 | 1129520 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll | 15.0.1978.0 | 80944 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.eventing.dll | 15.0.1978.0 | 70712 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll | 15.0.1978.0 | 35424 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll | 15.0.1978.0 | 31296 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll | 15.0.1978.0 | 46664 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll | 15.0.1978.0 | 21560 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.failover.dll | 15.0.1978.0 | 26704 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll | 15.0.1978.0 | 131632 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll | 15.0.1978.0 | 86584 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll | 15.0.1978.0 | 100912 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.dll | 15.0.1978.0 | 293456 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 120384 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 138296 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 141360 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 137776 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 150584 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 139840 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 134720 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 176720 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 117816 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 136752 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.nodes.dll | 15.0.1978.0 | 72760 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll | 15.0.1978.0 | 22096 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll | 15.0.1978.0 | 37472 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll | 15.0.1978.0 | 129104 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.dll | 15.0.1978.0 | 3064912 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll | 15.0.1978.0 | 3955760 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 118368 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 133216 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 137784 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 133688 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 148544 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 134192 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 130656 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 171056 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 115280 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 132168 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll | 15.0.1978.0 | 67640 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll | 15.0.1978.0 | 2682928 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.datawarehouse.utilities.dll | 15.0.1978.0 | 2436656 | 25-Jan-2025 | 13:27 | x86 |
| Microsoft.sqlserver.xe.core.dll | 2019.150.4420.2 | 83992 | 25-Jan-2025 | 13:27 | x64 |
| Microsoft.sqlserver.xevent.configuration.dll | 2019.150.4420.2 | 178216 | 25-Jan-2025 | 13:27 | x64 |
| Microsoft.sqlserver.xevent.dll | 2019.150.4420.2 | 194616 | 25-Jan-2025 | 13:27 | x64 |
| Mpdwinterop.dll | 2019.150.4420.2 | 452688 | 25-Jan-2025 | 13:27 | x64 |
| Mpdwsvc.exe | 2019.150.4420.2 | 7407680 | 25-Jan-2025 | 13:27 | x64 |
| Msodbcsql17.dll | 2017.174.1.1 | 2016120 | 25-Jan-2025 | 13:27 | x64 |
| Odbc32.dll | 10.0.17763.1 | 720792 | 25-Jan-2025 | 13:27 | x64 |
| Odbccp32.dll | 10.0.17763.1 | 138136 | 25-Jan-2025 | 13:27 | x64 |
| Odbctrac.dll | 10.0.17763.1 | 175000 | 25-Jan-2025 | 13:27 | x64 |
| Saslplain.dll | 2.1.26.0 | 170880 | 25-Jan-2025 | 13:27 | x64 |
| Saslplain.dll | 2.1.26.0 | 377792 | 25-Jan-2025 | 13:27 | x64 |
| Secforwarder.dll | 2019.150.4420.2 | 79944 | 25-Jan-2025 | 13:27 | x64 |
| Sharedmemory.dll | 2018.150.1978.0 | 61488 | 25-Jan-2025 | 13:27 | x64 |
| Sqldk.dll | 2019.150.4420.2 | 3180624 | 25-Jan-2025 | 13:27 | x64 |
| Sqldumper.exe | 2019.150.4420.2 | 378920 | 25-Jan-2025 | 13:27 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 1599568 | 25-Jan-2025 | 13:23 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 4175944 | 25-Jan-2025 | 13:23 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 3422248 | 25-Jan-2025 | 13:23 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 4167752 | 25-Jan-2025 | 13:23 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 4073536 | 25-Jan-2025 | 13:23 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 2226248 | 25-Jan-2025 | 13:23 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 2177096 | 25-Jan-2025 | 13:23 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 3831880 | 25-Jan-2025 | 13:23 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 3827752 | 25-Jan-2025 | 13:23 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 1542224 | 25-Jan-2025 | 13:23 | x64 |
| Sqlevn70.rll | 2019.150.4420.2 | 4040784 | 25-Jan-2025 | 13:23 | x64 |
| Sqlncli17e.dll | 2017.1710.6.1 | 1898520 | 25-Jan-2025 | 13:27 | x64 |
| Sqlos.dll | 2019.150.4420.2 | 43048 | 25-Jan-2025 | 13:27 | x64 |
| Sqlsortpdw.dll | 2018.150.1978.0 | 4841536 | 25-Jan-2025 | 13:27 | x64 |
| Sqltses.dll | 2019.150.4420.2 | 9119784 | 25-Jan-2025 | 13:27 | x64 |
| Tdataodbc\_sb | 17.0.0.27 | 12914640 | 25-Jan-2025 | 13:27 | x64 |
| Tdataodbc\_sb | 16.20.0.1078 | 14995920 | 25-Jan-2025 | 13:27 | x64 |
| Terasso.dll | 16.20.0.13 | 2158896 | 25-Jan-2025 | 13:27 | x64 |
| Terasso.dll | 17.0.0.28 | 2357064 | 25-Jan-2025 | 13:27 | x64 |
| Zlibwapi.dll | 1.2.11.0 | 281472 | 25-Jan-2025 | 13:27 | x64 |
| Zlibwapi.dll | 1.2.11.0 | 499248 | 25-Jan-2025 | 13:27 | x64 |

SQL Server 2019 sql_shared_mr

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Smrdll.dll | 15.0.4420.2 | 30800 | 25-Jan-2025 | 12:56 | x86 |

SQL Server 2019 sql_tools_extensions

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Autoadmin.dll | 2019.150.4420.2 | 1632336 | 25-Jan-2025 | 13:45 | x86 |
| Dtaengine.exe | 2019.150.4420.2 | 219176 | 25-Jan-2025 | 13:45 | x86 |
| Dteparse.dll | 2019.150.4420.2 | 124984 | 25-Jan-2025 | 13:45 | x64 |
| Dteparse.dll | 2019.150.4420.2 | 112696 | 25-Jan-2025 | 13:45 | x86 |
| Dteparsemgd.dll | 2019.150.4420.2 | 133176 | 25-Jan-2025 | 13:45 | x64 |
| Dteparsemgd.dll | 2019.150.4420.2 | 116776 | 25-Jan-2025 | 13:45 | x86 |
| Dtepkg.dll | 2019.150.4420.2 | 149544 | 25-Jan-2025 | 13:45 | x64 |
| Dtepkg.dll | 2019.150.4420.2 | 133160 | 25-Jan-2025 | 13:45 | x86 |
| Dtexec.exe | 2019.150.4420.2 | 73784 | 25-Jan-2025 | 13:45 | x64 |
| Dtexec.exe | 2019.150.4420.2 | 65064 | 25-Jan-2025 | 13:45 | x86 |
| Dts.dll | 2019.150.4420.2 | 3143760 | 25-Jan-2025 | 13:45 | x64 |
| Dts.dll | 2019.150.4420.2 | 2762768 | 25-Jan-2025 | 13:45 | x86 |
| Dtscomexpreval.dll | 2019.150.4420.2 | 501840 | 25-Jan-2025 | 13:45 | x64 |
| Dtscomexpreval.dll | 2019.150.4420.2 | 444480 | 25-Jan-2025 | 13:45 | x86 |
| Dtsconn.dll | 2019.150.4420.2 | 522320 | 25-Jan-2025 | 13:45 | x64 |
| Dtsconn.dll | 2019.150.4420.2 | 432192 | 25-Jan-2025 | 13:45 | x86 |
| Dtshost.exe | 2019.150.4420.2 | 107560 | 25-Jan-2025 | 13:45 | x64 |
| Dtshost.exe | 2019.150.4420.2 | 89640 | 25-Jan-2025 | 13:45 | x86 |
| Dtsmsg150.dll | 2019.150.4420.2 | 567352 | 25-Jan-2025 | 13:45 | x64 |
| Dtsmsg150.dll | 2019.150.4420.2 | 555088 | 25-Jan-2025 | 13:45 | x86 |
| Dtspipeline.dll | 2019.150.4420.2 | 1329192 | 25-Jan-2025 | 13:45 | x64 |
| Dtspipeline.dll | 2019.150.4420.2 | 1120296 | 25-Jan-2025 | 13:45 | x86 |
| Dtswizard.exe | 15.0.4420.2 | 886848 | 25-Jan-2025 | 13:45 | x64 |
| Dtswizard.exe | 15.0.4420.2 | 890936 | 25-Jan-2025 | 13:45 | x86 |
| Dtuparse.dll | 2019.150.4420.2 | 100424 | 25-Jan-2025 | 13:45 | x64 |
| Dtuparse.dll | 2019.150.4420.2 | 88104 | 25-Jan-2025 | 13:45 | x86 |
| Dtutil.exe | 2019.150.4420.2 | 151080 | 25-Jan-2025 | 13:45 | x64 |
| Dtutil.exe | 2019.150.4420.2 | 130616 | 25-Jan-2025 | 13:45 | x86 |
| Exceldest.dll | 2019.150.4420.2 | 280616 | 25-Jan-2025 | 13:45 | x64 |
| Exceldest.dll | 2019.150.4420.2 | 235560 | 25-Jan-2025 | 13:45 | x86 |
| Excelsrc.dll | 2019.150.4420.2 | 309320 | 25-Jan-2025 | 13:45 | x64 |
| Excelsrc.dll | 2019.150.4420.2 | 260160 | 25-Jan-2025 | 13:45 | x86 |
| Flatfiledest.dll | 2019.150.4420.2 | 358480 | 25-Jan-2025 | 13:45 | x86 |
| Flatfiledest.dll | 2019.150.4420.2 | 411688 | 25-Jan-2025 | 13:45 | x64 |
| Flatfilesrc.dll | 2019.150.4420.2 | 370768 | 25-Jan-2025 | 13:45 | x86 |
| Flatfilesrc.dll | 2019.150.4420.2 | 428072 | 25-Jan-2025 | 13:45 | x64 |
| Microsoft.sqlserver.astasks.dll | 15.0.4420.2 | 116776 | 25-Jan-2025 | 13:45 | x86 |
| Microsoft.sqlserver.chainer.infrastructure.dll | 15.0.4420.2 | 403536 | 25-Jan-2025 | 13:45 | x86 |
| Microsoft.sqlserver.chainer.infrastructure.dll | 15.0.4420.2 | 403520 | 25-Jan-2025 | 13:45 | x86 |
| Microsoft.sqlserver.configuration.sco.dll | 15.0.4420.2 | 3004480 | 25-Jan-2025 | 13:45 | x86 |
| Microsoft.sqlserver.configuration.sco.dll | 15.0.4420.2 | 3004456 | 25-Jan-2025 | 13:45 | x86 |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4420.2 | 43072 | 25-Jan-2025 | 13:45 | x86 |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4420.2 | 43088 | 25-Jan-2025 | 13:45 | x86 |
| Microsoft.sqlserver.management.integrationservicesenum.dll | 15.0.4420.2 | 59432 | 25-Jan-2025 | 13:45 | x86 |
| Microsoft.sqlserver.olapenum.dll | 15.0.18185.0 | 100800 | 25-Jan-2025 | 13:45 | x86 |
| Microsoft.sqlserver.xevent.configuration.dll | 2019.150.4420.2 | 178216 | 25-Jan-2025 | 13:45 | x64 |
| Microsoft.sqlserver.xevent.configuration.dll | 2019.150.4420.2 | 157768 | 25-Jan-2025 | 13:45 | x86 |
| Microsoft.sqlserver.xevent.dll | 2019.150.4420.2 | 194616 | 25-Jan-2025 | 13:45 | x64 |
| Microsoft.sqlserver.xevent.dll | 2019.150.4420.2 | 174144 | 25-Jan-2025 | 13:45 | x86 |
| Msdtssrvrutil.dll | 2019.150.4420.2 | 112680 | 25-Jan-2025 | 13:45 | x64 |
| Msdtssrvrutil.dll | 2019.150.4420.2 | 100408 | 25-Jan-2025 | 13:45 | x86 |
| Msmgdsrv.dll | 2018.150.35.51 | 8280112 | 25-Jan-2025 | 13:45 | x86 |
| Oledbdest.dll | 2019.150.4420.2 | 239656 | 25-Jan-2025 | 13:45 | x86 |
| Oledbdest.dll | 2019.150.4420.2 | 280616 | 25-Jan-2025 | 13:45 | x64 |
| Oledbsrc.dll | 2019.150.4420.2 | 264232 | 25-Jan-2025 | 13:45 | x86 |
| Oledbsrc.dll | 2019.150.4420.2 | 313408 | 25-Jan-2025 | 13:45 | x64 |
| Sqlresourceloader.dll | 2019.150.4420.2 | 51280 | 25-Jan-2025 | 13:45 | x64 |
| Sqlresourceloader.dll | 2019.150.4420.2 | 38952 | 25-Jan-2025 | 13:45 | x86 |
| Sqlscm.dll | 2019.150.4420.2 | 88128 | 25-Jan-2025 | 13:45 | x64 |
| Sqlscm.dll | 2019.150.4420.2 | 79928 | 25-Jan-2025 | 13:45 | x86 |
| Sqlsvc.dll | 2019.150.4420.2 | 182328 | 25-Jan-2025 | 13:45 | x64 |
| Sqlsvc.dll | 2019.150.4420.2 | 149544 | 25-Jan-2025 | 13:45 | x86 |
| Sqltaskconnections.dll | 2019.150.4420.2 | 202832 | 25-Jan-2025 | 13:45 | x64 |
| Sqltaskconnections.dll | 2019.150.4420.2 | 170024 | 25-Jan-2025 | 13:45 | x86 |
| Txdataconvert.dll | 2019.150.4420.2 | 276552 | 25-Jan-2025 | 13:45 | x86 |
| Txdataconvert.dll | 2019.150.4420.2 | 317480 | 25-Jan-2025 | 13:45 | x64 |
| Xe.dll | 2019.150.4420.2 | 632872 | 25-Jan-2025 | 13:45 | x86 |
| Xe.dll | 2019.150.4420.2 | 718912 | 25-Jan-2025 | 13:45 | x64 |

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2019.

</details>

<details>
<summary><b>Restart information</b></summary>

You might have to restart the computer after you apply this cumulative update package.

</details>

<details>
<summary><b>Registry information</b></summary>

To use one of the hotfixes in this package, you don't have to make any changes to the registry.

</details>

<details>
<summary><b>Important notices</b></summary>

This article also provides the following important information.

### Analysis Services CU build version

Beginning in Microsoft SQL Server 2017, the Analysis Services build version number and SQL Server Database Engine build version number don't match. For more information, see [Verify Analysis Services cumulative update build version](/sql/analysis-services/instances/analysis-services-component-version).

### Cumulative updates (CU)

- Each new CU contains all the fixes that were included with the previous CU for the installed version of SQL Server.
- SQL Server CUs are certified to the same levels as service packs, and should be installed at the same level of confidence.
- We recommend ongoing, proactive installation of CUs as they become available according to these guidelines:
  - Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU.
  - CUs might contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
- We recommend that you test SQL Server CUs before you deploy them to production environments.

</details>

<details>
<summary><b>Hybrid environment deployment</b></summary>

When you deploy an update to a hybrid environment (such as Always On, replication, cluster, and mirroring), we recommend that you refer to the following articles before you deploy the update:

- [Upgrade a failover cluster instance](/sql/sql-server/failover-clusters/windows/upgrade-a-sql-server-failover-cluster-instance)

    > [!NOTE]
    > If you don't want to use the rolling update process, follow these steps to apply an update:
    >
    > - Install the update on the passive node.
    > - Install the update on the active node (requires a service restart).

- [Upgrade and update of availability group servers that use minimal downtime and data loss](/sql/database-engine/availability-groups/windows/upgrading-always-on-availability-group-replica-instances)

  > [!NOTE]
  > If you enabled Always On together with the **SSISDB** catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) about how to apply an update in these environments.

- [How to apply a hotfix for SQL Server in a transactional replication and database mirroring topology](../../database-engine/replication/install-service-packs-hotfixes.md)
- [How to apply a hotfix for SQL Server in a replication topology](../../database-engine/replication/apply-hotfix-sql-replication-topology.md)
- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances)
- [Overview of SQL Server Servicing Installation](/sql/database-engine/install-windows/install-sql-server-servicing-updates)

</details>

<details>
<summary><b>Language support</b></summary>

SQL Server CUs are currently multilingual. Therefore, this CU package isn't specific to one language. It applies to all supported languages.

</details>

<details>
<summary><b>Components (features) updated</b></summary>

One CU package includes all available updates for all SQL Server 2019 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
</details>

## How to uninstall this update

<details>
<summary><b>How to uninstall this update on Windows</b></summary>

1. In Control Panel, open the **Programs and Features** item, and then select **View installed updates**.
1. Locate the entry that corresponds to this cumulative update package under **SQL Server 2019**.
1. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

<details>
<summary><b>How to uninstall this update on Linux</b></summary>

To uninstall this CU on Linux, you must roll back the package to the previous version. For more information about how to roll back the installation, see [Rollback SQL Server](/sql/linux/sql-server-linux-setup#rollback).

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [SQL Server Service Packs are no longer supported starting from SQL Server 2017](https://support.microsoft.com/topic/fd405dee-cae7-b40f-db14-01e3e4951169)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
