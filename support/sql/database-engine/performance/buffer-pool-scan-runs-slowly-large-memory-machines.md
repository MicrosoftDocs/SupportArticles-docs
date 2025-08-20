---
title: Operations that trigger buffer pool scan may run slowly on large-memory computers
description: This article describes how a scan of the SQL Server buffer pool might take a long time on a large-memory computer.
ms.date: 04/08/2025
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.reviewer: jopilov
---
# Operations that trigger a buffer pool scan may run slowly on large-memory computers

This article describes how scanning the SQL Server buffer pool might take a long time to finish on large-memory computers.

_Applies to:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4566579

## Symptoms

Certain operations in Microsoft SQL Server trigger a scan of the buffer pool (the cache that stores database pages in memory). On systems that have a large amount of RAM (1 TB of memory or greater), scanning the buffer pool may take a long time. This slows down the operation that triggered the scan.

### Operations that cause a buffer pool scan

Here are some operations that may trigger a buffer pool scan to occur:

- Database startup
- Database shutdown or restart
- AG failover
- Database removal (drop)
- File removal from a database
- Full or differential database backup
- Database restoration
- Transaction log restoration
- Online restoration
- `DBCC CHECKDB` or `DBCC CHECKTABLE` operation

### Error log shows that a scan took a long time

Starting with [SQL Server 2016 SP3](https://support.microsoft.com/help/5003279), [SQL Server 2017 CU23](https://prod.support.services.microsoft.com/topic/kb5000685-cumulative-update-23-for-sql-server-2017-22b653c7-8487-4564-9db2-b5c1bd465145?preview=true#bkmk_13741858) and [SQL Server 2019 CU9](https://support.microsoft.com/topic/kb5000642-cumulative-update-9-for-sql-server-2019-97ad5c3e-e002-4b6d-b566-698bf70ca44a#bkmk_13744390), an error message was added to the SQL Server [Error log](/sql/tools/configuration-manager/viewing-the-sql-server-error-log) to indicate that a buffer pool scan took a long time (10 seconds or longer):

> Buffer Pool scan took 14 seconds: database ID 7, command 'BACKUP DATABASE', operation 'FlushCache', scanned buffers 115, total iterated buffers 204640239, wait time 0 ms. See 'https://go.microsoft.com/fwlink/?linkid=2132602' for more information.

### Extended Event to diagnose a long scan

Also, starting with the same builds [SQL Server 2016 SP3](https://support.microsoft.com/help/5003279), [SQL Server 2017 CU23](https://prod.support.services.microsoft.com/topic/kb5000685-cumulative-update-23-for-sql-server-2017-22b653c7-8487-4564-9db2-b5c1bd465145?preview=true#bkmk_13741858) and [SQL Server 2019 CU9](https://support.microsoft.com/topic/kb5000642-cumulative-update-9-for-sql-server-2019-97ad5c3e-e002-4b6d-b566-698bf70ca44a#bkmk_13744390)  the **buffer_pool_scan_complete** Extended event was introduced to help you identify long buffer pool scans.

If a scan takes more than 1 second, the XEvent will be recorded as follows when the event is enabled.

|name|database_id|elapsed_time_ms|command|operation|scanned_buffers|total_iterated_buffers|
|-|-|-|-|-|-|-|
|buffer_pool_scan_complete|7|1308|BACKUP DATABASE|FlushCache|243|19932814|

> [!NOTE]
> The threshold in the XEvent is smaller to allow you to capture information at a finer-granularity.

## Workaround

Prior to SQL Server 2022, there was no way to eliminate this problem. It isn't recommended to perform any action to clear the buffer pool as dropping clean buffers ([DBCC DROPCLEANBUFFERS](/sql/t-sql/database-console-commands/dbcc-dropcleanbuffers-transact-sql)) from the buffer pool may result in a significant performance degradation. Removing database pages from memory will cause subsequent query executions to re-read the data from the database files on disk. This process of accessing data via disk I/O causes queries to be slow. 

In SQL Server 2022, this problem is mitigated because buffer pool scans are parallelized by utilizing multiple cores. There will be one task per 8 million buffers (64 GB) where a serial scan will still be used if there are less than 8 million buffers. For more information, watch [Buffer Pool Parallel Scan](/shows/data-exposed/sql-server-2022-introducing-buffer-pool-parallel-scan).

## More information

For more information about problems that can occur in large buffer pools, see [SQL Server : large RAM and DB Checkpointing](https://techcommunity.microsoft.com/t5/sql-server-support/sql-server-large-ram-and-db-checkpointing/ba-p/318973).
