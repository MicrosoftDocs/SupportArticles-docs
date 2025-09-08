---
title: Cumulative update 5 for SQL Server 2016 (KB4013105)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 cumulative update 5 (KB4013105).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4013105
appliesto:
- SQL Server 2016
---

# KB4013105 - Cumulative Update 5 for SQL Server 2016

_Release Date:_ &nbsp; March 20, 2017  
_Version:_ &nbsp; 13.0.2197.0

This article describes cumulative update package 5 (build number: 13.0.2197.0) for Microsoft SQL Server 2016. This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Known issues in this update

After installing this CU, Change Data Capture (CDC) functionality might break if:

- The databases enabled for CDC are part of Always On availability group (or)

- SQL Server replication components aren't installed on the server

For more information, see:

- [CDC functionality may break after upgrading to the latest CU for SQL Server 2012, 2014 and 2016](https://techcommunity.microsoft.com/t5/sql-server-blog/cdc-functionality-may-break-after-upgrading-to-the-latest-cu-for/ba-p/385297)

- [Special steps for change data capture or replication](/sql/database-engine/availability-groups/windows/upgrading-always-on-availability-group-replica-instances)

## Improvements and fixes included in this update

| Bug reference | Description| Fix area |
|------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|
| <a id=9077598>[9077598](#9077598) </a> | [FIX: "Adjust height to fit zone" setting of the SSRS 2016 Report Viewer Web Part isn't respected on a SharePoint webpage (KB3211948)](https://support.microsoft.com/help/3211948) | Reporting Services |
| <a id=9367817>[9367817](#9367817) </a> | [FIX: Cannot save the SSRS report after you change a parameter in Report Builder or the SQL Server Data Tool (KB3212193)](https://support.microsoft.com/help/3212193)| Reporting Services |
| <a id=9503251>[9503251](#9503251) </a> | [FIX: An MDX query returns incorrect results in SSAS 2014 or 2016 Tabular mode (KB4009839)](https://support.microsoft.com/help/4009839)| Analysis Services|
| <a id=8463442>[8463442](#8463442) </a> | [FIX: Wrong number of rows returned in sys.partitions for Columnstore index in SQL Server 2016 (KB3195752)](https://support.microsoft.com/help/3195752)| SQL Engine|
| <a id=9237404>[9237404](#9237404) </a> | [FIX: Error 21050 when you remove a table that is not part of a publication in SQL Server 2014 or 2016 (KB3209459)](https://support.microsoft.com/help/3209459)| SQL service|
| <a id=9237351>[9237351](#9237351) </a> | [FIX: "No Data Available" in the SQL Server Memory Usage page in the SQL Server 2014 or 2016 MDM report (KB3209442)](https://support.microsoft.com/help/3209442) | Management Tools |
| <a id=8532466>[8532466](#8532466) </a> | [FIX: Internal error 'FAC_HK_INTERNAL' when you insert or update large numbers of rows of data into or in a memory-optimized table in SQL Server 2016 (K4009794)](https://support.microsoft.com/help/4009794) | In-Memory OLTP |
| <a id=9237398>[9237398](#9237398) </a> | [FIX: Memory leak when you query sys.dm_sql_referenced_entities view in SQL Server 2014 or 2016 (KB3205994)](https://support.microsoft.com/help/3205994) | SQL service|
| <a id=9367827>[9367827](#9367827) </a> | [FIX: Changing the data type and then updating the table with more than 4,000 records causes database corruption (KB3213240)](https://support.microsoft.com/help/3213240)| SQL service|
| <a id=9231234>[9231234](#9231234) </a> | [FIX: DMV sys.dm_os_spinlock_stats returns incorrect results after you install SQL Server 2016 CU5 (KB3208460)](https://support.microsoft.com/help/3208460)| SQL service|
| <a id=9398962>[9398962](#9398962) </a> | [FIX: The sys.column_store_segments catalog view displays incorrect values in the column_id column in SQL Server 2016 (KB4013118)](https://support.microsoft.com/help/4013118) | SQL service|
| <a id=9237312>[9237312](#9237312) </a> | [FIX: Memory is paged out when columnstore index query consumes lots of memory in SQL Server 2014 or 2016 (KB3067968)](https://support.microsoft.com/help/3067968) | SQL service|
| <a id=8652609>[8652609](#8652609) </a> | [FIX: Out-of-memory error when you run a query to access LOB columns through In-Memory OLTP in SQL Server 2016 (KB3198751)](https://support.microsoft.com/help/3198751)| In-Memory OLTP |
| <a id=9503260>[9503260](#9503260) </a> | [FIX: "Invoke-sqlcmd" cmdlet executes a query statement multiple times if an error occurs in SQL Server 2014 or 2016 (KB4010159)](https://support.microsoft.com/help/4010159)| Management Tools |
| <a id=9503181>[9503181](#9503181) </a> | [Update improves handling of documents too large for Full-Text Search indexing in SQL Server 2014 or 2016 (KB3208276)](https://support.microsoft.com/help/3208276) | SQL service|
| <a id=9460252>[9460252](#9460252) </a> | [FIX: An access violation occurs when natively compiled stored procedures are executed concurrently in SQL Server 2016 (KB4013124)](https://support.microsoft.com/help/4013124)| In-Memory OLTP |
| <a id=9237340>[9237340](#9237340) </a> | [FIX: Incorrect query result when you use varchar(max) variable in the search condition in SQL Server 2014 or 2016 (KB3208245)](https://support.microsoft.com/help/3208245)| SQL performance|
| <a id=9367388>[9367388](#9367388) </a> | [FIX: "(0x80004002) No such interface supported" error when you use RMO to run Web Synchronization for Merge Replication in SQL Server 2016 (KB4014719)](https://support.microsoft.com/help/4014719) | SQL service|
| <a id=9237386>[9237386](#9237386) </a> | [FIX: Resize handle is missing from the parameter combo box in SQL Server 2014 or 2016 Reporting Services (KB3192069)](https://support.microsoft.com/help/3192069) | Reporting Services |
| <a id=8930551>[8930551](#8930551) </a> | [Update enables DML query plan to scan query memory-optimized tables in parallel in SQL Server 2016 (KB4013877)](https://support.microsoft.com/help/4013877) | In-Memory OLTP |
| <a id=8845976>[8845976](#8845976) </a> | [A memory leak occurs when you use Azure Storage in SQL Server 2014 or 2016 (KB3174370)](https://support.microsoft.com/help/3174370) | SQL service|
| <a id=8497323>[8497323](#8497323) </a> | [FIX: Distribution Agent fails for a SQL Server 2014 publisher and a SQL Server 2012 subscriber in Transactional Replication (KB3204469)](https://support.microsoft.com/help/3204469)| SQL service|
| <a id=9503253>[9503253](#9503253) </a> | [FIX: Can't set a database to partial containment if SQL Server change tracking was ever enabled on that database (KB3212318)](https://support.microsoft.com/help/3212318) | SQL service|
| <a id=9503265>[9503265](#9503265) </a> | [FIX: A system assert occurs when a Transact-SQL stored procedure with a TVP argument is called from a SQLCLR procedure (KB4010162)](https://support.microsoft.com/help/4010162) | SQL service|
| <a id=9367821>[9367821](#9367821) </a> | [MS15-058: Description of the security update for SQL Server 2012 Service Pack 2 GDR: July 14, 2015 (KB3045321)](https://support.microsoft.com/help/3045321) | Reporting Services |
| <a id=9237408>[9237408](#9237408) </a> | [FIX: You cannot select any replica when you fail over from an availability group that's in the resolving state (KB3208524)](https://support.microsoft.com/help/3208524)| High Availability|
| <a id=9503249>[9503249](#9503249) </a> | [FIX: AFTER DELETE triggers occur in the wrong order in the ON DELETE CASCADE action chain in SQL Server 2014 and 2016 (KB4009823)](https://support.microsoft.com/help/4009823)| SQL performance|
| <a id=9491987>[9491987](#9491987) </a> | [FIX: SQL Server Launchpad service fails to start if the installed version of R Services (In-Database) is different from the Database Engine in SQL Server 2016 (KB4014734)](https://support.microsoft.com/help/4014734) | SQL service|
| <a id=9237381>[9237381](#9237381) </a> | [FIX: Deadlock causes deferred transaction on the secondary replica in an Always On environment (KB3189959)](https://support.microsoft.com/help/3189959) | High Availability|
| <a id=9237406>[9237406](#9237406) </a> | [FIX: Adding a subscription to an Oracle transactional publication or an Oracle snapshot publication fails in SQL Server 2014 or 2016 (KB3208243)](https://support.microsoft.com/help/3208243)| SQL service|
| <a id=9367861>[9367861](#9367861) </a> | [FIX: Access violation occurs when you run and then cancel a query on distinct count partitions in SSAS (KB3025408)](https://support.microsoft.com/help/3025408) | Analysis Services|
| <a id=9503269>[9503269](#9503269) </a> | [FIX: Memory leak when you run a query that you don't have sufficient permissions for in SQL Server 2014 or 2016 (KB4010710)](https://support.microsoft.com/help/4010710)| SQL security |
| <a id=9237301>[9237301](#9237301) </a> | [FIX: The change table is ordered incorrectly for updated rows after you enable change data capture for a Microsoft SQL Server database (KB3030352)](https://support.microsoft.com/help/3030352) | SQL service|
| <a id=9237363>[9237363](#9237363) </a> | [FIX: MDX query returns errors if the value of MaxRolapOrConditions is greater than 256 in SQL Server Analysis Services (KB3208179)](https://support.microsoft.com/help/3208179) | Analysis Services|
| <a id=9237402>[9237402](#9237402) </a> | [FIX: On failover, the new secondary replica stops accepting transaction log records until the instance is restarted in SQL Server (KB3207327)](https://support.microsoft.com/help/3207327)| High Availability|
| <a id=9379517>[9379517](#9379517) </a> | [FIX: ALTER TABLE, ADD CONSTRAINT, and PRIMARY KEY statements do not detect a duplicate key in SQL Server 2016 (KB4013116)](https://support.microsoft.com/help/4013116)| In-Memory OLTP |
| <a id=9367384>[9367384](#9367384) </a> | [FIX: An Always On secondary replica goes into a disconnecting state (KB3213703)](https://support.microsoft.com/help/3213703)| High Availability|
| <a id=9503258>[9503258](#9503258) </a> | [FIX: The sp_msx_enlist stored procedure fails to enlist a target server into a master server in SQL Server 2014 or 2016 if the server name is too long (KB4010344)](https://support.microsoft.com/help/4010344) | Management Tools |
| <a id=9237345>[9237345](#9237345) </a> | [FIX: Error 2809 when you execute a stored procedure that takes a table-valued parameter from RPC calls in SQL Server 2014 or 2016 (KB3205935)](https://support.microsoft.com/help/3205935)| SQL performance|
| <a id=9367813>[9367813](#9367813) </a> | [FIX: Assert memory dump on a mirror server in SQL Server (KB3192692)](https://support.microsoft.com/help/3192692) | High Availability|
| <a id=9371141>[9371141](#9371141) </a> | [FIX: "ADD PERIOD FOR SYSTEM_TIME failed" error when you add period columns to a memory-optimized table in SQL Server 2016 (KB4013112)](https://support.microsoft.com/help/4013112)||
| <a id=9368262>[9368262](#9368262) </a> | [FIX: Error 5262 when you execute DBCC CHECKDB on the primary replica in SQL Server 2012, 2014 or 2016 (KB3211304)](https://support.microsoft.com/help/3211304)| High Availability|
| <a id=9237316>[9237316](#9237316) </a> | [FIX: Incremental statistics runs with higher sample rate than regular statistics when statistics are created or updated in SQL Server 2014 or 2016 (KB3196877)](https://support.microsoft.com/help/3196877) | SQL performance|
| <a id=9237400>[9237400](#9237400) </a> | [FIX: Availability databases in incorrect initializing/synchronizing state after failover of SQL Server 2014 or 2016 AlwaysOn availability group (KB3206299)](https://support.microsoft.com/help/3206299)| High Availability|
| <a id=9368267>[9368267](#9368267) </a> | [FIX: RDL report that's generated programmatically fails to run in SSRS (KB3157016)](https://support.microsoft.com/help/3157016) | Reporting Services |
| <a id=9237389>[9237389](#9237389) </a> | [FIX: Intra-query deadlock when values are inserted into a partitioned clustered columnstore index in SQL Server 2014 or 2016 (KB3204769)](https://support.microsoft.com/help/3204769) | SQL services |
| <a id=9503271>[9503271](#9503271) </a> | [FIX: SQL Server is stopped when you install patches on an instance of SQL Server that contains many databases (KB4010990)](https://support.microsoft.com/help/4010990)| Setup & Install|
| <a id=9379254>[9379254](#9379254) </a> | [FIX: Bad query plan created on secondary replicas after FULLSCAN statistics update on primary replica in SQL Server 2016 (KB4016655)](https://support.microsoft.com/help/4016655) | Setup & Install|
| <a id=8850865>[8850865](#8850865) </a> | Fixes large virtual allocations the size of Max Server Memory causing out of memory errors.| SQL Engine |

## How to obtain this cumulative update package

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for Microsoft SQL Server 2016 now](https://www.microsoft.com/download/details.aspx?id=53338)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

> [!NOTE]
> After future cumulative updates are released for SQL Server 2016, this CU can be located and downloaded from the [Microsoft Windows Update Catalog](https://catalog.update.microsoft.com/Search.aspx?q=sql%20server%202016). However, Microsoft recommends that you install the latest cumulative update available.

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
  > If you don't want to use the rolling update process, follow these steps to apply a CU or SP: </br></br>1. Install the service pack on the passive node. </br></br>2. Install the service pack on the active node (requires a service restart).

- [Upgrade availability group replicas](/sql/database-engine/availability-groups/windows/upgrading-always-on-availability-group-replica-instances)

  > [!NOTE]
  > If you enabled Always On with SSISDB catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) for more information about how to apply a CU or SP in these environments.

- [Apply a hotfix for SQL Server in a transactional replication and database mirroring topology](../../database-engine/replication/install-service-packs-hotfixes.md)

- [Apply a hotfix for SQL Server in a replication topology](../../database-engine/replication/apply-hotfix-sql-replication-topology.md)

- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances)

- [Install SQL Server Servicing Updates](/sql/database-engine/install-windows/install-sql-server-servicing-updates)

</details>

<details>
<summary><b>Language support</b></summary>

- SQL Server Cumulative Updates are currently multilingual. Therefore, this cumulative update package isn't specific to one language. It applies to all supported languages.

- The "Download the latest cumulative update package for Microsoft SQL Server 2014 now" form displays the languages for which the update package is available. If you don't see your language, that's because a cumulative update package isn't available for specifically for that language and the ENU download applies to all languages.

</details>

<details>
<summary><b>Components updated</b></summary>

One cumulative update package includes all the component packages. However, the cumulative update package updates only those components that are installed on the system.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).

</details>

<details>
<summary><b>How to uninstall this update</b></summary>

To do this, follow these steps:

1. In Control Panel, select **Add or Remove Programs**.

   > [!NOTE]
   > If you are running Windows 7 or a later version, select **Programs and Features** in Control Panel.

2. Locate the entry that corresponds to this cumulative update package.

3. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

## Cumulative update package information

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2016.

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

This cumulative update package may not contain all the files that you must have to fully update a product to the latest build. This package contains only the files that you must have to correct the issues that are listed in this article.

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x86-based versions

SQL Server 2016 Database Services Common Core

| File   name                                | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.adomdclient.dll | 13.0.2197.0     | 1023176   | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.analysisservices.core.dll        | 13.0.2197.0     | 1344200   | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.analysisservices.dll             | 13.0.2197.0     | 702664    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.analysisservices.tabular.dll     | 13.0.2197.0     | 765640    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2197.0     | 707264    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.edition.dll            | 13.0.2197.0     | 37064     | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.instapi.dll            | 13.0.2197.0     | 46280     | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2197.0 | 72904     | 25-Feb-2017 | 20:14 | x86      |
| Pbsvcacctsync.dll                          | 2015.130.2197.0 | 60104     | 25-Feb-2017 | 20:14 | x86      |
| Sql_common_core_keyfile.dll                | 2015.130.2197.0 | 88776     | 25-Feb-2017 | 20:13 | x86      |
| Sqlmgmprovider.dll                         | 2015.130.2197.0 | 364224    | 25-Feb-2017 | 20:14 | x86      |
| Sqlsvcsync.dll                             | 2015.130.2197.0 | 267456    | 25-Feb-2017 | 20:14 | x86      |
| Sqltdiagn.dll                              | 2015.130.2197.0 | 60616     | 25-Feb-2017 | 20:14 | x86      |
| Svrenumapi130.dll                          | 2015.130.2197.0 | 854216    | 25-Feb-2017 | 20:14 | x86      |

SQL Server 2016 Data Quality

| File   name                   | File version | File size | Date      | Time  | Platform |
|-------------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.ssdqs.cleansing.dll | 13.0.2197.0  | 473288    | 25-Feb-2017 | 20:13 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2197.0  | 1876680   | 25-Feb-2017 | 20:13 | x86      |

SQL Server 2016 sql_tools_extensions

| File   name                                                  | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dts.dll                                                      | 2015.130.2197.0 | 2631880   | 25-Feb-2017 | 20:13 | x86      |
| Dtspipeline.dll                                              | 2015.130.2197.0 | 1059520   | 25-Feb-2017 | 20:13 | x86      |
| Dtswizard.exe                                                | 13.0.2197.0     | 895688    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2197.0     | 432832    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2197.0     | 2044104   | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2197.0     | 33472     | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2197.0     | 250056    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2197.0     | 33992     | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2197.0     | 606408    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2197.0     | 445120    | 25-Feb-2017 | 20:14 | x86      |
| Msmdlocal.dll                                                | 2015.130.2197.0 | 37014728  | 25-Feb-2017 | 20:14 | x86      |
| Msmgdsrv.dll                                                 | 2015.130.2197.0 | 6501576   | 25-Feb-2017 | 20:13 | x86      |
| Msolap130.dll                                                | 2015.130.2197.0 | 6968008   | 25-Feb-2017 | 20:14 | x86      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2197.0 | 88776     | 25-Feb-2017 | 20:13 | x86      |
| Xmsrv.dll                                                    | 2015.130.2197.0 | 32693952  | 25-Feb-2017 | 20:13 | x86      |

x64-based versions

SQL Server 2016 Business Intelligence Development Studio

| File   name        | File version    | File size | Date      | Time  | Platform |
|--------------------|-----------------|-----------|-----------|-------|----------|
| Sqlsqm_keyfile.dll | 2015.130.2197.0 | 100544    | 25-Feb-2017 | 20:12 | x64      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date      | Time  | Platform |
|-----------------------|-----------------|-----------|-----------|-------|----------|
| Sqlboot.dll           | 2015.130.2197.0 | 186568    | 25-Feb-2017 | 20:12 | x64      |
| Sqlvdi.dll            | 2015.130.2197.0 | 197312    | 25-Feb-2017 | 20:13 | x64      |
| Sqlvdi.dll            | 2015.130.2197.0 | 168648    | 25-Feb-2017 | 20:14 | x86      |
| Sqlwriter_keyfile.dll | 2015.130.2197.0 | 100544    | 25-Feb-2017 | 20:12 | x64      |

SQL Server 2016 Analysis Services

| File   name                                   | File version    | File size | Date      | Time  | Platform |
|-----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.server.core.dll    | 13.0.2197.0     | 1343680   | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.analysisservices.server.tabular.dll | 13.0.2197.0     | 765632    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 04-Jun-2016  | 16:07 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 04-Jun-2016  | 16:07 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 04-Jun-2016  | 16:07 | x64      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 04-Jun-2016  | 16:07 | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 04-Jun-2016  | 16:07 | x86      |
| Msmdlocal.dll                                 | 2015.130.2197.0 | 56079048  | 25-Feb-2017 | 20:12 | x64      |
| Msmdlocal.dll                                 | 2015.130.2197.0 | 37014728  | 25-Feb-2017 | 20:14 | x86      |
| Msmdsrv.exe                                   | 2015.130.2197.0 | 56623816  | 25-Feb-2017 | 20:12 | x64      |
| Msmgdsrv.dll                                  | 2015.130.2197.0 | 6501576   | 25-Feb-2017 | 20:13 | x86      |
| Msmgdsrv.dll                                  | 2015.130.2197.0 | 7500488   | 25-Feb-2017 | 20:15 | x64      |
| Msolap130.dll                                 | 2015.130.2197.0 | 8590024   | 25-Feb-2017 | 20:12 | x64      |
| Msolap130.dll                                 | 2015.130.2197.0 | 6968008   | 25-Feb-2017 | 20:14 | x86      |
| Sql_as_keyfile.dll                            | 2015.130.2197.0 | 100544    | 25-Feb-2017 | 20:12 | x64      |
| Sqlboot.dll                                   | 2015.130.2197.0 | 186568    | 25-Feb-2017 | 20:12 | x64      |
| Sqlceip.exe                                   | 13.0.2197.0     | 249024    | 25-Feb-2017 | 20:12 | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 04-Jun-2016  | 16:07 | x86      |
| Tmapi.dll                                     | 2015.130.2197.0 | 4344520   | 25-Feb-2017 | 20:13 | x64      |
| Tmcachemgr.dll                                | 2015.130.2197.0 | 2825416   | 25-Feb-2017 | 20:13 | x64      |
| Tmpersistence.dll                             | 2015.130.2197.0 | 1069768   | 25-Feb-2017 | 20:13 | x64      |
| Tmtransactions.dll                            | 2015.130.2197.0 | 1349832   | 25-Feb-2017 | 20:13 | x64      |
| Xmsrv.dll                                     | 2015.130.2197.0 | 32693952  | 25-Feb-2017 | 20:13 | x86      |
| Xmsrv.dll                                     | 2015.130.2197.0 | 24013512  | 25-Feb-2017 | 20:13 | x64      |

SQL Server 2016 Database Services Common Core

| File   name                                | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.adomdclient.dll | 13.0.2197.0     | 1023176   | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 13.0.2197.0     | 1023168   | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.analysisservices.core.dll        | 13.0.2197.0     | 1344200   | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.analysisservices.dll             | 13.0.2197.0     | 702664    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.analysisservices.tabular.dll     | 13.0.2197.0     | 765640    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2197.0     | 707264    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2197.0     | 707264    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.edition.dll            | 13.0.2197.0     | 37064     | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.instapi.dll            | 13.0.2197.0     | 46280     | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2197.0 | 75456     | 25-Feb-2017 | 20:14 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2015.130.2197.0 | 72904     | 25-Feb-2017 | 20:14 | x86      |
| Pbsvcacctsync.dll                          | 2015.130.2197.0 | 72896     | 25-Feb-2017 | 20:12 | x64      |
| Pbsvcacctsync.dll                          | 2015.130.2197.0 | 60104     | 25-Feb-2017 | 20:14 | x86      |
| Sql_common_core_keyfile.dll                | 2015.130.2197.0 | 100544    | 25-Feb-2017 | 20:12 | x64      |
| Sqlmgmprovider.dll                         | 2015.130.2197.0 | 404168    | 25-Feb-2017 | 20:13 | x64      |
| Sqlmgmprovider.dll                         | 2015.130.2197.0 | 364224    | 25-Feb-2017 | 20:14 | x86      |
| Sqlsvcsync.dll                             | 2015.130.2197.0 | 349384    | 25-Feb-2017 | 20:13 | x64      |
| Sqlsvcsync.dll                             | 2015.130.2197.0 | 267456    | 25-Feb-2017 | 20:14 | x86      |
| Sqltdiagn.dll                              | 2015.130.2197.0 | 67776     | 25-Feb-2017 | 20:13 | x64      |
| Sqltdiagn.dll                              | 2015.130.2197.0 | 60616     | 25-Feb-2017 | 20:14 | x86      |
| Svrenumapi130.dll                          | 2015.130.2197.0 | 1115840   | 25-Feb-2017 | 20:13 | x64      |
| Svrenumapi130.dll                          | 2015.130.2197.0 | 854216    | 25-Feb-2017 | 20:14 | x86      |

SQL Server 2016 Data Quality

| File   name                   | File version | File size | Date      | Time  | Platform |
|-------------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.ssdqs.cleansing.dll | 13.0.2197.0  | 473288    | 25-Feb-2017 | 20:13 | x86      |
| Microsoft.ssdqs.cleansing.dll | 13.0.2197.0  | 473288    | 25-Feb-2017 | 20:15 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2197.0  | 1876680   | 25-Feb-2017 | 20:13 | x86      |
| Microsoft.ssdqs.infra.dll     | 13.0.2197.0  | 1876680   | 25-Feb-2017 | 20:15 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                          | File version    | File size | Date      | Time  | Platform |
|--------------------------------------|-----------------|-----------|-----------|-------|----------|
| Databasemail.exe                     | 13.0.16100.4    | 29888     | 09-Dec-2016  | 0:46  | x64      |
| Hadrres.dll                          | 2015.130.2197.0 | 177864    | 25-Feb-2017 | 20:13 | x64      |
| Hkcompile.dll                        | 2015.130.2197.0 | 1297088   | 25-Feb-2017 | 20:13 | x64      |
| Hkengine.dll                         | 2015.130.2197.0 | 5600456   | 25-Feb-2017 | 20:14 | x64      |
| Hkruntime.dll                        | 2015.130.2197.0 | 158912    | 25-Feb-2017 | 20:14 | x64      |
| Microsoft.sqlserver.types.dll        | 2015.130.2197.0 | 391880    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.vdiinterface.dll | 2015.130.2197.0 | 71368     | 25-Feb-2017 | 20:15 | x64      |
| Qds.dll                              | 2015.130.2197.0 | 845000    | 25-Feb-2017 | 20:12 | x64      |
| Rsfxft.dll                           | 2015.130.2197.0 | 34504     | 25-Feb-2017 | 20:13 | x64      |
| Sql_engine_core_inst_keyfile.dll     | 2015.130.2197.0 | 100544    | 25-Feb-2017 | 20:12 | x64      |
| Sqlaccess.dll                        | 2015.130.2197.0 | 462536    | 25-Feb-2017 | 20:14 | x64      |
| Sqlagent.exe                         | 2015.130.2197.0 | 565960    | 25-Feb-2017 | 20:12 | x64      |
| Sqlboot.dll                          | 2015.130.2197.0 | 186568    | 25-Feb-2017 | 20:12 | x64      |
| Sqlceip.exe                          | 13.0.2197.0     | 249024    | 25-Feb-2017 | 20:12 | x86      |
| Sqldk.dll                            | 2015.130.2197.0 | 2583752   | 25-Feb-2017 | 20:12 | x64      |
| Sqllang.dll                          | 2015.130.2197.0 | 39327944  | 25-Feb-2017 | 20:13 | x64      |
| Sqlmin.dll                           | 2015.130.2197.0 | 37349576  | 25-Feb-2017 | 20:13 | x64      |
| Sqlos.dll                            | 2015.130.2197.0 | 26304     | 25-Feb-2017 | 20:13 | x64      |
| Sqlscriptdowngrade.dll               | 2015.130.2197.0 | 27848     | 25-Feb-2017 | 20:13 | x64      |
| Sqlscriptupgrade.dll                 | 2015.130.2197.0 | 5797064   | 25-Feb-2017 | 20:13 | x64      |
| Sqlserverspatial130.dll              | 2015.130.2197.0 | 732864    | 25-Feb-2017 | 20:13 | x64      |
| Sqlservr.exe                         | 2015.130.2197.0 | 392896    | 25-Feb-2017 | 20:12 | x64      |
| Sqltses.dll                          | 2015.130.2197.0 | 8896712   | 25-Feb-2017 | 20:13 | x64      |
| Stretchcodegen.exe                   | 13.0.2197.0     | 55496     | 25-Feb-2017 | 20:14 | x86      |
| Xpstar.dll                           | 2015.130.2197.0 | 422088    | 25-Feb-2017 | 20:13 | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                                  | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dts.dll                                                      | 2015.130.2197.0 | 3145416   | 25-Feb-2017 | 20:12 | x64      |
| Dtspipeline.dll                                              | 2015.130.2197.0 | 1278152   | 25-Feb-2017 | 20:12 | x64      |
| Dtswizard.exe                                                | 13.0.2197.0     | 895176    | 25-Feb-2017 | 20:12 | x64      |
| Logread.exe                                                  | 2015.130.2197.0 | 616640    | 25-Feb-2017 | 20:12 | x64      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2197.0     | 33992     | 25-Feb-2017 | 20:15 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2197.0     | 606408    | 25-Feb-2017 | 20:15 | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                 | 13.0.2197.0     | 215232    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll             | 13.0.14510.3    | 30912     | 12-Oct-2016 | 10:35 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2197.0     | 445128    | 25-Feb-2017 | 20:15 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2015.130.2197.0 | 1638088   | 25-Feb-2017 | 20:15 | x64      |
| Repldp.dll                                                   | 2015.130.2197.0 | 276168    | 25-Feb-2017 | 20:12 | x64      |
| Sql_engine_core_shared_keyfile.dll                           | 2015.130.2197.0 | 100544    | 25-Feb-2017 | 20:12 | x64      |
| Sqlmergx.dll                                                 | 2015.130.2197.0 | 346824    | 25-Feb-2017 | 20:13 | x64      |
| Txdatacollector.dll                                          | 2015.130.2197.0 | 367304    | 25-Feb-2017 | 20:13 | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date      | Time  | Platform |
|-------------------------------|-----------------|-----------|-----------|-------|----------|
| Launchpad.exe                 | 2015.130.2197.0 | 1011912   | 25-Feb-2017 | 20:12 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.2197.0 | 100544    | 25-Feb-2017 | 20:12 | x64      |
| Sqlsatellite.dll              | 2015.130.2197.0 | 836808    | 25-Feb-2017 | 20:13 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version    | File size | Date      | Time  | Platform |
|--------------------------|-----------------|-----------|-----------|-------|----------|
| Fd.dll                   | 2015.130.2197.0 | 660160    | 25-Feb-2017 | 20:13 | x64      |
| Mswb7.dll                | 14.0.4763.1000  | 331672    | 03-Sep-2014  | 14:52 | x64      |
| Prm0007.bin              | 14.0.4763.1000  | 11602944  | 03-Sep-2014  | 14:53 | x64      |
| Prm0009.bin              | 14.0.4763.1000  | 5739008   | 03-Sep-2014  | 14:53 | x64      |
| Prm0013.bin              | 14.0.4763.1000  | 9482240   | 03-Sep-2014  | 14:53 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.2197.0 | 100544    | 25-Feb-2017 | 20:12 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version    | File size | Date      | Time  | Platform |
|-------------------------|-----------------|-----------|-----------|-------|----------|
| Imrdll.dll              | 13.0.2197.0     | 23752     | 25-Feb-2017 | 20:14 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.2197.0 | 100544    | 25-Feb-2017 | 20:12 | x64      |

SQL Server 2016 Integration Services

| File   name                                                   | File version    | File size | Date      | Time  | Platform |
|---------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dts.dll                                                       | 2015.130.2197.0 | 3145416   | 25-Feb-2017 | 20:12 | x64      |
| Dts.dll                                                       | 2015.130.2197.0 | 2631880   | 25-Feb-2017 | 20:13 | x86      |
| Dtspipeline.dll                                               | 2015.130.2197.0 | 1278152   | 25-Feb-2017 | 20:12 | x64      |
| Dtspipeline.dll                                               | 2015.130.2197.0 | 1059520   | 25-Feb-2017 | 20:13 | x86      |
| Dtswizard.exe                                                 | 13.0.2197.0     | 895176    | 25-Feb-2017 | 20:12 | x64      |
| Dtswizard.exe                                                 | 13.0.2197.0     | 895688    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2197.0     | 469696    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2197.0     | 469704    | 25-Feb-2017 | 20:15 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2197.0     | 33992     | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2197.0     | 33992     | 25-Feb-2017 | 20:15 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2197.0     | 606408    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2197.0     | 606408    | 25-Feb-2017 | 20:15 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2197.0     | 445120    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2197.0     | 445128    | 25-Feb-2017 | 20:15 | x86      |
| Msdtssrvr.exe                                                 | 13.0.2197.0     | 216776    | 25-Feb-2017 | 20:12 | x64      |
| Sql_is_keyfile.dll                                            | 2015.130.2197.0 | 100544    | 25-Feb-2017 | 20:12 | x64      |
| Sqlceip.exe                                                   | 13.0.2197.0     | 249024    | 25-Feb-2017 | 20:12 | x86      |

SQL Server 2016 Reporting Services

| File   name                                               | File version    | File size | Date      | Time  | Platform |
|-----------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.reportingservices.authorization.dll             | 13.0.2197.0     | 79048     | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.dataextensions.xmlaclient.dll | 13.0.2197.0     | 567496    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.2197.0     | 166088    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.2197.0     | 1620672   | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.2197.0     | 657608    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.2197.0     | 329416    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.2197.0     | 1069760   | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.2197.0     | 161992    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2197.0     | 76488     | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2197.0     | 76488     | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.2197.0     | 122568    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.2197.0     | 104136    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.2197.0     | 4904136   | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.2197.0     | 9644744   | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.2197.0     | 92864     | 25-Feb-2017 | 20:12 | x64      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.2197.0     | 5951176   | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.2197.0     | 245960    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.2197.0     | 207560    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.2197.0     | 500936    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.2197.0 | 396992    | 25-Feb-2017 | 20:13 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.2197.0 | 391880    | 25-Feb-2017 | 20:14 | x86      |
| Msmdlocal.dll                                             | 2015.130.2197.0 | 56079048  | 25-Feb-2017 | 20:12 | x64      |
| Msmdlocal.dll                                             | 2015.130.2197.0 | 37014728  | 25-Feb-2017 | 20:14 | x86      |
| Msmgdsrv.dll                                              | 2015.130.2197.0 | 6501576   | 25-Feb-2017 | 20:13 | x86      |
| Msmgdsrv.dll                                              | 2015.130.2197.0 | 7500488   | 25-Feb-2017 | 20:15 | x64      |
| Msolap130.dll                                             | 2015.130.2197.0 | 8590024   | 25-Feb-2017 | 20:12 | x64      |
| Msolap130.dll                                             | 2015.130.2197.0 | 6968008   | 25-Feb-2017 | 20:14 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.2197.0     | 2518208   | 25-Feb-2017 | 20:15 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.2197.0 | 114376    | 25-Feb-2017 | 20:13 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.2197.0 | 108744    | 25-Feb-2017 | 20:15 | x64      |
| Reportingservicesnativeserver.dll                         | 2015.130.2197.0 | 99008     | 25-Feb-2017 | 20:15 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.2197.0     | 2698440   | 25-Feb-2017 | 20:15 | x86      |
| Sql_rs_keyfile.dll                                        | 2015.130.2197.0 | 100544    | 25-Feb-2017 | 20:12 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.2197.0 | 732864    | 25-Feb-2017 | 20:13 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.2197.0 | 584392    | 25-Feb-2017 | 20:14 | x86      |
| Xmsrv.dll                                                 | 2015.130.2197.0 | 32693952  | 25-Feb-2017 | 20:13 | x86      |
| Xmsrv.dll                                                 | 2015.130.2197.0 | 24013512  | 25-Feb-2017 | 20:13 | x64      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time  | Platform |
|------------------------------------|-----------------|-----------|-----------|-------|----------|
| Smrdll.dll                         | 13.0.2197.0     | 23752     | 25-Feb-2017 | 20:15 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.2197.0 | 100544    | 25-Feb-2017 | 20:12 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                                  | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dts.dll                                                      | 2015.130.2197.0 | 3145416   | 25-Feb-2017 | 20:12 | x64      |
| Dts.dll                                                      | 2015.130.2197.0 | 2631880   | 25-Feb-2017 | 20:13 | x86      |
| Dtspipeline.dll                                              | 2015.130.2197.0 | 1278152   | 25-Feb-2017 | 20:12 | x64      |
| Dtspipeline.dll                                              | 2015.130.2197.0 | 1059520   | 25-Feb-2017 | 20:13 | x86      |
| Dtswizard.exe                                                | 13.0.2197.0     | 895176    | 25-Feb-2017 | 20:12 | x64      |
| Dtswizard.exe                                                | 13.0.2197.0     | 895688    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2197.0     | 432832    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2197.0     | 432832    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2197.0     | 2044104   | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2197.0     | 2044104   | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2197.0     | 33480     | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll                | 13.0.2197.0     | 33472     | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2197.0     | 250056    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2197.0     | 250056    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2197.0     | 33992     | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2197.0     | 33992     | 25-Feb-2017 | 20:15 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2197.0     | 606408    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2197.0     | 606408    | 25-Feb-2017 | 20:15 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2197.0     | 445120    | 25-Feb-2017 | 20:14 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2197.0     | 445128    | 25-Feb-2017 | 20:15 | x86      |
| Msmdlocal.dll                                                | 2015.130.2197.0 | 56079048  | 25-Feb-2017 | 20:12 | x64      |
| Msmdlocal.dll                                                | 2015.130.2197.0 | 37014728  | 25-Feb-2017 | 20:14 | x86      |
| Msmgdsrv.dll                                                 | 2015.130.2197.0 | 6501576   | 25-Feb-2017 | 20:13 | x86      |
| Msmgdsrv.dll                                                 | 2015.130.2197.0 | 7500488   | 25-Feb-2017 | 20:15 | x64      |
| Msolap130.dll                                                | 2015.130.2197.0 | 8590024   | 25-Feb-2017 | 20:12 | x64      |
| Msolap130.dll                                                | 2015.130.2197.0 | 6968008   | 25-Feb-2017 | 20:14 | x86      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2197.0 | 100544    | 25-Feb-2017 | 20:12 | x64      |
| Xmsrv.dll                                                    | 2015.130.2197.0 | 32693952  | 25-Feb-2017 | 20:13 | x86      |
| Xmsrv.dll                                                    | 2015.130.2197.0 | 24013512  | 25-Feb-2017 | 20:13 | x64      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
