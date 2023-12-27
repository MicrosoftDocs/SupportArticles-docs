---
title: Cumulative update 30 for SQL Server 2017 (KB5013756)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 30 (KB5013756).
ms.date: 08/04/2023
ms.custom: KB5013756
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB5013756 - Cumulative Update 30 for SQL Server 2017

_Release Date:_ &nbsp; July 13, 2022  
_Version:_ &nbsp; 14.0.3451.2

## Summary

This article describes Cumulative Update package 30 (CU30) for Microsoft SQL Server 2017. This update contains 8 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 29, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3451.2**, file version: **2017.140.3451.2**
- Analysis Services - Product version: **14.0.249.90**, file version: **2017.140.249.90**

## Known issues in this update

After applying SQL Server 2017 CU30, you may encounter an access violation when performing a bulk insert operation followed by a select statement in the same transaction. It can only occur when the database's recovery model is either simple or bulk-logged.

To mitigate this issue, you can either uninstall CU30 or apply a temporary workaround of enabling trace flag 805. The trace flag reverts the changes introduced through fix number [14669410](cumulativeupdate30.md#14669410) in CU30.

This issue will be addressed in a future CU.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with other people so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|-------------------------------------------|----------|
| <a id=14812566>[14812566](#14812566) </a> | A latch time-out occurs and the IOCP listener stalls when Service Broker connects to an endpoint by using database mirroring. </br></br>**Note**: This fix is available when TF 12323 is enabled. |SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id=14605069>[14605069](#14605069) </a> | An access violation occurs when you try to truncate specific partitions of a table by using the `$Partition` function if the function name or table name doesn't exist. |SQL Server Engine | Metadata | Windows |
| <a id=14669410>[14669410](#14669410) </a> | This fix resolves the following issues: </br></br>- An assertion failure occurs when your query contains the `MERGE` statement. </br></br>- The online index rebuild can't finish when you use the simple recovery model.| SQL Server Engine | Methods to access stored data | All |
| <a id=14644630>[14644630](#14644630) </a> | Dropping temp tables causes an unresolved deadlock and dump file in some rare cases. | SQL Server Engine | Programmability | Windows |
| <a id=14673411>[14673411](#14673411) </a> | Error 2706 occurs when you run `DBCC CHECKDB WITH EXTENDED_LOGICAL_CHECKS` against a database by using the Table-Valued Function (TVF) that uses indexes. Here's the error message: </br></br>Table '%.*ls' does not exist. | SQL Server Engine | Query Execution | Windows |
| <a id=14783868>[14783868](#14783868) </a> | In Microsoft SQL Server 2017, running parameterized queries skips the SelOnSeqPrj rule. Therefore, pushdown doesn't occur. | SQL Server Engine| Query Optimizer | All |
| <a id=14861990>[14861990](#14861990) </a> | In Microsoft SQL Server 2017, an index creation over a persisted computed column and partition function fails. Additionally, the following error 8624 occurs: </br></br>Internal Query Processor Error: The query processor could not produce a query plan. For more information, contact Customer Support Services. | SQL Server Engine | Query Optimizer | Windows |
| <a id=14576377>[14576377](#14576377) </a> | [Improvement: Match the lock escalation policy for the change tracking table to that of the base table (KB5014047)](https://support.microsoft.com/help/5014047) | SQL Server Engine | Replication | Windows |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2017 now](https://www.microsoft.com/download/details.aspx?id=56128)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog </b></summary>

> [!NOTE]
>
> After future cumulative updates are released for SQL Server 2017, this and all previous CUs can be downloaded from the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/search.aspx?q=sql%20server%202017). However, we recommend that you always install the latest cumulative update that is available.

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU30 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2022/07/sqlserver2017-kb5013756-x64_f4871b2167d371e508b73953ecbbcd42fc28f997.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB5013756-x64.exe* file through the following command:

`certutil -hashfile SQLServer2017-KB5013756-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB5013756-x64.exe| D21D0E68F9784CA1E479F43D69A591CEA51C1BD90D593DD7C36D17BFF614B4FA |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

| File   name                                        | File version    | File size | Date      | Time | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Asplatformhost.dll                                 | 2017.140.249.90 | 259472    | 23-Jun-22 | 05:20 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.249.90     | 735120    | 23-Jun-22 | 04:57 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.249.90     | 1374096   | 23-Jun-22 | 05:21 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.249.90     | 977296    | 23-Jun-22 | 05:21 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.249.90     | 516024    | 23-Jun-22 | 05:21 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 23-Jun-22 | 05:10 | x86      |
| Microsoft.data.edm.netfx35.dll                     | 5.7.0.62516     | 661072    | 23-Jun-22 | 04:57 | x86      |
| Microsoft.data.mashup.dll                          | 2.80.5803.541   | 186232    | 23-Jun-22 | 04:57 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.80.5803.541   | 30080     | 23-Jun-22 | 04:57 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.80.5803.541   | 74832     | 23-Jun-22 | 04:57 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.80.5803.541   | 102264    | 23-Jun-22 | 04:57 | x86      |
| Microsoft.data.odata.netfx35.dll                   | 5.7.0.62516     | 1454672   | 23-Jun-22 | 04:57 | x86      |
| Microsoft.data.odata.query.netfx35.dll             | 5.7.0.62516     | 181112    | 23-Jun-22 | 04:57 | x86      |
| Microsoft.data.sapclient.dll                       | 1.0.0.25        | 920656    | 23-Jun-22 | 04:57 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.80.5803.541   | 5262728   | 23-Jun-22 | 04:57 | x86      |
| Microsoft.mashup.container.exe                     | 2.80.5803.541   | 22392     | 23-Jun-22 | 04:57 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.80.5803.541   | 21880     | 23-Jun-22 | 04:57 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.80.5803.541   | 22096     | 23-Jun-22 | 04:57 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.80.5803.541   | 149368    | 23-Jun-22 | 04:57 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.80.5803.541   | 78712     | 23-Jun-22 | 04:57 | x86      |
| Microsoft.mashup.oledbinterop.dll                  | 2.80.5803.541   | 192392    | 23-Jun-22 | 04:57 | x64      |
| Microsoft.mashup.oledbprovider.dll                 | 2.80.5803.541   | 59984     | 23-Jun-22 | 04:57 | x86      |
| Microsoft.mashup.shims.dll                         | 2.80.5803.541   | 27512     | 23-Jun-22 | 04:57 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 140368    | 23-Jun-22 | 04:57 | x86      |
| Microsoft.mashupengine.dll                         | 2.80.5803.541   | 14271872  | 23-Jun-22 | 04:57 | x86      |
| Microsoft.odata.core.netfx35.dll                   | 6.15.0.0        | 1437568   | 23-Jun-22 | 04:57 | x86      |
| Microsoft.odata.edm.netfx35.dll                    | 6.15.0.0        | 778632    | 23-Jun-22 | 04:57 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.1.27.19      | 1104976   | 23-Jun-22 | 04:57 | x86      |
| Microsoft.spatial.netfx35.dll                      | 6.15.0.0        | 126336    | 23-Jun-22 | 04:57 | x86      |
| Msmdctr.dll                                        | 2017.140.249.90 | 33168     | 23-Jun-22 | 05:22 | x64      |
| Msmdlocal.dll                                      | 2017.140.249.90 | 40420240  | 23-Jun-22 | 05:00 | x86      |
| Msmdlocal.dll                                      | 2017.140.249.90 | 60767160  | 23-Jun-22 | 05:22 | x64      |
| Msmdpump.dll                                       | 2017.140.249.90 | 9333136   | 23-Jun-22 | 05:22 | x64      |
| Msmdredir.dll                                      | 2017.140.249.90 | 7088528   | 23-Jun-22 | 05:00 | x86      |
| Msmdsrv.exe                                        | 2017.140.249.90 | 60669856  | 23-Jun-22 | 05:22 | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.90 | 7305104   | 23-Jun-22 | 05:00 | x86      |
| Msmgdsrv.dll                                       | 2017.140.249.90 | 9001912   | 23-Jun-22 | 05:22 | x64      |
| Msolap.dll                                         | 2017.140.249.90 | 7772560   | 23-Jun-22 | 05:00 | x86      |
| Msolap.dll                                         | 2017.140.249.90 | 10256784  | 23-Jun-22 | 05:22 | x64      |
| Msolui.dll                                         | 2017.140.249.90 | 281528    | 23-Jun-22 | 04:59 | x86      |
| Msolui.dll                                         | 2017.140.249.90 | 304016    | 23-Jun-22 | 05:22 | x64      |
| Powerbiextensions.dll                              | 2.80.5803.541   | 9470032   | 23-Jun-22 | 04:57 | x86      |
| Private_odbc32.dll                                 | 10.0.14832.1000 | 728456    | 23-Jun-22 | 04:57 | x64      |
| Sql_as_keyfile.dll                                 | 2017.140.3451.2 | 94648     | 23-Jun-22 | 05:20 | x64      |
| Sqlboot.dll                                        | 2017.140.3451.2 | 191912    | 23-Jun-22 | 05:22 | x64      |
| Sqlceip.exe                                        | 14.0.3451.2     | 269208    | 23-Jun-22 | 05:10 | x86      |
| Sqldumper.exe                                      | 2017.140.3451.2 | 117152    | 23-Jun-22 | 04:59 | x86      |
| Sqldumper.exe                                      | 2017.140.3451.2 | 139680    | 23-Jun-22 | 05:07 | x64      |
| System.spatial.netfx35.dll                         | 5.7.0.62516     | 117640    | 23-Jun-22 | 04:57 | x86      |
| Tmapi.dll                                          | 2017.140.249.90 | 5814672   | 23-Jun-22 | 05:22 | x64      |
| Tmcachemgr.dll                                     | 2017.140.249.90 | 4158904   | 23-Jun-22 | 05:22 | x64      |
| Tmpersistence.dll                                  | 2017.140.249.90 | 1125264   | 23-Jun-22 | 05:22 | x64      |
| Tmtransactions.dll                                 | 2017.140.249.90 | 1637280   | 23-Jun-22 | 05:22 | x64      |
| Xe.dll                                             | 2017.140.3451.2 | 667552    | 23-Jun-22 | 05:22 | x64      |
| Xmlrw.dll                                          | 2017.140.3451.2 | 251792    | 23-Jun-22 | 05:00 | x86      |
| Xmlrw.dll                                          | 2017.140.3451.2 | 299432    | 23-Jun-22 | 05:22 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3451.2 | 183712    | 23-Jun-22 | 05:00 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3451.2 | 218528    | 23-Jun-22 | 05:22 | x64      |
| Xmsrv.dll                                          | 2017.140.249.90 | 33350584  | 23-Jun-22 | 05:00 | x86      |
| Xmsrv.dll                                          | 2017.140.249.90 | 25376144  | 23-Jun-22 | 05:22 | x64      |

SQL Server 2017 Database Services Common Core

| File   name                                | File version     | File size | Date      | Time | Platform |
|--------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                            | 2017.140.3451.2  | 154536    | 23-Jun-22 | 04:57 | x86      |
| Batchparser.dll                            | 2017.140.3451.2  | 175008    | 23-Jun-22 | 05:20 | x64      |
| Instapi140.dll                             | 2017.140.3451.2  | 56744     | 23-Jun-22 | 04:59 | x86      |
| Instapi140.dll                             | 2017.140.3451.2  | 66472     | 23-Jun-22 | 05:22 | x64      |
| Isacctchange.dll                           | 2017.140.3451.2  | 23464     | 23-Jun-22 | 04:57 | x86      |
| Isacctchange.dll                           | 2017.140.3451.2  | 24992     | 23-Jun-22 | 05:20 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.90      | 1081744   | 23-Jun-22 | 04:57 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.90      | 1082784   | 23-Jun-22 | 05:20 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.249.90      | 1374608   | 23-Jun-22 | 04:57 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.90      | 734608    | 23-Jun-22 | 04:57 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.90      | 734608    | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3451.2      | 31656     | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3451.2  | 72608     | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3451.2  | 76208     | 23-Jun-22 | 05:21 | x64      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3451.2      | 565648    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3451.2      | 565664    | 23-Jun-22 | 05:21 | x86      |
| Msasxpress.dll                             | 2017.140.249.90  | 24976     | 23-Jun-22 | 04:59 | x86      |
| Msasxpress.dll                             | 2017.140.249.90  | 30112     | 23-Jun-22 | 05:22 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3451.2  | 63392     | 23-Jun-22 | 05:00 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3451.2  | 78264     | 23-Jun-22 | 05:22 | x64      |
| Sql_common_core_keyfile.dll                | 2017.140.3451.2  | 94648     | 23-Jun-22 | 05:20 | x64      |
| Sqldumper.exe                              | 2017.140.3451.2  | 117152    | 23-Jun-22 | 04:59 | x86      |
| Sqldumper.exe                              | 2017.140.3451.2  | 139680    | 23-Jun-22 | 05:07 | x64      |
| Sqlftacct.dll                              | 2017.140.3451.2  | 50064     | 23-Jun-22 | 05:00 | x86      |
| Sqlftacct.dll                              | 2017.140.3451.2  | 58272     | 23-Jun-22 | 05:22 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 23-Jun-22 | 04:58 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 23-Jun-22 | 05:21 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3451.2  | 369552    | 23-Jun-22 | 04:58 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3451.2  | 414120    | 23-Jun-22 | 05:21 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3451.2  | 29080     | 23-Jun-22 | 05:00 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3451.2  | 31648     | 23-Jun-22 | 05:22 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3451.2  | 268208    | 23-Jun-22 | 05:00 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3451.2  | 352168    | 23-Jun-22 | 05:22 | x64      |
| Sqltdiagn.dll                              | 2017.140.3451.2  | 54696     | 23-Jun-22 | 04:58 | x86      |
| Sqltdiagn.dll                              | 2017.140.3451.2  | 61872     | 23-Jun-22 | 05:21 | x64      |
| Svrenumapi140.dll                          | 2017.140.3451.2  | 889256    | 23-Jun-22 | 05:00 | x86      |
| Svrenumapi140.dll                          | 2017.140.3451.2  | 1168800   | 23-Jun-22 | 05:22 | x64      |

SQL Server 2017 Data Quality Client

| File   name         | File version    | File size | Date      | Time | Platform |
|---------------------|-----------------|-----------|-----------|------|----------|
| Dumpbin.exe         | 12.10.30102.2   | 24624     | 23-Jun-22 | 04:58 | x86      |
| Link.exe            | 12.10.30102.2   | 852528    | 23-Jun-22 | 04:59 | x86      |
| Mspdb120.dll        | 12.10.30102.2   | 259632    | 23-Jun-22 | 04:59 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3451.2 | 94648     | 23-Jun-22 | 05:20 | x64      |
| Stdole.dll          | 7.0.9466.0      | 32296     | 23-Jun-22 | 05:00 | x86      |

SQL Server 2017 Data Quality

| File   name                                       | File version | File size | Date      | Time | Platform |
|---------------------------------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 23-Jun-22 | 05:21 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 23-Jun-22 | 05:21 | x86      |


SQL Server 2017 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2017.140.3451.2 | 115128    | 23-Jun-22 | 04:57 | x86      |
| Dreplaycommon.dll              | 2017.140.3451.2 | 694176    | 23-Jun-22 | 04:57 | x86      |
| Dreplayserverps.dll            | 2017.140.3451.2 | 27064     | 23-Jun-22 | 04:57 | x86      |
| Dreplayutil.dll                | 2017.140.3451.2 | 304536    | 23-Jun-22 | 04:57 | x86      |
| Instapi140.dll                 | 2017.140.3451.2 | 66472     | 23-Jun-22 | 05:22 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3451.2 | 94648     | 23-Jun-22 | 05:20 | x64      |
| Sqlresourceloader.dll          | 2017.140.3451.2 | 23480     | 23-Jun-22 | 04:58 | x86      |

SQL Server 2017 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2017.140.3451.2 | 694176    | 23-Jun-22 | 04:57 | x86      |
| Dreplaycontroller.exe              | 2017.140.3451.2 | 344480    | 23-Jun-22 | 04:57 | x86      |
| Dreplayprocess.dll                 | 2017.140.3451.2 | 165800    | 23-Jun-22 | 04:57 | x86      |
| Dreplayserverps.dll                | 2017.140.3451.2 | 27064     | 23-Jun-22 | 04:57 | x86      |
| Instapi140.dll                     | 2017.140.3451.2 | 66472     | 23-Jun-22 | 05:22 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3451.2 | 94648     | 23-Jun-22 | 05:20 | x64      |
| Sqlresourceloader.dll              | 2017.140.3451.2 | 23480     | 23-Jun-22 | 04:58 | x86      |

SQL Server 2017 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time | Platform |
|----------------------------------------------|-----------------|-----------|-----------|------|----------|
| Backuptourl.exe                              | 14.0.3451.2     | 34720     | 23-Jun-22 | 05:20 | x64      |
| Batchparser.dll                              | 2017.140.3451.2 | 175008    | 23-Jun-22 | 05:20 | x64      |
| C1.dll                                       | 18.10.40116.18  | 925232    | 23-Jun-22 | 05:12 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341440   | 23-Jun-22 | 05:12 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192048    | 23-Jun-22 | 05:12 | x64      |
| Clui.dll                                     | 18.10.40116.10  | 486144    | 23-Jun-22 | 05:10 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 23-Jun-22 | 05:20 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3451.2 | 221608    | 23-Jun-22 | 05:20 | x64      |
| Dcexec.exe                                   | 2017.140.3451.2 | 68536     | 23-Jun-22 | 05:20 | x64      |
| Fssres.dll                                   | 2017.140.3451.2 | 84880     | 23-Jun-22 | 05:22 | x64      |
| Hadrres.dll                                  | 2017.140.3451.2 | 183712    | 23-Jun-22 | 05:22 | x64      |
| Hkcompile.dll                                | 2017.140.3451.2 | 1417128   | 23-Jun-22 | 05:22 | x64      |
| Hkengine.dll                                 | 2017.140.3451.2 | 5855664   | 23-Jun-22 | 05:22 | x64      |
| Hkruntime.dll                                | 2017.140.3451.2 | 157096    | 23-Jun-22 | 05:22 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017392   | 23-Jun-22 | 05:12 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.249.90     | 734096    | 23-Jun-22 | 05:21 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 23-Jun-22 | 05:10 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3451.2     | 232872    | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3451.2     | 74152     | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.types.dll                | 2017.140.3451.2 | 386976    | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3451.2 | 66480     | 23-Jun-22 | 05:21 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3451.2 | 59296     | 23-Jun-22 | 05:21 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3451.2 | 146336    | 23-Jun-22 | 05:21 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3451.2 | 153504    | 23-Jun-22 | 05:21 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3451.2 | 297896    | 23-Jun-22 | 05:21 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3451.2 | 69048     | 23-Jun-22 | 05:21 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129576    | 23-Jun-22 | 05:12 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559144    | 23-Jun-22 | 05:12 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 23-Jun-22 | 05:12 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661040    | 23-Jun-22 | 05:12 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964656    | 23-Jun-22 | 05:12 | x64      |
| Odsole70.dll                                 | 2017.140.3451.2 | 86952     | 23-Jun-22 | 05:22 | x64      |
| Opends60.dll                                 | 2017.140.3451.2 | 27040     | 23-Jun-22 | 05:22 | x64      |
| Qds.dll                                      | 2017.140.3451.2 | 1178016   | 23-Jun-22 | 05:22 | x64      |
| Rsfxft.dll                                   | 2017.140.3451.2 | 28576     | 23-Jun-22 | 05:21 | x64      |
| Secforwarder.dll                             | 2017.140.3451.2 | 31656     | 23-Jun-22 | 05:22 | x64      |
| Sqagtres.dll                                 | 2017.140.3451.2 | 70032     | 23-Jun-22 | 05:22 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3451.2 | 94648     | 23-Jun-22 | 05:20 | x64      |
| Sqlaamss.dll                                 | 2017.140.3451.2 | 85936     | 23-Jun-22 | 05:21 | x64      |
| Sqlaccess.dll                                | 2017.140.3451.2 | 469920    | 23-Jun-22 | 05:22 | x64      |
| Sqlagent.exe                                 | 2017.140.3451.2 | 599448    | 23-Jun-22 | 05:21 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3451.2 | 48544     | 23-Jun-22 | 04:58 | x86      |
| Sqlagentctr140.dll                           | 2017.140.3451.2 | 57264     | 23-Jun-22 | 05:21 | x64      |
| Sqlagentlog.dll                              | 2017.140.3451.2 | 27064     | 23-Jun-22 | 05:21 | x64      |
| Sqlagentmail.dll                             | 2017.140.3451.2 | 48032     | 23-Jun-22 | 05:21 | x64      |
| Sqlboot.dll                                  | 2017.140.3451.2 | 191912    | 23-Jun-22 | 05:22 | x64      |
| Sqlceip.exe                                  | 14.0.3451.2     | 269208    | 23-Jun-22 | 05:10 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3451.2 | 68512     | 23-Jun-22 | 05:21 | x64      |
| Sqlctr140.dll                                | 2017.140.3451.2 | 107432    | 23-Jun-22 | 05:00 | x86      |
| Sqlctr140.dll                                | 2017.140.3451.2 | 124816    | 23-Jun-22 | 05:22 | x64      |
| Sqldk.dll                                    | 2017.140.3451.2 | 2805152   | 23-Jun-22 | 05:21 | x64      |
| Sqldtsss.dll                                 | 2017.140.3451.2 | 103328    | 23-Jun-22 | 05:21 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3785128   | 23-Jun-22 | 04:56 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3826064   | 23-Jun-22 | 04:56 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 1500584   | 23-Jun-22 | 04:56 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3486608   | 23-Jun-22 | 04:56 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3792296   | 23-Jun-22 | 04:56 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 2093480   | 23-Jun-22 | 04:57 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3296176   | 23-Jun-22 | 04:57 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3343784   | 23-Jun-22 | 04:58 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3301800   | 23-Jun-22 | 04:58 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3682728   | 23-Jun-22 | 04:58 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3922848   | 23-Jun-22 | 05:05 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 1447848   | 23-Jun-22 | 05:06 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3372456   | 23-Jun-22 | 05:06 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3218336   | 23-Jun-22 | 05:08 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3593616   | 23-Jun-22 | 05:08 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3641256   | 23-Jun-22 | 05:08 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3790752   | 23-Jun-22 | 05:09 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3407768   | 23-Jun-22 | 05:11 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3920304   | 23-Jun-22 | 05:12 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 4032928   | 23-Jun-22 | 05:12 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 2039728   | 23-Jun-22 | 05:16 | x64      |
| Sqlevn70.rll                                 | 2017.140.3451.2 | 3601824   | 23-Jun-22 | 04:56 | x64      |
| Sqliosim.com                                 | 2017.140.3451.2 | 307624    | 23-Jun-22 | 05:22 | x64      |
| Sqliosim.exe                                 | 2017.140.3451.2 | 3014040   | 23-Jun-22 | 05:22 | x64      |
| Sqllang.dll                                  | 2017.140.3451.2 | 41380240  | 23-Jun-22 | 05:22 | x64      |
| Sqlmin.dll                                   | 2017.140.3451.2 | 40596920  | 23-Jun-22 | 05:22 | x64      |
| Sqlolapss.dll                                | 2017.140.3451.2 | 103336    | 23-Jun-22 | 05:21 | x64      |
| Sqlos.dll                                    | 2017.140.3451.2 | 20392     | 23-Jun-22 | 05:21 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3451.2 | 63912     | 23-Jun-22 | 05:21 | x64      |
| Sqlrepss.dll                                 | 2017.140.3451.2 | 62880     | 23-Jun-22 | 05:21 | x64      |
| Sqlresld.dll                                 | 2017.140.3451.2 | 25016     | 23-Jun-22 | 05:21 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3451.2 | 26536     | 23-Jun-22 | 05:21 | x64      |
| Sqlscm.dll                                   | 2017.140.3451.2 | 66968     | 23-Jun-22 | 05:21 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3451.2 | 21944     | 23-Jun-22 | 05:22 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3451.2 | 5893536   | 23-Jun-22 | 05:22 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3451.2 | 726944    | 23-Jun-22 | 05:21 | x64      |
| Sqlservr.exe                                 | 2017.140.3451.2 | 482720    | 23-Jun-22 | 05:22 | x64      |
| Sqlsvc.dll                                   | 2017.140.3451.2 | 157096    | 23-Jun-22 | 05:21 | x64      |
| Sqltses.dll                                  | 2017.140.3451.2 | 9560480   | 23-Jun-22 | 05:21 | x64      |
| Sqsrvres.dll                                 | 2017.140.3451.2 | 256928    | 23-Jun-22 | 05:22 | x64      |
| Svl.dll                                      | 2017.140.3451.2 | 147864    | 23-Jun-22 | 05:22 | x64      |
| Xe.dll                                       | 2017.140.3451.2 | 667552    | 23-Jun-22 | 05:22 | x64      |
| Xmlrw.dll                                    | 2017.140.3451.2 | 299432    | 23-Jun-22 | 05:22 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3451.2 | 218528    | 23-Jun-22 | 05:22 | x64      |
| Xpadsi.exe                                   | 2017.140.3451.2 | 85920     | 23-Jun-22 | 05:22 | x64      |
| Xplog70.dll                                  | 2017.140.3451.2 | 72104     | 23-Jun-22 | 05:22 | x64      |
| Xpqueue.dll                                  | 2017.140.3451.2 | 69024     | 23-Jun-22 | 05:22 | x64      |
| Xprepl.dll                                   | 2017.140.3451.2 | 97704     | 23-Jun-22 | 05:22 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3451.2 | 26536     | 23-Jun-22 | 05:22 | x64      |
| Xpstar.dll                                   | 2017.140.3451.2 | 446360    | 23-Jun-22 | 05:22 | x64      |

SQL Server 2017 Database Services Core Shared

| File   name                                                 | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Batchparser.dll                                             | 2017.140.3451.2 | 154536    | 23-Jun-22 | 04:57 | x86      |
| Batchparser.dll                                             | 2017.140.3451.2 | 175008    | 23-Jun-22 | 05:20 | x64      |
| Bcp.exe                                                     | 2017.140.3451.2 | 114080    | 23-Jun-22 | 05:22 | x64      |
| Commanddest.dll                                             | 2017.140.3451.2 | 240048    | 23-Jun-22 | 05:20 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3451.2 | 110520    | 23-Jun-22 | 05:20 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3451.2 | 181688    | 23-Jun-22 | 05:20 | x64      |
| Distrib.exe                                                 | 2017.140.3451.2 | 199080    | 23-Jun-22 | 05:22 | x64      |
| Dteparse.dll                                                | 2017.140.3451.2 | 105400    | 23-Jun-22 | 05:20 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3451.2 | 83360     | 23-Jun-22 | 05:20 | x64      |
| Dtepkg.dll                                                  | 2017.140.3451.2 | 132000    | 23-Jun-22 | 05:20 | x64      |
| Dtexec.exe                                                  | 2017.140.3451.2 | 69048     | 23-Jun-22 | 05:20 | x64      |
| Dts.dll                                                     | 2017.140.3451.2 | 2995128   | 23-Jun-22 | 05:20 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3451.2 | 469408    | 23-Jun-22 | 05:20 | x64      |
| Dtsconn.dll                                                 | 2017.140.3451.2 | 494496    | 23-Jun-22 | 05:20 | x64      |
| Dtshost.exe                                                 | 2017.140.3451.2 | 100280    | 23-Jun-22 | 05:22 | x64      |
| Dtslog.dll                                                  | 2017.140.3451.2 | 114592    | 23-Jun-22 | 05:20 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3451.2 | 539552    | 23-Jun-22 | 05:22 | x64      |
| Dtspipeline.dll                                             | 2017.140.3451.2 | 1262480   | 23-Jun-22 | 05:20 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3451.2 | 42384     | 23-Jun-22 | 05:20 | x64      |
| Dtuparse.dll                                                | 2017.140.3451.2 | 83360     | 23-Jun-22 | 05:20 | x64      |
| Dtutil.exe                                                  | 2017.140.3451.2 | 142768    | 23-Jun-22 | 05:20 | x64      |
| Exceldest.dll                                               | 2017.140.3451.2 | 254888    | 23-Jun-22 | 05:20 | x64      |
| Excelsrc.dll                                                | 2017.140.3451.2 | 276904    | 23-Jun-22 | 05:20 | x64      |
| Execpackagetask.dll                                         | 2017.140.3451.2 | 162232    | 23-Jun-22 | 05:20 | x64      |
| Flatfiledest.dll                                            | 2017.140.3451.2 | 380840    | 23-Jun-22 | 05:20 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3451.2 | 393656    | 23-Jun-22 | 05:20 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3451.2 | 90552     | 23-Jun-22 | 05:20 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3451.2 | 53664     | 23-Jun-22 | 05:22 | x64      |
| Ionic.zip.dll                                               | 1.9.1.8         | 471440    | 23-Jun-22 | 04:58 | x86      |
| Logread.exe                                                 | 2017.140.3451.2 | 630688    | 23-Jun-22 | 05:22 | x64      |
| Mergetxt.dll                                                | 2017.140.3451.2 | 59296     | 23-Jun-22 | 05:22 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.249.90     | 1375120   | 23-Jun-22 | 05:21 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3451.2     | 131984    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll    | 14.0.3451.2     | 49568     | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3451.2     | 83856     | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll      | 14.0.3451.2     | 67512     | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                | 14.0.3451.2     | 386472    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3451.2     | 608680    | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3451.2 | 1658792   | 23-Jun-22 | 05:21 | x64      |
| Microsoft.sqlserver.rmo.dll                                 | 14.0.3451.2     | 565648    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3451.2 | 146336    | 23-Jun-22 | 05:21 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3451.2 | 153504    | 23-Jun-22 | 05:21 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3451.2 | 97184     | 23-Jun-22 | 05:20 | x64      |
| Msgprox.dll                                                 | 2017.140.3451.2 | 266152    | 23-Jun-22 | 05:22 | x64      |
| Msxmlsql.dll                                                | 2017.140.3451.2 | 1442208   | 23-Jun-22 | 05:22 | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111     | 522856    | 23-Jun-22 | 04:58 | x86      |
| Oledbdest.dll                                               | 2017.140.3451.2 | 255400    | 23-Jun-22 | 05:20 | x64      |
| Oledbsrc.dll                                                | 2017.140.3451.2 | 283064    | 23-Jun-22 | 05:20 | x64      |
| Osql.exe                                                    | 2017.140.3451.2 | 69552     | 23-Jun-22 | 05:20 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3451.2 | 469904    | 23-Jun-22 | 05:22 | x64      |
| Rawdest.dll                                                 | 2017.140.3451.2 | 200632    | 23-Jun-22 | 05:21 | x64      |
| Rawsource.dll                                               | 2017.140.3451.2 | 188328    | 23-Jun-22 | 05:21 | x64      |
| Rdistcom.dll                                                | 2017.140.3451.2 | 853416    | 23-Jun-22 | 05:22 | x64      |
| Recordsetdest.dll                                           | 2017.140.3451.2 | 183208    | 23-Jun-22 | 05:21 | x64      |
| Replagnt.dll                                                | 2017.140.3451.2 | 24976     | 23-Jun-22 | 05:22 | x64      |
| Repldp.dll                                                  | 2017.140.3451.2 | 286616    | 23-Jun-22 | 05:22 | x64      |
| Replerrx.dll                                                | 2017.140.3451.2 | 149920    | 23-Jun-22 | 05:22 | x64      |
| Replisapi.dll                                               | 2017.140.3451.2 | 358328    | 23-Jun-22 | 05:22 | x64      |
| Replmerg.exe                                                | 2017.140.3451.2 | 521120    | 23-Jun-22 | 05:22 | x64      |
| Replprov.dll                                                | 2017.140.3451.2 | 798120    | 23-Jun-22 | 05:22 | x64      |
| Replrec.dll                                                 | 2017.140.3451.2 | 973712    | 23-Jun-22 | 05:22 | x64      |
| Replsub.dll                                                 | 2017.140.3451.2 | 441272    | 23-Jun-22 | 05:22 | x64      |
| Replsync.dll                                                | 2017.140.3451.2 | 149408    | 23-Jun-22 | 05:22 | x64      |
| Sort00001000.dll                                            | 4.0.30319.576   | 871680    | 23-Jun-22 | 05:22 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576   | 75016     | 23-Jun-22 | 05:22 | x64      |
| Spresolv.dll                                                | 2017.140.3451.2 | 248224    | 23-Jun-22 | 05:22 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3451.2 | 94648     | 23-Jun-22 | 05:20 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3451.2 | 243104    | 23-Jun-22 | 05:22 | x64      |
| Sqldiag.exe                                                 | 2017.140.3451.2 | 1255848   | 23-Jun-22 | 05:22 | x64      |
| Sqldistx.dll                                                | 2017.140.3451.2 | 220576    | 23-Jun-22 | 05:22 | x64      |
| Sqllogship.exe                                              | 14.0.3451.2     | 100256    | 23-Jun-22 | 05:21 | x64      |
| Sqlmergx.dll                                                | 2017.140.3451.2 | 356264    | 23-Jun-22 | 05:22 | x64      |
| Sqlresld.dll                                                | 2017.140.3451.2 | 22968     | 23-Jun-22 | 04:58 | x86      |
| Sqlresld.dll                                                | 2017.140.3451.2 | 25016     | 23-Jun-22 | 05:21 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3451.2 | 23480     | 23-Jun-22 | 04:58 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3451.2 | 26536     | 23-Jun-22 | 05:21 | x64      |
| Sqlscm.dll                                                  | 2017.140.3451.2 | 56224     | 23-Jun-22 | 04:58 | x86      |
| Sqlscm.dll                                                  | 2017.140.3451.2 | 66968     | 23-Jun-22 | 05:21 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3451.2 | 129424    | 23-Jun-22 | 04:58 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3451.2 | 157096    | 23-Jun-22 | 05:21 | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3451.2 | 178080    | 23-Jun-22 | 05:21 | x64      |
| Sqlwep140.dll                                               | 2017.140.3451.2 | 99728     | 23-Jun-22 | 05:22 | x64      |
| Ssdebugps.dll                                               | 2017.140.3451.2 | 27536     | 23-Jun-22 | 05:22 | x64      |
| Ssisoledb.dll                                               | 2017.140.3451.2 | 210360    | 23-Jun-22 | 05:21 | x64      |
| Ssradd.dll                                                  | 2017.140.3451.2 | 71072     | 23-Jun-22 | 05:22 | x64      |
| Ssravg.dll                                                  | 2017.140.3451.2 | 71592     | 23-Jun-22 | 05:22 | x64      |
| Ssrdown.dll                                                 | 2017.140.3451.2 | 56224     | 23-Jun-22 | 05:22 | x64      |
| Ssrmax.dll                                                  | 2017.140.3451.2 | 69536     | 23-Jun-22 | 05:22 | x64      |
| Ssrmin.dll                                                  | 2017.140.3451.2 | 69536     | 23-Jun-22 | 05:22 | x64      |
| Ssrpub.dll                                                  | 2017.140.3451.2 | 56744     | 23-Jun-22 | 05:22 | x64      |
| Ssrup.dll                                                   | 2017.140.3451.2 | 56232     | 23-Jun-22 | 05:22 | x64      |
| Tablediff.exe                                               | 14.0.3451.2     | 80800     | 23-Jun-22 | 05:22 | x64      |
| Txagg.dll                                                   | 2017.140.3451.2 | 356256    | 23-Jun-22 | 05:21 | x64      |
| Txbdd.dll                                                   | 2017.140.3451.2 | 169384    | 23-Jun-22 | 05:21 | x64      |
| Txdatacollector.dll                                         | 2017.140.3451.2 | 361384    | 23-Jun-22 | 05:22 | x64      |
| Txdataconvert.dll                                           | 2017.140.3451.2 | 287136    | 23-Jun-22 | 05:22 | x64      |
| Txderived.dll                                               | 2017.140.3451.2 | 598440    | 23-Jun-22 | 05:22 | x64      |
| Txlookup.dll                                                | 2017.140.3451.2 | 522144    | 23-Jun-22 | 05:22 | x64      |
| Txmerge.dll                                                 | 2017.140.3451.2 | 225704    | 23-Jun-22 | 05:22 | x64      |
| Txmergejoin.dll                                             | 2017.140.3451.2 | 274360    | 23-Jun-22 | 05:22 | x64      |
| Txmulticast.dll                                             | 2017.140.3451.2 | 123816    | 23-Jun-22 | 05:22 | x64      |
| Txrowcount.dll                                              | 2017.140.3451.2 | 119736    | 23-Jun-22 | 05:22 | x64      |
| Txsort.dll                                                  | 2017.140.3451.2 | 255904    | 23-Jun-22 | 05:22 | x64      |
| Txsplit.dll                                                 | 2017.140.3451.2 | 590744    | 23-Jun-22 | 05:22 | x64      |
| Txunionall.dll                                              | 2017.140.3451.2 | 178080    | 23-Jun-22 | 05:22 | x64      |
| Xe.dll                                                      | 2017.140.3451.2 | 667552    | 23-Jun-22 | 05:22 | x64      |
| Xmlrw.dll                                                   | 2017.140.3451.2 | 299432    | 23-Jun-22 | 05:22 | x64      |
| Xmlsub.dll                                                  | 2017.140.3451.2 | 256400    | 23-Jun-22 | 05:22 | x64      |

SQL Server 2017 sql_extensibility

| File   name                   | File version    | File size | Date      | Time | Platform |
|-------------------------------|-----------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2017.140.3451.2 | 1127840   | 23-Jun-22 | 05:22 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3451.2 | 94648     | 23-Jun-22 | 05:20 | x64      |
| Sqlsatellite.dll              | 2017.140.3451.2 | 918416    | 23-Jun-22 | 05:22 | x64      |

SQL Server 2017 Full-Text Engine

| File   name              | File version    | File size | Date      | Time | Platform |
|--------------------------|-----------------|-----------|-----------|------|----------|
| Fd.dll                   | 2017.140.3451.2 | 666528    | 23-Jun-22 | 05:22 | x64      |
| Fdhost.exe               | 2017.140.3451.2 | 110512    | 23-Jun-22 | 05:22 | x64      |
| Fdlauncher.exe           | 2017.140.3451.2 | 58272     | 23-Jun-22 | 05:22 | x64      |
| Nlsdl.dll                | 6.0.6001.18000  | 46360     | 23-Jun-22 | 05:21 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3451.2 | 94648     | 23-Jun-22 | 05:20 | x64      |
| Sqlft140ph.dll           | 2017.140.3451.2 | 63912     | 23-Jun-22 | 05:22 | x64      |

SQL Server 2017 sql_inst_mr

| File   name             | File version    | File size | Date      | Time | Platform |
|-------------------------|-----------------|-----------|-----------|------|----------|
| Imrdll.dll              | 14.0.3451.2     | 18360     | 23-Jun-22 | 05:20 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3451.2 | 94648     | 23-Jun-22 | 05:20 | x64      |

SQL Server 2017 Integration Services

| File   name                                                   | File version    | File size | Date      | Time | Platform |
|---------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 23-Jun-22 | 04:57 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 23-Jun-22 | 05:20 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 23-Jun-22 | 04:57 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 23-Jun-22 | 05:20 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 23-Jun-22 | 04:57 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 23-Jun-22 | 05:20 | x86      |
| Commanddest.dll                                               | 2017.140.3451.2 | 194984    | 23-Jun-22 | 04:57 | x86      |
| Commanddest.dll                                               | 2017.140.3451.2 | 240048    | 23-Jun-22 | 05:20 | x64      |
| Dteparse.dll                                                  | 2017.140.3451.2 | 94616     | 23-Jun-22 | 04:57 | x86      |
| Dteparse.dll                                                  | 2017.140.3451.2 | 105400    | 23-Jun-22 | 05:20 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3451.2 | 77752     | 23-Jun-22 | 04:57 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3451.2 | 83360     | 23-Jun-22 | 05:20 | x64      |
| Dtepkg.dll                                                    | 2017.140.3451.2 | 111016    | 23-Jun-22 | 04:57 | x86      |
| Dtepkg.dll                                                    | 2017.140.3451.2 | 132000    | 23-Jun-22 | 05:20 | x64      |
| Dtexec.exe                                                    | 2017.140.3451.2 | 61856     | 23-Jun-22 | 04:57 | x86      |
| Dtexec.exe                                                    | 2017.140.3451.2 | 69048     | 23-Jun-22 | 05:20 | x64      |
| Dts.dll                                                       | 2017.140.3451.2 | 2545056   | 23-Jun-22 | 04:57 | x86      |
| Dts.dll                                                       | 2017.140.3451.2 | 2995128   | 23-Jun-22 | 05:20 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3451.2 | 412064    | 23-Jun-22 | 04:57 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3451.2 | 469408    | 23-Jun-22 | 05:20 | x64      |
| Dtsconn.dll                                                   | 2017.140.3451.2 | 396688    | 23-Jun-22 | 04:57 | x86      |
| Dtsconn.dll                                                   | 2017.140.3451.2 | 494496    | 23-Jun-22 | 05:20 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3451.2 | 89504     | 23-Jun-22 | 04:57 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3451.2 | 105896    | 23-Jun-22 | 05:20 | x64      |
| Dtshost.exe                                                   | 2017.140.3451.2 | 85432     | 23-Jun-22 | 04:58 | x86      |
| Dtshost.exe                                                   | 2017.140.3451.2 | 100280    | 23-Jun-22 | 05:22 | x64      |
| Dtslog.dll                                                    | 2017.140.3451.2 | 97192     | 23-Jun-22 | 04:57 | x86      |
| Dtslog.dll                                                    | 2017.140.3451.2 | 114592    | 23-Jun-22 | 05:20 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3451.2 | 535456    | 23-Jun-22 | 04:58 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3451.2 | 539552    | 23-Jun-22 | 05:22 | x64      |
| Dtspipeline.dll                                               | 2017.140.3451.2 | 1054624   | 23-Jun-22 | 04:57 | x86      |
| Dtspipeline.dll                                               | 2017.140.3451.2 | 1262480   | 23-Jun-22 | 05:20 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3451.2 | 36776     | 23-Jun-22 | 04:57 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3451.2 | 42384     | 23-Jun-22 | 05:20 | x64      |
| Dtuparse.dll                                                  | 2017.140.3451.2 | 74128     | 23-Jun-22 | 04:57 | x86      |
| Dtuparse.dll                                                  | 2017.140.3451.2 | 83360     | 23-Jun-22 | 05:20 | x64      |
| Dtutil.exe                                                    | 2017.140.3451.2 | 121768    | 23-Jun-22 | 04:57 | x86      |
| Dtutil.exe                                                    | 2017.140.3451.2 | 142768    | 23-Jun-22 | 05:20 | x64      |
| Exceldest.dll                                                 | 2017.140.3451.2 | 208800    | 23-Jun-22 | 04:57 | x86      |
| Exceldest.dll                                                 | 2017.140.3451.2 | 254888    | 23-Jun-22 | 05:20 | x64      |
| Excelsrc.dll                                                  | 2017.140.3451.2 | 224680    | 23-Jun-22 | 04:57 | x86      |
| Excelsrc.dll                                                  | 2017.140.3451.2 | 276904    | 23-Jun-22 | 05:20 | x64      |
| Execpackagetask.dll                                           | 2017.140.3451.2 | 129440    | 23-Jun-22 | 04:57 | x86      |
| Execpackagetask.dll                                           | 2017.140.3451.2 | 162232    | 23-Jun-22 | 05:20 | x64      |
| Flatfiledest.dll                                              | 2017.140.3451.2 | 326544    | 23-Jun-22 | 04:57 | x86      |
| Flatfiledest.dll                                              | 2017.140.3451.2 | 380840    | 23-Jun-22 | 05:20 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3451.2 | 338344    | 23-Jun-22 | 04:57 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3451.2 | 393656    | 23-Jun-22 | 05:20 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3451.2 | 74664     | 23-Jun-22 | 04:57 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3451.2 | 90552     | 23-Jun-22 | 05:20 | x64      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 23-Jun-22 | 04:58 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 23-Jun-22 | 04:58 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3451.2     | 461240    | 23-Jun-22 | 04:57 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3451.2     | 460704    | 23-Jun-22 | 05:20 | x64      |
| Isserverexec.exe                                              | 14.0.3451.2     | 143248    | 23-Jun-22 | 04:57 | x86      |
| Isserverexec.exe                                              | 14.0.3451.2     | 142752    | 23-Jun-22 | 05:20 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.90     | 1375120   | 23-Jun-22 | 04:57 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.90     | 1375120   | 23-Jun-22 | 05:21 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 23-Jun-22 | 05:10 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3451.2     | 106408    | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3451.2 | 101280    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3451.2 | 106400    | 23-Jun-22 | 05:21 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3451.2     | 49584     | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3451.2     | 49568     | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3451.2     | 83872     | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3451.2     | 83856     | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3451.2     | 67512     | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3451.2     | 67512     | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3451.2     | 508840    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3451.2     | 508840    | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3451.2     | 77712     | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3451.2     | 77736     | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3451.2     | 410016    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3451.2     | 410040    | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 14.0.3451.2     | 386472    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3451.2     | 608672    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3451.2     | 608680    | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3451.2     | 247200    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3451.2     | 247208    | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 14.0.3451.2     | 49064     | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 14.0.3451.2     | 49048     | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3451.2 | 136096    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3451.2 | 146336    | 23-Jun-22 | 05:21 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3451.2 | 139680    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3451.2 | 153504    | 23-Jun-22 | 05:21 | x64      |
| Msdtssrvr.exe                                                 | 14.0.3451.2     | 213920    | 23-Jun-22 | 05:21 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3451.2 | 84384     | 23-Jun-22 | 04:57 | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3451.2 | 97184     | 23-Jun-22 | 05:20 | x64      |
| Msmdpp.dll                                                    | 2017.140.249.90 | 9192848   | 23-Jun-22 | 05:22 | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 23-Jun-22 | 04:58 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 23-Jun-22 | 04:58 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 23-Jun-22 | 04:58 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 23-Jun-22 | 05:16 | x86      |
| Oledbdest.dll                                                 | 2017.140.3451.2 | 208800    | 23-Jun-22 | 04:57 | x86      |
| Oledbdest.dll                                                 | 2017.140.3451.2 | 255400    | 23-Jun-22 | 05:20 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3451.2 | 227240    | 23-Jun-22 | 04:57 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3451.2 | 283064    | 23-Jun-22 | 05:20 | x64      |
| Rawdest.dll                                                   | 2017.140.3451.2 | 160680    | 23-Jun-22 | 04:58 | x86      |
| Rawdest.dll                                                   | 2017.140.3451.2 | 200632    | 23-Jun-22 | 05:21 | x64      |
| Rawsource.dll                                                 | 2017.140.3451.2 | 147360    | 23-Jun-22 | 04:58 | x86      |
| Rawsource.dll                                                 | 2017.140.3451.2 | 188328    | 23-Jun-22 | 05:21 | x64      |
| Recordsetdest.dll                                             | 2017.140.3451.2 | 143264    | 23-Jun-22 | 04:58 | x86      |
| Recordsetdest.dll                                             | 2017.140.3451.2 | 183208    | 23-Jun-22 | 05:21 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3451.2 | 94648     | 23-Jun-22 | 05:20 | x64      |
| Sqlceip.exe                                                   | 14.0.3451.2     | 269208    | 23-Jun-22 | 05:10 | x86      |
| Sqldest.dll                                                   | 2017.140.3451.2 | 207776    | 23-Jun-22 | 04:58 | x86      |
| Sqldest.dll                                                   | 2017.140.3451.2 | 254880    | 23-Jun-22 | 05:21 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3451.2 | 149408    | 23-Jun-22 | 04:58 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3451.2 | 178080    | 23-Jun-22 | 05:21 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3451.2 | 170920    | 23-Jun-22 | 04:58 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3451.2 | 210360    | 23-Jun-22 | 05:21 | x64      |
| Txagg.dll                                                     | 2017.140.3451.2 | 296360    | 23-Jun-22 | 04:58 | x86      |
| Txagg.dll                                                     | 2017.140.3451.2 | 356256    | 23-Jun-22 | 05:21 | x64      |
| Txbdd.dll                                                     | 2017.140.3451.2 | 133544    | 23-Jun-22 | 04:58 | x86      |
| Txbdd.dll                                                     | 2017.140.3451.2 | 169384    | 23-Jun-22 | 05:21 | x64      |
| Txbestmatch.dll                                               | 2017.140.3451.2 | 487320    | 23-Jun-22 | 04:58 | x86      |
| Txbestmatch.dll                                               | 2017.140.3451.2 | 599440    | 23-Jun-22 | 05:21 | x64      |
| Txcache.dll                                                   | 2017.140.3451.2 | 140192    | 23-Jun-22 | 04:58 | x86      |
| Txcache.dll                                                   | 2017.140.3451.2 | 179112    | 23-Jun-22 | 05:21 | x64      |
| Txcharmap.dll                                                 | 2017.140.3451.2 | 243088    | 23-Jun-22 | 04:58 | x86      |
| Txcharmap.dll                                                 | 2017.140.3451.2 | 285624    | 23-Jun-22 | 05:21 | x64      |
| Txcopymap.dll                                                 | 2017.140.3451.2 | 139680    | 23-Jun-22 | 04:58 | x86      |
| Txcopymap.dll                                                 | 2017.140.3451.2 | 179128    | 23-Jun-22 | 05:21 | x64      |
| Txdataconvert.dll                                             | 2017.140.3451.2 | 247200    | 23-Jun-22 | 04:58 | x86      |
| Txdataconvert.dll                                             | 2017.140.3451.2 | 287136    | 23-Jun-22 | 05:22 | x64      |
| Txderived.dll                                                 | 2017.140.3451.2 | 509864    | 23-Jun-22 | 04:58 | x86      |
| Txderived.dll                                                 | 2017.140.3451.2 | 598440    | 23-Jun-22 | 05:22 | x64      |
| Txfileextractor.dll                                           | 2017.140.3451.2 | 155040    | 23-Jun-22 | 04:58 | x86      |
| Txfileextractor.dll                                           | 2017.140.3451.2 | 197560    | 23-Jun-22 | 05:22 | x64      |
| Txfileinserter.dll                                            | 2017.140.3451.2 | 153504    | 23-Jun-22 | 04:58 | x86      |
| Txfileinserter.dll                                            | 2017.140.3451.2 | 195504    | 23-Jun-22 | 05:22 | x64      |
| Txgroupdups.dll                                               | 2017.140.3451.2 | 225184    | 23-Jun-22 | 04:58 | x86      |
| Txgroupdups.dll                                               | 2017.140.3451.2 | 284576    | 23-Jun-22 | 05:22 | x64      |
| Txlineage.dll                                                 | 2017.140.3451.2 | 104352    | 23-Jun-22 | 04:58 | x86      |
| Txlineage.dll                                                 | 2017.140.3451.2 | 130984    | 23-Jun-22 | 05:22 | x64      |
| Txlookup.dll                                                  | 2017.140.3451.2 | 440728    | 23-Jun-22 | 04:58 | x86      |
| Txlookup.dll                                                  | 2017.140.3451.2 | 522144    | 23-Jun-22 | 05:22 | x64      |
| Txmerge.dll                                                   | 2017.140.3451.2 | 170912    | 23-Jun-22 | 04:58 | x86      |
| Txmerge.dll                                                   | 2017.140.3451.2 | 225704    | 23-Jun-22 | 05:22 | x64      |
| Txmergejoin.dll                                               | 2017.140.3451.2 | 215968    | 23-Jun-22 | 04:58 | x86      |
| Txmergejoin.dll                                               | 2017.140.3451.2 | 274360    | 23-Jun-22 | 05:22 | x64      |
| Txmulticast.dll                                               | 2017.140.3451.2 | 96672     | 23-Jun-22 | 04:58 | x86      |
| Txmulticast.dll                                               | 2017.140.3451.2 | 123816    | 23-Jun-22 | 05:22 | x64      |
| Txpivot.dll                                                   | 2017.140.3451.2 | 174496    | 23-Jun-22 | 04:58 | x86      |
| Txpivot.dll                                                   | 2017.140.3451.2 | 223648    | 23-Jun-22 | 05:22 | x64      |
| Txrowcount.dll                                                | 2017.140.3451.2 | 95648     | 23-Jun-22 | 04:58 | x86      |
| Txrowcount.dll                                                | 2017.140.3451.2 | 119736    | 23-Jun-22 | 05:22 | x64      |
| Txsampling.dll                                                | 2017.140.3451.2 | 129952    | 23-Jun-22 | 04:58 | x86      |
| Txsampling.dll                                                | 2017.140.3451.2 | 168352    | 23-Jun-22 | 05:22 | x64      |
| Txscd.dll                                                     | 2017.140.3451.2 | 164248    | 23-Jun-22 | 04:58 | x86      |
| Txscd.dll                                                     | 2017.140.3451.2 | 214968    | 23-Jun-22 | 05:22 | x64      |
| Txsort.dll                                                    | 2017.140.3451.2 | 202152    | 23-Jun-22 | 04:58 | x86      |
| Txsort.dll                                                    | 2017.140.3451.2 | 255904    | 23-Jun-22 | 05:22 | x64      |
| Txsplit.dll                                                   | 2017.140.3451.2 | 504736    | 23-Jun-22 | 04:58 | x86      |
| Txsplit.dll                                                   | 2017.140.3451.2 | 590744    | 23-Jun-22 | 05:22 | x64      |
| Txtermextraction.dll                                          | 2017.140.3451.2 | 8609192   | 23-Jun-22 | 04:58 | x86      |
| Txtermextraction.dll                                          | 2017.140.3451.2 | 8670624   | 23-Jun-22 | 05:22 | x64      |
| Txtermlookup.dll                                              | 2017.140.3451.2 | 4101032   | 23-Jun-22 | 04:58 | x86      |
| Txtermlookup.dll                                              | 2017.140.3451.2 | 4151216   | 23-Jun-22 | 05:22 | x64      |
| Txunionall.dll                                                | 2017.140.3451.2 | 133528    | 23-Jun-22 | 04:58 | x86      |
| Txunionall.dll                                                | 2017.140.3451.2 | 178080    | 23-Jun-22 | 05:22 | x64      |
| Txunpivot.dll                                                 | 2017.140.3451.2 | 154520    | 23-Jun-22 | 04:58 | x86      |
| Txunpivot.dll                                                 | 2017.140.3451.2 | 198584    | 23-Jun-22 | 05:22 | x64      |
| Xe.dll                                                        | 2017.140.3451.2 | 589736    | 23-Jun-22 | 05:00 | x86      |
| Xe.dll                                                        | 2017.140.3451.2 | 667552    | 23-Jun-22 | 05:22 | x64      |

SQL Server 2017 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|------|----------|
| Dms.dll                                                              | 13.0.9124.22     | 523848    | 23-Jun-22 | 05:08 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.22 | 78408     | 23-Jun-22 | 05:08 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.22     | 45640     | 23-Jun-22 | 05:08 | x86      |
| Instapi140.dll                                                       | 2017.140.3451.2  | 66472     | 23-Jun-22 | 05:08 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.22     | 74824     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.22     | 213576    | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.22     | 1799240   | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.22     | 116808    | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.22     | 390216    | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.22     | 196168    | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.22     | 131144    | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.22     | 63048     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.22     | 55368     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.22     | 93768     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.22     | 792648    | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.22     | 87624     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.22     | 77896     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.22     | 42056     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.22     | 36936     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.22     | 47688     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.22     | 27208     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.22     | 32328     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.22     | 129608    | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.22     | 95304     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.22     | 109128    | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.22     | 264264    | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 105032    | 23-Jun-22 | 05:07 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 119368    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 122440    | 23-Jun-22 | 04:56 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118856    | 23-Jun-22 | 05:06 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 129096    | 23-Jun-22 | 04:56 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 121416    | 23-Jun-22 | 05:16 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 116296    | 23-Jun-22 | 05:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 149576    | 23-Jun-22 | 04:56 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 102984    | 23-Jun-22 | 05:12 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118344    | 23-Jun-22 | 05:09 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.22     | 70216     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.22     | 28744     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.22     | 43592     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.22     | 83528     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.22     | 136776    | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.22     | 2340936   | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.22     | 3860040   | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 110664    | 23-Jun-22 | 05:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123464    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 128072    | 23-Jun-22 | 04:56 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123976    | 23-Jun-22 | 05:06 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 136776    | 23-Jun-22 | 04:56 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 124488    | 23-Jun-22 | 05:16 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 121416    | 23-Jun-22 | 05:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 156232    | 23-Jun-22 | 04:56 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 108616    | 23-Jun-22 | 05:12 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 122952    | 23-Jun-22 | 05:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.22     | 70216     | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.22     | 2756168   | 23-Jun-22 | 05:08 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.22     | 751688    | 23-Jun-22 | 05:08 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3451.2  | 401304    | 23-Jun-22 | 05:08 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3451.2  | 7324576   | 23-Jun-22 | 05:08 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3451.2  | 2259360   | 23-Jun-22 | 05:08 | x64      |
| Secforwarder.dll                                                     | 2017.140.3451.2  | 31656     | 23-Jun-22 | 05:08 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.22 | 64584     | 23-Jun-22 | 05:08 | x64      |
| Sqldk.dll                                                            | 2017.140.3451.2  | 2737080   | 23-Jun-22 | 05:08 | x64      |
| Sqldumper.exe                                                        | 2017.140.3451.2  | 139680    | 23-Jun-22 | 05:08 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3451.2  | 1500584   | 23-Jun-22 | 04:56 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3451.2  | 3920304   | 23-Jun-22 | 05:12 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3451.2  | 3218336   | 23-Jun-22 | 05:08 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3451.2  | 3922848   | 23-Jun-22 | 05:05 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3451.2  | 3826064   | 23-Jun-22 | 04:56 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3451.2  | 2093480   | 23-Jun-22 | 04:57 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3451.2  | 2039728   | 23-Jun-22 | 05:16 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3451.2  | 3593616   | 23-Jun-22 | 05:08 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3451.2  | 3601824   | 23-Jun-22 | 04:56 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3451.2  | 1447848   | 23-Jun-22 | 05:06 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3451.2  | 3790752   | 23-Jun-22 | 05:09 | x64      |
| Sqlos.dll                                                            | 2017.140.3451.2  | 20392     | 23-Jun-22 | 05:08 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.22 | 4347976   | 23-Jun-22 | 05:08 | x64      |
| Sqltses.dll                                                          | 2017.140.3451.2  | 9730488   | 23-Jun-22 | 05:08 | x64      |

SQL Server 2017 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Smrdll.dll                         | 14.0.3451.2     | 18352     | 23-Jun-22 | 05:21 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3451.2 | 94648     | 23-Jun-22 | 05:20 | x64      |

SQL Server 2017 sql_tools_extensions

| File   name                                                | File version    | File size | Date      | Time | Platform |
|------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                              | 2017.140.3451.2 | 1442720   | 23-Jun-22 | 04:58 | x86      |
| Dtaengine.exe                                              | 2017.140.3451.2 | 198576    | 23-Jun-22 | 04:57 | x86      |
| Dteparse.dll                                               | 2017.140.3451.2 | 94616     | 23-Jun-22 | 04:57 | x86      |
| Dteparse.dll                                               | 2017.140.3451.2 | 105400    | 23-Jun-22 | 05:20 | x64      |
| Dteparsemgd.dll                                            | 2017.140.3451.2 | 77752     | 23-Jun-22 | 04:57 | x86      |
| Dteparsemgd.dll                                            | 2017.140.3451.2 | 83360     | 23-Jun-22 | 05:20 | x64      |
| Dtepkg.dll                                                 | 2017.140.3451.2 | 111016    | 23-Jun-22 | 04:57 | x86      |
| Dtepkg.dll                                                 | 2017.140.3451.2 | 132000    | 23-Jun-22 | 05:20 | x64      |
| Dtexec.exe                                                 | 2017.140.3451.2 | 61856     | 23-Jun-22 | 04:57 | x86      |
| Dtexec.exe                                                 | 2017.140.3451.2 | 69048     | 23-Jun-22 | 05:20 | x64      |
| Dts.dll                                                    | 2017.140.3451.2 | 2545056   | 23-Jun-22 | 04:57 | x86      |
| Dts.dll                                                    | 2017.140.3451.2 | 2995128   | 23-Jun-22 | 05:20 | x64      |
| Dtscomexpreval.dll                                         | 2017.140.3451.2 | 412064    | 23-Jun-22 | 04:57 | x86      |
| Dtscomexpreval.dll                                         | 2017.140.3451.2 | 469408    | 23-Jun-22 | 05:20 | x64      |
| Dtsconn.dll                                                | 2017.140.3451.2 | 396688    | 23-Jun-22 | 04:57 | x86      |
| Dtsconn.dll                                                | 2017.140.3451.2 | 494496    | 23-Jun-22 | 05:20 | x64      |
| Dtshost.exe                                                | 2017.140.3451.2 | 85432     | 23-Jun-22 | 04:58 | x86      |
| Dtshost.exe                                                | 2017.140.3451.2 | 100280    | 23-Jun-22 | 05:22 | x64      |
| Dtslog.dll                                                 | 2017.140.3451.2 | 97192     | 23-Jun-22 | 04:57 | x86      |
| Dtslog.dll                                                 | 2017.140.3451.2 | 114592    | 23-Jun-22 | 05:20 | x64      |
| Dtsmsg140.dll                                              | 2017.140.3451.2 | 535456    | 23-Jun-22 | 04:58 | x86      |
| Dtsmsg140.dll                                              | 2017.140.3451.2 | 539552    | 23-Jun-22 | 05:22 | x64      |
| Dtspipeline.dll                                            | 2017.140.3451.2 | 1054624   | 23-Jun-22 | 04:57 | x86      |
| Dtspipeline.dll                                            | 2017.140.3451.2 | 1262480   | 23-Jun-22 | 05:20 | x64      |
| Dtspipelineperf140.dll                                     | 2017.140.3451.2 | 36776     | 23-Jun-22 | 04:57 | x86      |
| Dtspipelineperf140.dll                                     | 2017.140.3451.2 | 42384     | 23-Jun-22 | 05:20 | x64      |
| Dtuparse.dll                                               | 2017.140.3451.2 | 74128     | 23-Jun-22 | 04:57 | x86      |
| Dtuparse.dll                                               | 2017.140.3451.2 | 83360     | 23-Jun-22 | 05:20 | x64      |
| Dtutil.exe                                                 | 2017.140.3451.2 | 121768    | 23-Jun-22 | 04:57 | x86      |
| Dtutil.exe                                                 | 2017.140.3451.2 | 142768    | 23-Jun-22 | 05:20 | x64      |
| Exceldest.dll                                              | 2017.140.3451.2 | 208800    | 23-Jun-22 | 04:57 | x86      |
| Exceldest.dll                                              | 2017.140.3451.2 | 254888    | 23-Jun-22 | 05:20 | x64      |
| Excelsrc.dll                                               | 2017.140.3451.2 | 224680    | 23-Jun-22 | 04:57 | x86      |
| Excelsrc.dll                                               | 2017.140.3451.2 | 276904    | 23-Jun-22 | 05:20 | x64      |
| Flatfiledest.dll                                           | 2017.140.3451.2 | 326544    | 23-Jun-22 | 04:57 | x86      |
| Flatfiledest.dll                                           | 2017.140.3451.2 | 380840    | 23-Jun-22 | 05:20 | x64      |
| Flatfilesrc.dll                                            | 2017.140.3451.2 | 338344    | 23-Jun-22 | 04:57 | x86      |
| Flatfilesrc.dll                                            | 2017.140.3451.2 | 393656    | 23-Jun-22 | 05:20 | x64      |
| Foreachfileenumerator.dll                                  | 2017.140.3451.2 | 74664     | 23-Jun-22 | 04:57 | x86      |
| Foreachfileenumerator.dll                                  | 2017.140.3451.2 | 90552     | 23-Jun-22 | 05:20 | x64      |
| Microsoft.sqlserver.astasks.dll                            | 14.0.3451.2     | 106424    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.astasksui.dll                          | 14.0.3451.2     | 180648    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 14.0.3451.2     | 404384    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 14.0.3451.2     | 404384    | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 14.0.3451.2     | 2087840   | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 14.0.3451.2     | 2087824   | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.manageddts.dll                         | 14.0.3451.2     | 608672    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.manageddts.dll                         | 14.0.3451.2     | 608680    | 23-Jun-22 | 05:21 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll     | 14.0.3451.2     | 247200    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll | 14.0.3451.2     | 49064     | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll               | 2017.140.3451.2 | 136096    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll               | 2017.140.3451.2 | 146336    | 23-Jun-22 | 05:21 | x64      |
| Microsoft.sqlserver.xevent.dll                             | 2017.140.3451.2 | 139680    | 23-Jun-22 | 04:58 | x86      |
| Microsoft.sqlserver.xevent.dll                             | 2017.140.3451.2 | 153504    | 23-Jun-22 | 05:21 | x64      |
| Msdtssrvrutil.dll                                          | 2017.140.3451.2 | 84384     | 23-Jun-22 | 04:57 | x86      |
| Msdtssrvrutil.dll                                          | 2017.140.3451.2 | 97184     | 23-Jun-22 | 05:20 | x64      |
| Msmgdsrv.dll                                               | 2017.140.249.90 | 7305104   | 23-Jun-22 | 05:00 | x86      |
| Oledbdest.dll                                              | 2017.140.3451.2 | 208800    | 23-Jun-22 | 04:57 | x86      |
| Oledbdest.dll                                              | 2017.140.3451.2 | 255400    | 23-Jun-22 | 05:20 | x64      |
| Oledbsrc.dll                                               | 2017.140.3451.2 | 227240    | 23-Jun-22 | 04:57 | x86      |
| Oledbsrc.dll                                               | 2017.140.3451.2 | 283064    | 23-Jun-22 | 05:20 | x64      |
| Sql_tools_extensions_keyfile.dll                           | 2017.140.3451.2 | 94648     | 23-Jun-22 | 05:20 | x64      |
| Sqlresld.dll                                               | 2017.140.3451.2 | 22968     | 23-Jun-22 | 04:58 | x86      |
| Sqlresld.dll                                               | 2017.140.3451.2 | 25016     | 23-Jun-22 | 05:21 | x64      |
| Sqlresourceloader.dll                                      | 2017.140.3451.2 | 23480     | 23-Jun-22 | 04:58 | x86      |
| Sqlresourceloader.dll                                      | 2017.140.3451.2 | 26536     | 23-Jun-22 | 05:21 | x64      |
| Sqlscm.dll                                                 | 2017.140.3451.2 | 56224     | 23-Jun-22 | 04:58 | x86      |
| Sqlscm.dll                                                 | 2017.140.3451.2 | 66968     | 23-Jun-22 | 05:21 | x64      |
| Sqlsvc.dll                                                 | 2017.140.3451.2 | 129424    | 23-Jun-22 | 04:58 | x86      |
| Sqlsvc.dll                                                 | 2017.140.3451.2 | 157096    | 23-Jun-22 | 05:21 | x64      |
| Sqltaskconnections.dll                                     | 2017.140.3451.2 | 149408    | 23-Jun-22 | 04:58 | x86      |
| Sqltaskconnections.dll                                     | 2017.140.3451.2 | 178080    | 23-Jun-22 | 05:21 | x64      |
| Txdataconvert.dll                                          | 2017.140.3451.2 | 247200    | 23-Jun-22 | 04:58 | x86      |
| Txdataconvert.dll                                          | 2017.140.3451.2 | 287136    | 23-Jun-22 | 05:22 | x64      |
| Xe.dll                                                     | 2017.140.3451.2 | 589736    | 23-Jun-22 | 05:00 | x86      |
| Xe.dll                                                     | 2017.140.3451.2 | 667552    | 23-Jun-22 | 05:22 | x64      |
| Xmlrw.dll                                                  | 2017.140.3451.2 | 251792    | 23-Jun-22 | 05:00 | x86      |
| Xmlrw.dll                                                  | 2017.140.3451.2 | 299432    | 23-Jun-22 | 05:22 | x64      |
| Xmlrwbin.dll                                               | 2017.140.3451.2 | 183712    | 23-Jun-22 | 05:00 | x86      |
| Xmlrwbin.dll                                               | 2017.140.3451.2 | 218528    | 23-Jun-22 | 05:22 | x64      |

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2017.

</details>

<details>
<summary><b>Restart information</b></summary>

You might have to restart the computer after you apply this cumulative update package.

</details>

<details>
<summary><b>Registry information</b></summary>

To use one of the hotfixes in this package, you don't have to make any changes to the registry.

</details>

<details>
<summary><b>Important notices</b></summary>

This article also provides important information about the following situations:

- [**Pacemaker**](#pacemaker): A behavioral change is made in distributions that use the latest available version of Pacemaker. Mitigation methods are provided.

- [**Query Store**](#query-store): You must run this script if you use the Query Store and you have previously installed Microsoft SQL Server 2017 Cumulative Update 2 (CU2).

### Analysis Services CU build version

Beginning in Microsoft SQL Server 2017, the Analysis Services build version number and SQL Server Database Engine build version number don't match. For more information, see [Verify Analysis Services cumulative update build version](/sql/analysis-services/instances/analysis-services-component-version).

### Cumulative updates (CU)

Cumulative updates (CU) are now available at the Microsoft Download Center.

Only the most recent CU that was released for SQL Server 2017 is available at the Download Center.

CU packages for Linux are available at https://packages.microsoft.com/.

> [!NOTE]
> - Each new CU contains all the fixes that were included with the previous CU for the installed version of SQL Server.
> - SQL Server CUs are certified to the same levels as service packs, and should be installed at the same level of confidence.
>- We recommend ongoing, proactive installation of CUs as they become available according to these guidelines: </br>- Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU. </br>- CUs may contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
> - We recommend that you test SQL Server CUs before you deploy them to production environments.

</details>

<details>
<summary><b>Pacemaker notice</b></summary><a id="pacemaker"></a>

**IMPORTANT**

All distributions (including RHEL 7.3 and 7.4) that use the latest available **Pacemaker package 1.1.18-11.el7** introduce a behavior change for the `start-failure-is-fatal` cluster setting if its value is `false`. This change affects the failover workflow. If a primary replica experiences an outage, the cluster is expected to fail over to one of the available secondary replicas. Instead, users will notice that the cluster keeps trying to start the failed primary replica. If that primary never comes online (because of a permanent outage), the cluster never fails over to another available secondary replica.

This issue affects all SQL Server versions, regardless of the cumulative update version that they are on.

To mitigate the issue, use either of the following methods.

### Method 1

Follow these steps:

1. Remove the `start-failure-is-fatal` override from the existing cluster.

    \# RHEL, Ubuntu pcs property unset start-failure-is-fatal # or pcs property set start-failure-is-fatal=true # SLES crm configure property start-failure-is-fatal=true

1. Decrease the `cluster-recheck-interval` value.

    \# RHEL, Ubuntu pcs property set cluster-recheck-interval=\<Xmin> # SLES crm configure property cluster-recheck-interval=\<Xmin>

1. Add the `failure-timeout` meta property to each AG resource.

    \# RHEL, Ubuntu pcs resource update ag1 meta failure-timeout=60s # SLES crm configure edit ag1 # In the text editor, add \`meta failure-timeout=60s\` after any \`param\`s and before any \`op\`s

    > [!NOTE]
    > In this code, substitute the value for \<Xmin> as appropriate. If a replica goes down, the cluster tries to restart the replica at an interval that is bound by the `failure-timeout` value and the `cluster-recheck-interval` value. For example, if `failure-timeout` is set to 60 seconds and `cluster-recheck-interval` is set to 120 seconds, the restart is tried at an interval that is greater than 60 seconds but less than 120 seconds. We recommend that you set `failure-timeout` to `60s` and `cluster-recheck-interval` to a value that is greater than 60 seconds. We recommend that you do not set `cluster-recheck-interval` to a small value. For more information, refer to the Pacemaker documentation or consult the system provider.

### Method 2

Revert to Pacemaker version 1.1.16.

</details>

<details>
<summary><b>Query Store notice</b></summary><a id="query-store"></a>

**IMPORTANT**

You must run this script if you use Query Store and you're updating from SQL Server 2017 Cumulative Update 2 (CU2) directly to SQL Server 2017 Cumulative Update 3 (CU3) or any later cumulative update. You don't have to run this script if you have previously installed SQL Server 2017 Cumulative Update 3 (CU3) or any later SQL Server 2017 cumulative update.

```sql
SET NOCOUNT ON;
DROP TABLE IF EXISTS #tmpUserDBs;

SELECT [database_id], 0 AS [IsDone]
INTO #tmpUserDBs
FROM master.sys.databases
WHERE [database_id] > 4
 AND [state] = 0 -- must be ONLINE
 AND is_read_only = 0 -- cannot be READ_ONLY
 AND [database_id] NOT IN (SELECT dr.database_id FROM sys.dm_hadr_database_replica_states dr -- Except all local Always On secondary replicas
  INNER JOIN sys.dm_hadr_availability_replica_states rs ON dr.group_id = rs.group_id
  INNER JOIN sys.databases d ON dr.database_id = d.database_id
  WHERE rs.role = 2 -- Is Secondary
   AND dr.is_local = 1
   AND rs.is_local = 1)

DECLARE @userDB sysname;

WHILE (SELECT COUNT([database_id]) FROM #tmpUserDBs WHERE [IsDone] = 0) > 0
BEGIN
 SELECT TOP 1 @userDB = DB_NAME([database_id]) FROM #tmpUserDBs WHERE [IsDone] = 0

 -- PRINT 'Working on database ' + @userDB

 EXEC ('USE [' + @userDB + '];
DECLARE @clearPlan bigint, @clearQry bigint;
IF EXISTS (SELECT [actual_state] FROM sys.database_query_store_options WHERE [actual_state] IN (1,2))
BEGIN
 IF EXISTS (SELECT plan_id FROM sys.query_store_plan WHERE engine_version = ''14.0.3008.27'')
 BEGIN
  DROP TABLE IF EXISTS #tmpclearPlans;
  SELECT plan_id, query_id, 0 AS [IsDone]
  INTO #tmpclearPlans
  FROM sys.query_store_plan WHERE engine_version = ''14.0.3008.27''
  WHILE (SELECT COUNT(plan_id) FROM #tmpclearPlans WHERE [IsDone] = 0) > 0
  BEGIN
   SELECT TOP 1 @clearPlan = plan_id, @clearQry = query_id FROM #tmpclearPlans WHERE [IsDone] = 0
   EXECUTE sys.sp_query_store_unforce_plan @clearQry, @clearPlan;
   EXECUTE sys.sp_query_store_remove_plan @clearPlan;
   UPDATE #tmpclearPlans
   SET [IsDone] = 1
   WHERE plan_id = @clearPlan AND query_id = @clearQry
  END;
  PRINT ''- Cleared possibly affected plans in database [' + @userDB + ']''
 END
 ELSE
 BEGIN
  PRINT ''- No affected plans in database [' + @userDB + ']''
 END
END
ELSE
BEGIN
 PRINT ''- Query Store not enabled in database [' + @userDB + ']''
END')
  UPDATE #tmpUserDBs
  SET [IsDone] = 1
  WHERE [database_id] = DB_ID(@userDB)
END
```

</details>

<details>
<summary><b>Hybrid environment deployment</b></summary>

When you deploy an update to a hybrid environment (such as Always On, replication, cluster, and mirroring), we recommend that you refer to the following articles before you deploy the update:

- [Upgrade a failover cluster instance](/sql/sql-server/failover-clusters/windows/upgrade-a-sql-server-failover-cluster-instance)

> [!NOTE]
> If you don't want to use the rolling update process, follow these steps to apply an update:
>
> - Install the update on the passive node.
> - Install the update on the active node (requires a service restart).

- [Upgrade and update of availability group servers that use minimal downtime and data loss](/sql/database-engine/availability-groups/windows/upgrading-always-on-availability-group-replica-instances)

> [!NOTE]
> If you enabled Always On together with the **SSISDB** catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) about how to apply an update in these environments.

- [How to apply a hotfix for SQL Server in a transactional replication and database mirroring topology](../../database-engine/replication/install-service-packs-hotfixes.md)
- [How to apply a hotfix for SQL Server in a replication topology](../../database-engine/replication/apply-hotfix-sql-replication-topology.md)
- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances)
- [Overview of SQL Server Servicing Installation](https://technet.microsoft.com/library/dd638062.aspx)

</details>

<details>
<summary><b>Language support</b></summary>

SQL Server CUs are currently multilingual. Therefore, this CU package isn't specific to one language. It applies to all supported languages.

</details>

<details>
<summary><b>Components (features) updated</b></summary>

One CU package includes all available updates for all SQL Server 2017 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
</details>

## How to uninstall this update

<details>
<summary><b>How to uninstall this update on Windows</b></summary>

1. In Control Panel, open the **Programs and Features** item, and then select **View installed updates**.
1. Locate the entry that corresponds to this cumulative update package under **SQL Server 2017**.
1. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

<details>
<summary><b>How to uninstall this update on Linux</b></summary>

To uninstall this CU on Linux, you must roll back the package to the previous version. For more information about how to roll back the installation, see [Rollback SQL Server](/sql/linux/sql-server-linux-setup#rollback).

</details>

### Third-party information disclaimer

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [SQL Server Service Packs are no longer supported starting from SQL Server 2017](https://support.microsoft.com/topic/fd405dee-cae7-b40f-db14-01e3e4951169)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)

