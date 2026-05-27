---
title: Recommendations to reduce allocation contention
description: Learn how to reduce tempdb allocation contention on PFS, GAM, and SGAM pages to improve SQL Server performance under heavy load.
ms.date: 05/20/2026
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.reviewer: SureshKa, jopilov, v-shaywood
---
# Recommendations to reduce allocation contention in SQL Server tempdb database

_Original product version:_ &nbsp; SQL Server 2014, SQL Server 2016, SQL Server 2017, SQL Server 2019, SQL Server 2022  
_Original KB number:_ &nbsp; 2154845

## Summary

This article explains how to diagnose and reduce allocation contention in the SQL Server `tempdb` database. It covers `PAGELATCH_UP` waits on Page Free Space (PFS), Global Allocation Map (GAM), and Shared Global Allocation Map (SGAM) pages. It describes how to use multiple equally sized `tempdb` data files and, on older versions, trace flags 1118 and 1117 to improve SQL Server performance under heavy concurrent workloads.

## Symptoms

On a server that runs Microsoft SQL Server, you notice severe blocking when the server is under heavy load. The dynamic management views `sys.dm_exec_requests` and `sys.dm_os_waiting_tasks` show that the requests or tasks are waiting for `tempdb` resources. The wait type is `PAGELATCH_UP`, and the wait resource points to pages in `tempdb`. These pages might be in the format 2:1:1, 2:1:3, and so on (PFS and SGAM pages in `tempdb`).

> [!NOTE]
> If a page number is evenly divisible by 8088, it's a PFS page. For example, page 2:3:905856 is a PFS page in `file_id=3` in `tempdb`.

The following operations use `tempdb` extensively:

- Repetitive create-and-drop operations on temporary tables (local or global).
- Table variables that use `tempdb` for storage.
- Work tables associated with cursors.
- Work tables associated with an `ORDER BY` clause.
- Work tables associated with a `GROUP BY` clause.
- Work files associated with hash plans.

These activities can cause contention.

## Cause

When `tempdb` is heavily used, SQL Server can experience contention while it allocates pages. Depending on the degree of contention, queries and requests that use `tempdb` might become briefly unresponsive.

During object creation in older versions of SQL Server, the system allocates two pages from a mixed extent and assigns them to the new object. One page is the _Index Allocation Map_ (IAM) page, and the second page is the first page for the object. SQL Server tracks mixed extents by using the Shared Global Allocation Map (SGAM) page. Each SGAM page tracks about 4 GB of data.

To allocate a page from a mixed extent, SQL Server scans the Page Free Space (PFS) page to find a free mixed page. The PFS page tracks free space on every page, and each PFS page tracks about 8,000 pages. Synchronization is required when SQL Server changes PFS and SGAM pages, and that synchronization can stall other modifiers for short periods.

When SQL Server searches for a mixed page to allocate, it always starts the scan on the same file and SGAM page. This behavior causes intense contention on the SGAM page when many mixed-page allocations run at the same time, which produces the symptoms described earlier.

> [!NOTE]
> Deallocation activities also change these pages and can add to the contention.

To learn more about the allocation mechanisms that SQL Server uses (SGAM, GAM, PFS, and IAM), see the [Related content](#related-content) section.

## Solution

SQL Server 2014 reached the end of extended support on July 9, 2024, so most readers should follow the SQL Server 2016 and later versions guidance.

### SQL Server 2016 and later versions

1. Review [tempdb database](/sql/relational-databases/databases/tempdb-database) for current performance guidance.
1. Make sure that `tempdb` has multiple equally sized data files. As a starting point, use one data file per logical processor up to eight files. If contention continues, add files in groups of four up to the number of logical processors.
1. Keep the SQL Server instance current with the latest cumulative update to get further allocation improvements. For example, see [KB 4099472: PFS page round-robin algorithm improvement in SQL Server 2014, 2016, and 2017](https://support.microsoft.com/help/4099472).
1. If contention persists on SQL Server 2019 or a later version, review the [tempdb database](/sql/relational-databases/databases/tempdb-database) guidance on concurrent PFS updates and memory-optimized `tempdb` metadata.

### SQL Server 2014 and earlier versions

To improve the concurrency of `tempdb`, try the following methods:

- Increase the number of data files in `tempdb` to maximize disk bandwidth and reduce contention on allocation structures. As a rule, if the number of logical processors is eight or fewer, use the same number of data files as logical processors. If the number of logical processors is greater than eight, start with eight data files. If contention continues, add data files in groups of four up to the number of logical processors, or change the workload or code.
- Review the best practice guidance in [Working with tempdb in SQL Server 2005](/previous-versions/sql/sql-server-2005/administrator/cc966545(v=technet.10)).
- If the previous steps don't significantly reduce allocation contention and the contention is on SGAM pages, enable trace flag ``-T1118``. Under this trace flag, SQL Server allocates full extents to each database object, which substantially reduces contention on SGAM pages.

  > [!NOTE]
  >
  > - This trace flag affects every database on the SQL Server instance. To check whether allocation contention is on SGAM pages, see [Monitoring contention caused by DML operations](/previous-versions/sql/sql-server-2005/administrator/cc966545(v=technet.10)).
  > - For SQL Server 2014, apply Service Pack 3 to get the fix in [KB 4099472](https://support.microsoft.com/help/4099472), which further reduces contention by doing round-robin PFS page allocations across several PFS pages in the same data file.

## More information about tempdb allocation

### Default tempdb behavior in SQL Server 2016 and later versions

Starting with SQL Server 2016, several improvements reduce `tempdb` allocation contention by default, so you typically don't need to enable trace flags 1118 or 1117:

- **Mixed-extent allocations are disabled for `tempdb` by default** (the behavior previously enabled by trace flag 1118). All new allocations come from uniform extents.
- **All `tempdb` data files autogrow together** (the behavior previously enabled by trace flag 1117).
- **SQL Server Setup recommends multiple equally sized `tempdb` data files** based on the number of logical processors, up to eight.
- **Concurrent PFS updates** further reduce PFS page latch contention in SQL Server 2019 and later versions.

If you run SQL Server 2016 or a later version, focus on the sizing and number of `tempdb` files. Use trace flags only on SQL Server 2014 or earlier.

### Example of equal tempdb data file sizing

For example, if the single `tempdb` data file is 8 GB and the log file is 2 GB, increase the number of data files to eight (each 1 GB to keep equal sizing) and leave the log file unchanged. Placing the data files on separate disks can give an additional performance benefit, but it isn't required. The files can coexist on the same disk volume.

The best number of `tempdb` data files depends on the degree of contention you see. As a starting point, set the file count equal to the number of logical processors assigned to SQL Server. For higher-end systems, start with eight files. If contention isn't reduced, add more data files.

Use equal sizing for all data files. SQL Server 2000 Service Pack 4 (SP4) introduced a fix that uses a round-robin algorithm for mixed-page allocations. With this improvement, the starting file changes for each consecutive mixed-page allocation when more than one file exists. The SGAM allocation algorithm is pure round-robin and doesn't honor proportional fill, so create all `tempdb` data files at the same size.

### How more tempdb data files reduce contention

Adding equally sized `tempdb` data files reduces contention in the following ways:

- If you have one data file for `tempdb`, you have one GAM page and one SGAM page for each 4 GB of space.
- More data files of the same size effectively create one or more GAM and SGAM pages for each data file.
- The GAM allocation algorithm allocates one extent at a time (eight contiguous pages) from the files in round-robin fashion while honoring proportional fill. For example, if you have 10 equally sized files, the first allocation is from File1, the second from File2, the third from File3, and so on.
- PFS page contention is reduced because eight pages at a time are marked as FULL while GAM allocates the pages.

### How trace flag -T1118 reduces contention

> [!NOTE]
> This section applies only to SQL Server 2014 and earlier versions. In SQL Server 2016 and later versions, this behavior is the default for `tempdb`.

Trace flag `-T1118` reduces contention in the following ways:

- `-T1118` is a server-wide setting.
- Add `-T1118` to the SQL Server startup parameters so that the trace flag stays in effect after a SQL Server restart.
- `-T1118` removes almost all single-page allocations on the server.
- Disabling most single-page allocations reduces SGAM page contention.
- When `-T1118` is on, almost all new allocations come from a GAM page (for example, 2:1:2) that allocates eight pages (one extent) at a time to an object, instead of single pages from an extent for the first eight pages of an object.
- IAM pages still use single-page allocations from the SGAM page even when `-T1118` is on. But combined with hotfix 8.00.0702 and more `tempdb` data files, the net effect is reduced SGAM page contention. For space concerns, see the next section.

### Trace flag 1118 compared with default behavior in modern SQL Server

| Behavior | SQL Server 2014 and earlier (without `-T1118`) | SQL Server 2014 and earlier (with `-T1118`) | SQL Server 2016 and later (`tempdb` default) |
| --- | --- | --- | --- |
| First eight pages of a new object | Single-page allocations from mixed extents (SGAM) | Full uniform extent (GAM) | Full uniform extent (GAM) |
| SGAM page contention risk | High under heavy `tempdb` use | Low | Low |
| Scope | Not applicable | Server-wide | `tempdb` only |
| Action required | None | Add `-T1118` startup parameter | None |

### Disadvantages of trace flag -T1118

The disadvantage of using `-T1118` is that database size can grow if both of the following conditions are true:

- You create new objects in a user database.
- Each new object occupies less than 64 KB of storage.

Under these conditions, SQL Server can allocate 64 KB (eight pages * 8 KB) for an object that needs only 8 KB, which wastes 56 KB of storage. If the new object uses more than 64 KB (eight pages) during its lifetime, there's no disadvantage to the trace flag. In the worst case, SQL Server allocates seven extra pages during the first allocation, but only for new objects that never grow beyond one page.

## Related content

- [tempdb database](/sql/relational-databases/databases/tempdb-database)
- [DBCC TRACEON: trace flags (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql)
