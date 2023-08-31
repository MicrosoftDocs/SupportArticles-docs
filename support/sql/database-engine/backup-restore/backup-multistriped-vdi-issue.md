---
title: Backing up a SQL Server database using a VDI application using multi-striping may fail with error 3456
description: This article provides a resolution for the problem that occurs when you use VDI applications with multi-striping
ms.date: 08/31/2023
ms.custom: sap:Database Engine
ms.author: jopilov
---
# Backing up a SQL Server database using a VDI application using multi-striping may fail with error 3456

This article helps you resolve the problem that occurs when you use Volume Shadow Copy Services (VSS) based applications to back up your SQL Server databases.

## Symptoms

When you restore a multi-striped VDI full backup, you may get the error [MSSQLSERVER_3456](/sql/relational-databases/errors-events/mssqlserver-3456-database-engine-error):

```output
Could not redo log record (120600:18965748:1), for transaction ID (0:1527178398), on page (14:1987189), allocation unit 72057761533001728, database 'DB1_STRIPE' (database ID 8).
Page: LSN = (120598:23255372:8), allocation unit = 72057761317781504, type = 1. Log: OpCode = 6, context 2, PrevPageLSN: (120600:18965371:85).
```

## Cause

When SQL Server backs up to virtual device interfaces (VDI), it passes data to the VDI through a buffer. The VDI then handles the formatting of how to store that backup. However, the VDI client in many cases may be expecting only a singular copy of each data page. 
However, when striping a backup to VDI, there are multiple backup devices that together make up the contents of one full backup. The data is written asynchronously and data copy ordering is handled by the VDI client's logic. Due to the data copy phase being asynchronous, the data can be written out of order. However, in a full backup scenario prior to SQL Server 2019, there would only be one copy per data page. So when the VDI client sends data to the buffer that SQL Server reads from for a restore, SQL Server would still be able to know exactly where and how to restore each data page. With the introduction of delayed log pinning in SQL Server 2019, multiple copies of the data page may be found in the log. Multiple copies exist due to a mini differential backup happening inside the full backup (see the [More information](#more-information) section for details). Then multiple copies of the page may be seen. The VDI client is either not expecting multiple copies of the same data page, or passing the data pages back to SQL Server in the wrong order to cause the restore failure of "Could not redo log record". The log record that SQL Server is trying to apply is attempting to write over a newer version of the data page, but it's finding the older version.

## Resolution

1. Enable trace flag 3296 as a startup parameter. Trace flag 3296 disables Delay Log Pining for Full backups and essentially brings back the pre-2019 behavior.
2. Restart SQL Server

## More information

SQL Server 2019 introduces a feature called Delay log pinning. Prior to this feature introduction, during a full database backup, SQL Server blocks any transactions from happening (pins the log), copies the data and the log, and then removes the pin right at the beginning. With the feature present, SQL Server delays transactions from happening (pins the log) towards the end of backup start time, instead of right at the beginning. This feature is designed to avoid a full transaction log issue ([MSSQLSERVER_9002](/sql/relational-databases/errors-events/mssqlserver-9002-database-engine-error) error) during a full backups of very large databases (VLDBs) which may take a long time. Because the log pinning is delayed, transactions are still allowed to be applied to the database's data pages while the backup is ongoing, and SQL Server maintains a bitmap to identify the pages that were changed so it can take a mini differential backup of them. This way it gets an updated copy of each data page that was changed while it's backing up the entire database. This causes an extra copy of some data pages. Additionally, this extra section of the full backup is created.

So far this issue is observed Veritas VDI backup solutions. Other VDI backup providers could exhibit the same issue.