---
title: Cumulative update 6 for SQL Server 2016 (KB4019914)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 cumulative update 6 (KB4019914).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4019914
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Standard
- SQL Server 2016 Web
- SQL Server 2016 Express
---

# KB4019914 - Cumulative Update 6 for SQL Server 2016

_Release Date:_ &nbsp; May 15, 2017  
_Version:_ &nbsp; 13.0.2204.0

This article describes cumulative update package 6 (build number: 13.0.2204.0) for Microsoft SQL Server 2016. This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|
| <a id=9917140>[9917140](#9917140) </a> | [FIX: Query against sys.dm_db_partition_stats DMV is slow if the database contains many partitions in SQL Server 2016 (KB4019903)](https://support.microsoft.com/help/4019903)| SQL service|
| <a id=9902335>[9902335](#9902335) </a> | [FIX: Restore fails when you do backup with compression and checksum on TDE enabled database in SQL Server 2016 (KB4019893)](https://support.microsoft.com/help/4019893)| SQL service|
| <a id=9813852>[9813852](#9813852) </a> | [GDR update package for SQL Server 2016 SP1 (KB3210089)](https://support.microsoft.com/help/3210089)| Reporting Services |
| <a id=9813828>[9813828](#9813828) </a> | [FIX: DMV sys.dm_hadr_availability_group_states displays "NOT_HEALTHY" in synchronization_health_desc column on secondary replicas in SQL Server (KB4013111)](https://support.microsoft.com/help/4013111) | High Availability|
| <a id=9813857>[9813857](#9813857) </a> | [Update reduces the execution frequency of the sp_MSsubscription_cleanup stored procedure in SQL Server (KB4014798)](https://support.microsoft.com/help/4014798)| SQL service|
| <a id=9720331>[9720331](#9720331) </a> | [FIX: You receive incorrect results when you use SQL Server Management Objects to generate a script for a full-text Search index (KB4016850)](https://support.microsoft.com/help/4016850) | Management Tools |
| <a id=9642869>[9642869](#9642869) </a> | [FIX: Deadlock when you use sys.column_store_row_groups and sys.dm_db_column_store_row_group_physical_stats DMV with large DDL operations in SQL Server 2016 (KB4016946)](https://support.microsoft.com/help/4016946) | SQL service|
| <a id=9813835>[9813835](#9813835) </a> | [FIX: SQL Server Profiler fails to obfuscate sp_setapprole when it's executed from a remote procedure call in SQL Server (KB4014756)](https://support.microsoft.com/help/4014756) | SQL service|
| <a id=9808882>[9808882](#9808882) </a> | [FIX: Significantly increased PAGELATCH_EX contentions in sys.sysobjvalues in SQL Server 2016 (KB4013999)](https://support.microsoft.com/help/4013999)| SQL service|
| <a id=9901863>[9901863](#9901863) </a> | [FIX: Database schema is corrupted when you restore a database from a snapshot in SQL Server (KB4019701)](https://support.microsoft.com/help/4019701) | SQL service|
| <a id=9627365>[9627365](#9627365) </a> | [FIX: "The custom resolver for this article requires OLEAUT32.DLL with a minimum version of 2.40.4276" error with merge publication in SQL Server (KB4016945)](https://support.microsoft.com/help/4016945)| SQL service|
| <a id=9813867>[9813867](#9813867) </a> | [FIX: Error occurs when you drop a subscription by using a non-sysadmin account in SQL Server (KB4014738)](https://support.microsoft.com/help/4014738)| SQL service|
| <a id=9822981>[9822981](#9822981) </a> | Intra-query deadlock on communication buffer when you run a bulk load against a clustered columnstore index in SQL Server 2016 (KB4017154)| SQL performance|
| <a id=9813871>[9813871](#9813871) </a> | [FIX: "Partition cannot contain column segments of different data versions" error when you process data on a partition in SSAS Tabular model (KB4013208)](https://support.microsoft.com/help/4013208) | Analysis Services|
| <a id=9906184>[9906184](#9906184) </a> | FIX: A severe error occurs when you create a spatial index with the GEOMETRY_GRID or GEOGRAPHY_GRID option in SQL Server (KB4019671) | SQL service|
| <a id=9813824>[9813824](#9813824) </a> | [FIX: A memory leak in SQLWEP causes the host process Wmiprvse.exe to crash in SQL Server (KB4014732)](https://support.microsoft.com/help/4014732)| SQL service|
| <a id=9875181>[9875181](#9875181) </a> | FIX: SSAS crashes when you retrieve KPIs as hidden members by using schema rowsets in SQL Server (KB4019048) | Analysis Services|
| <a id=9813861>[9813861](#9813861) </a> | [FIX: Failed assertion and many access violation dump files after the sp_replcmds stored procedure is canceled in SQL Server (KB4014706)](https://support.microsoft.com/help/4014706) | SQL service|
| <a id=9719215>[9719215](#9719215) </a> | [FIX: Service Broker endpoint connections aren't closed after an availability group failover in SQL Server (KB4016361)](https://support.microsoft.com/help/4016361) | SQL service|
| <a id=9877136>[9877136](#9877136) </a> | [FIX: Queries against PolyBase external tables return incorrect results in SQL Server 2016 (KB4019840)](https://support.microsoft.com/help/4019840) | SQL service|
| <a id=9917205>[9917205](#9917205) </a> | [FIX: An assertion occurs when you execute an ALTER TABLE SWITCH statement on a partitioned temporal history table in SQL Server 2016 (KB4019863)](https://support.microsoft.com/help/4019863)| SQL service|
| <a id=9901010>[9901010](#9901010) </a> | [FIX: SQL Server 2016 stops responding when the "Latch_Suspend_End" extended event is triggered incorrectly (KB4019446)](https://support.microsoft.com/help/4019446)| SQL performance|

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

SQL Server 2016 Database Services Common Core

| File   name                                | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.adomdclient.dll | 13.0.2204.0     | 1023168   | 21-Apr-2017 | 11:02 | x86      |
| Microsoft.analysisservices.core.dll        | 13.0.2204.0     | 1344192   | 21-Apr-2017 | 11:02 | x86      |
| Microsoft.analysisservices.dll             | 13.0.2204.0     | 702656    | 21-Apr-2017 | 11:02 | x86      |
| Microsoft.analysisservices.tabular.dll     | 13.0.2204.0     | 765632    | 21-Apr-2017 | 11:02 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2204.0     | 707264    | 21-Apr-2017 | 11:02 | x86      |
| Microsoft.sqlserver.edition.dll            | 13.0.2204.0     | 37056     | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.instapi.dll            | 13.0.2204.0     | 46272     | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2204.0 | 72896     | 21-Apr-2017 | 11:05 | x86      |
| Pbsvcacctsync.dll                          | 2015.130.2204.0 | 60096     | 21-Apr-2017 | 11:02 | x86      |
| Sql_common_core_keyfile.dll                | 2015.130.2204.0 | 88768     | 21-Apr-2017 | 11:28 | x86      |
| Sqlmgmprovider.dll                         | 2015.130.2204.0 | 364224    | 21-Apr-2017 | 11:02 | x86      |
| Sqlsvcsync.dll                             | 2015.130.2204.0 | 267456    | 21-Apr-2017 | 11:02 | x86      |
| Sqltdiagn.dll                              | 2015.130.2204.0 | 60608     | 21-Apr-2017 | 11:03 | x86      |
| Svrenumapi130.dll                          | 2015.130.2204.0 | 854208    | 21-Apr-2017 | 11:03 | x86      |

SQL Server 2016 Data Quality

| File   name                   | File version | File size | Date      | Time  | Platform |
|-------------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.ssdqs.cleansing.dll | 13.0.2204.0  | 473280    | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2204.0  | 1876672   | 21-Apr-2017 | 11:01 | x86      |

SQL Server 2016 sql_tools_extensions

| File   name                                                  | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dts.dll                                                      | 2015.130.2204.0 | 2631872   | 21-Apr-2017 | 11:27 | x86      |
| Dtspipeline.dll                                              | 2015.130.2204.0 | 1059520   | 21-Apr-2017 | 11:27 | x86      |
| Dtswizard.exe                                                | 13.0.2204.0     | 895680    | 21-Apr-2017 | 11:02 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2204.0     | 432832    | 21-Apr-2017 | 11:27 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2204.0     | 2044096   | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2204.0     | 33472     | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2204.0     | 250048    | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2204.0     | 33984     | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2204.0     | 606400    | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2204.0     | 445120    | 21-Apr-2017 | 11:05 | x86      |
| Msmdlocal.dll                                                | 2015.130.2204.0 | 37018304  | 21-Apr-2017 | 11:02 | x86      |
| Msmgdsrv.dll                                                 | 2015.130.2204.0 | 6501568   | 21-Apr-2017 | 11:01 | x86      |
| Msolap130.dll                                                | 2015.130.2204.0 | 6968000   | 21-Apr-2017 | 11:02 | x86      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2204.0 | 88768     | 21-Apr-2017 | 11:28 | x86      |
| Xmsrv.dll                                                    | 2015.130.2204.0 | 32696000  | 21-Apr-2017 | 11:01 | x86      |

x64-based versions

SQL Server 2016 Business Intelligence Development Studio

| File   name        | File version    | File size | Date      | Time  | Platform |
|--------------------|-----------------|-----------|-----------|-------|----------|
| Sqlsqm_keyfile.dll | 2015.130.2204.0 | 100544    | 21-Apr-2017 | 11:02 | x64      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date      | Time  | Platform |
|-----------------------|-----------------|-----------|-----------|-------|----------|
| Sqlboot.dll           | 2015.130.2204.0 | 186560    | 21-Apr-2017 | 11:02 | x64      |
| Sqlvdi.dll            | 2015.130.2204.0 | 168640    | 21-Apr-2017 | 11:03 | x86      |
| Sqlvdi.dll            | 2015.130.2204.0 | 197312    | 21-Apr-2017 | 11:03 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.2204.0 | 100544    | 21-Apr-2017 | 11:02 | x64      |

SQL Server 2016 Analysis Services

| File   name                                   | File version    | File size | Date      | Time  | Platform |
|-----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.server.core.dll    | 13.0.2204.0     | 1343680   | 21-Apr-2017 | 11:26 | x86      |
| Microsoft.analysisservices.server.tabular.dll | 13.0.2204.0     | 765624    | 21-Apr-2017 | 11:26 | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 17-Jun-2016 | 13:40 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 17-Jun-2016 | 13:40 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 17-Jun-2016 | 13:40 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 17-Jun-2016 | 13:40 | x86      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 04-Jun-2016  | 17:07 | x64      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 17-Jun-2016 | 13:40 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 04-Jun-2016  | 17:07 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 17-Jun-2016 | 13:40 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 04-Jun-2016  | 17:07 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 17-Jun-2016 | 13:40 | x64      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 17-Jun-2016 | 13:40 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 17-Jun-2016 | 13:40 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 17-Jun-2016 | 13:40 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 17-Jun-2016 | 13:40 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 17-Jun-2016 | 13:40 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 17-Jun-2016 | 13:40 | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 04-Jun-2016  | 17:07 | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 17-Jun-2016 | 13:40 | x86      |
| Msmdlocal.dll                                 | 2015.130.2204.0 | 56107712  | 21-Apr-2017 | 11:02 | x64      |
| Msmdlocal.dll                                 | 2015.130.2204.0 | 37018304  | 21-Apr-2017 | 11:02 | x86      |
| Msmdsrv.exe                                   | 2015.130.2204.0 | 56651968  | 21-Apr-2017 | 11:26 | x64      |
| Msmgdsrv.dll                                  | 2015.130.2204.0 | 6501568   | 21-Apr-2017 | 11:01 | x86      |
| Msmgdsrv.dll                                  | 2015.130.2204.0 | 7499968   | 21-Apr-2017 | 11:04 | x64      |
| Msolap130.dll                                 | 2015.130.2204.0 | 6968000   | 21-Apr-2017 | 11:02 | x86      |
| Msolap130.dll                                 | 2015.130.2204.0 | 8590016   | 21-Apr-2017 | 11:02 | x64      |
| Sql_as_keyfile.dll                            | 2015.130.2204.0 | 100544    | 21-Apr-2017 | 11:02 | x64      |
| Sqlboot.dll                                   | 2015.130.2204.0 | 186560    | 21-Apr-2017 | 11:02 | x64      |
| Sqlceip.exe                                   | 13.0.2204.0     | 249024    | 21-Apr-2017 | 11:02 | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 04-Jun-2016  | 17:07 | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 17-Jun-2016 | 13:40 | x86      |
| Tmapi.dll                                     | 2015.130.2204.0 | 4344504   | 21-Apr-2017 | 11:28 | x64      |
| Tmcachemgr.dll                                | 2015.130.2204.0 | 2825408   | 21-Apr-2017 | 11:28 | x64      |
| Tmpersistence.dll                             | 2015.130.2204.0 | 1069752   | 21-Apr-2017 | 11:28 | x64      |
| Tmtransactions.dll                            | 2015.130.2204.0 | 1349824   | 21-Apr-2017 | 11:28 | x64      |
| Xmsrv.dll                                     | 2015.130.2204.0 | 32696000  | 21-Apr-2017 | 11:01 | x86      |
| Xmsrv.dll                                     | 2015.130.2204.0 | 24015552  | 21-Apr-2017 | 11:28 | x64      |

SQL Server 2016 Database Services Common Core

| File   name                                | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.adomdclient.dll | 13.0.2204.0     | 1023168   | 21-Apr-2017 | 11:02 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 13.0.2204.0     | 1023160   | 21-Apr-2017 | 11:26 | x86      |
| Microsoft.analysisservices.core.dll        | 13.0.2204.0     | 1344192   | 21-Apr-2017 | 11:02 | x86      |
| Microsoft.analysisservices.dll             | 13.0.2204.0     | 702656    | 21-Apr-2017 | 11:02 | x86      |
| Microsoft.analysisservices.tabular.dll     | 13.0.2204.0     | 765632    | 21-Apr-2017 | 11:02 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2204.0     | 707264    | 21-Apr-2017 | 11:02 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2204.0     | 707264    | 21-Apr-2017 | 11:26 | x86      |
| Microsoft.sqlserver.edition.dll            | 13.0.2204.0     | 37056     | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.instapi.dll            | 13.0.2204.0     | 46272     | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2204.0 | 75456     | 21-Apr-2017 | 11:05 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2204.0 | 72896     | 21-Apr-2017 | 11:05 | x86      |
| Pbsvcacctsync.dll                          | 2015.130.2204.0 | 60096     | 21-Apr-2017 | 11:02 | x86      |
| Pbsvcacctsync.dll                          | 2015.130.2204.0 | 72896     | 21-Apr-2017 | 11:02 | x64      |
| Sql_common_core_keyfile.dll                | 2015.130.2204.0 | 100544    | 21-Apr-2017 | 11:02 | x64      |
| Sqlmgmprovider.dll                         | 2015.130.2204.0 | 364224    | 21-Apr-2017 | 11:02 | x86      |
| Sqlmgmprovider.dll                         | 2015.130.2204.0 | 404152    | 21-Apr-2017 | 11:28 | x64      |
| Sqlsvcsync.dll                             | 2015.130.2204.0 | 267456    | 21-Apr-2017 | 11:02 | x86      |
| Sqlsvcsync.dll                             | 2015.130.2204.0 | 349376    | 21-Apr-2017 | 11:28 | x64      |
| Sqltdiagn.dll                              | 2015.130.2204.0 | 60608     | 21-Apr-2017 | 11:03 | x86      |
| Sqltdiagn.dll                              | 2015.130.2204.0 | 67768     | 21-Apr-2017 | 11:28 | x64      |
| Svrenumapi130.dll                          | 2015.130.2204.0 | 854208    | 21-Apr-2017 | 11:03 | x86      |
| Svrenumapi130.dll                          | 2015.130.2204.0 | 1115840   | 21-Apr-2017 | 11:28 | x64      |

SQL Server 2016 Data Quality

| File   name                   | File version | File size | Date      | Time  | Platform |
|-------------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.ssdqs.cleansing.dll | 13.0.2204.0  | 473280    | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.ssdqs.cleansing.dll | 13.0.2204.0  | 473280    | 21-Apr-2017 | 11:04 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2204.0  | 1876672   | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2204.0  | 1876672   | 21-Apr-2017 | 11:04 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                          | File version    | File size | Date      | Time  | Platform |
|--------------------------------------|-----------------|-----------|-----------|-------|----------|
| Databasemail.exe                     | 13.0.16100.4    | 29888     | 09-Dec-2016  | 01:46  | x64      |
| Hadrres.dll                          | 2015.130.2204.0 | 177856    | 21-Apr-2017 | 11:03 | x64      |
| Hkcompile.dll                        | 2015.130.2204.0 | 1297088   | 21-Apr-2017 | 11:03 | x64      |
| Hkengine.dll                         | 2015.130.2204.0 | 5600448   | 21-Apr-2017 | 11:02 | x64      |
| Hkruntime.dll                        | 2015.130.2204.0 | 158912    | 21-Apr-2017 | 11:02 | x64      |
| Microsoft.sqlserver.types.dll        | 2015.130.2204.0 | 391872    | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.vdiinterface.dll | 2015.130.2204.0 | 71360     | 21-Apr-2017 | 11:04 | x64      |
| Qds.dll                              | 2015.130.2204.0 | 844480    | 21-Apr-2017 | 11:02 | x64      |
| Rsfxft.dll                           | 2015.130.2204.0 | 34496     | 21-Apr-2017 | 11:03 | x64      |
| Sql_engine_core_inst_keyfile.dll     | 2015.130.2204.0 | 100544    | 21-Apr-2017 | 11:02 | x64      |
| Sqlaccess.dll                        | 2015.130.2204.0 | 462528    | 21-Apr-2017 | 11:05 | x64      |
| Sqlagent.exe                         | 2015.130.2204.0 | 565952    | 21-Apr-2017 | 11:26 | x64      |
| Sqlboot.dll                          | 2015.130.2204.0 | 186560    | 21-Apr-2017 | 11:02 | x64      |
| Sqlceip.exe                          | 13.0.2204.0     | 249024    | 21-Apr-2017 | 11:02 | x86      |
| Sqldk.dll                            | 2015.130.2204.0 | 2585792   | 21-Apr-2017 | 11:02 | x64      |
| Sqllang.dll                          | 2015.130.2204.0 | 39336128  | 21-Apr-2017 | 11:02 | x64      |
| Sqlmin.dll                           | 2015.130.2204.0 | 37352128  | 21-Apr-2017 | 11:28 | x64      |
| Sqlos.dll                            | 2015.130.2204.0 | 26304     | 21-Apr-2017 | 11:03 | x64      |
| Sqlscriptdowngrade.dll               | 2015.130.2204.0 | 27840     | 21-Apr-2017 | 11:28 | x64      |
| Sqlscriptupgrade.dll                 | 2015.130.2204.0 | 5797056   | 21-Apr-2017 | 11:03 | x64      |
| Sqlserverspatial130.dll              | 2015.130.2204.0 | 732864    | 21-Apr-2017 | 11:03 | x64      |
| Sqlservr.exe                         | 2015.130.2204.0 | 393408    | 21-Apr-2017 | 11:28 | x64      |
| Sqltses.dll                          | 2015.130.2204.0 | 8896704   | 21-Apr-2017 | 11:28 | x64      |
| Stretchcodegen.exe                   | 13.0.2204.0     | 55488     | 21-Apr-2017 | 11:26 | x86      |
| Xpstar.dll                           | 2015.130.2204.0 | 422080    | 21-Apr-2017 | 11:03 | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                                  | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dts.dll                                                      | 2015.130.2204.0 | 3145408   | 21-Apr-2017 | 11:02 | x64      |
| Dtspipeline.dll                                              | 2015.130.2204.0 | 1278144   | 21-Apr-2017 | 11:02 | x64      |
| Dtswizard.exe                                                | 13.0.2204.0     | 895168    | 21-Apr-2017 | 11:02 | x64      |
| Logread.exe                                                  | 2015.130.2204.0 | 616632    | 21-Apr-2017 | 11:26 | x64      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2204.0     | 33984     | 21-Apr-2017 | 11:04 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2204.0     | 606400    | 21-Apr-2017 | 11:04 | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                 | 13.0.2204.0     | 215232    | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll             | 13.0.16107.4    | 30912     | 20-Mar-2017 | 23:54 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2204.0     | 445120    | 21-Apr-2017 | 11:04 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2015.130.2204.0 | 1638080   | 21-Apr-2017 | 11:04 | x64      |
| Repldp.dll                                                   | 2015.130.2204.0 | 276160    | 21-Apr-2017 | 11:02 | x64      |
| Spresolv.dll                                                 | 2015.130.2204.0 | 244928    | 21-Apr-2017 | 11:02 | x64      |
| Sql_engine_core_shared_keyfile.dll                           | 2015.130.2204.0 | 100544    | 21-Apr-2017 | 11:02 | x64      |
| Sqlmergx.dll                                                 | 2015.130.2204.0 | 346816    | 21-Apr-2017 | 11:28 | x64      |
| Sqlwep130.dll                                                | 2015.130.2204.0 | 105664    | 21-Apr-2017 | 11:28 | x64      |
| Ssradd.dll                                                   | 2015.130.2204.0 | 65216     | 21-Apr-2017 | 11:28 | x64      |
| Ssravg.dll                                                   | 2015.130.2204.0 | 65216     | 21-Apr-2017 | 11:28 | x64      |
| Ssrdown.dll                                                  | 2015.130.2204.0 | 50880     | 21-Apr-2017 | 11:28 | x64      |
| Ssrmax.dll                                                   | 2015.130.2204.0 | 63168     | 21-Apr-2017 | 11:28 | x64      |
| Ssrmin.dll                                                   | 2015.130.2204.0 | 63680     | 21-Apr-2017 | 11:28 | x64      |
| Ssrpub.dll                                                   | 2015.130.2204.0 | 51392     | 21-Apr-2017 | 11:28 | x64      |
| Ssrup.dll                                                    | 2015.130.2204.0 | 50880     | 21-Apr-2017 | 11:28 | x64      |
| Txdatacollector.dll                                          | 2015.130.2204.0 | 367296    | 21-Apr-2017 | 11:28 | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date      | Time  | Platform |
|-------------------------------|-----------------|-----------|-----------|-------|----------|
| Launchpad.exe                 | 2015.130.2204.0 | 1011904   | 21-Apr-2017 | 11:02 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.2204.0 | 100544    | 21-Apr-2017 | 11:02 | x64      |
| Sqlsatellite.dll              | 2015.130.2204.0 | 836800    | 21-Apr-2017 | 11:03 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version    | File size | Date      | Time  | Platform |
|--------------------------|-----------------|-----------|-----------|-------|----------|
| Fd.dll                   | 2015.130.2204.0 | 660160    | 21-Apr-2017 | 11:03 | x64      |
| Mswb7.dll                | 14.0.4763.1000  | 331672    | 03-Sep-2014  | 15:52 | x64      |
| Prm0007.bin              | 14.0.4763.1000  | 11602944  | 03-Sep-2014  | 15:53 | x64      |
| Prm0009.bin              | 14.0.4763.1000  | 5739008   | 03-Sep-2014  | 15:53 | x64      |
| Prm0013.bin              | 14.0.4763.1000  | 9482240   | 03-Sep-2014  | 15:53 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.2204.0 | 100544    | 21-Apr-2017 | 11:02 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version    | File size | Date      | Time  | Platform |
|-------------------------|-----------------|-----------|-----------|-------|----------|
| Imrdll.dll              | 13.0.2204.0     | 23744     | 21-Apr-2017 | 11:26 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.2204.0 | 100544    | 21-Apr-2017 | 11:02 | x64      |

SQL Server 2016 Integration Services

| File   name                                                   | File version    | File size | Date      | Time  | Platform |
|---------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dts.dll                                                       | 2015.130.2204.0 | 3145408   | 21-Apr-2017 | 11:02 | x64      |
| Dts.dll                                                       | 2015.130.2204.0 | 2631872   | 21-Apr-2017 | 11:27 | x86      |
| Dtspipeline.dll                                               | 2015.130.2204.0 | 1278144   | 21-Apr-2017 | 11:02 | x64      |
| Dtspipeline.dll                                               | 2015.130.2204.0 | 1059520   | 21-Apr-2017 | 11:27 | x86      |
| Dtswizard.exe                                                 | 13.0.2204.0     | 895680    | 21-Apr-2017 | 11:02 | x86      |
| Dtswizard.exe                                                 | 13.0.2204.0     | 895168    | 21-Apr-2017 | 11:02 | x64      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2204.0     | 469696    | 21-Apr-2017 | 11:04 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2204.0     | 469696    | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2204.0     | 33984     | 21-Apr-2017 | 11:04 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2204.0     | 33984     | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2204.0     | 606400    | 21-Apr-2017 | 11:04 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2204.0     | 606400    | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2204.0     | 445120    | 21-Apr-2017 | 11:04 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2204.0     | 445120    | 21-Apr-2017 | 11:05 | x86      |
| Msdtssrvr.exe                                                 | 13.0.2204.0     | 216768    | 21-Apr-2017 | 11:02 | x64      |
| Sql_is_keyfile.dll                                            | 2015.130.2204.0 | 100544    | 21-Apr-2017 | 11:02 | x64      |
| Sqlceip.exe                                                   | 13.0.2204.0     | 249024    | 21-Apr-2017 | 11:02 | x86      |

SQL Server 2016 sql_polybase_core_inst

| File   name                               | File version | File size | Date      | Time | Platform |
|-------------------------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.sqlserver.datawarehouse.sql.dll | 10.0.8224.29 | 2155712   | 14-Apr-2017 | 05:35 | x86      |

SQL Server 2016 Reporting Services

| File   name                                               | File version    | File size | Date      | Time  | Platform |
|-----------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.reportingservices.authorization.dll             | 13.0.2204.0     | 79040     | 21-Apr-2017 | 11:26 | x86      |
| Microsoft.reportingservices.dataextensions.xmlaclient.dll | 13.0.2204.0     | 567488    | 21-Apr-2017 | 11:26 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.2204.0     | 166080    | 21-Apr-2017 | 11:26 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.2204.0     | 1620672   | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.2204.0     | 657600    | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.2204.0     | 329408    | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.2204.0     | 1069760   | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.2204.0     | 161984    | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2204.0     | 76480     | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2204.0     | 76480     | 21-Apr-2017 | 11:27 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.2204.0     | 124096    | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.2204.0     | 104128    | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.2204.0     | 4910272   | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.2204.0     | 9644224   | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.2204.0     | 92864     | 21-Apr-2017 | 11:02 | x64      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.2204.0     | 5951168   | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.2204.0     | 245952    | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.reportingservices.spbprocessing.dll             | 13.0.2204.0     | 298176    | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.2204.0     | 207552    | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.2204.0     | 500928    | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.2204.0 | 396992    | 21-Apr-2017 | 11:02 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.2204.0 | 391872    | 21-Apr-2017 | 11:05 | x86      |
| Msmdlocal.dll                                             | 2015.130.2204.0 | 56107712  | 21-Apr-2017 | 11:02 | x64      |
| Msmdlocal.dll                                             | 2015.130.2204.0 | 37018304  | 21-Apr-2017 | 11:02 | x86      |
| Msmgdsrv.dll                                              | 2015.130.2204.0 | 6501568   | 21-Apr-2017 | 11:01 | x86      |
| Msmgdsrv.dll                                              | 2015.130.2204.0 | 7499968   | 21-Apr-2017 | 11:04 | x64      |
| Msolap130.dll                                             | 2015.130.2204.0 | 6968000   | 21-Apr-2017 | 11:02 | x86      |
| Msolap130.dll                                             | 2015.130.2204.0 | 8590016   | 21-Apr-2017 | 11:02 | x64      |
| Reportingserviceslibrary.dll                              | 13.0.2204.0     | 2518208   | 21-Apr-2017 | 11:04 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.2204.0 | 114368    | 21-Apr-2017 | 11:01 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.2204.0 | 108736    | 21-Apr-2017 | 11:04 | x64      |
| Reportingservicesnativeserver.dll                         | 2015.130.2204.0 | 99008     | 21-Apr-2017 | 11:04 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.2204.0     | 2698432   | 21-Apr-2017 | 11:04 | x86      |
| Sql_rs_keyfile.dll                                        | 2015.130.2204.0 | 100544    | 21-Apr-2017 | 11:02 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.2204.0 | 584384    | 21-Apr-2017 | 11:02 | x86      |
| Sqlserverspatial130.dll                                   | 2015.130.2204.0 | 732864    | 21-Apr-2017 | 11:03 | x64      |
| Xmsrv.dll                                                 | 2015.130.2204.0 | 32696000  | 21-Apr-2017 | 11:01 | x86      |
| Xmsrv.dll                                                 | 2015.130.2204.0 | 24015552  | 21-Apr-2017 | 11:28 | x64      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time  | Platform |
|------------------------------------|-----------------|-----------|-----------|-------|----------|
| Smrdll.dll                         | 13.0.2204.0     | 23744     | 21-Apr-2017 | 11:04 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.2204.0 | 100544    | 21-Apr-2017 | 11:02 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                                  | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dts.dll                                                      | 2015.130.2204.0 | 3145408   | 21-Apr-2017 | 11:02 | x64      |
| Dts.dll                                                      | 2015.130.2204.0 | 2631872   | 21-Apr-2017 | 11:27 | x86      |
| Dtspipeline.dll                                              | 2015.130.2204.0 | 1278144   | 21-Apr-2017 | 11:02 | x64      |
| Dtspipeline.dll                                              | 2015.130.2204.0 | 1059520   | 21-Apr-2017 | 11:27 | x86      |
| Dtswizard.exe                                                | 13.0.2204.0     | 895680    | 21-Apr-2017 | 11:02 | x86      |
| Dtswizard.exe                                                | 13.0.2204.0     | 895168    | 21-Apr-2017 | 11:02 | x64      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2204.0     | 432832    | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2204.0     | 432832    | 21-Apr-2017 | 11:27 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2204.0     | 2044096   | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2204.0     | 2044096   | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2204.0     | 33472     | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2204.0     | 33472     | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2204.0     | 250048    | 21-Apr-2017 | 11:01 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2204.0     | 250048    | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2204.0     | 33984     | 21-Apr-2017 | 11:04 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2204.0     | 33984     | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2204.0     | 606400    | 21-Apr-2017 | 11:04 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2204.0     | 606400    | 21-Apr-2017 | 11:05 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2204.0     | 445120    | 21-Apr-2017 | 11:04 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2204.0     | 445120    | 21-Apr-2017 | 11:05 | x86      |
| Msmdlocal.dll                                                | 2015.130.2204.0 | 56107712  | 21-Apr-2017 | 11:02 | x64      |
| Msmdlocal.dll                                                | 2015.130.2204.0 | 37018304  | 21-Apr-2017 | 11:02 | x86      |
| Msmgdsrv.dll                                                 | 2015.130.2204.0 | 6501568   | 21-Apr-2017 | 11:01 | x86      |
| Msmgdsrv.dll                                                 | 2015.130.2204.0 | 7499968   | 21-Apr-2017 | 11:04 | x64      |
| Msolap130.dll                                                | 2015.130.2204.0 | 6968000   | 21-Apr-2017 | 11:02 | x86      |
| Msolap130.dll                                                | 2015.130.2204.0 | 8590016   | 21-Apr-2017 | 11:02 | x64      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2204.0 | 100544    | 21-Apr-2017 | 11:02 | x64      |
| Xmsrv.dll                                                    | 2015.130.2204.0 | 32696000  | 21-Apr-2017 | 11:01 | x86      |
| Xmsrv.dll                                                    | 2015.130.2204.0 | 24015552  | 21-Apr-2017 | 11:28 | x64      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
