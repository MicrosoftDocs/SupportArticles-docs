---
title: Cumulative update 14 for SQL Server 2016 SP2 (KB4564903)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP2 cumulative update 14 (KB4564903).
ms.date: 10/26/2023
ms.custom: KB4564903
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Web
---

# KB4564903 - Cumulative Update 14 for SQL Server 2016 SP2

_Release Date:_ &nbsp; August 06, 2020  
_Version:_ &nbsp; 13.0.5830.85

This article describes Cumulative Update package 14 (CU14) (build number: **13.0.5830.85**) for Microsoft SQL Server 2016 Service Pack 2 (SP2). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the initial release of SQL Server 2016 SP2.

## Improvements and fixes included in this update

| Bug reference| Description| Fix area | Platform |
|----------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|----------|
| <a id=13544150>[13544150](#13544150) </a>| This improvement includes object level lock optimization on secondary replicas of Always On Availability Groups and addresses the schema lock contention on secondary replica redo, especially when the number of logical processors is large.| High Availability| Windows|
| <a id=13573411>[13573411](#13573411) </a>| Fixes an access violation exception when you execute `insert into <table> exec sp_execute_external_script` statement and the table has an identity column in SQL Server 2016. | SQL Engine | All|
| <a id=12929737>[12929737](#12929737) </a>| [FIX: Access violation occurs when you query cloned database in SQL Server 2016 (KB4576757)](https://support.microsoft.com/help/4576757) | SQL Engine | Windows|
| <a id=13378995>[13378995](#13378995) </a>| [FIX: Automatic seeding failure occurs for a secondary replica in SQL Server 2016 (KB4568447)](https://support.microsoft.com/help/4568447) | High Availability| Windows|
| <a id=13516059>[13516059](#13516059) </a>| This improvement can force the Query Store option to be turned off by specifying the additional option `FORCED` in the `ALTER DB` command. `FORCED` option allows you to turn off Query Store immediately by aborting all background tasks.</br></br>`ALTER DATABASE {0} SET QUERY_STORE = OFF (FORCED)` | SQL Engine | Windows|
| <a id=13529589>[13529589](#13529589) </a>| [FIX: Log reader agent generates access violation exception for P2P or transactional replication with partitioning tables in SQL Server 2016 (KB4575939)](https://support.microsoft.com/help/4575939)| SQL Engine | Windows|
| <a id=13539976>[13539976](#13539976) </a>| Executing `sys.fn_xe_file_target_read_file` may cause an Access violation in SQL Server 2016.| SQL Engine | Windows|
| <a id=13560933>[13560933](#13560933) </a>| Fixes an access violation which occurs while querying row mod count property on spatial indexes in SQL Server 2016.| SQL performance| Windows|
| <a id=13561178>[13561178](#13561178) </a>| Fixes deadlocks that occur in [catalog].[set_execution_property_override_value]. | Integration Services | Windows|
| <a id=13567427>[13567427](#13567427) </a>| Fixes intermittent "Unexpected Exception" error that is encountered when using SQL Dialect against SSAS Tabular. | Analysis Services| Windows|
| <a id=13575425>[13575425](#13575425) </a>| [FIX: INSERT EXEC doesn't work when you insert row containing explicit identity value into table with IDENTITY column and IDENTITY_INSERT is OFF by default in SQL Server (KB4568653)](https://support.microsoft.com/help/4568653) | SQL Engine | Windows|
| <a id=13587428>[13587428](#13587428) </a>| Fixes indefinite hang during cube processing caused by connection throttling. This problem only occurs after applying Cumulative Update 7 (CU7) for SQL Server Analysis Services 2016 Service Pack 2 (SP2).| Analysis Services| Windows|
| <a id=13596467>[13596467](#13596467) </a>| [FIX: Intermittent connection error occurs when an expression is used for both connection string and password of a connection manager (KB4569837)](https://support.microsoft.com/help/4569837) | Integration Services | Windows|
| <a id=13606996>[13606996](#13606996) </a>| [FIX: Newly added articles' snapshot doesn't get applied to subscriber in SQL Server 2016 (KB4575940)](https://support.microsoft.com/help/4575940) | SQL Engine | Windows|
| <a id=13616653>[13616653](#13616653) </a>| [FIX: ISDBUpgradeWizard.exe throws error when you try to upgrade SSISDB after restoring from earlier versions in SQL Server (KB4547890)](https://support.microsoft.com/help/4547890) | Integration Services | Windows|
| <a id=13613608>[13613608](#13613608) </a> </br><a id=13622634>[13622634](#13622634) </a> | RSetup.exe is updated to version 9.4.7.515. This new version downloads new [SRS_9.4.7.958_1033.cab](https://go.microsoft.com/fwlink/?linkid=2136942) and [SRO_3.5.2.777_1033.cab](https://go.microsoft.com/fwlink/?linkid=2134897) CAB files. This update will install a new version of R 3.5, and configure it to be the default version in new installations. </br></br>An updated RegisterRext.exe that accepts the `/configure` and `/cleanup` command-line options to do the respective customer-requested actions is shipping together with the new R CAB files. To configure R 3.5 as the default version of R, or to clean up an unused old runtime in an existing installation by using this RegisterRext.exe, follow the instructions at [https://go.microsoft.com/fwlink/?linkid=2133077](https://go.microsoft.com/fwlink/?linkid=2133077). | SQL Engine | Windows|

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
> - Just as for SQL Server service packs, we recommend that you test CUs before you deploy them to production environments.
> - We recommend that you upgrade your SQL Server installation to [the latest SQL Server 2016 service pack](https://support.microsoft.com/help/3177534).

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

| File   name    | File version     | File size | Date     | Time | Platform |
|----------------|------------------|-----------|----------|------|----------|
| Instapi130.dll | 2015.131.5830.85 | 46488     | 01-Aug-2020 | 09:32 | x86      |
| Keyfile.dll    | 2015.131.5830.85 | 81808     | 01-Aug-2020 | 09:33 | x86      |
| Sqlbrowser.exe | 2015.131.5830.85 | 269704    | 01-Aug-2020 | 09:34 | x86      |
| Sqldumper.exe  | 2015.131.5830.85 | 103824    | 01-Aug-2020 | 09:33 | x86      |

SQL Server 2016 Writer

| File   name           | File version     | File size | Date     | Time | Platform |
|-----------------------|------------------|-----------|----------|------|----------|
| Instapi130.dll        | 2015.131.5830.85 | 54168     | 01-Aug-2020 | 09:20 | x64      |
| Sqlboot.dll           | 2015.131.5830.85 | 179608    | 01-Aug-2020 | 09:20 | x64      |
| Sqldumper.exe         | 2015.131.5830.85 | 123280    | 01-Aug-2020 | 09:21 | x64      |
| Sqlvdi.dll            | 2015.131.5830.85 | 190352    | 01-Aug-2020 | 09:20 | x64      |
| Sqlvdi.dll            | 2015.131.5830.85 | 161688    | 01-Aug-2020 | 09:32 | x86      |
| Sqlwriter.exe         | 2015.131.5830.85 | 124824    | 01-Aug-2020 | 09:35 | x64      |
| Sqlwriter_keyfile.dll | 2015.131.5830.85 | 93584     | 01-Aug-2020 | 09:21 | x64      |
| Sqlwvss.dll           | 2015.131.5830.85 | 339864    | 01-Aug-2020 | 09:31 | x64      |
| Sqlwvss_xp.dll        | 2015.131.5830.85 | 19336     | 01-Aug-2020 | 09:31 | x64      |

SQL Server 2016 Analysis Services

| File   name                                | File version     | File size | Date     | Time  | Platform |
|--------------------------------------------|------------------|-----------|----------|-------|----------|
| Microsoft.analysisservices.server.core.dll | 13.0.5830.85     | 1341832   | 01-Aug-2020 | 09:27  | x86      |
| Microsoft.applicationinsights.dll          | 2.7.0.13435      | 329872    | 06-Jul-2018 | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5830.85     | 983432    | 01-Aug-2020 | 09:24  | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5830.85     | 983448    | 01-Aug-2020 | 09:26  | x86      |
| Msmdctr130.dll                             | 2015.131.5830.85 | 33176     | 01-Aug-2020 | 09:20  | x64      |
| Msmdlocal.dll                              | 2015.131.5830.85 | 56245136  | 01-Aug-2020 | 09:22  | x64      |
| Msmdlocal.dll                              | 2015.131.5830.85 | 37128088  | 01-Aug-2020 | 09:33  | x86      |
| Msmdsrv.exe                                | 2015.131.5830.85 | 56792472  | 01-Aug-2020 | 09:38  | x64      |
| Msmgdsrv.dll                               | 2015.131.5830.85 | 7502728   | 01-Aug-2020 | 09:24  | x64      |
| Msmgdsrv.dll                               | 2015.131.5830.85 | 6502296   | 01-Aug-2020 | 09:31  | x86      |
| Msolap130.dll                              | 2015.131.5830.85 | 8636296   | 01-Aug-2020 | 09:21  | x64      |
| Msolap130.dll                              | 2015.131.5830.85 | 7004048   | 01-Aug-2020 | 09:33  | x86      |
| Msolui130.dll                              | 2015.131.5830.85 | 303512    | 01-Aug-2020 | 09:20  | x64      |
| Msolui130.dll                              | 2015.131.5830.85 | 280464    | 01-Aug-2020 | 09:32  | x86      |
| Sql_as_keyfile.dll                         | 2015.131.5830.85 | 93584     | 01-Aug-2020 | 09:21  | x64      |
| Sqlboot.dll                                | 2015.131.5830.85 | 179608    | 01-Aug-2020 | 09:20  | x64      |
| Sqlceip.exe                                | 13.0.5830.85     | 249240    | 01-Aug-2020 | 09:20  | x86      |
| Sqldumper.exe                              | 2015.131.5830.85 | 123280    | 01-Aug-2020 | 09:21  | x64      |
| Sqldumper.exe                              | 2015.131.5830.85 | 103824    | 01-Aug-2020 | 09:33  | x86      |
| Tmapi.dll                                  | 2015.131.5830.85 | 4339096   | 01-Aug-2020 | 09:31  | x64      |
| Tmcachemgr.dll                             | 2015.131.5830.85 | 2819480   | 01-Aug-2020 | 09:31  | x64      |
| Tmpersistence.dll                          | 2015.131.5830.85 | 1064344   | 01-Aug-2020 | 09:30  | x64      |
| Tmtransactions.dll                         | 2015.131.5830.85 | 1345432   | 01-Aug-2020 | 09:31  | x64      |
| Xe.dll                                     | 2015.131.5830.85 | 619400    | 01-Aug-2020 | 09:21  | x64      |
| Xmlrw.dll                                  | 2015.131.5830.85 | 252816    | 01-Aug-2020 | 09:19  | x86      |
| Xmlrw.dll                                  | 2015.131.5830.85 | 312216    | 01-Aug-2020 | 09:20  | x64      |
| Xmlrwbin.dll                               | 2015.131.5830.85 | 184712    | 01-Aug-2020 | 09:19  | x86      |
| Xmlrwbin.dll                               | 2015.131.5830.85 | 220552    | 01-Aug-2020 | 09:22  | x64      |
| Xmsrv.dll                                  | 2015.131.5830.85 | 32721288  | 01-Aug-2020 | 09:20  | x86      |
| Xmsrv.dll                                  | 2015.131.5830.85 | 24041368  | 01-Aug-2020 | 09:32  | x64      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date     | Time | Platform |
|---------------------------------------------|------------------|-----------|----------|------|----------|
| Batchparser.dll                             | 2015.131.5830.85 | 173960    | 01-Aug-2020 | 09:21 | x64      |
| Batchparser.dll                             | 2015.131.5830.85 | 153480    | 01-Aug-2020 | 09:33 | x86      |
| Instapi130.dll                              | 2015.131.5830.85 | 54168     | 01-Aug-2020 | 09:20 | x64      |
| Instapi130.dll                              | 2015.131.5830.85 | 46488     | 01-Aug-2020 | 09:32 | x86      |
| Isacctchange.dll                            | 2015.131.5830.85 | 23952     | 01-Aug-2020 | 09:21 | x64      |
| Isacctchange.dll                            | 2015.131.5830.85 | 22416     | 01-Aug-2020 | 09:32 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5830.85     | 1020824   | 01-Aug-2020 | 09:28 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5830.85     | 1020816   | 01-Aug-2020 | 09:29 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.5830.85     | 1341840   | 01-Aug-2020 | 09:29 | x86      |
| Microsoft.analysisservices.dll              | 13.0.5830.85     | 695704    | 01-Aug-2020 | 09:29 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.5830.85     | 758672    | 01-Aug-2020 | 09:30 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.5830.85     | 513944    | 01-Aug-2020 | 09:28 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5830.85     | 705424    | 01-Aug-2020 | 09:26 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5830.85     | 705424    | 01-Aug-2020 | 09:28 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5830.85 | 65928     | 01-Aug-2020 | 09:24 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5830.85 | 68488     | 01-Aug-2020 | 09:29 | x64      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5830.85     | 562576    | 01-Aug-2020 | 09:24 | x86      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5830.85     | 562576    | 01-Aug-2020 | 09:25 | x86      |
| Msasxpress.dll                              | 2015.131.5830.85 | 29080     | 01-Aug-2020 | 09:20 | x64      |
| Msasxpress.dll                              | 2015.131.5830.85 | 24976     | 01-Aug-2020 | 09:32 | x86      |
| Pbsvcacctsync.dll                           | 2015.131.5830.85 | 65928     | 01-Aug-2020 | 09:20 | x64      |
| Pbsvcacctsync.dll                           | 2015.131.5830.85 | 53144     | 01-Aug-2020 | 09:33 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.131.5830.85 | 93584     | 01-Aug-2020 | 09:21 | x64      |
| Sqldumper.exe                               | 2015.131.5830.85 | 123280    | 01-Aug-2020 | 09:21 | x64      |
| Sqldumper.exe                               | 2015.131.5830.85 | 103824    | 01-Aug-2020 | 09:33 | x86      |
| Sqlftacct.dll                               | 2015.131.5830.85 | 44936     | 01-Aug-2020 | 09:20 | x64      |
| Sqlftacct.dll                               | 2015.131.5830.85 | 39832     | 01-Aug-2020 | 09:32 | x86      |
| Sqlmgmprovider.dll                          | 2015.131.5830.85 | 399256    | 01-Aug-2020 | 09:31 | x64      |
| Sqlmgmprovider.dll                          | 2015.131.5830.85 | 358800    | 01-Aug-2020 | 09:32 | x86      |
| Sqlsecacctchg.dll                           | 2015.131.5830.85 | 28056     | 01-Aug-2020 | 09:32 | x86      |
| Sqlsecacctchg.dll                           | 2015.131.5830.85 | 30616     | 01-Aug-2020 | 09:32 | x64      |
| Sqltdiagn.dll                               | 2015.131.5830.85 | 60824     | 01-Aug-2020 | 09:31 | x64      |
| Sqltdiagn.dll                               | 2015.131.5830.85 | 53656     | 01-Aug-2020 | 09:32 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version     | File size | Date     | Time | Platform |
|--------------------------------|------------------|-----------|----------|------|----------|
| Dreplayclient.exe              | 2015.131.5830.85 | 114064    | 01-Aug-2020 | 09:34 | x86      |
| Dreplaycommon.dll              | 2015.131.5830.85 | 683920    | 01-Aug-2020 | 09:29 | x86      |
| Dreplayutil.dll                | 2015.131.5830.85 | 303000    | 01-Aug-2020 | 09:33 | x86      |
| Instapi130.dll                 | 2015.131.5830.85 | 54168     | 01-Aug-2020 | 09:20 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.131.5830.85 | 93584     | 01-Aug-2020 | 09:21 | x64      |
| Sqlresourceloader.dll          | 2015.131.5830.85 | 21384     | 01-Aug-2020 | 09:31 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version     | File size | Date     | Time | Platform |
|------------------------------------|------------------|-----------|----------|------|----------|
| Dreplaycommon.dll                  | 2015.131.5830.85 | 683920    | 01-Aug-2020 | 09:29 | x86      |
| Dreplaycontroller.exe              | 2015.131.5830.85 | 343440    | 01-Aug-2020 | 09:34 | x86      |
| Dreplayprocess.dll                 | 2015.131.5830.85 | 164760    | 01-Aug-2020 | 09:33 | x86      |
| Instapi130.dll                     | 2015.131.5830.85 | 54168     | 01-Aug-2020 | 09:20 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.131.5830.85 | 93584     | 01-Aug-2020 | 09:21 | x64      |
| Sqlresourceloader.dll              | 2015.131.5830.85 | 21384     | 01-Aug-2020 | 09:31 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version     | File size | Date     | Time  | Platform |
|----------------------------------------------|------------------|-----------|----------|-------|----------|
| Backuptourl.exe                              | 13.0.5830.85     | 34200     | 01-Aug-2020 | 09:35  | x64      |
| Batchparser.dll                              | 2015.131.5830.85 | 173960    | 01-Aug-2020 | 09:21  | x64      |
| Datacollectorcontroller.dll                  | 2015.131.5830.85 | 218512    | 01-Aug-2020 | 09:21  | x64      |
| Dcexec.exe                                   | 2015.131.5830.85 | 67472     | 01-Aug-2020 | 09:35  | x64      |
| Fssres.dll                                   | 2015.131.5830.85 | 74648     | 01-Aug-2020 | 09:21  | x64      |
| Hadrres.dll                                  | 2015.131.5830.85 | 170888    | 01-Aug-2020 | 09:20  | x64      |
| Hkcompile.dll                                | 2015.131.5830.85 | 1291160   | 01-Aug-2020 | 09:20  | x64      |
| Hkengine.dll                                 | 2015.131.5830.85 | 5594512   | 01-Aug-2020 | 09:38  | x64      |
| Hkruntime.dll                                | 2015.131.5830.85 | 151960    | 01-Aug-2020 | 09:39  | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435      | 329872    | 06-Jul-2018 | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.5830.85     | 227736    | 01-Aug-2020 | 09:23  | x86      |
| Microsoft.sqlserver.types.dll                | 2015.131.5830.85 | 385928    | 01-Aug-2020 | 09:29  | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.131.5830.85 | 65432     | 01-Aug-2020 | 09:23  | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.131.5830.85 | 58264     | 01-Aug-2020 | 09:28  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5830.85 | 143256    | 01-Aug-2020 | 09:33  | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5830.85 | 151960    | 01-Aug-2020 | 09:28  | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.131.5830.85 | 265104    | 01-Aug-2020 | 09:28  | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.131.5830.85 | 67992     | 01-Aug-2020 | 09:28  | x64      |
| Odsole70.dll                                 | 2015.131.5830.85 | 85912     | 01-Aug-2020 | 09:22  | x64      |
| Opends60.dll                                 | 2015.131.5830.85 | 26008     | 01-Aug-2020 | 09:20  | x64      |
| Qds.dll                                      | 2015.131.5830.85 | 869256    | 01-Aug-2020 | 09:20  | x64      |
| Rsfxft.dll                                   | 2015.131.5830.85 | 27544     | 01-Aug-2020 | 09:20  | x64      |
| Sqagtres.dll                                 | 2015.131.5830.85 | 57752     | 01-Aug-2020 | 09:20  | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.131.5830.85 | 93584     | 01-Aug-2020 | 09:21  | x64      |
| Sqlaamss.dll                                 | 2015.131.5830.85 | 73608     | 01-Aug-2020 | 09:24  | x64      |
| Sqlaccess.dll                                | 2015.131.5830.85 | 456088    | 01-Aug-2020 | 09:29  | x64      |
| Sqlagent.exe                                 | 2015.131.5830.85 | 559504    | 01-Aug-2020 | 09:35  | x64      |
| Sqlagentctr130.dll                           | 2015.131.5830.85 | 44936     | 01-Aug-2020 | 09:30  | x64      |
| Sqlagentctr130.dll                           | 2015.131.5830.85 | 37264     | 01-Aug-2020 | 09:32  | x86      |
| Sqlagentlog.dll                              | 2015.131.5830.85 | 26008     | 01-Aug-2020 | 09:20  | x64      |
| Sqlagentmail.dll                             | 2015.131.5830.85 | 40856     | 01-Aug-2020 | 09:22  | x64      |
| Sqlboot.dll                                  | 2015.131.5830.85 | 179608    | 01-Aug-2020 | 09:20  | x64      |
| Sqlceip.exe                                  | 13.0.5830.85     | 249240    | 01-Aug-2020 | 09:20  | x86      |
| Sqlcmdss.dll                                 | 2015.131.5830.85 | 53144     | 01-Aug-2020 | 09:20  | x64      |
| Sqldk.dll                                    | 2015.131.5830.85 | 2588568   | 01-Aug-2020 | 09:20  | x64      |
| Sqldtsss.dll                                 | 2015.131.5830.85 | 90504     | 01-Aug-2020 | 09:22  | x64      |
| Sqliosim.com                                 | 2015.131.5830.85 | 300944    | 01-Aug-2020 | 09:30  | x64      |
| Sqliosim.exe                                 | 2015.131.5830.85 | 3007384   | 01-Aug-2020 | 09:35  | x64      |
| Sqllang.dll                                  | 2015.131.5830.85 | 39544720  | 01-Aug-2020 | 09:21  | x64      |
| Sqlmin.dll                                   | 2015.131.5830.85 | 37948824  | 01-Aug-2020 | 09:31  | x64      |
| Sqlolapss.dll                                | 2015.131.5830.85 | 91032     | 01-Aug-2020 | 09:22  | x64      |
| Sqlos.dll                                    | 2015.131.5830.85 | 19352     | 01-Aug-2020 | 09:20  | x64      |
| Sqlpowershellss.dll                          | 2015.131.5830.85 | 51608     | 01-Aug-2020 | 09:31  | x64      |
| Sqlrepss.dll                                 | 2015.131.5830.85 | 48024     | 01-Aug-2020 | 09:31  | x64      |
| Sqlresld.dll                                 | 2015.131.5830.85 | 23960     | 01-Aug-2020 | 09:31  | x64      |
| Sqlresourceloader.dll                        | 2015.131.5830.85 | 23960     | 01-Aug-2020 | 09:31  | x64      |
| Sqlscm.dll                                   | 2015.131.5830.85 | 54152     | 01-Aug-2020 | 09:20  | x64      |
| Sqlscriptdowngrade.dll                       | 2015.131.5830.85 | 20888     | 01-Aug-2020 | 09:31  | x64      |
| Sqlscriptupgrade.dll                         | 2015.131.5830.85 | 5804944   | 01-Aug-2020 | 09:20  | x64      |
| Sqlserverspatial130.dll                      | 2015.131.5830.85 | 725896    | 01-Aug-2020 | 09:22  | x64      |
| Sqlservr.exe                                 | 2015.131.5830.85 | 385936    | 01-Aug-2020 | 09:34  | x64      |
| Sqlsvc.dll                                   | 2015.131.5830.85 | 145304    | 01-Aug-2020 | 09:31  | x64      |
| Sqltses.dll                                  | 2015.131.5830.85 | 8916376   | 01-Aug-2020 | 09:31  | x64      |
| Sqsrvres.dll                                 | 2015.131.5830.85 | 244120    | 01-Aug-2020 | 09:31  | x64      |
| Xe.dll                                       | 2015.131.5830.85 | 619400    | 01-Aug-2020 | 09:21  | x64      |
| Xmlrw.dll                                    | 2015.131.5830.85 | 312216    | 01-Aug-2020 | 09:20  | x64      |
| Xmlrwbin.dll                                 | 2015.131.5830.85 | 220552    | 01-Aug-2020 | 09:22  | x64      |
| Xpadsi.exe                                   | 2015.131.5830.85 | 72088     | 01-Aug-2020 | 09:23  | x64      |
| Xplog70.dll                                  | 2015.131.5830.85 | 58760     | 01-Aug-2020 | 09:21  | x64      |
| Xpsqlbot.dll                                 | 2015.131.5830.85 | 26520     | 01-Aug-2020 | 09:20  | x64      |
| Xpstar.dll                                   | 2015.131.5830.85 | 415624    | 01-Aug-2020 | 09:20  | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                  | File version     | File size | Date     | Time | Platform |
|----------------------------------------------|------------------|-----------|----------|------|----------|
| Batchparser.dll                              | 2015.131.5830.85 | 173960    | 01-Aug-2020 | 09:21 | x64      |
| Batchparser.dll                              | 2015.131.5830.85 | 153480    | 01-Aug-2020 | 09:33 | x86      |
| Bcp.exe                                      | 2015.131.5830.85 | 113048    | 01-Aug-2020 | 09:22 | x64      |
| Commanddest.dll                              | 2015.131.5830.85 | 242072    | 01-Aug-2020 | 09:21 | x64      |
| Datacollectorenumerators.dll                 | 2015.131.5830.85 | 108936    | 01-Aug-2020 | 09:21 | x64      |
| Datacollectortasks.dll                       | 2015.131.5830.85 | 181144    | 01-Aug-2020 | 09:21 | x64      |
| Distrib.exe                                  | 2015.131.5830.85 | 184208    | 01-Aug-2020 | 09:35 | x64      |
| Dteparse.dll                                 | 2015.131.5830.85 | 102808    | 01-Aug-2020 | 09:21 | x64      |
| Dteparsemgd.dll                              | 2015.131.5830.85 | 81808     | 01-Aug-2020 | 09:27 | x64      |
| Dtepkg.dll                                   | 2015.131.5830.85 | 130456    | 01-Aug-2020 | 09:21 | x64      |
| Dtexec.exe                                   | 2015.131.5830.85 | 65944     | 01-Aug-2020 | 09:36 | x64      |
| Dts.dll                                      | 2015.131.5830.85 | 3139480   | 01-Aug-2020 | 09:21 | x64      |
| Dtscomexpreval.dll                           | 2015.131.5830.85 | 470424    | 01-Aug-2020 | 09:21 | x64      |
| Dtsconn.dll                                  | 2015.131.5830.85 | 485776    | 01-Aug-2020 | 09:21 | x64      |
| Dtshost.exe                                  | 2015.131.5830.85 | 79768     | 01-Aug-2020 | 09:35 | x64      |
| Dtslog.dll                                   | 2015.131.5830.85 | 113552    | 01-Aug-2020 | 09:21 | x64      |
| Dtsmsg130.dll                                | 2015.131.5830.85 | 538520    | 01-Aug-2020 | 09:21 | x64      |
| Dtspipeline.dll                              | 2015.131.5830.85 | 1272208   | 01-Aug-2020 | 09:21 | x64      |
| Dtspipelineperf130.dll                       | 2015.131.5830.85 | 41352     | 01-Aug-2020 | 09:22 | x64      |
| Dtuparse.dll                                 | 2015.131.5830.85 | 80784     | 01-Aug-2020 | 09:21 | x64      |
| Dtutil.exe                                   | 2015.131.5830.85 | 127888    | 01-Aug-2020 | 09:35 | x64      |
| Exceldest.dll                                | 2015.131.5830.85 | 256400    | 01-Aug-2020 | 09:21 | x64      |
| Excelsrc.dll                                 | 2015.131.5830.85 | 278416    | 01-Aug-2020 | 09:21 | x64      |
| Execpackagetask.dll                          | 2015.131.5830.85 | 159632    | 01-Aug-2020 | 09:21 | x64      |
| Flatfiledest.dll                             | 2015.131.5830.85 | 382344    | 01-Aug-2020 | 09:21 | x64      |
| Flatfilesrc.dll                              | 2015.131.5830.85 | 394632    | 01-Aug-2020 | 09:21 | x64      |
| Foreachfileenumerator.dll                    | 2015.131.5830.85 | 89480     | 01-Aug-2020 | 09:21 | x64      |
| Hkengperfctrs.dll                            | 2015.131.5830.85 | 52120     | 01-Aug-2020 | 09:20 | x64      |
| Logread.exe                                  | 2015.131.5830.85 | 619920    | 01-Aug-2020 | 09:35 | x64      |
| Microsoft.analysisservices.applocal.core.dll | 13.0.5830.85     | 1307032   | 01-Aug-2020 | 09:27 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll | 13.0.5830.85     | 385416    | 01-Aug-2020 | 09:25 | x86      |
| Microsoft.sqlserver.replication.dll          | 2015.131.5830.85 | 1644440   | 01-Aug-2020 | 09:24 | x64      |
| Microsoft.sqlserver.rmo.dll                  | 13.0.5830.85     | 562576    | 01-Aug-2020 | 09:25 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5830.85 | 143256    | 01-Aug-2020 | 09:33 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5830.85 | 151960    | 01-Aug-2020 | 09:28 | x64      |
| Msdtssrvrutil.dll                            | 2015.131.5830.85 | 94616     | 01-Aug-2020 | 09:19 | x64      |
| Msxmlsql.dll                                 | 2015.131.5830.85 | 1487760   | 01-Aug-2020 | 09:20 | x64      |
| Oledbdest.dll                                | 2015.131.5830.85 | 257432    | 01-Aug-2020 | 09:20 | x64      |
| Oledbsrc.dll                                 | 2015.131.5830.85 | 284056    | 01-Aug-2020 | 09:20 | x64      |
| Osql.exe                                     | 2015.131.5830.85 | 68488     | 01-Aug-2020 | 09:21 | x64      |
| Rawdest.dll                                  | 2015.131.5830.85 | 202648    | 01-Aug-2020 | 09:20 | x64      |
| Rawsource.dll                                | 2015.131.5830.85 | 189848    | 01-Aug-2020 | 09:20 | x64      |
| Rdistcom.dll                                 | 2015.131.5830.85 | 900488    | 01-Aug-2020 | 09:21 | x64      |
| Recordsetdest.dll                            | 2015.131.5830.85 | 180120    | 01-Aug-2020 | 09:20 | x64      |
| Repldp.dll                                   | 2015.131.5830.85 | 274840    | 01-Aug-2020 | 09:20 | x64      |
| Replmerg.exe                                 | 2015.131.5830.85 | 511888    | 01-Aug-2020 | 09:35 | x64      |
| Replprov.dll                                 | 2015.131.5830.85 | 805272    | 01-Aug-2020 | 09:21 | x64      |
| Replrec.dll                                  | 2015.131.5830.85 | 1012104   | 01-Aug-2020 | 09:23 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2015.131.5830.85 | 93584     | 01-Aug-2020 | 09:21 | x64      |
| Sqlcmd.exe                                   | 2015.131.5830.85 | 242584    | 01-Aug-2020 | 09:22 | x64      |
| Sqldiag.exe                                  | 2015.131.5830.85 | 1250704   | 01-Aug-2020 | 09:35 | x64      |
| Sqllogship.exe                               | 13.0.5830.85     | 97680     | 01-Aug-2020 | 09:21 | x64      |
| Sqlresld.dll                                 | 2015.131.5830.85 | 23960     | 01-Aug-2020 | 09:31 | x64      |
| Sqlresld.dll                                 | 2015.131.5830.85 | 21912     | 01-Aug-2020 | 09:31 | x86      |
| Sqlresourceloader.dll                        | 2015.131.5830.85 | 23960     | 01-Aug-2020 | 09:31 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5830.85 | 21384     | 01-Aug-2020 | 09:31 | x86      |
| Sqlscm.dll                                   | 2015.131.5830.85 | 54152     | 01-Aug-2020 | 09:20 | x64      |
| Sqlscm.dll                                   | 2015.131.5830.85 | 45968     | 01-Aug-2020 | 09:32 | x86      |
| Sqlsvc.dll                                   | 2015.131.5830.85 | 145304    | 01-Aug-2020 | 09:31 | x64      |
| Sqlsvc.dll                                   | 2015.131.5830.85 | 120216    | 01-Aug-2020 | 09:32 | x86      |
| Sqltaskconnections.dll                       | 2015.131.5830.85 | 173976    | 01-Aug-2020 | 09:31 | x64      |
| Sqlwep130.dll                                | 2015.131.5830.85 | 98712     | 01-Aug-2020 | 09:31 | x64      |
| Ssisoledb.dll                                | 2015.131.5830.85 | 209288    | 01-Aug-2020 | 09:31 | x64      |
| Tablediff.exe                                | 13.0.5830.85     | 79768     | 01-Aug-2020 | 09:21 | x64      |
| Txagg.dll                                    | 2015.131.5830.85 | 357784    | 01-Aug-2020 | 09:31 | x64      |
| Txbdd.dll                                    | 2015.131.5830.85 | 165784    | 01-Aug-2020 | 09:31 | x64      |
| Txdatacollector.dll                          | 2015.131.5830.85 | 360840    | 01-Aug-2020 | 09:31 | x64      |
| Txdataconvert.dll                            | 2015.131.5830.85 | 289688    | 01-Aug-2020 | 09:30 | x64      |
| Txderived.dll                                | 2015.131.5830.85 | 600984    | 01-Aug-2020 | 09:31 | x64      |
| Txlookup.dll                                 | 2015.131.5830.85 | 525208    | 01-Aug-2020 | 09:30 | x64      |
| Txmerge.dll                                  | 2015.131.5830.85 | 223640    | 01-Aug-2020 | 09:30 | x64      |
| Txmergejoin.dll                              | 2015.131.5830.85 | 271768    | 01-Aug-2020 | 09:30 | x64      |
| Txmulticast.dll                              | 2015.131.5830.85 | 121232    | 01-Aug-2020 | 09:30 | x64      |
| Txrowcount.dll                               | 2015.131.5830.85 | 119704    | 01-Aug-2020 | 09:30 | x64      |
| Txsort.dll                                   | 2015.131.5830.85 | 252312    | 01-Aug-2020 | 09:31 | x64      |
| Txsplit.dll                                  | 2015.131.5830.85 | 593808    | 01-Aug-2020 | 09:30 | x64      |
| Txunionall.dll                               | 2015.131.5830.85 | 174984    | 01-Aug-2020 | 09:30 | x64      |
| Xe.dll                                       | 2015.131.5830.85 | 619400    | 01-Aug-2020 | 09:21 | x64      |
| Xmlrw.dll                                    | 2015.131.5830.85 | 312216    | 01-Aug-2020 | 09:20 | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version     | File size | Date     | Time | Platform |
|-------------------------------|------------------|-----------|----------|------|----------|
| Launchpad.exe                 | 2015.131.5830.85 | 1008536   | 01-Aug-2020 | 09:22 | x64      |
| Sql_extensibility_keyfile.dll | 2015.131.5830.85 | 93584     | 01-Aug-2020 | 09:21 | x64      |
| Sqlsatellite.dll              | 2015.131.5830.85 | 831376    | 01-Aug-2020 | 09:20 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version     | File size | Date     | Time | Platform |
|--------------------------|------------------|-----------|----------|------|----------|
| Fd.dll                   | 2015.131.5830.85 | 653208    | 01-Aug-2020 | 09:21 | x64      |
| Fdhost.exe               | 2015.131.5830.85 | 98200     | 01-Aug-2020 | 09:24 | x64      |
| Fdlauncher.exe           | 2015.131.5830.85 | 44432     | 01-Aug-2020 | 09:21 | x64      |
| Sql_fulltext_keyfile.dll | 2015.131.5830.85 | 93584     | 01-Aug-2020 | 09:21 | x64      |
| Sqlft130ph.dll           | 2015.131.5830.85 | 51096     | 01-Aug-2020 | 09:20 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version     | File size | Date     | Time | Platform |
|-------------------------|------------------|-----------|----------|------|----------|
| Imrdll.dll              | 13.0.5830.85     | 16776     | 01-Aug-2020 | 09:27 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.131.5830.85 | 93584     | 01-Aug-2020 | 09:21 | x64      |

SQL Server 2016 Integration Services

| File   name                                                   | File version     | File size | Date      | Time  | Platform |
|---------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 4.0.0.111        | 77944     | 07-Jul-2020  | 10:05 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 4.0.0.111        | 77944     | 20-Jul-20 | 10:16 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 4.0.0.111        | 37496     | 07-Jul-2020  | 10:05 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 4.0.0.111        | 37496     | 20-Jul-20 | 10:16 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 4.0.0.111        | 78456     | 07-Jul-2020  | 10:05 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 4.0.0.111        | 78456     | 20-Jul-20 | 10:16 | x86      |
| Commanddest.dll                                               | 2015.131.5830.85 | 242072    | 01-Aug-2020  | 09:21  | x64      |
| Commanddest.dll                                               | 2015.131.5830.85 | 195976    | 01-Aug-2020  | 09:33  | x86      |
| Dteparse.dll                                                  | 2015.131.5830.85 | 102808    | 01-Aug-2020  | 09:21  | x64      |
| Dteparse.dll                                                  | 2015.131.5830.85 | 92552     | 01-Aug-2020  | 09:32  | x86      |
| Dteparsemgd.dll                                               | 2015.131.5830.85 | 81808     | 01-Aug-2020  | 09:27  | x64      |
| Dteparsemgd.dll                                               | 2015.131.5830.85 | 76696     | 01-Aug-2020  | 09:30  | x86      |
| Dtepkg.dll                                                    | 2015.131.5830.85 | 130456    | 01-Aug-2020  | 09:21  | x64      |
| Dtepkg.dll                                                    | 2015.131.5830.85 | 108936    | 01-Aug-2020  | 09:33  | x86      |
| Dtexec.exe                                                    | 2015.131.5830.85 | 59784     | 01-Aug-2020  | 09:35  | x86      |
| Dtexec.exe                                                    | 2015.131.5830.85 | 65944     | 01-Aug-2020  | 09:36  | x64      |
| Dts.dll                                                       | 2015.131.5830.85 | 3139480   | 01-Aug-2020  | 09:21  | x64      |
| Dts.dll                                                       | 2015.131.5830.85 | 2625928   | 01-Aug-2020  | 09:33  | x86      |
| Dtscomexpreval.dll                                            | 2015.131.5830.85 | 470424    | 01-Aug-2020  | 09:21  | x64      |
| Dtscomexpreval.dll                                            | 2015.131.5830.85 | 412040    | 01-Aug-2020  | 09:32  | x86      |
| Dtsconn.dll                                                   | 2015.131.5830.85 | 485776    | 01-Aug-2020  | 09:21  | x64      |
| Dtsconn.dll                                                   | 2015.131.5830.85 | 385416    | 01-Aug-2020  | 09:33  | x86      |
| Dtsdebughost.exe                                              | 2015.131.5830.85 | 102808    | 01-Aug-2020  | 09:35  | x64      |
| Dtsdebughost.exe                                              | 2015.131.5830.85 | 86936     | 01-Aug-2020  | 09:35  | x86      |
| Dtshost.exe                                                   | 2015.131.5830.85 | 69528     | 01-Aug-2020  | 09:34  | x86      |
| Dtshost.exe                                                   | 2015.131.5830.85 | 79768     | 01-Aug-2020  | 09:35  | x64      |
| Dtslog.dll                                                    | 2015.131.5830.85 | 113552    | 01-Aug-2020  | 09:21  | x64      |
| Dtslog.dll                                                    | 2015.131.5830.85 | 96144     | 01-Aug-2020  | 09:32  | x86      |
| Dtsmsg130.dll                                                 | 2015.131.5830.85 | 538520    | 01-Aug-2020  | 09:21  | x64      |
| Dtsmsg130.dll                                                 | 2015.131.5830.85 | 534424    | 01-Aug-2020  | 09:33  | x86      |
| Dtspipeline.dll                                               | 2015.131.5830.85 | 1272208   | 01-Aug-2020  | 09:21  | x64      |
| Dtspipeline.dll                                               | 2015.131.5830.85 | 1052560   | 01-Aug-2020  | 09:32  | x86      |
| Dtspipelineperf130.dll                                        | 2015.131.5830.85 | 41352     | 01-Aug-2020  | 09:22  | x64      |
| Dtspipelineperf130.dll                                        | 2015.131.5830.85 | 35224     | 01-Aug-2020  | 09:33  | x86      |
| Dtuparse.dll                                                  | 2015.131.5830.85 | 80784     | 01-Aug-2020  | 09:21  | x64      |
| Dtuparse.dll                                                  | 2015.131.5830.85 | 73096     | 01-Aug-2020  | 09:33  | x86      |
| Dtutil.exe                                                    | 2015.131.5830.85 | 108432    | 01-Aug-2020  | 09:35  | x86      |
| Dtutil.exe                                                    | 2015.131.5830.85 | 127888    | 01-Aug-2020  | 09:35  | x64      |
| Exceldest.dll                                                 | 2015.131.5830.85 | 256400    | 01-Aug-2020  | 09:21  | x64      |
| Exceldest.dll                                                 | 2015.131.5830.85 | 209816    | 01-Aug-2020  | 09:34  | x86      |
| Excelsrc.dll                                                  | 2015.131.5830.85 | 278416    | 01-Aug-2020  | 09:21  | x64      |
| Excelsrc.dll                                                  | 2015.131.5830.85 | 225672    | 01-Aug-2020  | 09:32  | x86      |
| Execpackagetask.dll                                           | 2015.131.5830.85 | 159632    | 01-Aug-2020  | 09:21  | x64      |
| Execpackagetask.dll                                           | 2015.131.5830.85 | 128392    | 01-Aug-2020  | 09:32  | x86      |
| Flatfiledest.dll                                              | 2015.131.5830.85 | 382344    | 01-Aug-2020  | 09:21  | x64      |
| Flatfiledest.dll                                              | 2015.131.5830.85 | 327568    | 01-Aug-2020  | 09:33  | x86      |
| Flatfilesrc.dll                                               | 2015.131.5830.85 | 394632    | 01-Aug-2020  | 09:21  | x64      |
| Flatfilesrc.dll                                               | 2015.131.5830.85 | 338328    | 01-Aug-2020  | 09:33  | x86      |
| Foreachfileenumerator.dll                                     | 2015.131.5830.85 | 89480     | 01-Aug-2020  | 09:21  | x64      |
| Foreachfileenumerator.dll                                     | 2015.131.5830.85 | 73608     | 01-Aug-2020  | 09:32  | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 13.0.5830.85     | 1307032   | 01-Aug-2020  | 09:27  | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 13.0.5830.85     | 1307024   | 01-Aug-2020  | 09:30  | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435      | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 13.0.5830.85     | 66456     | 01-Aug-2020  | 09:25  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2015.131.5830.85 | 100232    | 01-Aug-2020  | 09:22  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2015.131.5830.85 | 105368    | 01-Aug-2020  | 09:24  | x64      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.5830.85     | 478616    | 01-Aug-2020  | 09:23  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.5830.85     | 478608    | 01-Aug-2020  | 09:25  | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 13.0.5830.85     | 75672     | 31-Jul-20 | 21:44 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 13.0.5830.85     | 75672     | 01-Aug-2020  | 09:24  | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 13.0.5830.85     | 385416    | 01-Aug-2020  | 09:25  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2015.131.5830.85 | 131984    | 01-Aug-2020  | 09:21  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2015.131.5830.85 | 143256    | 01-Aug-2020  | 09:33  | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2015.131.5830.85 | 137624    | 01-Aug-2020  | 09:21  | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2015.131.5830.85 | 151960    | 01-Aug-2020  | 09:28  | x64      |
| Msdtssrvr.exe                                                 | 13.0.5830.85     | 210328    | 01-Aug-2020  | 09:20  | x64      |
| Msdtssrvrutil.dll                                             | 2015.131.5830.85 | 94616     | 01-Aug-2020  | 09:19  | x64      |
| Msdtssrvrutil.dll                                             | 2015.131.5830.85 | 83336     | 01-Aug-2020  | 09:33  | x86      |
| Oledbdest.dll                                                 | 2015.131.5830.85 | 257432    | 01-Aug-2020  | 09:20  | x64      |
| Oledbdest.dll                                                 | 2015.131.5830.85 | 209816    | 01-Aug-2020  | 09:32  | x86      |
| Oledbsrc.dll                                                  | 2015.131.5830.85 | 284056    | 01-Aug-2020  | 09:20  | x64      |
| Oledbsrc.dll                                                  | 2015.131.5830.85 | 228744    | 01-Aug-2020  | 09:34  | x86      |
| Rawdest.dll                                                   | 2015.131.5830.85 | 202648    | 01-Aug-2020  | 09:20  | x64      |
| Rawdest.dll                                                   | 2015.131.5830.85 | 161688    | 01-Aug-2020  | 09:32  | x86      |
| Rawsource.dll                                                 | 2015.131.5830.85 | 189848    | 01-Aug-2020  | 09:20  | x64      |
| Rawsource.dll                                                 | 2015.131.5830.85 | 148376    | 01-Aug-2020  | 09:32  | x86      |
| Recordsetdest.dll                                             | 2015.131.5830.85 | 180120    | 01-Aug-2020  | 09:20  | x64      |
| Recordsetdest.dll                                             | 2015.131.5830.85 | 144792    | 01-Aug-2020  | 09:32  | x86      |
| Sql_is_keyfile.dll                                            | 2015.131.5830.85 | 93584     | 01-Aug-2020  | 09:21  | x64      |
| Sqlceip.exe                                                   | 13.0.5830.85     | 249240    | 01-Aug-2020  | 09:20  | x86      |
| Sqldest.dll                                                   | 2015.131.5830.85 | 256920    | 01-Aug-2020  | 09:20  | x64      |
| Sqldest.dll                                                   | 2015.131.5830.85 | 208784    | 01-Aug-2020  | 09:32  | x86      |
| Sqltaskconnections.dll                                        | 2015.131.5830.85 | 173976    | 01-Aug-2020  | 09:31  | x64      |
| Sqltaskconnections.dll                                        | 2015.131.5830.85 | 144280    | 01-Aug-2020  | 09:31  | x86      |
| Ssisoledb.dll                                                 | 2015.131.5830.85 | 209288    | 01-Aug-2020  | 09:31  | x64      |
| Ssisoledb.dll                                                 | 2015.131.5830.85 | 169880    | 01-Aug-2020  | 09:32  | x86      |
| Txagg.dll                                                     | 2015.131.5830.85 | 297872    | 01-Aug-2020  | 09:19  | x86      |
| Txagg.dll                                                     | 2015.131.5830.85 | 357784    | 01-Aug-2020  | 09:31  | x64      |
| Txbdd.dll                                                     | 2015.131.5830.85 | 130960    | 01-Aug-2020  | 09:19  | x86      |
| Txbdd.dll                                                     | 2015.131.5830.85 | 165784    | 01-Aug-2020  | 09:31  | x64      |
| Txbestmatch.dll                                               | 2015.131.5830.85 | 489352    | 01-Aug-2020  | 09:21  | x86      |
| Txbestmatch.dll                                               | 2015.131.5830.85 | 604568    | 01-Aug-2020  | 09:31  | x64      |
| Txcache.dll                                                   | 2015.131.5830.85 | 141200    | 01-Aug-2020  | 09:19  | x86      |
| Txcache.dll                                                   | 2015.131.5830.85 | 176536    | 01-Aug-2020  | 09:31  | x64      |
| Txcharmap.dll                                                 | 2015.131.5830.85 | 243608    | 01-Aug-2020  | 09:20  | x86      |
| Txcharmap.dll                                                 | 2015.131.5830.85 | 283032    | 01-Aug-2020  | 09:31  | x64      |
| Txcopymap.dll                                                 | 2015.131.5830.85 | 140688    | 01-Aug-2020  | 09:20  | x86      |
| Txcopymap.dll                                                 | 2015.131.5830.85 | 176024    | 01-Aug-2020  | 09:30  | x64      |
| Txdataconvert.dll                                             | 2015.131.5830.85 | 248216    | 01-Aug-2020  | 09:19  | x86      |
| Txdataconvert.dll                                             | 2015.131.5830.85 | 289688    | 01-Aug-2020  | 09:30  | x64      |
| Txderived.dll                                                 | 2015.131.5830.85 | 512408    | 01-Aug-2020  | 09:19  | x86      |
| Txderived.dll                                                 | 2015.131.5830.85 | 600984    | 01-Aug-2020  | 09:31  | x64      |
| Txfileextractor.dll                                           | 2015.131.5830.85 | 156056    | 01-Aug-2020  | 09:20  | x86      |
| Txfileextractor.dll                                           | 2015.131.5830.85 | 194968    | 01-Aug-2020  | 09:30  | x64      |
| Txfileinserter.dll                                            | 2015.131.5830.85 | 154008    | 01-Aug-2020  | 09:20  | x86      |
| Txfileinserter.dll                                            | 2015.131.5830.85 | 192920    | 01-Aug-2020  | 09:30  | x64      |
| Txgroupdups.dll                                               | 2015.131.5830.85 | 224656    | 01-Aug-2020  | 09:19  | x86      |
| Txgroupdups.dll                                               | 2015.131.5830.85 | 284040    | 01-Aug-2020  | 09:30  | x64      |
| Txlineage.dll                                                 | 2015.131.5830.85 | 102800    | 01-Aug-2020  | 09:19  | x86      |
| Txlineage.dll                                                 | 2015.131.5830.85 | 130960    | 01-Aug-2020  | 09:30  | x64      |
| Txlookup.dll                                                  | 2015.131.5830.85 | 442760    | 01-Aug-2020  | 09:19  | x86      |
| Txlookup.dll                                                  | 2015.131.5830.85 | 525208    | 01-Aug-2020  | 09:30  | x64      |
| Txmerge.dll                                                   | 2015.131.5830.85 | 169880    | 01-Aug-2020  | 09:19  | x86      |
| Txmerge.dll                                                   | 2015.131.5830.85 | 223640    | 01-Aug-2020  | 09:30  | x64      |
| Txmergejoin.dll                                               | 2015.131.5830.85 | 216984    | 01-Aug-2020  | 09:20  | x86      |
| Txmergejoin.dll                                               | 2015.131.5830.85 | 271768    | 01-Aug-2020  | 09:30  | x64      |
| Txmulticast.dll                                               | 2015.131.5830.85 | 95120     | 01-Aug-2020  | 09:19  | x86      |
| Txmulticast.dll                                               | 2015.131.5830.85 | 121232    | 01-Aug-2020  | 09:30  | x64      |
| Txpivot.dll                                                   | 2015.131.5830.85 | 175000    | 01-Aug-2020  | 09:19  | x86      |
| Txpivot.dll                                                   | 2015.131.5830.85 | 221080    | 01-Aug-2020  | 09:30  | x64      |
| Txrowcount.dll                                                | 2015.131.5830.85 | 94616     | 01-Aug-2020  | 09:20  | x86      |
| Txrowcount.dll                                                | 2015.131.5830.85 | 119704    | 01-Aug-2020  | 09:30  | x64      |
| Txsampling.dll                                                | 2015.131.5830.85 | 127888    | 01-Aug-2020  | 09:19  | x86      |
| Txsampling.dll                                                | 2015.131.5830.85 | 165272    | 01-Aug-2020  | 09:30  | x64      |
| Txscd.dll                                                     | 2015.131.5830.85 | 162712    | 01-Aug-2020  | 09:19  | x86      |
| Txscd.dll                                                     | 2015.131.5830.85 | 213400    | 01-Aug-2020  | 09:30  | x64      |
| Txsort.dll                                                    | 2015.131.5830.85 | 204176    | 01-Aug-2020  | 09:20  | x86      |
| Txsort.dll                                                    | 2015.131.5830.85 | 252312    | 01-Aug-2020  | 09:31  | x64      |
| Txsplit.dll                                                   | 2015.131.5830.85 | 506264    | 01-Aug-2020  | 09:20  | x86      |
| Txsplit.dll                                                   | 2015.131.5830.85 | 593808    | 01-Aug-2020  | 09:30  | x64      |
| Txtermextraction.dll                                          | 2015.131.5830.85 | 8608664   | 01-Aug-2020  | 09:21  | x86      |
| Txtermextraction.dll                                          | 2015.131.5830.85 | 8671128   | 01-Aug-2020  | 09:31  | x64      |
| Txtermlookup.dll                                              | 2015.131.5830.85 | 4099992   | 01-Aug-2020  | 09:19  | x86      |
| Txtermlookup.dll                                              | 2015.131.5830.85 | 4151696   | 01-Aug-2020  | 09:30  | x64      |
| Txunionall.dll                                                | 2015.131.5830.85 | 131992    | 01-Aug-2020  | 09:19  | x86      |
| Txunionall.dll                                                | 2015.131.5830.85 | 174984    | 01-Aug-2020  | 09:30  | x64      |
| Txunpivot.dll                                                 | 2015.131.5830.85 | 155544    | 01-Aug-2020  | 09:19  | x86      |
| Txunpivot.dll                                                 | 2015.131.5830.85 | 194968    | 01-Aug-2020  | 09:30  | x64      |
| Xe.dll                                                        | 2015.131.5830.85 | 619400    | 01-Aug-2020  | 09:21  | x64      |
| Xe.dll                                                        | 2015.131.5830.85 | 551832    | 01-Aug-2020  | 09:31  | x86      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date     | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|----------|-------|----------|
| Dms.dll                                                              | 10.0.8224.49     | 483624    | 09-May-2019 | 19:33 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.49 | 75560     | 09-May-2019 | 19:33 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.49     | 45864     | 09-May-2019 | 19:33 | x86      |
| Instapi130.dll                                                       | 2015.131.5830.85 | 54160     | 01-Aug-2020 | 09:30  | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 10.0.8224.49     | 74536     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 10.0.8224.49     | 202024    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 10.0.8224.49     | 2347304   | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 10.0.8224.49     | 102184    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 10.0.8224.49     | 378664    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 10.0.8224.49     | 185640    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 10.0.8224.49     | 127272    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 10.0.8224.49     | 63272     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 10.0.8224.49     | 52520     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 10.0.8224.49     | 87336     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 10.0.8224.49     | 721704    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 10.0.8224.49     | 87336     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 10.0.8224.49     | 78120     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 10.0.8224.49     | 41768     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 10.0.8224.49     | 36648     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 10.0.8224.49     | 47912     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 10.0.8224.49     | 27432     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 10.0.8224.49     | 33064     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 10.0.8224.49     | 119080    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 10.0.8224.49     | 94504     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 10.0.8224.49     | 108328    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 10.0.8224.49     | 256808    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 102184    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 116008    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 119080    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 116008    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 125736    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 118056    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 113448    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 145704    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 100136    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 114984    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 10.0.8224.49     | 69416     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 10.0.8224.49     | 28456     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 10.0.8224.49     | 43816     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 10.0.8224.49     | 82216     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 10.0.8224.49     | 137000    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 10.0.8224.49     | 2155816   | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 10.0.8224.49     | 3818792   | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 107816    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 120104    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 124712    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 121128    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 133408    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 121128    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 118568    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 152360    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 105280    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 119592    | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 10.0.8224.49     | 66856     | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 10.0.8224.49     | 2756392   | 09-May-2019 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 10.0.8224.49     | 752424    | 09-May-2019 | 19:33 | x86      |
| Mpdwinterop.dll                                                      | 2015.131.5830.85 | 387984    | 01-Aug-2020 | 09:19  | x64      |
| Mpdwsvc.exe                                                          | 2015.131.5830.85 | 6612368   | 01-Aug-2020 | 09:22  | x64      |
| Pdwodbcsql11.dll                                                     | 2015.131.5830.85 | 2223496   | 01-Aug-2020 | 09:30  | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.49 | 47400     | 09-May-2019 | 19:33 | x64      |
| Sqldk.dll                                                            | 2015.131.5830.85 | 2532744   | 01-Aug-2020 | 09:30  | x64      |
| Sqldumper.exe                                                        | 2015.131.5830.85 | 123272    | 01-Aug-2020 | 09:22  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5830.85 | 1434520   | 01-Aug-2020 | 09:36  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5830.85 | 3749768   | 01-Aug-2020 | 09:25  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5830.85 | 3080592   | 01-Aug-2020 | 09:30  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5830.85 | 3751304   | 01-Aug-2020 | 09:22  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5830.85 | 3654544   | 01-Aug-2020 | 09:36  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5830.85 | 2002824   | 01-Aug-2020 | 09:35  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5830.85 | 1948568   | 01-Aug-2020 | 09:35  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5830.85 | 3436944   | 01-Aug-2020 | 09:34  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5830.85 | 3448720   | 01-Aug-2020 | 09:33  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5830.85 | 1384344   | 01-Aug-2020 | 09:31  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5830.85 | 3623832   | 01-Aug-2020 | 09:30  | x64      |
| Sqlos.dll                                                            | 2015.131.5830.85 | 19344     | 01-Aug-2020 | 09:30  | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.49 | 4348200   | 09-May-2019 | 19:33 | x64      |
| Sqltses.dll                                                          | 2015.131.5830.85 | 9085848   | 01-Aug-2020 | 09:31  | x64      |

SQL Server 2016 Reporting Services

| File   name                                               | File version     | File size | Date     | Time | Platform |
|-----------------------------------------------------------|------------------|-----------|----------|------|----------|
| Microsoft.analysisservices.modeling.dll                   | 13.0.5830.85     | 604056    | 01-Aug-2020 | 09:28 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.5830.85     | 1613712   | 01-Aug-2020 | 09:25 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.5830.85     | 651664    | 01-Aug-2020 | 09:26 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.5830.85     | 322968    | 01-Aug-2020 | 09:26 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.5830.85     | 1083800   | 01-Aug-2020 | 09:26 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5830.85     | 541576    | 01-Aug-2020 | 09:21 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5830.85     | 541584    | 01-Aug-2020 | 09:24 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5830.85     | 541584    | 01-Aug-2020 | 09:26 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5830.85     | 541592    | 01-Aug-2020 | 09:37 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5830.85     | 541592    | 01-Aug-2020 | 09:30 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5830.85     | 541576    | 01-Aug-2020 | 09:36 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5830.85     | 541592    | 01-Aug-2020 | 09:18 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5830.85     | 541592    | 01-Aug-2020 | 09:31 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5830.85     | 541584    | 01-Aug-2020 | 09:29 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5830.85     | 541584    | 01-Aug-2020 | 09:35 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.5830.85     | 156056    | 01-Aug-2020 | 09:25 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.5830.85     | 119176    | 01-Aug-2020 | 09:25 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.5830.85     | 6069648   | 01-Aug-2020 | 09:24 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5830.85     | 4504464   | 01-Aug-2020 | 09:20 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5830.85     | 4504984   | 01-Aug-2020 | 09:25 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5830.85     | 4504968   | 01-Aug-2020 | 09:27 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5830.85     | 4504984   | 01-Aug-2020 | 09:37 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5830.85     | 4505488   | 01-Aug-2020 | 09:30 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5830.85     | 4505496   | 01-Aug-2020 | 09:38 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5830.85     | 4504984   | 01-Aug-2020 | 09:19 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5830.85     | 4506008   | 01-Aug-2020 | 09:31 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5830.85     | 4504464   | 01-Aug-2020 | 09:29 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5830.85     | 4504968   | 01-Aug-2020 | 09:36 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.5830.85     | 10920856  | 01-Aug-2020 | 09:24 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.5830.85     | 96136     | 01-Aug-2020 | 09:20 | x64      |
| Microsoft.reportingservices.storage.dll                   | 13.0.5830.85     | 202136    | 01-Aug-2020 | 09:24 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.131.5830.85 | 40856     | 01-Aug-2020 | 09:24 | x64      |
| Microsoft.sqlserver.types.dll                             | 2015.131.5830.85 | 390040    | 01-Aug-2020 | 09:27 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.131.5830.85 | 385928    | 01-Aug-2020 | 09:29 | x86      |
| Msmdlocal.dll                                             | 2015.131.5830.85 | 56245136  | 01-Aug-2020 | 09:22 | x64      |
| Msmdlocal.dll                                             | 2015.131.5830.85 | 37128088  | 01-Aug-2020 | 09:33 | x86      |
| Msmgdsrv.dll                                              | 2015.131.5830.85 | 7502728   | 01-Aug-2020 | 09:24 | x64      |
| Msmgdsrv.dll                                              | 2015.131.5830.85 | 6502296   | 01-Aug-2020 | 09:31 | x86      |
| Msolap130.dll                                             | 2015.131.5830.85 | 8636296   | 01-Aug-2020 | 09:21 | x64      |
| Msolap130.dll                                             | 2015.131.5830.85 | 7004048   | 01-Aug-2020 | 09:33 | x86      |
| Msolui130.dll                                             | 2015.131.5830.85 | 303512    | 01-Aug-2020 | 09:20 | x64      |
| Msolui130.dll                                             | 2015.131.5830.85 | 280464    | 01-Aug-2020 | 09:32 | x86      |
| Reportingservicescompression.dll                          | 2015.131.5830.85 | 55704     | 01-Aug-2020 | 09:20 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.5830.85     | 77704     | 01-Aug-2020 | 09:22 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.5830.85     | 2536840   | 01-Aug-2020 | 09:23 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.131.5830.85 | 101776    | 01-Aug-2020 | 09:23 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.131.5830.85 | 107416    | 01-Aug-2020 | 09:30 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.131.5830.85 | 92048     | 01-Aug-2020 | 09:22 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.5830.85     | 2722712   | 01-Aug-2020 | 09:23 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5830.85     | 877448    | 01-Aug-2020 | 09:36 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5830.85     | 881552    | 01-Aug-2020 | 09:39 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5830.85     | 881560    | 01-Aug-2020 | 09:31 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5830.85     | 881560    | 01-Aug-2020 | 09:27 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5830.85     | 885648    | 01-Aug-2020 | 09:34 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5830.85     | 881560    | 01-Aug-2020 | 09:35 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5830.85     | 881560    | 01-Aug-2020 | 09:34 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5830.85     | 893848    | 01-Aug-2020 | 09:38 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5830.85     | 877448    | 01-Aug-2020 | 09:37 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5830.85     | 881552    | 01-Aug-2020 | 09:28 | x86      |
| Rshttpruntime.dll                                         | 2015.131.5830.85 | 92568     | 01-Aug-2020 | 09:22 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.131.5830.85 | 93584     | 01-Aug-2020 | 09:21 | x64      |
| Sqldumper.exe                                             | 2015.131.5830.85 | 123280    | 01-Aug-2020 | 09:21 | x64      |
| Sqldumper.exe                                             | 2015.131.5830.85 | 103824    | 01-Aug-2020 | 09:33 | x86      |
| Sqlrsos.dll                                               | 2015.131.5830.85 | 19352     | 01-Aug-2020 | 09:31 | x64      |
| Sqlserverspatial130.dll                                   | 2015.131.5830.85 | 725896    | 01-Aug-2020 | 09:22 | x64      |
| Sqlserverspatial130.dll                                   | 2015.131.5830.85 | 577432    | 01-Aug-2020 | 09:32 | x86      |
| Xmlrw.dll                                                 | 2015.131.5830.85 | 252816    | 01-Aug-2020 | 09:19 | x86      |
| Xmlrw.dll                                                 | 2015.131.5830.85 | 312216    | 01-Aug-2020 | 09:20 | x64      |
| Xmlrwbin.dll                                              | 2015.131.5830.85 | 184712    | 01-Aug-2020 | 09:19 | x86      |
| Xmlrwbin.dll                                              | 2015.131.5830.85 | 220552    | 01-Aug-2020 | 09:22 | x64      |
| Xmsrv.dll                                                 | 2015.131.5830.85 | 32721288  | 01-Aug-2020 | 09:20 | x86      |
| Xmsrv.dll                                                 | 2015.131.5830.85 | 24041368  | 01-Aug-2020 | 09:32 | x64      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version     | File size | Date     | Time | Platform |
|------------------------------------|------------------|-----------|----------|------|----------|
| Smrdll.dll                         | 13.0.5830.85     | 16792     | 01-Aug-2020 | 09:22 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.131.5830.85 | 93584     | 01-Aug-2020 | 09:21 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                    | File version     | File size | Date     | Time | Platform |
|------------------------------------------------|------------------|-----------|----------|------|----------|
| Autoadmin.dll                                  | 2015.131.5830.85 | 1304984   | 01-Aug-2020 | 09:33 | x86      |
| Ddsshapes.dll                                  | 2015.131.5830.85 | 128920    | 01-Aug-2020 | 09:33 | x86      |
| Dtaengine.exe                                  | 2015.131.5830.85 | 160152    | 01-Aug-2020 | 09:34 | x86      |
| Dteparse.dll                                   | 2015.131.5830.85 | 102808    | 01-Aug-2020 | 09:21 | x64      |
| Dteparse.dll                                   | 2015.131.5830.85 | 92552     | 01-Aug-2020 | 09:32 | x86      |
| Dteparsemgd.dll                                | 2015.131.5830.85 | 81808     | 01-Aug-2020 | 09:27 | x64      |
| Dteparsemgd.dll                                | 2015.131.5830.85 | 76696     | 01-Aug-2020 | 09:30 | x86      |
| Dtepkg.dll                                     | 2015.131.5830.85 | 130456    | 01-Aug-2020 | 09:21 | x64      |
| Dtepkg.dll                                     | 2015.131.5830.85 | 108936    | 01-Aug-2020 | 09:33 | x86      |
| Dtexec.exe                                     | 2015.131.5830.85 | 59784     | 01-Aug-2020 | 09:35 | x86      |
| Dtexec.exe                                     | 2015.131.5830.85 | 65944     | 01-Aug-2020 | 09:36 | x64      |
| Dts.dll                                        | 2015.131.5830.85 | 3139480   | 01-Aug-2020 | 09:21 | x64      |
| Dts.dll                                        | 2015.131.5830.85 | 2625928   | 01-Aug-2020 | 09:33 | x86      |
| Dtscomexpreval.dll                             | 2015.131.5830.85 | 470424    | 01-Aug-2020 | 09:21 | x64      |
| Dtscomexpreval.dll                             | 2015.131.5830.85 | 412040    | 01-Aug-2020 | 09:32 | x86      |
| Dtsconn.dll                                    | 2015.131.5830.85 | 485776    | 01-Aug-2020 | 09:21 | x64      |
| Dtsconn.dll                                    | 2015.131.5830.85 | 385416    | 01-Aug-2020 | 09:33 | x86      |
| Dtshost.exe                                    | 2015.131.5830.85 | 69528     | 01-Aug-2020 | 09:34 | x86      |
| Dtshost.exe                                    | 2015.131.5830.85 | 79768     | 01-Aug-2020 | 09:35 | x64      |
| Dtslog.dll                                     | 2015.131.5830.85 | 113552    | 01-Aug-2020 | 09:21 | x64      |
| Dtslog.dll                                     | 2015.131.5830.85 | 96144     | 01-Aug-2020 | 09:32 | x86      |
| Dtsmsg130.dll                                  | 2015.131.5830.85 | 538520    | 01-Aug-2020 | 09:21 | x64      |
| Dtsmsg130.dll                                  | 2015.131.5830.85 | 534424    | 01-Aug-2020 | 09:33 | x86      |
| Dtspipeline.dll                                | 2015.131.5830.85 | 1272208   | 01-Aug-2020 | 09:21 | x64      |
| Dtspipeline.dll                                | 2015.131.5830.85 | 1052560   | 01-Aug-2020 | 09:32 | x86      |
| Dtspipelineperf130.dll                         | 2015.131.5830.85 | 41352     | 01-Aug-2020 | 09:22 | x64      |
| Dtspipelineperf130.dll                         | 2015.131.5830.85 | 35224     | 01-Aug-2020 | 09:33 | x86      |
| Dtuparse.dll                                   | 2015.131.5830.85 | 80784     | 01-Aug-2020 | 09:21 | x64      |
| Dtuparse.dll                                   | 2015.131.5830.85 | 73096     | 01-Aug-2020 | 09:33 | x86      |
| Dtutil.exe                                     | 2015.131.5830.85 | 108432    | 01-Aug-2020 | 09:35 | x86      |
| Dtutil.exe                                     | 2015.131.5830.85 | 127888    | 01-Aug-2020 | 09:35 | x64      |
| Exceldest.dll                                  | 2015.131.5830.85 | 256400    | 01-Aug-2020 | 09:21 | x64      |
| Exceldest.dll                                  | 2015.131.5830.85 | 209816    | 01-Aug-2020 | 09:34 | x86      |
| Excelsrc.dll                                   | 2015.131.5830.85 | 278416    | 01-Aug-2020 | 09:21 | x64      |
| Excelsrc.dll                                   | 2015.131.5830.85 | 225672    | 01-Aug-2020 | 09:32 | x86      |
| Flatfiledest.dll                               | 2015.131.5830.85 | 382344    | 01-Aug-2020 | 09:21 | x64      |
| Flatfiledest.dll                               | 2015.131.5830.85 | 327568    | 01-Aug-2020 | 09:33 | x86      |
| Flatfilesrc.dll                                | 2015.131.5830.85 | 394632    | 01-Aug-2020 | 09:21 | x64      |
| Flatfilesrc.dll                                | 2015.131.5830.85 | 338328    | 01-Aug-2020 | 09:33 | x86      |
| Foreachfileenumerator.dll                      | 2015.131.5830.85 | 89480     | 01-Aug-2020 | 09:21 | x64      |
| Foreachfileenumerator.dll                      | 2015.131.5830.85 | 73608     | 01-Aug-2020 | 09:32 | x86      |
| Microsoft.analysisservices.adomdclientui.dll   | 13.0.5830.85     | 85392     | 01-Aug-2020 | 09:29 | x86      |
| Microsoft.analysisservices.applocal.core.dll   | 13.0.5830.85     | 1307024   | 01-Aug-2020 | 09:30 | x86      |
| Microsoft.analysisservices.project.dll         | 2015.131.5830.85 | 2016664   | 01-Aug-2020 | 09:28 | x86      |
| Microsoft.analysisservices.projectui.dll       | 2015.131.5830.85 | 35208     | 01-Aug-2020 | 09:37 | x86      |
| Microsoft.sqlserver.astasks.dll                | 13.0.5830.85     | 66440     | 01-Aug-2020 | 09:22 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5830.85     | 428944    | 01-Aug-2020 | 09:22 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5830.85     | 428944    | 01-Aug-2020 | 09:23 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5830.85     | 2037648   | 01-Aug-2020 | 09:22 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5830.85     | 2037656   | 01-Aug-2020 | 09:23 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5830.85 | 131984    | 01-Aug-2020 | 09:21 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5830.85 | 143256    | 01-Aug-2020 | 09:33 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5830.85 | 137624    | 01-Aug-2020 | 09:21 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5830.85 | 151960    | 01-Aug-2020 | 09:28 | x64      |
| Msdtssrvrutil.dll                              | 2015.131.5830.85 | 94616     | 01-Aug-2020 | 09:19 | x64      |
| Msdtssrvrutil.dll                              | 2015.131.5830.85 | 83336     | 01-Aug-2020 | 09:33 | x86      |
| Msmdlocal.dll                                  | 2015.131.5830.85 | 56245136  | 01-Aug-2020 | 09:22 | x64      |
| Msmdlocal.dll                                  | 2015.131.5830.85 | 37128088  | 01-Aug-2020 | 09:33 | x86      |
| Msmgdsrv.dll                                   | 2015.131.5830.85 | 7502728   | 01-Aug-2020 | 09:24 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5830.85 | 6502296   | 01-Aug-2020 | 09:31 | x86      |
| Msolap130.dll                                  | 2015.131.5830.85 | 8636296   | 01-Aug-2020 | 09:21 | x64      |
| Msolap130.dll                                  | 2015.131.5830.85 | 7004048   | 01-Aug-2020 | 09:33 | x86      |
| Msolui130.dll                                  | 2015.131.5830.85 | 303512    | 01-Aug-2020 | 09:20 | x64      |
| Msolui130.dll                                  | 2015.131.5830.85 | 280464    | 01-Aug-2020 | 09:32 | x86      |
| Oledbdest.dll                                  | 2015.131.5830.85 | 257432    | 01-Aug-2020 | 09:20 | x64      |
| Oledbdest.dll                                  | 2015.131.5830.85 | 209816    | 01-Aug-2020 | 09:32 | x86      |
| Oledbsrc.dll                                   | 2015.131.5830.85 | 284056    | 01-Aug-2020 | 09:20 | x64      |
| Oledbsrc.dll                                   | 2015.131.5830.85 | 228744    | 01-Aug-2020 | 09:34 | x86      |
| Profiler.exe                                   | 2015.131.5830.85 | 797576    | 01-Aug-2020 | 09:30 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.131.5830.85 | 93584     | 01-Aug-2020 | 09:21 | x64      |
| Sqldumper.exe                                  | 2015.131.5830.85 | 123280    | 01-Aug-2020 | 09:21 | x64      |
| Sqldumper.exe                                  | 2015.131.5830.85 | 103824    | 01-Aug-2020 | 09:33 | x86      |
| Sqlresld.dll                                   | 2015.131.5830.85 | 23960     | 01-Aug-2020 | 09:31 | x64      |
| Sqlresld.dll                                   | 2015.131.5830.85 | 21912     | 01-Aug-2020 | 09:31 | x86      |
| Sqlresourceloader.dll                          | 2015.131.5830.85 | 23960     | 01-Aug-2020 | 09:31 | x64      |
| Sqlresourceloader.dll                          | 2015.131.5830.85 | 21384     | 01-Aug-2020 | 09:31 | x86      |
| Sqlscm.dll                                     | 2015.131.5830.85 | 54152     | 01-Aug-2020 | 09:20 | x64      |
| Sqlscm.dll                                     | 2015.131.5830.85 | 45968     | 01-Aug-2020 | 09:32 | x86      |
| Sqlsvc.dll                                     | 2015.131.5830.85 | 145304    | 01-Aug-2020 | 09:31 | x64      |
| Sqlsvc.dll                                     | 2015.131.5830.85 | 120216    | 01-Aug-2020 | 09:32 | x86      |
| Sqltaskconnections.dll                         | 2015.131.5830.85 | 173976    | 01-Aug-2020 | 09:31 | x64      |
| Sqltaskconnections.dll                         | 2015.131.5830.85 | 144280    | 01-Aug-2020 | 09:31 | x86      |
| Txdataconvert.dll                              | 2015.131.5830.85 | 248216    | 01-Aug-2020 | 09:19 | x86      |
| Txdataconvert.dll                              | 2015.131.5830.85 | 289688    | 01-Aug-2020 | 09:30 | x64      |
| Xe.dll                                         | 2015.131.5830.85 | 619400    | 01-Aug-2020 | 09:21 | x64      |
| Xe.dll                                         | 2015.131.5830.85 | 551832    | 01-Aug-2020 | 09:31 | x86      |
| Xmlrw.dll                                      | 2015.131.5830.85 | 252816    | 01-Aug-2020 | 09:19 | x86      |
| Xmlrw.dll                                      | 2015.131.5830.85 | 312216    | 01-Aug-2020 | 09:20 | x64      |
| Xmlrwbin.dll                                   | 2015.131.5830.85 | 184712    | 01-Aug-2020 | 09:19 | x86      |
| Xmlrwbin.dll                                   | 2015.131.5830.85 | 220552    | 01-Aug-2020 | 09:22 | x64      |
| Xmsrv.dll                                      | 2015.131.5830.85 | 32721288  | 01-Aug-2020 | 09:20 | x86      |
| Xmsrv.dll                                      | 2015.131.5830.85 | 24041368  | 01-Aug-2020 | 09:32 | x64      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
