---
title: Recommended updates and configuration options
description: This article includes a list of performance improvements and configuration options that are available for SQL Server 2014 and 2012.
ms.date: 06/12/2025
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.reviewer: ramakoni, Sureshka, jopilov
ms.topic: how-to
---
# Recommended updates and configuration options for SQL Server 2014 and 2012 with high-performance workloads

This article includes a list of performance improvements and configuration options that are available for SQL Server 2014 and SQL Server 2012.

_Original product version:_ &nbsp; SQL Server 2014, SQL Server 2012  
_Original KB number:_ &nbsp; 2964518

## Apply the recommended updates and improve the performance of SQL Server 2014 and SQL Server 2012

This article describes the performance improvements and changes that are available for SQL Server 2014 and SQL Server 2012 versions through various product updates and configuration options. You can consider applying these updates in order to improve the performance of the instance of SQL Server. The degree of improvement that you see will depend on various factors that include workload pattern, contention points, processor layout (number of processor groups, sockets, NUMA nodes, cores in a NUMA node) and amount of memory present in the system. SQL Server support team has used these updates and configuration changes to achieve reasonable performance gains for customer workloads that used hardware systems that had several NUMA nodes and lots of processors. The support team will continue to update this article with other updates in the future.

High-end systems
A high-end system typically has multiple sockets, eight cores or more per socket, and a half terabyte or more of memory.

> [!NOTE]
> In SQL Server 2016 and later versions, many of the trace flags mentioned in this article is the default behavior and you don't have to enable them in those versions.

The recommendations are grouped into three tables as follows:

- [Table 1](#table-1-important-updates-and-trace-flags-for-high--end-systems) contains the most frequently recommended updates and trace flags for scalability on high-end systems.
- [Table 2](#table-2-general-considerations-and-best-practices-for-improving-performance-of-your-instance-of-sql-server) contains recommendations and guidance for additional performance tuning.
- [Table 3](#table-3-performance-fixes-that-are-included-in-a-cumulative-update) contains additional scalability fixes that were included together with a cumulative update.

## Table 1. Important updates and trace flags for high- end systems

Review the following table and enable the trace flags in the Trace flag column after you make sure that your instance of SQL Server meets the requirements in the **Applicable Version and build ranges** column.

> [!NOTE]
>
> - Applicable Version and build indicates the specific update in which the change or trace flag was introduced. If no CU is specified, then all CU's in the SP are included.
>
> - Not Applicable Version and build indicates the specific update in which the change or trace flag became the default behavior. Therefore, just applying that update will be enough to get the benefits.

> [!IMPORTANT]
> When you enable fixes with trace flags in Always On environments, please be aware that you have to enable the fix and trace flags on all the replicas that are part of the Availability Group.

| Scenario and symptom to consider| Trace flag| Applicable Version and build ranges| Not Applicable Version and build ranges| Knowledge Base article/Blog link that provides more details |
|---|---|---|---|---|
|<ul><li>You encounter high CMEMTHREAD waits. </li><li>SQL Server is installed on systems with 8 or more cores per socket.</li></ul>|T8048|<ul><li>SQL Server 2012 RTM to current Service Pack (SP)/CU </li><li>SQL Server 2014 RTM to SP1</li></ul>|<ul><li>SQL Server 2014 SP2 to current SP/CU </li><li>SQL Server 2016 RTM to current SP/CU </li><li>SQL Server 2017 RTM to current SP/CU</li></ul>| |
|<ul><li>You encounter high CMEMTHREAD waits.</li><li>SQL Server is installed on systems with 8 or more cores per socket.</li></ul>| T8079| SQL Server 2014 SP2 to current SP/CU|<ul><li> SQL Server 2016 RTM to current SP/CU </li><li>SQL Server 2017 RTM to current SP/CU</li></ul>| <ul><li>[Soft-NUMA (SQL Server)](/sql/database-engine/configure-windows/soft-numa-sql-server)</li><li> [SQL Server 2014 Service Pack 2 is now Available !!!](/archive/blogs/sqlreleaseservices/sql-2014-service-pack-2-is-now-available)</li></ul> |
|<ul><li>You are using features that rely on log pool cache. (for example, Always On)</li><li>SQL Server is installed on systems with multiple sockets.</li></ul>|T9024| [Cumulative update package 3 for SQL Server 2012 Service Pack 1](https://support.microsoft.com/help/2812412) to SP2 SQL Server 2014 RTM|<ul><li>SQL Server 2012 SP3 to current SP/CUSQL </li><li>Server 2014 SP1 to current SP/CU </li><li>SQL Server 2016 RTM to current SP/CU </li><li>SQL Server 2017 RTM to current SP/CU</li></ul>| [FIX: High "log write waits" counter value on a SQL Server 2012 or SQL Server 2014 instance](https://support.microsoft.com/help/2809338) |
|Your instance of SQL Server is handling thousands of connection resets because of connection pooling.|T1236| [Cumulative update package 9 for SQL Server 2012 Service Pack 1](https://support.microsoft.com/help/2931078) to SP2 [Cumulative Update 1 for SQL Server 2014](https://support.microsoft.com/help/2931693)|<ul><li>SQL Server 2012 SP3 to current SP/CUSQL </li><li>Server 2014 SP1 to current SP/CUSQL </li><li>Server 2016 RTM to current SP/CU </li><li>SQL Server 2017 RTM to current SP/CU</li></ul>| |
|<ul><li>Your application workload involves frequent tempdb usage (creation and drop of temp tables or table variables).</li><li>You notice user requests waiting for tempdb page resources because of allocation contention.</li></ul>|T1118| <ul><li>SQL Server 2012 RTM to current SP/CU </li><li>SQL Server 2014 RTM to current SP/CU</li></ul>|<ul><li>SQL Server 2016 RTM to current SP/CU </li><li>SQL Server 2017 RTM to current SP/CU</li></ul>| [Concurrency enhancements for the tempdb database](https://support.microsoft.com/help/328551)  <br/><br/>**NOTE** Enable the trace flag and add multiple data files for the tempdb database. |
|<ul><li>You have multiple tempdb data files.</li><li>The data files at first are set to the same size.</li><li>Because of heavy activity, tempdb files encounter growth and not all files grow at the same time and cause allocation contention.</li></ul>|T1117| <ul><li>SQL Server 2012 RTM to current SP/CU </li><li>SQL Server 2014 RTM to current SP/CU</li></ul>|<ul><li>SQL Server 2016 RTM to current SP/CU </li><li>SQL Server 2017 RTM to current SP/CU</li></ul>| [Recommendations to reduce allocation contention in SQL Server tempdb database](https://support.microsoft.com/help/2154845)  |
| Heavy `SOS_CACHESTORE` spinlock contention or your plans are being evicted frequently on ad hoc query workloads.| T174| <ul><li>SQL Server 2012 SP1 CU14 to current SP/CU </li><li>[SQL Server 2014 RTM CU6](https://support.microsoft.com/help/3031047) to current SP/CU</li></ul>| None|<ul><li>Documentation of [DBCC TRACEON - Trace Flags (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql) </li><li>See Cache Size Management section of [Plan Cache Internals](/previous-versions/tn-archive/cc293624%28v=technet.10%29#cache-size-management)</li><ul> |
|<ul><li>Entries in the plan cache are evicted because of growth in other caches or memory clerks </li><li>High CPU consumption due to frequent recompiles of queries</li></ul>| T8032|<ul><li>SQL Server 2012 RTM to current SP/CU </li><li>SQL Server 2014 RTM to current SP/CU</li></ul>| None|<ul><li>Documentation of [DBCC TRACEON - Trace Flags (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql)</li><li> See Cache Size Management section of [Plan Cache Internals](/previous-versions/tn-archive/cc293624%28v=technet.10%29#cache-size-management)</li><ul> |
| Existing statistics are not frequently updated because of the large number of rows in the table.| T2371|<ul><li>SQL Server 2012 RTM to current SP/CU </li><li>SQL Server 2014 RTM to current SP/CU</li></ul>| None| |
|<ul><li>Statistics jobs take a long time to complete. </li><li>Cannot execute multiple statistics update jobs in parallel.</li></ul>| T7471| SQL Server 2014 SP1 CU6 to current SP/CU| None|  [Boosting Update Statistics performance with SQL 2014 & SQL 2016](/archive/blogs/sql_server_team/boosting-update-statistics-performance-with-sql-2014-sp1cu6) |
| CHECKDB command takes a long time for large databases.| <ul><li>T2562 </li><li> T2549</li><ul>|<ul><li>SQL Server 2012 RTM to current SP/CU </li><li>SQL Server 2014 RTM to current SP/CU| None|  |
| CHECKDB command takes a long time for large databases.| T2566|<ul><li>SQL Server 2012 RTM to current SP/CU </li><li>SQL Server 2014 RTM to current SP/CU</li></ul>| None|<ul><li>See T2566 details in [DBCC TRACEON - Trace Flags (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql).</li><li> [A faster CHECKDB in SQL Server (Part IV)](/archive/blogs/psssql/a-faster-checkdb-part-iv-sql-clr-udts)</li></ul> |
| Executing concurrent data warehouse queries that take long compile-time results in `RESOURCE_SEMAPHORE_QUERY_COMPILE` waits.| T6498| [Cumulative update package 6 for SQL Server 2014](https://support.microsoft.com/help/3031047) to SP1|<ul><li>SQL Server 2014 SP2 to current SP/CUSQL </li><li>Server 2016 RTM to current SP/CU </li><li>SQL Server 2017 RTM to current SP/CU</li></ul>| |
|You are troubleshooting specific query performance issues Optimizer fixes are disabled by default.| T4199|<ul><li>SQL Server 2012 RTM to SP4 </li><li>SQL Server 2014 RTM to latest</li></ul>| None| |
| You experience slow performance using query operations with spatial data types.|<ul><li>T6532</li><li>T6533</li><li> T6534</li></ul>|<ul><li>SQL Server 2012 SP3 to current SP/CU </li><li>SQL Server 2014 SP2 to current SP/CU</li><ul>| <ul><li>SQL Server 2016 RTM to current SP/CU </li><li>SQL Server 2017 RTM to current SP/CU</li><ul>| |
| <ul><li>Queries encounter `SOS_MEMORY_TOPLEVELBLOCKALLOCATOR` and CMEMTHREAD waits. </li><li>There is low available virtual address space for the SQL Server process. </li></ul>| T8075|<ul><li>SQL Server 2012 SP2 CU8 to current SP/CU </li><li>SQL Server 2014 RTM CU10 to current SP/CU</li></ul>| <ul><li>SQL Server 2016 RTM to current SP/CU </li><li>SQL Server 2017 RTM to current SP/CU</li></ul>| [FIX: Out of memory error when the virtual address space of the SQL Server process is low in SQL Server](https://support.microsoft.com/help/4077105)  |
| <ul><li>SQL Server is installed on a machine with large amounts of memory.</li><li> Creating new databases takes a long time.</li></ul>| T3449| <ul><li>SQL Server 2012 SP3 CU3 to current SP/CU </li><li>SQL Server 2014 RTM CU14 to current RTM CU </li><li>SQL Server 2014 SP1 CU7 to current SP/CU</li></ul>| <ul><li>SQL Server 2016 RTM to current SP/CU </li><li>SQL Server 2017 RTM to current SP/CU</li></ul>| [FIX: SQL Server database creation on a system with a large volume of memory takes longer than expected](https://support.microsoft.com/help/3158396)  |

## Table 2. General considerations and best practices for improving performance of your instance of SQL Server

Review the content in the Knowledge Base article/Books Online Resource column and consider implementing the guidance in the Recommended actions column.

| Knowledge Base article/Books Online resource| Recommended actions |
|---|---|
| [Configure the max degree of parallelism Server Configuration Option](/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option) |Use the sp_configure stored procedure to make configuration changes to [Configure the max degree of parallelism Server Configuration Option](/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option) for your instance of SQL Server as per the Knowledge Base article.|
| [Compute capacity limits by edition of SQL Server](/sql/sql-server/compute-capacity-limits-by-edition-of-sql-server)|Enterprise Edition with Server + Client Access License (CAL) licensing is limited to 20 cores per SQL Server instance. There are no limits under the Core-based Server Licensing model. Consider upgrading your edition of SQL Server to the appropriate SKU to leverage all hardware resources.|
| [Slow Performance on Windows Server when using the "Balanced" Power Plan](https://support.microsoft.com/help/2207548) |Review the article, and work with your Windows administrator to implement one of the solutions that are noted in the "Resolution" section of the article.|
| |Manually assign NUMA nodes to K-groups. |
| [Optimize for ad hoc workloads](/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option) [FORCED PARAMETERIZATION](/sql/relational-databases/query-processing-architecture-guide#ForcedParamGuide)| Entries in the plan cache are evicted because of growth in other caches or memory clerks. You might also encounter plan cache eviction when the cache reaches its maximum number of entries. In addition to trace flag 8032 discussed above, consider the [optimize for ad hoc workloads](/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option) server option and also the [FORCED PARAMETERIZATION](/sql/relational-databases/query-processing-architecture-guide#ForcedParamGuide) database option. |
| [How to reduce paging of buffer pool memory in SQL Server](https://support.microsoft.com/help/918483) |Assign the [Lock Pages in Memory Option (Windows)](/sql/database-engine/configure-windows/enable-the-lock-pages-in-memory-option-windows) user right to the SQL service Startup account. Set maximum server memory to approximately 90 percent of total physical memory. Make sure that the [Server memory configuration options](/sql/database-engine/configure-windows/server-memory-server-configuration-options) setting accounts for memory from only the nodes that are configured to use affinity mask settings.|
| [SQL Server and Large Pages Explained...](/archive/blogs/psssql/sql-server-and-large-pages-explained) [Tuning options for SQL Server when running in high performance workloads](https://support.microsoft.com/help/920093)| Consider enabling TF 834 if you have a server with a large amount of memory, particularly with an analytical or data warehousing workload. Keep in mind that [TF 834 is not recommended if you are using columnstore indexes](https://support.microsoft.com/kb/3210239). |
| [Description of the "access check cache bucket count" and "access check cache quota" options that are available in the sp_configure stored procedure](/sql/database-engine/configure-windows/access-check-cache-server-configuration-options)|Use [access check cache Server Configuration Options](/sql/database-engine/configure-windows/access-check-cache-server-configuration-options) to configure these values per the recommendations in the Knowledge Base article. Recommended values for high-end systems are as follows:<br/>"access check cache bucket count": 256<br/>"access check cache quota": 1024<br/> <br/>|
| [ALTER WORKLOAD GROUP](/sql/t-sql/statements/alter-workload-group-transact-sql) [Memory grant query hints](https://support.microsoft.com/help/3107401)| If you have many queries that are exhausting large memory grants, reduce `request_max_memory_grant_percent` for the default workload group in the resource governor configuration from the default 25 percent to a lower value. New query memory grant options are available (`min_grant_percent` and `max_grant_percent`) in SQL Server |
| [Instant File initialization](/sql/relational-databases/databases/database-instant-file-initialization)|Work with your Windows administrator to grant the SQL Server service account the "Perform Volume Maintenance Tasks" user right as per the information in the Books Online topic. |
| [Considerations for the "autogrow" and "autoshrink" settings in SQL Server](https://support.microsoft.com/help/315512) |Check the current settings of your database and make sure that they are configured as per the recommendations in the Knowledge Base article.|
| [Database Checkpoints (SQL Server)](/sql/relational-databases/logs/database-checkpoints-sql-server)|Consider enabling indirect checkpoints on user databases to optimize I/O behavior in SQL Server 2012 and 2014. |
| [FIX: Slow synchronization when disks have different sector sizes for primary and secondary replica log files in SQL Server AG and Logshipping environments](https://support.microsoft.com/kb/3009974) | If you have an Availability Group where the transaction log on the primary replica is on a disk with 512-byte sector size and the secondary replica's transaction log is on a drive with 4K sector size, you may have an issue where synchronization is slow. In these cases, enabling TF 1800 should correct the issue. For more information, see [Trace Flag 1800](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf1800).|
|<ul><li> [Developers Choice: Query progress - anytime, anywhere](/archive/blogs/sql_server_team/query-progress-anytime-anywhere) </li><li>[Update to expose per-operator query execution statistics in showplan XML and Extended Event in SQL Server 2014 SP2](https://support.microsoft.com/kb/3170113)</li></ul> | If your SQL Server is not already CPU bound and a 1.5% to 2% overhead is negligible for your workloads, we recommend you enable TF 7412 as a startup trace flag. This flag enables lightweight profiling in SQL Server 2014 SP2 or later, which will give you the ability to do live query troubleshooting in production environments. |
  
## Table 3. Performance fixes that are included in a cumulative update

Review the description in the Symptoms column and apply the required updates in the Required update column in applicable environments. You can review the Knowledge Base article for more information about the respective issues. These recommendations do not require you to enable additional trace flags as startup parameters. Just applying the latest Cumulative Update or Service Pack that includes these fixes is enough to get the benefit.

> [!NOTE]
> The CU name in the **Required update** column provides the first cumulative update of SQL Server that resolves this issue. A cumulative update contains all the hotfixes and all the updates that were included with the previous SQL Server update release. Therefore, we recommend that you install [the latest cumulative update](https://support.microsoft.com/help/957826) in order to resolve the issues.

| Symptoms| Required update| Knowledge Base article |
|---|---|---|
|Eager writes during Select-into for temp tables causes performance issues.| [SQL Server 2012 SP2 CU1](https://support.microsoft.com/help/2976982) <br/> [SQL Server 2012 SP1 CU10](https://support.microsoft.com/help/2954099)| [FIX: Poor performance on I/O when you execute select into temporary table operation in SQL Server 2012](https://support.microsoft.com/help/2958012)|
|You encounter `PWAIT_MD_RELATION_CACHE` or `MD_LAZYCACHE_RWLOCK` wait after an `ALTER INDEX ... ONLINE` query operation is aborted.| [SQL Server 2014 RTM CU1](https://support.microsoft.com/help/2931693) <br/> [SQL Server 2012 SP1 CU9](https://support.microsoft.com/help/2931078)| [FIX: Performance decreases after an ALTER INDEX…ONLINE operation is aborted in SQL Server 2012 or SQL Server 2014](https://support.microsoft.com/help/2926712)|
|Queries suddenly perform poorly on standard edition of the product.| [SQL Server 2014 RTM CU1](https://support.microsoft.com/help/2931693) <br/> [SQL Server 2012 SP1 CU7](https://support.microsoft.com/help/2894115)| [FIX: Threads are not scheduled evenly in SQL Server 2012 or SQL Server 2014 Standard Edition](https://support.microsoft.com/help/2879373) |
|Slow performance because of a sudden drop in Page life expectancy.| [SQL Server 2012 SP1 CU4](https://support.microsoft.com/help/2833645)| [FIX: You may experience performance issues in SQL Server 2012](https://support.microsoft.com/help/2845380) |
|High CPU usage by resource monitor on systems with NUMA configuration, large memory, and "max server memory" set to a low value.| [SQL Server 2012 SP1 CU3](https://support.microsoft.com/help/2812412)| [FIX: CPU spike when there is no load on a server after you install SQL Server 2012 on the server](https://support.microsoft.com/help/2813214)|
|Non-yielding scheduler while allocation memory for sort runs associated large memory grants on systems with large amount of memory installed.| [SQL Server 2012 SP1 CU2](https://support.microsoft.com/help/2790947)| [FIX: Error 17883 when you run a query on a server that has many CPUs and a large amount of memory in SQL Server 2012 or in SQL Server 2008 R2](https://support.microsoft.com/help/2801379) |
|Non-yielding scheduler when the sort operator traverses many buckets in the buffer pool on systems with large memory.| [SQL Server 2012 SP1 CU1](https://support.microsoft.com/help/2765331)| [FIX: "Process appears to be non-yielding on Scheduler " error message when you run a query in SQL Server 2012](https://support.microsoft.com/help/2762557)|
|High CPU usage when you run concurrent queries that take a long time to compile on systems with multiple NUMA nodes and many cores.| [SQL Server 2012 SP2 CU1](https://support.microsoft.com/help/2976982) <br/> [SQL Server 2014 RTM CU2](https://support.microsoft.com/help/2967546)| [FIX: Intense query compilation workload does not scale with growing number of cores on NUMA hardware and results in CPU saturation in SQL Server](https://support.microsoft.com/help/2928300)|
|Memory allocations for sort operators take a long time to complete on NUMA systems with large memory because of remote node allocations.| [SQL Server 2012 SP1 CU3](https://support.microsoft.com/help/2812412)| [FIX: SQL Server performance issues in NUMA environments](https://support.microsoft.com/help/2819662) |
|**Out of memory** errors when SQL Server is installed on a NUMA machine with large amount of RAM and SQL Server has lots of foreign pages.| [SQL Server 2012 RTM CU1](https://support.microsoft.com/help/2765331)| [FIX: Out-of-memory error when you run an instance of SQL Server 2012 on a computer that uses NUMA](https://support.microsoft.com/help/2688697) |
|Spinlock contention on `SOS_CACHESTORE` and `SOS_SELIST_SIZED_SLOCK` when you build an index on spatial data type in a large table.| [SQL Server 2014 RTM CU1](https://support.microsoft.com/help/2931693) <br/> [SQL Server 2012 SP1 CU7](https://support.microsoft.com/help/2894115)| [FIX: Slow performance in SQL Server 2012 or SQL Server 2014 when you build an index on a spatial data type of a large table](https://support.microsoft.com/help/2887899)|
|High CMEMTHREAD wait type when you build an index on a spatial data type in large tables.| [SQL Server 2014 RTM CU1](https://support.microsoft.com/help/2931693) <br/> [SQL Server 2012 SP1 CU7](https://support.microsoft.com/help/2894115)| [FIX: Slow performance in SQL Server when you build an index on a spatial data type of a large table in a SQL Server 2012 or SQL Server 2014 instance](https://support.microsoft.com/help/2887888) |
| Performance issues because of `SOS_PHYS_PAGE_CACHE` and CMEMTHREAD waits during memory allocation on large-memory computers.| [SQL Server 2014 RTM CU1](https://support.microsoft.com/help/2931693) <br/> [SQL Server 2012 SP1 CU9](https://support.microsoft.com/help/2931078)| [FIX: Performance problems occur in NUMA environments during foreign page processing in SQL Server 2012 or SQL Server 2014](https://support.microsoft.com/help/2926223)  |
|CHECKDB command takes a long time for large databases.| [Cumulative update package 6 for SQL Server 2014](https://support.microsoft.com/help/3031047)| [FIX: DBCC CHECKDB/CHECKTABLE command may take longer in SQL Server 2012 or SQL Server 2014](https://support.microsoft.com/help/3029825)|
  
## Important notes

- If all the conditions in the Table 1 apply to you:

  - Guidance for SQL Server 2014: Apply at least [Cumulative Update 1 for SQL Server 2014](https://support.microsoft.com/help/2931693) for RTM and add "-T8048 -T9024 -T1236 -T1117 -T1118" to SQL Server start up parameter list.
  - Guidance for SQL Server 2012: Apply [SP2](https://www.microsoft.com/download/details.aspx?id=43340) and add "-T8048 -T9024 -T1236 -T1117 -T1118" to SQL Server start up parameter list.
- For general information about how to use trace flags, check the [DBCC TRACEON - Trace Flags (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql) topic in SQL Server Books Online.
- You can find more information about number of processors, NUMA configuration, and so on, in your [View the SQL Server error log in SQL Server Management Studio (SSMS)](/sql/relational-databases/performance/view-the-sql-server-error-log-sql-server-management-studio).
- To find the version of SQL Server, check the following:

  [How to determine the version and edition of SQL Server and its components](https://support.microsoft.com/help/321185)

## References

- [DBCC (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-transact-sql)
- [DBCC TRACEON - Trace Flags (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql)
- [How to obtain the latest service pack for SQL Server 2012](https://support.microsoft.com/help/2755533)
- [Where to find information about the latest SQL Server builds](https://support.microsoft.com/help/957826)
- SQL Server community resources on important updates for SQL Server

  - [Performance and stability related fixes in post-SQL Server 2012 SP1 Builds](https://www.sqlskills.com/blogs/glenn/performance-and-stability-related-fixes-in-post-sql-server-2012-sp1-builds-2/)
  - [Latest builds of SQL Server 2012](https://support.microsoft.com/help/2692828)
  - [Latest builds of SQL Server 2012 SP1](https://support.microsoft.com/help/2772858)
  - [Latest builds of SQL Server 2012 SP2](https://support.microsoft.com/help/2983249)
  - [Latest builds of SQL Server 2014](https://support.microsoft.com/help/2936603)

## Applies to

- SQL Server 2014 Enterprise
- SQL Server 2014 Enterprise Core
- SQL Server 2014 Business Intelligence
- SQL Server 2014 Developer
- SQL Server 2014 Standard
- SQL Server 2014 Web
- SQL Server 2014 Express
- SQL Server 2012 Business Intelligence
- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Standard
- SQL Server 2012 Web
- SQL Server 2012 Enterprise Core
