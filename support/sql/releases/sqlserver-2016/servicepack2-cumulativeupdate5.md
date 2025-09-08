---
title: Cumulative update 5 for SQL Server 2016 SP2 (KB4475776)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 Service Pack 2 (SP2) cumulative update 5 (KB4475776).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4475776
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Express
- SQL Server 2016 Web
---

# KB4475776 - Cumulative Update 5 for SQL Server 2016 SP2

_Release Date:_ &nbsp; January 23, 2019  
_Version:_ &nbsp; 13.0.5264.1

This article describes Cumulative Update package 5 (CU5) (build number: **13.0.5264.1**) for Microsoft SQL Server 2016 Service Pack 2 (SP2). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the initial release of SQL Server 2016 SP2.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---|---|---|
| <a id="12488511">[12488511](#12488511)</a> | [FIX: Memory gets exhausted when you run Power BI report that executes DAX query on SSAS 2014, 2016 and 2017 Multidimensional mode (KB4090032)](https://support.microsoft.com/help/4090032) | Analysis Services |
| <a id="12491219">[12491219](#12491219)</a> | [FIX: Missing logs for Analysis Services Processing tasks in SQL Server 2016 and 2017 Integration Services (KB4055674)](https://support.microsoft.com/help/4055674) | Analysis Services |
| <a id="12599226">[12599226](#12599226)</a> | [FIX: Query results aren't as expected when you run a particular query from Excel in SQL 2014 SP2 CU14 or later version (2016, 2017 or 2019) (KB4486935)](https://support.microsoft.com/help/4486935) | Analysis Services |
| <a id="12488523">[12488523](#12488523)</a> | FIX: "An unexpected exception occurred" when you run an MDX query after an XMLA query to process a dimension in SSAS (KB4463328) | Analysis Services |
| <a id="12501413">[12501413](#12501413)</a> | FIX: An unexpected error occurs when you run an MDX query against an Excel pivot table in SSAS 2016 (KB4480795) | Analysis services |
| <a id="12559856">[12559856](#12559856)</a> | FIX: Deadlock occurs in SSAS 2016 and 2017 when you run a DAX query with time intelligence calculation in parallel (KB4465247) | Analysis Services |
| <a id="12571722">[12571722](#12571722)</a> | [FIX: Publishing MDS data from Excel fails when you save the changes to workbook, close and reopen it in SQL Server 2016 (KB4486937)](https://support.microsoft.com/help/4486937) | Data Quality Services (DQS) |
| <a id="12536281">[12536281](#12536281)</a> | Improvement: Performance issue when you create or modify entities, attributes, users, or groups when page load permissions are used in SQL Server (KB4480643) | Data Quality Services (DQS) |
| <a id="12478822">[12478822](#12478822)</a> | [FIX: Access violations and unhandled exceptions when you set automatic seeding for secondary replica or Distributed Availability Group replica in SQL Server (KB4457953)](https://support.microsoft.com/help/4457953) | High Availability |
| <a id="12517207">[12517207](#12517207)</a> | [FIX: sys.fn_hadr_backup_is_preferred_replica returns TRUE for more than one secondary replica even if the priority values are identical in SQL Server 2016 (KB4480650)](https://support.microsoft.com/help/4480650) | High Availability |
| <a id="12522073">[12522073](#12522073)</a> | [Update adds improvements and fixes issues when you use an Oracle RAC environment in SQL Server (KB4480647)](https://support.microsoft.com/help/4480647) | Integration services |
| <a id="12488519">[12488519](#12488519)</a> | [FIX: Error occurs when you run sp_send_dbmail stored procedure that contains comma in sender email address and name in SQL Server (KB4346803)](https://support.microsoft.com/help/4346803) | Management Tools |
| <a id="12519048">[12519048](#12519048)</a> | [FIX: "Login failed for user" error occurs when you run Maintenance plan with SQL login account in SQL Server 2016 (KB4486936)](https://support.microsoft.com/help/4486936) | Management Tools |
| <a id="12575103">[12575103](#12575103)</a> | [FIX: Error 18204 during automatic backup in virtual machines when the backup file is split into multiple files (KB4480709)](https://support.microsoft.com/help/4480709) | Management Tools |
| <a id="12496768">[12496768](#12496768)</a> | False error reporting when you execute the `Test-SqlAvailabilityGroup` cmdlet in SQL Server (KB4099335) | Management Tools |
| <a id="12430802">[12430802](#12430802)</a> | [FIX: The schedule changes to "Report-specific schedule" when you enable "Create cache snapshots on a schedule" for the report in SSRS 2016 (KB4467006)](https://support.microsoft.com/help/4467006) | Reporting Services |
| <a id="12437948">[12437948](#12437948)</a> | FIX: Nested tablix shows small font or partial text in SSRS 2016 and later versions (KB4470528) | Reporting Services |
| <a id="12490152">[12490152](#12490152)</a> | FIX: Large white space appears between the textbox and tablix when a report is viewed by using SSRS 2016 Report Manager (KB4480654) | Reporting Services |
| <a id="12478832">[12478832](#12478832)</a> | [Improvement: A way to configure logging for Hadoop bridge in PolyBase in SQL Server 2016 (KB4486941)](https://support.microsoft.com/help/4486941) | SQL Engine |
| <a id="12552077">[12552077](#12552077)</a> | [Snapshot Isolation and Savepoint support added for Availability Group databases on the same instance with DTC enabled in SQL Server (KB4483593)](https://support.microsoft.com/help/4483593) | SQL Engine |
| <a id="12373383">[12373383](#12373383)</a> | [FIX: Error occurs when you run a query that includes a Boolean field against PolyBase external tables in SQL Server 2016 and 2017 (KB4480653)](https://support.microsoft.com/help/4480653) | SQL Engine |
| <a id="12450169">[12450169](#12450169)</a> | [FIX: Possible assertion failure when a cross-database transaction involving an Availability Group database is committed from a SQL Server trigger (KB4483571)](https://support.microsoft.com/help/4483571) | SQL Engine |
| <a id="12476763">[12476763](#12476763)</a> | [FIX: Delays when Query Store Async Load is enabled in SQL Server 2016 (KB4487094)](https://support.microsoft.com/help/4487094) | SQL Engine |
| <a id="12487675">[12487675](#12487675)</a> | [FIX: Restore or Restore Verifyonly of a TDE-compressed backup fails with errors 33111 and 3013 in SQL Server 2016 and 2017 (KB4481148)](https://support.microsoft.com/help/4481148) | SQL Engine |
| <a id="12492081">[12492081](#12492081)</a> | [FIX: SQL Server service crashes when DBCC CHECKDB runs against a database that has a corrupted partition (KB4480639)](https://support.microsoft.com/help/4480639) | SQL Engine |
| <a id="12507746">[12507746](#12507746)</a> | [FIX: Access violation when you run a query that contains a batch-mode hash join on Clustered Columnstore Index table in SQL Server 2016 (KB4486852)](https://support.microsoft.com/help/4486852) | SQL Engine |
| <a id="12517286">[12517286](#12517286)</a> | [FIX: ObjectPropertyEx returns incorrect row count when there are partitions in a database object (KB4480648)](https://support.microsoft.com/help/4480648) | SQL Engine |
| <a id="12517650">[12517650](#12517650)</a> | [FIX: SQL Server installation fails if one of the remote nodes is unreachable in a cluster (KB4479283)](https://support.microsoft.com/help/4479283) | SQL Engine |
| <a id="12519485">[12519485](#12519485)</a> | [FIX: Server crashes when you cancel DBCC CHECKDB against a large database in SQL Server 2016 (KB4480640)](https://support.microsoft.com/help/4480640) | SQL Engine |
| <a id="12531194">[12531194](#12531194)</a> | [FIX: I/O error on a BPE file causes buffer time-out in SQL Server (KB4469268)](https://support.microsoft.com/help/4469268) | SQL Engine |
| <a id="12532591">[12532591](#12532591)</a> | [FIX: Transactions and log truncation may be blocked when you use Query Store in SQL Server 2016 and 2017 (KB4461562)](https://support.microsoft.com/help/4461562) | SQL Engine |
| <a id="12574520">[12574520](#12574520)</a> | [FIX: Out of memory error occurs when Database Node Memory (KB) drops below 2 percent in SQL Server 2014 and 2016 (KB4470916)](https://support.microsoft.com/help/4470916) | SQL Engine |
| <a id="12576803">[12576803](#12576803)</a> | [FIX: Access violation occurs and server stops unexpectedly when you use XEvent session with sqlos.wait_info event in SQL Server 2016 (KB4483427)](https://support.microsoft.com/help/4483427) | SQL Engine |
| <a id="12578033">[12578033](#12578033)</a> | [FIX: "Non-yielding" error occurs when there's a heavy use of prepared statements in SQL Server 2014 and 2016 (KB4475322)](https://support.microsoft.com/help/4475322) | SQL Engine |
| <a id="12588285">[12588285](#12588285)</a> | [FIX: Assertion failure occurs when you try to back up database in limited disk space in SQL Server 2016 (KB4486940)](https://support.microsoft.com/help/4486940) | SQL Engine |
| <a id="12594029">[12594029](#12594029)</a> | [FIX: Upgrade to SQL Server 2016 SP2 CU3 or CU4 fails with an error when sysadmin account "sa" is renamed in SQL Server 2016 (KB4486931)](https://support.microsoft.com/help/4486931) | SQL Engine |
| <a id="12486147">[12486147](#12486147)</a> | FIX: Restore of TDE-compressed backup is unsuccessful when backing up database to a 512-byte Emulation disk in SQL Server (KB4479280) | SQL Engine |
| <a id="12577822">[12577822](#12577822)</a> | FIX: Access violation occurs when SQL is trying to promote a transaction to DTC while collecting QDS statistics (KB4486939) | SQL Engine |
| <a id="12456075">[12456075](#12456075)</a> | [FIX: Columnstore Index build request may time out after 25 seconds though the memory grant time-out is configured in SQL Server 2016 (KB4480641)](https://support.microsoft.com/help/4480641) | SQL performance |
| <a id="12480339">[12480339](#12480339)</a> | [FIX: High CPU usage when there are many batch requests in SQL Server 2016 (KB4480635)](https://support.microsoft.com/help/4480635) | SQL performance |
| <a id="12571593">[12571593](#12571593)</a> | [FIX: Access violation when you compile a query and histogram amendment is enabled with default Cardinality Estimation in SQL Server 2016 and 2017 (KB4316948)](https://support.microsoft.com/help/4316948) | SQL performance |
| <a id="12488528">[12488528](#12488528)</a> | [FIX: Error occurs when the Database Encryption Key is longer than 3,456 bits in SQL Server 2016 and 2017 (KB4463125)](https://support.microsoft.com/help/4463125) | SQL security |
| <a id="12488531">[12488531](#12488531)</a> | FIX: Masked data is exposed when a query that uses `sp_cursorfetch` is run in SQL Server if Dynamic Data Masking is enabled (KB4459535) | SQL Security |
| <a id="12482228">[12482228](#12482228)</a> | [FIX: Access violation when you run a query that uses the XML data type in SQL Server 2014, 2016 and 2017 (KB4460112)](https://support.microsoft.com/help/4460112) | XML |

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
| Instapi130.dll | 2015.131.5264.1 | 53328     | 11-Jan-19 | 03:40 | x86      |
| Keyfile.dll    | 2015.131.5264.1 | 88656     | 11-Jan-19 | 03:38 | x86      |
| Sqlbrowser.exe | 2015.131.5264.1 | 276560    | 11-Jan-19 | 03:40 | x86      |
| Sqldumper.exe  | 2015.131.5264.1 | 107600    | 11-Jan-19 | 03:40 | x86      |

SQL Server 2016 Writer

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi130.dll        | 2015.131.5264.1 | 61008     | 11-Jan-19 | 03:39 | x64      |
| Sqlboot.dll           | 2015.131.5264.1 | 186456    | 11-Jan-19 | 03:42 | x64      |
| Sqldumper.exe         | 2015.131.5264.1 | 127264    | 11-Jan-19 | 03:42 | x64      |
| Sqlvdi.dll            | 2015.131.5264.1 | 168528    | 11-Jan-19 | 03:38 | x86      |
| Sqlvdi.dll            | 2015.131.5264.1 | 197200    | 11-Jan-19 | 03:39 | x64      |
| Sqlwriter.exe         | 2015.131.5264.1 | 131672    | 11-Jan-19 | 03:39 | x64      |
| Sqlwriter_keyfile.dll | 2015.131.5264.1 | 100648    | 11-Jan-19 | 03:42 | x64      |
| Sqlwvss.dll           | 2015.131.5264.1 | 340560    | 11-Jan-19 | 03:42 | x64      |
| Sqlwvss_xp.dll        | 2015.131.5264.1 | 26192     | 11-Jan-19 | 03:42 | x64      |

SQL Server 2016 Analysis Services

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.server.core.dll | 13.0.5264.1     | 1348184   | 11-Jan-19 | 03:38 | x86      |
| Microsoft.applicationinsights.dll          | 2.7.0.13435     | 329872    | 06-Jul-18 | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5264.1     | 990296    | 11-Jan-19 | 03:38 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5264.1     | 990288    | 11-Jan-19 | 03:42 | x86      |
| Msmdctr130.dll                             | 2015.131.5264.1 | 40024     | 11-Jan-19 | 03:42 | x64      |
| Msmdlocal.dll                              | 2015.131.5264.1 | 37101648  | 11-Jan-19 | 03:38 | x86      |
| Msmdlocal.dll                              | 2015.131.5264.1 | 56208472  | 11-Jan-19 | 03:42 | x64      |
| Msmdsrv.exe                                | 2015.131.5264.1 | 56745048  | 11-Jan-19 | 03:39 | x64      |
| Msmgdsrv.dll                               | 2015.131.5264.1 | 6507816   | 11-Jan-19 | 03:40 | x86      |
| Msmgdsrv.dll                               | 2015.131.5264.1 | 7507032   | 11-Jan-19 | 03:41 | x64      |
| Msolap130.dll                              | 2015.131.5264.1 | 7008336   | 11-Jan-19 | 03:38 | x86      |
| Msolap130.dll                              | 2015.131.5264.1 | 8639576   | 11-Jan-19 | 03:42 | x64      |
| Msolui130.dll                              | 2015.131.5264.1 | 287312    | 11-Jan-19 | 03:38 | x86      |
| Msolui130.dll                              | 2015.131.5264.1 | 310360    | 11-Jan-19 | 03:42 | x64      |
| Sql_as_keyfile.dll                         | 2015.131.5264.1 | 100648    | 11-Jan-19 | 03:42 | x64      |
| Sqlboot.dll                                | 2015.131.5264.1 | 186456    | 11-Jan-19 | 03:42 | x64      |
| Sqlceip.exe                                | 13.0.5264.1     | 256088    | 11-Jan-19 | 03:41 | x86      |
| Sqldumper.exe                              | 2015.131.5264.1 | 107600    | 11-Jan-19 | 03:40 | x86      |
| Sqldumper.exe                              | 2015.131.5264.1 | 127264    | 11-Jan-19 | 03:42 | x64      |
| Tmapi.dll                                  | 2015.131.5264.1 | 4345936   | 11-Jan-19 | 03:42 | x64      |
| Tmcachemgr.dll                             | 2015.131.5264.1 | 2826320   | 11-Jan-19 | 03:42 | x64      |
| Tmpersistence.dll                          | 2015.131.5264.1 | 1071184   | 11-Jan-19 | 03:42 | x64      |
| Tmtransactions.dll                         | 2015.131.5264.1 | 1352272   | 11-Jan-19 | 03:42 | x64      |
| Xe.dll                                     | 2015.131.5264.1 | 626256    | 11-Jan-19 | 03:39 | x64      |
| Xmlrw.dll                                  | 2015.131.5264.1 | 259672    | 11-Jan-19 | 03:39 | x86      |
| Xmlrw.dll                                  | 2015.131.5264.1 | 319056    | 11-Jan-19 | 03:39 | x64      |
| Xmlrwbin.dll                               | 2015.131.5264.1 | 191576    | 11-Jan-19 | 03:39 | x86      |
| Xmlrwbin.dll                               | 2015.131.5264.1 | 227408    | 11-Jan-19 | 03:39 | x64      |
| Xmsrv.dll                                  | 2015.131.5264.1 | 32727640  | 11-Jan-19 | 03:39 | x86      |
| Xmsrv.dll                                  | 2015.131.5264.1 | 24050776  | 11-Jan-19 | 03:42 | x64      |

SQL Server 2016 Database Services Common Core

|                  File name                  |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                             | 2015.131.5264.1 | 180816    | 11-Jan-19 | 03:39 | x64      |
| Batchparser.dll                             | 2015.131.5264.1 | 160336    | 11-Jan-19 | 03:40 | x86      |
| Instapi130.dll                              | 2015.131.5264.1 | 61008     | 11-Jan-19 | 03:39 | x64      |
| Instapi130.dll                              | 2015.131.5264.1 | 53328     | 11-Jan-19 | 03:40 | x86      |
| Isacctchange.dll                            | 2015.131.5264.1 | 29264     | 11-Jan-19 | 03:40 | x86      |
| Isacctchange.dll                            | 2015.131.5264.1 | 31016     | 11-Jan-19 | 03:42 | x64      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5264.1     | 1027672   | 11-Jan-19 | 03:38 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5264.1     | 1027672   | 11-Jan-19 | 03:41 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.5264.1     | 1348696   | 11-Jan-19 | 03:41 | x86      |
| Microsoft.analysisservices.dll              | 13.0.5264.1     | 702552    | 11-Jan-19 | 03:41 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.5264.1     | 765528    | 11-Jan-19 | 03:41 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.5264.1     | 520792    | 11-Jan-19 | 03:41 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5264.1     | 711768    | 11-Jan-19 | 03:38 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5264.1     | 711768    | 11-Jan-19 | 03:41 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5264.1 | 72784     | 11-Jan-19 | 03:39 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5264.1 | 75352     | 11-Jan-19 | 03:40 | x64      |
| Msasxpress.dll                              | 2015.131.5264.1 | 31824     | 11-Jan-19 | 03:38 | x86      |
| Msasxpress.dll                              | 2015.131.5264.1 | 35928     | 11-Jan-19 | 03:42 | x64      |
| Pbsvcacctsync.dll                           | 2015.131.5264.1 | 59984     | 11-Jan-19 | 03:38 | x86      |
| Pbsvcacctsync.dll                           | 2015.131.5264.1 | 72792     | 11-Jan-19 | 03:42 | x64      |
| Sql_common_core_keyfile.dll                 | 2015.131.5264.1 | 100648    | 11-Jan-19 | 03:42 | x64      |
| Sqldumper.exe                               | 2015.131.5264.1 | 107600    | 11-Jan-19 | 03:40 | x86      |
| Sqldumper.exe                               | 2015.131.5264.1 | 127264    | 11-Jan-19 | 03:42 | x64      |
| Sqlftacct.dll                               | 2015.131.5264.1 | 46672     | 11-Jan-19 | 03:38 | x86      |
| Sqlftacct.dll                               | 2015.131.5264.1 | 51800     | 11-Jan-19 | 03:42 | x64      |
| Sqlmgmprovider.dll                          | 2015.131.5264.1 | 364112    | 11-Jan-19 | 03:38 | x86      |
| Sqlmgmprovider.dll                          | 2015.131.5264.1 | 404048    | 11-Jan-19 | 03:42 | x64      |
| Sqlsecacctchg.dll                           | 2015.131.5264.1 | 34896     | 11-Jan-19 | 03:38 | x86      |
| Sqlsecacctchg.dll                           | 2015.131.5264.1 | 37456     | 11-Jan-19 | 03:42 | x64      |
| Sqltdiagn.dll                               | 2015.131.5264.1 | 60496     | 11-Jan-19 | 03:38 | x86      |
| Sqltdiagn.dll                               | 2015.131.5264.1 | 67664     | 11-Jan-19 | 03:42 | x64      |

SQL Server 2016 sql_dreplay_client

|            File name           |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2015.131.5264.1 | 120912    | 11-Jan-19 | 03:40 | x86      |
| Dreplaycommon.dll              | 2015.131.5264.1 | 690768    | 11-Jan-19 | 03:41 | x86      |
| Dreplayutil.dll                | 2015.131.5264.1 | 309840    | 11-Jan-19 | 03:40 | x86      |
| Instapi130.dll                 | 2015.131.5264.1 | 61008     | 11-Jan-19 | 03:39 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.131.5264.1 | 100648    | 11-Jan-19 | 03:42 | x64      |
| Sqlresourceloader.dll          | 2015.131.5264.1 | 28240     | 11-Jan-19 | 03:38 | x86      |

SQL Server 2016 sql_dreplay_controller

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2015.131.5264.1 | 690768    | 11-Jan-19 | 03:41 | x86      |
| Dreplaycontroller.exe              | 2015.131.5264.1 | 350288    | 11-Jan-19 | 03:40 | x86      |
| Dreplayprocess.dll                 | 2015.131.5264.1 | 171600    | 11-Jan-19 | 03:40 | x86      |
| Instapi130.dll                     | 2015.131.5264.1 | 61008     | 11-Jan-19 | 03:39 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.131.5264.1 | 100648    | 11-Jan-19 | 03:42 | x64      |
| Sqlresourceloader.dll              | 2015.131.5264.1 | 28240     | 11-Jan-19 | 03:38 | x86      |

SQL Server 2016 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Backuptourl.exe                              | 13.0.5264.1     | 41048     | 11-Jan-19 | 03:39 | x64      |
| Batchparser.dll                              | 2015.131.5264.1 | 180816    | 11-Jan-19 | 03:39 | x64      |
| Datacollectorcontroller.dll                  | 2015.131.5264.1 | 225576    | 11-Jan-19 | 03:42 | x64      |
| Dcexec.exe                                   | 2015.131.5264.1 | 74328     | 11-Jan-19 | 03:39 | x64      |
| Fssres.dll                                   | 2015.131.5264.1 | 81704     | 11-Jan-19 | 03:42 | x64      |
| Hadrres.dll                                  | 2015.131.5264.1 | 177744    | 11-Jan-19 | 03:39 | x64      |
| Hkcompile.dll                                | 2015.131.5264.1 | 1298000   | 11-Jan-19 | 03:39 | x64      |
| Hkengine.dll                                 | 2015.131.5264.1 | 5600848   | 11-Jan-19 | 03:40 | x64      |
| Hkruntime.dll                                | 2015.131.5264.1 | 158800    | 11-Jan-19 | 03:40 | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 06-Jul-18 | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.5264.1     | 234072    | 11-Jan-19 | 03:41 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.131.5264.1 | 72280     | 11-Jan-19 | 03:41 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.131.5264.1 | 65112     | 11-Jan-19 | 03:40 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5264.1 | 150104    | 11-Jan-19 | 03:40 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5264.1 | 158808    | 11-Jan-19 | 03:40 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.131.5264.1 | 271960    | 11-Jan-19 | 03:40 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.131.5264.1 | 74840     | 11-Jan-19 | 03:40 | x64      |
| Odsole70.dll                                 | 2015.131.5264.1 | 92760     | 11-Jan-19 | 03:42 | x64      |
| Opends60.dll                                 | 2015.131.5264.1 | 32848     | 11-Jan-19 | 03:39 | x64      |
| Qds.dll                                      | 2015.131.5264.1 | 869464    | 11-Jan-19 | 03:42 | x64      |
| Rsfxft.dll                                   | 2015.131.5264.1 | 34384     | 11-Jan-19 | 03:39 | x64      |
| Sqagtres.dll                                 | 2015.131.5264.1 | 64600     | 11-Jan-19 | 03:42 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.131.5264.1 | 100648    | 11-Jan-19 | 03:42 | x64      |
| Sqlaamss.dll                                 | 2015.131.5264.1 | 80472     | 11-Jan-19 | 03:41 | x64      |
| Sqlaccess.dll                                | 2015.131.5264.1 | 462424    | 11-Jan-19 | 03:40 | x64      |
| Sqlagent.exe                                 | 2015.131.5264.1 | 566360    | 11-Jan-19 | 03:39 | x64      |
| Sqlagentctr130.dll                           | 2015.131.5264.1 | 51792     | 11-Jan-19 | 03:38 | x64      |
| Sqlagentctr130.dll                           | 2015.131.5264.1 | 44112     | 11-Jan-19 | 03:38 | x86      |
| Sqlagentlog.dll                              | 2015.131.5264.1 | 32856     | 11-Jan-19 | 03:42 | x64      |
| Sqlagentmail.dll                             | 2015.131.5264.1 | 47704     | 11-Jan-19 | 03:41 | x64      |
| Sqlboot.dll                                  | 2015.131.5264.1 | 186456    | 11-Jan-19 | 03:42 | x64      |
| Sqlceip.exe                                  | 13.0.5264.1     | 256088    | 11-Jan-19 | 03:41 | x86      |
| Sqlcmdss.dll                                 | 2015.131.5264.1 | 59992     | 11-Jan-19 | 03:42 | x64      |
| Sqldk.dll                                    | 2015.131.5264.1 | 2587736   | 11-Jan-19 | 03:42 | x64      |
| Sqldtsss.dll                                 | 2015.131.5264.1 | 97368     | 11-Jan-19 | 03:41 | x64      |
| Sqliosim.com                                 | 2015.131.5264.1 | 307792    | 11-Jan-19 | 03:38 | x64      |
| Sqliosim.exe                                 | 2015.131.5264.1 | 3014232   | 11-Jan-19 | 03:39 | x64      |
| Sqllang.dll                                  | 2015.131.5264.1 | 39520856  | 11-Jan-19 | 03:42 | x64      |
| Sqlmin.dll                                   | 2015.131.5264.1 | 37891664  | 11-Jan-19 | 03:42 | x64      |
| Sqlolapss.dll                                | 2015.131.5264.1 | 97880     | 11-Jan-19 | 03:41 | x64      |
| Sqlos.dll                                    | 2015.131.5264.1 | 26192     | 11-Jan-19 | 03:39 | x64      |
| Sqlpowershellss.dll                          | 2015.131.5264.1 | 58448     | 11-Jan-19 | 03:42 | x64      |
| Sqlrepss.dll                                 | 2015.131.5264.1 | 54864     | 11-Jan-19 | 03:42 | x64      |
| Sqlresld.dll                                 | 2015.131.5264.1 | 30800     | 11-Jan-19 | 03:42 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5264.1 | 30800     | 11-Jan-19 | 03:42 | x64      |
| Sqlscm.dll                                   | 2015.131.5264.1 | 61008     | 11-Jan-19 | 03:39 | x64      |
| Sqlscriptdowngrade.dll                       | 2015.131.5264.1 | 27728     | 11-Jan-19 | 03:42 | x64      |
| Sqlscriptupgrade.dll                         | 2015.131.5264.1 | 5808720   | 11-Jan-19 | 03:39 | x64      |
| Sqlserverspatial130.dll                      | 2015.131.5264.1 | 732752    | 11-Jan-19 | 03:39 | x64      |
| Sqlservr.exe                                 | 2015.131.5264.1 | 392792    | 11-Jan-19 | 03:39 | x64      |
| Sqlsvc.dll                                   | 2015.131.5264.1 | 152144    | 11-Jan-19 | 03:42 | x64      |
| Sqltses.dll                                  | 2015.131.5264.1 | 8922192   | 11-Jan-19 | 03:42 | x64      |
| Sqsrvres.dll                                 | 2015.131.5264.1 | 250960    | 11-Jan-19 | 03:42 | x64      |
| Xe.dll                                       | 2015.131.5264.1 | 626256    | 11-Jan-19 | 03:39 | x64      |
| Xmlrw.dll                                    | 2015.131.5264.1 | 319056    | 11-Jan-19 | 03:39 | x64      |
| Xmlrwbin.dll                                 | 2015.131.5264.1 | 227408    | 11-Jan-19 | 03:39 | x64      |
| Xpadsi.exe                                   | 2015.131.5264.1 | 79144     | 11-Jan-19 | 03:42 | x64      |
| Xplog70.dll                                  | 2015.131.5264.1 | 65616     | 11-Jan-19 | 03:39 | x64      |
| Xpsqlbot.dll                                 | 2015.131.5264.1 | 33360     | 11-Jan-19 | 03:39 | x64      |
| Xpstar.dll                                   | 2015.131.5264.1 | 422480    | 11-Jan-19 | 03:39 | x64      |

SQL Server 2016 Database Services Core Shared

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2015.131.5264.1 | 180816    | 11-Jan-19 | 03:39 | x64      |
| Batchparser.dll                              | 2015.131.5264.1 | 160336    | 11-Jan-19 | 03:40 | x86      |
| Bcp.exe                                      | 2015.131.5264.1 | 120104    | 11-Jan-19 | 03:42 | x64      |
| Commanddest.dll                              | 2015.131.5264.1 | 249128    | 11-Jan-19 | 03:42 | x64      |
| Datacollectorenumerators.dll                 | 2015.131.5264.1 | 116008    | 11-Jan-19 | 03:42 | x64      |
| Datacollectortasks.dll                       | 2015.131.5264.1 | 188200    | 11-Jan-19 | 03:42 | x64      |
| Distrib.exe                                  | 2015.131.5264.1 | 191064    | 11-Jan-19 | 03:39 | x64      |
| Dteparse.dll                                 | 2015.131.5264.1 | 109864    | 11-Jan-19 | 03:42 | x64      |
| Dteparsemgd.dll                              | 2015.131.5264.1 | 88664     | 11-Jan-19 | 03:38 | x64      |
| Dtepkg.dll                                   | 2015.131.5264.1 | 137512    | 11-Jan-19 | 03:42 | x64      |
| Dtexec.exe                                   | 2015.131.5264.1 | 72792     | 11-Jan-19 | 03:39 | x64      |
| Dts.dll                                      | 2015.131.5264.1 | 3147048   | 11-Jan-19 | 03:42 | x64      |
| Dtscomexpreval.dll                           | 2015.131.5264.1 | 477480    | 11-Jan-19 | 03:42 | x64      |
| Dtsconn.dll                                  | 2015.131.5264.1 | 492840    | 11-Jan-19 | 03:42 | x64      |
| Dtshost.exe                                  | 2015.131.5264.1 | 86616     | 11-Jan-19 | 03:39 | x64      |
| Dtslog.dll                                   | 2015.131.5264.1 | 120616    | 11-Jan-19 | 03:42 | x64      |
| Dtsmsg130.dll                                | 2015.131.5264.1 | 545576    | 11-Jan-19 | 03:42 | x64      |
| Dtspipeline.dll                              | 2015.131.5264.1 | 1279296   | 11-Jan-19 | 03:42 | x64      |
| Dtspipelineperf130.dll                       | 2015.131.5264.1 | 48424     | 11-Jan-19 | 03:42 | x64      |
| Dtuparse.dll                                 | 2015.131.5264.1 | 87848     | 11-Jan-19 | 03:42 | x64      |
| Dtutil.exe                                   | 2015.131.5264.1 | 134744    | 11-Jan-19 | 03:39 | x64      |
| Exceldest.dll                                | 2015.131.5264.1 | 263464    | 11-Jan-19 | 03:42 | x64      |
| Excelsrc.dll                                 | 2015.131.5264.1 | 285480    | 11-Jan-19 | 03:42 | x64      |
| Execpackagetask.dll                          | 2015.131.5264.1 | 166696    | 11-Jan-19 | 03:42 | x64      |
| Flatfiledest.dll                             | 2015.131.5264.1 | 389416    | 11-Jan-19 | 03:42 | x64      |
| Flatfilesrc.dll                              | 2015.131.5264.1 | 401704    | 11-Jan-19 | 03:42 | x64      |
| Foreachfileenumerator.dll                    | 2015.131.5264.1 | 96552     | 11-Jan-19 | 03:42 | x64      |
| Hkengperfctrs.dll                            | 2015.131.5264.1 | 58960     | 11-Jan-19 | 03:39 | x64      |
| Logread.exe                                  | 2015.131.5264.1 | 626776    | 11-Jan-19 | 03:39 | x64      |
| Microsoft.analysisservices.applocal.core.dll | 13.0.5264.1     | 1313880   | 11-Jan-19 | 03:38 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll | 13.0.5264.1     | 391760    | 11-Jan-19 | 03:39 | x86      |
| Microsoft.sqlserver.replication.dll          | 2015.131.5264.1 | 1651288   | 11-Jan-19 | 03:41 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5264.1 | 150104    | 11-Jan-19 | 03:40 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5264.1 | 158808    | 11-Jan-19 | 03:40 | x64      |
| Msdtssrvrutil.dll                            | 2015.131.5264.1 | 101464    | 11-Jan-19 | 03:42 | x64      |
| Msxmlsql.dll                                 | 2015.131.5264.1 | 1494608   | 11-Jan-19 | 03:39 | x64      |
| Oledbdest.dll                                | 2015.131.5264.1 | 264280    | 11-Jan-19 | 03:42 | x64      |
| Oledbsrc.dll                                 | 2015.131.5264.1 | 290904    | 11-Jan-19 | 03:42 | x64      |
| Osql.exe                                     | 2015.131.5264.1 | 75584     | 11-Jan-19 | 03:42 | x64      |
| Rawdest.dll                                  | 2015.131.5264.1 | 209496    | 11-Jan-19 | 03:42 | x64      |
| Rawsource.dll                                | 2015.131.5264.1 | 196896    | 11-Jan-19 | 03:42 | x64      |
| Rdistcom.dll                                 | 2015.131.5264.1 | 906840    | 11-Jan-19 | 03:42 | x64      |
| Recordsetdest.dll                            | 2015.131.5264.1 | 186968    | 11-Jan-19 | 03:42 | x64      |
| Repldp.dll                                   | 2015.131.5264.1 | 281688    | 11-Jan-19 | 03:42 | x64      |
| Replprov.dll                                 | 2015.131.5264.1 | 812120    | 11-Jan-19 | 03:42 | x64      |
| Replrec.dll                                  | 2015.131.5264.1 | 1018968   | 11-Jan-19 | 03:41 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2015.131.5264.1 | 100648    | 11-Jan-19 | 03:42 | x64      |
| Sqlcmd.exe                                   | 2015.131.5264.1 | 249640    | 11-Jan-19 | 03:42 | x64      |
| Sqldiag.exe                                  | 2015.131.5264.1 | 1257560   | 11-Jan-19 | 03:39 | x64      |
| Sqllogship.exe                               | 13.0.5264.1     | 104536    | 11-Jan-19 | 03:41 | x64      |
| Sqlresld.dll                                 | 2015.131.5264.1 | 28752     | 11-Jan-19 | 03:38 | x86      |
| Sqlresld.dll                                 | 2015.131.5264.1 | 30800     | 11-Jan-19 | 03:42 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5264.1 | 28240     | 11-Jan-19 | 03:38 | x86      |
| Sqlresourceloader.dll                        | 2015.131.5264.1 | 30800     | 11-Jan-19 | 03:42 | x64      |
| Sqlscm.dll                                   | 2015.131.5264.1 | 52816     | 11-Jan-19 | 03:38 | x86      |
| Sqlscm.dll                                   | 2015.131.5264.1 | 61008     | 11-Jan-19 | 03:39 | x64      |
| Sqlsvc.dll                                   | 2015.131.5264.1 | 127056    | 11-Jan-19 | 03:38 | x86      |
| Sqlsvc.dll                                   | 2015.131.5264.1 | 152144    | 11-Jan-19 | 03:42 | x64      |
| Sqltaskconnections.dll                       | 2015.131.5264.1 | 180816    | 11-Jan-19 | 03:42 | x64      |
| Sqlwep130.dll                                | 2015.131.5264.1 | 105552    | 11-Jan-19 | 03:42 | x64      |
| Ssisoledb.dll                                | 2015.131.5264.1 | 216144    | 11-Jan-19 | 03:42 | x64      |
| Txagg.dll                                    | 2015.131.5264.1 | 364624    | 11-Jan-19 | 03:42 | x64      |
| Txbdd.dll                                    | 2015.131.5264.1 | 172624    | 11-Jan-19 | 03:42 | x64      |
| Txdatacollector.dll                          | 2015.131.5264.1 | 367696    | 11-Jan-19 | 03:42 | x64      |
| Txdataconvert.dll                            | 2015.131.5264.1 | 296528    | 11-Jan-19 | 03:42 | x64      |
| Txderived.dll                                | 2015.131.5264.1 | 607824    | 11-Jan-19 | 03:42 | x64      |
| Txlookup.dll                                 | 2015.131.5264.1 | 532048    | 11-Jan-19 | 03:42 | x64      |
| Txmerge.dll                                  | 2015.131.5264.1 | 230480    | 11-Jan-19 | 03:42 | x64      |
| Txmergejoin.dll                              | 2015.131.5264.1 | 278608    | 11-Jan-19 | 03:42 | x64      |
| Txmulticast.dll                              | 2015.131.5264.1 | 128080    | 11-Jan-19 | 03:42 | x64      |
| Txrowcount.dll                               | 2015.131.5264.1 | 126544    | 11-Jan-19 | 03:42 | x64      |
| Txsort.dll                                   | 2015.131.5264.1 | 259152    | 11-Jan-19 | 03:42 | x64      |
| Txsplit.dll                                  | 2015.131.5264.1 | 600656    | 11-Jan-19 | 03:42 | x64      |
| Txunionall.dll                               | 2015.131.5264.1 | 181840    | 11-Jan-19 | 03:42 | x64      |
| Xe.dll                                       | 2015.131.5264.1 | 626256    | 11-Jan-19 | 03:39 | x64      |
| Xmlrw.dll                                    | 2015.131.5264.1 | 319056    | 11-Jan-19 | 03:39 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.131.5264.1 | 1015080   | 11-Jan-19 | 03:42 | x64      |
| Sql_extensibility_keyfile.dll | 2015.131.5264.1 | 100648    | 11-Jan-19 | 03:42 | x64      |
| Sqlsatellite.dll              | 2015.131.5264.1 | 837200    | 11-Jan-19 | 03:39 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2015.131.5264.1 | 660048    | 11-Jan-19 | 03:39 | x64      |
| Fdhost.exe               | 2015.131.5264.1 | 105256    | 11-Jan-19 | 03:42 | x64      |
| Fdlauncher.exe           | 2015.131.5264.1 | 51496     | 11-Jan-19 | 03:42 | x64      |
| Sql_fulltext_keyfile.dll | 2015.131.5264.1 | 100648    | 11-Jan-19 | 03:42 | x64      |
| Sqlft130ph.dll           | 2015.131.5264.1 | 57936     | 11-Jan-19 | 03:39 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.5264.1     | 23640     | 11-Jan-19 | 03:38 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.131.5264.1 | 100648    | 11-Jan-19 | 03:42 | x64      |

SQL Server 2016 Integration Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                    | 2015.131.5264.1 | 202832    | 11-Jan-19 | 03:40 | x86      |
| Commanddest.dll                                    | 2015.131.5264.1 | 249128    | 11-Jan-19 | 03:42 | x64      |
| Dteparse.dll                                       | 2015.131.5264.1 | 99408     | 11-Jan-19 | 03:40 | x86      |
| Dteparse.dll                                       | 2015.131.5264.1 | 109864    | 11-Jan-19 | 03:42 | x64      |
| Dteparsemgd.dll                                    | 2015.131.5264.1 | 88664     | 11-Jan-19 | 03:38 | x64      |
| Dteparsemgd.dll                                    | 2015.131.5264.1 | 83544     | 11-Jan-19 | 03:41 | x86      |
| Dtepkg.dll                                         | 2015.131.5264.1 | 115792    | 11-Jan-19 | 03:40 | x86      |
| Dtepkg.dll                                         | 2015.131.5264.1 | 137512    | 11-Jan-19 | 03:42 | x64      |
| Dtexec.exe                                         | 2015.131.5264.1 | 72792     | 11-Jan-19 | 03:39 | x64      |
| Dtexec.exe                                         | 2015.131.5264.1 | 66640     | 11-Jan-19 | 03:40 | x86      |
| Dts.dll                                            | 2015.131.5264.1 | 2632784   | 11-Jan-19 | 03:40 | x86      |
| Dts.dll                                            | 2015.131.5264.1 | 3147048   | 11-Jan-19 | 03:42 | x64      |
| Dtscomexpreval.dll                                 | 2015.131.5264.1 | 418896    | 11-Jan-19 | 03:40 | x86      |
| Dtscomexpreval.dll                                 | 2015.131.5264.1 | 477480    | 11-Jan-19 | 03:42 | x64      |
| Dtsconn.dll                                        | 2015.131.5264.1 | 392272    | 11-Jan-19 | 03:40 | x86      |
| Dtsconn.dll                                        | 2015.131.5264.1 | 492840    | 11-Jan-19 | 03:42 | x64      |
| Dtsdebughost.exe                                   | 2015.131.5264.1 | 109656    | 11-Jan-19 | 03:39 | x64      |
| Dtsdebughost.exe                                   | 2015.131.5264.1 | 93776     | 11-Jan-19 | 03:40 | x86      |
| Dtshost.exe                                        | 2015.131.5264.1 | 86616     | 11-Jan-19 | 03:39 | x64      |
| Dtshost.exe                                        | 2015.131.5264.1 | 76368     | 11-Jan-19 | 03:40 | x86      |
| Dtslog.dll                                         | 2015.131.5264.1 | 102992    | 11-Jan-19 | 03:40 | x86      |
| Dtslog.dll                                         | 2015.131.5264.1 | 120616    | 11-Jan-19 | 03:42 | x64      |
| Dtsmsg130.dll                                      | 2015.131.5264.1 | 541264    | 11-Jan-19 | 03:40 | x86      |
| Dtsmsg130.dll                                      | 2015.131.5264.1 | 545576    | 11-Jan-19 | 03:42 | x64      |
| Dtspipeline.dll                                    | 2015.131.5264.1 | 1059408   | 11-Jan-19 | 03:40 | x86      |
| Dtspipeline.dll                                    | 2015.131.5264.1 | 1279296   | 11-Jan-19 | 03:42 | x64      |
| Dtspipelineperf130.dll                             | 2015.131.5264.1 | 42064     | 11-Jan-19 | 03:40 | x86      |
| Dtspipelineperf130.dll                             | 2015.131.5264.1 | 48424     | 11-Jan-19 | 03:42 | x64      |
| Dtuparse.dll                                       | 2015.131.5264.1 | 79952     | 11-Jan-19 | 03:40 | x86      |
| Dtuparse.dll                                       | 2015.131.5264.1 | 87848     | 11-Jan-19 | 03:42 | x64      |
| Dtutil.exe                                         | 2015.131.5264.1 | 134744    | 11-Jan-19 | 03:39 | x64      |
| Dtutil.exe                                         | 2015.131.5264.1 | 115280    | 11-Jan-19 | 03:40 | x86      |
| Exceldest.dll                                      | 2015.131.5264.1 | 216656    | 11-Jan-19 | 03:40 | x86      |
| Exceldest.dll                                      | 2015.131.5264.1 | 263464    | 11-Jan-19 | 03:42 | x64      |
| Excelsrc.dll                                       | 2015.131.5264.1 | 232528    | 11-Jan-19 | 03:40 | x86      |
| Excelsrc.dll                                       | 2015.131.5264.1 | 285480    | 11-Jan-19 | 03:42 | x64      |
| Execpackagetask.dll                                | 2015.131.5264.1 | 135248    | 11-Jan-19 | 03:40 | x86      |
| Execpackagetask.dll                                | 2015.131.5264.1 | 166696    | 11-Jan-19 | 03:42 | x64      |
| Flatfiledest.dll                                   | 2015.131.5264.1 | 334416    | 11-Jan-19 | 03:40 | x86      |
| Flatfiledest.dll                                   | 2015.131.5264.1 | 389416    | 11-Jan-19 | 03:42 | x64      |
| Flatfilesrc.dll                                    | 2015.131.5264.1 | 345168    | 11-Jan-19 | 03:40 | x86      |
| Flatfilesrc.dll                                    | 2015.131.5264.1 | 401704    | 11-Jan-19 | 03:42 | x64      |
| Foreachfileenumerator.dll                          | 2015.131.5264.1 | 80464     | 11-Jan-19 | 03:40 | x86      |
| Foreachfileenumerator.dll                          | 2015.131.5264.1 | 96552     | 11-Jan-19 | 03:42 | x64      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5264.1     | 1313880   | 11-Jan-19 | 03:38 | x86      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5264.1     | 1313880   | 11-Jan-19 | 03:41 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 06-Jul-18 | 22:33 | x86      |
| Microsoft.sqlserver.astasks.dll                    | 13.0.5264.1     | 73304     | 11-Jan-19 | 03:41 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5264.1 | 112216    | 11-Jan-19 | 03:41 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5264.1 | 107096    | 11-Jan-19 | 03:42 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5264.1     | 82720     | 10-Jan-19 | 17:33 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5264.1     | 82520     | 11-Jan-19 | 03:41 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll       | 13.0.5264.1     | 391760    | 11-Jan-19 | 03:39 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5264.1 | 150104    | 11-Jan-19 | 03:40 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5264.1 | 138832    | 11-Jan-19 | 03:41 | x86      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5264.1 | 158808    | 11-Jan-19 | 03:40 | x64      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5264.1 | 144472    | 11-Jan-19 | 03:41 | x86      |
| Msdtssrvr.exe                                      | 13.0.5264.1     | 216664    | 11-Jan-19 | 03:41 | x64      |
| Msdtssrvrutil.dll                                  | 2015.131.5264.1 | 90192     | 11-Jan-19 | 03:38 | x86      |
| Msdtssrvrutil.dll                                  | 2015.131.5264.1 | 101464    | 11-Jan-19 | 03:42 | x64      |
| Oledbdest.dll                                      | 2015.131.5264.1 | 216656    | 11-Jan-19 | 03:38 | x86      |
| Oledbdest.dll                                      | 2015.131.5264.1 | 264280    | 11-Jan-19 | 03:42 | x64      |
| Oledbsrc.dll                                       | 2015.131.5264.1 | 235600    | 11-Jan-19 | 03:38 | x86      |
| Oledbsrc.dll                                       | 2015.131.5264.1 | 290904    | 11-Jan-19 | 03:42 | x64      |
| Rawdest.dll                                        | 2015.131.5264.1 | 168528    | 11-Jan-19 | 03:38 | x86      |
| Rawdest.dll                                        | 2015.131.5264.1 | 209496    | 11-Jan-19 | 03:42 | x64      |
| Rawsource.dll                                      | 2015.131.5264.1 | 155216    | 11-Jan-19 | 03:38 | x86      |
| Rawsource.dll                                      | 2015.131.5264.1 | 196896    | 11-Jan-19 | 03:42 | x64      |
| Recordsetdest.dll                                  | 2015.131.5264.1 | 151632    | 11-Jan-19 | 03:38 | x86      |
| Recordsetdest.dll                                  | 2015.131.5264.1 | 186968    | 11-Jan-19 | 03:42 | x64      |
| Sql_is_keyfile.dll                                 | 2015.131.5264.1 | 100648    | 11-Jan-19 | 03:42 | x64      |
| Sqlceip.exe                                        | 13.0.5264.1     | 256088    | 11-Jan-19 | 03:41 | x86      |
| Sqldest.dll                                        | 2015.131.5264.1 | 215632    | 11-Jan-19 | 03:38 | x86      |
| Sqldest.dll                                        | 2015.131.5264.1 | 263768    | 11-Jan-19 | 03:42 | x64      |
| Sqltaskconnections.dll                             | 2015.131.5264.1 | 151120    | 11-Jan-19 | 03:38 | x86      |
| Sqltaskconnections.dll                             | 2015.131.5264.1 | 180816    | 11-Jan-19 | 03:42 | x64      |
| Ssisoledb.dll                                      | 2015.131.5264.1 | 176720    | 11-Jan-19 | 03:38 | x86      |
| Ssisoledb.dll                                      | 2015.131.5264.1 | 216144    | 11-Jan-19 | 03:42 | x64      |
| Txagg.dll                                          | 2015.131.5264.1 | 304728    | 11-Jan-19 | 03:39 | x86      |
| Txagg.dll                                          | 2015.131.5264.1 | 364624    | 11-Jan-19 | 03:42 | x64      |
| Txbdd.dll                                          | 2015.131.5264.1 | 137816    | 11-Jan-19 | 03:39 | x86      |
| Txbdd.dll                                          | 2015.131.5264.1 | 172624    | 11-Jan-19 | 03:42 | x64      |
| Txbestmatch.dll                                    | 2015.131.5264.1 | 496216    | 11-Jan-19 | 03:39 | x86      |
| Txbestmatch.dll                                    | 2015.131.5264.1 | 611408    | 11-Jan-19 | 03:42 | x64      |
| Txcache.dll                                        | 2015.131.5264.1 | 148056    | 11-Jan-19 | 03:39 | x86      |
| Txcache.dll                                        | 2015.131.5264.1 | 183376    | 11-Jan-19 | 03:42 | x64      |
| Txcharmap.dll                                      | 2015.131.5264.1 | 250456    | 11-Jan-19 | 03:39 | x86      |
| Txcharmap.dll                                      | 2015.131.5264.1 | 289872    | 11-Jan-19 | 03:42 | x64      |
| Txcopymap.dll                                      | 2015.131.5264.1 | 147544    | 11-Jan-19 | 03:39 | x86      |
| Txcopymap.dll                                      | 2015.131.5264.1 | 182864    | 11-Jan-19 | 03:42 | x64      |
| Txdataconvert.dll                                  | 2015.131.5264.1 | 255064    | 11-Jan-19 | 03:39 | x86      |
| Txdataconvert.dll                                  | 2015.131.5264.1 | 296528    | 11-Jan-19 | 03:42 | x64      |
| Txderived.dll                                      | 2015.131.5264.1 | 519256    | 11-Jan-19 | 03:39 | x86      |
| Txderived.dll                                      | 2015.131.5264.1 | 607824    | 11-Jan-19 | 03:42 | x64      |
| Txfileextractor.dll                                | 2015.131.5264.1 | 162904    | 11-Jan-19 | 03:39 | x86      |
| Txfileextractor.dll                                | 2015.131.5264.1 | 201808    | 11-Jan-19 | 03:42 | x64      |
| Txfileinserter.dll                                 | 2015.131.5264.1 | 160856    | 11-Jan-19 | 03:39 | x86      |
| Txfileinserter.dll                                 | 2015.131.5264.1 | 199760    | 11-Jan-19 | 03:42 | x64      |
| Txgroupdups.dll                                    | 2015.131.5264.1 | 231512    | 11-Jan-19 | 03:39 | x86      |
| Txgroupdups.dll                                    | 2015.131.5264.1 | 290896    | 11-Jan-19 | 03:42 | x64      |
| Txlineage.dll                                      | 2015.131.5264.1 | 109656    | 11-Jan-19 | 03:39 | x86      |
| Txlineage.dll                                      | 2015.131.5264.1 | 137808    | 11-Jan-19 | 03:42 | x64      |
| Txlookup.dll                                       | 2015.131.5264.1 | 449624    | 11-Jan-19 | 03:39 | x86      |
| Txlookup.dll                                       | 2015.131.5264.1 | 532048    | 11-Jan-19 | 03:42 | x64      |
| Txmerge.dll                                        | 2015.131.5264.1 | 176728    | 11-Jan-19 | 03:39 | x86      |
| Txmerge.dll                                        | 2015.131.5264.1 | 230480    | 11-Jan-19 | 03:42 | x64      |
| Txmergejoin.dll                                    | 2015.131.5264.1 | 223832    | 11-Jan-19 | 03:39 | x86      |
| Txmergejoin.dll                                    | 2015.131.5264.1 | 278608    | 11-Jan-19 | 03:42 | x64      |
| Txmulticast.dll                                    | 2015.131.5264.1 | 101976    | 11-Jan-19 | 03:39 | x86      |
| Txmulticast.dll                                    | 2015.131.5264.1 | 128080    | 11-Jan-19 | 03:42 | x64      |
| Txpivot.dll                                        | 2015.131.5264.1 | 181848    | 11-Jan-19 | 03:39 | x86      |
| Txpivot.dll                                        | 2015.131.5264.1 | 227920    | 11-Jan-19 | 03:42 | x64      |
| Txrowcount.dll                                     | 2015.131.5264.1 | 101464    | 11-Jan-19 | 03:39 | x86      |
| Txrowcount.dll                                     | 2015.131.5264.1 | 126544    | 11-Jan-19 | 03:42 | x64      |
| Txsampling.dll                                     | 2015.131.5264.1 | 134744    | 11-Jan-19 | 03:39 | x86      |
| Txsampling.dll                                     | 2015.131.5264.1 | 172112    | 11-Jan-19 | 03:42 | x64      |
| Txscd.dll                                          | 2015.131.5264.1 | 169560    | 11-Jan-19 | 03:39 | x86      |
| Txscd.dll                                          | 2015.131.5264.1 | 220240    | 11-Jan-19 | 03:42 | x64      |
| Txsort.dll                                         | 2015.131.5264.1 | 211032    | 11-Jan-19 | 03:39 | x86      |
| Txsort.dll                                         | 2015.131.5264.1 | 259152    | 11-Jan-19 | 03:42 | x64      |
| Txsplit.dll                                        | 2015.131.5264.1 | 513112    | 11-Jan-19 | 03:39 | x86      |
| Txsplit.dll                                        | 2015.131.5264.1 | 600656    | 11-Jan-19 | 03:42 | x64      |
| Txtermextraction.dll                               | 2015.131.5264.1 | 8615512   | 11-Jan-19 | 03:39 | x86      |
| Txtermextraction.dll                               | 2015.131.5264.1 | 8677968   | 11-Jan-19 | 03:42 | x64      |
| Txtermlookup.dll                                   | 2015.131.5264.1 | 4106840   | 11-Jan-19 | 03:39 | x86      |
| Txtermlookup.dll                                   | 2015.131.5264.1 | 4158544   | 11-Jan-19 | 03:42 | x64      |
| Txunionall.dll                                     | 2015.131.5264.1 | 138840    | 11-Jan-19 | 03:39 | x86      |
| Txunionall.dll                                     | 2015.131.5264.1 | 181840    | 11-Jan-19 | 03:42 | x64      |
| Txunpivot.dll                                      | 2015.131.5264.1 | 162392    | 11-Jan-19 | 03:39 | x86      |
| Txunpivot.dll                                      | 2015.131.5264.1 | 201808    | 11-Jan-19 | 03:42 | x64      |
| Xe.dll                                             | 2015.131.5264.1 | 626256    | 11-Jan-19 | 03:39 | x64      |
| Xe.dll                                             | 2015.131.5264.1 | 558680    | 11-Jan-19 | 03:39 | x86      |

SQL Server 2016 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 10.0.8224.47     | 483408    | 12-Dec-18 | 03:25 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.47 | 75344     | 12-Dec-18 | 03:25 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.47     | 45648     | 12-Dec-18 | 03:25 | x86      |
| Instapi130.dll                                                       | 2015.131.5264.1  | 61016     | 11-Jan-19 | 03:42 | x64      |
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
| Mpdwinterop.dll                                                      | 2015.131.5264.1  | 394320    | 11-Jan-19 | 03:42 | x64      |
| Mpdwsvc.exe                                                          | 2015.131.5264.1  | 6616360   | 11-Jan-19 | 03:42 | x64      |
| Pdwodbcsql11.dll                                                     | 2015.131.5264.1  | 2229848   | 11-Jan-19 | 03:42 | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.47 | 47184     | 12-Dec-18 | 03:26 | x64      |
| Sqldk.dll                                                            | 2015.131.5264.1  | 2532440   | 11-Jan-19 | 03:42 | x64      |
| Sqldumper.exe                                                        | 2015.131.5264.1  | 127272    | 11-Jan-19 | 03:42 | x64      |
| Sqlos.dll                                                            | 2015.131.5264.1  | 26200     | 11-Jan-19 | 03:42 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.47 | 4347984   | 12-Dec-18 | 03:26 | x64      |
| Sqltses.dll                                                          | 2015.131.5264.1  | 9091160   | 11-Jan-19 | 03:42 | x64      |

SQL Server 2016 Reporting Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.modeling.dll                   | 13.0.5264.1     | 610904    | 11-Jan-19 | 03:38 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.5264.1     | 1620056   | 11-Jan-19 | 03:38 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.5264.1     | 329816    | 11-Jan-19 | 03:38 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.5264.1     | 1072728   | 11-Jan-19 | 03:38 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5264.1     | 532056    | 11-Jan-19 | 03:39 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5264.1     | 532048    | 11-Jan-19 | 03:38 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5264.1     | 532056    | 11-Jan-19 | 03:39 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5264.1     | 532056    | 11-Jan-19 | 03:40 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5264.1     | 532056    | 11-Jan-19 | 03:39 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5264.1     | 532056    | 11-Jan-19 | 03:40 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5264.1     | 532056    | 11-Jan-19 | 03:42 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5264.1     | 532264    | 11-Jan-19 | 03:40 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5264.1     | 532256    | 11-Jan-19 | 03:40 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5264.1     | 532056    | 11-Jan-19 | 03:41 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.5264.1     | 162904    | 11-Jan-19 | 03:38 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.5264.1     | 6073424   | 11-Jan-19 | 03:41 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5264.1     | 4511320   | 11-Jan-19 | 03:39 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5264.1     | 4511824   | 11-Jan-19 | 03:38 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5264.1     | 4511832   | 11-Jan-19 | 03:39 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5264.1     | 4511832   | 11-Jan-19 | 03:40 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5264.1     | 4512344   | 11-Jan-19 | 03:39 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5264.1     | 4511832   | 11-Jan-19 | 03:40 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5264.1     | 4511832   | 11-Jan-19 | 03:42 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5264.1     | 4512576   | 11-Jan-19 | 03:40 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5264.1     | 4511520   | 11-Jan-19 | 03:40 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5264.1     | 4511832   | 11-Jan-19 | 03:41 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.5264.1     | 10889808  | 11-Jan-19 | 03:41 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.5264.1     | 100952    | 11-Jan-19 | 03:41 | x64      |
| Microsoft.reportingservices.storage.dll                   | 13.0.5264.1     | 208472    | 11-Jan-19 | 03:41 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.131.5264.1 | 47704     | 11-Jan-19 | 03:41 | x64      |
| Msmdlocal.dll                                             | 2015.131.5264.1 | 37101648  | 11-Jan-19 | 03:38 | x86      |
| Msmdlocal.dll                                             | 2015.131.5264.1 | 56208472  | 11-Jan-19 | 03:42 | x64      |
| Msmgdsrv.dll                                              | 2015.131.5264.1 | 6507816   | 11-Jan-19 | 03:40 | x86      |
| Msmgdsrv.dll                                              | 2015.131.5264.1 | 7507032   | 11-Jan-19 | 03:41 | x64      |
| Msolap130.dll                                             | 2015.131.5264.1 | 7008336   | 11-Jan-19 | 03:38 | x86      |
| Msolap130.dll                                             | 2015.131.5264.1 | 8639576   | 11-Jan-19 | 03:42 | x64      |
| Msolui130.dll                                             | 2015.131.5264.1 | 287312    | 11-Jan-19 | 03:38 | x86      |
| Msolui130.dll                                             | 2015.131.5264.1 | 310360    | 11-Jan-19 | 03:42 | x64      |
| Reportingservicescompression.dll                          | 2015.131.5264.1 | 62552     | 11-Jan-19 | 03:42 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.131.5264.1 | 114264    | 11-Jan-19 | 03:40 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.131.5264.1 | 108632    | 11-Jan-19 | 03:41 | x64      |
| Reportingservicesnativeserver.dll                         | 2015.131.5264.1 | 98904     | 11-Jan-19 | 03:41 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.5264.1     | 2710616   | 11-Jan-19 | 03:41 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5264.1     | 867928    | 11-Jan-19 | 03:41 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5264.1     | 872016    | 11-Jan-19 | 03:39 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5264.1     | 872016    | 11-Jan-19 | 03:40 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5264.1     | 872024    | 11-Jan-19 | 03:42 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5264.1     | 876120    | 11-Jan-19 | 03:40 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5264.1     | 872024    | 11-Jan-19 | 03:38 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5264.1     | 872024    | 11-Jan-19 | 03:39 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5264.1     | 884304    | 11-Jan-19 | 03:42 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5264.1     | 867928    | 11-Jan-19 | 03:40 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5264.1     | 872016    | 11-Jan-19 | 03:38 | x86      |
| Rshttpruntime.dll                                         | 2015.131.5264.1 | 99416     | 11-Jan-19 | 03:41 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.131.5264.1 | 100648    | 11-Jan-19 | 03:42 | x64      |
| Sqldumper.exe                                             | 2015.131.5264.1 | 107600    | 11-Jan-19 | 03:40 | x86      |
| Sqldumper.exe                                             | 2015.131.5264.1 | 127264    | 11-Jan-19 | 03:42 | x64      |
| Sqlrsos.dll                                               | 2015.131.5264.1 | 26192     | 11-Jan-19 | 03:42 | x64      |
| Sqlserverspatial130.dll                                   | 2015.131.5264.1 | 584272    | 11-Jan-19 | 03:38 | x86      |
| Sqlserverspatial130.dll                                   | 2015.131.5264.1 | 732752    | 11-Jan-19 | 03:39 | x64      |
| Xmlrw.dll                                                 | 2015.131.5264.1 | 259672    | 11-Jan-19 | 03:39 | x86      |
| Xmlrw.dll                                                 | 2015.131.5264.1 | 319056    | 11-Jan-19 | 03:39 | x64      |
| Xmlrwbin.dll                                              | 2015.131.5264.1 | 191576    | 11-Jan-19 | 03:39 | x86      |
| Xmlrwbin.dll                                              | 2015.131.5264.1 | 227408    | 11-Jan-19 | 03:39 | x64      |
| Xmsrv.dll                                                 | 2015.131.5264.1 | 32727640  | 11-Jan-19 | 03:39 | x86      |
| Xmsrv.dll                                                 | 2015.131.5264.1 | 24050776  | 11-Jan-19 | 03:42 | x64      |

SQL Server 2016 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.5264.1     | 23640     | 11-Jan-19 | 03:41 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.131.5264.1 | 100648    | 11-Jan-19 | 03:42 | x64      |

SQL Server 2016 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                  | 2015.131.5264.1 | 1311824   | 11-Jan-19 | 03:40 | x86      |
| Ddsshapes.dll                                  | 2015.131.5264.1 | 135760    | 11-Jan-19 | 03:40 | x86      |
| Dtaengine.exe                                  | 2015.131.5264.1 | 166992    | 11-Jan-19 | 03:40 | x86      |
| Dteparse.dll                                   | 2015.131.5264.1 | 99408     | 11-Jan-19 | 03:40 | x86      |
| Dteparse.dll                                   | 2015.131.5264.1 | 109864    | 11-Jan-19 | 03:42 | x64      |
| Dteparsemgd.dll                                | 2015.131.5264.1 | 88664     | 11-Jan-19 | 03:38 | x64      |
| Dteparsemgd.dll                                | 2015.131.5264.1 | 83544     | 11-Jan-19 | 03:41 | x86      |
| Dtepkg.dll                                     | 2015.131.5264.1 | 115792    | 11-Jan-19 | 03:40 | x86      |
| Dtepkg.dll                                     | 2015.131.5264.1 | 137512    | 11-Jan-19 | 03:42 | x64      |
| Dtexec.exe                                     | 2015.131.5264.1 | 72792     | 11-Jan-19 | 03:39 | x64      |
| Dtexec.exe                                     | 2015.131.5264.1 | 66640     | 11-Jan-19 | 03:40 | x86      |
| Dts.dll                                        | 2015.131.5264.1 | 2632784   | 11-Jan-19 | 03:40 | x86      |
| Dts.dll                                        | 2015.131.5264.1 | 3147048   | 11-Jan-19 | 03:42 | x64      |
| Dtscomexpreval.dll                             | 2015.131.5264.1 | 418896    | 11-Jan-19 | 03:40 | x86      |
| Dtscomexpreval.dll                             | 2015.131.5264.1 | 477480    | 11-Jan-19 | 03:42 | x64      |
| Dtsconn.dll                                    | 2015.131.5264.1 | 392272    | 11-Jan-19 | 03:40 | x86      |
| Dtsconn.dll                                    | 2015.131.5264.1 | 492840    | 11-Jan-19 | 03:42 | x64      |
| Dtshost.exe                                    | 2015.131.5264.1 | 86616     | 11-Jan-19 | 03:39 | x64      |
| Dtshost.exe                                    | 2015.131.5264.1 | 76368     | 11-Jan-19 | 03:40 | x86      |
| Dtslog.dll                                     | 2015.131.5264.1 | 102992    | 11-Jan-19 | 03:40 | x86      |
| Dtslog.dll                                     | 2015.131.5264.1 | 120616    | 11-Jan-19 | 03:42 | x64      |
| Dtsmsg130.dll                                  | 2015.131.5264.1 | 541264    | 11-Jan-19 | 03:40 | x86      |
| Dtsmsg130.dll                                  | 2015.131.5264.1 | 545576    | 11-Jan-19 | 03:42 | x64      |
| Dtspipeline.dll                                | 2015.131.5264.1 | 1059408   | 11-Jan-19 | 03:40 | x86      |
| Dtspipeline.dll                                | 2015.131.5264.1 | 1279296   | 11-Jan-19 | 03:42 | x64      |
| Dtspipelineperf130.dll                         | 2015.131.5264.1 | 42064     | 11-Jan-19 | 03:40 | x86      |
| Dtspipelineperf130.dll                         | 2015.131.5264.1 | 48424     | 11-Jan-19 | 03:42 | x64      |
| Dtuparse.dll                                   | 2015.131.5264.1 | 79952     | 11-Jan-19 | 03:40 | x86      |
| Dtuparse.dll                                   | 2015.131.5264.1 | 87848     | 11-Jan-19 | 03:42 | x64      |
| Dtutil.exe                                     | 2015.131.5264.1 | 134744    | 11-Jan-19 | 03:39 | x64      |
| Dtutil.exe                                     | 2015.131.5264.1 | 115280    | 11-Jan-19 | 03:40 | x86      |
| Exceldest.dll                                  | 2015.131.5264.1 | 216656    | 11-Jan-19 | 03:40 | x86      |
| Exceldest.dll                                  | 2015.131.5264.1 | 263464    | 11-Jan-19 | 03:42 | x64      |
| Excelsrc.dll                                   | 2015.131.5264.1 | 232528    | 11-Jan-19 | 03:40 | x86      |
| Excelsrc.dll                                   | 2015.131.5264.1 | 285480    | 11-Jan-19 | 03:42 | x64      |
| Flatfiledest.dll                               | 2015.131.5264.1 | 334416    | 11-Jan-19 | 03:40 | x86      |
| Flatfiledest.dll                               | 2015.131.5264.1 | 389416    | 11-Jan-19 | 03:42 | x64      |
| Flatfilesrc.dll                                | 2015.131.5264.1 | 345168    | 11-Jan-19 | 03:40 | x86      |
| Flatfilesrc.dll                                | 2015.131.5264.1 | 401704    | 11-Jan-19 | 03:42 | x64      |
| Foreachfileenumerator.dll                      | 2015.131.5264.1 | 80464     | 11-Jan-19 | 03:40 | x86      |
| Foreachfileenumerator.dll                      | 2015.131.5264.1 | 96552     | 11-Jan-19 | 03:42 | x64      |
| Microsoft.analysisservices.adomdclientui.dll   | 13.0.5264.1     | 92248     | 11-Jan-19 | 03:41 | x86      |
| Microsoft.analysisservices.applocal.core.dll   | 13.0.5264.1     | 1313880   | 11-Jan-19 | 03:41 | x86      |
| Microsoft.analysisservices.project.dll         | 2015.131.5264.1 | 2023000   | 11-Jan-19 | 03:41 | x86      |
| Microsoft.analysisservices.projectui.dll       | 2015.131.5264.1 | 42072     | 11-Jan-19 | 03:40 | x86      |
| Microsoft.sqlserver.astasks.dll                | 13.0.5264.1     | 73304     | 11-Jan-19 | 03:42 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5264.1     | 435800    | 11-Jan-19 | 03:41 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5264.1     | 435800    | 11-Jan-19 | 03:42 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5264.1     | 2044504   | 11-Jan-19 | 03:41 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5264.1     | 2044504   | 11-Jan-19 | 03:42 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5264.1 | 150104    | 11-Jan-19 | 03:40 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5264.1 | 138832    | 11-Jan-19 | 03:41 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5264.1 | 158808    | 11-Jan-19 | 03:40 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5264.1 | 144472    | 11-Jan-19 | 03:41 | x86      |
| Msdtssrvrutil.dll                              | 2015.131.5264.1 | 90192     | 11-Jan-19 | 03:38 | x86      |
| Msdtssrvrutil.dll                              | 2015.131.5264.1 | 101464    | 11-Jan-19 | 03:42 | x64      |
| Msmdlocal.dll                                  | 2015.131.5264.1 | 37101648  | 11-Jan-19 | 03:38 | x86      |
| Msmdlocal.dll                                  | 2015.131.5264.1 | 56208472  | 11-Jan-19 | 03:42 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5264.1 | 6507816   | 11-Jan-19 | 03:40 | x86      |
| Msmgdsrv.dll                                   | 2015.131.5264.1 | 7507032   | 11-Jan-19 | 03:41 | x64      |
| Msolap130.dll                                  | 2015.131.5264.1 | 7008336   | 11-Jan-19 | 03:38 | x86      |
| Msolap130.dll                                  | 2015.131.5264.1 | 8639576   | 11-Jan-19 | 03:42 | x64      |
| Msolui130.dll                                  | 2015.131.5264.1 | 287312    | 11-Jan-19 | 03:38 | x86      |
| Msolui130.dll                                  | 2015.131.5264.1 | 310360    | 11-Jan-19 | 03:42 | x64      |
| Oledbdest.dll                                  | 2015.131.5264.1 | 216656    | 11-Jan-19 | 03:38 | x86      |
| Oledbdest.dll                                  | 2015.131.5264.1 | 264280    | 11-Jan-19 | 03:42 | x64      |
| Oledbsrc.dll                                   | 2015.131.5264.1 | 235600    | 11-Jan-19 | 03:38 | x86      |
| Oledbsrc.dll                                   | 2015.131.5264.1 | 290904    | 11-Jan-19 | 03:42 | x64      |
| Profiler.exe                                   | 2015.131.5264.1 | 804432    | 11-Jan-19 | 03:41 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.131.5264.1 | 100648    | 11-Jan-19 | 03:42 | x64      |
| Sqldumper.exe                                  | 2015.131.5264.1 | 107600    | 11-Jan-19 | 03:40 | x86      |
| Sqldumper.exe                                  | 2015.131.5264.1 | 127264    | 11-Jan-19 | 03:42 | x64      |
| Sqlresld.dll                                   | 2015.131.5264.1 | 28752     | 11-Jan-19 | 03:38 | x86      |
| Sqlresld.dll                                   | 2015.131.5264.1 | 30800     | 11-Jan-19 | 03:42 | x64      |
| Sqlresourceloader.dll                          | 2015.131.5264.1 | 28240     | 11-Jan-19 | 03:38 | x86      |
| Sqlresourceloader.dll                          | 2015.131.5264.1 | 30800     | 11-Jan-19 | 03:42 | x64      |
| Sqlscm.dll                                     | 2015.131.5264.1 | 52816     | 11-Jan-19 | 03:38 | x86      |
| Sqlscm.dll                                     | 2015.131.5264.1 | 61008     | 11-Jan-19 | 03:39 | x64      |
| Sqlsvc.dll                                     | 2015.131.5264.1 | 127056    | 11-Jan-19 | 03:38 | x86      |
| Sqlsvc.dll                                     | 2015.131.5264.1 | 152144    | 11-Jan-19 | 03:42 | x64      |
| Sqltaskconnections.dll                         | 2015.131.5264.1 | 151120    | 11-Jan-19 | 03:38 | x86      |
| Sqltaskconnections.dll                         | 2015.131.5264.1 | 180816    | 11-Jan-19 | 03:42 | x64      |
| Txdataconvert.dll                              | 2015.131.5264.1 | 255064    | 11-Jan-19 | 03:39 | x86      |
| Txdataconvert.dll                              | 2015.131.5264.1 | 296528    | 11-Jan-19 | 03:42 | x64      |
| Xe.dll                                         | 2015.131.5264.1 | 626256    | 11-Jan-19 | 03:39 | x64      |
| Xe.dll                                         | 2015.131.5264.1 | 558680    | 11-Jan-19 | 03:39 | x86      |
| Xmlrw.dll                                      | 2015.131.5264.1 | 259672    | 11-Jan-19 | 03:39 | x86      |
| Xmlrw.dll                                      | 2015.131.5264.1 | 319056    | 11-Jan-19 | 03:39 | x64      |
| Xmlrwbin.dll                                   | 2015.131.5264.1 | 191576    | 11-Jan-19 | 03:39 | x86      |
| Xmlrwbin.dll                                   | 2015.131.5264.1 | 227408    | 11-Jan-19 | 03:39 | x64      |
| Xmsrv.dll                                      | 2015.131.5264.1 | 32727640  | 11-Jan-19 | 03:39 | x86      |
| Xmsrv.dll                                      | 2015.131.5264.1 | 24050776  | 11-Jan-19 | 03:42 | x64      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
