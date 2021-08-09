---
title: Buffer pool scan runs slowly on large memory machines
description: This article describes that scan the SQL Server buffer pool may take a long time on large memory machines.
ms.date: 01/15/2021
ms.prod-support-area-path: Performance
ms.reviewer: daleche
ms.topic: article
ms.prod: sql 
---
# Operations that scan SQL Server buffer pool are slow on large memory machines

This article describes that scan the SQL Server buffer pool may take a long time on large memory machines.

_Applies to:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4566579

## Summary

Certain operations in SQL Server trigger a scan of the buffer pool (the cache that stores database pages in memory). Here are some operations that may trigger a buffer pool scan:

- Database startup
- Database shutdown/restart
- AG failover
- Dropping a database
- Removing a file from a database
- Full/Differential Backup of a database
- Restoring a database
- Transaction log restore
- Online restore
- DBCC CheckDB/CheckTable

On systems with a large amount of memory (1 TB or higher), scanning the buffer pool takes a long time, which slows down the operation that triggered the scan.

There's currently no fix for this issue. If it is critical that the operation in question complete quickly, consider clearing the buffer pool using these commands: `USE <DatabaseName>; CHECKPOINT; GO`.

If the server has more than one database, repeat the commands above for all user databases on the server.

Once all the databases on the server have been checkpointed, run the command `DBCC DROPCLEANBUFFERS`;

> [!WARNING]
> Dropping clean buffers from the buffer pool removes all non-modified database pages from memory. This requires subsequent queries to read the data from the database files on disk and could cause severe performance degradation.

## More information

For more information on issues that may arise from large buffer pools, see [SQL Server : large RAM and DB Checkpointing](https://techcommunity.microsoft.com/t5/sql-server-support/sql-server-large-ram-and-db-checkpointing/ba-p/318973).

Starting with [SQL Server 2017 CU23](https://prod.support.services.microsoft.com/topic/kb5000685-cumulative-update-23-for-sql-server-2017-22b653c7-8487-4564-9db2-b5c1bd465145?preview=true#bkmk_13741858) and [SQL Server 2019 CU9](https://support.microsoft.com/topic/kb5000642-cumulative-update-9-for-sql-server-2019-97ad5c3e-e002-4b6d-b566-698bf70ca44a#bkmk_13744390), the following logging and XEvents were added to help identify long buffer pool scans:

### errorlog message

If a scan takes more than 10 seconds, a message will be printed as follows:

> Buffer Pool scan took 14 seconds: database ID 7, command 'BACKUP DATABASE', operation 'FlushCache', scanned buffers 115, total iterated buffers 204640239, wait time 0 ms. See 'https://go.microsoft.com/fwlink/?linkid=2132602' for more information.

### XEvent buffer_pool_scan_complete

If a scan takes more than 1 second, an XEvent will be recorded as follows when the event is enabled. The threshold is smaller to be able to optionally capture at a finer-granularity.

|name|database_id|elapsed_time_ms|command|operation|scanned_buffers|total_iterated_buffers|
|-|-|-|-|-|-|-|
|buffer_pool_scan_complete|7|1308|BACKUP DATABASE|FlushCache|243|19932814|
