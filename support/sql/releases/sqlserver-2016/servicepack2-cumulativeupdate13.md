---
title: Cumulative update 13 for SQL Server 2016 SP2 (KB4549825)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP2 cumulative update 13 (KB4549825).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4549825
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Web
---

# KB4549825 - Cumulative Update 13 for SQL Server 2016 SP2

_Release Date:_ &nbsp; May 28, 2020  
_Version:_ &nbsp; 13.0.5820.21

This article describes Cumulative Update package 13 (CU13) (build number: **13.0.5820.21**) for Microsoft SQL Server 2016 Service Pack 2 (SP2). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the initial release of SQL Server 2016 SP2.

## Improvements and fixes included in this update

| Bug reference | Description| Fix area | Platform |
|---------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|----------|
| <a id=13395275>[13395275](#13395275) </a> | Access violation exception may occur when `sp_server_diagnostics` is executed. | High Availability| Windows|
| <a id=13418764>[13418764](#13418764) </a> | `DBCC CHECKDB` can incorrectly report corruption on Spatial Index if base table has a column called Id. | SQL Engine | Windows|
| <a id=13422835>[13422835](#13422835) </a> | [FIX: SSRS 2016 URLs are case-sensitive after applying Security Update GDRs KB4532097 or KB4535706 (KB4556096)](https://support.microsoft.com/help/4556096)| Reporting Services | Windows|
| <a id=13431656>[13431656](#13431656) </a> | When SP/CU/GDR are applied on the SQL Server 2016 that has LocalDB installed, it may fail to update LocalDB binaries the first time it is executed. However, the second attempt to apply SP/CU/GDR will successfully update the files. | Setup & Install| Windows|
| <a id=13433228>[13433228](#13433228) </a> | Improves speed of memory dump generation (filtered dumps) using Page exclusion bitmap mechanism. The PageExclusionBitmap is turned on by default in SQL Server 2016. | SQL Engine | Windows|
| <a id=13435878>[13435878](#13435878) </a> | [FIX: Access violation exception occurs when promoting latches of frequently used database pages in SQL Server 2016 and 2017 (KB4551720)](https://support.microsoft.com/help/4551720)| SQL Engine | Windows|
| <a id=13443327>[13443327](#13443327) </a> | Access violation exception may occur when you execute queries in read uncommitted mode with high concurrent read or write pattern over XML data types. | SQL Engine | Windows|
| <a id=13457594>[13457594](#13457594) </a> | When you concurrently create sub directories in a FileTable directory, a deadlock may occur internally in the SQL Server Engine and all subsequent requests to FileTable directories and files may not respond.| SQL Engine | Windows|
| <a id=13463169>[13463169](#13463169) </a> | Fixed the long package execution time involving SSIS task of type TransferSqlServerObjectsTask when database contains tens of thousands of tables and the db user is not `db_owner`. | Integration Services | Windows|
| <a id=13478331>[13478331](#13478331) </a> | When a replication error such as deadlock occurs, the id value in the `MSRepl_errors` table increases a lot than the previous id value while it should only increase by 1. | Replication| Windows|
| <a id=13482849>[13482849](#13482849) </a> | When you run some alter commands that include rollback immediate option, the rollback may trigger before the command is processed even if the `ALTER` itself may fail due to lack of permissions. This hotfix will make sure that the rollback is processed only after the `ALTER` command completes.| SQL Engine | Windows|
| <a id=13485749>[13485749](#13485749) </a> | [FIX: Full-Text search auto crawl stops when Availability Group goes offline in SQL Server 2014 and 2016 (KB4511771)](https://support.microsoft.com/help/4511771)| SQL Engine | Windows|
| <a id=13487253>[13487253](#13487253) </a> | [FIX: Upgrade script may fail if you use an Always On high availability group as a secondary replica in SQL Server 2016 (KB4563115)](https://support.microsoft.com/help/4563115) | SQL Engine | Windows|
| <a id=13488608>[13488608](#13488608) </a> | `DELETE` statement return Foreign Key check constraint error as following even when REFERENCE table has no matching rows: </br></br>Msg 547, Level 16, State 0, Line \<LineNumber> </br>The DELETE statement conflicted with the REFERENCE constraint "FK_\<TableName>_\<ColumnName>". </br>The conflict occurred in database "\<DatabaseName", table "dbo.\<TableName>", column '\<ColumnName>'. </br>The statement has been terminated.| SQL performance| Windows|
| <a id=13418158>[13418158](#13418158) </a> | You encounter non-yielding messages (Msg 17883) when a query with large number of expressions is compiled. </br></br>\<DateTime>Server&nbsp;&nbsp;&nbsp;&nbsp;Process 0:0:0 (0x402c) Worker 0x0000001A619EC160 appears to be non-yielding on Scheduler 11. Thread creation time: 13224499735417. Approx Thread CPU Used: kernel 0 ms, user 70187 ms. Process Utilization 40%. System Idle 58%. Interval: 70193 ms. | SQL performance| Windows|
| <a id=13490149>[13490149](#13490149) </a> | This improves MDX query execution performance against a dimension user hierarchy which is a ragged hierarchy (HideMemberIf property set ) and has deep hierarchy level in SSAS Multidimensional instance.| Analysis Services| Windows|
| <a id=13491308>[13491308](#13491308) </a> | R Setup components fails to download CAB files when TLS 1.0 is disabled. This update includes a new R Setup version to add support for TLS1.2. | Setup & Install| Windows|
| <a id=13502076>[13502076](#13502076) </a> | `sys.key_constraints` reports duplicate rows for an index if you have an XML component id with an id which is same as the `object_id` of the primary key.| SQL Engine | Windows|
| <a id=13503406>[13503406](#13503406) </a> | R Setup components fails to download CAB files when TLS 1.0 is disabled. This update includes a new R Setup version to add support for TLS1.2. | Setup & Install| Windows|
| <a id=13507493>[13507493](#13507493) </a> | When you execute `DBCC CHECKTABLE`, `CHECKFILEGROUP` and `CHECKDB` commands against a database with table that contains Clustered Columnstore Index (CCI) located on a read-only filegroup, then you may receive the following error message: </br></br>Msg 8921, Level 16, State 1, Line \<LineNumber> </br>Check terminated. A failure was detected while collecting facts. Possibly tempdb out of space or a system table is inconsistent. Check previous errors. | SQL Engine | Windows|
| <a id=13508254>[13508254](#13508254) </a> | [FIX: Distributed transactions may experience long waits with DTC_STATE wait type in SQL Server 2016 (KB4560183)](https://support.microsoft.com/help/4560183)| SQL Engine | Windows|
| <a id=13517385>[13517385](#13517385) </a> | Assertion exception or Access Violation occurs when you query `sys.dm_db_file_space_usage` dmv in SQL Server 2016. | SQL Engine | Windows|
| <a id=13517428>[13517428](#13517428) </a> |  [FIX: Concurrent inserts against tables with columnstore indexes may cause queries to hang in SQL Server 2016 (KB4561305)](https://support.microsoft.com/help/4561305) | SQL Engine | Windows|
| <a id=13520595>[13520595](#13520595) </a> | Assertion may occur on the mirror server during redo process in SQL Server 2016. </br><br>Assertion: File: \<FileName>, line = \<LineNumber> Failed Assertion = 'result == LCK_OK' | High Availability| Windows|
| <a id=13525856>[13525856](#13525856) </a> | Access violation exception occurs when a query is executed with recursive CTE whose anchor is Clustered Columnstore Index (CCI) in SQL Server 2016.| SQL performance| Windows|
| <a id=13530802>[13530802](#13530802) </a> | Access Violation exception occurs when executing a query that references a non-existing partition function in SQL Server 2016. | SQL performance| Windows|
| <a id=13525672>[13525672](#13525672) </a> | [FIX: Assertion dump may occur when Implicit Transactions are enabled in SQL Server 2016 and 2017 (KB4563597)](https://support.microsoft.com/help/4563597) | SQL Engine | Windows|
| <a id=13545688>[13545688](#13545688) </a> | SQL Server failed to start: </br></br>The script level for 'system_xevents_modification.sql' in database 'master' cannot be downgraded from XXXXXXXXX to XXXXXXXXX, which is supported by this server. This usually implies that a future database was attached and the downgrade path is not supported by the current installation. Install a newer version of SQL Server and retry opening the database.| SQL Engine | Windows|
| <a id=13458569>[13458569](#13458569) </a> | Spatial data types (Geometry and Geography) are implemented as CLR data types in SQL Server. When the application domain hosting the spatial data type structures is unloaded, the engine treats this as a schema change to the underlying objects referenced in the cursor. As a result, spatial query may fail with related error message when the schema change is detected.| SQL Engine | All|
| <a id=13508779>[13508779](#13508779) </a> | [FIX: Availability Group failover generates lots of dumps as DTC support is toggled between PER_DB and NONE multiple times (KB4562173)](https://support.microsoft.com/help/4562173) | High Availability| All|

## How to obtain this cumulative update package

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2016 SP2 now](https://www.microsoft.com/download/details.aspx?id=56975)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

> [!NOTE]
> After future cumulative updates are released for SQL Server 2016, this CU can be located and downloaded from the [Microsoft Windows Update Catalog](https://catalog.update.microsoft.com/Search.aspx?q=sql%20server%202016). However, We recommend that you install the latest cumulative update available.

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
  > If you don't want to use the rolling update process, follow these steps to apply an update: </br></br>1. Install the service pack on the passive node. </br></br>2. Install the update on the active node (requires a service restart).

- [Upgrade availability group replicas](/sql/database-engine/availability-groups/windows/upgrading-always-on-availability-group-replica-instances)

  > [!NOTE]
  > If you enabled Always On with SSISDB catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) for more information about how to apply an update in these environments.

- [Apply a hotfix for SQL Server in a transactional replication and database mirroring topology](../../database-engine/replication/install-service-packs-hotfixes.md)

- [Apply a hotfix for SQL Server in a replication topology](../../database-engine/replication/apply-hotfix-sql-replication-topology.md)

- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances)

- [Install SQL Server Servicing Updates](/sql/database-engine/install-windows/install-sql-server-servicing-updates)

</details>

<details>
<summary><b>Language support</b></summary>

 SQL Server Cumulative Updates are currently multilingual. Therefore, this cumulative update package isn't specific to one language. It applies to all supported languages.

</details>

<details>
<summary><b>Components (features) updated</b></summary>

One Cumulative Update package includes all available updates for ALL SQL Server 2016 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance you select to be serviced.  If a SQL Server feature (e.g. Analysis Services) is added to the instance after this CU is applied, you must re-apply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).

</details>

<details>
<summary><b>How to uninstall this update</b></summary>

1. In Control Panel, select **View installed updates** under **Programs and Features**.

2. Locate the entry that corresponds to this cumulative update package under Microsoft SQL Server 2016.

3. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

## Cumulative update package information

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2016 SP2.

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

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2016 Browser Service

| File   name    | File version     | File size | Date      | Time  | Platform |
|----------------|------------------|-----------|-----------|-------|----------|
| Instapi130.dll | 2015.131.5820.21 | 46488     | 22-May-2020 | 20:43 | x86      |
| Keyfile.dll    | 2015.131.5820.21 | 81816     | 22-May-2020 | 20:46 | x86      |
| Sqlbrowser.exe | 2015.131.5820.21 | 269704    | 22-May-2020 | 20:44 | x86      |
| Sqldumper.exe  | 2015.131.5820.21 | 103832    | 22-May-2020 | 20:43 | x86      |

SQL Server 2016 Writer

| File   name           | File version     | File size | Date      | Time  | Platform |
|-----------------------|------------------|-----------|-----------|-------|----------|
| Instapi130.dll        | 2015.131.5820.21 | 54160     | 22-May-2020 | 20:45 | x64      |
| Sqlboot.dll           | 2015.131.5820.21 | 179608    | 22-May-2020 | 20:43 | x64      |
| Sqldumper.exe         | 2015.131.5820.21 | 123272    | 22-May-2020 | 20:45 | x64      |
| Sqlvdi.dll            | 2015.131.5820.21 | 161688    | 22-May-2020 | 20:43 | x86      |
| Sqlvdi.dll            | 2015.131.5820.21 | 190360    | 22-May-2020 | 20:45 | x64      |
| Sqlwriter.exe         | 2015.131.5820.21 | 124816    | 22-May-2020 | 20:43 | x64      |
| Sqlwriter_keyfile.dll | 2015.131.5820.21 | 93584     | 22-May-2020 | 20:44 | x64      |
| Sqlwvss.dll           | 2015.131.5820.21 | 339864    | 22-May-2020 | 20:41 | x64      |
| Sqlwvss_xp.dll        | 2015.131.5820.21 | 19336     | 22-May-2020 | 20:38 | x64      |

SQL Server 2016 Analysis Services

| File name                                  | File version     | File size | Date        | Time  | Platform |
|--------------------------------------------|------------------|-----------|-------------|-------|----------|
| Microsoft.analysisservices.server.core.dll | 13.0.5820.21     | 1341320   | 22-May-2020 | 20:47 | x86      |
| Microsoft.applicationinsights.dll          | 2.7.0.13435      | 329872    | 06-Jul-2018 | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5820.21     | 983440    | 22-May-2020 | 20:45 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5820.21     | 983440    | 22-May-2020 | 20:47 | x86      |
| Msmdctr130.dll                             | 2015.131.5820.21 | 33168     | 22-May-2020 | 20:44 | x64      |
| Msmdlocal.dll                              | 2015.131.5820.21 | 37128080  | 22-May-2020 | 20:44 | x86      |
| Msmdlocal.dll                              | 2015.131.5820.21 | 56246672  | 22-May-2020 | 20:45 | x64      |
| Msmdsrv.exe                                | 2015.131.5820.21 | 56790424  | 22-May-2020 | 20:45 | x64      |
| Msmgdsrv.dll                               | 2015.131.5820.21 | 7502736   | 22-May-2020 | 20:51 | x64      |
| Msmgdsrv.dll                               | 2015.131.5820.21 | 6502280   | 22-May-2020 | 20:51 | x86      |
| Msolap130.dll                              | 2015.131.5820.21 | 7004056   | 22-May-2020 | 20:45 | x86      |
| Msolap130.dll                              | 2015.131.5820.21 | 8636304   | 22-May-2020 | 20:45 | x64      |
| Msolui130.dll                              | 2015.131.5820.21 | 303512    | 22-May-2020 | 20:43 | x64      |
| Msolui130.dll                              | 2015.131.5820.21 | 280464    | 22-May-2020 | 20:44 | x86      |
| Sql_as_keyfile.dll                         | 2015.131.5820.21 | 93584     | 22-May-2020 | 20:44 | x64      |
| Sqlboot.dll                                | 2015.131.5820.21 | 179608    | 22-May-2020 | 20:43 | x64      |
| Sqlceip.exe                                | 13.0.5820.21     | 249240    | 22-May-2020 | 20:44 | x86      |
| Sqldumper.exe                              | 2015.131.5820.21 | 103832    | 22-May-2020 | 20:43 | x86      |
| Sqldumper.exe                              | 2015.131.5820.21 | 123272    | 22-May-2020 | 20:45 | x64      |
| Tmapi.dll                                  | 2015.131.5820.21 | 4339080   | 22-May-2020 | 20:38 | x64      |
| Tmcachemgr.dll                             | 2015.131.5820.21 | 2819472   | 22-May-2020 | 20:37 | x64      |
| Tmpersistence.dll                          | 2015.131.5820.21 | 1064336   | 22-May-2020 | 20:37 | x64      |
| Tmtransactions.dll                         | 2015.131.5820.21 | 1345416   | 22-May-2020 | 20:37 | x64      |
| Xe.dll                                     | 2015.131.5820.21 | 619400    | 22-May-2020 | 20:46 | x64      |
| Xmlrw.dll                                  | 2015.131.5820.21 | 312208    | 22-May-2020 | 20:45 | x64      |
| Xmlrw.dll                                  | 2015.131.5820.21 | 252816    | 22-May-2020 | 20:49 | x86      |
| Xmlrwbin.dll                               | 2015.131.5820.21 | 220560    | 22-May-2020 | 20:45 | x64      |
| Xmlrwbin.dll                               | 2015.131.5820.21 | 184712    | 22-May-2020 | 20:49 | x86      |
| Xmsrv.dll                                  | 2015.131.5820.21 | 24040840  | 22-May-2020 | 20:40 | x64      |
| Xmsrv.dll                                  | 2015.131.5820.21 | 32721304  | 22-May-2020 | 20:49 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time  | Platform |
|---------------------------------------------|------------------|-----------|-----------|-------|----------|
| Batchparser.dll                             | 2015.131.5820.21 | 153496    | 22-May-2020 | 20:43 | x86      |
| Batchparser.dll                             | 2015.131.5820.21 | 173960    | 22-May-2020 | 20:46 | x64      |
| Instapi130.dll                              | 2015.131.5820.21 | 46488     | 22-May-2020 | 20:43 | x86      |
| Instapi130.dll                              | 2015.131.5820.21 | 54160     | 22-May-2020 | 20:45 | x64      |
| Isacctchange.dll                            | 2015.131.5820.21 | 22408     | 22-May-2020 | 20:43 | x86      |
| Isacctchange.dll                            | 2015.131.5820.21 | 23944     | 22-May-2020 | 20:46 | x64      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5820.21     | 1020816   | 22-May-2020 | 20:47 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5820.21     | 1020816   | 22-May-2020 | 20:49 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.5820.21     | 1341840   | 22-May-2020 | 20:49 | x86      |
| Microsoft.analysisservices.dll              | 13.0.5820.21     | 695696    | 22-May-2020 | 20:49 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.5820.21     | 758672    | 22-May-2020 | 20:47 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.5820.21     | 513944    | 22-May-2020 | 20:49 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5820.21     | 704904    | 22-May-2020 | 20:47 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5820.21     | 704920    | 22-May-2020 | 20:48 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5820.21 | 65944     | 22-May-2020 | 20:46 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5820.21 | 68488     | 22-May-2020 | 20:48 | x64      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5820.21     | 562576    | 22-May-2020 | 20:46 | x86      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5820.21     | 562568    | 22-May-2020 | 20:51 | x86      |
| Msasxpress.dll                              | 2015.131.5820.21 | 29080     | 22-May-2020 | 20:43 | x64      |
| Msasxpress.dll                              | 2015.131.5820.21 | 24984     | 22-May-2020 | 20:44 | x86      |
| Pbsvcacctsync.dll                           | 2015.131.5820.21 | 65944     | 22-May-2020 | 20:43 | x64      |
| Pbsvcacctsync.dll                           | 2015.131.5820.21 | 53136     | 22-May-2020 | 20:44 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.131.5820.21 | 93584     | 22-May-2020 | 20:44 | x64      |
| Sqldumper.exe                               | 2015.131.5820.21 | 103832    | 22-May-2020 | 20:43 | x86      |
| Sqldumper.exe                               | 2015.131.5820.21 | 123272    | 22-May-2020 | 20:45 | x64      |
| Sqlftacct.dll                               | 2015.131.5820.21 | 44936     | 22-May-2020 | 20:43 | x64      |
| Sqlftacct.dll                               | 2015.131.5820.21 | 39816     | 22-May-2020 | 20:43 | x86      |
| Sqlmgmprovider.dll                          | 2015.131.5820.21 | 399240    | 22-May-2020 | 20:40 | x64      |
| Sqlmgmprovider.dll                          | 2015.131.5820.21 | 358808    | 22-May-2020 | 20:44 | x86      |
| Sqlsecacctchg.dll                           | 2015.131.5820.21 | 30608     | 22-May-2020 | 20:38 | x64      |
| Sqlsecacctchg.dll                           | 2015.131.5820.21 | 28056     | 22-May-2020 | 20:43 | x86      |
| Sqltdiagn.dll                               | 2015.131.5820.21 | 60816     | 22-May-2020 | 20:40 | x64      |
| Sqltdiagn.dll                               | 2015.131.5820.21 | 53656     | 22-May-2020 | 20:43 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version     | File size | Date      | Time  | Platform |
|--------------------------------|------------------|-----------|-----------|-------|----------|
| Dreplayclient.exe              | 2015.131.5820.21 | 114064    | 22-May-2020 | 20:44 | x86      |
| Dreplaycommon.dll              | 2015.131.5820.21 | 683928    | 22-May-2020 | 20:49 | x86      |
| Dreplayutil.dll                | 2015.131.5820.21 | 303000    | 22-May-2020 | 20:43 | x86      |
| Instapi130.dll                 | 2015.131.5820.21 | 54160     | 22-May-2020 | 20:45 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.131.5820.21 | 93584     | 22-May-2020 | 20:44 | x64      |
| Sqlresourceloader.dll          | 2015.131.5820.21 | 21400     | 22-May-2020 | 20:44 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version     | File size | Date      | Time  | Platform |
|------------------------------------|------------------|-----------|-----------|-------|----------|
| Dreplaycommon.dll                  | 2015.131.5820.21 | 683928    | 22-May-2020 | 20:49 | x86      |
| Dreplaycontroller.exe              | 2015.131.5820.21 | 343440    | 22-May-2020 | 20:44 | x86      |
| Dreplayprocess.dll                 | 2015.131.5820.21 | 164760    | 22-May-2020 | 20:44 | x86      |
| Instapi130.dll                     | 2015.131.5820.21 | 54160     | 22-May-2020 | 20:45 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.131.5820.21 | 93584     | 22-May-2020 | 20:44 | x64      |
| Sqlresourceloader.dll              | 2015.131.5820.21 | 21400     | 22-May-2020 | 20:44 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------|------------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 13.0.5820.21     | 34200     | 22-May-2020 | 20:43 | x64      |
| Batchparser.dll                              | 2015.131.5820.21 | 173960    | 22-May-2020 | 20:46 | x64      |
| Datacollectorcontroller.dll                  | 2015.131.5820.21 | 218512    | 22-May-2020 | 20:45 | x64      |
| Dcexec.exe                                   | 2015.131.5820.21 | 67464     | 22-May-2020 | 20:44 | x64      |
| Fssres.dll                                   | 2015.131.5820.21 | 74632     | 22-May-2020 | 20:46 | x64      |
| Hadrres.dll                                  | 2015.131.5820.21 | 170888    | 22-May-2020 | 20:46 | x64      |
| Hkcompile.dll                                | 2015.131.5820.21 | 1291160   | 22-May-2020 | 20:45 | x64      |
| Hkengine.dll                                 | 2015.131.5820.21 | 5594520   | 22-May-2020 | 20:45 | x64      |
| Hkruntime.dll                                | 2015.131.5820.21 | 151952    | 22-May-2020 | 20:45 | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435      | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.5820.21     | 227224    | 22-May-2020 | 20:50 | x86      |
| Microsoft.sqlserver.types.dll                | 2015.131.5820.21 | 385944    | 22-May-2020 | 20:48 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.131.5820.21 | 65416     | 22-May-2020 | 20:52 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.131.5820.21 | 58248     | 22-May-2020 | 20:48 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5820.21 | 143256    | 22-May-2020 | 20:48 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5820.21 | 151960    | 22-May-2020 | 20:48 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.131.5820.21 | 265112    | 22-May-2020 | 20:49 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.131.5820.21 | 67984     | 22-May-2020 | 20:48 | x64      |
| Odsole70.dll                                 | 2015.131.5820.21 | 85912     | 22-May-2020 | 20:44 | x64      |
| Opends60.dll                                 | 2015.131.5820.21 | 26000     | 22-May-2020 | 20:45 | x64      |
| Qds.dll                                      | 2015.131.5820.21 | 866704    | 22-May-2020 | 20:44 | x64      |
| Rsfxft.dll                                   | 2015.131.5820.21 | 27528     | 22-May-2020 | 20:45 | x64      |
| Sqagtres.dll                                 | 2015.131.5820.21 | 57752     | 22-May-2020 | 20:43 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.131.5820.21 | 93584     | 22-May-2020 | 20:44 | x64      |
| Sqlaamss.dll                                 | 2015.131.5820.21 | 73624     | 22-May-2020 | 20:50 | x64      |
| Sqlaccess.dll                                | 2015.131.5820.21 | 456072    | 22-May-2020 | 20:49 | x64      |
| Sqlagent.exe                                 | 2015.131.5820.21 | 559496    | 22-May-2020 | 20:43 | x64      |
| Sqlagentctr130.dll                           | 2015.131.5820.21 | 37272     | 22-May-2020 | 20:44 | x86      |
| Sqlagentctr130.dll                           | 2015.131.5820.21 | 44952     | 22-May-2020 | 20:48 | x64      |
| Sqlagentlog.dll                              | 2015.131.5820.21 | 25992     | 22-May-2020 | 20:43 | x64      |
| Sqlagentmail.dll                             | 2015.131.5820.21 | 40856     | 22-May-2020 | 20:49 | x64      |
| Sqlboot.dll                                  | 2015.131.5820.21 | 179608    | 22-May-2020 | 20:43 | x64      |
| Sqlceip.exe                                  | 13.0.5820.21     | 249240    | 22-May-2020 | 20:44 | x86      |
| Sqlcmdss.dll                                 | 2015.131.5820.21 | 53136     | 22-May-2020 | 20:44 | x64      |
| Sqldk.dll                                    | 2015.131.5820.21 | 2588552   | 22-May-2020 | 20:45 | x64      |
| Sqldtsss.dll                                 | 2015.131.5820.21 | 90520     | 22-May-2020 | 20:49 | x64      |
| Sqliosim.com                                 | 2015.131.5820.21 | 300952    | 22-May-2020 | 20:48 | x64      |
| Sqliosim.exe                                 | 2015.131.5820.21 | 3007376   | 22-May-2020 | 20:43 | x64      |
| Sqllang.dll                                  | 2015.131.5820.21 | 39540112  | 22-May-2020 | 20:46 | x64      |
| Sqlmin.dll                                   | 2015.131.5820.21 | 37942672  | 22-May-2020 | 20:41 | x64      |
| Sqlolapss.dll                                | 2015.131.5820.21 | 91032     | 22-May-2020 | 20:51 | x64      |
| Sqlos.dll                                    | 2015.131.5820.21 | 19344     | 22-May-2020 | 20:46 | x64      |
| Sqlpowershellss.dll                          | 2015.131.5820.21 | 51592     | 22-May-2020 | 20:38 | x64      |
| Sqlrepss.dll                                 | 2015.131.5820.21 | 48008     | 22-May-2020 | 20:38 | x64      |
| Sqlresld.dll                                 | 2015.131.5820.21 | 23960     | 22-May-2020 | 20:38 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5820.21 | 23944     | 22-May-2020 | 20:38 | x64      |
| Sqlscm.dll                                   | 2015.131.5820.21 | 54160     | 22-May-2020 | 20:45 | x64      |
| Sqlscriptdowngrade.dll                       | 2015.131.5820.21 | 20880     | 22-May-2020 | 20:38 | x64      |
| Sqlscriptupgrade.dll                         | 2015.131.5820.21 | 5804944   | 22-May-2020 | 20:46 | x64      |
| Sqlserverspatial130.dll                      | 2015.131.5820.21 | 725896    | 22-May-2020 | 20:45 | x64      |
| Sqlservr.exe                                 | 2015.131.5820.21 | 385944    | 22-May-2020 | 20:43 | x64      |
| Sqlsvc.dll                                   | 2015.131.5820.21 | 145288    | 22-May-2020 | 20:38 | x64      |
| Sqltses.dll                                  | 2015.131.5820.21 | 8916368   | 22-May-2020 | 20:40 | x64      |
| Sqsrvres.dll                                 | 2015.131.5820.21 | 244104    | 22-May-2020 | 20:39 | x64      |
| Xe.dll                                       | 2015.131.5820.21 | 619400    | 22-May-2020 | 20:46 | x64      |
| Xmlrw.dll                                    | 2015.131.5820.21 | 312208    | 22-May-2020 | 20:45 | x64      |
| Xmlrwbin.dll                                 | 2015.131.5820.21 | 220560    | 22-May-2020 | 20:45 | x64      |
| Xpadsi.exe                                   | 2015.131.5820.21 | 72080     | 22-May-2020 | 20:51 | x64      |
| Xplog70.dll                                  | 2015.131.5820.21 | 58768     | 22-May-2020 | 20:45 | x64      |
| Xpsqlbot.dll                                 | 2015.131.5820.21 | 26512     | 22-May-2020 | 20:46 | x64      |
| Xpstar.dll                                   | 2015.131.5820.21 | 415632    | 22-May-2020 | 20:46 | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                  | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------|------------------|-----------|-----------|-------|----------|
| Batchparser.dll                              | 2015.131.5820.21 | 153496    | 22-May-2020 | 20:43 | x86      |
| Batchparser.dll                              | 2015.131.5820.21 | 173960    | 22-May-2020 | 20:46 | x64      |
| Bcp.exe                                      | 2015.131.5820.21 | 113040    | 22-May-2020 | 20:45 | x64      |
| Commanddest.dll                              | 2015.131.5820.21 | 242072    | 22-May-2020 | 20:44 | x64      |
| Datacollectorenumerators.dll                 | 2015.131.5820.21 | 108936    | 22-May-2020 | 20:44 | x64      |
| Datacollectortasks.dll                       | 2015.131.5820.21 | 181128    | 22-May-2020 | 20:45 | x64      |
| Distrib.exe                                  | 2015.131.5820.21 | 184216    | 22-May-2020 | 20:43 | x64      |
| Dteparse.dll                                 | 2015.131.5820.21 | 102792    | 22-May-2020 | 20:45 | x64      |
| Dteparsemgd.dll                              | 2015.131.5820.21 | 81800     | 22-May-2020 | 20:47 | x64      |
| Dtepkg.dll                                   | 2015.131.5820.21 | 130440    | 22-May-2020 | 20:45 | x64      |
| Dtexec.exe                                   | 2015.131.5820.21 | 65944     | 22-May-2020 | 20:43 | x64      |
| Dts.dll                                      | 2015.131.5820.21 | 3139984   | 22-May-2020 | 20:45 | x64      |
| Dtscomexpreval.dll                           | 2015.131.5820.21 | 470416    | 22-May-2020 | 20:45 | x64      |
| Dtsconn.dll                                  | 2015.131.5820.21 | 485768    | 22-May-2020 | 20:45 | x64      |
| Dtshost.exe                                  | 2015.131.5820.21 | 79768     | 22-May-2020 | 20:43 | x64      |
| Dtslog.dll                                   | 2015.131.5820.21 | 113552    | 22-May-2020 | 20:45 | x64      |
| Dtsmsg130.dll                                | 2015.131.5820.21 | 538512    | 22-May-2020 | 20:45 | x64      |
| Dtspipeline.dll                              | 2015.131.5820.21 | 1272200   | 22-May-2020 | 20:45 | x64      |
| Dtspipelineperf130.dll                       | 2015.131.5820.21 | 41352     | 22-May-2020 | 20:45 | x64      |
| Dtuparse.dll                                 | 2015.131.5820.21 | 80792     | 22-May-2020 | 20:44 | x64      |
| Dtutil.exe                                   | 2015.131.5820.21 | 127896    | 22-May-2020 | 20:43 | x64      |
| Exceldest.dll                                | 2015.131.5820.21 | 256400    | 22-May-2020 | 20:44 | x64      |
| Excelsrc.dll                                 | 2015.131.5820.21 | 278424    | 22-May-2020 | 20:44 | x64      |
| Execpackagetask.dll                          | 2015.131.5820.21 | 159624    | 22-May-2020 | 20:44 | x64      |
| Flatfiledest.dll                             | 2015.131.5820.21 | 382352    | 22-May-2020 | 20:45 | x64      |
| Flatfilesrc.dll                              | 2015.131.5820.21 | 394632    | 22-May-2020 | 20:45 | x64      |
| Foreachfileenumerator.dll                    | 2015.131.5820.21 | 89488     | 22-May-2020 | 20:45 | x64      |
| Hkengperfctrs.dll                            | 2015.131.5820.21 | 52112     | 22-May-2020 | 20:45 | x64      |
| Logread.exe                                  | 2015.131.5820.21 | 619912    | 22-May-2020 | 20:43 | x64      |
| Microsoft.analysisservices.applocal.core.dll | 13.0.5820.21     | 1307016   | 22-May-2020 | 20:46 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll | 13.0.5820.21     | 385424    | 22-May-2020 | 20:46 | x86      |
| Microsoft.sqlserver.replication.dll          | 2015.131.5820.21 | 1644424   | 22-May-2020 | 20:51 | x64      |
| Microsoft.sqlserver.rmo.dll                  | 13.0.5820.21     | 562576    | 22-May-2020 | 20:46 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5820.21 | 143256    | 22-May-2020 | 20:48 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5820.21 | 151960    | 22-May-2020 | 20:48 | x64      |
| Msdtssrvrutil.dll                            | 2015.131.5820.21 | 94616     | 22-May-2020 | 20:44 | x64      |
| Msxmlsql.dll                                 | 2015.131.5820.21 | 1487760   | 22-May-2020 | 20:45 | x64      |
| Oledbdest.dll                                | 2015.131.5820.21 | 257432    | 22-May-2020 | 20:44 | x64      |
| Oledbsrc.dll                                 | 2015.131.5820.21 | 284056    | 22-May-2020 | 20:43 | x64      |
| Osql.exe                                     | 2015.131.5820.21 | 68504     | 22-May-2020 | 20:45 | x64      |
| Rawdest.dll                                  | 2015.131.5820.21 | 202648    | 22-May-2020 | 20:43 | x64      |
| Rawsource.dll                                | 2015.131.5820.21 | 189848    | 22-May-2020 | 20:43 | x64      |
| Rdistcom.dll                                 | 2015.131.5820.21 | 900496    | 22-May-2020 | 20:44 | x64      |
| Recordsetdest.dll                            | 2015.131.5820.21 | 180120    | 22-May-2020 | 20:43 | x64      |
| Repldp.dll                                   | 2015.131.5820.21 | 274840    | 22-May-2020 | 20:44 | x64      |
| Replmerg.exe                                 | 2015.131.5820.21 | 511880    | 22-May-2020 | 20:43 | x64      |
| Replprov.dll                                 | 2015.131.5820.21 | 805264    | 22-May-2020 | 20:44 | x64      |
| Replrec.dll                                  | 2015.131.5820.21 | 1012112   | 22-May-2020 | 20:51 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2015.131.5820.21 | 93584     | 22-May-2020 | 20:44 | x64      |
| Sqlcmd.exe                                   | 2015.131.5820.21 | 242584    | 22-May-2020 | 20:45 | x64      |
| Sqldiag.exe                                  | 2015.131.5820.21 | 1250712   | 22-May-2020 | 20:43 | x64      |
| Sqllogship.exe                               | 13.0.5820.21     | 97688     | 22-May-2020 | 20:44 | x64      |
| Sqlresld.dll                                 | 2015.131.5820.21 | 23960     | 22-May-2020 | 20:38 | x64      |
| Sqlresld.dll                                 | 2015.131.5820.21 | 21912     | 22-May-2020 | 20:43 | x86      |
| Sqlresourceloader.dll                        | 2015.131.5820.21 | 23944     | 22-May-2020 | 20:38 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5820.21 | 21400     | 22-May-2020 | 20:44 | x86      |
| Sqlscm.dll                                   | 2015.131.5820.21 | 45976     | 22-May-2020 | 20:44 | x86      |
| Sqlscm.dll                                   | 2015.131.5820.21 | 54160     | 22-May-2020 | 20:45 | x64      |
| Sqlsvc.dll                                   | 2015.131.5820.21 | 145288    | 22-May-2020 | 20:38 | x64      |
| Sqlsvc.dll                                   | 2015.131.5820.21 | 120200    | 22-May-2020 | 20:43 | x86      |
| Sqltaskconnections.dll                       | 2015.131.5820.21 | 173976    | 22-May-2020 | 20:38 | x64      |
| Sqlwep130.dll                                | 2015.131.5820.21 | 98704     | 22-May-2020 | 20:38 | x64      |
| Ssisoledb.dll                                | 2015.131.5820.21 | 209296    | 22-May-2020 | 20:38 | x64      |
| Tablediff.exe                                | 13.0.5820.21     | 79768     | 22-May-2020 | 20:45 | x64      |
| Txagg.dll                                    | 2015.131.5820.21 | 357776    | 22-May-2020 | 20:39 | x64      |
| Txbdd.dll                                    | 2015.131.5820.21 | 165768    | 22-May-2020 | 20:37 | x64      |
| Txdatacollector.dll                          | 2015.131.5820.21 | 360840    | 22-May-2020 | 20:37 | x64      |
| Txdataconvert.dll                            | 2015.131.5820.21 | 289688    | 22-May-2020 | 20:37 | x64      |
| Txderived.dll                                | 2015.131.5820.21 | 600976    | 22-May-2020 | 20:37 | x64      |
| Txlookup.dll                                 | 2015.131.5820.21 | 525208    | 22-May-2020 | 20:37 | x64      |
| Txmerge.dll                                  | 2015.131.5820.21 | 223640    | 22-May-2020 | 20:36 | x64      |
| Txmergejoin.dll                              | 2015.131.5820.21 | 271760    | 22-May-2020 | 20:36 | x64      |
| Txmulticast.dll                              | 2015.131.5820.21 | 121232    | 22-May-2020 | 20:40 | x64      |
| Txrowcount.dll                               | 2015.131.5820.21 | 119688    | 22-May-2020 | 20:37 | x64      |
| Txsort.dll                                   | 2015.131.5820.21 | 252296    | 22-May-2020 | 20:39 | x64      |
| Txsplit.dll                                  | 2015.131.5820.21 | 593808    | 22-May-2020 | 20:41 | x64      |
| Txunionall.dll                               | 2015.131.5820.21 | 174984    | 22-May-2020 | 20:37 | x64      |
| Xe.dll                                       | 2015.131.5820.21 | 619400    | 22-May-2020 | 20:46 | x64      |
| Xmlrw.dll                                    | 2015.131.5820.21 | 312208    | 22-May-2020 | 20:45 | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version     | File size | Date      | Time  | Platform |
|-------------------------------|------------------|-----------|-----------|-------|----------|
| Launchpad.exe                 | 2015.131.5820.21 | 1008536   | 22-May-2020 | 20:45 | x64      |
| Sql_extensibility_keyfile.dll | 2015.131.5820.21 | 93584     | 22-May-2020 | 20:44 | x64      |
| Sqlsatellite.dll              | 2015.131.5820.21 | 831376    | 22-May-2020 | 20:45 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version     | File size | Date      | Time  | Platform |
|--------------------------|------------------|-----------|-----------|-------|----------|
| Fd.dll                   | 2015.131.5820.21 | 653200    | 22-May-2020 | 20:45 | x64      |
| Fdhost.exe               | 2015.131.5820.21 | 98192     | 22-May-2020 | 20:45 | x64      |
| Fdlauncher.exe           | 2015.131.5820.21 | 44440     | 22-May-2020 | 20:45 | x64      |
| Sql_fulltext_keyfile.dll | 2015.131.5820.21 | 93584     | 22-May-2020 | 20:44 | x64      |
| Sqlft130ph.dll           | 2015.131.5820.21 | 51088     | 22-May-2020 | 20:45 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version     | File size | Date      | Time  | Platform |
|-------------------------|------------------|-----------|-----------|-------|----------|
| Imrdll.dll              | 13.0.5820.21     | 16776     | 22-May-2020 | 20:46 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.131.5820.21 | 93584     | 22-May-2020 | 20:44 | x64      |

SQL Server 2016 Integration Services

| File   name                                        | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll              | 4.0.0.111        | 77944     | 18-May-2020 | 10:12 | x86      |
| Attunity.sqlserver.cdccontroltask.dll              | 4.0.0.111        | 77944     | 20-May-20 | 4:13  | x86      |
| Attunity.sqlserver.cdcsplit.dll                    | 4.0.0.111        | 37496     | 18-May-2020 | 10:12 | x86      |
| Attunity.sqlserver.cdcsplit.dll                    | 4.0.0.111        | 37496     | 20-May-20 | 4:13  | x86      |
| Attunity.sqlserver.cdcsrc.dll                      | 4.0.0.111        | 78456     | 18-May-2020 | 10:12 | x86      |
| Attunity.sqlserver.cdcsrc.dll                      | 4.0.0.111        | 78456     | 20-May-20 | 4:13  | x86      |
| Commanddest.dll                                    | 2015.131.5820.21 | 195992    | 22-May-2020 | 20:43 | x86      |
| Commanddest.dll                                    | 2015.131.5820.21 | 242072    | 22-May-2020 | 20:44 | x64      |
| Dteparse.dll                                       | 2015.131.5820.21 | 92568     | 22-May-2020 | 20:43 | x86      |
| Dteparse.dll                                       | 2015.131.5820.21 | 102792    | 22-May-2020 | 20:45 | x64      |
| Dteparsemgd.dll                                    | 2015.131.5820.21 | 81800     | 22-May-2020 | 20:47 | x64      |
| Dteparsemgd.dll                                    | 2015.131.5820.21 | 76688     | 22-May-2020 | 20:49 | x86      |
| Dtepkg.dll                                         | 2015.131.5820.21 | 108952    | 22-May-2020 | 20:43 | x86      |
| Dtepkg.dll                                         | 2015.131.5820.21 | 130440    | 22-May-2020 | 20:45 | x64      |
| Dtexec.exe                                         | 2015.131.5820.21 | 65944     | 22-May-2020 | 20:43 | x64      |
| Dtexec.exe                                         | 2015.131.5820.21 | 59792     | 22-May-2020 | 20:44 | x86      |
| Dts.dll                                            | 2015.131.5820.21 | 2625944   | 22-May-2020 | 20:43 | x86      |
| Dts.dll                                            | 2015.131.5820.21 | 3139984   | 22-May-2020 | 20:45 | x64      |
| Dtscomexpreval.dll                                 | 2015.131.5820.21 | 412056    | 22-May-2020 | 20:43 | x86      |
| Dtscomexpreval.dll                                 | 2015.131.5820.21 | 470416    | 22-May-2020 | 20:45 | x64      |
| Dtsconn.dll                                        | 2015.131.5820.21 | 385432    | 22-May-2020 | 20:44 | x86      |
| Dtsconn.dll                                        | 2015.131.5820.21 | 485768    | 22-May-2020 | 20:45 | x64      |
| Dtsdebughost.exe                                   | 2015.131.5820.21 | 102792    | 22-May-2020 | 20:43 | x64      |
| Dtsdebughost.exe                                   | 2015.131.5820.21 | 86920     | 22-May-2020 | 20:45 | x86      |
| Dtshost.exe                                        | 2015.131.5820.21 | 79768     | 22-May-2020 | 20:43 | x64      |
| Dtshost.exe                                        | 2015.131.5820.21 | 69520     | 22-May-2020 | 20:44 | x86      |
| Dtslog.dll                                         | 2015.131.5820.21 | 96136     | 22-May-2020 | 20:43 | x86      |
| Dtslog.dll                                         | 2015.131.5820.21 | 113552    | 22-May-2020 | 20:45 | x64      |
| Dtsmsg130.dll                                      | 2015.131.5820.21 | 534424    | 22-May-2020 | 20:43 | x86      |
| Dtsmsg130.dll                                      | 2015.131.5820.21 | 538512    | 22-May-2020 | 20:45 | x64      |
| Dtspipeline.dll                                    | 2015.131.5820.21 | 1052568   | 22-May-2020 | 20:43 | x86      |
| Dtspipeline.dll                                    | 2015.131.5820.21 | 1272200   | 22-May-2020 | 20:45 | x64      |
| Dtspipelineperf130.dll                             | 2015.131.5820.21 | 35224     | 22-May-2020 | 20:43 | x86      |
| Dtspipelineperf130.dll                             | 2015.131.5820.21 | 41352     | 22-May-2020 | 20:45 | x64      |
| Dtuparse.dll                                       | 2015.131.5820.21 | 73112     | 22-May-2020 | 20:44 | x86      |
| Dtuparse.dll                                       | 2015.131.5820.21 | 80792     | 22-May-2020 | 20:44 | x64      |
| Dtutil.exe                                         | 2015.131.5820.21 | 127896    | 22-May-2020 | 20:43 | x64      |
| Dtutil.exe                                         | 2015.131.5820.21 | 108432    | 22-May-2020 | 20:44 | x86      |
| Exceldest.dll                                      | 2015.131.5820.21 | 209800    | 22-May-2020 | 20:43 | x86      |
| Exceldest.dll                                      | 2015.131.5820.21 | 256400    | 22-May-2020 | 20:44 | x64      |
| Excelsrc.dll                                       | 2015.131.5820.21 | 225680    | 22-May-2020 | 20:43 | x86      |
| Excelsrc.dll                                       | 2015.131.5820.21 | 278424    | 22-May-2020 | 20:44 | x64      |
| Execpackagetask.dll                                | 2015.131.5820.21 | 128408    | 22-May-2020 | 20:43 | x86      |
| Execpackagetask.dll                                | 2015.131.5820.21 | 159624    | 22-May-2020 | 20:44 | x64      |
| Flatfiledest.dll                                   | 2015.131.5820.21 | 327576    | 22-May-2020 | 20:43 | x86      |
| Flatfiledest.dll                                   | 2015.131.5820.21 | 382352    | 22-May-2020 | 20:45 | x64      |
| Flatfilesrc.dll                                    | 2015.131.5820.21 | 338328    | 22-May-2020 | 20:43 | x86      |
| Flatfilesrc.dll                                    | 2015.131.5820.21 | 394632    | 22-May-2020 | 20:45 | x64      |
| Foreachfileenumerator.dll                          | 2015.131.5820.21 | 89488     | 22-May-2020 | 20:45 | x64      |
| Foreachfileenumerator.dll                          | 2015.131.5820.21 | 73608     | 22-May-2020 | 20:46 | x86      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5820.21     | 1307016   | 22-May-2020 | 20:46 | x86      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5820.21     | 1307024   | 22-May-2020 | 20:49 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435      | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.sqlserver.astasks.dll                    | 13.0.5820.21     | 66456     | 22-May-2020 | 20:50 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5820.21 | 100232    | 22-May-2020 | 20:46 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5820.21 | 105352    | 22-May-2020 | 20:50 | x64      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5820.21     | 75664     | 22-May-2020 | 9:33  | x86      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5820.21     | 75656     | 22-May-2020 | 20:52 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll       | 13.0.5820.21     | 385424    | 22-May-2020 | 20:46 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5820.21 | 131984    | 22-May-2020 | 20:45 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5820.21 | 143256    | 22-May-2020 | 20:48 | x64      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5820.21 | 137616    | 22-May-2020 | 20:45 | x86      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5820.21 | 151960    | 22-May-2020 | 20:48 | x64      |
| Msdtssrvr.exe                                      | 13.0.5820.21     | 209800    | 22-May-2020 | 20:44 | x64      |
| Msdtssrvrutil.dll                                  | 2015.131.5820.21 | 94616     | 22-May-2020 | 20:44 | x64      |
| Msdtssrvrutil.dll                                  | 2015.131.5820.21 | 83344     | 22-May-2020 | 20:44 | x86      |
| Oledbdest.dll                                      | 2015.131.5820.21 | 257432    | 22-May-2020 | 20:44 | x64      |
| Oledbdest.dll                                      | 2015.131.5820.21 | 209808    | 22-May-2020 | 20:44 | x86      |
| Oledbsrc.dll                                       | 2015.131.5820.21 | 284056    | 22-May-2020 | 20:43 | x64      |
| Oledbsrc.dll                                       | 2015.131.5820.21 | 228744    | 22-May-2020 | 20:44 | x86      |
| Rawdest.dll                                        | 2015.131.5820.21 | 202648    | 22-May-2020 | 20:43 | x64      |
| Rawdest.dll                                        | 2015.131.5820.21 | 161680    | 22-May-2020 | 20:44 | x86      |
| Rawsource.dll                                      | 2015.131.5820.21 | 189848    | 22-May-2020 | 20:43 | x64      |
| Rawsource.dll                                      | 2015.131.5820.21 | 148360    | 22-May-2020 | 20:44 | x86      |
| Recordsetdest.dll                                  | 2015.131.5820.21 | 180120    | 22-May-2020 | 20:43 | x64      |
| Recordsetdest.dll                                  | 2015.131.5820.21 | 144792    | 22-May-2020 | 20:44 | x86      |
| Sql_is_keyfile.dll                                 | 2015.131.5820.21 | 93584     | 22-May-2020 | 20:44 | x64      |
| Sqlceip.exe                                        | 13.0.5820.21     | 249240    | 22-May-2020 | 20:44 | x86      |
| Sqldest.dll                                        | 2015.131.5820.21 | 208776    | 22-May-2020 | 20:43 | x86      |
| Sqldest.dll                                        | 2015.131.5820.21 | 256920    | 22-May-2020 | 20:44 | x64      |
| Sqltaskconnections.dll                             | 2015.131.5820.21 | 173976    | 22-May-2020 | 20:38 | x64      |
| Sqltaskconnections.dll                             | 2015.131.5820.21 | 144280    | 22-May-2020 | 20:43 | x86      |
| Ssisoledb.dll                                      | 2015.131.5820.21 | 209296    | 22-May-2020 | 20:38 | x64      |
| Ssisoledb.dll                                      | 2015.131.5820.21 | 169880    | 22-May-2020 | 20:43 | x86      |
| Txagg.dll                                          | 2015.131.5820.21 | 357776    | 22-May-2020 | 20:39 | x64      |
| Txagg.dll                                          | 2015.131.5820.21 | 297872    | 22-May-2020 | 20:50 | x86      |
| Txbdd.dll                                          | 2015.131.5820.21 | 165768    | 22-May-2020 | 20:37 | x64      |
| Txbdd.dll                                          | 2015.131.5820.21 | 130960    | 22-May-2020 | 20:49 | x86      |
| Txbestmatch.dll                                    | 2015.131.5820.21 | 604552    | 22-May-2020 | 20:39 | x64      |
| Txbestmatch.dll                                    | 2015.131.5820.21 | 489360    | 22-May-2020 | 20:51 | x86      |
| Txcache.dll                                        | 2015.131.5820.21 | 176528    | 22-May-2020 | 20:37 | x64      |
| Txcache.dll                                        | 2015.131.5820.21 | 141208    | 22-May-2020 | 20:49 | x86      |
| Txcharmap.dll                                      | 2015.131.5820.21 | 283032    | 22-May-2020 | 20:37 | x64      |
| Txcharmap.dll                                      | 2015.131.5820.21 | 243600    | 22-May-2020 | 20:49 | x86      |
| Txcopymap.dll                                      | 2015.131.5820.21 | 176016    | 22-May-2020 | 20:40 | x64      |
| Txcopymap.dll                                      | 2015.131.5820.21 | 140680    | 22-May-2020 | 20:49 | x86      |
| Txdataconvert.dll                                  | 2015.131.5820.21 | 289688    | 22-May-2020 | 20:37 | x64      |
| Txdataconvert.dll                                  | 2015.131.5820.21 | 248216    | 22-May-2020 | 20:49 | x86      |
| Txderived.dll                                      | 2015.131.5820.21 | 600976    | 22-May-2020 | 20:37 | x64      |
| Txderived.dll                                      | 2015.131.5820.21 | 512400    | 22-May-2020 | 20:50 | x86      |
| Txfileextractor.dll                                | 2015.131.5820.21 | 194960    | 22-May-2020 | 20:36 | x64      |
| Txfileextractor.dll                                | 2015.131.5820.21 | 156056    | 22-May-2020 | 20:50 | x86      |
| Txfileinserter.dll                                 | 2015.131.5820.21 | 192912    | 22-May-2020 | 20:37 | x64      |
| Txfileinserter.dll                                 | 2015.131.5820.21 | 154008    | 22-May-2020 | 20:49 | x86      |
| Txgroupdups.dll                                    | 2015.131.5820.21 | 284040    | 22-May-2020 | 20:37 | x64      |
| Txgroupdups.dll                                    | 2015.131.5820.21 | 224656    | 22-May-2020 | 20:49 | x86      |
| Txlineage.dll                                      | 2015.131.5820.21 | 130952    | 22-May-2020 | 20:36 | x64      |
| Txlineage.dll                                      | 2015.131.5820.21 | 102808    | 22-May-2020 | 20:49 | x86      |
| Txlookup.dll                                       | 2015.131.5820.21 | 525208    | 22-May-2020 | 20:37 | x64      |
| Txlookup.dll                                       | 2015.131.5820.21 | 442776    | 22-May-2020 | 20:50 | x86      |
| Txmerge.dll                                        | 2015.131.5820.21 | 223640    | 22-May-2020 | 20:36 | x64      |
| Txmerge.dll                                        | 2015.131.5820.21 | 169864    | 22-May-2020 | 20:49 | x86      |
| Txmergejoin.dll                                    | 2015.131.5820.21 | 271760    | 22-May-2020 | 20:36 | x64      |
| Txmergejoin.dll                                    | 2015.131.5820.21 | 216984    | 22-May-2020 | 20:49 | x86      |
| Txmulticast.dll                                    | 2015.131.5820.21 | 121232    | 22-May-2020 | 20:40 | x64      |
| Txmulticast.dll                                    | 2015.131.5820.21 | 95128     | 22-May-2020 | 20:50 | x86      |
| Txpivot.dll                                        | 2015.131.5820.21 | 221072    | 22-May-2020 | 20:41 | x64      |
| Txpivot.dll                                        | 2015.131.5820.21 | 175000    | 22-May-2020 | 20:49 | x86      |
| Txrowcount.dll                                     | 2015.131.5820.21 | 119688    | 22-May-2020 | 20:37 | x64      |
| Txrowcount.dll                                     | 2015.131.5820.21 | 94616     | 22-May-2020 | 20:49 | x86      |
| Txsampling.dll                                     | 2015.131.5820.21 | 165256    | 22-May-2020 | 20:36 | x64      |
| Txsampling.dll                                     | 2015.131.5820.21 | 127880    | 22-May-2020 | 20:49 | x86      |
| Txscd.dll                                          | 2015.131.5820.21 | 213392    | 22-May-2020 | 20:38 | x64      |
| Txscd.dll                                          | 2015.131.5820.21 | 162712    | 22-May-2020 | 20:49 | x86      |
| Txsort.dll                                         | 2015.131.5820.21 | 252296    | 22-May-2020 | 20:39 | x64      |
| Txsort.dll                                         | 2015.131.5820.21 | 204168    | 22-May-2020 | 20:49 | x86      |
| Txsplit.dll                                        | 2015.131.5820.21 | 593808    | 22-May-2020 | 20:41 | x64      |
| Txsplit.dll                                        | 2015.131.5820.21 | 506264    | 22-May-2020 | 20:49 | x86      |
| Txtermextraction.dll                               | 2015.131.5820.21 | 8671112   | 22-May-2020 | 20:40 | x64      |
| Txtermextraction.dll                               | 2015.131.5820.21 | 8608648   | 22-May-2020 | 20:49 | x86      |
| Txtermlookup.dll                                   | 2015.131.5820.21 | 4151688   | 22-May-2020 | 20:37 | x64      |
| Txtermlookup.dll                                   | 2015.131.5820.21 | 4099976   | 22-May-2020 | 20:49 | x86      |
| Txunionall.dll                                     | 2015.131.5820.21 | 174984    | 22-May-2020 | 20:37 | x64      |
| Txunionall.dll                                     | 2015.131.5820.21 | 131984    | 22-May-2020 | 20:49 | x86      |
| Txunpivot.dll                                      | 2015.131.5820.21 | 194952    | 22-May-2020 | 20:38 | x64      |
| Txunpivot.dll                                      | 2015.131.5820.21 | 155528    | 22-May-2020 | 20:49 | x86      |
| Xe.dll                                             | 2015.131.5820.21 | 619400    | 22-May-2020 | 20:46 | x64      |
| Xe.dll                                             | 2015.131.5820.21 | 551832    | 22-May-2020 | 20:49 | x86      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Dms.dll                                                              | 10.0.8224.49     | 483624    | 09-May-2019  | 19:33 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.49 | 75560     | 09-May-2019  | 19:33 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.49     | 45864     | 09-May-2019  | 19:33 | x86      |
| Instapi130.dll                                                       | 2015.131.5820.21 | 54152     | 22-May-2020 | 20:35 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 10.0.8224.49     | 74536     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 10.0.8224.49     | 202024    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 10.0.8224.49     | 2347304   | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 10.0.8224.49     | 102184    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 10.0.8224.49     | 378664    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 10.0.8224.49     | 185640    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 10.0.8224.49     | 127272    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 10.0.8224.49     | 63272     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 10.0.8224.49     | 52520     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 10.0.8224.49     | 87336     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 10.0.8224.49     | 721704    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 10.0.8224.49     | 87336     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 10.0.8224.49     | 78120     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 10.0.8224.49     | 41768     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 10.0.8224.49     | 36648     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 10.0.8224.49     | 47912     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 10.0.8224.49     | 27432     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 10.0.8224.49     | 33064     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 10.0.8224.49     | 119080    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 10.0.8224.49     | 94504     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 10.0.8224.49     | 108328    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 10.0.8224.49     | 256808    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 102184    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 116008    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 119080    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 116008    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 125736    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 118056    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 113448    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 145704    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 100136    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 114984    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 10.0.8224.49     | 69416     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 10.0.8224.49     | 28456     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 10.0.8224.49     | 43816     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 10.0.8224.49     | 82216     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 10.0.8224.49     | 137000    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 10.0.8224.49     | 2155816   | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 10.0.8224.49     | 3818792   | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 107816    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 120104    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 124712    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 121128    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 133408    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 121128    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 118568    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 152360    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 105280    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 119592    | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 10.0.8224.49     | 66856     | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 10.0.8224.49     | 2756392   | 09-May-2019  | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 10.0.8224.49     | 752424    | 09-May-2019  | 19:33 | x86      |
| Mpdwinterop.dll                                                      | 2015.131.5820.21 | 387992    | 22-May-2020 | 20:50 | x64      |
| Mpdwsvc.exe                                                          | 2015.131.5820.21 | 6612360   | 22-May-2020 | 20:51 | x64      |
| Pdwodbcsql11.dll                                                     | 2015.131.5820.21 | 2223496   | 22-May-2020 | 20:36 | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.49 | 47400     | 09-May-2019  | 19:33 | x64      |
| Sqldk.dll                                                            | 2015.131.5820.21 | 2532744   | 22-May-2020 | 20:38 | x64      |
| Sqldumper.exe                                                        | 2015.131.5820.21 | 123272    | 22-May-2020 | 20:50 | x64      |
| Sqlos.dll                                                            | 2015.131.5820.21 | 19336     | 22-May-2020 | 20:35 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.49 | 4348200   | 09-May-2019  | 19:33 | x64      |
| Sqltses.dll                                                          | 2015.131.5820.21 | 9085832   | 22-May-2020 | 20:38 | x64      |

SQL Server 2016 Reporting Services

| File   name                                               | File version     | File size | Date      | Time  | Platform |
|-----------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.modeling.dll                   | 13.0.5820.21     | 604040    | 22-May-2020 | 20:46 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.5820.21     | 1613200   | 22-May-2020 | 20:45 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.5820.21     | 651664    | 22-May-2020 | 20:45 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.5820.21     | 322952    | 22-May-2020 | 20:45 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.5820.21     | 1083784   | 22-May-2020 | 20:45 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5820.21     | 541576    | 22-May-2020 | 20:49 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5820.21     | 541576    | 22-May-2020 | 20:48 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5820.21     | 541576    | 22-May-2020 | 20:45 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5820.21     | 541576    | 22-May-2020 | 20:51 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5820.21     | 541592    | 22-May-2020 | 20:49 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5820.21     | 541584    | 22-May-2020 | 20:44 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5820.21     | 541592    | 22-May-2020 | 20:47 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5820.21     | 541592    | 22-May-2020 | 20:51 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5820.21     | 541576    | 22-May-2020 | 20:51 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5820.21     | 541592    | 22-May-2020 | 20:49 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.5820.21     | 156040    | 22-May-2020 | 20:45 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.5820.21     | 119176    | 22-May-2020 | 20:51 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.5820.21     | 6069648   | 22-May-2020 | 20:51 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5820.21     | 4504472   | 22-May-2020 | 20:50 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5820.21     | 4504984   | 22-May-2020 | 20:49 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5820.21     | 4504984   | 22-May-2020 | 20:45 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5820.21     | 4504968   | 22-May-2020 | 20:51 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5820.21     | 4505496   | 22-May-2020 | 20:49 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5820.21     | 4505496   | 22-May-2020 | 20:46 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5820.21     | 4504984   | 22-May-2020 | 20:48 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5820.21     | 4506000   | 22-May-2020 | 20:50 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5820.21     | 4504456   | 22-May-2020 | 20:51 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5820.21     | 4504976   | 22-May-2020 | 20:50 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.5820.21     | 10920848  | 22-May-2020 | 20:51 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.5820.21     | 96144     | 22-May-2020 | 20:44 | x64      |
| Microsoft.reportingservices.storage.dll                   | 13.0.5820.21     | 201608    | 22-May-2020 | 20:50 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.131.5820.21 | 40840     | 22-May-2020 | 20:50 | x64      |
| Microsoft.sqlserver.types.dll                             | 2015.131.5820.21 | 385944    | 22-May-2020 | 20:48 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.131.5820.21 | 390040    | 22-May-2020 | 20:51 | x86      |
| Msmdlocal.dll                                             | 2015.131.5820.21 | 37128080  | 22-May-2020 | 20:44 | x86      |
| Msmdlocal.dll                                             | 2015.131.5820.21 | 56246672  | 22-May-2020 | 20:45 | x64      |
| Msmgdsrv.dll                                              | 2015.131.5820.21 | 7502736   | 22-May-2020 | 20:51 | x64      |
| Msmgdsrv.dll                                              | 2015.131.5820.21 | 6502280   | 22-May-2020 | 20:51 | x86      |
| Msolap130.dll                                             | 2015.131.5820.21 | 7004056   | 22-May-2020 | 20:45 | x86      |
| Msolap130.dll                                             | 2015.131.5820.21 | 8636304   | 22-May-2020 | 20:45 | x64      |
| Msolui130.dll                                             | 2015.131.5820.21 | 303512    | 22-May-2020 | 20:43 | x64      |
| Msolui130.dll                                             | 2015.131.5820.21 | 280464    | 22-May-2020 | 20:44 | x86      |
| Reportingservicescompression.dll                          | 2015.131.5820.21 | 55704     | 22-May-2020 | 20:43 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.5820.21     | 77712     | 22-May-2020 | 20:49 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.5820.21     | 2536856   | 22-May-2020 | 20:51 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.131.5820.21 | 107400    | 22-May-2020 | 20:50 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.131.5820.21 | 101776    | 22-May-2020 | 20:51 | x64      |
| Reportingservicesnativeserver.dll                         | 2015.131.5820.21 | 92056     | 22-May-2020 | 20:49 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.5820.21     | 2722192   | 22-May-2020 | 20:51 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5820.21     | 877456    | 22-May-2020 | 20:50 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5820.21     | 881552    | 22-May-2020 | 20:46 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5820.21     | 881560    | 22-May-2020 | 20:49 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5820.21     | 881544    | 22-May-2020 | 20:47 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5820.21     | 885648    | 22-May-2020 | 20:47 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5820.21     | 881552    | 22-May-2020 | 20:51 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5820.21     | 881552    | 22-May-2020 | 20:49 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5820.21     | 893840    | 22-May-2020 | 20:46 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5820.21     | 877456    | 22-May-2020 | 20:51 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5820.21     | 881560    | 22-May-2020 | 20:49 | x86      |
| Rshttpruntime.dll                                         | 2015.131.5820.21 | 92568     | 22-May-2020 | 20:50 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.131.5820.21 | 93584     | 22-May-2020 | 20:44 | x64      |
| Sqldumper.exe                                             | 2015.131.5820.21 | 103832    | 22-May-2020 | 20:43 | x86      |
| Sqldumper.exe                                             | 2015.131.5820.21 | 123272    | 22-May-2020 | 20:45 | x64      |
| Sqlrsos.dll                                               | 2015.131.5820.21 | 19336     | 22-May-2020 | 20:38 | x64      |
| Sqlserverspatial130.dll                                   | 2015.131.5820.21 | 577432    | 22-May-2020 | 20:43 | x86      |
| Sqlserverspatial130.dll                                   | 2015.131.5820.21 | 725896    | 22-May-2020 | 20:45 | x64      |
| Xmlrw.dll                                                 | 2015.131.5820.21 | 312208    | 22-May-2020 | 20:45 | x64      |
| Xmlrw.dll                                                 | 2015.131.5820.21 | 252816    | 22-May-2020 | 20:49 | x86      |
| Xmlrwbin.dll                                              | 2015.131.5820.21 | 220560    | 22-May-2020 | 20:45 | x64      |
| Xmlrwbin.dll                                              | 2015.131.5820.21 | 184712    | 22-May-2020 | 20:49 | x86      |
| Xmsrv.dll                                                 | 2015.131.5820.21 | 24040840  | 22-May-2020 | 20:40 | x64      |
| Xmsrv.dll                                                 | 2015.131.5820.21 | 32721304  | 22-May-2020 | 20:49 | x86      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version     | File size | Date      | Time  | Platform |
|------------------------------------|------------------|-----------|-----------|-------|----------|
| Smrdll.dll                         | 13.0.5820.21     | 16784     | 22-May-2020 | 20:49 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.131.5820.21 | 93584     | 22-May-2020 | 20:44 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                    | File version     | File size | Date      | Time  | Platform |
|------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Autoadmin.dll                                  | 2015.131.5820.21 | 1304984   | 22-May-2020 | 20:43 | x86      |
| Ddsshapes.dll                                  | 2015.131.5820.21 | 128912    | 22-May-2020 | 20:43 | x86      |
| Dtaengine.exe                                  | 2015.131.5820.21 | 160136    | 22-May-2020 | 20:44 | x86      |
| Dteparse.dll                                   | 2015.131.5820.21 | 92568     | 22-May-2020 | 20:43 | x86      |
| Dteparse.dll                                   | 2015.131.5820.21 | 102792    | 22-May-2020 | 20:45 | x64      |
| Dteparsemgd.dll                                | 2015.131.5820.21 | 81800     | 22-May-2020 | 20:47 | x64      |
| Dteparsemgd.dll                                | 2015.131.5820.21 | 76688     | 22-May-2020 | 20:49 | x86      |
| Dtepkg.dll                                     | 2015.131.5820.21 | 108952    | 22-May-2020 | 20:43 | x86      |
| Dtepkg.dll                                     | 2015.131.5820.21 | 130440    | 22-May-2020 | 20:45 | x64      |
| Dtexec.exe                                     | 2015.131.5820.21 | 65944     | 22-May-2020 | 20:43 | x64      |
| Dtexec.exe                                     | 2015.131.5820.21 | 59792     | 22-May-2020 | 20:44 | x86      |
| Dts.dll                                        | 2015.131.5820.21 | 2625944   | 22-May-2020 | 20:43 | x86      |
| Dts.dll                                        | 2015.131.5820.21 | 3139984   | 22-May-2020 | 20:45 | x64      |
| Dtscomexpreval.dll                             | 2015.131.5820.21 | 412056    | 22-May-2020 | 20:43 | x86      |
| Dtscomexpreval.dll                             | 2015.131.5820.21 | 470416    | 22-May-2020 | 20:45 | x64      |
| Dtsconn.dll                                    | 2015.131.5820.21 | 385432    | 22-May-2020 | 20:44 | x86      |
| Dtsconn.dll                                    | 2015.131.5820.21 | 485768    | 22-May-2020 | 20:45 | x64      |
| Dtshost.exe                                    | 2015.131.5820.21 | 79768     | 22-May-2020 | 20:43 | x64      |
| Dtshost.exe                                    | 2015.131.5820.21 | 69520     | 22-May-2020 | 20:44 | x86      |
| Dtslog.dll                                     | 2015.131.5820.21 | 96136     | 22-May-2020 | 20:43 | x86      |
| Dtslog.dll                                     | 2015.131.5820.21 | 113552    | 22-May-2020 | 20:45 | x64      |
| Dtsmsg130.dll                                  | 2015.131.5820.21 | 534424    | 22-May-2020 | 20:43 | x86      |
| Dtsmsg130.dll                                  | 2015.131.5820.21 | 538512    | 22-May-2020 | 20:45 | x64      |
| Dtspipeline.dll                                | 2015.131.5820.21 | 1052568   | 22-May-2020 | 20:43 | x86      |
| Dtspipeline.dll                                | 2015.131.5820.21 | 1272200   | 22-May-2020 | 20:45 | x64      |
| Dtspipelineperf130.dll                         | 2015.131.5820.21 | 35224     | 22-May-2020 | 20:43 | x86      |
| Dtspipelineperf130.dll                         | 2015.131.5820.21 | 41352     | 22-May-2020 | 20:45 | x64      |
| Dtuparse.dll                                   | 2015.131.5820.21 | 73112     | 22-May-2020 | 20:44 | x86      |
| Dtuparse.dll                                   | 2015.131.5820.21 | 80792     | 22-May-2020 | 20:44 | x64      |
| Dtutil.exe                                     | 2015.131.5820.21 | 127896    | 22-May-2020 | 20:43 | x64      |
| Dtutil.exe                                     | 2015.131.5820.21 | 108432    | 22-May-2020 | 20:44 | x86      |
| Exceldest.dll                                  | 2015.131.5820.21 | 209800    | 22-May-2020 | 20:43 | x86      |
| Exceldest.dll                                  | 2015.131.5820.21 | 256400    | 22-May-2020 | 20:44 | x64      |
| Excelsrc.dll                                   | 2015.131.5820.21 | 225680    | 22-May-2020 | 20:43 | x86      |
| Excelsrc.dll                                   | 2015.131.5820.21 | 278424    | 22-May-2020 | 20:44 | x64      |
| Flatfiledest.dll                               | 2015.131.5820.21 | 327576    | 22-May-2020 | 20:43 | x86      |
| Flatfiledest.dll                               | 2015.131.5820.21 | 382352    | 22-May-2020 | 20:45 | x64      |
| Flatfilesrc.dll                                | 2015.131.5820.21 | 338328    | 22-May-2020 | 20:43 | x86      |
| Flatfilesrc.dll                                | 2015.131.5820.21 | 394632    | 22-May-2020 | 20:45 | x64      |
| Foreachfileenumerator.dll                      | 2015.131.5820.21 | 89488     | 22-May-2020 | 20:45 | x64      |
| Foreachfileenumerator.dll                      | 2015.131.5820.21 | 73608     | 22-May-2020 | 20:46 | x86      |
| Microsoft.analysisservices.adomdclientui.dll   | 13.0.5820.21     | 85392     | 22-May-2020 | 20:49 | x86      |
| Microsoft.analysisservices.applocal.core.dll   | 13.0.5820.21     | 1307024   | 22-May-2020 | 20:49 | x86      |
| Microsoft.analysisservices.project.dll         | 2015.131.5820.21 | 2016136   | 22-May-2020 | 20:47 | x86      |
| Microsoft.analysisservices.projectui.dll       | 2015.131.5820.21 | 35216     | 22-May-2020 | 20:46 | x86      |
| Microsoft.sqlserver.astasks.dll                | 13.0.5820.21     | 66456     | 22-May-2020 | 20:44 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5820.21     | 428936    | 22-May-2020 | 20:45 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5820.21     | 428952    | 22-May-2020 | 20:50 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5820.21     | 2037640   | 22-May-2020 | 20:45 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5820.21     | 2037648   | 22-May-2020 | 20:50 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5820.21 | 131984    | 22-May-2020 | 20:45 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5820.21 | 143256    | 22-May-2020 | 20:48 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5820.21 | 137616    | 22-May-2020 | 20:45 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5820.21 | 151960    | 22-May-2020 | 20:48 | x64      |
| Msdtssrvrutil.dll                              | 2015.131.5820.21 | 94616     | 22-May-2020 | 20:44 | x64      |
| Msdtssrvrutil.dll                              | 2015.131.5820.21 | 83344     | 22-May-2020 | 20:44 | x86      |
| Msmdlocal.dll                                  | 2015.131.5820.21 | 37128080  | 22-May-2020 | 20:44 | x86      |
| Msmdlocal.dll                                  | 2015.131.5820.21 | 56246672  | 22-May-2020 | 20:45 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5820.21 | 7502736   | 22-May-2020 | 20:51 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5820.21 | 6502280   | 22-May-2020 | 20:51 | x86      |
| Msolap130.dll                                  | 2015.131.5820.21 | 7004056   | 22-May-2020 | 20:45 | x86      |
| Msolap130.dll                                  | 2015.131.5820.21 | 8636304   | 22-May-2020 | 20:45 | x64      |
| Msolui130.dll                                  | 2015.131.5820.21 | 303512    | 22-May-2020 | 20:43 | x64      |
| Msolui130.dll                                  | 2015.131.5820.21 | 280464    | 22-May-2020 | 20:44 | x86      |
| Oledbdest.dll                                  | 2015.131.5820.21 | 257432    | 22-May-2020 | 20:44 | x64      |
| Oledbdest.dll                                  | 2015.131.5820.21 | 209808    | 22-May-2020 | 20:44 | x86      |
| Oledbsrc.dll                                   | 2015.131.5820.21 | 284056    | 22-May-2020 | 20:43 | x64      |
| Oledbsrc.dll                                   | 2015.131.5820.21 | 228744    | 22-May-2020 | 20:44 | x86      |
| Profiler.exe                                   | 2015.131.5820.21 | 797576    | 22-May-2020 | 20:49 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.131.5820.21 | 93584     | 22-May-2020 | 20:44 | x64      |
| Sqldumper.exe                                  | 2015.131.5820.21 | 103832    | 22-May-2020 | 20:43 | x86      |
| Sqldumper.exe                                  | 2015.131.5820.21 | 123272    | 22-May-2020 | 20:45 | x64      |
| Sqlresld.dll                                   | 2015.131.5820.21 | 23960     | 22-May-2020 | 20:38 | x64      |
| Sqlresld.dll                                   | 2015.131.5820.21 | 21912     | 22-May-2020 | 20:43 | x86      |
| Sqlresourceloader.dll                          | 2015.131.5820.21 | 23944     | 22-May-2020 | 20:38 | x64      |
| Sqlresourceloader.dll                          | 2015.131.5820.21 | 21400     | 22-May-2020 | 20:44 | x86      |
| Sqlscm.dll                                     | 2015.131.5820.21 | 45976     | 22-May-2020 | 20:44 | x86      |
| Sqlscm.dll                                     | 2015.131.5820.21 | 54160     | 22-May-2020 | 20:45 | x64      |
| Sqlsvc.dll                                     | 2015.131.5820.21 | 145288    | 22-May-2020 | 20:38 | x64      |
| Sqlsvc.dll                                     | 2015.131.5820.21 | 120200    | 22-May-2020 | 20:43 | x86      |
| Sqltaskconnections.dll                         | 2015.131.5820.21 | 173976    | 22-May-2020 | 20:38 | x64      |
| Sqltaskconnections.dll                         | 2015.131.5820.21 | 144280    | 22-May-2020 | 20:43 | x86      |
| Txdataconvert.dll                              | 2015.131.5820.21 | 289688    | 22-May-2020 | 20:37 | x64      |
| Txdataconvert.dll                              | 2015.131.5820.21 | 248216    | 22-May-2020 | 20:49 | x86      |
| Xe.dll                                         | 2015.131.5820.21 | 619400    | 22-May-2020 | 20:46 | x64      |
| Xe.dll                                         | 2015.131.5820.21 | 551832    | 22-May-2020 | 20:49 | x86      |
| Xmlrw.dll                                      | 2015.131.5820.21 | 312208    | 22-May-2020 | 20:45 | x64      |
| Xmlrw.dll                                      | 2015.131.5820.21 | 252816    | 22-May-2020 | 20:49 | x86      |
| Xmlrwbin.dll                                   | 2015.131.5820.21 | 220560    | 22-May-2020 | 20:45 | x64      |
| Xmlrwbin.dll                                   | 2015.131.5820.21 | 184712    | 22-May-2020 | 20:49 | x86      |
| Xmsrv.dll                                      | 2015.131.5820.21 | 24040840  | 22-May-2020 | 20:40 | x64      |
| Xmsrv.dll                                      | 2015.131.5820.21 | 32721304  | 22-May-2020 | 20:49 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
