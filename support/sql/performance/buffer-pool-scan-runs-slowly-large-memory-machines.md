---
title: Buffer pool scan runs slowly on large-memory computers
description: This article describes how a scan of the SQL Server buffer pool might take a long time on a large-memory computer.
ms.date: 01/15/2021
ms.prod-support-area-path: Performance
ms.reviewer: daleche
ms.topic: article
ms.prod: sql 
---
# Operations that scan the SQL Server buffer pool are slow on large-memory computers

This article describes how scanning the SQL Server buffer pool might take a long time to finish on large-memory computers.

_Applies to:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4566579

## Summary

Certain operations in Microsoft SQL Server can trigger a scan of the buffer pool (the cache that stores database pages in memory). Here are some operations that might cause  a buffer pool scan to occur:

- Database startup
- Database shutdown or restart
- AG failover
- Database removal (drop)
- File removal from a database
- Full or differential database backup
- Database restoration 
- Transaction log restoration
- Online restoration
- DBCC CheckDB or CheckTable operation

On systems that have a large amount of memory (1 TB or greater), scanning the buffer pool takes a long time. This slows down the operation that triggered the scan.

Currently, there is no fix for this problem. If it's critical that the operation in question finishes quickly, consider clearing the buffer pool by using the following commands:

`USE <*DatabaseName*>`

`CHECKPOINT`

`GO`

If the server has more than one database, repeat these commands for all user databases on the server.

After all the databases on the server have been checkpointed, run the following command:

`DBCC DROPCLEANBUFFERS`

> [!WARNING]
> Dropping clean buffers from the buffer pool removes all non-modified database pages from memory. This requires subsequent queries to read the data from the database files on disk and could cause severe performance degradation.

## More information

For more information about problems that can occur in large buffer pools, see [SQL Server : large RAM and DB Checkpointing](https://techcommunity.microsoft.com/t5/sql-server-support/sql-server-large-ram-and-db-checkpointing/ba-p/318973).

Starting in [SQL Server 2016 SP3](https://support.microsoft.com/help/5003279), [SQL Server 2017 CU23](https://prod.support.services.microsoft.com/topic/kb5000685-cumulative-update-23-for-sql-server-2017-22b653c7-8487-4564-9db2-b5c1bd465145?preview=true#bkmk_13741858) and [SQL Server 2019 CU9](https://support.microsoft.com/topic/kb5000642-cumulative-update-9-for-sql-server-2019-97ad5c3e-e002-4b6d-b566-698bf70ca44a#bkmk_13744390), the following logging and XEvents were added to help identify long buffer pool scans.

### errorlog message

If a scan takes more than 10 seconds, a message will be printed as follows:

> Buffer Pool scan took 14 seconds: database ID 7, command 'BACKUP DATABASE', operation 'FlushCache', scanned buffers 115, total iterated buffers 204640239, wait time 0 ms. See 'https://go.microsoft.com/fwlink/?linkid=2132602' for more information.

### XEvent buffer_pool_scan_complete

If a scan takes more than 1 second, an XEvent will be recorded as follows when the event is enabled. The threshold is smaller to be able to optionally capture information at a finer-granularity.

|name|database_id|elapsed_time_ms|command|operation|scanned_buffers|total_iterated_buffers|
|-|-|-|-|-|-|-|
|buffer_pool_scan_complete|7|1308|BACKUP DATABASE|FlushCache|243|19932814|
