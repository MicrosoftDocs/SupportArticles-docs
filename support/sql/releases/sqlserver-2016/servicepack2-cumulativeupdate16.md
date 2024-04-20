---
title: Cumulative update 16 for SQL Server 2016 SP2 (KB5000645)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP2 cumulative update 16 (KB5000645).
ms.date: 10/26/2023
ms.custom: KB5000645
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Web
---

# KB5000645 - Cumulative Update 16 for SQL Server 2016 SP2

_Release Date:_ &nbsp; February 11, 2021  
_Version:_ &nbsp; 13.0.5882.1

> [!NOTE]
> After you apply CU 16 for SQL Server 2016 SP2, you might encounter an issue in which DML (insert/update/delete) queries that use parallel plans cannot complete any execution and encounter `HP_SPOOL_BARRIER`` waits. You can use the trace flag 13116 or MAXDOP=1 hint to work around this issue. This issue is related to the introduction of fix for [13685819](servicepack2-cumulativeupdate16.md#13685819) and it will be fixed in the next Cumulative Update.

This article describes Cumulative Update package 16 (CU16) (build number: **13.0.5882.1**) for Microsoft SQL Server 2016 Service Pack 2 (SP2). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the initial release of SQL Server 2016 SP2.

## Improvements and fixes included in this update

| Bug reference | Description| Fix area| Platform |
|---------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|----------|
| <a id=13740271>[13740271](#13740271) </a> | [FIX: Wrong results due to undetected concatenation parameters from scalar expression (KB5000649)](https://support.microsoft.com/help/5000649) | SQL performance | All|
| <a id=13910344>[13910344](#13910344) </a> | [FIX: Assert failure occurs when concurrent query modifies the same bitmap during clustered columnstore delete bitmap seek in SQL Server 2016 (KB5000651)](https://support.microsoft.com/help/5000651) | SQL Engine| All|
| <a id=13684505>[13684505](#13684505) </a> | Fixes an Access Violation (AV) that occurs when error is being collected for Availability Group (AG) DB Failover while there is a AG failover undergoing.| High Availability | All|
| <a id=13790726>[13790726](#13790726) </a> | Improves the records stage of failure and error during stack copy for better diagnostics.| SQL Engine| All|
| <a id=13911648>[13911648](#13911648) </a> | FIX: Prevents error 9029 from being reported on AlwaysOn Availability Database during recovery after transition to SECONDARY role, which results in database being in Not Synchronizing/ In Recovery state. This can only occur if the database is configured to use Persistent Log Buffer for transaction log.| SQL Engine| All|
| <a id=13872394>[13872394](#13872394) </a> | [VC++ 2015 Redistributable installation returns error 1638 when newer version already installed (KB4092997)](https://support.microsoft.com/help/4092997) | SQL Engine| Windows|
| <a id=13714938>[13714938](#13714938) </a> | [FIX: User session is in rollback state indefinitely after it is killed in SQL Server 2016 and 2019 (KB4585971)](https://support.microsoft.com/help/4585971) | SQL Engine| Windows|
| <a id=13664250>[13664250](#13664250) </a> | [FIX: MERGE statement fails with Access Violation at BTreeRow::DisableAccessReleaseOnWait in SQL Server (KB4589350)](https://support.microsoft.com/help/4589350) | SQL performance | Windows|
| <a id=13755880>[13755880](#13755880) </a> | [FIX: Incorrect results occur when you run query on In-memory optimized table that has clustered columnstore index in SQL Server 2016 (KB5000650)](https://support.microsoft.com/help/5000650) | In-memory OLTP| Windows|
| <a id=13883014>[13883014](#13883014) </a> | [FIX: Non-yielding condition occurs when you execute a query in batch mode in SQL Server 2016 (KB5000652)](https://support.microsoft.com/help/5000652) | SQL Engine| Windows|
| <a id=13849761>[13849761](#13849761) </a> | [FIX: Failures with log reader agent occurs when you create and drop publication on CDC enabled database in SQL Server 2016 (KB5000715)](https://support.microsoft.com/help/5000715) | SQL Engine| Windows|
| <a id=13773660>[13773660](#13773660) </a> | [FIX: Error when you enable managed or automated backup in SQL Server 2016 and 2017 if "Allow Blob Public Access" is disabled on a storage account (KB4589360)](https://support.microsoft.com/help/4589360)| SQL Engine| Windows|
| <a id=13685819>[13685819](#13685819) </a> | Fixes an issue with insert query in SQL Server 2016 that reads the data from the same table and uses a parallel execution plan may produce duplicate rows. | SQL performance | Windows|
| <a id=13720644>[13720644](#13720644) </a> | Fixes an Access Violation error that occurs at `sqllang!CStatement::SetDbIdMaskingUsageInfo+0x11` in SQL Server 2016.| SQL security| Windows|
| <a id=13746920>[13746920](#13746920) </a> | Unable to connect to primary database replica after failing over the Availability Group in SQL Server. | High Availability | Windows|
| <a id=13760750>[13760750](#13760750) </a> | Forwarder is unable to reconnect to global primary following Global primary planned failover if the `LISTENER_URL` is modified.| High Availability | Windows|
| <a id=13786217>[13786217](#13786217) </a> | Fixes the replication issues that occur with Log Reader Agent and `xp_sqlagent_notify` after AG Failover.| SQL Engine| Windows|
| <a id=13819009>[13819009](#13819009) </a> | Fixes FullText query not returning the expected values that are located on the FullText index structure with AccentSensitivity turned on.| SQL Engine| Windows|
| <a id=13866749>[13866749](#13866749) </a> | Fixes Access violation exception that occurs when queries are executed in read uncommitted mode with high concurrent read or write pattern over XML data types. | SQL Engine| Windows|
| <a id=13878424>[13878424](#13878424) </a> | Fixes Performance issue that occurs with `CHANGETABLE` function and syscommit on SQL Server 2016.| SQL performance | Windows|
| <a id=13578477>[13578477](#13578477) </a> | Fixes the foreign key referencing unique index with included columns which causes replication to fail. | SQL Engine| Windows|
| <a id=13883910>[13883910](#13883910) </a> | Fixes the Access Violation error that occurs when importing large amount of data to Azure Blob storage. This can occur if PolyBase Data Movement Service encounters out-of-memory condition during large data insert transaction.| SQL Engine| Windows|
| <a id=13905138>[13905138](#13905138) </a> | Fixes the error that occurs when a change tracking function in MSTVF is called in SQL Server 2016. </br></br>Msg 443, Level 16, State 1, Procedure \<ProcedureName>, Line \<LineNumber> [Batch Start Line \<LineNumber>] </br>Invalid use of a side-effecting operator 'change_tracking_current_version' within a function | SQL Engine| Windows|

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

| File   name    | File version    | File size | Date      | Time | Platform |
|----------------|-----------------|-----------|-----------|------|----------|
| Instapi130.dll | 2015.131.5882.1 | 46488     | 26-Jan-2021 | 07:41 | x86      |
| Keyfile.dll    | 2015.131.5882.1 | 81808     | 26-Jan-2021 | 07:41 | x86      |
| Sqlbrowser.exe | 2015.131.5882.1 | 269704    | 26-Jan-2021 | 07:38 | x86      |
| Sqldumper.exe  | 2015.131.5882.1 | 103832    | 26-Jan-2021 | 07:37 | x86      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date      | Time | Platform |
|-----------------------|-----------------|-----------|-----------|------|----------|
| Instapi130.dll        | 2015.131.5882.1 | 54168     | 26-Jan-2021 | 07:40 | x64      |
| Sqlboot.dll           | 2015.131.5882.1 | 179592    | 26-Jan-2021 | 07:39 | x64      |
| Sqldumper.exe         | 2015.131.5882.1 | 123288    | 26-Jan-2021 | 07:40 | x64      |
| Sqlvdi.dll            | 2015.131.5882.1 | 190352    | 26-Jan-2021 | 07:41 | x64      |
| Sqlvdi.dll            | 2015.131.5882.1 | 161688    | 26-Jan-2021 | 07:42 | x86      |
| Sqlwriter.exe         | 2015.131.5882.1 | 124824    | 26-Jan-2021 | 07:47 | x64      |
| Sqlwriter_keyfile.dll | 2015.131.5882.1 | 93592     | 26-Jan-2021 | 07:40 | x64      |
| Sqlwvss.dll           | 2015.131.5882.1 | 341912    | 26-Jan-2021 | 07:26 | x64      |
| Sqlwvss_xp.dll        | 2015.131.5882.1 | 19344     | 26-Jan-2021 | 07:27 | x64      |

SQL Server 2016 Analysis Services

| File   name                                | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.server.core.dll | 13.0.5882.1     | 1341848   | 26-Jan-2021 | 07:39  | x86      |
| Microsoft.applicationinsights.dll          | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5882.1     | 983448    | 26-Jan-2021 | 07:38  | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5882.1     | 983448    | 26-Jan-2021 | 07:40  | x86      |
| Msmdctr130.dll                             | 2015.131.5882.1 | 33176     | 26-Jan-2021 | 07:39  | x64      |
| Msmdlocal.dll                              | 2015.131.5882.1 | 56245144  | 26-Jan-2021 | 07:40  | x64      |
| Msmdlocal.dll                              | 2015.131.5882.1 | 37127056  | 26-Jan-2021 | 07:41  | x86      |
| Msmdsrv.exe                                | 2015.131.5882.1 | 56791960  | 26-Jan-2021 | 07:49  | x64      |
| Msmgdsrv.dll                               | 2015.131.5882.1 | 6502296   | 26-Jan-2021 | 07:45  | x86      |
| Msmgdsrv.dll                               | 2015.131.5882.1 | 7502744   | 26-Jan-2021 | 07:50  | x64      |
| Msolap130.dll                              | 2015.131.5882.1 | 8636312   | 26-Jan-2021 | 07:40  | x64      |
| Msolap130.dll                              | 2015.131.5882.1 | 7003544   | 26-Jan-2021 | 07:42  | x86      |
| Msolui130.dll                              | 2015.131.5882.1 | 303512    | 26-Jan-2021 | 07:39  | x64      |
| Msolui130.dll                              | 2015.131.5882.1 | 280472    | 26-Jan-2021 | 07:41  | x86      |
| Sql_as_keyfile.dll                         | 2015.131.5882.1 | 93592     | 26-Jan-2021 | 07:40  | x64      |
| Sqlboot.dll                                | 2015.131.5882.1 | 179592    | 26-Jan-2021 | 07:39  | x64      |
| Sqlceip.exe                                | 13.0.5882.1     | 249240    | 26-Jan-2021 | 07:39  | x86      |
| Sqldumper.exe                              | 2015.131.5882.1 | 103832    | 26-Jan-2021 | 07:37  | x86      |
| Sqldumper.exe                              | 2015.131.5882.1 | 123288    | 26-Jan-2021 | 07:40  | x64      |
| Tmapi.dll                                  | 2015.131.5882.1 | 4339096   | 26-Jan-2021 | 07:27  | x64      |
| Tmcachemgr.dll                             | 2015.131.5882.1 | 2819472   | 26-Jan-2021 | 07:26  | x64      |
| Tmpersistence.dll                          | 2015.131.5882.1 | 1064344   | 26-Jan-2021 | 07:26  | x64      |
| Tmtransactions.dll                         | 2015.131.5882.1 | 1345432   | 26-Jan-2021 | 07:26  | x64      |
| Xe.dll                                     | 2015.131.5882.1 | 619416    | 26-Jan-2021 | 07:40  | x64      |
| Xmlrw.dll                                  | 2015.131.5882.1 | 252824    | 26-Jan-2021 | 07:39  | x86      |
| Xmlrw.dll                                  | 2015.131.5882.1 | 312216    | 26-Jan-2021 | 07:40  | x64      |
| Xmlrwbin.dll                               | 2015.131.5882.1 | 184728    | 26-Jan-2021 | 07:39  | x86      |
| Xmlrwbin.dll                               | 2015.131.5882.1 | 220568    | 26-Jan-2021 | 07:40  | x64      |
| Xmsrv.dll                                  | 2015.131.5882.1 | 24041872  | 26-Jan-2021 | 07:27  | x64      |
| Xmsrv.dll                                  | 2015.131.5882.1 | 32720792  | 26-Jan-2021 | 07:40  | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version    | File size | Date      | Time | Platform |
|---------------------------------------------|-----------------|-----------|-----------|------|----------|
| Batchparser.dll                             | 2015.131.5882.1 | 153496    | 26-Jan-2021 | 07:37 | x86      |
| Batchparser.dll                             | 2015.131.5882.1 | 173976    | 26-Jan-2021 | 07:40 | x64      |
| Instapi130.dll                              | 2015.131.5882.1 | 54168     | 26-Jan-2021 | 07:40 | x64      |
| Instapi130.dll                              | 2015.131.5882.1 | 46488     | 26-Jan-2021 | 07:41 | x86      |
| Isacctchange.dll                            | 2015.131.5882.1 | 23960     | 26-Jan-2021 | 07:39 | x64      |
| Isacctchange.dll                            | 2015.131.5882.1 | 22424     | 26-Jan-2021 | 07:41 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5882.1     | 1020816   | 26-Jan-2021 | 07:39 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5882.1     | 1020824   | 26-Jan-2021 | 07:39 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.5882.1     | 1341848   | 26-Jan-2021 | 07:39 | x86      |
| Microsoft.analysisservices.dll              | 13.0.5882.1     | 695704    | 26-Jan-2021 | 07:39 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.5882.1     | 758672    | 26-Jan-2021 | 07:40 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.5882.1     | 513944    | 26-Jan-2021 | 07:39 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5882.1     | 705424    | 26-Jan-2021 | 07:38 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5882.1     | 705432    | 26-Jan-2021 | 07:39 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5882.1 | 68504     | 26-Jan-2021 | 07:38 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5882.1 | 65944     | 26-Jan-2021 | 07:43 | x86      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5882.1     | 562584    | 26-Jan-2021 | 07:43 | x86      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5882.1     | 562584    | 26-Jan-2021 | 07:49 | x86      |
| Msasxpress.dll                              | 2015.131.5882.1 | 29080     | 26-Jan-2021 | 07:39 | x64      |
| Msasxpress.dll                              | 2015.131.5882.1 | 24984     | 26-Jan-2021 | 07:40 | x86      |
| Pbsvcacctsync.dll                           | 2015.131.5882.1 | 65944     | 26-Jan-2021 | 07:39 | x64      |
| Pbsvcacctsync.dll                           | 2015.131.5882.1 | 53144     | 26-Jan-2021 | 07:41 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.131.5882.1 | 93592     | 26-Jan-2021 | 07:40 | x64      |
| Sqldumper.exe                               | 2015.131.5882.1 | 103832    | 26-Jan-2021 | 07:37 | x86      |
| Sqldumper.exe                               | 2015.131.5882.1 | 123288    | 26-Jan-2021 | 07:40 | x64      |
| Sqlftacct.dll                               | 2015.131.5882.1 | 44952     | 26-Jan-2021 | 07:39 | x64      |
| Sqlftacct.dll                               | 2015.131.5882.1 | 39832     | 26-Jan-2021 | 07:43 | x86      |
| Sqlmgmprovider.dll                          | 2015.131.5882.1 | 399256    | 26-Jan-2021 | 07:27 | x64      |
| Sqlmgmprovider.dll                          | 2015.131.5882.1 | 358808    | 26-Jan-2021 | 07:40 | x86      |
| Sqlsecacctchg.dll                           | 2015.131.5882.1 | 30616     | 26-Jan-2021 | 07:26 | x64      |
| Sqlsecacctchg.dll                           | 2015.131.5882.1 | 28056     | 26-Jan-2021 | 07:39 | x86      |
| Sqltdiagn.dll                               | 2015.131.5882.1 | 60816     | 26-Jan-2021 | 07:26 | x64      |
| Sqltdiagn.dll                               | 2015.131.5882.1 | 53648     | 26-Jan-2021 | 07:40 | x86      |

SQL Server 2016 sql_dreplay_client

| File name                      | File version    | File size | Date        | Time  | Platform |
|--------------------------------|-----------------|-----------|-------------|-------|----------|
| Dreplayclient.exe              | 2015.131.5882.1 | 114072    | 26-Jan-2021 | 007:38 | x86      |
| Dreplaycommon.dll              | 2015.131.5882.1 | 683920    | 26-Jan-2021 | 007:39 | x86      |
| Dreplayutil.dll                | 2015.131.5882.1 | 302992    | 26-Jan-2021 | 007:38 | x86      |
| Instapi130.dll                 | 2015.131.5882.1 | 54168     | 26-Jan-2021 | 007:40 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.131.5882.1 | 93592     | 26-Jan-2021 | 007:40 | x64      |
| Sqlresourceloader.dll          | 2015.131.5882.1 | 21400     | 26-Jan-2021 | 007:40 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2015.131.5882.1 | 683920    | 26-Jan-2021 | 07:39 | x86      |
| Dreplaycontroller.exe              | 2015.131.5882.1 | 343448    | 26-Jan-2021 | 07:38 | x86      |
| Dreplayprocess.dll                 | 2015.131.5882.1 | 164760    | 26-Jan-2021 | 07:37 | x86      |
| Instapi130.dll                     | 2015.131.5882.1 | 54168     | 26-Jan-2021 | 07:40 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.131.5882.1 | 93592     | 26-Jan-2021 | 07:40 | x64      |
| Sqlresourceloader.dll              | 2015.131.5882.1 | 21400     | 26-Jan-2021 | 07:40 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 13.0.5882.1     | 34192     | 26-Jan-2021 | 07:47  | x64      |
| Batchparser.dll                              | 2015.131.5882.1 | 173976    | 26-Jan-2021 | 07:40  | x64      |
| Datacollectorcontroller.dll                  | 2015.131.5882.1 | 218520    | 26-Jan-2021 | 07:40  | x64      |
| Dcexec.exe                                   | 2015.131.5882.1 | 67480     | 26-Jan-2021 | 07:47  | x64      |
| Fssres.dll                                   | 2015.131.5882.1 | 74648     | 26-Jan-2021 | 07:40  | x64      |
| Hadrres.dll                                  | 2015.131.5882.1 | 170904    | 26-Jan-2021 | 07:40  | x64      |
| Hkcompile.dll                                | 2015.131.5882.1 | 1291160   | 26-Jan-2021 | 07:40  | x64      |
| Hkengine.dll                                 | 2015.131.5882.1 | 5596056   | 26-Jan-2021 | 07:38  | x64      |
| Hkruntime.dll                                | 2015.131.5882.1 | 151960    | 26-Jan-2021 | 07:38  | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.5882.1     | 229784    | 26-Jan-2021 | 07:40  | x86      |
| Microsoft.sqlserver.types.dll                | 2015.131.5882.1 | 385944    | 26-Jan-2021 | 07:38  | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.131.5882.1 | 65424     | 26-Jan-2021 | 07:48  | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.131.5882.1 | 58264     | 26-Jan-2021 | 07:38  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5882.1 | 143248    | 26-Jan-2021 | 07:38  | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5882.1 | 151968    | 26-Jan-2021 | 07:38  | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.131.5882.1 | 265112    | 26-Jan-2021 | 07:38  | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.131.5882.1 | 67992     | 26-Jan-2021 | 07:38  | x64      |
| Odsole70.dll                                 | 2015.131.5882.1 | 85912     | 26-Jan-2021 | 07:39  | x64      |
| Opends60.dll                                 | 2015.131.5882.1 | 26008     | 26-Jan-2021 | 07:40  | x64      |
| Qds.dll                                      | 2015.131.5882.1 | 889744    | 26-Jan-2021 | 07:39  | x64      |
| Rsfxft.dll                                   | 2015.131.5882.1 | 27536     | 26-Jan-2021 | 07:40  | x64      |
| Sqagtres.dll                                 | 2015.131.5882.1 | 57752     | 26-Jan-2021 | 07:39  | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.131.5882.1 | 93592     | 26-Jan-2021 | 07:40  | x64      |
| Sqlaamss.dll                                 | 2015.131.5882.1 | 73624     | 26-Jan-2021 | 07:48  | x64      |
| Sqlaccess.dll                                | 2015.131.5882.1 | 456088    | 26-Jan-2021 | 07:40  | x64      |
| Sqlagent.exe                                 | 2015.131.5882.1 | 559512    | 26-Jan-2021 | 07:49  | x64      |
| Sqlagentctr130.dll                           | 2015.131.5882.1 | 44952     | 26-Jan-2021 | 07:40  | x64      |
| Sqlagentctr130.dll                           | 2015.131.5882.1 | 37272     | 26-Jan-2021 | 07:40  | x86      |
| Sqlagentlog.dll                              | 2015.131.5882.1 | 26008     | 26-Jan-2021 | 07:39  | x64      |
| Sqlagentmail.dll                             | 2015.131.5882.1 | 40856     | 26-Jan-2021 | 07:47  | x64      |
| Sqlboot.dll                                  | 2015.131.5882.1 | 179592    | 26-Jan-2021 | 07:39  | x64      |
| Sqlceip.exe                                  | 13.0.5882.1     | 249240    | 26-Jan-2021 | 07:39  | x86      |
| Sqlcmdss.dll                                 | 2015.131.5882.1 | 53144     | 26-Jan-2021 | 07:39  | x64      |
| Sqldk.dll                                    | 2015.131.5882.1 | 2588048   | 26-Jan-2021 | 07:39  | x64      |
| Sqldtsss.dll                                 | 2015.131.5882.1 | 90512     | 26-Jan-2021 | 07:47  | x64      |
| Sqliosim.com                                 | 2015.131.5882.1 | 300952    | 26-Jan-2021 | 07:39  | x64      |
| Sqliosim.exe                                 | 2015.131.5882.1 | 3007376   | 26-Jan-2021 | 07:51  | x64      |
| Sqllang.dll                                  | 2015.131.5882.1 | 39538064  | 26-Jan-2021 | 07:40  | x64      |
| Sqlmin.dll                                   | 2015.131.5882.1 | 37955984  | 26-Jan-2021 | 07:27  | x64      |
| Sqlolapss.dll                                | 2015.131.5882.1 | 91032     | 26-Jan-2021 | 07:52  | x64      |
| Sqlos.dll                                    | 2015.131.5882.1 | 19352     | 26-Jan-2021 | 07:40  | x64      |
| Sqlpowershellss.dll                          | 2015.131.5882.1 | 51608     | 26-Jan-2021 | 07:27  | x64      |
| Sqlrepss.dll                                 | 2015.131.5882.1 | 48024     | 26-Jan-2021 | 07:26  | x64      |
| Sqlresld.dll                                 | 2015.131.5882.1 | 23960     | 26-Jan-2021 | 07:27  | x64      |
| Sqlresourceloader.dll                        | 2015.131.5882.1 | 23960     | 26-Jan-2021 | 07:27  | x64      |
| Sqlscm.dll                                   | 2015.131.5882.1 | 54168     | 26-Jan-2021 | 07:40  | x64      |
| Sqlscriptdowngrade.dll                       | 2015.131.5882.1 | 20888     | 26-Jan-2021 | 07:27  | x64      |
| Sqlscriptupgrade.dll                         | 2015.131.5882.1 | 5804944   | 26-Jan-2021 | 07:40  | x64      |
| Sqlserverspatial130.dll                      | 2015.131.5882.1 | 725912    | 26-Jan-2021 | 07:40  | x64      |
| Sqlservr.exe                                 | 2015.131.5882.1 | 385936    | 26-Jan-2021 | 07:47  | x64      |
| Sqlsvc.dll                                   | 2015.131.5882.1 | 145304    | 26-Jan-2021 | 07:26  | x64      |
| Sqltses.dll                                  | 2015.131.5882.1 | 8916376   | 26-Jan-2021 | 07:27  | x64      |
| Sqsrvres.dll                                 | 2015.131.5882.1 | 244120    | 26-Jan-2021 | 07:27  | x64      |
| Xe.dll                                       | 2015.131.5882.1 | 619416    | 26-Jan-2021 | 07:40  | x64      |
| Xmlrw.dll                                    | 2015.131.5882.1 | 312216    | 26-Jan-2021 | 07:40  | x64      |
| Xmlrwbin.dll                                 | 2015.131.5882.1 | 220568    | 26-Jan-2021 | 07:40  | x64      |
| Xpadsi.exe                                   | 2015.131.5882.1 | 72088     | 26-Jan-2021 | 07:41  | x64      |
| Xplog70.dll                                  | 2015.131.5882.1 | 58776     | 26-Jan-2021 | 07:40  | x64      |
| Xpsqlbot.dll                                 | 2015.131.5882.1 | 26520     | 26-Jan-2021 | 07:39  | x64      |
| Xpstar.dll                                   | 2015.131.5882.1 | 415640    | 26-Jan-2021 | 07:39  | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                  | File version    | File size | Date      | Time | Platform |
|----------------------------------------------|-----------------|-----------|-----------|------|----------|
| Batchparser.dll                              | 2015.131.5882.1 | 153496    | 26-Jan-2021 | 07:37 | x86      |
| Batchparser.dll                              | 2015.131.5882.1 | 173976    | 26-Jan-2021 | 07:40 | x64      |
| Bcp.exe                                      | 2015.131.5882.1 | 113048    | 26-Jan-2021 | 07:40 | x64      |
| Commanddest.dll                              | 2015.131.5882.1 | 242072    | 26-Jan-2021 | 07:40 | x64      |
| Datacollectorenumerators.dll                 | 2015.131.5882.1 | 108944    | 26-Jan-2021 | 07:40 | x64      |
| Datacollectortasks.dll                       | 2015.131.5882.1 | 181136    | 26-Jan-2021 | 07:40 | x64      |
| Distrib.exe                                  | 2015.131.5882.1 | 184208    | 26-Jan-2021 | 07:47 | x64      |
| Dteparse.dll                                 | 2015.131.5882.1 | 102808    | 26-Jan-2021 | 07:40 | x64      |
| Dteparsemgd.dll                              | 2015.131.5882.1 | 81816     | 26-Jan-2021 | 07:39 | x64      |
| Dtepkg.dll                                   | 2015.131.5882.1 | 130456    | 26-Jan-2021 | 07:40 | x64      |
| Dtexec.exe                                   | 2015.131.5882.1 | 65944     | 26-Jan-2021 | 07:48 | x64      |
| Dts.dll                                      | 2015.131.5882.1 | 3139480   | 26-Jan-2021 | 07:40 | x64      |
| Dtscomexpreval.dll                           | 2015.131.5882.1 | 470424    | 26-Jan-2021 | 07:40 | x64      |
| Dtsconn.dll                                  | 2015.131.5882.1 | 485776    | 26-Jan-2021 | 07:40 | x64      |
| Dtshost.exe                                  | 2015.131.5882.1 | 79768     | 26-Jan-2021 | 07:50 | x64      |
| Dtslog.dll                                   | 2015.131.5882.1 | 113552    | 26-Jan-2021 | 07:40 | x64      |
| Dtsmsg130.dll                                | 2015.131.5882.1 | 538520    | 26-Jan-2021 | 07:40 | x64      |
| Dtspipeline.dll                              | 2015.131.5882.1 | 1272208   | 26-Jan-2021 | 07:40 | x64      |
| Dtspipelineperf130.dll                       | 2015.131.5882.1 | 41368     | 26-Jan-2021 | 07:40 | x64      |
| Dtuparse.dll                                 | 2015.131.5882.1 | 80792     | 26-Jan-2021 | 07:40 | x64      |
| Dtutil.exe                                   | 2015.131.5882.1 | 127888    | 26-Jan-2021 | 07:48 | x64      |
| Exceldest.dll                                | 2015.131.5882.1 | 256408    | 26-Jan-2021 | 07:39 | x64      |
| Excelsrc.dll                                 | 2015.131.5882.1 | 278424    | 26-Jan-2021 | 07:40 | x64      |
| Execpackagetask.dll                          | 2015.131.5882.1 | 159640    | 26-Jan-2021 | 07:40 | x64      |
| Flatfiledest.dll                             | 2015.131.5882.1 | 382360    | 26-Jan-2021 | 07:39 | x64      |
| Flatfilesrc.dll                              | 2015.131.5882.1 | 394648    | 26-Jan-2021 | 07:39 | x64      |
| Foreachfileenumerator.dll                    | 2015.131.5882.1 | 89496     | 26-Jan-2021 | 07:39 | x64      |
| Hkengperfctrs.dll                            | 2015.131.5882.1 | 52112     | 26-Jan-2021 | 07:40 | x64      |
| Logread.exe                                  | 2015.131.5882.1 | 619928    | 26-Jan-2021 | 07:48 | x64      |
| Microsoft.analysisservices.applocal.core.dll | 13.0.5882.1     | 1307032   | 26-Jan-2021 | 07:40 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll | 13.0.5882.1     | 385432    | 26-Jan-2021 | 07:43 | x86      |
| Microsoft.sqlserver.replication.dll          | 2015.131.5882.1 | 1644440   | 26-Jan-2021 | 07:48 | x64      |
| Microsoft.sqlserver.rmo.dll                  | 13.0.5882.1     | 562584    | 26-Jan-2021 | 07:43 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5882.1 | 143248    | 26-Jan-2021 | 07:38 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5882.1 | 151968    | 26-Jan-2021 | 07:38 | x64      |
| Msdtssrvrutil.dll                            | 2015.131.5882.1 | 94616     | 26-Jan-2021 | 07:39 | x64      |
| Msxmlsql.dll                                 | 2015.131.5882.1 | 1487768   | 26-Jan-2021 | 07:40 | x64      |
| Oledbdest.dll                                | 2015.131.5882.1 | 257424    | 26-Jan-2021 | 07:39 | x64      |
| Oledbsrc.dll                                 | 2015.131.5882.1 | 284056    | 26-Jan-2021 | 07:39 | x64      |
| Osql.exe                                     | 2015.131.5882.1 | 68504     | 26-Jan-2021 | 07:40 | x64      |
| Rawdest.dll                                  | 2015.131.5882.1 | 202648    | 26-Jan-2021 | 07:39 | x64      |
| Rawsource.dll                                | 2015.131.5882.1 | 189848    | 26-Jan-2021 | 07:39 | x64      |
| Rdistcom.dll                                 | 2015.131.5882.1 | 900504    | 26-Jan-2021 | 07:39 | x64      |
| Recordsetdest.dll                            | 2015.131.5882.1 | 180112    | 26-Jan-2021 | 07:39 | x64      |
| Repldp.dll                                   | 2015.131.5882.1 | 274832    | 26-Jan-2021 | 07:39 | x64      |
| Replmerg.exe                                 | 2015.131.5882.1 | 511896    | 26-Jan-2021 | 07:47 | x64      |
| Replprov.dll                                 | 2015.131.5882.1 | 805264    | 26-Jan-2021 | 07:39 | x64      |
| Replrec.dll                                  | 2015.131.5882.1 | 1012120   | 26-Jan-2021 | 07:48 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2015.131.5882.1 | 93592     | 26-Jan-2021 | 07:40 | x64      |
| Sqlcmd.exe                                   | 2015.131.5882.1 | 242584    | 26-Jan-2021 | 07:40 | x64      |
| Sqldiag.exe                                  | 2015.131.5882.1 | 1250712   | 26-Jan-2021 | 07:49 | x64      |
| Sqllogship.exe                               | 13.0.5882.1     | 97688     | 26-Jan-2021 | 07:40 | x64      |
| Sqlresld.dll                                 | 2015.131.5882.1 | 23960     | 26-Jan-2021 | 07:27 | x64      |
| Sqlresld.dll                                 | 2015.131.5882.1 | 21904     | 26-Jan-2021 | 07:40 | x86      |
| Sqlresourceloader.dll                        | 2015.131.5882.1 | 23960     | 26-Jan-2021 | 07:27 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5882.1 | 21400     | 26-Jan-2021 | 07:40 | x86      |
| Sqlscm.dll                                   | 2015.131.5882.1 | 45976     | 26-Jan-2021 | 07:40 | x86      |
| Sqlscm.dll                                   | 2015.131.5882.1 | 54168     | 26-Jan-2021 | 07:40 | x64      |
| Sqlsvc.dll                                   | 2015.131.5882.1 | 145304    | 26-Jan-2021 | 07:26 | x64      |
| Sqlsvc.dll                                   | 2015.131.5882.1 | 120216    | 26-Jan-2021 | 07:39 | x86      |
| Sqltaskconnections.dll                       | 2015.131.5882.1 | 173976    | 26-Jan-2021 | 07:27 | x64      |
| Sqlwep130.dll                                | 2015.131.5882.1 | 98712     | 26-Jan-2021 | 07:26 | x64      |
| Ssisoledb.dll                                | 2015.131.5882.1 | 209296    | 26-Jan-2021 | 07:26 | x64      |
| Tablediff.exe                                | 13.0.5882.1     | 79760     | 26-Jan-2021 | 07:40 | x64      |
| Txagg.dll                                    | 2015.131.5882.1 | 357784    | 26-Jan-2021 | 07:26 | x64      |
| Txbdd.dll                                    | 2015.131.5882.1 | 165784    | 26-Jan-2021 | 07:26 | x64      |
| Txdatacollector.dll                          | 2015.131.5882.1 | 360848    | 26-Jan-2021 | 07:26 | x64      |
| Txdataconvert.dll                            | 2015.131.5882.1 | 289688    | 26-Jan-2021 | 07:27 | x64      |
| Txderived.dll                                | 2015.131.5882.1 | 600984    | 26-Jan-2021 | 07:26 | x64      |
| Txlookup.dll                                 | 2015.131.5882.1 | 525200    | 26-Jan-2021 | 07:26 | x64      |
| Txmerge.dll                                  | 2015.131.5882.1 | 223640    | 26-Jan-2021 | 07:26 | x64      |
| Txmergejoin.dll                              | 2015.131.5882.1 | 271760    | 26-Jan-2021 | 07:26 | x64      |
| Txmulticast.dll                              | 2015.131.5882.1 | 121240    | 26-Jan-2021 | 07:26 | x64      |
| Txrowcount.dll                               | 2015.131.5882.1 | 119704    | 26-Jan-2021 | 07:26 | x64      |
| Txsort.dll                                   | 2015.131.5882.1 | 252312    | 26-Jan-2021 | 07:26 | x64      |
| Txsplit.dll                                  | 2015.131.5882.1 | 593816    | 26-Jan-2021 | 07:26 | x64      |
| Txunionall.dll                               | 2015.131.5882.1 | 175000    | 26-Jan-2021 | 07:26 | x64      |
| Xe.dll                                       | 2015.131.5882.1 | 619416    | 26-Jan-2021 | 07:40 | x64      |
| Xmlrw.dll                                    | 2015.131.5882.1 | 312216    | 26-Jan-2021 | 07:40 | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date      | Time | Platform |
|-------------------------------|-----------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2015.131.5882.1 | 1008536   | 26-Jan-2021 | 07:40 | x64      |
| Sql_extensibility_keyfile.dll | 2015.131.5882.1 | 93592     | 26-Jan-2021 | 07:40 | x64      |
| Sqlsatellite.dll              | 2015.131.5882.1 | 831376    | 26-Jan-2021 | 07:40 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version    | File size | Date      | Time | Platform |
|--------------------------|-----------------|-----------|-----------|------|----------|
| Fd.dll                   | 2015.131.5882.1 | 653208    | 26-Jan-2021 | 07:40 | x64      |
| Fdhost.exe               | 2015.131.5882.1 | 98192     | 26-Jan-2021 | 07:40 | x64      |
| Fdlauncher.exe           | 2015.131.5882.1 | 44440     | 26-Jan-2021 | 07:40 | x64      |
| Sql_fulltext_keyfile.dll | 2015.131.5882.1 | 93592     | 26-Jan-2021 | 07:40 | x64      |
| Sqlft130ph.dll           | 2015.131.5882.1 | 51096     | 26-Jan-2021 | 07:41 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version    | File size | Date      | Time | Platform |
|-------------------------|-----------------|-----------|-----------|------|----------|
| Imrdll.dll              | 13.0.5882.1     | 16784     | 26-Jan-2021 | 07:39 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.131.5882.1 | 93592     | 26-Jan-2021 | 07:40 | x64      |

SQL Server 2016 Integration Services

| File   name                                                   | File version    | File size | Date      | Time  | Platform |
|---------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 4.0.0.111       | 77944     | 04-Oct-2019  | 18:46 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 4.0.0.111       | 77944     | 06-Mar-2020  | 18:46 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 4.0.0.111       | 37496     | 04-Oct-2019  | 18:46 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 4.0.0.111       | 37496     | 06-Mar-2020  | 18:46 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 4.0.0.111       | 78456     | 04-Oct-2019  | 18:46 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 4.0.0.111       | 78456     | 06-Mar-2020  | 18:46 | x86      |
| Commanddest.dll                                               | 2015.131.5882.1 | 195992    | 26-Jan-2021 | 07:37  | x86      |
| Commanddest.dll                                               | 2015.131.5882.1 | 242072    | 26-Jan-2021 | 07:40  | x64      |
| Dteparse.dll                                                  | 2015.131.5882.1 | 92568     | 26-Jan-2021 | 07:37  | x86      |
| Dteparse.dll                                                  | 2015.131.5882.1 | 102808    | 26-Jan-2021 | 07:40  | x64      |
| Dteparsemgd.dll                                               | 2015.131.5882.1 | 81816     | 26-Jan-2021 | 07:39  | x64      |
| Dteparsemgd.dll                                               | 2015.131.5882.1 | 76696     | 26-Jan-2021 | 07:40  | x86      |
| Dtepkg.dll                                                    | 2015.131.5882.1 | 108952    | 26-Jan-2021 | 07:37  | x86      |
| Dtepkg.dll                                                    | 2015.131.5882.1 | 130456    | 26-Jan-2021 | 07:40  | x64      |
| Dtexec.exe                                                    | 2015.131.5882.1 | 59792     | 26-Jan-2021 | 07:38  | x86      |
| Dtexec.exe                                                    | 2015.131.5882.1 | 65944     | 26-Jan-2021 | 07:48  | x64      |
| Dts.dll                                                       | 2015.131.5882.1 | 2625944   | 26-Jan-2021 | 07:37  | x86      |
| Dts.dll                                                       | 2015.131.5882.1 | 3139480   | 26-Jan-2021 | 07:40  | x64      |
| Dtscomexpreval.dll                                            | 2015.131.5882.1 | 412056    | 26-Jan-2021 | 07:38  | x86      |
| Dtscomexpreval.dll                                            | 2015.131.5882.1 | 470424    | 26-Jan-2021 | 07:40  | x64      |
| Dtsconn.dll                                                   | 2015.131.5882.1 | 385432    | 26-Jan-2021 | 07:37  | x86      |
| Dtsconn.dll                                                   | 2015.131.5882.1 | 485776    | 26-Jan-2021 | 07:40  | x64      |
| Dtsdebughost.exe                                              | 2015.131.5882.1 | 86928     | 26-Jan-2021 | 07:39  | x86      |
| Dtsdebughost.exe                                              | 2015.131.5882.1 | 102808    | 26-Jan-2021 | 07:49  | x64      |
| Dtshost.exe                                                   | 2015.131.5882.1 | 69528     | 26-Jan-2021 | 07:38  | x86      |
| Dtshost.exe                                                   | 2015.131.5882.1 | 79768     | 26-Jan-2021 | 07:50  | x64      |
| Dtslog.dll                                                    | 2015.131.5882.1 | 96152     | 26-Jan-2021 | 07:37  | x86      |
| Dtslog.dll                                                    | 2015.131.5882.1 | 113552    | 26-Jan-2021 | 07:40  | x64      |
| Dtsmsg130.dll                                                 | 2015.131.5882.1 | 534424    | 26-Jan-2021 | 07:37  | x86      |
| Dtsmsg130.dll                                                 | 2015.131.5882.1 | 538520    | 26-Jan-2021 | 07:40  | x64      |
| Dtspipeline.dll                                               | 2015.131.5882.1 | 1052568   | 26-Jan-2021 | 07:37  | x86      |
| Dtspipeline.dll                                               | 2015.131.5882.1 | 1272208   | 26-Jan-2021 | 07:40  | x64      |
| Dtspipelineperf130.dll                                        | 2015.131.5882.1 | 35224     | 26-Jan-2021 | 07:37  | x86      |
| Dtspipelineperf130.dll                                        | 2015.131.5882.1 | 41368     | 26-Jan-2021 | 07:40  | x64      |
| Dtuparse.dll                                                  | 2015.131.5882.1 | 73104     | 26-Jan-2021 | 07:37  | x86      |
| Dtuparse.dll                                                  | 2015.131.5882.1 | 80792     | 26-Jan-2021 | 07:40  | x64      |
| Dtutil.exe                                                    | 2015.131.5882.1 | 108440    | 26-Jan-2021 | 07:38  | x86      |
| Dtutil.exe                                                    | 2015.131.5882.1 | 127888    | 26-Jan-2021 | 07:48  | x64      |
| Exceldest.dll                                                 | 2015.131.5882.1 | 209808    | 26-Jan-2021 | 07:38  | x86      |
| Exceldest.dll                                                 | 2015.131.5882.1 | 256408    | 26-Jan-2021 | 07:39  | x64      |
| Excelsrc.dll                                                  | 2015.131.5882.1 | 225680    | 26-Jan-2021 | 07:37  | x86      |
| Excelsrc.dll                                                  | 2015.131.5882.1 | 278424    | 26-Jan-2021 | 07:40  | x64      |
| Execpackagetask.dll                                           | 2015.131.5882.1 | 128400    | 26-Jan-2021 | 07:37  | x86      |
| Execpackagetask.dll                                           | 2015.131.5882.1 | 159640    | 26-Jan-2021 | 07:40  | x64      |
| Flatfiledest.dll                                              | 2015.131.5882.1 | 327576    | 26-Jan-2021 | 07:37  | x86      |
| Flatfiledest.dll                                              | 2015.131.5882.1 | 382360    | 26-Jan-2021 | 07:39  | x64      |
| Flatfilesrc.dll                                               | 2015.131.5882.1 | 338328    | 26-Jan-2021 | 07:37  | x86      |
| Flatfilesrc.dll                                               | 2015.131.5882.1 | 394648    | 26-Jan-2021 | 07:39  | x64      |
| Foreachfileenumerator.dll                                     | 2015.131.5882.1 | 73624     | 26-Jan-2021 | 07:37  | x86      |
| Foreachfileenumerator.dll                                     | 2015.131.5882.1 | 89496     | 26-Jan-2021 | 07:39  | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 13.0.5882.1     | 1307032   | 26-Jan-2021 | 07:39  | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 13.0.5882.1     | 1307032   | 26-Jan-2021 | 07:40  | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 13.0.5882.1     | 66456     | 26-Jan-2021 | 07:40  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2015.131.5882.1 | 100248    | 26-Jan-2021 | 07:38  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2015.131.5882.1 | 105368    | 26-Jan-2021 | 07:40  | x64      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.5882.1     | 478616    | 26-Jan-2021 | 07:40  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.5882.1     | 478616    | 26-Jan-2021 | 07:44  | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 13.0.5882.1     | 75672     | 26-Jan-2021 | 07:50  | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 13.0.5882.1     | 75672     | 26-Jan-2021 | 0:20  | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 13.0.5882.1     | 385432    | 26-Jan-2021 | 07:43  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2015.131.5882.1 | 143248    | 26-Jan-2021 | 07:38  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2015.131.5882.1 | 131992    | 26-Jan-2021 | 07:40  | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2015.131.5882.1 | 151968    | 26-Jan-2021 | 07:38  | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2015.131.5882.1 | 137624    | 26-Jan-2021 | 07:40  | x86      |
| Msdtssrvr.exe                                                 | 13.0.5882.1     | 210328    | 26-Jan-2021 | 07:40  | x64      |
| Msdtssrvrutil.dll                                             | 2015.131.5882.1 | 94616     | 26-Jan-2021 | 07:39  | x64      |
| Msdtssrvrutil.dll                                             | 2015.131.5882.1 | 83352     | 26-Jan-2021 | 07:40  | x86      |
| Oledbdest.dll                                                 | 2015.131.5882.1 | 257424    | 26-Jan-2021 | 07:39  | x64      |
| Oledbdest.dll                                                 | 2015.131.5882.1 | 209816    | 26-Jan-2021 | 07:40  | x86      |
| Oledbsrc.dll                                                  | 2015.131.5882.1 | 284056    | 26-Jan-2021 | 07:39  | x64      |
| Oledbsrc.dll                                                  | 2015.131.5882.1 | 228760    | 26-Jan-2021 | 07:40  | x86      |
| Rawdest.dll                                                   | 2015.131.5882.1 | 202648    | 26-Jan-2021 | 07:39  | x64      |
| Rawdest.dll                                                   | 2015.131.5882.1 | 161688    | 26-Jan-2021 | 07:40  | x86      |
| Rawsource.dll                                                 | 2015.131.5882.1 | 189848    | 26-Jan-2021 | 07:39  | x64      |
| Rawsource.dll                                                 | 2015.131.5882.1 | 148376    | 26-Jan-2021 | 07:41  | x86      |
| Recordsetdest.dll                                             | 2015.131.5882.1 | 180112    | 26-Jan-2021 | 07:39  | x64      |
| Recordsetdest.dll                                             | 2015.131.5882.1 | 144792    | 26-Jan-2021 | 07:40  | x86      |
| Sql_is_keyfile.dll                                            | 2015.131.5882.1 | 93592     | 26-Jan-2021 | 07:40  | x64      |
| Sqlceip.exe                                                   | 13.0.5882.1     | 249240    | 26-Jan-2021 | 07:39  | x86      |
| Sqldest.dll                                                   | 2015.131.5882.1 | 256912    | 26-Jan-2021 | 07:39  | x64      |
| Sqldest.dll                                                   | 2015.131.5882.1 | 208792    | 26-Jan-2021 | 07:40  | x86      |
| Sqltaskconnections.dll                                        | 2015.131.5882.1 | 173976    | 26-Jan-2021 | 07:27  | x64      |
| Sqltaskconnections.dll                                        | 2015.131.5882.1 | 144280    | 26-Jan-2021 | 07:40  | x86      |
| Ssisoledb.dll                                                 | 2015.131.5882.1 | 209296    | 26-Jan-2021 | 07:26  | x64      |
| Ssisoledb.dll                                                 | 2015.131.5882.1 | 169872    | 26-Jan-2021 | 07:40  | x86      |
| Txagg.dll                                                     | 2015.131.5882.1 | 357784    | 26-Jan-2021 | 07:26  | x64      |
| Txagg.dll                                                     | 2015.131.5882.1 | 297880    | 26-Jan-2021 | 07:39  | x86      |
| Txbdd.dll                                                     | 2015.131.5882.1 | 165784    | 26-Jan-2021 | 07:26  | x64      |
| Txbdd.dll                                                     | 2015.131.5882.1 | 130968    | 26-Jan-2021 | 07:40  | x86      |
| Txbestmatch.dll                                               | 2015.131.5882.1 | 604568    | 26-Jan-2021 | 07:27  | x64      |
| Txbestmatch.dll                                               | 2015.131.5882.1 | 489368    | 26-Jan-2021 | 07:39  | x86      |
| Txcache.dll                                                   | 2015.131.5882.1 | 176536    | 26-Jan-2021 | 07:26  | x64      |
| Txcache.dll                                                   | 2015.131.5882.1 | 141208    | 26-Jan-2021 | 07:39  | x86      |
| Txcharmap.dll                                                 | 2015.131.5882.1 | 283024    | 26-Jan-2021 | 07:26  | x64      |
| Txcharmap.dll                                                 | 2015.131.5882.1 | 243608    | 26-Jan-2021 | 07:39  | x86      |
| Txcopymap.dll                                                 | 2015.131.5882.1 | 176024    | 26-Jan-2021 | 07:26  | x64      |
| Txcopymap.dll                                                 | 2015.131.5882.1 | 140688    | 26-Jan-2021 | 07:39  | x86      |
| Txdataconvert.dll                                             | 2015.131.5882.1 | 289688    | 26-Jan-2021 | 07:27  | x64      |
| Txdataconvert.dll                                             | 2015.131.5882.1 | 248216    | 26-Jan-2021 | 07:39  | x86      |
| Txderived.dll                                                 | 2015.131.5882.1 | 600984    | 26-Jan-2021 | 07:26  | x64      |
| Txderived.dll                                                 | 2015.131.5882.1 | 512408    | 26-Jan-2021 | 07:39  | x86      |
| Txfileextractor.dll                                           | 2015.131.5882.1 | 194968    | 26-Jan-2021 | 07:26  | x64      |
| Txfileextractor.dll                                           | 2015.131.5882.1 | 156056    | 26-Jan-2021 | 07:40  | x86      |
| Txfileinserter.dll                                            | 2015.131.5882.1 | 192920    | 26-Jan-2021 | 07:26  | x64      |
| Txfileinserter.dll                                            | 2015.131.5882.1 | 154008    | 26-Jan-2021 | 07:40  | x86      |
| Txgroupdups.dll                                               | 2015.131.5882.1 | 284048    | 26-Jan-2021 | 07:26  | x64      |
| Txgroupdups.dll                                               | 2015.131.5882.1 | 224664    | 26-Jan-2021 | 07:40  | x86      |
| Txlineage.dll                                                 | 2015.131.5882.1 | 130968    | 26-Jan-2021 | 07:26  | x64      |
| Txlineage.dll                                                 | 2015.131.5882.1 | 102808    | 26-Jan-2021 | 07:39  | x86      |
| Txlookup.dll                                                  | 2015.131.5882.1 | 525200    | 26-Jan-2021 | 07:26  | x64      |
| Txlookup.dll                                                  | 2015.131.5882.1 | 442776    | 26-Jan-2021 | 07:40  | x86      |
| Txmerge.dll                                                   | 2015.131.5882.1 | 223640    | 26-Jan-2021 | 07:26  | x64      |
| Txmerge.dll                                                   | 2015.131.5882.1 | 169880    | 26-Jan-2021 | 07:39  | x86      |
| Txmergejoin.dll                                               | 2015.131.5882.1 | 271760    | 26-Jan-2021 | 07:26  | x64      |
| Txmergejoin.dll                                               | 2015.131.5882.1 | 216984    | 26-Jan-2021 | 07:39  | x86      |
| Txmulticast.dll                                               | 2015.131.5882.1 | 121240    | 26-Jan-2021 | 07:26  | x64      |
| Txmulticast.dll                                               | 2015.131.5882.1 | 95120     | 26-Jan-2021 | 07:39  | x86      |
| Txpivot.dll                                                   | 2015.131.5882.1 | 221072    | 26-Jan-2021 | 07:26  | x64      |
| Txpivot.dll                                                   | 2015.131.5882.1 | 175000    | 26-Jan-2021 | 07:39  | x86      |
| Txrowcount.dll                                                | 2015.131.5882.1 | 119704    | 26-Jan-2021 | 07:26  | x64      |
| Txrowcount.dll                                                | 2015.131.5882.1 | 94616     | 26-Jan-2021 | 07:39  | x86      |
| Txsampling.dll                                                | 2015.131.5882.1 | 165264    | 26-Jan-2021 | 07:26  | x64      |
| Txsampling.dll                                                | 2015.131.5882.1 | 127896    | 26-Jan-2021 | 07:39  | x86      |
| Txscd.dll                                                     | 2015.131.5882.1 | 213400    | 26-Jan-2021 | 07:27  | x64      |
| Txscd.dll                                                     | 2015.131.5882.1 | 162712    | 26-Jan-2021 | 07:40  | x86      |
| Txsort.dll                                                    | 2015.131.5882.1 | 252312    | 26-Jan-2021 | 07:26  | x64      |
| Txsort.dll                                                    | 2015.131.5882.1 | 204184    | 26-Jan-2021 | 07:39  | x86      |
| Txsplit.dll                                                   | 2015.131.5882.1 | 593816    | 26-Jan-2021 | 07:26  | x64      |
| Txsplit.dll                                                   | 2015.131.5882.1 | 506256    | 26-Jan-2021 | 07:39  | x86      |
| Txtermextraction.dll                                          | 2015.131.5882.1 | 8671128   | 26-Jan-2021 | 07:27  | x64      |
| Txtermextraction.dll                                          | 2015.131.5882.1 | 8608664   | 26-Jan-2021 | 07:40  | x86      |
| Txtermlookup.dll                                              | 2015.131.5882.1 | 4151704   | 26-Jan-2021 | 07:26  | x64      |
| Txtermlookup.dll                                              | 2015.131.5882.1 | 4099984   | 26-Jan-2021 | 07:39  | x86      |
| Txunionall.dll                                                | 2015.131.5882.1 | 175000    | 26-Jan-2021 | 07:26  | x64      |
| Txunionall.dll                                                | 2015.131.5882.1 | 131984    | 26-Jan-2021 | 07:39  | x86      |
| Txunpivot.dll                                                 | 2015.131.5882.1 | 194960    | 26-Jan-2021 | 07:26  | x64      |
| Txunpivot.dll                                                 | 2015.131.5882.1 | 155544    | 26-Jan-2021 | 07:41  | x86      |
| Xe.dll                                                        | 2015.131.5882.1 | 619416    | 26-Jan-2021 | 07:40  | x64      |
| Xe.dll                                                        | 2015.131.5882.1 | 551824    | 26-Jan-2021 | 07:49  | x86      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Dms.dll                                                              | 10.0.8224.49     | 483624    | 09-May-2019  | 19:33 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.49 | 75560     | 09-May-2019  | 19:33 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.49     | 45864     | 09-May-2019  | 19:33 | x86      |
| Instapi130.dll                                                       | 2015.131.5882.1  | 54168     | 26-Jan-2021 | 07:26  | x64      |
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
| Mpdwinterop.dll                                                      | 2015.131.5882.1  | 387992    | 26-Jan-2021 | 07:46  | x64      |
| Mpdwsvc.exe                                                          | 2015.131.5882.1  | 6612376   | 26-Jan-2021 | 07:43  | x64      |
| Pdwodbcsql11.dll                                                     | 2015.131.5882.1  | 2223512   | 26-Jan-2021 | 07:26  | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.49 | 47400     | 09-May-2019  | 19:33 | x64      |
| Sqldk.dll                                                            | 2015.131.5882.1  | 2532760   | 26-Jan-2021 | 07:26  | x64      |
| Sqldumper.exe                                                        | 2015.131.5882.1  | 123288    | 26-Jan-2021 | 07:41  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5882.1  | 1434512   | 26-Jan-2021 | 07:38  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5882.1  | 3749784   | 26-Jan-2021 | 07:46  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5882.1  | 3080600   | 26-Jan-2021 | 07:40  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5882.1  | 3751320   | 26-Jan-2021 | 07:46  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5882.1  | 3654552   | 26-Jan-2021 | 07:40  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5882.1  | 2002832   | 26-Jan-2021 | 07:40  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5882.1  | 1948568   | 26-Jan-2021 | 07:40  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5882.1  | 3436944   | 26-Jan-2021 | 07:47  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5882.1  | 3448728   | 26-Jan-2021 | 07:44  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5882.1  | 1384344   | 26-Jan-2021 | 07:41  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5882.1  | 3623832   | 26-Jan-2021 | 07:40  | x64      |
| Sqlos.dll                                                            | 2015.131.5882.1  | 19352     | 26-Jan-2021 | 07:25  | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.49 | 4348200   | 09-May-2019  | 19:33 | x64      |
| Sqltses.dll                                                          | 2015.131.5882.1  | 9085840   | 26-Jan-2021 | 07:27  | x64      |

SQL Server 2016 Reporting Services

| File   name                                               | File version    | File size | Date      | Time | Platform |
|-----------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Microsoft.analysisservices.modeling.dll                   | 13.0.5882.1     | 604056    | 26-Jan-2021 | 07:39 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.5882.1     | 1613720   | 26-Jan-2021 | 07:40 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.5882.1     | 651672    | 26-Jan-2021 | 07:38 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.5882.1     | 322968    | 26-Jan-2021 | 07:38 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.5882.1     | 1083800   | 26-Jan-2021 | 07:38 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5882.1     | 541584    | 26-Jan-2021 | 07:49 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5882.1     | 541592    | 26-Jan-2021 | 07:44 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5882.1     | 541592    | 26-Jan-2021 | 07:43 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5882.1     | 541592    | 26-Jan-2021 | 07:49 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5882.1     | 541592    | 26-Jan-2021 | 07:49 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5882.1     | 541592    | 26-Jan-2021 | 07:47 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5882.1     | 541592    | 26-Jan-2021 | 07:45 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5882.1     | 541592    | 26-Jan-2021 | 07:50 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5882.1     | 541592    | 26-Jan-2021 | 07:45 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5882.1     | 541592    | 26-Jan-2021 | 07:47 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.5882.1     | 156056    | 26-Jan-2021 | 07:38 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.5882.1     | 119192    | 26-Jan-2021 | 07:41 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.5882.1     | 6069656   | 26-Jan-2021 | 07:40 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5882.1     | 4504472   | 26-Jan-2021 | 07:49 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5882.1     | 4504984   | 26-Jan-2021 | 07:45 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5882.1     | 4504976   | 26-Jan-2021 | 07:42 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5882.1     | 4504984   | 26-Jan-2021 | 07:48 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5882.1     | 4505496   | 26-Jan-2021 | 07:49 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5882.1     | 4505496   | 26-Jan-2021 | 07:48 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5882.1     | 4504976   | 26-Jan-2021 | 07:46 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5882.1     | 4506008   | 26-Jan-2021 | 07:50 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5882.1     | 4504472   | 26-Jan-2021 | 07:44 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5882.1     | 4504976   | 26-Jan-2021 | 07:47 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.5882.1     | 10920856  | 26-Jan-2021 | 07:40 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.5882.1     | 96152     | 26-Jan-2021 | 07:40 | x64      |
| Microsoft.reportingservices.storage.dll                   | 13.0.5882.1     | 202136    | 26-Jan-2021 | 07:40 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.131.5882.1 | 40856     | 26-Jan-2021 | 07:40 | x64      |
| Microsoft.sqlserver.types.dll                             | 2015.131.5882.1 | 385944    | 26-Jan-2021 | 07:38 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.131.5882.1 | 390040    | 26-Jan-2021 | 07:45 | x86      |
| Msmdlocal.dll                                             | 2015.131.5882.1 | 56245144  | 26-Jan-2021 | 07:40 | x64      |
| Msmdlocal.dll                                             | 2015.131.5882.1 | 37127056  | 26-Jan-2021 | 07:41 | x86      |
| Msmgdsrv.dll                                              | 2015.131.5882.1 | 6502296   | 26-Jan-2021 | 07:45 | x86      |
| Msmgdsrv.dll                                              | 2015.131.5882.1 | 7502744   | 26-Jan-2021 | 07:50 | x64      |
| Msolap130.dll                                             | 2015.131.5882.1 | 8636312   | 26-Jan-2021 | 07:40 | x64      |
| Msolap130.dll                                             | 2015.131.5882.1 | 7003544   | 26-Jan-2021 | 07:42 | x86      |
| Msolui130.dll                                             | 2015.131.5882.1 | 303512    | 26-Jan-2021 | 07:39 | x64      |
| Msolui130.dll                                             | 2015.131.5882.1 | 280472    | 26-Jan-2021 | 07:41 | x86      |
| Reportingservicescompression.dll                          | 2015.131.5882.1 | 55704     | 26-Jan-2021 | 07:39 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.5882.1     | 77720     | 26-Jan-2021 | 07:51 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.5882.1     | 2536856   | 26-Jan-2021 | 07:51 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.131.5882.1 | 107416    | 26-Jan-2021 | 07:45 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.131.5882.1 | 101776    | 26-Jan-2021 | 07:48 | x64      |
| Reportingservicesnativeserver.dll                         | 2015.131.5882.1 | 92056     | 26-Jan-2021 | 07:49 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.5882.1     | 2722704   | 26-Jan-2021 | 07:49 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5882.1     | 877464    | 26-Jan-2021 | 07:39 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5882.1     | 881560    | 26-Jan-2021 | 07:43 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5882.1     | 881560    | 26-Jan-2021 | 07:42 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5882.1     | 881560    | 26-Jan-2021 | 07:47 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5882.1     | 885656    | 26-Jan-2021 | 07:43 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5882.1     | 881560    | 26-Jan-2021 | 07:48 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5882.1     | 881560    | 26-Jan-2021 | 07:40 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5882.1     | 893840    | 26-Jan-2021 | 07:44 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5882.1     | 877464    | 26-Jan-2021 | 07:46 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5882.1     | 881552    | 26-Jan-2021 | 07:44 | x86      |
| Rshttpruntime.dll                                         | 2015.131.5882.1 | 92568     | 26-Jan-2021 | 07:47 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.131.5882.1 | 93592     | 26-Jan-2021 | 07:40 | x64      |
| Sqldumper.exe                                             | 2015.131.5882.1 | 103832    | 26-Jan-2021 | 07:37 | x86      |
| Sqldumper.exe                                             | 2015.131.5882.1 | 123288    | 26-Jan-2021 | 07:40 | x64      |
| Sqlrsos.dll                                               | 2015.131.5882.1 | 19352     | 26-Jan-2021 | 07:27 | x64      |
| Sqlserverspatial130.dll                                   | 2015.131.5882.1 | 577432    | 26-Jan-2021 | 07:40 | x86      |
| Sqlserverspatial130.dll                                   | 2015.131.5882.1 | 725912    | 26-Jan-2021 | 07:40 | x64      |
| Xmlrw.dll                                                 | 2015.131.5882.1 | 252824    | 26-Jan-2021 | 07:39 | x86      |
| Xmlrw.dll                                                 | 2015.131.5882.1 | 312216    | 26-Jan-2021 | 07:40 | x64      |
| Xmlrwbin.dll                                              | 2015.131.5882.1 | 184728    | 26-Jan-2021 | 07:39 | x86      |
| Xmlrwbin.dll                                              | 2015.131.5882.1 | 220568    | 26-Jan-2021 | 07:40 | x64      |
| Xmsrv.dll                                                 | 2015.131.5882.1 | 24041872  | 26-Jan-2021 | 07:27 | x64      |
| Xmsrv.dll                                                 | 2015.131.5882.1 | 32720792  | 26-Jan-2021 | 07:40 | x86      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Smrdll.dll                         | 13.0.5882.1     | 16792     | 26-Jan-2021 | 07:48 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.131.5882.1 | 93592     | 26-Jan-2021 | 07:40 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                    | File version    | File size | Date      | Time | Platform |
|------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                  | 2015.131.5882.1 | 1304976   | 26-Jan-2021 | 07:37 | x86      |
| Ddsshapes.dll                                  | 2015.131.5882.1 | 128920    | 26-Jan-2021 | 07:38 | x86      |
| Dtaengine.exe                                  | 2015.131.5882.1 | 160152    | 26-Jan-2021 | 07:39 | x86      |
| Dteparse.dll                                   | 2015.131.5882.1 | 92568     | 26-Jan-2021 | 07:37 | x86      |
| Dteparse.dll                                   | 2015.131.5882.1 | 102808    | 26-Jan-2021 | 07:40 | x64      |
| Dteparsemgd.dll                                | 2015.131.5882.1 | 81816     | 26-Jan-2021 | 07:39 | x64      |
| Dteparsemgd.dll                                | 2015.131.5882.1 | 76696     | 26-Jan-2021 | 07:40 | x86      |
| Dtepkg.dll                                     | 2015.131.5882.1 | 108952    | 26-Jan-2021 | 07:37 | x86      |
| Dtepkg.dll                                     | 2015.131.5882.1 | 130456    | 26-Jan-2021 | 07:40 | x64      |
| Dtexec.exe                                     | 2015.131.5882.1 | 59792     | 26-Jan-2021 | 07:38 | x86      |
| Dtexec.exe                                     | 2015.131.5882.1 | 65944     | 26-Jan-2021 | 07:48 | x64      |
| Dts.dll                                        | 2015.131.5882.1 | 2625944   | 26-Jan-2021 | 07:37 | x86      |
| Dts.dll                                        | 2015.131.5882.1 | 3139480   | 26-Jan-2021 | 07:40 | x64      |
| Dtscomexpreval.dll                             | 2015.131.5882.1 | 412056    | 26-Jan-2021 | 07:38 | x86      |
| Dtscomexpreval.dll                             | 2015.131.5882.1 | 470424    | 26-Jan-2021 | 07:40 | x64      |
| Dtsconn.dll                                    | 2015.131.5882.1 | 385432    | 26-Jan-2021 | 07:37 | x86      |
| Dtsconn.dll                                    | 2015.131.5882.1 | 485776    | 26-Jan-2021 | 07:40 | x64      |
| Dtshost.exe                                    | 2015.131.5882.1 | 69528     | 26-Jan-2021 | 07:38 | x86      |
| Dtshost.exe                                    | 2015.131.5882.1 | 79768     | 26-Jan-2021 | 07:50 | x64      |
| Dtslog.dll                                     | 2015.131.5882.1 | 96152     | 26-Jan-2021 | 07:37 | x86      |
| Dtslog.dll                                     | 2015.131.5882.1 | 113552    | 26-Jan-2021 | 07:40 | x64      |
| Dtsmsg130.dll                                  | 2015.131.5882.1 | 534424    | 26-Jan-2021 | 07:37 | x86      |
| Dtsmsg130.dll                                  | 2015.131.5882.1 | 538520    | 26-Jan-2021 | 07:40 | x64      |
| Dtspipeline.dll                                | 2015.131.5882.1 | 1052568   | 26-Jan-2021 | 07:37 | x86      |
| Dtspipeline.dll                                | 2015.131.5882.1 | 1272208   | 26-Jan-2021 | 07:40 | x64      |
| Dtspipelineperf130.dll                         | 2015.131.5882.1 | 35224     | 26-Jan-2021 | 07:37 | x86      |
| Dtspipelineperf130.dll                         | 2015.131.5882.1 | 41368     | 26-Jan-2021 | 07:40 | x64      |
| Dtuparse.dll                                   | 2015.131.5882.1 | 73104     | 26-Jan-2021 | 07:37 | x86      |
| Dtuparse.dll                                   | 2015.131.5882.1 | 80792     | 26-Jan-2021 | 07:40 | x64      |
| Dtutil.exe                                     | 2015.131.5882.1 | 108440    | 26-Jan-2021 | 07:38 | x86      |
| Dtutil.exe                                     | 2015.131.5882.1 | 127888    | 26-Jan-2021 | 07:48 | x64      |
| Exceldest.dll                                  | 2015.131.5882.1 | 209808    | 26-Jan-2021 | 07:38 | x86      |
| Exceldest.dll                                  | 2015.131.5882.1 | 256408    | 26-Jan-2021 | 07:39 | x64      |
| Excelsrc.dll                                   | 2015.131.5882.1 | 225680    | 26-Jan-2021 | 07:37 | x86      |
| Excelsrc.dll                                   | 2015.131.5882.1 | 278424    | 26-Jan-2021 | 07:40 | x64      |
| Flatfiledest.dll                               | 2015.131.5882.1 | 327576    | 26-Jan-2021 | 07:37 | x86      |
| Flatfiledest.dll                               | 2015.131.5882.1 | 382360    | 26-Jan-2021 | 07:39 | x64      |
| Flatfilesrc.dll                                | 2015.131.5882.1 | 338328    | 26-Jan-2021 | 07:37 | x86      |
| Flatfilesrc.dll                                | 2015.131.5882.1 | 394648    | 26-Jan-2021 | 07:39 | x64      |
| Foreachfileenumerator.dll                      | 2015.131.5882.1 | 73624     | 26-Jan-2021 | 07:37 | x86      |
| Foreachfileenumerator.dll                      | 2015.131.5882.1 | 89496     | 26-Jan-2021 | 07:39 | x64      |
| Microsoft.analysisservices.adomdclientui.dll   | 13.0.5882.1     | 85400     | 26-Jan-2021 | 07:39 | x86      |
| Microsoft.analysisservices.applocal.core.dll   | 13.0.5882.1     | 1307032   | 26-Jan-2021 | 07:39 | x86      |
| Microsoft.analysisservices.project.dll         | 2015.131.5882.1 | 2016656   | 26-Jan-2021 | 07:39 | x86      |
| Microsoft.analysisservices.projectui.dll       | 2015.131.5882.1 | 35224     | 26-Jan-2021 | 07:40 | x86      |
| Microsoft.sqlserver.astasks.dll                | 13.0.5882.1     | 66456     | 26-Jan-2021 | 07:38 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5882.1     | 428952    | 26-Jan-2021 | 07:38 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5882.1     | 428952    | 26-Jan-2021 | 07:40 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5882.1     | 2037656   | 26-Jan-2021 | 07:38 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5882.1     | 2037656   | 26-Jan-2021 | 07:39 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5882.1 | 143248    | 26-Jan-2021 | 07:38 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5882.1 | 131992    | 26-Jan-2021 | 07:40 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5882.1 | 151968    | 26-Jan-2021 | 07:38 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5882.1 | 137624    | 26-Jan-2021 | 07:40 | x86      |
| Msdtssrvrutil.dll                              | 2015.131.5882.1 | 94616     | 26-Jan-2021 | 07:39 | x64      |
| Msdtssrvrutil.dll                              | 2015.131.5882.1 | 83352     | 26-Jan-2021 | 07:40 | x86      |
| Msmdlocal.dll                                  | 2015.131.5882.1 | 56245144  | 26-Jan-2021 | 07:40 | x64      |
| Msmdlocal.dll                                  | 2015.131.5882.1 | 37127056  | 26-Jan-2021 | 07:41 | x86      |
| Msmgdsrv.dll                                   | 2015.131.5882.1 | 6502296   | 26-Jan-2021 | 07:45 | x86      |
| Msmgdsrv.dll                                   | 2015.131.5882.1 | 7502744   | 26-Jan-2021 | 07:50 | x64      |
| Msolap130.dll                                  | 2015.131.5882.1 | 8636312   | 26-Jan-2021 | 07:40 | x64      |
| Msolap130.dll                                  | 2015.131.5882.1 | 7003544   | 26-Jan-2021 | 07:42 | x86      |
| Msolui130.dll                                  | 2015.131.5882.1 | 303512    | 26-Jan-2021 | 07:39 | x64      |
| Msolui130.dll                                  | 2015.131.5882.1 | 280472    | 26-Jan-2021 | 07:41 | x86      |
| Oledbdest.dll                                  | 2015.131.5882.1 | 257424    | 26-Jan-2021 | 07:39 | x64      |
| Oledbdest.dll                                  | 2015.131.5882.1 | 209816    | 26-Jan-2021 | 07:40 | x86      |
| Oledbsrc.dll                                   | 2015.131.5882.1 | 284056    | 26-Jan-2021 | 07:39 | x64      |
| Oledbsrc.dll                                   | 2015.131.5882.1 | 228760    | 26-Jan-2021 | 07:40 | x86      |
| Profiler.exe                                   | 2015.131.5882.1 | 797592    | 26-Jan-2021 | 07:40 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.131.5882.1 | 93592     | 26-Jan-2021 | 07:40 | x64      |
| Sqldumper.exe                                  | 2015.131.5882.1 | 103832    | 26-Jan-2021 | 07:37 | x86      |
| Sqldumper.exe                                  | 2015.131.5882.1 | 123288    | 26-Jan-2021 | 07:40 | x64      |
| Sqlresld.dll                                   | 2015.131.5882.1 | 23960     | 26-Jan-2021 | 07:27 | x64      |
| Sqlresld.dll                                   | 2015.131.5882.1 | 21904     | 26-Jan-2021 | 07:40 | x86      |
| Sqlresourceloader.dll                          | 2015.131.5882.1 | 23960     | 26-Jan-2021 | 07:27 | x64      |
| Sqlresourceloader.dll                          | 2015.131.5882.1 | 21400     | 26-Jan-2021 | 07:40 | x86      |
| Sqlscm.dll                                     | 2015.131.5882.1 | 45976     | 26-Jan-2021 | 07:40 | x86      |
| Sqlscm.dll                                     | 2015.131.5882.1 | 54168     | 26-Jan-2021 | 07:40 | x64      |
| Sqlsvc.dll                                     | 2015.131.5882.1 | 145304    | 26-Jan-2021 | 07:26 | x64      |
| Sqlsvc.dll                                     | 2015.131.5882.1 | 120216    | 26-Jan-2021 | 07:39 | x86      |
| Sqltaskconnections.dll                         | 2015.131.5882.1 | 173976    | 26-Jan-2021 | 07:27 | x64      |
| Sqltaskconnections.dll                         | 2015.131.5882.1 | 144280    | 26-Jan-2021 | 07:40 | x86      |
| Txdataconvert.dll                              | 2015.131.5882.1 | 289688    | 26-Jan-2021 | 07:27 | x64      |
| Txdataconvert.dll                              | 2015.131.5882.1 | 248216    | 26-Jan-2021 | 07:39 | x86      |
| Xe.dll                                         | 2015.131.5882.1 | 619416    | 26-Jan-2021 | 07:40 | x64      |
| Xe.dll                                         | 2015.131.5882.1 | 551824    | 26-Jan-2021 | 07:49 | x86      |
| Xmlrw.dll                                      | 2015.131.5882.1 | 252824    | 26-Jan-2021 | 07:39 | x86      |
| Xmlrw.dll                                      | 2015.131.5882.1 | 312216    | 26-Jan-2021 | 07:40 | x64      |
| Xmlrwbin.dll                                   | 2015.131.5882.1 | 184728    | 26-Jan-2021 | 07:39 | x86      |
| Xmlrwbin.dll                                   | 2015.131.5882.1 | 220568    | 26-Jan-2021 | 07:40 | x64      |
| Xmsrv.dll                                      | 2015.131.5882.1 | 24041872  | 26-Jan-2021 | 07:27 | x64      |
| Xmsrv.dll                                      | 2015.131.5882.1 | 32720792  | 26-Jan-2021 | 07:40 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
