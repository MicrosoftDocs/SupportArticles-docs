---
title: Cumulative update 7 for SQL Server 2016 (KB4024304)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 cumulative update 7 (KB4024304).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4024304
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Standard
- SQL Server 2016 Web
- SQL Server 2016 Express
---

# KB4024304 - Cumulative Update 7 for SQL Server 2016

_Release Date:_ &nbsp; August 8, 2017  
_Version:_ &nbsp; 13.0.2210.0

Cumulative Update 7 (CU7) for Microsoft SQL Server 2016 was also released as a SQL Server Security Bulletin on 8/8/2017, [KB4019086](https://support.microsoft.com/help/4019086). See [CVE-2017-8516](https://cve.mitre.org/cgi-bin/cvename.cgi?name=cve-2017-8516) for more information. Because of this, you may already have CU7 installed as part of that security bulletin release and installation of this CU is unnecessary. If you do try to install CU7 after CVE-2017-8516, you may receive the following message:

> There are no SQL Server instances or shared features that can be updated on this computer.

This indicates that CU7 is already installed and no further action is required.

> [!NOTE]
> The package name for CU7, "SQLServer2016-KB4024304-<x86/x64>.exe", contains the CVE-2017-8516 KB number (4019086), not the CU7 KB number, (4024304). This can be ignored as a single package services both release channels.

This article describes cumulative update package 7 (build number: 13.0.2210.0) for Microsoft SQL Server 2016. This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

| Bug reference |  Description | Fix area|
|---------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|
| <a id=10029683>[10029683](#10029683) </a> | [FIX: A stored procedure may fail after an automatic failover occurs on a mirrored database in SQL Server (KB4018227)](https://support.microsoft.com/help/4018227)| High Availability |
| <a id=10015189>[10015189](#10015189) </a> | [FIX: Change Data Capture stops working after a recent cumulative update for SQL Server is installed (KB4038210)](https://support.microsoft.com/help/4038210) | SQL service |
| <a id=10163598>[10163598](#10163598) </a> | [FIX: Data mask on a floating points column is removed unexpectedly in SQL Server 2016 (KB4023995)](https://support.microsoft.com/help/4023995) | SQL security|
| <a id=10049123>[10049123](#10049123) </a> | [FIX: SQL Server Analysis Service proactive caching processes a partition but doesn't run an SQL query, causing stale data (KB4013585)](https://support.microsoft.com/help/4013585) | Analysis Services |
| <a id=10049112>[10049112](#10049112) </a> | [FIX: DMF sys.dm_db_incremental_stats_properties doesn't show all partitions if partitioning column is set to character or binary data type (KB4011477)](https://support.microsoft.com/help/4011477)| SQL performance |
| <a id=10049133>[10049133](#10049133) </a> | [FIX: SQL Server 2014 or 2016 Backup to Microsoft Azure Blob storage service URL isn't compatible for TLS 1.2 (KB4017023)](https://support.microsoft.com/help/4017023)| SQL service |
| <a id=10297645>[10297645](#10297645) </a> | [FIX: Security Bulletin MS16-136 breaks the SSRS data source type in PowerPivot in SQL Server 2016 (KB4025402)](https://support.microsoft.com/help/4025402) | Analysis Services |
| <a id=10420071>[10420071](#10420071) </a> | [FIX: Couldn't disable "change data capture" if any column is encrypted by "Always Encrypted" feature of SQL Server 2016 (KB4034376)](https://support.microsoft.com/help/4034376) | SQL service |
| <a id=10049114>[10049114](#10049114) </a> | [FIX: Intermittent failure with System.NullReferenceException when you use custom authentication in SSRS 2014 or 2016 (KB4014862)](https://support.microsoft.com/help/4014862)| Reporting Services|
| <a id=9995483>[9995483](#9995483) </a>| [FIX: Incorrect syntax error when you add a subscription by using the "sp_addpullsubscription_agent" stored procedure in SQL Server (KB4023138)](https://support.microsoft.com/help/4023138)| SQL service |
| <a id=10029656>[10029656](#10029656) </a> | [FIX: Transaction log backup failure on the secondary replica in SQL Server Always-On Availability Groups (KB4017080)](https://support.microsoft.com/help/4017080)| High Availability |
| <a id=10018568>[10018568](#10018568) </a> | [FIX: Parallel query execution returns incorrect results for merge join operations in SQL Server 2016 (KB4022435)](https://support.microsoft.com/help/4022435)| SQL performance |
| <a id=9983973>[9983973](#9983973) </a>| [Fix: System generated stored procedures are created incorrectly in P2P publication if the schema name of published table contains a period (.) in SQL Server 2014 or 2016 (KB4021580)](https://support.microsoft.com/help/4021580) | SQL service |
| <a id=10029670>[10029670](#10029670) </a> | [FIX: System Center Configuration Manager replication process by using BCP APIs fails when there is a large value in an XML column (KB4019125)](https://support.microsoft.com/help/4019125) | XML |
| <a id=10029674>[10029674](#10029674) </a> | [FIX: "Index was out of range" error when exporting to PDF in a SQL Server Reporting Services report (KB4019983)](https://support.microsoft.com/help/4019983) | Reporting Services|
| <a id=10029664>[10029664](#10029664) </a> | [FIX: Access violation when a stored procedure is dropped before you execute END TRY section in SQL Server (KB4015561)](https://support.microsoft.com/help/4015561) | SQL service |
| <a id=10087725>[10087725](#10087725) </a> | [FIX: Expanding the Entities folder on the Manage Groups page takes a long time in SQL Server 2016 MDS (KB4023865)](https://support.microsoft.com/help/4023865) | Data Quality Services (DQS) |
| <a id=10242547>[10242547](#10242547) </a> | [FIX: Access violation with query to retrieve data from a clustered columnstore index in SQL Server 2014 or 2016 (KB4024184)](https://support.microsoft.com/help/4024184) | SQL service |
| <a id=10107255>[10107255](#10107255) </a> | [FIX: Query with UNION ALL and a row goal may run slower in SQL Server 2014 or later versions when it's compared to SQL Server 2008 R2 (KB4023419)](https://support.microsoft.com/help/4023419) | SQL performance |
| <a id=10029679>[10029679](#10029679) </a> | FIX: Reporting Services "SortExpression" cause rsComparisonError when there is a NULL value in a column set as "DataTimeOffset" (KB4017827) | Reporting Services|
| <a id=10375302>[10375302](#10375302) </a> | [FIX: Access violation occurs when you execute a query in SQL Server 2016 (KB4034056)](https://support.microsoft.com/help/4034056)| SQL service |
| <a id=10049121>[10049121](#10049121) </a> | [GDR update package for SQL Server 2016 SP1 (KB3210089)](https://support.microsoft.com/help/3210089)| Reporting Services|
| <a id=10048665>[10048665](#10048665) </a> | [FIX: Deadlocks occur in SSISDB when you run multiple SSIS packages in SQL Server 2014 or 2016 (KB4016804)](https://support.microsoft.com/help/4016804) | Integration Services|
| <a id=10018516>[10018516](#10018516) </a> | [FIX: Databases on secondary replica shows "NOT SYNCHRONIZING" status after failover in SQL Server 2016 (KB4024449)](https://support.microsoft.com/help/4024449)| High Availability |
| <a id=10049127>[10049127](#10049127) </a> | [FIX: SSAS crashes when an MDX query that refers to parent-child dimensions runs in SQL Server 2014 or 2016 (KB4019603)](https://support.microsoft.com/help/4019603)| Analysis Services |
| <a id=10015189>[10015189](#10015189) </a> | [Update adds the "CLR strict security" feature to SQL Server 2016 (KB4018930)](https://support.microsoft.com/help/4018930)| SQL Service |
| <a id=10268792>[10268792](#10268792) </a> | [FIX: Error 9004 when you try to restore a compressed backup from multiple files for a large TDE-encrypted database in SQL Server (KB4025628)](https://support.microsoft.com/help/4025628)| SQL service |
| <a id=10351981>[10351981](#10351981) </a> | [FIX: Fail to compress the backup file when INIT and COMPRESSION option is used in a TDE enabled database in SQL Server 2016 (KB4032200)](https://support.microsoft.com/help/4032200) | SQL service |
| <a id=10273870>[10273870](#10273870) </a> | [FIX: "EXCEPTION_INVALID_CRT_PARAMETER" error when you execute a BULK INSERT statement in SQL Server (KB4024989)](https://support.microsoft.com/help/4024989) | SQL service |
| <a id=10351966>[10351966](#10351966) </a> | [FIX: Restore fails when you do backup by using compression and checksum on a TDE enabled database in SQL Server 2016 (KB4019893)](https://support.microsoft.com/help/4019893)| SQL service |
| <a id=9876047>[9876047](#9876047) </a>| [FIX: Dimension security is ignored by Power BI Desktop in SQL Server Analysis Services (Multidimensional model) (KB4018908)](https://support.microsoft.com/help/4018908) | SQL service |

## How to obtain this cumulative update package

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for Microsoft SQL Server 2016 now](https://www.microsoft.com/download/details.aspx?id=53338)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

> [!NOTE]
> After future cumulative updates are released for SQL Server 2016, this CU can be located and downloaded from the [Microsoft Windows Update Catalog](https://catalog.update.microsoft.com/Search.aspx?q=sql%20server%202016). However, Microsoft recommends that you install the latest cumulative update available.

## Notes for this update

<details>
<summary><b>Cumulative update</b></summary>

Cumulative updates (CU) are now available at the Microsoft Download Center.

Only the most recent CU that was released for SQL Server 2016 is available at the Download Center.

- Each new CU contains all the fixes that were included with the previous CU for the installed version/Service Pack of SQL Server.

- Microsoft recommends ongoing, proactive installation of CUs as they become available:

  - SQL Server CUs are certified to the same levels as Service Packs, and should be installed at the same level of confidence.

  - Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU.

  - CUs may contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.

- Just as for SQL Server service packs, we recommend that you test CUs before you deploy them to production environments.

- We recommend that you upgrade your SQL Server installation to [the latest SQL Server 2016 service pack](https://support.microsoft.com/help/3177534).

</details>

<details>
<summary><b>Hybrid environments deployment</b></summary>

When you deploy the hotfixes to a hybrid environment (such as Always On, replication, cluster, and mirroring), we recommend that you refer to the following articles before you deploy the hotfixes:

- [Upgrade a failover cluster instance](/sql/sql-server/failover-clusters/windows/upgrade-a-sql-server-failover-cluster-instance)

  > [!NOTE]
  > If you don't want to use the rolling update process, follow these steps to apply a CU or SP: </br></br>1. Install the service pack on the passive node. </br></br>2. Install the service pack on the active node (requires a service restart).

- [Upgrade availability group replicas](/sql/database-engine/availability-groups/windows/upgrading-always-on-availability-group-replica-instances)

  > [!NOTE]
  > If you enabled Always On with SSISDB catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) for more information about how to apply a CU or SP in these environments.

- [Apply a hotfix for SQL Server in a transactional replication and database mirroring topology](../../database-engine/replication/install-service-packs-hotfixes.md)

- [Apply a hotfix for SQL Server in a replication topology](../../database-engine/replication/apply-hotfix-sql-replication-topology.md)

- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances)

- [Install SQL Server Servicing Updates](/sql/database-engine/install-windows/install-sql-server-servicing-updates)

</details>

<details>
<summary><b>Language support</b></summary>

- SQL Server Cumulative Updates are currently multilingual. Therefore, this cumulative update package isn't specific to one language. It applies to all supported languages.

- The "Download the latest cumulative update package for Microsoft SQL Server 2014 now" form displays the languages for which the update package is available. If you don't see your language, that's because a cumulative update package isn't available for specifically for that language and the ENU download applies to all languages.

</details>

<details>
<summary><b>Components updated</b></summary>

One cumulative update package includes all the component packages. However, the cumulative update package updates only those components that are installed on the system.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).

</details>

<details>
<summary><b>How to uninstall this update</b></summary>

To do this, follow these steps:

1. In Control Panel, select **Add or Remove Programs**.

   > [!NOTE]
   > If you are running Windows 7 or a later version, select **Programs and Features** in Control Panel.

2. Locate the entry that corresponds to this cumulative update package.

3. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

## Cumulative update package information

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2016.

</details>

<details>
<summary><b>Restart information</b></summary>

You may have to restart the computer after you apply this cumulative update package.

</details>

<details>
<summary><b>Registry information</b></summary>

To use one of the hotfixes in this package, you don't have to make any changes to the registry.

</details>

## File information

<details>
<summary><b>Cumulative update package file information</b></summary>

This cumulative update package may not contain all the files that you must have to fully update a product to the latest build. This package contains only the files that you must have to correct the issues that are listed in this article.

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x86-based versions

SQL Server 2016 Browser Service

| File   name            | File version    | File size | Date      | Time  | Platform |
|------------------------|-----------------|-----------|-----------|-------|----------|
| Msmdsrv.rll            | 2015.130.2210.0 | 1295048   | 17-Jul-2017 | 13:24 | x86      |
| Msmdsrvi.rll           | 2015.130.2210.0 | 1291968   | 17-Jul-2017 | 13:24 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.2210.0 | 88768     | 17-Jul-2017 | 13:23 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.adomdclient.dll | 13.0.2210.0     | 1023168   | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.analysisservices.core.dll        | 13.0.2210.0     | 1344192   | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.analysisservices.dll             | 13.0.2210.0     | 702656    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.analysisservices.tabular.dll     | 13.0.2210.0     | 765632    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2210.0     | 707264    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.sqlserver.edition.dll            | 13.0.2210.0     | 37056     | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.instapi.dll            | 13.0.2210.0     | 46272     | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2210.0 | 72904     | 17-Jul-2017 | 13:23 | x86      |
| Pbsvcacctsync.dll                          | 2015.130.2210.0 | 60096     | 17-Jul-2017 | 13:22 | x86      |
| Sql_common_core_keyfile.dll                | 2015.130.2210.0 | 88768     | 17-Jul-2017 | 13:23 | x86      |
| Sqlmgmprovider.dll                         | 2015.130.2210.0 | 364224    | 17-Jul-2017 | 13:22 | x86      |
| Sqlsvcsync.dll                             | 2015.130.2210.0 | 267456    | 17-Jul-2017 | 13:22 | x86      |
| Sqltdiagn.dll                              | 2015.130.2210.0 | 60608     | 17-Jul-2017 | 13:22 | x86      |
| Svrenumapi130.dll                          | 2015.130.2210.0 | 854208    | 17-Jul-2017 | 13:22 | x86      |

SQL Server 2016 Data Quality

| File   name                   | File version | File size | Date      | Time  | Platform |
|-------------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.ssdqs.cleansing.dll | 13.0.2210.0  | 473280    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2210.0  | 1876680   | 17-Jul-2017 | 13:22 | x86      |

SQL Server 2016 sql_tools_extensions

| File   name                                                  | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Autoadmin.dll                                                | 2015.130.2210.0 | 1311432   | 17-Jul-2017 | 13:23 | x86      |
| Dtaengine.exe                                                | 2015.130.2210.0 | 167112    | 17-Jul-2017 | 13:23 | x86      |
| Dts.dll                                                      | 2015.130.2210.0 | 2631872   | 17-Jul-2017 | 13:23 | x86      |
| Dtspipeline.dll                                              | 2015.130.2210.0 | 1059520   | 17-Jul-2017 | 13:23 | x86      |
| Dtswizard.exe                                                | 13.0.2210.0     | 895680    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2210.0     | 432832    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2210.0     | 2044096   | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2210.0     | 33480     | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2210.0     | 250056    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2210.0     | 33984     | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2210.0     | 606400    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2210.0     | 445120    | 17-Jul-2017 | 13:23 | x86      |
| Msmdlocal.dll                                                | 2015.130.2210.0 | 37019840  | 17-Jul-2017 | 13:22 | x86      |
| Msmgdsrv.dll                                                 | 2015.130.2210.0 | 6501568   | 17-Jul-2017 | 13:22 | x86      |
| Msolap130.dll                                                | 2015.130.2210.0 | 6968000   | 17-Jul-2017 | 13:22 | x86      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2210.0 | 88768     | 17-Jul-2017 | 13:23 | x86      |
| Xmsrv.dll                                                    | 2015.130.2210.0 | 32696000  | 17-Jul-2017 | 13:22 | x86      |

x64-based versions

SQL Server 2016 Browser Service

| File   name  | File version    | File size | Date      | Time  | Platform |
|--------------|-----------------|-----------|-----------|-------|----------|
| Keyfile.dll  | 2015.130.2210.0 | 88768     | 17-Jul-2017 | 13:23 | x86      |
| Msmdsrv.rll  | 2015.130.2210.0 | 1295048   | 17-Jul-2017 | 13:24 | x86      |
| Msmdsrvi.rll | 2015.130.2210.0 | 1291968   | 17-Jul-2017 | 13:24 | x86      |

SQL Server 2016 Business Intelligence Development Studio

| File   name        | File version    | File size | Date      | Time  | Platform |
|--------------------|-----------------|-----------|-----------|-------|----------|
| Sqlsqm_keyfile.dll | 2015.130.2210.0 | 100552    | 17-Jul-2017 | 13:22 | x64      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date      | Time  | Platform |
|-----------------------|-----------------|-----------|-----------|-------|----------|
| Sqlboot.dll           | 2015.130.2210.0 | 186568    | 17-Jul-2017 | 13:22 | x64      |
| Sqlvdi.dll            | 2015.130.2210.0 | 168640    | 17-Jul-2017 | 13:22 | x86      |
| Sqlvdi.dll            | 2015.130.2210.0 | 197312    | 17-Jul-2017 | 13:23 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.2210.0 | 100552    | 17-Jul-2017 | 13:22 | x64      |

SQL Server 2016 Analysis Services

| File   name                                   | File version    | File size | Date      | Time  | Platform |
|-----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.server.core.dll    | 13.0.2210.0     | 1343680   | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.analysisservices.server.tabular.dll | 13.0.2210.0     | 765632    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 20-Jun-2016 | 13:28 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 20-Jun-2016 | 13:28 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 20-Jun-2016 | 13:28 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 20-Jun-2016 | 13:28 | x86      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 04-Jun-2016  | 17:07 | x64      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 20-Jun-2016 | 13:28 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 04-Jun-2016  | 17:07 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 20-Jun-2016 | 13:28 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 04-Jun-2016  | 17:07 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 20-Jun-2016 | 13:28 | x64      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 20-Jun-2016 | 13:28 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 20-Jun-2016 | 13:28 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 20-Jun-2016 | 13:28 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 20-Jun-2016 | 13:28 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 20-Jun-2016 | 13:28 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 20-Jun-2016 | 13:28 | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 20-Jun-2016 | 13:28 | x86      |
| Msmdlocal.dll                                 | 2015.130.2210.0 | 37019840  | 17-Jul-2017 | 13:22 | x86      |
| Msmdlocal.dll                                 | 2015.130.2210.0 | 56109768  | 17-Jul-2017 | 13:22 | x64      |
| Msmdsrv.exe                                   | 2015.130.2210.0 | 56655552  | 17-Jul-2017 | 13:23 | x64      |
| Msmgdsrv.dll                                  | 2015.130.2210.0 | 6501568   | 17-Jul-2017 | 13:22 | x86      |
| Msmgdsrv.dll                                  | 2015.130.2210.0 | 7499968   | 17-Jul-2017 | 13:22 | x64      |
| Msolap130.dll                                 | 2015.130.2210.0 | 6968000   | 17-Jul-2017 | 13:22 | x86      |
| Msolap130.dll                                 | 2015.130.2210.0 | 8590024   | 17-Jul-2017 | 13:22 | x64      |
| Sql_as_keyfile.dll                            | 2015.130.2210.0 | 100552    | 17-Jul-2017 | 13:22 | x64      |
| Sqlboot.dll                                   | 2015.130.2210.0 | 186568    | 17-Jul-2017 | 13:22 | x64      |
| Sqlceip.exe                                   | 13.0.2210.0     | 249032    | 17-Jul-2017 | 13:23 | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 04-Jun-2016  | 17:07 | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 20-Jun-2016 | 13:28 | x86      |
| Tmapi.dll                                     | 2015.130.2210.0 | 4344512   | 17-Jul-2017 | 13:20 | x64      |
| Tmcachemgr.dll                                | 2015.130.2210.0 | 2825408   | 17-Jul-2017 | 13:20 | x64      |
| Tmpersistence.dll                             | 2015.130.2210.0 | 1069768   | 17-Jul-2017 | 13:20 | x64      |
| Tmtransactions.dll                            | 2015.130.2210.0 | 1349824   | 17-Jul-2017 | 13:20 | x64      |
| Xmsrv.dll                                     | 2015.130.2210.0 | 24015552  | 17-Jul-2017 | 13:20 | x64      |
| Xmsrv.dll                                     | 2015.130.2210.0 | 32696000  | 17-Jul-2017 | 13:22 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.adomdclient.dll | 13.0.2210.0     | 1023168   | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 13.0.2210.0     | 1023168   | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.analysisservices.core.dll        | 13.0.2210.0     | 1344192   | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.analysisservices.dll             | 13.0.2210.0     | 702656    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.analysisservices.tabular.dll     | 13.0.2210.0     | 765632    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2210.0     | 707264    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2210.0     | 707264    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.edition.dll            | 13.0.2210.0     | 37056     | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.instapi.dll            | 13.0.2210.0     | 46272     | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2210.0 | 75456     | 17-Jul-2017 | 13:22 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2210.0 | 72904     | 17-Jul-2017 | 13:23 | x86      |
| Pbsvcacctsync.dll                          | 2015.130.2210.0 | 60096     | 17-Jul-2017 | 13:22 | x86      |
| Pbsvcacctsync.dll                          | 2015.130.2210.0 | 72896     | 17-Jul-2017 | 13:22 | x64      |
| Sql_common_core_keyfile.dll                | 2015.130.2210.0 | 100552    | 17-Jul-2017 | 13:22 | x64      |
| Sqlmgmprovider.dll                         | 2015.130.2210.0 | 404160    | 17-Jul-2017 | 13:20 | x64      |
| Sqlmgmprovider.dll                         | 2015.130.2210.0 | 364224    | 17-Jul-2017 | 13:22 | x86      |
| Sqlsvcsync.dll                             | 2015.130.2210.0 | 348864    | 17-Jul-2017 | 13:20 | x64      |
| Sqlsvcsync.dll                             | 2015.130.2210.0 | 267456    | 17-Jul-2017 | 13:22 | x86      |
| Sqltdiagn.dll                              | 2015.130.2210.0 | 67776     | 17-Jul-2017 | 13:20 | x64      |
| Sqltdiagn.dll                              | 2015.130.2210.0 | 60608     | 17-Jul-2017 | 13:22 | x86      |
| Svrenumapi130.dll                          | 2015.130.2210.0 | 1115840   | 17-Jul-2017 | 13:20 | x64      |
| Svrenumapi130.dll                          | 2015.130.2210.0 | 854208    | 17-Jul-2017 | 13:22 | x86      |

SQL Server 2016 Data Quality

| File   name                   | File version | File size | Date      | Time  | Platform |
|-------------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.ssdqs.cleansing.dll | 13.0.2210.0  | 473280    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.ssdqs.cleansing.dll | 13.0.2210.0  | 473280    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2210.0  | 1876680   | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2210.0  | 1876672   | 17-Jul-2017 | 13:22 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Backuptourl.exe                            | 13.0.2210.0     | 41152     | 17-Jul-2017 | 13:23 | x64      |
| Databasemail.exe                           | 13.0.16100.4    | 29888     | 09-Dec-2016  | 01:46  | x64      |
| Hadrres.dll                                | 2015.130.2210.0 | 177856    | 17-Jul-2017 | 13:23 | x64      |
| Hkcompile.dll                              | 2015.130.2210.0 | 1297088   | 17-Jul-2017 | 13:23 | x64      |
| Hkengine.dll                               | 2015.130.2210.0 | 5600448   | 17-Jul-2017 | 13:23 | x64      |
| Hkruntime.dll                              | 2015.130.2210.0 | 158912    | 17-Jul-2017 | 13:23 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 13.0.2210.0     | 231624    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.types.dll              | 2015.130.2210.0 | 391872    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.sqlserver.vdiinterface.dll       | 2015.130.2210.0 | 71360     | 17-Jul-2017 | 13:22 | x64      |
| Qds.dll                                    | 2015.130.2210.0 | 844480    | 17-Jul-2017 | 13:22 | x64      |
| Rsfxft.dll                                 | 2015.130.2210.0 | 34496     | 17-Jul-2017 | 13:23 | x64      |
| Sql_engine_core_inst_keyfile.dll           | 2015.130.2210.0 | 100552    | 17-Jul-2017 | 13:22 | x64      |
| Sqlaccess.dll                              | 2015.130.2210.0 | 462528    | 17-Jul-2017 | 13:22 | x64      |
| Sqlagent.exe                               | 2015.130.2210.0 | 565952    | 17-Jul-2017 | 13:23 | x64      |
| Sqlboot.dll                                | 2015.130.2210.0 | 186568    | 17-Jul-2017 | 13:22 | x64      |
| Sqlceip.exe                                | 13.0.2210.0     | 249032    | 17-Jul-2017 | 13:23 | x86      |
| Sqldk.dll                                  | 2015.130.2210.0 | 2585792   | 17-Jul-2017 | 13:22 | x64      |
| Sqllang.dll                                | 2015.130.2210.0 | 39335616  | 17-Jul-2017 | 13:22 | x64      |
| Sqlmin.dll                                 | 2015.130.2210.0 | 37353152  | 17-Jul-2017 | 13:20 | x64      |
| Sqlos.dll                                  | 2015.130.2210.0 | 26304     | 17-Jul-2017 | 13:23 | x64      |
| Sqlscriptdowngrade.dll                     | 2015.130.2210.0 | 27840     | 17-Jul-2017 | 13:20 | x64      |
| Sqlscriptupgrade.dll                       | 2015.130.2210.0 | 5797568   | 17-Jul-2017 | 13:23 | x64      |
| Sqlserverspatial130.dll                    | 2015.130.2210.0 | 732864    | 17-Jul-2017 | 13:23 | x64      |
| Sqlservr.exe                               | 2015.130.2210.0 | 392896    | 17-Jul-2017 | 13:23 | x64      |
| Sqltses.dll                                | 2015.130.2210.0 | 8896704   | 17-Jul-2017 | 13:20 | x64      |
| Stretchcodegen.exe                         | 13.0.2210.0     | 55488     | 17-Jul-2017 | 13:23 | x86      |
| Xpstar.dll                                 | 2015.130.2210.0 | 422080    | 17-Jul-2017 | 13:23 | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                                  | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dts.dll                                                      | 2015.130.2210.0 | 3145408   | 17-Jul-2017 | 13:22 | x64      |
| Dtspipeline.dll                                              | 2015.130.2210.0 | 1278144   | 17-Jul-2017 | 13:22 | x64      |
| Dtswizard.exe                                                | 13.0.2210.0     | 895176    | 17-Jul-2017 | 13:23 | x64      |
| Logread.exe                                                  | 2015.130.2210.0 | 616640    | 17-Jul-2017 | 13:23 | x64      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2210.0     | 33984     | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2210.0     | 606400    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                 | 13.0.2210.0     | 215232    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll             | 13.0.16107.4    | 30912     | 20-Mar-2017 | 23:54 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2210.0     | 445120    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2015.130.2210.0 | 1638088   | 17-Jul-2017 | 13:22 | x64      |
| Repldp.dll                                                   | 2015.130.2210.0 | 276160    | 17-Jul-2017 | 13:22 | x64      |
| Spresolv.dll                                                 | 2015.130.2210.0 | 244928    | 17-Jul-2017 | 13:22 | x64      |
| Sql_engine_core_shared_keyfile.dll                           | 2015.130.2210.0 | 100552    | 17-Jul-2017 | 13:22 | x64      |
| Sqlmergx.dll                                                 | 2015.130.2210.0 | 346816    | 17-Jul-2017 | 13:20 | x64      |
| Sqlwep130.dll                                                | 2015.130.2210.0 | 105664    | 17-Jul-2017 | 13:20 | x64      |
| Ssradd.dll                                                   | 2015.130.2210.0 | 65216     | 17-Jul-2017 | 13:20 | x64      |
| Ssravg.dll                                                   | 2015.130.2210.0 | 65216     | 17-Jul-2017 | 13:20 | x64      |
| Ssrdown.dll                                                  | 2015.130.2210.0 | 50880     | 17-Jul-2017 | 13:20 | x64      |
| Ssrmax.dll                                                   | 2015.130.2210.0 | 63168     | 17-Jul-2017 | 13:20 | x64      |
| Ssrmin.dll                                                   | 2015.130.2210.0 | 63680     | 17-Jul-2017 | 13:20 | x64      |
| Ssrpub.dll                                                   | 2015.130.2210.0 | 51392     | 17-Jul-2017 | 13:20 | x64      |
| Ssrup.dll                                                    | 2015.130.2210.0 | 50880     | 17-Jul-2017 | 13:20 | x64      |
| Txdatacollector.dll                                          | 2015.130.2210.0 | 367304    | 17-Jul-2017 | 13:20 | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date      | Time  | Platform |
|-------------------------------|-----------------|-----------|-----------|-------|----------|
| Launchpad.exe                 | 2015.130.2210.0 | 1011904   | 17-Jul-2017 | 13:22 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.2210.0 | 100552    | 17-Jul-2017 | 13:22 | x64      |
| Sqlsatellite.dll              | 2015.130.2210.0 | 836808    | 17-Jul-2017 | 13:23 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version    | File size | Date      | Time  | Platform |
|--------------------------|-----------------|-----------|-----------|-------|----------|
| Fd.dll                   | 2015.130.2210.0 | 660160    | 17-Jul-2017 | 13:23 | x64      |
| Mswb7.dll                | 14.0.4763.1000  | 331672    | 20-Jun-2016 | 13:29 | x64      |
| Prm0007.bin              | 14.0.4763.1000  | 11602944  | 20-Jun-2016 | 13:29 | x64      |
| Prm0009.bin              | 14.0.4763.1000  | 5739008   | 20-Jun-2016 | 13:29 | x64      |
| Prm0013.bin              | 14.0.4763.1000  | 9482240   | 20-Jun-2016 | 13:29 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.2210.0 | 100552    | 17-Jul-2017 | 13:22 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version    | File size | Date      | Time  | Platform |
|-------------------------|-----------------|-----------|-----------|-------|----------|
| Imrdll.dll              | 13.0.2210.0     | 23744     | 17-Jul-2017 | 13:23 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.2210.0 | 100552    | 17-Jul-2017 | 13:22 | x64      |

SQL Server 2016 Integration Services

| File   name                                                   | File version    | File size | Date      | Time  | Platform |
|---------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dts.dll                                                       | 2015.130.2210.0 | 3145408   | 17-Jul-2017 | 13:22 | x64      |
| Dts.dll                                                       | 2015.130.2210.0 | 2631872   | 17-Jul-2017 | 13:23 | x86      |
| Dtspipeline.dll                                               | 2015.130.2210.0 | 1278144   | 17-Jul-2017 | 13:22 | x64      |
| Dtspipeline.dll                                               | 2015.130.2210.0 | 1059520   | 17-Jul-2017 | 13:23 | x86      |
| Dtswizard.exe                                                 | 13.0.2210.0     | 895680    | 17-Jul-2017 | 13:22 | x86      |
| Dtswizard.exe                                                 | 13.0.2210.0     | 895176    | 17-Jul-2017 | 13:23 | x64      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2210.0     | 469696    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2210.0     | 469696    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2210.0     | 33984     | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2210.0     | 33984     | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2210.0     | 606400    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2210.0     | 606400    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2210.0     | 445120    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2210.0     | 445120    | 17-Jul-2017 | 13:23 | x86      |
| Msdtssrvr.exe                                                 | 13.0.2210.0     | 216768    | 17-Jul-2017 | 13:23 | x64      |
| Sql_is_keyfile.dll                                            | 2015.130.2210.0 | 100552    | 17-Jul-2017 | 13:22 | x64      |
| Sqlceip.exe                                                   | 13.0.2210.0     | 249032    | 17-Jul-2017 | 13:23 | x86      |

SQL Server 2016 sql_polybase_core_inst

| File   name                               | File version | File size | Date      | Time | Platform |
|-------------------------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.sqlserver.datawarehouse.sql.dll | 10.0.8224.29 | 2155712   | 14-Apr-2017 | 05:35 | x86      |

SQL Server 2016 Reporting Services

| File   name                                               | File version    | File size | Date      | Time  | Platform |
|-----------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.reportingservices.authorization.dll             | 13.0.2210.0     | 79040     | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.dataextensions.xmlaclient.dll | 13.0.2210.0     | 567488    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.2210.0     | 166088    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.2210.0     | 1619648   | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.2210.0     | 657600    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.2210.0     | 329920    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.2210.0     | 1069760   | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.2210.0     | 161984    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2210.0     | 76480     | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2210.0     | 76480     | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.2210.0     | 124096    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.2210.0     | 104128    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.2210.0     | 4910272   | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.2210.0     | 9645768   | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.2210.0     | 92864     | 17-Jul-2017 | 13:23 | x64      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.2210.0     | 5951168   | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.2210.0     | 245952    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.spbprocessing.dll             | 13.0.2210.0     | 298176    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.2210.0     | 207552    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.2210.0     | 500928    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.2210.0 | 391872    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.2210.0 | 396992    | 17-Jul-2017 | 13:23 | x86      |
| Msmdlocal.dll                                             | 2015.130.2210.0 | 37019840  | 17-Jul-2017 | 13:22 | x86      |
| Msmdlocal.dll                                             | 2015.130.2210.0 | 56109768  | 17-Jul-2017 | 13:22 | x64      |
| Msmgdsrv.dll                                              | 2015.130.2210.0 | 6501568   | 17-Jul-2017 | 13:22 | x86      |
| Msmgdsrv.dll                                              | 2015.130.2210.0 | 7499968   | 17-Jul-2017 | 13:22 | x64      |
| Msolap130.dll                                             | 2015.130.2210.0 | 6968000   | 17-Jul-2017 | 13:22 | x86      |
| Msolap130.dll                                             | 2015.130.2210.0 | 8590024   | 17-Jul-2017 | 13:22 | x64      |
| Reportingserviceslibrary.dll                              | 13.0.2210.0     | 2516160   | 17-Jul-2017 | 13:22 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.2210.0 | 114368    | 17-Jul-2017 | 13:22 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.2210.0 | 108736    | 17-Jul-2017 | 13:22 | x64      |
| Reportingservicesnativeserver.dll                         | 2015.130.2210.0 | 99008     | 17-Jul-2017 | 13:22 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.2210.0     | 2698432   | 17-Jul-2017 | 13:22 | x86      |
| Sql_rs_keyfile.dll                                        | 2015.130.2210.0 | 100552    | 17-Jul-2017 | 13:22 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.2210.0 | 584392    | 17-Jul-2017 | 13:22 | x86      |
| Sqlserverspatial130.dll                                   | 2015.130.2210.0 | 732864    | 17-Jul-2017 | 13:23 | x64      |
| Xmsrv.dll                                                 | 2015.130.2210.0 | 24015552  | 17-Jul-2017 | 13:20 | x64      |
| Xmsrv.dll                                                 | 2015.130.2210.0 | 32696000  | 17-Jul-2017 | 13:22 | x86      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time  | Platform |
|------------------------------------|-----------------|-----------|-----------|-------|----------|
| Smrdll.dll                         | 13.0.2210.0     | 23744     | 17-Jul-2017 | 13:22 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.2210.0 | 100552    | 17-Jul-2017 | 13:22 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                                  | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Autoadmin.dll                                                | 2015.130.2210.0 | 1311432   | 17-Jul-2017 | 13:23 | x86      |
| Dtaengine.exe                                                | 2015.130.2210.0 | 167112    | 17-Jul-2017 | 13:23 | x86      |
| Dts.dll                                                      | 2015.130.2210.0 | 3145408   | 17-Jul-2017 | 13:22 | x64      |
| Dts.dll                                                      | 2015.130.2210.0 | 2631872   | 17-Jul-2017 | 13:23 | x86      |
| Dtspipeline.dll                                              | 2015.130.2210.0 | 1278144   | 17-Jul-2017 | 13:22 | x64      |
| Dtspipeline.dll                                              | 2015.130.2210.0 | 1059520   | 17-Jul-2017 | 13:23 | x86      |
| Dtswizard.exe                                                | 13.0.2210.0     | 895680    | 17-Jul-2017 | 13:22 | x86      |
| Dtswizard.exe                                                | 13.0.2210.0     | 895176    | 17-Jul-2017 | 13:23 | x64      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2210.0     | 432832    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2210.0     | 432832    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2210.0     | 2044096   | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2210.0     | 2044096   | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2210.0     | 33480     | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2210.0     | 33472     | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2210.0     | 250056    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2210.0     | 250048    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2210.0     | 33984     | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2210.0     | 33984     | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2210.0     | 606400    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2210.0     | 606400    | 17-Jul-2017 | 13:23 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2210.0     | 445120    | 17-Jul-2017 | 13:22 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2210.0     | 445120    | 17-Jul-2017 | 13:23 | x86      |
| Msmdlocal.dll                                                | 2015.130.2210.0 | 37019840  | 17-Jul-2017 | 13:22 | x86      |
| Msmdlocal.dll                                                | 2015.130.2210.0 | 56109768  | 17-Jul-2017 | 13:22 | x64      |
| Msmgdsrv.dll                                                 | 2015.130.2210.0 | 6501568   | 17-Jul-2017 | 13:22 | x86      |
| Msmgdsrv.dll                                                 | 2015.130.2210.0 | 7499968   | 17-Jul-2017 | 13:22 | x64      |
| Msolap130.dll                                                | 2015.130.2210.0 | 6968000   | 17-Jul-2017 | 13:22 | x86      |
| Msolap130.dll                                                | 2015.130.2210.0 | 8590024   | 17-Jul-2017 | 13:22 | x64      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2210.0 | 100552    | 17-Jul-2017 | 13:22 | x64      |
| Xmsrv.dll                                                    | 2015.130.2210.0 | 24015552  | 17-Jul-2017 | 13:20 | x64      |
| Xmsrv.dll                                                    | 2015.130.2210.0 | 32696000  | 17-Jul-2017 | 13:22 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
