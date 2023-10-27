---
title: Cumulative update 10 for SQL Server 2016 SP2 (KB4524334)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP2 cumulative update 10 (KB4524334).
ms.date: 10/26/2023
ms.custom: KB4524334
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Web
---

# KB4524334 - Cumulative Update 10 for SQL Server 2016 SP2

_Release Date:_ &nbsp; October 08, 2019  
_Version:_ &nbsp; 13.0.5492.2

> [!NOTE]
> SQL Server 2016 SP2 CU10 is a replacement for SQL Server 2016 SP2 CU9. CU9 had an uninstall issue that is resolved in the CU10 package. If you previously installed CU9, we recommend that you install CU10.

This article describes Cumulative Update package 10 (CU10) (build number: **13.0.5492.2**) for Microsoft SQL Server 2016 Service Pack 2 (SP2). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the initial release of SQL Server 2016 SP2.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area|
|---------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|
| <a id=13113745>[13113745](#13113745) </a> | [FIX: Repair fails for Machine Learning components on server with no Internet access (KB4513096)](https://support.microsoft.com/help/4513096) | Setup & Install |
| <a id=13077821>[13077821](#13077821) </a> | [FIX: Transaction log isn't truncated on a single node Availability Group in SQL Server 2016 (KB4515772)](https://support.microsoft.com/help/4515772) | High Availability |
| <a id=13105506>[13105506](#13105506) </a> | [FIX: Orphaned CLR sessions cause blocking in SQL Server 2016 (KB4517771)](https://support.microsoft.com/help/4517771)| SQL Engine|
| <a id=13122059>[13122059](#13122059) </a> | [FIX: Access violation occurs when you run queries that involve PIVOT or UNPIVOT in SQL Server 2017 and 2016 (KB4518364)](https://support.microsoft.com/help/4518364) | SQL Engine|
| <a id=13130364>[13130364](#13130364) </a> | [FIX: Incorrect results occur with index intersection on partitioned table with a clustered columnstore index in SQL Server 2017 and 2016 (KB4519366)](https://support.microsoft.com/help/4519366)| SQL performance |
| <a id=13098936>[13098936](#13098936) </a> | [FIX: Access violation occurs when you enable TF 3924 to clean orphaned DTC transactions in SQL Server (KB4519668)](https://support.microsoft.com/help/4519668) | SQL Engine|
| <a id=13076524>[13076524](#13076524) </a> | [FIX: Different users get the same model list with different permissions in SQL Server 2016 (KB4519679)](https://support.microsoft.com/help/4519679)| Data Quality Services (DQS) |
| <a id=13138952>[13138952](#13138952) </a> | [FIX: Stack dump occurs when table type has a user-defined constraint in SQL Server 2016 (KB4519796)](https://support.microsoft.com/help/4519796) | SQL Engine|
| <a id=13140478>[13140478](#13140478) </a> | [FIX: MDS Configuration Manager reports SP2 base version in SQL Server 2016 (KB4519847)](https://support.microsoft.com/help/4519847)| Setup & Install |
| <a id=13069180>[13069180](#13069180) </a> | [FIX: Access violation occurs when you restore In-Memory OLTP database in SQL Server 2016 (KB4520109)](https://support.microsoft.com/help/4520109)| In-Memory OLTP|
| <a id=13086240>[13086240](#13086240) </a> | [FIX: Unable to mount SQL Server FILESTREAM share from Linux with SMB 3.x protocol (KB4520124)](https://support.microsoft.com/help/4520124) | SQL Engine|
| <a id=13122073>[13122073](#13122073) </a> | [FIX: When you change SEEDING_MODE to MANUAL using ALTER AVAILABILITY GROUP, SQL Server 2016 does not cancel the current seeding operations to the secondary replica (KB4520266)](https://support.microsoft.com/help/4520266) | High Availability |
| <a id=13056235>[13056235](#13056235) </a> | [FIX: Access violation error occurs when you try to insert results of stored procedure into a table with dynamic data masking in SQL Server 2016 (KB4520739)](https://support.microsoft.com/help/4520739) | SQL security|
| <a id=13162918>[13162918](#13162918) </a> | [FIX: SQL Writer Service fails to back up in non-component backup path in SQL Server 2017 and 2016 (KB4521659)](https://support.microsoft.com/help/4521659) | SQL Engine|
| <a id=13161356>[13161356](#13161356) </a> | [FIX: Cardinality property for a table doesn't include rows in the delta store or deleted bitmap if the table has a clustered columnstore index (KB4521701)](https://support.microsoft.com/help/4521701)| SQL Engine|
| <a id=13163758>[13163758](#13163758) </a> | [FIX: Error occurs when CDC capture process tries to insert duplicate key in table "cdc.lsn_time_mapping" in SQL Server 2016 (KB4521739)](https://support.microsoft.com/help/4521739) | SQL Engine|
| <a id=13134289>[13134289](#13134289) </a> | [FIX: Access violation occurs when a clone database verification fails in SQL Server 2017 and 2016 (KB4521960)](https://support.microsoft.com/help/4521960) | SQL Engine|
| <a id=13141042>[13141042](#13141042) </a> | [FIX: You may receive wrong results when you query sys.database_scoped_configurations in SQL Server 2016 (KB4522126)](https://support.microsoft.com/help/4522126) | SQL Engine|
| <a id=13107679>[13107679](#13107679) </a> | [FIX: Poor query performance due to low cardinality estimation in SQL Server 2016 when you use default CE and column is covered by both single and multi-column statistics (KB4522127)](https://support.microsoft.com/help/4522127) | SQL performance |
| <a id=13147775>[13147775](#13147775) </a> | [FIX: Subscriptions fail after you upgrade from SSRS 2012 to SSRS 2016 because of invalid character in mail header (KB4522134)](https://support.microsoft.com/help/4522134) | Reporting Services|
| <a id=13174187>[13174187](#13174187) </a> | [FIX: SQL Server 2016 database remains in frozen I/O state indefinitely when backed up by VSS (KB4523102)](https://support.microsoft.com/help/4523102)| SQL Engine|

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

| File   name    | File version    | File size | Date     | Time | Platform |
|----------------|-----------------|-----------|----------|------|----------|
| Instapi130.dll | 2015.131.5492.2 | 53360     | 05-Oct-2019 | 07:12 | x86      |
| Keyfile.dll    | 2015.131.5492.2 | 88688     | 05-Oct-2019 | 07:17 | x86      |
| Sqlbrowser.exe | 2015.131.5492.2 | 276592    | 05-Oct-2019 | 07:13 | x86      |
| Sqldumper.exe  | 2015.131.5492.2 | 107640    | 05-Oct-2019 | 07:12 | x86      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date     | Time | Platform |
|-----------------------|-----------------|-----------|----------|------|----------|
| Instapi130.dll        | 2015.131.5492.2 | 61040     | 05-Oct-2019 | 07:14 | x64      |
| Sqlboot.dll           | 2015.131.5492.2 | 186480    | 05-Oct-2019 | 07:15 | x64      |
| Sqldumper.exe         | 2015.131.5492.2 | 127088    | 05-Oct-2019 | 07:17 | x64      |
| Sqlvdi.dll            | 2015.131.5492.2 | 197232    | 05-Oct-2019 | 07:14 | x64      |
| Sqlvdi.dll            | 2015.131.5492.2 | 168776    | 05-Oct-2019 | 07:16 | x86      |
| Sqlwriter.exe         | 2015.131.5492.2 | 131704    | 05-Oct-2019 | 07:15 | x64      |
| Sqlwriter_keyfile.dll | 2015.131.5492.2 | 100672    | 05-Oct-2019 | 07:17 | x64      |
| Sqlwvss.dll           | 2015.131.5492.2 | 346736    | 05-Oct-2019 | 07:51 | x64      |
| Sqlwvss_xp.dll        | 2015.131.5492.2 | 26440     | 05-Oct-2019 | 07:51 | x64      |

SQL Server 2016 Analysis Services

| File   name                                | File version    | File size | Date     | Time | Platform |
|--------------------------------------------|-----------------|-----------|----------|------|----------|
| Microsoft.analysisservices.server.core.dll | 13.0.5492.2     | 1348208   | 05-Oct-2019 | 07:19 | x86      |
| Microsoft.applicationinsights.dll          | 2.7.0.13435     | 329872    | 06-Jul-2018 | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5492.2     | 990536    | 05-Oct-2019 | 07:17 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5492.2     | 990320    | 05-Oct-2019 | 07:17 | x86      |
| Msmdctr130.dll                             | 2015.131.5492.2 | 40048     | 05-Oct-2019 | 07:16 | x64      |
| Msmdlocal.dll                              | 2015.131.5492.2 | 37129024  | 05-Oct-2019 | 07:17 | x86      |
| Msmdlocal.dll                              | 2015.131.5492.2 | 56245360  | 05-Oct-2019 | 07:18 | x64      |
| Msmdsrv.exe                                | 2015.131.5492.2 | 56789104  | 05-Oct-2019 | 07:16 | x64      |
| Msmgdsrv.dll                               | 2015.131.5492.2 | 7509616   | 05-Oct-2019 | 07:15 | x64      |
| Msmgdsrv.dll                               | 2015.131.5492.2 | 6508648   | 05-Oct-2019 | 07:17 | x86      |
| Msolap130.dll                              | 2015.131.5492.2 | 7010416   | 05-Oct-2019 | 07:17 | x86      |
| Msolap130.dll                              | 2015.131.5492.2 | 8643184   | 05-Oct-2019 | 07:17 | x64      |
| Msolui130.dll                              | 2015.131.5492.2 | 310384    | 05-Oct-2019 | 07:17 | x64      |
| Msolui130.dll                              | 2015.131.5492.2 | 287344    | 05-Oct-2019 | 07:17 | x86      |
| Sql_as_keyfile.dll                         | 2015.131.5492.2 | 100672    | 05-Oct-2019 | 07:17 | x64      |
| Sqlboot.dll                                | 2015.131.5492.2 | 186480    | 05-Oct-2019 | 07:15 | x64      |
| Sqlceip.exe                                | 13.0.5492.2     | 256112    | 05-Oct-2019 | 07:14 | x86      |
| Sqldumper.exe                              | 2015.131.5492.2 | 107640    | 05-Oct-2019 | 07:12 | x86      |
| Sqldumper.exe                              | 2015.131.5492.2 | 127088    | 05-Oct-2019 | 07:17 | x64      |
| Tmapi.dll                                  | 2015.131.5492.2 | 4345968   | 05-Oct-2019 | 07:51 | x64      |
| Tmcachemgr.dll                             | 2015.131.5492.2 | 2826864   | 05-Oct-2019 | 07:51 | x64      |
| Tmpersistence.dll                          | 2015.131.5492.2 | 1071216   | 05-Oct-2019 | 07:51 | x64      |
| Tmtransactions.dll                         | 2015.131.5492.2 | 1352512   | 05-Oct-2019 | 07:51 | x64      |
| Xe.dll                                     | 2015.131.5492.2 | 626504    | 05-Oct-2019 | 07:20 | x64      |
| Xmlrw.dll                                  | 2015.131.5492.2 | 259904    | 05-Oct-2019 | 07:13 | x86      |
| Xmlrw.dll                                  | 2015.131.5492.2 | 319304    | 05-Oct-2019 | 07:15 | x64      |
| Xmlrwbin.dll                               | 2015.131.5492.2 | 191600    | 05-Oct-2019 | 07:13 | x86      |
| Xmlrwbin.dll                               | 2015.131.5492.2 | 227448    | 05-Oct-2019 | 07:15 | x64      |
| Xmsrv.dll                                  | 2015.131.5492.2 | 32727664  | 05-Oct-2019 | 07:14 | x86      |
| Xmsrv.dll                                  | 2015.131.5492.2 | 24051824  | 05-Oct-2019 | 07:51 | x64      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version    | File size | Date     | Time | Platform |
|---------------------------------------------|-----------------|-----------|----------|------|----------|
| Batchparser.dll                             | 2015.131.5492.2 | 160368    | 05-Oct-2019 | 07:12 | x86      |
| Batchparser.dll                             | 2015.131.5492.2 | 180848    | 05-Oct-2019 | 07:15 | x64      |
| Instapi130.dll                              | 2015.131.5492.2 | 53360     | 05-Oct-2019 | 07:12 | x86      |
| Instapi130.dll                              | 2015.131.5492.2 | 61040     | 05-Oct-2019 | 07:14 | x64      |
| Isacctchange.dll                            | 2015.131.5492.2 | 29512     | 05-Oct-2019 | 07:12 | x86      |
| Isacctchange.dll                            | 2015.131.5492.2 | 31040     | 05-Oct-2019 | 07:17 | x64      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5492.2     | 1027704   | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5492.2     | 1027704   | 05-Oct-2019 | 07:22 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.5492.2     | 1348728   | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.analysisservices.dll              | 13.0.5492.2     | 702792    | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.5492.2     | 765552    | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.5492.2     | 521032    | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5492.2     | 711800    | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5492.2     | 711800    | 05-Oct-2019 | 07:19 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5492.2 | 75384     | 05-Oct-2019 | 07:12 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5492.2 | 72824     | 05-Oct-2019 | 07:18 | x86      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5492.2     | 569456    | 05-Oct-2019 | 07:17 | x86      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5492.2     | 569672    | 05-Oct-2019 | 07:19 | x86      |
| Msasxpress.dll                              | 2015.131.5492.2 | 35952     | 05-Oct-2019 | 07:16 | x64      |
| Msasxpress.dll                              | 2015.131.5492.2 | 31856     | 05-Oct-2019 | 07:17 | x86      |
| Pbsvcacctsync.dll                           | 2015.131.5492.2 | 72816     | 05-Oct-2019 | 07:16 | x64      |
| Pbsvcacctsync.dll                           | 2015.131.5492.2 | 60016     | 05-Oct-2019 | 07:17 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.131.5492.2 | 100672    | 05-Oct-2019 | 07:17 | x64      |
| Sqldumper.exe                               | 2015.131.5492.2 | 107640    | 05-Oct-2019 | 07:12 | x86      |
| Sqldumper.exe                               | 2015.131.5492.2 | 127088    | 05-Oct-2019 | 07:17 | x64      |
| Sqlftacct.dll                               | 2015.131.5492.2 | 52040     | 05-Oct-2019 | 07:15 | x64      |
| Sqlftacct.dll                               | 2015.131.5492.2 | 46904     | 05-Oct-2019 | 07:16 | x86      |
| Sqlmgmprovider.dll                          | 2015.131.5492.2 | 365680    | 05-Oct-2019 | 07:15 | x86      |
| Sqlmgmprovider.dll                          | 2015.131.5492.2 | 406336    | 05-Oct-2019 | 07:51 | x64      |
| Sqlsecacctchg.dll                           | 2015.131.5492.2 | 34920     | 05-Oct-2019 | 07:16 | x86      |
| Sqlsecacctchg.dll                           | 2015.131.5492.2 | 37488     | 05-Oct-2019 | 07:51 | x64      |
| Sqltdiagn.dll                               | 2015.131.5492.2 | 60528     | 05-Oct-2019 | 07:15 | x86      |
| Sqltdiagn.dll                               | 2015.131.5492.2 | 67696     | 05-Oct-2019 | 07:50 | x64      |

SQL Server 2016 sql_dreplay_client

| File name                      | File version    | File size | Date        | Time  | Platform |
|--------------------------------|-----------------|-----------|-------------|-------|----------|
| Dreplayclient.exe              | 2015.131.5492.2 | 120944    | 05-Oct-2019 | 07:14 | x86      |
| Dreplaycommon.dll              | 2015.131.5492.2 | 691008    | 05-Oct-2019 | 07:15 | x86      |
| Dreplayutil.dll                | 2015.131.5492.2 | 309872    | 05-Oct-2019 | 07:12 | x86      |
| Instapi130.dll                 | 2015.131.5492.2 | 61040     | 05-Oct-2019 | 07:14 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.131.5492.2 | 100672    | 05-Oct-2019 | 07:17 | x64      |
| Sqlresourceloader.dll          | 2015.131.5492.2 | 28512     | 05-Oct-2019 | 07:16 | x86      |

SQL Server 2016 sql_dreplay_controller

| File name                          | File version    | File size | Date        | Time  | Platform |
|------------------------------------|-----------------|-----------|-------------|-------|----------|
| Dreplaycommon.dll                  | 2015.131.5492.2 | 691008    | 05-Oct-2019 | 07:15 | x86      |
| Dreplaycontroller.exe              | 2015.131.5492.2 | 350320    | 05-Oct-2019 | 07:13 | x86      |
| Dreplayprocess.dll                 | 2015.131.5492.2 | 171632    | 05-Oct-2019 | 07:12 | x86      |
| Instapi130.dll                     | 2015.131.5492.2 | 61040     | 05-Oct-2019 | 07:14 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.131.5492.2 | 100672    | 05-Oct-2019 | 07:17 | x64      |
| Sqlresourceloader.dll              | 2015.131.5492.2 | 28512     | 05-Oct-2019 | 07:16 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version    | File size | Date     | Time  | Platform |
|----------------------------------------------|-----------------|-----------|----------|-------|----------|
| Backuptourl.exe                              | 13.0.5492.2     | 41288     | 05-Oct-2019 | 07:15  | x64      |
| Batchparser.dll                              | 2015.131.5492.2 | 180848    | 05-Oct-2019 | 07:15  | x64      |
| Datacollectorcontroller.dll                  | 2015.131.5492.2 | 225400    | 05-Oct-2019 | 07:18  | x64      |
| Dcexec.exe                                   | 2015.131.5492.2 | 74568     | 05-Oct-2019 | 07:15  | x64      |
| Fssres.dll                                   | 2015.131.5492.2 | 81736     | 05-Oct-2019 | 07:19  | x64      |
| Hadrres.dll                                  | 2015.131.5492.2 | 177784    | 05-Oct-2019 | 07:15  | x64      |
| Hkcompile.dll                                | 2015.131.5492.2 | 1298032   | 05-Oct-2019 | 07:17  | x64      |
| Hkengine.dll                                 | 2015.131.5492.2 | 5601392   | 05-Oct-2019 | 07:15  | x64      |
| Hkruntime.dll                                | 2015.131.5492.2 | 159048    | 05-Oct-2019 | 07:16  | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 06-Jul-2018 | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.5492.2     | 234312    | 05-Oct-2019 | 07:15  | x86      |
| Microsoft.sqlserver.types.dll                | 2015.131.5492.2 | 393032    | 05-Oct-2019 | 07:12  | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.131.5492.2 | 72304     | 05-Oct-2019 | 07:16  | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.131.5492.2 | 65144     | 05-Oct-2019 | 07:12  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5492.2 | 150344    | 05-Oct-2019 | 07:13  | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5492.2 | 158832    | 05-Oct-2019 | 07:13  | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.131.5492.2 | 271992    | 05-Oct-2019 | 07:12  | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.131.5492.2 | 74872     | 05-Oct-2019 | 07:12  | x64      |
| Odsole70.dll                                 | 2015.131.5492.2 | 93000     | 05-Oct-2019 | 07:17  | x64      |
| Opends60.dll                                 | 2015.131.5492.2 | 32880     | 05-Oct-2019 | 07:14  | x64      |
| Qds.dll                                      | 2015.131.5492.2 | 874096    | 05-Oct-2019 | 07:17  | x64      |
| Rsfxft.dll                                   | 2015.131.5492.2 | 34416     | 05-Oct-2019 | 07:14  | x64      |
| Sqagtres.dll                                 | 2015.131.5492.2 | 64632     | 05-Oct-2019 | 07:15  | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.131.5492.2 | 100672    | 05-Oct-2019 | 07:17  | x64      |
| Sqlaamss.dll                                 | 2015.131.5492.2 | 80496     | 05-Oct-2019 | 07:14  | x64      |
| Sqlaccess.dll                                | 2015.131.5492.2 | 462968    | 05-Oct-2019 | 07:12  | x64      |
| Sqlagent.exe                                 | 2015.131.5492.2 | 566624    | 05-Oct-2019 | 07:15  | x64      |
| Sqlagentctr130.dll                           | 2015.131.5492.2 | 52040     | 05-Oct-2019 | 07:16  | x64      |
| Sqlagentctr130.dll                           | 2015.131.5492.2 | 44144     | 05-Oct-2019 | 07:17  | x86      |
| Sqlagentlog.dll                              | 2015.131.5492.2 | 33088     | 05-Oct-2019 | 07:16  | x64      |
| Sqlagentmail.dll                             | 2015.131.5492.2 | 47736     | 05-Oct-2019 | 07:15  | x64      |
| Sqlboot.dll                                  | 2015.131.5492.2 | 186480    | 05-Oct-2019 | 07:15  | x64      |
| Sqlceip.exe                                  | 13.0.5492.2     | 256112    | 05-Oct-2019 | 07:14  | x86      |
| Sqlcmdss.dll                                 | 2015.131.5492.2 | 60232     | 05-Oct-2019 | 07:15  | x64      |
| Sqldk.dll                                    | 2015.131.5492.2 | 2590528   | 05-Oct-2019 | 07:17  | x64      |
| Sqldtsss.dll                                 | 2015.131.5492.2 | 97400     | 05-Oct-2019 | 07:14  | x64      |
| Sqliosim.com                                 | 2015.131.5492.2 | 307824    | 05-Oct-2019 | 07:18  | x64      |
| Sqliosim.exe                                 | 2015.131.5492.2 | 3014464   | 05-Oct-2019 | 07:16  | x64      |
| Sqllang.dll                                  | 2015.131.5492.2 | 39536752  | 05-Oct-2019 | 07:18  | x64      |
| Sqlmin.dll                                   | 2015.131.5492.2 | 37915248  | 05-Oct-2019 | 07:51  | x64      |
| Sqlolapss.dll                                | 2015.131.5492.2 | 97904     | 05-Oct-2019 | 07:14  | x64      |
| Sqlos.dll                                    | 2015.131.5492.2 | 26224     | 05-Oct-2019 | 07:14  | x64      |
| Sqlpowershellss.dll                          | 2015.131.5492.2 | 58480     | 05-Oct-2019 | 07:51  | x64      |
| Sqlrepss.dll                                 | 2015.131.5492.2 | 55136     | 05-Oct-2019 | 07:51  | x64      |
| Sqlresld.dll                                 | 2015.131.5492.2 | 31040     | 05-Oct-2019 | 07:51  | x64      |
| Sqlresourceloader.dll                        | 2015.131.5492.2 | 31040     | 05-Oct-2019 | 07:51  | x64      |
| Sqlscm.dll                                   | 2015.131.5492.2 | 61040     | 05-Oct-2019 | 07:14  | x64      |
| Sqlscriptdowngrade.dll                       | 2015.131.5492.2 | 27976     | 05-Oct-2019 | 07:51  | x64      |
| Sqlscriptupgrade.dll                         | 2015.131.5492.2 | 5808960   | 05-Oct-2019 | 07:16  | x64      |
| Sqlserverspatial130.dll                      | 2015.131.5492.2 | 732784    | 05-Oct-2019 | 07:16  | x64      |
| Sqlservr.exe                                 | 2015.131.5492.2 | 393032    | 05-Oct-2019 | 07:15  | x64      |
| Sqlsvc.dll                                   | 2015.131.5492.2 | 152392    | 05-Oct-2019 | 07:51  | x64      |
| Sqltses.dll                                  | 2015.131.5492.2 | 8923760   | 05-Oct-2019 | 07:51  | x64      |
| Sqsrvres.dll                                 | 2015.131.5492.2 | 251200    | 05-Oct-2019 | 07:51  | x64      |
| Xe.dll                                       | 2015.131.5492.2 | 626504    | 05-Oct-2019 | 07:20  | x64      |
| Xmlrw.dll                                    | 2015.131.5492.2 | 319304    | 05-Oct-2019 | 07:15  | x64      |
| Xmlrwbin.dll                                 | 2015.131.5492.2 | 227448    | 05-Oct-2019 | 07:15  | x64      |
| Xpadsi.exe                                   | 2015.131.5492.2 | 78960     | 05-Oct-2019 | 07:22  | x64      |
| Xplog70.dll                                  | 2015.131.5492.2 | 65648     | 05-Oct-2019 | 07:14  | x64      |
| Xpsqlbot.dll                                 | 2015.131.5492.2 | 33400     | 05-Oct-2019 | 07:15  | x64      |
| Xpstar.dll                                   | 2015.131.5492.2 | 422512    | 05-Oct-2019 | 07:14  | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                  | File version    | File size | Date     | Time | Platform |
|----------------------------------------------|-----------------|-----------|----------|------|----------|
| Batchparser.dll                              | 2015.131.5492.2 | 160368    | 05-Oct-2019 | 07:12 | x86      |
| Batchparser.dll                              | 2015.131.5492.2 | 180848    | 05-Oct-2019 | 07:15 | x64      |
| Bcp.exe                                      | 2015.131.5492.2 | 119928    | 05-Oct-2019 | 07:18 | x64      |
| Commanddest.dll                              | 2015.131.5492.2 | 249152    | 05-Oct-2019 | 07:18 | x64      |
| Datacollectorenumerators.dll                 | 2015.131.5492.2 | 115832    | 05-Oct-2019 | 07:18 | x64      |
| Datacollectortasks.dll                       | 2015.131.5492.2 | 188016    | 05-Oct-2019 | 07:18 | x64      |
| Distrib.exe                                  | 2015.131.5492.2 | 191296    | 05-Oct-2019 | 07:15 | x64      |
| Dteparse.dll                                 | 2015.131.5492.2 | 109680    | 05-Oct-2019 | 07:18 | x64      |
| Dteparsemgd.dll                              | 2015.131.5492.2 | 88688     | 05-Oct-2019 | 07:21 | x64      |
| Dtepkg.dll                                   | 2015.131.5492.2 | 137328    | 05-Oct-2019 | 07:18 | x64      |
| Dtexec.exe                                   | 2015.131.5492.2 | 73032     | 05-Oct-2019 | 07:15 | x64      |
| Dts.dll                                      | 2015.131.5492.2 | 3147080   | 05-Oct-2019 | 07:18 | x64      |
| Dtscomexpreval.dll                           | 2015.131.5492.2 | 477536    | 05-Oct-2019 | 07:18 | x64      |
| Dtsconn.dll                                  | 2015.131.5492.2 | 492656    | 05-Oct-2019 | 07:19 | x64      |
| Dtshost.exe                                  | 2015.131.5492.2 | 86856     | 05-Oct-2019 | 07:15 | x64      |
| Dtslog.dll                                   | 2015.131.5492.2 | 120648    | 05-Oct-2019 | 07:18 | x64      |
| Dtsmsg130.dll                                | 2015.131.5492.2 | 545392    | 05-Oct-2019 | 07:18 | x64      |
| Dtspipeline.dll                              | 2015.131.5492.2 | 1279088   | 05-Oct-2019 | 07:18 | x64      |
| Dtspipelineperf130.dll                       | 2015.131.5492.2 | 48240     | 05-Oct-2019 | 07:18 | x64      |
| Dtuparse.dll                                 | 2015.131.5492.2 | 87664     | 05-Oct-2019 | 07:17 | x64      |
| Dtutil.exe                                   | 2015.131.5492.2 | 134768    | 05-Oct-2019 | 07:15 | x64      |
| Exceldest.dll                                | 2015.131.5492.2 | 263520    | 05-Oct-2019 | 07:17 | x64      |
| Excelsrc.dll                                 | 2015.131.5492.2 | 285296    | 05-Oct-2019 | 07:18 | x64      |
| Execpackagetask.dll                          | 2015.131.5492.2 | 166520    | 05-Oct-2019 | 07:18 | x64      |
| Flatfiledest.dll                             | 2015.131.5492.2 | 389440    | 05-Oct-2019 | 07:17 | x64      |
| Flatfilesrc.dll                              | 2015.131.5492.2 | 401736    | 05-Oct-2019 | 07:18 | x64      |
| Foreachfileenumerator.dll                    | 2015.131.5492.2 | 96376     | 05-Oct-2019 | 07:18 | x64      |
| Hkengperfctrs.dll                            | 2015.131.5492.2 | 59000     | 05-Oct-2019 | 07:15 | x64      |
| Logread.exe                                  | 2015.131.5492.2 | 627016    | 05-Oct-2019 | 07:16 | x64      |
| Microsoft.analysisservices.applocal.core.dll | 13.0.5492.2     | 1313904   | 05-Oct-2019 | 07:21 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll | 13.0.5492.2     | 391800    | 05-Oct-2019 | 07:19 | x86      |
| Microsoft.sqlserver.replication.dll          | 2015.131.5492.2 | 1651312   | 05-Oct-2019 | 07:17 | x64      |
| Microsoft.sqlserver.rmo.dll                  | 13.0.5492.2     | 569672    | 05-Oct-2019 | 07:19 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5492.2 | 150344    | 05-Oct-2019 | 07:13 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5492.2 | 158832    | 05-Oct-2019 | 07:13 | x64      |
| Msdtssrvrutil.dll                            | 2015.131.5492.2 | 101496    | 05-Oct-2019 | 07:16 | x64      |
| Msxmlsql.dll                                 | 2015.131.5492.2 | 1494640   | 05-Oct-2019 | 07:15 | x64      |
| Oledbdest.dll                                | 2015.131.5492.2 | 264304    | 05-Oct-2019 | 07:17 | x64      |
| Oledbsrc.dll                                 | 2015.131.5492.2 | 290928    | 05-Oct-2019 | 07:16 | x64      |
| Osql.exe                                     | 2015.131.5492.2 | 75376     | 05-Oct-2019 | 07:19 | x64      |
| Rawdest.dll                                  | 2015.131.5492.2 | 209528    | 05-Oct-2019 | 07:17 | x64      |
| Rawsource.dll                                | 2015.131.5492.2 | 196936    | 05-Oct-2019 | 07:16 | x64      |
| Rdistcom.dll                                 | 2015.131.5492.2 | 907384    | 05-Oct-2019 | 07:16 | x64      |
| Recordsetdest.dll                            | 2015.131.5492.2 | 186992    | 05-Oct-2019 | 07:17 | x64      |
| Repldp.dll                                   | 2015.131.5492.2 | 281712    | 05-Oct-2019 | 07:16 | x64      |
| Replmerg.exe                                 | 2015.131.5492.2 | 518984    | 05-Oct-2019 | 07:15 | x64      |
| Replprov.dll                                 | 2015.131.5492.2 | 812360    | 05-Oct-2019 | 07:16 | x64      |
| Replrec.dll                                  | 2015.131.5492.2 | 1019208   | 05-Oct-2019 | 07:15 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2015.131.5492.2 | 100672    | 05-Oct-2019 | 07:17 | x64      |
| Sqlcmd.exe                                   | 2015.131.5492.2 | 249456    | 05-Oct-2019 | 07:17 | x64      |
| Sqldiag.exe                                  | 2015.131.5492.2 | 1257800   | 05-Oct-2019 | 07:15 | x64      |
| Sqllogship.exe                               | 13.0.5492.2     | 104560    | 05-Oct-2019 | 07:14 | x64      |
| Sqlresld.dll                                 | 2015.131.5492.2 | 28992     | 05-Oct-2019 | 07:16 | x86      |
| Sqlresld.dll                                 | 2015.131.5492.2 | 31040     | 05-Oct-2019 | 07:51 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5492.2 | 28512     | 05-Oct-2019 | 07:16 | x86      |
| Sqlresourceloader.dll                        | 2015.131.5492.2 | 31040     | 05-Oct-2019 | 07:51 | x64      |
| Sqlscm.dll                                   | 2015.131.5492.2 | 61040     | 05-Oct-2019 | 07:14 | x64      |
| Sqlscm.dll                                   | 2015.131.5492.2 | 53064     | 05-Oct-2019 | 07:16 | x86      |
| Sqlsvc.dll                                   | 2015.131.5492.2 | 127088    | 05-Oct-2019 | 07:16 | x86      |
| Sqlsvc.dll                                   | 2015.131.5492.2 | 152392    | 05-Oct-2019 | 07:51 | x64      |
| Sqltaskconnections.dll                       | 2015.131.5492.2 | 180848    | 05-Oct-2019 | 07:51 | x64      |
| Sqlwep130.dll                                | 2015.131.5492.2 | 105792    | 05-Oct-2019 | 07:51 | x64      |
| Ssisoledb.dll                                | 2015.131.5492.2 | 216176    | 05-Oct-2019 | 07:51 | x64      |
| Tablediff.exe                                | 13.0.5492.2     | 86640     | 05-Oct-2019 | 07:14 | x64      |
| Txagg.dll                                    | 2015.131.5492.2 | 364656    | 05-Oct-2019 | 07:51 | x64      |
| Txbdd.dll                                    | 2015.131.5492.2 | 172864    | 05-Oct-2019 | 07:51 | x64      |
| Txdatacollector.dll                          | 2015.131.5492.2 | 367728    | 05-Oct-2019 | 07:50 | x64      |
| Txdataconvert.dll                            | 2015.131.5492.2 | 296552    | 05-Oct-2019 | 07:51 | x64      |
| Txderived.dll                                | 2015.131.5492.2 | 607848    | 05-Oct-2019 | 07:51 | x64      |
| Txlookup.dll                                 | 2015.131.5492.2 | 532080    | 05-Oct-2019 | 07:51 | x64      |
| Txmerge.dll                                  | 2015.131.5492.2 | 230512    | 05-Oct-2019 | 07:51 | x64      |
| Txmergejoin.dll                              | 2015.131.5492.2 | 278640    | 05-Oct-2019 | 07:51 | x64      |
| Txmulticast.dll                              | 2015.131.5492.2 | 128112    | 05-Oct-2019 | 07:51 | x64      |
| Txrowcount.dll                               | 2015.131.5492.2 | 126568    | 05-Oct-2019 | 07:51 | x64      |
| Txsort.dll                                   | 2015.131.5492.2 | 259184    | 05-Oct-2019 | 07:51 | x64      |
| Txsplit.dll                                  | 2015.131.5492.2 | 600688    | 05-Oct-2019 | 07:51 | x64      |
| Txunionall.dll                               | 2015.131.5492.2 | 181872    | 05-Oct-2019 | 07:51 | x64      |
| Xe.dll                                       | 2015.131.5492.2 | 626504    | 05-Oct-2019 | 07:20 | x64      |
| Xmlrw.dll                                    | 2015.131.5492.2 | 319304    | 05-Oct-2019 | 07:15 | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date     | Time | Platform |
|-------------------------------|-----------------|-----------|----------|------|----------|
| Launchpad.exe                 | 2015.131.5492.2 | 1014896   | 05-Oct-2019 | 07:18 | x64      |
| Sql_extensibility_keyfile.dll | 2015.131.5492.2 | 100672    | 05-Oct-2019 | 07:17 | x64      |
| Sqlsatellite.dll              | 2015.131.5492.2 | 837232    | 05-Oct-2019 | 07:15 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version    | File size | Date     | Time | Platform |
|--------------------------|-----------------|-----------|----------|------|----------|
| Fd.dll                   | 2015.131.5492.2 | 660296    | 05-Oct-2019 | 07:15 | x64      |
| Fdhost.exe               | 2015.131.5492.2 | 105080    | 05-Oct-2019 | 07:18 | x64      |
| Fdlauncher.exe           | 2015.131.5492.2 | 51312     | 05-Oct-2019 | 07:18 | x64      |
| Sql_fulltext_keyfile.dll | 2015.131.5492.2 | 100672    | 05-Oct-2019 | 07:17 | x64      |
| Sqlft130ph.dll           | 2015.131.5492.2 | 57968     | 05-Oct-2019 | 07:14 | x64      |

SQL Server 2016 sql_inst_mr

| File name               | File version    | File size | Date        | Time  | Platform |
|-------------------------|-----------------|-----------|-------------|-------|----------|
| Imrdll.dll              | 13.0.5492.2     | 23664     | 05-Oct-2019 | 07:21 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.131.5492.2 | 100672    | 05-Oct-2019 | 07:17 | x64      |

SQL Server 2016 Integration Services

| File name                                          | File version    | File size | Date        | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|-------------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll              | 4.0.0.111       | 77944     | 03-Oct-2019 | 19:25 | x86      |
| Attunity.sqlserver.cdccontroltask.dll              | 4.0.0.111       | 77944     | 04-Oct-2019 | 12:46 | x86      |
| Attunity.sqlserver.cdcsplit.dll                    | 4.0.0.111       | 37496     | 03-Oct-2019 | 19:25 | x86      |
| Attunity.sqlserver.cdcsplit.dll                    | 4.0.0.111       | 37496     | 04-Oct-2019 | 12:46 | x86      |
| Attunity.sqlserver.cdcsrc.dll                      | 4.0.0.111       | 78456     | 03-Oct-2019 | 19:25 | x86      |
| Attunity.sqlserver.cdcsrc.dll                      | 4.0.0.111       | 78456     | 04-Oct-2019 | 12:46 | x86      |
| Commanddest.dll                                    | 2015.131.5492.2 | 203080    | 05-Oct-2019 | 07:14 | x86      |
| Commanddest.dll                                    | 2015.131.5492.2 | 249152    | 05-Oct-2019 | 07:18 | x64      |
| Dteparse.dll                                       | 2015.131.5492.2 | 99448     | 05-Oct-2019 | 07:12 | x86      |
| Dteparse.dll                                       | 2015.131.5492.2 | 109680    | 05-Oct-2019 | 07:18 | x64      |
| Dteparsemgd.dll                                    | 2015.131.5492.2 | 83568     | 05-Oct-2019 | 07:15 | x86      |
| Dteparsemgd.dll                                    | 2015.131.5492.2 | 88688     | 05-Oct-2019 | 07:21 | x64      |
| Dtepkg.dll                                         | 2015.131.5492.2 | 115824    | 05-Oct-2019 | 07:13 | x86      |
| Dtepkg.dll                                         | 2015.131.5492.2 | 137328    | 05-Oct-2019 | 07:18 | x64      |
| Dtexec.exe                                         | 2015.131.5492.2 | 66680     | 05-Oct-2019 | 07:14 | x86      |
| Dtexec.exe                                         | 2015.131.5492.2 | 73032     | 05-Oct-2019 | 07:15 | x64      |
| Dts.dll                                            | 2015.131.5492.2 | 2633024   | 05-Oct-2019 | 07:14 | x86      |
| Dts.dll                                            | 2015.131.5492.2 | 3147080   | 05-Oct-2019 | 07:18 | x64      |
| Dtscomexpreval.dll                                 | 2015.131.5492.2 | 418928    | 05-Oct-2019 | 07:12 | x86      |
| Dtscomexpreval.dll                                 | 2015.131.5492.2 | 477536    | 05-Oct-2019 | 07:18 | x64      |
| Dtsconn.dll                                        | 2015.131.5492.2 | 392304    | 05-Oct-2019 | 07:12 | x86      |
| Dtsconn.dll                                        | 2015.131.5492.2 | 492656    | 05-Oct-2019 | 07:19 | x64      |
| Dtsdebughost.exe                                   | 2015.131.5492.2 | 93808     | 05-Oct-2019 | 07:14 | x86      |
| Dtsdebughost.exe                                   | 2015.131.5492.2 | 109896    | 05-Oct-2019 | 07:15 | x64      |
| Dtshost.exe                                        | 2015.131.5492.2 | 76408     | 05-Oct-2019 | 07:14 | x86      |
| Dtshost.exe                                        | 2015.131.5492.2 | 86856     | 05-Oct-2019 | 07:15 | x64      |
| Dtslog.dll                                         | 2015.131.5492.2 | 103024    | 05-Oct-2019 | 07:12 | x86      |
| Dtslog.dll                                         | 2015.131.5492.2 | 120648    | 05-Oct-2019 | 07:18 | x64      |
| Dtsmsg130.dll                                      | 2015.131.5492.2 | 541296    | 05-Oct-2019 | 07:13 | x86      |
| Dtsmsg130.dll                                      | 2015.131.5492.2 | 545392    | 05-Oct-2019 | 07:18 | x64      |
| Dtspipeline.dll                                    | 2015.131.5492.2 | 1059440   | 05-Oct-2019 | 07:12 | x86      |
| Dtspipeline.dll                                    | 2015.131.5492.2 | 1279088   | 05-Oct-2019 | 07:18 | x64      |
| Dtspipelineperf130.dll                             | 2015.131.5492.2 | 42096     | 05-Oct-2019 | 07:12 | x86      |
| Dtspipelineperf130.dll                             | 2015.131.5492.2 | 48240     | 05-Oct-2019 | 07:18 | x64      |
| Dtuparse.dll                                       | 2015.131.5492.2 | 79984     | 05-Oct-2019 | 07:12 | x86      |
| Dtuparse.dll                                       | 2015.131.5492.2 | 87664     | 05-Oct-2019 | 07:17 | x64      |
| Dtutil.exe                                         | 2015.131.5492.2 | 115320    | 05-Oct-2019 | 07:14 | x86      |
| Dtutil.exe                                         | 2015.131.5492.2 | 134768    | 05-Oct-2019 | 07:15 | x64      |
| Exceldest.dll                                      | 2015.131.5492.2 | 216696    | 05-Oct-2019 | 07:12 | x86      |
| Exceldest.dll                                      | 2015.131.5492.2 | 263520    | 05-Oct-2019 | 07:17 | x64      |
| Excelsrc.dll                                       | 2015.131.5492.2 | 232560    | 05-Oct-2019 | 07:12 | x86      |
| Excelsrc.dll                                       | 2015.131.5492.2 | 285296    | 05-Oct-2019 | 07:18 | x64      |
| Execpackagetask.dll                                | 2015.131.5492.2 | 135280    | 05-Oct-2019 | 07:12 | x86      |
| Execpackagetask.dll                                | 2015.131.5492.2 | 166520    | 05-Oct-2019 | 07:18 | x64      |
| Flatfiledest.dll                                   | 2015.131.5492.2 | 334440    | 05-Oct-2019 | 07:12 | x86      |
| Flatfiledest.dll                                   | 2015.131.5492.2 | 389440    | 05-Oct-2019 | 07:17 | x64      |
| Flatfilesrc.dll                                    | 2015.131.5492.2 | 345192    | 05-Oct-2019 | 07:12 | x86      |
| Flatfilesrc.dll                                    | 2015.131.5492.2 | 401736    | 05-Oct-2019 | 07:18 | x64      |
| Foreachfileenumerator.dll                          | 2015.131.5492.2 | 80496     | 05-Oct-2019 | 07:12 | x86      |
| Foreachfileenumerator.dll                          | 2015.131.5492.2 | 96376     | 05-Oct-2019 | 07:18 | x64      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5492.2     | 1313912   | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.analysisservices.applocal.core.dll       | 13.0.5492.2     | 1313904   | 05-Oct-2019 | 07:21 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 06-Jul-2018 | 22:33 | x86      |
| Microsoft.sqlserver.astasks.dll                    | 13.0.5492.2     | 73328     | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5492.2 | 112240    | 05-Oct-2019 | 07:15 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5492.2 | 107336    | 05-Oct-2019 | 07:16 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5492.2     | 82536     | 04-Oct-2019 | 22:24 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5492.2     | 82752     | 05-Oct-2019 | 07:16 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll       | 13.0.5492.2     | 391800    | 05-Oct-2019 | 07:19 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5492.2 | 150344    | 05-Oct-2019 | 07:13 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5492.2 | 139080    | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5492.2 | 158832    | 05-Oct-2019 | 07:13 | x64      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5492.2 | 144496    | 05-Oct-2019 | 07:14 | x86      |
| Msdtssrvr.exe                                      | 13.0.5492.2     | 216688    | 05-Oct-2019 | 07:14 | x64      |
| Msdtssrvrutil.dll                                  | 2015.131.5492.2 | 101496    | 05-Oct-2019 | 07:16 | x64      |
| Msdtssrvrutil.dll                                  | 2015.131.5492.2 | 90232     | 05-Oct-2019 | 07:17 | x86      |
| Oledbdest.dll                                      | 2015.131.5492.2 | 216904    | 05-Oct-2019 | 07:17 | x86      |
| Oledbdest.dll                                      | 2015.131.5492.2 | 264304    | 05-Oct-2019 | 07:17 | x64      |
| Oledbsrc.dll                                       | 2015.131.5492.2 | 290928    | 05-Oct-2019 | 07:16 | x64      |
| Oledbsrc.dll                                       | 2015.131.5492.2 | 235840    | 05-Oct-2019 | 07:17 | x86      |
| Rawdest.dll                                        | 2015.131.5492.2 | 209528    | 05-Oct-2019 | 07:17 | x64      |
| Rawdest.dll                                        | 2015.131.5492.2 | 168776    | 05-Oct-2019 | 07:17 | x86      |
| Rawsource.dll                                      | 2015.131.5492.2 | 196936    | 05-Oct-2019 | 07:16 | x64      |
| Rawsource.dll                                      | 2015.131.5492.2 | 155456    | 05-Oct-2019 | 07:17 | x86      |
| Recordsetdest.dll                                  | 2015.131.5492.2 | 186992    | 05-Oct-2019 | 07:17 | x64      |
| Recordsetdest.dll                                  | 2015.131.5492.2 | 151656    | 05-Oct-2019 | 07:17 | x86      |
| Sql_is_keyfile.dll                                 | 2015.131.5492.2 | 100672    | 05-Oct-2019 | 07:17 | x64      |
| Sqlceip.exe                                        | 13.0.5492.2     | 256112    | 05-Oct-2019 | 07:14 | x86      |
| Sqldest.dll                                        | 2015.131.5492.2 | 263800    | 05-Oct-2019 | 07:15 | x64      |
| Sqldest.dll                                        | 2015.131.5492.2 | 215672    | 05-Oct-2019 | 07:17 | x86      |
| Sqltaskconnections.dll                             | 2015.131.5492.2 | 151160    | 05-Oct-2019 | 07:17 | x86      |
| Sqltaskconnections.dll                             | 2015.131.5492.2 | 180848    | 05-Oct-2019 | 07:51 | x64      |
| Ssisoledb.dll                                      | 2015.131.5492.2 | 176752    | 05-Oct-2019 | 07:17 | x86      |
| Ssisoledb.dll                                      | 2015.131.5492.2 | 216176    | 05-Oct-2019 | 07:51 | x64      |
| Txagg.dll                                          | 2015.131.5492.2 | 304760    | 05-Oct-2019 | 07:13 | x86      |
| Txagg.dll                                          | 2015.131.5492.2 | 364656    | 05-Oct-2019 | 07:51 | x64      |
| Txbdd.dll                                          | 2015.131.5492.2 | 138048    | 05-Oct-2019 | 07:13 | x86      |
| Txbdd.dll                                          | 2015.131.5492.2 | 172864    | 05-Oct-2019 | 07:51 | x64      |
| Txbestmatch.dll                                    | 2015.131.5492.2 | 496240    | 05-Oct-2019 | 07:14 | x86      |
| Txbestmatch.dll                                    | 2015.131.5492.2 | 611440    | 05-Oct-2019 | 07:51 | x64      |
| Txcache.dll                                        | 2015.131.5492.2 | 148088    | 05-Oct-2019 | 07:14 | x86      |
| Txcache.dll                                        | 2015.131.5492.2 | 183408    | 05-Oct-2019 | 07:51 | x64      |
| Txcharmap.dll                                      | 2015.131.5492.2 | 250480    | 05-Oct-2019 | 07:14 | x86      |
| Txcharmap.dll                                      | 2015.131.5492.2 | 289904    | 05-Oct-2019 | 07:50 | x64      |
| Txcopymap.dll                                      | 2015.131.5492.2 | 147568    | 05-Oct-2019 | 07:14 | x86      |
| Txcopymap.dll                                      | 2015.131.5492.2 | 182896    | 05-Oct-2019 | 07:51 | x64      |
| Txdataconvert.dll                                  | 2015.131.5492.2 | 255088    | 05-Oct-2019 | 07:14 | x86      |
| Txdataconvert.dll                                  | 2015.131.5492.2 | 296552    | 05-Oct-2019 | 07:51 | x64      |
| Txderived.dll                                      | 2015.131.5492.2 | 519288    | 05-Oct-2019 | 07:13 | x86      |
| Txderived.dll                                      | 2015.131.5492.2 | 607848    | 05-Oct-2019 | 07:51 | x64      |
| Txfileextractor.dll                                | 2015.131.5492.2 | 162928    | 05-Oct-2019 | 07:14 | x86      |
| Txfileextractor.dll                                | 2015.131.5492.2 | 201840    | 05-Oct-2019 | 07:51 | x64      |
| Txfileinserter.dll                                 | 2015.131.5492.2 | 160880    | 05-Oct-2019 | 07:14 | x86      |
| Txfileinserter.dll                                 | 2015.131.5492.2 | 199792    | 05-Oct-2019 | 07:51 | x64      |
| Txgroupdups.dll                                    | 2015.131.5492.2 | 231544    | 05-Oct-2019 | 07:14 | x86      |
| Txgroupdups.dll                                    | 2015.131.5492.2 | 290920    | 05-Oct-2019 | 07:51 | x64      |
| Txlineage.dll                                      | 2015.131.5492.2 | 109680    | 05-Oct-2019 | 07:13 | x86      |
| Txlineage.dll                                      | 2015.131.5492.2 | 137840    | 05-Oct-2019 | 07:51 | x64      |
| Txlookup.dll                                       | 2015.131.5492.2 | 449856    | 05-Oct-2019 | 07:13 | x86      |
| Txlookup.dll                                       | 2015.131.5492.2 | 532080    | 05-Oct-2019 | 07:51 | x64      |
| Txmerge.dll                                        | 2015.131.5492.2 | 176760    | 05-Oct-2019 | 07:13 | x86      |
| Txmerge.dll                                        | 2015.131.5492.2 | 230512    | 05-Oct-2019 | 07:51 | x64      |
| Txmergejoin.dll                                    | 2015.131.5492.2 | 223856    | 05-Oct-2019 | 07:14 | x86      |
| Txmergejoin.dll                                    | 2015.131.5492.2 | 278640    | 05-Oct-2019 | 07:51 | x64      |
| Txmulticast.dll                                    | 2015.131.5492.2 | 102008    | 05-Oct-2019 | 07:13 | x86      |
| Txmulticast.dll                                    | 2015.131.5492.2 | 128112    | 05-Oct-2019 | 07:51 | x64      |
| Txpivot.dll                                        | 2015.131.5492.2 | 181880    | 05-Oct-2019 | 07:14 | x86      |
| Txpivot.dll                                        | 2015.131.5492.2 | 227952    | 05-Oct-2019 | 07:51 | x64      |
| Txrowcount.dll                                     | 2015.131.5492.2 | 101496    | 05-Oct-2019 | 07:13 | x86      |
| Txrowcount.dll                                     | 2015.131.5492.2 | 126568    | 05-Oct-2019 | 07:51 | x64      |
| Txsampling.dll                                     | 2015.131.5492.2 | 134768    | 05-Oct-2019 | 07:13 | x86      |
| Txsampling.dll                                     | 2015.131.5492.2 | 172144    | 05-Oct-2019 | 07:51 | x64      |
| Txscd.dll                                          | 2015.131.5492.2 | 169592    | 05-Oct-2019 | 07:14 | x86      |
| Txscd.dll                                          | 2015.131.5492.2 | 220264    | 05-Oct-2019 | 07:51 | x64      |
| Txsort.dll                                         | 2015.131.5492.2 | 211056    | 05-Oct-2019 | 07:14 | x86      |
| Txsort.dll                                         | 2015.131.5492.2 | 259184    | 05-Oct-2019 | 07:51 | x64      |
| Txsplit.dll                                        | 2015.131.5492.2 | 513136    | 05-Oct-2019 | 07:12 | x86      |
| Txsplit.dll                                        | 2015.131.5492.2 | 600688    | 05-Oct-2019 | 07:51 | x64      |
| Txtermextraction.dll                               | 2015.131.5492.2 | 8615536   | 05-Oct-2019 | 07:14 | x86      |
| Txtermextraction.dll                               | 2015.131.5492.2 | 8677992   | 05-Oct-2019 | 07:51 | x64      |
| Txtermlookup.dll                                   | 2015.131.5492.2 | 4106864   | 05-Oct-2019 | 07:14 | x86      |
| Txtermlookup.dll                                   | 2015.131.5492.2 | 4158576   | 05-Oct-2019 | 07:51 | x64      |
| Txunionall.dll                                     | 2015.131.5492.2 | 138872    | 05-Oct-2019 | 07:14 | x86      |
| Txunionall.dll                                     | 2015.131.5492.2 | 181872    | 05-Oct-2019 | 07:51 | x64      |
| Txunpivot.dll                                      | 2015.131.5492.2 | 162616    | 05-Oct-2019 | 07:13 | x86      |
| Txunpivot.dll                                      | 2015.131.5492.2 | 201840    | 05-Oct-2019 | 07:51 | x64      |
| Xe.dll                                             | 2015.131.5492.2 | 558904    | 05-Oct-2019 | 07:16 | x86      |
| Xe.dll                                             | 2015.131.5492.2 | 626504    | 05-Oct-2019 | 07:20 | x64      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date     | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|----------|-------|----------|
| Dms.dll                                                              | 10.0.8224.49     | 483624    | 09-May-2019 | 19:33 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.49 | 75560     | 09-May-2019 | 19:33 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.49     | 45864     | 09-May-2019 | 19:33 | x86      |
| Instapi130.dll                                                       | 2015.131.5492.2  | 61040     | 05-Oct-2019 | 07:51  | x64      |
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
| Mpdwinterop.dll                                                      | 2015.131.5492.2  | 395064    | 05-Oct-2019 | 07:17  | x64      |
| Mpdwsvc.exe                                                          | 2015.131.5492.2  | 6618736   | 05-Oct-2019 | 07:21  | x64      |
| Pdwodbcsql11.dll                                                     | 2015.131.5492.2  | 2229864   | 05-Oct-2019 | 07:51  | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.49 | 47400     | 09-May-2019 | 19:33 | x64      |
| Sqldk.dll                                                            | 2015.131.5492.2  | 2532968   | 05-Oct-2019 | 07:51  | x64      |
| Sqldumper.exe                                                        | 2015.131.5492.2  | 127080    | 05-Oct-2019 | 07:21  | x64      |
| Sqlos.dll                                                            | 2015.131.5492.2  | 26224     | 05-Oct-2019 | 07:51  | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.49 | 4348200   | 09-May-2019 | 19:33 | x64      |
| Sqltses.dll                                                          | 2015.131.5492.2  | 9092720   | 05-Oct-2019 | 07:51  | x64      |

SQL Server 2016 Reporting Services

| File   name                                               | File version    | File size | Date     | Time | Platform |
|-----------------------------------------------------------|-----------------|-----------|----------|------|----------|
| Microsoft.analysisservices.modeling.dll                   | 13.0.5492.2     | 610936    | 05-Oct-2019 | 07:20 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.5492.2     | 1620080   | 05-Oct-2019 | 07:16 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.5492.2     | 658032    | 05-Oct-2019 | 07:19 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.5492.2     | 330048    | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.5492.2     | 1090672   | 05-Oct-2019 | 07:21 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5492.2     | 548464    | 05-Oct-2019 | 07:18 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5492.2     | 548472    | 05-Oct-2019 | 07:13 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5492.2     | 548704    | 05-Oct-2019 | 07:14 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5492.2     | 548464    | 05-Oct-2019 | 07:21 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5492.2     | 548672    | 05-Oct-2019 | 07:19 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5492.2     | 548464    | 05-Oct-2019 | 07:14 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5492.2     | 548680    | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5492.2     | 548464    | 05-Oct-2019 | 07:42 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5492.2     | 548464    | 05-Oct-2019 | 07:17 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5492.2     | 548680    | 05-Oct-2019 | 07:19 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.5492.2     | 163144    | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.5492.2     | 126280    | 05-Oct-2019 | 07:16 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.5492.2     | 6076736   | 05-Oct-2019 | 07:16 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5492.2     | 4511344   | 05-Oct-2019 | 07:18 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5492.2     | 4511864   | 05-Oct-2019 | 07:13 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5492.2     | 4511856   | 05-Oct-2019 | 07:14 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5492.2     | 4511856   | 05-Oct-2019 | 07:21 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5492.2     | 4512368   | 05-Oct-2019 | 07:20 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5492.2     | 4512584   | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5492.2     | 4512064   | 05-Oct-2019 | 07:16 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5492.2     | 4512880   | 05-Oct-2019 | 07:42 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5492.2     | 4511344   | 05-Oct-2019 | 07:17 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5492.2     | 4512064   | 05-Oct-2019 | 07:20 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.5492.2     | 10894144  | 05-Oct-2019 | 07:17 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.5492.2     | 100976    | 05-Oct-2019 | 07:14 | x64      |
| Microsoft.reportingservices.storage.dll                   | 13.0.5492.2     | 208496    | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.131.5492.2 | 47736     | 05-Oct-2019 | 07:17 | x64      |
| Microsoft.sqlserver.types.dll                             | 2015.131.5492.2 | 393032    | 05-Oct-2019 | 07:12 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.131.5492.2 | 397128    | 05-Oct-2019 | 07:18 | x86      |
| Msmdlocal.dll                                             | 2015.131.5492.2 | 37129024  | 05-Oct-2019 | 07:17 | x86      |
| Msmdlocal.dll                                             | 2015.131.5492.2 | 56245360  | 05-Oct-2019 | 07:18 | x64      |
| Msmgdsrv.dll                                              | 2015.131.5492.2 | 7509616   | 05-Oct-2019 | 07:15 | x64      |
| Msmgdsrv.dll                                              | 2015.131.5492.2 | 6508648   | 05-Oct-2019 | 07:17 | x86      |
| Msolap130.dll                                             | 2015.131.5492.2 | 7010416   | 05-Oct-2019 | 07:17 | x86      |
| Msolap130.dll                                             | 2015.131.5492.2 | 8643184   | 05-Oct-2019 | 07:17 | x64      |
| Msolui130.dll                                             | 2015.131.5492.2 | 310384    | 05-Oct-2019 | 07:17 | x64      |
| Msolui130.dll                                             | 2015.131.5492.2 | 287344    | 05-Oct-2019 | 07:17 | x86      |
| Reportingservicescompression.dll                          | 2015.131.5492.2 | 62784     | 05-Oct-2019 | 07:16 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.5492.2     | 84808     | 05-Oct-2019 | 07:16 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.5492.2     | 2543944   | 05-Oct-2019 | 07:15 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.131.5492.2 | 108664    | 05-Oct-2019 | 07:15 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.131.5492.2 | 114288    | 05-Oct-2019 | 07:17 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.131.5492.2 | 98928     | 05-Oct-2019 | 07:15 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.5492.2     | 2728560   | 05-Oct-2019 | 07:15 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5492.2     | 884344    | 05-Oct-2019 | 07:18 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5492.2     | 888432    | 05-Oct-2019 | 07:17 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5492.2     | 888432    | 05-Oct-2019 | 07:17 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5492.2     | 888432    | 05-Oct-2019 | 07:40 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5492.2     | 892528    | 05-Oct-2019 | 07:19 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5492.2     | 888440    | 05-Oct-2019 | 07:22 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5492.2     | 888432    | 05-Oct-2019 | 07:15 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5492.2     | 900720    | 05-Oct-2019 | 07:21 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5492.2     | 884544    | 05-Oct-2019 | 07:40 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5492.2     | 888432    | 05-Oct-2019 | 07:21 | x86      |
| Rshttpruntime.dll                                         | 2015.131.5492.2 | 99440     | 05-Oct-2019 | 07:14 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.131.5492.2 | 100672    | 05-Oct-2019 | 07:17 | x64      |
| Sqldumper.exe                                             | 2015.131.5492.2 | 107640    | 05-Oct-2019 | 07:12 | x86      |
| Sqldumper.exe                                             | 2015.131.5492.2 | 127088    | 05-Oct-2019 | 07:17 | x64      |
| Sqlrsos.dll                                               | 2015.131.5492.2 | 26216     | 05-Oct-2019 | 07:51 | x64      |
| Sqlserverspatial130.dll                                   | 2015.131.5492.2 | 584520    | 05-Oct-2019 | 07:16 | x86      |
| Sqlserverspatial130.dll                                   | 2015.131.5492.2 | 732784    | 05-Oct-2019 | 07:16 | x64      |
| Xmlrw.dll                                                 | 2015.131.5492.2 | 259904    | 05-Oct-2019 | 07:13 | x86      |
| Xmlrw.dll                                                 | 2015.131.5492.2 | 319304    | 05-Oct-2019 | 07:15 | x64      |
| Xmlrwbin.dll                                              | 2015.131.5492.2 | 191600    | 05-Oct-2019 | 07:13 | x86      |
| Xmlrwbin.dll                                              | 2015.131.5492.2 | 227448    | 05-Oct-2019 | 07:15 | x64      |
| Xmsrv.dll                                                 | 2015.131.5492.2 | 32727664  | 05-Oct-2019 | 07:14 | x86      |
| Xmsrv.dll                                                 | 2015.131.5492.2 | 24051824  | 05-Oct-2019 | 07:51 | x64      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version    | File size | Date     | Time | Platform |
|------------------------------------|-----------------|-----------|----------|------|----------|
| Smrdll.dll                         | 13.0.5492.2     | 23664     | 05-Oct-2019 | 07:14 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.131.5492.2 | 100672    | 05-Oct-2019 | 07:17 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                    | File version    | File size | Date     | Time | Platform |
|------------------------------------------------|-----------------|-----------|----------|------|----------|
| Autoadmin.dll                                  | 2015.131.5492.2 | 1311864   | 05-Oct-2019 | 07:14 | x86      |
| Ddsshapes.dll                                  | 2015.131.5492.2 | 135792    | 05-Oct-2019 | 07:13 | x86      |
| Dtaengine.exe                                  | 2015.131.5492.2 | 167032    | 05-Oct-2019 | 07:13 | x86      |
| Dteparse.dll                                   | 2015.131.5492.2 | 99448     | 05-Oct-2019 | 07:12 | x86      |
| Dteparse.dll                                   | 2015.131.5492.2 | 109680    | 05-Oct-2019 | 07:18 | x64      |
| Dteparsemgd.dll                                | 2015.131.5492.2 | 83568     | 05-Oct-2019 | 07:15 | x86      |
| Dteparsemgd.dll                                | 2015.131.5492.2 | 88688     | 05-Oct-2019 | 07:21 | x64      |
| Dtepkg.dll                                     | 2015.131.5492.2 | 115824    | 05-Oct-2019 | 07:13 | x86      |
| Dtepkg.dll                                     | 2015.131.5492.2 | 137328    | 05-Oct-2019 | 07:18 | x64      |
| Dtexec.exe                                     | 2015.131.5492.2 | 66680     | 05-Oct-2019 | 07:14 | x86      |
| Dtexec.exe                                     | 2015.131.5492.2 | 73032     | 05-Oct-2019 | 07:15 | x64      |
| Dts.dll                                        | 2015.131.5492.2 | 2633024   | 05-Oct-2019 | 07:14 | x86      |
| Dts.dll                                        | 2015.131.5492.2 | 3147080   | 05-Oct-2019 | 07:18 | x64      |
| Dtscomexpreval.dll                             | 2015.131.5492.2 | 418928    | 05-Oct-2019 | 07:12 | x86      |
| Dtscomexpreval.dll                             | 2015.131.5492.2 | 477536    | 05-Oct-2019 | 07:18 | x64      |
| Dtsconn.dll                                    | 2015.131.5492.2 | 392304    | 05-Oct-2019 | 07:12 | x86      |
| Dtsconn.dll                                    | 2015.131.5492.2 | 492656    | 05-Oct-2019 | 07:19 | x64      |
| Dtshost.exe                                    | 2015.131.5492.2 | 76408     | 05-Oct-2019 | 07:14 | x86      |
| Dtshost.exe                                    | 2015.131.5492.2 | 86856     | 05-Oct-2019 | 07:15 | x64      |
| Dtslog.dll                                     | 2015.131.5492.2 | 103024    | 05-Oct-2019 | 07:12 | x86      |
| Dtslog.dll                                     | 2015.131.5492.2 | 120648    | 05-Oct-2019 | 07:18 | x64      |
| Dtsmsg130.dll                                  | 2015.131.5492.2 | 541296    | 05-Oct-2019 | 07:13 | x86      |
| Dtsmsg130.dll                                  | 2015.131.5492.2 | 545392    | 05-Oct-2019 | 07:18 | x64      |
| Dtspipeline.dll                                | 2015.131.5492.2 | 1059440   | 05-Oct-2019 | 07:12 | x86      |
| Dtspipeline.dll                                | 2015.131.5492.2 | 1279088   | 05-Oct-2019 | 07:18 | x64      |
| Dtspipelineperf130.dll                         | 2015.131.5492.2 | 42096     | 05-Oct-2019 | 07:12 | x86      |
| Dtspipelineperf130.dll                         | 2015.131.5492.2 | 48240     | 05-Oct-2019 | 07:18 | x64      |
| Dtuparse.dll                                   | 2015.131.5492.2 | 79984     | 05-Oct-2019 | 07:12 | x86      |
| Dtuparse.dll                                   | 2015.131.5492.2 | 87664     | 05-Oct-2019 | 07:17 | x64      |
| Dtutil.exe                                     | 2015.131.5492.2 | 115320    | 05-Oct-2019 | 07:14 | x86      |
| Dtutil.exe                                     | 2015.131.5492.2 | 134768    | 05-Oct-2019 | 07:15 | x64      |
| Exceldest.dll                                  | 2015.131.5492.2 | 216696    | 05-Oct-2019 | 07:12 | x86      |
| Exceldest.dll                                  | 2015.131.5492.2 | 263520    | 05-Oct-2019 | 07:17 | x64      |
| Excelsrc.dll                                   | 2015.131.5492.2 | 232560    | 05-Oct-2019 | 07:12 | x86      |
| Excelsrc.dll                                   | 2015.131.5492.2 | 285296    | 05-Oct-2019 | 07:18 | x64      |
| Flatfiledest.dll                               | 2015.131.5492.2 | 334440    | 05-Oct-2019 | 07:12 | x86      |
| Flatfiledest.dll                               | 2015.131.5492.2 | 389440    | 05-Oct-2019 | 07:17 | x64      |
| Flatfilesrc.dll                                | 2015.131.5492.2 | 345192    | 05-Oct-2019 | 07:12 | x86      |
| Flatfilesrc.dll                                | 2015.131.5492.2 | 401736    | 05-Oct-2019 | 07:18 | x64      |
| Foreachfileenumerator.dll                      | 2015.131.5492.2 | 80496     | 05-Oct-2019 | 07:12 | x86      |
| Foreachfileenumerator.dll                      | 2015.131.5492.2 | 96376     | 05-Oct-2019 | 07:18 | x64      |
| Microsoft.analysisservices.adomdclientui.dll   | 13.0.5492.2     | 92264     | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.analysisservices.applocal.core.dll   | 13.0.5492.2     | 1313912   | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.analysisservices.project.dll         | 2015.131.5492.2 | 2023232   | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.analysisservices.projectui.dll       | 2015.131.5492.2 | 42304     | 05-Oct-2019 | 07:16 | x86      |
| Microsoft.sqlserver.astasks.dll                | 13.0.5492.2     | 73336     | 05-Oct-2019 | 07:16 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5492.2     | 436032    | 05-Oct-2019 | 07:16 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5492.2     | 436032    | 05-Oct-2019 | 07:16 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5492.2     | 2044520   | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5492.2     | 2044528   | 05-Oct-2019 | 07:16 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5492.2 | 150344    | 05-Oct-2019 | 07:13 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5492.2 | 139080    | 05-Oct-2019 | 07:15 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5492.2 | 158832    | 05-Oct-2019 | 07:13 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5492.2 | 144496    | 05-Oct-2019 | 07:14 | x86      |
| Msdtssrvrutil.dll                              | 2015.131.5492.2 | 101496    | 05-Oct-2019 | 07:16 | x64      |
| Msdtssrvrutil.dll                              | 2015.131.5492.2 | 90232     | 05-Oct-2019 | 07:17 | x86      |
| Msmdlocal.dll                                  | 2015.131.5492.2 | 37129024  | 05-Oct-2019 | 07:17 | x86      |
| Msmdlocal.dll                                  | 2015.131.5492.2 | 56245360  | 05-Oct-2019 | 07:18 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5492.2 | 7509616   | 05-Oct-2019 | 07:15 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5492.2 | 6508648   | 05-Oct-2019 | 07:17 | x86      |
| Msolap130.dll                                  | 2015.131.5492.2 | 7010416   | 05-Oct-2019 | 07:17 | x86      |
| Msolap130.dll                                  | 2015.131.5492.2 | 8643184   | 05-Oct-2019 | 07:17 | x64      |
| Msolui130.dll                                  | 2015.131.5492.2 | 310384    | 05-Oct-2019 | 07:17 | x64      |
| Msolui130.dll                                  | 2015.131.5492.2 | 287344    | 05-Oct-2019 | 07:17 | x86      |
| Oledbdest.dll                                  | 2015.131.5492.2 | 216904    | 05-Oct-2019 | 07:17 | x86      |
| Oledbdest.dll                                  | 2015.131.5492.2 | 264304    | 05-Oct-2019 | 07:17 | x64      |
| Oledbsrc.dll                                   | 2015.131.5492.2 | 290928    | 05-Oct-2019 | 07:16 | x64      |
| Oledbsrc.dll                                   | 2015.131.5492.2 | 235840    | 05-Oct-2019 | 07:17 | x86      |
| Profiler.exe                                   | 2015.131.5492.2 | 804464    | 05-Oct-2019 | 07:15 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.131.5492.2 | 100672    | 05-Oct-2019 | 07:17 | x64      |
| Sqldumper.exe                                  | 2015.131.5492.2 | 107640    | 05-Oct-2019 | 07:12 | x86      |
| Sqldumper.exe                                  | 2015.131.5492.2 | 127088    | 05-Oct-2019 | 07:17 | x64      |
| Sqlresld.dll                                   | 2015.131.5492.2 | 28992     | 05-Oct-2019 | 07:16 | x86      |
| Sqlresld.dll                                   | 2015.131.5492.2 | 31040     | 05-Oct-2019 | 07:51 | x64      |
| Sqlresourceloader.dll                          | 2015.131.5492.2 | 28512     | 05-Oct-2019 | 07:16 | x86      |
| Sqlresourceloader.dll                          | 2015.131.5492.2 | 31040     | 05-Oct-2019 | 07:51 | x64      |
| Sqlscm.dll                                     | 2015.131.5492.2 | 61040     | 05-Oct-2019 | 07:14 | x64      |
| Sqlscm.dll                                     | 2015.131.5492.2 | 53064     | 05-Oct-2019 | 07:16 | x86      |
| Sqlsvc.dll                                     | 2015.131.5492.2 | 127088    | 05-Oct-2019 | 07:16 | x86      |
| Sqlsvc.dll                                     | 2015.131.5492.2 | 152392    | 05-Oct-2019 | 07:51 | x64      |
| Sqltaskconnections.dll                         | 2015.131.5492.2 | 151160    | 05-Oct-2019 | 07:17 | x86      |
| Sqltaskconnections.dll                         | 2015.131.5492.2 | 180848    | 05-Oct-2019 | 07:51 | x64      |
| Txdataconvert.dll                              | 2015.131.5492.2 | 255088    | 05-Oct-2019 | 07:14 | x86      |
| Txdataconvert.dll                              | 2015.131.5492.2 | 296552    | 05-Oct-2019 | 07:51 | x64      |
| Xe.dll                                         | 2015.131.5492.2 | 558904    | 05-Oct-2019 | 07:16 | x86      |
| Xe.dll                                         | 2015.131.5492.2 | 626504    | 05-Oct-2019 | 07:20 | x64      |
| Xmlrw.dll                                      | 2015.131.5492.2 | 259904    | 05-Oct-2019 | 07:13 | x86      |
| Xmlrw.dll                                      | 2015.131.5492.2 | 319304    | 05-Oct-2019 | 07:15 | x64      |
| Xmlrwbin.dll                                   | 2015.131.5492.2 | 191600    | 05-Oct-2019 | 07:13 | x86      |
| Xmlrwbin.dll                                   | 2015.131.5492.2 | 227448    | 05-Oct-2019 | 07:15 | x64      |
| Xmsrv.dll                                      | 2015.131.5492.2 | 32727664  | 05-Oct-2019 | 07:14 | x86      |
| Xmsrv.dll                                      | 2015.131.5492.2 | 24051824  | 05-Oct-2019 | 07:51 | x64      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
