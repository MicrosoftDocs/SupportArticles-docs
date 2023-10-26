---
title: Cumulative update 6 for SQL Server 2016 SP2 (KB4488536)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 Service Pack 2 (SP2) cumulative update 6 (KB4488536).
ms.date: 10/26/2023
ms.custom: KB4488536
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Express
- SQL Server 2016 Web
---

# KB4488536 - Cumulative Update 6 for SQL Server 2016 SP2

_Release Date:_ &nbsp; March 19, 2019  
_Version:_ &nbsp; 13.0.5292.0

This article describes Cumulative Update package 6 (CU6) (build number: **13.0.5292.0**) for Microsoft SQL Server 2016 Service Pack 2 (SP2). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the initial release of SQL Server 2016 SP2.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---|---|---|
| <a id="12654303">[12654303](#12654303)</a> | [FIX: MDS database upgrade fails with error in SQL Server 2016 (KB4488971)](https://support.microsoft.com/help/4488971) | Data Quality Services (DQS) |
| <a id="12391094">[12391094](#12391094)</a> | [Improvement: DMV sys.dm_hadr_cluster reports cloud witness quorum type "4" and quorum_type_desc "UNKNOWN_QUORUM" in SQL Server 2016 (KB4490141)](https://support.microsoft.com/help/4490141) | High Availability |
| <a id="12711556">[12711556](#12711556)</a> | [FIX: Automatic seeding assertions when databases are removed from AG in SQL Server 2016 (KB4492880)](https://support.microsoft.com/help/4492880) | High Availability |
| <a id="12708933">[12708933](#12708933)</a> | [FIX: "The given key was not present in the dictionary" occurs if you do a preview in the CDC Source in SQL Server 2016 (KB4490435)](https://support.microsoft.com/help/4490435) | Integration services |
| <a id="12679390">[12679390](#12679390)</a> | Improvement: You can use JQuery 3.0.0 or later versions in SSRS 2016 (KB4492865) | Reporting Services |
| <a id="12600924">[12600924](#12600924)</a> | FIX: Images in the report won't display when the report name contains a bracket "`(`" in SSRS 2016 (KB4488403) | Reporting Services |
| <a id="12664995">[12664995](#12664995)</a> | FIX: Subscription will fail if the `DateTime` parameter is created and edited by different locale and keyboard language in SSRS 2016 (KB4491333) | Reporting Services |
| <a id="12689122">[12689122](#12689122)</a> | FIX: Simple Data Grid row header disappears when an item within the grid is clicked in SSRS 2016 (KB4490743) | Reporting Services |
| <a id="12700350">[12700350](#12700350)</a> | FIX: Unable to edit a Data-Driven subscription with date parameter in SSRS 2016 (KB4490737) | Reporting Services |
| <a id="12186150">[12186150](#12186150)</a> | [Improvement: Optional replacement for "String or binary data would be truncated" message with extended information in SQL Server 2016 and 2017 (KB4468101)](https://support.microsoft.com/help/4468101) | SQL Engine |
| <a id="12639882">[12639882](#12639882)</a> | [FIX: Error 2812 and 20028 occur when you drop publisher or enable database for publication after you upgrade your SQL Server 2016 (KB4488856)](https://support.microsoft.com/help/4488856) | SQL Engine |
| <a id="12644636">[12644636](#12644636)</a> | [FIX: Error occurs when sp_addarticle is used to add article for transactional replication to memory-optimized table on subscriber in SQL Server 2016 (KB4493329)](https://support.microsoft.com/help/4493329) | SQL Engine |
| <a id="12646096">[12646096](#12646096)</a> | [FIX: Assertion occurs when a parallel query deletes from a Filestream table in SQL Server 2014 and 2016 (KB4488809)](https://support.microsoft.com/help/4488809) | SQL Engine |
| <a id="12654426">[12654426](#12654426)</a> | [FIX: Assertion occurs when linked server which points to itself is used in a cross-database transaction in SQL Server 2016 (KB4488949)](https://support.microsoft.com/help/4488949) | SQL Engine |
| <a id="12658209">[12658209](#12658209)</a> | [FIX: 'MSrepl_agent_jobs' doesn't exist when you run sp_addpullsubscription_agent to create pull subscription in SQL Server 2016 (KB4488853)](https://support.microsoft.com/help/4488853) | SQL Engine |
| <a id="12660793">[12660793](#12660793)</a> | [FIX: Error 10314 occurs when you load .NET CLR assembly in SQL Server 2016 database (KB4489202)](https://support.microsoft.com/help/4489202) | SQL Engine |
| <a id="12668586">[12668586](#12668586)</a> | [FIX: FILESTREAM for file I/O access feature can't be enabled when you use Cluster Shared Volumes (CSV) in SQL Server 2016 Failover Cluster Instances (KB4488817)](https://support.microsoft.com/help/4488817) | SQL Engine |
| <a id="12673166">[12673166](#12673166)</a> | [FIX: Stack Dump occurs in the change tracking cleanup process in SQL Server 2016 (KB4490140)](https://support.microsoft.com/help/4490140) | SQL Engine |
| <a id="12710423">[12710423](#12710423)</a> | [FIX: Non-yielding scheduler issue occurs when you run queries in batch mode that spill in SQL Server 2016 (KB4500327)](https://support.microsoft.com/help/4500327) | SQL Engine |
| <a id="12722975">[12722975](#12722975)</a> | [FIX: SQL Trace Collection Set fails when you click "Collect and Upload Now" in SQL Server 2016 (KB4492762)](https://support.microsoft.com/help/4492762) | SQL Engine |
| <a id="12733996">[12733996](#12733996)</a> | [FIX: Error occurs when you back up a virtual machine with non-component based backup in SQL Server 2016 (KB4493364)](https://support.microsoft.com/help/4493364) | SQL Engine |
| <a id="12741001">[12741001](#12741001)</a> | [FIX: FileTable database level directory is inaccessible after database startup in SQL Server 2016 (KB4492899)](https://support.microsoft.com/help/4492899) | SQL Engine |
| <a id="12748064">[12748064](#12748064)</a> | [FIX: SQL Writer Service can cause undetected deadlocks on system DMV when you do a VSS backup (KB4480652)](https://support.microsoft.com/help/4480652) | SQL Engine |
| <a id="12671862">[12671862](#12671862)</a> | [FIX: Users are incorrectly permitted to create incremental statistics on nonclustered indexes that aren't aligned to the base table in SQL Server 2016 (KB4486932)](https://support.microsoft.com/help/4486932) | SQL performance |
| <a id="12677809">[12677809](#12677809)</a> | [FIX: Filtered NCI over a CCI may not be maintained when the table is updated in a way that none of the key or included columns of the NCI are changed (KB4490138)](https://support.microsoft.com/help/4490138) | SQL performance |
| <a id="12738723">[12738723](#12738723)</a> | [FIX: A specially crafted query run by a low-privileged user may expose the masked data in SQL Server 2016 (KB4493363)](https://support.microsoft.com/help/4493363) | SQL security |

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
| Instapi130.dll | 2015.131.5292.0 | 53536     | 12-Mar-19 | 08:18 | x86      |
| Keyfile.dll    | 2015.131.5292.0 | 88656     | 12-Mar-19 | 08:18 | x86      |
| Sqlbrowser.exe | 2015.131.5292.0 | 276792    | 12-Mar-19 | 08:18 | x86      |
| Sqldumper.exe  | 2015.131.5292.0 | 107808    | 12-Mar-19 | 08:18 | x86      |

SQL Server 2016 Writer

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi130.dll        | 2015.131.5292.0 | 61016     | 12-Mar-19 | 08:23 | x64      |
| Sqlboot.dll           | 2015.131.5292.0 | 186448    | 12-Mar-19 | 08:21 | x64      |
| Sqldumper.exe         | 2015.131.5292.0 | 127056    | 12-Mar-19 | 08:21 | x64      |
| Sqlvdi.dll            | 2015.131.5292.0 | 168736    | 12-Mar-19 | 08:18 | x86      |
| Sqlvdi.dll            | 2015.131.5292.0 | 197208    | 12-Mar-19 | 08:23 | x64      |
| Sqlwriter.exe         | 2015.131.5292.0 | 131664    | 12-Mar-19 | 08:21 | x64      |
| Sqlwriter_keyfile.dll | 2015.131.5292.0 | 100432    | 12-Mar-19 | 08:21 | x64      |
| Sqlwvss.dll           | 2015.131.5292.0 | 346712    | 12-Mar-19 | 08:19 | x64      |
| Sqlwvss_xp.dll        | 2015.131.5292.0 | 26200     | 12-Mar-19 | 08:19 | x64      |

SQL Server 2016 Analysis Services

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.server.core.dll | 13.0.5292.0     | 1348184   | 12-Mar-19 | 08:18 | x86      |
| Microsoft.applicationinsights.dll          | 2.7.0.13435     | 329872    | 06-Jul-18 | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5292.0     | 990296    | 12-Mar-19 | 08:18 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5292.0     | 990288    | 12-Mar-19 | 08:18 | x86      |
| Msmdctr130.dll                             | 2015.131.5292.0 | 40016     | 12-Mar-19 | 08:21 | x64      |
| Msmdlocal.dll                              | 2015.131.5292.0 | 37101648  | 12-Mar-19 | 08:18 | x86      |
| Msmdlocal.dll                              | 2015.131.5292.0 | 56208464  | 12-Mar-19 | 08:21 | x64      |
| Msmdsrv.exe                                | 2015.131.5292.0 | 56745552  | 12-Mar-19 | 08:21 | x64      |
| Msmgdsrv.dll                               | 2015.131.5292.0 | 6507608   | 12-Mar-19 | 08:18 | x86      |
| Msmgdsrv.dll                               | 2015.131.5292.0 | 7507032   | 12-Mar-19 | 08:19 | x64      |
| Msolap130.dll                              | 2015.131.5292.0 | 7008336   | 12-Mar-19 | 08:18 | x86      |
| Msolap130.dll                              | 2015.131.5292.0 | 8639568   | 12-Mar-19 | 08:21 | x64      |
| Msolui130.dll                              | 2015.131.5292.0 | 287312    | 12-Mar-19 | 08:18 | x86      |
| Msolui130.dll                              | 2015.131.5292.0 | 310352    | 12-Mar-19 | 08:21 | x64      |
| Sql_as_keyfile.dll                         | 2015.131.5292.0 | 100432    | 12-Mar-19 | 08:21 | x64      |
| Sqlboot.dll                                | 2015.131.5292.0 | 186448    | 12-Mar-19 | 08:21 | x64      |
| Sqlceip.exe                                | 13.0.5292.0     | 256288    | 12-Mar-19 | 08:18 | x86      |
| Sqldumper.exe                              | 2015.131.5292.0 | 107808    | 12-Mar-19 | 08:18 | x86      |
| Sqldumper.exe                              | 2015.131.5292.0 | 127056    | 12-Mar-19 | 08:21 | x64      |
| Tmapi.dll                                  | 2015.131.5292.0 | 4345944   | 12-Mar-19 | 08:19 | x64      |
| Tmcachemgr.dll                             | 2015.131.5292.0 | 2826328   | 12-Mar-19 | 08:19 | x64      |
| Tmpersistence.dll                          | 2015.131.5292.0 | 1071192   | 12-Mar-19 | 08:19 | x64      |
| Tmtransactions.dll                         | 2015.131.5292.0 | 1352280   | 12-Mar-19 | 08:19 | x64      |
| Xe.dll                                     | 2015.131.5292.0 | 626264    | 12-Mar-19 | 08:23 | x64      |
| Xmlrw.dll                                  | 2015.131.5292.0 | 259672    | 12-Mar-19 | 08:21 | x86      |
| Xmlrw.dll                                  | 2015.131.5292.0 | 319064    | 12-Mar-19 | 08:23 | x64      |
| Xmlrwbin.dll                               | 2015.131.5292.0 | 191576    | 12-Mar-19 | 08:21 | x86      |
| Xmlrwbin.dll                               | 2015.131.5292.0 | 227416    | 12-Mar-19 | 08:23 | x64      |
| Xmsrv.dll                                  | 2015.131.5292.0 | 24050776  | 12-Mar-19 | 08:19 | x64      |
| Xmsrv.dll                                  | 2015.131.5292.0 | 32727640  | 12-Mar-19 | 08:21 | x86      |

SQL Server 2016 Database Services Common Core

|                  File name                  |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                             | 2015.131.5292.0 | 160544    | 12-Mar-19 | 08:18 | x86      |
| Batchparser.dll                             | 2015.131.5292.0 | 180824    | 12-Mar-19 | 08:23 | x64      |
| Instapi130.dll                              | 2015.131.5292.0 | 53536     | 12-Mar-19 | 08:18 | x86      |
| Instapi130.dll                              | 2015.131.5292.0 | 61016     | 12-Mar-19 | 08:23 | x64      |
| Isacctchange.dll                            | 2015.131.5292.0 | 29472     | 12-Mar-19 | 08:18 | x86      |
| Isacctchange.dll                            | 2015.131.5292.0 | 30800     | 12-Mar-19 | 08:21 | x64      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5292.0     | 1027672   | 12-Mar-19 | 08:18 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5292.0     | 1027664   | 12-Mar-19 | 08:18 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.5292.0     | 1348688   | 12-Mar-19 | 08:18 | x86      |
| Microsoft.analysisservices.dll              | 13.0.5292.0     | 702752    | 12-Mar-19 | 08:18 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.5292.0     | 765728    | 12-Mar-19 | 08:18 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.5292.0     | 520992    | 12-Mar-19 | 08:18 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5292.0     | 711768    | 12-Mar-19 | 08:18 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5292.0     | 711968    | 12-Mar-19 | 08:18 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5292.0 | 75352     | 12-Mar-19 | 08:19 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5292.0 | 72792     | 12-Mar-19 | 08:21 | x86      |
| Msasxpress.dll                              | 2015.131.5292.0 | 31824     | 12-Mar-19 | 08:18 | x86      |
| Msasxpress.dll                              | 2015.131.5292.0 | 35920     | 12-Mar-19 | 08:21 | x64      |
| Pbsvcacctsync.dll                           | 2015.131.5292.0 | 59984     | 12-Mar-19 | 08:18 | x86      |
| Pbsvcacctsync.dll                           | 2015.131.5292.0 | 72784     | 12-Mar-19 | 08:21 | x64      |
| Sql_common_core_keyfile.dll                 | 2015.131.5292.0 | 100432    | 12-Mar-19 | 08:21 | x64      |
| Sqldumper.exe                               | 2015.131.5292.0 | 107808    | 12-Mar-19 | 08:18 | x86      |
| Sqldumper.exe                               | 2015.131.5292.0 | 127056    | 12-Mar-19 | 08:21 | x64      |
| Sqlftacct.dll                               | 2015.131.5292.0 | 46880     | 12-Mar-19 | 08:18 | x86      |
| Sqlftacct.dll                               | 2015.131.5292.0 | 51792     | 12-Mar-19 | 08:21 | x64      |
| Sqlmgmprovider.dll                          | 2015.131.5292.0 | 365880    | 12-Mar-19 | 08:18 | x86      |
| Sqlmgmprovider.dll                          | 2015.131.5292.0 | 406104    | 12-Mar-19 | 08:19 | x64      |
| Sqlsecacctchg.dll                           | 2015.131.5292.0 | 35104     | 12-Mar-19 | 08:18 | x86      |
| Sqlsecacctchg.dll                           | 2015.131.5292.0 | 37464     | 12-Mar-19 | 08:19 | x64      |
| Sqltdiagn.dll                               | 2015.131.5292.0 | 60704     | 12-Mar-19 | 08:18 | x86      |
| Sqltdiagn.dll                               | 2015.131.5292.0 | 67672     | 12-Mar-19 | 08:19 | x64      |

SQL Server 2016 sql_dreplay_client

|            File name           |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2015.131.5292.0 | 121120    | 12-Mar-19 | 08:18 | x86      |
| Dreplaycommon.dll              | 2015.131.5292.0 | 690768    | 12-Mar-19 | 08:18 | x86      |
| Dreplayutil.dll                | 2015.131.5292.0 | 310048    | 12-Mar-19 | 08:18 | x86      |
| Instapi130.dll                 | 2015.131.5292.0 | 61016     | 12-Mar-19 | 08:23 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.131.5292.0 | 100432    | 12-Mar-19 | 08:21 | x64      |
| Sqlresourceloader.dll          | 2015.131.5292.0 | 28448     | 12-Mar-19 | 08:18 | x86      |

SQL Server 2016 sql_dreplay_controller

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2015.131.5292.0 | 690768    | 12-Mar-19 | 08:18 | x86      |
| Dreplaycontroller.exe              | 2015.131.5292.0 | 350496    | 12-Mar-19 | 08:18 | x86      |
| Dreplayprocess.dll                 | 2015.131.5292.0 | 171808    | 12-Mar-19 | 08:18 | x86      |
| Instapi130.dll                     | 2015.131.5292.0 | 61016     | 12-Mar-19 | 08:23 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.131.5292.0 | 100432    | 12-Mar-19 | 08:21 | x64      |
| Sqlresourceloader.dll              | 2015.131.5292.0 | 28448     | 12-Mar-19 | 08:18 | x86      |

SQL Server 2016 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Backuptourl.exe                              | 13.0.5292.0     | 41040     | 12-Mar-19 | 08:21 | x64      |
| Batchparser.dll                              | 2015.131.5292.0 | 180824    | 12-Mar-19 | 08:23 | x64      |
| Datacollectorcontroller.dll                  | 2015.131.5292.0 | 225360    | 12-Mar-19 | 08:21 | x64      |
| Dcexec.exe                                   | 2015.131.5292.0 | 74320     | 12-Mar-19 | 08:21 | x64      |
| Fssres.dll                                   | 2015.131.5292.0 | 81488     | 12-Mar-19 | 08:21 | x64      |
| Hadrres.dll                                  | 2015.131.5292.0 | 177752    | 12-Mar-19 | 08:23 | x64      |
| Hkcompile.dll                                | 2015.131.5292.0 | 1298008   | 12-Mar-19 | 08:23 | x64      |
| Hkengine.dll                                 | 2015.131.5292.0 | 5600848   | 12-Mar-19 | 08:20 | x64      |
| Hkruntime.dll                                | 2015.131.5292.0 | 158800    | 12-Mar-19 | 08:20 | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 06-Jul-18 | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.5292.0     | 234064    | 12-Mar-19 | 08:21 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.131.5292.0 | 72280     | 12-Mar-19 | 08:19 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.131.5292.0 | 65112     | 12-Mar-19 | 08:19 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5292.0 | 150104    | 12-Mar-19 | 08:19 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5292.0 | 158808    | 12-Mar-19 | 08:19 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.131.5292.0 | 271960    | 12-Mar-19 | 08:19 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.131.5292.0 | 74840     | 12-Mar-19 | 08:19 | x64      |
| Odsole70.dll                                 | 2015.131.5292.0 | 92752     | 12-Mar-19 | 08:21 | x64      |
| Opends60.dll                                 | 2015.131.5292.0 | 32856     | 12-Mar-19 | 08:23 | x64      |
| Qds.dll                                      | 2015.131.5292.0 | 869968    | 12-Mar-19 | 08:21 | x64      |
| Rsfxft.dll                                   | 2015.131.5292.0 | 34392     | 12-Mar-19 | 08:23 | x64      |
| Sqagtres.dll                                 | 2015.131.5292.0 | 64592     | 12-Mar-19 | 08:21 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.131.5292.0 | 100432    | 12-Mar-19 | 08:21 | x64      |
| Sqlaamss.dll                                 | 2015.131.5292.0 | 80472     | 12-Mar-19 | 08:19 | x64      |
| Sqlaccess.dll                                | 2015.131.5292.0 | 462936    | 12-Mar-19 | 08:19 | x64      |
| Sqlagent.exe                                 | 2015.131.5292.0 | 566352    | 12-Mar-19 | 08:21 | x64      |
| Sqlagentctr130.dll                           | 2015.131.5292.0 | 44320     | 12-Mar-19 | 08:18 | x86      |
| Sqlagentctr130.dll                           | 2015.131.5292.0 | 51792     | 12-Mar-19 | 08:22 | x64      |
| Sqlagentlog.dll                              | 2015.131.5292.0 | 32848     | 12-Mar-19 | 08:21 | x64      |
| Sqlagentmail.dll                             | 2015.131.5292.0 | 47704     | 12-Mar-19 | 08:19 | x64      |
| Sqlboot.dll                                  | 2015.131.5292.0 | 186448    | 12-Mar-19 | 08:21 | x64      |
| Sqlceip.exe                                  | 13.0.5292.0     | 256288    | 12-Mar-19 | 08:18 | x86      |
| Sqlcmdss.dll                                 | 2015.131.5292.0 | 59984     | 12-Mar-19 | 08:21 | x64      |
| Sqldk.dll                                    | 2015.131.5292.0 | 2587728   | 12-Mar-19 | 08:21 | x64      |
| Sqldtsss.dll                                 | 2015.131.5292.0 | 97368     | 12-Mar-19 | 08:19 | x64      |
| Sqliosim.com                                 | 2015.131.5292.0 | 307792    | 12-Mar-19 | 08:22 | x64      |
| Sqliosim.exe                                 | 2015.131.5292.0 | 3014224   | 12-Mar-19 | 08:21 | x64      |
| Sqllang.dll                                  | 2015.131.5292.0 | 39528528  | 12-Mar-19 | 08:21 | x64      |
| Sqlmin.dll                                   | 2015.131.5292.0 | 37892184  | 12-Mar-19 | 08:19 | x64      |
| Sqlolapss.dll                                | 2015.131.5292.0 | 97880     | 12-Mar-19 | 08:19 | x64      |
| Sqlos.dll                                    | 2015.131.5292.0 | 26200     | 12-Mar-19 | 08:23 | x64      |
| Sqlpowershellss.dll                          | 2015.131.5292.0 | 58456     | 12-Mar-19 | 08:19 | x64      |
| Sqlrepss.dll                                 | 2015.131.5292.0 | 54872     | 12-Mar-19 | 08:19 | x64      |
| Sqlresld.dll                                 | 2015.131.5292.0 | 30808     | 12-Mar-19 | 08:19 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5292.0 | 30808     | 12-Mar-19 | 08:19 | x64      |
| Sqlscm.dll                                   | 2015.131.5292.0 | 61016     | 12-Mar-19 | 08:23 | x64      |
| Sqlscriptdowngrade.dll                       | 2015.131.5292.0 | 27736     | 12-Mar-19 | 08:19 | x64      |
| Sqlscriptupgrade.dll                         | 2015.131.5292.0 | 5808728   | 12-Mar-19 | 08:23 | x64      |
| Sqlserverspatial130.dll                      | 2015.131.5292.0 | 732760    | 12-Mar-19 | 08:23 | x64      |
| Sqlservr.exe                                 | 2015.131.5292.0 | 393296    | 12-Mar-19 | 08:21 | x64      |
| Sqlsvc.dll                                   | 2015.131.5292.0 | 152152    | 12-Mar-19 | 08:19 | x64      |
| Sqltses.dll                                  | 2015.131.5292.0 | 8923736   | 12-Mar-19 | 08:19 | x64      |
| Sqsrvres.dll                                 | 2015.131.5292.0 | 250968    | 12-Mar-19 | 08:19 | x64      |
| Xe.dll                                       | 2015.131.5292.0 | 626264    | 12-Mar-19 | 08:23 | x64      |
| Xmlrw.dll                                    | 2015.131.5292.0 | 319064    | 12-Mar-19 | 08:23 | x64      |
| Xmlrwbin.dll                                 | 2015.131.5292.0 | 227416    | 12-Mar-19 | 08:23 | x64      |
| Xpadsi.exe                                   | 2015.131.5292.0 | 78928     | 12-Mar-19 | 08:21 | x64      |
| Xplog70.dll                                  | 2015.131.5292.0 | 65624     | 12-Mar-19 | 08:23 | x64      |
| Xpsqlbot.dll                                 | 2015.131.5292.0 | 33368     | 12-Mar-19 | 08:23 | x64      |
| Xpstar.dll                                   | 2015.131.5292.0 | 422488    | 12-Mar-19 | 08:23 | x64      |

SQL Server 2016 Database Services Core Shared

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2015.131.5292.0 | 160544    | 12-Mar-19 | 08:18 | x86      |
| Batchparser.dll                              | 2015.131.5292.0 | 180824    | 12-Mar-19 | 08:23 | x64      |
| Bcp.exe                                      | 2015.131.5292.0 | 119888    | 12-Mar-19 | 08:21 | x64      |
| Commanddest.dll                              | 2015.131.5292.0 | 248912    | 12-Mar-19 | 08:21 | x64      |
| Datacollectorenumerators.dll                 | 2015.131.5292.0 | 115792    | 12-Mar-19 | 08:21 | x64      |
| Datacollectortasks.dll                       | 2015.131.5292.0 | 187984    | 12-Mar-19 | 08:21 | x64      |
| Distrib.exe                                  | 2015.131.5292.0 | 191056    | 12-Mar-19 | 08:21 | x64      |
| Dteparse.dll                                 | 2015.131.5292.0 | 109648    | 12-Mar-19 | 08:21 | x64      |
| Dteparsemgd.dll                              | 2015.131.5292.0 | 88664     | 12-Mar-19 | 08:18 | x64      |
| Dtepkg.dll                                   | 2015.131.5292.0 | 137296    | 12-Mar-19 | 08:21 | x64      |
| Dtexec.exe                                   | 2015.131.5292.0 | 72784     | 12-Mar-19 | 08:21 | x64      |
| Dts.dll                                      | 2015.131.5292.0 | 3146832   | 12-Mar-19 | 08:21 | x64      |
| Dtscomexpreval.dll                           | 2015.131.5292.0 | 477264    | 12-Mar-19 | 08:21 | x64      |
| Dtsconn.dll                                  | 2015.131.5292.0 | 492624    | 12-Mar-19 | 08:21 | x64      |
| Dtshost.exe                                  | 2015.131.5292.0 | 86608     | 12-Mar-19 | 08:21 | x64      |
| Dtslog.dll                                   | 2015.131.5292.0 | 120400    | 12-Mar-19 | 08:21 | x64      |
| Dtsmsg130.dll                                | 2015.131.5292.0 | 545360    | 12-Mar-19 | 08:21 | x64      |
| Dtspipeline.dll                              | 2015.131.5292.0 | 1279056   | 12-Mar-19 | 08:21 | x64      |
| Dtspipelineperf130.dll                       | 2015.131.5292.0 | 48208     | 12-Mar-19 | 08:21 | x64      |
| Dtuparse.dll                                 | 2015.131.5292.0 | 87632     | 12-Mar-19 | 08:21 | x64      |
| Dtutil.exe                                   | 2015.131.5292.0 | 134736    | 12-Mar-19 | 08:21 | x64      |
| Exceldest.dll                                | 2015.131.5292.0 | 263248    | 12-Mar-19 | 08:21 | x64      |
| Excelsrc.dll                                 | 2015.131.5292.0 | 285264    | 12-Mar-19 | 08:21 | x64      |
| Execpackagetask.dll                          | 2015.131.5292.0 | 166480    | 12-Mar-19 | 08:21 | x64      |
| Flatfiledest.dll                             | 2015.131.5292.0 | 389200    | 12-Mar-19 | 08:21 | x64      |
| Flatfilesrc.dll                              | 2015.131.5292.0 | 401488    | 12-Mar-19 | 08:21 | x64      |
| Foreachfileenumerator.dll                    | 2015.131.5292.0 | 96336     | 12-Mar-19 | 08:21 | x64      |
| Hkengperfctrs.dll                            | 2015.131.5292.0 | 58968     | 12-Mar-19 | 08:23 | x64      |
| Logread.exe                                  | 2015.131.5292.0 | 626768    | 12-Mar-19 | 08:21 | x64      |
| Microsoft.analysisservices.applocal.core.dll | 13.0.5292.0     | 1313880   | 12-Mar-19 | 08:18 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll | 13.0.5292.0     | 391768    | 12-Mar-19 | 08:21 | x86      |
| Microsoft.sqlserver.replication.dll          | 2015.131.5292.0 | 1651288   | 12-Mar-19 | 08:19 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5292.0 | 150104    | 12-Mar-19 | 08:19 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5292.0 | 158808    | 12-Mar-19 | 08:19 | x64      |
| Msdtssrvrutil.dll                            | 2015.131.5292.0 | 101456    | 12-Mar-19 | 08:21 | x64      |
| Msxmlsql.dll                                 | 2015.131.5292.0 | 1494616   | 12-Mar-19 | 08:23 | x64      |
| Oledbdest.dll                                | 2015.131.5292.0 | 264272    | 12-Mar-19 | 08:21 | x64      |
| Oledbsrc.dll                                 | 2015.131.5292.0 | 290896    | 12-Mar-19 | 08:21 | x64      |
| Osql.exe                                     | 2015.131.5292.0 | 75344     | 12-Mar-19 | 08:21 | x64      |
| Rawdest.dll                                  | 2015.131.5292.0 | 209488    | 12-Mar-19 | 08:21 | x64      |
| Rawsource.dll                                | 2015.131.5292.0 | 196688    | 12-Mar-19 | 08:21 | x64      |
| Rdistcom.dll                                 | 2015.131.5292.0 | 906832    | 12-Mar-19 | 08:21 | x64      |
| Recordsetdest.dll                            | 2015.131.5292.0 | 186960    | 12-Mar-19 | 08:21 | x64      |
| Repldp.dll                                   | 2015.131.5292.0 | 281680    | 12-Mar-19 | 08:21 | x64      |
| Replprov.dll                                 | 2015.131.5292.0 | 812112    | 12-Mar-19 | 08:21 | x64      |
| Replrec.dll                                  | 2015.131.5292.0 | 1018968   | 12-Mar-19 | 08:19 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2015.131.5292.0 | 100432    | 12-Mar-19 | 08:21 | x64      |
| Sqlcmd.exe                                   | 2015.131.5292.0 | 249424    | 12-Mar-19 | 08:21 | x64      |
| Sqldiag.exe                                  | 2015.131.5292.0 | 1257552   | 12-Mar-19 | 08:21 | x64      |
| Sqllogship.exe                               | 13.0.5292.0     | 104736    | 12-Mar-19 | 08:18 | x64      |
| Sqlresld.dll                                 | 2015.131.5292.0 | 28960     | 12-Mar-19 | 08:18 | x86      |
| Sqlresld.dll                                 | 2015.131.5292.0 | 30808     | 12-Mar-19 | 08:19 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5292.0 | 28448     | 12-Mar-19 | 08:18 | x86      |
| Sqlresourceloader.dll                        | 2015.131.5292.0 | 30808     | 12-Mar-19 | 08:19 | x64      |
| Sqlscm.dll                                   | 2015.131.5292.0 | 53024     | 12-Mar-19 | 08:18 | x86      |
| Sqlscm.dll                                   | 2015.131.5292.0 | 61016     | 12-Mar-19 | 08:23 | x64      |
| Sqlsvc.dll                                   | 2015.131.5292.0 | 127288    | 12-Mar-19 | 08:18 | x86      |
| Sqlsvc.dll                                   | 2015.131.5292.0 | 152152    | 12-Mar-19 | 08:19 | x64      |
| Sqltaskconnections.dll                       | 2015.131.5292.0 | 180824    | 12-Mar-19 | 08:19 | x64      |
| Sqlwep130.dll                                | 2015.131.5292.0 | 105560    | 12-Mar-19 | 08:19 | x64      |
| Ssisoledb.dll                                | 2015.131.5292.0 | 216144    | 12-Mar-19 | 08:19 | x64      |
| Txagg.dll                                    | 2015.131.5292.0 | 364632    | 12-Mar-19 | 08:19 | x64      |
| Txbdd.dll                                    | 2015.131.5292.0 | 172632    | 12-Mar-19 | 08:19 | x64      |
| Txdatacollector.dll                          | 2015.131.5292.0 | 367704    | 12-Mar-19 | 08:19 | x64      |
| Txdataconvert.dll                            | 2015.131.5292.0 | 296536    | 12-Mar-19 | 08:19 | x64      |
| Txderived.dll                                | 2015.131.5292.0 | 607832    | 12-Mar-19 | 08:19 | x64      |
| Txlookup.dll                                 | 2015.131.5292.0 | 532056    | 12-Mar-19 | 08:19 | x64      |
| Txmerge.dll                                  | 2015.131.5292.0 | 230488    | 12-Mar-19 | 08:19 | x64      |
| Txmergejoin.dll                              | 2015.131.5292.0 | 278616    | 12-Mar-19 | 08:19 | x64      |
| Txmulticast.dll                              | 2015.131.5292.0 | 128088    | 12-Mar-19 | 08:19 | x64      |
| Txrowcount.dll                               | 2015.131.5292.0 | 126552    | 12-Mar-19 | 08:19 | x64      |
| Txsort.dll                                   | 2015.131.5292.0 | 259160    | 12-Mar-19 | 08:19 | x64      |
| Txsplit.dll                                  | 2015.131.5292.0 | 600664    | 12-Mar-19 | 08:19 | x64      |
| Txunionall.dll                               | 2015.131.5292.0 | 181848    | 12-Mar-19 | 08:19 | x64      |
| Xe.dll                                       | 2015.131.5292.0 | 626264    | 12-Mar-19 | 08:23 | x64      |
| Xmlrw.dll                                    | 2015.131.5292.0 | 319064    | 12-Mar-19 | 08:23 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.131.5292.0 | 1014864   | 12-Mar-19 | 08:21 | x64      |
| Sql_extensibility_keyfile.dll | 2015.131.5292.0 | 100432    | 12-Mar-19 | 08:21 | x64      |
| Sqlsatellite.dll              | 2015.131.5292.0 | 837208    | 12-Mar-19 | 08:23 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2015.131.5292.0 | 660056    | 12-Mar-19 | 08:23 | x64      |
| Fdhost.exe               | 2015.131.5292.0 | 105040    | 12-Mar-19 | 08:21 | x64      |
| Fdlauncher.exe           | 2015.131.5292.0 | 51280     | 12-Mar-19 | 08:21 | x64      |
| Sql_fulltext_keyfile.dll | 2015.131.5292.0 | 100432    | 12-Mar-19 | 08:21 | x64      |
| Sqlft130ph.dll           | 2015.131.5292.0 | 57936     | 12-Mar-19 | 08:23 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.5292.0     | 23640     | 12-Mar-19 | 08:18 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.131.5292.0 | 100432    | 12-Mar-19 | 08:21 | x64      |

SQL Server 2016 Integration Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll              | 4.0.0.111       | 77944     | 11-Mar-19 | 23:02 | x86      |
| Attunity.sqlserver.cdccontroltask.dll              | 4.0.0.111       | 77944     | 11-Mar-19 | 23:02 | x86      |
| Attunity.sqlserver.cdcsplit.dll                    | 4.0.0.111       | 37496     | 11-Mar-19 | 23:02 | x86      |
| Attunity.sqlserver.cdcsplit.dll                    | 4.0.0.111       | 37496     | 11-Mar-19 | 23:02 | x86      |
| Attunity.sqlserver.cdcsrc.dll                      | 4.0.0.111       | 78456     | 11-Mar-19 | 23:02 | x86      |
| Attunity.sqlserver.cdcsrc.dll                      | 4.0.0.111       | 78456     | 11-Mar-19 | 23:02 | x86      |
| Commanddest.dll                                    | 2015.131.5292.0 | 203040    | 12-Mar-19 | 08:18 | x86      |
| Commanddest.dll                                    | 2015.131.5292.0 | 248912    | 12-Mar-19 | 08:21 | x64      |
| Dteparse.dll                                       | 2015.131.5292.0 | 99616     | 12-Mar-19 | 08:18 | x86      |
| Dteparse.dll                                       | 2015.131.5292.0 | 109648    | 12-Mar-19 | 08:21 | x64      |
| Dteparsemgd.dll                                    | 2015.131.5292.0 | 88664     | 12-Mar-19 | 08:18 | x64      |
| Dteparsemgd.dll                                    | 2015.131.5292.0 | 83536     | 12-Mar-19 | 08:18 | x86      |
| Dtepkg.dll                                         | 2015.131.5292.0 | 116000    | 12-Mar-19 | 08:18 | x86      |
| Dtepkg.dll                                         | 2015.131.5292.0 | 137296    | 12-Mar-19 | 08:21 | x64      |
| Dtexec.exe                                         | 2015.131.5292.0 | 66848     | 12-Mar-19 | 08:18 | x86      |
| Dtexec.exe                                         | 2015.131.5292.0 | 72784     | 12-Mar-19 | 08:21 | x64      |
| Dts.dll                                            | 2015.131.5292.0 | 2632992   | 12-Mar-19 | 08:18 | x86      |
| Dts.dll                                            | 2015.131.5292.0 | 3146832   | 12-Mar-19 | 08:21 | x64      |
| Dtscomexpreval.dll                                 | 2015.131.5292.0 | 419104    | 12-Mar-19 | 08:18 | x86      |
| Dtscomexpreval.dll                                 | 2015.131.5292.0 | 477264    | 12-Mar-19 | 08:21 | x64      |
| Dtsconn.dll                                        | 2015.131.5292.0 | 392480    | 12-Mar-19 | 08:18 | x86      |
| Dtsconn.dll                                        | 2015.131.5292.0 | 492624    | 12-Mar-19 | 08:21 | x64      |
| Dtsdebughost.exe                                   | 2015.131.5292.0 | 93984     | 12-Mar-19 | 08:18 | x86      |
| Dtsdebughost.exe                                   | 2015.131.5292.0 | 109648    | 12-Mar-19 | 08:21 | x64      |
| Dtshost.exe                                        | 2015.131.5292.0 | 76576     | 12-Mar-19 | 08:18 | x86      |
| Dtshost.exe                                        | 2015.131.5292.0 | 86608     | 12-Mar-19 | 08:21 | x64      |
| Dtslog.dll                                         | 2015.131.5292.0 | 103200    | 12-Mar-19 | 08:18 | x86      |
| Dtslog.dll                                         | 2015.131.5292.0 | 120400    | 12-Mar-19 | 08:21 | x64      |
| Dtsmsg130.dll                                      | 2015.131.5292.0 | 541472    | 12-Mar-19 | 08:18 | x86      |
| Dtsmsg130.dll                                      | 2015.131.5292.0 | 545360    | 12-Mar-19 | 08:21 | x64      |
| Dtspipeline.dll                                    | 2015.131.5292.0 | 1059616   | 12-Mar-19 | 08:18 | x86      |
| Dtspipeline.dll                                    | 2015.131.5292.0 | 1279056   | 12-Mar-19 | 08:21 | x64      |
| Dtspipelineperf130.dll                             | 2015.131.5292.0 | 42272     | 12-Mar-19 | 08:18 | x86      |
| Dtspipelineperf130.dll                             | 2015.131.5292.0 | 48208     | 12-Mar-19 | 08:21 | x64      |
| Dtuparse.dll                                       | 2015.131.5292.0 | 80160     | 12-Mar-19 | 08:18 | x86      |
| Dtuparse.dll                                       | 2015.131.5292.0 | 87632     | 12-Mar-19 | 08:21 | x64      |
| Dtutil.exe                                         | 2015.131.5292.0 | 115488    | 12-Mar-19 | 08:18 | x86      |
| Dtutil.exe                                         | 2015.131.5292.0 | 134736    | 12-Mar-19 | 08:21 | x64      |
| Exceldest.dll                                      | 2015.131.5292.0 | 216864    | 12-Mar-19 | 08:18 | x86      |
| Exceldest.dll                                      | 2015.131.5292.0 | 263248    | 12-Mar-19 | 08:21 | x64      |
| Excelsrc.dll                                       | 2015.131.5292.0 | 232736    | 12-Mar-19 | 08:18 | x86      |
| Excelsrc.dll                                       | 2015.131.5292.0 | 285264    | 12-Mar-19 | 08:21 | x64      |
| Execpackagetask.dll                                | 2015.131.5292.0 | 135456    | 12-Mar-19 | 08:18 | x86      |
| Execpackagetask.dll                                | 2015.131.5292.0 | 166480    | 12-Mar-19 | 08:21 | x64      |
| Flatfiledest.dll                                   | 2015.131.5292.0 | 334624    | 12-Mar-19 | 08:18 | x86      |
| Flatfiledest.dll                                   | 2015.131.5292.0 | 389200    | 12-Mar-19 | 08:21 | x64      |
| Flatfilesrc.dll                                    | 2015.131.5292.0 | 345376    | 12-Mar-19 | 08:18 | x86      |
| Flatfilesrc.dll                                    | 2015.131.5292.0 | 401488    | 12-Mar-19 | 08:21 | x64      |
| Foreachfileenumerator.dll                          | 2015.131.5292.0 | 80680     | 12-Mar-19 | 08:18 | x86      |
| Foreachfileenumerator.dll                          | 2015.131.5292.0 | 96336     | 12-Mar-19 | 08:21 | x64      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5292.0     | 1313880   | 12-Mar-19 | 08:18 | x86      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5292.0     | 1313872   | 12-Mar-19 | 08:18 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 06-Jul-18 | 22:33 | x86      |
| Microsoft.sqlserver.astasks.dll                    | 13.0.5292.0     | 73296     | 12-Mar-19 | 08:21 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5292.0 | 107296    | 12-Mar-19 | 08:18 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5292.0 | 112208    | 12-Mar-19 | 08:21 | x64      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5292.0     | 82520     | 12-Mar-19 | 08:19 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5292.0     | 82512     | 12-Mar-19 | 01:20 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll       | 13.0.5292.0     | 391768    | 12-Mar-19 | 08:21 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5292.0 | 139040    | 12-Mar-19 | 08:18 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5292.0 | 150104    | 12-Mar-19 | 08:19 | x64      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5292.0 | 144672    | 12-Mar-19 | 08:18 | x86      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5292.0 | 158808    | 12-Mar-19 | 08:19 | x64      |
| Msdtssrvr.exe                                      | 13.0.5292.0     | 216864    | 12-Mar-19 | 08:18 | x64      |
| Msdtssrvrutil.dll                                  | 2015.131.5292.0 | 90192     | 12-Mar-19 | 08:18 | x86      |
| Msdtssrvrutil.dll                                  | 2015.131.5292.0 | 101456    | 12-Mar-19 | 08:21 | x64      |
| Oledbdest.dll                                      | 2015.131.5292.0 | 216656    | 12-Mar-19 | 08:18 | x86      |
| Oledbdest.dll                                      | 2015.131.5292.0 | 264272    | 12-Mar-19 | 08:21 | x64      |
| Oledbsrc.dll                                       | 2015.131.5292.0 | 235600    | 12-Mar-19 | 08:18 | x86      |
| Oledbsrc.dll                                       | 2015.131.5292.0 | 290896    | 12-Mar-19 | 08:21 | x64      |
| Rawdest.dll                                        | 2015.131.5292.0 | 168528    | 12-Mar-19 | 08:18 | x86      |
| Rawdest.dll                                        | 2015.131.5292.0 | 209488    | 12-Mar-19 | 08:21 | x64      |
| Rawsource.dll                                      | 2015.131.5292.0 | 155216    | 12-Mar-19 | 08:18 | x86      |
| Rawsource.dll                                      | 2015.131.5292.0 | 196688    | 12-Mar-19 | 08:21 | x64      |
| Recordsetdest.dll                                  | 2015.131.5292.0 | 151632    | 12-Mar-19 | 08:18 | x86      |
| Recordsetdest.dll                                  | 2015.131.5292.0 | 186960    | 12-Mar-19 | 08:21 | x64      |
| Sql_is_keyfile.dll                                 | 2015.131.5292.0 | 100432    | 12-Mar-19 | 08:21 | x64      |
| Sqlceip.exe                                        | 13.0.5292.0     | 256288    | 12-Mar-19 | 08:18 | x86      |
| Sqldest.dll                                        | 2015.131.5292.0 | 215840    | 12-Mar-19 | 08:18 | x86      |
| Sqldest.dll                                        | 2015.131.5292.0 | 263760    | 12-Mar-19 | 08:21 | x64      |
| Sqltaskconnections.dll                             | 2015.131.5292.0 | 151328    | 12-Mar-19 | 08:18 | x86      |
| Sqltaskconnections.dll                             | 2015.131.5292.0 | 180824    | 12-Mar-19 | 08:19 | x64      |
| Ssisoledb.dll                                      | 2015.131.5292.0 | 176928    | 12-Mar-19 | 08:18 | x86      |
| Ssisoledb.dll                                      | 2015.131.5292.0 | 216144    | 12-Mar-19 | 08:19 | x64      |
| Txagg.dll                                          | 2015.131.5292.0 | 364632    | 12-Mar-19 | 08:19 | x64      |
| Txagg.dll                                          | 2015.131.5292.0 | 304728    | 12-Mar-19 | 08:21 | x86      |
| Txbdd.dll                                          | 2015.131.5292.0 | 172632    | 12-Mar-19 | 08:19 | x64      |
| Txbdd.dll                                          | 2015.131.5292.0 | 137816    | 12-Mar-19 | 08:21 | x86      |
| Txbestmatch.dll                                    | 2015.131.5292.0 | 611416    | 12-Mar-19 | 08:19 | x64      |
| Txbestmatch.dll                                    | 2015.131.5292.0 | 496216    | 12-Mar-19 | 08:21 | x86      |
| Txcache.dll                                        | 2015.131.5292.0 | 183384    | 12-Mar-19 | 08:19 | x64      |
| Txcache.dll                                        | 2015.131.5292.0 | 148056    | 12-Mar-19 | 08:21 | x86      |
| Txcharmap.dll                                      | 2015.131.5292.0 | 289880    | 12-Mar-19 | 08:19 | x64      |
| Txcharmap.dll                                      | 2015.131.5292.0 | 250456    | 12-Mar-19 | 08:21 | x86      |
| Txcopymap.dll                                      | 2015.131.5292.0 | 182872    | 12-Mar-19 | 08:19 | x64      |
| Txcopymap.dll                                      | 2015.131.5292.0 | 147544    | 12-Mar-19 | 08:21 | x86      |
| Txdataconvert.dll                                  | 2015.131.5292.0 | 296536    | 12-Mar-19 | 08:19 | x64      |
| Txdataconvert.dll                                  | 2015.131.5292.0 | 255064    | 12-Mar-19 | 08:21 | x86      |
| Txderived.dll                                      | 2015.131.5292.0 | 607832    | 12-Mar-19 | 08:19 | x64      |
| Txderived.dll                                      | 2015.131.5292.0 | 519256    | 12-Mar-19 | 08:21 | x86      |
| Txfileextractor.dll                                | 2015.131.5292.0 | 201816    | 12-Mar-19 | 08:19 | x64      |
| Txfileextractor.dll                                | 2015.131.5292.0 | 162904    | 12-Mar-19 | 08:21 | x86      |
| Txfileinserter.dll                                 | 2015.131.5292.0 | 199768    | 12-Mar-19 | 08:19 | x64      |
| Txfileinserter.dll                                 | 2015.131.5292.0 | 160856    | 12-Mar-19 | 08:21 | x86      |
| Txgroupdups.dll                                    | 2015.131.5292.0 | 290904    | 12-Mar-19 | 08:19 | x64      |
| Txgroupdups.dll                                    | 2015.131.5292.0 | 231512    | 12-Mar-19 | 08:21 | x86      |
| Txlineage.dll                                      | 2015.131.5292.0 | 137816    | 12-Mar-19 | 08:19 | x64      |
| Txlineage.dll                                      | 2015.131.5292.0 | 109656    | 12-Mar-19 | 08:21 | x86      |
| Txlookup.dll                                       | 2015.131.5292.0 | 532056    | 12-Mar-19 | 08:19 | x64      |
| Txlookup.dll                                       | 2015.131.5292.0 | 449624    | 12-Mar-19 | 08:21 | x86      |
| Txmerge.dll                                        | 2015.131.5292.0 | 230488    | 12-Mar-19 | 08:19 | x64      |
| Txmerge.dll                                        | 2015.131.5292.0 | 176728    | 12-Mar-19 | 08:21 | x86      |
| Txmergejoin.dll                                    | 2015.131.5292.0 | 278616    | 12-Mar-19 | 08:19 | x64      |
| Txmergejoin.dll                                    | 2015.131.5292.0 | 223832    | 12-Mar-19 | 08:21 | x86      |
| Txmulticast.dll                                    | 2015.131.5292.0 | 128088    | 12-Mar-19 | 08:19 | x64      |
| Txmulticast.dll                                    | 2015.131.5292.0 | 101976    | 12-Mar-19 | 08:21 | x86      |
| Txpivot.dll                                        | 2015.131.5292.0 | 227928    | 12-Mar-19 | 08:19 | x64      |
| Txpivot.dll                                        | 2015.131.5292.0 | 181848    | 12-Mar-19 | 08:21 | x86      |
| Txrowcount.dll                                     | 2015.131.5292.0 | 126552    | 12-Mar-19 | 08:19 | x64      |
| Txrowcount.dll                                     | 2015.131.5292.0 | 101464    | 12-Mar-19 | 08:21 | x86      |
| Txsampling.dll                                     | 2015.131.5292.0 | 172120    | 12-Mar-19 | 08:19 | x64      |
| Txsampling.dll                                     | 2015.131.5292.0 | 134744    | 12-Mar-19 | 08:21 | x86      |
| Txscd.dll                                          | 2015.131.5292.0 | 220248    | 12-Mar-19 | 08:19 | x64      |
| Txscd.dll                                          | 2015.131.5292.0 | 169560    | 12-Mar-19 | 08:21 | x86      |
| Txsort.dll                                         | 2015.131.5292.0 | 259160    | 12-Mar-19 | 08:19 | x64      |
| Txsort.dll                                         | 2015.131.5292.0 | 211032    | 12-Mar-19 | 08:21 | x86      |
| Txsplit.dll                                        | 2015.131.5292.0 | 600664    | 12-Mar-19 | 08:19 | x64      |
| Txsplit.dll                                        | 2015.131.5292.0 | 513112    | 12-Mar-19 | 08:21 | x86      |
| Txtermextraction.dll                               | 2015.131.5292.0 | 8677976   | 12-Mar-19 | 08:19 | x64      |
| Txtermextraction.dll                               | 2015.131.5292.0 | 8615512   | 12-Mar-19 | 08:21 | x86      |
| Txtermlookup.dll                                   | 2015.131.5292.0 | 4158552   | 12-Mar-19 | 08:19 | x64      |
| Txtermlookup.dll                                   | 2015.131.5292.0 | 4106840   | 12-Mar-19 | 08:21 | x86      |
| Txunionall.dll                                     | 2015.131.5292.0 | 181848    | 12-Mar-19 | 08:19 | x64      |
| Txunionall.dll                                     | 2015.131.5292.0 | 138840    | 12-Mar-19 | 08:21 | x86      |
| Txunpivot.dll                                      | 2015.131.5292.0 | 201816    | 12-Mar-19 | 08:19 | x64      |
| Txunpivot.dll                                      | 2015.131.5292.0 | 162392    | 12-Mar-19 | 08:21 | x86      |
| Xe.dll                                             | 2015.131.5292.0 | 558672    | 12-Mar-19 | 08:19 | x86      |
| Xe.dll                                             | 2015.131.5292.0 | 626264    | 12-Mar-19 | 08:23 | x64      |

SQL Server 2016 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 10.0.8224.47     | 483408    | 12-Dec-18 | 03:25 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.47 | 75344     | 12-Dec-18 | 03:25 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.47     | 45648     | 12-Dec-18 | 03:25 | x86      |
| Instapi130.dll                                                       | 2015.131.5292.0  | 61016     | 12-Mar-19 | 08:19 | x64      |
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
| Mpdwinterop.dll                                                      | 2015.131.5292.0  | 394840    | 12-Mar-19 | 08:23 | x64      |
| Mpdwsvc.exe                                                          | 2015.131.5292.0  | 6618192   | 12-Mar-19 | 08:21 | x64      |
| Pdwodbcsql11.dll                                                     | 2015.131.5292.0  | 2229848   | 12-Mar-19 | 08:19 | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.47 | 47184     | 12-Dec-18 | 03:26 | x64      |
| Sqldk.dll                                                            | 2015.131.5292.0  | 2532440   | 12-Mar-19 | 08:19 | x64      |
| Sqldumper.exe                                                        | 2015.131.5292.0  | 127056    | 12-Mar-19 | 08:21 | x64      |
| Sqlos.dll                                                            | 2015.131.5292.0  | 26200     | 12-Mar-19 | 08:19 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.47 | 4347984   | 12-Dec-18 | 03:26 | x64      |
| Sqltses.dll                                                          | 2015.131.5292.0  | 9092696   | 12-Mar-19 | 08:19 | x64      |

SQL Server 2016 Reporting Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.modeling.dll                   | 13.0.5292.0     | 610904    | 12-Mar-19 | 08:18 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.5292.0     | 1620056   | 12-Mar-19 | 08:18 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.5292.0     | 329816    | 12-Mar-19 | 08:18 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.5292.0     | 1090648   | 12-Mar-19 | 08:18 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5292.0     | 548432    | 12-Mar-19 | 08:19 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5292.0     | 548440    | 12-Mar-19 | 08:18 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5292.0     | 548432    | 12-Mar-19 | 08:20 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5292.0     | 548432    | 12-Mar-19 | 08:21 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5292.0     | 548432    | 12-Mar-19 | 08:21 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5292.0     | 548432    | 12-Mar-19 | 08:19 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5292.0     | 548440    | 12-Mar-19 | 08:23 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5292.0     | 548440    | 12-Mar-19 | 08:22 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5292.0     | 548440    | 12-Mar-19 | 08:22 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5292.0     | 548440    | 12-Mar-19 | 08:20 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.5292.0     | 162904    | 12-Mar-19 | 08:18 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.5292.0     | 126032    | 12-Mar-19 | 08:21 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.5292.0     | 6076496   | 12-Mar-19 | 08:21 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5292.0     | 4511312   | 12-Mar-19 | 08:19 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5292.0     | 4511832   | 12-Mar-19 | 08:18 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5292.0     | 4511824   | 12-Mar-19 | 08:20 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5292.0     | 4511824   | 12-Mar-19 | 08:21 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5292.0     | 4512336   | 12-Mar-19 | 08:21 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5292.0     | 4512336   | 12-Mar-19 | 08:19 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5292.0     | 4511832   | 12-Mar-19 | 08:23 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5292.0     | 4512856   | 12-Mar-19 | 08:22 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5292.0     | 4511320   | 12-Mar-19 | 08:22 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5292.0     | 4511832   | 12-Mar-19 | 08:20 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.5292.0     | 10893904  | 12-Mar-19 | 08:21 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.5292.0     | 101152    | 12-Mar-19 | 08:18 | x64      |
| Microsoft.reportingservices.storage.dll                   | 13.0.5292.0     | 208464    | 12-Mar-19 | 08:21 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.131.5292.0 | 47696     | 12-Mar-19 | 08:21 | x64      |
| Msmdlocal.dll                                             | 2015.131.5292.0 | 37101648  | 12-Mar-19 | 08:18 | x86      |
| Msmdlocal.dll                                             | 2015.131.5292.0 | 56208464  | 12-Mar-19 | 08:21 | x64      |
| Msmgdsrv.dll                                              | 2015.131.5292.0 | 6507608   | 12-Mar-19 | 08:18 | x86      |
| Msmgdsrv.dll                                              | 2015.131.5292.0 | 7507032   | 12-Mar-19 | 08:19 | x64      |
| Msolap130.dll                                             | 2015.131.5292.0 | 7008336   | 12-Mar-19 | 08:18 | x86      |
| Msolap130.dll                                             | 2015.131.5292.0 | 8639568   | 12-Mar-19 | 08:21 | x64      |
| Msolui130.dll                                             | 2015.131.5292.0 | 287312    | 12-Mar-19 | 08:18 | x86      |
| Msolui130.dll                                             | 2015.131.5292.0 | 310352    | 12-Mar-19 | 08:21 | x64      |
| Reportingservicescompression.dll                          | 2015.131.5292.0 | 62544     | 12-Mar-19 | 08:21 | x64      |
| Reportingserviceslibrary.dll                              | 13.0.5292.0     | 2543704   | 12-Mar-19 | 08:19 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.131.5292.0 | 114264    | 12-Mar-19 | 08:18 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.131.5292.0 | 108632    | 12-Mar-19 | 08:19 | x64      |
| Reportingservicesnativeserver.dll                         | 2015.131.5292.0 | 98904     | 12-Mar-19 | 08:19 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.5292.0     | 2728536   | 12-Mar-19 | 08:19 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5292.0     | 884304    | 12-Mar-19 | 08:21 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5292.0     | 888408    | 12-Mar-19 | 08:21 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5292.0     | 888400    | 12-Mar-19 | 08:21 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5292.0     | 888408    | 12-Mar-19 | 08:21 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5292.0     | 892504    | 12-Mar-19 | 08:23 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5292.0     | 888408    | 12-Mar-19 | 08:24 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5292.0     | 888400    | 12-Mar-19 | 08:20 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5292.0     | 900696    | 12-Mar-19 | 08:22 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5292.0     | 884312    | 12-Mar-19 | 08:21 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5292.0     | 888408    | 12-Mar-19 | 08:22 | x86      |
| Rshttpruntime.dll                                         | 2015.131.5292.0 | 99416     | 12-Mar-19 | 08:19 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.131.5292.0 | 100432    | 12-Mar-19 | 08:21 | x64      |
| Sqldumper.exe                                             | 2015.131.5292.0 | 107808    | 12-Mar-19 | 08:18 | x86      |
| Sqldumper.exe                                             | 2015.131.5292.0 | 127056    | 12-Mar-19 | 08:21 | x64      |
| Sqlrsos.dll                                               | 2015.131.5292.0 | 26200     | 12-Mar-19 | 08:19 | x64      |
| Sqlserverspatial130.dll                                   | 2015.131.5292.0 | 584480    | 12-Mar-19 | 08:18 | x86      |
| Sqlserverspatial130.dll                                   | 2015.131.5292.0 | 732760    | 12-Mar-19 | 08:23 | x64      |
| Xmlrw.dll                                                 | 2015.131.5292.0 | 259672    | 12-Mar-19 | 08:21 | x86      |
| Xmlrw.dll                                                 | 2015.131.5292.0 | 319064    | 12-Mar-19 | 08:23 | x64      |
| Xmlrwbin.dll                                              | 2015.131.5292.0 | 191576    | 12-Mar-19 | 08:21 | x86      |
| Xmlrwbin.dll                                              | 2015.131.5292.0 | 227416    | 12-Mar-19 | 08:23 | x64      |
| Xmsrv.dll                                                 | 2015.131.5292.0 | 24050776  | 12-Mar-19 | 08:19 | x64      |
| Xmsrv.dll                                                 | 2015.131.5292.0 | 32727640  | 12-Mar-19 | 08:21 | x86      |

SQL Server 2016 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.5292.0     | 23640     | 12-Mar-19 | 08:19 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.131.5292.0 | 100432    | 12-Mar-19 | 08:21 | x64      |

SQL Server 2016 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                  | 2015.131.5292.0 | 1312032   | 12-Mar-19 | 08:18 | x86      |
| Ddsshapes.dll                                  | 2015.131.5292.0 | 135968    | 12-Mar-19 | 08:18 | x86      |
| Dtaengine.exe                                  | 2015.131.5292.0 | 167200    | 12-Mar-19 | 08:18 | x86      |
| Dteparse.dll                                   | 2015.131.5292.0 | 99616     | 12-Mar-19 | 08:18 | x86      |
| Dteparse.dll                                   | 2015.131.5292.0 | 109648    | 12-Mar-19 | 08:21 | x64      |
| Dteparsemgd.dll                                | 2015.131.5292.0 | 88664     | 12-Mar-19 | 08:18 | x64      |
| Dteparsemgd.dll                                | 2015.131.5292.0 | 83536     | 12-Mar-19 | 08:18 | x86      |
| Dtepkg.dll                                     | 2015.131.5292.0 | 116000    | 12-Mar-19 | 08:18 | x86      |
| Dtepkg.dll                                     | 2015.131.5292.0 | 137296    | 12-Mar-19 | 08:21 | x64      |
| Dtexec.exe                                     | 2015.131.5292.0 | 66848     | 12-Mar-19 | 08:18 | x86      |
| Dtexec.exe                                     | 2015.131.5292.0 | 72784     | 12-Mar-19 | 08:21 | x64      |
| Dts.dll                                        | 2015.131.5292.0 | 2632992   | 12-Mar-19 | 08:18 | x86      |
| Dts.dll                                        | 2015.131.5292.0 | 3146832   | 12-Mar-19 | 08:21 | x64      |
| Dtscomexpreval.dll                             | 2015.131.5292.0 | 419104    | 12-Mar-19 | 08:18 | x86      |
| Dtscomexpreval.dll                             | 2015.131.5292.0 | 477264    | 12-Mar-19 | 08:21 | x64      |
| Dtsconn.dll                                    | 2015.131.5292.0 | 392480    | 12-Mar-19 | 08:18 | x86      |
| Dtsconn.dll                                    | 2015.131.5292.0 | 492624    | 12-Mar-19 | 08:21 | x64      |
| Dtshost.exe                                    | 2015.131.5292.0 | 76576     | 12-Mar-19 | 08:18 | x86      |
| Dtshost.exe                                    | 2015.131.5292.0 | 86608     | 12-Mar-19 | 08:21 | x64      |
| Dtslog.dll                                     | 2015.131.5292.0 | 103200    | 12-Mar-19 | 08:18 | x86      |
| Dtslog.dll                                     | 2015.131.5292.0 | 120400    | 12-Mar-19 | 08:21 | x64      |
| Dtsmsg130.dll                                  | 2015.131.5292.0 | 541472    | 12-Mar-19 | 08:18 | x86      |
| Dtsmsg130.dll                                  | 2015.131.5292.0 | 545360    | 12-Mar-19 | 08:21 | x64      |
| Dtspipeline.dll                                | 2015.131.5292.0 | 1059616   | 12-Mar-19 | 08:18 | x86      |
| Dtspipeline.dll                                | 2015.131.5292.0 | 1279056   | 12-Mar-19 | 08:21 | x64      |
| Dtspipelineperf130.dll                         | 2015.131.5292.0 | 42272     | 12-Mar-19 | 08:18 | x86      |
| Dtspipelineperf130.dll                         | 2015.131.5292.0 | 48208     | 12-Mar-19 | 08:21 | x64      |
| Dtuparse.dll                                   | 2015.131.5292.0 | 80160     | 12-Mar-19 | 08:18 | x86      |
| Dtuparse.dll                                   | 2015.131.5292.0 | 87632     | 12-Mar-19 | 08:21 | x64      |
| Dtutil.exe                                     | 2015.131.5292.0 | 115488    | 12-Mar-19 | 08:18 | x86      |
| Dtutil.exe                                     | 2015.131.5292.0 | 134736    | 12-Mar-19 | 08:21 | x64      |
| Exceldest.dll                                  | 2015.131.5292.0 | 216864    | 12-Mar-19 | 08:18 | x86      |
| Exceldest.dll                                  | 2015.131.5292.0 | 263248    | 12-Mar-19 | 08:21 | x64      |
| Excelsrc.dll                                   | 2015.131.5292.0 | 232736    | 12-Mar-19 | 08:18 | x86      |
| Excelsrc.dll                                   | 2015.131.5292.0 | 285264    | 12-Mar-19 | 08:21 | x64      |
| Flatfiledest.dll                               | 2015.131.5292.0 | 334624    | 12-Mar-19 | 08:18 | x86      |
| Flatfiledest.dll                               | 2015.131.5292.0 | 389200    | 12-Mar-19 | 08:21 | x64      |
| Flatfilesrc.dll                                | 2015.131.5292.0 | 345376    | 12-Mar-19 | 08:18 | x86      |
| Flatfilesrc.dll                                | 2015.131.5292.0 | 401488    | 12-Mar-19 | 08:21 | x64      |
| Foreachfileenumerator.dll                      | 2015.131.5292.0 | 80680     | 12-Mar-19 | 08:18 | x86      |
| Foreachfileenumerator.dll                      | 2015.131.5292.0 | 96336     | 12-Mar-19 | 08:21 | x64      |
| Microsoft.analysisservices.adomdclientui.dll   | 13.0.5292.0     | 92240     | 12-Mar-19 | 08:18 | x86      |
| Microsoft.analysisservices.applocal.core.dll   | 13.0.5292.0     | 1313872   | 12-Mar-19 | 08:18 | x86      |
| Microsoft.analysisservices.project.dll         | 2015.131.5292.0 | 2023200   | 12-Mar-19 | 08:18 | x86      |
| Microsoft.analysisservices.projectui.dll       | 2015.131.5292.0 | 42064     | 12-Mar-19 | 08:19 | x86      |
| Microsoft.sqlserver.astasks.dll                | 13.0.5292.0     | 73504     | 12-Mar-19 | 08:18 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5292.0     | 436000    | 12-Mar-19 | 08:18 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5292.0     | 435792    | 12-Mar-19 | 08:21 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5292.0     | 2044704   | 12-Mar-19 | 08:18 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5292.0     | 2044496   | 12-Mar-19 | 08:21 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5292.0 | 139040    | 12-Mar-19 | 08:18 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5292.0 | 150104    | 12-Mar-19 | 08:19 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5292.0 | 144672    | 12-Mar-19 | 08:18 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5292.0 | 158808    | 12-Mar-19 | 08:19 | x64      |
| Msdtssrvrutil.dll                              | 2015.131.5292.0 | 90192     | 12-Mar-19 | 08:18 | x86      |
| Msdtssrvrutil.dll                              | 2015.131.5292.0 | 101456    | 12-Mar-19 | 08:21 | x64      |
| Msmdlocal.dll                                  | 2015.131.5292.0 | 37101648  | 12-Mar-19 | 08:18 | x86      |
| Msmdlocal.dll                                  | 2015.131.5292.0 | 56208464  | 12-Mar-19 | 08:21 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5292.0 | 6507608   | 12-Mar-19 | 08:18 | x86      |
| Msmgdsrv.dll                                   | 2015.131.5292.0 | 7507032   | 12-Mar-19 | 08:19 | x64      |
| Msolap130.dll                                  | 2015.131.5292.0 | 7008336   | 12-Mar-19 | 08:18 | x86      |
| Msolap130.dll                                  | 2015.131.5292.0 | 8639568   | 12-Mar-19 | 08:21 | x64      |
| Msolui130.dll                                  | 2015.131.5292.0 | 287312    | 12-Mar-19 | 08:18 | x86      |
| Msolui130.dll                                  | 2015.131.5292.0 | 310352    | 12-Mar-19 | 08:21 | x64      |
| Oledbdest.dll                                  | 2015.131.5292.0 | 216656    | 12-Mar-19 | 08:18 | x86      |
| Oledbdest.dll                                  | 2015.131.5292.0 | 264272    | 12-Mar-19 | 08:21 | x64      |
| Oledbsrc.dll                                   | 2015.131.5292.0 | 235600    | 12-Mar-19 | 08:18 | x86      |
| Oledbsrc.dll                                   | 2015.131.5292.0 | 290896    | 12-Mar-19 | 08:21 | x64      |
| Profiler.exe                                   | 2015.131.5292.0 | 804432    | 12-Mar-19 | 08:18 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.131.5292.0 | 100432    | 12-Mar-19 | 08:21 | x64      |
| Sqldumper.exe                                  | 2015.131.5292.0 | 107808    | 12-Mar-19 | 08:18 | x86      |
| Sqldumper.exe                                  | 2015.131.5292.0 | 127056    | 12-Mar-19 | 08:21 | x64      |
| Sqlresld.dll                                   | 2015.131.5292.0 | 28960     | 12-Mar-19 | 08:18 | x86      |
| Sqlresld.dll                                   | 2015.131.5292.0 | 30808     | 12-Mar-19 | 08:19 | x64      |
| Sqlresourceloader.dll                          | 2015.131.5292.0 | 28448     | 12-Mar-19 | 08:18 | x86      |
| Sqlresourceloader.dll                          | 2015.131.5292.0 | 30808     | 12-Mar-19 | 08:19 | x64      |
| Sqlscm.dll                                     | 2015.131.5292.0 | 53024     | 12-Mar-19 | 08:18 | x86      |
| Sqlscm.dll                                     | 2015.131.5292.0 | 61016     | 12-Mar-19 | 08:23 | x64      |
| Sqlsvc.dll                                     | 2015.131.5292.0 | 127288    | 12-Mar-19 | 08:18 | x86      |
| Sqlsvc.dll                                     | 2015.131.5292.0 | 152152    | 12-Mar-19 | 08:19 | x64      |
| Sqltaskconnections.dll                         | 2015.131.5292.0 | 151328    | 12-Mar-19 | 08:18 | x86      |
| Sqltaskconnections.dll                         | 2015.131.5292.0 | 180824    | 12-Mar-19 | 08:19 | x64      |
| Txdataconvert.dll                              | 2015.131.5292.0 | 296536    | 12-Mar-19 | 08:19 | x64      |
| Txdataconvert.dll                              | 2015.131.5292.0 | 255064    | 12-Mar-19 | 08:21 | x86      |
| Xe.dll                                         | 2015.131.5292.0 | 558672    | 12-Mar-19 | 08:19 | x86      |
| Xe.dll                                         | 2015.131.5292.0 | 626264    | 12-Mar-19 | 08:23 | x64      |
| Xmlrw.dll                                      | 2015.131.5292.0 | 259672    | 12-Mar-19 | 08:21 | x86      |
| Xmlrw.dll                                      | 2015.131.5292.0 | 319064    | 12-Mar-19 | 08:23 | x64      |
| Xmlrwbin.dll                                   | 2015.131.5292.0 | 191576    | 12-Mar-19 | 08:21 | x86      |
| Xmlrwbin.dll                                   | 2015.131.5292.0 | 227416    | 12-Mar-19 | 08:23 | x64      |
| Xmsrv.dll                                      | 2015.131.5292.0 | 24050776  | 12-Mar-19 | 08:19 | x64      |
| Xmsrv.dll                                      | 2015.131.5292.0 | 32727640  | 12-Mar-19 | 08:21 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
