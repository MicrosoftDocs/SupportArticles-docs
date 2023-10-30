---
title: SQL Server 2016 Service Pack 3 release information (KB5003279)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 Service Pack 3 release information (KB5003279).
ms.date: 10/26/2023
ms.custom: KB5003279
appliesto:
- SQL Server 2016
- SQL Server 2016 Service Pack 3
---

# KB5003279 - SQL Server 2016 Service Pack 3 release information

_Release Date:_ &nbsp; September 15, 2021  
_Version:_ &nbsp; 13.0.6300.2

This article contains important information to read before you install Microsoft SQL Server 2016 Service Pack 3 (SP3). It describes how to get the service pack, the list of fixes that are included in the service pack, known issues, and a list of copyright attributions for the product.

> [!NOTE]
> This article serves as a single source of information to locate all documentation that's related to this service pack. It includes all the information that you previously found in the release notes and Readme.txt files.

## Known issues in this update

If you use the Change Tracking feature, you might encounter errors. For more information, see [KB5007039](https://support.microsoft.com/help/5007039) before you apply this update package.

## List of fixes included in SQL Server 2016 SP3

Microsoft SQL Server 2016 service packs are cumulative updates. SQL Server 2016 SP3 upgrades all editions and service levels of SQL Server 2016 to SQL Server 2016 SP3. In addition to the fixes that are listed in this article, SQL Server 2016 SP3 includes hotfixes that were included in [SQL Server 2016 Cumulative Update 1 (CU1)](rtm-cumulativeupdate1.md) to [SQL Server 2016 SP2 CU17](servicepack2-cumulativeupdate17.md).

For more information about the cumulative updates that are available in SQL Server 2016, see [SQL Server 2016 build versions](build-versions.md).

> [!NOTE]
>
> - Additional fixes that aren't documented here may also be included in the service pack.
> - This list will be updated when more articles are released.

For more information about the bugs that are fixed in SQL Server 2016 SP3, go to the following Microsoft Knowledge Base articles.

| Bug reference| Area Path| Description|
|----------------------------------------------------------------------------------------------|------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <a id=14048342>[14048342](#14048342) </a>| [Improvement: Availability Group listener without the load balancer in SQL Server 2019, 2017, and 2016 (KB4578579)](https://support.microsoft.com/help/4578579)| High Availability |
| <a id=12344341>[12344341](#12344341) </a>| [FIX: Transaction log isn't truncated on a single node Availability Group in SQL Server (KB4515772)](https://support.microsoft.com/help/4515772)| High Availability |
| <a id=13323519>[13323519](#13323519) </a>| [FIX: Non-yielding Scheduler error may occur with Always On availability group in Microsoft SQL Server (KB4541303)](https://support.microsoft.com/help/4541303)| High Availability |
| <a id=14059362>[14059362](#14059362) </a>| [FIX: Log line is verbose when Always On Availability Group has many databases in SQL Server 2019 and 2016 (KB5003596)](https://support.microsoft.com/help/5003596)| High Availability |
| <a id=13829857>[13829857](#13829857) </a>| Fixes an access violation exception that may occur when `sp_server_diagnostics` is executed.| High Availability|
| <a id=14031841>[14031841](#14031841) </a>| Fixes an issue that causes the database `log_reuse_wait_desc` to change to `AVAILABILITY_REPLICA` when a database is removed from Availability Group.|High Availability |
| <a id=13435419>[13435419](#13435419) </a>| Fixes security vulnerabilities [CVE-2015-6420](https://nvd.nist.gov/vuln/detail/CVE-2015-6420) and [CVE-2017-15708](https://nvd.nist.gov/vuln/detail/CVE-2017-15708) | Integration Services |
| <a id=13163658>[13163658](#13163658) </a>| [FIX: Setup fails when you install SQL Server on FCI with mount points (KB5005686)](https://support.microsoft.com/help/5005686)| Setup & Install |
| <a id=14056703>[14056703](#14056703) </a>| [Improvement: Enable DNN feature in SQL Server 2019 and 2016 FCI (KB4537868)](https://support.microsoft.com/help/4537868) | SQL Connectivity |
| <a id=13526297>[13526297](#13526297) </a>| [INSERT EXEC failed because the stored procedure altered the schema of the target table error in SQL Server 2016](../../database-engine/general/error-556-insert-exec-failed.md) |SQL Engine |
| <a id=12670403>[12670403](#12670403) </a>| [Improvement: Improve CDC supportability and usability with In-Memory Databases (KB4500511)](https://support.microsoft.com/help/4500511) | SQL Engine |
| <a id=13330609>[13330609](#13330609) </a>| [Improvement: Size and retention policy are increased in default XEvent trace system_health in SQL Server 2019, 2017, and 2016 (KB4541132)](https://support.microsoft.com/help/4541132) | SQL Engine |
| <a id=13032229>[13032229](#13032229) </a>| [Improvement: New XEvents temp_table_cache_trace and temp_table_destroy_list_trace are created in SQL Server 2019 and 2016 (KB5003937)](https://support.microsoft.com/help/5003937) | SQL Engine |
| <a id=11324212>[11324212](#11324212) </a>| [FIX: Assertion occurs when you access memory-optimized table through MARS in SQL Server 2017 or 2016 (KB4046056)](https://support.microsoft.com/help/4046056) | SQL Engine |
| <a id=12920913>[12920913](#12920913) </a>| [FIX: Error occurs when sp_addarticle is used to add article for transactional replication to memory-optimized table on subscriber in SQL Server 2017 and 2016 (KB4493329)](https://support.microsoft.com/help/4493329) | SQL Engine |
| <a id=13048725>[13048725](#13048725) </a>| [FIX: Geocentric Datum of Australia 2020 is added to SQL Server 2017, 2016, and 2014 (KB4506023)](https://support.microsoft.com/help/4506023) | SQL Engine |
| <a id=13186160>[13186160](#13186160) </a>| [FIX: SQL update package does not update Local DB files correctly when installed using SqlLocalDb.msi (KB4526524)](https://support.microsoft.com/help/4526524) | SQL Engine |
| <a id=12107073>[12107073](#12107073) </a>| [FIX: Assertion occurs when sys.sp_cdc_enable_table is used to enable CDC on column set table in SQL Server 2017 and 2016 (KB4531386)](https://support.microsoft.com/help/4531386) |SQL Engine |
| <a id=13128336>[13128336](#13128336) </a>| [FIX: Fix incorrect memory page accounting that causes out-of-memory errors in SQL Server (KB4536005)](https://support.microsoft.com/help/4536005) |SQL Engine |
| <a id=13127842>[13127842](#13127842) </a>| [FIX: Access violation exception occurs when promoting latches of frequently used database pages in SQL Server 2017 and 2016 (KB4551720)](https://support.microsoft.com/help/4551720) | SQL Engine |
| <a id=13345987>[13345987](#13345987) </a>| [FIX: Managed backup fails to take full backup when backup preference is set to secondary on Read-Only secondary in SQL Server 2016 (KB5004059)](https://support.microsoft.com/help/5004059) |SQL Engine |
| <a id=14048422>[14048422](#14048422) </a>| [FIX: Update SQL Server 2017 and 2016 CEIP service to send usage and diagnostic data to a new endpoint (KB5004466)](https://support.microsoft.com/help/5004466) | SQL Engine |
| <a id=14037575>[14037575](#14037575) </a>| [FIX: SQLLocalDB.exe info doesn't display information about the specified LocalDB instance if SQL LocalDB 2016 SP2 is installed (KB5005453)](https://support.microsoft.com/help/5005453) |SQL Engine |
| <a id=13327250>[13327250](#13327250) </a>| [FIX: "SQLLocalDB.exe versions" stops listing the versions of LocalDB installed on the computer if SQL LocalDB 2016 SP1/SP2 is installed (KB5005687)](https://support.microsoft.com/help/5005687) | SQL Engine |
| <a id=13965515>[13965515](#13965515) </a>| Fixes `EXCEPTION_INVALID_CRT_PARAMETER` exception when you perform `INSERT`\\`UPDATE` of wide replicated table. | SQL Engine |
| <a id=13990061>[13990061](#13990061) </a>| Fixes a memory leak when you use STDistance spatial method with a spatial index. | SQL Engine |
| <a id=13992219>[13992219](#13992219) </a>| Fixes the `sp_hadr_verify_replication_publisher` displaying wrong distribution database name in error message. | SQL Engine |
| <a id=14034656>[14034656](#14034656) </a>| Introduces new logging and XEvents to help troubleshoot long-running Buffer Pool scans. For more information, see [Operations that scan SQL Server buffer pool are slow on large memory machines](../../database-engine/performance/buffer-pool-scan-runs-slowly-large-memory-machines.md). | SQL Engine |
| <a id=14042368>[14042368](#14042368) </a>| Fixes an issue in which some of the temporary working folders aren't cleared when many R queries are run in parallel. | SQL Engine |
| <a id=14043334>[14043334](#14043334) </a>| Fixes the following assertion that may cause SQL Server to generate a dump: </br></br>RecXdes::AnalyzeLogRecord file =FilePath\FileName line = LineNumber expression = m_state == XDES_COMMITTED | SQL Engine |
| <a id=14068486>[14068486](#14068486) </a>| Fixes an issue where you are unable to set up Managed Backup on SQL Server 2016 by using Azure SAS credential with a long secret due to SAS expiration. |SQL Engine |
| <a id=14072767>[14072767](#14072767) </a>| Enables new logging format for SQL Writer that provides additional troubleshooting data in an easy to read/parse format, along with enhanced control of log verbosity and enabling/disabling. For more information, see [SQL Server VSS Writer logging](/sql/relational-databases/backup-restore/sql-server-vss-writer-logging). |SQL Engine |
| <a id=14117764>[14117764](#14117764) </a>| Fixes Snapshot Agent performance issue observed on SQL 2016 SP2 CU13 and later. |SQL Engine |
| <a id=14130908>[14130908](#14130908) </a>| Fixes a missing data problem in Change Data Capture (CDC) side table and adds more error handling to prevent data loss. | SQL Engine |
| <a id=14187407>[14187407](#14187407) </a>| Fixes an issue where you cannot run Machine Learning Services (R scripts) when you slipstream an installation of Microsoft SQL Server 2016 without [vc_redist 2015 (msvcp140.dll)](https://www.microsoft.com/download/details.aspx?id=48145). | SQL Engine |
| <a id=14193631>[14193631](#14193631) </a>|  Fixes an issue where an access violation (AV) occurs and you see keywords `EXCEPTION_ACCESS_VIOLATION` and `FFtFileObject::ProcessSetInfo` in the SQL Server error log when you use the FileTable feature in SQL Server on the machine that uses Windows Defender Antivirus. </br></br>**Note**: This issue can occur after Windows Defender updates on Windows 10, version 1607 or a later version, Windows Server 2016, and Windows Server 2019. |SQL Engine |
| <a id=12904837>[12904837](#12904837) </a>| [Improvement: Enhancement adds sql_statement_post_compile XEvent in SQL Server 2017 and 2016 (KB4480630)](https://support.microsoft.com/help/4480630) |SQL Performance|
| <a id=11985415>[11985415](#11985415) </a> </br><a id=13377244>[13377244](#13377244) </a> | [Improvement: Corrupt statistics can be detected by using extended_logical_checks in SQL Server 2019 and 2016 (KB4530907)](https://support.microsoft.com/help/4530907)|SQL Performance |
| <a id=12994428>[12994428](#12994428) </a>| Makes CPU time and duration reported by xevent `query_plan_profile` more accurate. For more information, see [Query Profiling Infrastructure](/sql/relational-databases/performance/query-profiling-infrastructure#lightweight-query-execution-statistics-profiling-infrastructure-v2).| SQL Performance |
| <a id=13989322>[13989322](#13989322) </a>| Fixes the Access Violation error that occurs when `ALTER INDEX` is forced to execute using Query Store.| SQL Performance |
| <a id=14056563>[14056563](#14056563) </a>| Fixes a stack overflow issue when you run a query that has a very large number of `UNION` clauses.| SQL Performance |
| <a id=14080827>[14080827](#14080827) </a>| Fixes an assertion in CQPOnDemandTask::ExecuteQPJob if auto async update statistics is enabled.|SQL Performance |
| <a id=10087766>[10087766](#10087766) </a>| [FIX: SQL Server fails to start with error messages when an incorrect certificate is provisioned for SSL (KB5005689)](https://support.microsoft.com/help/5005689) | SQL Security |

## How to get SQL Server 2016 SP3

SQL Server 2016 SP3, Microsoft SQL Server 2016 SP3 Express, and Microsoft SQL Server 2016 SP3 Feature Pack are available for manual download and installation at the following Microsoft Download Center websites.

- [SQL Server 2016 SP3](https://www.microsoft.com/download/details.aspx?id=103440)

- [SQL Server 2016 SP3 Express](https://www.microsoft.com/download/details.aspx?id=103447)

- [Microsoft SQL Server 2016 SP3 Feature Pack](https://www.microsoft.com/download/details.aspx?id=103444)

> [!NOTE]
> After you install this service pack, the SQL Server service version should be 13.0.6300.2. Microsoft SQL Server 2016 service packs are cumulative updates. SQL Server 2016 SP3 upgrades all editions and service levels of SQL Server 2016 to SQL Server 2016 SP3.

## File information

<details>
<summary><b>File hash information</b></summary>

| File   name                            | SHA256 hash                                                      |
|----------------------------------------|------------------------------------------------------------------|
| SQLServer2016SP3-KB5003279-x64-ENU.exe | CAE75F65C7C3C263A7BDBAEF0F4AFD0AE49BAF57C08AB27141A7B26008658A91 |
| SQLServer2016-SSEI-Expr.exe            | 25692917049A856B9CCEA2C1242F42A1A585D3AD94F1F449E93BE183F17C397A |

</details>

## Notes for this update

For more information about how to upgrade your SQL Server installation to SQL Server 2016 SP3, see [Supported Version and Edition Upgrades](/sql/database-engine/install-windows/supported-version-and-edition-upgrades).

<details>
<summary><b>Uninstalling SQL Server 2016 SP3 (not recommended)</b></summary>

If, for any reason, you choose to uninstall SQL Server 2016 SP3, the uninstallation of SQL Server 2016 SP3 will not be blocked, and you will be able to uninstall SQL Server 2016 SP3 in the same manner as any other service packs. However, if you are running the Standard, Web, or Express edition of SQL Server, and you are using some new features that are unlocked only when you start SQL Server 2016 SP3, you might experience errors or see databases left in a suspect state after the uninstallation of SQL Server 2016 SP3. Even worse, if the system databases are using new features (for example, partitioned tables in master databases), this could prevent SQL Server instances from starting after you uninstall SQL Server 2016 SP3.

We recommend that you verify that all the new features are disabled or dropped before you choose to uninstall SQL Server 2016 SP3 on editions other than the Enterprise edition. You cannot drop the [memory_optimized_data](/sql/relational-databases/in-memory-oltp/the-memory-optimized-filegroup) filegroup on your database with SP3, you should not uninstall SQL Server 2016 SP3. Otherwise, the database will get into a suspect state, and the following entry will be logged in the error log:

> \<DateTime> Error: 41381, Severity: 21, State: 1.</br>\<DateTime> The database cannot be started in this edition of SQL Server because it contains a MEMORY_OPTIMIZED_DATA filegroup. See Books Online for more details on feature support in different SQL Server editions.

</details>

<details>
<summary><b>How to intall R Services</b></summary>

To learn how to install SQL Server 2016 R Services on Windows, see [Install SQL Server 2016 R Services](/sql/machine-learning/install/sql-r-services-windows-install)

</details>

<details>
<summary><b>Copyright attributions</b></summary>

- This product contains software derived from the Xerox Secure Hash Function.

- This product includes software from the zlib general purpose compression library.

- Parts of this software are based in part on the work of RSA Data Security, Inc. Because Microsoft has included the RSA Data Security, Inc., software in this product, Microsoft is required to include the text below that accompanied such software:
  - Copyright 1990, RSA Data Security, Inc. All rights reserved.
  
  - License to copy and use this software is granted provided that it is identified as the "RSA Data Security, Inc., MD5 Message-Digest Algorithm" in all material mentioning or referencing this software or this function. License is also granted to make and use derivative works provided that such works are identified as "derived from the RSA Data Security, Inc., MD5 Message-Digest Algorithm" in all material mentioning or referencing the derived work.
  - RSA Data Security, Inc., makes no representations concerning either the merchantability of this software or the suitability of this software for any particular purpose. It is provided "as is" without express or implied warranty of any kind.
  
  These notices must be retained in any copies of any part of this documentation or software.

- The Reporting Services mapping feature uses data from TIGER/Line Shapefiles that are provided courtesy of the [United States Census Bureau](https://www.census.gov/). TIGER/Line Shapefiles are an extract of selected geographic and cartographic information from the Census MAF/TIGER database. TIGER/Line Shapefiles are available without charge from the United States Census Bureau. To get more information about the TIGER/Line shapefiles, go to [TIGER/Line shapefiles](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html). The boundary information in the TIGER/Line Shapefiles is for statistical data collection and tabulation purposes only; its depiction and designation for statistical purposes does not constitute a determination of jurisdictional authority, rights of ownership, or entitlement, and does not reflect legal land descriptions. Census TIGER and TIGER/Line are registered trademarks of the United States Census Bureau.

Copyright 2012 Microsoft. All rights reserved.

</details>

## References

For more information about how to determine the current SQL Server version and edition, select the following article number to go to the article in the Microsoft Knowledge Base:

[321185](https://support.microsoft.com/help/321185) How to identify your SQL Server version and edition

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
