---
title: Cumulative update 14 for SQL Server 2022 (KB5038325)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 14 (KB5038325).
ms.date: 09/11/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5038325
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5038325 - Cumulative Update 14 for SQL Server 2022

_Release Date:_ &nbsp; July 23, 2024  
_Version:_ &nbsp; 16.0.4135.4

## Summary

This article describes Cumulative Update package 14 (CU14) for Microsoft SQL Server 2022. This update contains 12 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 13, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4135.4**, file version: **2022.160.4135.4**
- Analysis Services - Product version: **16.0.43.233**, file version: **2022.160.43.233**

## Known issues in this update

### Issue one: Patching error for secondary replicas in an availability group with databases enabled replication, CDC, or SSISDB

[!INCLUDE [patching-error-2022](../includes/patching-error-2022.md)]

### Issue two: SQL Server VSS Writer might fail to perform a backup because no database is available to freeze

When backup tools such as Azure Recovery Vault perform a backup on a virtual machine (VM), they might fail to achieve application consistency. There might not be any errors. The application runs fast without any backups being done. The SQL Server Volume Shadow Copy Service (VSS) Writer ends up in a non-retryable error state. If you enable SQL Server VSS Writer trace, you might see the following exception, which indicates there's no database to freeze, resulting in an unsuccessful snapshot:

```output
[0543739500,0x002948:011b4:0xb87fa68e] sqlwriter.yukon\sqllib\snapsql.cpp(1058): Snapshot::Prepare: Server PROD-SQL01 has no databases to freeze
```

Additionally, some databases might be detected with `Online:0`:

```output
[0543739390,0x002948:0x11b4:0xb87fa68e] sqlwriter.yukon\sqllib\snapsql.cpp(0408): FrozenServer::FindDatabases2000: Examining database <ReportServerTempDB>
Online:0 Standby:0 AutoClose:0 Closed:0
```

If you use Azure Recovery Vault, you might see an error like the following one in the event list:

```output
App-consistent recovery point generation failed.
```

The issue arises from a code change in SQL Server 2022 CU14 that checks if a database is online and ready to be frozen. The current solution is to roll back to SQL Server 2022 CU13 and perform the snapshot backup. For more information about how to roll back the package to a previous version, see [Uninstall a Cumulative Update from SQL Server](/sql/sql-server/install/uninstall-a-cumulative-update-from-sql-server).

This issue is fixed in [SQL Server 2022 CU15](cumulativeupdate15.md#3459086).

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description | Fix area| Component | Platform |
|----------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------|-----------------------------------------|----------|
| <a id=3217208>[3217208](#3217208) </a> | Starting with SQL Server 2022 (16.x) CU14, container images include the new [mssql-tools18 package](/sql/linux/sql-server-linux-setup-tools#install-tools-on-linux). The previous directory */opt/mssql-tools/bin* is phased out. The new directory for Microsoft ODBC 18 tools is */opt/mssql-tools18/bin*, aligning with the latest tools offering. For more information about changes and security enhancements, see [ODBC Driver 18.0 for SQL Server Released](https://techcommunity.microsoft.com/t5/sql-server-blog/odbc-driver-18-0-for-sql-server-released/ba-p/3169228).| SQL Server Client Tools | Command Line Tools| Linux|
| <a id=3110961>[3110961](#3110961) </a> | Fixes an issue in which maintenance plan logs might report garbled characters when the message reported involves non-ASCII characters.| SQL Server Client Tools | Management Services | Windows|
| <a id=3278705>[3278705](#3278705) </a> | Fixes the following error that you encounter during a Volume Shadow Copy Service (VSS) restore on a SQL Server instance that has previously deleted databases: </br></br>Volume Shadow Copy Service error: Unexpected error calling routine GetVolumePathName is fail on the path \<PathName> ... The system cannot find the file specified.| SQL Server Engine | Backup Restore| Windows|
| <a id=3285752>[3285752](#3285752) </a> | Fixes an issue in which the SQL Server Launchpad service can't shut down properly when certain errors occur during startup. | SQL Server Engine | Extensibility | Windows|
| <a id=2897811>[2897811](#2897811) </a> | Fixes an issue in which the remote secondary replica shows **Not Synchronizing** for several minutes after successive failovers between local replicas. It occurs when configured in multi-subnet, multi-region configurations in the cloud with two or more local replicas and one or more remote replicas. | SQL Server Engine | High Availability and Disaster Recovery | Windows|
| <a id=3088149>[3088149](#3088149) </a> | Fixes an assertion dump issue (Location: hadrlogcapture.cpp:\<LineNumber>; Expression: m_pFsManager->GetEnqueuedBlockId () < capturedLogBlockId \|\| capturedLogBlockId == m_pDbPartner->GetFirstLogBlockIdToCapture ()) that you encounter when there are FILESTREAM transactions in an Always On availability group (AG).| SQL Server Engine | High Availability and Disaster Recovery | All|
| <a id=3157066>[3157066](#3157066) </a> | Adds performance monitor counters to the cluster log report when the health check timeout is reported.| SQL Server Engine | High Availability and Disaster Recovery | Windows|
| <a id=3207515>[3207515](#3207515) </a> | [FIX: Memory exceeds the configured limits that are specified by memory.memorylimitmb in SQL Server (KB5042369)](memory-exceed-configured-limits-memory-memorylimitmb.md) | SQL Server Engine | Linux | Linux|
| <a id=3155852>[3155852](#3155852) </a> | Fixes an assertion failure (Location: sosmemobj.cpp:2744; Expression: pvb->FInUse()) in `CVariableInfo::PviRelease` that you encounter when you use UTF-8 collations and the `WITH RESULT SETS` clause. | SQL Server Engine | Programmability | All|
| <a id=3157452>[3157452](#3157452) </a> | Fixes two issues related to cardinality estimation (CE) feedback: plan cache leaks and access violations due to race conditions with statement recompilations.| SQL Server Engine | Query Optimizer | All|
| <a id=3236328>[3236328](#3236328) </a> | Improves cardinality estimation (CE) for predicates that request ranges disjoint with column statistics when statistics have only one histogram step. | SQL Server Engine | Query Optimizer | All|
| <a id=3222639>[3222639](#3222639) </a> | Fixes an issue in which change tracking auto cleanup consumes CPU in cycles every 30 minutes even if change tracking isn't enabled on any databases. </br></br>**Note**: After applying the fix, if you see some rows in `sys.syscommittab` or `dbo.MSchange_tracking_history` tables in databases where change tracking is disabled, you need to re-enable and then disable change tracking on these databases. This will clean all tracking data. For more information, see [Enable and Disable Change Tracking](/sql/relational-databases/track-changes/enable-and-disable-change-tracking-sql-server). | SQL Server Engine | Replication | All|

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU14 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5038325)

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

You can verify the download by computing the hash of the *SQLServer2022-KB5038325-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5038325-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5038325-x64.exe| 954287B6D8E64612E93E9137379002D49A401CAF1E37B5697D340F127177AEDA |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

|                      File name                      |   File version  | File size |     Date    |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Anglesharp.dll                                      | 0.9.9.0         | 1240112   | 10-Jul-2024 | 14:40 | x86      |
| Asplatformhost.dll                                  | 2022.160.43.233 | 336944    | 10-Jul-2024 | 14:40 | x64      |
| Mashupcompression.dll                               | 2.127.602.0     | 141760    | 10-Jul-2024 | 14:40 | x64      |
| Microsoft.analysisservices.minterop.dll             | 16.0.43.233     | 865216    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.233     | 2903488   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.edm.netfx35.dll                      | 5.7.0.62516     | 661936    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.mashup.dll                           | 2.127.602.0     | 224184    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.mashup.oledb.dll                     | 2.127.602.0     | 32192     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.mashup.preview.dll                   | 2.127.602.0     | 153528    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.mashup.providercommon.dll            | 2.127.602.0     | 113088    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 38832     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42928     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 33216     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 47040     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42928     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 47024     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 38832     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.127.602.0     | 25536     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.odata.netfx35.dll                    | 5.7.0.62516     | 1455536   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.odata.query.netfx35.dll              | 5.7.0.62516     | 182200    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.sapclient.dll                        | 1.0.0.25        | 931680    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 35200     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 36704     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 39808     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 36704     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 37216     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 49024     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.sqlclient.dll                        | 2.17.23292.1    | 1997744   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.sqlclient.sni.dll                    | 2.1.1.0         | 511920    | 10-Jul-2024 | 14:40 | x64      |
| Microsoft.dataintegration.fuzzyclustering.dll       | 1.0.0.0         | 40368     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.dataintegration.fuzzymatching.dll         | 1.0.0.0         | 628144    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.dataintegration.fuzzymatchingcommon.dll   | 1.0.0.0         | 390064    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.exchange.webservices.dll                  | 15.0.913.15     | 1124272   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.hostintegration.connectors.dll            | 2.127.602.0     | 4964800   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.identity.client.dll                       | 4.57.0.0        | 1653680   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 6.35.0.41201    | 111536    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.identitymodel.logging.dll                 | 6.35.0.41201    | 38320     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.identitymodel.protocols.dll               | 6.35.0.41201    | 39856     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 6.35.0.41201    | 114096    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 6.35.0.41201    | 992192    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.cdm.icdmprovider.dll               | 2.127.602.0     | 21952     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.container.exe                      | 2.127.602.0     | 25024     | 10-Jul-2024 | 14:40 | x64      |
| Microsoft.mashup.container.netfx40.exe              | 2.127.602.0     | 24000     | 10-Jul-2024 | 14:40 | x64      |
| Microsoft.mashup.container.netfx45.exe              | 2.127.602.0     | 23992     | 10-Jul-2024 | 14:40 | x64      |
| Microsoft.mashup.eventsource.dll                    | 2.127.602.0     | 150448    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oauth.dll                          | 2.127.602.0     | 94144     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 15808     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16320     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16312     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16816     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 17344     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 15792     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oledbinterop.dll                   | 2.127.602.0     | 201144    | 10-Jul-2024 | 14:40 | x64      |
| Microsoft.mashup.oledbprovider.dll                  | 2.127.602.0     | 67008     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14264     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.sapbwprovider.dll                  | 2.127.602.0     | 334256    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.scriptdom.dll                      | 2.40.4554.261   | 2365872   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.shims.dll                          | 2.127.602.0     | 29616     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll         | 1.0.0.0         | 141248    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.dll                          | 2.127.602.0     | 15941040  | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.library45.dll                | 2.127.602.0     | 7617472   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39856     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39872     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 40368     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 40888     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 42424     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 35872     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 36288     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39360     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 47024     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 620464    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 747448    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 739248    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 718776    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 776128    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 726960    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 702384    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 980912    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 612272    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 714672    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.mshtml.dll                                | 7.0.3300.1      | 8017840   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.odata.core.netfx35.dll                    | 6.15.0.0        | 1438656   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.odata.core.netfx35.v7.dll                 | 7.4.0.11102     | 1262000   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.odata.edm.netfx35.dll                     | 6.15.0.0        | 779712    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.odata.edm.netfx35.v7.dll                  | 7.4.0.11102     | 745920    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.powerbi.adomdclient.dll                   | 16.0.122.20     | 1216944   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.spatial.netfx35.dll                       | 6.15.0.0        | 127408    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.spatial.netfx35.v7.dll                    | 7.4.0.11102     | 125368    | 10-Jul-2024 | 14:40 | x86      |
| Msmdctr.dll                                         | 2022.160.43.233 | 38864     | 10-Jul-2024 | 14:40 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.233 | 71818688  | 10-Jul-2024 | 14:40 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.233 | 53976120  | 10-Jul-2024 | 14:40 | x86      |
| Msmdpump.dll                                        | 2022.160.43.233 | 10333744  | 10-Jul-2024 | 14:40 | x64      |
| Msmdredir.dll                                       | 2022.160.43.233 | 8132032   | 10-Jul-2024 | 14:40 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.233 | 71367216  | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 956992    | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1884720   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1671728   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1881152   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1848360   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1147440   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1140280   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1769520   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1749040   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 932912    | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1837616   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 955456    | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1882672   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1668656   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1876528   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1844784   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1145392   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1138752   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1765440   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1745456   | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 933424    | 10-Jul-2024 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1833008   | 10-Jul-2024 | 14:40 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.233 | 10083392  | 10-Jul-2024 | 14:40 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.233 | 8265280   | 10-Jul-2024 | 14:40 | x86      |
| Msolap.dll                                          | 2022.160.43.233 | 10969648  | 10-Jul-2024 | 14:40 | x64      |
| Msolap.dll                                          | 2022.160.43.233 | 8743880   | 10-Jul-2024 | 14:40 | x86      |
| Msolui.dll                                          | 2022.160.43.233 | 308264    | 10-Jul-2024 | 14:40 | x64      |
| Msolui.dll                                          | 2022.160.43.233 | 289840    | 10-Jul-2024 | 14:40 | x86      |
| Newtonsoft.json.dll                                 | 13.0.3.27908    | 722264    | 10-Jul-2024 | 14:40 | x86      |
| Parquetsharp.dll                                    | 0.0.0.0         | 412592    | 10-Jul-2024 | 14:40 | x64      |
| Parquetsharpnative.dll                              | 7.0.0.17        | 20091320  | 10-Jul-2024 | 14:40 | x64      |
| Powerbiextensions.dll                               | 2.127.602.0     | 11111344  | 10-Jul-2024 | 14:40 | x86      |
| Private_odbc32.dll                                  | 10.0.19041.1    | 735288    | 10-Jul-2024 | 14:40 | x64      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 10-Jul-2024 | 14:40 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4135.4 | 137256    | 10-Jul-2024 | 14:40 | x64      |
| Sqlceip.exe                                         | 16.0.4135.4     | 301096    | 10-Jul-2024 | 14:40 | x86      |
| Sqldumper.exe                                       | 2022.160.4135.4 | 448448    | 10-Jul-2024 | 14:40 | x64      |
| Sqldumper.exe                                       | 2022.160.4135.4 | 378920    | 10-Jul-2024 | 14:40 | x86      |
| System.identitymodel.tokens.jwt.dll                 | 6.35.0.41201    | 77248     | 10-Jul-2024 | 14:40 | x86      |
| System.spatial.netfx35.dll                          | 5.7.0.62516     | 118704    | 10-Jul-2024 | 14:40 | x86      |
| Tmapi.dll                                           | 2022.160.43.233 | 5884480   | 10-Jul-2024 | 14:40 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.233 | 5575216   | 10-Jul-2024 | 14:40 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.233 | 1481264   | 10-Jul-2024 | 14:40 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.233 | 7198264   | 10-Jul-2024 | 14:40 | x64      |
| Xmsrv.dll                                           | 2022.160.43.233 | 26593232  | 10-Jul-2024 | 14:40 | x64      |
| Xmsrv.dll                                           | 2022.160.43.233 | 35895856  | 10-Jul-2024 | 14:40 | x86      |

SQL Server 2022 Database Services Common Core

|                  File name                 |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4135.4 | 104384    | 10-Jul-2024 | 14:41 | x64      |
| Instapi150.dll                             | 2022.160.4135.4 | 79808     | 10-Jul-2024 | 14:41 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.233     | 2633776   | 10-Jul-2024 | 14:41 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.233     | 2633784   | 10-Jul-2024 | 14:41 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.233     | 2933296   | 10-Jul-2024 | 14:41 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.233     | 2323520   | 10-Jul-2024 | 14:41 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.233     | 2323520   | 10-Jul-2024 | 14:41 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4135.4 | 104504    | 10-Jul-2024 | 14:41 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4135.4 | 92200     | 10-Jul-2024 | 14:41 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4135.4     | 555048    | 10-Jul-2024 | 14:41 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4135.4     | 554944    | 10-Jul-2024 | 14:41 | x86      |
| Msasxpress.dll                             | 2022.160.43.233 | 32816     | 10-Jul-2024 | 14:41 | x64      |
| Msasxpress.dll                             | 2022.160.43.233 | 27696     | 10-Jul-2024 | 14:41 | x86      |
| Sql_common_core_keyfile.dll                | 2022.160.4135.4 | 137256    | 10-Jul-2024 | 14:40 | x64      |
| Sqldumper.exe                              | 2022.160.4135.4 | 448448    | 10-Jul-2024 | 14:41 | x64      |
| Sqldumper.exe                              | 2022.160.4135.4 | 378920    | 10-Jul-2024 | 14:41 | x86      |
| Sqlmgmprovider.dll                         | 2022.160.4135.4 | 456744    | 10-Jul-2024 | 14:41 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4135.4 | 395320    | 10-Jul-2024 | 14:41 | x86      |

SQL Server 2022 Data Quality Client

|             File name            |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.infra.dll | 16.0.4135.4     | 309288    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.ssdqs.studio.views.dll | 16.0.4135.4     | 2070568   | 10-Jul-2024 | 14:40 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4135.4 | 137256    | 10-Jul-2024 | 14:40 | x64      |

SQL Server 2022 Data Quality

|         File name         | File version | File size |     Date    |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4135.4  | 600104    | 10-Jul-2024 | 14:41 | x86      |
| Microsoft.ssdqs.core.dll  | 16.0.4135.4  | 600104    | 10-Jul-2024 | 14:41 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4135.4  | 174032    | 10-Jul-2024 | 14:41 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4135.4  | 174136    | 10-Jul-2024 | 14:41 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4135.4  | 1857592   | 10-Jul-2024 | 14:41 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4135.4  | 1857592   | 10-Jul-2024 | 14:41 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4135.4  | 370624    | 10-Jul-2024 | 14:41 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4135.4  | 370728    | 10-Jul-2024 | 14:41 | x86      |

SQL Server 2022 Database Services Core Instance

|                   File name                  |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Adal.dll                                     | 3.6.1.64359     | 1618832   | 10-Jul-2024 | 15:45 | x64      |
| Adalsqlrda.dll                               | 3.6.1.64359     | 1618832   | 10-Jul-2024 | 15:45 | x64      |
| Aetm-enclave-simulator.dll                   | 2022.160.4135.4 | 5994536   | 10-Jul-2024 | 15:24 | x64      |
| Aetm-enclave.dll                             | 2022.160.4135.4 | 5959584   | 10-Jul-2024 | 15:24 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4135.4 | 6194688   | 10-Jul-2024 | 15:24 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4135.4 | 6160592   | 10-Jul-2024 | 15:24 | x64      |
| Dcexec.exe                                   | 2022.160.4135.4 | 96296     | 10-Jul-2024 | 15:45 | x64      |
| Fssres.dll                                   | 2022.160.4135.4 | 100392    | 10-Jul-2024 | 15:45 | x64      |
| Hadrres.dll                                  | 2022.160.4135.4 | 227368    | 10-Jul-2024 | 15:45 | x64      |
| Hkcompile.dll                                | 2022.160.4135.4 | 1427392   | 10-Jul-2024 | 15:45 | x64      |
| Hkengine.dll                                 | 2022.160.4135.4 | 5769272   | 10-Jul-2024 | 15:24 | x64      |
| Hkruntime.dll                                | 2022.160.4135.4 | 190416    | 10-Jul-2024 | 15:24 | x64      |
| Hktempdb.dll                                 | 2022.160.4135.4 | 71736     | 10-Jul-2024 | 15:45 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.233     | 2322480   | 10-Jul-2024 | 15:45 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4135.4 | 333776    | 10-Jul-2024 | 15:45 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4135.4 | 96296     | 10-Jul-2024 | 15:45 | x64      |
| Odsole70.rll                                 | 16.0.4135.4     | 30776     | 10-Jul-2024 | 15:45 | x64      |
| Odsole70.rll                                 | 16.0.4135.4     | 38968     | 10-Jul-2024 | 15:45 | x64      |
| Odsole70.rll                                 | 16.0.4135.4     | 34856     | 10-Jul-2024 | 15:45 | x64      |
| Odsole70.rll                                 | 16.0.4135.4     | 38952     | 10-Jul-2024 | 15:45 | x64      |
| Odsole70.rll                                 | 16.0.4135.4     | 38968     | 10-Jul-2024 | 15:45 | x64      |
| Odsole70.rll                                 | 16.0.4135.4     | 30760     | 10-Jul-2024 | 15:45 | x64      |
| Odsole70.rll                                 | 16.0.4135.4     | 30776     | 10-Jul-2024 | 15:45 | x64      |
| Odsole70.rll                                 | 16.0.4135.4     | 34856     | 10-Jul-2024 | 15:45 | x64      |
| Odsole70.rll                                 | 16.0.4135.4     | 38952     | 10-Jul-2024 | 15:45 | x64      |
| Odsole70.rll                                 | 16.0.4135.4     | 30656     | 10-Jul-2024 | 15:45 | x64      |
| Odsole70.rll                                 | 16.0.4135.4     | 38952     | 10-Jul-2024 | 15:45 | x64      |
| Qds.dll                                      | 2022.160.4135.4 | 1808424   | 10-Jul-2024 | 15:45 | x64      |
| Rsfxft.dll                                   | 2022.160.4135.4 | 55336     | 10-Jul-2024 | 15:45 | x64      |
| Secforwarder.dll                             | 2022.160.4135.4 | 84008     | 10-Jul-2024 | 15:24 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4135.4 | 137256    | 10-Jul-2024 | 15:45 | x64      |
| Sqlaamss.dll                                 | 2022.160.4135.4 | 120872    | 10-Jul-2024 | 15:45 | x64      |
| Sqlaccess.dll                                | 2022.160.4135.4 | 444456    | 10-Jul-2024 | 15:45 | x64      |
| Sqlagent.exe                                 | 2022.160.4135.4 | 718784    | 10-Jul-2024 | 15:45 | x64      |
| Sqlceip.exe                                  | 16.0.4135.4     | 301096    | 10-Jul-2024 | 15:45 | x86      |
| Sqlcmdss.dll                                 | 2022.160.4135.4 | 104504    | 10-Jul-2024 | 15:45 | x64      |
| Sqlctr160.dll                                | 2022.160.4135.4 | 157632    | 10-Jul-2024 | 15:45 | x64      |
| Sqlctr160.dll                                | 2022.160.4135.4 | 129080    | 10-Jul-2024 | 15:45 | x86      |
| Sqldk.dll                                    | 2022.160.4135.4 | 4024256   | 10-Jul-2024 | 15:45 | x64      |
| Sqldtsss.dll                                 | 2022.160.4135.4 | 120768    | 10-Jul-2024 | 15:45 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 1755176   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 3860520   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 4077504   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 4589504   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 4720576   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 3762112   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 3950632   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 4589608   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 4417472   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 4491200   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 2451408   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 2394064   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 4274128   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 3909568   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 4429760   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 4220968   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 4204584   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 3987496   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 3864528   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 1693736   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 4315072   | 10-Jul-2024 | 15:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4135.4 | 4454440   | 10-Jul-2024 | 15:24 | x64      |
| Sqliosim.com                                 | 2022.160.4135.4 | 387128    | 10-Jul-2024 | 15:45 | x64      |
| Sqliosim.exe                                 | 2022.160.4135.4 | 3057600   | 10-Jul-2024 | 15:45 | x64      |
| Sqllang.dll                                  | 2022.160.4135.4 | 48805928  | 10-Jul-2024 | 15:45 | x64      |
| Sqlmin.dll                                   | 2022.160.4135.4 | 51242944  | 10-Jul-2024 | 15:45 | x64      |
| Sqlolapss.dll                                | 2022.160.4135.4 | 116776    | 10-Jul-2024 | 15:45 | x64      |
| Sqlos.dll                                    | 2022.160.4135.4 | 51256     | 10-Jul-2024 | 15:24 | x64      |
| Sqlpowershellss.dll                          | 2022.160.4135.4 | 100288    | 10-Jul-2024 | 15:45 | x64      |
| Sqlrepss.dll                                 | 2022.160.4135.4 | 141248    | 10-Jul-2024 | 15:45 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4135.4 | 51256     | 10-Jul-2024 | 15:45 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4135.4 | 5834792   | 10-Jul-2024 | 15:45 | x64      |
| Sqlservr.exe                                 | 2022.160.4135.4 | 722984    | 10-Jul-2024 | 15:45 | x64      |
| Sqlsvc.dll                                   | 2022.160.4135.4 | 194512    | 10-Jul-2024 | 15:45 | x64      |
| Sqltses.dll                                  | 2022.160.4135.4 | 10667968  | 10-Jul-2024 | 15:45 | x64      |
| Sqsrvres.dll                                 | 2022.160.4135.4 | 305088    | 10-Jul-2024 | 15:45 | x64      |
| Svl.dll                                      | 2022.160.4135.4 | 247848    | 10-Jul-2024 | 15:24 | x64      |
| Xe.dll                                       | 2022.160.4135.4 | 718904    | 10-Jul-2024 | 15:45 | x64      |
| Xpqueue.dll                                  | 2022.160.4135.4 | 100392    | 10-Jul-2024 | 15:45 | x64      |
| Xpstar.dll                                   | 2022.160.4135.4 | 534584    | 10-Jul-2024 | 15:45 | x64      |

SQL Server 2022 Database Services Core Shared

|                       File name                      |   File version   | File size |     Date    |  Time | Platform |
|:----------------------------------------------------:|:----------------:|:---------:|:-----------:|:-----:|:--------:|
| Azure.core.dll                                       | 1.3600.23.56006  | 384432    | 10-Jul-2024 | 14:40 | x86      |
| Azure.identity.dll                                   | 1.1000.423.56303 | 334768    | 10-Jul-2024 | 14:40 | x86      |
| Bcp.exe                                              | 2022.160.4135.4  | 141248    | 10-Jul-2024 | 14:40 | x64      |
| Commanddest.dll                                      | 2022.160.4135.4  | 272440    | 10-Jul-2024 | 14:40 | x64      |
| Datacollectortasks.dll                               | 2022.160.4135.4  | 227368    | 10-Jul-2024 | 14:40 | x64      |
| Distrib.exe                                          | 2022.160.4135.4  | 260136    | 10-Jul-2024 | 14:40 | x64      |
| Dteparse.dll                                         | 2022.160.4135.4  | 133056    | 10-Jul-2024 | 14:40 | x64      |
| Dteparsemgd.dll                                      | 2022.160.4135.4  | 178112    | 10-Jul-2024 | 14:40 | x64      |
| Dtepkg.dll                                           | 2022.160.4135.4  | 153640    | 10-Jul-2024 | 14:40 | x64      |
| Dtexec.exe                                           | 2022.160.4135.4  | 76856     | 10-Jul-2024 | 14:40 | x64      |
| Dts.dll                                              | 2022.160.4135.4  | 3266600   | 10-Jul-2024 | 14:40 | x64      |
| Dtscomexpreval.dll                                   | 2022.160.4135.4  | 493608    | 10-Jul-2024 | 14:40 | x64      |
| Dtsconn.dll                                          | 2022.160.4135.4  | 550952    | 10-Jul-2024 | 14:40 | x64      |
| Dtshost.exe                                          | 2022.160.4135.4  | 120256    | 10-Jul-2024 | 14:40 | x64      |
| Dtslog.dll                                           | 2022.160.4135.4  | 137152    | 10-Jul-2024 | 14:40 | x64      |
| Dtspipeline.dll                                      | 2022.160.4135.4  | 1337400   | 10-Jul-2024 | 14:40 | x64      |
| Dtuparse.dll                                         | 2022.160.4135.4  | 104384    | 10-Jul-2024 | 14:40 | x64      |
| Dtutil.exe                                           | 2022.160.4135.4  | 166456    | 10-Jul-2024 | 14:40 | x64      |
| Exceldest.dll                                        | 2022.160.4135.4  | 284712    | 10-Jul-2024 | 14:40 | x64      |
| Excelsrc.dll                                         | 2022.160.4135.4  | 305104    | 10-Jul-2024 | 14:40 | x64      |
| Execpackagetask.dll                                  | 2022.160.4135.4  | 182208    | 10-Jul-2024 | 14:40 | x64      |
| Flatfiledest.dll                                     | 2022.160.4135.4  | 423992    | 10-Jul-2024 | 14:40 | x64      |
| Flatfilesrc.dll                                      | 2022.160.4135.4  | 440376    | 10-Jul-2024 | 14:40 | x64      |
| Logread.exe                                          | 2022.160.4135.4  | 792512    | 10-Jul-2024 | 14:40 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.233      | 2933816   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.bcl.asyncinterfaces.dll                    | 6.0.21.52210     | 22144     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.sqlclient.dll                         | 5.13.23292.1     | 2048632   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.data.sqlclient.sni.dll                     | 5.1.1.0          | 504872    | 10-Jul-2024 | 14:40 | x64      |
| Microsoft.data.tools.sql.batchparser.dll             | 17.100.23.0      | 42416     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4135.4      | 30760     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.identity.client.dll                        | 4.56.0.0         | 1652320   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.identity.client.extensions.msal.dll        | 4.56.0.0         | 66552     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.identitymodel.abstractions.dll             | 6.24.0.31013     | 18864     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 6.24.0.31013     | 85424     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.identitymodel.logging.dll                  | 6.24.0.31013     | 34224     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.identitymodel.protocols.dll                | 6.24.0.31013     | 38288     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 6.24.0.31013     | 114048    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 6.24.0.31013     | 986032    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.sqlserver.connectioninfo.dll               | 17.100.23.0      | 126496    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.sqlserver.dmf.common.dll                   | 17.100.23.0      | 63520     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll         | 16.0.4135.4      | 391104    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.sqlserver.management.sdk.sfc.dll           | 17.100.23.0      | 513464    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4135.4  | 1710016   | 10-Jul-2024 | 14:40 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4135.4      | 554944    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.sqlserver.servicebrokerenum.dll            | 17.100.23.0      | 37920     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.sqlserver.smo.dll                          | 17.100.23.0      | 4451872   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.sqlserver.smoextended.dll                  | 17.100.23.0      | 161208    | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.sqlserver.sqlclrprovider.dll               | 17.100.23.0      | 21536     | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.sqlserver.sqlenum.dll                      | 17.100.23.0      | 1587744   | 10-Jul-2024 | 14:40 | x86      |
| Msdtssrvrutil.dll                                    | 2022.160.4135.4  | 124864    | 10-Jul-2024 | 14:40 | x64      |
| Msgprox.dll                                          | 2022.160.4135.4  | 313400    | 10-Jul-2024 | 14:40 | x64      |
| Msoledbsql.dll                                       | 2018.187.4.0     | 2750472   | 10-Jul-2024 | 14:40 | x64      |
| Msoledbsql.dll                                       | 2018.187.4.0     | 153608    | 10-Jul-2024 | 14:40 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517     | 704408    | 10-Jul-2024 | 14:40 | x86      |
| Oledbdest.dll                                        | 2022.160.4135.4  | 288808    | 10-Jul-2024 | 14:40 | x64      |
| Oledbsrc.dll                                         | 2022.160.4135.4  | 313296    | 10-Jul-2024 | 14:40 | x64      |
| Qrdrsvc.exe                                          | 2022.160.4135.4  | 526392    | 10-Jul-2024 | 14:40 | x64      |
| Rawdest.dll                                          | 2022.160.4135.4  | 227280    | 10-Jul-2024 | 14:40 | x64      |
| Rawsource.dll                                        | 2022.160.4135.4  | 214976    | 10-Jul-2024 | 14:40 | x64      |
| Rdistcom.dll                                         | 2022.160.4135.4  | 940072    | 10-Jul-2024 | 14:40 | x64      |
| Recordsetdest.dll                                    | 2022.160.4135.4  | 206784    | 10-Jul-2024 | 14:40 | x64      |
| Repldp.dll                                           | 2022.160.4135.4  | 337960    | 10-Jul-2024 | 14:40 | x64      |
| Replerrx.dll                                         | 2022.160.4135.4  | 198592    | 10-Jul-2024 | 14:40 | x64      |
| Replisapi.dll                                        | 2022.160.4135.4  | 419776    | 10-Jul-2024 | 14:40 | x64      |
| Replmerg.exe                                         | 2022.160.4135.4  | 596008    | 10-Jul-2024 | 14:40 | x64      |
| Replprov.dll                                         | 2022.160.4135.4  | 890816    | 10-Jul-2024 | 14:40 | x64      |
| Replrec.dll                                          | 2022.160.4135.4  | 1058856   | 10-Jul-2024 | 14:40 | x64      |
| Replsub.dll                                          | 2022.160.4135.4  | 501816    | 10-Jul-2024 | 14:40 | x64      |
| Spresolv.dll                                         | 2022.160.4135.4  | 301096    | 10-Jul-2024 | 14:40 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4135.4  | 137256    | 10-Jul-2024 | 14:40 | x64      |
| Sqlcmd.exe                                           | 2022.160.4135.4  | 276520    | 10-Jul-2024 | 14:40 | x64      |
| Sqldiag.exe                                          | 2022.160.4135.4  | 1140776   | 10-Jul-2024 | 14:40 | x64      |
| Sqldistx.dll                                         | 2022.160.4135.4  | 268344    | 10-Jul-2024 | 14:40 | x64      |
| Sqlmergx.dll                                         | 2022.160.4135.4  | 423992    | 10-Jul-2024 | 14:40 | x64      |
| Sqlnclirda11.dll                                     | 2011.110.5069.66 | 3478208   | 10-Jul-2024 | 14:40 | x64      |
| Sqlsvc.dll                                           | 2022.160.4135.4  | 194512    | 10-Jul-2024 | 14:40 | x64      |
| Sqlsvc.dll                                           | 2022.160.4135.4  | 153536    | 10-Jul-2024 | 14:40 | x86      |
| Sqltaskconnections.dll                               | 2022.160.4135.4  | 210984    | 10-Jul-2024 | 14:40 | x64      |
| Ssradd.dll                                           | 2022.160.4135.4  | 100392    | 10-Jul-2024 | 14:40 | x64      |
| Ssravg.dll                                           | 2022.160.4135.4  | 100392    | 10-Jul-2024 | 14:40 | x64      |
| Ssrmax.dll                                           | 2022.160.4135.4  | 100392    | 10-Jul-2024 | 14:40 | x64      |
| Ssrmin.dll                                           | 2022.160.4135.4  | 100408    | 10-Jul-2024 | 14:40 | x64      |
| System.diagnostics.diagnosticsource.dll              | 7.0.423.11508    | 173232    | 10-Jul-2024 | 14:40 | x86      |
| System.memory.dll                                    | 4.6.31308.1      | 142240    | 10-Jul-2024 | 14:40 | x86      |
| System.runtime.compilerservices.unsafe.dll           | 6.0.21.52210     | 18024     | 10-Jul-2024 | 14:40 | x86      |
| System.security.cryptography.protecteddata.dll       | 7.0.22.51805     | 21640     | 10-Jul-2024 | 14:40 | x86      |
| Txagg.dll                                            | 2022.160.4135.4  | 395304    | 10-Jul-2024 | 14:40 | x64      |
| Txbdd.dll                                            | 2022.160.4135.4  | 190504    | 10-Jul-2024 | 14:40 | x64      |
| Txdatacollector.dll                                  | 2022.160.4135.4  | 469048    | 10-Jul-2024 | 14:40 | x64      |
| Txdataconvert.dll                                    | 2022.160.4135.4  | 333880    | 10-Jul-2024 | 14:40 | x64      |
| Txderived.dll                                        | 2022.160.4135.4  | 632768    | 10-Jul-2024 | 14:40 | x64      |
| Txlookup.dll                                         | 2022.160.4135.4  | 608312    | 10-Jul-2024 | 14:40 | x64      |
| Txmerge.dll                                          | 2022.160.4135.4  | 243752    | 10-Jul-2024 | 14:40 | x64      |
| Txmergejoin.dll                                      | 2022.160.4135.4  | 300992    | 10-Jul-2024 | 14:40 | x64      |
| Txmulticast.dll                                      | 2022.160.4135.4  | 145344    | 10-Jul-2024 | 14:40 | x64      |
| Txrowcount.dll                                       | 2022.160.4135.4  | 145344    | 10-Jul-2024 | 14:40 | x64      |
| Txsort.dll                                           | 2022.160.4135.4  | 276536    | 10-Jul-2024 | 14:40 | x64      |
| Txsplit.dll                                          | 2022.160.4135.4  | 620496    | 10-Jul-2024 | 14:40 | x64      |
| Txunionall.dll                                       | 2022.160.4135.4  | 194512    | 10-Jul-2024 | 14:40 | x64      |
| Xe.dll                                               | 2022.160.4135.4  | 718904    | 10-Jul-2024 | 14:40 | x64      |

SQL Server 2022 sql_extensibility

|           File name           |   File version  | File size |     Date    |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4135.4 | 100392    | 10-Jul-2024 | 14:41 | x64      |
| Exthost.exe                   | 2022.160.4135.4 | 247848    | 10-Jul-2024 | 14:41 | x64      |
| Launchpad.exe                 | 2022.160.4135.4 | 1452088   | 10-Jul-2024 | 14:41 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4135.4 | 137256    | 10-Jul-2024 | 14:41 | x64      |
| Sqlsatellite.dll              | 2022.160.4135.4 | 1255480   | 10-Jul-2024 | 14:41 | x64      |

SQL Server 2022 Full-Text Engine

|         File name        |   File version  | File size |     Date    |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4135.4 | 710712    | 10-Jul-2024 | 14:40 | x64      |
| Fdhost.exe               | 2022.160.4135.4 | 153536    | 10-Jul-2024 | 14:40 | x64      |
| Fdlauncher.exe           | 2022.160.4135.4 | 100304    | 10-Jul-2024 | 14:40 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4135.4 | 137256    | 10-Jul-2024 | 14:40 | x64      |

SQL Server 2022 Integration Services

|                           File name                           |   File version  | File size |     Date    |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 10-Jul-2024 | 14:48 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 10-Jul-2024 | 14:48 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 10-Jul-2024 | 14:48 | x86      |
| Commanddest.dll                                               | 2022.160.4135.4 | 231464    | 10-Jul-2024 | 14:48 | x86      |
| Commanddest.dll                                               | 2022.160.4135.4 | 272440    | 10-Jul-2024 | 14:48 | x64      |
| Dteparse.dll                                                  | 2022.160.4135.4 | 116776    | 10-Jul-2024 | 14:48 | x86      |
| Dteparse.dll                                                  | 2022.160.4135.4 | 133056    | 10-Jul-2024 | 14:48 | x64      |
| Dteparsemgd.dll                                               | 2022.160.4135.4 | 165928    | 10-Jul-2024 | 14:48 | x86      |
| Dteparsemgd.dll                                               | 2022.160.4135.4 | 178112    | 10-Jul-2024 | 14:48 | x64      |
| Dtepkg.dll                                                    | 2022.160.4135.4 | 129080    | 10-Jul-2024 | 14:48 | x86      |
| Dtepkg.dll                                                    | 2022.160.4135.4 | 153640    | 10-Jul-2024 | 14:48 | x64      |
| Dtexec.exe                                                    | 2022.160.4135.4 | 64960     | 10-Jul-2024 | 14:48 | x86      |
| Dtexec.exe                                                    | 2022.160.4135.4 | 76856     | 10-Jul-2024 | 14:48 | x64      |
| Dts.dll                                                       | 2022.160.4135.4 | 2861096   | 10-Jul-2024 | 14:48 | x86      |
| Dts.dll                                                       | 2022.160.4135.4 | 3266600   | 10-Jul-2024 | 14:48 | x64      |
| Dtscomexpreval.dll                                            | 2022.160.4135.4 | 444456    | 10-Jul-2024 | 14:48 | x86      |
| Dtscomexpreval.dll                                            | 2022.160.4135.4 | 493608    | 10-Jul-2024 | 14:48 | x64      |
| Dtsconn.dll                                                   | 2022.160.4135.4 | 464936    | 10-Jul-2024 | 14:48 | x86      |
| Dtsconn.dll                                                   | 2022.160.4135.4 | 550952    | 10-Jul-2024 | 14:48 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4135.4 | 114744    | 10-Jul-2024 | 14:48 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4135.4 | 94760     | 10-Jul-2024 | 14:48 | x86      |
| Dtshost.exe                                                   | 2022.160.4135.4 | 120256    | 10-Jul-2024 | 14:48 | x64      |
| Dtshost.exe                                                   | 2022.160.4135.4 | 98344     | 10-Jul-2024 | 14:48 | x86      |
| Dtslog.dll                                                    | 2022.160.4135.4 | 120888    | 10-Jul-2024 | 14:48 | x86      |
| Dtslog.dll                                                    | 2022.160.4135.4 | 137152    | 10-Jul-2024 | 14:48 | x64      |
| Dtspipeline.dll                                               | 2022.160.4135.4 | 1144768   | 10-Jul-2024 | 14:48 | x86      |
| Dtspipeline.dll                                               | 2022.160.4135.4 | 1337400   | 10-Jul-2024 | 14:48 | x64      |
| Dtuparse.dll                                                  | 2022.160.4135.4 | 104384    | 10-Jul-2024 | 14:48 | x64      |
| Dtuparse.dll                                                  | 2022.160.4135.4 | 88104     | 10-Jul-2024 | 14:48 | x86      |
| Dtutil.exe                                                    | 2022.160.4135.4 | 142272    | 10-Jul-2024 | 14:48 | x86      |
| Dtutil.exe                                                    | 2022.160.4135.4 | 166456    | 10-Jul-2024 | 14:48 | x64      |
| Exceldest.dll                                                 | 2022.160.4135.4 | 284712    | 10-Jul-2024 | 14:48 | x64      |
| Exceldest.dll                                                 | 2022.160.4135.4 | 247864    | 10-Jul-2024 | 14:48 | x86      |
| Excelsrc.dll                                                  | 2022.160.4135.4 | 305104    | 10-Jul-2024 | 14:48 | x64      |
| Excelsrc.dll                                                  | 2022.160.4135.4 | 264248    | 10-Jul-2024 | 14:48 | x86      |
| Execpackagetask.dll                                           | 2022.160.4135.4 | 182208    | 10-Jul-2024 | 14:48 | x64      |
| Execpackagetask.dll                                           | 2022.160.4135.4 | 149544    | 10-Jul-2024 | 14:48 | x86      |
| Flatfiledest.dll                                              | 2022.160.4135.4 | 423992    | 10-Jul-2024 | 14:48 | x64      |
| Flatfiledest.dll                                              | 2022.160.4135.4 | 374840    | 10-Jul-2024 | 14:48 | x86      |
| Flatfilesrc.dll                                               | 2022.160.4135.4 | 440376    | 10-Jul-2024 | 14:48 | x64      |
| Flatfilesrc.dll                                               | 2022.160.4135.4 | 391208    | 10-Jul-2024 | 14:48 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4135.4     | 120768    | 10-Jul-2024 | 14:48 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4135.4     | 120784    | 10-Jul-2024 | 14:48 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.233     | 2933824   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.233     | 2933816   | 10-Jul-2024 | 14:40 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4135.4     | 509992    | 10-Jul-2024 | 14:48 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 16.0.4135.4     | 391104    | 10-Jul-2024 | 14:48 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4135.4     | 219072    | 10-Jul-2024 | 14:48 | x64      |
| Msdtssrvrutil.dll                                             | 2022.160.4135.4 | 100392    | 10-Jul-2024 | 14:48 | x86      |
| Msdtssrvrutil.dll                                             | 2022.160.4135.4 | 124864    | 10-Jul-2024 | 14:48 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.233 | 10164160  | 10-Jul-2024 | 14:40 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 10-Jul-2024 | 14:48 | x86      |
| Odbcdest.dll                                                  | 2022.160.4135.4 | 342056    | 10-Jul-2024 | 14:48 | x86      |
| Odbcdest.dll                                                  | 2022.160.4135.4 | 383016    | 10-Jul-2024 | 14:48 | x64      |
| Odbcsrc.dll                                                   | 2022.160.4135.4 | 350248    | 10-Jul-2024 | 14:48 | x86      |
| Odbcsrc.dll                                                   | 2022.160.4135.4 | 399400    | 10-Jul-2024 | 14:48 | x64      |
| Oledbdest.dll                                                 | 2022.160.4135.4 | 247864    | 10-Jul-2024 | 14:48 | x86      |
| Oledbdest.dll                                                 | 2022.160.4135.4 | 288808    | 10-Jul-2024 | 14:48 | x64      |
| Oledbsrc.dll                                                  | 2022.160.4135.4 | 268344    | 10-Jul-2024 | 14:48 | x86      |
| Oledbsrc.dll                                                  | 2022.160.4135.4 | 313296    | 10-Jul-2024 | 14:48 | x64      |
| Rawdest.dll                                                   | 2022.160.4135.4 | 190504    | 10-Jul-2024 | 14:48 | x86      |
| Rawdest.dll                                                   | 2022.160.4135.4 | 227280    | 10-Jul-2024 | 14:48 | x64      |
| Rawsource.dll                                                 | 2022.160.4135.4 | 186408    | 10-Jul-2024 | 14:48 | x86      |
| Rawsource.dll                                                 | 2022.160.4135.4 | 214976    | 10-Jul-2024 | 14:48 | x64      |
| Recordsetdest.dll                                             | 2022.160.4135.4 | 174120    | 10-Jul-2024 | 14:48 | x86      |
| Recordsetdest.dll                                             | 2022.160.4135.4 | 206784    | 10-Jul-2024 | 14:48 | x64      |
| Sql_is_keyfile.dll                                            | 2022.160.4135.4 | 137256    | 10-Jul-2024 | 14:40 | x64      |
| Sqlceip.exe                                                   | 16.0.4135.4     | 301096    | 10-Jul-2024 | 14:48 | x86      |
| Sqldest.dll                                                   | 2022.160.4135.4 | 256040    | 10-Jul-2024 | 14:48 | x86      |
| Sqldest.dll                                                   | 2022.160.4135.4 | 288808    | 10-Jul-2024 | 14:48 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4135.4 | 174136    | 10-Jul-2024 | 14:48 | x86      |
| Sqltaskconnections.dll                                        | 2022.160.4135.4 | 210984    | 10-Jul-2024 | 14:48 | x64      |
| Txagg.dll                                                     | 2022.160.4135.4 | 346168    | 10-Jul-2024 | 14:48 | x86      |
| Txagg.dll                                                     | 2022.160.4135.4 | 395304    | 10-Jul-2024 | 14:48 | x64      |
| Txbdd.dll                                                     | 2022.160.4135.4 | 149560    | 10-Jul-2024 | 14:48 | x86      |
| Txbdd.dll                                                     | 2022.160.4135.4 | 190504    | 10-Jul-2024 | 14:48 | x64      |
| Txbestmatch.dll                                               | 2022.160.4135.4 | 567352    | 10-Jul-2024 | 14:48 | x86      |
| Txbestmatch.dll                                               | 2022.160.4135.4 | 661560    | 10-Jul-2024 | 14:48 | x64      |
| Txcache.dll                                                   | 2022.160.4135.4 | 169928    | 10-Jul-2024 | 14:48 | x86      |
| Txcache.dll                                                   | 2022.160.4135.4 | 202792    | 10-Jul-2024 | 14:48 | x64      |
| Txcharmap.dll                                                 | 2022.160.4135.4 | 280616    | 10-Jul-2024 | 14:48 | x86      |
| Txcharmap.dll                                                 | 2022.160.4135.4 | 325688    | 10-Jul-2024 | 14:48 | x64      |
| Txcopymap.dll                                                 | 2022.160.4135.4 | 165928    | 10-Jul-2024 | 14:48 | x86      |
| Txcopymap.dll                                                 | 2022.160.4135.4 | 202688    | 10-Jul-2024 | 14:48 | x64      |
| Txdataconvert.dll                                             | 2022.160.4135.4 | 288808    | 10-Jul-2024 | 14:48 | x86      |
| Txdataconvert.dll                                             | 2022.160.4135.4 | 333880    | 10-Jul-2024 | 14:48 | x64      |
| Txderived.dll                                                 | 2022.160.4135.4 | 559160    | 10-Jul-2024 | 14:48 | x86      |
| Txderived.dll                                                 | 2022.160.4135.4 | 632768    | 10-Jul-2024 | 14:48 | x64      |
| Txfileextractor.dll                                           | 2022.160.4135.4 | 186312    | 10-Jul-2024 | 14:48 | x86      |
| Txfileextractor.dll                                           | 2022.160.4135.4 | 219072    | 10-Jul-2024 | 14:48 | x64      |
| Txfileinserter.dll                                            | 2022.160.4135.4 | 186424    | 10-Jul-2024 | 14:48 | x86      |
| Txfileinserter.dll                                            | 2022.160.4135.4 | 219176    | 10-Jul-2024 | 14:48 | x64      |
| Txgroupdups.dll                                               | 2022.160.4135.4 | 354344    | 10-Jul-2024 | 14:48 | x86      |
| Txgroupdups.dll                                               | 2022.160.4135.4 | 403496    | 10-Jul-2024 | 14:48 | x64      |
| Txlineage.dll                                                 | 2022.160.4135.4 | 129064    | 10-Jul-2024 | 14:48 | x86      |
| Txlineage.dll                                                 | 2022.160.4135.4 | 157736    | 10-Jul-2024 | 14:48 | x64      |
| Txlookup.dll                                                  | 2022.160.4135.4 | 522280    | 10-Jul-2024 | 14:48 | x86      |
| Txlookup.dll                                                  | 2022.160.4135.4 | 608312    | 10-Jul-2024 | 14:48 | x64      |
| Txmerge.dll                                                   | 2022.160.4135.4 | 194600    | 10-Jul-2024 | 14:48 | x86      |
| Txmerge.dll                                                   | 2022.160.4135.4 | 243752    | 10-Jul-2024 | 14:48 | x64      |
| Txmergejoin.dll                                               | 2022.160.4135.4 | 256040    | 10-Jul-2024 | 14:48 | x86      |
| Txmergejoin.dll                                               | 2022.160.4135.4 | 300992    | 10-Jul-2024 | 14:48 | x64      |
| Txmulticast.dll                                               | 2022.160.4135.4 | 116776    | 10-Jul-2024 | 14:48 | x86      |
| Txmulticast.dll                                               | 2022.160.4135.4 | 145344    | 10-Jul-2024 | 14:48 | x64      |
| Txpivot.dll                                                   | 2022.160.4135.4 | 198608    | 10-Jul-2024 | 14:48 | x86      |
| Txpivot.dll                                                   | 2022.160.4135.4 | 239552    | 10-Jul-2024 | 14:48 | x64      |
| Txrowcount.dll                                                | 2022.160.4135.4 | 116776    | 10-Jul-2024 | 14:48 | x86      |
| Txrowcount.dll                                                | 2022.160.4135.4 | 145344    | 10-Jul-2024 | 14:48 | x64      |
| Txsampling.dll                                                | 2022.160.4135.4 | 153640    | 10-Jul-2024 | 14:48 | x86      |
| Txsampling.dll                                                | 2022.160.4135.4 | 186304    | 10-Jul-2024 | 14:48 | x64      |
| Txscd.dll                                                     | 2022.160.4135.4 | 198712    | 10-Jul-2024 | 14:48 | x86      |
| Txscd.dll                                                     | 2022.160.4135.4 | 235456    | 10-Jul-2024 | 14:48 | x64      |
| Txsort.dll                                                    | 2022.160.4135.4 | 231480    | 10-Jul-2024 | 14:48 | x86      |
| Txsort.dll                                                    | 2022.160.4135.4 | 276536    | 10-Jul-2024 | 14:48 | x64      |
| Txsplit.dll                                                   | 2022.160.4135.4 | 550952    | 10-Jul-2024 | 14:48 | x86      |
| Txsplit.dll                                                   | 2022.160.4135.4 | 620496    | 10-Jul-2024 | 14:48 | x64      |
| Txtermextraction.dll                                          | 2022.160.4135.4 | 8648656   | 10-Jul-2024 | 14:48 | x86      |
| Txtermextraction.dll                                          | 2022.160.4135.4 | 8701992   | 10-Jul-2024 | 14:48 | x64      |
| Txtermlookup.dll                                              | 2022.160.4135.4 | 4138944   | 10-Jul-2024 | 14:48 | x86      |
| Txtermlookup.dll                                              | 2022.160.4135.4 | 4184104   | 10-Jul-2024 | 14:48 | x64      |
| Txunionall.dll                                                | 2022.160.4135.4 | 153656    | 10-Jul-2024 | 14:48 | x86      |
| Txunionall.dll                                                | 2022.160.4135.4 | 194512    | 10-Jul-2024 | 14:48 | x64      |
| Txunpivot.dll                                                 | 2022.160.4135.4 | 178216    | 10-Jul-2024 | 14:48 | x86      |
| Txunpivot.dll                                                 | 2022.160.4135.4 | 215080    | 10-Jul-2024 | 14:48 | x64      |
| Xe.dll                                                        | 2022.160.4135.4 | 641080    | 10-Jul-2024 | 14:48 | x86      |
| Xe.dll                                                        | 2022.160.4135.4 | 718904    | 10-Jul-2024 | 14:48 | x64      |

SQL Server 2022 sql_polybase_core_inst

|                               File name                              |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1035.0     | 559688    | 10-Jul-2024 | 15:28 | x86      |
| Dmsnative.dll                                                        | 2022.160.1035.0 | 152632    | 10-Jul-2024 | 15:28 | x64      |
| Dwengineservice.dll                                                  | 16.0.1035.0     | 45016     | 10-Jul-2024 | 15:28 | x86      |
| Instapi150.dll                                                       | 2022.160.4135.4 | 104384    | 10-Jul-2024 | 15:28 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1035.0     | 67528     | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1035.0     | 293320    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1035.0     | 1958360   | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1035.0     | 169424    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1035.0     | 647224    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1035.0     | 246216    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1035.0     | 139320    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1035.0     | 79944     | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1035.0     | 51272     | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1035.0     | 88632     | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1035.0     | 1129432   | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1035.0     | 80952     | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1035.0     | 70712     | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1035.0     | 35272     | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1035.0     | 31304     | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1035.0     | 46552     | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1035.0     | 21560     | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1035.0     | 26584     | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1035.0     | 131640    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1035.0     | 86480     | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1035.0     | 100936    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1035.0     | 293336    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 120280    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 138296    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 141384    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 137672    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 150488    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 139736    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 134616    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 176696    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 117704    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 136664    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1035.0     | 72760     | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1035.0     | 22072     | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1035.0     | 37320     | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1035.0     | 128968    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1035.0     | 3064776   | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1035.0     | 3955768   | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 118344    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 133176    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 137784    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 133688    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 148536    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 134200    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 130616    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 171064    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 115256    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 132152    | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1035.0     | 67544     | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1035.0     | 2682840   | 10-Jul-2024 | 15:28 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1035.0     | 2436552   | 10-Jul-2024 | 15:28 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4135.4 | 297016    | 10-Jul-2024 | 15:28 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4135.4 | 9078720   | 10-Jul-2024 | 15:28 | x64      |
| Secforwarder.dll                                                     | 2022.160.4135.4 | 84008     | 10-Jul-2024 | 15:28 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1035.0 | 61400     | 10-Jul-2024 | 15:28 | x64      |
| Sqldk.dll                                                            | 2022.160.4135.4 | 4024256   | 10-Jul-2024 | 15:28 | x64      |
| Sqldumper.exe                                                        | 2022.160.4135.4 | 448448    | 10-Jul-2024 | 15:28 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4135.4 | 1755176   | 10-Jul-2024 | 15:27 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4135.4 | 4589504   | 10-Jul-2024 | 15:27 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4135.4 | 3762112   | 10-Jul-2024 | 15:27 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4135.4 | 4589608   | 10-Jul-2024 | 15:27 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4135.4 | 4491200   | 10-Jul-2024 | 15:27 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4135.4 | 2451408   | 10-Jul-2024 | 15:27 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4135.4 | 2394064   | 10-Jul-2024 | 15:27 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4135.4 | 4220968   | 10-Jul-2024 | 15:27 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4135.4 | 4204584   | 10-Jul-2024 | 15:27 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4135.4 | 1693736   | 10-Jul-2024 | 15:27 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4135.4 | 4454440   | 10-Jul-2024 | 15:27 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.6.1   | 1898520   | 10-Jul-2024 | 15:28 | x64      |
| Sqlos.dll                                                            | 2022.160.4135.4 | 51256     | 10-Jul-2024 | 15:28 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1035.0 | 4841528   | 10-Jul-2024 | 15:28 | x64      |
| Sqltses.dll                                                          | 2022.160.4135.4 | 10667968  | 10-Jul-2024 | 15:28 | x64      |

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
