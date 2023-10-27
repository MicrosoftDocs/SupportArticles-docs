---
title: Cumulative update 17 for SQL Server 2016 SP2 (KB5001092)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP2 cumulative update 17 (KB5001092).
ms.date: 10/26/2023
ms.custom: KB5001092
appliesto:
- SQL Server 2016
---

# KB5001092 - Cumulative Update 17 for SQL Server 2016 SP2

_Release Date:_ &nbsp; March 29, 2021  
_Version:_ &nbsp; 13.0.5888.11

This article describes Cumulative Update package 17 (CU17) (build number: **13.0.5888.11**) for Microsoft SQL Server 2016 Service Pack 2 (SP2). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the initial release of SQL Server 2016 SP2.

## Improvements and fixes included in this update

| Bug reference | Description| Fix area | Platform |
|---------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|----------|
| <a id=13944405>[13944405](#13944405) </a> | [Improvement: Performance improvements of several spatial built-in properties and methods in SQL Server 2016 (KB5001260)](https://support.microsoft.com/help/5001260)| SQL Engine | All|
| <a id=13685819>[13685819](#13685819) </a> | Fixes an issue with insert query in SQL Server 2016 that reads the data from the same table and uses a parallel execution plan may produce duplicate rows. | SQL Engine | All|
| <a id=13984384>[13984384](#13984384) </a> | Fixes an Access Violation issue in 'AGDBErrorPublisherActual::PublishErrorReported' that occurs due to timing issue during frequent AG failovers.| High Availability| All|
| <a id=13924723>[13924723](#13924723) </a> | [FIX: "Login failed for user" error occurs when you run Maintenance plan with SQL login account in SQL Server 2016 and 2017 (KB4486936)](https://support.microsoft.com/help/4486936) | SQL Engine | Windows|
| <a id=13944404>[13944404](#13944404) </a> | [FIX: Access Violation occurs during a concurrent columnstore index scan (KB5001114)](https://support.microsoft.com/help/5001114)| SQL Engine | Windows|
| <a id=13459573>[13459573](#13459573) </a> | Fixes an issue where performance counter Data File(s) Size (KB) doesn't report the correct total size of database files if one file is created with initial size>4 TB or grown by more than 4 TB. | SQL Engine | Windows|
| <a id=13804158>[13804158](#13804158) </a> | Fixes an issue in a query against `sys.all_columns` when `XACT_ABORT` is set to on. </br></br>**Note**: `XACT_ABORT` causes the transaction to rollback and return a null view. The fix patches this and returns a complete view even when `XACT_ABORT` is set to on.| SQL Engine | Windows|
| <a id=13909099>[13909099](#13909099) </a> | `DBCC SHRINKFLE` or `SHRINKDATABASE` can cause an assertion exception error when executed against database or files containing system-versioned temporal tables. | SQL Engine | Windows|
| <a id=13916073>[13916073](#13916073) </a> | Fixes an error that HTTP connection manager cannot connect to web services via TLS 1.1 & 1.2.| Integration services | Windows|
| <a id=13930066>[13930066](#13930066) </a> | Fixes the failed assertion that occurs due to implicit conversion where predicate's precision is greater than the value. </br></br>Msg 3624, Level 20, State 1, Line \<LineNumber> </br>A system assertion check has failed. Check the SQL Server error log for details. Typically, an assertion failure is caused by a software bug or data corruption. To check for database corruption, consider running DBCC CHECKDB. If you agreed to send dumps to Microsoft during setup, a mini dump will be sent to Microsoft. An update might be available from Microsoft in the latest Service Pack or in a Hotfix from Technical Support. </br></br>Msg 596, Level 21, State 1, Line \<LineNumber> </br>Cannot continue the execution because the session is in the kill state. </br></br>Msg 0, Level 20, State 0, Line \<LineNumber> </br>A severe error occurred on the current command. The results, if any, should be discarded. | SQL Engine | Windows|
| <a id=13935812>[13935812](#13935812) </a> | Fixes an issue where the upgrade process resets the SQL Server Agent subsystems `Max_Woker_Threads` value to default in system table `msdb.dbo.subsystems` after applying a Service Pack or Cumulative Update on SQL Server 2016.| SQL Engine | Windows|
| <a id=13949607>[13949607](#13949607) </a> | Fixes an issue where synchronizeSecurity setting of AMO method 'Microsoft.AnalysisServices.Tabular.Server.Synchronize' shown in [Server.Synchronize Method](/dotnet/api/microsoft.analysisservices.core.server.synchronize#Microsoft_AnalysisServices_Core_Server_Synchronize_System_String_System_String_Microsoft_AnalysisServices_SynchronizeSecurity_System_Boolean) is ignored. | Analysis services| Windows|
| <a id=13955379>[13955379](#13955379) </a> | Fixes an error that occurs when the Pull Subscription Merge Agent fails with an error when there is a conflict. </br></br>"The process could not initialize Microsoft SQL Server Subscriber Always Wins Conflict Resolver.Verify that the component is registered correctly."| SQL Engine | Windows|
| <a id=13966885>[13966885](#13966885) </a> | Fix to keep `PERSIST_SAMPLE_PERCENT` value for statistics on an indexed column after index rebuild.| SQL performance| Windows|
| <a id=13969680>[13969680](#13969680) </a> | Fixes an error that occurs after a failover of a Distributed Availability Group that attempts to connect to the secondary AG listener with application intent set to READ ONLY.| High Availability| Windows|
| <a id=13970219>[13970219](#13970219) </a> | Fixes an issue where `DBCC PAGE` with option 3 generates access violation dumps after dropping a unique identifier column from the table in SQL Server 2016. </br></br>Msg 596, Level 21, State 1, Line \<LineNumber> </br>Cannot continue the execution because the session is in the kill state. </br></br>Msg 0, Level 20, State 0, Line \<LineNumber> </br>A severe error occurred on the current command. The results, if any, should be discarded. | SQL Engine | Windows|
| <a id=13988911>[13988911](#13988911) </a> | Fixes a potential issue that causes error 5511 when performing a log backup on a database that has filestream data.| SQL Engine | Windows|

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
<summary><b>File hash information</b></summary>

| File   name                     | SHA1 hash                                | SHA256 hash                                                      |
|---------------------------------|------------------------------------------|------------------------------------------------------------------|
| SQLServer2016-KB5001092-x64.exe | F9A30A72026251DDB3BA4BC840135066B528A494 | D4B43D9762BF01EE0F540D68226FC5E737162AD1F8F0A7F2E240A0F4F6CF3C7E |

</details>

<details>
<summary><b>Cumulative update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2016 Browser Service

| File   name    | File version     | File size | Date      | Time | Platform |
|----------------|------------------|-----------|-----------|------|----------|
| Instapi130.dll | 2015.131.5888.11 | 46472     | 20-Mar-2021 | 05:08 | x86      |
| Keyfile.dll    | 2015.131.5888.11 | 81800     | 20-Mar-2021 | 05:08 | x86      |
| Sqlbrowser.exe | 2015.131.5888.11 | 269720    | 20-Mar-2021 | 05:07 | x86      |
| Sqldumper.exe  | 2015.131.5888.11 | 103832    | 20-Mar-2021 | 05:07 | x86      |

SQL Server 2016 Writer

| File   name           | File version     | File size | Date      | Time | Platform |
|-----------------------|------------------|-----------|-----------|------|----------|
| Instapi130.dll        | 2015.131.5888.11 | 54152     | 20-Mar-2021 | 04:47 | x64      |
| Sqlboot.dll           | 2015.131.5888.11 | 179608    | 20-Mar-2021 | 05:08 | x64      |
| Sqldumper.exe         | 2015.131.5888.11 | 123288    | 20-Mar-2021 | 05:09 | x64      |
| Sqlvdi.dll            | 2015.131.5888.11 | 161688    | 20-Mar-2021 | 05:07 | x86      |
| Sqlvdi.dll            | 2015.131.5888.11 | 190360    | 20-Mar-2021 | 04:46 | x64      |
| Sqlwriter.exe         | 2015.131.5888.11 | 124816    | 20-Mar-2021 | 05:08 | x64      |
| Sqlwriter_keyfile.dll | 2015.131.5888.11 | 93592     | 20-Mar-2021 | 05:09 | x64      |
| Sqlwvss.dll           | 2015.131.5888.11 | 341912    | 20-Mar-2021 | 04:48 | x64      |
| Sqlwvss_xp.dll        | 2015.131.5888.11 | 19352     | 20-Mar-2021 | 04:48 | x64      |

SQL Server 2016 Analysis Services

| File   name                                | File version     | File size | Date      | Time  | Platform |
|--------------------------------------------|------------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.server.core.dll | 13.0.5888.11     | 1341856   | 20-Mar-2021 | 05:09  | x86      |
| Microsoft.applicationinsights.dll          | 2.7.0.13435      | 329872    | 6-Jul-18  | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5888.11     | 983432    | 20-Mar-2021 | 05:08  | x86      |
| Microsoft.powerbi.adomdclient.dll          | 13.0.5888.11     | 983448    | 20-Mar-2021 | 05:11  | x86      |
| Msmdctr130.dll                             | 2015.131.5888.11 | 33160     | 20-Mar-2021 | 05:08  | x64      |
| Msmdlocal.dll                              | 2015.131.5888.11 | 37127064  | 20-Mar-2021 | 05:08  | x86      |
| Msmdlocal.dll                              | 2015.131.5888.11 | 56245144  | 20-Mar-2021 | 05:08  | x64      |
| Msmdsrv.exe                                | 2015.131.5888.11 | 56791432  | 20-Mar-2021 | 05:08  | x64      |
| Msmgdsrv.dll                               | 2015.131.5888.11 | 6502296   | 20-Mar-2021 | 05:08  | x86      |
| Msmgdsrv.dll                               | 2015.131.5888.11 | 7502744   | 20-Mar-2021 | 04:50  | x64      |
| Msolap130.dll                              | 2015.131.5888.11 | 7003528   | 20-Mar-2021 | 05:08  | x86      |
| Msolap130.dll                              | 2015.131.5888.11 | 8636312   | 20-Mar-2021 | 05:08  | x64      |
| Msolui130.dll                              | 2015.131.5888.11 | 280456    | 20-Mar-2021 | 05:08  | x86      |
| Msolui130.dll                              | 2015.131.5888.11 | 303520    | 20-Mar-2021 | 05:08  | x64      |
| Sql_as_keyfile.dll                         | 2015.131.5888.11 | 93592     | 20-Mar-2021 | 05:09  | x64      |
| Sqlboot.dll                                | 2015.131.5888.11 | 179608    | 20-Mar-2021 | 05:08  | x64      |
| Sqlceip.exe                                | 13.0.5888.11     | 249240    | 20-Mar-2021 | 05:07  | x86      |
| Sqldumper.exe                              | 2015.131.5888.11 | 103832    | 20-Mar-2021 | 05:07  | x86      |
| Sqldumper.exe                              | 2015.131.5888.11 | 123288    | 20-Mar-2021 | 05:09  | x64      |
| Tmapi.dll                                  | 2015.131.5888.11 | 4339080   | 20-Mar-2021 | 04:48  | x64      |
| Tmcachemgr.dll                             | 2015.131.5888.11 | 2819472   | 20-Mar-2021 | 04:48  | x64      |
| Tmpersistence.dll                          | 2015.131.5888.11 | 1064328   | 20-Mar-2021 | 04:48  | x64      |
| Tmtransactions.dll                         | 2015.131.5888.11 | 1345440   | 20-Mar-2021 | 04:48  | x64      |
| Xe.dll                                     | 2015.131.5888.11 | 619416    | 20-Mar-2021 | 04:48  | x64      |
| Xmlrw.dll                                  | 2015.131.5888.11 | 252832    | 20-Mar-2021 | 05:08  | x86      |
| Xmlrw.dll                                  | 2015.131.5888.11 | 312200    | 20-Mar-2021 | 04:46  | x64      |
| Xmlrwbin.dll                               | 2015.131.5888.11 | 184728    | 20-Mar-2021 | 05:08  | x86      |
| Xmlrwbin.dll                               | 2015.131.5888.11 | 220552    | 20-Mar-2021 | 04:46  | x64      |
| Xmsrv.dll                                  | 2015.131.5888.11 | 32720792  | 20-Mar-2021 | 05:08  | x86      |
| Xmsrv.dll                                  | 2015.131.5888.11 | 24041880  | 20-Mar-2021 | 04:48  | x64      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time | Platform |
|---------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                             | 2015.131.5888.11 | 153488    | 20-Mar-2021 | 05:07 | x86      |
| Batchparser.dll                             | 2015.131.5888.11 | 173976    | 20-Mar-2021 | 04:47 | x64      |
| Instapi130.dll                              | 2015.131.5888.11 | 46472     | 20-Mar-2021 | 05:08 | x86      |
| Instapi130.dll                              | 2015.131.5888.11 | 54152     | 20-Mar-2021 | 04:47 | x64      |
| Isacctchange.dll                            | 2015.131.5888.11 | 22408     | 20-Mar-2021 | 05:08 | x86      |
| Isacctchange.dll                            | 2015.131.5888.11 | 23960     | 20-Mar-2021 | 05:09 | x64      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5888.11     | 1020808   | 20-Mar-2021 | 05:09 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.5888.11     | 1020808   | 20-Mar-2021 | 05:11 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.5888.11     | 1342360   | 20-Mar-2021 | 05:11 | x86      |
| Microsoft.analysisservices.dll              | 13.0.5888.11     | 695688    | 20-Mar-2021 | 05:11 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.5888.11     | 758664    | 20-Mar-2021 | 05:10 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.5888.11     | 513928    | 20-Mar-2021 | 05:10 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5888.11     | 705440    | 20-Mar-2021 | 05:08 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.5888.11     | 705432    | 20-Mar-2021 | 05:10 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5888.11 | 65952     | 20-Mar-2021 | 05:10 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.131.5888.11 | 68504     | 20-Mar-2021 | 04:47 | x64      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5888.11     | 562592    | 20-Mar-2021 | 05:10 | x86      |
| Microsoft.sqlserver.rmo.dll                 | 13.0.5888.11     | 562584    | 20-Mar-2021 | 04:50 | x86      |
| Msasxpress.dll                              | 2015.131.5888.11 | 24968     | 20-Mar-2021 | 05:08 | x86      |
| Msasxpress.dll                              | 2015.131.5888.11 | 29088     | 20-Mar-2021 | 05:08 | x64      |
| Pbsvcacctsync.dll                           | 2015.131.5888.11 | 53128     | 20-Mar-2021 | 05:08 | x86      |
| Pbsvcacctsync.dll                           | 2015.131.5888.11 | 65944     | 20-Mar-2021 | 05:08 | x64      |
| Sql_common_core_keyfile.dll                 | 2015.131.5888.11 | 93592     | 20-Mar-2021 | 05:09 | x64      |
| Sqldumper.exe                               | 2015.131.5888.11 | 103832    | 20-Mar-2021 | 05:07 | x86      |
| Sqldumper.exe                               | 2015.131.5888.11 | 123288    | 20-Mar-2021 | 05:09 | x64      |
| Sqlftacct.dll                               | 2015.131.5888.11 | 39824     | 20-Mar-2021 | 05:07 | x86      |
| Sqlftacct.dll                               | 2015.131.5888.11 | 44952     | 20-Mar-2021 | 05:08 | x64      |
| Sqlmgmprovider.dll                          | 2015.131.5888.11 | 358808    | 20-Mar-2021 | 05:07 | x86      |
| Sqlmgmprovider.dll                          | 2015.131.5888.11 | 399264    | 20-Mar-2021 | 04:49 | x64      |
| Sqlsecacctchg.dll                           | 2015.131.5888.11 | 28056     | 20-Mar-2021 | 05:07 | x86      |
| Sqlsecacctchg.dll                           | 2015.131.5888.11 | 30616     | 20-Mar-2021 | 04:48 | x64      |
| Sqltdiagn.dll                               | 2015.131.5888.11 | 53656     | 20-Mar-2021 | 05:07 | x86      |
| Sqltdiagn.dll                               | 2015.131.5888.11 | 60824     | 20-Mar-2021 | 04:48 | x64      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version     | File size | Date      | Time | Platform |
|--------------------------------|------------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2015.131.5888.11 | 114056    | 20-Mar-2021 | 05:08 | x86      |
| Dreplaycommon.dll              | 2015.131.5888.11 | 683912    | 20-Mar-2021 | 05:11 | x86      |
| Dreplayutil.dll                | 2015.131.5888.11 | 303000    | 20-Mar-2021 | 05:07 | x86      |
| Instapi130.dll                 | 2015.131.5888.11 | 54152     | 20-Mar-2021 | 04:47 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.131.5888.11 | 93592     | 20-Mar-2021 | 05:09 | x64      |
| Sqlresourceloader.dll          | 2015.131.5888.11 | 21400     | 20-Mar-2021 | 05:07 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version     | File size | Date      | Time | Platform |
|------------------------------------|------------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2015.131.5888.11 | 683912    | 20-Mar-2021 | 05:11 | x86      |
| Dreplaycontroller.exe              | 2015.131.5888.11 | 343448    | 20-Mar-2021 | 05:08 | x86      |
| Dreplayprocess.dll                 | 2015.131.5888.11 | 164752    | 20-Mar-2021 | 05:07 | x86      |
| Instapi130.dll                     | 2015.131.5888.11 | 54152     | 20-Mar-2021 | 04:47 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.131.5888.11 | 93592     | 20-Mar-2021 | 05:09 | x64      |
| Sqlresourceloader.dll              | 2015.131.5888.11 | 21400     | 20-Mar-2021 | 05:07 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------|------------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 13.0.5888.11     | 34184     | 20-Mar-2021 | 05:08  | x64      |
| Batchparser.dll                              | 2015.131.5888.11 | 173976    | 20-Mar-2021 | 04:47  | x64      |
| Datacollectorcontroller.dll                  | 2015.131.5888.11 | 218528    | 20-Mar-2021 | 05:09  | x64      |
| Dcexec.exe                                   | 2015.131.5888.11 | 67464     | 20-Mar-2021 | 05:08  | x64      |
| Fssres.dll                                   | 2015.131.5888.11 | 74632     | 20-Mar-2021 | 05:09  | x64      |
| Hadrres.dll                                  | 2015.131.5888.11 | 170904    | 20-Mar-2021 | 04:47  | x64      |
| Hkcompile.dll                                | 2015.131.5888.11 | 1291144   | 20-Mar-2021 | 04:47  | x64      |
| Hkengine.dll                                 | 2015.131.5888.11 | 5596056   | 20-Mar-2021 | 04:49  | x64      |
| Hkruntime.dll                                | 2015.131.5888.11 | 151960    | 20-Mar-2021 | 04:49  | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435      | 329872    | 6-Jul-18  | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.5888.11     | 229768    | 20-Mar-2021 | 04:50  | x86      |
| Microsoft.sqlserver.types.dll                | 2015.131.5888.11 | 385944    | 20-Mar-2021 | 04:47  | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.131.5888.11 | 65432     | 20-Mar-2021 | 04:50  | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.131.5888.11 | 58264     | 20-Mar-2021 | 04:48  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5888.11 | 143256    | 20-Mar-2021 | 04:48  | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5888.11 | 151944    | 20-Mar-2021 | 04:48  | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.131.5888.11 | 265096    | 20-Mar-2021 | 04:48  | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.131.5888.11 | 67976     | 20-Mar-2021 | 04:48  | x64      |
| Odsole70.dll                                 | 2015.131.5888.11 | 85912     | 20-Mar-2021 | 05:08  | x64      |
| Opends60.dll                                 | 2015.131.5888.11 | 25992     | 20-Mar-2021 | 04:47  | x64      |
| Qds.dll                                      | 2015.131.5888.11 | 889752    | 20-Mar-2021 | 05:08  | x64      |
| Rsfxft.dll                                   | 2015.131.5888.11 | 27552     | 20-Mar-2021 | 04:47  | x64      |
| Sqagtres.dll                                 | 2015.131.5888.11 | 57752     | 20-Mar-2021 | 05:08  | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.131.5888.11 | 93592     | 20-Mar-2021 | 05:09  | x64      |
| Sqlaamss.dll                                 | 2015.131.5888.11 | 73624     | 20-Mar-2021 | 04:49  | x64      |
| Sqlaccess.dll                                | 2015.131.5888.11 | 456072    | 20-Mar-2021 | 04:47  | x64      |
| Sqlagent.exe                                 | 2015.131.5888.11 | 559512    | 20-Mar-2021 | 05:08  | x64      |
| Sqlagentctr130.dll                           | 2015.131.5888.11 | 37256     | 20-Mar-2021 | 05:07  | x86      |
| Sqlagentctr130.dll                           | 2015.131.5888.11 | 44952     | 20-Mar-2021 | 04:47  | x64      |
| Sqlagentlog.dll                              | 2015.131.5888.11 | 26008     | 20-Mar-2021 | 05:08  | x64      |
| Sqlagentmail.dll                             | 2015.131.5888.11 | 40856     | 20-Mar-2021 | 04:49  | x64      |
| Sqlboot.dll                                  | 2015.131.5888.11 | 179608    | 20-Mar-2021 | 05:08  | x64      |
| Sqlceip.exe                                  | 13.0.5888.11     | 249240    | 20-Mar-2021 | 05:07  | x86      |
| Sqlcmdss.dll                                 | 2015.131.5888.11 | 53144     | 20-Mar-2021 | 05:08  | x64      |
| Sqldk.dll                                    | 2015.131.5888.11 | 2589592   | 20-Mar-2021 | 05:08  | x64      |
| Sqldtsss.dll                                 | 2015.131.5888.11 | 90520     | 20-Mar-2021 | 04:49  | x64      |
| Sqliosim.com                                 | 2015.131.5888.11 | 300936    | 20-Mar-2021 | 04:47  | x64      |
| Sqliosim.exe                                 | 2015.131.5888.11 | 3007384   | 20-Mar-2021 | 05:08  | x64      |
| Sqllang.dll                                  | 2015.131.5888.11 | 39554464  | 20-Mar-2021 | 05:08  | x64      |
| Sqlmin.dll                                   | 2015.131.5888.11 | 37961112  | 20-Mar-2021 | 04:49  | x64      |
| Sqlolapss.dll                                | 2015.131.5888.11 | 91032     | 20-Mar-2021 | 04:49  | x64      |
| Sqlos.dll                                    | 2015.131.5888.11 | 19344     | 20-Mar-2021 | 04:47  | x64      |
| Sqlpowershellss.dll                          | 2015.131.5888.11 | 51600     | 20-Mar-2021 | 04:49  | x64      |
| Sqlrepss.dll                                 | 2015.131.5888.11 | 48024     | 20-Mar-2021 | 04:49  | x64      |
| Sqlresld.dll                                 | 2015.131.5888.11 | 23968     | 20-Mar-2021 | 04:49  | x64      |
| Sqlresourceloader.dll                        | 2015.131.5888.11 | 23960     | 20-Mar-2021 | 04:49  | x64      |
| Sqlscm.dll                                   | 2015.131.5888.11 | 54152     | 20-Mar-2021 | 04:47  | x64      |
| Sqlscriptdowngrade.dll                       | 2015.131.5888.11 | 20888     | 20-Mar-2021 | 04:48  | x64      |
| Sqlscriptupgrade.dll                         | 2015.131.5888.11 | 5807512   | 20-Mar-2021 | 04:46  | x64      |
| Sqlserverspatial130.dll                      | 2015.131.5888.11 | 725896    | 20-Mar-2021 | 04:46  | x64      |
| Sqlservr.exe                                 | 2015.131.5888.11 | 385952    | 20-Mar-2021 | 05:08  | x64      |
| Sqlsvc.dll                                   | 2015.131.5888.11 | 145304    | 20-Mar-2021 | 04:48  | x64      |
| Sqltses.dll                                  | 2015.131.5888.11 | 8916896   | 20-Mar-2021 | 04:48  | x64      |
| Sqsrvres.dll                                 | 2015.131.5888.11 | 244112    | 20-Mar-2021 | 04:48  | x64      |
| Xe.dll                                       | 2015.131.5888.11 | 619416    | 20-Mar-2021 | 04:48  | x64      |
| Xmlrw.dll                                    | 2015.131.5888.11 | 312200    | 20-Mar-2021 | 04:46  | x64      |
| Xmlrwbin.dll                                 | 2015.131.5888.11 | 220552    | 20-Mar-2021 | 04:46  | x64      |
| Xpadsi.exe                                   | 2015.131.5888.11 | 72096     | 20-Mar-2021 | 05:10  | x64      |
| Xplog70.dll                                  | 2015.131.5888.11 | 58776     | 20-Mar-2021 | 04:46  | x64      |
| Xpsqlbot.dll                                 | 2015.131.5888.11 | 26504     | 20-Mar-2021 | 04:49  | x64      |
| Xpstar.dll                                   | 2015.131.5888.11 | 415624    | 20-Mar-2021 | 04:49  | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                  | File version     | File size | Date      | Time | Platform |
|----------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                              | 2015.131.5888.11 | 153488    | 20-Mar-2021 | 05:07 | x86      |
| Batchparser.dll                              | 2015.131.5888.11 | 173976    | 20-Mar-2021 | 04:47 | x64      |
| Bcp.exe                                      | 2015.131.5888.11 | 113040    | 20-Mar-2021 | 05:09 | x64      |
| Commanddest.dll                              | 2015.131.5888.11 | 242072    | 20-Mar-2021 | 05:09 | x64      |
| Datacollectorenumerators.dll                 | 2015.131.5888.11 | 108944    | 20-Mar-2021 | 05:09 | x64      |
| Datacollectortasks.dll                       | 2015.131.5888.11 | 181128    | 20-Mar-2021 | 05:09 | x64      |
| Distrib.exe                                  | 2015.131.5888.11 | 184200    | 20-Mar-2021 | 05:08 | x64      |
| Dteparse.dll                                 | 2015.131.5888.11 | 102816    | 20-Mar-2021 | 05:09 | x64      |
| Dteparsemgd.dll                              | 2015.131.5888.11 | 81800     | 20-Mar-2021 | 05:09 | x64      |
| Dtepkg.dll                                   | 2015.131.5888.11 | 130440    | 20-Mar-2021 | 05:09 | x64      |
| Dtexec.exe                                   | 2015.131.5888.11 | 65928     | 20-Mar-2021 | 05:08 | x64      |
| Dts.dll                                      | 2015.131.5888.11 | 3139464   | 20-Mar-2021 | 05:09 | x64      |
| Dtscomexpreval.dll                           | 2015.131.5888.11 | 470408    | 20-Mar-2021 | 05:09 | x64      |
| Dtsconn.dll                                  | 2015.131.5888.11 | 485768    | 20-Mar-2021 | 05:09 | x64      |
| Dtshost.exe                                  | 2015.131.5888.11 | 79752     | 20-Mar-2021 | 05:08 | x64      |
| Dtslog.dll                                   | 2015.131.5888.11 | 113544    | 20-Mar-2021 | 05:09 | x64      |
| Dtsmsg130.dll                                | 2015.131.5888.11 | 538504    | 20-Mar-2021 | 05:09 | x64      |
| Dtspipeline.dll                              | 2015.131.5888.11 | 1272200   | 20-Mar-2021 | 05:09 | x64      |
| Dtspipelineperf130.dll                       | 2015.131.5888.11 | 41360     | 20-Mar-2021 | 05:09 | x64      |
| Dtuparse.dll                                 | 2015.131.5888.11 | 80776     | 20-Mar-2021 | 05:09 | x64      |
| Dtutil.exe                                   | 2015.131.5888.11 | 127880    | 20-Mar-2021 | 05:08 | x64      |
| Exceldest.dll                                | 2015.131.5888.11 | 256392    | 20-Mar-2021 | 05:09 | x64      |
| Excelsrc.dll                                 | 2015.131.5888.11 | 278424    | 20-Mar-2021 | 05:09 | x64      |
| Execpackagetask.dll                          | 2015.131.5888.11 | 159640    | 20-Mar-2021 | 05:09 | x64      |
| Flatfiledest.dll                             | 2015.131.5888.11 | 382352    | 20-Mar-2021 | 05:09 | x64      |
| Flatfilesrc.dll                              | 2015.131.5888.11 | 394648    | 20-Mar-2021 | 05:09 | x64      |
| Foreachfileenumerator.dll                    | 2015.131.5888.11 | 89488     | 20-Mar-2021 | 05:09 | x64      |
| Hkengperfctrs.dll                            | 2015.131.5888.11 | 52104     | 20-Mar-2021 | 04:47 | x64      |
| Logread.exe                                  | 2015.131.5888.11 | 619936    | 20-Mar-2021 | 05:08 | x64      |
| Microsoft.analysisservices.applocal.core.dll | 13.0.5888.11     | 1307528   | 20-Mar-2021 | 05:09 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll | 13.0.5888.11     | 385416    | 20-Mar-2021 | 05:10 | x86      |
| Microsoft.sqlserver.replication.dll          | 2015.131.5888.11 | 1644424   | 20-Mar-2021 | 04:50 | x64      |
| Microsoft.sqlserver.rmo.dll                  | 13.0.5888.11     | 562592    | 20-Mar-2021 | 05:10 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5888.11 | 143256    | 20-Mar-2021 | 04:48 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5888.11 | 151944    | 20-Mar-2021 | 04:48 | x64      |
| Msdtssrvrutil.dll                            | 2015.131.5888.11 | 94616     | 20-Mar-2021 | 05:08 | x64      |
| Msxmlsql.dll                                 | 2015.131.5888.11 | 1487752   | 20-Mar-2021 | 04:47 | x64      |
| Oledbdest.dll                                | 2015.131.5888.11 | 257432    | 20-Mar-2021 | 05:08 | x64      |
| Oledbsrc.dll                                 | 2015.131.5888.11 | 284056    | 20-Mar-2021 | 05:08 | x64      |
| Osql.exe                                     | 2015.131.5888.11 | 68512     | 20-Mar-2021 | 05:09 | x64      |
| Rawdest.dll                                  | 2015.131.5888.11 | 202648    | 20-Mar-2021 | 05:08 | x64      |
| Rawsource.dll                                | 2015.131.5888.11 | 189848    | 20-Mar-2021 | 05:08 | x64      |
| Rdistcom.dll                                 | 2015.131.5888.11 | 900496    | 20-Mar-2021 | 05:08 | x64      |
| Recordsetdest.dll                            | 2015.131.5888.11 | 180120    | 20-Mar-2021 | 05:08 | x64      |
| Repldp.dll                                   | 2015.131.5888.11 | 274840    | 20-Mar-2021 | 05:08 | x64      |
| Replmerg.exe                                 | 2015.131.5888.11 | 511896    | 20-Mar-2021 | 05:08 | x64      |
| Replprov.dll                                 | 2015.131.5888.11 | 805280    | 20-Mar-2021 | 05:08 | x64      |
| Replrec.dll                                  | 2015.131.5888.11 | 1012120   | 20-Mar-2021 | 04:49 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2015.131.5888.11 | 93592     | 20-Mar-2021 | 05:09 | x64      |
| Sqlcmd.exe                                   | 2015.131.5888.11 | 242584    | 20-Mar-2021 | 05:09 | x64      |
| Sqldiag.exe                                  | 2015.131.5888.11 | 1250696   | 20-Mar-2021 | 05:08 | x64      |
| Sqllogship.exe                               | 13.0.5888.11     | 97688     | 20-Mar-2021 | 05:07 | x64      |
| Sqlresld.dll                                 | 2015.131.5888.11 | 21904     | 20-Mar-2021 | 05:07 | x86      |
| Sqlresld.dll                                 | 2015.131.5888.11 | 23968     | 20-Mar-2021 | 04:49 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5888.11 | 21400     | 20-Mar-2021 | 05:07 | x86      |
| Sqlresourceloader.dll                        | 2015.131.5888.11 | 23960     | 20-Mar-2021 | 04:49 | x64      |
| Sqlscm.dll                                   | 2015.131.5888.11 | 45976     | 20-Mar-2021 | 05:07 | x86      |
| Sqlscm.dll                                   | 2015.131.5888.11 | 54152     | 20-Mar-2021 | 04:47 | x64      |
| Sqlsvc.dll                                   | 2015.131.5888.11 | 120216    | 20-Mar-2021 | 05:07 | x86      |
| Sqlsvc.dll                                   | 2015.131.5888.11 | 145304    | 20-Mar-2021 | 04:48 | x64      |
| Sqltaskconnections.dll                       | 2015.131.5888.11 | 173984    | 20-Mar-2021 | 04:48 | x64      |
| Sqlwep130.dll                                | 2015.131.5888.11 | 98720     | 20-Mar-2021 | 04:48 | x64      |
| Ssisoledb.dll                                | 2015.131.5888.11 | 209288    | 20-Mar-2021 | 04:48 | x64      |
| Tablediff.exe                                | 13.0.5888.11     | 79760     | 20-Mar-2021 | 05:07 | x64      |
| Txagg.dll                                    | 2015.131.5888.11 | 357768    | 20-Mar-2021 | 04:48 | x64      |
| Txbdd.dll                                    | 2015.131.5888.11 | 165768    | 20-Mar-2021 | 04:48 | x64      |
| Txdatacollector.dll                          | 2015.131.5888.11 | 360840    | 20-Mar-2021 | 04:48 | x64      |
| Txdataconvert.dll                            | 2015.131.5888.11 | 289672    | 20-Mar-2021 | 04:48 | x64      |
| Txderived.dll                                | 2015.131.5888.11 | 600968    | 20-Mar-2021 | 04:48 | x64      |
| Txlookup.dll                                 | 2015.131.5888.11 | 525208    | 20-Mar-2021 | 04:48 | x64      |
| Txmerge.dll                                  | 2015.131.5888.11 | 223624    | 20-Mar-2021 | 04:48 | x64      |
| Txmergejoin.dll                              | 2015.131.5888.11 | 271752    | 20-Mar-2021 | 04:48 | x64      |
| Txmulticast.dll                              | 2015.131.5888.11 | 121224    | 20-Mar-2021 | 04:48 | x64      |
| Txrowcount.dll                               | 2015.131.5888.11 | 119688    | 20-Mar-2021 | 04:48 | x64      |
| Txsort.dll                                   | 2015.131.5888.11 | 252296    | 20-Mar-2021 | 04:48 | x64      |
| Txsplit.dll                                  | 2015.131.5888.11 | 593800    | 20-Mar-2021 | 04:48 | x64      |
| Txunionall.dll                               | 2015.131.5888.11 | 174984    | 20-Mar-2021 | 04:48 | x64      |
| Xe.dll                                       | 2015.131.5888.11 | 619416    | 20-Mar-2021 | 04:48 | x64      |
| Xmlrw.dll                                    | 2015.131.5888.11 | 312200    | 20-Mar-2021 | 04:46 | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version     | File size | Date      | Time | Platform |
|-------------------------------|------------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2015.131.5888.11 | 1008536   | 20-Mar-2021 | 05:09 | x64      |
| Sql_extensibility_keyfile.dll | 2015.131.5888.11 | 93592     | 20-Mar-2021 | 05:09 | x64      |
| Sqlsatellite.dll              | 2015.131.5888.11 | 831368    | 20-Mar-2021 | 04:47 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version     | File size | Date      | Time | Platform |
|--------------------------|------------------|-----------|-----------|------|----------|
| Fd.dll                   | 2015.131.5888.11 | 653208    | 20-Mar-2021 | 04:47 | x64      |
| Fdhost.exe               | 2015.131.5888.11 | 98200     | 20-Mar-2021 | 05:09 | x64      |
| Fdlauncher.exe           | 2015.131.5888.11 | 44440     | 20-Mar-2021 | 05:09 | x64      |
| Sql_fulltext_keyfile.dll | 2015.131.5888.11 | 93592     | 20-Mar-2021 | 05:09 | x64      |
| Sqlft130ph.dll           | 2015.131.5888.11 | 51080     | 20-Mar-2021 | 04:47 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version     | File size | Date      | Time | Platform |
|-------------------------|------------------|-----------|-----------|------|----------|
| Imrdll.dll              | 13.0.5888.11     | 16776     | 20-Mar-2021 | 05:09 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.131.5888.11 | 93592     | 20-Mar-2021 | 05:09 | x64      |

SQL Server 2016 Integration Services

| File   name                                                   | File version     | File size | Date      | Time  | Platform |
|---------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 4.0.0.111        | 77944     | 02-Mar-2021  | 12:25 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 4.0.0.111        | 77944     | 07-Mar-2021  | 13:47 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 4.0.0.111        | 37496     | 02-Mar-2021  | 12:25 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 4.0.0.111        | 37496     | 07-Mar-2021  | 13:47 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 4.0.0.111        | 78456     | 02-Mar-2021  | 12:25 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 4.0.0.111        | 78456     | 07-Mar-2021  | 13:47 | x86      |
| Commanddest.dll                                               | 2015.131.5888.11 | 195984    | 20-Mar-2021 | 05:07  | x86      |
| Commanddest.dll                                               | 2015.131.5888.11 | 242072    | 20-Mar-2021 | 05:09  | x64      |
| Dteparse.dll                                                  | 2015.131.5888.11 | 92568     | 20-Mar-2021 | 05:07  | x86      |
| Dteparse.dll                                                  | 2015.131.5888.11 | 102816    | 20-Mar-2021 | 05:09  | x64      |
| Dteparsemgd.dll                                               | 2015.131.5888.11 | 81800     | 20-Mar-2021 | 05:09  | x64      |
| Dteparsemgd.dll                                               | 2015.131.5888.11 | 76680     | 20-Mar-2021 | 05:11  | x86      |
| Dtepkg.dll                                                    | 2015.131.5888.11 | 108952    | 20-Mar-2021 | 05:07  | x86      |
| Dtepkg.dll                                                    | 2015.131.5888.11 | 130440    | 20-Mar-2021 | 05:09  | x64      |
| Dtexec.exe                                                    | 2015.131.5888.11 | 59792     | 20-Mar-2021 | 05:08  | x86      |
| Dtexec.exe                                                    | 2015.131.5888.11 | 65928     | 20-Mar-2021 | 05:08  | x64      |
| Dts.dll                                                       | 2015.131.5888.11 | 2625936   | 20-Mar-2021 | 05:07  | x86      |
| Dts.dll                                                       | 2015.131.5888.11 | 3139464   | 20-Mar-2021 | 05:09  | x64      |
| Dtscomexpreval.dll                                            | 2015.131.5888.11 | 412056    | 20-Mar-2021 | 05:07  | x86      |
| Dtscomexpreval.dll                                            | 2015.131.5888.11 | 470408    | 20-Mar-2021 | 05:09  | x64      |
| Dtsconn.dll                                                   | 2015.131.5888.11 | 385432    | 20-Mar-2021 | 05:07  | x86      |
| Dtsconn.dll                                                   | 2015.131.5888.11 | 485768    | 20-Mar-2021 | 05:09  | x64      |
| Dtsdebughost.exe                                              | 2015.131.5888.11 | 86920     | 20-Mar-2021 | 05:08  | x86      |
| Dtsdebughost.exe                                              | 2015.131.5888.11 | 102808    | 20-Mar-2021 | 05:08  | x64      |
| Dtshost.exe                                                   | 2015.131.5888.11 | 69528     | 20-Mar-2021 | 05:08  | x86      |
| Dtshost.exe                                                   | 2015.131.5888.11 | 79752     | 20-Mar-2021 | 05:08  | x64      |
| Dtslog.dll                                                    | 2015.131.5888.11 | 96144     | 20-Mar-2021 | 05:07  | x86      |
| Dtslog.dll                                                    | 2015.131.5888.11 | 113544    | 20-Mar-2021 | 05:09  | x64      |
| Dtsmsg130.dll                                                 | 2015.131.5888.11 | 534424    | 20-Mar-2021 | 05:07  | x86      |
| Dtsmsg130.dll                                                 | 2015.131.5888.11 | 538504    | 20-Mar-2021 | 05:09  | x64      |
| Dtspipeline.dll                                               | 2015.131.5888.11 | 1052568   | 20-Mar-2021 | 05:07  | x86      |
| Dtspipeline.dll                                               | 2015.131.5888.11 | 1272200   | 20-Mar-2021 | 05:09  | x64      |
| Dtspipelineperf130.dll                                        | 2015.131.5888.11 | 35224     | 20-Mar-2021 | 05:07  | x86      |
| Dtspipelineperf130.dll                                        | 2015.131.5888.11 | 41360     | 20-Mar-2021 | 05:09  | x64      |
| Dtuparse.dll                                                  | 2015.131.5888.11 | 73112     | 20-Mar-2021 | 05:06  | x86      |
| Dtuparse.dll                                                  | 2015.131.5888.11 | 80776     | 20-Mar-2021 | 05:09  | x64      |
| Dtutil.exe                                                    | 2015.131.5888.11 | 108440    | 20-Mar-2021 | 05:08  | x86      |
| Dtutil.exe                                                    | 2015.131.5888.11 | 127880    | 20-Mar-2021 | 05:08  | x64      |
| Exceldest.dll                                                 | 2015.131.5888.11 | 209816    | 20-Mar-2021 | 05:06  | x86      |
| Exceldest.dll                                                 | 2015.131.5888.11 | 256392    | 20-Mar-2021 | 05:09  | x64      |
| Excelsrc.dll                                                  | 2015.131.5888.11 | 225688    | 20-Mar-2021 | 05:06  | x86      |
| Excelsrc.dll                                                  | 2015.131.5888.11 | 278424    | 20-Mar-2021 | 05:09  | x64      |
| Execpackagetask.dll                                           | 2015.131.5888.11 | 128408    | 20-Mar-2021 | 05:06  | x86      |
| Execpackagetask.dll                                           | 2015.131.5888.11 | 159640    | 20-Mar-2021 | 05:09  | x64      |
| Flatfiledest.dll                                              | 2015.131.5888.11 | 327576    | 20-Mar-2021 | 05:06  | x86      |
| Flatfiledest.dll                                              | 2015.131.5888.11 | 382352    | 20-Mar-2021 | 05:09  | x64      |
| Flatfilesrc.dll                                               | 2015.131.5888.11 | 338328    | 20-Mar-2021 | 05:06  | x86      |
| Flatfilesrc.dll                                               | 2015.131.5888.11 | 394648    | 20-Mar-2021 | 05:09  | x64      |
| Foreachfileenumerator.dll                                     | 2015.131.5888.11 | 73624     | 20-Mar-2021 | 05:06  | x86      |
| Foreachfileenumerator.dll                                     | 2015.131.5888.11 | 89488     | 20-Mar-2021 | 05:09  | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 13.0.5888.11     | 1307528   | 20-Mar-2021 | 05:09  | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 13.0.5888.11     | 1307552   | 20-Mar-2021 | 05:11  | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435      | 329872    | 6-Jul-18  | 22:33 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 13.0.5888.11     | 66440     | 20-Mar-2021 | 04:50  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2015.131.5888.11 | 100232    | 20-Mar-2021 | 05:10  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2015.131.5888.11 | 105352    | 20-Mar-2021 | 04:50  | x64      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.5888.11     | 478624    | 20-Mar-2021 | 05:10  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.5888.11     | 478600    | 20-Mar-2021 | 04:48  | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 13.0.5888.11     | 75656     | 19-Mar-21 | 22:03 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 13.0.5888.11     | 75672     | 20-Mar-2021 | 04:51  | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 13.0.5888.11     | 385416    | 20-Mar-2021 | 05:10  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2015.131.5888.11 | 132000    | 20-Mar-2021 | 05:08  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2015.131.5888.11 | 143256    | 20-Mar-2021 | 04:48  | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2015.131.5888.11 | 137624    | 20-Mar-2021 | 05:08  | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2015.131.5888.11 | 151944    | 20-Mar-2021 | 04:48  | x64      |
| Msdtssrvr.exe                                                 | 13.0.5888.11     | 210312    | 20-Mar-2021 | 05:07  | x64      |
| Msdtssrvrutil.dll                                             | 2015.131.5888.11 | 83336     | 20-Mar-2021 | 05:08  | x86      |
| Msdtssrvrutil.dll                                             | 2015.131.5888.11 | 94616     | 20-Mar-2021 | 05:08  | x64      |
| Oledbdest.dll                                                 | 2015.131.5888.11 | 209800    | 20-Mar-2021 | 05:08  | x86      |
| Oledbdest.dll                                                 | 2015.131.5888.11 | 257432    | 20-Mar-2021 | 05:08  | x64      |
| Oledbsrc.dll                                                  | 2015.131.5888.11 | 228744    | 20-Mar-2021 | 05:08  | x86      |
| Oledbsrc.dll                                                  | 2015.131.5888.11 | 284056    | 20-Mar-2021 | 05:08  | x64      |
| Rawdest.dll                                                   | 2015.131.5888.11 | 161688    | 20-Mar-2021 | 05:07  | x86      |
| Rawdest.dll                                                   | 2015.131.5888.11 | 202648    | 20-Mar-2021 | 05:08  | x64      |
| Rawsource.dll                                                 | 2015.131.5888.11 | 148376    | 20-Mar-2021 | 05:07  | x86      |
| Rawsource.dll                                                 | 2015.131.5888.11 | 189848    | 20-Mar-2021 | 05:08  | x64      |
| Recordsetdest.dll                                             | 2015.131.5888.11 | 144776    | 20-Mar-2021 | 05:07  | x86      |
| Recordsetdest.dll                                             | 2015.131.5888.11 | 180120    | 20-Mar-2021 | 05:08  | x64      |
| Sql_is_keyfile.dll                                            | 2015.131.5888.11 | 93592     | 20-Mar-2021 | 05:09  | x64      |
| Sqlceip.exe                                                   | 13.0.5888.11     | 249240    | 20-Mar-2021 | 05:07  | x86      |
| Sqldest.dll                                                   | 2015.131.5888.11 | 208776    | 20-Mar-2021 | 05:07  | x86      |
| Sqldest.dll                                                   | 2015.131.5888.11 | 256920    | 20-Mar-2021 | 05:08  | x64      |
| Sqltaskconnections.dll                                        | 2015.131.5888.11 | 144272    | 20-Mar-2021 | 05:07  | x86      |
| Sqltaskconnections.dll                                        | 2015.131.5888.11 | 173984    | 20-Mar-2021 | 04:48  | x64      |
| Ssisoledb.dll                                                 | 2015.131.5888.11 | 169872    | 20-Mar-2021 | 05:07  | x86      |
| Ssisoledb.dll                                                 | 2015.131.5888.11 | 209288    | 20-Mar-2021 | 04:48  | x64      |
| Txagg.dll                                                     | 2015.131.5888.11 | 297864    | 20-Mar-2021 | 05:08  | x86      |
| Txagg.dll                                                     | 2015.131.5888.11 | 357768    | 20-Mar-2021 | 04:48  | x64      |
| Txbdd.dll                                                     | 2015.131.5888.11 | 130952    | 20-Mar-2021 | 05:08  | x86      |
| Txbdd.dll                                                     | 2015.131.5888.11 | 165768    | 20-Mar-2021 | 04:48  | x64      |
| Txbestmatch.dll                                               | 2015.131.5888.11 | 489352    | 20-Mar-2021 | 05:08  | x86      |
| Txbestmatch.dll                                               | 2015.131.5888.11 | 604552    | 20-Mar-2021 | 04:48  | x64      |
| Txcache.dll                                                   | 2015.131.5888.11 | 141192    | 20-Mar-2021 | 05:08  | x86      |
| Txcache.dll                                                   | 2015.131.5888.11 | 176520    | 20-Mar-2021 | 04:48  | x64      |
| Txcharmap.dll                                                 | 2015.131.5888.11 | 243592    | 20-Mar-2021 | 05:08  | x86      |
| Txcharmap.dll                                                 | 2015.131.5888.11 | 283016    | 20-Mar-2021 | 04:48  | x64      |
| Txcopymap.dll                                                 | 2015.131.5888.11 | 140680    | 20-Mar-2021 | 05:08  | x86      |
| Txcopymap.dll                                                 | 2015.131.5888.11 | 176008    | 20-Mar-2021 | 04:48  | x64      |
| Txdataconvert.dll                                             | 2015.131.5888.11 | 248200    | 20-Mar-2021 | 05:08  | x86      |
| Txdataconvert.dll                                             | 2015.131.5888.11 | 289672    | 20-Mar-2021 | 04:48  | x64      |
| Txderived.dll                                                 | 2015.131.5888.11 | 512392    | 20-Mar-2021 | 05:08  | x86      |
| Txderived.dll                                                 | 2015.131.5888.11 | 600968    | 20-Mar-2021 | 04:48  | x64      |
| Txfileextractor.dll                                           | 2015.131.5888.11 | 156040    | 20-Mar-2021 | 05:08  | x86      |
| Txfileextractor.dll                                           | 2015.131.5888.11 | 194968    | 20-Mar-2021 | 04:48  | x64      |
| Txfileinserter.dll                                            | 2015.131.5888.11 | 153992    | 20-Mar-2021 | 05:08  | x86      |
| Txfileinserter.dll                                            | 2015.131.5888.11 | 192904    | 20-Mar-2021 | 04:48  | x64      |
| Txgroupdups.dll                                               | 2015.131.5888.11 | 224648    | 20-Mar-2021 | 05:08  | x86      |
| Txgroupdups.dll                                               | 2015.131.5888.11 | 284040    | 20-Mar-2021 | 04:48  | x64      |
| Txlineage.dll                                                 | 2015.131.5888.11 | 102792    | 20-Mar-2021 | 05:08  | x86      |
| Txlineage.dll                                                 | 2015.131.5888.11 | 130968    | 20-Mar-2021 | 04:48  | x64      |
| Txlookup.dll                                                  | 2015.131.5888.11 | 442760    | 20-Mar-2021 | 05:08  | x86      |
| Txlookup.dll                                                  | 2015.131.5888.11 | 525208    | 20-Mar-2021 | 04:48  | x64      |
| Txmerge.dll                                                   | 2015.131.5888.11 | 169864    | 20-Mar-2021 | 05:08  | x86      |
| Txmerge.dll                                                   | 2015.131.5888.11 | 223624    | 20-Mar-2021 | 04:48  | x64      |
| Txmergejoin.dll                                               | 2015.131.5888.11 | 216968    | 20-Mar-2021 | 05:08  | x86      |
| Txmergejoin.dll                                               | 2015.131.5888.11 | 271752    | 20-Mar-2021 | 04:48  | x64      |
| Txmulticast.dll                                               | 2015.131.5888.11 | 95112     | 20-Mar-2021 | 05:08  | x86      |
| Txmulticast.dll                                               | 2015.131.5888.11 | 121224    | 20-Mar-2021 | 04:48  | x64      |
| Txpivot.dll                                                   | 2015.131.5888.11 | 174984    | 20-Mar-2021 | 05:08  | x86      |
| Txpivot.dll                                                   | 2015.131.5888.11 | 221064    | 20-Mar-2021 | 04:48  | x64      |
| Txrowcount.dll                                                | 2015.131.5888.11 | 94624     | 20-Mar-2021 | 05:08  | x86      |
| Txrowcount.dll                                                | 2015.131.5888.11 | 119688    | 20-Mar-2021 | 04:48  | x64      |
| Txsampling.dll                                                | 2015.131.5888.11 | 127904    | 20-Mar-2021 | 05:08  | x86      |
| Txsampling.dll                                                | 2015.131.5888.11 | 165256    | 20-Mar-2021 | 04:48  | x64      |
| Txscd.dll                                                     | 2015.131.5888.11 | 162720    | 20-Mar-2021 | 05:08  | x86      |
| Txscd.dll                                                     | 2015.131.5888.11 | 213384    | 20-Mar-2021 | 04:48  | x64      |
| Txsort.dll                                                    | 2015.131.5888.11 | 204192    | 20-Mar-2021 | 05:08  | x86      |
| Txsort.dll                                                    | 2015.131.5888.11 | 252296    | 20-Mar-2021 | 04:48  | x64      |
| Txsplit.dll                                                   | 2015.131.5888.11 | 506248    | 20-Mar-2021 | 05:08  | x86      |
| Txsplit.dll                                                   | 2015.131.5888.11 | 593800    | 20-Mar-2021 | 04:48  | x64      |
| Txtermextraction.dll                                          | 2015.131.5888.11 | 8608648   | 20-Mar-2021 | 05:08  | x86      |
| Txtermextraction.dll                                          | 2015.131.5888.11 | 8671128   | 20-Mar-2021 | 04:48  | x64      |
| Txtermlookup.dll                                              | 2015.131.5888.11 | 4099976   | 20-Mar-2021 | 05:08  | x86      |
| Txtermlookup.dll                                              | 2015.131.5888.11 | 4151688   | 20-Mar-2021 | 04:48  | x64      |
| Txunionall.dll                                                | 2015.131.5888.11 | 131976    | 20-Mar-2021 | 05:08  | x86      |
| Txunionall.dll                                                | 2015.131.5888.11 | 174984    | 20-Mar-2021 | 04:48  | x64      |
| Txunpivot.dll                                                 | 2015.131.5888.11 | 155552    | 20-Mar-2021 | 05:08  | x86      |
| Txunpivot.dll                                                 | 2015.131.5888.11 | 194952    | 20-Mar-2021 | 04:48  | x64      |
| Xe.dll                                                        | 2015.131.5888.11 | 551816    | 20-Mar-2021 | 05:08  | x86      |
| Xe.dll                                                        | 2015.131.5888.11 | 619416    | 20-Mar-2021 | 04:48  | x64      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Dms.dll                                                              | 10.0.8224.49     | 483624    | 09-May-2019  | 19:33 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.49 | 75560     | 09-May-2019  | 19:33 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.49     | 45864     | 09-May-2019  | 19:33 | x86      |
| Instapi130.dll                                                       | 2015.131.5888.11 | 54152     | 20-Mar-2021 | 04:47  | x64      |
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
| Mpdwinterop.dll                                                      | 2015.131.5888.11 | 387976    | 20-Mar-2021 | 05:14  | x64      |
| Mpdwsvc.exe                                                          | 2015.131.5888.11 | 6611864   | 20-Mar-2021 | 05:10  | x64      |
| Pdwodbcsql11.dll                                                     | 2015.131.5888.11 | 2223496   | 20-Mar-2021 | 04:47  | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.49 | 47400     | 09-May-2019  | 19:33 | x64      |
| Sqldk.dll                                                            | 2015.131.5888.11 | 2532744   | 20-Mar-2021 | 04:47  | x64      |
| Sqldumper.exe                                                        | 2015.131.5888.11 | 123296    | 20-Mar-2021 | 05:10  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5888.11 | 1434520   | 20-Mar-2021 | 04:47  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5888.11 | 3749784   | 20-Mar-2021 | 05:11  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5888.11 | 3080584   | 20-Mar-2021 | 04:47  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5888.11 | 3751328   | 20-Mar-2021 | 05:11  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5888.11 | 3654552   | 20-Mar-2021 | 04:48  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5888.11 | 2002824   | 20-Mar-2021 | 04:47  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5888.11 | 1948552   | 20-Mar-2021 | 04:47  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5888.11 | 3436952   | 20-Mar-2021 | 04:49  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5888.11 | 3448736   | 20-Mar-2021 | 04:48  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5888.11 | 1384328   | 20-Mar-2021 | 04:48  | x64      |
| Sqlevn70.rll                                                         | 2015.131.5888.11 | 3623832   | 20-Mar-2021 | 04:48  | x64      |
| Sqlos.dll                                                            | 2015.131.5888.11 | 19336     | 20-Mar-2021 | 04:47  | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.49 | 4348200   | 09-May-2019  | 19:33 | x64      |
| Sqltses.dll                                                          | 2015.131.5888.11 | 9085832   | 20-Mar-2021 | 04:47  | x64      |

SQL Server 2016 Reporting Services

| File   name                                               | File version     | File size | Date      | Time | Platform |
|-----------------------------------------------------------|------------------|-----------|-----------|------|----------|
| Microsoft.analysisservices.modeling.dll                   | 13.0.5888.11     | 604064    | 20-Mar-2021 | 05:09 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.5888.11     | 1613720   | 20-Mar-2021 | 05:08 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.5888.11     | 651656    | 20-Mar-2021 | 05:08 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.5888.11     | 322968    | 20-Mar-2021 | 05:08 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.5888.11     | 1083784   | 20-Mar-2021 | 05:08 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5888.11     | 541592    | 20-Mar-2021 | 04:49 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5888.11     | 541600    | 20-Mar-2021 | 05:10 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5888.11     | 541576    | 20-Mar-2021 | 04:47 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5888.11     | 541600    | 20-Mar-2021 | 04:49 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5888.11     | 541576    | 20-Mar-2021 | 04:48 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5888.11     | 541600    | 20-Mar-2021 | 04:47 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5888.11     | 541576    | 20-Mar-2021 | 05:14 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5888.11     | 541576    | 20-Mar-2021 | 05:08 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5888.11     | 541592    | 20-Mar-2021 | 05:10 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.5888.11     | 541600    | 20-Mar-2021 | 04:49 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.5888.11     | 156040    | 20-Mar-2021 | 05:08 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.5888.11     | 119192    | 20-Mar-2021 | 04:50 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.5888.11     | 6069656   | 20-Mar-2021 | 04:50 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5888.11     | 4504472   | 20-Mar-2021 | 04:49 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5888.11     | 4504992   | 20-Mar-2021 | 05:10 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5888.11     | 4504984   | 20-Mar-2021 | 04:47 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5888.11     | 4504992   | 20-Mar-2021 | 04:49 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5888.11     | 4505504   | 20-Mar-2021 | 04:48 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5888.11     | 4505504   | 20-Mar-2021 | 04:47 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5888.11     | 4504984   | 20-Mar-2021 | 05:14 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5888.11     | 4505992   | 20-Mar-2021 | 05:08 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5888.11     | 4504472   | 20-Mar-2021 | 05:10 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.5888.11     | 4504992   | 20-Mar-2021 | 04:48 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.5888.11     | 10920840  | 20-Mar-2021 | 04:50 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.5888.11     | 96136     | 20-Mar-2021 | 05:07 | x64      |
| Microsoft.reportingservices.storage.dll                   | 13.0.5888.11     | 202136    | 20-Mar-2021 | 04:50 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.131.5888.11 | 40856     | 20-Mar-2021 | 04:50 | x64      |
| Microsoft.sqlserver.types.dll                             | 2015.131.5888.11 | 390048    | 20-Mar-2021 | 05:08 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.131.5888.11 | 385944    | 20-Mar-2021 | 04:47 | x86      |
| Msmdlocal.dll                                             | 2015.131.5888.11 | 37127064  | 20-Mar-2021 | 05:08 | x86      |
| Msmdlocal.dll                                             | 2015.131.5888.11 | 56245144  | 20-Mar-2021 | 05:08 | x64      |
| Msmgdsrv.dll                                              | 2015.131.5888.11 | 6502296   | 20-Mar-2021 | 05:08 | x86      |
| Msmgdsrv.dll                                              | 2015.131.5888.11 | 7502744   | 20-Mar-2021 | 04:50 | x64      |
| Msolap130.dll                                             | 2015.131.5888.11 | 7003528   | 20-Mar-2021 | 05:08 | x86      |
| Msolap130.dll                                             | 2015.131.5888.11 | 8636312   | 20-Mar-2021 | 05:08 | x64      |
| Msolui130.dll                                             | 2015.131.5888.11 | 280456    | 20-Mar-2021 | 05:08 | x86      |
| Msolui130.dll                                             | 2015.131.5888.11 | 303520    | 20-Mar-2021 | 05:08 | x64      |
| Reportingservicescompression.dll                          | 2015.131.5888.11 | 55704     | 20-Mar-2021 | 05:08 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.5888.11     | 77720     | 20-Mar-2021 | 04:49 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.5888.11     | 2536864   | 20-Mar-2021 | 04:49 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.131.5888.11 | 107424    | 20-Mar-2021 | 05:08 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.131.5888.11 | 101792    | 20-Mar-2021 | 04:49 | x64      |
| Reportingservicesnativeserver.dll                         | 2015.131.5888.11 | 92048     | 20-Mar-2021 | 04:49 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.5888.11     | 2722712   | 20-Mar-2021 | 04:49 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5888.11     | 877456    | 20-Mar-2021 | 04:47 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5888.11     | 881560    | 20-Mar-2021 | 04:50 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5888.11     | 881568    | 20-Mar-2021 | 05:10 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5888.11     | 881568    | 20-Mar-2021 | 04:49 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5888.11     | 885664    | 20-Mar-2021 | 04:48 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5888.11     | 881552    | 20-Mar-2021 | 04:48 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5888.11     | 881544    | 20-Mar-2021 | 04:48 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5888.11     | 893856    | 20-Mar-2021 | 04:48 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5888.11     | 877472    | 20-Mar-2021 | 04:47 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.5888.11     | 881568    | 20-Mar-2021 | 04:48 | x86      |
| Rshttpruntime.dll                                         | 2015.131.5888.11 | 92568     | 20-Mar-2021 | 04:49 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.131.5888.11 | 93592     | 20-Mar-2021 | 05:09 | x64      |
| Sqldumper.exe                                             | 2015.131.5888.11 | 103832    | 20-Mar-2021 | 05:07 | x86      |
| Sqldumper.exe                                             | 2015.131.5888.11 | 123288    | 20-Mar-2021 | 05:09 | x64      |
| Sqlrsos.dll                                               | 2015.131.5888.11 | 19344     | 20-Mar-2021 | 04:49 | x64      |
| Sqlserverspatial130.dll                                   | 2015.131.5888.11 | 577424    | 20-Mar-2021 | 05:07 | x86      |
| Sqlserverspatial130.dll                                   | 2015.131.5888.11 | 725896    | 20-Mar-2021 | 04:46 | x64      |
| Xmlrw.dll                                                 | 2015.131.5888.11 | 252832    | 20-Mar-2021 | 05:08 | x86      |
| Xmlrw.dll                                                 | 2015.131.5888.11 | 312200    | 20-Mar-2021 | 04:46 | x64      |
| Xmlrwbin.dll                                              | 2015.131.5888.11 | 184728    | 20-Mar-2021 | 05:08 | x86      |
| Xmlrwbin.dll                                              | 2015.131.5888.11 | 220552    | 20-Mar-2021 | 04:46 | x64      |
| Xmsrv.dll                                                 | 2015.131.5888.11 | 32720792  | 20-Mar-2021 | 05:08 | x86      |
| Xmsrv.dll                                                 | 2015.131.5888.11 | 24041880  | 20-Mar-2021 | 04:48 | x64      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version     | File size | Date      | Time | Platform |
|------------------------------------|------------------|-----------|-----------|------|----------|
| Smrdll.dll                         | 13.0.5888.11     | 16792     | 20-Mar-2021 | 04:49 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.131.5888.11 | 93592     | 20-Mar-2021 | 05:09 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                    | File version     | File size | Date      | Time | Platform |
|------------------------------------------------|------------------|-----------|-----------|------|----------|
| Autoadmin.dll                                  | 2015.131.5888.11 | 1304984   | 20-Mar-2021 | 05:07 | x86      |
| Ddsshapes.dll                                  | 2015.131.5888.11 | 128920    | 20-Mar-2021 | 05:07 | x86      |
| Dtaengine.exe                                  | 2015.131.5888.11 | 160152    | 20-Mar-2021 | 05:08 | x86      |
| Dteparse.dll                                   | 2015.131.5888.11 | 92568     | 20-Mar-2021 | 05:07 | x86      |
| Dteparse.dll                                   | 2015.131.5888.11 | 102816    | 20-Mar-2021 | 05:09 | x64      |
| Dteparsemgd.dll                                | 2015.131.5888.11 | 81800     | 20-Mar-2021 | 05:09 | x64      |
| Dteparsemgd.dll                                | 2015.131.5888.11 | 76680     | 20-Mar-2021 | 05:11 | x86      |
| Dtepkg.dll                                     | 2015.131.5888.11 | 108952    | 20-Mar-2021 | 05:07 | x86      |
| Dtepkg.dll                                     | 2015.131.5888.11 | 130440    | 20-Mar-2021 | 05:09 | x64      |
| Dtexec.exe                                     | 2015.131.5888.11 | 59792     | 20-Mar-2021 | 05:08 | x86      |
| Dtexec.exe                                     | 2015.131.5888.11 | 65928     | 20-Mar-2021 | 05:08 | x64      |
| Dts.dll                                        | 2015.131.5888.11 | 2625936   | 20-Mar-2021 | 05:07 | x86      |
| Dts.dll                                        | 2015.131.5888.11 | 3139464   | 20-Mar-2021 | 05:09 | x64      |
| Dtscomexpreval.dll                             | 2015.131.5888.11 | 412056    | 20-Mar-2021 | 05:07 | x86      |
| Dtscomexpreval.dll                             | 2015.131.5888.11 | 470408    | 20-Mar-2021 | 05:09 | x64      |
| Dtsconn.dll                                    | 2015.131.5888.11 | 385432    | 20-Mar-2021 | 05:07 | x86      |
| Dtsconn.dll                                    | 2015.131.5888.11 | 485768    | 20-Mar-2021 | 05:09 | x64      |
| Dtshost.exe                                    | 2015.131.5888.11 | 69528     | 20-Mar-2021 | 05:08 | x86      |
| Dtshost.exe                                    | 2015.131.5888.11 | 79752     | 20-Mar-2021 | 05:08 | x64      |
| Dtslog.dll                                     | 2015.131.5888.11 | 96144     | 20-Mar-2021 | 05:07 | x86      |
| Dtslog.dll                                     | 2015.131.5888.11 | 113544    | 20-Mar-2021 | 05:09 | x64      |
| Dtsmsg130.dll                                  | 2015.131.5888.11 | 534424    | 20-Mar-2021 | 05:07 | x86      |
| Dtsmsg130.dll                                  | 2015.131.5888.11 | 538504    | 20-Mar-2021 | 05:09 | x64      |
| Dtspipeline.dll                                | 2015.131.5888.11 | 1052568   | 20-Mar-2021 | 05:07 | x86      |
| Dtspipeline.dll                                | 2015.131.5888.11 | 1272200   | 20-Mar-2021 | 05:09 | x64      |
| Dtspipelineperf130.dll                         | 2015.131.5888.11 | 35224     | 20-Mar-2021 | 05:07 | x86      |
| Dtspipelineperf130.dll                         | 2015.131.5888.11 | 41360     | 20-Mar-2021 | 05:09 | x64      |
| Dtuparse.dll                                   | 2015.131.5888.11 | 73112     | 20-Mar-2021 | 05:06 | x86      |
| Dtuparse.dll                                   | 2015.131.5888.11 | 80776     | 20-Mar-2021 | 05:09 | x64      |
| Dtutil.exe                                     | 2015.131.5888.11 | 108440    | 20-Mar-2021 | 05:08 | x86      |
| Dtutil.exe                                     | 2015.131.5888.11 | 127880    | 20-Mar-2021 | 05:08 | x64      |
| Exceldest.dll                                  | 2015.131.5888.11 | 209816    | 20-Mar-2021 | 05:06 | x86      |
| Exceldest.dll                                  | 2015.131.5888.11 | 256392    | 20-Mar-2021 | 05:09 | x64      |
| Excelsrc.dll                                   | 2015.131.5888.11 | 225688    | 20-Mar-2021 | 05:06 | x86      |
| Excelsrc.dll                                   | 2015.131.5888.11 | 278424    | 20-Mar-2021 | 05:09 | x64      |
| Flatfiledest.dll                               | 2015.131.5888.11 | 327576    | 20-Mar-2021 | 05:06 | x86      |
| Flatfiledest.dll                               | 2015.131.5888.11 | 382352    | 20-Mar-2021 | 05:09 | x64      |
| Flatfilesrc.dll                                | 2015.131.5888.11 | 338328    | 20-Mar-2021 | 05:06 | x86      |
| Flatfilesrc.dll                                | 2015.131.5888.11 | 394648    | 20-Mar-2021 | 05:09 | x64      |
| Foreachfileenumerator.dll                      | 2015.131.5888.11 | 73624     | 20-Mar-2021 | 05:06 | x86      |
| Foreachfileenumerator.dll                      | 2015.131.5888.11 | 89488     | 20-Mar-2021 | 05:09 | x64      |
| Microsoft.analysisservices.adomdclientui.dll   | 13.0.5888.11     | 85384     | 20-Mar-2021 | 05:11 | x86      |
| Microsoft.analysisservices.applocal.core.dll   | 13.0.5888.11     | 1307552   | 20-Mar-2021 | 05:11 | x86      |
| Microsoft.analysisservices.project.dll         | 2015.131.5888.11 | 2016648   | 20-Mar-2021 | 05:11 | x86      |
| Microsoft.analysisservices.projectui.dll       | 2015.131.5888.11 | 35232     | 20-Mar-2021 | 05:08 | x86      |
| Microsoft.sqlserver.astasks.dll                | 13.0.5888.11     | 66440     | 20-Mar-2021 | 05:10 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5888.11     | 428936    | 20-Mar-2021 | 05:10 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5888.11     | 428936    | 20-Mar-2021 | 04:50 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5888.11     | 2037640   | 20-Mar-2021 | 05:10 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5888.11     | 2037640   | 20-Mar-2021 | 04:49 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5888.11 | 132000    | 20-Mar-2021 | 05:08 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5888.11 | 143256    | 20-Mar-2021 | 04:48 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5888.11 | 137624    | 20-Mar-2021 | 05:08 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5888.11 | 151944    | 20-Mar-2021 | 04:48 | x64      |
| Msdtssrvrutil.dll                              | 2015.131.5888.11 | 83336     | 20-Mar-2021 | 05:08 | x86      |
| Msdtssrvrutil.dll                              | 2015.131.5888.11 | 94616     | 20-Mar-2021 | 05:08 | x64      |
| Msmdlocal.dll                                  | 2015.131.5888.11 | 37127064  | 20-Mar-2021 | 05:08 | x86      |
| Msmdlocal.dll                                  | 2015.131.5888.11 | 56245144  | 20-Mar-2021 | 05:08 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5888.11 | 6502296   | 20-Mar-2021 | 05:08 | x86      |
| Msmgdsrv.dll                                   | 2015.131.5888.11 | 7502744   | 20-Mar-2021 | 04:50 | x64      |
| Msolap130.dll                                  | 2015.131.5888.11 | 7003528   | 20-Mar-2021 | 05:08 | x86      |
| Msolap130.dll                                  | 2015.131.5888.11 | 8636312   | 20-Mar-2021 | 05:08 | x64      |
| Msolui130.dll                                  | 2015.131.5888.11 | 280456    | 20-Mar-2021 | 05:08 | x86      |
| Msolui130.dll                                  | 2015.131.5888.11 | 303520    | 20-Mar-2021 | 05:08 | x64      |
| Oledbdest.dll                                  | 2015.131.5888.11 | 209800    | 20-Mar-2021 | 05:08 | x86      |
| Oledbdest.dll                                  | 2015.131.5888.11 | 257432    | 20-Mar-2021 | 05:08 | x64      |
| Oledbsrc.dll                                   | 2015.131.5888.11 | 228744    | 20-Mar-2021 | 05:08 | x86      |
| Oledbsrc.dll                                   | 2015.131.5888.11 | 284056    | 20-Mar-2021 | 05:08 | x64      |
| Profiler.exe                                   | 2015.131.5888.11 | 797576    | 20-Mar-2021 | 05:11 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.131.5888.11 | 93592     | 20-Mar-2021 | 05:09 | x64      |
| Sqldumper.exe                                  | 2015.131.5888.11 | 103832    | 20-Mar-2021 | 05:07 | x86      |
| Sqldumper.exe                                  | 2015.131.5888.11 | 123288    | 20-Mar-2021 | 05:09 | x64      |
| Sqlresld.dll                                   | 2015.131.5888.11 | 21904     | 20-Mar-2021 | 05:07 | x86      |
| Sqlresld.dll                                   | 2015.131.5888.11 | 23968     | 20-Mar-2021 | 04:49 | x64      |
| Sqlresourceloader.dll                          | 2015.131.5888.11 | 21400     | 20-Mar-2021 | 05:07 | x86      |
| Sqlresourceloader.dll                          | 2015.131.5888.11 | 23960     | 20-Mar-2021 | 04:49 | x64      |
| Sqlscm.dll                                     | 2015.131.5888.11 | 45976     | 20-Mar-2021 | 05:07 | x86      |
| Sqlscm.dll                                     | 2015.131.5888.11 | 54152     | 20-Mar-2021 | 04:47 | x64      |
| Sqlsvc.dll                                     | 2015.131.5888.11 | 120216    | 20-Mar-2021 | 05:07 | x86      |
| Sqlsvc.dll                                     | 2015.131.5888.11 | 145304    | 20-Mar-2021 | 04:48 | x64      |
| Sqltaskconnections.dll                         | 2015.131.5888.11 | 144272    | 20-Mar-2021 | 05:07 | x86      |
| Sqltaskconnections.dll                         | 2015.131.5888.11 | 173984    | 20-Mar-2021 | 04:48 | x64      |
| Txdataconvert.dll                              | 2015.131.5888.11 | 248200    | 20-Mar-2021 | 05:08 | x86      |
| Txdataconvert.dll                              | 2015.131.5888.11 | 289672    | 20-Mar-2021 | 04:48 | x64      |
| Xe.dll                                         | 2015.131.5888.11 | 551816    | 20-Mar-2021 | 05:08 | x86      |
| Xe.dll                                         | 2015.131.5888.11 | 619416    | 20-Mar-2021 | 04:48 | x64      |
| Xmlrw.dll                                      | 2015.131.5888.11 | 252832    | 20-Mar-2021 | 05:08 | x86      |
| Xmlrw.dll                                      | 2015.131.5888.11 | 312200    | 20-Mar-2021 | 04:46 | x64      |
| Xmlrwbin.dll                                   | 2015.131.5888.11 | 184728    | 20-Mar-2021 | 05:08 | x86      |
| Xmlrwbin.dll                                   | 2015.131.5888.11 | 220552    | 20-Mar-2021 | 04:46 | x64      |
| Xmsrv.dll                                      | 2015.131.5888.11 | 32720792  | 20-Mar-2021 | 05:08 | x86      |
| Xmsrv.dll                                      | 2015.131.5888.11 | 24041880  | 20-Mar-2021 | 04:48 | x64      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
