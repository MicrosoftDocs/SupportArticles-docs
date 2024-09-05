---
title: Cumulative update 15 for SQL Server 2022 (KB5041321)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 15 (KB5041321).
ms.date: 09/12/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5041321
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5041321 - Cumulative Update 15 for SQL Server 2022

_Release Date:_ &nbsp; September 12, 2024  
_Version:_ &nbsp; 16.0.4145.2

## Summary

This article describes Cumulative Update package 15 (CU15) for Microsoft SQL Server 2022. This update contains 12 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 14, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4145.2**, file version: **2022.160.4145.2**
- Analysis Services - Product version: **16.0.43.233**, file version: **2022.160.43.233**

## Known issues in this update

### Patching error for secondary replicas in an availability group with databases enabled replication, CDC, or SSISDB

[!INCLUDE [patching-error-2022](../includes/patching-error-2022.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description| Fix area | Component | Platform |
|------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|-------------------------------------------|----------|
| <a id=3285880>[3285880](#3285880) </a> | Fixes a domain account authentication issue in the configuration tool by adding an auto-retry method to the account validation part, which will use the **UPN** format and try to authenticate using three separate authentication methods after the authentication fails in **SAM** format and default. | Master Data Services | Master Data Services| Windows|
| <a id=3354272>[3354272](#3354272) </a> | Updates the criterion for determining the current machine type and the judgment conditions of whether it is a domain controller. | Master Data Services | Master Data Services| Windows|
| <a id=3287656>[3287656](#3287656) </a> | Fixes an assertion failure (Location: ListenerSpec.cpp:480; Expression: totalUsed + cbListenerName <= cbObj) that you encounter when creating a [distributed availability group (DAG)](/sql/database-engine/availability-groups/windows/distributed-availability-groups) and incorrectly specifying the number of availability groups in it to be other than two.| SQL Server Engine| High Availability and Disaster Recovery | All|
| <a id=3301982>[3301982](#3301982) </a> | Fixes an assertion failure (Location: MetadataVersion.cpp:71; Expression: !CFeatureSwitchesMin::GetCurrentInstance()->FEntityVerStoreCsnCheckEnabled() \|\| newInfo != InvalidXts()) that you encounter when you try to change the database owner on a readable secondary replica of an Always On availability group.| SQL Server Engine| Metadata| All|
| <a id=3338395>[3338395](#3338395) </a> | Fixes an issue in which PolyBase throws the following error at service startup if the SQL Server instance is configured to listen on multiple TCP ports: </br></br>System.ArgumentException: Unable to parse port, instance = '\<InstanceName>', text = '\<Text>'| SQL Server Engine| PolyBase| All|
| <a id=3181615>[3181615](#3181615) </a> | Adds a new security feature to implement change data capture (CDC) metadata data definition language (DDL) lockdown, preventing errors that might occur when running `sp_cdc_vupgrade` against a database with CDC disabled. | SQL Server Engine| Replication | All|
| <a id=3338274>[3338274](#3338274) </a> | Fixes the following error 21890 that you encounter when you use the case-sensitive collation and run `sp_validate_redirected_publisher`: </br></br>The SQL Server instance '\<InstanceName>' with distributor '\<DistributorName>' and distribution database '\<DatabaseName>' cannot be used with publisher database '\<DatabaseName>'. Reconfigure the publisher to make use of distributor '\<DistributorName>' and distribution database '\<DatabaseName>'.| SQL Server Engine| Replication | All|
| <a id=3362871>[3362871](#3362871) </a> | Fixes an issue with checkpoint operation in which the following error 2601 occurs when SQL Server tries to checkpoint a database that has change tracking enabled: </br></br>\<DateTime> Error: 2601, Severity: 14, State: 1. </br>\<DateTime> Cannot insert duplicate key row in object '\<ObjectName>' with unique index '\<IndexName>'. The duplicate key value is \<KeyValue>. | SQL Server Engine| Replication | All|
| <a id=3394373>[3394373](#3394373) </a> | Fixes an issue in which error 18752 occurs and transactional replication stops working when you use a heavy workload in combination with availability groups and after a failover occurs. </br></br>Error message: </br></br>Only one Log Reader Agent or log-related procedure (sp_repldone, sp_replcmds, and sp_replshowcmds) can connect to a database at a time. If you executed a log-related procedure, drop the connection with session ID \<SessionID> over which the procedure was executed or execute sp_replflush over that connection before starting the Log Reader Agent or executing another log-related procedure. | SQL Server Engine| Replication | Windows|
| <a id=3325413>[3325413](#3325413) </a> | Before the fix, the SQL Server error log records many messages regarding starting or stopping extended events (XE) sessions. After applying the fix, starting or stopping XE sessions isn't logged by default. You can enable it by turning trace flag 9714 on. | SQL Server Engine| Storage Management| All|
| <a id=3409327>[3409327](#3409327) </a> | Fixes an issue in which table and column names that are read from database metadata aren't correctly quoted in some cases when building internal SQL Server batches in stored procedures that manage temporal tables. After applying the fix, quoting is completed correctly.| SQL Server Engine| Temporal| All|
| <a id=2862558>[2862558](#2862558) </a> | Fixes the slowness of `RESTORE WITH STANDBY` operations that you encounter when accelerated database recovery (ADR) isn't enabled. | SQL Server Engine| Transaction Services| All|

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?familyid=4fa9aa71-05f4-40ef-bc55-606ac00479b1)

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
|SQLServer2022-KB5041321-x64.exe| 01A929B4727BEB69721A62B06E7EC710CBDE2BED36C7EBE23832BFB6B3BAACD6  |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

|                      File name                      |   File version  | File size |     Date    |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Anglesharp.dll                                      | 0.9.9.0         | 1240112   | 23-Aug-2024 | 15:35 | x86      |
| Asplatformhost.dll                                  | 2022.160.43.233 | 336944    | 23-Aug-2024 | 15:33 | x64      |
| Mashupcompression.dll                               | 2.127.602.0     | 141760    | 23-Aug-2024 | 15:35 | x64      |
| Microsoft.analysisservices.minterop.dll             | 16.0.43.233     | 865216    | 23-Aug-2024 | 15:33 | x86      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.233     | 2903488   | 23-Aug-2024 | 15:33 | x86      |
| Microsoft.data.edm.netfx35.dll                      | 5.7.0.62516     | 661936    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.mashup.dll                           | 2.127.602.0     | 224184    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.mashup.oledb.dll                     | 2.127.602.0     | 32192     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.mashup.preview.dll                   | 2.127.602.0     | 153528    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.mashup.providercommon.dll            | 2.127.602.0     | 113088    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 38832     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42928     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 33216     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 47040     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42928     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 47024     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 38832     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.127.602.0     | 25536     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.odata.netfx35.dll                    | 5.7.0.62516     | 1455536   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.odata.query.netfx35.dll              | 5.7.0.62516     | 182200    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.sapclient.dll                        | 1.0.0.25        | 931680    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 35200     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 36704     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 37216     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 39808     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 49024     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.sqlclient.dll                        | 2.17.23292.1    | 1997744   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.sqlclient.sni.dll                    | 2.1.1.0         | 511920    | 23-Aug-2024 | 15:35 | x64      |
| Microsoft.dataintegration.fuzzyclustering.dll       | 1.0.0.0         | 40368     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.dataintegration.fuzzymatching.dll         | 1.0.0.0         | 628144    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.dataintegration.fuzzymatchingcommon.dll   | 1.0.0.0         | 390064    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.exchange.webservices.dll                  | 15.0.913.15     | 1124272   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.hostintegration.connectors.dll            | 2.127.602.0     | 4964800   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.identity.client.dll                       | 4.57.0.0        | 1653680   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 6.35.0.41201    | 111536    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.identitymodel.logging.dll                 | 6.35.0.41201    | 38320     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.identitymodel.protocols.dll               | 6.35.0.41201    | 39856     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 6.35.0.41201    | 114096    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 6.35.0.41201    | 992192    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.cdm.icdmprovider.dll               | 2.127.602.0     | 21952     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.container.exe                      | 2.127.602.0     | 25024     | 23-Aug-2024 | 15:35 | x64      |
| Microsoft.mashup.container.netfx40.exe              | 2.127.602.0     | 24000     | 23-Aug-2024 | 15:35 | x64      |
| Microsoft.mashup.container.netfx45.exe              | 2.127.602.0     | 23992     | 23-Aug-2024 | 15:35 | x64      |
| Microsoft.mashup.eventsource.dll                    | 2.127.602.0     | 150448    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oauth.dll                          | 2.127.602.0     | 94144     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 15808     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16320     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16312     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16816     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 17344     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 15792     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oledbinterop.dll                   | 2.127.602.0     | 201144    | 23-Aug-2024 | 15:35 | x64      |
| Microsoft.mashup.oledbprovider.dll                  | 2.127.602.0     | 67008     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14264     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.sapbwprovider.dll                  | 2.127.602.0     | 334256    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.scriptdom.dll                      | 2.40.4554.261   | 2365872   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.shims.dll                          | 2.127.602.0     | 29616     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll         | 1.0.0.0         | 141248    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.dll                          | 2.127.602.0     | 15941040  | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.library45.dll                | 2.127.602.0     | 7617472   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39856     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39872     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 40368     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 40888     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 42424     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 47024     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 35872     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 36288     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39360     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 620464    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 747448    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 739248    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 718776    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 776128    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 726960    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 702384    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 980912    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 612272    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 714672    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.mshtml.dll                                | 7.0.3300.1      | 8017840   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.odata.core.netfx35.dll                    | 6.15.0.0        | 1438656   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.odata.core.netfx35.v7.dll                 | 7.4.0.11102     | 1262000   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.odata.edm.netfx35.dll                     | 6.15.0.0        | 779712    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.odata.edm.netfx35.v7.dll                  | 7.4.0.11102     | 745920    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.powerbi.adomdclient.dll                   | 16.0.122.20     | 1216944   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.spatial.netfx35.dll                       | 6.15.0.0        | 127408    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.spatial.netfx35.v7.dll                    | 7.4.0.11102     | 125368    | 23-Aug-2024 | 15:35 | x86      |
| Msmdctr.dll                                         | 2022.160.43.233 | 38864     | 23-Aug-2024 | 15:33 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.233 | 71818688  | 23-Aug-2024 | 15:33 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.233 | 53976120  | 23-Aug-2024 | 15:33 | x86      |
| Msmdpump.dll                                        | 2022.160.43.233 | 10333744  | 23-Aug-2024 | 15:33 | x64      |
| Msmdredir.dll                                       | 2022.160.43.233 | 8132032   | 23-Aug-2024 | 15:33 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.233 | 71367216  | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 956992    | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1884720   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1671728   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1881152   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1848360   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1147440   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1140280   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1769520   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1749040   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 932912    | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1837616   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 955456    | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1882672   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1668656   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1876528   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1844784   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1145392   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1138752   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1765440   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1745456   | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 933424    | 23-Aug-2024 | 15:33 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1833008   | 23-Aug-2024 | 15:33 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.233 | 10083392  | 23-Aug-2024 | 15:33 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.233 | 8265280   | 23-Aug-2024 | 15:33 | x86      |
| Msolap.dll                                          | 2022.160.43.233 | 10969648  | 23-Aug-2024 | 15:33 | x64      |
| Msolap.dll                                          | 2022.160.43.233 | 8743880   | 23-Aug-2024 | 15:33 | x86      |
| Msolui.dll                                          | 2022.160.43.233 | 308264    | 23-Aug-2024 | 15:33 | x64      |
| Msolui.dll                                          | 2022.160.43.233 | 289840    | 23-Aug-2024 | 15:33 | x86      |
| Newtonsoft.json.dll                                 | 13.0.3.27908    | 722264    | 23-Aug-2024 | 15:35 | x86      |
| Parquetsharp.dll                                    | 0.0.0.0         | 412592    | 23-Aug-2024 | 15:35 | x64      |
| Parquetsharpnative.dll                              | 7.0.0.17        | 20091320  | 23-Aug-2024 | 15:35 | x64      |
| Powerbiextensions.dll                               | 2.127.602.0     | 11111344  | 23-Aug-2024 | 15:35 | x86      |
| Private_odbc32.dll                                  | 10.0.19041.1    | 735288    | 23-Aug-2024 | 15:35 | x64      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 23-Aug-2024 | 15:35 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4145.2 | 137272    | 23-Aug-2024 | 15:35 | x64      |
| Sqlceip.exe                                         | 16.0.4145.2     | 300984    | 23-Aug-2024 | 15:35 | x86      |
| Sqldumper.exe                                       | 2022.160.4145.2 | 448552    | 23-Aug-2024 | 15:35 | x64      |
| Sqldumper.exe                                       | 2022.160.4145.2 | 378920    | 23-Aug-2024 | 15:35 | x86      |
| System.identitymodel.tokens.jwt.dll                 | 6.35.0.41201    | 77248     | 23-Aug-2024 | 15:35 | x86      |
| System.spatial.netfx35.dll                          | 5.7.0.62516     | 118704    | 23-Aug-2024 | 15:35 | x86      |
| Tmapi.dll                                           | 2022.160.43.233 | 5884480   | 23-Aug-2024 | 15:33 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.233 | 5575216   | 23-Aug-2024 | 15:33 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.233 | 1481264   | 23-Aug-2024 | 15:33 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.233 | 7198264   | 23-Aug-2024 | 15:33 | x64      |
| Xmsrv.dll                                           | 2022.160.43.233 | 26593232  | 23-Aug-2024 | 15:33 | x64      |
| Xmsrv.dll                                           | 2022.160.43.233 | 35895856  | 23-Aug-2024 | 15:34 | x86      |

SQL Server 2022 Database Services Common Core

|                  File name                 |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4145.2 | 104488    | 23-Aug-2024 | 15:35 | x64      |
| Instapi150.dll                             | 2022.160.4145.2 | 79912     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.233     | 2633784   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.233     | 2633776   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.233     | 2933296   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.233     | 2323520   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4145.2 | 104488    | 23-Aug-2024 | 15:35 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4145.2 | 92200     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4145.2     | 554944    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4145.2     | 555080    | 23-Aug-2024 | 15:35 | x86      |
| Msasxpress.dll                             | 2022.160.43.233 | 27696     | 23-Aug-2024 | 15:35 | x86      |
| Msasxpress.dll                             | 2022.160.43.233 | 32816     | 23-Aug-2024 | 15:35 | x64      |
| Sql_common_core_keyfile.dll                | 2022.160.4145.2 | 137272    | 23-Aug-2024 | 15:35 | x64      |
| Sqldumper.exe                              | 2022.160.4145.2 | 448552    | 23-Aug-2024 | 15:35 | x64      |
| Sqldumper.exe                              | 2022.160.4145.2 | 378920    | 23-Aug-2024 | 15:35 | x86      |
| Sqlmgmprovider.dll                         | 2022.160.4145.2 | 456744    | 23-Aug-2024 | 15:35 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4145.2 | 395304    | 23-Aug-2024 | 15:35 | x86      |

SQL Server 2022 Data Quality Client

|             File name            |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.infra.dll | 16.0.4145.2     | 309288    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.ssdqs.studio.views.dll | 16.0.4145.2     | 2070464   | 23-Aug-2024 | 15:35 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4145.2 | 137272    | 23-Aug-2024 | 15:35 | x64      |

SQL Server 2022 Data Quality

|         File name         | File version | File size |     Date    |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4145.2  | 600104    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4145.2  | 174016    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4145.2  | 174152    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4145.2  | 1857608   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4145.2  | 370752    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4145.2  | 370768    | 23-Aug-2024 | 15:35 | x86      |

SQL Server 2022 Database Services Core Instance

|                   File name                  |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Adal.dll                                     | 3.6.1.64359     | 1618832   | 23-Aug-2024 | 16:28 | x64      |
| Adalsqlrda.dll                               | 3.6.1.64359     | 1618832   | 23-Aug-2024 | 16:28 | x64      |
| Aetm-enclave-simulator.dll                   | 2022.160.4145.2 | 5994536   | 23-Aug-2024 | 16:28 | x64      |
| Aetm-enclave.dll                             | 2022.160.4145.2 | 5959672   | 23-Aug-2024 | 16:28 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4145.2 | 6194800   | 23-Aug-2024 | 16:28 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4145.2 | 6160568   | 23-Aug-2024 | 16:28 | x64      |
| Dcexec.exe                                   | 2022.160.4145.2 | 96296     | 23-Aug-2024 | 16:28 | x64      |
| Fssres.dll                                   | 2022.160.4145.2 | 100392    | 23-Aug-2024 | 16:28 | x64      |
| Hadrres.dll                                  | 2022.160.4145.2 | 227384    | 23-Aug-2024 | 16:28 | x64      |
| Hkcompile.dll                                | 2022.160.4145.2 | 1427496   | 23-Aug-2024 | 16:28 | x64      |
| Hkengine.dll                                 | 2022.160.4145.2 | 5769288   | 23-Aug-2024 | 16:28 | x64      |
| Hkruntime.dll                                | 2022.160.4145.2 | 190544    | 23-Aug-2024 | 16:28 | x64      |
| Hktempdb.dll                                 | 2022.160.4145.2 | 71752     | 23-Aug-2024 | 16:28 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.233     | 2322480   | 23-Aug-2024 | 16:28 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4145.2 | 333896    | 23-Aug-2024 | 16:28 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4145.2 | 96320     | 23-Aug-2024 | 16:28 | x64      |
| Odsole70.rll                                 | 16.0.4145.2     | 30800     | 23-Aug-2024 | 16:28 | x64      |
| Odsole70.rll                                 | 16.0.4145.2     | 38984     | 23-Aug-2024 | 16:28 | x64      |
| Odsole70.rll                                 | 16.0.4145.2     | 34752     | 23-Aug-2024 | 16:28 | x64      |
| Odsole70.rll                                 | 16.0.4145.2     | 38984     | 23-Aug-2024 | 16:28 | x64      |
| Odsole70.rll                                 | 16.0.4145.2     | 38976     | 23-Aug-2024 | 16:28 | x64      |
| Odsole70.rll                                 | 16.0.4145.2     | 30792     | 23-Aug-2024 | 16:28 | x64      |
| Odsole70.rll                                 | 16.0.4145.2     | 30784     | 23-Aug-2024 | 16:28 | x64      |
| Odsole70.rll                                 | 16.0.4145.2     | 34888     | 23-Aug-2024 | 16:28 | x64      |
| Odsole70.rll                                 | 16.0.4145.2     | 38848     | 23-Aug-2024 | 16:28 | x64      |
| Odsole70.rll                                 | 16.0.4145.2     | 30656     | 23-Aug-2024 | 16:28 | x64      |
| Odsole70.rll                                 | 16.0.4145.2     | 38984     | 23-Aug-2024 | 16:28 | x64      |
| Qds.dll                                      | 2022.160.4145.2 | 1808424   | 23-Aug-2024 | 16:28 | x64      |
| Rsfxft.dll                                   | 2022.160.4145.2 | 55336     | 23-Aug-2024 | 16:28 | x64      |
| Secforwarder.dll                             | 2022.160.4145.2 | 84048     | 23-Aug-2024 | 16:28 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4145.2 | 137272    | 23-Aug-2024 | 16:28 | x64      |
| Sqlaamss.dll                                 | 2022.160.4145.2 | 120888    | 23-Aug-2024 | 16:28 | x64      |
| Sqlaccess.dll                                | 2022.160.4145.2 | 444456    | 23-Aug-2024 | 16:28 | x64      |
| Sqlagent.exe                                 | 2022.160.4145.2 | 723016    | 23-Aug-2024 | 16:28 | x64      |
| Sqlceip.exe                                  | 16.0.4145.2     | 300984    | 23-Aug-2024 | 16:28 | x86      |
| Sqlcmdss.dll                                 | 2022.160.4145.2 | 104488    | 23-Aug-2024 | 16:28 | x64      |
| Sqlctr160.dll                                | 2022.160.4145.2 | 157776    | 23-Aug-2024 | 16:28 | x64      |
| Sqlctr160.dll                                | 2022.160.4145.2 | 129064    | 23-Aug-2024 | 16:28 | x86      |
| Sqldk.dll                                    | 2022.160.4145.2 | 4024272   | 23-Aug-2024 | 16:28 | x64      |
| Sqldtsss.dll                                 | 2022.160.4145.2 | 120904    | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 1755176   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 3864528   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 4081616   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 4593720   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 4724776   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 3766312   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 3954728   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 4593704   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 4421672   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 4495416   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 2455592   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 2398248   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 4278312   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 3913768   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 4433960   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 4225064   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 4208680   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 3991592   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 3868712   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 1693752   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 4319272   | 23-Aug-2024 | 16:28 | x64      |
| Sqlevn70.rll                                 | 2022.160.4145.2 | 4458536   | 23-Aug-2024 | 16:28 | x64      |
| Sqliosim.com                                 | 2022.160.4145.2 | 387112    | 23-Aug-2024 | 16:28 | x64      |
| Sqliosim.exe                                 | 2022.160.4145.2 | 3057720   | 23-Aug-2024 | 16:28 | x64      |
| Sqllang.dll                                  | 2022.160.4145.2 | 48814120  | 23-Aug-2024 | 16:28 | x64      |
| Sqlmin.dll                                   | 2022.160.4145.2 | 51271624  | 23-Aug-2024 | 16:28 | x64      |
| Sqlolapss.dll                                | 2022.160.4145.2 | 116776    | 23-Aug-2024 | 16:28 | x64      |
| Sqlos.dll                                    | 2022.160.4145.2 | 51240     | 23-Aug-2024 | 16:28 | x64      |
| Sqlpowershellss.dll                          | 2022.160.4145.2 | 100408    | 23-Aug-2024 | 16:28 | x64      |
| Sqlrepss.dll                                 | 2022.160.4145.2 | 145448    | 23-Aug-2024 | 16:28 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4145.2 | 51256     | 23-Aug-2024 | 16:28 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4145.2 | 5834792   | 23-Aug-2024 | 16:28 | x64      |
| Sqlservr.exe                                 | 2022.160.4145.2 | 723000    | 23-Aug-2024 | 16:28 | x64      |
| Sqlsvc.dll                                   | 2022.160.4145.2 | 194632    | 23-Aug-2024 | 16:28 | x64      |
| Sqltses.dll                                  | 2022.160.4145.2 | 10668072  | 23-Aug-2024 | 16:28 | x64      |
| Sqsrvres.dll                                 | 2022.160.4145.2 | 305208    | 23-Aug-2024 | 16:28 | x64      |
| Svl.dll                                      | 2022.160.4145.2 | 247848    | 23-Aug-2024 | 16:28 | x64      |
| Xe.dll                                       | 2022.160.4145.2 | 718888    | 23-Aug-2024 | 16:28 | x64      |
| Xpqueue.dll                                  | 2022.160.4145.2 | 100288    | 23-Aug-2024 | 16:28 | x64      |
| Xpstar.dll                                   | 2022.160.4145.2 | 534608    | 23-Aug-2024 | 16:28 | x64      |

SQL Server 2022 Database Services Core Shared

|                       File name                      |   File version   | File size |     Date    |  Time | Platform |
|:----------------------------------------------------:|:----------------:|:---------:|:-----------:|:-----:|:--------:|
| Azure.core.dll                                       | 1.3600.23.56006  | 384432    | 23-Aug-2024 | 15:35 | x86      |
| Azure.identity.dll                                   | 1.1000.423.56303 | 334768    | 23-Aug-2024 | 15:35 | x86      |
| Bcp.exe                                              | 2022.160.4145.2  | 141352    | 23-Aug-2024 | 15:35 | x64      |
| Commanddest.dll                                      | 2022.160.4145.2  | 272440    | 23-Aug-2024 | 15:35 | x64      |
| Datacollectortasks.dll                               | 2022.160.4145.2  | 227368    | 23-Aug-2024 | 15:35 | x64      |
| Distrib.exe                                          | 2022.160.4145.2  | 260160    | 23-Aug-2024 | 15:35 | x64      |
| Dteparse.dll                                         | 2022.160.4145.2  | 133176    | 23-Aug-2024 | 15:35 | x64      |
| Dteparsemgd.dll                                      | 2022.160.4145.2  | 178256    | 23-Aug-2024 | 15:35 | x64      |
| Dtepkg.dll                                           | 2022.160.4145.2  | 153536    | 23-Aug-2024 | 15:35 | x64      |
| Dtexec.exe                                           | 2022.160.4145.2  | 76840     | 23-Aug-2024 | 15:35 | x64      |
| Dts.dll                                              | 2022.160.4145.2  | 3266600   | 23-Aug-2024 | 15:35 | x64      |
| Dtscomexpreval.dll                                   | 2022.160.4145.2  | 493608    | 23-Aug-2024 | 15:35 | x64      |
| Dtsconn.dll                                          | 2022.160.4145.2  | 550992    | 23-Aug-2024 | 15:35 | x64      |
| Dtshost.exe                                          | 2022.160.4145.2  | 120360    | 23-Aug-2024 | 15:35 | x64      |
| Dtslog.dll                                           | 2022.160.4145.2  | 137272    | 23-Aug-2024 | 15:35 | x64      |
| Dtspipeline.dll                                      | 2022.160.4145.2  | 1337400   | 23-Aug-2024 | 15:35 | x64      |
| Dtuparse.dll                                         | 2022.160.4145.2  | 104488    | 23-Aug-2024 | 15:35 | x64      |
| Dtutil.exe                                           | 2022.160.4145.2  | 166352    | 23-Aug-2024 | 15:35 | x64      |
| Exceldest.dll                                        | 2022.160.4145.2  | 284712    | 23-Aug-2024 | 15:35 | x64      |
| Excelsrc.dll                                         | 2022.160.4145.2  | 305192    | 23-Aug-2024 | 15:35 | x64      |
| Execpackagetask.dll                                  | 2022.160.4145.2  | 182312    | 23-Aug-2024 | 15:35 | x64      |
| Flatfiledest.dll                                     | 2022.160.4145.2  | 423976    | 23-Aug-2024 | 15:35 | x64      |
| Flatfilesrc.dll                                      | 2022.160.4145.2  | 440360    | 23-Aug-2024 | 15:35 | x64      |
| Logread.exe                                          | 2022.160.4145.2  | 792616    | 23-Aug-2024 | 15:35 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.233      | 2933816   | 23-Aug-2024 | 15:33 | x86      |
| Microsoft.bcl.asyncinterfaces.dll                    | 6.0.21.52210     | 22144     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.sqlclient.dll                         | 5.13.23292.1     | 2048632   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.data.sqlclient.sni.dll                     | 5.1.1.0          | 504872    | 23-Aug-2024 | 15:35 | x64      |
| Microsoft.data.tools.sql.batchparser.dll             | 17.100.23.0      | 42416     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4145.2      | 30656     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.identity.client.dll                        | 4.56.0.0         | 1652320   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.identity.client.extensions.msal.dll        | 4.56.0.0         | 66552     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.identitymodel.abstractions.dll             | 6.24.0.31013     | 18864     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 6.24.0.31013     | 85424     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.identitymodel.logging.dll                  | 6.24.0.31013     | 34224     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.identitymodel.protocols.dll                | 6.24.0.31013     | 38288     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 6.24.0.31013     | 114048    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 6.24.0.31013     | 986032    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.sqlserver.connectioninfo.dll               | 17.100.23.0      | 126496    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.sqlserver.dmf.common.dll                   | 17.100.23.0      | 63520     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll         | 16.0.4145.2      | 391232    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.sqlserver.management.sdk.sfc.dll           | 17.100.23.0      | 513464    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4145.2  | 1718312   | 23-Aug-2024 | 15:35 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4145.2      | 555080    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.sqlserver.servicebrokerenum.dll            | 17.100.23.0      | 37920     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.sqlserver.smo.dll                          | 17.100.23.0      | 4451872   | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.sqlserver.smoextended.dll                  | 17.100.23.0      | 161208    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.sqlserver.sqlclrprovider.dll               | 17.100.23.0      | 21536     | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.sqlserver.sqlenum.dll                      | 17.100.23.0      | 1587744   | 23-Aug-2024 | 15:35 | x86      |
| Msdtssrvrutil.dll                                    | 2022.160.4145.2  | 124984    | 23-Aug-2024 | 15:35 | x64      |
| Msgprox.dll                                          | 2022.160.4145.2  | 313384    | 23-Aug-2024 | 15:35 | x64      |
| Msoledbsql.dll                                       | 2018.187.4.0     | 2750472   | 23-Aug-2024 | 15:35 | x64      |
| Msoledbsql.dll                                       | 2018.187.4.0     | 153608    | 23-Aug-2024 | 15:35 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517     | 704408    | 23-Aug-2024 | 15:35 | x86      |
| Oledbdest.dll                                        | 2022.160.4145.2  | 288824    | 23-Aug-2024 | 15:35 | x64      |
| Oledbsrc.dll                                         | 2022.160.4145.2  | 313384    | 23-Aug-2024 | 15:35 | x64      |
| Qrdrsvc.exe                                          | 2022.160.4145.2  | 526392    | 23-Aug-2024 | 15:35 | x64      |
| Rawdest.dll                                          | 2022.160.4145.2  | 227384    | 23-Aug-2024 | 15:35 | x64      |
| Rawsource.dll                                        | 2022.160.4145.2  | 215096    | 23-Aug-2024 | 15:35 | x64      |
| Rdistcom.dll                                         | 2022.160.4145.2  | 944200    | 23-Aug-2024 | 15:35 | x64      |
| Recordsetdest.dll                                    | 2022.160.4145.2  | 206888    | 23-Aug-2024 | 15:35 | x64      |
| Repldp.dll                                           | 2022.160.4145.2  | 337976    | 23-Aug-2024 | 15:35 | x64      |
| Replerrx.dll                                         | 2022.160.4145.2  | 198712    | 23-Aug-2024 | 15:35 | x64      |
| Replisapi.dll                                        | 2022.160.4145.2  | 419920    | 23-Aug-2024 | 15:35 | x64      |
| Replmerg.exe                                         | 2022.160.4145.2  | 596024    | 23-Aug-2024 | 15:35 | x64      |
| Replprov.dll                                         | 2022.160.4145.2  | 890936    | 23-Aug-2024 | 15:35 | x64      |
| Replrec.dll                                          | 2022.160.4145.2  | 1058856   | 23-Aug-2024 | 15:35 | x64      |
| Replsub.dll                                          | 2022.160.4145.2  | 501800    | 23-Aug-2024 | 15:35 | x64      |
| Spresolv.dll                                         | 2022.160.4145.2  | 301096    | 23-Aug-2024 | 15:35 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4145.2  | 137272    | 23-Aug-2024 | 15:35 | x64      |
| Sqlcmd.exe                                           | 2022.160.4145.2  | 276520    | 23-Aug-2024 | 15:35 | x64      |
| Sqldiag.exe                                          | 2022.160.4145.2  | 1140776   | 23-Aug-2024 | 15:35 | x64      |
| Sqldistx.dll                                         | 2022.160.4145.2  | 268328    | 23-Aug-2024 | 15:35 | x64      |
| Sqlmergx.dll                                         | 2022.160.4145.2  | 423976    | 23-Aug-2024 | 15:35 | x64      |
| Sqlnclirda11.dll                                     | 2011.110.5069.66 | 3478208   | 23-Aug-2024 | 15:35 | x64      |
| Sqlsvc.dll                                           | 2022.160.4145.2  | 194632    | 23-Aug-2024 | 15:35 | x64      |
| Sqlsvc.dll                                           | 2022.160.4145.2  | 153640    | 23-Aug-2024 | 15:35 | x86      |
| Sqltaskconnections.dll                               | 2022.160.4145.2  | 211000    | 23-Aug-2024 | 15:35 | x64      |
| Ssradd.dll                                           | 2022.160.4145.2  | 100288    | 23-Aug-2024 | 15:35 | x64      |
| Ssravg.dll                                           | 2022.160.4145.2  | 100392    | 23-Aug-2024 | 15:35 | x64      |
| Ssrmax.dll                                           | 2022.160.4145.2  | 100288    | 23-Aug-2024 | 15:35 | x64      |
| Ssrmin.dll                                           | 2022.160.4145.2  | 100392    | 23-Aug-2024 | 15:35 | x64      |
| System.diagnostics.diagnosticsource.dll              | 7.0.423.11508    | 173232    | 23-Aug-2024 | 15:35 | x86      |
| System.memory.dll                                    | 4.6.31308.1      | 142240    | 23-Aug-2024 | 15:35 | x86      |
| System.runtime.compilerservices.unsafe.dll           | 6.0.21.52210     | 18024     | 23-Aug-2024 | 15:35 | x86      |
| System.security.cryptography.protecteddata.dll       | 7.0.22.51805     | 21640     | 23-Aug-2024 | 15:35 | x86      |
| Txagg.dll                                            | 2022.160.4145.2  | 395304    | 23-Aug-2024 | 15:35 | x64      |
| Txbdd.dll                                            | 2022.160.4145.2  | 190504    | 23-Aug-2024 | 15:35 | x64      |
| Txdatacollector.dll                                  | 2022.160.4145.2  | 469032    | 23-Aug-2024 | 15:35 | x64      |
| Txdataconvert.dll                                    | 2022.160.4145.2  | 333776    | 23-Aug-2024 | 15:35 | x64      |
| Txderived.dll                                        | 2022.160.4145.2  | 632872    | 23-Aug-2024 | 15:35 | x64      |
| Txlookup.dll                                         | 2022.160.4145.2  | 608328    | 23-Aug-2024 | 15:35 | x64      |
| Txmerge.dll                                          | 2022.160.4145.2  | 243768    | 23-Aug-2024 | 15:35 | x64      |
| Txmergejoin.dll                                      | 2022.160.4145.2  | 301096    | 23-Aug-2024 | 15:35 | x64      |
| Txmulticast.dll                                      | 2022.160.4145.2  | 145464    | 23-Aug-2024 | 15:35 | x64      |
| Txrowcount.dll                                       | 2022.160.4145.2  | 145448    | 23-Aug-2024 | 15:35 | x64      |
| Txsort.dll                                           | 2022.160.4145.2  | 276520    | 23-Aug-2024 | 15:35 | x64      |
| Txsplit.dll                                          | 2022.160.4145.2  | 620584    | 23-Aug-2024 | 15:35 | x64      |
| Txunionall.dll                                       | 2022.160.4145.2  | 194600    | 23-Aug-2024 | 15:35 | x64      |
| Xe.dll                                               | 2022.160.4145.2  | 718888    | 23-Aug-2024 | 15:35 | x64      |

SQL Server 2022 sql_extensibility

|           File name           |   File version  | File size |     Date    |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4145.2 | 100288    | 23-Aug-2024 | 15:35 | x64      |
| Exthost.exe                   | 2022.160.4145.2 | 247848    | 23-Aug-2024 | 15:35 | x64      |
| Launchpad.exe                 | 2022.160.4145.2 | 1452072   | 23-Aug-2024 | 15:35 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4145.2 | 137272    | 23-Aug-2024 | 15:35 | x64      |
| Sqlsatellite.dll              | 2022.160.4145.2 | 1255488   | 23-Aug-2024 | 15:35 | x64      |

SQL Server 2022 Full-Text Engine

|         File name        |   File version  | File size |     Date    |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4145.2 | 710592    | 23-Aug-2024 | 15:35 | x64      |
| Fdhost.exe               | 2022.160.4145.2 | 153536    | 23-Aug-2024 | 15:35 | x64      |
| Fdlauncher.exe           | 2022.160.4145.2 | 100392    | 23-Aug-2024 | 15:35 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4145.2 | 137272    | 23-Aug-2024 | 15:35 | x64      |

SQL Server 2022 Integration Services

|                           File name                           |   File version  | File size |     Date    |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 23-Aug-2024 | 15:35 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 23-Aug-2024 | 15:35 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 23-Aug-2024 | 15:35 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 23-Aug-2024 | 15:35 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 23-Aug-2024 | 15:35 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 23-Aug-2024 | 15:35 | x86      |
| Commanddest.dll                                               | 2022.160.4145.2 | 272440    | 23-Aug-2024 | 15:35 | x64      |
| Commanddest.dll                                               | 2022.160.4145.2 | 231464    | 23-Aug-2024 | 15:35 | x86      |
| Dteparse.dll                                                  | 2022.160.4145.2 | 133176    | 23-Aug-2024 | 15:35 | x64      |
| Dteparse.dll                                                  | 2022.160.4145.2 | 116776    | 23-Aug-2024 | 15:35 | x86      |
| Dteparsemgd.dll                                               | 2022.160.4145.2 | 178256    | 23-Aug-2024 | 15:35 | x64      |
| Dteparsemgd.dll                                               | 2022.160.4145.2 | 165840    | 23-Aug-2024 | 15:35 | x86      |
| Dtepkg.dll                                                    | 2022.160.4145.2 | 153536    | 23-Aug-2024 | 15:35 | x64      |
| Dtepkg.dll                                                    | 2022.160.4145.2 | 129096    | 23-Aug-2024 | 15:35 | x86      |
| Dtexec.exe                                                    | 2022.160.4145.2 | 76840     | 23-Aug-2024 | 15:35 | x64      |
| Dtexec.exe                                                    | 2022.160.4145.2 | 65064     | 23-Aug-2024 | 15:35 | x86      |
| Dts.dll                                                       | 2022.160.4145.2 | 3266600   | 23-Aug-2024 | 15:35 | x64      |
| Dts.dll                                                       | 2022.160.4145.2 | 2860992   | 23-Aug-2024 | 15:35 | x86      |
| Dtscomexpreval.dll                                            | 2022.160.4145.2 | 493608    | 23-Aug-2024 | 15:35 | x64      |
| Dtscomexpreval.dll                                            | 2022.160.4145.2 | 444456    | 23-Aug-2024 | 15:35 | x86      |
| Dtsconn.dll                                                   | 2022.160.4145.2 | 550992    | 23-Aug-2024 | 15:35 | x64      |
| Dtsconn.dll                                                   | 2022.160.4145.2 | 464968    | 23-Aug-2024 | 15:35 | x86      |
| Dtsdebughost.exe                                              | 2022.160.4145.2 | 114728    | 23-Aug-2024 | 15:35 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4145.2 | 94760     | 23-Aug-2024 | 15:35 | x86      |
| Dtshost.exe                                                   | 2022.160.4145.2 | 120360    | 23-Aug-2024 | 15:35 | x64      |
| Dtshost.exe                                                   | 2022.160.4145.2 | 98344     | 23-Aug-2024 | 15:35 | x86      |
| Dtslog.dll                                                    | 2022.160.4145.2 | 137272    | 23-Aug-2024 | 15:35 | x64      |
| Dtslog.dll                                                    | 2022.160.4145.2 | 120768    | 23-Aug-2024 | 15:35 | x86      |
| Dtspipeline.dll                                               | 2022.160.4145.2 | 1337400   | 23-Aug-2024 | 15:35 | x64      |
| Dtspipeline.dll                                               | 2022.160.4145.2 | 1144784   | 23-Aug-2024 | 15:35 | x86      |
| Dtuparse.dll                                                  | 2022.160.4145.2 | 104488    | 23-Aug-2024 | 15:35 | x64      |
| Dtuparse.dll                                                  | 2022.160.4145.2 | 88120     | 23-Aug-2024 | 15:35 | x86      |
| Dtutil.exe                                                    | 2022.160.4145.2 | 166352    | 23-Aug-2024 | 15:35 | x64      |
| Dtutil.exe                                                    | 2022.160.4145.2 | 142408    | 23-Aug-2024 | 15:35 | x86      |
| Exceldest.dll                                                 | 2022.160.4145.2 | 284712    | 23-Aug-2024 | 15:35 | x64      |
| Exceldest.dll                                                 | 2022.160.4145.2 | 247848    | 23-Aug-2024 | 15:35 | x86      |
| Excelsrc.dll                                                  | 2022.160.4145.2 | 305192    | 23-Aug-2024 | 15:35 | x64      |
| Excelsrc.dll                                                  | 2022.160.4145.2 | 264232    | 23-Aug-2024 | 15:35 | x86      |
| Execpackagetask.dll                                           | 2022.160.4145.2 | 182312    | 23-Aug-2024 | 15:35 | x64      |
| Execpackagetask.dll                                           | 2022.160.4145.2 | 149544    | 23-Aug-2024 | 15:35 | x86      |
| Flatfiledest.dll                                              | 2022.160.4145.2 | 423976    | 23-Aug-2024 | 15:35 | x64      |
| Flatfiledest.dll                                              | 2022.160.4145.2 | 374824    | 23-Aug-2024 | 15:35 | x86      |
| Flatfilesrc.dll                                               | 2022.160.4145.2 | 440360    | 23-Aug-2024 | 15:35 | x64      |
| Flatfilesrc.dll                                               | 2022.160.4145.2 | 391224    | 23-Aug-2024 | 15:35 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4145.2     | 120872    | 23-Aug-2024 | 15:35 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4145.2     | 120912    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.233     | 2933816   | 23-Aug-2024 | 15:33 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.233     | 2933824   | 23-Aug-2024 | 15:34 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4145.2     | 510008    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4145.2     | 509888    | 23-Aug-2024 | 15:35 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 16.0.4145.2     | 391232    | 23-Aug-2024 | 15:35 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4145.2     | 219176    | 23-Aug-2024 | 15:35 | x64      |
| Msdtssrvrutil.dll                                             | 2022.160.4145.2 | 124984    | 23-Aug-2024 | 15:35 | x64      |
| Msdtssrvrutil.dll                                             | 2022.160.4145.2 | 100392    | 23-Aug-2024 | 15:35 | x86      |
| Msmdpp.dll                                                    | 2022.160.43.233 | 10164160  | 23-Aug-2024 | 15:33 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 23-Aug-2024 | 15:33 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 23-Aug-2024 | 15:35 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 23-Aug-2024 | 15:35 | x86      |
| Odbcdest.dll                                                  | 2022.160.4145.2 | 383032    | 23-Aug-2024 | 15:35 | x64      |
| Odbcdest.dll                                                  | 2022.160.4145.2 | 342056    | 23-Aug-2024 | 15:35 | x86      |
| Odbcsrc.dll                                                   | 2022.160.4145.2 | 399400    | 23-Aug-2024 | 15:35 | x64      |
| Odbcsrc.dll                                                   | 2022.160.4145.2 | 350248    | 23-Aug-2024 | 15:35 | x86      |
| Oledbdest.dll                                                 | 2022.160.4145.2 | 288824    | 23-Aug-2024 | 15:35 | x64      |
| Oledbdest.dll                                                 | 2022.160.4145.2 | 247848    | 23-Aug-2024 | 15:35 | x86      |
| Oledbsrc.dll                                                  | 2022.160.4145.2 | 313384    | 23-Aug-2024 | 15:35 | x64      |
| Oledbsrc.dll                                                  | 2022.160.4145.2 | 268328    | 23-Aug-2024 | 15:35 | x86      |
| Rawdest.dll                                                   | 2022.160.4145.2 | 227384    | 23-Aug-2024 | 15:35 | x64      |
| Rawdest.dll                                                   | 2022.160.4145.2 | 190520    | 23-Aug-2024 | 15:35 | x86      |
| Rawsource.dll                                                 | 2022.160.4145.2 | 215096    | 23-Aug-2024 | 15:35 | x64      |
| Rawsource.dll                                                 | 2022.160.4145.2 | 186424    | 23-Aug-2024 | 15:35 | x86      |
| Recordsetdest.dll                                             | 2022.160.4145.2 | 206888    | 23-Aug-2024 | 15:35 | x64      |
| Recordsetdest.dll                                             | 2022.160.4145.2 | 174120    | 23-Aug-2024 | 15:35 | x86      |
| Sql_is_keyfile.dll                                            | 2022.160.4145.2 | 137272    | 23-Aug-2024 | 15:35 | x64      |
| Sqlceip.exe                                                   | 16.0.4145.2     | 300984    | 23-Aug-2024 | 15:35 | x86      |
| Sqldest.dll                                                   | 2022.160.4145.2 | 288808    | 23-Aug-2024 | 15:35 | x64      |
| Sqldest.dll                                                   | 2022.160.4145.2 | 256040    | 23-Aug-2024 | 15:35 | x86      |
| Sqltaskconnections.dll                                        | 2022.160.4145.2 | 211000    | 23-Aug-2024 | 15:35 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4145.2 | 174120    | 23-Aug-2024 | 15:35 | x86      |
| Txagg.dll                                                     | 2022.160.4145.2 | 395304    | 23-Aug-2024 | 15:35 | x64      |
| Txagg.dll                                                     | 2022.160.4145.2 | 346152    | 23-Aug-2024 | 15:35 | x86      |
| Txbdd.dll                                                     | 2022.160.4145.2 | 190504    | 23-Aug-2024 | 15:35 | x64      |
| Txbdd.dll                                                     | 2022.160.4145.2 | 149544    | 23-Aug-2024 | 15:35 | x86      |
| Txbestmatch.dll                                               | 2022.160.4145.2 | 661568    | 23-Aug-2024 | 15:35 | x64      |
| Txbestmatch.dll                                               | 2022.160.4145.2 | 567248    | 23-Aug-2024 | 15:35 | x86      |
| Txcache.dll                                                   | 2022.160.4145.2 | 202792    | 23-Aug-2024 | 15:35 | x64      |
| Txcache.dll                                                   | 2022.160.4145.2 | 170024    | 23-Aug-2024 | 15:35 | x86      |
| Txcharmap.dll                                                 | 2022.160.4145.2 | 325672    | 23-Aug-2024 | 15:35 | x64      |
| Txcharmap.dll                                                 | 2022.160.4145.2 | 280656    | 23-Aug-2024 | 15:35 | x86      |
| Txcopymap.dll                                                 | 2022.160.4145.2 | 202792    | 23-Aug-2024 | 15:35 | x64      |
| Txcopymap.dll                                                 | 2022.160.4145.2 | 165928    | 23-Aug-2024 | 15:35 | x86      |
| Txdataconvert.dll                                             | 2022.160.4145.2 | 333776    | 23-Aug-2024 | 15:35 | x64      |
| Txdataconvert.dll                                             | 2022.160.4145.2 | 288840    | 23-Aug-2024 | 15:35 | x86      |
| Txderived.dll                                                 | 2022.160.4145.2 | 632872    | 23-Aug-2024 | 15:35 | x64      |
| Txderived.dll                                                 | 2022.160.4145.2 | 559160    | 23-Aug-2024 | 15:35 | x86      |
| Txfileextractor.dll                                           | 2022.160.4145.2 | 219176    | 23-Aug-2024 | 15:35 | x64      |
| Txfileextractor.dll                                           | 2022.160.4145.2 | 186408    | 23-Aug-2024 | 15:35 | x86      |
| Txfileinserter.dll                                            | 2022.160.4145.2 | 219192    | 23-Aug-2024 | 15:35 | x64      |
| Txfileinserter.dll                                            | 2022.160.4145.2 | 186408    | 23-Aug-2024 | 15:35 | x86      |
| Txgroupdups.dll                                               | 2022.160.4145.2 | 403496    | 23-Aug-2024 | 15:35 | x64      |
| Txgroupdups.dll                                               | 2022.160.4145.2 | 354360    | 23-Aug-2024 | 15:35 | x86      |
| Txlineage.dll                                                 | 2022.160.4145.2 | 157736    | 23-Aug-2024 | 15:35 | x64      |
| Txlineage.dll                                                 | 2022.160.4145.2 | 129096    | 23-Aug-2024 | 15:35 | x86      |
| Txlookup.dll                                                  | 2022.160.4145.2 | 608328    | 23-Aug-2024 | 15:35 | x64      |
| Txlookup.dll                                                  | 2022.160.4145.2 | 522280    | 23-Aug-2024 | 15:35 | x86      |
| Txmerge.dll                                                   | 2022.160.4145.2 | 243768    | 23-Aug-2024 | 15:35 | x64      |
| Txmerge.dll                                                   | 2022.160.4145.2 | 194600    | 23-Aug-2024 | 15:35 | x86      |
| Txmergejoin.dll                                               | 2022.160.4145.2 | 301096    | 23-Aug-2024 | 15:35 | x64      |
| Txmergejoin.dll                                               | 2022.160.4145.2 | 256040    | 23-Aug-2024 | 15:35 | x86      |
| Txmulticast.dll                                               | 2022.160.4145.2 | 145464    | 23-Aug-2024 | 15:35 | x64      |
| Txmulticast.dll                                               | 2022.160.4145.2 | 116776    | 23-Aug-2024 | 15:35 | x86      |
| Txpivot.dll                                                   | 2022.160.4145.2 | 239656    | 23-Aug-2024 | 15:35 | x64      |
| Txpivot.dll                                                   | 2022.160.4145.2 | 198696    | 23-Aug-2024 | 15:35 | x86      |
| Txrowcount.dll                                                | 2022.160.4145.2 | 145448    | 23-Aug-2024 | 15:35 | x64      |
| Txrowcount.dll                                                | 2022.160.4145.2 | 116776    | 23-Aug-2024 | 15:35 | x86      |
| Txsampling.dll                                                | 2022.160.4145.2 | 186408    | 23-Aug-2024 | 15:35 | x64      |
| Txsampling.dll                                                | 2022.160.4145.2 | 153656    | 23-Aug-2024 | 15:35 | x86      |
| Txscd.dll                                                     | 2022.160.4145.2 | 235560    | 23-Aug-2024 | 15:35 | x64      |
| Txscd.dll                                                     | 2022.160.4145.2 | 198696    | 23-Aug-2024 | 15:35 | x86      |
| Txsort.dll                                                    | 2022.160.4145.2 | 276520    | 23-Aug-2024 | 15:35 | x64      |
| Txsort.dll                                                    | 2022.160.4145.2 | 231464    | 23-Aug-2024 | 15:35 | x86      |
| Txsplit.dll                                                   | 2022.160.4145.2 | 620584    | 23-Aug-2024 | 15:35 | x64      |
| Txsplit.dll                                                   | 2022.160.4145.2 | 550952    | 23-Aug-2024 | 15:35 | x86      |
| Txtermextraction.dll                                          | 2022.160.4145.2 | 8701992   | 23-Aug-2024 | 15:35 | x64      |
| Txtermextraction.dll                                          | 2022.160.4145.2 | 8648744   | 23-Aug-2024 | 15:35 | x86      |
| Txtermlookup.dll                                              | 2022.160.4145.2 | 4184120   | 23-Aug-2024 | 15:35 | x64      |
| Txtermlookup.dll                                              | 2022.160.4145.2 | 4139048   | 23-Aug-2024 | 15:35 | x86      |
| Txunionall.dll                                                | 2022.160.4145.2 | 194600    | 23-Aug-2024 | 15:35 | x64      |
| Txunionall.dll                                                | 2022.160.4145.2 | 153640    | 23-Aug-2024 | 15:35 | x86      |
| Txunpivot.dll                                                 | 2022.160.4145.2 | 215080    | 23-Aug-2024 | 15:35 | x64      |
| Txunpivot.dll                                                 | 2022.160.4145.2 | 178216    | 23-Aug-2024 | 15:35 | x86      |
| Xe.dll                                                        | 2022.160.4145.2 | 718888    | 23-Aug-2024 | 15:35 | x64      |
| Xe.dll                                                        | 2022.160.4145.2 | 641064    | 23-Aug-2024 | 15:35 | x86      |

SQL Server 2022 sql_polybase_core_inst

|                               File name                              |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1037.0     | 559688    | 23-Aug-2024 | 16:10 | x86      |
| Dmsnative.dll                                                        | 2022.160.1037.0 | 152648    | 23-Aug-2024 | 16:10 | x64      |
| Dwengineservice.dll                                                  | 16.0.1037.0     | 45128     | 23-Aug-2024 | 16:10 | x86      |
| Instapi150.dll                                                       | 2022.160.4145.2 | 104488    | 23-Aug-2024 | 16:10 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1037.0     | 67656     | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1037.0     | 293448    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1037.0     | 1958360   | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1037.0     | 169544    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1037.0     | 647240    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1037.0     | 246344    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1037.0     | 139224    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1037.0     | 79944     | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1037.0     | 51272     | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1037.0     | 88536     | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1037.0     | 1129432   | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1037.0     | 80856     | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1037.0     | 70616     | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1037.0     | 35400     | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1037.0     | 30792     | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1037.0     | 46664     | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1037.0     | 21464     | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1037.0     | 26696     | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1037.0     | 131656    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1037.0     | 86600     | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1037.0     | 100936    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1037.0     | 293448    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 120280    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 138312    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 141272    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 137800    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 150600    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 139848    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 134728    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 176712    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 117832    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1037.0     | 136776    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1037.0     | 72776     | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1037.0     | 21976     | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1037.0     | 37448     | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1037.0     | 129096    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1037.0     | 3064904   | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1037.0     | 3955672   | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 118232    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 133080    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 137688    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 133592    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 148440    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 134104    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 130520    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 170968    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 115160    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1037.0     | 132064    | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1037.0     | 67552     | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1037.0     | 2682840   | 23-Aug-2024 | 16:10 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1037.0     | 2436568   | 23-Aug-2024 | 16:10 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4145.2 | 297000    | 23-Aug-2024 | 16:10 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4145.2 | 9078824   | 23-Aug-2024 | 16:10 | x64      |
| Secforwarder.dll                                                     | 2022.160.4145.2 | 84048     | 23-Aug-2024 | 16:10 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1037.0 | 61400     | 23-Aug-2024 | 16:10 | x64      |
| Sqldk.dll                                                            | 2022.160.4145.2 | 4024272   | 23-Aug-2024 | 16:10 | x64      |
| Sqldumper.exe                                                        | 2022.160.4145.2 | 448552    | 23-Aug-2024 | 16:10 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.2 | 1755176   | 23-Aug-2024 | 16:10 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.2 | 4593720   | 23-Aug-2024 | 16:10 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.2 | 3766312   | 23-Aug-2024 | 16:10 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.2 | 4593704   | 23-Aug-2024 | 16:10 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.2 | 4495416   | 23-Aug-2024 | 16:10 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.2 | 2455592   | 23-Aug-2024 | 16:10 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.2 | 2398248   | 23-Aug-2024 | 16:10 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.2 | 4225064   | 23-Aug-2024 | 16:10 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.2 | 4208680   | 23-Aug-2024 | 16:10 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.2 | 1693752   | 23-Aug-2024 | 16:10 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4145.2 | 4458536   | 23-Aug-2024 | 16:10 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.6.1   | 1898520   | 23-Aug-2024 | 16:10 | x64      |
| Sqlos.dll                                                            | 2022.160.4145.2 | 51240     | 23-Aug-2024 | 16:10 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1037.0 | 4841432   | 23-Aug-2024 | 16:10 | x64      |
| Sqltses.dll                                                          | 2022.160.4145.2 | 10668072  | 23-Aug-2024 | 16:10 | x64      |

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
