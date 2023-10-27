---
title: Cumulative update 7 for SQL Server 2016 SP2 (KB4495256)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 Service Pack 2 (SP2) cumulative update 7 (KB4495256).
ms.date: 10/26/2023
ms.custom: KB4495256
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Express
- SQL Server 2016 Web
---

# KB4495256 - Cumulative Update 7 for SQL Server 2016 SP2

_Release Date:_ &nbsp; May 22, 2019  
_Version:_ &nbsp; 13.0.5337.0

This article describes Cumulative Update package 7 (CU7) (build number: **13.0.5337.0**) for Microsoft SQL Server 2016 Service Pack 2 (SP2). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the initial release of SQL Server 2016 SP2.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---|---|---|
| <a id="12800325">[12800325](#12800325)</a> | [FIX: Database may crash when multiple threads update permissions on the same database in SQL Server 2016 (KB4497222)](https://support.microsoft.com/help/4497222) | Analysis Services |
| <a id="12639785">[12639785](#12639785)</a> | [FIX: Manual failover between forwarder and secondary replica fails with all replicas synchronized in SQL Server 2016 (KB4492604)](https://support.microsoft.com/help/4492604) | High Availability |
| <a id="12722070">[12722070](#12722070)</a> | [FIX: Access violation occurs when you query sys.dm_hadr_availability_replica_states in SQL Server 2016 (KB4491560)](https://support.microsoft.com/help/4491560) | High Availability |
| <a id="12783210">[12783210](#12783210)</a> | [FIX: Access violation occurs when you run a query against sys.availability_replicas in SQL Server 2016 (KB4494225)](https://support.microsoft.com/help/4494225) | High Availability |
| <a id="12823777">[12823777](#12823777)</a> | [FIX: Data movement to DAG Forwarder doesn't resume automatically after connection time-out in SQL Server 2016 (KB4501797)](https://support.microsoft.com/help/4501797) | High Availability |
| <a id="12860702">[12860702](#12860702)</a> | [FIX: AG is suspended when cross-database transaction is applied on AG databases in SQL Server 2016 (KB4500770)](https://support.microsoft.com/help/4500770) | High Availability |
| <a id="12865860">[12865860](#12865860)</a> | [FIX: Fail to join the secondary replica if the database has a defunct filegroup in SQL Server 2014 and 2016 (KB4497230)](https://support.microsoft.com/help/4497230) | High Availability |
| <a id="12572712">[12572712](#12572712)</a> | [FIX: Assertion error occurs when you run a query to access sys.dm_db_xtp_checkpoint_files in SQL Server 2016 (KB4502428)](https://support.microsoft.com/help/4502428) | In-Memory OLTP |
| <a id="12819451">[12819451](#12819451)</a> | [FIX: Floating point exception error 3628 occurs when you query DMV sys.dm_db_xtp_hash_index_stats in SQL Server 2016 (KB4491696)](https://support.microsoft.com/help/4491696) | In-Memory OLTP |
| <a id="12865856">[12865856](#12865856)</a> | [FIX: SQL jobs fail due to blocking in SSISDB in SQL Server 2014 and 2016 (KB4338636)](https://support.microsoft.com/help/4338636) | Integration Services |
| <a id="12770729">[12770729](#12770729)</a> | [FIX: HTML files can't be opened directly from the web portal in SSRS 2016 (KB4493765)](https://support.microsoft.com/help/4493765) | Reporting Services |
| <a id="12834142">[12834142](#12834142)</a> | [FIX: URL encoding is incorrect when the Excel workbook name is in Russian language in SSRS 2016 (KB4501741)](https://support.microsoft.com/help/4501741) | Reporting Services |
| <a id="12750695">[12750695](#12750695)</a> | [Improvement: Enable PDW APS to access TRY_CONVERT() function in SQL Server 2016 (KB4501052)](https://support.microsoft.com/help/4501052) | SQL Engine |
| <a id="12748363">[12748363](#12748363)</a> | [FIX: Indirect checkpoints on tempdb database cause "Non-yielding scheduler" error in SQL Server 2016 (KB4497928)](https://support.microsoft.com/help/4497928) | SQL Engine |
| <a id="12796269">[12796269](#12796269)</a> | [FIX: Adding new Publication may fail if distribution database is in AG and collation is set to BIN in SQL Server 2016 (KB4494805)](https://support.microsoft.com/help/4494805) | SQL Engine |
| <a id="12801855">[12801855](#12801855)</a> | [FIX: Remote ad hoc queries that use OPENDATASOURCE produce an incorrect error message when the new OLE DB provider is used (KB4495547)](https://support.microsoft.com/help/4495547) | SQL Engine |
| <a id="12809383">[12809383](#12809383)</a> | [FIX: Repl_Schema_Access wait issues when there are multiple publisher databases on the same instance of SQL Server 2016 (KB4488036)](https://support.microsoft.com/help/4488036) | SQL Engine |
| <a id="12816125">[12816125](#12816125)</a> | [FIX: Access violation occurs when you run sys.fn_dump_dblog function in SQL Server 2016 (KB4502427)](https://support.microsoft.com/help/4502427) | SQL Engine |
| <a id="12816588">[12816588](#12816588)</a> | [FIX: Query against table with both clustered columnstore index and nonclustered rowstore index may return incorrect results in SQL Server 2016 (KB4497225)](https://support.microsoft.com/help/4497225) | SQL Engine |
| <a id="12865873">[12865873](#12865873)</a> | [FIX: Log reader agent may fail after AG failover with TF 1448 enabled in SQL Server 2014 and 2016 (KB4499231)](https://support.microsoft.com/help/4499231) | SQL Engine |
| <a id="12865876">[12865876](#12865876)</a> | [FIX: Columnstore filter pushdown may return wrong results when there's an overflow in filter expressions in SQL Server 2014 and 2016 (KB4497701)](https://support.microsoft.com/help/4497701) | SQL Engine |
| <a id="12865966">[12865966](#12865966)</a> | [FIX: "Non-yielding Scheduler" occurs when you clean up in-memory runtime statistics of Query Store in SQL Server 2016 (KB4501205)](https://support.microsoft.com/help/4501205) | SQL Engine |
| <a id="12866582">[12866582](#12866582)</a> | [FIX: Tlog grows quickly when you run auto cleanup procedure in SQL Server 2016 (KB4500403)](https://support.microsoft.com/help/4500403) | SQL Engine |
| <a id="12931646">[12931646](#12931646)</a> | [FIX: Error occurs when you back up a virtual machine with non-component based backup in SQL Server 2016 (KB4493364)](https://support.microsoft.com/help/4493364) | SQL Engine |
| <a id="12673144">[12673144](#12673144)</a> | [FIX: Assertion error occurs when you use sys.dm_exec_query_statistics_xml in SQL Server 2016 (KB4490136)](https://support.microsoft.com/help/4490136) | SQL performance |
| <a id="12805639">[12805639](#12805639)</a> | [FIX: SQL Server 2016 doesn't perform the requested pre-row assignments when you use MERGE statement that performs assignments of local variables for each row (KB4502400)](https://support.microsoft.com/help/4502400) | SQL performance |
| <a id="12822163">[12822163](#12822163)</a> | [FIX: Filtered index may be corrupted when you rebuild index in parallel in SQL Server 2014 and 2016 (KB4489150)](https://support.microsoft.com/help/4489150) | SQL performance |

## How to obtain this cumulative update package

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2016 SP2 now](https://www.microsoft.com/download/details.aspx?id=56975)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

> [!NOTE]
> After future cumulative updates are released for SQL Server 2016, this CU can be located and downloaded from the [Microsoft Windows Update Catalog](https://catalog.update.microsoft.com/search.aspx?q=sql%20server%202016). However, we recommend that you always install the latest cumulative update that is available.

## Notes for this update

<details>
<summary><b>Cumulative update</b></summary>

Cumulative updates (CU) are now available at the Microsoft Download Center.

Only the most recent CU that was released for SQL Server 2016 SP2 is available at the Download Center.

- Each new CU contains all the fixes that were included with the previous CU for the installed version/Service Pack of SQL Server.
- Microsoft recommends ongoing, proactive installation of CUs as they become available:
  - SQL Server CUs are certified to the same levels as Service Packs, and should be installed at the same level of confidence.
  - Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU.
  - CUs might contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
- Just as for SQL Server service packs, we recommend that you test CUs before you deploy them to production environments.
- We recommend that you upgrade your SQL Server installation to [the latest SQL Server 2016 service pack](https://support.microsoft.com/help/3177534).

</details>

<details>
<summary><b>Hybrid environments deployment</b></summary>

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

SQL Server Cumulative Updates are currently multilingual. Therefore, this cumulative update package isn't specific to one language. It applies to all supported languages.

</details>

<details>
<summary><b>Components (features) updated</b></summary>

One CU package includes all available updates for all SQL Server 2016 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).

</details>

<details>
<summary><b>How to uninstall this update</b></summary>

1. In Control Panel, select **View installed updates** under **Programs and Features**.
1. Locate the entry that corresponds to this cumulative update package under Microsoft SQL Server 2016.
1. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

## Cumulative update package information

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2016 SP2.

</details>

<details>
<summary><b>Restart information</b></summary>

You might have to restart the computer after you apply this cumulative update package.

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

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.server.core.dll | 13.0.5337.0     | 1348400   | 16-May-19 | 13:15 | x86      |
| Microsoft.applicationinsights.dll          | 2.7.0.13435     | 329872    | 06-Jul-18 | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5337.0     | 990536    | 16-May-19 | 13:15 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5337.0     | 990296    | 16-May-19 | 13:17 | x86      |
| Msmdctr.dll                                | 2015.131.5337.0 | 40264     | 16-May-19 | 13:13 | x64      |
| Msmdlocal.dll                              | 2015.131.5337.0 | 37103912  | 16-May-19 | 13:12 | x86      |
| Msmdlocal.dll                              | 2015.131.5337.0 | 56208984  | 16-May-19 | 13:14 | x64      |
| Msmdsrv.exe                                | 2015.131.5337.0 | 56747824  | 16-May-19 | 13:12 | x64      |
| Msmgdsrv.dll                               | 2015.131.5337.0 | 7507248   | 16-May-19 | 13:12 | x64      |
| Msmgdsrv.dll                               | 2015.131.5337.0 | 6507824   | 16-May-19 | 13:12 | x86      |
| Msolap130.dll                              | 2015.131.5337.0 | 7008344   | 16-May-19 | 13:11 | x86      |
| Msolap130.dll                              | 2015.131.5337.0 | 8639280   | 16-May-19 | 13:14 | x64      |
| Msolui130.dll                              | 2015.131.5337.0 | 287536    | 16-May-19 | 13:11 | x86      |
| Msolui130.dll                              | 2015.131.5337.0 | 310360    | 16-May-19 | 13:14 | x64      |
| Sql_as_keyfile.dll                         | 2015.131.5337.0 | 100656    | 16-May-19 | 13:14 | x64      |
| Sqlboot.dll                                | 2015.131.5337.0 | 186664    | 16-May-19 | 13:13 | x64      |
| Sqlceip.exe                                | 13.0.5337.0     | 256088    | 16-May-19 | 13:08 | x86      |
| Sqldumper.exe                              | 2015.131.5337.0 | 107608    | 16-May-19 | 13:10 | x86      |
| Sqldumper.exe                              | 2015.131.5337.0 | 127064    | 16-May-19 | 13:14 | x64      |
| Tmapi.dll                                  | 2015.131.5337.0 | 4346160   | 16-May-19 | 13:00 | x64      |
| Tmcachemgr.dll                             | 2015.131.5337.0 | 2826544   | 16-May-19 | 13:00 | x64      |
| Tmpersistence.dll                          | 2015.131.5337.0 | 1071408   | 16-May-19 | 13:00 | x64      |
| Tmtransactions.dll                         | 2015.131.5337.0 | 1352288   | 16-May-19 | 13:00 | x64      |
| Xe.dll                                     | 2015.131.5337.0 | 626480    | 16-May-19 | 13:12 | x64      |
| Xmlrw.dll                                  | 2015.131.5337.0 | 259680    | 16-May-19 | 13:10 | x86      |
| Xmlrw.dll                                  | 2015.131.5337.0 | 319064    | 16-May-19 | 13:11 | x64      |
| Xmlrwbin.dll                               | 2015.131.5337.0 | 191584    | 16-May-19 | 13:10 | x86      |
| Xmlrwbin.dll                               | 2015.131.5337.0 | 227416    | 16-May-19 | 13:10 | x64      |
| Xmsrv.dll                                  | 2015.131.5337.0 | 24050992  | 16-May-19 | 13:00 | x64      |
| Xmsrv.dll                                  | 2015.131.5337.0 | 32727648  | 16-May-19 | 13:10 | x86      |

SQL Server 2016 Database Services Common Core

|                  File name                  |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                             | 2015.131.5337.0 | 160352    | 16-May-19 | 13:10 | x86      |
| Batchparser.dll                             | 2015.131.5337.0 | 181040    | 16-May-19 | 13:12 | x64      |
| Instapi150.dll                              | 2015.131.5337.0 | 53344     | 16-May-19 | 13:10 | x86      |
| Instapi150.dll                              | 2015.131.5337.0 | 61232     | 16-May-19 | 13:11 | x64      |
| Isacctchange.dll                            | 2015.131.5337.0 | 29280     | 16-May-19 | 13:09 | x86      |
| Isacctchange.dll                            | 2015.131.5337.0 | 30808     | 16-May-19 | 13:14 | x64      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5337.0     | 1027672   | 16-May-19 | 13:11 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5337.0     | 1027672   | 16-May-19 | 13:16 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5337.0     | 1027672   | 16-May-19 | 13:11 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5337.0     | 1027672   | 16-May-19 | 13:16 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.5337.0     | 1348912   | 16-May-19 | 13:11 | x86      |
| Microsoft.analysisservices.dll              | 13.0.5337.0     | 702768    | 16-May-19 | 13:11 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.5337.0     | 765528    | 16-May-19 | 13:11 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.5337.0     | 520792    | 16-May-19 | 13:11 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5337.0     | 711984    | 16-May-19 | 13:11 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5337.0     | 711984    | 16-May-19 | 13:15 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5337.0 | 73008     | 16-May-19 | 13:15 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5337.0 | 75360     | 16-May-19 | 13:16 | x64      |
| Msasxpress.dll                              | 2015.131.5337.0 | 32072     | 16-May-19 | 13:11 | x86      |
| Msasxpress.dll                              | 2015.131.5337.0 | 35928     | 16-May-19 | 13:16 | x64      |
| Pbsvcacctsync.dll                           | 2015.131.5337.0 | 59992     | 16-May-19 | 13:11 | x86      |
| Pbsvcacctsync.dll                           | 2015.131.5337.0 | 73008     | 16-May-19 | 13:13 | x64      |
| Sql_common_core_keyfile.dll                 | 2015.131.5337.0 | 100656    | 16-May-19 | 13:14 | x64      |
| Sqldumper.exe                               | 2015.131.5337.0 | 107608    | 16-May-19 | 13:10 | x86      |
| Sqldumper.exe                               | 2015.131.5337.0 | 127064    | 16-May-19 | 13:14 | x64      |
| Sqlftacct.dll                               | 2015.131.5337.0 | 46896     | 16-May-19 | 13:11 | x86      |
| Sqlftacct.dll                               | 2015.131.5337.0 | 52016     | 16-May-19 | 13:13 | x64      |
| Sqlmgmprovider.dll                          | 2015.131.5337.0 | 406320    | 16-May-19 | 13:00 | x64      |
| Sqlmgmprovider.dll                          | 2015.131.5337.0 | 365872    | 16-May-19 | 13:11 | x86      |
| Sqlsecacctchg.dll                           | 2015.131.5337.0 | 37680     | 16-May-19 | 13:00 | x64      |
| Sqlsecacctchg.dll                           | 2015.131.5337.0 | 35120     | 16-May-19 | 13:11 | x86      |
| Sqltdiagn.dll                               | 2015.131.5337.0 | 67888     | 16-May-19 | 13:00 | x64      |
| Sqltdiagn.dll                               | 2015.131.5337.0 | 60504     | 16-May-19 | 13:11 | x86      |

SQL Server 2016 sql_dreplay_client

|            File name           |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2015.131.5337.0 | 121136    | 16-May-19 | 13:11 | x86      |
| Dreplaycommon.dll              | 2015.131.5337.0 | 690776    | 16-May-19 | 13:11 | x86      |
| Dreplayutil.dll                | 2015.131.5337.0 | 309856    | 16-May-19 | 13:10 | x86      |
| Instapi150.dll                 | 2015.131.5337.0 | 61232     | 16-May-19 | 13:11 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.131.5337.0 | 100656    | 16-May-19 | 13:14 | x64      |
| Sqlresourceloader.dll          | 2015.131.5337.0 | 28248     | 16-May-19 | 13:12 | x86      |

SQL Server 2016 sql_dreplay_controller

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2015.131.5337.0 | 690776    | 16-May-19 | 13:11 | x86      |
| Dreplaycontroller.exe              | 2015.131.5337.0 | 350296    | 16-May-19 | 13:11 | x86      |
| Dreplayprocess.dll                 | 2015.131.5337.0 | 171616    | 16-May-19 | 13:10 | x86      |
| Instapi150.dll                     | 2015.131.5337.0 | 61232     | 16-May-19 | 13:11 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.131.5337.0 | 100656    | 16-May-19 | 13:14 | x64      |
| Sqlresourceloader.dll              | 2015.131.5337.0 | 28248     | 16-May-19 | 13:12 | x86      |

SQL Server 2016 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Backuptourl.exe                              | 13.0.5337.0     | 41048     | 16-May-19 | 13:11 | x64      |
| Batchparser.dll                              | 2015.131.5337.0 | 181040    | 16-May-19 | 13:12 | x64      |
| Datacollectorcontroller.dll                  | 2015.131.5337.0 | 225368    | 16-May-19 | 13:14 | x64      |
| Dcexec.exe                                   | 2015.131.5337.0 | 74328     | 16-May-19 | 13:11 | x64      |
| Fssres.dll                                   | 2015.131.5337.0 | 81712     | 16-May-19 | 13:13 | x64      |
| Hadrres.dll                                  | 2015.131.5337.0 | 177752    | 16-May-19 | 13:11 | x64      |
| Hkcompile.dll                                | 2015.131.5337.0 | 1298008   | 16-May-19 | 13:11 | x64      |
| Hkengine.dll                                 | 2015.131.5337.0 | 5601072   | 16-May-19 | 13:11 | x64      |
| Hkruntime.dll                                | 2015.131.5337.0 | 158808    | 16-May-19 | 13:11 | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 06-Jul-18 | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.5337.0     | 234288    | 16-May-19 | 13:18 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.131.5337.0 | 72496     | 16-May-19 | 13:13 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.131.5337.0 | 65112     | 16-May-19 | 13:15 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5337.0 | 150104    | 16-May-19 | 13:15 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5337.0 | 158808    | 16-May-19 | 13:15 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.131.5337.0 | 271960    | 16-May-19 | 13:15 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.131.5337.0 | 74840     | 16-May-19 | 13:15 | x64      |
| Odsole70.dll                                 | 2015.131.5337.0 | 92976     | 16-May-19 | 13:14 | x64      |
| Opends60.dll                                 | 2015.131.5337.0 | 33072     | 16-May-19 | 13:10 | x64      |
| Qds.dll                                      | 2015.131.5337.0 | 869672    | 16-May-19 | 13:13 | x64      |
| Rsfxft.dll                                   | 2015.131.5337.0 | 34392     | 16-May-19 | 13:11 | x64      |
| Sqagtres.dll                                 | 2015.131.5337.0 | 64808     | 16-May-19 | 13:14 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.131.5337.0 | 100656    | 16-May-19 | 13:14 | x64      |
| Sqlaamss.dll                                 | 2015.131.5337.0 | 80688     | 16-May-19 | 13:12 | x64      |
| Sqlaccess.dll                                | 2015.131.5337.0 | 462936    | 16-May-19 | 13:14 | x64      |
| Sqlagent.exe                                 | 2015.131.5337.0 | 566360    | 16-May-19 | 13:10 | x64      |
| Sqlagentctr130.dll                           | 2015.131.5337.0 | 44128     | 16-May-19 | 13:10 | x86      |
| Sqlagentctr130.dll                           | 2015.131.5337.0 | 52016     | 16-May-19 | 13:13 | x64      |
| Sqlagentlog.dll                              | 2015.131.5337.0 | 33072     | 16-May-19 | 13:13 | x64      |
| Sqlagentmail.dll                             | 2015.131.5337.0 | 47704     | 16-May-19 | 13:12 | x64      |
| Sqlboot.dll                                  | 2015.131.5337.0 | 186664    | 16-May-19 | 13:13 | x64      |
| Sqlceip.exe                                  | 13.0.5337.0     | 256088    | 16-May-19 | 13:08 | x86      |
| Sqlcmdss.dll                                 | 2015.131.5337.0 | 60208     | 16-May-19 | 13:13 | x64      |
| Sqldk.dll                                    | 2015.131.5337.0 | 2588248   | 16-May-19 | 13:14 | x64      |
| Sqldtsss.dll                                 | 2015.131.5337.0 | 97584     | 16-May-19 | 13:11 | x64      |
| Sqliosim.com                                 | 2015.131.5337.0 | 307808    | 16-May-19 | 13:10 | x64      |
| Sqliosim.exe                                 | 2015.131.5337.0 | 3014448   | 16-May-19 | 13:11 | x64      |
| Sqllang.dll                                  | 2015.131.5337.0 | 39530072  | 16-May-19 | 13:14 | x64      |
| Sqlmin.dll                                   | 2015.131.5337.0 | 37908576  | 16-May-19 | 13:01 | x64      |
| Sqlolapss.dll                                | 2015.131.5337.0 | 97880     | 16-May-19 | 13:11 | x64      |
| Sqlos.dll                                    | 2015.131.5337.0 | 26416     | 16-May-19 | 13:10 | x64      |
| Sqlpowershellss.dll                          | 2015.131.5337.0 | 58672     | 16-May-19 | 13:00 | x64      |
| Sqlrepss.dll                                 | 2015.131.5337.0 | 55088     | 16-May-19 | 13:00 | x64      |
| Sqlresld.dll                                 | 2015.131.5337.0 | 30816     | 16-May-19 | 13:00 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5337.0 | 31024     | 16-May-19 | 13:00 | x64      |
| Sqlscm.dll                                   | 2015.131.5337.0 | 61232     | 16-May-19 | 13:12 | x64      |
| Sqlscriptdowngrade.dll                       | 2015.131.5337.0 | 27952     | 16-May-19 | 13:00 | x64      |
| Sqlscriptupgrade.dll                         | 2015.131.5337.0 | 5808944   | 16-May-19 | 13:11 | x64      |
| Sqlserverspatial150.dll                      | 2015.131.5337.0 | 732976    | 16-May-19 | 13:11 | x64      |
| Sqlservr.exe                                 | 2015.131.5337.0 | 393008    | 16-May-19 | 13:10 | x64      |
| Sqlsvc.dll                                   | 2015.131.5337.0 | 152392    | 16-May-19 | 13:00 | x64      |
| Sqltses.dll                                  | 2015.131.5337.0 | 8923952   | 16-May-19 | 13:00 | x64      |
| Sqsrvres.dll                                 | 2015.131.5337.0 | 251184    | 16-May-19 | 13:00 | x64      |
| Xe.dll                                       | 2015.131.5337.0 | 626480    | 16-May-19 | 13:12 | x64      |
| Xmlrw.dll                                    | 2015.131.5337.0 | 319064    | 16-May-19 | 13:11 | x64      |
| Xmlrwbin.dll                                 | 2015.131.5337.0 | 227416    | 16-May-19 | 13:10 | x64      |
| Xpadsi.exe                                   | 2015.131.5337.0 | 79152     | 16-May-19 | 13:13 | x64      |
| Xplog70.dll                                  | 2015.131.5337.0 | 65864     | 16-May-19 | 13:11 | x64      |
| Xpsqlbot.dll                                 | 2015.131.5337.0 | 33584     | 16-May-19 | 13:10 | x64      |
| Xpstar.dll                                   | 2015.131.5337.0 | 422488    | 16-May-19 | 13:10 | x64      |

SQL Server 2016 Database Services Core Shared

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2015.131.5337.0 | 160352    | 16-May-19 | 13:10 | x86      |
| Batchparser.dll                              | 2015.131.5337.0 | 181040    | 16-May-19 | 13:12 | x64      |
| Bcp.exe                                      | 2015.131.5337.0 | 119896    | 16-May-19 | 13:14 | x64      |
| Commanddest.dll                              | 2015.131.5337.0 | 248920    | 16-May-19 | 13:14 | x64      |
| Datacollectorenumerators.dll                 | 2015.131.5337.0 | 115800    | 16-May-19 | 13:14 | x64      |
| Datacollectortasks.dll                       | 2015.131.5337.0 | 187992    | 16-May-19 | 13:14 | x64      |
| Distrib.exe                                  | 2015.131.5337.0 | 191064    | 16-May-19 | 13:11 | x64      |
| Dteparse.dll                                 | 2015.131.5337.0 | 109872    | 16-May-19 | 13:14 | x64      |
| Dteparsemgd.dll                              | 2015.131.5337.0 | 88664     | 16-May-19 | 13:16 | x64      |
| Dtepkg.dll                                   | 2015.131.5337.0 | 137304    | 16-May-19 | 13:14 | x64      |
| Dtexec.exe                                   | 2015.131.5337.0 | 72792     | 16-May-19 | 13:11 | x64      |
| Dts.dll                                      | 2015.131.5337.0 | 3147080   | 16-May-19 | 13:14 | x64      |
| Dtscomexpreval.dll                           | 2015.131.5337.0 | 477272    | 16-May-19 | 13:14 | x64      |
| Dtsconn.dll                                  | 2015.131.5337.0 | 492632    | 16-May-19 | 13:14 | x64      |
| Dtshost.exe                                  | 2015.131.5337.0 | 86616     | 16-May-19 | 13:11 | x64      |
| Dtslog.dll                                   | 2015.131.5337.0 | 120624    | 16-May-19 | 13:14 | x64      |
| Dtsmsg150.dll                                | 2015.131.5337.0 | 545368    | 16-May-19 | 13:14 | x64      |
| Dtspipeline.dll                              | 2015.131.5337.0 | 1279064   | 16-May-19 | 13:14 | x64      |
| Dtspipelineperf150.dll                       | 2015.131.5337.0 | 48216     | 16-May-19 | 13:14 | x64      |
| Dtuparse.dll                                 | 2015.131.5337.0 | 87640     | 16-May-19 | 13:14 | x64      |
| Dtutil.exe                                   | 2015.131.5337.0 | 134960    | 16-May-19 | 13:12 | x64      |
| Exceldest.dll                                | 2015.131.5337.0 | 263464    | 16-May-19 | 13:14 | x64      |
| Excelsrc.dll                                 | 2015.131.5337.0 | 285512    | 16-May-19 | 13:14 | x64      |
| Execpackagetask.dll                          | 2015.131.5337.0 | 166488    | 16-May-19 | 13:14 | x64      |
| Flatfiledest.dll                             | 2015.131.5337.0 | 389416    | 16-May-19 | 13:14 | x64      |
| Flatfilesrc.dll                              | 2015.131.5337.0 | 401704    | 16-May-19 | 13:14 | x64      |
| Foreachfileenumerator.dll                    | 2015.131.5337.0 | 96344     | 16-May-19 | 13:14 | x64      |
| Hkengperfctrs.dll                            | 2015.131.5337.0 | 59208     | 16-May-19 | 13:12 | x64      |
| Logread.exe                                  | 2015.131.5337.0 | 626776    | 16-May-19 | 13:11 | x64      |
| Microsoft.analysisservices.applocal.core.dll | 13.0.5337.0     | 1313880   | 16-May-19 | 13:16 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll | 13.0.5337.0     | 391768    | 16-May-19 | 13:15 | x86      |
| Microsoft.sqlserver.replication.dll          | 2015.131.5337.0 | 1651504   | 16-May-19 | 13:12 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5337.0 | 150104    | 16-May-19 | 13:15 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5337.0 | 158808    | 16-May-19 | 13:15 | x64      |
| Msdtssrvrutil.dll                            | 2015.131.5337.0 | 101464    | 16-May-19 | 13:16 | x64      |
| Msxmlsql.dll                                 | 2015.131.5337.0 | 1494616   | 16-May-19 | 13:11 | x64      |
| Oledbdest.dll                                | 2015.131.5337.0 | 264280    | 16-May-19 | 13:14 | x64      |
| Oledbsrc.dll                                 | 2015.131.5337.0 | 291120    | 16-May-19 | 13:13 | x64      |
| Osql.exe                                     | 2015.131.5337.0 | 75352     | 16-May-19 | 13:14 | x64      |
| Rawdest.dll                                  | 2015.131.5337.0 | 209712    | 16-May-19 | 13:13 | x64      |
| Rawsource.dll                                | 2015.131.5337.0 | 196912    | 16-May-19 | 13:13 | x64      |
| Rdistcom.dll                                 | 2015.131.5337.0 | 907056    | 16-May-19 | 13:13 | x64      |
| Recordsetdest.dll                            | 2015.131.5337.0 | 187176    | 16-May-19 | 13:13 | x64      |
| Repldp.dll                                   | 2015.131.5337.0 | 281904    | 16-May-19 | 13:13 | x64      |
| Replprov.dll                                 | 2015.131.5337.0 | 812336    | 16-May-19 | 13:13 | x64      |
| Replrec.dll                                  | 2015.131.5337.0 | 1019184   | 16-May-19 | 13:12 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2015.131.5337.0 | 100656    | 16-May-19 | 13:14 | x64      |
| Sqlcmd.exe                                   | 2015.131.5337.0 | 249432    | 16-May-19 | 13:14 | x64      |
| Sqldiag.exe                                  | 2015.131.5337.0 | 1257560   | 16-May-19 | 13:11 | x64      |
| Sqllogship.exe                               | 13.0.5337.0     | 104536    | 16-May-19 | 13:09 | x64      |
| Sqlresld.dll                                 | 2015.131.5337.0 | 30816     | 16-May-19 | 13:00 | x64      |
| Sqlresld.dll                                 | 2015.131.5337.0 | 28760     | 16-May-19 | 13:11 | x86      |
| Sqlresourceloader.dll                        | 2015.131.5337.0 | 31024     | 16-May-19 | 13:00 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5337.0 | 28248     | 16-May-19 | 13:12 | x86      |
| Sqlscm.dll                                   | 2015.131.5337.0 | 52824     | 16-May-19 | 13:11 | x86      |
| Sqlscm.dll                                   | 2015.131.5337.0 | 61232     | 16-May-19 | 13:12 | x64      |
| Sqlsvc.dll                                   | 2015.131.5337.0 | 152392    | 16-May-19 | 13:00 | x64      |
| Sqlsvc.dll                                   | 2015.131.5337.0 | 127064    | 16-May-19 | 13:11 | x86      |
| Sqltaskconnections.dll                       | 2015.131.5337.0 | 181040    | 16-May-19 | 13:00 | x64      |
| Sqlwep130.dll                                | 2015.131.5337.0 | 105776    | 16-May-19 | 13:00 | x64      |
| Ssisoledb.dll                                | 2015.131.5337.0 | 216368    | 16-May-19 | 13:00 | x64      |
| Txagg.dll                                    | 2015.131.5337.0 | 364640    | 16-May-19 | 13:01 | x64      |
| Txbdd.dll                                    | 2015.131.5337.0 | 172872    | 16-May-19 | 13:00 | x64      |
| Txdatacollector.dll                          | 2015.131.5337.0 | 367920    | 16-May-19 | 13:00 | x64      |
| Txdataconvert.dll                            | 2015.131.5337.0 | 296544    | 16-May-19 | 13:00 | x64      |
| Txderived.dll                                | 2015.131.5337.0 | 617160    | 16-May-19 | 13:00 | x64      |
| Txlookup.dll                                 | 2015.131.5337.0 | 532272    | 16-May-19 | 13:00 | x64      |
| Txmerge.dll                                  | 2015.131.5337.0 | 230496    | 16-May-19 | 13:00 | x64      |
| Txmergejoin.dll                              | 2015.131.5337.0 | 278624    | 16-May-19 | 13:00 | x64      |
| Txmulticast.dll                              | 2015.131.5337.0 | 128096    | 16-May-19 | 13:00 | x64      |
| Txrowcount.dll                               | 2015.131.5337.0 | 126560    | 16-May-19 | 13:00 | x64      |
| Txsort.dll                                   | 2015.131.5337.0 | 259168    | 16-May-19 | 13:00 | x64      |
| Txsplit.dll                                  | 2015.131.5337.0 | 600880    | 16-May-19 | 13:00 | x64      |
| Txunionall.dll                               | 2015.131.5337.0 | 182064    | 16-May-19 | 13:00 | x64      |
| Xe.dll                                       | 2015.131.5337.0 | 626480    | 16-May-19 | 13:12 | x64      |
| Xmlrw.dll                                    | 2015.131.5337.0 | 319064    | 16-May-19 | 13:11 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.131.5337.0 | 1014872   | 16-May-19 | 13:14 | x64      |
| Sql_extensibility_keyfile.dll | 2015.131.5337.0 | 100656    | 16-May-19 | 13:14 | x64      |
| Sqlsatellite.dll              | 2015.131.5337.0 | 837424    | 16-May-19 | 13:12 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2015.131.5337.0 | 660056    | 16-May-19 | 13:11 | x64      |
| Fdhost.exe               | 2015.131.5337.0 | 105048    | 16-May-19 | 13:14 | x64      |
| Fdlauncher.exe           | 2015.131.5337.0 | 51288     | 16-May-19 | 13:14 | x64      |
| Sql_fulltext_keyfile.dll | 2015.131.5337.0 | 100656    | 16-May-19 | 13:14 | x64      |
| Sqlft130ph.dll           | 2015.131.5337.0 | 58160     | 16-May-19 | 13:12 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.5337.0     | 23640     | 16-May-19 | 13:16 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.131.5337.0 | 100656    | 16-May-19 | 13:14 | x64      |

SQL Server 2016 Integration Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll              | 4.0.0.111       | 77944     | 16-May-19 | 01:36 | x86      |
| Attunity.sqlserver.cdccontroltask.dll              | 4.0.0.111       | 77944     | 16-May-19 | 01:50 | x86      |
| Attunity.sqlserver.cdcsplit.dll                    | 4.0.0.111       | 37496     | 16-May-19 | 01:36 | x86      |
| Attunity.sqlserver.cdcsplit.dll                    | 4.0.0.111       | 37496     | 16-May-19 | 01:50 | x86      |
| Attunity.sqlserver.cdcsrc.dll                      | 4.0.0.111       | 78456     | 16-May-19 | 01:36 | x86      |
| Attunity.sqlserver.cdcsrc.dll                      | 4.0.0.111       | 78456     | 16-May-19 | 01:50 | x86      |
| Commanddest.dll                                    | 2015.131.5337.0 | 202848    | 16-May-19 | 13:10 | x86      |
| Commanddest.dll                                    | 2015.131.5337.0 | 248920    | 16-May-19 | 13:14 | x64      |
| Dteparse.dll                                       | 2015.131.5337.0 | 99424     | 16-May-19 | 13:10 | x86      |
| Dteparse.dll                                       | 2015.131.5337.0 | 109872    | 16-May-19 | 13:14 | x64      |
| Dteparsemgd.dll                                    | 2015.131.5337.0 | 83544     | 16-May-19 | 13:11 | x86      |
| Dteparsemgd.dll                                    | 2015.131.5337.0 | 88664     | 16-May-19 | 13:16 | x64      |
| Dtepkg.dll                                         | 2015.131.5337.0 | 115808    | 16-May-19 | 13:10 | x86      |
| Dtepkg.dll                                         | 2015.131.5337.0 | 137304    | 16-May-19 | 13:14 | x64      |
| Dtexec.exe                                         | 2015.131.5337.0 | 66648     | 16-May-19 | 13:11 | x86      |
| Dtexec.exe                                         | 2015.131.5337.0 | 72792     | 16-May-19 | 13:11 | x64      |
| Dts.dll                                            | 2015.131.5337.0 | 2632800   | 16-May-19 | 13:10 | x86      |
| Dts.dll                                            | 2015.131.5337.0 | 3147080   | 16-May-19 | 13:14 | x64      |
| Dtscomexpreval.dll                                 | 2015.131.5337.0 | 418912    | 16-May-19 | 13:10 | x86      |
| Dtscomexpreval.dll                                 | 2015.131.5337.0 | 477272    | 16-May-19 | 13:14 | x64      |
| Dtsconn.dll                                        | 2015.131.5337.0 | 392288    | 16-May-19 | 13:09 | x86      |
| Dtsconn.dll                                        | 2015.131.5337.0 | 492632    | 16-May-19 | 13:14 | x64      |
| Dtsdebughost.exe                                   | 2015.131.5337.0 | 93784     | 16-May-19 | 13:11 | x86      |
| Dtsdebughost.exe                                   | 2015.131.5337.0 | 109656    | 16-May-19 | 13:11 | x64      |
| Dtshost.exe                                        | 2015.131.5337.0 | 76376     | 16-May-19 | 13:11 | x86      |
| Dtshost.exe                                        | 2015.131.5337.0 | 86616     | 16-May-19 | 13:11 | x64      |
| Dtslog.dll                                         | 2015.131.5337.0 | 103008    | 16-May-19 | 13:10 | x86      |
| Dtslog.dll                                         | 2015.131.5337.0 | 120624    | 16-May-19 | 13:14 | x64      |
| Dtsmsg150.dll                                      | 2015.131.5337.0 | 541280    | 16-May-19 | 13:09 | x86      |
| Dtsmsg150.dll                                      | 2015.131.5337.0 | 545368    | 16-May-19 | 13:14 | x64      |
| Dtspipeline.dll                                    | 2015.131.5337.0 | 1059424   | 16-May-19 | 13:09 | x86      |
| Dtspipeline.dll                                    | 2015.131.5337.0 | 1279064   | 16-May-19 | 13:14 | x64      |
| Dtspipelineperf150.dll                             | 2015.131.5337.0 | 42080     | 16-May-19 | 13:10 | x86      |
| Dtspipelineperf150.dll                             | 2015.131.5337.0 | 48216     | 16-May-19 | 13:14 | x64      |
| Dtuparse.dll                                       | 2015.131.5337.0 | 79968     | 16-May-19 | 13:10 | x86      |
| Dtuparse.dll                                       | 2015.131.5337.0 | 87640     | 16-May-19 | 13:14 | x64      |
| Dtutil.exe                                         | 2015.131.5337.0 | 115504    | 16-May-19 | 13:11 | x86      |
| Dtutil.exe                                         | 2015.131.5337.0 | 134960    | 16-May-19 | 13:12 | x64      |
| Exceldest.dll                                      | 2015.131.5337.0 | 216672    | 16-May-19 | 13:10 | x86      |
| Exceldest.dll                                      | 2015.131.5337.0 | 263464    | 16-May-19 | 13:14 | x64      |
| Excelsrc.dll                                       | 2015.131.5337.0 | 232544    | 16-May-19 | 13:09 | x86      |
| Excelsrc.dll                                       | 2015.131.5337.0 | 285512    | 16-May-19 | 13:14 | x64      |
| Execpackagetask.dll                                | 2015.131.5337.0 | 135264    | 16-May-19 | 13:09 | x86      |
| Execpackagetask.dll                                | 2015.131.5337.0 | 166488    | 16-May-19 | 13:14 | x64      |
| Flatfiledest.dll                                   | 2015.131.5337.0 | 334432    | 16-May-19 | 13:09 | x86      |
| Flatfiledest.dll                                   | 2015.131.5337.0 | 389416    | 16-May-19 | 13:14 | x64      |
| Flatfilesrc.dll                                    | 2015.131.5337.0 | 345184    | 16-May-19 | 13:10 | x86      |
| Flatfilesrc.dll                                    | 2015.131.5337.0 | 401704    | 16-May-19 | 13:14 | x64      |
| Foreachfileenumerator.dll                          | 2015.131.5337.0 | 80480     | 16-May-19 | 13:10 | x86      |
| Foreachfileenumerator.dll                          | 2015.131.5337.0 | 96344     | 16-May-19 | 13:14 | x64      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5337.0     | 1313880   | 16-May-19 | 13:11 | x86      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5337.0     | 1313880   | 16-May-19 | 13:16 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 06-Jul-18 | 22:33 | x86      |
| Microsoft.sqlserver.astasks.dll                    | 13.0.5337.0     | 73544     | 16-May-19 | 13:18 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5337.0 | 107312    | 16-May-19 | 13:15 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5337.0 | 112432    | 16-May-19 | 13:17 | x64      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5337.0     | 82736     | 16-May-19 | 13:12 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5337.0     | 82736     | 16-May-19 | 04:49 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll       | 13.0.5337.0     | 391768    | 16-May-19 | 13:15 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5337.0 | 138840    | 16-May-19 | 13:08 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5337.0 | 150104    | 16-May-19 | 13:15 | x64      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5337.0 | 144472    | 16-May-19 | 13:09 | x86      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5337.0 | 158808    | 16-May-19 | 13:15 | x64      |
| Msdtssrvr.exe                                      | 13.0.5337.0     | 216664    | 16-May-19 | 13:09 | x64      |
| Msdtssrvrutil.dll                                  | 2015.131.5337.0 | 90416     | 16-May-19 | 13:11 | x86      |
| Msdtssrvrutil.dll                                  | 2015.131.5337.0 | 101464    | 16-May-19 | 13:16 | x64      |
| Oledbdest.dll                                      | 2015.131.5337.0 | 216880    | 16-May-19 | 13:11 | x86      |
| Oledbdest.dll                                      | 2015.131.5337.0 | 264280    | 16-May-19 | 13:14 | x64      |
| Oledbsrc.dll                                       | 2015.131.5337.0 | 235824    | 16-May-19 | 13:11 | x86      |
| Oledbsrc.dll                                       | 2015.131.5337.0 | 291120    | 16-May-19 | 13:13 | x64      |
| Rawdest.dll                                        | 2015.131.5337.0 | 168752    | 16-May-19 | 13:11 | x86      |
| Rawdest.dll                                        | 2015.131.5337.0 | 209712    | 16-May-19 | 13:13 | x64      |
| Rawsource.dll                                      | 2015.131.5337.0 | 155440    | 16-May-19 | 13:11 | x86      |
| Rawsource.dll                                      | 2015.131.5337.0 | 196912    | 16-May-19 | 13:13 | x64      |
| Recordsetdest.dll                                  | 2015.131.5337.0 | 151640    | 16-May-19 | 13:11 | x86      |
| Recordsetdest.dll                                  | 2015.131.5337.0 | 187176    | 16-May-19 | 13:13 | x64      |
| Sql_is_keyfile.dll                                 | 2015.131.5337.0 | 100656    | 16-May-19 | 13:14 | x64      |
| Sqlceip.exe                                        | 13.0.5337.0     | 256088    | 16-May-19 | 13:08 | x86      |
| Sqldest.dll                                        | 2015.131.5337.0 | 215856    | 16-May-19 | 13:11 | x86      |
| Sqldest.dll                                        | 2015.131.5337.0 | 263984    | 16-May-19 | 13:13 | x64      |
| Sqltaskconnections.dll                             | 2015.131.5337.0 | 181040    | 16-May-19 | 13:00 | x64      |
| Sqltaskconnections.dll                             | 2015.131.5337.0 | 151128    | 16-May-19 | 13:11 | x86      |
| Ssisoledb.dll                                      | 2015.131.5337.0 | 216368    | 16-May-19 | 13:00 | x64      |
| Ssisoledb.dll                                      | 2015.131.5337.0 | 176728    | 16-May-19 | 13:11 | x86      |
| Txagg.dll                                          | 2015.131.5337.0 | 364640    | 16-May-19 | 13:01 | x64      |
| Txagg.dll                                          | 2015.131.5337.0 | 304736    | 16-May-19 | 13:10 | x86      |
| Txbdd.dll                                          | 2015.131.5337.0 | 172872    | 16-May-19 | 13:00 | x64      |
| Txbdd.dll                                          | 2015.131.5337.0 | 137824    | 16-May-19 | 13:10 | x86      |
| Txbestmatch.dll                                    | 2015.131.5337.0 | 611632    | 16-May-19 | 13:00 | x64      |
| Txbestmatch.dll                                    | 2015.131.5337.0 | 496224    | 16-May-19 | 13:10 | x86      |
| Txcache.dll                                        | 2015.131.5337.0 | 183392    | 16-May-19 | 13:00 | x64      |
| Txcache.dll                                        | 2015.131.5337.0 | 148064    | 16-May-19 | 13:10 | x86      |
| Txcharmap.dll                                      | 2015.131.5337.0 | 290096    | 16-May-19 | 13:00 | x64      |
| Txcharmap.dll                                      | 2015.131.5337.0 | 250464    | 16-May-19 | 13:10 | x86      |
| Txcopymap.dll                                      | 2015.131.5337.0 | 183088    | 16-May-19 | 13:00 | x64      |
| Txcopymap.dll                                      | 2015.131.5337.0 | 147552    | 16-May-19 | 13:10 | x86      |
| Txdataconvert.dll                                  | 2015.131.5337.0 | 296544    | 16-May-19 | 13:00 | x64      |
| Txdataconvert.dll                                  | 2015.131.5337.0 | 255072    | 16-May-19 | 13:10 | x86      |
| Txderived.dll                                      | 2015.131.5337.0 | 617160    | 16-May-19 | 13:00 | x64      |
| Txderived.dll                                      | 2015.131.5337.0 | 519264    | 16-May-19 | 13:10 | x86      |
| Txfileextractor.dll                                | 2015.131.5337.0 | 202032    | 16-May-19 | 13:00 | x64      |
| Txfileextractor.dll                                | 2015.131.5337.0 | 162912    | 16-May-19 | 13:10 | x86      |
| Txfileinserter.dll                                 | 2015.131.5337.0 | 199776    | 16-May-19 | 13:00 | x64      |
| Txfileinserter.dll                                 | 2015.131.5337.0 | 160864    | 16-May-19 | 13:10 | x86      |
| Txgroupdups.dll                                    | 2015.131.5337.0 | 290912    | 16-May-19 | 13:00 | x64      |
| Txgroupdups.dll                                    | 2015.131.5337.0 | 231520    | 16-May-19 | 13:10 | x86      |
| Txlineage.dll                                      | 2015.131.5337.0 | 137824    | 16-May-19 | 13:00 | x64      |
| Txlineage.dll                                      | 2015.131.5337.0 | 109656    | 16-May-19 | 13:10 | x86      |
| Txlookup.dll                                       | 2015.131.5337.0 | 532272    | 16-May-19 | 13:00 | x64      |
| Txlookup.dll                                       | 2015.131.5337.0 | 449624    | 16-May-19 | 13:10 | x86      |
| Txmerge.dll                                        | 2015.131.5337.0 | 230496    | 16-May-19 | 13:00 | x64      |
| Txmerge.dll                                        | 2015.131.5337.0 | 176736    | 16-May-19 | 13:10 | x86      |
| Txmergejoin.dll                                    | 2015.131.5337.0 | 278624    | 16-May-19 | 13:00 | x64      |
| Txmergejoin.dll                                    | 2015.131.5337.0 | 223840    | 16-May-19 | 13:10 | x86      |
| Txmulticast.dll                                    | 2015.131.5337.0 | 128096    | 16-May-19 | 13:00 | x64      |
| Txmulticast.dll                                    | 2015.131.5337.0 | 101984    | 16-May-19 | 13:10 | x86      |
| Txpivot.dll                                        | 2015.131.5337.0 | 227936    | 16-May-19 | 13:00 | x64      |
| Txpivot.dll                                        | 2015.131.5337.0 | 181856    | 16-May-19 | 13:10 | x86      |
| Txrowcount.dll                                     | 2015.131.5337.0 | 126560    | 16-May-19 | 13:00 | x64      |
| Txrowcount.dll                                     | 2015.131.5337.0 | 101472    | 16-May-19 | 13:10 | x86      |
| Txsampling.dll                                     | 2015.131.5337.0 | 172336    | 16-May-19 | 13:00 | x64      |
| Txsampling.dll                                     | 2015.131.5337.0 | 134752    | 16-May-19 | 13:10 | x86      |
| Txscd.dll                                          | 2015.131.5337.0 | 220464    | 16-May-19 | 13:00 | x64      |
| Txscd.dll                                          | 2015.131.5337.0 | 169568    | 16-May-19 | 13:10 | x86      |
| Txsort.dll                                         | 2015.131.5337.0 | 259168    | 16-May-19 | 13:00 | x64      |
| Txsort.dll                                         | 2015.131.5337.0 | 211040    | 16-May-19 | 13:10 | x86      |
| Txsplit.dll                                        | 2015.131.5337.0 | 600880    | 16-May-19 | 13:00 | x64      |
| Txsplit.dll                                        | 2015.131.5337.0 | 513112    | 16-May-19 | 13:10 | x86      |
| Txtermextraction.dll                               | 2015.131.5337.0 | 8678192   | 16-May-19 | 13:00 | x64      |
| Txtermextraction.dll                               | 2015.131.5337.0 | 8615520   | 16-May-19 | 13:10 | x86      |
| Txtermlookup.dll                                   | 2015.131.5337.0 | 4158768   | 16-May-19 | 13:00 | x64      |
| Txtermlookup.dll                                   | 2015.131.5337.0 | 4106848   | 16-May-19 | 13:10 | x86      |
| Txunionall.dll                                     | 2015.131.5337.0 | 182064    | 16-May-19 | 13:00 | x64      |
| Txunionall.dll                                     | 2015.131.5337.0 | 138840    | 16-May-19 | 13:10 | x86      |
| Txunpivot.dll                                      | 2015.131.5337.0 | 201824    | 16-May-19 | 13:00 | x64      |
| Txunpivot.dll                                      | 2015.131.5337.0 | 162400    | 16-May-19 | 13:10 | x86      |
| Xe.dll                                             | 2015.131.5337.0 | 626480    | 16-May-19 | 13:12 | x64      |
| Xe.dll                                             | 2015.131.5337.0 | 558680    | 16-May-19 | 13:17 | x86      |

SQL Server 2016 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 10.0.8224.47     | 483408    | 12-Dec-18 | 03:25 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.47 | 75344     | 12-Dec-18 | 03:25 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.47     | 45648     | 12-Dec-18 | 03:25 | x86      |
| Instapi130.dll                                                       | 2015.131.5337.0  | 61024     | 16-May-19 | 13:00 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 10.0.8224.47     | 74320     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 10.0.8224.47     | 201808    | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 10.0.8224.47     | 2347088   | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 10.0.8224.47     | 101968    | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 10.0.8224.47     | 378448    | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 10.0.8224.47     | 185424    | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 10.0.8224.47     | 127056    | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 10.0.8224.47     | 63056     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 10.0.8224.47     | 52304     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 10.0.8224.47     | 87120     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 10.0.8224.47     | 721488    | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 10.0.8224.47     | 87120     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 10.0.8224.47     | 77904     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 10.0.8224.47     | 41552     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 10.0.8224.47     | 36424     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 10.0.8224.47     | 47696     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 10.0.8224.47     | 27216     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 10.0.8224.47     | 32848     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 10.0.8224.47     | 118864    | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 10.0.8224.47     | 94288     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 10.0.8224.47     | 108112    | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 10.0.8224.47     | 256592    | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.47     | 101968    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.47     | 115792    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.47     | 118864    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.47     | 115792    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.47     | 125520    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.47     | 117840    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.47     | 113232    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.47     | 145488    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.47     | 99920     | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.47     | 114768    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 10.0.8224.47     | 69200     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 10.0.8224.47     | 28240     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 10.0.8224.47     | 43600     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 10.0.8224.47     | 82000     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 10.0.8224.47     | 136784    | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 10.0.8224.47     | 2155600   | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 10.0.8224.47     | 3818576   | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.47     | 107600    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.47     | 119888    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.47     | 124496    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.47     | 120912    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.47     | 133200    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.47     | 120912    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.47     | 118352    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.47     | 152144    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.47     | 105040    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.47     | 119376    | 12-Dec-18 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 10.0.8224.47     | 66640     | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 10.0.8224.47     | 2756176   | 12-Dec-18 | 03:25 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 10.0.8224.47     | 752200    | 12-Dec-18 | 03:25 | x86      |
| Mpdwinterop.dll                                                      | 2015.131.5337.0  | 394848    | 16-May-19 | 13:09 | x64      |
| Mpdwsvc.exe                                                          | 2015.131.5337.0  | 6618416   | 16-May-19 | 13:13 | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.47 | 47184     | 12-Dec-18 | 03:26 | x64      |
| Sqldk.dll                                                            | 2015.131.5337.0  | 2533168   | 16-May-19 | 13:00 | x64      |
| Sqldumper.exe                                                        | 2015.131.5337.0  | 127280    | 16-May-19 | 13:12 | x64      |
| Sqlncli13e.dll                                                       | 2015.131.5337.0  | 2230064   | 16-May-19 | 13:00 | x64      |
| Sqlos.dll                                                            | 2015.131.5337.0  | 26208     | 16-May-19 | 13:00 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.47 | 4347984   | 12-Dec-18 | 03:26 | x64      |
| Sqltses.dll                                                          | 2015.131.5337.0  | 9092912   | 16-May-19 | 13:00 | x64      |

SQL Server 2016 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.5337.0     | 23856     | 16-May-19 | 13:11 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.131.5337.0 | 100656    | 16-May-19 | 13:14 | x64      |

SQL Server 2016 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| As_msmdlocal_dll.32                            | 2015.131.5337.0 | 37103912  | 16-May-19 | 13:12 | x86      |
| As_msmdlocal_dll.64                            | 2015.131.5337.0 | 56208984  | 16-May-19 | 13:14 | x64      |
| Autoadmin.dll                                  | 2015.131.5337.0 | 1311840   | 16-May-19 | 13:10 | x86      |
| Ddsshapeslib.dll                               | 2015.131.5337.0 | 135776    | 16-May-19 | 13:10 | x86      |
| Dtaengine.exe                                  | 2015.131.5337.0 | 167216    | 16-May-19 | 13:11 | x86      |
| Dteparse.dll                                   | 2015.131.5337.0 | 99424     | 16-May-19 | 13:10 | x86      |
| Dteparse.dll                                   | 2015.131.5337.0 | 109872    | 16-May-19 | 13:14 | x64      |
| Dteparsemgd.dll                                | 2015.131.5337.0 | 83544     | 16-May-19 | 13:11 | x86      |
| Dteparsemgd.dll                                | 2015.131.5337.0 | 88664     | 16-May-19 | 13:16 | x64      |
| Dtepkg.dll                                     | 2015.131.5337.0 | 115808    | 16-May-19 | 13:10 | x86      |
| Dtepkg.dll                                     | 2015.131.5337.0 | 137304    | 16-May-19 | 13:14 | x64      |
| Dtexec.exe                                     | 2015.131.5337.0 | 66648     | 16-May-19 | 13:11 | x86      |
| Dtexec.exe                                     | 2015.131.5337.0 | 72792     | 16-May-19 | 13:11 | x64      |
| Dts.dll                                        | 2015.131.5337.0 | 2632800   | 16-May-19 | 13:10 | x86      |
| Dts.dll                                        | 2015.131.5337.0 | 3147080   | 16-May-19 | 13:14 | x64      |
| Dtscomexpreval.dll                             | 2015.131.5337.0 | 418912    | 16-May-19 | 13:10 | x86      |
| Dtscomexpreval.dll                             | 2015.131.5337.0 | 477272    | 16-May-19 | 13:14 | x64      |
| Dtsconn.dll                                    | 2015.131.5337.0 | 392288    | 16-May-19 | 13:09 | x86      |
| Dtsconn.dll                                    | 2015.131.5337.0 | 492632    | 16-May-19 | 13:14 | x64      |
| Dtshost.exe                                    | 2015.131.5337.0 | 76376     | 16-May-19 | 13:11 | x86      |
| Dtshost.exe                                    | 2015.131.5337.0 | 86616     | 16-May-19 | 13:11 | x64      |
| Dtslog.dll                                     | 2015.131.5337.0 | 103008    | 16-May-19 | 13:10 | x86      |
| Dtslog.dll                                     | 2015.131.5337.0 | 120624    | 16-May-19 | 13:14 | x64      |
| Dtsmsg150.dll                                  | 2015.131.5337.0 | 541280    | 16-May-19 | 13:09 | x86      |
| Dtsmsg150.dll                                  | 2015.131.5337.0 | 545368    | 16-May-19 | 13:14 | x64      |
| Dtspipeline.dll                                | 2015.131.5337.0 | 1059424   | 16-May-19 | 13:09 | x86      |
| Dtspipeline.dll                                | 2015.131.5337.0 | 1279064   | 16-May-19 | 13:14 | x64      |
| Dtspipelineperf150.dll                         | 2015.131.5337.0 | 42080     | 16-May-19 | 13:10 | x86      |
| Dtspipelineperf150.dll                         | 2015.131.5337.0 | 48216     | 16-May-19 | 13:14 | x64      |
| Dtuparse.dll                                   | 2015.131.5337.0 | 79968     | 16-May-19 | 13:10 | x86      |
| Dtuparse.dll                                   | 2015.131.5337.0 | 87640     | 16-May-19 | 13:14 | x64      |
| Dtutil.exe                                     | 2015.131.5337.0 | 115504    | 16-May-19 | 13:11 | x86      |
| Dtutil.exe                                     | 2015.131.5337.0 | 134960    | 16-May-19 | 13:12 | x64      |
| Exceldest.dll                                  | 2015.131.5337.0 | 216672    | 16-May-19 | 13:10 | x86      |
| Exceldest.dll                                  | 2015.131.5337.0 | 263464    | 16-May-19 | 13:14 | x64      |
| Excelsrc.dll                                   | 2015.131.5337.0 | 232544    | 16-May-19 | 13:09 | x86      |
| Excelsrc.dll                                   | 2015.131.5337.0 | 285512    | 16-May-19 | 13:14 | x64      |
| Flatfiledest.dll                               | 2015.131.5337.0 | 334432    | 16-May-19 | 13:09 | x86      |
| Flatfiledest.dll                               | 2015.131.5337.0 | 389416    | 16-May-19 | 13:14 | x64      |
| Flatfilesrc.dll                                | 2015.131.5337.0 | 345184    | 16-May-19 | 13:10 | x86      |
| Flatfilesrc.dll                                | 2015.131.5337.0 | 401704    | 16-May-19 | 13:14 | x64      |
| Foreachfileenumerator.dll                      | 2015.131.5337.0 | 80480     | 16-May-19 | 13:10 | x86      |
| Foreachfileenumerator.dll                      | 2015.131.5337.0 | 96344     | 16-May-19 | 13:14 | x64      |
| Microsoft.analysisservices.adomdclientui.dll   | 13.0.5337.0     | 92248     | 16-May-19 | 13:11 | x86      |
| Microsoft.analysisservices.applocal.core.dll   | 13.0.5337.0     | 1313880   | 16-May-19 | 13:11 | x86      |
| Microsoft.analysisservices.project.dll         | 2015.131.5337.0 | 2023216   | 16-May-19 | 13:11 | x86      |
| Microsoft.analysisservices.projectui.dll       | 2015.131.5337.0 | 42072     | 16-May-19 | 13:11 | x86      |
| Microsoft.sqlserver.astasks.dll                | 13.0.5337.0     | 73520     | 16-May-19 | 13:15 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5337.0     | 436040    | 16-May-19 | 13:15 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5337.0     | 436016    | 16-May-19 | 13:18 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5337.0     | 2044504   | 16-May-19 | 13:15 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5337.0     | 2044504   | 16-May-19 | 13:17 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5337.0 | 138840    | 16-May-19 | 13:08 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5337.0 | 150104    | 16-May-19 | 13:15 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5337.0 | 144472    | 16-May-19 | 13:09 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5337.0 | 158808    | 16-May-19 | 13:15 | x64      |
| Msdtssrvrutil.dll                              | 2015.131.5337.0 | 90416     | 16-May-19 | 13:11 | x86      |
| Msdtssrvrutil.dll                              | 2015.131.5337.0 | 101464    | 16-May-19 | 13:16 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5337.0 | 6507824   | 16-May-19 | 13:12 | x86      |
| Msmgdsrv.dll                                   | 2015.131.5337.0 | 7507248   | 16-May-19 | 13:12 | x64      |
| Msolap130.dll                                  | 2015.131.5337.0 | 7008344   | 16-May-19 | 13:11 | x86      |
| Msolap130.dll                                  | 2015.131.5337.0 | 8639280   | 16-May-19 | 13:14 | x64      |
| Msolui130.dll                                  | 2015.131.5337.0 | 287536    | 16-May-19 | 13:11 | x86      |
| Msolui130.dll                                  | 2015.131.5337.0 | 310360    | 16-May-19 | 13:14 | x64      |
| Oledbdest.dll                                  | 2015.131.5337.0 | 216880    | 16-May-19 | 13:11 | x86      |
| Oledbdest.dll                                  | 2015.131.5337.0 | 264280    | 16-May-19 | 13:14 | x64      |
| Oledbsrc.dll                                   | 2015.131.5337.0 | 235824    | 16-May-19 | 13:11 | x86      |
| Oledbsrc.dll                                   | 2015.131.5337.0 | 291120    | 16-May-19 | 13:13 | x64      |
| Profiler.exe                                   | 2015.131.5337.0 | 804656    | 16-May-19 | 13:11 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.131.5337.0 | 100656    | 16-May-19 | 13:14 | x64      |
| Sqldumper.exe                                  | 2015.131.5337.0 | 107608    | 16-May-19 | 13:10 | x86      |
| Sqldumper.exe                                  | 2015.131.5337.0 | 127064    | 16-May-19 | 13:14 | x64      |
| Sqlresld.dll                                   | 2015.131.5337.0 | 30816     | 16-May-19 | 13:00 | x64      |
| Sqlresld.dll                                   | 2015.131.5337.0 | 28760     | 16-May-19 | 13:11 | x86      |
| Sqlresourceloader.dll                          | 2015.131.5337.0 | 31024     | 16-May-19 | 13:00 | x64      |
| Sqlresourceloader.dll                          | 2015.131.5337.0 | 28248     | 16-May-19 | 13:12 | x86      |
| Sqlscm.dll                                     | 2015.131.5337.0 | 52824     | 16-May-19 | 13:11 | x86      |
| Sqlscm.dll                                     | 2015.131.5337.0 | 61232     | 16-May-19 | 13:12 | x64      |
| Sqlsvc.dll                                     | 2015.131.5337.0 | 152392    | 16-May-19 | 13:00 | x64      |
| Sqlsvc.dll                                     | 2015.131.5337.0 | 127064    | 16-May-19 | 13:11 | x86      |
| Sqltaskconnections.dll                         | 2015.131.5337.0 | 181040    | 16-May-19 | 13:00 | x64      |
| Sqltaskconnections.dll                         | 2015.131.5337.0 | 151128    | 16-May-19 | 13:11 | x86      |
| Txdataconvert.dll                              | 2015.131.5337.0 | 296544    | 16-May-19 | 13:00 | x64      |
| Txdataconvert.dll                              | 2015.131.5337.0 | 255072    | 16-May-19 | 13:10 | x86      |
| Xe.dll                                         | 2015.131.5337.0 | 626480    | 16-May-19 | 13:12 | x64      |
| Xe.dll                                         | 2015.131.5337.0 | 558680    | 16-May-19 | 13:17 | x86      |
| Xmlrw.dll                                      | 2015.131.5337.0 | 259680    | 16-May-19 | 13:10 | x86      |
| Xmlrw.dll                                      | 2015.131.5337.0 | 319064    | 16-May-19 | 13:11 | x64      |
| Xmlrwbin.dll                                   | 2015.131.5337.0 | 191584    | 16-May-19 | 13:10 | x86      |
| Xmlrwbin.dll                                   | 2015.131.5337.0 | 227416    | 16-May-19 | 13:10 | x64      |
| Xmsrv.dll                                      | 2015.131.5337.0 | 24050992  | 16-May-19 | 13:00 | x64      |
| Xmsrv.dll                                      | 2015.131.5337.0 | 32727648  | 16-May-19 | 13:10 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
