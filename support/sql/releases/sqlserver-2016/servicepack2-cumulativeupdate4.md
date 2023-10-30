---
title: Cumulative update 4 for SQL Server 2016 SP2 (KB4464106)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 Service Pack 2 (SP2) cumulative update 4 (KB4464106).
ms.date: 10/26/2023
ms.custom: KB4464106
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Express
- SQL Server 2016 Web
---

# KB4464106 - Cumulative Update 4 for SQL Server 2016 SP2

_Release Date:_ &nbsp; November 13, 2018  
_Version:_ &nbsp; 13.0.5233.0

This article describes Cumulative Update package 4 (CU4) (build number: **13.0.5233.0**) for Microsoft SQL Server 2016 Service Pack 2 (SP2). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the initial release of SQL Server 2016 SP2.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---|---|---|
| <a id="12253702">[12253702](#12253702)</a> | [FIX: "ORA-01036: illegal variable name/number" when you query an Oracle database in SSAS 2016 (KB4465249)](https://support.microsoft.com/help/4465249) | Analysis Services |
| <a id="12427355">[12427355](#12427355)</a> | [FIX: "A connection cannot be made" error when SSIS package uses a parameterized connection manager in SQL Server 2016 (KB4466831)](https://support.microsoft.com/help/4466831) | Analysis Services |
| <a id="12458031">[12458031](#12458031)</a> | [FIX: Access violation occurs and SSAS crashes when you process an SSAS database in SQL Server 2016 (KB4459981)](https://support.microsoft.com/help/4459981) | Analysis Services |
| <a id="12399709">[12399709](#12399709)</a> | FIX: Server may freeze when you send create session to call custom assembly in SSAS 2016 (KB4468868) | Analysis Services |
| <a id="12408293">[12408293](#12408293)</a> | FIX: Errors when changing filters in Excel or PBI reports after model is updated in SSAS (KB4465476) | Analysis Services |
| <a id="12449923">[12449923](#12449923)</a> | FIX: Relationships not working correctly on synchronized tabular database (KB4468869) | Analysis Services |
| <a id="12456157">[12456157](#12456157)</a> | [FIX: Can't connect to the MDS database by using the MDS Add-in for Microsoft Excel (KB4469292)](https://support.microsoft.com/help/4469292) | Data Quality Services (DQS) |
| <a id="12425044">[12425044](#12425044)</a> | FIX: Error occurs when you change the "Display value" of "Name" attribute of an entity to any value other than "Name" in SQL Server 2016 MDS Add-in for Excel (KB4462426) | Data Quality Services (DQS) |
| <a id="12466467">[12466467](#12466467)</a> | FIX: Can't add data to a new users attribute in an MDS database in SQL Server (KB4469815) | Data Quality Services (DQS) |
| <a id="12352282">[12352282](#12352282)</a> | FIX: `DefaultLanguage.LCID` property changes for partially contained In-Memory OLTP database (KB4469539) | High Availability |
| <a id="12399753">[12399753](#12399753)</a> | FIX: Assertion occurs when you use parallel redo in a secondary replica of SQL Server 2016 AG (KB4468322) | High Availability |
| <a id="12470289">[12470289](#12470289)</a> | [FIX: Assertion error occurs when you restart the SQL Server 2016 database (KB4466793)](https://support.microsoft.com/help/4466793) | In-Memory OLTP |
| <a id="12470305">[12470305](#12470305)</a> | [FIX: "3414" and "9003" errors and a .pmm log file grows large in SQL Server 2016 (KB4466994)](https://support.microsoft.com/help/4466994) | In-Memory OLTP |
| <a id="12224901">[12224901](#12224901)</a> | [FIX: Sharing violation when the "sp_cycle_agent_errorlog" stored procedure is run in SQL Server 2016 (KB4469942)](https://support.microsoft.com/help/4469942) | Management Tools |
| <a id="12524441">[12524441](#12524441)</a> | [FIX: Database Mail can't send email after you install CU1, CU2 or CU3 for SQL Server 2016 Service Pack 2 (KB4476949)](https://support.microsoft.com/help/4476949) | Management Tools |
| <a id="12399988">[12399988](#12399988)</a> | FIX: Snapshot Agent fails when you publish many tables using snapshot or transactional replication (KB4465747) | Management Tools |
| <a id="12180470">[12180470](#12180470)</a> | [FIX: Deadlock when you run the "CleanOrphanedPolicies" and "DeleteDataSources" built-in stored procedures together in SSRS 2016 (KB4019799)](https://support.microsoft.com/help/4019799) | Reporting Services |
| <a id="12418284">[12418284](#12418284)</a> | FIX: Inner error details won't be displayed to remote machine even after "Enable remote errors" is enabled in SSRS 2016 (KB4469857) | Reporting Services |
| <a id="12437948">[12437948](#12437948)</a> | FIX: Nested tablix shows small font or partial text in SSRS 2016 and later versions (KB4470528) | Reporting Services |
| <a id="11967430">[11967430](#11967430)</a> | [FIX: Assertion error occurs when you run a MERGE statement with an OUTPUT clause in SQL Server 2016 (KB4465745)](https://support.microsoft.com/help/4465745) | SQL Engine |
| <a id="12180165">[12180165](#12180165)</a> | [FIX: Access violation when you try to access a table when page compression is enabled on the table in SQL Server (KB4294694)](https://support.microsoft.com/help/4294694) | SQL Engine |
| <a id="12191968">[12191968](#12191968)</a> | [FIX: Access violation occurs when SQL Server 2016 tries to start Query Store Manager during startup (KB4052133)](https://support.microsoft.com/help/4052133) | SQL Engine |
| <a id="12245671">[12245671](#12245671)</a> | [FIX: SQL Server may generate EXCEPTION_ACCESS_VIOLATION dump file when you merge two partitions of system-versioned temporal tables in SQL Server 2016 (KB4338761)](https://support.microsoft.com/help/4338761) | SQL Engine |
| <a id="12339098">[12339098](#12339098)</a> | [FIX: Query plans are different on clone database created by DBCC CLONEDATABASE and its original database in SQL Server 2016 (KB4467058)](https://support.microsoft.com/help/4467058) | SQL Engine |
| <a id="12342903">[12342903](#12342903)</a> | [FIX: Excessive memory usage when you trace RPC events that involve Table-Valued Parameters in SQL Server 2016 (KB4468102)](https://support.microsoft.com/help/4468102) | SQL Engine |
| <a id="12357601">[12357601](#12357601)</a> | [FIX: Backing up a SQL Server 2008 database by using a VSS backup application may fail after installing CU2 for SQL Server 2016 SP2 (KB4466108)](https://support.microsoft.com/help/4466108) | SQL Engine |
| <a id="12357741">[12357741](#12357741)</a> | [FIX: Access violation occurs in Distribution Agent in SQL Server 2016 (KB4468103)](https://support.microsoft.com/help/4468103) | SQL Engine |
| <a id="12357915">[12357915](#12357915)</a> | [FIX: Access violation occurs in compile code when you parse the forced plan in SQL Server 2016 (KB4465236)](https://support.microsoft.com/help/4465236) | SQL Engine |
| <a id="12430193">[12430193](#12430193)</a> | [FIX: Assertion error occurs during restoration of TDE compressed backups in SQL Server 2016 (KB4469554)](https://support.microsoft.com/help/4469554) | SQL Engine |
| <a id="12458043">[12458043](#12458043)</a> | [FIX: "ran out of memory" error when executing a query on a table that has a large full-text index in SQL Server 2016 (KB4465867)](https://support.microsoft.com/help/4465867) | SQL Engine |
| <a id="12466220">[12466220](#12466220)</a> | [FIX: "9003 error, sev 20, state 1" error when a backup operation fails on a secondary replica that is running under asynchronous-commit mode (KB4458880)](https://support.microsoft.com/help/4458880) | SQL Engine |
| <a id="12389928">[12389928](#12389928)</a> | FIX: Access violation occurs when you query data from a view created on a table with columnstore index in SQL Server 2016 (KB4467119) | SQL Engine |
| <a id="12409272">[12409272](#12409272)</a> | FIX: The "`modification_counter`" in DMV `sys.dm_db_stats_properties` shows incorrect value when partitions are merged through `ALTER PARTITION` in SQL Server 2016 (KB4465443) | SQL Engine |
| <a id="12321047">[12321047](#12321047)</a> | [FIX: Query operation freezes when you insert data into a clustered columnstore index in parallel in SQL Server data warehousing (KB4462481)](https://support.microsoft.com/help/4462481) | SQL performance |
| <a id="12458028">[12458028](#12458028)</a> | [FIX: Overestimations when using default Cardinality Estimator to query table with many null values (KB4460116)](https://support.microsoft.com/help/4460116) | SQL performance |
| <a id="12458621">[12458621](#12458621)</a> | [FIX: Error 3961 occurs when you use Application roles for the second time in read-only secondary replicas in SQL Server 2016 AG (KB4469908)](https://support.microsoft.com/help/4469908) | SQL security |
| <a id="12494639">[12494639](#12494639)</a> | FIX: Access violation when you run a granular audit policy for DML in SQL Server (KB4470991) | SQL security |

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

SQL Server 2016 Browser Service

|    File name   |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi130.dll | 2015.131.5233.0 | 53536     | 03-Nov-18 | 09:01 | x86      |
| Keyfile.dll    | 2015.131.5233.0 | 88848     | 03-Nov-18 | 09:01 | x86      |
| Sqlbrowser.exe | 2015.131.5233.0 | 276768    | 03-Nov-18 | 09:01 | x86      |
| Sqldumper.exe  | 2015.131.5233.0 | 107816    | 03-Nov-18 | 09:01 | x86      |

SQL Server 2016 Writer

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi130.dll        | 2015.131.5233.0 | 61216     | 03-Nov-18 | 09:02 | x64      |
| Sqlboot.dll           | 2015.131.5233.0 | 186640    | 03-Nov-18 | 09:04 | x64      |
| Sqldumper.exe         | 2015.131.5233.0 | 127248    | 03-Nov-18 | 09:04 | x64      |
| Sqlvdi.dll            | 2015.131.5233.0 | 168728    | 03-Nov-18 | 09:01 | x86      |
| Sqlvdi.dll            | 2015.131.5233.0 | 197416    | 03-Nov-18 | 09:02 | x64      |
| Sqlwriter.exe         | 2015.131.5233.0 | 131872    | 03-Nov-18 | 09:02 | x64      |
| Sqlwriter_keyfile.dll | 2015.131.5233.0 | 100632    | 03-Nov-18 | 09:04 | x64      |
| Sqlwvss.dll           | 2015.131.5233.0 | 342840    | 03-Nov-18 | 09:01 | x64      |
| Sqlwvss_xp.dll        | 2015.131.5233.0 | 26400     | 03-Nov-18 | 09:01 | x64      |

SQL Server 2016 Analysis Services

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.server.core.dll | 13.0.5233.0     | 1348368   | 03-Nov-18 | 09:03 | x86      |
| Microsoft.applicationinsights.dll          | 2.7.0.13435     | 329872    | 06-Jul-18 | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5233.0     | 990496    | 03-Nov-18 | 09:01 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5233.0     | 990480    | 03-Nov-18 | 09:03 | x86      |
| Msmdctr130.dll                             | 2015.131.5233.0 | 40216     | 03-Nov-18 | 09:04 | x64      |
| Msmdlocal.dll                              | 2015.131.5233.0 | 37100312  | 03-Nov-18 | 09:01 | x86      |
| Msmdlocal.dll                              | 2015.131.5233.0 | 56209688  | 03-Nov-18 | 09:04 | x64      |
| Msmdsrv.exe                                | 2015.131.5233.0 | 56748320  | 03-Nov-18 | 09:02 | x64      |
| Msmgdsrv.dll                               | 2015.131.5233.0 | 6507792   | 03-Nov-18 | 09:01 | x86      |
| Msmgdsrv.dll                               | 2015.131.5233.0 | 7507232   | 03-Nov-18 | 09:01 | x64      |
| Msolui130.dll                              | 2015.131.5233.0 | 287512    | 03-Nov-18 | 09:01 | x86      |
| Msolui130.dll                              | 2015.131.5233.0 | 310544    | 03-Nov-18 | 09:04 | x64      |
| Sql_as_keyfile.dll                         | 2015.131.5233.0 | 100632    | 03-Nov-18 | 09:04 | x64      |
| Sqlboot.dll                                | 2015.131.5233.0 | 186640    | 03-Nov-18 | 09:04 | x64      |
| Sqlceip.exe                                | 13.0.5233.0     | 256280    | 03-Nov-18 | 09:03 | x86      |
| Sqldumper.exe                              | 2015.131.5233.0 | 107816    | 03-Nov-18 | 09:01 | x86      |
| Sqldumper.exe                              | 2015.131.5233.0 | 127248    | 03-Nov-18 | 09:04 | x64      |
| Tmapi.dll                                  | 2015.131.5233.0 | 4346144   | 03-Nov-18 | 09:01 | x64      |
| Tmcachemgr.dll                             | 2015.131.5233.0 | 2826528   | 03-Nov-18 | 09:01 | x64      |
| Tmpersistence.dll                          | 2015.131.5233.0 | 1071400   | 03-Nov-18 | 09:01 | x64      |
| Tmtransactions.dll                         | 2015.131.5233.0 | 1352480   | 03-Nov-18 | 09:01 | x64      |
| Xe.dll                                     | 2015.131.5233.0 | 626464    | 03-Nov-18 | 09:02 | x64      |
| Xmlrw.dll                                  | 2015.131.5233.0 | 319272    | 03-Nov-18 | 09:02 | x64      |
| Xmlrw.dll                                  | 2015.131.5233.0 | 259856    | 03-Nov-18 | 09:03 | x86      |
| Xmlrwbin.dll                               | 2015.131.5233.0 | 227616    | 03-Nov-18 | 09:02 | x64      |
| Xmlrwbin.dll                               | 2015.131.5233.0 | 191760    | 03-Nov-18 | 09:03 | x86      |
| Xmsrv.dll                                  | 2015.131.5233.0 | 24050984  | 03-Nov-18 | 09:02 | x64      |
| Xmsrv.dll                                  | 2015.131.5233.0 | 32727824  | 03-Nov-18 | 09:03 | x86      |

SQL Server 2016 Database Services Common Core

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                            | 2015.131.5233.0 | 160552    | 03-Nov-18 | 09:01 | x86      |
| Batchparser.dll                            | 2015.131.5233.0 | 181024    | 03-Nov-18 | 09:02 | x64      |
| Instapi130.dll                             | 2015.131.5233.0 | 53536     | 03-Nov-18 | 09:01 | x86      |
| Instapi130.dll                             | 2015.131.5233.0 | 61216     | 03-Nov-18 | 09:02 | x64      |
| Isacctchange.dll                           | 2015.131.5233.0 | 29472     | 03-Nov-18 | 09:01 | x86      |
| Isacctchange.dll                           | 2015.131.5233.0 | 30992     | 03-Nov-18 | 09:04 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 13.0.5233.0     | 1027856   | 03-Nov-18 | 09:02 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 13.0.5233.0     | 1027856   | 03-Nov-18 | 09:03 | x86      |
| Microsoft.analysisservices.core.dll        | 13.0.5233.0     | 1348880   | 03-Nov-18 | 09:02 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.5233.0     | 711960    | 03-Nov-18 | 09:02 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.5233.0     | 711952    | 03-Nov-18 | 09:03 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.131.5233.0 | 72976     | 03-Nov-18 | 09:02 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.131.5233.0 | 75560     | 03-Nov-18 | 09:02 | x64      |
| Msasxpress.dll                             | 2015.131.5233.0 | 32024     | 03-Nov-18 | 09:01 | x86      |
| Msasxpress.dll                             | 2015.131.5233.0 | 36112     | 03-Nov-18 | 09:04 | x64      |
| Pbsvcacctsync.dll                          | 2015.131.5233.0 | 60184     | 03-Nov-18 | 09:01 | x86      |
| Pbsvcacctsync.dll                          | 2015.131.5233.0 | 72976     | 03-Nov-18 | 09:04 | x64      |
| Sql_common_core_keyfile.dll                | 2015.131.5233.0 | 100632    | 03-Nov-18 | 09:04 | x64      |
| Sqldumper.exe                              | 2015.131.5233.0 | 107816    | 03-Nov-18 | 09:01 | x86      |
| Sqldumper.exe                              | 2015.131.5233.0 | 127248    | 03-Nov-18 | 09:04 | x64      |
| Sqlftacct.dll                              | 2015.131.5233.0 | 46872     | 03-Nov-18 | 09:01 | x86      |
| Sqlftacct.dll                              | 2015.131.5233.0 | 51992     | 03-Nov-18 | 09:04 | x64      |
| Sqlmgmprovider.dll                         | 2015.131.5233.0 | 364312    | 03-Nov-18 | 09:01 | x86      |
| Sqlmgmprovider.dll                         | 2015.131.5233.0 | 404256    | 03-Nov-18 | 09:01 | x64      |
| Sqlsecacctchg.dll                          | 2015.131.5233.0 | 35096     | 03-Nov-18 | 09:01 | x86      |
| Sqlsecacctchg.dll                          | 2015.131.5233.0 | 37664     | 03-Nov-18 | 09:01 | x64      |
| Sqltdiagn.dll                              | 2015.131.5233.0 | 60696     | 03-Nov-18 | 09:01 | x86      |
| Sqltdiagn.dll                              | 2015.131.5233.0 | 67872     | 03-Nov-18 | 09:01 | x64      |

SQL Server 2016 sql_dreplay_client

|            File name           |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2015.131.5233.0 | 121128    | 03-Nov-18 | 09:01 | x86      |
| Dreplaycommon.dll              | 2015.131.5233.0 | 690960    | 03-Nov-18 | 09:02 | x86      |
| Dreplayutil.dll                | 2015.131.5233.0 | 310048    | 03-Nov-18 | 09:01 | x86      |
| Instapi130.dll                 | 2015.131.5233.0 | 61216     | 03-Nov-18 | 09:02 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.131.5233.0 | 100632    | 03-Nov-18 | 09:04 | x64      |
| Sqlresourceloader.dll          | 2015.131.5233.0 | 28440     | 03-Nov-18 | 09:01 | x86      |

SQL Server 2016 sql_dreplay_controller

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2015.131.5233.0 | 690960    | 03-Nov-18 | 09:02 | x86      |
| Dreplaycontroller.exe              | 2015.131.5233.0 | 350496    | 03-Nov-18 | 09:01 | x86      |
| Dreplayprocess.dll                 | 2015.131.5233.0 | 171816    | 03-Nov-18 | 09:01 | x86      |
| Instapi130.dll                     | 2015.131.5233.0 | 61216     | 03-Nov-18 | 09:02 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.131.5233.0 | 100632    | 03-Nov-18 | 09:04 | x64      |
| Sqlresourceloader.dll              | 2015.131.5233.0 | 28440     | 03-Nov-18 | 09:01 | x86      |

SQL Server 2016 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Backuptourl.exe                              | 13.0.5233.0     | 41248     | 03-Nov-18 | 09:02 | x64      |
| Batchparser.dll                              | 2015.131.5233.0 | 181024    | 03-Nov-18 | 09:02 | x64      |
| Datacollectorcontroller.dll                  | 2015.131.5233.0 | 225552    | 03-Nov-18 | 09:04 | x64      |
| Dcexec.exe                                   | 2015.131.5233.0 | 74528     | 03-Nov-18 | 09:02 | x64      |
| Fssres.dll                                   | 2015.131.5233.0 | 81680     | 03-Nov-18 | 09:04 | x64      |
| Hadrres.dll                                  | 2015.131.5233.0 | 177976    | 03-Nov-18 | 09:02 | x64      |
| Hkcompile.dll                                | 2015.131.5233.0 | 1298232   | 03-Nov-18 | 09:02 | x64      |
| Hkengine.dll                                 | 2015.131.5233.0 | 5601056   | 03-Nov-18 | 09:02 | x64      |
| Hkruntime.dll                                | 2015.131.5233.0 | 159008    | 03-Nov-18 | 09:02 | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 06-Jul-18 | 22:33 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.131.5233.0 | 72488     | 03-Nov-18 | 09:01 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.131.5233.0 | 65312     | 03-Nov-18 | 09:02 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5233.0 | 150304    | 03-Nov-18 | 09:02 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5233.0 | 159008    | 03-Nov-18 | 09:02 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.131.5233.0 | 272184    | 03-Nov-18 | 09:02 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.131.5233.0 | 75040     | 03-Nov-18 | 09:02 | x64      |
| Odsole70.dll                                 | 2015.131.5233.0 | 92944     | 03-Nov-18 | 09:04 | x64      |
| Opends60.dll                                 | 2015.131.5233.0 | 33056     | 03-Nov-18 | 09:02 | x64      |
| Qds.dll                                      | 2015.131.5233.0 | 862488    | 03-Nov-18 | 09:04 | x64      |
| Rsfxft.dll                                   | 2015.131.5233.0 | 34592     | 03-Nov-18 | 09:02 | x64      |
| Sqagtres.dll                                 | 2015.131.5233.0 | 64784     | 03-Nov-18 | 09:04 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.131.5233.0 | 100632    | 03-Nov-18 | 09:04 | x64      |
| Sqlaamss.dll                                 | 2015.131.5233.0 | 80672     | 03-Nov-18 | 09:01 | x64      |
| Sqlaccess.dll                                | 2015.131.5233.0 | 462632    | 03-Nov-18 | 09:02 | x64      |
| Sqlagent.exe                                 | 2015.131.5233.0 | 566560    | 03-Nov-18 | 09:02 | x64      |
| Sqlagentctr130.dll                           | 2015.131.5233.0 | 44312     | 03-Nov-18 | 09:01 | x86      |
| Sqlagentctr130.dll                           | 2015.131.5233.0 | 52000     | 03-Nov-18 | 09:04 | x64      |
| Sqlagentlog.dll                              | 2015.131.5233.0 | 33040     | 03-Nov-18 | 09:04 | x64      |
| Sqlagentmail.dll                             | 2015.131.5233.0 | 47904     | 03-Nov-18 | 09:01 | x64      |
| Sqlboot.dll                                  | 2015.131.5233.0 | 186640    | 03-Nov-18 | 09:04 | x64      |
| Sqlceip.exe                                  | 13.0.5233.0     | 256280    | 03-Nov-18 | 09:03 | x86      |
| Sqlcmdss.dll                                 | 2015.131.5233.0 | 60176     | 03-Nov-18 | 09:04 | x64      |
| Sqldk.dll                                    | 2015.131.5233.0 | 2587920   | 03-Nov-18 | 09:04 | x64      |
| Sqldtsss.dll                                 | 2015.131.5233.0 | 97568     | 03-Nov-18 | 09:01 | x64      |
| Sqliosim.com                                 | 2015.131.5233.0 | 308000    | 03-Nov-18 | 09:04 | x64      |
| Sqliosim.exe                                 | 2015.131.5233.0 | 3014432   | 03-Nov-18 | 09:02 | x64      |
| Sqllang.dll                                  | 2015.131.5233.0 | 39511312  | 03-Nov-18 | 09:04 | x64      |
| Sqlmin.dll                                   | 2015.131.5233.0 | 37887784  | 03-Nov-18 | 09:02 | x64      |
| Sqlolapss.dll                                | 2015.131.5233.0 | 98080     | 03-Nov-18 | 09:01 | x64      |
| Sqlos.dll                                    | 2015.131.5233.0 | 26400     | 03-Nov-18 | 09:02 | x64      |
| Sqlpowershellss.dll                          | 2015.131.5233.0 | 58656     | 03-Nov-18 | 09:01 | x64      |
| Sqlrepss.dll                                 | 2015.131.5233.0 | 55072     | 03-Nov-18 | 09:01 | x64      |
| Sqlresld.dll                                 | 2015.131.5233.0 | 31008     | 03-Nov-18 | 09:01 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5233.0 | 31008     | 03-Nov-18 | 09:01 | x64      |
| Sqlscm.dll                                   | 2015.131.5233.0 | 61224     | 03-Nov-18 | 09:02 | x64      |
| Sqlscriptdowngrade.dll                       | 2015.131.5233.0 | 27936     | 03-Nov-18 | 09:01 | x64      |
| Sqlscriptupgrade.dll                         | 2015.131.5233.0 | 5807904   | 03-Nov-18 | 09:02 | x64      |
| Sqlserverspatial130.dll                      | 2015.131.5233.0 | 732960    | 03-Nov-18 | 09:02 | x64      |
| Sqlservr.exe                                 | 2015.131.5233.0 | 393504    | 03-Nov-18 | 09:02 | x64      |
| Sqlsvc.dll                                   | 2015.131.5233.0 | 152352    | 03-Nov-18 | 09:01 | x64      |
| Sqltses.dll                                  | 2015.131.5233.0 | 8922408   | 03-Nov-18 | 09:01 | x64      |
| Sqsrvres.dll                                 | 2015.131.5233.0 | 251176    | 03-Nov-18 | 09:01 | x64      |
| Xe.dll                                       | 2015.131.5233.0 | 626464    | 03-Nov-18 | 09:02 | x64      |
| Xmlrw.dll                                    | 2015.131.5233.0 | 319272    | 03-Nov-18 | 09:02 | x64      |
| Xmlrwbin.dll                                 | 2015.131.5233.0 | 227616    | 03-Nov-18 | 09:02 | x64      |
| Xpadsi.exe                                   | 2015.131.5233.0 | 79120     | 03-Nov-18 | 09:05 | x64      |
| Xplog70.dll                                  | 2015.131.5233.0 | 65824     | 03-Nov-18 | 09:02 | x64      |
| Xpsqlbot.dll                                 | 2015.131.5233.0 | 33568     | 03-Nov-18 | 09:02 | x64      |
| Xpstar.dll                                   | 2015.131.5233.0 | 422688    | 03-Nov-18 | 09:02 | x64      |

SQL Server 2016 Database Services Core Shared

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2015.131.5233.0 | 160552    | 03-Nov-18 | 09:01 | x86      |
| Batchparser.dll                              | 2015.131.5233.0 | 181024    | 03-Nov-18 | 09:02 | x64      |
| Bcp.exe                                      | 2015.131.5233.0 | 120080    | 03-Nov-18 | 09:04 | x64      |
| Commanddest.dll                              | 2015.131.5233.0 | 249104    | 03-Nov-18 | 09:04 | x64      |
| Datacollectorenumerators.dll                 | 2015.131.5233.0 | 115992    | 03-Nov-18 | 09:04 | x64      |
| Datacollectortasks.dll                       | 2015.131.5233.0 | 188176    | 03-Nov-18 | 09:04 | x64      |
| Distrib.exe                                  | 2015.131.5233.0 | 191264    | 03-Nov-18 | 09:02 | x64      |
| Dteparse.dll                                 | 2015.131.5233.0 | 109840    | 03-Nov-18 | 09:04 | x64      |
| Dteparsemgd.dll                              | 2015.131.5233.0 | 88848     | 03-Nov-18 | 09:03 | x64      |
| Dtepkg.dll                                   | 2015.131.5233.0 | 137488    | 03-Nov-18 | 09:04 | x64      |
| Dtexec.exe                                   | 2015.131.5233.0 | 73016     | 03-Nov-18 | 09:02 | x64      |
| Dts.dll                                      | 2015.131.5233.0 | 3147024   | 03-Nov-18 | 09:04 | x64      |
| Dtscomexpreval.dll                           | 2015.131.5233.0 | 477456    | 03-Nov-18 | 09:04 | x64      |
| Dtsconn.dll                                  | 2015.131.5233.0 | 492816    | 03-Nov-18 | 09:04 | x64      |
| Dtshost.exe                                  | 2015.131.5233.0 | 86816     | 03-Nov-18 | 09:02 | x64      |
| Dtslog.dll                                   | 2015.131.5233.0 | 120592    | 03-Nov-18 | 09:04 | x64      |
| Dtsmsg130.dll                                | 2015.131.5233.0 | 545552    | 03-Nov-18 | 09:04 | x64      |
| Dtspipeline.dll                              | 2015.131.5233.0 | 1279256   | 03-Nov-18 | 09:04 | x64      |
| Dtspipelineperf130.dll                       | 2015.131.5233.0 | 48400     | 03-Nov-18 | 09:04 | x64      |
| Dtuparse.dll                                 | 2015.131.5233.0 | 87824     | 03-Nov-18 | 09:04 | x64      |
| Dtutil.exe                                   | 2015.131.5233.0 | 134944    | 03-Nov-18 | 09:02 | x64      |
| Exceldest.dll                                | 2015.131.5233.0 | 263440    | 03-Nov-18 | 09:04 | x64      |
| Excelsrc.dll                                 | 2015.131.5233.0 | 285456    | 03-Nov-18 | 09:04 | x64      |
| Execpackagetask.dll                          | 2015.131.5233.0 | 166680    | 03-Nov-18 | 09:04 | x64      |
| Flatfiledest.dll                             | 2015.131.5233.0 | 389400    | 03-Nov-18 | 09:04 | x64      |
| Flatfilesrc.dll                              | 2015.131.5233.0 | 401680    | 03-Nov-18 | 09:04 | x64      |
| Foreachfileenumerator.dll                    | 2015.131.5233.0 | 96528     | 03-Nov-18 | 09:04 | x64      |
| Hkengperfctrs.dll                            | 2015.131.5233.0 | 59168     | 03-Nov-18 | 09:02 | x64      |
| Logread.exe                                  | 2015.131.5233.0 | 626976    | 03-Nov-18 | 09:02 | x64      |
| Microsoft.analysisservices.applocal.core.dll | 13.0.5233.0     | 1314064   | 03-Nov-18 | 09:03 | x86      |
| Microsoft.sqlserver.replication.dll          | 2015.131.5233.0 | 1651488   | 03-Nov-18 | 09:01 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5233.0 | 150304    | 03-Nov-18 | 09:02 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5233.0 | 159008    | 03-Nov-18 | 09:02 | x64      |
| Msdtssrvrutil.dll                            | 2015.131.5233.0 | 101648    | 03-Nov-18 | 09:04 | x64      |
| Msxmlsql.dll                                 | 2015.131.5233.0 | 1494816   | 03-Nov-18 | 09:02 | x64      |
| Oledbdest.dll                                | 2015.131.5233.0 | 264464    | 03-Nov-18 | 09:04 | x64      |
| Oledbsrc.dll                                 | 2015.131.5233.0 | 291088    | 03-Nov-18 | 09:04 | x64      |
| Osql.exe                                     | 2015.131.5233.0 | 75536     | 03-Nov-18 | 09:04 | x64      |
| Rawdest.dll                                  | 2015.131.5233.0 | 209680    | 03-Nov-18 | 09:04 | x64      |
| Rawsource.dll                                | 2015.131.5233.0 | 196880    | 03-Nov-18 | 09:04 | x64      |
| Rdistcom.dll                                 | 2015.131.5233.0 | 907032    | 03-Nov-18 | 09:04 | x64      |
| Recordsetdest.dll                            | 2015.131.5233.0 | 187160    | 03-Nov-18 | 09:04 | x64      |
| Repldp.dll                                   | 2015.131.5233.0 | 281872    | 03-Nov-18 | 09:04 | x64      |
| Replprov.dll                                 | 2015.131.5233.0 | 812304    | 03-Nov-18 | 09:04 | x64      |
| Replrec.dll                                  | 2015.131.5233.0 | 1019176   | 03-Nov-18 | 09:01 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2015.131.5233.0 | 100632    | 03-Nov-18 | 09:04 | x64      |
| Sqlcmd.exe                                   | 2015.131.5233.0 | 249616    | 03-Nov-18 | 09:04 | x64      |
| Sqldiag.exe                                  | 2015.131.5233.0 | 1257760   | 03-Nov-18 | 09:02 | x64      |
| Sqllogship.exe                               | 13.0.5233.0     | 104728    | 03-Nov-18 | 09:03 | x64      |
| Sqlresld.dll                                 | 2015.131.5233.0 | 28952     | 03-Nov-18 | 09:01 | x86      |
| Sqlresld.dll                                 | 2015.131.5233.0 | 31008     | 03-Nov-18 | 09:01 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5233.0 | 28440     | 03-Nov-18 | 09:01 | x86      |
| Sqlresourceloader.dll                        | 2015.131.5233.0 | 31008     | 03-Nov-18 | 09:01 | x64      |
| Sqlscm.dll                                   | 2015.131.5233.0 | 53016     | 03-Nov-18 | 09:01 | x86      |
| Sqlscm.dll                                   | 2015.131.5233.0 | 61224     | 03-Nov-18 | 09:02 | x64      |
| Sqlsvc.dll                                   | 2015.131.5233.0 | 127256    | 03-Nov-18 | 09:01 | x86      |
| Sqlsvc.dll                                   | 2015.131.5233.0 | 152352    | 03-Nov-18 | 09:01 | x64      |
| Sqltaskconnections.dll                       | 2015.131.5233.0 | 181032    | 03-Nov-18 | 09:01 | x64      |
| Sqlwep130.dll                                | 2015.131.5233.0 | 105760    | 03-Nov-18 | 09:01 | x64      |
| Ssisoledb.dll                                | 2015.131.5233.0 | 216352    | 03-Nov-18 | 09:01 | x64      |
| Txagg.dll                                    | 2015.131.5233.0 | 364840    | 03-Nov-18 | 09:01 | x64      |
| Txbdd.dll                                    | 2015.131.5233.0 | 172840    | 03-Nov-18 | 09:01 | x64      |
| Txdatacollector.dll                          | 2015.131.5233.0 | 367904    | 03-Nov-18 | 09:01 | x64      |
| Txdataconvert.dll                            | 2015.131.5233.0 | 296736    | 03-Nov-18 | 09:01 | x64      |
| Txderived.dll                                | 2015.131.5233.0 | 608032    | 03-Nov-18 | 09:01 | x64      |
| Txlookup.dll                                 | 2015.131.5233.0 | 532256    | 03-Nov-18 | 09:01 | x64      |
| Txmerge.dll                                  | 2015.131.5233.0 | 230688    | 03-Nov-18 | 09:01 | x64      |
| Txmergejoin.dll                              | 2015.131.5233.0 | 278816    | 03-Nov-18 | 09:01 | x64      |
| Txmulticast.dll                              | 2015.131.5233.0 | 128288    | 03-Nov-18 | 09:01 | x64      |
| Txrowcount.dll                               | 2015.131.5233.0 | 126760    | 03-Nov-18 | 09:01 | x64      |
| Txsort.dll                                   | 2015.131.5233.0 | 259360    | 03-Nov-18 | 09:01 | x64      |
| Txsplit.dll                                  | 2015.131.5233.0 | 600864    | 03-Nov-18 | 09:01 | x64      |
| Txunionall.dll                               | 2015.131.5233.0 | 182056    | 03-Nov-18 | 09:01 | x64      |
| Xe.dll                                       | 2015.131.5233.0 | 626464    | 03-Nov-18 | 09:02 | x64      |
| Xmlrw.dll                                    | 2015.131.5233.0 | 319272    | 03-Nov-18 | 09:02 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.131.5233.0 | 1015056   | 03-Nov-18 | 09:04 | x64      |
| Sql_extensibility_keyfile.dll | 2015.131.5233.0 | 100632    | 03-Nov-18 | 09:04 | x64      |
| Sqlsatellite.dll              | 2015.131.5233.0 | 837408    | 03-Nov-18 | 09:02 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2015.131.5233.0 | 660256    | 03-Nov-18 | 09:02 | x64      |
| Fdhost.exe               | 2015.131.5233.0 | 105232    | 03-Nov-18 | 09:04 | x64      |
| Fdlauncher.exe           | 2015.131.5233.0 | 51472     | 03-Nov-18 | 09:04 | x64      |
| Sql_fulltext_keyfile.dll | 2015.131.5233.0 | 100632    | 03-Nov-18 | 09:04 | x64      |
| Sqlft130ph.dll           | 2015.131.5233.0 | 58144     | 03-Nov-18 | 09:02 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.5233.0     | 23824     | 03-Nov-18 | 09:03 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.131.5233.0 | 100632    | 03-Nov-18 | 09:04 | x64      |

SQL Server 2016 Integration Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                    | 2015.131.5233.0 | 203064    | 03-Nov-18 | 09:01 | x86      |
| Commanddest.dll                                    | 2015.131.5233.0 | 249104    | 03-Nov-18 | 09:04 | x64      |
| Dteparse.dll                                       | 2015.131.5233.0 | 99616     | 03-Nov-18 | 09:01 | x86      |
| Dteparse.dll                                       | 2015.131.5233.0 | 109840    | 03-Nov-18 | 09:04 | x64      |
| Dteparsemgd.dll                                    | 2015.131.5233.0 | 83736     | 03-Nov-18 | 09:02 | x86      |
| Dteparsemgd.dll                                    | 2015.131.5233.0 | 88848     | 03-Nov-18 | 09:03 | x64      |
| Dtepkg.dll                                         | 2015.131.5233.0 | 116000    | 03-Nov-18 | 09:01 | x86      |
| Dtepkg.dll                                         | 2015.131.5233.0 | 137488    | 03-Nov-18 | 09:04 | x64      |
| Dtexec.exe                                         | 2015.131.5233.0 | 66848     | 03-Nov-18 | 09:01 | x86      |
| Dtexec.exe                                         | 2015.131.5233.0 | 73016     | 03-Nov-18 | 09:02 | x64      |
| Dts.dll                                            | 2015.131.5233.0 | 2632992   | 03-Nov-18 | 09:01 | x86      |
| Dts.dll                                            | 2015.131.5233.0 | 3147024   | 03-Nov-18 | 09:04 | x64      |
| Dtscomexpreval.dll                                 | 2015.131.5233.0 | 419112    | 03-Nov-18 | 09:01 | x86      |
| Dtscomexpreval.dll                                 | 2015.131.5233.0 | 477456    | 03-Nov-18 | 09:04 | x64      |
| Dtsconn.dll                                        | 2015.131.5233.0 | 392488    | 03-Nov-18 | 09:01 | x86      |
| Dtsconn.dll                                        | 2015.131.5233.0 | 492816    | 03-Nov-18 | 09:04 | x64      |
| Dtsdebughost.exe                                   | 2015.131.5233.0 | 93992     | 03-Nov-18 | 09:01 | x86      |
| Dtsdebughost.exe                                   | 2015.131.5233.0 | 109856    | 03-Nov-18 | 09:02 | x64      |
| Dtshost.exe                                        | 2015.131.5233.0 | 76584     | 03-Nov-18 | 09:01 | x86      |
| Dtshost.exe                                        | 2015.131.5233.0 | 86816     | 03-Nov-18 | 09:02 | x64      |
| Dtslog.dll                                         | 2015.131.5233.0 | 103208    | 03-Nov-18 | 09:01 | x86      |
| Dtslog.dll                                         | 2015.131.5233.0 | 120592    | 03-Nov-18 | 09:04 | x64      |
| Dtsmsg130.dll                                      | 2015.131.5233.0 | 541472    | 03-Nov-18 | 09:01 | x86      |
| Dtsmsg130.dll                                      | 2015.131.5233.0 | 545552    | 03-Nov-18 | 09:04 | x64      |
| Dtspipeline.dll                                    | 2015.131.5233.0 | 1059616   | 03-Nov-18 | 09:01 | x86      |
| Dtspipeline.dll                                    | 2015.131.5233.0 | 1279256   | 03-Nov-18 | 09:04 | x64      |
| Dtspipelineperf130.dll                             | 2015.131.5233.0 | 42280     | 03-Nov-18 | 09:01 | x86      |
| Dtspipelineperf130.dll                             | 2015.131.5233.0 | 48400     | 03-Nov-18 | 09:04 | x64      |
| Dtuparse.dll                                       | 2015.131.5233.0 | 80184     | 03-Nov-18 | 09:01 | x86      |
| Dtuparse.dll                                       | 2015.131.5233.0 | 87824     | 03-Nov-18 | 09:04 | x64      |
| Dtutil.exe                                         | 2015.131.5233.0 | 115488    | 03-Nov-18 | 09:01 | x86      |
| Dtutil.exe                                         | 2015.131.5233.0 | 134944    | 03-Nov-18 | 09:02 | x64      |
| Exceldest.dll                                      | 2015.131.5233.0 | 216864    | 03-Nov-18 | 09:01 | x86      |
| Exceldest.dll                                      | 2015.131.5233.0 | 263440    | 03-Nov-18 | 09:04 | x64      |
| Excelsrc.dll                                       | 2015.131.5233.0 | 232736    | 03-Nov-18 | 09:01 | x86      |
| Excelsrc.dll                                       | 2015.131.5233.0 | 285456    | 03-Nov-18 | 09:04 | x64      |
| Execpackagetask.dll                                | 2015.131.5233.0 | 135464    | 03-Nov-18 | 09:01 | x86      |
| Execpackagetask.dll                                | 2015.131.5233.0 | 166680    | 03-Nov-18 | 09:04 | x64      |
| Flatfiledest.dll                                   | 2015.131.5233.0 | 334624    | 03-Nov-18 | 09:01 | x86      |
| Flatfiledest.dll                                   | 2015.131.5233.0 | 389400    | 03-Nov-18 | 09:04 | x64      |
| Flatfilesrc.dll                                    | 2015.131.5233.0 | 345376    | 03-Nov-18 | 09:01 | x86      |
| Flatfilesrc.dll                                    | 2015.131.5233.0 | 401680    | 03-Nov-18 | 09:04 | x64      |
| Foreachfileenumerator.dll                          | 2015.131.5233.0 | 80672     | 03-Nov-18 | 09:01 | x86      |
| Foreachfileenumerator.dll                          | 2015.131.5233.0 | 96528     | 03-Nov-18 | 09:04 | x64      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5233.0     | 1314064   | 03-Nov-18 | 09:02 | x86      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5233.0     | 1314064   | 03-Nov-18 | 09:03 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 06-Jul-18 | 22:33 | x86      |
| Microsoft.sqlserver.astasks.dll                    | 13.0.5233.0     | 73504     | 03-Nov-18 | 09:01 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5233.0 | 112424    | 03-Nov-18 | 09:01 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5233.0 | 107304    | 03-Nov-18 | 09:02 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5233.0     | 82520     | 02-Nov-18 | 20:23 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5233.0     | 82720     | 03-Nov-18 | 09:01 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5233.0 | 150304    | 03-Nov-18 | 09:02 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5233.0 | 139032    | 03-Nov-18 | 09:03 | x86      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5233.0 | 159008    | 03-Nov-18 | 09:02 | x64      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5233.0 | 144664    | 03-Nov-18 | 09:03 | x86      |
| Msdtssrvr.exe                                      | 13.0.5233.0     | 216856    | 03-Nov-18 | 09:03 | x64      |
| Msdtssrvrutil.dll                                  | 2015.131.5233.0 | 90392     | 03-Nov-18 | 09:01 | x86      |
| Msdtssrvrutil.dll                                  | 2015.131.5233.0 | 101648    | 03-Nov-18 | 09:04 | x64      |
| Oledbdest.dll                                      | 2015.131.5233.0 | 216856    | 03-Nov-18 | 09:01 | x86      |
| Oledbdest.dll                                      | 2015.131.5233.0 | 264464    | 03-Nov-18 | 09:04 | x64      |
| Oledbsrc.dll                                       | 2015.131.5233.0 | 235800    | 03-Nov-18 | 09:01 | x86      |
| Oledbsrc.dll                                       | 2015.131.5233.0 | 291088    | 03-Nov-18 | 09:04 | x64      |
| Rawdest.dll                                        | 2015.131.5233.0 | 168728    | 03-Nov-18 | 09:01 | x86      |
| Rawdest.dll                                        | 2015.131.5233.0 | 209680    | 03-Nov-18 | 09:04 | x64      |
| Rawsource.dll                                      | 2015.131.5233.0 | 155416    | 03-Nov-18 | 09:01 | x86      |
| Rawsource.dll                                      | 2015.131.5233.0 | 196880    | 03-Nov-18 | 09:04 | x64      |
| Recordsetdest.dll                                  | 2015.131.5233.0 | 151832    | 03-Nov-18 | 09:01 | x86      |
| Recordsetdest.dll                                  | 2015.131.5233.0 | 187160    | 03-Nov-18 | 09:04 | x64      |
| Sql_is_keyfile.dll                                 | 2015.131.5233.0 | 100632    | 03-Nov-18 | 09:04 | x64      |
| Sqlceip.exe                                        | 13.0.5233.0     | 256280    | 03-Nov-18 | 09:03 | x86      |
| Sqldest.dll                                        | 2015.131.5233.0 | 215832    | 03-Nov-18 | 09:01 | x86      |
| Sqldest.dll                                        | 2015.131.5233.0 | 263952    | 03-Nov-18 | 09:04 | x64      |
| Sqltaskconnections.dll                             | 2015.131.5233.0 | 151320    | 03-Nov-18 | 09:01 | x86      |
| Sqltaskconnections.dll                             | 2015.131.5233.0 | 181032    | 03-Nov-18 | 09:01 | x64      |
| Ssisoledb.dll                                      | 2015.131.5233.0 | 176920    | 03-Nov-18 | 09:01 | x86      |
| Ssisoledb.dll                                      | 2015.131.5233.0 | 216352    | 03-Nov-18 | 09:01 | x64      |
| Txagg.dll                                          | 2015.131.5233.0 | 364840    | 03-Nov-18 | 09:01 | x64      |
| Txagg.dll                                          | 2015.131.5233.0 | 304912    | 03-Nov-18 | 09:03 | x86      |
| Txbdd.dll                                          | 2015.131.5233.0 | 172840    | 03-Nov-18 | 09:01 | x64      |
| Txbdd.dll                                          | 2015.131.5233.0 | 138000    | 03-Nov-18 | 09:03 | x86      |
| Txbestmatch.dll                                    | 2015.131.5233.0 | 611624    | 03-Nov-18 | 09:01 | x64      |
| Txbestmatch.dll                                    | 2015.131.5233.0 | 496408    | 03-Nov-18 | 09:03 | x86      |
| Txcache.dll                                        | 2015.131.5233.0 | 183584    | 03-Nov-18 | 09:01 | x64      |
| Txcache.dll                                        | 2015.131.5233.0 | 148240    | 03-Nov-18 | 09:03 | x86      |
| Txcharmap.dll                                      | 2015.131.5233.0 | 290088    | 03-Nov-18 | 09:01 | x64      |
| Txcharmap.dll                                      | 2015.131.5233.0 | 250640    | 03-Nov-18 | 09:03 | x86      |
| Txcopymap.dll                                      | 2015.131.5233.0 | 183080    | 03-Nov-18 | 09:01 | x64      |
| Txcopymap.dll                                      | 2015.131.5233.0 | 147728    | 03-Nov-18 | 09:03 | x86      |
| Txdataconvert.dll                                  | 2015.131.5233.0 | 296736    | 03-Nov-18 | 09:01 | x64      |
| Txdataconvert.dll                                  | 2015.131.5233.0 | 255256    | 03-Nov-18 | 09:03 | x86      |
| Txderived.dll                                      | 2015.131.5233.0 | 608032    | 03-Nov-18 | 09:01 | x64      |
| Txderived.dll                                      | 2015.131.5233.0 | 519448    | 03-Nov-18 | 09:03 | x86      |
| Txfileextractor.dll                                | 2015.131.5233.0 | 202024    | 03-Nov-18 | 09:01 | x64      |
| Txfileextractor.dll                                | 2015.131.5233.0 | 163096    | 03-Nov-18 | 09:03 | x86      |
| Txfileinserter.dll                                 | 2015.131.5233.0 | 199968    | 03-Nov-18 | 09:01 | x64      |
| Txfileinserter.dll                                 | 2015.131.5233.0 | 161040    | 03-Nov-18 | 09:03 | x86      |
| Txgroupdups.dll                                    | 2015.131.5233.0 | 291104    | 03-Nov-18 | 09:01 | x64      |
| Txgroupdups.dll                                    | 2015.131.5233.0 | 231696    | 03-Nov-18 | 09:03 | x86      |
| Txlineage.dll                                      | 2015.131.5233.0 | 138016    | 03-Nov-18 | 09:01 | x64      |
| Txlineage.dll                                      | 2015.131.5233.0 | 109840    | 03-Nov-18 | 09:03 | x86      |
| Txlookup.dll                                       | 2015.131.5233.0 | 532256    | 03-Nov-18 | 09:01 | x64      |
| Txlookup.dll                                       | 2015.131.5233.0 | 449808    | 03-Nov-18 | 09:03 | x86      |
| Txmerge.dll                                        | 2015.131.5233.0 | 230688    | 03-Nov-18 | 09:01 | x64      |
| Txmerge.dll                                        | 2015.131.5233.0 | 176912    | 03-Nov-18 | 09:03 | x86      |
| Txmergejoin.dll                                    | 2015.131.5233.0 | 278816    | 03-Nov-18 | 09:01 | x64      |
| Txmergejoin.dll                                    | 2015.131.5233.0 | 224016    | 03-Nov-18 | 09:03 | x86      |
| Txmulticast.dll                                    | 2015.131.5233.0 | 128288    | 03-Nov-18 | 09:01 | x64      |
| Txmulticast.dll                                    | 2015.131.5233.0 | 102168    | 03-Nov-18 | 09:03 | x86      |
| Txpivot.dll                                        | 2015.131.5233.0 | 228128    | 03-Nov-18 | 09:01 | x64      |
| Txpivot.dll                                        | 2015.131.5233.0 | 182032    | 03-Nov-18 | 09:03 | x86      |
| Txrowcount.dll                                     | 2015.131.5233.0 | 126760    | 03-Nov-18 | 09:01 | x64      |
| Txrowcount.dll                                     | 2015.131.5233.0 | 101648    | 03-Nov-18 | 09:03 | x86      |
| Txsampling.dll                                     | 2015.131.5233.0 | 172328    | 03-Nov-18 | 09:01 | x64      |
| Txsampling.dll                                     | 2015.131.5233.0 | 134936    | 03-Nov-18 | 09:03 | x86      |
| Txscd.dll                                          | 2015.131.5233.0 | 220448    | 03-Nov-18 | 09:01 | x64      |
| Txscd.dll                                          | 2015.131.5233.0 | 169744    | 03-Nov-18 | 09:03 | x86      |
| Txsort.dll                                         | 2015.131.5233.0 | 259360    | 03-Nov-18 | 09:01 | x64      |
| Txsort.dll                                         | 2015.131.5233.0 | 211216    | 03-Nov-18 | 09:03 | x86      |
| Txsplit.dll                                        | 2015.131.5233.0 | 600864    | 03-Nov-18 | 09:01 | x64      |
| Txsplit.dll                                        | 2015.131.5233.0 | 513304    | 03-Nov-18 | 09:03 | x86      |
| Txtermextraction.dll                               | 2015.131.5233.0 | 8678176   | 03-Nov-18 | 09:02 | x64      |
| Txtermextraction.dll                               | 2015.131.5233.0 | 8615696   | 03-Nov-18 | 09:03 | x86      |
| Txtermlookup.dll                                   | 2015.131.5233.0 | 4158760   | 03-Nov-18 | 09:01 | x64      |
| Txtermlookup.dll                                   | 2015.131.5233.0 | 4107032   | 03-Nov-18 | 09:03 | x86      |
| Txunionall.dll                                     | 2015.131.5233.0 | 182056    | 03-Nov-18 | 09:01 | x64      |
| Txunionall.dll                                     | 2015.131.5233.0 | 139024    | 03-Nov-18 | 09:03 | x86      |
| Txunpivot.dll                                      | 2015.131.5233.0 | 202024    | 03-Nov-18 | 09:01 | x64      |
| Txunpivot.dll                                      | 2015.131.5233.0 | 162576    | 03-Nov-18 | 09:03 | x86      |
| Xe.dll                                             | 2015.131.5233.0 | 558880    | 03-Nov-18 | 09:01 | x86      |
| Xe.dll                                             | 2015.131.5233.0 | 626464    | 03-Nov-18 | 09:02 | x64      |

SQL Server 2016 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 10.0.8224.46     | 483504    | 18-Jun-18 | 22:50 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.46 | 75432     | 18-Jun-18 | 22:50 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.46     | 45736     | 18-Jun-18 | 22:50 | x86      |
| Instapi130.dll                                                       | 2015.131.5233.0  | 61216     | 03-Nov-18 | 09:01 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 10.0.8224.46     | 74408     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 10.0.8224.46     | 201896    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 10.0.8224.46     | 2347184   | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 10.0.8224.46     | 102056    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 10.0.8224.46     | 378544    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 10.0.8224.46     | 185512    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 10.0.8224.46     | 127152    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 10.0.8224.46     | 63144     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 10.0.8224.46     | 52392     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 10.0.8224.46     | 87216     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 10.0.8224.46     | 721584    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 10.0.8224.46     | 87208     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 10.0.8224.46     | 77992     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 10.0.8224.46     | 41640     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 10.0.8224.46     | 36528     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 10.0.8224.46     | 47784     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 10.0.8224.46     | 27312     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 10.0.8224.46     | 32944     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 10.0.8224.46     | 118952    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 10.0.8224.46     | 94376     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 10.0.8224.46     | 108200    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 10.0.8224.46     | 256680    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 102056    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 115880    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 118952    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 115880    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 125616    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 117936    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 113328    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 145576    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 100016    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 114856    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 10.0.8224.46     | 69288     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 10.0.8224.46     | 28328     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 10.0.8224.46     | 43696     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 10.0.8224.46     | 82088     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 10.0.8224.46     | 136872    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 10.0.8224.46     | 2155688   | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 10.0.8224.46     | 3818672   | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 107696    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 119984    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 124584    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 121000    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 133288    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 121000    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 118448    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 152240    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 105136    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 119464    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 10.0.8224.46     | 66728     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 10.0.8224.46     | 2756272   | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 10.0.8224.46     | 752296    | 18-Jun-18 | 22:50 | x86      |
| Mpdwinterop.dll                                                      | 2015.131.5233.0  | 394512    | 03-Nov-18 | 09:02 | x64      |
| Mpdwsvc.exe                                                          | 2015.131.5233.0  | 6616336   | 03-Nov-18 | 09:05 | x64      |
| Pdwodbcsql11.dll                                                     | 2015.131.5233.0  | 2230056   | 03-Nov-18 | 09:01 | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.46 | 47280     | 18-Jun-18 | 22:50 | x64      |
| Sqldk.dll                                                            | 2015.131.5233.0  | 2532136   | 03-Nov-18 | 09:01 | x64      |
| Sqldumper.exe                                                        | 2015.131.5233.0  | 127248    | 03-Nov-18 | 09:05 | x64      |
| Sqlos.dll                                                            | 2015.131.5233.0  | 26408     | 03-Nov-18 | 09:01 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.46 | 4348072   | 18-Jun-18 | 22:50 | x64      |
| Sqltses.dll                                                          | 2015.131.5233.0  | 9091872   | 03-Nov-18 | 09:01 | x64      |

SQL Server 2016 Reporting Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.modeling.dll                   | 13.0.5233.0     | 611088    | 03-Nov-18 | 09:03 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.5233.0     | 1620248   | 03-Nov-18 | 09:03 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.5233.0     | 330008    | 03-Nov-18 | 09:03 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.5233.0     | 1072920   | 03-Nov-18 | 09:03 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5233.0     | 532240    | 03-Nov-18 | 09:02 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5233.0     | 532264    | 03-Nov-18 | 09:03 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5233.0     | 532256    | 03-Nov-18 | 09:02 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5233.0     | 532280    | 03-Nov-18 | 09:04 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5233.0     | 532240    | 03-Nov-18 | 09:03 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5233.0     | 532264    | 03-Nov-18 | 09:02 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5233.0     | 532264    | 03-Nov-18 | 09:02 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5233.0     | 532240    | 03-Nov-18 | 09:04 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5233.0     | 532240    | 03-Nov-18 | 09:03 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5233.0     | 532240    | 03-Nov-18 | 09:03 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.5233.0     | 163096    | 03-Nov-18 | 09:03 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.5233.0     | 5906720   | 03-Nov-18 | 09:01 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5233.0     | 4343568   | 03-Nov-18 | 09:02 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5233.0     | 4344096   | 03-Nov-18 | 09:03 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5233.0     | 4344096   | 03-Nov-18 | 09:02 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5233.0     | 4344104   | 03-Nov-18 | 09:04 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5233.0     | 4344104   | 03-Nov-18 | 09:03 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5233.0     | 4344096   | 03-Nov-18 | 09:02 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5233.0     | 4344096   | 03-Nov-18 | 09:02 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5233.0     | 4344592   | 03-Nov-18 | 09:04 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5233.0     | 4343568   | 03-Nov-18 | 09:03 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5233.0     | 4344080   | 03-Nov-18 | 09:03 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.5233.0     | 10888992  | 03-Nov-18 | 09:01 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.5233.0     | 101144    | 03-Nov-18 | 09:03 | x64      |
| Microsoft.reportingservices.storage.dll                   | 13.0.5233.0     | 208672    | 03-Nov-18 | 09:01 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.131.5233.0 | 47904     | 03-Nov-18 | 09:01 | x64      |
| Msmdlocal.dll                                             | 2015.131.5233.0 | 37100312  | 03-Nov-18 | 09:01 | x86      |
| Msmdlocal.dll                                             | 2015.131.5233.0 | 56209688  | 03-Nov-18 | 09:04 | x64      |
| Msmgdsrv.dll                                              | 2015.131.5233.0 | 6507792   | 03-Nov-18 | 09:01 | x86      |
| Msmgdsrv.dll                                              | 2015.131.5233.0 | 7507232   | 03-Nov-18 | 09:01 | x64      |
| Msolui130.dll                                             | 2015.131.5233.0 | 287512    | 03-Nov-18 | 09:01 | x86      |
| Msolui130.dll                                             | 2015.131.5233.0 | 310544    | 03-Nov-18 | 09:04 | x64      |
| Reportingservicescompression.dll                          | 2015.131.5233.0 | 62736     | 03-Nov-18 | 09:04 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.131.5233.0 | 114456    | 03-Nov-18 | 09:01 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.131.5233.0 | 108832    | 03-Nov-18 | 09:01 | x64      |
| Reportingservicesnativeserver.dll                         | 2015.131.5233.0 | 99112     | 03-Nov-18 | 09:01 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.5233.0     | 2710816   | 03-Nov-18 | 09:01 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5233.0     | 868128    | 03-Nov-18 | 09:03 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5233.0     | 872208    | 03-Nov-18 | 09:05 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5233.0     | 872208    | 03-Nov-18 | 09:03 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5233.0     | 872216    | 03-Nov-18 | 09:05 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5233.0     | 876344    | 03-Nov-18 | 09:03 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5233.0     | 872208    | 03-Nov-18 | 09:04 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5233.0     | 872232    | 03-Nov-18 | 09:02 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5233.0     | 884512    | 03-Nov-18 | 09:03 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5233.0     | 868120    | 03-Nov-18 | 09:03 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5233.0     | 872216    | 03-Nov-18 | 09:03 | x86      |
| Rshttpruntime.dll                                         | 2015.131.5233.0 | 99616     | 03-Nov-18 | 09:01 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.131.5233.0 | 100632    | 03-Nov-18 | 09:04 | x64      |
| Sqldumper.exe                                             | 2015.131.5233.0 | 107816    | 03-Nov-18 | 09:01 | x86      |
| Sqldumper.exe                                             | 2015.131.5233.0 | 127248    | 03-Nov-18 | 09:04 | x64      |
| Sqlrsos.dll                                               | 2015.131.5233.0 | 26408     | 03-Nov-18 | 09:01 | x64      |
| Sqlserverspatial130.dll                                   | 2015.131.5233.0 | 584472    | 03-Nov-18 | 09:01 | x86      |
| Sqlserverspatial130.dll                                   | 2015.131.5233.0 | 732960    | 03-Nov-18 | 09:02 | x64      |
| Xmlrw.dll                                                 | 2015.131.5233.0 | 319272    | 03-Nov-18 | 09:02 | x64      |
| Xmlrw.dll                                                 | 2015.131.5233.0 | 259856    | 03-Nov-18 | 09:03 | x86      |
| Xmlrwbin.dll                                              | 2015.131.5233.0 | 227616    | 03-Nov-18 | 09:02 | x64      |
| Xmlrwbin.dll                                              | 2015.131.5233.0 | 191760    | 03-Nov-18 | 09:03 | x86      |
| Xmsrv.dll                                                 | 2015.131.5233.0 | 24050984  | 03-Nov-18 | 09:02 | x64      |
| Xmsrv.dll                                                 | 2015.131.5233.0 | 32727824  | 03-Nov-18 | 09:03 | x86      |

SQL Server 2016 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.5233.0     | 23840     | 03-Nov-18 | 09:01 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.131.5233.0 | 100632    | 03-Nov-18 | 09:04 | x64      |

SQL Server 2016 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                  | 2015.131.5233.0 | 1312032   | 03-Nov-18 | 09:01 | x86      |
| Ddsshapes.dll                                  | 2015.131.5233.0 | 135968    | 03-Nov-18 | 09:01 | x86      |
| Dtaengine.exe                                  | 2015.131.5233.0 | 167200    | 03-Nov-18 | 09:01 | x86      |
| Dteparse.dll                                   | 2015.131.5233.0 | 99616     | 03-Nov-18 | 09:01 | x86      |
| Dteparse.dll                                   | 2015.131.5233.0 | 109840    | 03-Nov-18 | 09:04 | x64      |
| Dteparsemgd.dll                                | 2015.131.5233.0 | 83736     | 03-Nov-18 | 09:02 | x86      |
| Dteparsemgd.dll                                | 2015.131.5233.0 | 88848     | 03-Nov-18 | 09:03 | x64      |
| Dtepkg.dll                                     | 2015.131.5233.0 | 116000    | 03-Nov-18 | 09:01 | x86      |
| Dtepkg.dll                                     | 2015.131.5233.0 | 137488    | 03-Nov-18 | 09:04 | x64      |
| Dtexec.exe                                     | 2015.131.5233.0 | 66848     | 03-Nov-18 | 09:01 | x86      |
| Dtexec.exe                                     | 2015.131.5233.0 | 73016     | 03-Nov-18 | 09:02 | x64      |
| Dts.dll                                        | 2015.131.5233.0 | 2632992   | 03-Nov-18 | 09:01 | x86      |
| Dts.dll                                        | 2015.131.5233.0 | 3147024   | 03-Nov-18 | 09:04 | x64      |
| Dtscomexpreval.dll                             | 2015.131.5233.0 | 419112    | 03-Nov-18 | 09:01 | x86      |
| Dtscomexpreval.dll                             | 2015.131.5233.0 | 477456    | 03-Nov-18 | 09:04 | x64      |
| Dtsconn.dll                                    | 2015.131.5233.0 | 392488    | 03-Nov-18 | 09:01 | x86      |
| Dtsconn.dll                                    | 2015.131.5233.0 | 492816    | 03-Nov-18 | 09:04 | x64      |
| Dtshost.exe                                    | 2015.131.5233.0 | 76584     | 03-Nov-18 | 09:01 | x86      |
| Dtshost.exe                                    | 2015.131.5233.0 | 86816     | 03-Nov-18 | 09:02 | x64      |
| Dtslog.dll                                     | 2015.131.5233.0 | 103208    | 03-Nov-18 | 09:01 | x86      |
| Dtslog.dll                                     | 2015.131.5233.0 | 120592    | 03-Nov-18 | 09:04 | x64      |
| Dtsmsg130.dll                                  | 2015.131.5233.0 | 541472    | 03-Nov-18 | 09:01 | x86      |
| Dtsmsg130.dll                                  | 2015.131.5233.0 | 545552    | 03-Nov-18 | 09:04 | x64      |
| Dtspipeline.dll                                | 2015.131.5233.0 | 1059616   | 03-Nov-18 | 09:01 | x86      |
| Dtspipeline.dll                                | 2015.131.5233.0 | 1279256   | 03-Nov-18 | 09:04 | x64      |
| Dtspipelineperf130.dll                         | 2015.131.5233.0 | 42280     | 03-Nov-18 | 09:01 | x86      |
| Dtspipelineperf130.dll                         | 2015.131.5233.0 | 48400     | 03-Nov-18 | 09:04 | x64      |
| Dtuparse.dll                                   | 2015.131.5233.0 | 80184     | 03-Nov-18 | 09:01 | x86      |
| Dtuparse.dll                                   | 2015.131.5233.0 | 87824     | 03-Nov-18 | 09:04 | x64      |
| Dtutil.exe                                     | 2015.131.5233.0 | 115488    | 03-Nov-18 | 09:01 | x86      |
| Dtutil.exe                                     | 2015.131.5233.0 | 134944    | 03-Nov-18 | 09:02 | x64      |
| Exceldest.dll                                  | 2015.131.5233.0 | 216864    | 03-Nov-18 | 09:01 | x86      |
| Exceldest.dll                                  | 2015.131.5233.0 | 263440    | 03-Nov-18 | 09:04 | x64      |
| Excelsrc.dll                                   | 2015.131.5233.0 | 232736    | 03-Nov-18 | 09:01 | x86      |
| Excelsrc.dll                                   | 2015.131.5233.0 | 285456    | 03-Nov-18 | 09:04 | x64      |
| Flatfiledest.dll                               | 2015.131.5233.0 | 334624    | 03-Nov-18 | 09:01 | x86      |
| Flatfiledest.dll                               | 2015.131.5233.0 | 389400    | 03-Nov-18 | 09:04 | x64      |
| Flatfilesrc.dll                                | 2015.131.5233.0 | 345376    | 03-Nov-18 | 09:01 | x86      |
| Flatfilesrc.dll                                | 2015.131.5233.0 | 401680    | 03-Nov-18 | 09:04 | x64      |
| Foreachfileenumerator.dll                      | 2015.131.5233.0 | 80672     | 03-Nov-18 | 09:01 | x86      |
| Foreachfileenumerator.dll                      | 2015.131.5233.0 | 96528     | 03-Nov-18 | 09:04 | x64      |
| Microsoft.analysisservices.adomdclientui.dll   | 13.0.5233.0     | 92440     | 03-Nov-18 | 09:02 | x86      |
| Microsoft.analysisservices.applocal.core.dll   | 13.0.5233.0     | 1314064   | 03-Nov-18 | 09:02 | x86      |
| Microsoft.analysisservices.project.dll         | 2015.131.5233.0 | 2023192   | 03-Nov-18 | 09:02 | x86      |
| Microsoft.analysisservices.projectui.dll       | 2015.131.5233.0 | 42280     | 03-Nov-18 | 09:01 | x86      |
| Microsoft.sqlserver.astasks.dll                | 13.0.5233.0     | 73504     | 03-Nov-18 | 09:02 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5233.0     | 436008    | 03-Nov-18 | 09:01 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5233.0     | 436024    | 03-Nov-18 | 09:02 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5233.0     | 2044704   | 03-Nov-18 | 09:01 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5233.0     | 2044704   | 03-Nov-18 | 09:02 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5233.0 | 150304    | 03-Nov-18 | 09:02 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5233.0 | 139032    | 03-Nov-18 | 09:03 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5233.0 | 159008    | 03-Nov-18 | 09:02 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5233.0 | 144664    | 03-Nov-18 | 09:03 | x86      |
| Msdtssrvrutil.dll                              | 2015.131.5233.0 | 90392     | 03-Nov-18 | 09:01 | x86      |
| Msdtssrvrutil.dll                              | 2015.131.5233.0 | 101648    | 03-Nov-18 | 09:04 | x64      |
| Msmdlocal.dll                                  | 2015.131.5233.0 | 37100312  | 03-Nov-18 | 09:01 | x86      |
| Msmdlocal.dll                                  | 2015.131.5233.0 | 56209688  | 03-Nov-18 | 09:04 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5233.0 | 6507792   | 03-Nov-18 | 09:01 | x86      |
| Msmgdsrv.dll                                   | 2015.131.5233.0 | 7507232   | 03-Nov-18 | 09:01 | x64      |
| Msolui130.dll                                  | 2015.131.5233.0 | 287512    | 03-Nov-18 | 09:01 | x86      |
| Msolui130.dll                                  | 2015.131.5233.0 | 310544    | 03-Nov-18 | 09:04 | x64      |
| Oledbdest.dll                                  | 2015.131.5233.0 | 216856    | 03-Nov-18 | 09:01 | x86      |
| Oledbdest.dll                                  | 2015.131.5233.0 | 264464    | 03-Nov-18 | 09:04 | x64      |
| Oledbsrc.dll                                   | 2015.131.5233.0 | 235800    | 03-Nov-18 | 09:01 | x86      |
| Oledbsrc.dll                                   | 2015.131.5233.0 | 291088    | 03-Nov-18 | 09:04 | x64      |
| Profiler.exe                                   | 2015.131.5233.0 | 804624    | 03-Nov-18 | 09:02 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.131.5233.0 | 100632    | 03-Nov-18 | 09:04 | x64      |
| Sqldumper.exe                                  | 2015.131.5233.0 | 107816    | 03-Nov-18 | 09:01 | x86      |
| Sqldumper.exe                                  | 2015.131.5233.0 | 127248    | 03-Nov-18 | 09:04 | x64      |
| Sqlresld.dll                                   | 2015.131.5233.0 | 28952     | 03-Nov-18 | 09:01 | x86      |
| Sqlresld.dll                                   | 2015.131.5233.0 | 31008     | 03-Nov-18 | 09:01 | x64      |
| Sqlresourceloader.dll                          | 2015.131.5233.0 | 28440     | 03-Nov-18 | 09:01 | x86      |
| Sqlresourceloader.dll                          | 2015.131.5233.0 | 31008     | 03-Nov-18 | 09:01 | x64      |
| Sqlscm.dll                                     | 2015.131.5233.0 | 53016     | 03-Nov-18 | 09:01 | x86      |
| Sqlscm.dll                                     | 2015.131.5233.0 | 61224     | 03-Nov-18 | 09:02 | x64      |
| Sqlsvc.dll                                     | 2015.131.5233.0 | 127256    | 03-Nov-18 | 09:01 | x86      |
| Sqlsvc.dll                                     | 2015.131.5233.0 | 152352    | 03-Nov-18 | 09:01 | x64      |
| Sqltaskconnections.dll                         | 2015.131.5233.0 | 151320    | 03-Nov-18 | 09:01 | x86      |
| Sqltaskconnections.dll                         | 2015.131.5233.0 | 181032    | 03-Nov-18 | 09:01 | x64      |
| Txdataconvert.dll                              | 2015.131.5233.0 | 296736    | 03-Nov-18 | 09:01 | x64      |
| Txdataconvert.dll                              | 2015.131.5233.0 | 255256    | 03-Nov-18 | 09:03 | x86      |
| Xe.dll                                         | 2015.131.5233.0 | 558880    | 03-Nov-18 | 09:01 | x86      |
| Xe.dll                                         | 2015.131.5233.0 | 626464    | 03-Nov-18 | 09:02 | x64      |
| Xmlrw.dll                                      | 2015.131.5233.0 | 319272    | 03-Nov-18 | 09:02 | x64      |
| Xmlrw.dll                                      | 2015.131.5233.0 | 259856    | 03-Nov-18 | 09:03 | x86      |
| Xmlrwbin.dll                                   | 2015.131.5233.0 | 227616    | 03-Nov-18 | 09:02 | x64      |
| Xmlrwbin.dll                                   | 2015.131.5233.0 | 191760    | 03-Nov-18 | 09:03 | x86      |
| Xmsrv.dll                                      | 2015.131.5233.0 | 24050984  | 03-Nov-18 | 09:02 | x64      |
| Xmsrv.dll                                      | 2015.131.5233.0 | 32727824  | 03-Nov-18 | 09:03 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
