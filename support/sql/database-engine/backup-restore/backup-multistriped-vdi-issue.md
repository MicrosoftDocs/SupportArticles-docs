---
title: Error 3456 when restoring a SQL Server database using a VDI application with multi-striping
description: This article provides a resolution for an issue that occurs when you restore a SQL Server database using VDI applications with multi-striping.
ms.date: 10/16/2024
ms.custom: sap:Database Backup and Restore
ms.author: jopilov
author: PiJoCoder
ms.reviewer: hesha, amamun, v-sidong
---
# Restoring a SQL Server database using a VDI application with multi-striping might fail with error 3456

This article helps you resolve an issue that occurs when you use Virtual Device Interface (VDI)-based applications to restore your SQL Server databases.

## Symptoms

When you restore a multi-striped [virtual device interface (VDI)](/sql/relational-databases/backup-restore/vdi-reference/reference-virtual-device-interface) full backup on SQL Server 2019 or later, you might get the error [MSSQLSERVER_3456](/sql/relational-databases/errors-events/mssqlserver-3456-database-engine-error):

```output
Msg 3456, Level 16, State 1, Line <LineNumber>
Could not redo log record (120600:18965748:1), for transaction ID (0:1527178398), on page (14:1987189), allocation unit 72057761533001728, database 'DB1_STRIPE' (database ID 8).
Page: LSN = (120598:23255372:8), allocation unit = 72057761317781504, type = 1. Log: OpCode = 6, context 2, PrevPageLSN: (120600:18965371:85).
```

## Cause

When SQL Server backs up to VDI, it passes data to the VDI through a buffer. The VDI then handles the formatting of how to store that backup. However, in many cases, the VDI client might expect only a single copy of each data page.

When you stripe a backup to VDI, multiple backup devices together make up the contents of a full backup. The data is written asynchronously, and the data copy ordering is handled by the VDI client's logic. Since the data copy phase is asynchronous, the data can be written out of order. However, in a full backup scenario prior to SQL Server 2019, there's only one copy per data page. So when the VDI client sends data to the buffer that SQL Server reads from for a restore, SQL Server would still be able to know exactly where and how to restore each data page. With the introduction of delayed log pinning in SQL Server 2019, multiple copies of the data page might be found in the backup files. Multiple copies exist due to a mini differential backup happening inside the full backup (see the [More information](#more-information) section for details). The VDI client is either not expecting multiple copies of the same data page, or passing the data pages back to SQL Server in the wrong order. This behavior causes the restore failure. The error 3456 `Could not redo log record` indicates that SQL Server tries to apply a log record that expects the latest version of the data page, but it finds an older version.

## Resolution

1. Depending on your configuration, you need to enable one or more trace flags as startup parameters for your SQL Server instance:

   -	If you're taking full backups when the instance is acting as a primary replica or an instance without availability groups, enable trace flag 3471 to disable the delayed log pinning feature for full backups.

   -	If you're taking differential backups when the instance is acting as a primary replica or an instance without availability groups, enable trace flag 3475 to disable the delayed log pinning feature for differential backups.

   -	If you're taking full backups with [COPY_ONLY](/sql/relational-databases/backup-restore/copy-only-backups-sql-server) when the instance is acting as a secondary replica, enable trace flag 3472 to disable the delayed log pinning feature for differential backups.

1. Restart SQL Server.

1. Take your full or differential backups again.


> [!NOTE]
> You can also temporarily enable these trace flags using the [DBCC TRACEON](/sql/t-sql/database-console-commands/dbcc-traceon-transact-sql) command. 
>
> ```SQL
> DBCC TRACEON(3471,3472,3475,-1)
> ```
> This command can be used to mitigate the issue if you can't restart your SQL Server instance immediately.

> [!Important]
> Due to this issue, existing backups might not be restorable if the following conditions are true:
> 
> - The backup is taken with the delay log pining feature enabled.
> - The backup tool is using VDI.
> - The backup is done using multi-striping (backing up to several files).

We encourage you to restore your existing backups on a test server to check if they can be restored successfully.

## More information

SQL Server 2019 introduces a feature called delayed log pinning. Prior to the introduction of this feature, during a full database backup, SQL Server blocks any transactions from happening (pins the log), copies the data and the log, and then removes the pin right at the beginning. With the feature present, SQL Server delays transactions from happening (pins the log) towards the end of the backup duration, instead of right at the beginning. This feature is designed to avoid a full transaction log issue ([MSSQLSERVER_9002](/sql/relational-databases/errors-events/mssqlserver-9002-database-engine-error) error) during a full backup that's taking a long time to complete. Because the log pinning is delayed, transactions are still allowed to be applied to the database's data pages while the backup is ongoing. SQL Server maintains a bitmap to identify the pages that have changed since the start time of the ongoing full backup, so that it can take a mini differential backup of them. In this way, it gets an updated copy of each data page that was changed while it's backing up the entire database. This causes an extra copy of some data pages. Additionally, this extra section of the full backup is created.
