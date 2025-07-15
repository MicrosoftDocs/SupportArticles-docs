---
title: Cumulative update 15 for SQL Server 2022 (KB5041321)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 15 (KB5041321).
ms.date: 05/30/2025
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5041321
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5041321 - Cumulative Update 15 for SQL Server 2022

_Release Date:_ &nbsp; September 25, 2024  
_Version:_ &nbsp; 16.0.4145.4

## Summary

This article describes Cumulative Update package 15 (CU15) for Microsoft SQL Server 2022. This update contains 14 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 14, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4145.4**, file version: **2022.160.4145.4**
- Analysis Services - Product version: **16.0.43.233**, file version: **2022.160.43.233**

## Known issues in this update

### Issue one: Patching error for secondary replicas in an availability group with databases enabled replication or CDC

[!INCLUDE [patching-error-2022](../includes/patching-error-2022.md)]

### Issue two: Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description| Fix area | Component | Platform |
|------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|-------------------------------------------|----------|
| <a id=3285880>[3285880](#3285880) </a> | Fixes a domain account authentication issue in the configuration tool by adding an auto-retry method to the account validation part, which will use the **UPN** format and try to authenticate using three separate authentication methods after the authentication fails in **SAM** format and default. | Master Data Services | Master Data Services| Windows|
| <a id=3354272>[3354272](#3354272) </a> | Updates the criterion for determining the current machine type and the judgment conditions of whether it is a domain controller. | Master Data Services | Master Data Services| Windows|
| <a id=3459086>[3459086](#3459086) </a> | Fixes an issue in which the SQL Server Volume Shadow Copy Service (VSS) Writer can't freeze the database during a VSS-based backup. For more information, see [known issue two of SQL Server 2022 CU14](cumulativeupdate14.md#issue-two-sql-server-vss-writer-might-fail-to-perform-a-backup-because-no-database-is-available-to-freeze). | SQL Server Engine| Backup Restore | Windows|
| <a id=3287656>[3287656](#3287656) </a> | Fixes an assertion failure (Location: ListenerSpec.cpp:480; Expression: totalUsed + cbListenerName <= cbObj) that you encounter when creating a [distributed availability group (DAG)](/sql/database-engine/availability-groups/windows/distributed-availability-groups) and incorrectly specifying the number of availability groups in it to be other than two.| SQL Server Engine| High Availability and Disaster Recovery | All|
| <a id=3301982>[3301982](#3301982) </a> | Fixes an assertion failure (Location: MetadataVersion.cpp:71; Expression: !CFeatureSwitchesMin::GetCurrentInstance()->FEntityVerStoreCsnCheckEnabled() \|\| newInfo != InvalidXts()) that you encounter when you try to change the database owner on a readable secondary replica of an Always On availability group.| SQL Server Engine| Metadata| All|
| <a id=3338395>[3338395](#3338395) </a> | Fixes an issue in which PolyBase throws the following error at service startup if the SQL Server instance is configured to listen on multiple TCP ports: </br></br>System.ArgumentException: Unable to parse port, instance = '\<InstanceName>', text = '\<Text>'| SQL Server Engine| PolyBase| All|
| <a id=3101865>[3101865](#3101865) </a> | Adds a validation for the `MODEL` parameter when running `PREDICT` to avoid errors due to the input of wrong models.| SQL Server Engine| Query Execution| All|
| <a id=3181615>[3181615](#3181615) </a> | Adds a new security feature to implement change data capture (CDC) metadata data definition language (DDL) lockdown, preventing errors that might occur when running `sp_cdc_vupgrade` against a database with CDC disabled. | SQL Server Engine| Replication | All|
| <a id=3338274>[3338274](#3338274) </a> | Fixes the following error 21890 that you encounter when you use the case-sensitive collation and run `sp_validate_redirected_publisher`: </br></br>The SQL Server instance '\<InstanceName>' with distributor '\<DistributorName>' and distribution database '\<DatabaseName>' cannot be used with publisher database '\<DatabaseName>'. Reconfigure the publisher to make use of distributor '\<DistributorName>' and distribution database '\<DatabaseName>'.| SQL Server Engine| Replication | All|
| <a id=3362871>[3362871](#3362871) </a> | Fixes an issue with checkpoint operation in which the following error 2601 occurs when SQL Server tries to perform a checkpoint operation on the database that has change tracking enabled: </br></br>\<DateTime> Error: 2601, Severity: 14, State: 1. </br>\<DateTime> Cannot insert duplicate key row in object '\<ObjectName>' with unique index '\<IndexName>'. The duplicate key value is \<KeyValue>.  | SQL Server Engine| Replication | All|
| <a id=3394373>[3394373](#3394373) </a> | Fixes an issue in which error 18752 occurs and transactional replication stops working when you use a heavy workload in combination with availability groups and after a failover occurs. </br></br>Error message: </br></br>Only one Log Reader Agent or log-related procedure (sp_repldone, sp_replcmds, and sp_replshowcmds) can connect to a database at a time. If you executed a log-related procedure, drop the connection with session ID \<SessionID> over which the procedure was executed or execute sp_replflush over that connection before starting the Log Reader Agent or executing another log-related procedure. | SQL Server Engine| Replication | Windows|
| <a id=3325413>[3325413](#3325413) </a> | Before the fix, the SQL Server error log records many messages regarding starting or stopping Extended Events (XEvents) sessions. After applying the fix, starting or stopping XEvents sessions isn't logged by default. You can enable it by turning trace flag 9714 on. | SQL Server Engine| Storage Management| All|
| <a id=3409327>[3409327](#3409327) </a> | Fixes an issue in which table and column names that are read from database metadata aren't correctly quoted in some cases when building internal SQL Server batches in stored procedures that manage temporal tables. After applying the fix, quoting is completed correctly.| SQL Server Engine| Temporal| All|
| <a id=2862558>[2862558](#2862558) </a> | Fixes the slowness of `RESTORE WITH STANDBY` operations that you encounter when accelerated database recovery (ADR) isn't enabled. | SQL Server Engine| Transaction Services| All|

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?id=105013)

> [!NOTE]
>
> - Microsoft Download Center will always offer the latest SQL Server 2022 CU release.
> - If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU15 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5041321)

> [!NOTE]
>
> - [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202022) contains this SQL Server 2022 CU and previously released SQL Server 2022 CU releases.
> - This CU is also available through Windows Server Update Services (WSUS).
> - We recommend that you always install the latest cumulative update that is available.

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2022 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2022 Release Notes](/sql/linux/sql-server-linux-release-notes-2022).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2022-KB5041321-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5041321-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5041321-x64.exe| 758EE805FAA130028085114FB2BCE215765EE10C9648DDB80DAB40FD8D6AE51A  |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

|                      File name                      |   File version  | File size |     Date    |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Anglesharp.dll                                      | 0.9.9.0         | 1240112   | 19-Sep-2024 | 08:59 | x86      |
| Asplatformhost.dll                                  | 2022.160.43.233 | 336944    | 19-Sep-2024 | 08:59 | x64      |
| Mashupcompression.dll                               | 2.127.602.0     | 141760    | 19-Sep-2024 | 08:59 | x64      |
| Microsoft.analysisservices.minterop.dll             | 16.0.43.233     | 865216    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.233     | 2903488   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.edm.netfx35.dll                      | 5.7.0.62516     | 661936    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.mashup.dll                           | 2.127.602.0     | 224184    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.mashup.oledb.dll                     | 2.127.602.0     | 32192     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.mashup.preview.dll                   | 2.127.602.0     | 153528    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.mashup.providercommon.dll            | 2.127.602.0     | 113088    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 38832     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42928     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 33216     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 47040     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42928     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 47024     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 38832     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.127.602.0     | 25536     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.odata.netfx35.dll                    | 5.7.0.62516     | 1455536   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.odata.query.netfx35.dll              | 5.7.0.62516     | 182200    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.sapclient.dll                        | 1.0.0.25        | 931680    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 35200     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 36704     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 37216     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 39808     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 49024     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.sqlclient.dll                        | 2.17.23292.1    | 1997744   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.sqlclient.sni.dll                    | 2.1.1.0         | 511920    | 19-Sep-2024 | 08:59 | x64      |
| Microsoft.dataintegration.fuzzyclustering.dll       | 1.0.0.0         | 40368     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.dataintegration.fuzzymatching.dll         | 1.0.0.0         | 628144    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.dataintegration.fuzzymatchingcommon.dll   | 1.0.0.0         | 390064    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.exchange.webservices.dll                  | 15.0.913.15     | 1124272   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.hostintegration.connectors.dll            | 2.127.602.0     | 4964800   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.identity.client.dll                       | 4.57.0.0        | 1653680   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 6.35.0.41201    | 111536    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.identitymodel.logging.dll                 | 6.35.0.41201    | 38320     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.identitymodel.protocols.dll               | 6.35.0.41201    | 39856     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 6.35.0.41201    | 114096    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 6.35.0.41201    | 992192    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.cdm.icdmprovider.dll               | 2.127.602.0     | 21952     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.container.exe                      | 2.127.602.0     | 25024     | 19-Sep-2024 | 08:59 | x64      |
| Microsoft.mashup.container.netfx40.exe              | 2.127.602.0     | 24000     | 19-Sep-2024 | 08:59 | x64      |
| Microsoft.mashup.container.netfx45.exe              | 2.127.602.0     | 23992     | 19-Sep-2024 | 08:59 | x64      |
| Microsoft.mashup.eventsource.dll                    | 2.127.602.0     | 150448    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oauth.dll                          | 2.127.602.0     | 94144     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 15808     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16320     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16312     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16816     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 17344     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 15792     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oledbinterop.dll                   | 2.127.602.0     | 201144    | 19-Sep-2024 | 08:59 | x64      |
| Microsoft.mashup.oledbprovider.dll                  | 2.127.602.0     | 67008     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14264     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.sapbwprovider.dll                  | 2.127.602.0     | 334256    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.scriptdom.dll                      | 2.40.4554.261   | 2365872   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.shims.dll                          | 2.127.602.0     | 29616     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll         | 1.0.0.0         | 141248    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.dll                          | 2.127.602.0     | 15941040  | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.library45.dll                | 2.127.602.0     | 7617472   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39360     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 35872     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 36288     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39856     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39872     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 40368     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 40888     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 42424     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 47024     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 620464    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 747448    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 739248    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 718776    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 776128    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 726960    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 702384    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 980912    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 612272    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 714672    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.mshtml.dll                                | 7.0.3300.1      | 8017840   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.odata.core.netfx35.dll                    | 6.15.0.0        | 1438656   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.odata.core.netfx35.v7.dll                 | 7.4.0.11102     | 1262000   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.odata.edm.netfx35.dll                     | 6.15.0.0        | 779712    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.odata.edm.netfx35.v7.dll                  | 7.4.0.11102     | 745920    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.powerbi.adomdclient.dll                   | 16.0.122.20     | 1216944   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.spatial.netfx35.dll                       | 6.15.0.0        | 127408    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.spatial.netfx35.v7.dll                    | 7.4.0.11102     | 125368    | 19-Sep-2024 | 08:59 | x86      |
| Msmdctr.dll                                         | 2022.160.43.233 | 38864     | 19-Sep-2024 | 08:59 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.233 | 53976120  | 19-Sep-2024 | 08:59 | x86      |
| Msmdlocal.dll                                       | 2022.160.43.233 | 71818688  | 19-Sep-2024 | 08:59 | x64      |
| Msmdpump.dll                                        | 2022.160.43.233 | 10333744  | 19-Sep-2024 | 08:59 | x64      |
| Msmdredir.dll                                       | 2022.160.43.233 | 8132032   | 19-Sep-2024 | 08:59 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.233 | 71367216  | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 956992    | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1884720   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1671728   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1881152   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1848360   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1147440   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1140280   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1769520   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1749040   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 932912    | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1837616   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 955456    | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1882672   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1668656   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1876528   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1844784   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1145392   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1138752   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1765440   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1745456   | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 933424    | 19-Sep-2024 | 08:59 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1833008   | 19-Sep-2024 | 08:59 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.233 | 10083392  | 19-Sep-2024 | 08:59 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.233 | 8265280   | 19-Sep-2024 | 08:59 | x86      |
| Msolap.dll                                          | 2022.160.43.233 | 10969648  | 19-Sep-2024 | 08:59 | x64      |
| Msolap.dll                                          | 2022.160.43.233 | 8743880   | 19-Sep-2024 | 08:59 | x86      |
| Msolui.dll                                          | 2022.160.43.233 | 289840    | 19-Sep-2024 | 08:59 | x86      |
| Msolui.dll                                          | 2022.160.43.233 | 308264    | 19-Sep-2024 | 08:59 | x64      |
| Newtonsoft.json.dll                                 | 13.0.3.27908    | 722264    | 19-Sep-2024 | 08:59 | x86      |
| Parquetsharp.dll                                    | 0.0.0.0         | 412592    | 19-Sep-2024 | 08:59 | x64      |
| Parquetsharpnative.dll                              | 7.0.0.17        | 20091320  | 19-Sep-2024 | 08:59 | x64      |
| Powerbiextensions.dll                               | 2.127.602.0     | 11111344  | 19-Sep-2024 | 08:59 | x86      |
| Private_odbc32.dll                                  | 10.0.19041.1    | 735288    | 19-Sep-2024 | 08:59 | x64      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 19-Sep-2024 | 08:59 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4145.4 | 137296    | 19-Sep-2024 | 08:59 | x64      |
| Sqlceip.exe                                         | 16.0.4145.4     | 301008    | 19-Sep-2024 | 08:59 | x86      |
| Sqldumper.exe                                       | 2022.160.4145.4 | 378920    | 19-Sep-2024 | 08:59 | x86      |
| Sqldumper.exe                                       | 2022.160.4145.4 | 448592    | 19-Sep-2024 | 08:59 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 6.35.0.41201    | 77248     | 19-Sep-2024 | 08:59 | x86      |
| System.spatial.netfx35.dll                          | 5.7.0.62516     | 118704    | 19-Sep-2024 | 08:59 | x86      |
| Tmapi.dll                                           | 2022.160.43.233 | 5884480   | 19-Sep-2024 | 08:59 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.233 | 5575216   | 19-Sep-2024 | 08:59 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.233 | 1481264   | 19-Sep-2024 | 08:59 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.233 | 7198264   | 19-Sep-2024 | 08:59 | x64      |
| Xmsrv.dll                                           | 2022.160.43.233 | 26593232  | 19-Sep-2024 | 08:59 | x64      |
| Xmsrv.dll                                           | 2022.160.43.233 | 35895856  | 19-Sep-2024 | 08:59 | x86      |

SQL Server 2022 Database Services Common Core

|                  File name                 |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4145.4 | 104488    | 19-Sep-2024 | 08:59 | x64      |
| Instapi150.dll                             | 2022.160.4145.4 | 79936     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.233     | 2633784   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.233     | 2633776   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.233     | 2933296   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.233     | 2323520   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4145.4 | 104488    | 19-Sep-2024 | 08:59 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4145.4 | 92200     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4145.4     | 555072    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4145.4     | 555088    | 19-Sep-2024 | 08:59 | x86      |
| Msasxpress.dll                             | 2022.160.43.233 | 27696     | 19-Sep-2024 | 08:59 | x86      |
| Msasxpress.dll                             | 2022.160.43.233 | 32816     | 19-Sep-2024 | 08:59 | x64      |
| Sql_common_core_keyfile.dll                | 2022.160.4145.4 | 137296    | 19-Sep-2024 | 08:59 | x64      |
| Sqldumper.exe                              | 2022.160.4145.4 | 448592    | 19-Sep-2024 | 08:59 | x64      |
| Sqldumper.exe                              | 2022.160.4145.4 | 378920    | 19-Sep-2024 | 08:59 | x86      |
| Sqlmgmprovider.dll                         | 2022.160.4145.4 | 456744    | 19-Sep-2024 | 08:59 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4145.4 | 395304    | 19-Sep-2024 | 08:59 | x86      |

SQL Server 2022 Data Quality Client

|             File name            |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.infra.dll | 16.0.4145.4     | 309192    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.ssdqs.studio.views.dll | 16.0.4145.4     | 2070592   | 19-Sep-2024 | 08:59 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4145.4 | 137296    | 19-Sep-2024 | 08:56 | x64      |

SQL Server 2022 Data Quality

|         File name         | File version | File size |     Date    |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4145.4  | 600016    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.ssdqs.core.dll  | 16.0.4145.4  | 600104    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4145.4  | 174120    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4145.4  | 174144    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4145.4  | 1857472   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4145.4  | 1857576   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4145.4  | 370744    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4145.4  | 370768    | 19-Sep-2024 | 08:59 | x86      |

SQL Server 2022 Database Services Core Instance

|                   File name                  |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Adal.dll                                     | 3.6.1.64359     | 1618832   | 19-Sep-2024 | 10:02 | x64      |
| Adalsqlrda.dll                               | 3.6.1.64359     | 1618832   | 19-Sep-2024 | 10:02 | x64      |
| Aetm-enclave-simulator.dll                   | 2022.160.4145.4 | 5994536   | 19-Sep-2024 | 10:02 | x64      |
| Aetm-enclave.dll                             | 2022.160.4145.4 | 5959696   | 19-Sep-2024 | 10:02 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4145.4 | 6194688   | 19-Sep-2024 | 10:02 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4145.4 | 6160568   | 19-Sep-2024 | 10:02 | x64      |
| Dcexec.exe                                   | 2022.160.4145.4 | 96208     | 19-Sep-2024 | 10:02 | x64      |
| Fssres.dll                                   | 2022.160.4145.4 | 100432    | 19-Sep-2024 | 10:02 | x64      |
| Hadrres.dll                                  | 2022.160.4145.4 | 227392    | 19-Sep-2024 | 10:02 | x64      |
| Hkcompile.dll                                | 2022.160.4145.4 | 1427392   | 19-Sep-2024 | 10:02 | x64      |
| Hkengine.dll                                 | 2022.160.4145.4 | 5769152   | 19-Sep-2024 | 10:02 | x64      |
| Hkruntime.dll                                | 2022.160.4145.4 | 190400    | 19-Sep-2024 | 10:02 | x64      |
| Hktempdb.dll                                 | 2022.160.4145.4 | 71736     | 19-Sep-2024 | 10:02 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.233     | 2322480   | 19-Sep-2024 | 10:02 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4145.4 | 333880    | 19-Sep-2024 | 10:02 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4145.4 | 96296     | 19-Sep-2024 | 10:02 | x64      |
| Odsole70.rll                                 | 16.0.4145.4     | 30800     | 19-Sep-2024 | 10:02 | x64      |
| Odsole70.rll                                 | 16.0.4145.4     | 38976     | 19-Sep-2024 | 10:02 | x64      |
| Odsole70.rll                                 | 16.0.4145.4     | 34856     | 19-Sep-2024 | 10:02 | x64      |
| Odsole70.rll                                 | 16.0.4145.4     | 38864     | 19-Sep-2024 | 10:02 | x64      |
| Odsole70.rll                                 | 16.0.4145.4     | 38952     | 19-Sep-2024 | 10:02 | x64      |
| Odsole70.rll                                 | 16.0.4145.4     | 30656     | 19-Sep-2024 | 10:02 | x64      |
| Odsole70.rll                                 | 16.0.4145.4     | 30784     | 19-Sep-2024 | 10:02 | x64      |
| Odsole70.rll                                 | 16.0.4145.4     | 34752     | 19-Sep-2024 | 10:02 | x64      |
| Odsole70.rll                                 | 16.0.4145.4     | 38952     | 19-Sep-2024 | 10:02 | x64      |
| Odsole70.rll                                 | 16.0.4145.4     | 30656     | 19-Sep-2024 | 10:02 | x64      |
| Odsole70.rll                                 | 16.0.4145.4     | 38848     | 19-Sep-2024 | 10:02 | x64      |
| Qds.dll                                      | 2022.160.4145.4 | 1808424   | 19-Sep-2024 | 10:02 | x64      |
| Rsfxft.dll                                   | 2022.160.4145.4 | 55336     | 19-Sep-2024 | 10:02 | x64      |
| Secforwarder.dll                             | 2022.160.4145.4 | 84040     | 19-Sep-2024 | 10:02 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4145.4 | 137296    | 19-Sep-2024 | 10:02 | x64      |
| Sqlaamss.dll                                 | 2022.160.4145.4 | 120872    | 19-Sep-2024 | 10:02 | x64      |
| Sqlaccess.dll                                | 2022.160.4145.4 | 444472    | 19-Sep-2024 | 10:02 | x64      |
| Sqlagent.exe                                 | 2022.160.4145.4 | 723024    | 19-Sep-2024 | 10:02 | x64      |
| Sqlceip.exe                                  | 16.0.4145.4     | 301008    | 19-Sep-2024 | 10:02 | x86      |
| Sqlcmdss.dll                                 | 2022.160.4145.4 | 104384    | 19-Sep-2024 | 10:02 | x64      |
| Sqlctr160.dll                                | 2022.160.4145.4 | 157768    | 19-Sep-2024 | 10:02 | x64      |
| Sqlctr160.dll                                | 2022.160.4145.4 | 129088    | 19-Sep-2024 | 10:02 | x86      |
| Sqldk.dll                                    | 2022.160.4145.4 | 4024376   | 19-Sep-2024 | 10:02 | x64      |
| Sqldtsss.dll                                 | 2022.160.4145.4 | 120896    | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 1755208   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 3864616   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 4081704   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 4593600   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 4724792   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 3766328   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 3954624   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 4593736   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 4421568   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 4495400   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 2455608   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 2398264   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 4278208   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 3913784   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 4433976   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 4225064   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 4208680   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 3991608   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 3868712   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 1693752   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 4319272   | 19-Sep-2024 | 10:02 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.4 | 4458560   | 19-Sep-2024 | 10:02 | x64      |
| Sqliosim.com                                 | 2022.160.4145.4 | 387008    | 19-Sep-2024 | 10:02 | x64      |
| Sqliosim.exe                                 | 2022.160.4145.4 | 3057600   | 19-Sep-2024 | 10:02 | x64      |
| Sqllang.dll                                  | 2022.160.4145.4 | 48814120  | 19-Sep-2024 | 10:02 | x64      |
| Sqlmin.dll                                   | 2022.160.4145.4 | 51267640  | 19-Sep-2024 | 10:02 | x64      |
| Sqlolapss.dll                                | 2022.160.4145.4 | 116792    | 19-Sep-2024 | 10:02 | x64      |
| Sqlos.dll                                    | 2022.160.4145.4 | 51256     | 19-Sep-2024 | 10:02 | x64      |
| Sqlpowershellss.dll                          | 2022.160.4145.4 | 100416    | 19-Sep-2024 | 10:02 | x64      |
| Sqlrepss.dll                                 | 2022.160.4145.4 | 145480    | 19-Sep-2024 | 10:02 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4145.4 | 51136     | 19-Sep-2024 | 10:02 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4145.4 | 5834816   | 19-Sep-2024 | 10:02 | x64      |
| Sqlservr.exe                                 | 2022.160.4145.4 | 723000    | 19-Sep-2024 | 10:02 | x64      |
| Sqlsvc.dll                                   | 2022.160.4145.4 | 194616    | 19-Sep-2024 | 10:02 | x64      |
| Sqltses.dll                                  | 2022.160.4145.4 | 10668072  | 19-Sep-2024 | 10:02 | x64      |
| Sqsrvres.dll                                 | 2022.160.4145.4 | 305192    | 19-Sep-2024 | 10:02 | x64      |
| Svl.dll                                      | 2022.160.4145.4 | 247848    | 19-Sep-2024 | 10:02 | x64      |
| Xe.dll                                       | 2022.160.4145.4 | 718784    | 19-Sep-2024 | 10:02 | x64      |
| Xpqueue.dll                                  | 2022.160.4145.4 | 100424    | 19-Sep-2024 | 10:02 | x64      |
| Xpstar.dll                                   | 2022.160.4145.4 | 534584    | 19-Sep-2024 | 10:02 | x64      |

SQL Server 2022 Database Services Core Shared

|                       File name                      |   File version   | File size |     Date    |  Time | Platform |
|:----------------------------------------------------:|:----------------:|:---------:|:-----------:|:-----:|:--------:|
| Azure.core.dll                                       | 1.3600.23.56006  | 384432    | 19-Sep-2024 | 08:59 | x86      |
| Azure.identity.dll                                   | 1.1000.423.56303 | 334768    | 19-Sep-2024 | 08:59 | x86      |
| Bcp.exe                                              | 2022.160.4145.4  | 141352    | 19-Sep-2024 | 08:59 | x64      |
| Commanddest.dll                                      | 2022.160.4145.4  | 272464    | 19-Sep-2024 | 08:56 | x64      |
| Datacollectortasks.dll                               | 2022.160.4145.4  | 227408    | 19-Sep-2024 | 08:59 | x64      |
| Distrib.exe                                          | 2022.160.4145.4  | 260032    | 19-Sep-2024 | 08:59 | x64      |
| Dteparse.dll                                         | 2022.160.4145.4  | 133200    | 19-Sep-2024 | 08:59 | x64      |
| Dteparsemgd.dll                                      | 2022.160.4145.4  | 178112    | 19-Sep-2024 | 08:59 | x64      |
| Dtepkg.dll                                           | 2022.160.4145.4  | 153664    | 19-Sep-2024 | 08:59 | x64      |
| Dtexec.exe                                           | 2022.160.4145.4  | 76864     | 19-Sep-2024 | 08:59 | x64      |
| Dts.dll                                              | 2022.160.4145.4  | 3266496   | 19-Sep-2024 | 08:56 | x64      |
| Dtscomexpreval.dll                                   | 2022.160.4145.4  | 493640    | 19-Sep-2024 | 08:56 | x64      |
| Dtsconn.dll                                          | 2022.160.4145.4  | 550992    | 19-Sep-2024 | 08:56 | x64      |
| Dtshost.exe                                          | 2022.160.4145.4  | 120256    | 19-Sep-2024 | 08:59 | x64      |
| Dtslog.dll                                           | 2022.160.4145.4  | 137256    | 19-Sep-2024 | 08:56 | x64      |
| Dtspipeline.dll                                      | 2022.160.4145.4  | 1337384   | 19-Sep-2024 | 08:56 | x64      |
| Dtuparse.dll                                         | 2022.160.4145.4  | 104528    | 19-Sep-2024 | 08:59 | x64      |
| Dtutil.exe                                           | 2022.160.4145.4  | 166464    | 19-Sep-2024 | 08:59 | x64      |
| Exceldest.dll                                        | 2022.160.4145.4  | 284752    | 19-Sep-2024 | 08:56 | x64      |
| Excelsrc.dll                                         | 2022.160.4145.4  | 305192    | 19-Sep-2024 | 08:56 | x64      |
| Execpackagetask.dll                                  | 2022.160.4145.4  | 182208    | 19-Sep-2024 | 08:56 | x64      |
| Flatfiledest.dll                                     | 2022.160.4145.4  | 423888    | 19-Sep-2024 | 08:56 | x64      |
| Flatfilesrc.dll                                      | 2022.160.4145.4  | 440400    | 19-Sep-2024 | 08:56 | x64      |
| Logread.exe                                          | 2022.160.4145.4  | 792528    | 19-Sep-2024 | 08:59 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.233      | 2933816   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.bcl.asyncinterfaces.dll                    | 6.0.21.52210     | 22144     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.sqlclient.dll                         | 5.13.23292.1     | 2048632   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.data.sqlclient.sni.dll                     | 5.1.1.0          | 504872    | 19-Sep-2024 | 08:59 | x64      |
| Microsoft.data.tools.sql.batchparser.dll             | 17.100.23.0      | 42416     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4145.4      | 30792     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.identity.client.dll                        | 4.56.0.0         | 1652320   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.identity.client.extensions.msal.dll        | 4.56.0.0         | 66552     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.identitymodel.abstractions.dll             | 6.24.0.31013     | 18864     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 6.24.0.31013     | 85424     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.identitymodel.logging.dll                  | 6.24.0.31013     | 34224     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.identitymodel.protocols.dll                | 6.24.0.31013     | 38288     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 6.24.0.31013     | 114048    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 6.24.0.31013     | 986032    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.sqlserver.connectioninfo.dll               | 17.100.23.0      | 126496    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.sqlserver.dmf.common.dll                   | 17.100.23.0      | 63520     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll         | 16.0.4145.4      | 391208    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.sqlserver.management.sdk.sfc.dll           | 17.100.23.0      | 513464    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4145.4  | 1718312   | 19-Sep-2024 | 08:59 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4145.4      | 555072    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.sqlserver.servicebrokerenum.dll            | 17.100.23.0      | 37920     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.sqlserver.smo.dll                          | 17.100.23.0      | 4451872   | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.sqlserver.smoextended.dll                  | 17.100.23.0      | 161208    | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.sqlserver.sqlclrprovider.dll               | 17.100.23.0      | 21536     | 19-Sep-2024 | 08:59 | x86      |
| Microsoft.sqlserver.sqlenum.dll                      | 17.100.23.0      | 1587744   | 19-Sep-2024 | 08:59 | x86      |
| Msdtssrvrutil.dll                                    | 2022.160.4145.4  | 124864    | 19-Sep-2024 | 08:56 | x64      |
| Msgprox.dll                                          | 2022.160.4145.4  | 313408    | 19-Sep-2024 | 08:59 | x64      |
| Msoledbsql.dll                                       | 2018.187.4.0     | 2750472   | 19-Sep-2024 | 08:59 | x64      |
| Msoledbsql.dll                                       | 2018.187.4.0     | 153608    | 19-Sep-2024 | 08:59 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517     | 704408    | 19-Sep-2024 | 08:56 | x86      |
| Oledbdest.dll                                        | 2022.160.4145.4  | 288832    | 19-Sep-2024 | 08:56 | x64      |
| Oledbsrc.dll                                         | 2022.160.4145.4  | 313296    | 19-Sep-2024 | 08:56 | x64      |
| Qrdrsvc.exe                                          | 2022.160.4145.4  | 526392    | 19-Sep-2024 | 08:59 | x64      |
| Rawdest.dll                                          | 2022.160.4145.4  | 227264    | 19-Sep-2024 | 08:56 | x64      |
| Rawsource.dll                                        | 2022.160.4145.4  | 215120    | 19-Sep-2024 | 08:56 | x64      |
| Rdistcom.dll                                         | 2022.160.4145.4  | 944200    | 19-Sep-2024 | 08:59 | x64      |
| Recordsetdest.dll                                    | 2022.160.4145.4  | 206888    | 19-Sep-2024 | 08:56 | x64      |
| Repldp.dll                                           | 2022.160.4145.4  | 337984    | 19-Sep-2024 | 08:59 | x64      |
| Replerrx.dll                                         | 2022.160.4145.4  | 198720    | 19-Sep-2024 | 08:59 | x64      |
| Replisapi.dll                                        | 2022.160.4145.4  | 419904    | 19-Sep-2024 | 08:59 | x64      |
| Replmerg.exe                                         | 2022.160.4145.4  | 595912    | 19-Sep-2024 | 08:59 | x64      |
| Replprov.dll                                         | 2022.160.4145.4  | 890816    | 19-Sep-2024 | 08:59 | x64      |
| Replrec.dll                                          | 2022.160.4145.4  | 1058880   | 19-Sep-2024 | 08:59 | x64      |
| Replsub.dll                                          | 2022.160.4145.4  | 501832    | 19-Sep-2024 | 08:59 | x64      |
| Spresolv.dll                                         | 2022.160.4145.4  | 301112    | 19-Sep-2024 | 08:59 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4145.4  | 137296    | 19-Sep-2024 | 08:56 | x64      |
| Sqlcmd.exe                                           | 2022.160.4145.4  | 276536    | 19-Sep-2024 | 08:59 | x64      |
| Sqldiag.exe                                          | 2022.160.4145.4  | 1140800   | 19-Sep-2024 | 08:59 | x64      |
| Sqldistx.dll                                         | 2022.160.4145.4  | 268224    | 19-Sep-2024 | 08:59 | x64      |
| Sqlmergx.dll                                         | 2022.160.4145.4  | 424008    | 19-Sep-2024 | 08:59 | x64      |
| Sqlnclirda11.dll                                     | 2011.110.5069.66 | 3478208   | 19-Sep-2024 | 08:59 | x64      |
| Sqlsvc.dll                                           | 2022.160.4145.4  | 153672    | 19-Sep-2024 | 08:59 | x86      |
| Sqlsvc.dll                                           | 2022.160.4145.4  | 194616    | 19-Sep-2024 | 08:59 | x64      |
| Sqltaskconnections.dll                               | 2022.160.4145.4  | 210880    | 19-Sep-2024 | 08:56 | x64      |
| Ssradd.dll                                           | 2022.160.4145.4  | 100416    | 19-Sep-2024 | 08:59 | x64      |
| Ssravg.dll                                           | 2022.160.4145.4  | 100408    | 19-Sep-2024 | 08:59 | x64      |
| Ssrmax.dll                                           | 2022.160.4145.4  | 100424    | 19-Sep-2024 | 08:59 | x64      |
| Ssrmin.dll                                           | 2022.160.4145.4  | 100392    | 19-Sep-2024 | 08:59 | x64      |
| System.diagnostics.diagnosticsource.dll              | 7.0.423.11508    | 173232    | 19-Sep-2024 | 08:59 | x86      |
| System.memory.dll                                    | 4.6.31308.1      | 142240    | 19-Sep-2024 | 08:59 | x86      |
| System.runtime.compilerservices.unsafe.dll           | 6.0.21.52210     | 18024     | 19-Sep-2024 | 08:59 | x86      |
| System.security.cryptography.protecteddata.dll       | 7.0.22.51805     | 21640     | 19-Sep-2024 | 08:59 | x86      |
| Txagg.dll                                            | 2022.160.4145.4  | 395328    | 19-Sep-2024 | 08:56 | x64      |
| Txbdd.dll                                            | 2022.160.4145.4  | 190504    | 19-Sep-2024 | 08:56 | x64      |
| Txdatacollector.dll                                  | 2022.160.4145.4  | 469056    | 19-Sep-2024 | 08:59 | x64      |
| Txdataconvert.dll                                    | 2022.160.4145.4  | 333776    | 19-Sep-2024 | 08:56 | x64      |
| Txderived.dll                                        | 2022.160.4145.4  | 632912    | 19-Sep-2024 | 08:56 | x64      |
| Txlookup.dll                                         | 2022.160.4145.4  | 608192    | 19-Sep-2024 | 08:56 | x64      |
| Txmerge.dll                                          | 2022.160.4145.4  | 243792    | 19-Sep-2024 | 08:56 | x64      |
| Txmergejoin.dll                                      | 2022.160.4145.4  | 300992    | 19-Sep-2024 | 08:56 | x64      |
| Txmulticast.dll                                      | 2022.160.4145.4  | 145448    | 19-Sep-2024 | 08:56 | x64      |
| Txrowcount.dll                                       | 2022.160.4145.4  | 145464    | 19-Sep-2024 | 08:56 | x64      |
| Txsort.dll                                           | 2022.160.4145.4  | 276416    | 19-Sep-2024 | 08:56 | x64      |
| Txsplit.dll                                          | 2022.160.4145.4  | 620624    | 19-Sep-2024 | 08:56 | x64      |
| Txunionall.dll                                       | 2022.160.4145.4  | 194600    | 19-Sep-2024 | 08:56 | x64      |
| Xe.dll                                               | 2022.160.4145.4  | 718784    | 19-Sep-2024 | 08:59 | x64      |

SQL Server 2022 sql_extensibility

|           File name           |   File version  | File size |     Date    |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4145.4 | 100392    | 19-Sep-2024 | 08:59 | x64      |
| Exthost.exe                   | 2022.160.4145.4 | 247848    | 19-Sep-2024 | 08:59 | x64      |
| Launchpad.exe                 | 2022.160.4145.4 | 1452072   | 19-Sep-2024 | 08:59 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4145.4 | 137296    | 19-Sep-2024 | 08:56 | x64      |
| Sqlsatellite.dll              | 2022.160.4145.4 | 1255464   | 19-Sep-2024 | 08:59 | x64      |

SQL Server 2022 Full-Text Engine

|         File name        |   File version  | File size |     Date    |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4145.4 | 710696    | 19-Sep-2024 | 08:59 | x64      |
| Fdhost.exe               | 2022.160.4145.4 | 153680    | 19-Sep-2024 | 08:59 | x64      |
| Fdlauncher.exe           | 2022.160.4145.4 | 100392    | 19-Sep-2024 | 08:59 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4145.4 | 137296    | 19-Sep-2024 | 08:55 | x64      |

SQL Server 2022 Integration Services

|                           File name                           |   File version  | File size |     Date    |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 19-Sep-2024 | 09:05 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 19-Sep-2024 | 09:05 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 19-Sep-2024 | 09:05 | x86      |
| Commanddest.dll                                               | 2022.160.4145.4 | 231496    | 19-Sep-2024 | 09:05 | x86      |
| Commanddest.dll                                               | 2022.160.4145.4 | 272464    | 19-Sep-2024 | 09:05 | x64      |
| Dteparse.dll                                                  | 2022.160.4145.4 | 116800    | 19-Sep-2024 | 09:05 | x86      |
| Dteparse.dll                                                  | 2022.160.4145.4 | 133200    | 19-Sep-2024 | 09:05 | x64      |
| Dteparsemgd.dll                                               | 2022.160.4145.4 | 165968    | 19-Sep-2024 | 09:05 | x86      |
| Dteparsemgd.dll                                               | 2022.160.4145.4 | 178112    | 19-Sep-2024 | 09:05 | x64      |
| Dtepkg.dll                                                    | 2022.160.4145.4 | 128976    | 19-Sep-2024 | 09:05 | x86      |
| Dtepkg.dll                                                    | 2022.160.4145.4 | 153664    | 19-Sep-2024 | 09:05 | x64      |
| Dtexec.exe                                                    | 2022.160.4145.4 | 65088     | 19-Sep-2024 | 09:05 | x86      |
| Dtexec.exe                                                    | 2022.160.4145.4 | 76864     | 19-Sep-2024 | 09:05 | x64      |
| Dts.dll                                                       | 2022.160.4145.4 | 2861096   | 19-Sep-2024 | 09:05 | x86      |
| Dts.dll                                                       | 2022.160.4145.4 | 3266496   | 19-Sep-2024 | 09:05 | x64      |
| Dtscomexpreval.dll                                            | 2022.160.4145.4 | 444352    | 19-Sep-2024 | 09:05 | x86      |
| Dtscomexpreval.dll                                            | 2022.160.4145.4 | 493640    | 19-Sep-2024 | 09:05 | x64      |
| Dtsconn.dll                                                   | 2022.160.4145.4 | 464968    | 19-Sep-2024 | 09:05 | x86      |
| Dtsconn.dll                                                   | 2022.160.4145.4 | 550992    | 19-Sep-2024 | 09:05 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4145.4 | 114760    | 19-Sep-2024 | 09:05 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4145.4 | 94784     | 19-Sep-2024 | 09:05 | x86      |
| Dtshost.exe                                                   | 2022.160.4145.4 | 120256    | 19-Sep-2024 | 09:05 | x64      |
| Dtshost.exe                                                   | 2022.160.4145.4 | 98240     | 19-Sep-2024 | 09:05 | x86      |
| Dtslog.dll                                                    | 2022.160.4145.4 | 120896    | 19-Sep-2024 | 09:05 | x86      |
| Dtslog.dll                                                    | 2022.160.4145.4 | 137256    | 19-Sep-2024 | 09:05 | x64      |
| Dtspipeline.dll                                               | 2022.160.4145.4 | 1144872   | 19-Sep-2024 | 09:05 | x86      |
| Dtspipeline.dll                                               | 2022.160.4145.4 | 1337384   | 19-Sep-2024 | 09:05 | x64      |
| Dtuparse.dll                                                  | 2022.160.4145.4 | 104528    | 19-Sep-2024 | 09:05 | x64      |
| Dtuparse.dll                                                  | 2022.160.4145.4 | 88144     | 19-Sep-2024 | 09:05 | x86      |
| Dtutil.exe                                                    | 2022.160.4145.4 | 142416    | 19-Sep-2024 | 09:05 | x86      |
| Dtutil.exe                                                    | 2022.160.4145.4 | 166464    | 19-Sep-2024 | 09:05 | x64      |
| Exceldest.dll                                                 | 2022.160.4145.4 | 247880    | 19-Sep-2024 | 09:05 | x86      |
| Exceldest.dll                                                 | 2022.160.4145.4 | 284752    | 19-Sep-2024 | 09:05 | x64      |
| Excelsrc.dll                                                  | 2022.160.4145.4 | 264256    | 19-Sep-2024 | 09:05 | x86      |
| Excelsrc.dll                                                  | 2022.160.4145.4 | 305192    | 19-Sep-2024 | 09:05 | x64      |
| Execpackagetask.dll                                           | 2022.160.4145.4 | 149568    | 19-Sep-2024 | 09:05 | x86      |
| Execpackagetask.dll                                           | 2022.160.4145.4 | 182208    | 19-Sep-2024 | 09:05 | x64      |
| Flatfiledest.dll                                              | 2022.160.4145.4 | 374848    | 19-Sep-2024 | 09:05 | x86      |
| Flatfiledest.dll                                              | 2022.160.4145.4 | 423888    | 19-Sep-2024 | 09:05 | x64      |
| Flatfilesrc.dll                                               | 2022.160.4145.4 | 391232    | 19-Sep-2024 | 09:05 | x86      |
| Flatfilesrc.dll                                               | 2022.160.4145.4 | 440400    | 19-Sep-2024 | 09:05 | x64      |
| Isdbupgradewizard.exe                                         | 16.0.4145.4     | 120888    | 19-Sep-2024 | 09:05 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4145.4     | 120896    | 19-Sep-2024 | 09:05 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.233     | 2933816   | 19-Sep-2024 | 09:05 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.233     | 2933824   | 19-Sep-2024 | 09:05 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4145.4     | 509992    | 19-Sep-2024 | 09:05 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4145.4     | 510016    | 19-Sep-2024 | 09:05 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 16.0.4145.4     | 391208    | 19-Sep-2024 | 09:05 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4145.4     | 219200    | 19-Sep-2024 | 09:05 | x64      |
| Msdtssrvrutil.dll                                             | 2022.160.4145.4 | 100392    | 19-Sep-2024 | 09:05 | x86      |
| Msdtssrvrutil.dll                                             | 2022.160.4145.4 | 124864    | 19-Sep-2024 | 09:05 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.233 | 10164160  | 19-Sep-2024 | 09:05 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 19-Sep-2024 | 09:05 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 19-Sep-2024 | 09:05 | x86      |
| Odbcdest.dll                                                  | 2022.160.4145.4 | 342056    | 19-Sep-2024 | 09:05 | x86      |
| Odbcdest.dll                                                  | 2022.160.4145.4 | 382912    | 19-Sep-2024 | 09:05 | x64      |
| Odbcsrc.dll                                                   | 2022.160.4145.4 | 350280    | 19-Sep-2024 | 09:05 | x86      |
| Odbcsrc.dll                                                   | 2022.160.4145.4 | 399416    | 19-Sep-2024 | 09:05 | x64      |
| Oledbdest.dll                                                 | 2022.160.4145.4 | 247848    | 19-Sep-2024 | 09:05 | x86      |
| Oledbdest.dll                                                 | 2022.160.4145.4 | 288832    | 19-Sep-2024 | 09:05 | x64      |
| Oledbsrc.dll                                                  | 2022.160.4145.4 | 268328    | 19-Sep-2024 | 09:05 | x86      |
| Oledbsrc.dll                                                  | 2022.160.4145.4 | 313296    | 19-Sep-2024 | 09:05 | x64      |
| Rawdest.dll                                                   | 2022.160.4145.4 | 227264    | 19-Sep-2024 | 09:05 | x64      |
| Rawdest.dll                                                   | 2022.160.4145.4 | 190416    | 19-Sep-2024 | 09:05 | x86      |
| Rawsource.dll                                                 | 2022.160.4145.4 | 215120    | 19-Sep-2024 | 09:05 | x64      |
| Rawsource.dll                                                 | 2022.160.4145.4 | 186304    | 19-Sep-2024 | 09:05 | x86      |
| Recordsetdest.dll                                             | 2022.160.4145.4 | 206888    | 19-Sep-2024 | 09:05 | x64      |
| Recordsetdest.dll                                             | 2022.160.4145.4 | 174144    | 19-Sep-2024 | 09:05 | x86      |
| Sql_is_keyfile.dll                                            | 2022.160.4145.4 | 137296    | 19-Sep-2024 | 09:05 | x64      |
| Sqlceip.exe                                                   | 16.0.4145.4     | 301008    | 19-Sep-2024 | 09:05 | x86      |
| Sqldest.dll                                                   | 2022.160.4145.4 | 256080    | 19-Sep-2024 | 09:05 | x86      |
| Sqldest.dll                                                   | 2022.160.4145.4 | 288704    | 19-Sep-2024 | 09:05 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4145.4 | 210880    | 19-Sep-2024 | 09:05 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4145.4 | 174120    | 19-Sep-2024 | 09:05 | x86      |
| Txagg.dll                                                     | 2022.160.4145.4 | 346176    | 19-Sep-2024 | 09:05 | x86      |
| Txagg.dll                                                     | 2022.160.4145.4 | 395328    | 19-Sep-2024 | 09:05 | x64      |
| Txbdd.dll                                                     | 2022.160.4145.4 | 149568    | 19-Sep-2024 | 09:05 | x86      |
| Txbdd.dll                                                     | 2022.160.4145.4 | 190504    | 19-Sep-2024 | 09:05 | x64      |
| Txbestmatch.dll                                               | 2022.160.4145.4 | 567336    | 19-Sep-2024 | 09:05 | x86      |
| Txbestmatch.dll                                               | 2022.160.4145.4 | 661448    | 19-Sep-2024 | 09:05 | x64      |
| Txcache.dll                                                   | 2022.160.4145.4 | 170064    | 19-Sep-2024 | 09:05 | x86      |
| Txcache.dll                                                   | 2022.160.4145.4 | 202816    | 19-Sep-2024 | 09:05 | x64      |
| Txcharmap.dll                                                 | 2022.160.4145.4 | 280616    | 19-Sep-2024 | 09:05 | x86      |
| Txcharmap.dll                                                 | 2022.160.4145.4 | 325696    | 19-Sep-2024 | 09:05 | x64      |
| Txcopymap.dll                                                 | 2022.160.4145.4 | 165928    | 19-Sep-2024 | 09:05 | x86      |
| Txcopymap.dll                                                 | 2022.160.4145.4 | 202688    | 19-Sep-2024 | 09:05 | x64      |
| Txdataconvert.dll                                             | 2022.160.4145.4 | 288832    | 19-Sep-2024 | 09:05 | x86      |
| Txdataconvert.dll                                             | 2022.160.4145.4 | 333776    | 19-Sep-2024 | 09:05 | x64      |
| Txderived.dll                                                 | 2022.160.4145.4 | 559176    | 19-Sep-2024 | 09:05 | x86      |
| Txderived.dll                                                 | 2022.160.4145.4 | 632912    | 19-Sep-2024 | 09:05 | x64      |
| Txfileextractor.dll                                           | 2022.160.4145.4 | 186408    | 19-Sep-2024 | 09:05 | x86      |
| Txfileextractor.dll                                           | 2022.160.4145.4 | 219200    | 19-Sep-2024 | 09:05 | x64      |
| Txfileinserter.dll                                            | 2022.160.4145.4 | 186432    | 19-Sep-2024 | 09:05 | x86      |
| Txfileinserter.dll                                            | 2022.160.4145.4 | 219200    | 19-Sep-2024 | 09:05 | x64      |
| Txgroupdups.dll                                               | 2022.160.4145.4 | 354384    | 19-Sep-2024 | 09:05 | x86      |
| Txgroupdups.dll                                               | 2022.160.4145.4 | 403408    | 19-Sep-2024 | 09:05 | x64      |
| Txlineage.dll                                                 | 2022.160.4145.4 | 129088    | 19-Sep-2024 | 09:05 | x86      |
| Txlineage.dll                                                 | 2022.160.4145.4 | 157736    | 19-Sep-2024 | 09:05 | x64      |
| Txlookup.dll                                                  | 2022.160.4145.4 | 522296    | 19-Sep-2024 | 09:05 | x86      |
| Txlookup.dll                                                  | 2022.160.4145.4 | 608192    | 19-Sep-2024 | 09:05 | x64      |
| Txmerge.dll                                                   | 2022.160.4145.4 | 194600    | 19-Sep-2024 | 09:05 | x86      |
| Txmerge.dll                                                   | 2022.160.4145.4 | 243792    | 19-Sep-2024 | 09:05 | x64      |
| Txmergejoin.dll                                               | 2022.160.4145.4 | 255936    | 19-Sep-2024 | 09:05 | x86      |
| Txmergejoin.dll                                               | 2022.160.4145.4 | 300992    | 19-Sep-2024 | 09:05 | x64      |
| Txmulticast.dll                                               | 2022.160.4145.4 | 116800    | 19-Sep-2024 | 09:05 | x86      |
| Txmulticast.dll                                               | 2022.160.4145.4 | 145448    | 19-Sep-2024 | 09:05 | x64      |
| Txpivot.dll                                                   | 2022.160.4145.4 | 198720    | 19-Sep-2024 | 09:05 | x86      |
| Txpivot.dll                                                   | 2022.160.4145.4 | 239680    | 19-Sep-2024 | 09:05 | x64      |
| Txrowcount.dll                                                | 2022.160.4145.4 | 116808    | 19-Sep-2024 | 09:05 | x86      |
| Txrowcount.dll                                                | 2022.160.4145.4 | 145464    | 19-Sep-2024 | 09:05 | x64      |
| Txsampling.dll                                                | 2022.160.4145.4 | 153680    | 19-Sep-2024 | 09:05 | x86      |
| Txsampling.dll                                                | 2022.160.4145.4 | 186408    | 19-Sep-2024 | 09:05 | x64      |
| Txscd.dll                                                     | 2022.160.4145.4 | 198736    | 19-Sep-2024 | 09:05 | x86      |
| Txscd.dll                                                     | 2022.160.4145.4 | 235560    | 19-Sep-2024 | 09:05 | x64      |
| Txsort.dll                                                    | 2022.160.4145.4 | 231464    | 19-Sep-2024 | 09:05 | x86      |
| Txsort.dll                                                    | 2022.160.4145.4 | 276416    | 19-Sep-2024 | 09:05 | x64      |
| Txsplit.dll                                                   | 2022.160.4145.4 | 550848    | 19-Sep-2024 | 09:05 | x86      |
| Txsplit.dll                                                   | 2022.160.4145.4 | 620624    | 19-Sep-2024 | 09:05 | x64      |
| Txtermextraction.dll                                          | 2022.160.4145.4 | 8648784   | 19-Sep-2024 | 09:05 | x86      |
| Txtermextraction.dll                                          | 2022.160.4145.4 | 8702016   | 19-Sep-2024 | 09:05 | x64      |
| Txtermlookup.dll                                              | 2022.160.4145.4 | 4139064   | 19-Sep-2024 | 09:05 | x86      |
| Txtermlookup.dll                                              | 2022.160.4145.4 | 4184000   | 19-Sep-2024 | 09:05 | x64      |
| Txunionall.dll                                                | 2022.160.4145.4 | 153672    | 19-Sep-2024 | 09:05 | x86      |
| Txunionall.dll                                                | 2022.160.4145.4 | 194600    | 19-Sep-2024 | 09:05 | x64      |
| Txunpivot.dll                                                 | 2022.160.4145.4 | 178248    | 19-Sep-2024 | 09:05 | x86      |
| Txunpivot.dll                                                 | 2022.160.4145.4 | 215104    | 19-Sep-2024 | 09:05 | x64      |
| Xe.dll                                                        | 2022.160.4145.4 | 641080    | 19-Sep-2024 | 09:05 | x86      |
| Xe.dll                                                        | 2022.160.4145.4 | 718784    | 19-Sep-2024 | 09:05 | x64      |

SQL Server 2022 sql_polybase_core_inst

|                               File name                              |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1037.0     | 559688    | 19-Sep-2024 | 09:43 | x86      |
| Dmsnative.dll                                                        | 2022.160.1037.0 | 152648    | 19-Sep-2024 | 09:43 | x64      |
| Dwengineservice.dll                                                  | 16.0.1037.0     | 45128     | 19-Sep-2024 | 09:43 | x86      |
| Instapi150.dll                                                       | 2022.160.4145.4 | 104488    | 19-Sep-2024 | 09:43 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1037.0     | 67656     | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1037.0     | 293448    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1037.0     | 1958360   | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1037.0     | 169544    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1037.0     | 647240    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1037.0     | 246344    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1037.0     | 139224    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1037.0     | 79944     | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1037.0     | 51272     | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1037.0     | 88536     | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1037.0     | 1129432   | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1037.0     | 80856     | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1037.0     | 70616     | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1037.0     | 35400     | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1037.0     | 30792     | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1037.0     | 46664     | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1037.0     | 21464     | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1037.0     | 26696     | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1037.0     | 131656    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1037.0     | 86600     | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1037.0     | 100936    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1037.0     | 293448    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 120280    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 138312    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 141272    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 137800    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 150600    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 139848    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 134728    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 176712    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 117832    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 136776    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1037.0     | 72776     | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1037.0     | 21976     | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1037.0     | 37448     | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1037.0     | 129096    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1037.0     | 3064904   | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1037.0     | 3955672   | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 118232    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 133080    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 137688    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 133592    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 148440    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 134104    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 130520    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 170968    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 115160    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 132064    | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1037.0     | 67552     | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1037.0     | 2682840   | 19-Sep-2024 | 09:43 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1037.0     | 2436568   | 19-Sep-2024 | 09:43 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4145.4 | 297040    | 19-Sep-2024 | 09:43 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4145.4 | 9078824   | 19-Sep-2024 | 09:43 | x64      |
| Secforwarder.dll                                                     | 2022.160.4145.4 | 84040     | 19-Sep-2024 | 09:43 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1037.0 | 61400     | 19-Sep-2024 | 09:43 | x64      |
| Sqldk.dll                                                            | 2022.160.4145.4 | 4024376   | 19-Sep-2024 | 09:43 | x64      |
| Sqldumper.exe                                                        | 2022.160.4145.4 | 448592    | 19-Sep-2024 | 09:43 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.4 | 1755208   | 19-Sep-2024 | 09:43 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.4 | 4593600   | 19-Sep-2024 | 09:43 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.4 | 3766328   | 19-Sep-2024 | 09:43 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.4 | 4593736   | 19-Sep-2024 | 09:43 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.4 | 4495400   | 19-Sep-2024 | 09:43 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.4 | 2455608   | 19-Sep-2024 | 09:43 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.4 | 2398264   | 19-Sep-2024 | 09:43 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.4 | 4225064   | 19-Sep-2024 | 09:43 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.4 | 4208680   | 19-Sep-2024 | 09:43 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.4 | 1693752   | 19-Sep-2024 | 09:43 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.4 | 4458560   | 19-Sep-2024 | 09:43 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.6.1   | 1898520   | 19-Sep-2024 | 09:43 | x64      |
| Sqlos.dll                                                            | 2022.160.4145.4 | 51256     | 19-Sep-2024 | 09:43 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1037.0 | 4841432   | 19-Sep-2024 | 09:43 | x64      |
| Sqltses.dll                                                          | 2022.160.4145.4 | 10668072  | 19-Sep-2024 | 09:43 | x64      |

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2022.

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

- [Upgrade and update of availability group servers that use minimal downtime and data loss](https://msdn.microsoft.com/library/dn178483.aspx)

    > [!NOTE]
    > If you enabled Always On together with the **SSISDB** catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) about how to apply an update in these environments.

- [How to apply a hotfix for SQL Server in a transactional replication and database mirroring topology](../../database-engine/replication/install-service-packs-hotfixes.md)
- [How to apply a hotfix for SQL Server in a replication topology](../../database-engine/replication/apply-hotfix-sql-replication-topology.md)
- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances)
- [Overview of SQL Server Servicing Installation](https://technet.microsoft.com/library/dd638062.aspx)

</details>

<details>
<summary><b>Language support</b></summary>

SQL Server CUs are currently multilingual. Therefore, this CU package isn't specific to one language. It applies to all supported languages.

</details>

<details>
<summary><b>Components (features) updated</b></summary>

One CU package includes all available updates for all SQL Server 2022 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
</details>

## How to uninstall this update

<details>
<summary><b>How to uninstall this update on Windows</b></summary>

1. In Control Panel, open the **Programs and Features** item, and then select **View installed updates**.
1. Locate the entry that corresponds to this cumulative update package under **SQL Server 2022**.
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
