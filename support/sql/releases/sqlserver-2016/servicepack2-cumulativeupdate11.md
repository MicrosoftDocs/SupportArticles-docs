---
title: Cumulative update 11 for SQL Server 2016 SP2 (KB4527378)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP2 cumulative update 11 (KB4527378).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4527378
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Web
---

# KB4527378 - Cumulative Update 11 for SQL Server 2016 SP2

_Release Date:_ &nbsp; December 09, 2019  
_Version:_ &nbsp; 13.0.5598.27

This article describes Cumulative Update package 11 (CU11) (build number: **13.0.5598.27**) for Microsoft SQL Server 2016 Service Pack 2 (SP2). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the initial release of SQL Server 2016 SP2.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|
| <a id=12519855>[12519855](#12519855) </a> | [FIX: Error 41168 occurs when you try to alter DAG SEEDING_MODE in SQL Server 2016 and 2017 (KB4470057)](https://support.microsoft.com/help/4470057)| High Availability|
| <a id=12880798>[12880798](#12880798) </a> | [FIX: Self-deadlock occurs when transaction auditing is enabled in SQL Server 2016 and 2017 (KB4500574)](https://support.microsoft.com/help/4500574)| SQL security |
| <a id=13163646>[13163646](#13163646) </a> | [FIX: Non-yielding scheduler condition occurs if large number of row-column values are processed in row groups in SQL Server 2016 (KB4521599)](https://support.microsoft.com/help/4521599)| SQL Engine |
| <a id=13180659>[13180659](#13180659) </a> | [FIX: MDS and/or LocalDB patch installation fails if you patch SQL Server 2016 with a next CU (KB4524542)](https://support.microsoft.com/help/4524542)| Setup & Install|
| <a id=13211308>[13211308](#13211308) </a> | [FIX: Exception error 3628 may occur when you execute stored procedure in SQL Server 2016 and 2017 (KB4525483)](https://support.microsoft.com/help/4525483) | SQL Engine |
| <a id=13108557>[13108557](#13108557) </a> | [FIX: BorderStyle property of TextBox controls may not be rendered in EXCELOPENXML format in SQL Server 2016 (KB4525612)](https://support.microsoft.com/help/4525612) | Reporting Services |
| <a id=13218541>[13218541](#13218541) </a> | [FIX: Database cannot recover and reports error 5243 in SQL Server 2016 and 2017 (KB4526315)](https://support.microsoft.com/help/4526315) | SQL Engine |
| <a id=13159458>[13159458](#13159458) </a> | [FIX: UPDATE STATISTICS takes very long time to generate maintenance plan for large databases in SQL Server 2016 and 2017 (KB4527229)](https://support.microsoft.com/help/4527229)| Management Tools |
| <a id=13178749>[13178749](#13178749) </a> | [FIX: Synchronized job may fail when the target servers start to synchronize the database in SQL Server 2016 (KB4527355)](https://support.microsoft.com/help/4527355) | Analysis Services|
| <a id=13219010>[13219010](#13219010) </a> | [FIX: You may encounter a non-yielding scheduler condition when you run query with parallel batch-mode sort operator in SQL Server 2016 (KB4527716)](https://support.microsoft.com/help/4527716)| SQL performance|
| <a id=13233701>[13233701](#13233701) </a> | [FIX: DBCC CHECKDB with EXTENDED_LOGICAL_CHECKS fails on a table in SQL Server 2016 (KB4528065)](https://support.microsoft.com/help/4528065)| SQL Engine |
| <a id=13229640>[13229640](#13229640) </a> | [FIX: Unable to restore SQL Server 2012 databases on SQL Server 2016 because of NCCI (KB4528066)](https://support.microsoft.com/help/4528066) | SQL Engine |
| <a id=13229516>[13229516](#13229516) </a> | [FIX: Error 8959 may occur on IAM page when you query sys.dm_db_index_physical_stats against partitioned columnstore table after partition switch in SQL Server (KB4528067)](https://support.microsoft.com/help/4528067)| SQL performance|
| <a id=13207394>[13207394](#13207394) </a> | [FIX: Access violation occurs when you restore the In-Memory Optimized database in SQL Server 2016 and 2017 (KB4528130)](https://support.microsoft.com/help/4528130)| In-Memory OLTP |
| <a id=13112345>[13112345](#13112345) </a> | [FIX: Assertion error occurs when you use IDENT_CURRENT on view that has identity columns in SQL Server 2016 (KB4528250)](https://support.microsoft.com/help/4528250) | In-Memory OLTP |
| <a id=13215464>[13215464](#13215464) </a> | [FIX: Memory may not get released when you process partitions with data in SQL Server 2016 (KB4529876)](https://support.microsoft.com/help/4529876) | Analysis Services|
| <a id=13201027>[13201027](#13201027) </a> | [FIX: Restore fails when you try to restore compressed TDE backups prior to SQL Server 2016 SP2 CU4 on SQL Server 2016 SP2 CU8 (KB4529942)](https://support.microsoft.com/help/4529942) | SQL Engine |
| <a id=13180656>[13180656](#13180656) </a> | [FIX: Access violation occurs when you use sys.dm_os_memory_objects in SQL Server 2016 and 2017 (KB4530212)](https://support.microsoft.com/help/4530212)| SQL performance|
| <a id=13198715>[13198715](#13198715) </a> | [FIX: Error 8601 occurs when you run a query with partition function in SQL Server (KB4530251)](https://support.microsoft.com/help/4530251) | SQL performance|
| <a id=13248516>[13248516](#13248516) </a> | [FIX: Scripts generated by SSMS collect different wait types after you install SQL Server 2016 SP2 CU10 (KB4530259)](https://support.microsoft.com/help/4530259)| SQL Engine |
| <a id=13207875>[13207875](#13207875) </a> | [FIX: Non-yielding scheduler issue occurs in SQL Server 2016 when you run an online build for an index that is not partition-aligned (KB4530443)](https://support.microsoft.com/help/4530443) | SQL performance|
| <a id=13255946>[13255946](#13255946) </a> | [FIX: IsError function fails to detect error in Excel XIRR function when MDX query is executed from SSIS 2016 (KB4530475)](https://support.microsoft.com/help/4530475)| Analysis Services|
| <a id=13261030>[13261030](#13261030) </a> | [FIX: Assertion dump occurs when sp_cdc_disable_db is executed to disable CDC or when distributed transaction is commited after ROLLBACK SAVEPOINT in SQL Server (KB4530500)](https://support.microsoft.com/help/4530500) | SQL Engine |
| <a id=13224868>[13224868](#13224868) </a> | [FIX: "The File location cannot be opened" error occurs when you try to open a FileTable directory in SQL Server (KB4530720)](https://support.microsoft.com/help/4530720) | SQL Engine |
| <a id=13121512>[13121512](#13121512) </a> | [FIX: CREATE INDEX with new CE reads the partition table and results in huge row count higher than the total table row count in SQL Server 2016 (KB4531010)](https://support.microsoft.com/help/4531010) | SQL performance|
| <a id=13202407>[13202407](#13202407) </a> | [FIX: Assertion error occurs when you run getHKTable function to get Hekaton database in SQL Server 2016 (KB4531027)](https://support.microsoft.com/help/4531027) | In-Memory OLTP |

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

| File   name    | File version     | File size | Date      | Time | Platform |
|----------------|------------------|-----------|-----------|------|----------|
| Instapi130.dll | 2015.131.5598.27 | 53568     | 28-Nov-2019 | 04:56 | x86      |
| Keyfile.dll    | 2015.131.5598.27 | 88696     | 28-Nov-2019 | 04:45 | x86      |
| Sqlbrowser.exe | 2015.131.5598.27 | 276800    | 28-Nov-2019 | 04:56 | x86      |
| Sqldumper.exe  | 2015.131.5598.27 | 107840    | 28-Nov-2019 | 04:56 | x86      |

SQL Server 2016 Writer

| File   name           | File version     | File size | Date      | Time | Platform |
|-----------------------|------------------|-----------|-----------|------|----------|
| Instapi130.dll        | 2015.131.5598.27 | 61040     | 28-Nov-2019 | 04:50 | x64      |
| Sqlboot.dll           | 2015.131.5598.27 | 186696    | 28-Nov-2019 | 04:55 | x64      |
| Sqldumper.exe         | 2015.131.5598.27 | 127304    | 28-Nov-2019 | 04:57 | x64      |
| Sqlvdi.dll            | 2015.131.5598.27 | 168776    | 28-Nov-2019 | 04:44 | x86      |
| Sqlvdi.dll            | 2015.131.5598.27 | 197232    | 28-Nov-2019 | 04:50 | x64      |
| Sqlwriter.exe         | 2015.131.5598.27 | 131696    | 28-Nov-2019 | 04:49 | x64      |
| Sqlwriter_keyfile.dll | 2015.131.5598.27 | 100696    | 28-Nov-2019 | 04:59 | x64      |
| Sqlwvss.dll           | 2015.131.5598.27 | 346952    | 28-Nov-2019 | 04:32 | x64      |
| Sqlwvss_xp.dll        | 2015.131.5598.27 | 26224     | 28-Nov-2019 | 04:32 | x64      |

SQL Server 2016 Analysis Services

| File   name                                | File version     | File size | Date      | Time  | Platform |
|--------------------------------------------|------------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.server.core.dll | 13.0.5598.27     | 1348416   | 28-Nov-2019 | 05:04  | x86      |
| Microsoft.applicationinsights.dll          | 2.7.0.13435      | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5598.27     | 990320    | 28-Nov-2019 | 05:06  | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5598.27     | 990328    | 28-Nov-2019 | 04:55  | x86      |
| Msmdctr130.dll                             | 2015.131.5598.27 | 40056     | 28-Nov-2019 | 04:55  | x64      |
| Msmdlocal.dll                              | 2015.131.5598.27 | 56252528  | 28-Nov-2019 | 04:58  | x64      |
| Msmdlocal.dll                              | 2015.131.5598.27 | 37133640  | 28-Nov-2019 | 04:46  | x86      |
| Msmdsrv.exe                                | 2015.131.5598.27 | 56799048  | 28-Nov-2019 | 04:50  | x64      |
| Msmgdsrv.dll                               | 2015.131.5598.27 | 7509848   | 28-Nov-2019 | 04:57  | x64      |
| Msmgdsrv.dll                               | 2015.131.5598.27 | 6509168   | 28-Nov-2019 | 05:08  | x86      |
| Msolap130.dll                              | 2015.131.5598.27 | 7010424   | 28-Nov-2019 | 04:46  | x86      |
| Msolap130.dll                              | 2015.131.5598.27 | 8643192   | 28-Nov-2019 | 04:55  | x64      |
| Msolui130.dll                              | 2015.131.5598.27 | 287352    | 28-Nov-2019 | 04:45  | x86      |
| Msolui130.dll                              | 2015.131.5598.27 | 310384    | 28-Nov-2019 | 04:55  | x64      |
| Sql_as_keyfile.dll                         | 2015.131.5598.27 | 100696    | 28-Nov-2019 | 04:59  | x64      |
| Sqlboot.dll                                | 2015.131.5598.27 | 186696    | 28-Nov-2019 | 04:55  | x64      |
| Sqlceip.exe                                | 13.0.5598.27     | 256328    | 28-Nov-2019 | 04:52  | x86      |
| Sqldumper.exe                              | 2015.131.5598.27 | 127304    | 28-Nov-2019 | 04:57  | x64      |
| Sqldumper.exe                              | 2015.131.5598.27 | 107840    | 28-Nov-2019 | 04:56  | x86      |
| Tmapi.dll                                  | 2015.131.5598.27 | 4346176   | 28-Nov-2019 | 04:32  | x64      |
| Tmcachemgr.dll                             | 2015.131.5598.27 | 2826568   | 28-Nov-2019 | 04:32  | x64      |
| Tmpersistence.dll                          | 2015.131.5598.27 | 1071224   | 28-Nov-2019 | 04:32  | x64      |
| Tmtransactions.dll                         | 2015.131.5598.27 | 1352312   | 28-Nov-2019 | 04:34  | x64      |
| Xe.dll                                     | 2015.131.5598.27 | 626496    | 28-Nov-2019 | 04:51  | x64      |
| Xmlrw.dll                                  | 2015.131.5598.27 | 319304    | 28-Nov-2019 | 04:50  | x64      |
| Xmlrw.dll                                  | 2015.131.5598.27 | 259696    | 28-Nov-2019 | 04:55  | x86      |
| Xmlrwbin.dll                               | 2015.131.5598.27 | 227648    | 28-Nov-2019 | 04:50  | x64      |
| Xmlrwbin.dll                               | 2015.131.5598.27 | 191808    | 28-Nov-2019 | 04:55  | x86      |
| Xmsrv.dll                                  | 2015.131.5598.27 | 32727872  | 28-Nov-2019 | 04:57  | x86      |
| Xmsrv.dll                                  | 2015.131.5598.27 | 24051832  | 28-Nov-2019 | 04:32  | x64      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time | Platform |
|---------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                             | 2015.131.5598.27 | 181056    | 28-Nov-2019 | 04:50 | x64      |
| Batchparser.dll                             | 2015.131.5598.27 | 160576    | 28-Nov-2019 | 04:56 | x86      |
| Instapi130.dll                              | 2015.131.5598.27 | 61040     | 28-Nov-2019 | 04:50 | x64      |
| Instapi130.dll                              | 2015.131.5598.27 | 53568     | 28-Nov-2019 | 04:56 | x86      |
| Isacctchange.dll                            | 2015.131.5598.27 | 30840     | 28-Nov-2019 | 04:58 | x64      |
| Isacctchange.dll                            | 2015.131.5598.27 | 29504     | 28-Nov-2019 | 04:56 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5598.27     | 1027704   | 28-Nov-2019 | 05:04 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5598.27     | 1027696   | 28-Nov-2019 | 05:06 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.5598.27     | 1348952   | 28-Nov-2019 | 05:06 | x86      |
| Microsoft.analysisservices.dll              | 13.0.5598.27     | 702784    | 28-Nov-2019 | 05:06 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.5598.27     | 765560    | 28-Nov-2019 | 05:06 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.5598.27     | 520816    | 28-Nov-2019 | 05:06 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5598.27     | 711792    | 28-Nov-2019 | 05:03 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5598.27     | 711792    | 28-Nov-2019 | 05:06 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5598.27 | 72824     | 28-Nov-2019 | 04:58 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5598.27 | 75592     | 28-Nov-2019 | 05:07 | x64      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5598.27     | 569464    | 28-Nov-2019 | 04:57 | x86      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5598.27     | 569672    | 28-Nov-2019 | 04:57 | x86      |
| Msasxpress.dll                              | 2015.131.5598.27 | 31864     | 28-Nov-2019 | 04:46 | x86      |
| Msasxpress.dll                              | 2015.131.5598.27 | 36160     | 28-Nov-2019 | 04:54 | x64      |
| Pbsvcacctsync.dll                           | 2015.131.5598.27 | 60016     | 28-Nov-2019 | 04:45 | x86      |
| Pbsvcacctsync.dll                           | 2015.131.5598.27 | 72824     | 28-Nov-2019 | 04:55 | x64      |
| Sql_common_core_keyfile.dll                 | 2015.131.5598.27 | 100696    | 28-Nov-2019 | 04:59 | x64      |
| Sqldumper.exe                               | 2015.131.5598.27 | 127304    | 28-Nov-2019 | 04:57 | x64      |
| Sqldumper.exe                               | 2015.131.5598.27 | 107840    | 28-Nov-2019 | 04:56 | x86      |
| Sqlftacct.dll                               | 2015.131.5598.27 | 52040     | 28-Nov-2019 | 04:56 | x64      |
| Sqlftacct.dll                               | 2015.131.5598.27 | 46920     | 28-Nov-2019 | 04:44 | x86      |
| Sqlmgmprovider.dll                          | 2015.131.5598.27 | 406128    | 28-Nov-2019 | 04:32 | x64      |
| Sqlmgmprovider.dll                          | 2015.131.5598.27 | 365896    | 28-Nov-2019 | 04:45 | x86      |
| Sqlsecacctchg.dll                           | 2015.131.5598.27 | 37496     | 28-Nov-2019 | 04:32 | x64      |
| Sqlsecacctchg.dll                           | 2015.131.5598.27 | 35144     | 28-Nov-2019 | 04:44 | x86      |
| Sqltdiagn.dll                               | 2015.131.5598.27 | 67904     | 28-Nov-2019 | 04:32 | x64      |
| Sqltdiagn.dll                               | 2015.131.5598.27 | 60744     | 28-Nov-2019 | 04:44 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version     | File size | Date      | Time | Platform |
|--------------------------------|------------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2015.131.5598.27 | 120952    | 28-Nov-2019 | 04:58 | x86      |
| Dreplaycommon.dll              | 2015.131.5598.27 | 690800    | 28-Nov-2019 | 05:05 | x86      |
| Dreplayutil.dll                | 2015.131.5598.27 | 309872    | 28-Nov-2019 | 04:56 | x86      |
| Instapi130.dll                 | 2015.131.5598.27 | 61040     | 28-Nov-2019 | 04:50 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.131.5598.27 | 100696    | 28-Nov-2019 | 04:59 | x64      |
| Sqlresourceloader.dll          | 2015.131.5598.27 | 28488     | 28-Nov-2019 | 04:44 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version     | File size | Date      | Time | Platform |
|------------------------------------|------------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2015.131.5598.27 | 690800    | 28-Nov-2019 | 05:05 | x86      |
| Dreplaycontroller.exe              | 2015.131.5598.27 | 350320    | 28-Nov-2019 | 04:57 | x86      |
| Dreplayprocess.dll                 | 2015.131.5598.27 | 171840    | 28-Nov-2019 | 04:56 | x86      |
| Instapi130.dll                     | 2015.131.5598.27 | 61040     | 28-Nov-2019 | 04:50 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.131.5598.27 | 100696    | 28-Nov-2019 | 04:59 | x64      |
| Sqlresourceloader.dll              | 2015.131.5598.27 | 28488     | 28-Nov-2019 | 04:44 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------|------------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 13.0.5598.27     | 41080     | 28-Nov-2019 | 04:51  | x64      |
| Batchparser.dll                              | 2015.131.5598.27 | 181056    | 28-Nov-2019 | 04:50  | x64      |
| Datacollectorcontroller.dll                  | 2015.131.5598.27 | 225600    | 28-Nov-2019 | 04:57  | x64      |
| Dcexec.exe                                   | 2015.131.5598.27 | 74360     | 28-Nov-2019 | 04:49  | x64      |
| Fssres.dll                                   | 2015.131.5598.27 | 81736     | 28-Nov-2019 | 04:56  | x64      |
| Hadrres.dll                                  | 2015.131.5598.27 | 177992    | 28-Nov-2019 | 04:50  | x64      |
| Hkcompile.dll                                | 2015.131.5598.27 | 1298032   | 28-Nov-2019 | 04:51  | x64      |
| Hkengine.dll                                 | 2015.131.5598.27 | 5601400   | 28-Nov-2019 | 05:07  | x64      |
| Hkruntime.dll                                | 2015.131.5598.27 | 159040    | 28-Nov-2019 | 05:08  | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435      | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.5598.27     | 234104    | 28-Nov-2019 | 04:53  | x86      |
| Microsoft.sqlserver.types.dll                | 2015.131.5598.27 | 393032    | 28-Nov-2019 | 05:07  | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.131.5598.27 | 72520     | 28-Nov-2019 | 04:57  | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.131.5598.27 | 65352     | 28-Nov-2019 | 05:07  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5598.27 | 150128    | 28-Nov-2019 | 05:07  | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5598.27 | 158840    | 28-Nov-2019 | 05:07  | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.131.5598.27 | 272192    | 28-Nov-2019 | 05:07  | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.131.5598.27 | 74872     | 28-Nov-2019 | 05:07  | x64      |
| Odsole70.dll                                 | 2015.131.5598.27 | 92992     | 28-Nov-2019 | 04:54  | x64      |
| Opends60.dll                                 | 2015.131.5598.27 | 33088     | 28-Nov-2019 | 04:50  | x64      |
| Qds.dll                                      | 2015.131.5598.27 | 873592    | 28-Nov-2019 | 04:55  | x64      |
| Rsfxft.dll                                   | 2015.131.5598.27 | 34416     | 28-Nov-2019 | 04:51  | x64      |
| Sqagtres.dll                                 | 2015.131.5598.27 | 64832     | 28-Nov-2019 | 04:55  | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.131.5598.27 | 100696    | 28-Nov-2019 | 04:59  | x64      |
| Sqlaamss.dll                                 | 2015.131.5598.27 | 80496     | 28-Nov-2019 | 04:56  | x64      |
| Sqlaccess.dll                                | 2015.131.5598.27 | 462968    | 28-Nov-2019 | 05:07  | x64      |
| Sqlagent.exe                                 | 2015.131.5598.27 | 566592    | 28-Nov-2019 | 04:51  | x64      |
| Sqlagentctr130.dll                           | 2015.131.5598.27 | 44360     | 28-Nov-2019 | 04:44  | x86      |
| Sqlagentctr130.dll                           | 2015.131.5598.27 | 52032     | 28-Nov-2019 | 04:54  | x64      |
| Sqlagentlog.dll                              | 2015.131.5598.27 | 33088     | 28-Nov-2019 | 04:54  | x64      |
| Sqlagentmail.dll                             | 2015.131.5598.27 | 47728     | 28-Nov-2019 | 04:55  | x64      |
| Sqlboot.dll                                  | 2015.131.5598.27 | 186696    | 28-Nov-2019 | 04:55  | x64      |
| Sqlceip.exe                                  | 13.0.5598.27     | 256328    | 28-Nov-2019 | 04:52  | x86      |
| Sqlcmdss.dll                                 | 2015.131.5598.27 | 60024     | 28-Nov-2019 | 04:55  | x64      |
| Sqldk.dll                                    | 2015.131.5598.27 | 2589304   | 28-Nov-2019 | 04:55  | x64      |
| Sqldtsss.dll                                 | 2015.131.5598.27 | 97392     | 28-Nov-2019 | 04:57  | x64      |
| Sqliosim.com                                 | 2015.131.5598.27 | 307824    | 28-Nov-2019 | 04:54  | x64      |
| Sqliosim.exe                                 | 2015.131.5598.27 | 3014264   | 28-Nov-2019 | 04:50  | x64      |
| Sqllang.dll                                  | 2015.131.5598.27 | 39539520   | 28-Nov-2019 | 04:57  | x64      |
| Sqlmin.dll                                   | 2015.131.5598.27 | 37942080   | 28-Nov-2019 | 04:35  | x64      |
| Sqlolapss.dll                                | 2015.131.5598.27 | 97904     | 28-Nov-2019 | 04:57  | x64      |
| Sqlos.dll                                    | 2015.131.5598.27 | 26432     | 28-Nov-2019 | 04:50  | x64      |
| Sqlpowershellss.dll                          | 2015.131.5598.27 | 58688     | 28-Nov-2019 | 04:34  | x64      |
| Sqlrepss.dll                                 | 2015.131.5598.27 | 55128     | 28-Nov-2019 | 04:32  | x64      |
| Sqlresld.dll                                 | 2015.131.5598.27 | 30832     | 28-Nov-2019 | 04:32  | x64      |
| Sqlresourceloader.dll                        | 2015.131.5598.27 | 30840     | 28-Nov-2019 | 04:32  | x64      |
| Sqlscm.dll                                   | 2015.131.5598.27 | 61040     | 28-Nov-2019 | 04:50  | x64      |
| Sqlscriptdowngrade.dll                       | 2015.131.5598.27 | 27976     | 28-Nov-2019 | 04:32  | x64      |
| Sqlscriptupgrade.dll                         | 2015.131.5598.27 | 5808752   | 28-Nov-2019 | 04:51  | x64      |
| Sqlserverspatial130.dll                      | 2015.131.5598.27 | 732784    | 28-Nov-2019 | 04:50  | x64      |
| Sqlservr.exe                                 | 2015.131.5598.27 | 393024    | 28-Nov-2019 | 04:52  | x64      |
| Sqlsvc.dll                                   | 2015.131.5598.27 | 152384    | 28-Nov-2019 | 04:34  | x64      |
| Sqltses.dll                                  | 2015.131.5598.27 | 8923256   | 28-Nov-2019 | 04:32  | x64      |
| Sqsrvres.dll                                 | 2015.131.5598.27 | 250992    | 28-Nov-2019 | 04:32  | x64      |
| Xe.dll                                       | 2015.131.5598.27 | 626496    | 28-Nov-2019 | 04:51  | x64      |
| Xmlrw.dll                                    | 2015.131.5598.27 | 319304    | 28-Nov-2019 | 04:50  | x64      |
| Xmlrwbin.dll                                 | 2015.131.5598.27 | 227648    | 28-Nov-2019 | 04:50  | x64      |
| Xpadsi.exe                                   | 2015.131.5598.27 | 79176     | 28-Nov-2019 | 04:51  | x64      |
| Xplog70.dll                                  | 2015.131.5598.27 | 65656     | 28-Nov-2019 | 04:50  | x64      |
| Xpsqlbot.dll                                 | 2015.131.5598.27 | 33600     | 28-Nov-2019 | 04:51  | x64      |
| Xpstar.dll                                   | 2015.131.5598.27 | 422720    | 28-Nov-2019 | 04:50  | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                  | File version     | File size | Date      | Time | Platform |
|----------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                              | 2015.131.5598.27 | 181056    | 28-Nov-2019 | 04:50 | x64      |
| Batchparser.dll                              | 2015.131.5598.27 | 160576    | 28-Nov-2019 | 04:56 | x86      |
| Bcp.exe                                      | 2015.131.5598.27 | 120136    | 28-Nov-2019 | 04:59 | x64      |
| Commanddest.dll                              | 2015.131.5598.27 | 249160    | 28-Nov-2019 | 04:57 | x64      |
| Datacollectorenumerators.dll                 | 2015.131.5598.27 | 116032    | 28-Nov-2019 | 04:56 | x64      |
| Datacollectortasks.dll                       | 2015.131.5598.27 | 188016    | 28-Nov-2019 | 05:00 | x64      |
| Distrib.exe                                  | 2015.131.5598.27 | 191304    | 28-Nov-2019 | 04:50 | x64      |
| Dteparse.dll                                 | 2015.131.5598.27 | 109888    | 28-Nov-2019 | 04:56 | x64      |
| Dteparsemgd.dll                              | 2015.131.5598.27 | 88904     | 28-Nov-2019 | 05:04 | x64      |
| Dtepkg.dll                                   | 2015.131.5598.27 | 137536    | 28-Nov-2019 | 04:57 | x64      |
| Dtexec.exe                                   | 2015.131.5598.27 | 72824     | 28-Nov-2019 | 04:51 | x64      |
| Dts.dll                                      | 2015.131.5598.27 | 3147072   | 28-Nov-2019 | 04:56 | x64      |
| Dtscomexpreval.dll                           | 2015.131.5598.27 | 477528    | 28-Nov-2019 | 04:56 | x64      |
| Dtsconn.dll                                  | 2015.131.5598.27 | 492864    | 28-Nov-2019 | 04:56 | x64      |
| Dtshost.exe                                  | 2015.131.5598.27 | 86848     | 28-Nov-2019 | 04:50 | x64      |
| Dtslog.dll                                   | 2015.131.5598.27 | 120640    | 28-Nov-2019 | 04:57 | x64      |
| Dtsmsg130.dll                                | 2015.131.5598.27 | 545392    | 28-Nov-2019 | 04:57 | x64      |
| Dtspipeline.dll                              | 2015.131.5598.27 | 1279088   | 28-Nov-2019 | 04:57 | x64      |
| Dtspipelineperf130.dll                       | 2015.131.5598.27 | 48248     | 28-Nov-2019 | 04:57 | x64      |
| Dtuparse.dll                                 | 2015.131.5598.27 | 87872     | 28-Nov-2019 | 04:57 | x64      |
| Dtutil.exe                                   | 2015.131.5598.27 | 134976    | 28-Nov-2019 | 04:50 | x64      |
| Exceldest.dll                                | 2015.131.5598.27 | 263496    | 28-Nov-2019 | 04:59 | x64      |
| Excelsrc.dll                                 | 2015.131.5598.27 | 285304    | 28-Nov-2019 | 04:58 | x64      |
| Execpackagetask.dll                          | 2015.131.5598.27 | 166512    | 28-Nov-2019 | 04:58 | x64      |
| Flatfiledest.dll                             | 2015.131.5598.27 | 389232    | 28-Nov-2019 | 04:57 | x64      |
| Flatfilesrc.dll                              | 2015.131.5598.27 | 401528    | 28-Nov-2019 | 04:58 | x64      |
| Foreachfileenumerator.dll                    | 2015.131.5598.27 | 96368     | 28-Nov-2019 | 04:57 | x64      |
| Hkengperfctrs.dll                            | 2015.131.5598.27 | 59208     | 28-Nov-2019 | 04:51 | x64      |
| Logread.exe                                  | 2015.131.5598.27 | 627008    | 28-Nov-2019 | 04:51 | x64      |
| Microsoft.analysisservices.applocal.core.dll | 13.0.5598.27     | 1314112   | 28-Nov-2019 | 05:03 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll | 13.0.5598.27     | 392312    | 28-Nov-2019 | 04:58 | x86      |
| Microsoft.sqlserver.replication.dll          | 2015.131.5598.27 | 1651528   | 28-Nov-2019 | 04:57 | x64      |
| Microsoft.sqlserver.rmo.dll                  | 13.0.5598.27     | 569464    | 28-Nov-2019 | 04:57 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5598.27 | 150128    | 28-Nov-2019 | 05:07 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5598.27 | 158840    | 28-Nov-2019 | 05:07 | x64      |
| Msdtssrvrutil.dll                            | 2015.131.5598.27 | 101488    | 28-Nov-2019 | 04:55 | x64      |
| Msxmlsql.dll                                 | 2015.131.5598.27 | 1494848   | 28-Nov-2019 | 04:51 | x64      |
| Oledbdest.dll                                | 2015.131.5598.27 | 264312    | 28-Nov-2019 | 04:56 | x64      |
| Oledbsrc.dll                                 | 2015.131.5598.27 | 290928    | 28-Nov-2019 | 04:54 | x64      |
| Osql.exe                                     | 2015.131.5598.27 | 75384     | 28-Nov-2019 | 04:58 | x64      |
| Rawdest.dll                                  | 2015.131.5598.27 | 209520    | 28-Nov-2019 | 04:55 | x64      |
| Rawsource.dll                                | 2015.131.5598.27 | 196936    | 28-Nov-2019 | 04:54 | x64      |
| Rdistcom.dll                                 | 2015.131.5598.27 | 907376    | 28-Nov-2019 | 04:55 | x64      |
| Recordsetdest.dll                            | 2015.131.5598.27 | 187000    | 28-Nov-2019 | 04:55 | x64      |
| Repldp.dll                                   | 2015.131.5598.27 | 281944    | 28-Nov-2019 | 04:55 | x64      |
| Replmerg.exe                                 | 2015.131.5598.27 | 518776    | 28-Nov-2019 | 04:50 | x64      |
| Replprov.dll                                 | 2015.131.5598.27 | 812144    | 28-Nov-2019 | 04:55 | x64      |
| Replrec.dll                                  | 2015.131.5598.27 | 1019200   | 28-Nov-2019 | 04:57 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2015.131.5598.27 | 100696    | 28-Nov-2019 | 04:59 | x64      |
| Sqlcmd.exe                                   | 2015.131.5598.27 | 249672    | 28-Nov-2019 | 04:57 | x64      |
| Sqldiag.exe                                  | 2015.131.5598.27 | 1257584   | 28-Nov-2019 | 04:51 | x64      |
| Sqllogship.exe                               | 13.0.5598.27     | 104560    | 28-Nov-2019 | 04:52 | x64      |
| Sqlresld.dll                                 | 2015.131.5598.27 | 30832     | 28-Nov-2019 | 04:32 | x64      |
| Sqlresld.dll                                 | 2015.131.5598.27 | 29000     | 28-Nov-2019 | 04:44 | x86      |
| Sqlresourceloader.dll                        | 2015.131.5598.27 | 30840     | 28-Nov-2019 | 04:32 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5598.27 | 28488     | 28-Nov-2019 | 04:44 | x86      |
| Sqlscm.dll                                   | 2015.131.5598.27 | 53064     | 28-Nov-2019 | 04:44 | x86      |
| Sqlscm.dll                                   | 2015.131.5598.27 | 61040     | 28-Nov-2019 | 04:50 | x64      |
| Sqlsvc.dll                                   | 2015.131.5598.27 | 152384    | 28-Nov-2019 | 04:34 | x64      |
| Sqlsvc.dll                                   | 2015.131.5598.27 | 127096    | 28-Nov-2019 | 04:45 | x86      |
| Sqltaskconnections.dll                       | 2015.131.5598.27 | 180856    | 28-Nov-2019 | 04:32 | x64      |
| Sqlwep130.dll                                | 2015.131.5598.27 | 105792    | 28-Nov-2019 | 04:34 | x64      |
| Ssisoledb.dll                                | 2015.131.5598.27 | 216184    | 28-Nov-2019 | 04:32 | x64      |
| Tablediff.exe                                | 13.0.5598.27     | 86848     | 28-Nov-2019 | 04:52 | x64      |
| Txagg.dll                                    | 2015.131.5598.27 | 364872    | 28-Nov-2019 | 04:32 | x64      |
| Txbdd.dll                                    | 2015.131.5598.27 | 172864    | 28-Nov-2019 | 04:34 | x64      |
| Txdatacollector.dll                          | 2015.131.5598.27 | 367736    | 28-Nov-2019 | 04:33 | x64      |
| Txdataconvert.dll                            | 2015.131.5598.27 | 296776    | 28-Nov-2019 | 04:32 | x64      |
| Txderived.dll                                | 2015.131.5598.27 | 607864    | 28-Nov-2019 | 04:32 | x64      |
| Txlookup.dll                                 | 2015.131.5598.27 | 532320    | 28-Nov-2019 | 04:32 | x64      |
| Txmerge.dll                                  | 2015.131.5598.27 | 230520    | 28-Nov-2019 | 04:32 | x64      |
| Txmergejoin.dll                              | 2015.131.5598.27 | 278648    | 28-Nov-2019 | 04:32 | x64      |
| Txmulticast.dll                              | 2015.131.5598.27 | 128120    | 28-Nov-2019 | 04:32 | x64      |
| Txrowcount.dll                               | 2015.131.5598.27 | 126584    | 28-Nov-2019 | 04:32 | x64      |
| Txsort.dll                                   | 2015.131.5598.27 | 259192    | 28-Nov-2019 | 04:32 | x64      |
| Txsplit.dll                                  | 2015.131.5598.27 | 600696    | 28-Nov-2019 | 04:32 | x64      |
| Txunionall.dll                               | 2015.131.5598.27 | 181880    | 28-Nov-2019 | 04:32 | x64      |
| Xe.dll                                       | 2015.131.5598.27 | 626496    | 28-Nov-2019 | 04:51 | x64      |
| Xmlrw.dll                                    | 2015.131.5598.27 | 319304    | 28-Nov-2019 | 04:50 | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version     | File size | Date      | Time | Platform |
|-------------------------------|------------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2015.131.5598.27 | 1014904   | 28-Nov-2019 | 04:58 | x64      |
| Sql_extensibility_keyfile.dll | 2015.131.5598.27 | 100696    | 28-Nov-2019 | 04:59 | x64      |
| Sqlsatellite.dll              | 2015.131.5598.27 | 837440    | 28-Nov-2019 | 04:51 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version     | File size | Date      | Time | Platform |
|--------------------------|------------------|-----------|-----------|------|----------|
| Fd.dll                   | 2015.131.5598.27 | 660288    | 28-Nov-2019 | 04:51 | x64      |
| Fdhost.exe               | 2015.131.5598.27 | 105072    | 28-Nov-2019 | 04:58 | x64      |
| Fdlauncher.exe           | 2015.131.5598.27 | 51520     | 28-Nov-2019 | 04:57 | x64      |
| Sql_fulltext_keyfile.dll | 2015.131.5598.27 | 100696    | 28-Nov-2019 | 04:59 | x64      |
| Sqlft130ph.dll           | 2015.131.5598.27 | 57968     | 28-Nov-2019 | 04:50 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version     | File size | Date      | Time | Platform |
|-------------------------|------------------|-----------|-----------|------|----------|
| Imrdll.dll              | 13.0.5598.27     | 23664     | 28-Nov-2019 | 05:04 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.131.5598.27 | 100696    | 28-Nov-2019 | 04:59 | x64      |

SQL Server 2016 Integration Services

| File   name                                        | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll              | 4.0.0.111        | 77944     | 27-Nov-2019 | 05:48  | x86      |
| Attunity.sqlserver.cdccontroltask.dll              | 4.0.0.111        | 77944     | 27-Nov-2019 | 11:26 | x86      |
| Attunity.sqlserver.cdcsplit.dll                    | 4.0.0.111        | 37496     | 27-Nov-2019 | 05:48  | x86      |
| Attunity.sqlserver.cdcsplit.dll                    | 4.0.0.111        | 37496     | 27-Nov-2019 | 11:26 | x86      |
| Attunity.sqlserver.cdcsrc.dll                      | 4.0.0.111        | 78456     | 27-Nov-2019 | 05:48  | x86      |
| Attunity.sqlserver.cdcsrc.dll                      | 4.0.0.111        | 78456     | 27-Nov-2019 | 11:26 | x86      |
| Commanddest.dll                                    | 2015.131.5598.27 | 249160    | 28-Nov-2019 | 04:57  | x64      |
| Commanddest.dll                                    | 2015.131.5598.27 | 203072    | 28-Nov-2019 | 04:56  | x86      |
| Dteparse.dll                                       | 2015.131.5598.27 | 109888    | 28-Nov-2019 | 04:56  | x64      |
| Dteparse.dll                                       | 2015.131.5598.27 | 99648     | 28-Nov-2019 | 04:56  | x86      |
| Dteparsemgd.dll                                    | 2015.131.5598.27 | 88904     | 28-Nov-2019 | 05:04  | x64      |
| Dteparsemgd.dll                                    | 2015.131.5598.27 | 83776     | 28-Nov-2019 | 05:06  | x86      |
| Dtepkg.dll                                         | 2015.131.5598.27 | 137536    | 28-Nov-2019 | 04:57  | x64      |
| Dtepkg.dll                                         | 2015.131.5598.27 | 115824    | 28-Nov-2019 | 04:56  | x86      |
| Dtexec.exe                                         | 2015.131.5598.27 | 66888     | 28-Nov-2019 | 04:57  | x86      |
| Dtexec.exe                                         | 2015.131.5598.27 | 72824     | 28-Nov-2019 | 04:51  | x64      |
| Dts.dll                                            | 2015.131.5598.27 | 3147072   | 28-Nov-2019 | 04:56  | x64      |
| Dts.dll                                            | 2015.131.5598.27 | 2633032   | 28-Nov-2019 | 04:58  | x86      |
| Dtscomexpreval.dll                                 | 2015.131.5598.27 | 477528    | 28-Nov-2019 | 04:56  | x64      |
| Dtscomexpreval.dll                                 | 2015.131.5598.27 | 419136    | 28-Nov-2019 | 04:56  | x86      |
| Dtsconn.dll                                        | 2015.131.5598.27 | 492864    | 28-Nov-2019 | 04:56  | x64      |
| Dtsconn.dll                                        | 2015.131.5598.27 | 392512    | 28-Nov-2019 | 04:56  | x86      |
| Dtsdebughost.exe                                   | 2015.131.5598.27 | 94048     | 28-Nov-2019 | 04:57  | x86      |
| Dtsdebughost.exe                                   | 2015.131.5598.27 | 109896    | 28-Nov-2019 | 04:49  | x64      |
| Dtshost.exe                                        | 2015.131.5598.27 | 76608     | 28-Nov-2019 | 04:57  | x86      |
| Dtshost.exe                                        | 2015.131.5598.27 | 86848     | 28-Nov-2019 | 04:50  | x64      |
| Dtslog.dll                                         | 2015.131.5598.27 | 120640    | 28-Nov-2019 | 04:57  | x64      |
| Dtslog.dll                                         | 2015.131.5598.27 | 103232    | 28-Nov-2019 | 04:56  | x86      |
| Dtsmsg130.dll                                      | 2015.131.5598.27 | 545392    | 28-Nov-2019 | 04:57  | x64      |
| Dtsmsg130.dll                                      | 2015.131.5598.27 | 541304    | 28-Nov-2019 | 04:56  | x86      |
| Dtspipeline.dll                                    | 2015.131.5598.27 | 1279088   | 28-Nov-2019 | 04:57  | x64      |
| Dtspipeline.dll                                    | 2015.131.5598.27 | 1059672   | 28-Nov-2019 | 04:56  | x86      |
| Dtspipelineperf130.dll                             | 2015.131.5598.27 | 48248     | 28-Nov-2019 | 04:57  | x64      |
| Dtspipelineperf130.dll                             | 2015.131.5598.27 | 42096     | 28-Nov-2019 | 04:56  | x86      |
| Dtuparse.dll                                       | 2015.131.5598.27 | 87872     | 28-Nov-2019 | 04:57  | x64      |
| Dtuparse.dll                                       | 2015.131.5598.27 | 80192     | 28-Nov-2019 | 04:56  | x86      |
| Dtutil.exe                                         | 2015.131.5598.27 | 115528    | 28-Nov-2019 | 04:57  | x86      |
| Dtutil.exe                                         | 2015.131.5598.27 | 134976    | 28-Nov-2019 | 04:50  | x64      |
| Exceldest.dll                                      | 2015.131.5598.27 | 263496    | 28-Nov-2019 | 04:59  | x64      |
| Exceldest.dll                                      | 2015.131.5598.27 | 216688    | 28-Nov-2019 | 04:56  | x86      |
| Excelsrc.dll                                       | 2015.131.5598.27 | 285304    | 28-Nov-2019 | 04:58  | x64      |
| Excelsrc.dll                                       | 2015.131.5598.27 | 232560    | 28-Nov-2019 | 04:56  | x86      |
| Execpackagetask.dll                                | 2015.131.5598.27 | 166512    | 28-Nov-2019 | 04:58  | x64      |
| Execpackagetask.dll                                | 2015.131.5598.27 | 135488    | 28-Nov-2019 | 04:56  | x86      |
| Flatfiledest.dll                                   | 2015.131.5598.27 | 389232    | 28-Nov-2019 | 04:57  | x64      |
| Flatfiledest.dll                                   | 2015.131.5598.27 | 334656    | 28-Nov-2019 | 04:56  | x86      |
| Flatfilesrc.dll                                    | 2015.131.5598.27 | 401528    | 28-Nov-2019 | 04:58  | x64      |
| Flatfilesrc.dll                                    | 2015.131.5598.27 | 345408    | 28-Nov-2019 | 04:59  | x86      |
| Foreachfileenumerator.dll                          | 2015.131.5598.27 | 96368     | 28-Nov-2019 | 04:57  | x64      |
| Foreachfileenumerator.dll                          | 2015.131.5598.27 | 80704     | 28-Nov-2019 | 04:56  | x86      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5598.27     | 1314112   | 28-Nov-2019 | 05:03  | x86      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5598.27     | 1313904   | 28-Nov-2019 | 05:06  | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435      | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.sqlserver.astasks.dll                    | 13.0.5598.27     | 73336     | 28-Nov-2019 | 04:53  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5598.27 | 107128    | 28-Nov-2019 | 04:55  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5598.27 | 112480    | 28-Nov-2019 | 04:56  | x64      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5598.27     | 82544     | 27-Nov-2019 | 18:48 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5598.27     | 82544     | 28-Nov-2019 | 04:57  | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll       | 13.0.5598.27     | 392312    | 28-Nov-2019 | 04:58  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5598.27 | 150128    | 28-Nov-2019 | 05:07  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5598.27 | 138864    | 28-Nov-2019 | 04:53  | x86      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5598.27 | 158840    | 28-Nov-2019 | 05:07  | x64      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5598.27 | 144712    | 28-Nov-2019 | 04:52  | x86      |
| Msdtssrvr.exe                                      | 13.0.5598.27     | 216696    | 28-Nov-2019 | 04:52  | x64      |
| Msdtssrvrutil.dll                                  | 2015.131.5598.27 | 90232     | 28-Nov-2019 | 04:45  | x86      |
| Msdtssrvrutil.dll                                  | 2015.131.5598.27 | 101488    | 28-Nov-2019 | 04:55  | x64      |
| Oledbdest.dll                                      | 2015.131.5598.27 | 216696    | 28-Nov-2019 | 04:45  | x86      |
| Oledbdest.dll                                      | 2015.131.5598.27 | 264312    | 28-Nov-2019 | 04:56  | x64      |
| Oledbsrc.dll                                       | 2015.131.5598.27 | 235640    | 28-Nov-2019 | 04:45  | x86      |
| Oledbsrc.dll                                       | 2015.131.5598.27 | 290928    | 28-Nov-2019 | 04:54  | x64      |
| Rawdest.dll                                        | 2015.131.5598.27 | 168568    | 28-Nov-2019 | 04:45  | x86      |
| Rawdest.dll                                        | 2015.131.5598.27 | 209520    | 28-Nov-2019 | 04:55  | x64      |
| Rawsource.dll                                      | 2015.131.5598.27 | 155464    | 28-Nov-2019 | 04:49  | x86      |
| Rawsource.dll                                      | 2015.131.5598.27 | 196936    | 28-Nov-2019 | 04:54  | x64      |
| Recordsetdest.dll                                  | 2015.131.5598.27 | 151880    | 28-Nov-2019 | 04:45  | x86      |
| Recordsetdest.dll                                  | 2015.131.5598.27 | 187000    | 28-Nov-2019 | 04:55  | x64      |
| Sql_is_keyfile.dll                                 | 2015.131.5598.27 | 100696    | 28-Nov-2019 | 04:59  | x64      |
| Sqlceip.exe                                        | 13.0.5598.27     | 256328    | 28-Nov-2019 | 04:52  | x86      |
| Sqldest.dll                                        | 2015.131.5598.27 | 215872    | 28-Nov-2019 | 04:44  | x86      |
| Sqldest.dll                                        | 2015.131.5598.27 | 263800    | 28-Nov-2019 | 04:56  | x64      |
| Sqltaskconnections.dll                             | 2015.131.5598.27 | 180856    | 28-Nov-2019 | 04:32  | x64      |
| Sqltaskconnections.dll                             | 2015.131.5598.27 | 151368    | 28-Nov-2019 | 04:44  | x86      |
| Ssisoledb.dll                                      | 2015.131.5598.27 | 216184    | 28-Nov-2019 | 04:32  | x64      |
| Ssisoledb.dll                                      | 2015.131.5598.27 | 176760    | 28-Nov-2019 | 04:45  | x86      |
| Txagg.dll                                          | 2015.131.5598.27 | 304960    | 28-Nov-2019 | 04:57  | x86      |
| Txagg.dll                                          | 2015.131.5598.27 | 364872    | 28-Nov-2019 | 04:32  | x64      |
| Txbdd.dll                                          | 2015.131.5598.27 | 138056    | 28-Nov-2019 | 04:56  | x86      |
| Txbdd.dll                                          | 2015.131.5598.27 | 172864    | 28-Nov-2019 | 04:34  | x64      |
| Txbestmatch.dll                                    | 2015.131.5598.27 | 611656    | 28-Nov-2019 | 04:32  | x64      |
| Txbestmatch.dll                                    | 2015.131.5598.27 | 496240    | 28-Nov-2019 | 04:56  | x86      |
| Txcache.dll                                        | 2015.131.5598.27 | 148288    | 28-Nov-2019 | 04:57  | x86      |
| Txcache.dll                                        | 2015.131.5598.27 | 183416    | 28-Nov-2019 | 04:32  | x64      |
| Txcharmap.dll                                      | 2015.131.5598.27 | 250480    | 28-Nov-2019 | 04:57  | x86      |
| Txcharmap.dll                                      | 2015.131.5598.27 | 289912    | 28-Nov-2019 | 04:32  | x64      |
| Txcopymap.dll                                      | 2015.131.5598.27 | 147776    | 28-Nov-2019 | 04:57  | x86      |
| Txcopymap.dll                                      | 2015.131.5598.27 | 182904    | 28-Nov-2019 | 04:32  | x64      |
| Txdataconvert.dll                                  | 2015.131.5598.27 | 255296    | 28-Nov-2019 | 04:57  | x86      |
| Txdataconvert.dll                                  | 2015.131.5598.27 | 296776    | 28-Nov-2019 | 04:32  | x64      |
| Txderived.dll                                      | 2015.131.5598.27 | 519488    | 28-Nov-2019 | 04:57  | x86      |
| Txderived.dll                                      | 2015.131.5598.27 | 607864    | 28-Nov-2019 | 04:32  | x64      |
| Txfileextractor.dll                                | 2015.131.5598.27 | 163160    | 28-Nov-2019 | 04:56  | x86      |
| Txfileextractor.dll                                | 2015.131.5598.27 | 201840    | 28-Nov-2019 | 04:32  | x64      |
| Txfileinserter.dll                                 | 2015.131.5598.27 | 161112    | 28-Nov-2019 | 04:57  | x86      |
| Txfileinserter.dll                                 | 2015.131.5598.27 | 200008    | 28-Nov-2019 | 04:32  | x64      |
| Txgroupdups.dll                                    | 2015.131.5598.27 | 231744    | 28-Nov-2019 | 04:56  | x86      |
| Txgroupdups.dll                                    | 2015.131.5598.27 | 290936    | 28-Nov-2019 | 04:32  | x64      |
| Txlineage.dll                                      | 2015.131.5598.27 | 109680    | 28-Nov-2019 | 04:56  | x86      |
| Txlineage.dll                                      | 2015.131.5598.27 | 137848    | 28-Nov-2019 | 04:32  | x64      |
| Txlookup.dll                                       | 2015.131.5598.27 | 532320    | 28-Nov-2019 | 04:32  | x64      |
| Txlookup.dll                                       | 2015.131.5598.27 | 449856    | 28-Nov-2019 | 04:56  | x86      |
| Txmerge.dll                                        | 2015.131.5598.27 | 176752    | 28-Nov-2019 | 04:57  | x86      |
| Txmerge.dll                                        | 2015.131.5598.27 | 230520    | 28-Nov-2019 | 04:32  | x64      |
| Txmergejoin.dll                                    | 2015.131.5598.27 | 223864    | 28-Nov-2019 | 04:59  | x86      |
| Txmergejoin.dll                                    | 2015.131.5598.27 | 278648    | 28-Nov-2019 | 04:32  | x64      |
| Txmulticast.dll                                    | 2015.131.5598.27 | 128120    | 28-Nov-2019 | 04:32  | x64      |
| Txmulticast.dll                                    | 2015.131.5598.27 | 102000    | 28-Nov-2019 | 04:55  | x86      |
| Txpivot.dll                                        | 2015.131.5598.27 | 182080    | 28-Nov-2019 | 04:57  | x86      |
| Txpivot.dll                                        | 2015.131.5598.27 | 227960    | 28-Nov-2019 | 04:32  | x64      |
| Txrowcount.dll                                     | 2015.131.5598.27 | 126584    | 28-Nov-2019 | 04:32  | x64      |
| Txrowcount.dll                                     | 2015.131.5598.27 | 101704    | 28-Nov-2019 | 04:55  | x86      |
| Txsampling.dll                                     | 2015.131.5598.27 | 172360    | 28-Nov-2019 | 04:32  | x64      |
| Txsampling.dll                                     | 2015.131.5598.27 | 134768    | 28-Nov-2019 | 04:56  | x86      |
| Txscd.dll                                          | 2015.131.5598.27 | 220280    | 28-Nov-2019 | 04:32  | x64      |
| Txscd.dll                                          | 2015.131.5598.27 | 169584    | 28-Nov-2019 | 04:55  | x86      |
| Txsort.dll                                         | 2015.131.5598.27 | 211272    | 28-Nov-2019 | 04:56  | x86      |
| Txsort.dll                                         | 2015.131.5598.27 | 259192    | 28-Nov-2019 | 04:32  | x64      |
| Txsplit.dll                                        | 2015.131.5598.27 | 600696    | 28-Nov-2019 | 04:32  | x64      |
| Txsplit.dll                                        | 2015.131.5598.27 | 513136    | 28-Nov-2019 | 04:55  | x86      |
| Txtermextraction.dll                               | 2015.131.5598.27 | 8615536   | 28-Nov-2019 | 04:56  | x86      |
| Txtermextraction.dll                               | 2015.131.5598.27 | 8678000   | 28-Nov-2019 | 04:32  | x64      |
| Txtermlookup.dll                                   | 2015.131.5598.27 | 4106864   | 28-Nov-2019 | 04:57  | x86      |
| Txtermlookup.dll                                   | 2015.131.5598.27 | 4158784   | 28-Nov-2019 | 04:34  | x64      |
| Txunionall.dll                                     | 2015.131.5598.27 | 181880    | 28-Nov-2019 | 04:32  | x64      |
| Txunionall.dll                                     | 2015.131.5598.27 | 138864    | 28-Nov-2019 | 04:55  | x86      |
| Txunpivot.dll                                      | 2015.131.5598.27 | 201848    | 28-Nov-2019 | 04:32  | x64      |
| Txunpivot.dll                                      | 2015.131.5598.27 | 162624    | 28-Nov-2019 | 04:55  | x86      |
| Xe.dll                                             | 2015.131.5598.27 | 558704    | 28-Nov-2019 | 05:01  | x86      |
| Xe.dll                                             | 2015.131.5598.27 | 626496    | 28-Nov-2019 | 04:51  | x64      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Dms.dll                                                              | 10.0.8224.49     | 483624    | 09-May-2019  | 19:33 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.49 | 75560     | 09-May-2019  | 19:33 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.49     | 45864     | 09-May-2019  | 19:33 | x86      |
| Instapi130.dll                                                       | 2015.131.5598.27 | 61048     | 28-Nov-2019 | 04:32  | x64      |
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
| Mpdwinterop.dll                                                      | 2015.131.5598.27 | 395080    | 28-Nov-2019 | 05:01  | x64      |
| Mpdwsvc.exe                                                          | 2015.131.5598.27 | 6618976   | 28-Nov-2019 | 04:52  | x64      |
| Pdwodbcsql11.dll                                                     | 2015.131.5598.27 | 2230088   | 28-Nov-2019 | 04:32  | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.49 | 47400     | 09-May-2019  | 19:33 | x64      |
| Sqldk.dll                                                            | 2015.131.5598.27 | 2533216   | 28-Nov-2019 | 04:32  | x64      |
| Sqldumper.exe                                                        | 2015.131.5598.27 | 127304    | 28-Nov-2019 | 04:51  | x64      |
| Sqlos.dll                                                            | 2015.131.5598.27 | 26232     | 28-Nov-2019 | 04:33  | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.49 | 4348200   | 09-May-2019  | 19:33 | x64      |
| Sqltses.dll                                                          | 2015.131.5598.27 | 9092720   | 28-Nov-2019 | 04:32  | x64      |

SQL Server 2016 Reporting Services

| File   name                                               | File version     | File size | Date      | Time | Platform |
|-----------------------------------------------------------|------------------|-----------|-----------|------|----------|
| Microsoft.analysisservices.modeling.dll                   | 13.0.5598.27     | 611144    | 28-Nov-2019 | 05:04 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.5598.27     | 1620296   | 28-Nov-2019 | 05:04 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.5598.27     | 658552    | 28-Nov-2019 | 05:06 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.5598.27     | 329840    | 28-Nov-2019 | 05:05 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.5598.27     | 1090888   | 28-Nov-2019 | 05:04 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5598.27     | 548672    | 28-Nov-2019 | 04:48 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5598.27     | 548464    | 28-Nov-2019 | 04:59 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5598.27     | 548680    | 28-Nov-2019 | 04:51 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5598.27     | 548464    | 28-Nov-2019 | 05:11 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5598.27     | 548680    | 28-Nov-2019 | 04:52 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5598.27     | 548672    | 28-Nov-2019 | 05:06 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5598.27     | 548464    | 28-Nov-2019 | 05:00 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5598.27     | 548680    | 28-Nov-2019 | 04:55 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5598.27     | 548672    | 28-Nov-2019 | 04:55 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5598.27     | 548672    | 28-Nov-2019 | 05:07 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.5598.27     | 162928    | 28-Nov-2019 | 05:04 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.5598.27     | 126280    | 28-Nov-2019 | 04:54 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.5598.27     | 6076736   | 28-Nov-2019 | 04:56 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5598.27     | 4511560   | 28-Nov-2019 | 04:49 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5598.27     | 4511864   | 28-Nov-2019 | 04:58 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5598.27     | 4511864   | 28-Nov-2019 | 04:52 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5598.27     | 4512064   | 28-Nov-2019 | 05:10 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5598.27     | 4512376   | 28-Nov-2019 | 04:51 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5598.27     | 4512368   | 28-Nov-2019 | 05:06 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5598.27     | 4511856   | 28-Nov-2019 | 05:00 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5598.27     | 4513096   | 28-Nov-2019 | 04:56 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5598.27     | 4511344   | 28-Nov-2019 | 04:55 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5598.27     | 4511856   | 28-Nov-2019 | 05:06 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.5598.27     | 10894152  | 28-Nov-2019 | 04:54 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.5598.27     | 100984    | 28-Nov-2019 | 04:53 | x64      |
| Microsoft.reportingservices.storage.dll                   | 13.0.5598.27     | 208712    | 28-Nov-2019 | 04:54 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.131.5598.27 | 47936     | 28-Nov-2019 | 04:56 | x64      |
| Microsoft.sqlserver.types.dll                             | 2015.131.5598.27 | 393032    | 28-Nov-2019 | 05:07 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.131.5598.27 | 397152    | 28-Nov-2019 | 04:50 | x86      |
| Msmdlocal.dll                                             | 2015.131.5598.27 | 56252528  | 28-Nov-2019 | 04:58 | x64      |
| Msmdlocal.dll                                             | 2015.131.5598.27 | 37133640  | 28-Nov-2019 | 04:46 | x86      |
| Msmgdsrv.dll                                              | 2015.131.5598.27 | 7509848   | 28-Nov-2019 | 04:57 | x64      |
| Msmgdsrv.dll                                              | 2015.131.5598.27 | 6509168   | 28-Nov-2019 | 05:08 | x86      |
| Msolap130.dll                                             | 2015.131.5598.27 | 7010424   | 28-Nov-2019 | 04:46 | x86      |
| Msolap130.dll                                             | 2015.131.5598.27 | 8643192   | 28-Nov-2019 | 04:55 | x64      |
| Msolui130.dll                                             | 2015.131.5598.27 | 287352    | 28-Nov-2019 | 04:45 | x86      |
| Msolui130.dll                                             | 2015.131.5598.27 | 310384    | 28-Nov-2019 | 04:55 | x64      |
| Reportingservicescompression.dll                          | 2015.131.5598.27 | 62784     | 28-Nov-2019 | 04:54 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.5598.27     | 84592     | 28-Nov-2019 | 04:58 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.5598.27     | 2543736   | 28-Nov-2019 | 04:58 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.131.5598.27 | 108864    | 28-Nov-2019 | 04:56 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.131.5598.27 | 114288    | 28-Nov-2019 | 05:08 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.131.5598.27 | 98928     | 28-Nov-2019 | 04:56 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.5598.27     | 2728768   | 28-Nov-2019 | 04:57 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5598.27     | 884336    | 28-Nov-2019 | 05:00 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5598.27     | 888440    | 28-Nov-2019 | 04:51 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5598.27     | 888432    | 28-Nov-2019 | 05:04 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5598.27     | 888648    | 28-Nov-2019 | 04:59 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5598.27     | 892760    | 28-Nov-2019 | 05:04 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5598.27     | 888640    | 28-Nov-2019 | 05:04 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5598.27     | 888432    | 28-Nov-2019 | 04:58 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5598.27     | 900720    | 28-Nov-2019 | 04:52 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5598.27     | 884544    | 28-Nov-2019 | 05:09 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5598.27     | 888432    | 28-Nov-2019 | 04:57 | x86      |
| Rshttpruntime.dll                                         | 2015.131.5598.27 | 99648     | 28-Nov-2019 | 04:57 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.131.5598.27 | 100696    | 28-Nov-2019 | 04:59 | x64      |
| Sqldumper.exe                                             | 2015.131.5598.27 | 127304    | 28-Nov-2019 | 04:57 | x64      |
| Sqldumper.exe                                             | 2015.131.5598.27 | 107840    | 28-Nov-2019 | 04:56 | x86      |
| Sqlrsos.dll                                               | 2015.131.5598.27 | 26432     | 28-Nov-2019 | 04:34 | x64      |
| Sqlserverspatial130.dll                                   | 2015.131.5598.27 | 584512    | 28-Nov-2019 | 04:45 | x86      |
| Sqlserverspatial130.dll                                   | 2015.131.5598.27 | 732784    | 28-Nov-2019 | 04:50 | x64      |
| Xmlrw.dll                                                 | 2015.131.5598.27 | 319304    | 28-Nov-2019 | 04:50 | x64      |
| Xmlrw.dll                                                 | 2015.131.5598.27 | 259696    | 28-Nov-2019 | 04:55 | x86      |
| Xmlrwbin.dll                                              | 2015.131.5598.27 | 227648    | 28-Nov-2019 | 04:50 | x64      |
| Xmlrwbin.dll                                              | 2015.131.5598.27 | 191808    | 28-Nov-2019 | 04:55 | x86      |
| Xmsrv.dll                                                 | 2015.131.5598.27 | 32727872  | 28-Nov-2019 | 04:57 | x86      |
| Xmsrv.dll                                                 | 2015.131.5598.27 | 24051832  | 28-Nov-2019 | 04:32 | x64      |

SQL Server 2016 sql_shared_mr

| File name                          | File version     | File size | Date        | Time  | Platform |
|------------------------------------|------------------|-----------|-------------|-------|----------|
| Smrdll.dll                         | 13.0.5598.27     | 23664     | 28-Nov-2019 | 04:57 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.131.5598.27 | 100696    | 28-Nov-2019 | 04:59 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                    | File version     | File size | Date      | Time | Platform |
|------------------------------------------------|------------------|-----------|-----------|------|----------|
| Autoadmin.dll                                  | 2015.131.5598.27 | 1312064   | 28-Nov-2019 | 04:56 | x86      |
| Ddsshapes.dll                                  | 2015.131.5598.27 | 135792    | 28-Nov-2019 | 04:56 | x86      |
| Dtaengine.exe                                  | 2015.131.5598.27 | 167032    | 28-Nov-2019 | 04:58 | x86      |
| Dteparse.dll                                   | 2015.131.5598.27 | 109888    | 28-Nov-2019 | 04:56 | x64      |
| Dteparse.dll                                   | 2015.131.5598.27 | 99648     | 28-Nov-2019 | 04:56 | x86      |
| Dteparsemgd.dll                                | 2015.131.5598.27 | 88904     | 28-Nov-2019 | 05:04 | x64      |
| Dteparsemgd.dll                                | 2015.131.5598.27 | 83776     | 28-Nov-2019 | 05:06 | x86      |
| Dtepkg.dll                                     | 2015.131.5598.27 | 137536    | 28-Nov-2019 | 04:57 | x64      |
| Dtepkg.dll                                     | 2015.131.5598.27 | 115824    | 28-Nov-2019 | 04:56 | x86      |
| Dtexec.exe                                     | 2015.131.5598.27 | 66888     | 28-Nov-2019 | 04:57 | x86      |
| Dtexec.exe                                     | 2015.131.5598.27 | 72824     | 28-Nov-2019 | 04:51 | x64      |
| Dts.dll                                        | 2015.131.5598.27 | 3147072   | 28-Nov-2019 | 04:56 | x64      |
| Dts.dll                                        | 2015.131.5598.27 | 2633032   | 28-Nov-2019 | 04:58 | x86      |
| Dtscomexpreval.dll                             | 2015.131.5598.27 | 477528    | 28-Nov-2019 | 04:56 | x64      |
| Dtscomexpreval.dll                             | 2015.131.5598.27 | 419136    | 28-Nov-2019 | 04:56 | x86      |
| Dtsconn.dll                                    | 2015.131.5598.27 | 492864    | 28-Nov-2019 | 04:56 | x64      |
| Dtsconn.dll                                    | 2015.131.5598.27 | 392512    | 28-Nov-2019 | 04:56 | x86      |
| Dtshost.exe                                    | 2015.131.5598.27 | 76608     | 28-Nov-2019 | 04:57 | x86      |
| Dtshost.exe                                    | 2015.131.5598.27 | 86848     | 28-Nov-2019 | 04:50 | x64      |
| Dtslog.dll                                     | 2015.131.5598.27 | 120640    | 28-Nov-2019 | 04:57 | x64      |
| Dtslog.dll                                     | 2015.131.5598.27 | 103232    | 28-Nov-2019 | 04:56 | x86      |
| Dtsmsg130.dll                                  | 2015.131.5598.27 | 545392    | 28-Nov-2019 | 04:57 | x64      |
| Dtsmsg130.dll                                  | 2015.131.5598.27 | 541304    | 28-Nov-2019 | 04:56 | x86      |
| Dtspipeline.dll                                | 2015.131.5598.27 | 1279088   | 28-Nov-2019 | 04:57 | x64      |
| Dtspipeline.dll                                | 2015.131.5598.27 | 1059672   | 28-Nov-2019 | 04:56 | x86      |
| Dtspipelineperf130.dll                         | 2015.131.5598.27 | 48248     | 28-Nov-2019 | 04:57 | x64      |
| Dtspipelineperf130.dll                         | 2015.131.5598.27 | 42096     | 28-Nov-2019 | 04:56 | x86      |
| Dtuparse.dll                                   | 2015.131.5598.27 | 87872     | 28-Nov-2019 | 04:57 | x64      |
| Dtuparse.dll                                   | 2015.131.5598.27 | 80192     | 28-Nov-2019 | 04:56 | x86      |
| Dtutil.exe                                     | 2015.131.5598.27 | 115528    | 28-Nov-2019 | 04:57 | x86      |
| Dtutil.exe                                     | 2015.131.5598.27 | 134976    | 28-Nov-2019 | 04:50 | x64      |
| Exceldest.dll                                  | 2015.131.5598.27 | 263496    | 28-Nov-2019 | 04:59 | x64      |
| Exceldest.dll                                  | 2015.131.5598.27 | 216688    | 28-Nov-2019 | 04:56 | x86      |
| Excelsrc.dll                                   | 2015.131.5598.27 | 285304    | 28-Nov-2019 | 04:58 | x64      |
| Excelsrc.dll                                   | 2015.131.5598.27 | 232560    | 28-Nov-2019 | 04:56 | x86      |
| Flatfiledest.dll                               | 2015.131.5598.27 | 389232    | 28-Nov-2019 | 04:57 | x64      |
| Flatfiledest.dll                               | 2015.131.5598.27 | 334656    | 28-Nov-2019 | 04:56 | x86      |
| Flatfilesrc.dll                                | 2015.131.5598.27 | 401528    | 28-Nov-2019 | 04:58 | x64      |
| Flatfilesrc.dll                                | 2015.131.5598.27 | 345408    | 28-Nov-2019 | 04:59 | x86      |
| Foreachfileenumerator.dll                      | 2015.131.5598.27 | 96368     | 28-Nov-2019 | 04:57 | x64      |
| Foreachfileenumerator.dll                      | 2015.131.5598.27 | 80704     | 28-Nov-2019 | 04:56 | x86      |
| Microsoft.analysisservices.adomdclientui.dll   | 13.0.5598.27     | 92480     | 28-Nov-2019 | 05:06 | x86      |
| Microsoft.analysisservices.applocal.core.dll   | 13.0.5598.27     | 1313904   | 28-Nov-2019 | 05:06 | x86      |
| Microsoft.analysisservices.project.dll         | 2015.131.5598.27 | 2023232   | 28-Nov-2019 | 05:06 | x86      |
| Microsoft.analysisservices.projectui.dll       | 2015.131.5598.27 | 42304     | 28-Nov-2019 | 04:56 | x86      |
| Microsoft.sqlserver.astasks.dll                | 13.0.5598.27     | 73336     | 28-Nov-2019 | 04:55 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5598.27     | 436056    | 28-Nov-2019 | 04:53 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5598.27     | 436040    | 28-Nov-2019 | 04:55 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5598.27     | 2044528   | 28-Nov-2019 | 04:53 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5598.27     | 2044528   | 28-Nov-2019 | 04:54 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5598.27 | 150128    | 28-Nov-2019 | 05:07 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5598.27 | 138864    | 28-Nov-2019 | 04:53 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5598.27 | 158840    | 28-Nov-2019 | 05:07 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5598.27 | 144712    | 28-Nov-2019 | 04:52 | x86      |
| Msdtssrvrutil.dll                              | 2015.131.5598.27 | 90232     | 28-Nov-2019 | 04:45 | x86      |
| Msdtssrvrutil.dll                              | 2015.131.5598.27 | 101488    | 28-Nov-2019 | 04:55 | x64      |
| Msmdlocal.dll                                  | 2015.131.5598.27 | 56252528  | 28-Nov-2019 | 04:58 | x64      |
| Msmdlocal.dll                                  | 2015.131.5598.27 | 37133640  | 28-Nov-2019 | 04:46 | x86      |
| Msmgdsrv.dll                                   | 2015.131.5598.27 | 7509848   | 28-Nov-2019 | 04:57 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5598.27 | 6509168   | 28-Nov-2019 | 05:08 | x86      |
| Msolap130.dll                                  | 2015.131.5598.27 | 7010424   | 28-Nov-2019 | 04:46 | x86      |
| Msolap130.dll                                  | 2015.131.5598.27 | 8643192   | 28-Nov-2019 | 04:55 | x64      |
| Msolui130.dll                                  | 2015.131.5598.27 | 287352    | 28-Nov-2019 | 04:45 | x86      |
| Msolui130.dll                                  | 2015.131.5598.27 | 310384    | 28-Nov-2019 | 04:55 | x64      |
| Oledbdest.dll                                  | 2015.131.5598.27 | 216696    | 28-Nov-2019 | 04:45 | x86      |
| Oledbdest.dll                                  | 2015.131.5598.27 | 264312    | 28-Nov-2019 | 04:56 | x64      |
| Oledbsrc.dll                                   | 2015.131.5598.27 | 235640    | 28-Nov-2019 | 04:45 | x86      |
| Oledbsrc.dll                                   | 2015.131.5598.27 | 290928    | 28-Nov-2019 | 04:54 | x64      |
| Profiler.exe                                   | 2015.131.5598.27 | 804472    | 28-Nov-2019 | 05:06 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.131.5598.27 | 100696    | 28-Nov-2019 | 04:59 | x64      |
| Sqldumper.exe                                  | 2015.131.5598.27 | 127304    | 28-Nov-2019 | 04:57 | x64      |
| Sqldumper.exe                                  | 2015.131.5598.27 | 107840    | 28-Nov-2019 | 04:56 | x86      |
| Sqlresld.dll                                   | 2015.131.5598.27 | 30832     | 28-Nov-2019 | 04:32 | x64      |
| Sqlresld.dll                                   | 2015.131.5598.27 | 29000     | 28-Nov-2019 | 04:44 | x86      |
| Sqlresourceloader.dll                          | 2015.131.5598.27 | 30840     | 28-Nov-2019 | 04:32 | x64      |
| Sqlresourceloader.dll                          | 2015.131.5598.27 | 28488     | 28-Nov-2019 | 04:44 | x86      |
| Sqlscm.dll                                     | 2015.131.5598.27 | 53064     | 28-Nov-2019 | 04:44 | x86      |
| Sqlscm.dll                                     | 2015.131.5598.27 | 61040     | 28-Nov-2019 | 04:50 | x64      |
| Sqlsvc.dll                                     | 2015.131.5598.27 | 152384    | 28-Nov-2019 | 04:34 | x64      |
| Sqlsvc.dll                                     | 2015.131.5598.27 | 127096    | 28-Nov-2019 | 04:45 | x86      |
| Sqltaskconnections.dll                         | 2015.131.5598.27 | 180856    | 28-Nov-2019 | 04:32 | x64      |
| Sqltaskconnections.dll                         | 2015.131.5598.27 | 151368    | 28-Nov-2019 | 04:44 | x86      |
| Txdataconvert.dll                              | 2015.131.5598.27 | 255296    | 28-Nov-2019 | 04:57 | x86      |
| Txdataconvert.dll                              | 2015.131.5598.27 | 296776    | 28-Nov-2019 | 04:32 | x64      |
| Xe.dll                                         | 2015.131.5598.27 | 558704    | 28-Nov-2019 | 05:01 | x86      |
| Xe.dll                                         | 2015.131.5598.27 | 626496    | 28-Nov-2019 | 04:51 | x64      |
| Xmlrw.dll                                      | 2015.131.5598.27 | 319304    | 28-Nov-2019 | 04:50 | x64      |
| Xmlrw.dll                                      | 2015.131.5598.27 | 259696    | 28-Nov-2019 | 04:55 | x86      |
| Xmlrwbin.dll                                   | 2015.131.5598.27 | 227648    | 28-Nov-2019 | 04:50 | x64      |
| Xmlrwbin.dll                                   | 2015.131.5598.27 | 191808    | 28-Nov-2019 | 04:55 | x86      |
| Xmsrv.dll                                      | 2015.131.5598.27 | 32727872  | 28-Nov-2019 | 04:57 | x86      |
| Xmsrv.dll                                      | 2015.131.5598.27 | 24051832  | 28-Nov-2019 | 04:32 | x64      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
