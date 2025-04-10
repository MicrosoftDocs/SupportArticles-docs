---
title: Cumulative update 28 for SQL Server 2019 (KB5039747)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 28 (KB5039747).
ms.date: 01/29/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5039747
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5039747 - Cumulative Update 28 for SQL Server 2019

_Release Date:_ &nbsp; August 01, 2024  
_Version:_ &nbsp; 15.0.4385.2

## Summary

This article describes Cumulative Update package 28 (CU28) for Microsoft SQL Server 2019. This update contains 13 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 27, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4385.2**, file version: **2019.150.4385.2**
- Analysis Services - Product version: **15.0.35.48**, file version: **2018.150.35.48**

## Known issues in this update

### Issue one: Access violation when session is reset

[!INCLUDE [av-sesssion-context-2019](../includes/av-sesssion-context-2019.md)]

### Issue two: Patching error for secondary replicas in an availability group with databases enabled replication, CDC, or SSISDB

[!INCLUDE [patching-error-2019](../includes/patching-error-2019.md)]

### Issue three: SQL Server VSS Writer might fail to perform a backup because no database is available to freeze

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

The issue arises from a code change in SQL Server 2019 CU28 that checks if a database is online and ready to be frozen. The current solution is to roll back to SQL Server 2019 CU27 and perform the snapshot backup. For more information about how to roll back the package to a previous version, see [Uninstall a Cumulative Update from SQL Server](/sql/sql-server/install/uninstall-a-cumulative-update-from-sql-server).

This issue is fixed in [SQL Server 2019 CU29](cumulativeupdate29.md#3459328).

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description| Fix area| Component| Platform |
|----------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|-------------------|----------|
| <a id=3305037>[3305037](#3305037) </a> | Digitally signs the Intel Threading Building Blocks (Intel TBB) assemblies by using a Microsoft certificate. | Analysis Services | Analysis Services | Windows|
| <a id=3217207>[3217207](#3217207) </a> | Starting with SQL Server 2019 (15.x) CU28, container images include the new [mssql-tools18 package](/sql/linux/sql-server-linux-setup-tools#install-tools-on-linux). The previous directory */opt/mssql-tools/bin* is phased out. The new directory for Microsoft ODBC 18 tools is */opt/mssql-tools18/bin*, aligning with the latest tools offering. For more information about changes and security enhancements, see [ODBC Driver 18.0 for SQL Server Released](https://techcommunity.microsoft.com/t5/sql-server-blog/odbc-driver-18-0-for-sql-server-released/ba-p/3169228).| SQL Server Client Tools | Command Line Tools| Linux|
| <a id=3278707>[3278707](#3278707) </a> | Fixes the following error that you encounter during a Volume Shadow Copy Service (VSS) restore on a SQL Server instance that has previously deleted databases: </br></br>Volume Shadow Copy Service error: Unexpected error calling routine GetVolumePathName is fail on the path \<PathName> ... The system cannot find the file specified.| SQL Server Engine | Backup Restore| Windows|
| <a id=3285766>[3285766](#3285766) </a> | Fixes an issue in which the SQL Server Launchpad service can't shut down properly when certain errors occur during startup.| SQL Server Engine | Extensibility | Windows|
| <a id=2830668>[2830668](#2830668) </a> | Fixes a latch time-out issue that you encounter when fetching the next value for sequence objects, which is due to self-deadlock during lock escalation. | SQL Server Engine | Metadata| All |
| <a id=3282395>[3282395](#3282395) </a> | Fixes the following error 1204 due to unintentionally disabled lock escalation regression introduced in [CU26](cumulativeupdate26.md): </br></br>SQL Server Database Engine cannot obtain a LOCK resource at this time. | SQL Server Engine | Metadata | All |
| <a id=3323675>[3323675](#3323675) </a> | Fixes a latch time-out issue that you encounter when fetching the next value for sequence objects, which is due to self-deadlock during lock escalation. | SQL Server Engine | Metadata| All|
| <a id=3296380>[3296380](#3296380) </a> | Fixes an issue in which PolyBase throws the following error at service startup if the SQL Server instance is configured to listen on multiple TCP ports: </br></br>System.ArgumentException: Unable to parse port, instance = '\<InstanceName>', text = '\<Text>'| SQL Server Engine | PolyBase| All|
| <a id=3312936>[3312936](#3312936) </a> | Fixes a non-yielding scheduler dump issue that you might encounter when forcing a query plan in the Query Store (QDS). | SQL Server Engine | Query Optimizer | All|
| <a id=3312950>[3312950](#3312950) </a> | Fixes an issue in which error 18752 occurs and transactional replication stops working when you use a heavy workload in combination with availability groups and after a failover occurs. </br></br>Error message: </br></br>Only one Log Reader Agent or log-related procedure (sp_repldone, sp_replcmds, and sp_replshowcmds) can connect to a database at a time. If you executed a log-related procedure, drop the connection with session ID \<SessionID> over which the procedure was executed or execute sp_replflush over that connection before starting the Log Reader Agent or executing another log-related procedure. | SQL Server Engine | Replication | Windows|
| <a id=3338718>[3338718](#3338718) </a> | Fixes the following error 21890 that you encounter when you use the case-sensitive collation and run `sp_validate_redirected_publisher`: </br></br>The SQL Server instance '\<InstanceName>' with distributor '\<DistributorName>' and distribution database '\<DatabaseName>' cannot be used with publisher database '\<DatabaseName>'. Reconfigure the publisher to make use of distributor '\<DistributorName>' and distribution database '\<DatabaseName>'. | SQL Server Engine | Replication | All |
| <a id=3020820>[3020820](#3020820) </a> | Fixes an out of memory issue that you encounter when running a stored procedure on a remote SQL Server instance by using a linked server.| SQL Server Engine | SQL OS| All|
| <a id=3312461>[3312461](#3312461) </a> | Increases the threshold of the following log message when high I/O latencies are detected in Bufferpool Lazy Writer (`ntdll!ZwWriteFile` system call) due to a performance issue in the underlying storage: </br></br>WARNING Long asynchronous API Call: The scheduling fairness of scheduler can be impacted by an asynchronous API invocation unexpectedly exceeding xxx ms. </br></br>The SQL Server error log might be filled by excessive logging of the log message. | SQL Server Engine | SQL OS| All|

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU28 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5039747)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5039747-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5039747-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5039747-x64.exe| BC70570A217F4562710B88C35F80476474CB34107D2A93D1A2220090FB4E25AA |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                        File   name                        |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.48  | 292800    | 25-Jul-24 | 21:57 | x64      |
| Mashupcompression.dll                                     | 2.87.142.0      | 140672    | 25-Jul-24 | 21:57 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.48      | 758224    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.48      | 175552    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.48      | 199616    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.48      | 202176    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.48      | 198592    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.48      | 214992    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.48      | 197584    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.48      | 193488    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.48      | 252352    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.48      | 174016    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.48      | 197056    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.48      | 1098800   | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.48      | 567336    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.48      | 54832     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.48      | 59440     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.48      | 59952     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.48      | 58928     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.48      | 61904     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.48      | 58320     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.48      | 58408     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.48      | 67632     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.48      | 53808     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.48      | 58416     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.48      | 17968     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.48      | 17856     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.48      | 17864     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.48      | 17968     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.48      | 17856     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.48      | 17856     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.48      | 17968     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.48      | 18880     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.48      | 17968     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.48      | 17864     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660872    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.mashup.dll                                 | 2.87.142.0      | 191352    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.87.142.0      | 30592     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.87.142.0      | 76672     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.87.142.0      | 103808    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37760     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 32120     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 45952     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37752     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454464   | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181120    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 929592    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33064     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35128     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 46888     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.87.142.0      | 5283720   | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.container.exe                            | 2.87.142.0      | 23432     | 25-Jul-24 | 21:57 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.87.142.0      | 22912     | 25-Jul-24 | 21:57 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.87.142.0      | 22912     | 25-Jul-24 | 21:57 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.87.142.0      | 149384    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.87.142.0      | 78720     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14712     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15224     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15744     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14720     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.87.142.0      | 199560    | 25-Jul-24 | 21:57 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.87.142.0      | 64888     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.shims.dll                                | 2.87.142.0      | 27528     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140168    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashupengine.dll                                | 2.87.142.0      | 14835080  | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 566136    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 676728    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 672640    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 652152    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 701312    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 660352    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 639872    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 881536    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 553848    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 648064    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 25-Jul-24 | 21:57 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.61.21      | 1109368   | 25-Jul-24 | 21:57 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126344    | 25-Jul-24 | 21:57 | x86      |
| Msmdctr.dll                                               | 2018.150.35.48  | 38352     | 25-Jul-24 | 21:57 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.48  | 47785008  | 25-Jul-24 | 21:57 | x86      |
| Msmdlocal.dll                                             | 2018.150.35.48  | 66260944  | 25-Jul-24 | 21:57 | x64      |
| Msmdpump.dll                                              | 2018.150.35.48  | 10187304  | 25-Jul-24 | 21:57 | x64      |
| Msmdredir.dll                                             | 2018.150.35.48  | 7957456   | 25-Jul-24 | 21:57 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.48      | 16944     | 25-Jul-24 | 21:57 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.48      | 16832     | 25-Jul-24 | 21:57 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.48      | 17456     | 25-Jul-24 | 21:57 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.48      | 16944     | 25-Jul-24 | 21:57 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.48      | 17456     | 25-Jul-24 | 21:57 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.48      | 17472     | 25-Jul-24 | 21:57 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.48      | 17472     | 25-Jul-24 | 21:57 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.48      | 18384     | 25-Jul-24 | 21:57 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.48      | 16960     | 25-Jul-24 | 21:57 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.48      | 16944     | 25-Jul-24 | 21:57 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.48  | 65797568  | 25-Jul-24 | 21:57 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.48  | 833488    | 25-Jul-24 | 21:57 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.48  | 1628096   | 25-Jul-24 | 21:57 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.48  | 1454032   | 25-Jul-24 | 21:57 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.48  | 1642944   | 25-Jul-24 | 21:57 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.48  | 1608640   | 25-Jul-24 | 21:57 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.48  | 1001408   | 25-Jul-24 | 21:57 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.48  | 992704    | 25-Jul-24 | 21:57 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.48  | 1536976   | 25-Jul-24 | 21:57 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.48  | 1521600   | 25-Jul-24 | 21:57 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.48  | 810960    | 25-Jul-24 | 21:57 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.48  | 1596368   | 25-Jul-24 | 21:57 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.48  | 832456    | 25-Jul-24 | 21:57 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.48  | 1624528   | 25-Jul-24 | 21:57 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.48  | 1450944   | 25-Jul-24 | 21:57 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.48  | 1637944   | 25-Jul-24 | 21:57 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.48  | 1604544   | 25-Jul-24 | 21:57 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.48  | 998848    | 25-Jul-24 | 21:57 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.48  | 991184    | 25-Jul-24 | 21:57 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.48  | 1532864   | 25-Jul-24 | 21:57 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.48  | 1518016   | 25-Jul-24 | 21:57 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.48  | 809920    | 25-Jul-24 | 21:57 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.48  | 1591744   | 25-Jul-24 | 21:57 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.48  | 8280000   | 25-Jul-24 | 21:57 | x86      |
| Msmgdsrv.dll                                              | 2018.150.35.48  | 10186280  | 25-Jul-24 | 21:57 | x64      |
| Msolap.dll                                                | 2018.150.35.48  | 8607184   | 25-Jul-24 | 21:57 | x86      |
| Msolap.dll                                                | 2018.150.35.48  | 11013168  | 25-Jul-24 | 21:57 | x64      |
| Msolui.dll                                                | 2018.150.35.48  | 286256    | 25-Jul-24 | 21:57 | x86      |
| Msolui.dll                                                | 2018.150.35.48  | 306640    | 25-Jul-24 | 21:57 | x64      |
| Powerbiextensions.dll                                     | 2.87.142.0      | 8853888   | 25-Jul-24 | 21:57 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728448    | 25-Jul-24 | 21:57 | x64      |
| Sqlboot.dll                                               | 2019.150.4385.2 | 215080    | 25-Jul-24 | 21:57 | x64      |
| Sqlceip.exe                                               | 15.0.4385.2     | 297000    | 25-Jul-24 | 21:57 | x86      |
| Sqldumper.exe                                             | 2019.150.4385.2 | 321576    | 25-Jul-24 | 21:57 | x86      |
| Sqldumper.exe                                             | 2019.150.4385.2 | 378920    | 25-Jul-24 | 21:57 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 25-Jul-24 | 21:57 | x86      |
| Tbb.dll                                                   | 2019.0.2019.410 | 442688    | 25-Jul-24 | 21:57 | x64      |
| Tbbmalloc.dll                                             | 2019.0.2019.410 | 270144    | 25-Jul-24 | 21:57 | x64      |
| Tmapi.dll                                                 | 2018.150.35.48  | 6178240   | 25-Jul-24 | 21:57 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.48  | 4917712   | 25-Jul-24 | 21:57 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.48  | 1184704   | 25-Jul-24 | 21:57 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.48  | 6807104   | 25-Jul-24 | 21:57 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.48  | 26025408  | 25-Jul-24 | 21:57 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.48  | 35460160  | 25-Jul-24 | 21:57 | x86      |

SQL Server 2019 Database Services Common Core

|              File   name             |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                      | 2019.150.4385.2 | 165928    | 25-Jul-24 | 21:57 | x86      |
| Batchparser.dll                      | 2019.150.4385.2 | 182328    | 25-Jul-24 | 21:57 | x64      |
| Instapi150.dll                       | 2019.150.4385.2 | 75816     | 25-Jul-24 | 21:57 | x86      |
| Instapi150.dll                       | 2019.150.4385.2 | 88104     | 25-Jul-24 | 21:57 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4385.2 | 104488    | 25-Jul-24 | 21:57 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4385.2 | 88120     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4385.2     | 550968    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4385.2     | 550968    | 25-Jul-24 | 21:57 | x86      |
| Msasxpress.dll                       | 2018.150.35.48  | 32192     | 25-Jul-24 | 21:57 | x64      |
| Msasxpress.dll                       | 2018.150.35.48  | 27088     | 25-Jul-24 | 21:57 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4385.2 | 75816     | 25-Jul-24 | 21:57 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4385.2 | 92096     | 25-Jul-24 | 21:57 | x64      |
| Sqldumper.exe                        | 2019.150.4385.2 | 321576    | 25-Jul-24 | 21:57 | x86      |
| Sqldumper.exe                        | 2019.150.4385.2 | 378920    | 25-Jul-24 | 21:57 | x64      |
| Sqlftacct.dll                        | 2019.150.4385.2 | 59448     | 25-Jul-24 | 21:57 | x86      |
| Sqlftacct.dll                        | 2019.150.4385.2 | 79928     | 25-Jul-24 | 21:57 | x64      |
| Sqlmanager.dll                       | 2019.150.4385.2 | 743360    | 25-Jul-24 | 21:57 | x86      |
| Sqlmanager.dll                       | 2019.150.4385.2 | 878648    | 25-Jul-24 | 21:57 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4385.2 | 378920    | 25-Jul-24 | 21:57 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4385.2 | 432168    | 25-Jul-24 | 21:57 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4385.2 | 276520    | 25-Jul-24 | 21:57 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4385.2 | 358440    | 25-Jul-24 | 21:57 | x64      |
| Svrenumapi150.dll                    | 2019.150.4385.2 | 1161168   | 25-Jul-24 | 21:57 | x64      |
| Svrenumapi150.dll                    | 2019.150.4385.2 | 911296    | 25-Jul-24 | 21:57 | x86      |

SQL Server 2019 Data Quality

|        File   name        | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 15.0.4385.2  | 600104    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.ssdqs.core.dll  | 15.0.4385.2  | 600120    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4385.2  | 1857576   | 25-Jul-24 | 21:57 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4385.2  | 1857576   | 25-Jul-24 | 21:57 | x86      |

SQL Server 2019 sql_dreplay_client

|      File   name      |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4385.2 | 137168    | 25-Jul-24 | 21:58 | x86      |
| Dreplaycommon.dll     | 2019.150.4385.2 | 667688    | 25-Jul-24 | 21:58 | x86      |
| Dreplayutil.dll       | 2019.150.4385.2 | 305192    | 25-Jul-24 | 21:58 | x86      |
| Instapi150.dll        | 2019.150.4385.2 | 88104     | 25-Jul-24 | 21:58 | x64      |
| Sqlresourceloader.dll | 2019.150.4385.2 | 38952     | 25-Jul-24 | 21:58 | x86      |

SQL Server 2019 sql_dreplay_controller

|      File   name      |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4385.2 | 667688    | 25-Jul-24 | 21:57 | x86      |
| Dreplaycontroller.exe | 2019.150.4385.2 | 366528    | 25-Jul-24 | 21:57 | x86      |
| Instapi150.dll        | 2019.150.4385.2 | 88104     | 25-Jul-24 | 21:57 | x64      |
| Sqlresourceloader.dll | 2019.150.4385.2 | 38952     | 25-Jul-24 | 21:57 | x86      |

SQL Server 2019 Database Services Core Instance

|                 File   name                |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4385.2 | 4658112   | 25-Jul-24 | 22:46 | x64      |
| Aetm-enclave.dll                           | 2019.150.4385.2 | 4612536   | 25-Jul-24 | 22:46 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4385.2 | 4931904   | 25-Jul-24 | 22:46 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4385.2 | 4873544   | 25-Jul-24 | 22:46 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 25-Jul-24 | 22:46 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 25-Jul-24 | 22:46 | x64      |
| Batchparser.dll                            | 2019.150.4385.2 | 182328    | 25-Jul-24 | 22:46 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 25-Jul-24 | 22:46 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 25-Jul-24 | 22:46 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 25-Jul-24 | 22:46 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 25-Jul-24 | 22:46 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4385.2 | 280616    | 25-Jul-24 | 22:46 | x64      |
| Dcexec.exe                                 | 2019.150.4385.2 | 88104     | 25-Jul-24 | 22:46 | x64      |
| Fssres.dll                                 | 2019.150.4385.2 | 96296     | 25-Jul-24 | 22:46 | x64      |
| Hadrres.dll                                | 2019.150.4385.2 | 206784    | 25-Jul-24 | 22:46 | x64      |
| Hkcompile.dll                              | 2019.150.4385.2 | 1292344   | 25-Jul-24 | 22:46 | x64      |
| Hkengine.dll                               | 2019.150.4385.2 | 5793728   | 25-Jul-24 | 22:46 | x64      |
| Hkruntime.dll                              | 2019.150.4385.2 | 182312    | 25-Jul-24 | 22:46 | x64      |
| Hktempdb.dll                               | 2019.150.4385.2 | 63544     | 25-Jul-24 | 22:46 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 25-Jul-24 | 22:46 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4385.2     | 235560    | 25-Jul-24 | 22:46 | x86      |
| Microsoft.sqlserver.types.dll              | 2019.150.4385.2 | 391224    | 25-Jul-24 | 22:46 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4385.2 | 325672    | 25-Jul-24 | 22:46 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4385.2 | 92112     | 25-Jul-24 | 22:46 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 25-Jul-24 | 22:46 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 25-Jul-24 | 22:46 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 25-Jul-24 | 22:46 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 25-Jul-24 | 22:46 | x64      |
| Qds.dll                                    | 2019.150.4385.2 | 1189824   | 25-Jul-24 | 22:46 | x64      |
| Rsfxft.dll                                 | 2019.150.4385.2 | 51240     | 25-Jul-24 | 22:46 | x64      |
| Secforwarder.dll                           | 2019.150.4385.2 | 79912     | 25-Jul-24 | 22:46 | x64      |
| Sqagtres.dll                               | 2019.150.4385.2 | 88104     | 25-Jul-24 | 22:46 | x64      |
| Sqlaamss.dll                               | 2019.150.4385.2 | 108584    | 25-Jul-24 | 22:46 | x64      |
| Sqlaccess.dll                              | 2019.150.4385.2 | 493608    | 25-Jul-24 | 22:46 | x64      |
| Sqlagent.exe                               | 2019.150.4385.2 | 731072    | 25-Jul-24 | 22:46 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4385.2 | 71616     | 25-Jul-24 | 22:46 | x86      |
| Sqlagentctr150.dll                         | 2019.150.4385.2 | 79912     | 25-Jul-24 | 22:46 | x64      |
| Sqlboot.dll                                | 2019.150.4385.2 | 215080    | 25-Jul-24 | 22:46 | x64      |
| Sqlceip.exe                                | 15.0.4385.2     | 297000    | 25-Jul-24 | 22:46 | x86      |
| Sqlcmdss.dll                               | 2019.150.4385.2 | 88104     | 25-Jul-24 | 22:46 | x64      |
| Sqlctr150.dll                              | 2019.150.4385.2 | 116776    | 25-Jul-24 | 22:46 | x86      |
| Sqlctr150.dll                              | 2019.150.4385.2 | 145344    | 25-Jul-24 | 22:46 | x64      |
| Sqldk.dll                                  | 2019.150.4385.2 | 3180584   | 25-Jul-24 | 22:46 | x64      |
| Sqldtsss.dll                               | 2019.150.4385.2 | 108584    | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 1595432   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 3508264   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 3704872   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 4171816   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 4290600   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 3422264   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 3586088   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 4163640   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 4020264   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 4069416   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 2226216   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 2177080   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 3876904   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 3553320   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 4024376   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 3827752   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 3823672   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 3618872   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 3508264   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 1542200   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 3917880   | 25-Jul-24 | 22:46 | x64      |
| Sqlevn70.rll                               | 2019.150.4385.2 | 4036664   | 25-Jul-24 | 22:46 | x64      |
| Sqllang.dll                                | 2019.150.4385.2 | 40077248  | 25-Jul-24 | 22:46 | x64      |
| Sqlmin.dll                                 | 2019.150.4385.2 | 40648640  | 25-Jul-24 | 22:46 | x64      |
| Sqlolapss.dll                              | 2019.150.4385.2 | 108584    | 25-Jul-24 | 22:46 | x64      |
| Sqlos.dll                                  | 2019.150.4385.2 | 43048     | 25-Jul-24 | 22:46 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4385.2 | 84008     | 25-Jul-24 | 22:46 | x64      |
| Sqlrepss.dll                               | 2019.150.4385.2 | 88000     | 25-Jul-24 | 22:46 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4385.2 | 51152     | 25-Jul-24 | 22:46 | x64      |
| Sqlscm.dll                                 | 2019.150.4385.2 | 88000     | 25-Jul-24 | 22:46 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4385.2 | 38968     | 25-Jul-24 | 22:46 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4385.2 | 5806120   | 25-Jul-24 | 22:46 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4385.2 | 673832    | 25-Jul-24 | 22:46 | x64      |
| Sqlservr.exe                               | 2019.150.4385.2 | 628776    | 25-Jul-24 | 22:46 | x64      |
| Sqlsvc.dll                                 | 2019.150.4385.2 | 182328    | 25-Jul-24 | 22:46 | x64      |
| Sqltses.dll                                | 2019.150.4385.2 | 9119800   | 25-Jul-24 | 22:46 | x64      |
| Sqsrvres.dll                               | 2019.150.4385.2 | 280512    | 25-Jul-24 | 22:46 | x64      |
| Stretchcodegen.exe                         | 15.0.4385.2     | 59432     | 25-Jul-24 | 22:46 | x86      |
| Svl.dll                                    | 2019.150.4385.2 | 161848    | 25-Jul-24 | 22:46 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 25-Jul-24 | 22:46 | x64      |
| Xe.dll                                     | 2019.150.4385.2 | 723000    | 25-Jul-24 | 22:46 | x64      |
| Xpadsi.exe                                 | 2019.150.4385.2 | 116776    | 25-Jul-24 | 22:46 | x64      |
| Xplog70.dll                                | 2019.150.4385.2 | 92096     | 25-Jul-24 | 22:46 | x64      |
| Xpqueue.dll                                | 2019.150.4385.2 | 92112     | 25-Jul-24 | 22:46 | x64      |
| Xprepl.dll                                 | 2019.150.4385.2 | 120872    | 25-Jul-24 | 22:46 | x64      |
| Xpstar.dll                                 | 2019.150.4385.2 | 473128    | 25-Jul-24 | 22:46 | x64      |

SQL Server 2019 Database Services Core Shared

|                          File   name                         |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                              | 2019.150.4385.2  | 182328    | 25-Jul-24 | 21:57 | x64      |
| Batchparser.dll                                              | 2019.150.4385.2  | 165928    | 25-Jul-24 | 21:57 | x86      |
| Commanddest.dll                                              | 2019.150.4385.2  | 264232    | 25-Jul-24 | 21:57 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4385.2  | 231464    | 25-Jul-24 | 21:57 | x64      |
| Distrib.exe                                                  | 2019.150.4385.2  | 243752    | 25-Jul-24 | 21:57 | x64      |
| Dteparse.dll                                                 | 2019.150.4385.2  | 124984    | 25-Jul-24 | 21:57 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4385.2  | 133176    | 25-Jul-24 | 21:57 | x64      |
| Dtepkg.dll                                                   | 2019.150.4385.2  | 149456    | 25-Jul-24 | 21:57 | x64      |
| Dtexec.exe                                                   | 2019.150.4385.2  | 73784     | 25-Jul-24 | 21:57 | x64      |
| Dts.dll                                                      | 2019.150.4385.2  | 3143616   | 25-Jul-24 | 21:57 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4385.2  | 501800    | 25-Jul-24 | 21:57 | x64      |
| Dtsconn.dll                                                  | 2019.150.4385.2  | 522280    | 25-Jul-24 | 21:57 | x64      |
| Dtshost.exe                                                  | 2019.150.4385.2  | 107560    | 25-Jul-24 | 21:57 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4385.2  | 567336    | 25-Jul-24 | 21:57 | x64      |
| Dtspipeline.dll                                              | 2019.150.4385.2  | 1329192   | 25-Jul-24 | 21:57 | x64      |
| Dtswizard.exe                                                | 15.0.4385.2      | 886736    | 25-Jul-24 | 21:57 | x64      |
| Dtuparse.dll                                                 | 2019.150.4385.2  | 100392    | 25-Jul-24 | 21:57 | x64      |
| Dtutil.exe                                                   | 2019.150.4385.2  | 151096    | 25-Jul-24 | 21:57 | x64      |
| Exceldest.dll                                                | 2019.150.4385.2  | 280528    | 25-Jul-24 | 21:57 | x64      |
| Excelsrc.dll                                                 | 2019.150.4385.2  | 309288    | 25-Jul-24 | 21:57 | x64      |
| Execpackagetask.dll                                          | 2019.150.4385.2  | 186424    | 25-Jul-24 | 21:57 | x64      |
| Flatfiledest.dll                                             | 2019.150.4385.2  | 411704    | 25-Jul-24 | 21:57 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4385.2  | 428072    | 25-Jul-24 | 21:57 | x64      |
| Logread.exe                                                  | 2019.150.4385.2  | 723000    | 25-Jul-24 | 21:57 | x64      |
| Mergetxt.dll                                                 | 2019.150.4385.2  | 75816     | 25-Jul-24 | 21:57 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4385.2      | 59328     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4385.2      | 43048     | 25-Jul-24 | 21:57 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4385.2      | 391208    | 25-Jul-24 | 21:57 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4385.2  | 1697832   | 25-Jul-24 | 21:57 | x64      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4385.2  | 1640488   | 25-Jul-24 | 21:57 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4385.2      | 550968    | 25-Jul-24 | 21:57 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4385.2  | 112592    | 25-Jul-24 | 21:57 | x64      |
| Msgprox.dll                                                  | 2019.150.4385.2  | 301112    | 25-Jul-24 | 21:57 | x64      |
| Msoledbsql.dll                                               | 2018.187.4.0     | 2750472   | 25-Jul-24 | 21:57 | x64      |
| Msoledbsql.dll                                               | 2018.187.4.0     | 153608    | 25-Jul-24 | 21:57 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4385.2  | 1497128   | 25-Jul-24 | 21:57 | x64      |
| Oledbdest.dll                                                | 2019.150.4385.2  | 280616    | 25-Jul-24 | 21:57 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4385.2  | 313384    | 25-Jul-24 | 21:57 | x64      |
| Osql.exe                                                     | 2019.150.4385.2  | 92216     | 25-Jul-24 | 21:57 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4385.2  | 501800    | 25-Jul-24 | 21:57 | x64      |
| Rawdest.dll                                                  | 2019.150.4385.2  | 227368    | 25-Jul-24 | 21:57 | x64      |
| Rawsource.dll                                                | 2019.150.4385.2  | 210888    | 25-Jul-24 | 21:57 | x64      |
| Rdistcom.dll                                                 | 2019.150.4385.2  | 915392    | 25-Jul-24 | 21:57 | x64      |
| Recordsetdest.dll                                            | 2019.150.4385.2  | 202808    | 25-Jul-24 | 21:57 | x64      |
| Repldp.dll                                                   | 2019.150.4385.2  | 313280    | 25-Jul-24 | 21:57 | x64      |
| Replerrx.dll                                                 | 2019.150.4385.2  | 182312    | 25-Jul-24 | 21:57 | x64      |
| Replisapi.dll                                                | 2019.150.4385.2  | 395216    | 25-Jul-24 | 21:57 | x64      |
| Replmerg.exe                                                 | 2019.150.4385.2  | 563136    | 25-Jul-24 | 21:57 | x64      |
| Replprov.dll                                                 | 2019.150.4385.2  | 862248    | 25-Jul-24 | 21:57 | x64      |
| Replrec.dll                                                  | 2019.150.4385.2  | 1034296   | 25-Jul-24 | 21:57 | x64      |
| Replsub.dll                                                  | 2019.150.4385.2  | 473128    | 25-Jul-24 | 21:57 | x64      |
| Replsync.dll                                                 | 2019.150.4385.2  | 165944    | 25-Jul-24 | 21:57 | x64      |
| Spresolv.dll                                                 | 2019.150.4385.2  | 276432    | 25-Jul-24 | 21:57 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4385.2  | 264128    | 25-Jul-24 | 21:57 | x64      |
| Sqldiag.exe                                                  | 2019.150.4385.2  | 1140776   | 25-Jul-24 | 21:57 | x64      |
| Sqldistx.dll                                                 | 2019.150.4385.2  | 251944    | 25-Jul-24 | 21:57 | x64      |
| Sqllogship.exe                                               | 15.0.4385.2      | 104400    | 25-Jul-24 | 21:57 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4385.2  | 399400    | 25-Jul-24 | 21:57 | x64      |
| Sqlnclirda11.dll                                             | 2011.110.5069.66 | 3478208   | 25-Jul-24 | 21:57 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4385.2  | 51152     | 25-Jul-24 | 21:57 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4385.2  | 38952     | 25-Jul-24 | 21:57 | x86      |
| Sqlscm.dll                                                   | 2019.150.4385.2  | 88000     | 25-Jul-24 | 21:57 | x64      |
| Sqlscm.dll                                                   | 2019.150.4385.2  | 79912     | 25-Jul-24 | 21:57 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4385.2  | 182328    | 25-Jul-24 | 21:57 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4385.2  | 149544    | 25-Jul-24 | 21:57 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4385.2  | 202792    | 25-Jul-24 | 21:57 | x64      |
| Ssradd.dll                                                   | 2019.150.4385.2  | 84024     | 25-Jul-24 | 21:57 | x64      |
| Ssravg.dll                                                   | 2019.150.4385.2  | 83920     | 25-Jul-24 | 21:57 | x64      |
| Ssrdown.dll                                                  | 2019.150.4385.2  | 75816     | 25-Jul-24 | 21:57 | x64      |
| Ssrmax.dll                                                   | 2019.150.4385.2  | 84008     | 25-Jul-24 | 21:57 | x64      |
| Ssrmin.dll                                                   | 2019.150.4385.2  | 84024     | 25-Jul-24 | 21:57 | x64      |
| Ssrpub.dll                                                   | 2019.150.4385.2  | 79912     | 25-Jul-24 | 21:57 | x64      |
| Ssrup.dll                                                    | 2019.150.4385.2  | 75816     | 25-Jul-24 | 21:57 | x64      |
| Txagg.dll                                                    | 2019.150.4385.2  | 391224    | 25-Jul-24 | 21:57 | x64      |
| Txbdd.dll                                                    | 2019.150.4385.2  | 190400    | 25-Jul-24 | 21:57 | x64      |
| Txdatacollector.dll                                          | 2019.150.4385.2  | 473144    | 25-Jul-24 | 21:57 | x64      |
| Txdataconvert.dll                                            | 2019.150.4385.2  | 317480    | 25-Jul-24 | 21:57 | x64      |
| Txderived.dll                                                | 2019.150.4385.2  | 641080    | 25-Jul-24 | 21:57 | x64      |
| Txlookup.dll                                                 | 2019.150.4385.2  | 542760    | 25-Jul-24 | 21:57 | x64      |
| Txmerge.dll                                                  | 2019.150.4385.2  | 247848    | 25-Jul-24 | 21:57 | x64      |
| Txmergejoin.dll                                              | 2019.150.4385.2  | 309288    | 25-Jul-24 | 21:57 | x64      |
| Txmulticast.dll                                              | 2019.150.4385.2  | 145360    | 25-Jul-24 | 21:57 | x64      |
| Txrowcount.dll                                               | 2019.150.4385.2  | 141352    | 25-Jul-24 | 21:57 | x64      |
| Txsort.dll                                                   | 2019.150.4385.2  | 288808    | 25-Jul-24 | 21:57 | x64      |
| Txsplit.dll                                                  | 2019.150.4385.2  | 624592    | 25-Jul-24 | 21:57 | x64      |
| Txunionall.dll                                               | 2019.150.4385.2  | 198712    | 25-Jul-24 | 21:57 | x64      |
| Xe.dll                                                       | 2019.150.4385.2  | 723000    | 25-Jul-24 | 21:57 | x64      |
| Xmlsub.dll                                                   | 2019.150.4385.2  | 297000    | 25-Jul-24 | 21:57 | x64      |

SQL Server 2019 sql_extensibility

|     File   name    |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4385.2 | 96312     | 25-Jul-24 | 21:57 | x64      |
| Exthost.exe        | 2019.150.4385.2 | 239656    | 25-Jul-24 | 21:57 | x64      |
| Launchpad.exe      | 2019.150.4385.2 | 1230792   | 25-Jul-24 | 21:57 | x64      |
| Sqlsatellite.dll   | 2019.150.4385.2 | 1026104   | 25-Jul-24 | 21:57 | x64      |

SQL Server 2019 Full-Text Engine

|   File   name  |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4385.2 | 686120    | 25-Jul-24 | 21:57 | x64      |
| Fdhost.exe     | 2019.150.4385.2 | 129064    | 25-Jul-24 | 21:57 | x64      |
| Fdlauncher.exe | 2019.150.4385.2 | 79808     | 25-Jul-24 | 21:57 | x64      |
| Sqlft150ph.dll | 2019.150.4385.2 | 92216     | 25-Jul-24 | 21:57 | x64      |

SQL Server 2019 sql_inst_mr

| File   name | File version | File size |    Date   |  Time | Platform |
|:-----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll  | 15.0.4385.2  | 30776     | 25-Jul-24 | 21:57 | x86      |

SQL Server 2019 Integration Services

|                          File   name                          |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4385.2 | 227264    | 25-Jul-24 | 22:02 | x86      |
| Commanddest.dll                                               | 2019.150.4385.2 | 264232    | 25-Jul-24 | 22:02 | x64      |
| Dteparse.dll                                                  | 2019.150.4385.2 | 112696    | 25-Jul-24 | 22:02 | x86      |
| Dteparse.dll                                                  | 2019.150.4385.2 | 124984    | 25-Jul-24 | 22:02 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4385.2 | 116672    | 25-Jul-24 | 22:02 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4385.2 | 133176    | 25-Jul-24 | 22:02 | x64      |
| Dtepkg.dll                                                    | 2019.150.4385.2 | 133160    | 25-Jul-24 | 22:02 | x86      |
| Dtepkg.dll                                                    | 2019.150.4385.2 | 149456    | 25-Jul-24 | 22:02 | x64      |
| Dtexec.exe                                                    | 2019.150.4385.2 | 64960     | 25-Jul-24 | 22:02 | x86      |
| Dtexec.exe                                                    | 2019.150.4385.2 | 73784     | 25-Jul-24 | 22:02 | x64      |
| Dts.dll                                                       | 2019.150.4385.2 | 2762688   | 25-Jul-24 | 22:02 | x86      |
| Dts.dll                                                       | 2019.150.4385.2 | 3143616   | 25-Jul-24 | 22:02 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4385.2 | 444456    | 25-Jul-24 | 22:02 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4385.2 | 501800    | 25-Jul-24 | 22:02 | x64      |
| Dtsconn.dll                                                   | 2019.150.4385.2 | 432168    | 25-Jul-24 | 22:02 | x86      |
| Dtsconn.dll                                                   | 2019.150.4385.2 | 522280    | 25-Jul-24 | 22:02 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4385.2 | 113208    | 25-Jul-24 | 22:02 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4385.2 | 94760     | 25-Jul-24 | 22:02 | x86      |
| Dtshost.exe                                                   | 2019.150.4385.2 | 107560    | 25-Jul-24 | 22:02 | x64      |
| Dtshost.exe                                                   | 2019.150.4385.2 | 89640     | 25-Jul-24 | 22:02 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4385.2 | 554944    | 25-Jul-24 | 22:02 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4385.2 | 567336    | 25-Jul-24 | 22:02 | x64      |
| Dtspipeline.dll                                               | 2019.150.4385.2 | 1120208   | 25-Jul-24 | 22:02 | x86      |
| Dtspipeline.dll                                               | 2019.150.4385.2 | 1329192   | 25-Jul-24 | 22:02 | x64      |
| Dtswizard.exe                                                 | 15.0.4385.2     | 886736    | 25-Jul-24 | 22:02 | x64      |
| Dtswizard.exe                                                 | 15.0.4385.2     | 890816    | 25-Jul-24 | 22:02 | x86      |
| Dtuparse.dll                                                  | 2019.150.4385.2 | 100392    | 25-Jul-24 | 22:02 | x64      |
| Dtuparse.dll                                                  | 2019.150.4385.2 | 88000     | 25-Jul-24 | 22:02 | x86      |
| Dtutil.exe                                                    | 2019.150.4385.2 | 130496    | 25-Jul-24 | 22:02 | x86      |
| Dtutil.exe                                                    | 2019.150.4385.2 | 151096    | 25-Jul-24 | 22:02 | x64      |
| Exceldest.dll                                                 | 2019.150.4385.2 | 235456    | 25-Jul-24 | 22:02 | x86      |
| Exceldest.dll                                                 | 2019.150.4385.2 | 280528    | 25-Jul-24 | 22:02 | x64      |
| Excelsrc.dll                                                  | 2019.150.4385.2 | 260032    | 25-Jul-24 | 22:02 | x86      |
| Excelsrc.dll                                                  | 2019.150.4385.2 | 309288    | 25-Jul-24 | 22:02 | x64      |
| Execpackagetask.dll                                           | 2019.150.4385.2 | 149440    | 25-Jul-24 | 22:02 | x86      |
| Execpackagetask.dll                                           | 2019.150.4385.2 | 186424    | 25-Jul-24 | 22:02 | x64      |
| Flatfiledest.dll                                              | 2019.150.4385.2 | 358352    | 25-Jul-24 | 22:02 | x86      |
| Flatfiledest.dll                                              | 2019.150.4385.2 | 411704    | 25-Jul-24 | 22:02 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4385.2 | 370744    | 25-Jul-24 | 22:02 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4385.2 | 428072    | 25-Jul-24 | 22:02 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4385.2     | 120768    | 25-Jul-24 | 22:02 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4385.2     | 120784    | 25-Jul-24 | 22:02 | x86      |
| Isserverexec.exe                                              | 15.0.4385.2     | 149456    | 25-Jul-24 | 22:02 | x86      |
| Isserverexec.exe                                              | 15.0.4385.2     | 145360    | 25-Jul-24 | 22:02 | x64      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4385.2     | 116672    | 25-Jul-24 | 22:02 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4385.2     | 59328     | 25-Jul-24 | 22:02 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4385.2     | 59448     | 25-Jul-24 | 22:02 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4385.2     | 509888    | 25-Jul-24 | 22:02 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4385.2     | 509992    | 25-Jul-24 | 22:02 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4385.2     | 42944     | 25-Jul-24 | 22:02 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4385.2     | 43048     | 25-Jul-24 | 22:02 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4385.2     | 391208    | 25-Jul-24 | 22:02 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4385.2     | 59432     | 25-Jul-24 | 22:02 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4385.2     | 141352    | 25-Jul-24 | 22:02 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4385.2     | 219072    | 25-Jul-24 | 22:02 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4385.2 | 100408    | 25-Jul-24 | 22:02 | x86      |
| Msdtssrvrutil.dll                                             | 2019.150.4385.2 | 112592    | 25-Jul-24 | 22:02 | x64      |
| Msmdpp.dll                                                    | 2018.150.35.48  | 10062912  | 25-Jul-24 | 21:58 | x64      |
| Odbcdest.dll                                                  | 2019.150.4385.2 | 370728    | 25-Jul-24 | 22:02 | x64      |
| Odbcdest.dll                                                  | 2019.150.4385.2 | 321576    | 25-Jul-24 | 22:02 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4385.2 | 382912    | 25-Jul-24 | 22:02 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4385.2 | 329784    | 25-Jul-24 | 22:02 | x86      |
| Oledbdest.dll                                                 | 2019.150.4385.2 | 280616    | 25-Jul-24 | 22:02 | x64      |
| Oledbdest.dll                                                 | 2019.150.4385.2 | 239552    | 25-Jul-24 | 22:02 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4385.2 | 313384    | 25-Jul-24 | 22:02 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4385.2 | 264128    | 25-Jul-24 | 22:02 | x86      |
| Rawdest.dll                                                   | 2019.150.4385.2 | 190416    | 25-Jul-24 | 22:02 | x86      |
| Rawdest.dll                                                   | 2019.150.4385.2 | 227368    | 25-Jul-24 | 22:02 | x64      |
| Rawsource.dll                                                 | 2019.150.4385.2 | 178128    | 25-Jul-24 | 22:02 | x86      |
| Rawsource.dll                                                 | 2019.150.4385.2 | 210888    | 25-Jul-24 | 22:02 | x64      |
| Recordsetdest.dll                                             | 2019.150.4385.2 | 174032    | 25-Jul-24 | 22:02 | x86      |
| Recordsetdest.dll                                             | 2019.150.4385.2 | 202808    | 25-Jul-24 | 22:02 | x64      |
| Sqlceip.exe                                                   | 15.0.4385.2     | 297000    | 25-Jul-24 | 22:02 | x86      |
| Sqldest.dll                                                   | 2019.150.4385.2 | 276520    | 25-Jul-24 | 22:02 | x64      |
| Sqldest.dll                                                   | 2019.150.4385.2 | 239552    | 25-Jul-24 | 22:02 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4385.2 | 202792    | 25-Jul-24 | 22:02 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4385.2 | 169920    | 25-Jul-24 | 22:02 | x86      |
| Txagg.dll                                                     | 2019.150.4385.2 | 329768    | 25-Jul-24 | 22:02 | x86      |
| Txagg.dll                                                     | 2019.150.4385.2 | 391224    | 25-Jul-24 | 22:02 | x64      |
| Txbdd.dll                                                     | 2019.150.4385.2 | 153536    | 25-Jul-24 | 22:02 | x86      |
| Txbdd.dll                                                     | 2019.150.4385.2 | 190400    | 25-Jul-24 | 22:02 | x64      |
| Txbestmatch.dll                                               | 2019.150.4385.2 | 546856    | 25-Jul-24 | 22:02 | x86      |
| Txbestmatch.dll                                               | 2019.150.4385.2 | 653368    | 25-Jul-24 | 22:02 | x64      |
| Txcache.dll                                                   | 2019.150.4385.2 | 165824    | 25-Jul-24 | 22:02 | x86      |
| Txcache.dll                                                   | 2019.150.4385.2 | 198696    | 25-Jul-24 | 22:02 | x64      |
| Txcharmap.dll                                                 | 2019.150.4385.2 | 272440    | 25-Jul-24 | 22:02 | x86      |
| Txcharmap.dll                                                 | 2019.150.4385.2 | 313280    | 25-Jul-24 | 22:02 | x64      |
| Txcopymap.dll                                                 | 2019.150.4385.2 | 165824    | 25-Jul-24 | 22:02 | x86      |
| Txcopymap.dll                                                 | 2019.150.4385.2 | 202808    | 25-Jul-24 | 22:02 | x64      |
| Txdataconvert.dll                                             | 2019.150.4385.2 | 276432    | 25-Jul-24 | 22:02 | x86      |
| Txdataconvert.dll                                             | 2019.150.4385.2 | 317480    | 25-Jul-24 | 22:02 | x64      |
| Txderived.dll                                                 | 2019.150.4385.2 | 559144    | 25-Jul-24 | 22:02 | x86      |
| Txderived.dll                                                 | 2019.150.4385.2 | 641080    | 25-Jul-24 | 22:02 | x64      |
| Txfileextractor.dll                                           | 2019.150.4385.2 | 182312    | 25-Jul-24 | 22:02 | x86      |
| Txfileextractor.dll                                           | 2019.150.4385.2 | 219072    | 25-Jul-24 | 22:02 | x64      |
| Txfileinserter.dll                                            | 2019.150.4385.2 | 182216    | 25-Jul-24 | 22:02 | x86      |
| Txfileinserter.dll                                            | 2019.150.4385.2 | 215080    | 25-Jul-24 | 22:02 | x64      |
| Txgroupdups.dll                                               | 2019.150.4385.2 | 255936    | 25-Jul-24 | 22:02 | x86      |
| Txgroupdups.dll                                               | 2019.150.4385.2 | 313384    | 25-Jul-24 | 22:02 | x64      |
| Txlineage.dll                                                 | 2019.150.4385.2 | 128960    | 25-Jul-24 | 22:02 | x86      |
| Txlineage.dll                                                 | 2019.150.4385.2 | 153656    | 25-Jul-24 | 22:02 | x64      |
| Txlookup.dll                                                  | 2019.150.4385.2 | 468928    | 25-Jul-24 | 22:02 | x86      |
| Txlookup.dll                                                  | 2019.150.4385.2 | 542760    | 25-Jul-24 | 22:02 | x64      |
| Txmerge.dll                                                   | 2019.150.4385.2 | 202792    | 25-Jul-24 | 22:02 | x86      |
| Txmerge.dll                                                   | 2019.150.4385.2 | 247848    | 25-Jul-24 | 22:02 | x64      |
| Txmergejoin.dll                                               | 2019.150.4385.2 | 247848    | 25-Jul-24 | 22:02 | x86      |
| Txmergejoin.dll                                               | 2019.150.4385.2 | 309288    | 25-Jul-24 | 22:02 | x64      |
| Txmulticast.dll                                               | 2019.150.4385.2 | 116688    | 25-Jul-24 | 22:02 | x86      |
| Txmulticast.dll                                               | 2019.150.4385.2 | 145360    | 25-Jul-24 | 22:02 | x64      |
| Txpivot.dll                                                   | 2019.150.4385.2 | 206800    | 25-Jul-24 | 22:02 | x86      |
| Txpivot.dll                                                   | 2019.150.4385.2 | 239568    | 25-Jul-24 | 22:02 | x64      |
| Txrowcount.dll                                                | 2019.150.4385.2 | 112576    | 25-Jul-24 | 22:02 | x86      |
| Txrowcount.dll                                                | 2019.150.4385.2 | 141352    | 25-Jul-24 | 22:02 | x64      |
| Txsampling.dll                                                | 2019.150.4385.2 | 157736    | 25-Jul-24 | 22:02 | x86      |
| Txsampling.dll                                                | 2019.150.4385.2 | 194616    | 25-Jul-24 | 22:02 | x64      |
| Txscd.dll                                                     | 2019.150.4385.2 | 198608    | 25-Jul-24 | 22:02 | x86      |
| Txscd.dll                                                     | 2019.150.4385.2 | 235576    | 25-Jul-24 | 22:02 | x64      |
| Txsort.dll                                                    | 2019.150.4385.2 | 231464    | 25-Jul-24 | 22:02 | x86      |
| Txsort.dll                                                    | 2019.150.4385.2 | 288808    | 25-Jul-24 | 22:02 | x64      |
| Txsplit.dll                                                   | 2019.150.4385.2 | 550952    | 25-Jul-24 | 22:02 | x86      |
| Txsplit.dll                                                   | 2019.150.4385.2 | 624592    | 25-Jul-24 | 22:02 | x64      |
| Txtermextraction.dll                                          | 2019.150.4385.2 | 8644648   | 25-Jul-24 | 22:02 | x86      |
| Txtermextraction.dll                                          | 2019.150.4385.2 | 8701992   | 25-Jul-24 | 22:02 | x64      |
| Txtermlookup.dll                                              | 2019.150.4385.2 | 4139048   | 25-Jul-24 | 22:02 | x86      |
| Txtermlookup.dll                                              | 2019.150.4385.2 | 4184104   | 25-Jul-24 | 22:02 | x64      |
| Txunionall.dll                                                | 2019.150.4385.2 | 161832    | 25-Jul-24 | 22:02 | x86      |
| Txunionall.dll                                                | 2019.150.4385.2 | 198712    | 25-Jul-24 | 22:02 | x64      |
| Txunpivot.dll                                                 | 2019.150.4385.2 | 182328    | 25-Jul-24 | 22:02 | x86      |
| Txunpivot.dll                                                 | 2019.150.4385.2 | 215096    | 25-Jul-24 | 22:02 | x64      |
| Xe.dll                                                        | 2019.150.4385.2 | 632888    | 25-Jul-24 | 22:02 | x86      |
| Xe.dll                                                        | 2019.150.4385.2 | 723000    | 25-Jul-24 | 22:02 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                              File   name                             |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1970.0     | 559688    | 25-Jul-24 | 22:38 | x86      |
| Dmsnative.dll                                                        | 2018.150.1970.0 | 152632    | 25-Jul-24 | 22:38 | x64      |
| Dwengineservice.dll                                                  | 15.0.1970.0     | 45016     | 25-Jul-24 | 22:38 | x86      |
| Eng_polybase_odbcdrivermongo_2321_mongodbodbc_sb64_dll.64            | 2.3.21.1023     | 18691056  | 25-Jul-24 | 22:38 | x64      |
| Eng_polybase_odbcdrivermongo_2321_saslsspi_dll.64                    | 1.0.2.1003      | 147504    | 25-Jul-24 | 22:39 | x64      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 25-Jul-24 | 22:38 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 25-Jul-24 | 22:38 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.304       | 2532096   | 25-Jul-24 | 22:39 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2592      | 2425088   | 25-Jul-24 | 22:38 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2592      | 151808    | 25-Jul-24 | 22:38 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2416384   | 25-Jul-24 | 22:38 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.216       | 2953472   | 25-Jul-24 | 22:38 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 25-Jul-24 | 22:38 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 25-Jul-24 | 22:38 | x64      |
| Icudt58.dll                                                          | 58.3.0.0        | 27110344  | 25-Jul-24 | 22:38 | x64      |
| Icudt58.dll                                                          | 58.3.0.0        | 27110344  | 25-Jul-24 | 22:39 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 25-Jul-24 | 22:38 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 25-Jul-24 | 22:38 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2562504   | 25-Jul-24 | 22:38 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2551752   | 25-Jul-24 | 22:39 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15491840  | 25-Jul-24 | 22:39 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 25-Jul-24 | 22:38 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 25-Jul-24 | 22:38 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1924040   | 25-Jul-24 | 22:38 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1888712   | 25-Jul-24 | 22:39 | x64      |
| Instapi150.dll                                                       | 2019.150.4385.2 | 88104     | 25-Jul-24 | 22:38 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 25-Jul-24 | 22:38 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 25-Jul-24 | 22:38 | x64      |
| Libcrypto                                                            | 1.1.1.11        | 4321232   | 25-Jul-24 | 22:38 | x64      |
| Libcrypto                                                            | 1.1.1.14        | 4085336   | 25-Jul-24 | 22:39 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 25-Jul-24 | 22:38 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 521664    | 25-Jul-24 | 22:38 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 25-Jul-24 | 22:38 | x64      |
| Libssl                                                               | 1.1.1.11        | 1322960   | 25-Jul-24 | 22:38 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 25-Jul-24 | 22:38 | x64      |
| Libssl                                                               | 1.1.1.14        | 1195600   | 25-Jul-24 | 22:39 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1970.0     | 67656     | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1970.0     | 293448    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1970.0     | 1957832   | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1970.0     | 169544    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1970.0     | 649800    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1970.0     | 246344    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1970.0     | 139336    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1970.0     | 79832     | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1970.0     | 51272     | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1970.0     | 88648     | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1970.0     | 1129432   | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1970.0     | 80968     | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1970.0     | 70616     | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1970.0     | 35400     | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1970.0     | 31176     | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1970.0     | 46552     | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1970.0     | 21464     | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1970.0     | 26696     | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1970.0     | 131656    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1970.0     | 86488     | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1970.0     | 100936    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1970.0     | 293336    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 120280    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 138184    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 141272    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 137672    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 150488    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 139720    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 134712    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 176600    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 117704    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1970.0     | 136656    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1970.0     | 72776     | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1970.0     | 21976     | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1970.0     | 37448     | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1970.0     | 129096    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1970.0     | 3064904   | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1970.0     | 3955784   | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 118344    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 133192    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 137800    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 133704    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 148440    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 134104    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 130632    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 171080    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 115272    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1970.0     | 132168    | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1970.0     | 67656     | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1970.0     | 2682952   | 25-Jul-24 | 22:38 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1970.0     | 2436568   | 25-Jul-24 | 22:38 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4385.2 | 452648    | 25-Jul-24 | 22:38 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4385.2 | 7407656   | 25-Jul-24 | 22:38 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 25-Jul-24 | 22:38 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 25-Jul-24 | 22:38 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 25-Jul-24 | 22:38 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 25-Jul-24 | 22:38 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 25-Jul-24 | 22:38 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 377792    | 25-Jul-24 | 22:39 | x64      |
| Secforwarder.dll                                                     | 2019.150.4385.2 | 79912     | 25-Jul-24 | 22:38 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1970.0 | 61392     | 25-Jul-24 | 22:38 | x64      |
| Sqldk.dll                                                            | 2019.150.4385.2 | 3180584   | 25-Jul-24 | 22:38 | x64      |
| Sqldumper.exe                                                        | 2019.150.4385.2 | 378920    | 25-Jul-24 | 22:38 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4385.2 | 1595432   | 25-Jul-24 | 22:38 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4385.2 | 4171816   | 25-Jul-24 | 22:38 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4385.2 | 3422264   | 25-Jul-24 | 22:38 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4385.2 | 4163640   | 25-Jul-24 | 22:38 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4385.2 | 4069416   | 25-Jul-24 | 22:38 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4385.2 | 2226216   | 25-Jul-24 | 22:38 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4385.2 | 2177080   | 25-Jul-24 | 22:38 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4385.2 | 3827752   | 25-Jul-24 | 22:38 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4385.2 | 3823672   | 25-Jul-24 | 22:38 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4385.2 | 1542200   | 25-Jul-24 | 22:38 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4385.2 | 4036664   | 25-Jul-24 | 22:38 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.6.1   | 1898520   | 25-Jul-24 | 22:38 | x64      |
| Sqlos.dll                                                            | 2019.150.4385.2 | 43048     | 25-Jul-24 | 22:38 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1970.0 | 4841432   | 25-Jul-24 | 22:38 | x64      |
| Sqltses.dll                                                          | 2019.150.4385.2 | 9119800   | 25-Jul-24 | 22:38 | x64      |
| Tdataodbc_sb                                                         | 17.0.0.27       | 12914640  | 25-Jul-24 | 22:38 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 25-Jul-24 | 22:38 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 25-Jul-24 | 22:38 | x64      |
| Terasso.dll                                                          | 17.0.0.28       | 2357064   | 25-Jul-24 | 22:38 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 25-Jul-24 | 22:38 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 499248    | 25-Jul-24 | 22:39 | x64      |

SQL Server 2019 sql_shared_mr

| File   name | File version | File size |    Date   |  Time | Platform |
|:-----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll  | 15.0.4385.2  | 30760     | 25-Jul-24 | 21:57 | x86      |

SQL Server 2019 sql_tools_extensions

|                          File   name                         |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4385.2 | 1632296   | 25-Jul-24 | 22:18 | x86      |
| Dtaengine.exe                                                | 2019.150.4385.2 | 219176    | 25-Jul-24 | 22:18 | x86      |
| Dteparse.dll                                                 | 2019.150.4385.2 | 112696    | 25-Jul-24 | 22:18 | x86      |
| Dteparse.dll                                                 | 2019.150.4385.2 | 124984    | 25-Jul-24 | 22:18 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4385.2 | 116672    | 25-Jul-24 | 22:18 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4385.2 | 133176    | 25-Jul-24 | 22:18 | x64      |
| Dtepkg.dll                                                   | 2019.150.4385.2 | 133160    | 25-Jul-24 | 22:18 | x86      |
| Dtepkg.dll                                                   | 2019.150.4385.2 | 149456    | 25-Jul-24 | 22:18 | x64      |
| Dtexec.exe                                                   | 2019.150.4385.2 | 64960     | 25-Jul-24 | 22:18 | x86      |
| Dtexec.exe                                                   | 2019.150.4385.2 | 73784     | 25-Jul-24 | 22:18 | x64      |
| Dts.dll                                                      | 2019.150.4385.2 | 2762688   | 25-Jul-24 | 22:18 | x86      |
| Dts.dll                                                      | 2019.150.4385.2 | 3143616   | 25-Jul-24 | 22:18 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4385.2 | 444456    | 25-Jul-24 | 22:18 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4385.2 | 501800    | 25-Jul-24 | 22:18 | x64      |
| Dtsconn.dll                                                  | 2019.150.4385.2 | 432168    | 25-Jul-24 | 22:18 | x86      |
| Dtsconn.dll                                                  | 2019.150.4385.2 | 522280    | 25-Jul-24 | 22:18 | x64      |
| Dtshost.exe                                                  | 2019.150.4385.2 | 89640     | 25-Jul-24 | 22:18 | x86      |
| Dtshost.exe                                                  | 2019.150.4385.2 | 107560    | 25-Jul-24 | 22:18 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4385.2 | 554944    | 25-Jul-24 | 22:18 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4385.2 | 567336    | 25-Jul-24 | 22:18 | x64      |
| Dtspipeline.dll                                              | 2019.150.4385.2 | 1120208   | 25-Jul-24 | 22:18 | x86      |
| Dtspipeline.dll                                              | 2019.150.4385.2 | 1329192   | 25-Jul-24 | 22:18 | x64      |
| Dtswizard.exe                                                | 15.0.4385.2     | 890816    | 25-Jul-24 | 22:18 | x86      |
| Dtswizard.exe                                                | 15.0.4385.2     | 886736    | 25-Jul-24 | 22:18 | x64      |
| Dtuparse.dll                                                 | 2019.150.4385.2 | 88000     | 25-Jul-24 | 22:18 | x86      |
| Dtuparse.dll                                                 | 2019.150.4385.2 | 100392    | 25-Jul-24 | 22:18 | x64      |
| Dtutil.exe                                                   | 2019.150.4385.2 | 130496    | 25-Jul-24 | 22:18 | x86      |
| Dtutil.exe                                                   | 2019.150.4385.2 | 151096    | 25-Jul-24 | 22:18 | x64      |
| Exceldest.dll                                                | 2019.150.4385.2 | 280528    | 25-Jul-24 | 22:18 | x64      |
| Exceldest.dll                                                | 2019.150.4385.2 | 235456    | 25-Jul-24 | 22:18 | x86      |
| Excelsrc.dll                                                 | 2019.150.4385.2 | 309288    | 25-Jul-24 | 22:18 | x64      |
| Excelsrc.dll                                                 | 2019.150.4385.2 | 260032    | 25-Jul-24 | 22:18 | x86      |
| Flatfiledest.dll                                             | 2019.150.4385.2 | 411704    | 25-Jul-24 | 22:18 | x64      |
| Flatfiledest.dll                                             | 2019.150.4385.2 | 358352    | 25-Jul-24 | 22:18 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4385.2 | 428072    | 25-Jul-24 | 22:18 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4385.2 | 370744    | 25-Jul-24 | 22:18 | x86      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4385.2     | 116776    | 25-Jul-24 | 22:18 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4385.2     | 403392    | 25-Jul-24 | 22:18 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4385.2     | 403512    | 25-Jul-24 | 22:18 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4385.2     | 3004352   | 25-Jul-24 | 22:18 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4385.2     | 3004456   | 25-Jul-24 | 22:18 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4385.2     | 42944     | 25-Jul-24 | 22:18 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4385.2     | 43048     | 25-Jul-24 | 22:18 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4385.2     | 59432     | 25-Jul-24 | 22:18 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18185.0    | 100800    | 25-Jul-24 | 22:18 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4385.2 | 100408    | 25-Jul-24 | 22:18 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4385.2 | 112592    | 25-Jul-24 | 22:18 | x64      |
| Msmgdsrv.dll                                                 | 2018.150.35.48  | 8280000   | 25-Jul-24 | 22:18 | x86      |
| Oledbdest.dll                                                | 2019.150.4385.2 | 239552    | 25-Jul-24 | 22:18 | x86      |
| Oledbdest.dll                                                | 2019.150.4385.2 | 280616    | 25-Jul-24 | 22:18 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4385.2 | 264128    | 25-Jul-24 | 22:18 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4385.2 | 313384    | 25-Jul-24 | 22:18 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4385.2 | 38952     | 25-Jul-24 | 22:18 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4385.2 | 51152     | 25-Jul-24 | 22:18 | x64      |
| Sqlscm.dll                                                   | 2019.150.4385.2 | 79912     | 25-Jul-24 | 22:18 | x86      |
| Sqlscm.dll                                                   | 2019.150.4385.2 | 88000     | 25-Jul-24 | 22:18 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4385.2 | 149544    | 25-Jul-24 | 22:18 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4385.2 | 182328    | 25-Jul-24 | 22:18 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4385.2 | 169920    | 25-Jul-24 | 22:18 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4385.2 | 202792    | 25-Jul-24 | 22:18 | x64      |
| Txdataconvert.dll                                            | 2019.150.4385.2 | 276432    | 25-Jul-24 | 22:18 | x86      |
| Txdataconvert.dll                                            | 2019.150.4385.2 | 317480    | 25-Jul-24 | 22:18 | x64      |
| Xe.dll                                                       | 2019.150.4385.2 | 723000    | 25-Jul-24 | 22:18 | x64      |
| Xe.dll                                                       | 2019.150.4385.2 | 632888    | 25-Jul-24 | 22:18 | x86      |

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
