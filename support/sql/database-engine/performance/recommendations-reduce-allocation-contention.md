---
title: Recommendations to reduce allocation contention
description: This article provides resolution for the problem where you notice severe blocking when the server is experiencing a heavy load.
ms.date: 09/25/2020
ms.custom: sap:Performance
ms.reviewer: SureshKa
---
# Recommendations to reduce allocation contention in SQL Server tempdb database

This article helps you resolve the problem where you notice severe blocking when the server is experiencing a heavy load.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2154845

## Symptoms

On a server that is running Microsoft SQL Server, you notice severe blocking when the server is experiencing a heavy load. Dynamic Management Views [`sys.dm_exec_request` or `sys.dm_os_waiting_tasks`] indicates that these requests or tasks are waiting for **tempdb** resources. Additionally, the wait type is `PAGELATCH_UP`, and the wait resource points to pages in **tempdb**. These pages might be of the format 2:1:1, 2:1:3, and so on (PFS and SGAM pages in **tempdb**).

> [!NOTE]
> If a page is evenly divisible by 8088, it is a PFS page. For example, page 2:3:905856 is a PFS in file_id=3 in **tempdb**.

The following operations use **tempdb** extensively:

- Repetitive create-and-drop operation of temporary tables (local or global).
- Table variables that use **tempdb** for storage.
- Work tables that are associated with CURSORS.
- Work tables that are associated with an ORDER BY clause.
- Work tables that are associated with a GROUP BY clause.
- Work files that are associated with HASH PLANS.

These activities may cause contention problems.

## Cause

When the **tempdb** database is heavily used, SQL Server may experience contention when it tries to allocate pages. Depending on the degree of contention, this may cause queries and requests that involve **tempdb** to be briefly unresponsive.

During object creation, two (2) pages must be allocated from a mixed extent and assigned to the new object. One page is for the Index Allocation Map (IAM), and the second is for the first page for the object. SQL Server tracks mixed extents by using the Shared Global Allocation Map (SGAM) page. Each SGAM page tracks about 4 gigabytes of data.

To allocate a page from the mixed extent, SQL Server must scan the Page Free Space (PFS) page to determine which mixed page is free to be allocated. The PFS page keeps track of free space available on every page, and each PFS page tracks about 8000 pages. Appropriate synchronization is maintained to make changes to the PFS and SGAM pages; and that can stall other modifiers for short periods.

When SQL Server searches for a mixed page to allocate, it always starts the scan on the same file and SGAM page. This causes intense contention on the SGAM page when several mixed-page allocations are underway. This can cause the problems that are documented in the [Symptoms](#symptoms) section.

> [!NOTE]
> De-allocation activities must also modify the pages. This can contribute to the increased contention.

To learn more about the different allocation mechanisms that are used by SQL Server (SGAM, GAM, PFS, IAM), see the [References](#references) section.

## Resolution

- SQL Server 2016 and later versions:

  Review

  - Optimizing [tempdb database](/sql/relational-databases/databases/tempdb-database) performance in SQL Server.  
  
  - [TEMPDB – Files and Trace Flags and Updates, Oh My!](/archive/blogs/sql_server_team/tempdb-files-and-trace-flags-and-updates-oh-my)
  
  - Apply the relevant CU for SQL Server 2016 and 2017 to take advantage of the following update. An improvement has been made that further reduces contention in SQL Server 2016 and SQL Server 2017. In addition to the round-robin allocation across all tempdb data files, the fix improves PFS page allocation by performing round-robin allocations across several PFS pages in the same data file. For more information, see [KB4099472 - PFS page round robin algorithm improvement in SQL Server 2014, 2016 and 2017](https://support.microsoft.com/help/4099472).
  
  For more information on these recommendations and other changes that were introduced in SQL 2016 review
  
  - [SQL Server 2016 – It Just Runs Faster: -T1117 and -T1118 changes for TEMPDB and user databases](/archive/blogs/psssql/sql-2016-it-just-runs-faster-t1117-and-t1118-changes-for-tempdb-and-user-databases)
  
  - [SQL Server 2016 – It Just Runs Faster: Automatic TEMPDB Configuration](/archive/blogs/psssql/sql-2016-it-just-runs-faster-automatic-tempdb-configuration)

- SQL Server 2014 and earlier versions:

  To improve the concurrency of tempdb, try the following methods:

  - Increase the number of data files in **tempdb** to maximize disk bandwidth and reduce contention in allocation structures. As a rule, if the number of logical processors is less than or equal to eight (8), use the same number of data files as logical processors. If the number of logical processors is greater than eight (8), use eight data files. If contention continues, increase the number of data files by multiples of four (4) up to the number of logical processors until the contention is reduced to acceptable levels. Alternatively, make changes to the workload or code.

  - Consider implementing the best practice recommendations in [Working with tempdb in SQL Server 2005](/previous-versions/sql/sql-server-2005/administrator/cc966545(v=technet.10)).

  - If the previous steps do not significantly reduce the allocation contention and the contention is on SGAM pages, implement trace flag **-T1118**. Under this trace flag, SQL Server allocates full extents to each database object, thereby eliminating the contention on SGAM pages.

    > [!NOTE]
    >
    > - This trace flag affects every database on the instance of SQL Server. For information about how to determine whether the allocation contention is on SGAM pages, see the [Monitoring contention caused by DML operations](/previous-versions/sql/sql-server-2005/administrator/cc966545(v=technet.10)).
    >
    > - For SQL Server 2014 environments, ensure you apply Service Pack 3 to take advantage of the fix documented in the following KB article. The improvement further reduces contention in SQL Server 2014 environments. In addition to the round-robin allocation across all tempdb data files, the fix improves PFS page allocation by performing round-robin allocations across several PFS pages in the same data file.
    >
    >   [KB4099472 - PFS page round robin algorithm improvement in SQL Server 2014, 2016 and 2017](https://support.microsoft.com/help/4099472)
    >
    > - MSSQL Tiger Team Blog: [Files and trace flags and updates in SQL Server tempdb](/archive/blogs/sql_server_team/tempdb-files-and-trace-flags-and-updates-oh-my)

## Increase the number of tempdb data files that have equal sizing

As an example, if the single data file size of **tempdb** is 8 GB, and the Log file size is 2 GB, the recommendation is to increase the number of data files to eight (8) (each of 1 GB to maintain equal sizing) and leave the log file as is. Having the different data files on separate disks would be provide additional performance benefit. However, this is not required. The files can coexist on the same disk volume.

The optimal number of **tempdb** data files depends on the degree of contention seen in **tempdb**. As a starting point, you can configure **tempdb**  to be at least equal to the number of logical processors that are assigned for SQL Server. For higher-end systems, the starting number could be eight (8). If the contention is not reduced, you may have to increase the number of data files.

We recommend that you use equal sizing of data files. SQL Server 2000 Service Pack 4 (SP4) introduced a fix that uses a round robin algorithm for mixed page allocations. Because of this improvement, the starting file is different for each consecutive mixed page allocation (if more than one file exists). The new allocation algorithm for SGAM is pure round robin and does not honor the proportional fill to maintain speed. We recommend that you create all **tempdb** data files at the same size.

## How increasing the number of tempdb data files reduces contention

The following list explains how increasing the number of **tempdb** data files that have equal sizing reduces contention:

- If you have one data file for the **tempdb**, you only have one GAM page, and one SGAM page for each 4 GB of space.

- Increasing the number of data files that have the same sizes for **tempdb** effectively creates one or more GAM and SGAM pages for each data file.

- The allocation algorithm for GAM allocates one extent at a time (eight contiguous pages) from the number of files in a round robin fashion while honoring the proportional fill. Therefore, if you have 10 equally sized files, the first allocation is from File1, the second from File2, the third from File3, and so on.

- The resource contention of the PFS page is reduced because eight pages at a time are marked as FULL because GAM is allocating the pages.  

## How implementing trace flag -T1118 reduces contention

> [!NOTE]
> This section only applies to SQL Server 2014 and earlier versions.

The following list explains how using trace flag **-T1118** reduces contention:

- **-T1118**  is a server-wide setting.
- Include the **-T1118**  trace flag in the Startup parameters for SQL Server so that the trace flag remains in effect even after SQL Server is recycled.
- **-T1118**  removes almost all single page allocations on the server.
- By disabling most of the single page allocations, you reduce the contention on the SGAM page.
- If **-T1118**  is turned ON, almost all new allocations are made from a GAM page (for example, 2:1:2) that allocates eight (8) pages (one extent) at a time to an object as opposed to a single page from an extent for the first eight (8) pages of an object, without the trace flag.
- The IAM pages still use the single page allocations from the SGAM page, even if **-T1118** is turned **ON**. However, when it is combined with hotfix 8.00.0702 and increased **tempdb**  data files, the net effect is a reduction in contention on the SGAM page. For space concerns, see the next section.  

## Disadvantages

The disadvantage of using **-T1118** is that you may see increases in database size if the following conditions are true:

- New objects are created in a user database.
- Each of the new objects occupies less than 64 KB of storage.

If these conditions are true, you may allocate 64 KB (eight pages * 8 KB = 64 KB) for an object that only requires 8 KB of space, thus wasting 56 KB of storage. However, if the new object uses more than 64 KB (eight pages) in its lifetime, there is no disadvantage to the trace flag. Therefore, in a worst case scenario, SQL Server may allocate seven (7) additional pages during the first allocation only for new objects that never grow beyond one (1) page.

## References

- [TempDB Monitoring and Troubleshooting: Allocation Bottleneck](/archive/blogs/sqlserverstorageengine/tempdb-monitoring-and-troubleshooting-allocation-bottleneck)
- [Managing TempDB in SQL Server: TempDB Configuration](/archive/blogs/sqlserverstorageengine/managing-tempdb-in-sql-server-tempdb-configuration)
- [SQL Server TempDB - Number of Files - The Raw Truth](/archive/blogs/psssql/sql-server-tempdb-number-of-files-the-raw-truth)
- [SQL Server (2005 and 2008) Trace Flag 1118 (-T1118) Usage](/archive/blogs/psssql/sql-server-2005-and-2008-trace-flag-1118-t1118-usage)
