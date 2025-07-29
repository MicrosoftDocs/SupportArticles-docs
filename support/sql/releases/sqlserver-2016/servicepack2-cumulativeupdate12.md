---
title: Cumulative update 12 for SQL Server 2016 SP2 (KB4536648)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP2 cumulative update 12 (KB4536648).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4536648
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Web
---

# KB4536648 - Cumulative Update 12 for SQL Server 2016 SP2

_Release Date:_ &nbsp; February 24, 2020  
_Version:_ &nbsp; 13.0.5698.0

This article describes Cumulative Update package 12 (CU12) (build number: **13.0.5698.0**) for Microsoft SQL Server 2016 Service Pack 2 (SP2). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the initial release of SQL Server 2016 SP2.

## Known issues in this update

Under certain circumstances, there is a known uninstall issue with this SQL Server 2016 SP2 CU12.  If you uninstall this CU, SQL Server doesn't come online and you find the following SQL Server error log message:

> The script level for 'system_xevents_modification.sql' in database 'master' cannot be downgraded from XXXXXXXXX to XXXXXXXXX, which is supported by this server. This usually implies that a future database was attached and the downgrade path is not supported by the current installation. Install a newer version of SQL Server and re-try opening the database.

Mitigation is to enable Trace Flag - T902, then SQL Server will come online and you are done. You don't need to uninstall it again. To upgrade to new CU you need to remove this flag first.

SQL Server 2016 SP2 CU13 or any later CU release contains the fix.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area| Platform |
|---------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|----------|
| <a id=13275018>[13275018](#13275018) </a> | [Improvement: Merge operation will consider the number of deleted rows in the rowgroup in SQL Server 2016 and 2017 (KB4480651)](https://support.microsoft.com/help/4480651) | SQL Engine| All|
| <a id=13326775>[13326775](#13326775) </a> | [FIX: User hierarchy is not hidden when you run DISCOVER_CSDL_METADATA in SQL Server (KB4527510)](https://support.microsoft.com/help/4527510) | Analysis Services | Windows|
| <a id=13358372>[13358372](#13358372) </a> | [FIX: Access violation occurs when you run DBCC CHECKTABLE against a table with Clustered Columnstore Index in SQL Server (KB4537350)](https://support.microsoft.com/help/4537350)| SQL Engine| Windows|
| <a id=13335640>[13335640](#13335640) </a> | [FIX: The "is_media_read_only" value remains unchanged for a SQL Server data file even though the media is no longer read-only (KB4538378)](https://support.microsoft.com/help/4538378) | SQL Engine| Windows|
| <a id=13331373>[13331373](#13331373) </a> | [FIX: Access violation occurs when change tracking auto cleanup tries to clean up side tables in SQL Server 2016 (KB4539815)](https://support.microsoft.com/help/4539815) | SQL Engine| Windows|
| <a id=13294054>[13294054](#13294054) </a> | [FIX: Access violation occurs with wait_info XEvent on busy SQL Server 2016 (KB4539880)](https://support.microsoft.com/help/4539880)| SQL performance | Windows|
| <a id=13298018>[13298018](#13298018) </a> | [FIX: Error occurs when you run a stored procedure from database A which pulls data from database B in SQL Server 2016 (KB4539892)](https://support.microsoft.com/help/4539892) | SQL performance | Windows|
| <a id=13361172>[13361172](#13361172) </a> | [FIX: Access violation may occur when you run XML query against a table that has a primary XML index in SQL Server 2016 (KB4539897)](https://support.microsoft.com/help/4539897)| SQL performance | Windows|
| <a id=13184475>[13184475](#13184475) </a> | [FIX: Assertion occurs when you run DATABASE SCOPED command in SQL Server 2016 (KB4539947)](https://support.microsoft.com/help/4539947) | SQL Engine| Windows|
| <a id=13329385>[13329385](#13329385) </a> | [FIX: System or background task may fail when number of sessions reaches the maximum limit in SQL Server 2016 (KB4540107)](https://support.microsoft.com/help/4540107)| SQL Engine| Windows|
| <a id=13381812>[13381812](#13381812) </a> | [FIX: Non-yielding scheduler condition occurs with CONNECTION_MANAGER spinlock in SQL Server 2016 (KB4540342)](https://support.microsoft.com/help/4540342)| SQL Engine| Windows|
| <a id=13372511>[13372511](#13372511) </a> | [FIX: MERGE statement fails with assert "Attempt to access expired blob handle (1)" in SQL Server 2016 (KB4540346)](https://support.microsoft.com/help/4540346) | SQL performance | Windows|
| <a id=13367056>[13367056](#13367056) </a> | [FIX: DAX query causes server to have exceptions in TBB heap and crash in Windows heap in SQL Server 2016 (KB4540385)](https://support.microsoft.com/help/4540385)| Analysis Services | Windows|
| <a id=13372802>[13372802](#13372802) </a> | [FIX: Error occurs in sp_xml_preparedocument where MSXMLSQL tries to access virtual address space beyond limit in SQL Server 2016, 2017 and 2019 (KB4540449)](https://support.microsoft.com/help/4540449) | XML | All|
| <a id=13346757>[13346757](#13346757) </a> | [FIX: Unexpected exception error occurs when you run DISCOVER_CSDL_METADATA in Power BI Desktop in SQL Server 2016 (KB4540731)](https://support.microsoft.com/help/4540731) | Analysis Services | Windows|
| <a id=13333249>[13333249](#13333249) </a> | [FIX: Access violation may occur when enumerating files in a FileTable in SQL Server (KB4540896)](https://support.microsoft.com/help/4540896) | SQL Engine| Windows|
| <a id=13375360>[13375360](#13375360) </a> | [FIX: SQL Server may terminate due to lock conflicts during error message processing in SQL Server 2016 (KB4540901)](https://support.microsoft.com/help/4540901)| SQL security| Windows|
| <a id=13368730>[13368730](#13368730) </a> | [FIX: Non-yielding scheduler dump occurs in InterlockedCompareExchangePointer and SOS_RWLock in SQL Server 2016 (KB4540903)](https://support.microsoft.com/help/4540903)| SQL Engine| Windows|
| <a id=13249030>[13249030](#13249030) </a> | [FIX: Access Violation occurs when you run query on computed columns in SQL Server 2016 (KB4541096)](https://support.microsoft.com/help/4541096)| SQL performance | All|
| <a id=13358502>[13358502](#13358502) </a> | [Improvement: Size and retention policy are increased in default XEvent trace system_health in SQL Server 2016 (KB4541132)](https://support.microsoft.com/help/4541132) | Analysis Services | Windows|
| <a id=13293964>[13293964](#13293964) </a> | [FIX: Non-yielding scheduler dumps occur when running a batch mode query with multiple joins in SQL Server 2016 (KB4541288)](https://support.microsoft.com/help/4541288)| SQL Engine| Windows|
| <a id=13323647>[13323647](#13323647) </a> | [FIX: Fix incorrect values in auto seeding XEvents in SQL Server 2016 (KB4541300)](https://support.microsoft.com/help/4541300)| High Availability | Windows|
| <a id=13245644>[13245644](#13245644) </a> | [FIX: Non-yielding Scheduler error may occur with Always On availability group in Microsoft SQL Server 2016 (KB4541303)](https://support.microsoft.com/help/4541303)| High Availability | Windows|
| <a id=13215330>[13215330](#13215330) </a> | [FIX: Missing log block may occur when you use Always On availability group in SQL Server 2016 (KB4541309)](https://support.microsoft.com/help/4541309) | High Availability | Windows|
| <a id=13331676>[13331676](#13331676) </a> | [FIX: Database initialization may fail by using automatic seeding in SQL Server 2016 (KB4541385)](https://support.microsoft.com/help/4541385) | High Availability | Windows|
| <a id=13308278>[13308278](#13308278) </a> | [FIX: Error occurs when you rename a column on temporal current table in SQL Server 2016 (KB4541435)](https://support.microsoft.com/help/4541435) | SQL Engine| Windows|
| <a id=13273913>[13273913](#13273913) </a> | [FIX: Assertion occurs when you process a malformed XML message sent as message in Service Broker queue in SQL Server 2016 (KB4541520)](https://support.microsoft.com/help/4541520) | SQL Engine| Windows|
| <a id=13285484>[13285484](#13285484) </a> | [FIX: Intermittent non-yielding scheduler event causes outage of Availability Groups in SQL Server 2016 (KB4541724)](https://support.microsoft.com/help/4541724)| In-Memory OLTP| Windows|
| <a id=13368461>[13368461](#13368461) </a> | [FIX: Management Data Warehouse Server Activity Collection Set may fail in SQL Server 2016 (KB4541762)](https://support.microsoft.com/help/4541762) | Management Tools| Windows|
| <a id=13184966>[13184966](#13184966) </a> | [FIX: Error occurs when running sp_updatestats on the table that has a clustered columnstore index and memory optimized index (KB4541769)](https://support.microsoft.com/help/4541769)| SQL Engine| All|
| <a id=13325406>[13325406](#13325406) </a> | [FIX: Assertion failure occurs when persistent log buffer is used in SQL Server 2016 (KB4541770)](https://support.microsoft.com/help/4541770) | SQL Engine| Windows|
| <a id=13012856>[13012856](#13012856) </a> | [FIX: Parallel sampled filtered statistics may cause incorrect histogram scaling in SQL Server 2016 (KB4543027)](https://support.microsoft.com/help/4543027)| SQL performance | All|

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

| File   name    | File version    | File size | Date | Time | Platform |
|----------------|-----------------|-----------|------|------|----------|
| Instapi130.dll | 2015.131.5698.0 | 46480     | 16-2 | 04:20 | x86      |
| Keyfile.dll    | 2015.131.5698.0 | 81808     | 16-2 | 04:26 | x86      |
| Sqlbrowser.exe | 2015.131.5698.0 | 269712    | 16-2 | 04:20 | x86      |
| Sqldumper.exe  | 2015.131.5698.0 | 100752    | 16-2 | 04:20 | x86      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date | Time | Platform |
|-----------------------|-----------------|-----------|------|------|----------|
| Instapi130.dll        | 2015.131.5698.0 | 54160     | 16-2 | 04:20 | x64      |
| Sqlboot.dll           | 2015.131.5698.0 | 179808    | 16-2 | 04:18 | x64      |
| Sqldumper.exe         | 2015.131.5698.0 | 120208    | 16-2 | 04:19 | x64      |
| Sqlvdi.dll            | 2015.131.5698.0 | 190352    | 16-2 | 04:21 | x64      |
| Sqlvdi.dll            | 2015.131.5698.0 | 161680    | 16-2 | 04:26 | x86      |
| Sqlwriter.exe         | 2015.131.5698.0 | 125024    | 16-2 | 04:22 | x64      |
| Sqlwriter_keyfile.dll | 2015.131.5698.0 | 93584     | 16-2 | 04:18 | x64      |
| Sqlwvss.dll           | 2015.131.5698.0 | 339856    | 16-2 | 04:09 | x64      |
| Sqlwvss_xp.dll        | 2015.131.5698.0 | 19344     | 16-2 | 04:09 | x64      |

SQL Server 2016 Analysis Services

| File   name                                | File version    | File size | Date  | Time  | Platform |
|--------------------------------------------|-----------------|-----------|-------|-------|----------|
| Microsoft.analysisservices.server.core.dll | 13.0.5698.0     | 1341536   | 16-2  | 04:22  | x86      |
| Microsoft.applicationinsights.dll          | 2.7.0.13435     | 329872    | 07-6 | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5698.0     | 983648    | 16-2  | 04:22  | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5698.0     | 983440    | 16-2  | 04:23  | x86      |
| Msmdctr130.dll                             | 2015.131.5698.0 | 33168     | 16-2  | 04:18  | x64      |
| Msmdlocal.dll                              | 2015.131.5698.0 | 56246672  | 16-2  | 04:19  | x64      |
| Msmdlocal.dll                              | 2015.131.5698.0 | 37127264  | 16-2  | 04:27  | x86      |
| Msmdsrv.exe                                | 2015.131.5698.0 | 56793992  | 16-2  | 04:24  | x64      |
| Msmgdsrv.dll                               | 2015.131.5698.0 | 7502736   | 16-2  | 04:20  | x64      |
| Msmgdsrv.dll                               | 2015.131.5698.0 | 6502288   | 16-2  | 04:29  | x86      |
| Msolap130.dll                              | 2015.131.5698.0 | 8636304   | 16-2  | 04:19  | x64      |
| Msolap130.dll                              | 2015.131.5698.0 | 7004048   | 16-2  | 04:26  | x86      |
| Msolui130.dll                              | 2015.131.5698.0 | 303504    | 16-2  | 04:18  | x64      |
| Msolui130.dll                              | 2015.131.5698.0 | 280464    | 16-2  | 04:26  | x86      |
| Sql_as_keyfile.dll                         | 2015.131.5698.0 | 93584     | 16-2  | 04:18  | x64      |
| Sqlboot.dll                                | 2015.131.5698.0 | 179808    | 16-2  | 04:18  | x64      |
| Sqlceip.exe                                | 13.0.5698.0     | 249440    | 16-2  | 04:20  | x86      |
| Sqldumper.exe                              | 2015.131.5698.0 | 120208    | 16-2  | 04:19  | x64      |
| Sqldumper.exe                              | 2015.131.5698.0 | 100752    | 16-2  | 04:20  | x86      |
| Tmapi.dll                                  | 2015.131.5698.0 | 4339088   | 16-2  | 04:10  | x64      |
| Tmcachemgr.dll                             | 2015.131.5698.0 | 2819472   | 16-2  | 04:10  | x64      |
| Tmpersistence.dll                          | 2015.131.5698.0 | 1064336   | 16-2  | 04:10  | x64      |
| Tmtransactions.dll                         | 2015.131.5698.0 | 1345424   | 16-2  | 04:09  | x64      |
| Xe.dll                                     | 2015.131.5698.0 | 619616    | 16-2  | 04:21  | x64      |
| Xmlrw.dll                                  | 2015.131.5698.0 | 312208    | 16-2  | 04:20  | x64      |
| Xmlrw.dll                                  | 2015.131.5698.0 | 252816    | 16-2  | 04:22  | x86      |
| Xmlrwbin.dll                               | 2015.131.5698.0 | 220560    | 16-2  | 04:20  | x64      |
| Xmlrwbin.dll                               | 2015.131.5698.0 | 184928    | 16-2  | 04:22  | x86      |
| Xmsrv.dll                                  | 2015.131.5698.0 | 24040848  | 16-2  | 04:10  | x64      |
| Xmsrv.dll                                  | 2015.131.5698.0 | 32721296  | 16-2  | 04:25  | x86      |

SQL Server 2016 Database Services Common Core

| File name                                   | File version    | File size | Date | Time  | Platform |
|---------------------------------------------|-----------------|-----------|------|-------|----------|
| Batchparser.dll                             | 2015.131.5698.0 | 153488    | 16-2 | 04:20 | x86      |
| Batchparser.dll                             | 2015.131.5698.0 | 173968    | 16-2 | 04:20 | x64      |
| Instapi130.dll                              | 2015.131.5698.0 | 46480     | 16-2 | 04:20 | x86      |
| Instapi130.dll                              | 2015.131.5698.0 | 54160     | 16-2 | 04:20 | x64      |
| Isacctchange.dll                            | 2015.131.5698.0 | 23952     | 16-2 | 04:18 | x64      |
| Isacctchange.dll                            | 2015.131.5698.0 | 22416     | 16-2 | 04:20 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5698.0     | 1021024   | 16-2 | 04:22 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5698.0     | 1020816   | 16-2 | 04:29 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.5698.0     | 1342048   | 16-2 | 04:28 | x86      |
| Microsoft.analysisservices.dll              | 13.0.5698.0     | 695696    | 16-2 | 04:28 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.5698.0     | 758880    | 16-2 | 04:28 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.5698.0     | 514144    | 16-2 | 04:28 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5698.0     | 705120    | 16-2 | 04:22 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5698.0     | 704912    | 16-2 | 04:28 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5698.0 | 66144     | 16-2 | 04:21 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5698.0 | 68488     | 16-2 | 04:23 | x64      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5698.0     | 562576    | 16-2 | 04:21 | x86      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5698.0     | 562784    | 16-2 | 04:21 | x86      |
| Msasxpress.dll                              | 2015.131.5698.0 | 29280     | 16-2 | 04:18 | x64      |
| Msasxpress.dll                              | 2015.131.5698.0 | 25208     | 16-2 | 04:26 | x86      |
| Pbsvcacctsync.dll                           | 2015.131.5698.0 | 65936     | 16-2 | 04:18 | x64      |
| Pbsvcacctsync.dll                           | 2015.131.5698.0 | 53344     | 16-2 | 04:26 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.131.5698.0 | 93584     | 16-2 | 04:18 | x64      |
| Sqldumper.exe                               | 2015.131.5698.0 | 120208    | 16-2 | 04:19 | x64      |
| Sqldumper.exe                               | 2015.131.5698.0 | 100752    | 16-2 | 04:20 | x86      |
| Sqlftacct.dll                               | 2015.131.5698.0 | 44944     | 16-2 | 04:19 | x64      |
| Sqlftacct.dll                               | 2015.131.5698.0 | 40032     | 16-2 | 04:26 | x86      |
| Sqlmgmprovider.dll                          | 2015.131.5698.0 | 399248    | 16-2 | 04:10 | x64      |
| Sqlmgmprovider.dll                          | 2015.131.5698.0 | 359008    | 16-2 | 04:26 | x86      |
| Sqlsecacctchg.dll                           | 2015.131.5698.0 | 30608     | 16-2 | 04:09 | x64      |
| Sqlsecacctchg.dll                           | 2015.131.5698.0 | 28256     | 16-2 | 04:26 | x86      |
| Sqltdiagn.dll                               | 2015.131.5698.0 | 60808     | 16-2 | 04:09 | x64      |
| Sqltdiagn.dll                               | 2015.131.5698.0 | 53648     | 16-2 | 04:26 | x86      |

SQL Server 2016 sql_dreplay_client

| File name                      | File version    | File size | Date | Time  | Platform |
|--------------------------------|-----------------|-----------|------|-------|----------|
| Dreplayclient.exe              | 2015.131.5698.0 | 114064    | 16-2 | 04:20 | x86      |
| Dreplaycommon.dll              | 2015.131.5698.0 | 683920    | 16-2 | 04:28 | x86      |
| Dreplayutil.dll                | 2015.131.5698.0 | 303200    | 16-2 | 04:20 | x86      |
| Instapi130.dll                 | 2015.131.5698.0 | 54160     | 16-2 | 04:20 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.131.5698.0 | 93584     | 16-2 | 04:18 | x64      |
| Sqlresourceloader.dll          | 2015.131.5698.0 | 21600     | 16-2 | 04:26 | x86      |

SQL Server 2016 sql_dreplay_controller

| File name                          | File version    | File size | Date | Time  | Platform |
|------------------------------------|-----------------|-----------|------|-------|----------|
| Dreplaycommon.dll                  | 2015.131.5698.0 | 683920    | 16-2 | 04:28 | x86      |
| Dreplaycontroller.exe              | 2015.131.5698.0 | 343440    | 16-2 | 04:20 | x86      |
| Dreplayprocess.dll                 | 2015.131.5698.0 | 164752    | 16-2 | 04:20 | x86      |
| Instapi130.dll                     | 2015.131.5698.0 | 54160     | 16-2 | 04:20 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.131.5698.0 | 93584     | 16-2 | 04:18 | x64      |
| Sqlresourceloader.dll              | 2015.131.5698.0 | 21600     | 16-2 | 04:26 | x86      |

SQL Server 2016 Database Services Core Instance

| File name                                    | File version    | File size | Date | Time  | Platform |
|----------------------------------------------|-----------------|-----------|------|-------|----------|
| Backuptourl.exe                              | 13.0.5698.0     | 34424     | 16-2 | 04:23 | x64      |
| Batchparser.dll                              | 2015.131.5698.0 | 173968    | 16-2 | 04:20 | x64      |
| Datacollectorcontroller.dll                  | 2015.131.5698.0 | 218512    | 16-2 | 04:19 | x64      |
| Dcexec.exe                                   | 2015.131.5698.0 | 67472     | 16-2 | 04:22 | x64      |
| Fssres.dll                                   | 2015.131.5698.0 | 74640     | 16-2 | 04:18 | x64      |
| Hadrres.dll                                  | 2015.131.5698.0 | 170896    | 16-2 | 04:20 | x64      |
| Hkcompile.dll                                | 2015.131.5698.0 | 1291152   | 16-2 | 04:21 | x64      |
| Hkengine.dll                                 | 2015.131.5698.0 | 5594720   | 16-2 | 04:23 | x64      |
| Hkruntime.dll                                | 2015.131.5698.0 | 152160    | 16-2 | 04:23 | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 06-7 | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.5698.0     | 227216    | 16-2 | 04:23 | x86      |
| Microsoft.sqlserver.types.dll                | 2015.131.5698.0 | 385936    | 16-2 | 04:25 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.131.5698.0 | 65424     | 16-2 | 04:20 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.131.5698.0 | 58256     | 16-2 | 04:24 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5698.0 | 143240    | 16-2 | 04:24 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5698.0 | 151952    | 16-2 | 04:24 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.131.5698.0 | 265312    | 16-2 | 04:24 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.131.5698.0 | 67984     | 16-2 | 04:24 | x64      |
| Odsole70.dll                                 | 2015.131.5698.0 | 85904     | 16-2 | 04:19 | x64      |
| Opends60.dll                                 | 2015.131.5698.0 | 26000     | 16-2 | 04:20 | x64      |
| Qds.dll                                      | 2015.131.5698.0 | 867216    | 16-2 | 04:19 | x64      |
| Rsfxft.dll                                   | 2015.131.5698.0 | 27528     | 16-2 | 04:20 | x64      |
| Sqagtres.dll                                 | 2015.131.5698.0 | 57952     | 16-2 | 04:19 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.131.5698.0 | 93584     | 16-2 | 04:18 | x64      |
| Sqlaamss.dll                                 | 2015.131.5698.0 | 73616     | 16-2 | 04:20 | x64      |
| Sqlaccess.dll                                | 2015.131.5698.0 | 456288    | 16-2 | 04:24 | x64      |
| Sqlagent.exe                                 | 2015.131.5698.0 | 559504    | 16-2 | 04:22 | x64      |
| Sqlagentctr130.dll                           | 2015.131.5698.0 | 44944     | 16-2 | 04:19 | x64      |
| Sqlagentctr130.dll                           | 2015.131.5698.0 | 37264     | 16-2 | 04:19 | x86      |
| Sqlagentlog.dll                              | 2015.131.5698.0 | 26000     | 16-2 | 04:18 | x64      |
| Sqlagentmail.dll                             | 2015.131.5698.0 | 40848     | 16-2 | 04:20 | x64      |
| Sqlboot.dll                                  | 2015.131.5698.0 | 179808    | 16-2 | 04:18 | x64      |
| Sqlceip.exe                                  | 13.0.5698.0     | 249440    | 16-2 | 04:20 | x86      |
| Sqlcmdss.dll                                 | 2015.131.5698.0 | 53136     | 16-2 | 04:19 | x64      |
| Sqldk.dll                                    | 2015.131.5698.0 | 2582416   | 16-2 | 04:19 | x64      |
| Sqldtsss.dll                                 | 2015.131.5698.0 | 90512     | 16-2 | 04:20 | x64      |
| Sqliosim.com                                 | 2015.131.5698.0 | 301152    | 16-2 | 04:19 | x64      |
| Sqliosim.exe                                 | 2015.131.5698.0 | 3007608   | 16-2 | 04:23 | x64      |
| Sqllang.dll                                  | 2015.131.5698.0 | 39535200  | 16-2 | 04:19 | x64      |
| Sqlmin.dll                                   | 2015.131.5698.0 | 37938576  | 16-2 | 04:10 | x64      |
| Sqlolapss.dll                                | 2015.131.5698.0 | 91024     | 16-2 | 04:20 | x64      |
| Sqlos.dll                                    | 2015.131.5698.0 | 19344     | 16-2 | 04:20 | x64      |
| Sqlpowershellss.dll                          | 2015.131.5698.0 | 51600     | 16-2 | 04:10 | x64      |
| Sqlrepss.dll                                 | 2015.131.5698.0 | 48016     | 16-2 | 04:10 | x64      |
| Sqlresld.dll                                 | 2015.131.5698.0 | 23952     | 16-2 | 04:10 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5698.0 | 23952     | 16-2 | 04:10 | x64      |
| Sqlscm.dll                                   | 2015.131.5698.0 | 54160     | 16-2 | 04:20 | x64      |
| Sqlscriptdowngrade.dll                       | 2015.131.5698.0 | 20880     | 16-2 | 04:10 | x64      |
| Sqlscriptupgrade.dll                         | 2015.131.5698.0 | 5804944   | 16-2 | 04:22 | x64      |
| Sqlserverspatial130.dll                      | 2015.131.5698.0 | 725904    | 16-2 | 04:20 | x64      |
| Sqlservr.exe                                 | 2015.131.5698.0 | 386144    | 16-2 | 04:22 | x64      |
| Sqlsvc.dll                                   | 2015.131.5698.0 | 145296    | 16-2 | 04:10 | x64      |
| Sqltses.dll                                  | 2015.131.5698.0 | 8916368   | 16-2 | 04:10 | x64      |
| Sqsrvres.dll                                 | 2015.131.5698.0 | 244112    | 16-2 | 04:10 | x64      |
| Xe.dll                                       | 2015.131.5698.0 | 619616    | 16-2 | 04:21 | x64      |
| Xmlrw.dll                                    | 2015.131.5698.0 | 312208    | 16-2 | 04:20 | x64      |
| Xmlrwbin.dll                                 | 2015.131.5698.0 | 220560    | 16-2 | 04:20 | x64      |
| Xpadsi.exe                                   | 2015.131.5698.0 | 72080     | 16-2 | 04:25 | x64      |
| Xplog70.dll                                  | 2015.131.5698.0 | 58768     | 16-2 | 04:20 | x64      |
| Xpsqlbot.dll                                 | 2015.131.5698.0 | 26512     | 16-2 | 04:20 | x64      |
| Xpstar.dll                                   | 2015.131.5698.0 | 415632    | 16-2 | 04:20 | x64      |

SQL Server 2016 Database Services Core Shared

| File name                                    | File version    | File size | Date | Time  | Platform |
|----------------------------------------------|-----------------|-----------|------|-------|----------|
| Batchparser.dll                              | 2015.131.5698.0 | 153488    | 16-2 | 04:20 | x86      |
| Batchparser.dll                              | 2015.131.5698.0 | 173968    | 16-2 | 04:20 | x64      |
| Bcp.exe                                      | 2015.131.5698.0 | 113040    | 16-2 | 04:19 | x64      |
| Commanddest.dll                              | 2015.131.5698.0 | 242064    | 16-2 | 04:19 | x64      |
| Datacollectorenumerators.dll                 | 2015.131.5698.0 | 108944    | 16-2 | 04:19 | x64      |
| Datacollectortasks.dll                       | 2015.131.5698.0 | 181136    | 16-2 | 04:19 | x64      |
| Distrib.exe                                  | 2015.131.5698.0 | 184416    | 16-2 | 04:23 | x64      |
| Dteparse.dll                                 | 2015.131.5698.0 | 102792    | 16-2 | 04:19 | x64      |
| Dteparsemgd.dll                              | 2015.131.5698.0 | 81808     | 16-2 | 04:22 | x64      |
| Dtepkg.dll                                   | 2015.131.5698.0 | 130448    | 16-2 | 04:19 | x64      |
| Dtexec.exe                                   | 2015.131.5698.0 | 66144     | 16-2 | 04:23 | x64      |
| Dts.dll                                      | 2015.131.5698.0 | 3139984   | 16-2 | 04:19 | x64      |
| Dtscomexpreval.dll                           | 2015.131.5698.0 | 470416    | 16-2 | 04:19 | x64      |
| Dtsconn.dll                                  | 2015.131.5698.0 | 485776    | 16-2 | 04:19 | x64      |
| Dtshost.exe                                  | 2015.131.5698.0 | 79760     | 16-2 | 04:22 | x64      |
| Dtslog.dll                                   | 2015.131.5698.0 | 113552    | 16-2 | 04:19 | x64      |
| Dtsmsg130.dll                                | 2015.131.5698.0 | 538512    | 16-2 | 04:19 | x64      |
| Dtspipeline.dll                              | 2015.131.5698.0 | 1272208   | 16-2 | 04:19 | x64      |
| Dtspipelineperf130.dll                       | 2015.131.5698.0 | 41360     | 16-2 | 04:18 | x64      |
| Dtuparse.dll                                 | 2015.131.5698.0 | 80784     | 16-2 | 04:19 | x64      |
| Dtutil.exe                                   | 2015.131.5698.0 | 127888    | 16-2 | 04:22 | x64      |
| Exceldest.dll                                | 2015.131.5698.0 | 256400    | 16-2 | 04:18 | x64      |
| Excelsrc.dll                                 | 2015.131.5698.0 | 278416    | 16-2 | 04:19 | x64      |
| Execpackagetask.dll                          | 2015.131.5698.0 | 159632    | 16-2 | 04:19 | x64      |
| Flatfiledest.dll                             | 2015.131.5698.0 | 382344    | 16-2 | 04:18 | x64      |
| Flatfilesrc.dll                              | 2015.131.5698.0 | 394640    | 16-2 | 04:18 | x64      |
| Foreachfileenumerator.dll                    | 2015.131.5698.0 | 89488     | 16-2 | 04:18 | x64      |
| Hkengperfctrs.dll                            | 2015.131.5698.0 | 52112     | 16-2 | 04:20 | x64      |
| Logread.exe                                  | 2015.131.5698.0 | 620128    | 16-2 | 04:22 | x64      |
| Microsoft.analysisservices.applocal.core.dll | 13.0.5698.0     | 1307024   | 16-2 | 04:22 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll | 13.0.5698.0     | 385632    | 16-2 | 04:21 | x86      |
| Microsoft.sqlserver.replication.dll          | 2015.131.5698.0 | 1644432   | 16-2 | 04:20 | x64      |
| Microsoft.sqlserver.rmo.dll                  | 13.0.5698.0     | 562784    | 16-2 | 04:21 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5698.0 | 143240    | 16-2 | 04:24 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5698.0 | 151952    | 16-2 | 04:24 | x64      |
| Msdtssrvrutil.dll                            | 2015.131.5698.0 | 94608     | 16-2 | 04:18 | x64      |
| Msxmlsql.dll                                 | 2015.131.5698.0 | 1487760   | 16-2 | 04:21 | x64      |
| Oledbdest.dll                                | 2015.131.5698.0 | 257424    | 16-2 | 04:19 | x64      |
| Oledbsrc.dll                                 | 2015.131.5698.0 | 284048    | 16-2 | 04:18 | x64      |
| Osql.exe                                     | 2015.131.5698.0 | 68496     | 16-2 | 04:19 | x64      |
| Rawdest.dll                                  | 2015.131.5698.0 | 202640    | 16-2 | 04:19 | x64      |
| Rawsource.dll                                | 2015.131.5698.0 | 189840    | 16-2 | 04:19 | x64      |
| Rdistcom.dll                                 | 2015.131.5698.0 | 900496    | 16-2 | 04:18 | x64      |
| Recordsetdest.dll                            | 2015.131.5698.0 | 180112    | 16-2 | 04:18 | x64      |
| Repldp.dll                                   | 2015.131.5698.0 | 274832    | 16-2 | 04:18 | x64      |
| Replmerg.exe                                 | 2015.131.5698.0 | 512096    | 16-2 | 04:22 | x64      |
| Replprov.dll                                 | 2015.131.5698.0 | 805264    | 16-2 | 04:18 | x64      |
| Replrec.dll                                  | 2015.131.5698.0 | 1012320   | 16-2 | 04:20 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2015.131.5698.0 | 93584     | 16-2 | 04:18 | x64      |
| Sqlcmd.exe                                   | 2015.131.5698.0 | 242576    | 16-2 | 04:19 | x64      |
| Sqldiag.exe                                  | 2015.131.5698.0 | 1250912   | 16-2 | 04:23 | x64      |
| Sqllogship.exe                               | 13.0.5698.0     | 97888     | 16-2 | 04:20 | x64      |
| Sqlresld.dll                                 | 2015.131.5698.0 | 23952     | 16-2 | 04:10 | x64      |
| Sqlresld.dll                                 | 2015.131.5698.0 | 22112     | 16-2 | 04:26 | x86      |
| Sqlresourceloader.dll                        | 2015.131.5698.0 | 23952     | 16-2 | 04:10 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5698.0 | 21600     | 16-2 | 04:26 | x86      |
| Sqlscm.dll                                   | 2015.131.5698.0 | 54160     | 16-2 | 04:20 | x64      |
| Sqlscm.dll                                   | 2015.131.5698.0 | 46200     | 16-2 | 04:26 | x86      |
| Sqlsvc.dll                                   | 2015.131.5698.0 | 145296    | 16-2 | 04:10 | x64      |
| Sqlsvc.dll                                   | 2015.131.5698.0 | 120416    | 16-2 | 04:26 | x86      |
| Sqltaskconnections.dll                       | 2015.131.5698.0 | 173968    | 16-2 | 04:09 | x64      |
| Sqlwep130.dll                                | 2015.131.5698.0 | 98704     | 16-2 | 04:10 | x64      |
| Ssisoledb.dll                                | 2015.131.5698.0 | 209296    | 16-2 | 04:10 | x64      |
| Tablediff.exe                                | 13.0.5698.0     | 79760     | 16-2 | 04:20 | x64      |
| Txagg.dll                                    | 2015.131.5698.0 | 357768    | 16-2 | 04:09 | x64      |
| Txbdd.dll                                    | 2015.131.5698.0 | 165776    | 16-2 | 04:09 | x64      |
| Txdatacollector.dll                          | 2015.131.5698.0 | 360848    | 16-2 | 04:09 | x64      |
| Txdataconvert.dll                            | 2015.131.5698.0 | 289680    | 16-2 | 04:09 | x64      |
| Txderived.dll                                | 2015.131.5698.0 | 600976    | 16-2 | 04:09 | x64      |
| Txlookup.dll                                 | 2015.131.5698.0 | 525200    | 16-2 | 04:09 | x64      |
| Txmerge.dll                                  | 2015.131.5698.0 | 223632    | 16-2 | 04:09 | x64      |
| Txmergejoin.dll                              | 2015.131.5698.0 | 271760    | 16-2 | 04:09 | x64      |
| Txmulticast.dll                              | 2015.131.5698.0 | 121232    | 16-2 | 04:09 | x64      |
| Txrowcount.dll                               | 2015.131.5698.0 | 119696    | 16-2 | 04:09 | x64      |
| Txsort.dll                                   | 2015.131.5698.0 | 252296    | 16-2 | 04:09 | x64      |
| Txsplit.dll                                  | 2015.131.5698.0 | 593808    | 16-2 | 04:09 | x64      |
| Txunionall.dll                               | 2015.131.5698.0 | 174992    | 16-2 | 04:09 | x64      |
| Xe.dll                                       | 2015.131.5698.0 | 619616    | 16-2 | 04:21 | x64      |
| Xmlrw.dll                                    | 2015.131.5698.0 | 312208    | 16-2 | 04:20 | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date | Time | Platform |
|-------------------------------|-----------------|-----------|------|------|----------|
| Launchpad.exe                 | 2015.131.5698.0 | 1008016   | 16-2 | 04:19 | x64      |
| Sql_extensibility_keyfile.dll | 2015.131.5698.0 | 93584     | 16-2 | 04:18 | x64      |
| Sqlsatellite.dll              | 2015.131.5698.0 | 830864    | 16-2 | 04:20 | x64      |

SQL Server 2016 Full-Text Engine

| File name                | File version    | File size | Date | Time  | Platform |
|--------------------------|-----------------|-----------|------|-------|----------|
| Fd.dll                   | 2015.131.5698.0 | 653200    | 16-2 | 04:20 | x64      |
| Fdhost.exe               | 2015.131.5698.0 | 98192     | 16-2 | 04:19 | x64      |
| Fdlauncher.exe           | 2015.131.5698.0 | 44432     | 16-2 | 04:19 | x64      |
| Sql_fulltext_keyfile.dll | 2015.131.5698.0 | 93584     | 16-2 | 04:18 | x64      |
| Sqlft130ph.dll           | 2015.131.5698.0 | 51088     | 16-2 | 04:20 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version    | File size | Date | Time | Platform |
|-------------------------|-----------------|-----------|------|------|----------|
| Imrdll.dll              | 13.0.5698.0     | 16992     | 16-2 | 04:22 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.131.5698.0 | 93584     | 16-2 | 04:18 | x64      |

SQL Server 2016 Integration Services

| File   name                                        | File version    | File size | Date  | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|-------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll              | 4.0.0.111       | 77944     | 31-1  | 10:38 | x86      |
| Attunity.sqlserver.cdccontroltask.dll              | 4.0.0.111       | 77944     | 03-2 | 10:39 | x86      |
| Attunity.sqlserver.cdcsplit.dll                    | 4.0.0.111       | 37496     | 31-1  | 10:38 | x86      |
| Attunity.sqlserver.cdcsplit.dll                    | 4.0.0.111       | 37496     | 03-2 | 10:39 | x86      |
| Attunity.sqlserver.cdcsrc.dll                      | 4.0.0.111       | 78456     | 31-1  | 10:38 | x86      |
| Attunity.sqlserver.cdcsrc.dll                      | 4.0.0.111       | 78456     | 03-2 | 10:39 | x86      |
| Commanddest.dll                                    | 2015.131.5698.0 | 242064    | 16-2  | 04:19  | x64      |
| Commanddest.dll                                    | 2015.131.5698.0 | 195984    | 16-2  | 04:20  | x86      |
| Dteparse.dll                                       | 2015.131.5698.0 | 102792    | 16-2  | 04:19  | x64      |
| Dteparse.dll                                       | 2015.131.5698.0 | 92768     | 16-2  | 04:20  | x86      |
| Dteparsemgd.dll                                    | 2015.131.5698.0 | 81808     | 16-2  | 04:22  | x64      |
| Dteparsemgd.dll                                    | 2015.131.5698.0 | 76896     | 16-2  | 04:29  | x86      |
| Dtepkg.dll                                         | 2015.131.5698.0 | 130448    | 16-2  | 04:19  | x64      |
| Dtepkg.dll                                         | 2015.131.5698.0 | 109152    | 16-2  | 04:20  | x86      |
| Dtexec.exe                                         | 2015.131.5698.0 | 59792     | 16-2  | 04:20  | x86      |
| Dtexec.exe                                         | 2015.131.5698.0 | 66144     | 16-2  | 04:23  | x64      |
| Dts.dll                                            | 2015.131.5698.0 | 3139984   | 16-2  | 04:19  | x64      |
| Dts.dll                                            | 2015.131.5698.0 | 2625936   | 16-2  | 04:20  | x86      |
| Dtscomexpreval.dll                                 | 2015.131.5698.0 | 470416    | 16-2  | 04:19  | x64      |
| Dtscomexpreval.dll                                 | 2015.131.5698.0 | 412048    | 16-2  | 04:20  | x86      |
| Dtsconn.dll                                        | 2015.131.5698.0 | 485776    | 16-2  | 04:19  | x64      |
| Dtsconn.dll                                        | 2015.131.5698.0 | 385632    | 16-2  | 04:20  | x86      |
| Dtsdebughost.exe                                   | 2015.131.5698.0 | 86928     | 16-2  | 04:20  | x86      |
| Dtsdebughost.exe                                   | 2015.131.5698.0 | 103032    | 16-2  | 04:22  | x64      |
| Dtshost.exe                                        | 2015.131.5698.0 | 69728     | 16-2  | 04:20  | x86      |
| Dtshost.exe                                        | 2015.131.5698.0 | 79760     | 16-2  | 04:22  | x64      |
| Dtslog.dll                                         | 2015.131.5698.0 | 113552    | 16-2  | 04:19  | x64      |
| Dtslog.dll                                         | 2015.131.5698.0 | 96144     | 16-2  | 04:20  | x86      |
| Dtsmsg130.dll                                      | 2015.131.5698.0 | 538512    | 16-2  | 04:19  | x64      |
| Dtsmsg130.dll                                      | 2015.131.5698.0 | 534416    | 16-2  | 04:20  | x86      |
| Dtspipeline.dll                                    | 2015.131.5698.0 | 1272208   | 16-2  | 04:19  | x64      |
| Dtspipeline.dll                                    | 2015.131.5698.0 | 1052560   | 16-2  | 04:20  | x86      |
| Dtspipelineperf130.dll                             | 2015.131.5698.0 | 41360     | 16-2  | 04:18  | x64      |
| Dtspipelineperf130.dll                             | 2015.131.5698.0 | 35216     | 16-2  | 04:20  | x86      |
| Dtuparse.dll                                       | 2015.131.5698.0 | 80784     | 16-2  | 04:19  | x64      |
| Dtuparse.dll                                       | 2015.131.5698.0 | 73104     | 16-2  | 04:20  | x86      |
| Dtutil.exe                                         | 2015.131.5698.0 | 108432    | 16-2  | 04:20  | x86      |
| Dtutil.exe                                         | 2015.131.5698.0 | 127888    | 16-2  | 04:22  | x64      |
| Exceldest.dll                                      | 2015.131.5698.0 | 256400    | 16-2  | 04:18  | x64      |
| Exceldest.dll                                      | 2015.131.5698.0 | 209808    | 16-2  | 04:20  | x86      |
| Excelsrc.dll                                       | 2015.131.5698.0 | 278416    | 16-2  | 04:19  | x64      |
| Excelsrc.dll                                       | 2015.131.5698.0 | 225888    | 16-2  | 04:20  | x86      |
| Execpackagetask.dll                                | 2015.131.5698.0 | 159632    | 16-2  | 04:19  | x64      |
| Execpackagetask.dll                                | 2015.131.5698.0 | 128400    | 16-2  | 04:20  | x86      |
| Flatfiledest.dll                                   | 2015.131.5698.0 | 382344    | 16-2  | 04:18  | x64      |
| Flatfiledest.dll                                   | 2015.131.5698.0 | 327568    | 16-2  | 04:20  | x86      |
| Flatfilesrc.dll                                    | 2015.131.5698.0 | 394640    | 16-2  | 04:18  | x64      |
| Flatfilesrc.dll                                    | 2015.131.5698.0 | 338320    | 16-2  | 04:20  | x86      |
| Foreachfileenumerator.dll                          | 2015.131.5698.0 | 89488     | 16-2  | 04:18  | x64      |
| Foreachfileenumerator.dll                          | 2015.131.5698.0 | 73824     | 16-2  | 04:20  | x86      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5698.0     | 1307024   | 16-2  | 04:22  | x86      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5698.0     | 1307256   | 16-2  | 04:28  | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 07-6 | 22:33 | x86      |
| Microsoft.sqlserver.astasks.dll                    | 13.0.5698.0     | 66448     | 16-2  | 04:23  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5698.0 | 100448    | 16-2  | 04:22  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5698.0 | 105568    | 16-2  | 04:23  | x64      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5698.0     | 75664     | 15-2  | 5:09  | x86      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5698.0     | 75664     | 16-2  | 04:20  | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll       | 13.0.5698.0     | 385632    | 16-2  | 04:21  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5698.0 | 131984    | 16-2  | 04:21  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5698.0 | 143240    | 16-2  | 04:24  | x64      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5698.0 | 137616    | 16-2  | 04:21  | x86      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5698.0 | 151952    | 16-2  | 04:24  | x64      |
| Msdtssrvr.exe                                      | 13.0.5698.0     | 209800    | 16-2  | 04:20  | x64      |
| Msdtssrvrutil.dll                                  | 2015.131.5698.0 | 94608     | 16-2  | 04:18  | x64      |
| Msdtssrvrutil.dll                                  | 2015.131.5698.0 | 83344     | 16-2  | 04:26  | x86      |
| Oledbdest.dll                                      | 2015.131.5698.0 | 257424    | 16-2  | 04:19  | x64      |
| Oledbdest.dll                                      | 2015.131.5698.0 | 209808    | 16-2  | 04:26  | x86      |
| Oledbsrc.dll                                       | 2015.131.5698.0 | 284048    | 16-2  | 04:18  | x64      |
| Oledbsrc.dll                                       | 2015.131.5698.0 | 228752    | 16-2  | 04:26  | x86      |
| Rawdest.dll                                        | 2015.131.5698.0 | 202640    | 16-2  | 04:19  | x64      |
| Rawdest.dll                                        | 2015.131.5698.0 | 161672    | 16-2  | 04:26  | x86      |
| Rawsource.dll                                      | 2015.131.5698.0 | 189840    | 16-2  | 04:19  | x64      |
| Rawsource.dll                                      | 2015.131.5698.0 | 148368    | 16-2  | 04:26  | x86      |
| Recordsetdest.dll                                  | 2015.131.5698.0 | 180112    | 16-2  | 04:18  | x64      |
| Recordsetdest.dll                                  | 2015.131.5698.0 | 144992    | 16-2  | 04:26  | x86      |
| Sql_is_keyfile.dll                                 | 2015.131.5698.0 | 93584     | 16-2  | 04:18  | x64      |
| Sqlceip.exe                                        | 13.0.5698.0     | 249440    | 16-2  | 04:20  | x86      |
| Sqldest.dll                                        | 2015.131.5698.0 | 257120    | 16-2  | 04:18  | x64      |
| Sqldest.dll                                        | 2015.131.5698.0 | 208992    | 16-2  | 04:26  | x86      |
| Sqltaskconnections.dll                             | 2015.131.5698.0 | 173968    | 16-2  | 04:09  | x64      |
| Sqltaskconnections.dll                             | 2015.131.5698.0 | 144480    | 16-2  | 04:26  | x86      |
| Ssisoledb.dll                                      | 2015.131.5698.0 | 209296    | 16-2  | 04:10  | x64      |
| Ssisoledb.dll                                      | 2015.131.5698.0 | 170080    | 16-2  | 04:26  | x86      |
| Txagg.dll                                          | 2015.131.5698.0 | 357768    | 16-2  | 04:09  | x64      |
| Txagg.dll                                          | 2015.131.5698.0 | 298080    | 16-2  | 04:23  | x86      |
| Txbdd.dll                                          | 2015.131.5698.0 | 165776    | 16-2  | 04:09  | x64      |
| Txbdd.dll                                          | 2015.131.5698.0 | 131168    | 16-2  | 04:24  | x86      |
| Txbestmatch.dll                                    | 2015.131.5698.0 | 604560    | 16-2  | 04:09  | x64      |
| Txbestmatch.dll                                    | 2015.131.5698.0 | 489592    | 16-2  | 04:23  | x86      |
| Txcache.dll                                        | 2015.131.5698.0 | 176528    | 16-2  | 04:10  | x64      |
| Txcache.dll                                        | 2015.131.5698.0 | 141408    | 16-2  | 04:22  | x86      |
| Txcharmap.dll                                      | 2015.131.5698.0 | 283024    | 16-2  | 04:09  | x64      |
| Txcharmap.dll                                      | 2015.131.5698.0 | 243832    | 16-2  | 04:22  | x86      |
| Txcopymap.dll                                      | 2015.131.5698.0 | 176016    | 16-2  | 04:09  | x64      |
| Txcopymap.dll                                      | 2015.131.5698.0 | 140896    | 16-2  | 04:24  | x86      |
| Txdataconvert.dll                                  | 2015.131.5698.0 | 289680    | 16-2  | 04:09  | x64      |
| Txdataconvert.dll                                  | 2015.131.5698.0 | 248416    | 16-2  | 04:24  | x86      |
| Txderived.dll                                      | 2015.131.5698.0 | 600976    | 16-2  | 04:09  | x64      |
| Txderived.dll                                      | 2015.131.5698.0 | 512632    | 16-2  | 04:24  | x86      |
| Txfileextractor.dll                                | 2015.131.5698.0 | 194952    | 16-2  | 04:09  | x64      |
| Txfileextractor.dll                                | 2015.131.5698.0 | 156256    | 16-2  | 04:24  | x86      |
| Txfileinserter.dll                                 | 2015.131.5698.0 | 192912    | 16-2  | 04:09  | x64      |
| Txfileinserter.dll                                 | 2015.131.5698.0 | 154000    | 16-2  | 04:24  | x86      |
| Txgroupdups.dll                                    | 2015.131.5698.0 | 284048    | 16-2  | 04:09  | x64      |
| Txgroupdups.dll                                    | 2015.131.5698.0 | 224656    | 16-2  | 04:23  | x86      |
| Txlineage.dll                                      | 2015.131.5698.0 | 130960    | 16-2  | 04:09  | x64      |
| Txlineage.dll                                      | 2015.131.5698.0 | 103008    | 16-2  | 04:23  | x86      |
| Txlookup.dll                                       | 2015.131.5698.0 | 525200    | 16-2  | 04:09  | x64      |
| Txlookup.dll                                       | 2015.131.5698.0 | 442976    | 16-2  | 04:23  | x86      |
| Txmerge.dll                                        | 2015.131.5698.0 | 223632    | 16-2  | 04:09  | x64      |
| Txmerge.dll                                        | 2015.131.5698.0 | 169872    | 16-2  | 04:28  | x86      |
| Txmergejoin.dll                                    | 2015.131.5698.0 | 271760    | 16-2  | 04:09  | x64      |
| Txmergejoin.dll                                    | 2015.131.5698.0 | 217184    | 16-2  | 04:24  | x86      |
| Txmulticast.dll                                    | 2015.131.5698.0 | 121232    | 16-2  | 04:09  | x64      |
| Txmulticast.dll                                    | 2015.131.5698.0 | 95328     | 16-2  | 04:24  | x86      |
| Txpivot.dll                                        | 2015.131.5698.0 | 221072    | 16-2  | 04:09  | x64      |
| Txpivot.dll                                        | 2015.131.5698.0 | 175200    | 16-2  | 04:23  | x86      |
| Txrowcount.dll                                     | 2015.131.5698.0 | 119696    | 16-2  | 04:09  | x64      |
| Txrowcount.dll                                     | 2015.131.5698.0 | 94816     | 16-2  | 04:21  | x86      |
| Txsampling.dll                                     | 2015.131.5698.0 | 165264    | 16-2  | 04:09  | x64      |
| Txsampling.dll                                     | 2015.131.5698.0 | 127888    | 16-2  | 04:23  | x86      |
| Txscd.dll                                          | 2015.131.5698.0 | 213392    | 16-2  | 04:09  | x64      |
| Txscd.dll                                          | 2015.131.5698.0 | 162912    | 16-2  | 04:22  | x86      |
| Txsort.dll                                         | 2015.131.5698.0 | 252296    | 16-2  | 04:09  | x64      |
| Txsort.dll                                         | 2015.131.5698.0 | 204176    | 16-2  | 04:21  | x86      |
| Txsplit.dll                                        | 2015.131.5698.0 | 593808    | 16-2  | 04:09  | x64      |
| Txsplit.dll                                        | 2015.131.5698.0 | 506464    | 16-2  | 04:21  | x86      |
| Txtermextraction.dll                               | 2015.131.5698.0 | 8671120   | 16-2  | 04:10  | x64      |
| Txtermextraction.dll                               | 2015.131.5698.0 | 8608864   | 16-2  | 04:23  | x86      |
| Txtermlookup.dll                                   | 2015.131.5698.0 | 4151696   | 16-2  | 04:10  | x64      |
| Txtermlookup.dll                                   | 2015.131.5698.0 | 4099984   | 16-2  | 04:24  | x86      |
| Txunionall.dll                                     | 2015.131.5698.0 | 174992    | 16-2  | 04:09  | x64      |
| Txunionall.dll                                     | 2015.131.5698.0 | 131984    | 16-2  | 04:23  | x86      |
| Txunpivot.dll                                      | 2015.131.5698.0 | 194960    | 16-2  | 04:09  | x64      |
| Txunpivot.dll                                      | 2015.131.5698.0 | 155744    | 16-2  | 04:24  | x86      |
| Xe.dll                                             | 2015.131.5698.0 | 619616    | 16-2  | 04:21  | x64      |
| Xe.dll                                             | 2015.131.5698.0 | 552032    | 16-2  | 04:27  | x86      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date  | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-------|-------|----------|
| Dms.dll                                                              | 10.0.8224.49     | 483624    | 09-5 | 19:33 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.49 | 75560     | 09-5 | 19:33 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.49     | 45864     | 09-5 | 19:33 | x86      |
| Instapi130.dll                                                       | 2015.131.5698.0  | 54160     | 16-2  | 04:09  | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 10.0.8224.49     | 74536     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 10.0.8224.49     | 202024    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 10.0.8224.49     | 2347304   | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 10.0.8224.49     | 102184    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 10.0.8224.49     | 378664    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 10.0.8224.49     | 185640    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 10.0.8224.49     | 127272    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 10.0.8224.49     | 63272     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 10.0.8224.49     | 52520     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 10.0.8224.49     | 87336     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 10.0.8224.49     | 721704    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 10.0.8224.49     | 87336     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 10.0.8224.49     | 78120     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 10.0.8224.49     | 41768     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 10.0.8224.49     | 36648     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 10.0.8224.49     | 47912     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 10.0.8224.49     | 27432     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 10.0.8224.49     | 33064     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 10.0.8224.49     | 119080    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 10.0.8224.49     | 94504     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 10.0.8224.49     | 108328    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 10.0.8224.49     | 256808    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 102184    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 116008    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 119080    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 116008    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 125736    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 118056    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 113448    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 145704    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 100136    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 114984    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 10.0.8224.49     | 69416     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 10.0.8224.49     | 28456     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 10.0.8224.49     | 43816     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 10.0.8224.49     | 82216     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 10.0.8224.49     | 137000    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 10.0.8224.49     | 2155816   | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 10.0.8224.49     | 3818792   | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 107816    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 120104    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 124712    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 121128    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 133408    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 121128    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 118568    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 152360    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 105280    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 119592    | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 10.0.8224.49     | 66856     | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 10.0.8224.49     | 2756392   | 09-5 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 10.0.8224.49     | 752424    | 09-5 | 19:33 | x86      |
| Mpdwinterop.dll                                                      | 2015.131.5698.0  | 388192    | 16-2  | 04:19  | x64      |
| Mpdwsvc.exe                                                          | 2015.131.5698.0  | 6611856   | 16-2  | 04:26  | x64      |
| Pdwodbcsql11.dll                                                     | 2015.131.5698.0  | 2222992   | 16-2  | 04:09  | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.49 | 47400     | 09-5 | 19:33 | x64      |
| Sqldk.dll                                                            | 2015.131.5698.0  | 2526096   | 16-2  | 04:09  | x64      |
| Sqldumper.exe                                                        | 2015.131.5698.0  | 120416    | 16-2  | 04:25  | x64      |
| Sqlos.dll                                                            | 2015.131.5698.0  | 19344     | 16-2  | 04:09  | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.49 | 4348200   | 09-5 | 19:33 | x64      |
| Sqltses.dll                                                          | 2015.131.5698.0  | 9085840   | 16-2  | 04:10  | x64      |

SQL Server 2016 Reporting Services

| File   name                                               | File version    | File size | Date | Time | Platform |
|-----------------------------------------------------------|-----------------|-----------|------|------|----------|
| Microsoft.analysisservices.modeling.dll                   | 13.0.5698.0     | 604256    | 16-2 | 04:22 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.5698.0     | 1613200   | 16-2 | 04:22 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.5698.0     | 651664    | 16-2 | 04:22 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.5698.0     | 323168    | 16-2 | 04:22 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.5698.0     | 1084000   | 16-2 | 04:22 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5698.0     | 541792    | 16-2 | 04:23 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5698.0     | 541584    | 16-2 | 04:25 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5698.0     | 541792    | 16-2 | 04:22 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5698.0     | 541584    | 16-2 | 04:29 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5698.0     | 541584    | 16-2 | 04:28 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5698.0     | 541584    | 16-2 | 04:22 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5698.0     | 541584    | 16-2 | 04:19 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5698.0     | 541792    | 16-2 | 04:27 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5698.0     | 541584    | 16-2 | 04:26 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5698.0     | 541576    | 16-2 | 04:27 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.5698.0     | 156256    | 16-2 | 04:22 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.5698.0     | 119176    | 16-2 | 04:24 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.5698.0     | 6069856   | 16-2 | 04:24 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5698.0     | 4504456   | 16-2 | 04:24 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5698.0     | 4504976   | 16-2 | 04:27 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5698.0     | 4505184   | 16-2 | 04:23 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5698.0     | 4504976   | 16-2 | 04:28 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5698.0     | 4505480   | 16-2 | 04:29 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5698.0     | 4505696   | 16-2 | 04:23 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5698.0     | 4504976   | 16-2 | 04:19 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5698.0     | 4506208   | 16-2 | 04:26 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5698.0     | 4504672   | 16-2 | 04:26 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5698.0     | 4505184   | 16-2 | 04:27 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.5698.0     | 10921056  | 16-2 | 04:24 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.5698.0     | 95632     | 16-2 | 04:20 | x64      |
| Microsoft.reportingservices.storage.dll                   | 13.0.5698.0     | 201824    | 16-2 | 04:24 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.131.5698.0 | 40848     | 16-2 | 04:23 | x64      |
| Microsoft.sqlserver.types.dll                             | 2015.131.5698.0 | 390024    | 16-2 | 04:20 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.131.5698.0 | 385936    | 16-2 | 04:25 | x86      |
| Msmdlocal.dll                                             | 2015.131.5698.0 | 56246672  | 16-2 | 04:19 | x64      |
| Msmdlocal.dll                                             | 2015.131.5698.0 | 37127264  | 16-2 | 04:27 | x86      |
| Msmgdsrv.dll                                              | 2015.131.5698.0 | 7502736   | 16-2 | 04:20 | x64      |
| Msmgdsrv.dll                                              | 2015.131.5698.0 | 6502288   | 16-2 | 04:29 | x86      |
| Msolap130.dll                                             | 2015.131.5698.0 | 8636304   | 16-2 | 04:19 | x64      |
| Msolap130.dll                                             | 2015.131.5698.0 | 7004048   | 16-2 | 04:26 | x86      |
| Msolui130.dll                                             | 2015.131.5698.0 | 303504    | 16-2 | 04:18 | x64      |
| Msolui130.dll                                             | 2015.131.5698.0 | 280464    | 16-2 | 04:26 | x86      |
| Reportingservicescompression.dll                          | 2015.131.5698.0 | 55904     | 16-2 | 04:18 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.5698.0     | 77712     | 16-2 | 04:20 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.5698.0     | 2536848   | 16-2 | 04:20 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.131.5698.0 | 101776    | 16-2 | 04:20 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.131.5698.0 | 107400    | 16-2 | 04:27 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.131.5698.0 | 92048     | 16-2 | 04:20 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.5698.0     | 2722192   | 16-2 | 04:20 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5698.0     | 877456    | 16-2 | 04:16 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5698.0     | 881760    | 16-2 | 04:22 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5698.0     | 881760    | 16-2 | 04:20 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5698.0     | 881760    | 16-2 | 04:27 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5698.0     | 885856    | 16-2 | 04:23 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5698.0     | 881552    | 16-2 | 04:26 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5698.0     | 881760    | 16-2 | 04:25 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5698.0     | 894048    | 16-2 | 04:23 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5698.0     | 877664    | 16-2 | 04:26 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5698.0     | 881760    | 16-2 | 04:20 | x86      |
| Rshttpruntime.dll                                         | 2015.131.5698.0 | 92560     | 16-2 | 04:20 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.131.5698.0 | 93584     | 16-2 | 04:18 | x64      |
| Sqldumper.exe                                             | 2015.131.5698.0 | 120208    | 16-2 | 04:19 | x64      |
| Sqldumper.exe                                             | 2015.131.5698.0 | 100752    | 16-2 | 04:20 | x86      |
| Sqlrsos.dll                                               | 2015.131.5698.0 | 19344     | 16-2 | 04:09 | x64      |
| Sqlserverspatial130.dll                                   | 2015.131.5698.0 | 725904    | 16-2 | 04:20 | x64      |
| Sqlserverspatial130.dll                                   | 2015.131.5698.0 | 577656    | 16-2 | 04:26 | x86      |
| Xmlrw.dll                                                 | 2015.131.5698.0 | 312208    | 16-2 | 04:20 | x64      |
| Xmlrw.dll                                                 | 2015.131.5698.0 | 252816    | 16-2 | 04:22 | x86      |
| Xmlrwbin.dll                                              | 2015.131.5698.0 | 220560    | 16-2 | 04:20 | x64      |
| Xmlrwbin.dll                                              | 2015.131.5698.0 | 184928    | 16-2 | 04:22 | x86      |
| Xmsrv.dll                                                 | 2015.131.5698.0 | 24040848  | 16-2 | 04:10 | x64      |
| Xmsrv.dll                                                 | 2015.131.5698.0 | 32721296  | 16-2 | 04:25 | x86      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version    | File size | Date | Time | Platform |
|------------------------------------|-----------------|-----------|------|------|----------|
| Smrdll.dll                         | 13.0.5698.0     | 16784     | 16-2 | 04:20 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.131.5698.0 | 93584     | 16-2 | 04:18 | x64      |

SQL Server 2016 sql_tools_extensions

| File name                                      | File version    | File size | Date | Time  | Platform |
|------------------------------------------------|-----------------|-----------|------|-------|----------|
| Autoadmin.dll                                  | 2015.131.5698.0 | 1304976   | 16-2 | 04:20 | x86      |
| Ddsshapes.dll                                  | 2015.131.5698.0 | 129120    | 16-2 | 04:20 | x86      |
| Dtaengine.exe                                  | 2015.131.5698.0 | 160144    | 16-2 | 04:21 | x86      |
| Dteparse.dll                                   | 2015.131.5698.0 | 102792    | 16-2 | 04:19 | x64      |
| Dteparse.dll                                   | 2015.131.5698.0 | 92768     | 16-2 | 04:20 | x86      |
| Dteparsemgd.dll                                | 2015.131.5698.0 | 81808     | 16-2 | 04:22 | x64      |
| Dteparsemgd.dll                                | 2015.131.5698.0 | 76896     | 16-2 | 04:29 | x86      |
| Dtepkg.dll                                     | 2015.131.5698.0 | 130448    | 16-2 | 04:19 | x64      |
| Dtepkg.dll                                     | 2015.131.5698.0 | 109152    | 16-2 | 04:20 | x86      |
| Dtexec.exe                                     | 2015.131.5698.0 | 59792     | 16-2 | 04:20 | x86      |
| Dtexec.exe                                     | 2015.131.5698.0 | 66144     | 16-2 | 04:23 | x64      |
| Dts.dll                                        | 2015.131.5698.0 | 3139984   | 16-2 | 04:19 | x64      |
| Dts.dll                                        | 2015.131.5698.0 | 2625936   | 16-2 | 04:20 | x86      |
| Dtscomexpreval.dll                             | 2015.131.5698.0 | 470416    | 16-2 | 04:19 | x64      |
| Dtscomexpreval.dll                             | 2015.131.5698.0 | 412048    | 16-2 | 04:20 | x86      |
| Dtsconn.dll                                    | 2015.131.5698.0 | 485776    | 16-2 | 04:19 | x64      |
| Dtsconn.dll                                    | 2015.131.5698.0 | 385632    | 16-2 | 04:20 | x86      |
| Dtshost.exe                                    | 2015.131.5698.0 | 69728     | 16-2 | 04:20 | x86      |
| Dtshost.exe                                    | 2015.131.5698.0 | 79760     | 16-2 | 04:22 | x64      |
| Dtslog.dll                                     | 2015.131.5698.0 | 113552    | 16-2 | 04:19 | x64      |
| Dtslog.dll                                     | 2015.131.5698.0 | 96144     | 16-2 | 04:20 | x86      |
| Dtsmsg130.dll                                  | 2015.131.5698.0 | 538512    | 16-2 | 04:19 | x64      |
| Dtsmsg130.dll                                  | 2015.131.5698.0 | 534416    | 16-2 | 04:20 | x86      |
| Dtspipeline.dll                                | 2015.131.5698.0 | 1272208   | 16-2 | 04:19 | x64      |
| Dtspipeline.dll                                | 2015.131.5698.0 | 1052560   | 16-2 | 04:20 | x86      |
| Dtspipelineperf130.dll                         | 2015.131.5698.0 | 41360     | 16-2 | 04:18 | x64      |
| Dtspipelineperf130.dll                         | 2015.131.5698.0 | 35216     | 16-2 | 04:20 | x86      |
| Dtuparse.dll                                   | 2015.131.5698.0 | 80784     | 16-2 | 04:19 | x64      |
| Dtuparse.dll                                   | 2015.131.5698.0 | 73104     | 16-2 | 04:20 | x86      |
| Dtutil.exe                                     | 2015.131.5698.0 | 108432    | 16-2 | 04:20 | x86      |
| Dtutil.exe                                     | 2015.131.5698.0 | 127888    | 16-2 | 04:22 | x64      |
| Exceldest.dll                                  | 2015.131.5698.0 | 256400    | 16-2 | 04:18 | x64      |
| Exceldest.dll                                  | 2015.131.5698.0 | 209808    | 16-2 | 04:20 | x86      |
| Excelsrc.dll                                   | 2015.131.5698.0 | 278416    | 16-2 | 04:19 | x64      |
| Excelsrc.dll                                   | 2015.131.5698.0 | 225888    | 16-2 | 04:20 | x86      |
| Flatfiledest.dll                               | 2015.131.5698.0 | 382344    | 16-2 | 04:18 | x64      |
| Flatfiledest.dll                               | 2015.131.5698.0 | 327568    | 16-2 | 04:20 | x86      |
| Flatfilesrc.dll                                | 2015.131.5698.0 | 394640    | 16-2 | 04:18 | x64      |
| Flatfilesrc.dll                                | 2015.131.5698.0 | 338320    | 16-2 | 04:20 | x86      |
| Foreachfileenumerator.dll                      | 2015.131.5698.0 | 89488     | 16-2 | 04:18 | x64      |
| Foreachfileenumerator.dll                      | 2015.131.5698.0 | 73824     | 16-2 | 04:20 | x86      |
| Microsoft.analysisservices.adomdclientui.dll   | 13.0.5698.0     | 85624     | 16-2 | 04:29 | x86      |
| Microsoft.analysisservices.applocal.core.dll   | 13.0.5698.0     | 1307256   | 16-2 | 04:28 | x86      |
| Microsoft.analysisservices.project.dll         | 2015.131.5698.0 | 2016352   | 16-2 | 04:28 | x86      |
| Microsoft.analysisservices.projectui.dll       | 2015.131.5698.0 | 35216     | 16-2 | 04:21 | x86      |
| Microsoft.sqlserver.astasks.dll                | 13.0.5698.0     | 66656     | 16-2 | 04:22 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5698.0     | 428944    | 16-2 | 04:22 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5698.0     | 429152    | 16-2 | 04:23 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5698.0     | 2037880   | 16-2 | 04:22 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5698.0     | 2037648   | 16-2 | 04:23 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5698.0 | 131984    | 16-2 | 04:21 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5698.0 | 143240    | 16-2 | 04:24 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5698.0 | 137616    | 16-2 | 04:21 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5698.0 | 151952    | 16-2 | 04:24 | x64      |
| Msdtssrvrutil.dll                              | 2015.131.5698.0 | 94608     | 16-2 | 04:18 | x64      |
| Msdtssrvrutil.dll                              | 2015.131.5698.0 | 83344     | 16-2 | 04:26 | x86      |
| Msmdlocal.dll                                  | 2015.131.5698.0 | 56246672  | 16-2 | 04:19 | x64      |
| Msmdlocal.dll                                  | 2015.131.5698.0 | 37127264  | 16-2 | 04:27 | x86      |
| Msmgdsrv.dll                                   | 2015.131.5698.0 | 7502736   | 16-2 | 04:20 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5698.0 | 6502288   | 16-2 | 04:29 | x86      |
| Msolap130.dll                                  | 2015.131.5698.0 | 8636304   | 16-2 | 04:19 | x64      |
| Msolap130.dll                                  | 2015.131.5698.0 | 7004048   | 16-2 | 04:26 | x86      |
| Msolui130.dll                                  | 2015.131.5698.0 | 303504    | 16-2 | 04:18 | x64      |
| Msolui130.dll                                  | 2015.131.5698.0 | 280464    | 16-2 | 04:26 | x86      |
| Oledbdest.dll                                  | 2015.131.5698.0 | 257424    | 16-2 | 04:19 | x64      |
| Oledbdest.dll                                  | 2015.131.5698.0 | 209808    | 16-2 | 04:26 | x86      |
| Oledbsrc.dll                                   | 2015.131.5698.0 | 284048    | 16-2 | 04:18 | x64      |
| Oledbsrc.dll                                   | 2015.131.5698.0 | 228752    | 16-2 | 04:26 | x86      |
| Profiler.exe                                   | 2015.131.5698.0 | 797584    | 16-2 | 04:28 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.131.5698.0 | 93584     | 16-2 | 04:18 | x64      |
| Sqldumper.exe                                  | 2015.131.5698.0 | 120208    | 16-2 | 04:19 | x64      |
| Sqldumper.exe                                  | 2015.131.5698.0 | 100752    | 16-2 | 04:20 | x86      |
| Sqlresld.dll                                   | 2015.131.5698.0 | 23952     | 16-2 | 04:10 | x64      |
| Sqlresld.dll                                   | 2015.131.5698.0 | 22112     | 16-2 | 04:26 | x86      |
| Sqlresourceloader.dll                          | 2015.131.5698.0 | 23952     | 16-2 | 04:10 | x64      |
| Sqlresourceloader.dll                          | 2015.131.5698.0 | 21600     | 16-2 | 04:26 | x86      |
| Sqlscm.dll                                     | 2015.131.5698.0 | 54160     | 16-2 | 04:20 | x64      |
| Sqlscm.dll                                     | 2015.131.5698.0 | 46200     | 16-2 | 04:26 | x86      |
| Sqlsvc.dll                                     | 2015.131.5698.0 | 145296    | 16-2 | 04:10 | x64      |
| Sqlsvc.dll                                     | 2015.131.5698.0 | 120416    | 16-2 | 04:26 | x86      |
| Sqltaskconnections.dll                         | 2015.131.5698.0 | 173968    | 16-2 | 04:09 | x64      |
| Sqltaskconnections.dll                         | 2015.131.5698.0 | 144480    | 16-2 | 04:26 | x86      |
| Txdataconvert.dll                              | 2015.131.5698.0 | 289680    | 16-2 | 04:09 | x64      |
| Txdataconvert.dll                              | 2015.131.5698.0 | 248416    | 16-2 | 04:24 | x86      |
| Xe.dll                                         | 2015.131.5698.0 | 619616    | 16-2 | 04:21 | x64      |
| Xe.dll                                         | 2015.131.5698.0 | 552032    | 16-2 | 04:27 | x86      |
| Xmlrw.dll                                      | 2015.131.5698.0 | 312208    | 16-2 | 04:20 | x64      |
| Xmlrw.dll                                      | 2015.131.5698.0 | 252816    | 16-2 | 04:22 | x86      |
| Xmlrwbin.dll                                   | 2015.131.5698.0 | 220560    | 16-2 | 04:20 | x64      |
| Xmlrwbin.dll                                   | 2015.131.5698.0 | 184928    | 16-2 | 04:22 | x86      |
| Xmsrv.dll                                      | 2015.131.5698.0 | 24040848  | 16-2 | 04:10 | x64      |
| Xmsrv.dll                                      | 2015.131.5698.0 | 32721296  | 16-2 | 04:25 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
