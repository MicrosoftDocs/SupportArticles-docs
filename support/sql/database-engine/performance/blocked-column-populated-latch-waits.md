---
title: The blocked column is populated for latch waits
description: This article describes that the blocked column in the sysprocesses table is populated for latch waits.
ms.date: 01/20/2021
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.reviewer: bartd
---
# The blocked column in the sysprocesses table is populated for latch waits

This article introduces that the blocked column in the `sysprocesses` table is populated for latch waits.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 906344

## Summary

In SQL Server, you may notice that the blocked column in the `sysprocesses` system table is populated for latch waits in addition to lock waits. Sometimes, you may notice brief periods of time when a single server process ID (SPID) is reported as blocking itself. This behavior is expected.

## More information

Latches are used to synchronize access to cached data pages and other in-memory objects. Typically, latches are only held briefly, and latch wait times are correspondingly small. SQL Server has diagnostics to help troubleshoot cases in which an SPID waits a long time for a latch. These diagnostics cause the blocked column in the `sysprocesses` system table to reflect the owner of a latch that is blocking the latch request of another SPID.

Latch ownership is only tracked for latches that are in exclusive (EX) or update (UP) latch mode. Ownership isn't tracked for latches that are in shared (SH) latch mode. This means that the blocked column won't be populated for some latch requests.

Most of the time, you can ignore the value in the blocked column if the following conditions are true:

- The value in the `waittime` column is low.
- The `waittype` of the SPID is a latch waittype.

For more information about the possible values in the `waittype` column, see [sys.dm_os_wait_stats (Transact-SQL)](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql).

When an SPID is waiting for an I/O page latch, you may notice that the blocked column briefly reports that the SPID is blocking itself. This behavior is a side effect of the way that latches are used for I/O operations on data pages. When a thread issues an I/O request, the SPID that issues the I/O request acquires a latch on the page. All SQL Server I/O operations are asynchronous. Therefore, the SPID will try to acquire another latch on the same page if the SPID that issued the I/O request must wait for the request to finish. This second latch is blocked by the first latch. Therefore, the blocked column reports that the SPID is blocking itself. When the I/O request finishes, the first latch is released. Then, the second latch request is granted.

For example, the following conditions may occur:

1. SPID 55 wants to read a data page that doesn't exist in the buffer pool.
1. SPID 55 acquires an EX latch on the page. Because the page doesn't exist yet in memory, the requested latch mode is EX. The EX latch mode forces other SPIDs that may also want to access the page to wait for the I/O request to finish. The EX latch mode also prevents other SPIDs from issuing a duplicate I/O request for the same page.
1. SPID 55 issues the I/O request to read the page from disk.

1. Because SPID 55 wants to read the page, SPID 55 must wait for the I/O request to finish. To wait for the I/O request to finish, SPID 55 tries to acquire another latch that has the shared (SH) latch mode on the same page. Because an EX latch has already been acquired, the SH latch request is blocked, and the SPID is suspended. Because the EX latch that blocks the SH latch request was also acquired by SPID 55, the SPID is temporarily reported as blocking itself.

1. When the I/O request finishes, the EX latch on the page is released.
1. The release of the EX latch gives the SH latch to SPID 55.

1. SPID 55 can now read the page.

Between step 4 and step 5, the `sysprocesses` table indicates that SPID 55 is blocked by itself together with a waittype of PAGEIOLATCH_**XX**. In this waittype, **XX** may be SH, UP, or EX. This behavior indicates that SPID 55 issued an I/O request and SPID 55 is waiting for the I/O request to finish.
