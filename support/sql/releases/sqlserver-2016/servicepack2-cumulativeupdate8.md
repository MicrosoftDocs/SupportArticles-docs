---
title: Cumulative update 8 for SQL Server 2016 SP2 (KB4505830)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 Service Pack 2 (SP2) cumulative update 8 (KB4505830).
ms.date: 10/26/2023
ms.custom: KB4505830
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Express
- SQL Server 2016 Web
---

# KB4505830 - Cumulative Update 8 for SQL Server 2016 SP2

_Release Date:_ &nbsp; July 31, 2019  
_Version:_ &nbsp; 13.0.5426.0

> [!NOTE]
> Due to a change made in SQL Server 2016 SP2 CU8 , any single-stripe TDE compressed backups taken on SQL Server 2016 SP2 through SQL Server 2016 SP2 CU4 will not be able to be restored on SQL Server 2016 SP2 CU8 . Downgrade to the previous CU in order to restore these backups. This issue will be fixed in a future CU.

This article describes Cumulative Update package 8 (CU8) (build number: **13.0.5426.0**) for Microsoft SQL Server 2016 Service Pack 2 (SP2). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the initial release of SQL Server 2016 SP2.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---|---|---|
| <a id="12975677">[12975677](#12975677)</a> | [FIX: DAX query requires more than 200 times of memory than the size of the database in SQL Server 2016 and 2017 multidimensional model database (KB4503385)](https://support.microsoft.com/help/4503385) | Analysis Services |
| <a id="12991696">[12991696](#12991696)</a> | [FIX: Data processing is much slower in SSAS 2016 SP2 than in SSAS 2016 SP1 (KB4508621)](https://support.microsoft.com/help/4508621) | Analysis Services |
| <a id="13031076">[13031076](#13031076)</a> | [FIX: Multidimensional mode randomly crashes and an access violation occurs in SQL Server 2016 (KB4512821)](https://support.microsoft.com/help/4512821) | Analysis Services |
| <a id="12740272">[12740272](#12740272)</a> | [FIX: Internal thread deadlock occurs on secondary replica of availability group in SQL Server 2016 SP2 and 2017 (KB4513236)](https://support.microsoft.com/help/4513236) | High Availability |
| <a id="12987669">[12987669](#12987669)</a> | [FIX: Memory dumps generate when access violation occurs in SQL Server 2016 (KB4511834)](https://support.microsoft.com/help/4511834) | High Availability |
| <a id="12928930">[12928930](#12928930)</a> | [Improvement: Allow altering external data source in APS in SQL Server 2016 (KB4504511)](https://support.microsoft.com/help/4504511) | SQL Engine |
| <a id="12414933">[12414933](#12414933)</a> | [FIX: Encryption scan task triggered upon the startup of a database may be canceled in SQL Server 2016 (KB4466107)](https://support.microsoft.com/help/4466107) | SQL Engine |
| <a id="12519852">[12519852](#12519852)</a> | [FIX: Peer-to-peer replication fails in SQL Server 2016 if the host name isn't uppercase (KB4469600)](https://support.microsoft.com/help/4469600) | SQL Engine |
| <a id="12680774">[12680774](#12680774)</a> | [FIX: Error 409 occurs when you back up databases by using BackuptoURL (KB4511868)](https://support.microsoft.com/help/4511868) | SQL Engine |
| <a id="12737583">[12737583](#12737583)</a> | [FIX: Assertion dump occurs when you select a view on a linked server in SQL Server 2016 and 2017 (KB4503417)](https://support.microsoft.com/help/4503417) | SQL Engine |
| <a id="12912746">[12912746](#12912746)</a> | [FIX: Filled transaction log causes outages when you run Query Store in SQL Server 2016 and 2017 (KB4511715)](https://support.microsoft.com/help/4511715) | SQL Engine |
| <a id="12917911">[12917911](#12917911)</a> | [FIX: "No valid credentials provided" occurs after you restart PolyBase in SQL Server 2016 and 2017 (KB4502658)](https://support.microsoft.com/help/4502658) | SQL Engine |
| <a id="12918636">[12918636](#12918636)</a> | [FIX: Access violation occurs when you enable TF 3924 to clean orphaned DTC transactions in SQL Server 2016 (KB4511816)](https://support.microsoft.com/help/4511816) | SQL Engine |
| <a id="12929260">[12929260](#12929260)</a> | [FIX: Access Violation occurs when you use LOG function with a remote query in SQL Server 2016 or 2017 (KB4512151)](https://support.microsoft.com/help/4512151) | SQL Engine |
| <a id="12930344">[12930344](#12930344)</a> | [FIX: Querying sys.tables returns temporary tables created by concurrent users starting from SQL Server 2012 (KB4512956)](https://support.microsoft.com/help/4512956) | SQL Engine |
| <a id="12931722">[12931722](#12931722)</a> | [FIX: Azure Site Recovery and other VSS jobs may report failures on servers hosting SQL Server 2016 instances (KB4519682)](https://support.microsoft.com/help/4519682) | SQL Engine |
| <a id="12933051">[12933051](#12933051)</a> | [FIX: "Non-yielding Scheduler" occurs when you run queries with batch-mode hash join and/or sort in SQL Server 2016 (KB4512567)](https://support.microsoft.com/help/4512567) | SQL Engine |
| <a id="12944542">[12944542](#12944542)</a> | [FIX: Slow performance occurs as CMEMTHREAD waiting occurs due to temporary table cachestore memory object contention in SQL Server 2016 and 2017 (KB4578496)](https://support.microsoft.com/help/4578496) | SQL Engine |
| <a id="12949750">[12949750](#12949750)</a> | [FIX: Geocentric Datum of Australia 2020 is added to SQL Server 2016 (KB4506023)](https://support.microsoft.com/help/4506023) | SQL Engine |
| <a id="12964579">[12964579](#12964579)</a> | [FIX: Concurrent Inserts into a CCI can cause deadlock under memory pressure in SQL Server 2016 (KB4506912)](https://support.microsoft.com/help/4506912) | SQL Engine |
| <a id="12969908">[12969908](#12969908)</a> | [FIX: Access violation error occurs when SQL Server 2016 uses hash join, hash aggregate, sort or window function in batch-mode plan in the deadlock monitor (KB4511751)](https://support.microsoft.com/help/4511751) | SQL Engine |
| <a id="12970135">[12970135](#12970135)</a> | [FIX: Restore or RESTORE VERIFYONLY of a TDE-compressed backup fails in SQL Server 2016 and 2017 (KB4513097)](https://support.microsoft.com/help/4513097) | SQL Engine |
| <a id="13010511">[13010511](#13010511)</a> | [FIX: Intermittent "row not found" error at Azure SQL DB Subscriber caused by duplication of BEGIN TRAN statements (KB4508472)](https://support.microsoft.com/help/4508472) | SQL Engine |
| <a id="13011771">[13011771](#13011771)</a> | [FIX: Azure storage I/O subsystem may not reset transfer details for a failed I/O resulting in backup errors (KB4513099)](https://support.microsoft.com/help/4513099) | SQL Engine |
| <a id="13015911">[13015911](#13015911)</a> | [FIX: Error 9003 occurs when you back up a database on a secondary replica in Microsoft SQL Server 2016 (KB4513238)](https://support.microsoft.com/help/4513238) | SQL Engine |
| <a id="13017913">[13017913](#13017913)</a> | [FIX: Prolonged non-transactional usage of FileTable without instance restart may cause non-yielding scheduler error or server crash in SQL Server 2014, 2016 and 2017 (KB4510934)](https://support.microsoft.com/help/4510934) | SQL Engine |
| <a id="13044398">[13044398](#13044398)</a> | [FIX: Assertion error occurs when SQL Server 2016 uses hash join, hash aggregate, sort or window function in batch-mode plan (KB4512558)](https://support.microsoft.com/help/4512558) | SQL Engine |
| <a id="13049762">[13049762](#13049762)</a> | [FIX: Syscommittab cleanup causes a lock escalation that will block the syscommittab flush in SQL Server 2016 (KB4512016)](https://support.microsoft.com/help/4512016) | SQL Engine |
| <a id="12883565">[12883565](#12883565)</a> | [FIX: DBCC SHOW_STATISTICS permission check fails with an AV error in SQL Server 2016 and 2017 (KB4511593)](https://support.microsoft.com/help/4511593) | SQL performance |
| <a id="12963177">[12963177](#12963177)</a> | [FIX: Data masking may not be applied when you use PIVOT or UNPIVOT function on masked column in SQL Server 2016 and 2017 (KB4512130)](https://support.microsoft.com/help/4512130) | SQL security |

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
| Instapi130.dll | 2015.131.5426.0 | 53368     | 22-Jul-19 | 06:58 | x86      |
| Keyfile.dll    | 2015.131.5426.0 | 88688     | 22-Jul-19 | 07:02 | x86      |
| Sqlbrowser.exe | 2015.131.5426.0 | 276808    | 22-Jul-19 | 06:57 | x86      |
| Sqldumper.exe  | 2015.131.5426.0 | 107848    | 22-Jul-19 | 06:57 | x86      |

SQL Server 2016 Writer

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi130.dll        | 2015.131.5426.0 | 61048     | 22-Jul-19 | 06:59 | x64      |
| Sqlboot.dll           | 2015.131.5426.0 | 186488    | 22-Jul-19 | 06:59 | x64      |
| Sqldumper.exe         | 2015.131.5426.0 | 127088    | 22-Jul-19 | 07:00 | x64      |
| Sqlvdi.dll            | 2015.131.5426.0 | 168568    | 22-Jul-19 | 06:59 | x86      |
| Sqlvdi.dll            | 2015.131.5426.0 | 197240    | 22-Jul-19 | 06:59 | x64      |
| Sqlwriter.exe         | 2015.131.5426.0 | 131904    | 22-Jul-19 | 06:58 | x64      |
| Sqlwriter_keyfile.dll | 2015.131.5426.0 | 100472    | 22-Jul-19 | 07:00 | x64      |
| Sqlwvss.dll           | 2015.131.5426.0 | 346736    | 22-Jul-19 | 06:50 | x64      |
| Sqlwvss_xp.dll        | 2015.131.5426.0 | 26224     | 22-Jul-19 | 06:50 | x64      |

SQL Server 2016 Analysis Services

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.server.core.dll | 13.0.5426.0     | 1348216   | 22-Jul-19 | 06:59 | x86      |
| Microsoft.applicationinsights.dll          | 2.7.0.13435     | 329872    | 06-Jul-18 | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5426.0     | 990328    | 22-Jul-19 | 06:58 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5426.0     | 990328    | 22-Jul-19 | 07:00 | x86      |
| Msmdctr130.dll                             | 2015.131.5426.0 | 40056     | 22-Jul-19 | 07:00 | x64      |
| Msmdlocal.dll                              | 2015.131.5426.0 | 56245360  | 22-Jul-19 | 07:00 | x64      |
| Msmdlocal.dll                              | 2015.131.5426.0 | 37129032  | 22-Jul-19 | 07:01 | x86      |
| Msmdsrv.exe                                | 2015.131.5426.0 | 56789104  | 22-Jul-19 | 07:00 | x64      |
| Msmgdsrv.dll                               | 2015.131.5426.0 | 7509624   | 22-Jul-19 | 06:58 | x64      |
| Msmgdsrv.dll                               | 2015.131.5426.0 | 6508656   | 22-Jul-19 | 07:03 | x86      |
| Msolap130.dll                              | 2015.131.5426.0 | 8643184   | 22-Jul-19 | 07:00 | x64      |
| Msolap130.dll                              | 2015.131.5426.0 | 7010632   | 22-Jul-19 | 07:01 | x86      |
| Msolui130.dll                              | 2015.131.5426.0 | 310392    | 22-Jul-19 | 06:59 | x64      |
| Msolui130.dll                              | 2015.131.5426.0 | 287560    | 22-Jul-19 | 07:01 | x86      |
| Sql_as_keyfile.dll                         | 2015.131.5426.0 | 100472    | 22-Jul-19 | 07:00 | x64      |
| Sqlboot.dll                                | 2015.131.5426.0 | 186488    | 22-Jul-19 | 06:59 | x64      |
| Sqlceip.exe                                | 13.0.5426.0     | 256112    | 22-Jul-19 | 07:00 | x86      |
| Sqldumper.exe                              | 2015.131.5426.0 | 107848    | 22-Jul-19 | 06:57 | x86      |
| Sqldumper.exe                              | 2015.131.5426.0 | 127088    | 22-Jul-19 | 07:00 | x64      |
| Tmapi.dll                                  | 2015.131.5426.0 | 4345968   | 22-Jul-19 | 06:50 | x64      |
| Tmcachemgr.dll                             | 2015.131.5426.0 | 2826864   | 22-Jul-19 | 06:50 | x64      |
| Tmpersistence.dll                          | 2015.131.5426.0 | 1071216   | 22-Jul-19 | 06:50 | x64      |
| Tmtransactions.dll                         | 2015.131.5426.0 | 1352304   | 22-Jul-19 | 06:50 | x64      |
| Xe.dll                                     | 2015.131.5426.0 | 626288    | 22-Jul-19 | 07:00 | x64      |
| Xmlrw.dll                                  | 2015.131.5426.0 | 319096    | 22-Jul-19 | 06:59 | x64      |
| Xmlrw.dll                                  | 2015.131.5426.0 | 259936    | 22-Jul-19 | 07:01 | x86      |
| Xmlrwbin.dll                               | 2015.131.5426.0 | 227448    | 22-Jul-19 | 06:59 | x64      |
| Xmlrwbin.dll                               | 2015.131.5426.0 | 191600    | 22-Jul-19 | 07:01 | x86      |
| Xmsrv.dll                                  | 2015.131.5426.0 | 24051824  | 22-Jul-19 | 06:50 | x64      |
| Xmsrv.dll                                  | 2015.131.5426.0 | 32727904  | 22-Jul-19 | 07:01 | x86      |

SQL Server 2016 Database Services Common Core

|                  File name                  |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                             | 2015.131.5426.0 | 160584    | 22-Jul-19 | 06:57 | x86      |
| Batchparser.dll                             | 2015.131.5426.0 | 180856    | 22-Jul-19 | 06:59 | x64      |
| Instapi130.dll                              | 2015.131.5426.0 | 53368     | 22-Jul-19 | 06:58 | x86      |
| Instapi130.dll                              | 2015.131.5426.0 | 61048     | 22-Jul-19 | 06:59 | x64      |
| Isacctchange.dll                            | 2015.131.5426.0 | 29504     | 22-Jul-19 | 06:57 | x86      |
| Isacctchange.dll                            | 2015.131.5426.0 | 30840     | 22-Jul-19 | 07:00 | x64      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5426.0     | 1027704   | 22-Jul-19 | 07:00 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5426.0     | 1027912   | 22-Jul-19 | 07:02 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.5426.0     | 1348936   | 22-Jul-19 | 07:02 | x86      |
| Microsoft.analysisservices.dll              | 13.0.5426.0     | 702792    | 22-Jul-19 | 07:01 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.5426.0     | 765552    | 22-Jul-19 | 07:01 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.5426.0     | 520816    | 22-Jul-19 | 07:01 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5426.0     | 711800    | 22-Jul-19 | 06:59 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5426.0     | 711792    | 22-Jul-19 | 07:01 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5426.0 | 72816     | 22-Jul-19 | 07:00 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5426.0 | 75376     | 22-Jul-19 | 07:01 | x64      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5426.0     | 569456    | 22-Jul-19 | 07:00 | x86      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5426.0     | 569456    | 22-Jul-19 | 07:03 | x86      |
| Msasxpress.dll                              | 2015.131.5426.0 | 35960     | 22-Jul-19 | 06:59 | x64      |
| Msasxpress.dll                              | 2015.131.5426.0 | 32072     | 22-Jul-19 | 07:01 | x86      |
| Pbsvcacctsync.dll                           | 2015.131.5426.0 | 72824     | 22-Jul-19 | 06:59 | x64      |
| Pbsvcacctsync.dll                           | 2015.131.5426.0 | 60232     | 22-Jul-19 | 07:01 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.131.5426.0 | 100472    | 22-Jul-19 | 07:00 | x64      |
| Sqldumper.exe                               | 2015.131.5426.0 | 107848    | 22-Jul-19 | 06:57 | x86      |
| Sqldumper.exe                               | 2015.131.5426.0 | 127088    | 22-Jul-19 | 07:00 | x64      |
| Sqlftacct.dll                               | 2015.131.5426.0 | 46712     | 22-Jul-19 | 06:59 | x86      |
| Sqlftacct.dll                               | 2015.131.5426.0 | 51832     | 22-Jul-19 | 06:59 | x64      |
| Sqlmgmprovider.dll                          | 2015.131.5426.0 | 406128    | 22-Jul-19 | 06:50 | x64      |
| Sqlmgmprovider.dll                          | 2015.131.5426.0 | 365680    | 22-Jul-19 | 07:00 | x86      |
| Sqlsecacctchg.dll                           | 2015.131.5426.0 | 37488     | 22-Jul-19 | 06:50 | x64      |
| Sqlsecacctchg.dll                           | 2015.131.5426.0 | 34936     | 22-Jul-19 | 06:59 | x86      |
| Sqltdiagn.dll                               | 2015.131.5426.0 | 67696     | 22-Jul-19 | 06:50 | x64      |
| Sqltdiagn.dll                               | 2015.131.5426.0 | 60536     | 22-Jul-19 | 06:59 | x86      |

SQL Server 2016 sql_dreplay_client

|            File name           |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2015.131.5426.0 | 120952    | 22-Jul-19 | 06:58 | x86      |
| Dreplaycommon.dll              | 2015.131.5426.0 | 691016    | 22-Jul-19 | 07:02 | x86      |
| Dreplayutil.dll                | 2015.131.5426.0 | 310088    | 22-Jul-19 | 06:57 | x86      |
| Instapi130.dll                 | 2015.131.5426.0 | 61048     | 22-Jul-19 | 06:59 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.131.5426.0 | 100472    | 22-Jul-19 | 07:00 | x64      |
| Sqlresourceloader.dll          | 2015.131.5426.0 | 28280     | 22-Jul-19 | 06:59 | x86      |

SQL Server 2016 sql_dreplay_controller

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2015.131.5426.0 | 691016    | 22-Jul-19 | 07:02 | x86      |
| Dreplaycontroller.exe              | 2015.131.5426.0 | 350536    | 22-Jul-19 | 06:57 | x86      |
| Dreplayprocess.dll                 | 2015.131.5426.0 | 171848    | 22-Jul-19 | 06:57 | x86      |
| Instapi130.dll                     | 2015.131.5426.0 | 61048     | 22-Jul-19 | 06:59 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.131.5426.0 | 100472    | 22-Jul-19 | 07:00 | x64      |
| Sqlresourceloader.dll              | 2015.131.5426.0 | 28280     | 22-Jul-19 | 06:59 | x86      |

SQL Server 2016 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Backuptourl.exe                              | 13.0.5426.0     | 41288     | 22-Jul-19 | 06:58 | x64      |
| Batchparser.dll                              | 2015.131.5426.0 | 180856    | 22-Jul-19 | 06:59 | x64      |
| Datacollectorcontroller.dll                  | 2015.131.5426.0 | 225400    | 22-Jul-19 | 07:00 | x64      |
| Dcexec.exe                                   | 2015.131.5426.0 | 74568     | 22-Jul-19 | 06:58 | x64      |
| Fssres.dll                                   | 2015.131.5426.0 | 81528     | 22-Jul-19 | 07:00 | x64      |
| Hadrres.dll                                  | 2015.131.5426.0 | 177784    | 22-Jul-19 | 06:59 | x64      |
| Hkcompile.dll                                | 2015.131.5426.0 | 1298040   | 22-Jul-19 | 06:59 | x64      |
| Hkengine.dll                                 | 2015.131.5426.0 | 5600888   | 22-Jul-19 | 06:59 | x64      |
| Hkruntime.dll                                | 2015.131.5426.0 | 158832    | 22-Jul-19 | 07:00 | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 06-Jul-18 | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.5426.0     | 234336    | 22-Jul-19 | 07:02 | x86      |
| Microsoft.sqlserver.types.dll                | 2015.131.5426.0 | 392816    | 22-Jul-19 | 07:00 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.131.5426.0 | 72312     | 22-Jul-19 | 06:59 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.131.5426.0 | 65136     | 22-Jul-19 | 07:01 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5426.0 | 150368    | 22-Jul-19 | 07:02 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5426.0 | 159048    | 22-Jul-19 | 07:01 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.131.5426.0 | 272200    | 22-Jul-19 | 07:01 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.131.5426.0 | 74864     | 22-Jul-19 | 07:01 | x64      |
| Odsole70.dll                                 | 2015.131.5426.0 | 92784     | 22-Jul-19 | 06:59 | x64      |
| Opends60.dll                                 | 2015.131.5426.0 | 32888     | 22-Jul-19 | 06:59 | x64      |
| Qds.dll                                      | 2015.131.5426.0 | 873592    | 22-Jul-19 | 07:00 | x64      |
| Rsfxft.dll                                   | 2015.131.5426.0 | 34424     | 22-Jul-19 | 06:59 | x64      |
| Sqagtres.dll                                 | 2015.131.5426.0 | 64632     | 22-Jul-19 | 06:59 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.131.5426.0 | 100472    | 22-Jul-19 | 07:00 | x64      |
| Sqlaamss.dll                                 | 2015.131.5426.0 | 80712     | 22-Jul-19 | 06:57 | x64      |
| Sqlaccess.dll                                | 2015.131.5426.0 | 463176    | 22-Jul-19 | 07:02 | x64      |
| Sqlagent.exe                                 | 2015.131.5426.0 | 566600    | 22-Jul-19 | 06:58 | x64      |
| Sqlagentctr130.dll                           | 2015.131.5426.0 | 52040     | 22-Jul-19 | 06:57 | x64      |
| Sqlagentctr130.dll                           | 2015.131.5426.0 | 44152     | 22-Jul-19 | 06:59 | x86      |
| Sqlagentlog.dll                              | 2015.131.5426.0 | 32888     | 22-Jul-19 | 06:59 | x64      |
| Sqlagentmail.dll                             | 2015.131.5426.0 | 47960     | 22-Jul-19 | 06:58 | x64      |
| Sqlboot.dll                                  | 2015.131.5426.0 | 186488    | 22-Jul-19 | 06:59 | x64      |
| Sqlceip.exe                                  | 13.0.5426.0     | 256112    | 22-Jul-19 | 07:00 | x86      |
| Sqlcmdss.dll                                 | 2015.131.5426.0 | 60024     | 22-Jul-19 | 06:59 | x64      |
| Sqldk.dll                                    | 2015.131.5426.0 | 2588280   | 22-Jul-19 | 07:00 | x64      |
| Sqldtsss.dll                                 | 2015.131.5426.0 | 97608     | 22-Jul-19 | 06:58 | x64      |
| Sqliosim.com                                 | 2015.131.5426.0 | 308032    | 22-Jul-19 | 06:58 | x64      |
| Sqliosim.exe                                 | 2015.131.5426.0 | 3014264   | 22-Jul-19 | 06:59 | x64      |
| Sqllang.dll                                  | 2015.131.5426.0 | 39536752  | 22-Jul-19 | 07:00 | x64      |
| Sqlmin.dll                                   | 2015.131.5426.0 | 37914736  | 22-Jul-19 | 06:50 | x64      |
| Sqlolapss.dll                                | 2015.131.5426.0 | 98120     | 22-Jul-19 | 06:58 | x64      |
| Sqlos.dll                                    | 2015.131.5426.0 | 26232     | 22-Jul-19 | 06:59 | x64      |
| Sqlpowershellss.dll                          | 2015.131.5426.0 | 58480     | 22-Jul-19 | 06:50 | x64      |
| Sqlrepss.dll                                 | 2015.131.5426.0 | 54896     | 22-Jul-19 | 06:50 | x64      |
| Sqlresld.dll                                 | 2015.131.5426.0 | 30832     | 22-Jul-19 | 06:50 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5426.0 | 30832     | 22-Jul-19 | 06:50 | x64      |
| Sqlscm.dll                                   | 2015.131.5426.0 | 61048     | 22-Jul-19 | 06:59 | x64      |
| Sqlscriptdowngrade.dll                       | 2015.131.5426.0 | 27760     | 22-Jul-19 | 06:50 | x64      |
| Sqlscriptupgrade.dll                         | 2015.131.5426.0 | 5808760   | 22-Jul-19 | 06:59 | x64      |
| Sqlserverspatial130.dll                      | 2015.131.5426.0 | 732792    | 22-Jul-19 | 06:59 | x64      |
| Sqlservr.exe                                 | 2015.131.5426.0 | 393024    | 22-Jul-19 | 06:57 | x64      |
| Sqlsvc.dll                                   | 2015.131.5426.0 | 152176    | 22-Jul-19 | 06:50 | x64      |
| Sqltses.dll                                  | 2015.131.5426.0 | 8923760   | 22-Jul-19 | 06:50 | x64      |
| Sqsrvres.dll                                 | 2015.131.5426.0 | 250992    | 22-Jul-19 | 06:50 | x64      |
| Xe.dll                                       | 2015.131.5426.0 | 626288    | 22-Jul-19 | 07:00 | x64      |
| Xmlrw.dll                                    | 2015.131.5426.0 | 319096    | 22-Jul-19 | 06:59 | x64      |
| Xmlrwbin.dll                                 | 2015.131.5426.0 | 227448    | 22-Jul-19 | 06:59 | x64      |
| Xpadsi.exe                                   | 2015.131.5426.0 | 79176     | 22-Jul-19 | 07:01 | x64      |
| Xplog70.dll                                  | 2015.131.5426.0 | 65656     | 22-Jul-19 | 06:59 | x64      |
| Xpsqlbot.dll                                 | 2015.131.5426.0 | 33400     | 22-Jul-19 | 06:59 | x64      |
| Xpstar.dll                                   | 2015.131.5426.0 | 422520    | 22-Jul-19 | 06:59 | x64      |

SQL Server 2016 Database Services Core Shared

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2015.131.5426.0 | 160584    | 22-Jul-19 | 06:57 | x86      |
| Batchparser.dll                              | 2015.131.5426.0 | 180856    | 22-Jul-19 | 06:59 | x64      |
| Bcp.exe                                      | 2015.131.5426.0 | 119920    | 22-Jul-19 | 07:00 | x64      |
| Commanddest.dll                              | 2015.131.5426.0 | 248944    | 22-Jul-19 | 07:00 | x64      |
| Datacollectorenumerators.dll                 | 2015.131.5426.0 | 115832    | 22-Jul-19 | 07:00 | x64      |
| Datacollectortasks.dll                       | 2015.131.5426.0 | 188016    | 22-Jul-19 | 07:00 | x64      |
| Distrib.exe                                  | 2015.131.5426.0 | 191096    | 22-Jul-19 | 06:58 | x64      |
| Dteparse.dll                                 | 2015.131.5426.0 | 109688    | 22-Jul-19 | 07:00 | x64      |
| Dteparsemgd.dll                              | 2015.131.5426.0 | 88696     | 22-Jul-19 | 06:59 | x64      |
| Dtepkg.dll                                   | 2015.131.5426.0 | 137336    | 22-Jul-19 | 07:00 | x64      |
| Dtexec.exe                                   | 2015.131.5426.0 | 73024     | 22-Jul-19 | 06:58 | x64      |
| Dts.dll                                      | 2015.131.5426.0 | 3146864   | 22-Jul-19 | 07:00 | x64      |
| Dtscomexpreval.dll                           | 2015.131.5426.0 | 477304    | 22-Jul-19 | 07:00 | x64      |
| Dtsconn.dll                                  | 2015.131.5426.0 | 492664    | 22-Jul-19 | 07:00 | x64      |
| Dtshost.exe                                  | 2015.131.5426.0 | 86856     | 22-Jul-19 | 06:58 | x64      |
| Dtslog.dll                                   | 2015.131.5426.0 | 120440    | 22-Jul-19 | 07:00 | x64      |
| Dtsmsg130.dll                                | 2015.131.5426.0 | 545400    | 22-Jul-19 | 07:00 | x64      |
| Dtspipeline.dll                              | 2015.131.5426.0 | 1279096   | 22-Jul-19 | 07:00 | x64      |
| Dtspipelineperf130.dll                       | 2015.131.5426.0 | 48240     | 22-Jul-19 | 07:00 | x64      |
| Dtuparse.dll                                 | 2015.131.5426.0 | 87672     | 22-Jul-19 | 07:00 | x64      |
| Dtutil.exe                                   | 2015.131.5426.0 | 134984    | 22-Jul-19 | 06:57 | x64      |
| Exceldest.dll                                | 2015.131.5426.0 | 263288    | 22-Jul-19 | 07:00 | x64      |
| Excelsrc.dll                                 | 2015.131.5426.0 | 285304    | 22-Jul-19 | 07:00 | x64      |
| Execpackagetask.dll                          | 2015.131.5426.0 | 166520    | 22-Jul-19 | 07:00 | x64      |
| Flatfiledest.dll                             | 2015.131.5426.0 | 389240    | 22-Jul-19 | 07:00 | x64      |
| Flatfilesrc.dll                              | 2015.131.5426.0 | 401528    | 22-Jul-19 | 07:00 | x64      |
| Foreachfileenumerator.dll                    | 2015.131.5426.0 | 96376     | 22-Jul-19 | 07:00 | x64      |
| Hkengperfctrs.dll                            | 2015.131.5426.0 | 59000     | 22-Jul-19 | 06:59 | x64      |
| Logread.exe                                  | 2015.131.5426.0 | 626808    | 22-Jul-19 | 07:00 | x64      |
| Microsoft.analysisservices.applocal.core.dll | 13.0.5426.0     | 1313912   | 22-Jul-19 | 06:59 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll | 13.0.5426.0     | 391792    | 22-Jul-19 | 07:00 | x86      |
| Microsoft.sqlserver.replication.dll          | 2015.131.5426.0 | 1651528   | 22-Jul-19 | 07:01 | x64      |
| Microsoft.sqlserver.rmo.dll                  | 13.0.5426.0     | 569456    | 22-Jul-19 | 07:00 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5426.0 | 150368    | 22-Jul-19 | 07:02 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5426.0 | 159048    | 22-Jul-19 | 07:01 | x64      |
| Msdtssrvrutil.dll                            | 2015.131.5426.0 | 101496    | 22-Jul-19 | 06:59 | x64      |
| Msxmlsql.dll                                 | 2015.131.5426.0 | 1494648   | 22-Jul-19 | 06:59 | x64      |
| Oledbdest.dll                                | 2015.131.5426.0 | 264312    | 22-Jul-19 | 07:00 | x64      |
| Oledbsrc.dll                                 | 2015.131.5426.0 | 290936    | 22-Jul-19 | 06:59 | x64      |
| Osql.exe                                     | 2015.131.5426.0 | 75376     | 22-Jul-19 | 07:00 | x64      |
| Rawdest.dll                                  | 2015.131.5426.0 | 209528    | 22-Jul-19 | 06:59 | x64      |
| Rawsource.dll                                | 2015.131.5426.0 | 196728    | 22-Jul-19 | 06:59 | x64      |
| Rdistcom.dll                                 | 2015.131.5426.0 | 907384    | 22-Jul-19 | 07:00 | x64      |
| Recordsetdest.dll                            | 2015.131.5426.0 | 187000    | 22-Jul-19 | 06:59 | x64      |
| Repldp.dll                                   | 2015.131.5426.0 | 281720    | 22-Jul-19 | 07:00 | x64      |
| Replmerg.exe                                 | 2015.131.5426.0 | 518984    | 22-Jul-19 | 06:58 | x64      |
| Replprov.dll                                 | 2015.131.5426.0 | 812152    | 22-Jul-19 | 07:00 | x64      |
| Replrec.dll                                  | 2015.131.5426.0 | 1019208   | 22-Jul-19 | 06:58 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2015.131.5426.0 | 100472    | 22-Jul-19 | 07:00 | x64      |
| Sqlcmd.exe                                   | 2015.131.5426.0 | 249456    | 22-Jul-19 | 07:00 | x64      |
| Sqldiag.exe                                  | 2015.131.5426.0 | 1257592   | 22-Jul-19 | 06:59 | x64      |
| Sqllogship.exe                               | 13.0.5426.0     | 104560    | 22-Jul-19 | 07:00 | x64      |
| Sqlresld.dll                                 | 2015.131.5426.0 | 30832     | 22-Jul-19 | 06:50 | x64      |
| Sqlresld.dll                                 | 2015.131.5426.0 | 28792     | 22-Jul-19 | 06:59 | x86      |
| Sqlresourceloader.dll                        | 2015.131.5426.0 | 30832     | 22-Jul-19 | 06:50 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5426.0 | 28280     | 22-Jul-19 | 06:59 | x86      |
| Sqlscm.dll                                   | 2015.131.5426.0 | 61048     | 22-Jul-19 | 06:59 | x64      |
| Sqlscm.dll                                   | 2015.131.5426.0 | 52856     | 22-Jul-19 | 06:59 | x86      |
| Sqlsvc.dll                                   | 2015.131.5426.0 | 152176    | 22-Jul-19 | 06:50 | x64      |
| Sqlsvc.dll                                   | 2015.131.5426.0 | 127096    | 22-Jul-19 | 06:59 | x86      |
| Sqltaskconnections.dll                       | 2015.131.5426.0 | 180848    | 22-Jul-19 | 06:50 | x64      |
| Sqlwep130.dll                                | 2015.131.5426.0 | 105584    | 22-Jul-19 | 06:50 | x64      |
| Ssisoledb.dll                                | 2015.131.5426.0 | 216176    | 22-Jul-19 | 06:50 | x64      |
| Tablediff.exe                                | 13.0.5426.0     | 86640     | 22-Jul-19 | 07:00 | x64      |
| Txagg.dll                                    | 2015.131.5426.0 | 364656    | 22-Jul-19 | 06:50 | x64      |
| Txbdd.dll                                    | 2015.131.5426.0 | 172656    | 22-Jul-19 | 06:50 | x64      |
| Txdatacollector.dll                          | 2015.131.5426.0 | 367728    | 22-Jul-19 | 06:51 | x64      |
| Txdataconvert.dll                            | 2015.131.5426.0 | 296560    | 22-Jul-19 | 06:50 | x64      |
| Txderived.dll                                | 2015.131.5426.0 | 607856    | 22-Jul-19 | 06:50 | x64      |
| Txlookup.dll                                 | 2015.131.5426.0 | 532080    | 22-Jul-19 | 06:51 | x64      |
| Txmerge.dll                                  | 2015.131.5426.0 | 230512    | 22-Jul-19 | 06:50 | x64      |
| Txmergejoin.dll                              | 2015.131.5426.0 | 278640    | 22-Jul-19 | 06:50 | x64      |
| Txmulticast.dll                              | 2015.131.5426.0 | 128112    | 22-Jul-19 | 06:50 | x64      |
| Txrowcount.dll                               | 2015.131.5426.0 | 126576    | 22-Jul-19 | 06:50 | x64      |
| Txsort.dll                                   | 2015.131.5426.0 | 259184    | 22-Jul-19 | 06:50 | x64      |
| Txsplit.dll                                  | 2015.131.5426.0 | 600688    | 22-Jul-19 | 06:50 | x64      |
| Txunionall.dll                               | 2015.131.5426.0 | 181872    | 22-Jul-19 | 06:50 | x64      |
| Xe.dll                                       | 2015.131.5426.0 | 626288    | 22-Jul-19 | 07:00 | x64      |
| Xmlrw.dll                                    | 2015.131.5426.0 | 319096    | 22-Jul-19 | 06:59 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.131.5426.0 | 1014896   | 22-Jul-19 | 07:00 | x64      |
| Sql_extensibility_keyfile.dll | 2015.131.5426.0 | 100472    | 22-Jul-19 | 07:00 | x64      |
| Sqlsatellite.dll              | 2015.131.5426.0 | 837240    | 22-Jul-19 | 06:59 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2015.131.5426.0 | 660088    | 22-Jul-19 | 06:59 | x64      |
| Fdhost.exe               | 2015.131.5426.0 | 105072    | 22-Jul-19 | 07:00 | x64      |
| Fdlauncher.exe           | 2015.131.5426.0 | 51312     | 22-Jul-19 | 07:00 | x64      |
| Sql_fulltext_keyfile.dll | 2015.131.5426.0 | 100472    | 22-Jul-19 | 07:00 | x64      |
| Sqlft130ph.dll           | 2015.131.5426.0 | 57976     | 22-Jul-19 | 06:59 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.5426.0     | 23672     | 22-Jul-19 | 06:59 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.131.5426.0 | 100472    | 22-Jul-19 | 07:00 | x64      |

SQL Server 2016 Integration Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll              | 4.0.0.111       | 77944     | 18-Jul-19 | 14:24 | x86      |
| Attunity.sqlserver.cdccontroltask.dll              | 4.0.0.111       | 77944     | 21-Jul-19 | 20:42 | x86      |
| Attunity.sqlserver.cdcsplit.dll                    | 4.0.0.111       | 37496     | 18-Jul-19 | 14:24 | x86      |
| Attunity.sqlserver.cdcsplit.dll                    | 4.0.0.111       | 37496     | 21-Jul-19 | 20:42 | x86      |
| Attunity.sqlserver.cdcsrc.dll                      | 4.0.0.111       | 78456     | 18-Jul-19 | 14:24 | x86      |
| Attunity.sqlserver.cdcsrc.dll                      | 4.0.0.111       | 78456     | 21-Jul-19 | 20:42 | x86      |
| Commanddest.dll                                    | 2015.131.5426.0 | 203080    | 22-Jul-19 | 06:57 | x86      |
| Commanddest.dll                                    | 2015.131.5426.0 | 248944    | 22-Jul-19 | 07:00 | x64      |
| Dteparse.dll                                       | 2015.131.5426.0 | 99656     | 22-Jul-19 | 06:57 | x86      |
| Dteparse.dll                                       | 2015.131.5426.0 | 109688    | 22-Jul-19 | 07:00 | x64      |
| Dteparsemgd.dll                                    | 2015.131.5426.0 | 88696     | 22-Jul-19 | 06:59 | x64      |
| Dteparsemgd.dll                                    | 2015.131.5426.0 | 83784     | 22-Jul-19 | 07:02 | x86      |
| Dtepkg.dll                                         | 2015.131.5426.0 | 116032    | 22-Jul-19 | 06:57 | x86      |
| Dtepkg.dll                                         | 2015.131.5426.0 | 137336    | 22-Jul-19 | 07:00 | x64      |
| Dtexec.exe                                         | 2015.131.5426.0 | 66888     | 22-Jul-19 | 06:57 | x86      |
| Dtexec.exe                                         | 2015.131.5426.0 | 73024     | 22-Jul-19 | 06:58 | x64      |
| Dts.dll                                            | 2015.131.5426.0 | 2633024   | 22-Jul-19 | 06:57 | x86      |
| Dts.dll                                            | 2015.131.5426.0 | 3146864   | 22-Jul-19 | 07:00 | x64      |
| Dtscomexpreval.dll                                 | 2015.131.5426.0 | 419136    | 22-Jul-19 | 06:57 | x86      |
| Dtscomexpreval.dll                                 | 2015.131.5426.0 | 477304    | 22-Jul-19 | 07:00 | x64      |
| Dtsconn.dll                                        | 2015.131.5426.0 | 392520    | 22-Jul-19 | 06:57 | x86      |
| Dtsconn.dll                                        | 2015.131.5426.0 | 492664    | 22-Jul-19 | 07:00 | x64      |
| Dtsdebughost.exe                                   | 2015.131.5426.0 | 93816     | 22-Jul-19 | 06:58 | x86      |
| Dtsdebughost.exe                                   | 2015.131.5426.0 | 109688    | 22-Jul-19 | 06:58 | x64      |
| Dtshost.exe                                        | 2015.131.5426.0 | 76608     | 22-Jul-19 | 06:57 | x86      |
| Dtshost.exe                                        | 2015.131.5426.0 | 86856     | 22-Jul-19 | 06:58 | x64      |
| Dtslog.dll                                         | 2015.131.5426.0 | 103240    | 22-Jul-19 | 06:57 | x86      |
| Dtslog.dll                                         | 2015.131.5426.0 | 120440    | 22-Jul-19 | 07:00 | x64      |
| Dtsmsg130.dll                                      | 2015.131.5426.0 | 541504    | 22-Jul-19 | 06:57 | x86      |
| Dtsmsg130.dll                                      | 2015.131.5426.0 | 545400    | 22-Jul-19 | 07:00 | x64      |
| Dtspipeline.dll                                    | 2015.131.5426.0 | 1059656   | 22-Jul-19 | 06:57 | x86      |
| Dtspipeline.dll                                    | 2015.131.5426.0 | 1279096   | 22-Jul-19 | 07:00 | x64      |
| Dtspipelineperf130.dll                             | 2015.131.5426.0 | 42328     | 22-Jul-19 | 06:57 | x86      |
| Dtspipelineperf130.dll                             | 2015.131.5426.0 | 48240     | 22-Jul-19 | 07:00 | x64      |
| Dtuparse.dll                                       | 2015.131.5426.0 | 80200     | 22-Jul-19 | 06:57 | x86      |
| Dtuparse.dll                                       | 2015.131.5426.0 | 87672     | 22-Jul-19 | 07:00 | x64      |
| Dtutil.exe                                         | 2015.131.5426.0 | 115528    | 22-Jul-19 | 06:57 | x86      |
| Dtutil.exe                                         | 2015.131.5426.0 | 134984    | 22-Jul-19 | 06:57 | x64      |
| Exceldest.dll                                      | 2015.131.5426.0 | 216896    | 22-Jul-19 | 06:57 | x86      |
| Exceldest.dll                                      | 2015.131.5426.0 | 263288    | 22-Jul-19 | 07:00 | x64      |
| Excelsrc.dll                                       | 2015.131.5426.0 | 232776    | 22-Jul-19 | 06:57 | x86      |
| Excelsrc.dll                                       | 2015.131.5426.0 | 285304    | 22-Jul-19 | 07:00 | x64      |
| Execpackagetask.dll                                | 2015.131.5426.0 | 135496    | 22-Jul-19 | 06:57 | x86      |
| Execpackagetask.dll                                | 2015.131.5426.0 | 166520    | 22-Jul-19 | 07:00 | x64      |
| Flatfiledest.dll                                   | 2015.131.5426.0 | 334664    | 22-Jul-19 | 06:57 | x86      |
| Flatfiledest.dll                                   | 2015.131.5426.0 | 389240    | 22-Jul-19 | 07:00 | x64      |
| Flatfilesrc.dll                                    | 2015.131.5426.0 | 345416    | 22-Jul-19 | 06:57 | x86      |
| Flatfilesrc.dll                                    | 2015.131.5426.0 | 401528    | 22-Jul-19 | 07:00 | x64      |
| Foreachfileenumerator.dll                          | 2015.131.5426.0 | 80712     | 22-Jul-19 | 06:57 | x86      |
| Foreachfileenumerator.dll                          | 2015.131.5426.0 | 96376     | 22-Jul-19 | 07:00 | x64      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5426.0     | 1313912   | 22-Jul-19 | 06:59 | x86      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5426.0     | 1314112   | 22-Jul-19 | 07:02 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 06-Jul-18 | 22:33 | x86      |
| Microsoft.sqlserver.astasks.dll                    | 13.0.5426.0     | 73544     | 22-Jul-19 | 07:02 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5426.0 | 107328    | 22-Jul-19 | 06:57 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5426.0 | 112456    | 22-Jul-19 | 07:02 | x64      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5426.0     | 82552     | 21-Jul-19 | 23:31 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5426.0     | 82544     | 22-Jul-19 | 07:02 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll       | 13.0.5426.0     | 391792    | 22-Jul-19 | 07:00 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5426.0 | 138864    | 22-Jul-19 | 07:01 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5426.0 | 150368    | 22-Jul-19 | 07:02 | x64      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5426.0 | 144496    | 22-Jul-19 | 07:01 | x86      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5426.0 | 159048    | 22-Jul-19 | 07:01 | x64      |
| Msdtssrvr.exe                                      | 13.0.5426.0     | 216688    | 22-Jul-19 | 07:00 | x64      |
| Msdtssrvrutil.dll                                  | 2015.131.5426.0 | 101496    | 22-Jul-19 | 06:59 | x64      |
| Msdtssrvrutil.dll                                  | 2015.131.5426.0 | 90440     | 22-Jul-19 | 07:01 | x86      |
| Oledbdest.dll                                      | 2015.131.5426.0 | 264312    | 22-Jul-19 | 07:00 | x64      |
| Oledbdest.dll                                      | 2015.131.5426.0 | 216688    | 22-Jul-19 | 07:00 | x86      |
| Oledbsrc.dll                                       | 2015.131.5426.0 | 290936    | 22-Jul-19 | 06:59 | x64      |
| Oledbsrc.dll                                       | 2015.131.5426.0 | 235632    | 22-Jul-19 | 07:00 | x86      |
| Rawdest.dll                                        | 2015.131.5426.0 | 209528    | 22-Jul-19 | 06:59 | x64      |
| Rawdest.dll                                        | 2015.131.5426.0 | 168560    | 22-Jul-19 | 07:00 | x86      |
| Rawsource.dll                                      | 2015.131.5426.0 | 196728    | 22-Jul-19 | 06:59 | x64      |
| Rawsource.dll                                      | 2015.131.5426.0 | 155464    | 22-Jul-19 | 07:01 | x86      |
| Recordsetdest.dll                                  | 2015.131.5426.0 | 187000    | 22-Jul-19 | 06:59 | x64      |
| Recordsetdest.dll                                  | 2015.131.5426.0 | 151664    | 22-Jul-19 | 07:00 | x86      |
| Sql_is_keyfile.dll                                 | 2015.131.5426.0 | 100472    | 22-Jul-19 | 07:00 | x64      |
| Sqlceip.exe                                        | 13.0.5426.0     | 256112    | 22-Jul-19 | 07:00 | x86      |
| Sqldest.dll                                        | 2015.131.5426.0 | 215672    | 22-Jul-19 | 06:59 | x86      |
| Sqldest.dll                                        | 2015.131.5426.0 | 263800    | 22-Jul-19 | 06:59 | x64      |
| Sqltaskconnections.dll                             | 2015.131.5426.0 | 180848    | 22-Jul-19 | 06:50 | x64      |
| Sqltaskconnections.dll                             | 2015.131.5426.0 | 151160    | 22-Jul-19 | 06:59 | x86      |
| Ssisoledb.dll                                      | 2015.131.5426.0 | 216176    | 22-Jul-19 | 06:50 | x64      |
| Ssisoledb.dll                                      | 2015.131.5426.0 | 176760    | 22-Jul-19 | 06:59 | x86      |
| Txagg.dll                                          | 2015.131.5426.0 | 364656    | 22-Jul-19 | 06:50 | x64      |
| Txagg.dll                                          | 2015.131.5426.0 | 304968    | 22-Jul-19 | 07:01 | x86      |
| Txbdd.dll                                          | 2015.131.5426.0 | 172656    | 22-Jul-19 | 06:50 | x64      |
| Txbdd.dll                                          | 2015.131.5426.0 | 138056    | 22-Jul-19 | 07:01 | x86      |
| Txbestmatch.dll                                    | 2015.131.5426.0 | 611440    | 22-Jul-19 | 06:50 | x64      |
| Txbestmatch.dll                                    | 2015.131.5426.0 | 496456    | 22-Jul-19 | 07:01 | x86      |
| Txcache.dll                                        | 2015.131.5426.0 | 183408    | 22-Jul-19 | 06:50 | x64      |
| Txcache.dll                                        | 2015.131.5426.0 | 148296    | 22-Jul-19 | 07:01 | x86      |
| Txcharmap.dll                                      | 2015.131.5426.0 | 289904    | 22-Jul-19 | 06:50 | x64      |
| Txcharmap.dll                                      | 2015.131.5426.0 | 250688    | 22-Jul-19 | 07:01 | x86      |
| Txcopymap.dll                                      | 2015.131.5426.0 | 182896    | 22-Jul-19 | 06:50 | x64      |
| Txcopymap.dll                                      | 2015.131.5426.0 | 147784    | 22-Jul-19 | 07:01 | x86      |
| Txdataconvert.dll                                  | 2015.131.5426.0 | 296560    | 22-Jul-19 | 06:50 | x64      |
| Txdataconvert.dll                                  | 2015.131.5426.0 | 255304    | 22-Jul-19 | 07:01 | x86      |
| Txderived.dll                                      | 2015.131.5426.0 | 607856    | 22-Jul-19 | 06:50 | x64      |
| Txderived.dll                                      | 2015.131.5426.0 | 519496    | 22-Jul-19 | 07:01 | x86      |
| Txfileextractor.dll                                | 2015.131.5426.0 | 201840    | 22-Jul-19 | 06:51 | x64      |
| Txfileextractor.dll                                | 2015.131.5426.0 | 163144    | 22-Jul-19 | 07:01 | x86      |
| Txfileinserter.dll                                 | 2015.131.5426.0 | 199792    | 22-Jul-19 | 06:50 | x64      |
| Txfileinserter.dll                                 | 2015.131.5426.0 | 161096    | 22-Jul-19 | 07:01 | x86      |
| Txgroupdups.dll                                    | 2015.131.5426.0 | 290928    | 22-Jul-19 | 06:51 | x64      |
| Txgroupdups.dll                                    | 2015.131.5426.0 | 231752    | 22-Jul-19 | 07:01 | x86      |
| Txlineage.dll                                      | 2015.131.5426.0 | 137840    | 22-Jul-19 | 06:50 | x64      |
| Txlineage.dll                                      | 2015.131.5426.0 | 109896    | 22-Jul-19 | 07:01 | x86      |
| Txlookup.dll                                       | 2015.131.5426.0 | 532080    | 22-Jul-19 | 06:51 | x64      |
| Txlookup.dll                                       | 2015.131.5426.0 | 449864    | 22-Jul-19 | 07:01 | x86      |
| Txmerge.dll                                        | 2015.131.5426.0 | 230512    | 22-Jul-19 | 06:50 | x64      |
| Txmerge.dll                                        | 2015.131.5426.0 | 176968    | 22-Jul-19 | 07:01 | x86      |
| Txmergejoin.dll                                    | 2015.131.5426.0 | 278640    | 22-Jul-19 | 06:50 | x64      |
| Txmergejoin.dll                                    | 2015.131.5426.0 | 224072    | 22-Jul-19 | 07:01 | x86      |
| Txmulticast.dll                                    | 2015.131.5426.0 | 128112    | 22-Jul-19 | 06:50 | x64      |
| Txmulticast.dll                                    | 2015.131.5426.0 | 102208    | 22-Jul-19 | 07:01 | x86      |
| Txpivot.dll                                        | 2015.131.5426.0 | 227952    | 22-Jul-19 | 06:50 | x64      |
| Txpivot.dll                                        | 2015.131.5426.0 | 182088    | 22-Jul-19 | 07:01 | x86      |
| Txrowcount.dll                                     | 2015.131.5426.0 | 126576    | 22-Jul-19 | 06:50 | x64      |
| Txrowcount.dll                                     | 2015.131.5426.0 | 101704    | 22-Jul-19 | 07:01 | x86      |
| Txsampling.dll                                     | 2015.131.5426.0 | 172144    | 22-Jul-19 | 06:50 | x64      |
| Txsampling.dll                                     | 2015.131.5426.0 | 134984    | 22-Jul-19 | 07:01 | x86      |
| Txscd.dll                                          | 2015.131.5426.0 | 220272    | 22-Jul-19 | 06:50 | x64      |
| Txscd.dll                                          | 2015.131.5426.0 | 169800    | 22-Jul-19 | 07:01 | x86      |
| Txsort.dll                                         | 2015.131.5426.0 | 259184    | 22-Jul-19 | 06:50 | x64      |
| Txsort.dll                                         | 2015.131.5426.0 | 211272    | 22-Jul-19 | 07:01 | x86      |
| Txsplit.dll                                        | 2015.131.5426.0 | 600688    | 22-Jul-19 | 06:50 | x64      |
| Txsplit.dll                                        | 2015.131.5426.0 | 513352    | 22-Jul-19 | 07:01 | x86      |
| Txtermextraction.dll                               | 2015.131.5426.0 | 8678000   | 22-Jul-19 | 06:50 | x64      |
| Txtermextraction.dll                               | 2015.131.5426.0 | 8615752   | 22-Jul-19 | 07:01 | x86      |
| Txtermlookup.dll                                   | 2015.131.5426.0 | 4158576   | 22-Jul-19 | 06:50 | x64      |
| Txtermlookup.dll                                   | 2015.131.5426.0 | 4107080   | 22-Jul-19 | 07:01 | x86      |
| Txunionall.dll                                     | 2015.131.5426.0 | 181872    | 22-Jul-19 | 06:50 | x64      |
| Txunionall.dll                                     | 2015.131.5426.0 | 138864    | 22-Jul-19 | 07:01 | x86      |
| Txunpivot.dll                                      | 2015.131.5426.0 | 201840    | 22-Jul-19 | 06:50 | x64      |
| Txunpivot.dll                                      | 2015.131.5426.0 | 162416    | 22-Jul-19 | 07:01 | x86      |
| Xe.dll                                             | 2015.131.5426.0 | 626288    | 22-Jul-19 | 07:00 | x64      |
| Xe.dll                                             | 2015.131.5426.0 | 558704    | 22-Jul-19 | 07:01 | x86      |

SQL Server 2016 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 10.0.8224.49     | 483624    | 09-May-19 | 19:33 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.49 | 75560     | 09-May-19 | 19:33 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.49     | 45864     | 09-May-19 | 19:33 | x86      |
| Instapi130.dll                                                       | 2015.131.5426.0  | 61040     | 22-Jul-19 | 06:50 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 10.0.8224.49     | 74536     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 10.0.8224.49     | 202024    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 10.0.8224.49     | 2347304   | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 10.0.8224.49     | 102184    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 10.0.8224.49     | 378664    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 10.0.8224.49     | 185640    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 10.0.8224.49     | 127272    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 10.0.8224.49     | 63272     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 10.0.8224.49     | 52520     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 10.0.8224.49     | 87336     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 10.0.8224.49     | 721704    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 10.0.8224.49     | 87336     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 10.0.8224.49     | 78120     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 10.0.8224.49     | 41768     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 10.0.8224.49     | 36648     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 10.0.8224.49     | 47912     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 10.0.8224.49     | 27432     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 10.0.8224.49     | 33064     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 10.0.8224.49     | 119080    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 10.0.8224.49     | 94504     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 10.0.8224.49     | 108328    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 10.0.8224.49     | 256808    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 102184    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 116008    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 119080    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 116008    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 125736    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 118056    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 113448    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 145704    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 100136    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.49     | 114984    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 10.0.8224.49     | 69416     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 10.0.8224.49     | 28456     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 10.0.8224.49     | 43816     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 10.0.8224.49     | 82216     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 10.0.8224.49     | 137000    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 10.0.8224.49     | 2155816   | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 10.0.8224.49     | 3818792   | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 107816    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 120104    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 124712    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 121128    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 133408    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 121128    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 118568    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 152360    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 105280    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.49     | 119592    | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 10.0.8224.49     | 66856     | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 10.0.8224.49     | 2756392   | 09-May-19 | 19:33 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 10.0.8224.49     | 752424    | 09-May-19 | 19:33 | x86      |
| Mpdwinterop.dll                                                      | 2015.131.5426.0  | 395080    | 22-Jul-19 | 06:57 | x64      |
| Mpdwsvc.exe                                                          | 2015.131.5426.0  | 6618440   | 22-Jul-19 | 07:01 | x64      |
| Pdwodbcsql11.dll                                                     | 2015.131.5426.0  | 2229872   | 22-Jul-19 | 06:50 | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.49 | 47400     | 09-May-19 | 19:33 | x64      |
| Sqldk.dll                                                            | 2015.131.5426.0  | 2532976   | 22-Jul-19 | 06:50 | x64      |
| Sqldumper.exe                                                        | 2015.131.5426.0  | 127328    | 22-Jul-19 | 07:01 | x64      |
| Sqlos.dll                                                            | 2015.131.5426.0  | 26224     | 22-Jul-19 | 06:51 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.49 | 4348200   | 09-May-19 | 19:33 | x64      |
| Sqltses.dll                                                          | 2015.131.5426.0  | 9092720   | 22-Jul-19 | 06:50 | x64      |

SQL Server 2016 Reporting Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.modeling.dll                   | 13.0.5426.0     | 610936    | 22-Jul-19 | 06:59 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.5426.0     | 1620088   | 22-Jul-19 | 06:59 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.5426.0     | 658040    | 22-Jul-19 | 06:59 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.5426.0     | 329848    | 22-Jul-19 | 06:59 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.5426.0     | 1090680   | 22-Jul-19 | 06:59 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5426.0     | 548472    | 22-Jul-19 | 06:59 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5426.0     | 548680    | 22-Jul-19 | 07:01 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5426.0     | 548464    | 22-Jul-19 | 07:03 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5426.0     | 548464    | 22-Jul-19 | 07:04 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5426.0     | 548472    | 22-Jul-19 | 06:58 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5426.0     | 548680    | 22-Jul-19 | 06:57 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5426.0     | 548472    | 22-Jul-19 | 06:56 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5426.0     | 548472    | 22-Jul-19 | 07:00 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5426.0     | 548464    | 22-Jul-19 | 07:03 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5426.0     | 548464    | 22-Jul-19 | 07:04 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.5426.0     | 162936    | 22-Jul-19 | 06:59 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.5426.0     | 126280    | 22-Jul-19 | 07:02 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.5426.0     | 6076528   | 22-Jul-19 | 07:03 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5426.0     | 4511344   | 22-Jul-19 | 07:00 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5426.0     | 4512072   | 22-Jul-19 | 07:01 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5426.0     | 4511856   | 22-Jul-19 | 07:02 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5426.0     | 4512072   | 22-Jul-19 | 07:05 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5426.0     | 4512376   | 22-Jul-19 | 06:59 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5426.0     | 4512600   | 22-Jul-19 | 06:57 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5426.0     | 4511864   | 22-Jul-19 | 06:57 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5426.0     | 4512880   | 22-Jul-19 | 07:00 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5426.0     | 4511344   | 22-Jul-19 | 07:03 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5426.0     | 4511856   | 22-Jul-19 | 07:03 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.5426.0     | 10894152  | 22-Jul-19 | 07:02 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.5426.0     | 100976    | 22-Jul-19 | 07:00 | x64      |
| Microsoft.reportingservices.storage.dll                   | 13.0.5426.0     | 208712    | 22-Jul-19 | 07:02 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.131.5426.0 | 47968     | 22-Jul-19 | 07:02 | x64      |
| Microsoft.sqlserver.types.dll                             | 2015.131.5426.0 | 392816    | 22-Jul-19 | 07:00 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.131.5426.0 | 396912    | 22-Jul-19 | 07:04 | x86      |
| Msmdlocal.dll                                             | 2015.131.5426.0 | 56245360  | 22-Jul-19 | 07:00 | x64      |
| Msmdlocal.dll                                             | 2015.131.5426.0 | 37129032  | 22-Jul-19 | 07:01 | x86      |
| Msmgdsrv.dll                                              | 2015.131.5426.0 | 7509624   | 22-Jul-19 | 06:58 | x64      |
| Msmgdsrv.dll                                              | 2015.131.5426.0 | 6508656   | 22-Jul-19 | 07:03 | x86      |
| Msolap130.dll                                             | 2015.131.5426.0 | 8643184   | 22-Jul-19 | 07:00 | x64      |
| Msolap130.dll                                             | 2015.131.5426.0 | 7010632   | 22-Jul-19 | 07:01 | x86      |
| Msolui130.dll                                             | 2015.131.5426.0 | 310392    | 22-Jul-19 | 06:59 | x64      |
| Msolui130.dll                                             | 2015.131.5426.0 | 287560    | 22-Jul-19 | 07:01 | x86      |
| Reportingservicescompression.dll                          | 2015.131.5426.0 | 62584     | 22-Jul-19 | 06:59 | x64      |
| Reportingserviceslibrary.dll                              | 13.0.5426.0     | 2543944   | 22-Jul-19 | 06:58 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.131.5426.0 | 108872    | 22-Jul-19 | 06:57 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.131.5426.0 | 114288    | 22-Jul-19 | 07:03 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.131.5426.0 | 99136     | 22-Jul-19 | 06:58 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.5426.0     | 2728776   | 22-Jul-19 | 06:58 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5426.0     | 884344    | 22-Jul-19 | 06:57 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5426.0     | 888440    | 22-Jul-19 | 06:58 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5426.0     | 888432    | 22-Jul-19 | 07:02 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5426.0     | 888432    | 22-Jul-19 | 07:02 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5426.0     | 892744    | 22-Jul-19 | 07:01 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5426.0     | 888440    | 22-Jul-19 | 06:59 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5426.0     | 888440    | 22-Jul-19 | 06:59 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5426.0     | 900936    | 22-Jul-19 | 07:01 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5426.0     | 884336    | 22-Jul-19 | 07:02 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5426.0     | 888432    | 22-Jul-19 | 07:04 | x86      |
| Rshttpruntime.dll                                         | 2015.131.5426.0 | 99648     | 22-Jul-19 | 06:57 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.131.5426.0 | 100472    | 22-Jul-19 | 07:00 | x64      |
| Sqldumper.exe                                             | 2015.131.5426.0 | 107848    | 22-Jul-19 | 06:57 | x86      |
| Sqldumper.exe                                             | 2015.131.5426.0 | 127088    | 22-Jul-19 | 07:00 | x64      |
| Sqlrsos.dll                                               | 2015.131.5426.0 | 26224     | 22-Jul-19 | 06:50 | x64      |
| Sqlserverspatial130.dll                                   | 2015.131.5426.0 | 732792    | 22-Jul-19 | 06:59 | x64      |
| Sqlserverspatial130.dll                                   | 2015.131.5426.0 | 584312    | 22-Jul-19 | 06:59 | x86      |
| Xmlrw.dll                                                 | 2015.131.5426.0 | 319096    | 22-Jul-19 | 06:59 | x64      |
| Xmlrw.dll                                                 | 2015.131.5426.0 | 259936    | 22-Jul-19 | 07:01 | x86      |
| Xmlrwbin.dll                                              | 2015.131.5426.0 | 227448    | 22-Jul-19 | 06:59 | x64      |
| Xmlrwbin.dll                                              | 2015.131.5426.0 | 191600    | 22-Jul-19 | 07:01 | x86      |
| Xmsrv.dll                                                 | 2015.131.5426.0 | 24051824  | 22-Jul-19 | 06:50 | x64      |
| Xmsrv.dll                                                 | 2015.131.5426.0 | 32727904  | 22-Jul-19 | 07:01 | x86      |

SQL Server 2016 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.5426.0     | 23880     | 22-Jul-19 | 06:58 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.131.5426.0 | 100472    | 22-Jul-19 | 07:00 | x64      |

SQL Server 2016 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                  | 2015.131.5426.0 | 1312072   | 22-Jul-19 | 06:57 | x86      |
| Ddsshapes.dll                                  | 2015.131.5426.0 | 136000    | 22-Jul-19 | 06:57 | x86      |
| Dtaengine.exe                                  | 2015.131.5426.0 | 167232    | 22-Jul-19 | 06:57 | x86      |
| Dteparse.dll                                   | 2015.131.5426.0 | 99656     | 22-Jul-19 | 06:57 | x86      |
| Dteparse.dll                                   | 2015.131.5426.0 | 109688    | 22-Jul-19 | 07:00 | x64      |
| Dteparsemgd.dll                                | 2015.131.5426.0 | 88696     | 22-Jul-19 | 06:59 | x64      |
| Dteparsemgd.dll                                | 2015.131.5426.0 | 83784     | 22-Jul-19 | 07:02 | x86      |
| Dtepkg.dll                                     | 2015.131.5426.0 | 116032    | 22-Jul-19 | 06:57 | x86      |
| Dtepkg.dll                                     | 2015.131.5426.0 | 137336    | 22-Jul-19 | 07:00 | x64      |
| Dtexec.exe                                     | 2015.131.5426.0 | 66888     | 22-Jul-19 | 06:57 | x86      |
| Dtexec.exe                                     | 2015.131.5426.0 | 73024     | 22-Jul-19 | 06:58 | x64      |
| Dts.dll                                        | 2015.131.5426.0 | 2633024   | 22-Jul-19 | 06:57 | x86      |
| Dts.dll                                        | 2015.131.5426.0 | 3146864   | 22-Jul-19 | 07:00 | x64      |
| Dtscomexpreval.dll                             | 2015.131.5426.0 | 419136    | 22-Jul-19 | 06:57 | x86      |
| Dtscomexpreval.dll                             | 2015.131.5426.0 | 477304    | 22-Jul-19 | 07:00 | x64      |
| Dtsconn.dll                                    | 2015.131.5426.0 | 392520    | 22-Jul-19 | 06:57 | x86      |
| Dtsconn.dll                                    | 2015.131.5426.0 | 492664    | 22-Jul-19 | 07:00 | x64      |
| Dtshost.exe                                    | 2015.131.5426.0 | 76608     | 22-Jul-19 | 06:57 | x86      |
| Dtshost.exe                                    | 2015.131.5426.0 | 86856     | 22-Jul-19 | 06:58 | x64      |
| Dtslog.dll                                     | 2015.131.5426.0 | 103240    | 22-Jul-19 | 06:57 | x86      |
| Dtslog.dll                                     | 2015.131.5426.0 | 120440    | 22-Jul-19 | 07:00 | x64      |
| Dtsmsg130.dll                                  | 2015.131.5426.0 | 541504    | 22-Jul-19 | 06:57 | x86      |
| Dtsmsg130.dll                                  | 2015.131.5426.0 | 545400    | 22-Jul-19 | 07:00 | x64      |
| Dtspipeline.dll                                | 2015.131.5426.0 | 1059656   | 22-Jul-19 | 06:57 | x86      |
| Dtspipeline.dll                                | 2015.131.5426.0 | 1279096   | 22-Jul-19 | 07:00 | x64      |
| Dtspipelineperf130.dll                         | 2015.131.5426.0 | 42328     | 22-Jul-19 | 06:57 | x86      |
| Dtspipelineperf130.dll                         | 2015.131.5426.0 | 48240     | 22-Jul-19 | 07:00 | x64      |
| Dtuparse.dll                                   | 2015.131.5426.0 | 80200     | 22-Jul-19 | 06:57 | x86      |
| Dtuparse.dll                                   | 2015.131.5426.0 | 87672     | 22-Jul-19 | 07:00 | x64      |
| Dtutil.exe                                     | 2015.131.5426.0 | 115528    | 22-Jul-19 | 06:57 | x86      |
| Dtutil.exe                                     | 2015.131.5426.0 | 134984    | 22-Jul-19 | 06:57 | x64      |
| Exceldest.dll                                  | 2015.131.5426.0 | 216896    | 22-Jul-19 | 06:57 | x86      |
| Exceldest.dll                                  | 2015.131.5426.0 | 263288    | 22-Jul-19 | 07:00 | x64      |
| Excelsrc.dll                                   | 2015.131.5426.0 | 232776    | 22-Jul-19 | 06:57 | x86      |
| Excelsrc.dll                                   | 2015.131.5426.0 | 285304    | 22-Jul-19 | 07:00 | x64      |
| Flatfiledest.dll                               | 2015.131.5426.0 | 334664    | 22-Jul-19 | 06:57 | x86      |
| Flatfiledest.dll                               | 2015.131.5426.0 | 389240    | 22-Jul-19 | 07:00 | x64      |
| Flatfilesrc.dll                                | 2015.131.5426.0 | 345416    | 22-Jul-19 | 06:57 | x86      |
| Flatfilesrc.dll                                | 2015.131.5426.0 | 401528    | 22-Jul-19 | 07:00 | x64      |
| Foreachfileenumerator.dll                      | 2015.131.5426.0 | 80712     | 22-Jul-19 | 06:57 | x86      |
| Foreachfileenumerator.dll                      | 2015.131.5426.0 | 96376     | 22-Jul-19 | 07:00 | x64      |
| Microsoft.analysisservices.adomdclientui.dll   | 13.0.5426.0     | 92488     | 22-Jul-19 | 07:02 | x86      |
| Microsoft.analysisservices.applocal.core.dll   | 13.0.5426.0     | 1314112   | 22-Jul-19 | 07:02 | x86      |
| Microsoft.analysisservices.project.dll         | 2015.131.5426.0 | 2023240   | 22-Jul-19 | 07:01 | x86      |
| Microsoft.analysisservices.projectui.dll       | 2015.131.5426.0 | 42104     | 22-Jul-19 | 06:58 | x86      |
| Microsoft.sqlserver.astasks.dll                | 13.0.5426.0     | 73536     | 22-Jul-19 | 06:57 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5426.0     | 436040    | 22-Jul-19 | 06:57 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5426.0     | 436040    | 22-Jul-19 | 07:02 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5426.0     | 2044736   | 22-Jul-19 | 06:57 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5426.0     | 2044744   | 22-Jul-19 | 07:01 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5426.0 | 138864    | 22-Jul-19 | 07:01 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5426.0 | 150368    | 22-Jul-19 | 07:02 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5426.0 | 144496    | 22-Jul-19 | 07:01 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5426.0 | 159048    | 22-Jul-19 | 07:01 | x64      |
| Msdtssrvrutil.dll                              | 2015.131.5426.0 | 101496    | 22-Jul-19 | 06:59 | x64      |
| Msdtssrvrutil.dll                              | 2015.131.5426.0 | 90440     | 22-Jul-19 | 07:01 | x86      |
| Msmdlocal.dll                                  | 2015.131.5426.0 | 56245360  | 22-Jul-19 | 07:00 | x64      |
| Msmdlocal.dll                                  | 2015.131.5426.0 | 37129032  | 22-Jul-19 | 07:01 | x86      |
| Msmgdsrv.dll                                   | 2015.131.5426.0 | 7509624   | 22-Jul-19 | 06:58 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5426.0 | 6508656   | 22-Jul-19 | 07:03 | x86      |
| Msolap130.dll                                  | 2015.131.5426.0 | 8643184   | 22-Jul-19 | 07:00 | x64      |
| Msolap130.dll                                  | 2015.131.5426.0 | 7010632   | 22-Jul-19 | 07:01 | x86      |
| Msolui130.dll                                  | 2015.131.5426.0 | 310392    | 22-Jul-19 | 06:59 | x64      |
| Msolui130.dll                                  | 2015.131.5426.0 | 287560    | 22-Jul-19 | 07:01 | x86      |
| Oledbdest.dll                                  | 2015.131.5426.0 | 264312    | 22-Jul-19 | 07:00 | x64      |
| Oledbdest.dll                                  | 2015.131.5426.0 | 216688    | 22-Jul-19 | 07:00 | x86      |
| Oledbsrc.dll                                   | 2015.131.5426.0 | 290936    | 22-Jul-19 | 06:59 | x64      |
| Oledbsrc.dll                                   | 2015.131.5426.0 | 235632    | 22-Jul-19 | 07:00 | x86      |
| Profiler.exe                                   | 2015.131.5426.0 | 804680    | 22-Jul-19 | 07:02 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.131.5426.0 | 100472    | 22-Jul-19 | 07:00 | x64      |
| Sqldumper.exe                                  | 2015.131.5426.0 | 107848    | 22-Jul-19 | 06:57 | x86      |
| Sqldumper.exe                                  | 2015.131.5426.0 | 127088    | 22-Jul-19 | 07:00 | x64      |
| Sqlresld.dll                                   | 2015.131.5426.0 | 30832     | 22-Jul-19 | 06:50 | x64      |
| Sqlresld.dll                                   | 2015.131.5426.0 | 28792     | 22-Jul-19 | 06:59 | x86      |
| Sqlresourceloader.dll                          | 2015.131.5426.0 | 30832     | 22-Jul-19 | 06:50 | x64      |
| Sqlresourceloader.dll                          | 2015.131.5426.0 | 28280     | 22-Jul-19 | 06:59 | x86      |
| Sqlscm.dll                                     | 2015.131.5426.0 | 61048     | 22-Jul-19 | 06:59 | x64      |
| Sqlscm.dll                                     | 2015.131.5426.0 | 52856     | 22-Jul-19 | 06:59 | x86      |
| Sqlsvc.dll                                     | 2015.131.5426.0 | 152176    | 22-Jul-19 | 06:50 | x64      |
| Sqlsvc.dll                                     | 2015.131.5426.0 | 127096    | 22-Jul-19 | 06:59 | x86      |
| Sqltaskconnections.dll                         | 2015.131.5426.0 | 180848    | 22-Jul-19 | 06:50 | x64      |
| Sqltaskconnections.dll                         | 2015.131.5426.0 | 151160    | 22-Jul-19 | 06:59 | x86      |
| Txdataconvert.dll                              | 2015.131.5426.0 | 296560    | 22-Jul-19 | 06:50 | x64      |
| Txdataconvert.dll                              | 2015.131.5426.0 | 255304    | 22-Jul-19 | 07:01 | x86      |
| Xe.dll                                         | 2015.131.5426.0 | 626288    | 22-Jul-19 | 07:00 | x64      |
| Xe.dll                                         | 2015.131.5426.0 | 558704    | 22-Jul-19 | 07:01 | x86      |
| Xmlrw.dll                                      | 2015.131.5426.0 | 319096    | 22-Jul-19 | 06:59 | x64      |
| Xmlrw.dll                                      | 2015.131.5426.0 | 259936    | 22-Jul-19 | 07:01 | x86      |
| Xmlrwbin.dll                                   | 2015.131.5426.0 | 227448    | 22-Jul-19 | 06:59 | x64      |
| Xmlrwbin.dll                                   | 2015.131.5426.0 | 191600    | 22-Jul-19 | 07:01 | x86      |
| Xmsrv.dll                                      | 2015.131.5426.0 | 24051824  | 22-Jul-19 | 06:50 | x64      |
| Xmsrv.dll                                      | 2015.131.5426.0 | 32727904  | 22-Jul-19 | 07:01 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
