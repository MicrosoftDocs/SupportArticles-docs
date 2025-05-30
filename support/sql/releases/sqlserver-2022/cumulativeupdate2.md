---
title: Cumulative update 2 for SQL Server 2022 (KB5023127)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 2 (KB5023127).
ms.date: 05/30/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5023127
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5023127 - Cumulative Update 2 for SQL Server 2022

_Release Date:_ &nbsp; March 15, 2023  
_Version:_ &nbsp; 16.0.4015.1

## Summary

This article describes Cumulative Update package 2 (CU2) for Microsoft SQL Server 2022. This update contains 13 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 1, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4015.1**, file version: **2022.160.4015.1**
- Analysis Services - Product version: **16.0.43.208**, file version: **2022.160.43.208**

## Known issues in this update

### Issue one

After you install this cumulative update, external data sources using generic ODBC connector may no longer work. When you try to query external tables that were created before installing this cumulative update, you receive the following error message:

> Msg 7320, Level 16, State 110, Line 68  
> Cannot execute the query "Remote Query" against OLE DB provider "MSOLEDBSQL" for linked server "(null)". Object reference not set to an instance of an object.

If you try to create a new external table, you receive the following error message:

> Msg 110813, Level 16, State 1, Line 64  
> Object reference not set to an instance of an object.

To work around this issue, you can uninstall this cumulative update or add the Driver keyword to the `CONNECTION_OPTIONS` argument. For more information, see [Generic ODBC external data sources may not work after installing Cumulative Update](https://techcommunity.microsoft.com/t5/sql-server-support-blog/generic-odbc-external-data-sources-may-not-work-after-installing/ba-p/3783873).

This issue is fixed in [SQL Server 2022 CU5](cumulativeupdate5.md#2398344).

### Issue two

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---------------|-------------|----------|-----------|----------|
| <a id="2043384">[2043384](#2043384)</a> | Fixes an issue where the **sqlcmd** utility doesn't honor the **sqlcmd** command "`:!!`" when you run operating system (OS) commands. For more information, see [sqlcmd commands](/sql/tools/sqlcmd/sqlcmd-utility#sqlcmd-commands). | SQL Server Client Tools | Command Line Tools | Windows |
| <a id="2232487">[2232487](#2232487)</a> | Starting in SQL Server 2022 CU2, `CREATE EXTERNAL DATA SOURCE` supports the use of TNS files when connecting to Oracle by using the `CONNECTION_OPTIONS` parameter. | SQL Server Engine | PolyBase | All |
| <a id="2217522">[2217522](#2217522)</a> | Fixes an issue where interleaved execution for multi-statement table-valued functions (MSTVFs) uses the `OPTIMIZE FOR` query hint value and returns an incorrect result on the first execution when the runtime constant value is different from the `OPTIMIZE FOR` query hint value. After you apply this fix, the interleaved execution will check the `OPTIMIZE FOR` query hint in all cases to avoid using the `OPTIMIZE FOR` query hint value on the first execution. | SQL Server Engine | Query Execution | All |
| <a id="2217553">[2217553](#2217553)</a> | Fixes a memory issue when a recursive graph query is aborted during execution. | SQL Server Engine | Query Execution | All |
| <a id="2231144">[2231144](#2231144)</a> | Fixes an issue that's caused by automatic parameterization of queries where interleaved execution of multi-statement table-valued functions (MSTVFs) may return incorrect results or cause a deadlock on the first execution. | SQL Server Engine | Query Optimizer | All |
| <a id="2217036">[2217036](#2217036)</a> | [FIX: sp_replmonitorsubscriptionpendingcmds returns incorrect pending commands for P2P replication (KB5017009)](https://support.microsoft.com/help/5017009) | SQL Server Engine | Replication | All |
| <a id="2119277">[2119277](#2119277)</a> | Fixes an issue where the full cleanup failure in the first side table and partial cleanup failure in others can cause incorrect syscommittab table cleanup in change tracking auto cleanup. This issue can leave orphaned records in the side tables. | SQL Server Engine | Replication | Windows |
| <a id="2163005">[2163005](#2163005)</a> | Fixes an issue where the `DataAccess` property for the linked server is reset to `False` when you execute the `sp_addsubscription` stored procedure or create a subscription through the New Subscription Wizard on server A after: </br></br>1. You have a linked server on server A for server B and have used the linked server for data access. </br>2. You configure server A as the Publisher and server B as the Subscriber and create transactional replication. | SQL Server Engine | Replication | All |
| <a id="2205260">[2205260](#2205260)</a> </br><a id="2216691">[2216691](#2216691)</a> </br><a id="2234321">[2234321](#2234321)</a> | Before the fix, you can still enable transactional replication or change data capture (CDC) and delayed durability on a database at the same time, even if transactional replication or CDC and delayed durability aren't compatible. This fix explicitly prevents you from enabling transactional replication or CDC and delayed durability on a database at the same time by returning the following error 22891 or 22892: </br></br>22891: Could not enable '\<FeatureName>' for database '\<DatabaseName>'. '\<FeatureName>' cannot be enabled on a DB with delayed durability set. </br></br>22892: Could not enable delayed durability on DB. Delayed durability cannot be enabled on a DB while '\<FeatureName>' is enabled. </br></br>For more information, see [Delayed durability and other SQL Server features](/sql/relational-databases/logs/control-transaction-durability#bkmk_OtherSQLFeatures). | SQL Server Engine | Replication | All |
| <a id="2223628">[2223628](#2223628)</a> | Fixes the incorrect primary key column indexing issue during the schema export phase of Azure Synapse Link replication. This issue occurs when you drop one or more columns that are in front of the primary key column of a table and then enable Azure Synapse Link replication for the table. | SQL Server Engine | Replication | Windows |
| <a id="2230926">[2230926](#2230926)</a> | [FIX: Error may occur when setting the SQL Server Agent job history log (KB5024352)](error-set-sql-server-agent-job-history-log.md) | SQL Server Engine | SQL Agent | Linux |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?id=105013)

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2022 CU release.
> - If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU2 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2023/03/sqlserver2022-kb5023127-x64_8773dc0f893badbbd32531e2e8cc7889ffcb7f54.exe)

> [!NOTE]
>
> - [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202022) contains this SQL Server 2022 CU and previously released SQL Server 2022 CU releases.
> - This CU is also available through Windows Server Update Services (WSUS).
> - We recommend that you always install the latest cumulative update that is available.

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2022 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2022 Release Notes](/sql/linux/sql-server-linux-release-notes-2022).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2022-KB5023127-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5023127-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5023127-x64.exe| 076E99DF447AC3F977F6ABB3D94874F5D75EE8C6EB1AD772FB1C874F5D17CA35 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

SQL Server 2022 Analysis Services

|                      File name                      |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                  | 2022.160.43.208 | 336808    | 27-Feb-23 | 16:20 | x64      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.208     | 2903472   | 27-Feb-23 | 16:20 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.108.3243.0    | 24480     | 27-Feb-23 | 16:20 | x86      |
| Microsoft.data.sqlclient.dll                        | 1.14.21068.1    | 1920960   | 27-Feb-23 | 16:20 | x86      |
| Microsoft.identity.client.dll                       | 4.14.0.0        | 1350048   | 27-Feb-23 | 16:20 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 5.6.0.61018     | 65952     | 27-Feb-23 | 16:20 | x86      |
| Microsoft.identitymodel.logging.dll                 | 5.6.0.61018     | 26528     | 27-Feb-23 | 16:20 | x86      |
| Microsoft.identitymodel.protocols.dll               | 5.6.0.61018     | 32192     | 27-Feb-23 | 16:20 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 5.6.0.61018     | 103328    | 27-Feb-23 | 16:20 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 5.6.0.61018     | 162720    | 27-Feb-23 | 16:20 | x86      |
| Msmdctr.dll                                         | 2022.160.43.208 | 38864     | 27-Feb-23 | 16:20 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.208 | 71755216  | 27-Feb-23 | 16:20 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.208 | 53920160  | 27-Feb-23 | 16:20 | x86      |
| Msmdpump.dll                                        | 2022.160.43.208 | 10335152  | 27-Feb-23 | 16:20 | x64      |
| Msmdredir.dll                                       | 2022.160.43.208 | 8132016   | 27-Feb-23 | 16:20 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.208 | 71308720  | 27-Feb-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 954832    | 27-Feb-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1882576   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1669584   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1878992   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1846224   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1145296   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1138128   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1767376   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1746896   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 930768    | 27-Feb-23 | 16:20 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.208 | 1835472   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 953296    | 27-Feb-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1880528   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1666512   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1874384   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1842640   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1143248   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1136584   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1763792   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1743312   | 27-Feb-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 931280    | 27-Feb-23 | 16:20 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.208 | 1830864   | 27-Feb-23 | 16:20 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.208 | 10083760  | 27-Feb-23 | 16:20 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.208 | 8265648   | 27-Feb-23 | 16:20 | x86      |
| Msolap.dll                                          | 2022.160.43.208 | 10970016  | 27-Feb-23 | 16:20 | x64      |
| Msolap.dll                                          | 2022.160.43.208 | 8744864   | 27-Feb-23 | 16:20 | x86      |
| Msolui.dll                                          | 2022.160.43.208 | 289696    | 27-Feb-23 | 16:20 | x86      |
| Msolui.dll                                          | 2022.160.43.208 | 308144    | 27-Feb-23 | 16:20 | x64      |
| Newtonsoft.json.dll                                 | 13.0.1.25517    | 704448    | 27-Feb-23 | 16:20 | x86      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 27-Feb-23 | 16:20 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4015.1 | 137168    | 27-Feb-23 | 16:19 | x64      |
| Sqlceip.exe                                         | 16.0.4015.1     | 300960    | 27-Feb-23 | 16:20 | x86      |
| Sqldumper.exe                                       | 2022.160.4015.1 | 227280    | 27-Feb-23 | 16:20 | x86      |
| Sqldumper.exe                                       | 2022.160.4015.1 | 260000    | 27-Feb-23 | 16:20 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 5.6.0.61018     | 83872     | 27-Feb-23 | 16:20 | x86      |
| Tmapi.dll                                           | 2022.160.43.208 | 5884336   | 27-Feb-23 | 16:20 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.208 | 5575120   | 27-Feb-23 | 16:20 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.208 | 1481136   | 27-Feb-23 | 16:20 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.208 | 7197648   | 27-Feb-23 | 16:20 | x64      |
| Xmsrv.dll                                           | 2022.160.43.208 | 26594224  | 27-Feb-23 | 16:20 | x64      |
| Xmsrv.dll                                           | 2022.160.43.208 | 35895712  | 27-Feb-23 | 16:20 | x86      |

SQL Server 2022 Database Services Common Core

|                   File   name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4015.1 | 104352    | 27-Feb-23 | 16:20 | x64      |
| Instapi150.dll                             | 2022.160.4015.1 | 79776     | 27-Feb-23 | 16:20 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.208     | 2633680   | 27-Feb-23 | 16:19 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.208     | 2633672   | 27-Feb-23 | 16:20 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.208     | 2933152   | 27-Feb-23 | 16:20 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.208     | 2323360   | 27-Feb-23 | 16:20 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.208     | 2323408   | 27-Feb-23 | 16:20 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4015.1     | 554960    | 27-Feb-23 | 16:20 | x86      |
| Msasxpress.dll                             | 2022.160.43.208 | 27600     | 27-Feb-23 | 16:20 | x86      |
| Msasxpress.dll                             | 2022.160.43.208 | 32672     | 27-Feb-23 | 16:20 | x64      |
| Sql_common_core_keyfile.dll                | 2022.160.4015.1 | 137168    | 27-Feb-23 | 16:19 | x64      |
| Sqldumper.exe                              | 2022.160.4015.1 | 227280    | 27-Feb-23 | 16:20 | x86      |
| Sqldumper.exe                              | 2022.160.4015.1 | 260000    | 27-Feb-23 | 16:20 | x64      |

SQL Server 2022 Data Quality

|          File   name      | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4015.1  | 599968    | 27-Feb-23 | 16:20 | x86      |
| Microsoft.ssdqs.core.dll  | 16.0.4015.1  | 600016    | 27-Feb-23 | 16:20 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4015.1  | 173984    | 27-Feb-23 | 16:20 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4015.1  | 1857440   | 27-Feb-23 | 16:20 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4015.1  | 370632    | 27-Feb-23 | 16:20 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4015.1  | 370640    | 27-Feb-23 | 16:20 | x86      |

SQL Server 2022 Database Services Core Instance

|                    File   name               |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                   | 2022.160.4015.1 | 4719056   | 27-Feb-23 | 17:52 | x64      |
| Aetm-enclave.dll                             | 2022.160.4015.1 | 4673464   | 27-Feb-23 | 17:52 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4015.1 | 4909136   | 27-Feb-23 | 17:52 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4015.1 | 4874464   | 27-Feb-23 | 17:52 | x64      |
| Hadrres.dll                                  | 2022.160.4015.1 | 227280    | 27-Feb-23 | 17:52 | x64      |
| Hkcompile.dll                                | 2022.160.4015.1 | 1411024   | 27-Feb-23 | 17:52 | x64      |
| Hkengine.dll                                 | 2022.160.4015.1 | 5760928   | 27-Feb-23 | 17:52 | x64      |
| Hkruntime.dll                                | 2022.160.4015.1 | 190416    | 27-Feb-23 | 17:52 | x64      |
| Hktempdb.dll                                 | 2022.160.4015.1 | 71632     | 27-Feb-23 | 17:52 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.208     | 2322336   | 27-Feb-23 | 17:52 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4015.1 | 333776    | 27-Feb-23 | 17:52 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4015.1 | 96160     | 27-Feb-23 | 17:52 | x64      |
| `Odsole70.rll`                                 | 16.0.4015.1     | 30624     | 27-Feb-23 | 17:52 | x64      |
| `Odsole70.rll`                                 | 16.0.4015.1     | 38816     | 27-Feb-23 | 17:52 | x64      |
| `Odsole70.rll`                                 | 16.0.4015.1     | 34768     | 27-Feb-23 | 17:52 | x64      |
| `Odsole70.rll`                                 | 16.0.4015.1     | 38816     | 27-Feb-23 | 17:52 | x64      |
| `Odsole70.rll`                                 | 16.0.4015.1     | 38816     | 27-Feb-23 | 17:52 | x64      |
| `Odsole70.rll`                                 | 16.0.4015.1     | 30624     | 27-Feb-23 | 17:52 | x64      |
| `Odsole70.rll`                                 | 16.0.4015.1     | 30672     | 27-Feb-23 | 17:52 | x64      |
| `Odsole70.rll`                                 | 16.0.4015.1     | 34720     | 27-Feb-23 | 17:52 | x64      |
| `Odsole70.rll`                                 | 16.0.4015.1     | 38816     | 27-Feb-23 | 17:52 | x64      |
| `Odsole70.rll`                                 | 16.0.4015.1     | 30624     | 27-Feb-23 | 17:52 | x64      |
| `Odsole70.rll`                                 | 16.0.4015.1     | 38816     | 27-Feb-23 | 17:52 | x64      |
| Qds.dll                                      | 2022.160.4015.1 | 1779616   | 27-Feb-23 | 17:52 | x64      |
| Rsfxft.dll                                   | 2022.160.4015.1 | 55200     | 27-Feb-23 | 17:52 | x64      |
| Secforwarder.dll                             | 2022.160.4015.1 | 83872     | 27-Feb-23 | 17:52 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4015.1 | 137168    | 27-Feb-23 | 17:52 | x64      |
| Sqlaccess.dll                                | 2022.160.4015.1 | 444320    | 27-Feb-23 | 17:52 | x64      |
| Sqlagent.exe                                 | 2022.160.4015.1 | 726992    | 27-Feb-23 | 17:52 | x64      |
| Sqlceip.exe                                  | 16.0.4015.1     | 300960    | 27-Feb-23 | 17:52 | x86      |
| Sqlctr160.dll                                | 2022.160.4015.1 | 128928    | 27-Feb-23 | 17:52 | x86      |
| Sqlctr160.dll                                | 2022.160.4015.1 | 157648    | 27-Feb-23 | 17:52 | x64      |
| Sqldk.dll                                    | 2022.160.4015.1 | 4028368   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 1746848   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 3839904   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 4056992   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 4564896   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 4695968   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 3741600   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 3930016   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 4564896   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 4396960   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 4466592   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 2439072   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 2381728   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 4253600   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 3889056   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 4405152   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 4196256   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 4179872   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 3966880   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 3844000   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 1685408   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 4290464   | 27-Feb-23 | 17:52 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4015.1 | 4429728   | 27-Feb-23 | 17:52 | x64      |
| Sqllang.dll                                  | 2022.160.4015.1 | 48568224  | 27-Feb-23 | 17:52 | x64      |
| Sqlmin.dll                                   | 2022.160.4015.1 | 51316640  | 27-Feb-23 | 17:52 | x64      |
| Sqlos.dll                                    | 2022.160.4015.1 | 51152     | 27-Feb-23 | 17:52 | x64      |
| Sqlrepss.dll                                 | 2022.160.4015.1 | 137120    | 27-Feb-23 | 17:52 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4015.1 | 51104     | 27-Feb-23 | 17:52 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4015.1 | 5830608   | 27-Feb-23 | 17:52 | x64      |
| Sqlservr.exe                                 | 2022.160.4015.1 | 722848    | 27-Feb-23 | 17:52 | x64      |
| Sqltses.dll                                  | 2022.160.4015.1 | 9390024   | 27-Feb-23 | 17:52 | x64      |
| Sqsrvres.dll                                 | 2022.160.4015.1 | 305104    | 27-Feb-23 | 17:52 | x64      |
| Svl.dll                                      | 2022.160.4015.1 | 247712    | 27-Feb-23 | 17:52 | x64      |
| Xe.dll                                       | 2022.160.4015.1 | 718800    | 27-Feb-23 | 17:52 | x64      |
| Xpstar.dll                                   | 2022.160.4015.1 | 534432    | 27-Feb-23 | 17:52 | x64      |

SQL Server 2022 Database Services Core Shared

|                        File   name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Distrib.exe                                          | 2022.160.4015.1 | 268240    | 27-Feb-23 | 16:21 | x64      |
| Logread.exe                                          | 2022.160.4015.1 | 788384    | 27-Feb-23 | 16:21 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.208     | 2933680   | 27-Feb-23 | 16:21 | x86      |
| Microsoft.data.sqlclient.dll                         | 3.10.22089.1    | 2032120   | 27-Feb-23 | 16:20 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4015.1     | 30624     | 27-Feb-23 | 16:20 | x86      |
| Microsoft.identity.client.dll                        | 4.36.1.0        | 1503672   | 27-Feb-23 | 16:20 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 5.5.0.60624     | 66096     | 27-Feb-23 | 16:20 | x86      |
| Microsoft.identitymodel.logging.dll                  | 5.5.0.60624     | 32296     | 27-Feb-23 | 16:20 | x86      |
| Microsoft.identitymodel.protocols.dll                | 5.5.0.60624     | 37416     | 27-Feb-23 | 16:20 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 5.5.0.60624     | 109096    | 27-Feb-23 | 16:20 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 5.5.0.60624     | 167672    | 27-Feb-23 | 16:21 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4015.1 | 1714128   | 27-Feb-23 | 16:21 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4015.1     | 554960    | 27-Feb-23 | 16:21 | x86      |
| Msgprox.dll                                          | 2022.160.4015.1 | 313248    | 27-Feb-23 | 16:21 | x64      |
| Msoledbsql.dll                                       | 2018.186.4.0    | 2734072   | 27-Feb-23 | 16:20 | x64      |
| Msoledbsql.dll                                       | 2018.186.4.0    | 153584    | 27-Feb-23 | 16:20 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517    | 704408    | 27-Feb-23 | 16:21 | x86      |
| Qrdrsvc.exe                                          | 2022.160.4015.1 | 530336    | 27-Feb-23 | 16:21 | x64      |
| Rdistcom.dll                                         | 2022.160.4015.1 | 939984    | 27-Feb-23 | 16:21 | x64      |
| Repldp.dll                                           | 2022.160.4015.1 | 337864    | 27-Feb-23 | 16:21 | x64      |
| Replisapi.dll                                        | 2022.160.4015.1 | 419792    | 27-Feb-23 | 16:21 | x64      |
| Replmerg.exe                                         | 2022.160.4015.1 | 604112    | 27-Feb-23 | 16:21 | x64      |
| Replprov.dll                                         | 2022.160.4015.1 | 890784    | 27-Feb-23 | 16:21 | x64      |
| Replrec.dll                                          | 2022.160.4015.1 | 1058720   | 27-Feb-23 | 16:21 | x64      |
| Replsub.dll                                          | 2022.160.4015.1 | 501712    | 27-Feb-23 | 16:21 | x64      |
| Spresolv.dll                                         | 2022.160.4015.1 | 301008    | 27-Feb-23 | 16:21 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4015.1 | 137168    | 27-Feb-23 | 16:20 | x64      |
| Sqlcmd.exe                                           | 2022.160.4015.1 | 276432    | 27-Feb-23 | 16:21 | x64      |
| Sqldistx.dll                                         | 2022.160.4015.1 | 268240    | 27-Feb-23 | 16:21 | x64      |
| Sqlmergx.dll                                         | 2022.160.4015.1 | 423888    | 27-Feb-23 | 16:21 | x64      |
| Xe.dll                                               | 2022.160.4015.1 | 718800    | 27-Feb-23 | 16:21 | x64      |

SQL Server 2022 sql_extensibility

|            File   name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4015.1 | 100304    | 27-Feb-23 | 16:20 | x64      |
| Exthost.exe                   | 2022.160.4015.1 | 247712    | 27-Feb-23 | 16:20 | x64      |
| Launchpad.exe                 | 2022.160.4015.1 | 1361872   | 27-Feb-23 | 16:20 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4015.1 | 137168    | 27-Feb-23 | 16:20 | x64      |
| Sqlsatellite.dll              | 2022.160.4015.1 | 1165216   | 27-Feb-23 | 16:20 | x64      |

SQL Server 2022 Full-Text Engine

|          File   name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4015.1 | 710608    | 27-Feb-23 | 16:20 | x64      |
| Fdhost.exe               | 2022.160.4015.1 | 153504    | 27-Feb-23 | 16:20 | x64      |
| Fdlauncher.exe           | 2022.160.4015.1 | 100304    | 27-Feb-23 | 16:20 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4015.1 | 137168    | 27-Feb-23 | 16:19 | x64      |

SQL Server 2022 Integration Services

|                            File   name                        |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 79176     | 27-Feb-23 | 16:23 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 79176     | 27-Feb-23 | 16:23 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 40312     | 27-Feb-23 | 16:23 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 40312     | 27-Feb-23 | 16:23 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 80728     | 27-Feb-23 | 16:23 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 80728     | 27-Feb-23 | 16:23 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4015.1     | 120776    | 27-Feb-23 | 16:22 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4015.1     | 120736    | 27-Feb-23 | 16:22 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.208     | 2933664   | 27-Feb-23 | 16:22 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.208     | 2933680   | 27-Feb-23 | 16:22 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4015.1     | 509856    | 27-Feb-23 | 16:22 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4015.1     | 219040    | 27-Feb-23 | 16:22 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.208 | 10165664  | 27-Feb-23 | 16:22 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 27-Feb-23 | 16:22 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 27-Feb-23 | 16:22 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 27-Feb-23 | 16:23 | x86      |
| Sql_is_keyfile.dll                                            | 2022.160.4015.1 | 137168    | 27-Feb-23 | 16:22 | x64      |
| Sqlceip.exe                                                   | 16.0.4015.1     | 300960    | 27-Feb-23 | 16:22 | x86      |
| Xe.dll                                                        | 2022.160.4015.1 | 718800    | 27-Feb-23 | 16:22 | x64      |
| Xe.dll                                                        | 2022.160.4015.1 | 640976    | 27-Feb-23 | 16:23 | x86      |

SQL Server 2022 sql_polybase_core_inst

|                                File   name                           |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1020.0     | 559576    | 27-Feb-23 | 17:34 | x86      |
| Dmsnative.dll                                                        | 2022.160.1020.0 | 152536    | 27-Feb-23 | 17:34 | x64      |
| Dwengineservice.dll                                                  | 16.0.1020.0     | 44976     | 27-Feb-23 | 17:34 | x86      |
| Instapi150.dll                                                       | 2022.160.4015.1 | 104352    | 27-Feb-23 | 17:34 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1020.0     | 67544     | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1020.0     | 293336    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1020.0     | 1956824   | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1020.0     | 169400    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1020.0     | 646616    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1020.0     | 246232    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1020.0     | 139184    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1020.0     | 79792     | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1020.0     | 51120     | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1020.0     | 88536     | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1020.0     | 1129432   | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1020.0     | 80816     | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1020.0     | 70576     | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1020.0     | 35288     | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1020.0     | 30648     | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1020.0     | 46504     | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1020.0     | 21424     | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1020.0     | 26584     | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1020.0     | 131544    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1020.0     | 86488     | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1020.0     | 100784    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1020.0     | 292792    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1020.0     | 120280    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1020.0     | 138160    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1020.0     | 141240    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1020.0     | 137648    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1020.0     | 150456    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1020.0     | 139696    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1020.0     | 134616    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1020.0     | 176568    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1020.0     | 117168    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1020.0     | 136632    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1020.0     | 72664     | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1020.0     | 21944     | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1020.0     | 37296     | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1020.0     | 128952    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1020.0     | 3064752   | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1020.0     | 3955672   | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1020.0     | 118192    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1020.0     | 133040    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1020.0     | 137648    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1020.0     | 133552    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1020.0     | 148440    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1020.0     | 134064    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1020.0     | 130480    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1020.0     | 170928    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1020.0     | 115120    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1020.0     | 132056    | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1020.0     | 67504     | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1020.0     | 2682808   | 27-Feb-23 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1020.0     | 2436568   | 27-Feb-23 | 17:34 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4015.1 | 296864    | 27-Feb-23 | 17:34 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4015.1 | 7817120   | 27-Feb-23 | 17:34 | x64      |
| Secforwarder.dll                                                     | 2022.160.4015.1 | 83872     | 27-Feb-23 | 17:34 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1020.0 | 61360     | 27-Feb-23 | 17:34 | x64      |
| Sqldk.dll                                                            | 2022.160.4015.1 | 4028368   | 27-Feb-23 | 17:34 | x64      |
| Sqldumper.exe                                                        | 2022.160.4015.1 | 260000    | 27-Feb-23 | 17:34 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4015.1 | 1746848   | 27-Feb-23 | 17:34 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4015.1 | 4564896   | 27-Feb-23 | 17:34 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4015.1 | 3741600   | 27-Feb-23 | 17:34 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4015.1 | 4564896   | 27-Feb-23 | 17:34 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4015.1 | 4466592   | 27-Feb-23 | 17:34 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4015.1 | 2439072   | 27-Feb-23 | 17:34 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4015.1 | 2381728   | 27-Feb-23 | 17:34 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4015.1 | 4196256   | 27-Feb-23 | 17:34 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4015.1 | 4179872   | 27-Feb-23 | 17:34 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4015.1 | 1685408   | 27-Feb-23 | 17:34 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4015.1 | 4429728   | 27-Feb-23 | 17:34 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.3.1   | 1898432   | 27-Feb-23 | 17:34 | x64      |
| Sqlos.dll                                                            | 2022.160.4015.1 | 51152     | 27-Feb-23 | 17:34 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1020.0 | 4841392   | 27-Feb-23 | 17:34 | x64      |
| Sqltses.dll                                                          | 2022.160.4015.1 | 9390024   | 27-Feb-23 | 17:34 | x64      |

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2022.

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

This article also provides the following important information.

### Analysis Services CU build version

Beginning in Microsoft SQL Server 2017, the Analysis Services build version number and SQL Server Database Engine build version number don't match. For more information, see [Verify Analysis Services cumulative update build version](/sql/analysis-services/instances/analysis-services-component-version).

### Cumulative updates (CU)

- Each new CU contains all the fixes that were included with the previous CU for the installed version of SQL Server.
- SQL Server CUs are certified to the same levels as service packs, and should be installed at the same level of confidence.
- We recommend ongoing, proactive installation of CUs as they become available according to these guidelines:
  - Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU.
  - CUs may contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
- We recommend that you test SQL Server CUs before you deploy them to production environments.

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

SQL Server CUs are currently multilingual. Therefore, this CU package isn't specific to one language. It applies to all supported languages.

</details>

<details>
<summary><b>Components (features) updated</b></summary>

One CU package includes all available updates for all SQL Server 2022 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
</details>

## How to uninstall this update

<details>
<summary><b>How to uninstall this update on Windows</b></summary>

1. In Control Panel, open the **Programs and Features** item, and then select **View installed updates**.
1. Locate the entry that corresponds to this cumulative update package under **SQL Server 2022**.
1. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

<details>
<summary><b>How to uninstall this update on Linux</b></summary>

To uninstall this CU on Linux, you must roll back the package to the previous version. For more information about how to roll back the installation, see [Rollback SQL Server](/sql/linux/sql-server-linux-setup#rollback).

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [SQL Server Service Packs are no longer supported starting from SQL Server 2017](https://support.microsoft.com/topic/fd405dee-cae7-b40f-db14-01e3e4951169)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
