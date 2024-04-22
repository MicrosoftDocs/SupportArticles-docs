---
title: Cumulative update 18 for SQL Server 2017 (KB4527377)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 18 (KB4527377).
ms.date: 08/04/2023
ms.custom: KB4527377, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4527377 - Cumulative Update 18 for SQL Server 2017

_Release Date:_ &nbsp; December 9, 2019  
_Version:_ &nbsp; 14.0.3257.3

## Summary

This article describes Cumulative Update package 18 (CU18) for Microsoft SQL Server 2017. This update contains 29 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 17, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3257.3**, file version: **2017.140.3257.3**
- Analysis Services - Product version: **14.0.249.21**, file version: **2017.140.249.21**

## Known issues in this update

There are no known issues with this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with other people so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|-------------------------------------------|----------|
| <a id=13212803>[13212803](#13212803) </a> | [FIX: User hierarchy is not hidden when you run DISCOVER_CSDL_METADATA in SQL Server 2017 (KB4527510)](https://support.microsoft.com/help/4527510) | Analysis Services | Analysis Services | Windows |
| <a id=13197357>[13197357](#13197357) </a> | [FIX: Menu and scroll bar are missing in "Changes" section when large number of changesets are added in Excel add-in for MDS in SQL Server 2017 (KB4524191)](https://support.microsoft.com/help/4524191) | Master Data Services | Client | Windows |
| <a id=13198907>[13198907](#13198907) </a> | [FIX: Different users get the same model list with different permissions in SQL Server 2016 and 2017 (KB4519679)](https://support.microsoft.com/help/4519679) | Master Data Services | Client | Windows |
| <a id=13201028>[13201028](#13201028) </a> | [FIX: Restore fails when you try to restore compressed TDE backups prior to SQL Server 2016 SP2 CU4 on SQL Server 2016 SP2 CU8 (KB4529942)](https://support.microsoft.com/help/4529942) | SQL Server Engine | Backup Restore | Windows |
| <a id=13087323>[13087323](#13087323) </a> | [FIX: Concurrent inserts into a CCI can cause deadlock under memory pressure in SQL Server 2016 and 2017 (KB4506912)](https://support.microsoft.com/help/4506912) | SQL Server Engine | Column Stores | Windows |
| <a id=13224871>[13224871](#13224871) </a> | [FIX: "The File location cannot be opened" error occurs when you try to open a FileTable directory in SQL Server (KB4530720)](https://support.microsoft.com/help/4530720) | SQL Server Engine | FileStream and FileTable | Windows |
| <a id=12519856>[12519856](#12519856) </a> | [FIX: Error 41168 occurs when you try to alter DAG SEEDING_MODE in SQL Server 2016 and 2017 (KB4470057)](https://support.microsoft.com/help/4470057)| SQL Server Engine| High Availability and Disaster Recovery | Windows |
| <a id=13198909>[13198909](#13198909) </a> | [FIX: Transaction log isn't truncated on a single node Availability Group in SQL Server (KB4515772)](https://support.microsoft.com/help/4515772)| SQL Server Engine| High Availability and Disaster Recovery | Windows |
| <a id=13207342>[13207342](#13207342) </a> | [FIX: Access violation occurs when you restore the In-Memory Optimized database in SQL Server 2016 and 2017 (KB4528130)](https://support.microsoft.com/help/4528130)| SQL Server Engine| In-Memory OLTP | Windows |
| <a id=13354946>[13354946](#13354946) </a> | [FIX: Connection error occurs when you try to connect SQL Server 2017 on Linux by using OpenSSL 1.1 (KB4548001)](https://support.microsoft.com/help/4548001) | SQL Server Engine | Linux | Linux |
| <a id=13159453>[13159453](#13159453) </a> | [FIX: UPDATE STATISTICS takes very long time to generate maintenance plan for large databases in SQL Server 2016 and 2017 (KB4527229)](https://support.microsoft.com/help/4527229) | SQL Server Engine | Management Services | Windows |
| <a id=13210153>[13210153](#13210153) </a> | [FIX: You may receive incorrect object_id after you switch a partition in SQL Server 2017 (KB4527916)](https://support.microsoft.com/help/4527916) | SQL Server Engine | Methods to access stored data | Windows |
| <a id=13211437>[13211437](#13211437) </a> | [FIX: Exception error 3628 may occur when you run store procedure in SQL Server 2016 and 2017 (KB4525483)](https://support.microsoft.com/help/4525483) | SQL Server Engine | Methods to access stored data | Windows |
| <a id=13198915>[13198915](#13198915) </a> | [FIX: Orphaned CLR sessions cause blocking in SQL Server (KB4517771)](https://support.microsoft.com/help/4517771) | SQL Server Engine | Programmability | Windows |
| <a id=13203071>[13203071](#13203071) </a> | [FIX: .NET Framework DbDataAdapter.FillSchema method returns NULL on database with compatibility level 140 in SQL Server 2017 (KB4529927)](https://support.microsoft.com/help/4529927) | SQL Server Engine | Programmability | Windows |
| <a id=13165622>[13165622](#13165622) </a> | [FIX: Access violation occurs when you use sys.dm_os_memory_objects in SQL Server 2016 and 2017 (KB4530212)](https://support.microsoft.com/help/4530212) | SQL Server Engine | Query Execution | Linux|
| <a id=13197185>[13197185](#13197185) </a> | [FIX: "A system assertion check has failed" error when a procedure call is made from CLR with an OUTPUT large object argument (KB4527538)](https://support.microsoft.com/help/4527538) | SQL Server Engine | Query Execution | Windows |
| <a id=13198726>[13198726](#13198726) </a> | [FIX: Error 8601 occurs when you run a query with partition function in SQL Server (KB4530251)](https://support.microsoft.com/help/4530251) | SQL Server Engine| Query Execution | Windows|
| <a id=13212298>[13212298](#13212298) </a> | [FIX: An access violation may occur when the optimizer uses an Adaptive Join in SQL Server 2017 (KB4531009)](https://support.microsoft.com/help/4531009) | SQL Server Engine | Query Optimizer | Windows |
| <a id=12110364>[12110364](#12110364) </a> | [Improvement: Snapshot replication and transactional replication are enabled on Linux in SQL Server 2017 (KB4532751)](https://support.microsoft.com/help/4532751) | SQL Server Engine | Replication | Linux |
| <a id=13200683>[13200683](#13200683) </a> | [FIX: Error occurs when CDC capture process tries to insert duplicate key in table "cdc.lsn_time_mapping" in SQL Server 2016 and 2017 (KB4521739)](https://support.microsoft.com/help/4521739) | SQL Server Engine | Replication | All |
| <a id=13234374>[13234374](#13234374) </a> | [FIX: SQL Server 2017 generates dump when you transfer ownership of full-text stoplist to another user if previous owner is dropped (KB4527842)](https://support.microsoft.com/help/4527842) | SQL Server Engine | Search | All |
| <a id=13179510>[13179510](#13179510) </a> | [FIX: sp_describe_parameter_encryption returns different results if you switch parameter positions in SQL Server 2017 (KB4529833)](https://support.microsoft.com/help/4529833)| SQL Server Engine | Security Infrastructure | Windows |
| <a id=13198903>[13198903](#13198903) </a> | [FIX: Access violation error occurs when you try to insert results of stored procedure into a table with dynamic data masking in SQL Server 2016 and 2017 (KB4520739)](https://support.microsoft.com/help/4520739) | SQL Server Engine | Security Infrastructure | Windows |
| <a id=13284243>[13284243](#13284243) </a> | FIX: Symmetric key encryption takes longer time in SQL Server 2017 than in SQL Server 2012 (KB4532171) | SQL Server Engine| Security Infrastructure | Windows |
| <a id=13218545>[13218545](#13218545) </a> | [FIX: Database cannot recover and reports error 5243 in SQL Server 2016 and 2017 (KB4526315)](https://support.microsoft.com/help/4526315) | SQL Server Engine | Storage Management | Windows |
| <a id=13262554>[13262554](#13262554) </a> | [FIX: Error 18456 occurs when you run DMV queries on the SQL Server 2017 instance after rebuilding system databases (KB4530955)](https://support.microsoft.com/help/4530955) | SQL Server Engine | Telemetry | All |
| <a id=13261031>[13261031](#13261031) </a> | [FIX: Assertion dump occurs when sp_cdc_disable_db is executed to disable CDC or when distributed transaction is committed after ROLLBACK SAVEPOINT in SQL Server (KB4530500)](https://support.microsoft.com/help/4530500) | SQL Server Engine | Transaction Services | Windows |
| <a id=13193748>[13193748](#13193748) </a> | [FIX: SQL patch does not update Local DB files correctly when installed using SqlLocalDb.msi (KB4526524)](https://support.microsoft.com/help/4526524) | SQL Setup | Deployment Platform | Windows |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2017 now](https://www.microsoft.com/download/details.aspx?id=56128)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2017 CU release.
> - If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog </b></summary>

> [!NOTE]
>
> After future cumulative updates are released for SQL Server 2017, this and all previous CUs can be downloaded from the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/search.aspx?q=sql%20server%202017). However, we recommend that you always install the latest cumulative update that is available.

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU18 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2019/12/sqlserver2017-kb4527377-x64_cd2488e727d332802f77d5032e3e4b40da777f77.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4527377-x64.exe* file through the following command:

`certutil -hashfile SQLServer2017-KB4527377-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4527377-x64.exe| F43C2FD9BA972E7D0FE72ACCF916C1F8BC82A2FB47A0C8D9E91F3B0B61748312 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

| File   name                                        | File version    | File size | Date  | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|-------|-------|----------|
| Asplatformhost.dll                                 | 2017.140.249.21 | 259672    | 16-11 | 13:19 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.249.21     | 734600    | 16-11 | 12:58 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.249.21     | 1373576   | 16-11 | 13:19 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.249.21     | 977288    | 16-11 | 13:19 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.249.21     | 514648    | 16-11 | 13:19 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 16-11 | 13:13 | x86      |
| Microsoft.data.mashup.dll                          | 2.57.5068.261   | 180424    | 16-11 | 12:58 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.57.5068.261   | 37584     | 16-11 | 12:58 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.57.5068.261   | 54472     | 16-11 | 12:58 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.57.5068.261   | 107728    | 16-11 | 12:58 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.57.5068.261   | 5223112   | 16-11 | 12:58 | x86      |
| Microsoft.mashup.container.exe                     | 2.57.5068.261   | 26312     | 16-11 | 12:58 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.57.5068.261   | 26824     | 16-11 | 12:58 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.57.5068.261   | 26824     | 16-11 | 12:58 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.57.5068.261   | 159440    | 16-11 | 12:58 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.57.5068.261   | 84176     | 16-11 | 12:58 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.57.5068.261   | 67280     | 16-11 | 12:58 | x86      |
| Microsoft.mashup.shims.dll                         | 2.57.5068.261   | 25808     | 16-11 | 12:58 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 151240    | 16-11 | 12:58 | x86      |
| Microsoft.mashupengine.dll                         | 2.57.5068.261   | 13608144  | 16-11 | 12:58 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.0.1.272      | 1106088   | 16-11 | 12:58 | x86      |
| Msmdctr.dll                                        | 2017.140.249.21 | 33368     | 16-11 | 13:20 | x64      |
| Msmdlocal.dll                                      | 2017.140.249.21 | 40407128  | 16-11 | 13:01 | x86      |
| Msmdlocal.dll                                      | 2017.140.249.21 | 60746632  | 16-11 | 13:20 | x64      |
| Msmdpump.dll                                       | 2017.140.249.21 | 9332824   | 16-11 | 13:20 | x64      |
| Msmdredir.dll                                      | 2017.140.249.21 | 7088008   | 16-11 | 13:01 | x86      |
| Msmdsrv.exe                                        | 2017.140.249.21 | 60645464  | 16-11 | 13:20 | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.21 | 7304584   | 16-11 | 13:01 | x86      |
| Msmgdsrv.dll                                       | 2017.140.249.21 | 9000328   | 16-11 | 13:20 | x64      |
| Msolap.dll                                         | 2017.140.249.21 | 7772760   | 16-11 | 13:01 | x86      |
| Msolap.dll                                         | 2017.140.249.21 | 10255752  | 16-11 | 13:20 | x64      |
| Msolui.dll                                         | 2017.140.249.21 | 280456    | 16-11 | 13:01 | x86      |
| Msolui.dll                                         | 2017.140.249.21 | 304216    | 16-11 | 13:20 | x64      |
| Powerbiextensions.dll                              | 2.57.5068.261   | 6606536   | 16-11 | 12:58 | x86      |
| Sql_as_keyfile.dll                                 | 2017.140.3257.3 | 100456    | 16-11 | 13:19 | x64      |
| Sqlboot.dll                                        | 2017.140.3257.3 | 197736    | 16-11 | 13:20 | x64      |
| Sqlceip.exe                                        | 14.0.3257.3     | 261944    | 16-11 | 13:13 | x86      |
| Sqldumper.exe                                      | 2017.140.3257.3 | 123192    | 16-11 | 12:51 | x86      |
| Sqldumper.exe                                      | 2017.140.3257.3 | 145720    | 16-11 | 13:05 | x64      |
| Tmapi.dll                                          | 2017.140.249.21 | 5814664   | 16-11 | 13:20 | x64      |
| Tmcachemgr.dll                                     | 2017.140.249.21 | 4158040   | 16-11 | 13:20 | x64      |
| Tmpersistence.dll                                  | 2017.140.249.21 | 1125256   | 16-11 | 13:20 | x64      |
| Tmtransactions.dll                                 | 2017.140.249.21 | 1634184   | 16-11 | 13:20 | x64      |
| Xe.dll                                             | 2017.140.3257.3 | 673592    | 16-11 | 13:20 | x64      |
| Xmlrw.dll                                          | 2017.140.3257.3 | 257640    | 16-11 | 13:02 | x86      |
| Xmlrw.dll                                          | 2017.140.3257.3 | 305464    | 16-11 | 13:20 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3257.3 | 189752    | 16-11 | 13:02 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3257.3 | 224360    | 16-11 | 13:20 | x64      |
| Xmsrv.dll                                          | 2017.140.249.21 | 33346648  | 16-11 | 13:02 | x86      |
| Xmsrv.dll                                          | 2017.140.249.21 | 25372552  | 16-11 | 13:20 | x64      |

SQL Server 2017 Database Services Common Core

| File   name                                | File version     | File size | Date  | Time  | Platform |
|--------------------------------------------|------------------|-----------|-------|-------|----------|
| Batchparser.dll                            | 2017.140.3257.3  | 160568    | 16-11 | 12:59 | x86      |
| Batchparser.dll                            | 2017.140.3257.3  | 181048    | 16-11 | 13:19 | x64      |
| Instapi140.dll                             | 2017.140.3257.3  | 62568     | 16-11 | 13:01 | x86      |
| Instapi140.dll                             | 2017.140.3257.3  | 72296     | 16-11 | 13:20 | x64      |
| Isacctchange.dll                           | 2017.140.3257.3  | 29288     | 16-11 | 12:59 | x86      |
| Isacctchange.dll                           | 2017.140.3257.3  | 31032     | 16-11 | 13:19 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.21      | 1081944   | 16-11 | 12:59 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.21      | 1081736   | 16-11 | 13:19 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.249.21      | 1374600   | 16-11 | 12:59 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.21      | 734600    | 16-11 | 12:59 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.21      | 734600    | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3257.3      | 37176     | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3257.3  | 78648     | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3257.3  | 82024     | 16-11 | 13:19 | x64      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3257.3      | 571496    | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3257.3      | 571704    | 16-11 | 13:19 | x86      |
| Msasxpress.dll                             | 2017.140.249.21  | 25176     | 16-11 | 13:01 | x86      |
| Msasxpress.dll                             | 2017.140.249.21  | 29272     | 16-11 | 13:20 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3257.3  | 69224     | 16-11 | 13:02 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3257.3  | 84280     | 16-11 | 13:20 | x64      |
| Sql_common_core_keyfile.dll                | 2017.140.3257.3  | 100456    | 16-11 | 13:19 | x64      |
| Sqldumper.exe                              | 2017.140.3257.3  | 123192    | 16-11 | 12:51 | x86      |
| Sqldumper.exe                              | 2017.140.3257.3  | 145720    | 16-11 | 13:05 | x64      |
| Sqlftacct.dll                              | 2017.140.3257.3  | 56120     | 16-11 | 13:02 | x86      |
| Sqlftacct.dll                              | 2017.140.3257.3  | 64104     | 16-11 | 13:20 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 16-11 | 13:01 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 16-11 | 13:20 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3257.3  | 375608    | 16-11 | 13:01 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3257.3  | 420144    | 16-11 | 13:20 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3257.3  | 35128     | 16-11 | 13:02 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3257.3  | 37480     | 16-11 | 13:20 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3257.3  | 274024    | 16-11 | 13:02 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3257.3  | 358200    | 16-11 | 13:20 | x64      |
| Sqltdiagn.dll                              | 2017.140.3257.3  | 60728     | 16-11 | 13:01 | x86      |
| Sqltdiagn.dll                              | 2017.140.3257.3  | 67896     | 16-11 | 13:20 | x64      |
| Svrenumapi140.dll                          | 2017.140.3257.3  | 895288    | 16-11 | 13:02 | x86      |
| Svrenumapi140.dll                          | 2017.140.3257.3  | 1174632   | 16-11 | 13:20 | x64      |

SQL Server 2017 Data Quality Client

| File   name         | File version    | File size | Date  | Time  | Platform |
|---------------------|-----------------|-----------|-------|-------|----------|
| Dumpbin.exe         | 12.10.30102.2   | 24624     | 16-11 | 13:01 | x86      |
| Link.exe            | 12.10.30102.2   | 852528    | 16-11 | 13:01 | x86      |
| Mspdb120.dll        | 12.10.30102.2   | 259632    | 16-11 | 13:01 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3257.3 | 100456    | 16-11 | 13:19 | x64      |
| Stdole.dll          | 7.0.9466.0      | 32296     | 16-11 | 13:02 | x86      |

SQL Server 2017 Data Quality

| File   name                                       | File version | File size | Date  | Time  | Platform |
|---------------------------------------------------|--------------|-----------|-------|-------|----------|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 16-11 | 12:59 | x86      |
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 16-11 | 13:19 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 16-11 | 12:59 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 16-11 | 13:19 | x86      |

SQL Server 2017 sql_dreplay_client

| File   name                    | File version    | File size | Date  | Time  | Platform |
|--------------------------------|-----------------|-----------|-------|-------|----------|
| Dreplayclient.exe              | 2017.140.3257.3 | 120936    | 16-11 | 12:59 | x86      |
| Dreplaycommon.dll              | 2017.140.3257.3 | 700216    | 16-11 | 12:59 | x86      |
| Dreplayserverps.dll            | 2017.140.3257.3 | 32872     | 16-11 | 12:59 | x86      |
| Dreplayutil.dll                | 2017.140.3257.3 | 309864    | 16-11 | 12:59 | x86      |
| Instapi140.dll                 | 2017.140.3257.3 | 72296     | 16-11 | 13:20 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3257.3 | 100456    | 16-11 | 13:19 | x64      |
| Sqlresourceloader.dll          | 2017.140.3257.3 | 29288     | 16-11 | 13:01 | x86      |

SQL Server 2017 sql_dreplay_controller

| File   name                        | File version    | File size | Date  | Time  | Platform |
|------------------------------------|-----------------|-----------|-------|-------|----------|
| Dreplaycommon.dll                  | 2017.140.3257.3 | 700216    | 16-11 | 12:59 | x86      |
| Dreplaycontroller.exe              | 2017.140.3257.3 | 350312    | 16-11 | 12:59 | x86      |
| Dreplayprocess.dll                 | 2017.140.3257.3 | 171832    | 16-11 | 12:59 | x86      |
| Dreplayserverps.dll                | 2017.140.3257.3 | 32872     | 16-11 | 12:59 | x86      |
| Instapi140.dll                     | 2017.140.3257.3 | 72296     | 16-11 | 13:20 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3257.3 | 100456    | 16-11 | 13:19 | x64      |
| Sqlresourceloader.dll              | 2017.140.3257.3 | 29288     | 16-11 | 13:01 | x86      |

SQL Server 2017 Database Services Core Instance

| File   name                                  | File version    | File size | Date  | Time  | Platform |
|----------------------------------------------|-----------------|-----------|-------|-------|----------|
| Backuptourl.exe                              | 14.0.3257.3     | 40760     | 16-11 | 13:19 | x64      |
| Batchparser.dll                              | 2017.140.3257.3 | 181048    | 16-11 | 13:19 | x64      |
| C1.dll                                       | 18.10.40116.18  | 925232    | 16-11 | 12:49 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341440   | 16-11 | 12:49 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192048    | 16-11 | 12:49 | x64      |
| Clui.dll                                     | 18.10.40116.10  | 486144    | 16-11 | 13:08 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 16-11 | 13:19 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3257.3 | 227640    | 16-11 | 13:19 | x64      |
| Dcexec.exe                                   | 2017.140.3257.3 | 76392     | 16-11 | 13:19 | x64      |
| Fssres.dll                                   | 2017.140.3257.3 | 90936     | 16-11 | 13:20 | x64      |
| Hadrres.dll                                  | 2017.140.3257.3 | 189752    | 16-11 | 13:20 | x64      |
| Hkcompile.dll                                | 2017.140.3257.3 | 1423160   | 16-11 | 13:20 | x64      |
| Hkengine.dll                                 | 2017.140.3257.3 | 5858920   | 16-11 | 13:20 | x64      |
| Hkruntime.dll                                | 2017.140.3257.3 | 162920    | 16-11 | 13:20 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017392   | 16-11 | 12:49 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.249.21     | 734088    | 16-11 | 13:19 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 16-11 | 13:13 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3257.3     | 236344    | 16-11 | 13:19 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3257.3     | 79456     | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.types.dll                | 2017.140.3257.3 | 392808    | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3257.3 | 72504     | 16-11 | 13:19 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3257.3 | 65336     | 16-11 | 13:19 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3257.3 | 152168    | 16-11 | 13:19 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3257.3 | 159544    | 16-11 | 13:19 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3257.3 | 303720    | 16-11 | 13:19 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3257.3 | 75064     | 16-11 | 13:19 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129576    | 16-11 | 12:49 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559144    | 16-11 | 12:49 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 16-11 | 12:49 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661040    | 16-11 | 12:49 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964656    | 16-11 | 12:49 | x64      |
| Odsole70.dll                                 | 2017.140.3257.3 | 92776     | 16-11 | 13:20 | x64      |
| Opends60.dll                                 | 2017.140.3257.3 | 33080     | 16-11 | 13:20 | x64      |
| Qds.dll                                      | 2017.140.3257.3 | 1181792   | 16-11 | 13:20 | x64      |
| Rsfxft.dll                                   | 2017.140.3257.3 | 34408     | 16-11 | 13:20 | x64      |
| Secforwarder.dll                             | 2017.140.3257.3 | 37480     | 16-11 | 13:20 | x64      |
| Sqagtres.dll                                 | 2017.140.3257.3 | 76088     | 16-11 | 13:20 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3257.3 | 100456    | 16-11 | 13:19 | x64      |
| Sqlaamss.dll                                 | 2017.140.3257.3 | 91752     | 16-11 | 13:20 | x64      |
| Sqlaccess.dll                                | 2017.140.3257.3 | 475752    | 16-11 | 13:20 | x64      |
| Sqlagent.exe                                 | 2017.140.3257.3 | 604776    | 16-11 | 13:20 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3257.3 | 54376     | 16-11 | 13:01 | x86      |
| Sqlagentctr140.dll                           | 2017.140.3257.3 | 63288     | 16-11 | 13:20 | x64      |
| Sqlagentlog.dll                              | 2017.140.3257.3 | 32872     | 16-11 | 13:20 | x64      |
| Sqlagentmail.dll                             | 2017.140.3257.3 | 53864     | 16-11 | 13:20 | x64      |
| Sqlboot.dll                                  | 2017.140.3257.3 | 197736    | 16-11 | 13:20 | x64      |
| Sqlceip.exe                                  | 14.0.3257.3     | 261944    | 16-11 | 13:13 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3257.3 | 74552     | 16-11 | 13:20 | x64      |
| Sqlctr140.dll                                | 2017.140.3257.3 | 113256    | 16-11 | 13:02 | x86      |
| Sqlctr140.dll                                | 2017.140.3257.3 | 130872    | 16-11 | 13:20 | x64      |
| Sqldk.dll                                    | 2017.140.3257.3 | 2802280   | 16-11 | 13:20 | x64      |
| Sqldtsss.dll                                 | 2017.140.3257.3 | 109368    | 16-11 | 13:20 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3407160   | 16-11 | 12:48 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3343160   | 16-11 | 12:49 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 1500496   | 16-11 | 12:49 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3785016   | 16-11 | 12:49 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 2039608   | 16-11 | 12:50 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3601512   | 16-11 | 12:54 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3923256   | 16-11 | 12:55 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3791976   | 16-11 | 12:56 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3919976   | 16-11 | 12:56 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3301688   | 16-11 | 12:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3372128   | 16-11 | 13:05 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3218232   | 16-11 | 13:06 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3641144   | 16-11 | 13:06 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3681888   | 16-11 | 13:06 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 2092856   | 16-11 | 13:07 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3593320   | 16-11 | 13:08 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3296056   | 16-11 | 13:09 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3826280   | 16-11 | 13:13 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3486520   | 16-11 | 13:14 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 3790648   | 16-11 | 13:14 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 1447736   | 16-11 | 13:15 | x64      |
| Sqlevn70.rll                                 | 2017.140.3257.3 | 4032312   | 16-11 | 13:18 | x64      |
| Sqliosim.com                                 | 2017.140.3257.3 | 313656    | 16-11 | 13:20 | x64      |
| Sqliosim.exe                                 | 2017.140.3257.3 | 3020088   | 16-11 | 13:20 | x64      |
| Sqllang.dll                                  | 2017.140.3257.3 | 41303656  | 16-11 | 13:20 | x64      |
| Sqlmin.dll                                   | 2017.140.3257.3 | 40522584  | 16-11 | 13:20 | x64      |
| Sqlolapss.dll                                | 2017.140.3257.3 | 109368    | 16-11 | 13:20 | x64      |
| Sqlos.dll                                    | 2017.140.3257.3 | 26216     | 16-11 | 13:20 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3257.3 | 69944     | 16-11 | 13:20 | x64      |
| Sqlrepss.dll                                 | 2017.140.3257.3 | 68712     | 16-11 | 13:20 | x64      |
| Sqlresld.dll                                 | 2017.140.3257.3 | 31032     | 16-11 | 13:20 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3257.3 | 32568     | 16-11 | 13:20 | x64      |
| Sqlscm.dll                                   | 2017.140.3257.3 | 72808     | 16-11 | 13:20 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3257.3 | 27752     | 16-11 | 13:20 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3257.3 | 5882680   | 16-11 | 13:20 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3257.3 | 732776    | 16-11 | 13:20 | x64      |
| Sqlservr.exe                                 | 2017.140.3257.3 | 488760    | 16-11 | 13:20 | x64      |
| Sqlsvc.dll                                   | 2017.140.3257.3 | 162920    | 16-11 | 13:20 | x64      |
| Sqltses.dll                                  | 2017.140.3257.3 | 9566520   | 16-11 | 13:20 | x64      |
| Sqsrvres.dll                                 | 2017.140.3257.3 | 262968    | 16-11 | 13:20 | x64      |
| Svl.dll                                      | 2017.140.3257.3 | 153912    | 16-11 | 13:20 | x64      |
| Xe.dll                                       | 2017.140.3257.3 | 673592    | 16-11 | 13:20 | x64      |
| Xmlrw.dll                                    | 2017.140.3257.3 | 305464    | 16-11 | 13:20 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3257.3 | 224360    | 16-11 | 13:20 | x64      |
| Xpadsi.exe                                   | 2017.140.3257.3 | 91752     | 16-11 | 13:20 | x64      |
| Xplog70.dll                                  | 2017.140.3257.3 | 77928     | 16-11 | 13:20 | x64      |
| Xpqueue.dll                                  | 2017.140.3257.3 | 75064     | 16-11 | 13:20 | x64      |
| Xprepl.dll                                   | 2017.140.3257.3 | 103736    | 16-11 | 13:20 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3257.3 | 32568     | 16-11 | 13:20 | x64      |
| Xpstar.dll                                   | 2017.140.3257.3 | 452200    | 16-11 | 13:20 | x64      |

SQL Server 2017 Database Services Core Shared

| File   name                                                 | File version    | File size | Date  | Time  | Platform |
|-------------------------------------------------------------|-----------------|-----------|-------|-------|----------|
| Batchparser.dll                                             | 2017.140.3257.3 | 160568    | 16-11 | 12:59 | x86      |
| Batchparser.dll                                             | 2017.140.3257.3 | 181048    | 16-11 | 13:19 | x64      |
| Bcp.exe                                                     | 2017.140.3257.3 | 120120    | 16-11 | 13:20 | x64      |
| Commanddest.dll                                             | 2017.140.3257.3 | 246104    | 16-11 | 13:19 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3257.3 | 116536    | 16-11 | 13:19 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3257.3 | 187496    | 16-11 | 13:19 | x64      |
| Distrib.exe                                                 | 2017.140.3257.3 | 205112    | 16-11 | 13:20 | x64      |
| Dteparse.dll                                                | 2017.140.3257.3 | 111416    | 16-11 | 13:19 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3257.3 | 89184     | 16-11 | 13:19 | x64      |
| Dtepkg.dll                                                  | 2017.140.3257.3 | 137832    | 16-11 | 13:19 | x64      |
| Dtexec.exe                                                  | 2017.140.3257.3 | 74064     | 16-11 | 13:19 | x64      |
| Dts.dll                                                     | 2017.140.3257.3 | 3001144   | 16-11 | 13:19 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3257.3 | 475448    | 16-11 | 13:19 | x64      |
| Dtsconn.dll                                                 | 2017.140.3257.3 | 499000    | 16-11 | 13:19 | x64      |
| Dtshost.exe                                                 | 2017.140.3257.3 | 106088    | 16-11 | 13:20 | x64      |
| Dtslog.dll                                                  | 2017.140.3257.3 | 120632    | 16-11 | 13:19 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3257.3 | 545384    | 16-11 | 13:20 | x64      |
| Dtspipeline.dll                                             | 2017.140.3257.3 | 1268328   | 16-11 | 13:19 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3257.3 | 48472     | 16-11 | 13:19 | x64      |
| Dtuparse.dll                                                | 2017.140.3257.3 | 89192     | 16-11 | 13:19 | x64      |
| Dtutil.exe                                                  | 2017.140.3257.3 | 148792    | 16-11 | 13:19 | x64      |
| Exceldest.dll                                               | 2017.140.3257.3 | 260712    | 16-11 | 13:19 | x64      |
| Excelsrc.dll                                                | 2017.140.3257.3 | 282728    | 16-11 | 13:19 | x64      |
| Execpackagetask.dll                                         | 2017.140.3257.3 | 168040    | 16-11 | 13:19 | x64      |
| Flatfiledest.dll                                            | 2017.140.3257.3 | 386872    | 16-11 | 13:19 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3257.3 | 399464    | 16-11 | 13:19 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3257.3 | 96360     | 16-11 | 13:19 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3257.3 | 59496     | 16-11 | 13:20 | x64      |
| Ionic.zip.dll                                               | 1.9.1.8         | 471440    | 16-11 | 12:49 | x86      |
| Logread.exe                                                 | 2017.140.3257.3 | 636728    | 16-11 | 13:20 | x64      |
| Mergetxt.dll                                                | 2017.140.3257.3 | 65128     | 16-11 | 13:20 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.249.21     | 1374808   | 16-11 | 13:19 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 16-11 | 12:49 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3257.3     | 137832    | 16-11 | 12:59 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll    | 14.0.3257.3     | 54888     | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3257.3     | 89704     | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll      | 14.0.3257.3     | 73320     | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                | 14.0.3257.3     | 391992    | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3257.3     | 614200    | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3257.3 | 1664824   | 16-11 | 13:19 | x64      |
| Microsoft.sqlserver.rmo.dll                                 | 14.0.3257.3     | 571496    | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3257.3 | 152168    | 16-11 | 13:19 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3257.3 | 159544    | 16-11 | 13:19 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3257.3 | 103224    | 16-11 | 13:19 | x64      |
| Msgprox.dll                                                 | 2017.140.3257.3 | 271976    | 16-11 | 13:20 | x64      |
| Msxmlsql.dll                                                | 2017.140.3257.3 | 1448040   | 16-11 | 13:20 | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111     | 522856    | 16-11 | 12:49 | x86      |
| Oledbdest.dll                                               | 2017.140.3257.3 | 261224    | 16-11 | 13:19 | x64      |
| Oledbsrc.dll                                                | 2017.140.3257.3 | 288872    | 16-11 | 13:19 | x64      |
| Osql.exe                                                    | 2017.140.3257.3 | 75576     | 16-11 | 13:19 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3257.3 | 475752    | 16-11 | 13:20 | x64      |
| Rawdest.dll                                                 | 2017.140.3257.3 | 206648    | 16-11 | 13:20 | x64      |
| Rawsource.dll                                               | 2017.140.3257.3 | 194360    | 16-11 | 13:20 | x64      |
| Rdistcom.dll                                                | 2017.140.3257.3 | 859448    | 16-11 | 13:20 | x64      |
| Recordsetdest.dll                                           | 2017.140.3257.3 | 184632    | 16-11 | 13:20 | x64      |
| Replagnt.dll                                                | 2017.140.3257.3 | 30824     | 16-11 | 13:20 | x64      |
| Repldp.dll                                                  | 2017.140.3257.3 | 292456    | 16-11 | 13:20 | x64      |
| Replerrx.dll                                                | 2017.140.3257.3 | 155960    | 16-11 | 13:20 | x64      |
| Replisapi.dll                                               | 2017.140.3257.3 | 364344    | 16-11 | 13:20 | x64      |
| Replmerg.exe                                                | 2017.140.3257.3 | 527160    | 16-11 | 13:20 | x64      |
| Replprov.dll                                                | 2017.140.3257.3 | 804152    | 16-11 | 13:20 | x64      |
| Replrec.dll                                                 | 2017.140.3257.3 | 977208    | 16-11 | 13:20 | x64      |
| Replsub.dll                                                 | 2017.140.3257.3 | 447288    | 16-11 | 13:20 | x64      |
| Replsync.dll                                                | 2017.140.3257.3 | 155240    | 16-11 | 13:20 | x64      |
| Sort00001000.dll                                            | 4.0.30319.576   | 871680    | 16-11 | 13:20 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576   | 75016     | 16-11 | 13:20 | x64      |
| Spresolv.dll                                                | 2017.140.3257.3 | 254056    | 16-11 | 13:20 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3257.3 | 100456    | 16-11 | 13:19 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3257.3 | 249144    | 16-11 | 13:20 | x64      |
| Sqldiag.exe                                                 | 2017.140.3257.3 | 1257784   | 16-11 | 13:20 | x64      |
| Sqldistx.dll                                                | 2017.140.3257.3 | 226616    | 16-11 | 13:20 | x64      |
| Sqllogship.exe                                              | 14.0.3257.3     | 105568    | 16-11 | 13:20 | x64      |
| Sqlmergx.dll                                                | 2017.140.3257.3 | 362296    | 16-11 | 13:20 | x64      |
| Sqlresld.dll                                                | 2017.140.3257.3 | 28984     | 16-11 | 13:01 | x86      |
| Sqlresld.dll                                                | 2017.140.3257.3 | 31032     | 16-11 | 13:20 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3257.3 | 29288     | 16-11 | 13:01 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3257.3 | 32568     | 16-11 | 13:20 | x64      |
| Sqlscm.dll                                                  | 2017.140.3257.3 | 62264     | 16-11 | 13:01 | x86      |
| Sqlscm.dll                                                  | 2017.140.3257.3 | 72808     | 16-11 | 13:20 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3257.3 | 135272    | 16-11 | 13:01 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3257.3 | 162920    | 16-11 | 13:20 | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3257.3 | 183904    | 16-11 | 13:20 | x64      |
| Sqlwep140.dll                                               | 2017.140.3257.3 | 105784    | 16-11 | 13:20 | x64      |
| Ssdebugps.dll                                               | 2017.140.3257.3 | 33592     | 16-11 | 13:20 | x64      |
| Ssisoledb.dll                                               | 2017.140.3257.3 | 216168    | 16-11 | 13:20 | x64      |
| Ssradd.dll                                                  | 2017.140.3257.3 | 77112     | 16-11 | 13:20 | x64      |
| Ssravg.dll                                                  | 2017.140.3257.3 | 77416     | 16-11 | 13:20 | x64      |
| Ssrdown.dll                                                 | 2017.140.3257.3 | 62264     | 16-11 | 13:20 | x64      |
| Ssrmax.dll                                                  | 2017.140.3257.3 | 75576     | 16-11 | 13:20 | x64      |
| Ssrmin.dll                                                  | 2017.140.3257.3 | 75576     | 16-11 | 13:20 | x64      |
| Ssrpub.dll                                                  | 2017.140.3257.3 | 62568     | 16-11 | 13:20 | x64      |
| Ssrup.dll                                                   | 2017.140.3257.3 | 62056     | 16-11 | 13:20 | x64      |
| Tablediff.exe                                               | 14.0.3257.3     | 86632     | 16-11 | 13:20 | x64      |
| Txagg.dll                                                   | 2017.140.3257.3 | 362296    | 16-11 | 13:20 | x64      |
| Txbdd.dll                                                   | 2017.140.3257.3 | 175208    | 16-11 | 13:20 | x64      |
| Txdatacollector.dll                                         | 2017.140.3257.3 | 360760    | 16-11 | 13:20 | x64      |
| Txdataconvert.dll                                           | 2017.140.3257.3 | 293176    | 16-11 | 13:20 | x64      |
| Txderived.dll                                               | 2017.140.3257.3 | 604472    | 16-11 | 13:20 | x64      |
| Txlookup.dll                                                | 2017.140.3257.3 | 527968    | 16-11 | 13:20 | x64      |
| Txmerge.dll                                                 | 2017.140.3257.3 | 229992    | 16-11 | 13:20 | x64      |
| Txmergejoin.dll                                             | 2017.140.3257.3 | 275768    | 16-11 | 13:20 | x64      |
| Txmulticast.dll                                             | 2017.140.3257.3 | 127592    | 16-11 | 13:20 | x64      |
| Txrowcount.dll                                              | 2017.140.3257.3 | 125776    | 16-11 | 13:20 | x64      |
| Txsort.dll                                                  | 2017.140.3257.3 | 256824    | 16-11 | 13:20 | x64      |
| Txsplit.dll                                                 | 2017.140.3257.3 | 596584    | 16-11 | 13:20 | x64      |
| Txunionall.dll                                              | 2017.140.3257.3 | 181864    | 16-11 | 13:20 | x64      |
| Xe.dll                                                      | 2017.140.3257.3 | 673592    | 16-11 | 13:20 | x64      |
| Xmlrw.dll                                                   | 2017.140.3257.3 | 305464    | 16-11 | 13:20 | x64      |
| Xmlsub.dll                                                  | 2017.140.3257.3 | 262248    | 16-11 | 13:20 | x64      |

SQL Server 2017 sql_extensibility

| File   name                   | File version    | File size | Date  | Time  | Platform |
|-------------------------------|-----------------|-----------|-------|-------|----------|
| Launchpad.exe                 | 2017.140.3257.3 | 1125992   | 16-11 | 13:20 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3257.3 | 100456    | 16-11 | 13:19 | x64      |
| Sqlsatellite.dll              | 2017.140.3257.3 | 923960    | 16-11 | 13:20 | x64      |

SQL Server 2017 Full-Text Engine

| File   name              | File version    | File size | Date  | Time  | Platform |
|--------------------------|-----------------|-----------|-------|-------|----------|
| Fd.dll                   | 2017.140.3257.3 | 672568    | 16-11 | 13:20 | x64      |
| Fdhost.exe               | 2017.140.3257.3 | 116536    | 16-11 | 13:20 | x64      |
| Fdlauncher.exe           | 2017.140.3257.3 | 64096     | 16-11 | 13:20 | x64      |
| Nlsdl.dll                | 6.0.6001.18000  | 46360     | 16-11 | 13:20 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3257.3 | 100456    | 16-11 | 13:19 | x64      |
| Sqlft140ph.dll           | 2017.140.3257.3 | 69944     | 16-11 | 13:20 | x64      |

SQL Server 2017 sql_inst_mr

| File   name             | File version    | File size | Date  | Time  | Platform |
|-------------------------|-----------------|-----------|-------|-------|----------|
| Imrdll.dll              | 14.0.3257.3     | 23656     | 16-11 | 13:19 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3257.3 | 100456    | 16-11 | 13:19 | x64      |

SQL Server 2017 Integration Services

| File   name                                                   | File version    | File size | Date  | Time  | Platform |
|---------------------------------------------------------------|-----------------|-----------|-------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 16-11 | 12:59 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 16-11 | 13:19 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 16-11 | 12:59 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 16-11 | 13:19 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 16-11 | 12:59 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 16-11 | 13:19 | x86      |
| Commanddest.dll                                               | 2017.140.3257.3 | 201016    | 16-11 | 12:59 | x86      |
| Commanddest.dll                                               | 2017.140.3257.3 | 246104    | 16-11 | 13:19 | x64      |
| Dteparse.dll                                                  | 2017.140.3257.3 | 100456    | 16-11 | 12:59 | x86      |
| Dteparse.dll                                                  | 2017.140.3257.3 | 111416    | 16-11 | 13:19 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3257.3 | 83792     | 16-11 | 12:59 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3257.3 | 89184     | 16-11 | 13:19 | x64      |
| Dtepkg.dll                                                    | 2017.140.3257.3 | 117048    | 16-11 | 12:59 | x86      |
| Dtepkg.dll                                                    | 2017.140.3257.3 | 137832    | 16-11 | 13:19 | x64      |
| Dtexec.exe                                                    | 2017.140.3257.3 | 67688     | 16-11 | 12:59 | x86      |
| Dtexec.exe                                                    | 2017.140.3257.3 | 74064     | 16-11 | 13:19 | x64      |
| Dts.dll                                                       | 2017.140.3257.3 | 2551096   | 16-11 | 12:59 | x86      |
| Dts.dll                                                       | 2017.140.3257.3 | 3001144   | 16-11 | 13:19 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3257.3 | 417896    | 16-11 | 12:59 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3257.3 | 475448    | 16-11 | 13:19 | x64      |
| Dtsconn.dll                                                   | 2017.140.3257.3 | 400696    | 16-11 | 12:59 | x86      |
| Dtsconn.dll                                                   | 2017.140.3257.3 | 499000    | 16-11 | 13:19 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3257.3 | 95328     | 16-11 | 12:59 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3257.3 | 111416    | 16-11 | 13:19 | x64      |
| Dtshost.exe                                                   | 2017.140.3257.3 | 91240     | 16-11 | 13:01 | x86      |
| Dtshost.exe                                                   | 2017.140.3257.3 | 106088    | 16-11 | 13:20 | x64      |
| Dtslog.dll                                                    | 2017.140.3257.3 | 103016    | 16-11 | 12:59 | x86      |
| Dtslog.dll                                                    | 2017.140.3257.3 | 120632    | 16-11 | 13:19 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3257.3 | 541496    | 16-11 | 13:01 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3257.3 | 545384    | 16-11 | 13:20 | x64      |
| Dtspipeline.dll                                               | 2017.140.3257.3 | 1060456   | 16-11 | 12:59 | x86      |
| Dtspipeline.dll                                               | 2017.140.3257.3 | 1268328   | 16-11 | 13:19 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3257.3 | 42808     | 16-11 | 12:59 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3257.3 | 48472     | 16-11 | 13:19 | x64      |
| Dtuparse.dll                                                  | 2017.140.3257.3 | 80184     | 16-11 | 12:59 | x86      |
| Dtuparse.dll                                                  | 2017.140.3257.3 | 89192     | 16-11 | 13:19 | x64      |
| Dtutil.exe                                                    | 2017.140.3257.3 | 127800    | 16-11 | 12:59 | x86      |
| Dtutil.exe                                                    | 2017.140.3257.3 | 148792    | 16-11 | 13:19 | x64      |
| Exceldest.dll                                                 | 2017.140.3257.3 | 214840    | 16-11 | 12:59 | x86      |
| Exceldest.dll                                                 | 2017.140.3257.3 | 260712    | 16-11 | 13:19 | x64      |
| Excelsrc.dll                                                  | 2017.140.3257.3 | 230504    | 16-11 | 12:59 | x86      |
| Excelsrc.dll                                                  | 2017.140.3257.3 | 282728    | 16-11 | 13:19 | x64      |
| Execpackagetask.dll                                           | 2017.140.3257.3 | 135480    | 16-11 | 12:59 | x86      |
| Execpackagetask.dll                                           | 2017.140.3257.3 | 168040    | 16-11 | 13:19 | x64      |
| Flatfiledest.dll                                              | 2017.140.3257.3 | 332600    | 16-11 | 12:59 | x86      |
| Flatfiledest.dll                                              | 2017.140.3257.3 | 386872    | 16-11 | 13:19 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3257.3 | 344376    | 16-11 | 12:59 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3257.3 | 399464    | 16-11 | 13:19 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3257.3 | 80696     | 16-11 | 12:59 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3257.3 | 96360     | 16-11 | 13:19 | x64      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 16-11 | 12:49 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 16-11 | 12:56 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3257.3     | 467048    | 16-11 | 12:59 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3257.3     | 466536    | 16-11 | 13:19 | x64      |
| Isserverexec.exe                                              | 14.0.3257.3     | 149096    | 16-11 | 12:59 | x86      |
| Isserverexec.exe                                              | 14.0.3257.3     | 148584    | 16-11 | 13:19 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.21     | 1374600   | 16-11 | 12:59 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.21     | 1374808   | 16-11 | 13:19 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 16-11 | 13:13 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 16-11 | 12:49 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 16-11 | 12:56 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3257.3     | 73016     | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3257.3 | 107320    | 16-11 | 13:00 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3257.3 | 112440    | 16-11 | 13:19 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3257.3     | 55096     | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3257.3     | 54888     | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3257.3     | 89704     | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3257.3     | 89704     | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3257.3     | 73528     | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3257.3     | 73320     | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3257.3     | 502584    | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3257.3     | 502584    | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3257.3     | 83768     | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3257.3     | 83768     | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3257.3     | 416056    | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3257.3     | 416056    | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 14.0.3257.3     | 391992    | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3257.3     | 614200    | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3257.3     | 614200    | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3257.3     | 252728    | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3257.3     | 252520    | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3257.3 | 142136    | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3257.3 | 152168    | 16-11 | 13:19 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3257.3 | 145512    | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3257.3 | 159544    | 16-11 | 13:19 | x64      |
| Msdtssrvr.exe                                                 | 14.0.3257.3     | 219960    | 16-11 | 13:19 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3257.3 | 90424     | 16-11 | 12:59 | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3257.3 | 103224    | 16-11 | 13:19 | x64      |
| Msmdpp.dll                                                    | 2017.140.249.21 | 9191816   | 16-11 | 13:20 | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 16-11 | 12:49 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 16-11 | 12:56 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 16-11 | 12:57 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 16-11 | 13:07 | x86      |
| Oledbdest.dll                                                 | 2017.140.3257.3 | 214632    | 16-11 | 12:59 | x86      |
| Oledbdest.dll                                                 | 2017.140.3257.3 | 261224    | 16-11 | 13:19 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3257.3 | 233272    | 16-11 | 12:59 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3257.3 | 288872    | 16-11 | 13:19 | x64      |
| Rawdest.dll                                                   | 2017.140.3257.3 | 166504    | 16-11 | 13:01 | x86      |
| Rawdest.dll                                                   | 2017.140.3257.3 | 206648    | 16-11 | 13:20 | x64      |
| Rawsource.dll                                                 | 2017.140.3257.3 | 153400    | 16-11 | 13:01 | x86      |
| Rawsource.dll                                                 | 2017.140.3257.3 | 194360    | 16-11 | 13:20 | x64      |
| Recordsetdest.dll                                             | 2017.140.3257.3 | 149304    | 16-11 | 13:01 | x86      |
| Recordsetdest.dll                                             | 2017.140.3257.3 | 184632    | 16-11 | 13:20 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3257.3 | 100456    | 16-11 | 13:19 | x64      |
| Sqlceip.exe                                                   | 14.0.3257.3     | 261944    | 16-11 | 13:13 | x86      |
| Sqldest.dll                                                   | 2017.140.3257.3 | 213608    | 16-11 | 13:01 | x86      |
| Sqldest.dll                                                   | 2017.140.3257.3 | 260704    | 16-11 | 13:20 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3257.3 | 155240    | 16-11 | 13:01 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3257.3 | 183904    | 16-11 | 13:20 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3257.3 | 176744    | 16-11 | 13:01 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3257.3 | 216168    | 16-11 | 13:20 | x64      |
| Txagg.dll                                                     | 2017.140.3257.3 | 302392    | 16-11 | 13:01 | x86      |
| Txagg.dll                                                     | 2017.140.3257.3 | 362296    | 16-11 | 13:20 | x64      |
| Txbdd.dll                                                     | 2017.140.3257.3 | 136504    | 16-11 | 13:01 | x86      |
| Txbdd.dll                                                     | 2017.140.3257.3 | 175208    | 16-11 | 13:20 | x64      |
| Txbestmatch.dll                                               | 2017.140.3257.3 | 493160    | 16-11 | 13:01 | x86      |
| Txbestmatch.dll                                               | 2017.140.3257.3 | 605288    | 16-11 | 13:20 | x64      |
| Txcache.dll                                                   | 2017.140.3257.3 | 146232    | 16-11 | 13:01 | x86      |
| Txcache.dll                                                   | 2017.140.3257.3 | 180536    | 16-11 | 13:20 | x64      |
| Txcharmap.dll                                                 | 2017.140.3257.3 | 248936    | 16-11 | 13:01 | x86      |
| Txcharmap.dll                                                 | 2017.140.3257.3 | 287032    | 16-11 | 13:20 | x64      |
| Txcopymap.dll                                                 | 2017.140.3257.3 | 148312    | 16-11 | 13:01 | x86      |
| Txcopymap.dll                                                 | 2017.140.3257.3 | 184936    | 16-11 | 13:20 | x64      |
| Txdataconvert.dll                                             | 2017.140.3257.3 | 253240    | 16-11 | 13:01 | x86      |
| Txdataconvert.dll                                             | 2017.140.3257.3 | 293176    | 16-11 | 13:20 | x64      |
| Txderived.dll                                                 | 2017.140.3257.3 | 515688    | 16-11 | 13:01 | x86      |
| Txderived.dll                                                 | 2017.140.3257.3 | 604472    | 16-11 | 13:20 | x64      |
| Txfileextractor.dll                                           | 2017.140.3257.3 | 160872    | 16-11 | 13:01 | x86      |
| Txfileextractor.dll                                           | 2017.140.3257.3 | 198968    | 16-11 | 13:20 | x64      |
| Txfileinserter.dll                                            | 2017.140.3257.3 | 159336    | 16-11 | 13:01 | x86      |
| Txfileinserter.dll                                            | 2017.140.3257.3 | 196712    | 16-11 | 13:20 | x64      |
| Txgroupdups.dll                                               | 2017.140.3257.3 | 231016    | 16-11 | 13:01 | x86      |
| Txgroupdups.dll                                               | 2017.140.3257.3 | 290616    | 16-11 | 13:20 | x64      |
| Txlineage.dll                                                 | 2017.140.3257.3 | 110392    | 16-11 | 13:01 | x86      |
| Txlineage.dll                                                 | 2017.140.3257.3 | 137016    | 16-11 | 13:20 | x64      |
| Txlookup.dll                                                  | 2017.140.3257.3 | 446568    | 16-11 | 13:01 | x86      |
| Txlookup.dll                                                  | 2017.140.3257.3 | 527968    | 16-11 | 13:20 | x64      |
| Txmerge.dll                                                   | 2017.140.3257.3 | 176744    | 16-11 | 13:01 | x86      |
| Txmerge.dll                                                   | 2017.140.3257.3 | 229992    | 16-11 | 13:20 | x64      |
| Txmergejoin.dll                                               | 2017.140.3257.3 | 222008    | 16-11 | 13:01 | x86      |
| Txmergejoin.dll                                               | 2017.140.3257.3 | 275768    | 16-11 | 13:20 | x64      |
| Txmulticast.dll                                               | 2017.140.3257.3 | 102712    | 16-11 | 13:01 | x86      |
| Txmulticast.dll                                               | 2017.140.3257.3 | 127592    | 16-11 | 13:20 | x64      |
| Txpivot.dll                                                   | 2017.140.3257.3 | 180536    | 16-11 | 13:01 | x86      |
| Txpivot.dll                                                   | 2017.140.3257.3 | 225080    | 16-11 | 13:20 | x64      |
| Txrowcount.dll                                                | 2017.140.3257.3 | 101480    | 16-11 | 13:01 | x86      |
| Txrowcount.dll                                                | 2017.140.3257.3 | 125776    | 16-11 | 13:20 | x64      |
| Txsampling.dll                                                | 2017.140.3257.3 | 135992    | 16-11 | 13:01 | x86      |
| Txsampling.dll                                                | 2017.140.3257.3 | 172856    | 16-11 | 13:20 | x64      |
| Txscd.dll                                                     | 2017.140.3257.3 | 170296    | 16-11 | 13:01 | x86      |
| Txscd.dll                                                     | 2017.140.3257.3 | 220776    | 16-11 | 13:20 | x64      |
| Txsort.dll                                                    | 2017.140.3257.3 | 207976    | 16-11 | 13:01 | x86      |
| Txsort.dll                                                    | 2017.140.3257.3 | 256824    | 16-11 | 13:20 | x64      |
| Txsplit.dll                                                   | 2017.140.3257.3 | 510568    | 16-11 | 13:01 | x86      |
| Txsplit.dll                                                   | 2017.140.3257.3 | 596584    | 16-11 | 13:20 | x64      |
| Txtermextraction.dll                                          | 2017.140.3257.3 | 8615224   | 16-11 | 13:01 | x86      |
| Txtermextraction.dll                                          | 2017.140.3257.3 | 8676664   | 16-11 | 13:20 | x64      |
| Txtermlookup.dll                                              | 2017.140.3257.3 | 4106848   | 16-11 | 13:01 | x86      |
| Txtermlookup.dll                                              | 2017.140.3257.3 | 4157264   | 16-11 | 13:20 | x64      |
| Txunionall.dll                                                | 2017.140.3257.3 | 139576    | 16-11 | 13:01 | x86      |
| Txunionall.dll                                                | 2017.140.3257.3 | 181864    | 16-11 | 13:20 | x64      |
| Txunpivot.dll                                                 | 2017.140.3257.3 | 160360    | 16-11 | 13:01 | x86      |
| Txunpivot.dll                                                 | 2017.140.3257.3 | 199784    | 16-11 | 13:20 | x64      |
| Xe.dll                                                        | 2017.140.3257.3 | 595768    | 16-11 | 13:02 | x86      |
| Xe.dll                                                        | 2017.140.3257.3 | 673592    | 16-11 | 13:20 | x64      |

SQL Server 2017 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date  | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-------|-------|----------|
| Dms.dll                                                              | 13.0.9124.22     | 523848    | 16-11 | 13:15 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.22 | 78408     | 16-11 | 13:15 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.22     | 45640     | 16-11 | 13:15 | x86      |
| Instapi140.dll                                                       | 2017.140.3257.3  | 72296     | 16-11 | 13:15 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.22     | 74824     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.22     | 213576    | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.22     | 1799240   | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.22     | 116808    | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.22     | 390216    | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.22     | 196168    | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.22     | 131144    | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.22     | 63048     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.22     | 55368     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.22     | 93768     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.22     | 792648    | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.22     | 87624     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.22     | 77896     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.22     | 42056     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.22     | 36936     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.22     | 47688     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.22     | 27208     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.22     | 32328     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.22     | 129608    | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.22     | 95304     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.22     | 109128    | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.22     | 264264    | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 105032    | 16-11 | 12:48 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 119368    | 16-11 | 13:06 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 122440    | 16-11 | 12:58 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118856    | 16-11 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 129096    | 16-11 | 12:59 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 121416    | 16-11 | 12:54 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 116296    | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 149576    | 16-11 | 12:57 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 102984    | 16-11 | 12:59 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118344    | 16-11 | 13:07 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.22     | 70216     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.22     | 28744     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.22     | 43592     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.22     | 83528     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.22     | 136776    | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.22     | 2340936   | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.22     | 3860040   | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 110664    | 16-11 | 12:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123464    | 16-11 | 13:06 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 128072    | 16-11 | 12:58 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123976    | 16-11 | 12:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 136776    | 16-11 | 12:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 124488    | 16-11 | 12:54 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 121416    | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 156232    | 16-11 | 12:57 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 108616    | 16-11 | 12:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 122952    | 16-11 | 13:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.22     | 70216     | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.22     | 2756168   | 16-11 | 13:15 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.22     | 751688    | 16-11 | 13:15 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3257.3  | 407144    | 16-11 | 13:15 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3257.3  | 7328056   | 16-11 | 13:15 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3257.3  | 2264888   | 16-11 | 13:15 | x64      |
| Secforwarder.dll                                                     | 2017.140.3257.3  | 37480     | 16-11 | 13:15 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.22 | 64584     | 16-11 | 13:15 | x64      |
| Sqldk.dll                                                            | 2017.140.3257.3  | 2736440   | 16-11 | 13:15 | x64      |
| Sqldumper.exe                                                        | 2017.140.3257.3  | 145720    | 16-11 | 13:15 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3257.3  | 1500496   | 16-11 | 12:49 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3257.3  | 3919976   | 16-11 | 12:56 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3257.3  | 3218232   | 16-11 | 13:06 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3257.3  | 3923256   | 16-11 | 12:55 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3257.3  | 3826280   | 16-11 | 13:13 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3257.3  | 2092856   | 16-11 | 13:07 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3257.3  | 2039608   | 16-11 | 12:50 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3257.3  | 3593320   | 16-11 | 13:08 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3257.3  | 3601512   | 16-11 | 12:54 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3257.3  | 1447736   | 16-11 | 13:15 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3257.3  | 3790648   | 16-11 | 13:14 | x64      |
| Sqlos.dll                                                            | 2017.140.3257.3  | 26216     | 16-11 | 13:15 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.22 | 4347976   | 16-11 | 13:15 | x64      |
| Sqltses.dll                                                          | 2017.140.3257.3  | 9736504   | 16-11 | 13:15 | x64      |

SQL Server 2017 sql_shared_mr

| File   name                        | File version    | File size | Date  | Time  | Platform |
|------------------------------------|-----------------|-----------|-------|-------|----------|
| Smrdll.dll                         | 14.0.3257.3     | 23864     | 16-11 | 13:20 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3257.3 | 100456    | 16-11 | 13:19 | x64      |

SQL Server 2017 sql_tools_extensions

| File   name                                            | File version    | File size | Date  | Time  | Platform |
|--------------------------------------------------------|-----------------|-----------|-------|-------|----------|
| Autoadmin.dll                                          | 2017.140.3257.3 | 1448552   | 16-11 | 13:01 | x86      |
| Dtaengine.exe                                          | 2017.140.3257.3 | 204392    | 16-11 | 12:59 | x86      |
| Dteparse.dll                                           | 2017.140.3257.3 | 100456    | 16-11 | 12:59 | x86      |
| Dteparse.dll                                           | 2017.140.3257.3 | 111416    | 16-11 | 13:19 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3257.3 | 83792     | 16-11 | 12:59 | x86      |
| Dteparsemgd.dll                                        | 2017.140.3257.3 | 89184     | 16-11 | 13:19 | x64      |
| Dtepkg.dll                                             | 2017.140.3257.3 | 117048    | 16-11 | 12:59 | x86      |
| Dtepkg.dll                                             | 2017.140.3257.3 | 137832    | 16-11 | 13:19 | x64      |
| Dtexec.exe                                             | 2017.140.3257.3 | 67688     | 16-11 | 12:59 | x86      |
| Dtexec.exe                                             | 2017.140.3257.3 | 74064     | 16-11 | 13:19 | x64      |
| Dts.dll                                                | 2017.140.3257.3 | 2551096   | 16-11 | 12:59 | x86      |
| Dts.dll                                                | 2017.140.3257.3 | 3001144   | 16-11 | 13:19 | x64      |
| Dtscomexpreval.dll                                     | 2017.140.3257.3 | 417896    | 16-11 | 12:59 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3257.3 | 475448    | 16-11 | 13:19 | x64      |
| Dtsconn.dll                                            | 2017.140.3257.3 | 400696    | 16-11 | 12:59 | x86      |
| Dtsconn.dll                                            | 2017.140.3257.3 | 499000    | 16-11 | 13:19 | x64      |
| Dtshost.exe                                            | 2017.140.3257.3 | 91240     | 16-11 | 13:01 | x86      |
| Dtshost.exe                                            | 2017.140.3257.3 | 106088    | 16-11 | 13:20 | x64      |
| Dtslog.dll                                             | 2017.140.3257.3 | 103016    | 16-11 | 12:59 | x86      |
| Dtslog.dll                                             | 2017.140.3257.3 | 120632    | 16-11 | 13:19 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3257.3 | 541496    | 16-11 | 13:01 | x86      |
| Dtsmsg140.dll                                          | 2017.140.3257.3 | 545384    | 16-11 | 13:20 | x64      |
| Dtspipeline.dll                                        | 2017.140.3257.3 | 1060456   | 16-11 | 12:59 | x86      |
| Dtspipeline.dll                                        | 2017.140.3257.3 | 1268328   | 16-11 | 13:19 | x64      |
| Dtspipelineperf140.dll                                 | 2017.140.3257.3 | 42808     | 16-11 | 12:59 | x86      |
| Dtspipelineperf140.dll                                 | 2017.140.3257.3 | 48472     | 16-11 | 13:19 | x64      |
| Dtuparse.dll                                           | 2017.140.3257.3 | 80184     | 16-11 | 12:59 | x86      |
| Dtuparse.dll                                           | 2017.140.3257.3 | 89192     | 16-11 | 13:19 | x64      |
| Dtutil.exe                                             | 2017.140.3257.3 | 127800    | 16-11 | 12:59 | x86      |
| Dtutil.exe                                             | 2017.140.3257.3 | 148792    | 16-11 | 13:19 | x64      |
| Exceldest.dll                                          | 2017.140.3257.3 | 214840    | 16-11 | 12:59 | x86      |
| Exceldest.dll                                          | 2017.140.3257.3 | 260712    | 16-11 | 13:19 | x64      |
| Excelsrc.dll                                           | 2017.140.3257.3 | 230504    | 16-11 | 12:59 | x86      |
| Excelsrc.dll                                           | 2017.140.3257.3 | 282728    | 16-11 | 13:19 | x64      |
| Flatfiledest.dll                                       | 2017.140.3257.3 | 332600    | 16-11 | 12:59 | x86      |
| Flatfiledest.dll                                       | 2017.140.3257.3 | 386872    | 16-11 | 13:19 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3257.3 | 344376    | 16-11 | 12:59 | x86      |
| Flatfilesrc.dll                                        | 2017.140.3257.3 | 399464    | 16-11 | 13:19 | x64      |
| Foreachfileenumerator.dll                              | 2017.140.3257.3 | 80696     | 16-11 | 12:59 | x86      |
| Foreachfileenumerator.dll                              | 2017.140.3257.3 | 96360     | 16-11 | 13:19 | x64      |
| Microsoft.sqlserver.astasks.dll                        | 14.0.3257.3     | 72808     | 16-11 | 13:00 | x86      |
| Microsoft.sqlserver.astasksui.dll                      | 14.0.3257.3     | 186464    | 16-11 | 13:00 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3257.3     | 409704    | 16-11 | 13:00 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3257.3     | 409696    | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3257.3     | 2093368   | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3257.3     | 2093368   | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3257.3     | 614200    | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3257.3     | 614200    | 16-11 | 13:19 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll | 14.0.3257.3     | 252728    | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3257.3 | 142136    | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3257.3 | 152168    | 16-11 | 13:19 | x64      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3257.3 | 145512    | 16-11 | 13:01 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3257.3 | 159544    | 16-11 | 13:19 | x64      |
| Msdtssrvrutil.dll                                      | 2017.140.3257.3 | 90424     | 16-11 | 12:59 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3257.3 | 103224    | 16-11 | 13:19 | x64      |
| Msmgdsrv.dll                                           | 2017.140.249.21 | 7304584   | 16-11 | 13:01 | x86      |
| Oledbdest.dll                                          | 2017.140.3257.3 | 214632    | 16-11 | 12:59 | x86      |
| Oledbdest.dll                                          | 2017.140.3257.3 | 261224    | 16-11 | 13:19 | x64      |
| Oledbsrc.dll                                           | 2017.140.3257.3 | 233272    | 16-11 | 12:59 | x86      |
| Oledbsrc.dll                                           | 2017.140.3257.3 | 288872    | 16-11 | 13:19 | x64      |
| Sql_tools_extensions_keyfile.dll                       | 2017.140.3257.3 | 100456    | 16-11 | 13:19 | x64      |
| Sqlresld.dll                                           | 2017.140.3257.3 | 28984     | 16-11 | 13:01 | x86      |
| Sqlresld.dll                                           | 2017.140.3257.3 | 31032     | 16-11 | 13:20 | x64      |
| Sqlresourceloader.dll                                  | 2017.140.3257.3 | 29288     | 16-11 | 13:01 | x86      |
| Sqlresourceloader.dll                                  | 2017.140.3257.3 | 32568     | 16-11 | 13:20 | x64      |
| Sqlscm.dll                                             | 2017.140.3257.3 | 62264     | 16-11 | 13:01 | x86      |
| Sqlscm.dll                                             | 2017.140.3257.3 | 72808     | 16-11 | 13:20 | x64      |
| Sqlsvc.dll                                             | 2017.140.3257.3 | 135272    | 16-11 | 13:01 | x86      |
| Sqlsvc.dll                                             | 2017.140.3257.3 | 162920    | 16-11 | 13:20 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3257.3 | 155240    | 16-11 | 13:01 | x86      |
| Sqltaskconnections.dll                                 | 2017.140.3257.3 | 183904    | 16-11 | 13:20 | x64      |
| Txdataconvert.dll                                      | 2017.140.3257.3 | 253240    | 16-11 | 13:01 | x86      |
| Txdataconvert.dll                                      | 2017.140.3257.3 | 293176    | 16-11 | 13:20 | x64      |
| Xe.dll                                                 | 2017.140.3257.3 | 595768    | 16-11 | 13:02 | x86      |
| Xe.dll                                                 | 2017.140.3257.3 | 673592    | 16-11 | 13:20 | x64      |
| Xmlrw.dll                                              | 2017.140.3257.3 | 257640    | 16-11 | 13:02 | x86      |
| Xmlrw.dll                                              | 2017.140.3257.3 | 305464    | 16-11 | 13:20 | x64      |
| Xmlrwbin.dll                                           | 2017.140.3257.3 | 189752    | 16-11 | 13:02 | x86      |
| Xmlrwbin.dll                                           | 2017.140.3257.3 | 224360    | 16-11 | 13:20 | x64      |

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
