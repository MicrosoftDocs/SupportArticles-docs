---
title: Cumulative update 15 for SQL Server 2016 SP2 (KB4577775)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP2 cumulative update 15 (KB4577775).
ms.date: 10/26/2023
ms.custom: KB4577775
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Web
---

# KB4577775 - Cumulative Update 15 for SQL Server 2016 SP2

_Release Date:_ &nbsp; September 28, 2020  
_Version:_ &nbsp; 13.0.5850.14

This article describes Cumulative Update package 15 (CU15) (build number: **13.0.5850.14**) for Microsoft SQL Server 2016 Service Pack 2 (SP2). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the initial release of SQL Server 2016 SP2.

## Known issues in this update

There is a known issue with the SQL Writer component in SQL Server 2016 SP2 CU15. The SQL Writer service is shared across all instances of SQL Server that run on the same server, regardless of version. If you have installed this cumulative update on a server that also runs older versions of SQL Server, such as SQL Server 2014 or SQL Server 2012, VSS backups will fail against these older instances. If you are running SQL Server 2016 side-by-side with older versions of SQL Server, we recommend that you do not install this Cumulative Update. This issue will be fixed in the next Cumulative Update release.

## Improvements and fixes included in this update

| Bug reference| Description| Fix area | Platform |
|----------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|----------|
| <a id=13663199>[13663199](#13663199) </a>| Intermittent error 6552 occurs when running Spatial query with `TOP <param> or OFFSET <param1> ROWS FETCH NEXT <param2> ROWS ONLY` clause and parallel plan.| SQL Engine | All|
| <a id=13671166>[13671166](#13671166) </a>| Query Store scalability improvement for adhoc workloads. Query Store now imposes internal limits to the amount of memory, it can use and automatically changes the operation mode to READ-ONLY until enough memory has been returned to the Database Engine, preventing performance issues.| SQL Engine | All|
| <a id=13703158>[13703158](#13703158) </a>| [FIX: Fix incorrect memory page accounting that causes out-of-memory errors in SQL Server (KB4536005)](https://support.microsoft.com/help/4536005) | SQL Engine | All|
| <a id=12833050>[12833050](#12833050) </a>| [FIX: Incorrect results occur when you run INSERT INTO SELECT statement on memory-optimized table variables in SQL Server 2016 (KB4580397)](https://support.microsoft.com/help/4580397)| In-Memory OLTP | Windows|
| <a id=13398580>[13398580](#13398580) </a>| Fixes an issue where the session gets killed when you run `DBCC CHECKTABLE` with `PHYSICAL_ONLY` due to disk full. The session remains in `KILLED`\\`ROLLBACK` state and threads are waiting on `CHECK_TABLES_THREAD_BARRIER` wait type with increasing wait time.| SQL Engine | Windows|
| <a id=13446509>[13446509](#13446509) </a>| Unable to connect to primary database replica after failing over the Availability Group in SQL Server 2016. | High Availability| Windows|
| <a id=13527337>[13527337](#13527337) </a>| When using FileTables in SQL Server, you may notice dumps being generated periodically that contain an assertion in function `FFtFileObject::ProcessPostCreate`. In some environments, these dumps may trigger a failover. </br></br>FFtFileObject::ProcessPostCreate file = FileName line = LineNumber expression = FALSE | SQL Engine | Windows|
| <a id=13562643>[13562643](#13562643) </a>| [FIX: Incorrect results can occur when you run linked server query with aggregates or joins on table with filtered index on a remote server in SQL Server 2016 and 2017 (KB4575689)](https://support.microsoft.com/help/4575689) | SQL performance| Windows|
| <a id=13607958>[13607958](#13607958) </a>| When you run a `RESTORE HEADERONLY` of SQL Server 2016 backup, you may notice [error 3285](/sql/relational-databases/errors-events/database-engine-events-and-errors#errors-3000---3999) even if the correct blocksize has been specified. If the error persists after applying this fix, you may specify the proper blocksize or contact Microsoft Support for assistance.| SQL Engine | Windows|
| <a id=13615273>[13615273](#13615273) </a>| When you try to restore from a compressed or encrypted backup over an existing TDE enabled database, you may notice that the restore operation may take longer time than expected. | SQL Engine | Windows|
| <a id=13622766>[13622766](#13622766) </a>| [FIX: Managed backup is not backing up the database when SQL Agent system jobs are changed to different name other than 'sa' in SQL Server 2016 and 2017 (KB4578008)](https://support.microsoft.com/help/4578008)| SQL Engine | Windows|
| <a id=13624298>[13624298](#13624298) </a>| `CHECKDB` reports no errors but users may see [errors 602 and 608](/sql/relational-databases/errors-events/database-engine-events-and-errors#errors--2-to-999) due to inconsistent Full Text metadata. | SQL Engine | Windows|
| <a id=13634007>[13634007](#13634007) </a>| When you try to backup a READ-ONLY database that contains memory optimized filegroups and files or filestream objects, the backup fails with [errors 3013 and 3906](/sql/relational-databases/errors-events/database-engine-events-and-errors#errors-3000---3999). | SQL Engine | Windows|
| <a id=13636611>[13636611](#13636611) </a>| When a VSS backup tries to backup SQL Server databases that are hosted on the forwarder replica of a Distributed Availability Group then the backup operation fails. </br></br>This BACKUP or RESTORE command is not supported on a database mirror or secondary replica. </br>BACKUP DATABASE is terminating abnormally. </br></br>In the error log, you may see the following error:</br></br>\<DateTime> Error: 3041, Severity: 16, State: 1. </br></br>\<DateTime> BACKUP failed to complete the command BACKUP DATABASE DatabaseName. Check the backup application log for detailed messages. | SQL Engine | Windows|
| <a id=13641664>[13641664](#13641664) </a>| `VERIFY_CLONEDB` prints message 'Clone database verification has failed' for the database if the database name starts with a number. | SQL Engine | Windows|
| <a id=13647266>[13647266](#13647266) </a>| When a role user with role filter in SQL Server 2016 Analysis services (SSAS 2016) runs Direct Query, you may receive an error: </br></br> An unexpected error occurred (file 'FileName', line \<LineNumber>, function 'FunctionNameQueryFragment_Source::BuildSourceFragment'). | Analysis services| Windows|
| <a id=13647774>[13647774](#13647774) </a>| [FIX: Assertion error occurs when the Availability Group is failed over manually to another replica in SQL Server 2016 (KB4587239)](https://support.microsoft.com/help/4587239)| SQL Engine | Windows|
| <a id=13658146>[13658146](#13658146) </a>| Non-yielding Scheduler error may occur when query store tries to grow its memory structure during heavy workload.| SQL Engine | Windows|
| <a id=13671014>[13671014](#13671014) </a>| When you export a report that has a period (.) in the report name, the exported file name will be truncated. | Reporting services | Windows|
| <a id=13708141>[13708141](#13708141) </a>| SSAS 2016 tabular process 'calculate' may take 2-4 times longer time after upgrading to the latest Cumulative Update (CU) for SQL Server 2016 SP2. After the upgrade, the increased time was on the attribute hierarchy processing during the process calculate. | Analysis services| Windows|

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

Only the most recent CU that was released for SQL Server 2016 SP2 is available at the Download Center. Each new CU contains all the fixes that were included togetrher with the previous CU for the installed version or service pack of SQL Server. For a list of the latest cumulative updates for SQL Server, see the following article:

[SQL Server 2016 build versions](build-versions.md)

> [!NOTE]
> Microsoft recommends ongoing, proactive installation of CUs as they become available:
>
> - SQL Server CUs are certified to the same levels as Service Packs, and should be installed at the same level of confidence.
> - Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU.
> - CUs may contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
>
> Just as for SQL Server service packs, we recommend that you test CUs before you deploy them to production environments.
>
> We recommend that you upgrade your SQL Server installation to [the latest SQL Server 2016 service pack](https://support.microsoft.com/help/3177534).

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

One Cumulative Update package includes all available updates for ALL SQL Server 2016 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance you select to be serviced. If a SQL Server feature (e.g. Analysis Services) is added to the instance after this CU is applied, you must re-apply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).

</details>

<details>
<summary><b>How to uninstall this update</b></summary>

To do this, follow these steps:

1. In Control Panel, select **View installed updates** under **Programs and Features**.

2. Locate the entry that corresponds to this cumulative update package under **Microsoft SQL Server 2016**.

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

SQL Server 2016 Analysis Services

|                 File   name                |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.server.core.dll | 13.0.5850.14     | 1341840   | 18-Sep-2020 | 10:01 | x86      |
| Microsoft.applicationinsights.dll          | 2.7.0.13435      | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5850.14     | 983440    | 18-Sep-2020 | 10:00 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5850.14     | 983448    | 18-Sep-2020 | 10:19 | x86      |
| Msmdctr.dll                                | 2015.131.5850.14 | 33176     | 18-Sep-2020 | 10:04 | x64      |
| Msmdlocal.dll                              | 2015.131.5850.14 | 56245144  | 18-Sep-2020 | 10:06 | x64      |
| Msmdlocal.dll                              | 2015.131.5850.14 | 37127064  | 18-Sep-2020 | 10:15 | x86      |
| Msmdsrv.exe                                | 2015.131.5850.14 | 56790936  | 18-Sep-2020 | 10:15 | x64      |
| Msmgdsrv.dll                               | 2015.131.5850.14 | 6502280   | 18-Sep-2020 | 10:02 | x86      |
| Msmgdsrv.dll                               | 2015.131.5850.14 | 7502744   | 18-Sep-2020 | 10:08 | x64      |
| Msolap130.dll                              | 2015.131.5850.14 | 8636312   | 18-Sep-2020 | 10:05 | x64      |
| Msolap130.dll                              | 2015.131.5850.14 | 7003544   | 18-Sep-2020 | 10:15 | x86      |
| Msolui130.dll                              | 2015.131.5850.14 | 303512    | 18-Sep-2020 | 10:03 | x64      |
| Msolui130.dll                              | 2015.131.5850.14 | 280472    | 18-Sep-2020 | 10:14 | x86      |
| Sql_as_keyfile.dll                         | 2015.131.5850.14 | 93592     | 18-Sep-2020 | 10:04 | x64      |
| Sqlboot.dll                                | 2015.131.5850.14 | 179608    | 18-Sep-2020 | 10:03 | x64      |
| Sqlceip.exe                                | 13.0.5850.14     | 249240    | 18-Sep-2020 | 10:17 | x86      |
| Sqldumper.exe                              | 2015.131.5850.14 | 103816    | 18-Sep-2020 | 10:00 | x86      |
| Sqldumper.exe                              | 2015.131.5850.14 | 123288    | 18-Sep-2020 | 10:05 | x64      |
| Tmapi.dll                                  | 2015.131.5850.14 | 4339096   | 18-Sep-2020 | 09:47  | x64      |
| Tmcachemgr.dll                             | 2015.131.5850.14 | 2819480   | 18-Sep-2020 | 09:47  | x64      |
| Tmpersistence.dll                          | 2015.131.5850.14 | 1064344   | 18-Sep-2020 | 09:47  | x64      |
| Tmtransactions.dll                         | 2015.131.5850.14 | 1345432   | 18-Sep-2020 | 09:46  | x64      |
| Xe.dll                                     | 2015.131.5850.14 | 619416    | 18-Sep-2020 | 10:02 | x64      |
| Xmlrw.dll                                  | 2015.131.5850.14 | 312216    | 18-Sep-2020 | 10:02 | x64      |
| Xmlrw.dll                                  | 2015.131.5850.14 | 252808    | 18-Sep-2020 | 10:15 | x86      |
| Xmlrwbin.dll                               | 2015.131.5850.14 | 220568    | 18-Sep-2020 | 10:03 | x64      |
| Xmlrwbin.dll                               | 2015.131.5850.14 | 184720    | 18-Sep-2020 | 10:16 | x86      |
| Xmsrv.dll                                  | 2015.131.5850.14 | 24041872  | 18-Sep-2020 | 09:47  | x64      |
| Xmsrv.dll                                  | 2015.131.5850.14 | 32720784  | 18-Sep-2020 | 10:16 | x86      |

SQL Server 2016 Database Services Common Core

|                 File   name                 |   File version   | File size |    Date   |  Time | Platform |
|:-------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                             | 2015.131.5850.14 | 153480    | 18-Sep-2020 | 10:00 | x86      |
| Batchparser.dll                             | 2015.131.5850.14 | 173976    | 18-Sep-2020 | 10:03 | x64      |
| Instapi150.dll                              | 2015.131.5850.14 | 54168     | 18-Sep-2020 | 10:02 | x64      |
| Instapi150.dll                              | 2015.131.5850.14 | 46488     | 18-Sep-2020 | 10:16 | x86      |
| Isacctchange.dll                            | 2015.131.5850.14 | 23952     | 18-Sep-2020 | 10:04 | x64      |
| Isacctchange.dll                            | 2015.131.5850.14 | 22408     | 18-Sep-2020 | 10:16 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5850.14     | 1020824   | 18-Sep-2020 | 10:01 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5850.14     | 1020824   | 18-Sep-2020 | 10:05 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5850.14     | 1020824   | 18-Sep-2020 | 10:01 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5850.14     | 1020824   | 18-Sep-2020 | 10:05 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.5850.14     | 1341848   | 18-Sep-2020 | 10:04 | x86      |
| Microsoft.analysisservices.dll              | 13.0.5850.14     | 695704    | 18-Sep-2020 | 10:04 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.5850.14     | 758664    | 18-Sep-2020 | 10:04 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.5850.14     | 513944    | 18-Sep-2020 | 10:04 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5850.14     | 705432    | 18-Sep-2020 | 10:01 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5850.14     | 705416    | 18-Sep-2020 | 10:04 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5850.14 | 68504     | 18-Sep-2020 | 10:14 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5850.14 | 65944     | 18-Sep-2020 | 10:16 | x86      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5850.14     | 562568    | 18-Sep-2020 | 10:08 | x86      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5850.14     | 562584    | 18-Sep-2020 | 10:18 | x86      |
| Msasxpress.dll                              | 2015.131.5850.14 | 29080     | 18-Sep-2020 | 10:03 | x64      |
| Msasxpress.dll                              | 2015.131.5850.14 | 24984     | 18-Sep-2020 | 10:15 | x86      |
| Pbsvcacctsync.dll                           | 2015.131.5850.14 | 65944     | 18-Sep-2020 | 10:03 | x64      |
| Pbsvcacctsync.dll                           | 2015.131.5850.14 | 53136     | 18-Sep-2020 | 10:14 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.131.5850.14 | 93592     | 18-Sep-2020 | 10:04 | x64      |
| Sqldumper.exe                               | 2015.131.5850.14 | 103816    | 18-Sep-2020 | 10:00 | x86      |
| Sqldumper.exe                               | 2015.131.5850.14 | 123288    | 18-Sep-2020 | 10:05 | x64      |
| Sqlftacct.dll                               | 2015.131.5850.14 | 44936     | 18-Sep-2020 | 10:03 | x64      |
| Sqlftacct.dll                               | 2015.131.5850.14 | 39832     | 18-Sep-2020 | 10:14 | x86      |
| Sqlmgmprovider.dll                          | 2015.131.5850.14 | 399240    | 18-Sep-2020 | 09:49  | x64      |
| Sqlmgmprovider.dll                          | 2015.131.5850.14 | 358808    | 18-Sep-2020 | 10:15 | x86      |
| Sqlsecacctchg.dll                           | 2015.131.5850.14 | 30600     | 18-Sep-2020 | 09:47  | x64      |
| Sqlsecacctchg.dll                           | 2015.131.5850.14 | 28048     | 18-Sep-2020 | 10:13 | x86      |
| Sqltdiagn.dll                               | 2015.131.5850.14 | 60824     | 18-Sep-2020 | 09:47  | x64      |
| Sqltdiagn.dll                               | 2015.131.5850.14 | 53640     | 18-Sep-2020 | 10:15 | x86      |

SQL Server 2016 sql_dreplay_client

|           File   name          |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2015.131.5850.14 | 114056    | 18-Sep-2020 | 10:03 | x86      |
| Dreplaycommon.dll              | 2015.131.5850.14 | 683928    | 18-Sep-2020 | 10:07 | x86      |
| Dreplayutil.dll                | 2015.131.5850.14 | 303000    | 18-Sep-2020 | 10:00 | x86      |
| Instapi150.dll                 | 2015.131.5850.14 | 54168     | 18-Sep-2020 | 10:02 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.131.5850.14 | 93592     | 18-Sep-2020 | 10:04 | x64      |
| Sqlresourceloader.dll          | 2015.131.5850.14 | 21384     | 18-Sep-2020 | 10:14 | x86      |

SQL Server 2016 sql_dreplay_controller

|             File   name            |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2015.131.5850.14 | 683928    | 18-Sep-2020 | 10:07 | x86      |
| Dreplaycontroller.exe              | 2015.131.5850.14 | 343448    | 18-Sep-2020 | 10:01 | x86      |
| Dreplayprocess.dll                 | 2015.131.5850.14 | 164760    | 18-Sep-2020 | 10:01 | x86      |
| Instapi150.dll                     | 2015.131.5850.14 | 54168     | 18-Sep-2020 | 10:02 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.131.5850.14 | 93592     | 18-Sep-2020 | 10:04 | x64      |
| Sqlresourceloader.dll              | 2015.131.5850.14 | 21384     | 18-Sep-2020 | 10:14 | x86      |

SQL Server 2016 Database Services Core Instance

|                  File   name                 |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Backuptourl.exe                              | 13.0.5850.14     | 34200     | 18-Sep-2020 | 10:12 | x64      |
| Batchparser.dll                              | 2015.131.5850.14 | 173976    | 18-Sep-2020 | 10:03 | x64      |
| Datacollectorcontroller.dll                  | 2015.131.5850.14 | 218520    | 18-Sep-2020 | 10:04 | x64      |
| Dcexec.exe                                   | 2015.131.5850.14 | 67480     | 18-Sep-2020 | 10:13 | x64      |
| Fssres.dll                                   | 2015.131.5850.14 | 74640     | 18-Sep-2020 | 10:04 | x64      |
| Hadrres.dll                                  | 2015.131.5850.14 | 170904    | 18-Sep-2020 | 10:02 | x64      |
| Hkcompile.dll                                | 2015.131.5850.14 | 1291152   | 18-Sep-2020 | 10:03 | x64      |
| Hkengine.dll                                 | 2015.131.5850.14 | 5596056   | 18-Sep-2020 | 10:10 | x64      |
| Hkruntime.dll                                | 2015.131.5850.14 | 151960    | 18-Sep-2020 | 10:09 | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435      | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.5850.14     | 227736    | 18-Sep-2020 | 10:13 | x86      |
| Microsoft.sqlserver.types.dll                | 2015.131.5850.14 | 385936    | 18-Sep-2020 | 10:13 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.131.5850.14 | 65432     | 18-Sep-2020 | 10:09 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.131.5850.14 | 58264     | 18-Sep-2020 | 10:15 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5850.14 | 143256    | 18-Sep-2020 | 10:14 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5850.14 | 151952    | 18-Sep-2020 | 10:15 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.131.5850.14 | 265104    | 18-Sep-2020 | 10:15 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.131.5850.14 | 67984     | 18-Sep-2020 | 10:14 | x64      |
| Odsole70.dll                                 | 2015.131.5850.14 | 85912     | 18-Sep-2020 | 10:03 | x64      |
| Opends60.dll                                 | 2015.131.5850.14 | 26008     | 18-Sep-2020 | 10:02 | x64      |
| Qds.dll                                      | 2015.131.5850.14 | 889752    | 18-Sep-2020 | 10:04 | x64      |
| Rsfxft.dll                                   | 2015.131.5850.14 | 27544     | 18-Sep-2020 | 10:01 | x64      |
| Sqagtres.dll                                 | 2015.131.5850.14 | 57736     | 18-Sep-2020 | 10:03 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.131.5850.14 | 93592     | 18-Sep-2020 | 10:04 | x64      |
| Sqlaamss.dll                                 | 2015.131.5850.14 | 73624     | 18-Sep-2020 | 10:08 | x64      |
| Sqlaccess.dll                                | 2015.131.5850.14 | 456088    | 18-Sep-2020 | 10:13 | x64      |
| Sqlagent.exe                                 | 2015.131.5850.14 | 559512    | 18-Sep-2020 | 10:14 | x64      |
| Sqlagentctr130.dll                           | 2015.131.5850.14 | 44944     | 18-Sep-2020 | 10:03 | x64      |
| Sqlagentctr130.dll                           | 2015.131.5850.14 | 37264     | 18-Sep-2020 | 10:04 | x86      |
| Sqlagentlog.dll                              | 2015.131.5850.14 | 26008     | 18-Sep-2020 | 10:03 | x64      |
| Sqlagentmail.dll                             | 2015.131.5850.14 | 40856     | 18-Sep-2020 | 10:08 | x64      |
| Sqlboot.dll                                  | 2015.131.5850.14 | 179608    | 18-Sep-2020 | 10:03 | x64      |
| Sqlceip.exe                                  | 13.0.5850.14     | 249240    | 18-Sep-2020 | 10:17 | x86      |
| Sqlcmdss.dll                                 | 2015.131.5850.14 | 53128     | 18-Sep-2020 | 10:04 | x64      |
| Sqldk.dll                                    | 2015.131.5850.14 | 2589592   | 18-Sep-2020 | 10:05 | x64      |
| Sqldtsss.dll                                 | 2015.131.5850.14 | 90512     | 18-Sep-2020 | 10:08 | x64      |
| Sqliosim.com                                 | 2015.131.5850.14 | 300936    | 18-Sep-2020 | 10:04 | x64      |
| Sqliosim.exe                                 | 2015.131.5850.14 | 3007384   | 18-Sep-2020 | 10:13 | x64      |
| Sqllang.dll                                  | 2015.131.5850.14 | 39545736  | 18-Sep-2020 | 10:05 | x64      |
| Sqlmin.dll                                   | 2015.131.5850.14 | 37950872  | 18-Sep-2020 | 09:48  | x64      |
| Sqlolapss.dll                                | 2015.131.5850.14 | 91024     | 18-Sep-2020 | 10:08 | x64      |
| Sqlos.dll                                    | 2015.131.5850.14 | 19352     | 18-Sep-2020 | 10:02 | x64      |
| Sqlpowershellss.dll                          | 2015.131.5850.14 | 51600     | 18-Sep-2020 | 09:47  | x64      |
| Sqlrepss.dll                                 | 2015.131.5850.14 | 48008     | 18-Sep-2020 | 09:47  | x64      |
| Sqlresld.dll                                 | 2015.131.5850.14 | 23944     | 18-Sep-2020 | 09:47  | x64      |
| Sqlresourceloader.dll                        | 2015.131.5850.14 | 23960     | 18-Sep-2020 | 09:47  | x64      |
| Sqlscm.dll                                   | 2015.131.5850.14 | 54168     | 18-Sep-2020 | 10:02 | x64      |
| Sqlscriptdowngrade.dll                       | 2015.131.5850.14 | 20888     | 18-Sep-2020 | 09:47  | x64      |
| Sqlscriptupgrade.dll                         | 2015.131.5850.14 | 5804952   | 18-Sep-2020 | 10:02 | x64      |
| Sqlserverspatial150.dll                      | 2015.131.5850.14 | 725912    | 18-Sep-2020 | 10:02 | x64      |
| Sqlservr.exe                                 | 2015.131.5850.14 | 385944    | 18-Sep-2020 | 10:13 | x64      |
| Sqlsvc.dll                                   | 2015.131.5850.14 | 145304    | 18-Sep-2020 | 09:47  | x64      |
| Sqltses.dll                                  | 2015.131.5850.14 | 8916888   | 18-Sep-2020 | 09:47  | x64      |
| Sqsrvres.dll                                 | 2015.131.5850.14 | 244120    | 18-Sep-2020 | 09:47  | x64      |
| Xe.dll                                       | 2015.131.5850.14 | 619416    | 18-Sep-2020 | 10:02 | x64      |
| Xmlrw.dll                                    | 2015.131.5850.14 | 312216    | 18-Sep-2020 | 10:02 | x64      |
| Xmlrwbin.dll                                 | 2015.131.5850.14 | 220568    | 18-Sep-2020 | 10:03 | x64      |
| Xpadsi.exe                                   | 2015.131.5850.14 | 72080     | 18-Sep-2020 | 10:20 | x64      |
| Xplog70.dll                                  | 2015.131.5850.14 | 58768     | 18-Sep-2020 | 10:02 | x64      |
| Xpsqlbot.dll                                 | 2015.131.5850.14 | 26520     | 18-Sep-2020 | 10:09 | x64      |
| Xpstar.dll                                   | 2015.131.5850.14 | 415640    | 18-Sep-2020 | 10:09 | x64      |

SQL Server 2016 Database Services Core Shared

|                  File   name                 |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2015.131.5850.14 | 153480    | 18-Sep-2020 | 10:00 | x86      |
| Batchparser.dll                              | 2015.131.5850.14 | 173976    | 18-Sep-2020 | 10:03 | x64      |
| Bcp.exe                                      | 2015.131.5850.14 | 113040    | 18-Sep-2020 | 10:07 | x64      |
| Commanddest.dll                              | 2015.131.5850.14 | 242056    | 18-Sep-2020 | 10:05 | x64      |
| Datacollectorenumerators.dll                 | 2015.131.5850.14 | 108936    | 18-Sep-2020 | 10:05 | x64      |
| Datacollectortasks.dll                       | 2015.131.5850.14 | 181144    | 18-Sep-2020 | 10:04 | x64      |
| Distrib.exe                                  | 2015.131.5850.14 | 184208    | 18-Sep-2020 | 10:13 | x64      |
| Dteparse.dll                                 | 2015.131.5850.14 | 102800    | 18-Sep-2020 | 10:04 | x64      |
| Dteparsemgd.dll                              | 2015.131.5850.14 | 81816     | 18-Sep-2020 | 10:02 | x64      |
| Dtepkg.dll                                   | 2015.131.5850.14 | 130440    | 18-Sep-2020 | 10:04 | x64      |
| Dtexec.exe                                   | 2015.131.5850.14 | 65944     | 18-Sep-2020 | 10:12 | x64      |
| Dts.dll                                      | 2015.131.5850.14 | 3139480   | 18-Sep-2020 | 10:05 | x64      |
| Dtscomexpreval.dll                           | 2015.131.5850.14 | 470408    | 18-Sep-2020 | 10:04 | x64      |
| Dtsconn.dll                                  | 2015.131.5850.14 | 485768    | 18-Sep-2020 | 10:05 | x64      |
| Dtshost.exe                                  | 2015.131.5850.14 | 79768     | 18-Sep-2020 | 10:13 | x64      |
| Dtslog.dll                                   | 2015.131.5850.14 | 113560    | 18-Sep-2020 | 10:05 | x64      |
| Dtsmsg150.dll                                | 2015.131.5850.14 | 538504    | 18-Sep-2020 | 10:06 | x64      |
| Dtspipeline.dll                              | 2015.131.5850.14 | 1272208   | 18-Sep-2020 | 10:06 | x64      |
| Dtspipelineperf150.dll                       | 2015.131.5850.14 | 41368     | 18-Sep-2020 | 10:04 | x64      |
| Dtuparse.dll                                 | 2015.131.5850.14 | 80792     | 18-Sep-2020 | 10:05 | x64      |
| Dtutil.exe                                   | 2015.131.5850.14 | 127896    | 18-Sep-2020 | 10:19 | x64      |
| Exceldest.dll                                | 2015.131.5850.14 | 256392    | 18-Sep-2020 | 10:04 | x64      |
| Excelsrc.dll                                 | 2015.131.5850.14 | 278424    | 18-Sep-2020 | 10:04 | x64      |
| Execpackagetask.dll                          | 2015.131.5850.14 | 159640    | 18-Sep-2020 | 10:06 | x64      |
| Flatfiledest.dll                             | 2015.131.5850.14 | 382360    | 18-Sep-2020 | 10:04 | x64      |
| Flatfilesrc.dll                              | 2015.131.5850.14 | 394648    | 18-Sep-2020 | 10:04 | x64      |
| Foreachfileenumerator.dll                    | 2015.131.5850.14 | 89480     | 18-Sep-2020 | 10:04 | x64      |
| Hkengperfctrs.dll                            | 2015.131.5850.14 | 52120     | 18-Sep-2020 | 10:02 | x64      |
| Logread.exe                                  | 2015.131.5850.14 | 619928    | 18-Sep-2020 | 10:13 | x64      |
| Microsoft.analysisservices.applocal.core.dll | 13.0.5850.14     | 1307032   | 18-Sep-2020 | 10:04 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll | 13.0.5850.14     | 385432    | 18-Sep-2020 | 10:17 | x86      |
| Microsoft.sqlserver.replication.dll          | 2015.131.5850.14 | 1644440   | 18-Sep-2020 | 10:09 | x64      |
| Microsoft.sqlserver.rmo.dll                  | 13.0.5850.14     | 562584    | 18-Sep-2020 | 10:18 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5850.14 | 143256    | 18-Sep-2020 | 10:14 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5850.14 | 151952    | 18-Sep-2020 | 10:15 | x64      |
| Msdtssrvrutil.dll                            | 2015.131.5850.14 | 94616     | 18-Sep-2020 | 10:04 | x64      |
| Msxmlsql.dll                                 | 2015.131.5850.14 | 1487768   | 18-Sep-2020 | 10:02 | x64      |
| Oledbdest.dll                                | 2015.131.5850.14 | 257424    | 18-Sep-2020 | 10:03 | x64      |
| Oledbsrc.dll                                 | 2015.131.5850.14 | 284056    | 18-Sep-2020 | 10:03 | x64      |
| Osql.exe                                     | 2015.131.5850.14 | 68504     | 18-Sep-2020 | 10:05 | x64      |
| Rawdest.dll                                  | 2015.131.5850.14 | 202632    | 18-Sep-2020 | 10:03 | x64      |
| Rawsource.dll                                | 2015.131.5850.14 | 189848    | 18-Sep-2020 | 10:04 | x64      |
| Rdistcom.dll                                 | 2015.131.5850.14 | 900504    | 18-Sep-2020 | 10:04 | x64      |
| Recordsetdest.dll                            | 2015.131.5850.14 | 180120    | 18-Sep-2020 | 10:03 | x64      |
| Repldp.dll                                   | 2015.131.5850.14 | 274824    | 18-Sep-2020 | 10:03 | x64      |
| Replmerg.exe                                 | 2015.131.5850.14 | 511880    | 18-Sep-2020 | 10:16 | x64      |
| Replprov.dll                                 | 2015.131.5850.14 | 805264    | 18-Sep-2020 | 10:03 | x64      |
| Replrec.dll                                  | 2015.131.5850.14 | 1012112   | 18-Sep-2020 | 10:08 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2015.131.5850.14 | 93592     | 18-Sep-2020 | 10:04 | x64      |
| Sqlcmd.exe                                   | 2015.131.5850.14 | 242584    | 18-Sep-2020 | 10:05 | x64      |
| Sqldiag.exe                                  | 2015.131.5850.14 | 1250712   | 18-Sep-2020 | 10:13 | x64      |
| Sqllogship.exe                               | 13.0.5850.14     | 97688     | 18-Sep-2020 | 10:17 | x64      |
| Sqlresld.dll                                 | 2015.131.5850.14 | 23944     | 18-Sep-2020 | 09:47  | x64      |
| Sqlresld.dll                                 | 2015.131.5850.14 | 21896     | 18-Sep-2020 | 10:14 | x86      |
| Sqlresourceloader.dll                        | 2015.131.5850.14 | 23960     | 18-Sep-2020 | 09:47  | x64      |
| Sqlresourceloader.dll                        | 2015.131.5850.14 | 21384     | 18-Sep-2020 | 10:14 | x86      |
| Sqlscm.dll                                   | 2015.131.5850.14 | 54168     | 18-Sep-2020 | 10:02 | x64      |
| Sqlscm.dll                                   | 2015.131.5850.14 | 45976     | 18-Sep-2020 | 10:14 | x86      |
| Sqlsvc.dll                                   | 2015.131.5850.14 | 145304    | 18-Sep-2020 | 09:47  | x64      |
| Sqlsvc.dll                                   | 2015.131.5850.14 | 120208    | 18-Sep-2020 | 10:13 | x86      |
| Sqltaskconnections.dll                       | 2015.131.5850.14 | 173976    | 18-Sep-2020 | 09:47  | x64      |
| Sqlwep130.dll                                | 2015.131.5850.14 | 98696     | 18-Sep-2020 | 09:47  | x64      |
| Ssisoledb.dll                                | 2015.131.5850.14 | 209296    | 18-Sep-2020 | 09:47  | x64      |
| Tablediff.exe                                | 13.0.5850.14     | 79768     | 18-Sep-2020 | 10:17 | x64      |
| Txagg.dll                                    | 2015.131.5850.14 | 357784    | 18-Sep-2020 | 09:46  | x64      |
| Txbdd.dll                                    | 2015.131.5850.14 | 165784    | 18-Sep-2020 | 09:46  | x64      |
| Txdatacollector.dll                          | 2015.131.5850.14 | 360856    | 18-Sep-2020 | 09:46  | x64      |
| Txdataconvert.dll                            | 2015.131.5850.14 | 289688    | 18-Sep-2020 | 09:46  | x64      |
| Txderived.dll                                | 2015.131.5850.14 | 600984    | 18-Sep-2020 | 09:47  | x64      |
| Txlookup.dll                                 | 2015.131.5850.14 | 525208    | 18-Sep-2020 | 09:46  | x64      |
| Txmerge.dll                                  | 2015.131.5850.14 | 223640    | 18-Sep-2020 | 09:46  | x64      |
| Txmergejoin.dll                              | 2015.131.5850.14 | 271768    | 18-Sep-2020 | 09:46  | x64      |
| Txmulticast.dll                              | 2015.131.5850.14 | 121232    | 18-Sep-2020 | 09:46  | x64      |
| Txrowcount.dll                               | 2015.131.5850.14 | 119704    | 18-Sep-2020 | 09:46  | x64      |
| Txsort.dll                                   | 2015.131.5850.14 | 252312    | 18-Sep-2020 | 09:46  | x64      |
| Txsplit.dll                                  | 2015.131.5850.14 | 593816    | 18-Sep-2020 | 09:46  | x64      |
| Txunionall.dll                               | 2015.131.5850.14 | 175000    | 18-Sep-2020 | 09:46  | x64      |
| Xe.dll                                       | 2015.131.5850.14 | 619416    | 18-Sep-2020 | 10:02 | x64      |
| Xmlrw.dll                                    | 2015.131.5850.14 | 312216    | 18-Sep-2020 | 10:02 | x64      |

SQL Server 2016 sql_extensibility

|          File   name          |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.131.5850.14 | 1008520   | 18-Sep-2020 | 10:05 | x64      |
| Sql_extensibility_keyfile.dll | 2015.131.5850.14 | 93592     | 18-Sep-2020 | 10:04 | x64      |
| Sqlsatellite.dll              | 2015.131.5850.14 | 831384    | 18-Sep-2020 | 10:02 | x64      |

SQL Server 2016 Full-Text Engine

|        File   name       |   File version   | File size |    Date   |  Time | Platform |
|:------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2015.131.5850.14 | 653208    | 18-Sep-2020 | 10:04 | x64      |
| Fdhost.exe               | 2015.131.5850.14 | 98200     | 18-Sep-2020 | 10:05 | x64      |
| Fdlauncher.exe           | 2015.131.5850.14 | 44440     | 18-Sep-2020 | 10:06 | x64      |
| Sql_fulltext_keyfile.dll | 2015.131.5850.14 | 93592     | 18-Sep-2020 | 10:04 | x64      |
| Sqlft130ph.dll           | 2015.131.5850.14 | 51088     | 18-Sep-2020 | 10:03 | x64      |

SQL Server 2016 sql_inst_mr

|       File   name       |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.5850.14     | 16776     | 18-Sep-2020 | 10:02 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.131.5850.14 | 93592     | 18-Sep-2020 | 10:04 | x64      |

SQL Server 2016 Integration Services

|                          File   name                          |   File version   | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 4.0.0.111        | 77944     | 18-Aug-2020 | 00:31  | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 4.0.0.111        | 77944     | 08-Sep-2020  | 10:08 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 4.0.0.111        | 37496     | 18-Aug-2020 | 00:31  | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 4.0.0.111        | 37496     | 08-Sep-2020  | 10:08 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 4.0.0.111        | 78456     | 18-Aug-2020 | 00:31  | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 4.0.0.111        | 78456     | 08-Sep-2020  | 10:08 | x86      |
| Commanddest.dll                                               | 2015.131.5850.14 | 195984    | 18-Sep-2020 | 10:00 | x86      |
| Commanddest.dll                                               | 2015.131.5850.14 | 242056    | 18-Sep-2020 | 10:05 | x64      |
| Dteparse.dll                                                  | 2015.131.5850.14 | 92568     | 18-Sep-2020 | 10:00 | x86      |
| Dteparse.dll                                                  | 2015.131.5850.14 | 102800    | 18-Sep-2020 | 10:04 | x64      |
| Dteparsemgd.dll                                               | 2015.131.5850.14 | 81816     | 18-Sep-2020 | 10:02 | x64      |
| Dteparsemgd.dll                                               | 2015.131.5850.14 | 76688     | 18-Sep-2020 | 10:04 | x86      |
| Dtepkg.dll                                                    | 2015.131.5850.14 | 108936    | 18-Sep-2020 | 10:00 | x86      |
| Dtepkg.dll                                                    | 2015.131.5850.14 | 130440    | 18-Sep-2020 | 10:04 | x64      |
| Dtexec.exe                                                    | 2015.131.5850.14 | 59784     | 18-Sep-2020 | 10:01 | x86      |
| Dtexec.exe                                                    | 2015.131.5850.14 | 65944     | 18-Sep-2020 | 10:12 | x64      |
| Dts.dll                                                       | 2015.131.5850.14 | 2625928   | 18-Sep-2020 | 10:00 | x86      |
| Dts.dll                                                       | 2015.131.5850.14 | 3139480   | 18-Sep-2020 | 10:05 | x64      |
| Dtscomexpreval.dll                                            | 2015.131.5850.14 | 412056    | 18-Sep-2020 | 10:00 | x86      |
| Dtscomexpreval.dll                                            | 2015.131.5850.14 | 470408    | 18-Sep-2020 | 10:04 | x64      |
| Dtsconn.dll                                                   | 2015.131.5850.14 | 385432    | 18-Sep-2020 | 10:00 | x86      |
| Dtsconn.dll                                                   | 2015.131.5850.14 | 485768    | 18-Sep-2020 | 10:05 | x64      |
| Dtsdebughost.exe                                              | 2015.131.5850.14 | 86936     | 18-Sep-2020 | 10:01 | x86      |
| Dtsdebughost.exe                                              | 2015.131.5850.14 | 102808    | 18-Sep-2020 | 10:14 | x64      |
| Dtshost.exe                                                   | 2015.131.5850.14 | 69528     | 18-Sep-2020 | 10:01 | x86      |
| Dtshost.exe                                                   | 2015.131.5850.14 | 79768     | 18-Sep-2020 | 10:13 | x64      |
| Dtslog.dll                                                    | 2015.131.5850.14 | 96136     | 18-Sep-2020 | 10:02 | x86      |
| Dtslog.dll                                                    | 2015.131.5850.14 | 113560    | 18-Sep-2020 | 10:05 | x64      |
| Dtsmsg150.dll                                                 | 2015.131.5850.14 | 534424    | 18-Sep-2020 | 10:00 | x86      |
| Dtsmsg150.dll                                                 | 2015.131.5850.14 | 538504    | 18-Sep-2020 | 10:06 | x64      |
| Dtspipeline.dll                                               | 2015.131.5850.14 | 1052560   | 18-Sep-2020 | 10:00 | x86      |
| Dtspipeline.dll                                               | 2015.131.5850.14 | 1272208   | 18-Sep-2020 | 10:06 | x64      |
| Dtspipelineperf150.dll                                        | 2015.131.5850.14 | 35216     | 18-Sep-2020 | 10:00 | x86      |
| Dtspipelineperf150.dll                                        | 2015.131.5850.14 | 41368     | 18-Sep-2020 | 10:04 | x64      |
| Dtuparse.dll                                                  | 2015.131.5850.14 | 73112     | 18-Sep-2020 | 10:00 | x86      |
| Dtuparse.dll                                                  | 2015.131.5850.14 | 80792     | 18-Sep-2020 | 10:05 | x64      |
| Dtutil.exe                                                    | 2015.131.5850.14 | 108432    | 18-Sep-2020 | 10:02 | x86      |
| Dtutil.exe                                                    | 2015.131.5850.14 | 127896    | 18-Sep-2020 | 10:19 | x64      |
| Exceldest.dll                                                 | 2015.131.5850.14 | 209816    | 18-Sep-2020 | 10:00 | x86      |
| Exceldest.dll                                                 | 2015.131.5850.14 | 256392    | 18-Sep-2020 | 10:04 | x64      |
| Excelsrc.dll                                                  | 2015.131.5850.14 | 225688    | 18-Sep-2020 | 10:00 | x86      |
| Excelsrc.dll                                                  | 2015.131.5850.14 | 278424    | 18-Sep-2020 | 10:04 | x64      |
| Execpackagetask.dll                                           | 2015.131.5850.14 | 128408    | 18-Sep-2020 | 10:00 | x86      |
| Execpackagetask.dll                                           | 2015.131.5850.14 | 159640    | 18-Sep-2020 | 10:06 | x64      |
| Flatfiledest.dll                                              | 2015.131.5850.14 | 327576    | 18-Sep-2020 | 10:00 | x86      |
| Flatfiledest.dll                                              | 2015.131.5850.14 | 382360    | 18-Sep-2020 | 10:04 | x64      |
| Flatfilesrc.dll                                               | 2015.131.5850.14 | 338312    | 18-Sep-2020 | 10:00 | x86      |
| Flatfilesrc.dll                                               | 2015.131.5850.14 | 394648    | 18-Sep-2020 | 10:04 | x64      |
| Foreachfileenumerator.dll                                     | 2015.131.5850.14 | 73608     | 18-Sep-2020 | 10:00 | x86      |
| Foreachfileenumerator.dll                                     | 2015.131.5850.14 | 89480     | 18-Sep-2020 | 10:04 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 13.0.5850.14     | 1307032   | 18-Sep-2020 | 10:04 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 13.0.5850.14     | 1307032   | 18-Sep-2020 | 10:05 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435      | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 13.0.5850.14     | 66448     | 18-Sep-2020 | 10:12 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2015.131.5850.14 | 105360    | 18-Sep-2020 | 10:13 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2015.131.5850.14 | 100232    | 18-Sep-2020 | 10:16 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.5850.14     | 478608    | 18-Sep-2020 | 10:11 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.5850.14     | 478600    | 18-Sep-2020 | 10:18 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 13.0.5850.14     | 75672     | 18-Sep-2020 | 10:09 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 13.0.5850.14     | 75672     | 18-Sep-2020 | 1:02  | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 13.0.5850.14     | 385432    | 18-Sep-2020 | 10:17 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2015.131.5850.14 | 143256    | 18-Sep-2020 | 10:14 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2015.131.5850.14 | 131976    | 18-Sep-2020 | 10:19 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2015.131.5850.14 | 151952    | 18-Sep-2020 | 10:15 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2015.131.5850.14 | 137624    | 18-Sep-2020 | 10:18 | x86      |
| Msdtssrvr.exe                                                 | 13.0.5850.14     | 210312    | 18-Sep-2020 | 10:17 | x64      |
| Msdtssrvrutil.dll                                             | 2015.131.5850.14 | 94616     | 18-Sep-2020 | 10:04 | x64      |
| Msdtssrvrutil.dll                                             | 2015.131.5850.14 | 83352     | 18-Sep-2020 | 10:15 | x86      |
| Oledbdest.dll                                                 | 2015.131.5850.14 | 257424    | 18-Sep-2020 | 10:03 | x64      |
| Oledbdest.dll                                                 | 2015.131.5850.14 | 209816    | 18-Sep-2020 | 10:14 | x86      |
| Oledbsrc.dll                                                  | 2015.131.5850.14 | 284056    | 18-Sep-2020 | 10:03 | x64      |
| Oledbsrc.dll                                                  | 2015.131.5850.14 | 228760    | 18-Sep-2020 | 10:14 | x86      |
| Rawdest.dll                                                   | 2015.131.5850.14 | 202632    | 18-Sep-2020 | 10:03 | x64      |
| Rawdest.dll                                                   | 2015.131.5850.14 | 161688    | 18-Sep-2020 | 10:15 | x86      |
| Rawsource.dll                                                 | 2015.131.5850.14 | 189848    | 18-Sep-2020 | 10:04 | x64      |
| Rawsource.dll                                                 | 2015.131.5850.14 | 148376    | 18-Sep-2020 | 10:15 | x86      |
| Recordsetdest.dll                                             | 2015.131.5850.14 | 180120    | 18-Sep-2020 | 10:03 | x64      |
| Recordsetdest.dll                                             | 2015.131.5850.14 | 144792    | 18-Sep-2020 | 10:15 | x86      |
| Sql_is_keyfile.dll                                            | 2015.131.5850.14 | 93592     | 18-Sep-2020 | 10:04 | x64      |
| Sqlceip.exe                                                   | 13.0.5850.14     | 249240    | 18-Sep-2020 | 10:17 | x86      |
| Sqldest.dll                                                   | 2015.131.5850.14 | 256904    | 18-Sep-2020 | 10:03 | x64      |
| Sqldest.dll                                                   | 2015.131.5850.14 | 208792    | 18-Sep-2020 | 10:13 | x86      |
| Sqltaskconnections.dll                                        | 2015.131.5850.14 | 173976    | 18-Sep-2020 | 09:47  | x64      |
| Sqltaskconnections.dll                                        | 2015.131.5850.14 | 144264    | 18-Sep-2020 | 10:13 | x86      |
| Ssisoledb.dll                                                 | 2015.131.5850.14 | 209296    | 18-Sep-2020 | 09:47  | x64      |
| Ssisoledb.dll                                                 | 2015.131.5850.14 | 169880    | 18-Sep-2020 | 10:13 | x86      |
| Txagg.dll                                                     | 2015.131.5850.14 | 357784    | 18-Sep-2020 | 09:46  | x64      |
| Txagg.dll                                                     | 2015.131.5850.14 | 297872    | 18-Sep-2020 | 10:15 | x86      |
| Txbdd.dll                                                     | 2015.131.5850.14 | 165784    | 18-Sep-2020 | 09:46  | x64      |
| Txbdd.dll                                                     | 2015.131.5850.14 | 130952    | 18-Sep-2020 | 10:17 | x86      |
| Txbestmatch.dll                                               | 2015.131.5850.14 | 604568    | 18-Sep-2020 | 09:46  | x64      |
| Txbestmatch.dll                                               | 2015.131.5850.14 | 489352    | 18-Sep-2020 | 10:15 | x86      |
| Txcache.dll                                                   | 2015.131.5850.14 | 176536    | 18-Sep-2020 | 09:46  | x64      |
| Txcache.dll                                                   | 2015.131.5850.14 | 141208    | 18-Sep-2020 | 10:15 | x86      |
| Txcharmap.dll                                                 | 2015.131.5850.14 | 283032    | 18-Sep-2020 | 09:46  | x64      |
| Txcharmap.dll                                                 | 2015.131.5850.14 | 243608    | 18-Sep-2020 | 10:16 | x86      |
| Txcopymap.dll                                                 | 2015.131.5850.14 | 176024    | 18-Sep-2020 | 09:46  | x64      |
| Txcopymap.dll                                                 | 2015.131.5850.14 | 140696    | 18-Sep-2020 | 10:16 | x86      |
| Txdataconvert.dll                                             | 2015.131.5850.14 | 289688    | 18-Sep-2020 | 09:46  | x64      |
| Txdataconvert.dll                                             | 2015.131.5850.14 | 248208    | 18-Sep-2020 | 10:15 | x86      |
| Txderived.dll                                                 | 2015.131.5850.14 | 600984    | 18-Sep-2020 | 09:47  | x64      |
| Txderived.dll                                                 | 2015.131.5850.14 | 512392    | 18-Sep-2020 | 10:16 | x86      |
| Txfileextractor.dll                                           | 2015.131.5850.14 | 194968    | 18-Sep-2020 | 09:47  | x64      |
| Txfileextractor.dll                                           | 2015.131.5850.14 | 156056    | 18-Sep-2020 | 10:15 | x86      |
| Txfileinserter.dll                                            | 2015.131.5850.14 | 192920    | 18-Sep-2020 | 09:46  | x64      |
| Txfileinserter.dll                                            | 2015.131.5850.14 | 154008    | 18-Sep-2020 | 10:15 | x86      |
| Txgroupdups.dll                                               | 2015.131.5850.14 | 284048    | 18-Sep-2020 | 09:46  | x64      |
| Txgroupdups.dll                                               | 2015.131.5850.14 | 224664    | 18-Sep-2020 | 10:15 | x86      |
| Txlineage.dll                                                 | 2015.131.5850.14 | 130968    | 18-Sep-2020 | 09:46  | x64      |
| Txlineage.dll                                                 | 2015.131.5850.14 | 102792    | 18-Sep-2020 | 10:16 | x86      |
| Txlookup.dll                                                  | 2015.131.5850.14 | 525208    | 18-Sep-2020 | 09:46  | x64      |
| Txlookup.dll                                                  | 2015.131.5850.14 | 442760    | 18-Sep-2020 | 10:15 | x86      |
| Txmerge.dll                                                   | 2015.131.5850.14 | 223640    | 18-Sep-2020 | 09:46  | x64      |
| Txmerge.dll                                                   | 2015.131.5850.14 | 169880    | 18-Sep-2020 | 10:16 | x86      |
| Txmergejoin.dll                                               | 2015.131.5850.14 | 271768    | 18-Sep-2020 | 09:46  | x64      |
| Txmergejoin.dll                                               | 2015.131.5850.14 | 216984    | 18-Sep-2020 | 10:15 | x86      |
| Txmulticast.dll                                               | 2015.131.5850.14 | 121232    | 18-Sep-2020 | 09:46  | x64      |
| Txmulticast.dll                                               | 2015.131.5850.14 | 95128     | 18-Sep-2020 | 10:15 | x86      |
| Txpivot.dll                                                   | 2015.131.5850.14 | 221080    | 18-Sep-2020 | 09:46  | x64      |
| Txpivot.dll                                                   | 2015.131.5850.14 | 175000    | 18-Sep-2020 | 10:15 | x86      |
| Txrowcount.dll                                                | 2015.131.5850.14 | 119704    | 18-Sep-2020 | 09:46  | x64      |
| Txrowcount.dll                                                | 2015.131.5850.14 | 94616     | 18-Sep-2020 | 10:16 | x86      |
| Txsampling.dll                                                | 2015.131.5850.14 | 165272    | 18-Sep-2020 | 09:46  | x64      |
| Txsampling.dll                                                | 2015.131.5850.14 | 127888    | 18-Sep-2020 | 10:15 | x86      |
| Txscd.dll                                                     | 2015.131.5850.14 | 213392    | 18-Sep-2020 | 09:46  | x64      |
| Txscd.dll                                                     | 2015.131.5850.14 | 162712    | 18-Sep-2020 | 10:15 | x86      |
| Txsort.dll                                                    | 2015.131.5850.14 | 252312    | 18-Sep-2020 | 09:46  | x64      |
| Txsort.dll                                                    | 2015.131.5850.14 | 204176    | 18-Sep-2020 | 10:15 | x86      |
| Txsplit.dll                                                   | 2015.131.5850.14 | 593816    | 18-Sep-2020 | 09:46  | x64      |
| Txsplit.dll                                                   | 2015.131.5850.14 | 506264    | 18-Sep-2020 | 10:16 | x86      |
| Txtermextraction.dll                                          | 2015.131.5850.14 | 8671112   | 18-Sep-2020 | 09:47  | x64      |
| Txtermextraction.dll                                          | 2015.131.5850.14 | 8608656   | 18-Sep-2020 | 10:17 | x86      |
| Txtermlookup.dll                                              | 2015.131.5850.14 | 4151704   | 18-Sep-2020 | 09:46  | x64      |
| Txtermlookup.dll                                              | 2015.131.5850.14 | 4099992   | 18-Sep-2020 | 10:16 | x86      |
| Txunionall.dll                                                | 2015.131.5850.14 | 175000    | 18-Sep-2020 | 09:46  | x64      |
| Txunionall.dll                                                | 2015.131.5850.14 | 131976    | 18-Sep-2020 | 10:16 | x86      |
| Txunpivot.dll                                                 | 2015.131.5850.14 | 194960    | 18-Sep-2020 | 09:46  | x64      |
| Txunpivot.dll                                                 | 2015.131.5850.14 | 155528    | 18-Sep-2020 | 10:15 | x86      |
| Xe.dll                                                        | 2015.131.5850.14 | 619416    | 18-Sep-2020 | 10:02 | x64      |
| Xe.dll                                                        | 2015.131.5850.14 | 551816    | 18-Sep-2020 | 10:04 | x86      |

SQL Server 2016 sql_polybase_core_inst

|                              File   name                             |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 10.0.8224.49     | 483624    | 09-May-2019  | 19:33 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.49 | 75560     | 09-May-2019  | 19:33 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.49     | 45864     | 09-May-2019  | 19:33 | x86      |
| Instapi130.dll                                                       | 2015.131.5850.14 | 54168     | 18-Sep-2020 | 09:46  | x64      |
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
| Mpdwinterop.dll                                                      | 2015.131.5850.14 | 387992    | 18-Sep-2020 | 10:11 | x64      |
| Mpdwsvc.exe                                                          | 2015.131.5850.14 | 6611864   | 18-Sep-2020 | 10:20 | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.49 | 47400     | 09-May-2019  | 19:33 | x64      |
| Sqldk.dll                                                            | 2015.131.5850.14 | 2533272   | 18-Sep-2020 | 09:46  | x64      |
| Sqldumper.exe                                                        | 2015.131.5850.14 | 123288    | 18-Sep-2020 | 10:21 | x64      |
| Sqlevn70.rll                                                         | 2015.131.5850.14 | 1434512   | 18-Sep-2020 | 10:08 | x64      |
| Sqlevn70.rll                                                         | 2015.131.5850.14 | 3749784   | 18-Sep-2020 | 10:15 | x64      |
| Sqlevn70.rll                                                         | 2015.131.5850.14 | 3080584   | 18-Sep-2020 | 10:04 | x64      |
| Sqlevn70.rll                                                         | 2015.131.5850.14 | 3751320   | 18-Sep-2020 | 10:14 | x64      |
| Sqlevn70.rll                                                         | 2015.131.5850.14 | 3654552   | 18-Sep-2020 | 10:03 | x64      |
| Sqlevn70.rll                                                         | 2015.131.5850.14 | 2002840   | 18-Sep-2020 | 10:03 | x64      |
| Sqlevn70.rll                                                         | 2015.131.5850.14 | 1948568   | 18-Sep-2020 | 10:02 | x64      |
| Sqlevn70.rll                                                         | 2015.131.5850.14 | 3436936   | 18-Sep-2020 | 10:04 | x64      |
| Sqlevn70.rll                                                         | 2015.131.5850.14 | 3448712   | 18-Sep-2020 | 10:05 | x64      |
| Sqlevn70.rll                                                         | 2015.131.5850.14 | 1384344   | 18-Sep-2020 | 10:05 | x64      |
| Sqlevn70.rll                                                         | 2015.131.5850.14 | 3623816   | 18-Sep-2020 | 10:05 | x64      |
| Sqlncli13e.dll                                                       | 2015.131.5850.14 | 2223512   | 18-Sep-2020 | 09:46  | x64      |
| Sqlos.dll                                                            | 2015.131.5850.14 | 19352     | 18-Sep-2020 | 09:47  | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.49 | 4348200   | 09-May-2019  | 19:33 | x64      |
| Sqltses.dll                                                          | 2015.131.5850.14 | 9085832   | 18-Sep-2020 | 09:47  | x64      |

SQL Server 2016 sql_shared_mr

|             File   name            |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.5850.14     | 16784     | 18-Sep-2020 | 10:10 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.131.5850.14 | 93592     | 18-Sep-2020 | 10:04 | x64      |

SQL Server 2016 sql_tools_extensions

|                   File   name                  |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| As_msmdlocal_dll.32                            | 2015.131.5850.14 | 37127064  | 18-Sep-2020 | 10:15 | x86      |
| As_msmdlocal_dll.64                            | 2015.131.5850.14 | 56245144  | 18-Sep-2020 | 10:06 | x64      |
| Autoadmin.dll                                  | 2015.131.5850.14 | 1304968   | 18-Sep-2020 | 10:00 | x86      |
| Ddsshapeslib.dll                               | 2015.131.5850.14 | 128904    | 18-Sep-2020 | 10:00 | x86      |
| Dtaengine.exe                                  | 2015.131.5850.14 | 160152    | 18-Sep-2020 | 10:01 | x86      |
| Dteparse.dll                                   | 2015.131.5850.14 | 92568     | 18-Sep-2020 | 10:00 | x86      |
| Dteparse.dll                                   | 2015.131.5850.14 | 102800    | 18-Sep-2020 | 10:04 | x64      |
| Dteparsemgd.dll                                | 2015.131.5850.14 | 81816     | 18-Sep-2020 | 10:02 | x64      |
| Dteparsemgd.dll                                | 2015.131.5850.14 | 76688     | 18-Sep-2020 | 10:04 | x86      |
| Dtepkg.dll                                     | 2015.131.5850.14 | 108936    | 18-Sep-2020 | 10:00 | x86      |
| Dtepkg.dll                                     | 2015.131.5850.14 | 130440    | 18-Sep-2020 | 10:04 | x64      |
| Dtexec.exe                                     | 2015.131.5850.14 | 59784     | 18-Sep-2020 | 10:01 | x86      |
| Dtexec.exe                                     | 2015.131.5850.14 | 65944     | 18-Sep-2020 | 10:12 | x64      |
| Dts.dll                                        | 2015.131.5850.14 | 2625928   | 18-Sep-2020 | 10:00 | x86      |
| Dts.dll                                        | 2015.131.5850.14 | 3139480   | 18-Sep-2020 | 10:05 | x64      |
| Dtscomexpreval.dll                             | 2015.131.5850.14 | 412056    | 18-Sep-2020 | 10:00 | x86      |
| Dtscomexpreval.dll                             | 2015.131.5850.14 | 470408    | 18-Sep-2020 | 10:04 | x64      |
| Dtsconn.dll                                    | 2015.131.5850.14 | 385432    | 18-Sep-2020 | 10:00 | x86      |
| Dtsconn.dll                                    | 2015.131.5850.14 | 485768    | 18-Sep-2020 | 10:05 | x64      |
| Dtshost.exe                                    | 2015.131.5850.14 | 69528     | 18-Sep-2020 | 10:01 | x86      |
| Dtshost.exe                                    | 2015.131.5850.14 | 79768     | 18-Sep-2020 | 10:13 | x64      |
| Dtslog.dll                                     | 2015.131.5850.14 | 96136     | 18-Sep-2020 | 10:02 | x86      |
| Dtslog.dll                                     | 2015.131.5850.14 | 113560    | 18-Sep-2020 | 10:05 | x64      |
| Dtsmsg150.dll                                  | 2015.131.5850.14 | 534424    | 18-Sep-2020 | 10:00 | x86      |
| Dtsmsg150.dll                                  | 2015.131.5850.14 | 538504    | 18-Sep-2020 | 10:06 | x64      |
| Dtspipeline.dll                                | 2015.131.5850.14 | 1052560   | 18-Sep-2020 | 10:00 | x86      |
| Dtspipeline.dll                                | 2015.131.5850.14 | 1272208   | 18-Sep-2020 | 10:06 | x64      |
| Dtspipelineperf150.dll                         | 2015.131.5850.14 | 35216     | 18-Sep-2020 | 10:00 | x86      |
| Dtspipelineperf150.dll                         | 2015.131.5850.14 | 41368     | 18-Sep-2020 | 10:04 | x64      |
| Dtuparse.dll                                   | 2015.131.5850.14 | 73112     | 18-Sep-2020 | 10:00 | x86      |
| Dtuparse.dll                                   | 2015.131.5850.14 | 80792     | 18-Sep-2020 | 10:05 | x64      |
| Dtutil.exe                                     | 2015.131.5850.14 | 108432    | 18-Sep-2020 | 10:02 | x86      |
| Dtutil.exe                                     | 2015.131.5850.14 | 127896    | 18-Sep-2020 | 10:19 | x64      |
| Exceldest.dll                                  | 2015.131.5850.14 | 209816    | 18-Sep-2020 | 10:00 | x86      |
| Exceldest.dll                                  | 2015.131.5850.14 | 256392    | 18-Sep-2020 | 10:04 | x64      |
| Excelsrc.dll                                   | 2015.131.5850.14 | 225688    | 18-Sep-2020 | 10:00 | x86      |
| Excelsrc.dll                                   | 2015.131.5850.14 | 278424    | 18-Sep-2020 | 10:04 | x64      |
| Flatfiledest.dll                               | 2015.131.5850.14 | 327576    | 18-Sep-2020 | 10:00 | x86      |
| Flatfiledest.dll                               | 2015.131.5850.14 | 382360    | 18-Sep-2020 | 10:04 | x64      |
| Flatfilesrc.dll                                | 2015.131.5850.14 | 338312    | 18-Sep-2020 | 10:00 | x86      |
| Flatfilesrc.dll                                | 2015.131.5850.14 | 394648    | 18-Sep-2020 | 10:04 | x64      |
| Foreachfileenumerator.dll                      | 2015.131.5850.14 | 73608     | 18-Sep-2020 | 10:00 | x86      |
| Foreachfileenumerator.dll                      | 2015.131.5850.14 | 89480     | 18-Sep-2020 | 10:04 | x64      |
| Microsoft.analysisservices.adomdclientui.dll   | 13.0.5850.14     | 85392     | 18-Sep-2020 | 10:04 | x86      |
| Microsoft.analysisservices.applocal.core.dll   | 13.0.5850.14     | 1307032   | 18-Sep-2020 | 10:05 | x86      |
| Microsoft.analysisservices.project.dll         | 2015.131.5850.14 | 2016664   | 18-Sep-2020 | 10:04 | x86      |
| Microsoft.analysisservices.projectui.dll       | 2015.131.5850.14 | 35216     | 18-Sep-2020 | 10:17 | x86      |
| Microsoft.sqlserver.astasks.dll                | 13.0.5850.14     | 66448     | 18-Sep-2020 | 10:16 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5850.14     | 428952    | 18-Sep-2020 | 10:13 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5850.14     | 428952    | 18-Sep-2020 | 10:15 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5850.14     | 2037640   | 18-Sep-2020 | 10:13 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5850.14     | 2037640   | 18-Sep-2020 | 10:16 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5850.14 | 143256    | 18-Sep-2020 | 10:14 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5850.14 | 131976    | 18-Sep-2020 | 10:19 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5850.14 | 151952    | 18-Sep-2020 | 10:15 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5850.14 | 137624    | 18-Sep-2020 | 10:18 | x86      |
| Msdtssrvrutil.dll                              | 2015.131.5850.14 | 94616     | 18-Sep-2020 | 10:04 | x64      |
| Msdtssrvrutil.dll                              | 2015.131.5850.14 | 83352     | 18-Sep-2020 | 10:15 | x86      |
| Msmgdsrv.dll                                   | 2015.131.5850.14 | 6502280   | 18-Sep-2020 | 10:02 | x86      |
| Msmgdsrv.dll                                   | 2015.131.5850.14 | 7502744   | 18-Sep-2020 | 10:08 | x64      |
| Msolap130.dll                                  | 2015.131.5850.14 | 8636312   | 18-Sep-2020 | 10:05 | x64      |
| Msolap130.dll                                  | 2015.131.5850.14 | 7003544   | 18-Sep-2020 | 10:15 | x86      |
| Msolui130.dll                                  | 2015.131.5850.14 | 303512    | 18-Sep-2020 | 10:03 | x64      |
| Msolui130.dll                                  | 2015.131.5850.14 | 280472    | 18-Sep-2020 | 10:14 | x86      |
| Oledbdest.dll                                  | 2015.131.5850.14 | 257424    | 18-Sep-2020 | 10:03 | x64      |
| Oledbdest.dll                                  | 2015.131.5850.14 | 209816    | 18-Sep-2020 | 10:14 | x86      |
| Oledbsrc.dll                                   | 2015.131.5850.14 | 284056    | 18-Sep-2020 | 10:03 | x64      |
| Oledbsrc.dll                                   | 2015.131.5850.14 | 228760    | 18-Sep-2020 | 10:14 | x86      |
| Profiler.exe                                   | 2015.131.5850.14 | 797592    | 18-Sep-2020 | 10:05 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.131.5850.14 | 93592     | 18-Sep-2020 | 10:04 | x64      |
| Sqldumper.exe                                  | 2015.131.5850.14 | 103816    | 18-Sep-2020 | 10:00 | x86      |
| Sqldumper.exe                                  | 2015.131.5850.14 | 123288    | 18-Sep-2020 | 10:05 | x64      |
| Sqlresld.dll                                   | 2015.131.5850.14 | 23944     | 18-Sep-2020 | 09:47  | x64      |
| Sqlresld.dll                                   | 2015.131.5850.14 | 21896     | 18-Sep-2020 | 10:14 | x86      |
| Sqlresourceloader.dll                          | 2015.131.5850.14 | 23960     | 18-Sep-2020 | 09:47  | x64      |
| Sqlresourceloader.dll                          | 2015.131.5850.14 | 21384     | 18-Sep-2020 | 10:14 | x86      |
| Sqlscm.dll                                     | 2015.131.5850.14 | 54168     | 18-Sep-2020 | 10:02 | x64      |
| Sqlscm.dll                                     | 2015.131.5850.14 | 45976     | 18-Sep-2020 | 10:14 | x86      |
| Sqlsvc.dll                                     | 2015.131.5850.14 | 145304    | 18-Sep-2020 | 09:47  | x64      |
| Sqlsvc.dll                                     | 2015.131.5850.14 | 120208    | 18-Sep-2020 | 10:13 | x86      |
| Sqltaskconnections.dll                         | 2015.131.5850.14 | 173976    | 18-Sep-2020 | 09:47  | x64      |
| Sqltaskconnections.dll                         | 2015.131.5850.14 | 144264    | 18-Sep-2020 | 10:13 | x86      |
| Txdataconvert.dll                              | 2015.131.5850.14 | 289688    | 18-Sep-2020 | 09:46  | x64      |
| Txdataconvert.dll                              | 2015.131.5850.14 | 248208    | 18-Sep-2020 | 10:15 | x86      |
| Xe.dll                                         | 2015.131.5850.14 | 619416    | 18-Sep-2020 | 10:02 | x64      |
| Xe.dll                                         | 2015.131.5850.14 | 551816    | 18-Sep-2020 | 10:04 | x86      |
| Xmlrw.dll                                      | 2015.131.5850.14 | 312216    | 18-Sep-2020 | 10:02 | x64      |
| Xmlrw.dll                                      | 2015.131.5850.14 | 252808    | 18-Sep-2020 | 10:15 | x86      |
| Xmlrwbin.dll                                   | 2015.131.5850.14 | 220568    | 18-Sep-2020 | 10:03 | x64      |
| Xmlrwbin.dll                                   | 2015.131.5850.14 | 184720    | 18-Sep-2020 | 10:16 | x86      |
| Xmsrv.dll                                      | 2015.131.5850.14 | 24041872  | 18-Sep-2020 | 09:47  | x64      |
| Xmsrv.dll                                      | 2015.131.5850.14 | 32720784  | 18-Sep-2020 | 10:16 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
