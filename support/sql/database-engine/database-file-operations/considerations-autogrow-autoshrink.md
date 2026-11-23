---
title: Configure Autogrow and Autoshrink Settings in SQL Server
description: Learn how autogrow and autoshrink settings affect SQL Server performance. Follow best practices to configure file growth and avoid fragmentation.
ms.date: 10/19/2026
ms.custom: sap:File, Filegroup, Database Operations or Corruption
ms.reviewer: jopilov
ai-usage: ai-assisted
---

# Considerations for the autogrow and autoshrink settings in SQL Server

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 315512

## Summary

The autogrow and autoshrink settings control how SQL Server automatically increases (autogrow) or reduces (autoshrink) the size of database data and log files. The default settings are appropriate on many SQL Server systems, but some environments require you to adjust them. This article explains how these settings affect performance, and it provides best practices to help you avoid slow transactions, file fragmentation, and unplanned disk space usage.

This article is for database administrators (DBAs) who configure file growth and shrink behavior for databases in SQL Server.

## How do I configure the autogrow and autoshrink settings?

1. Configure or modify the autogrow and autoshrink settings by using one of the following methods:

   - [SQL Server Management Studio](/sql/relational-databases/databases/database-properties-options-page)
   - An `ALTER DATABASE` statement:

     - Use [File and Filegroup options](/sql/t-sql/statements/alter-database-transact-sql-file-and-filegroup-options) to modify the autogrow (`FILEGROWTH`) settings.
     - Use [SET options](/sql/t-sql/statements/alter-database-transact-sql-set-options) to configure the `AUTO_SHRINK` setting.

   > [!NOTE]
   > For more information about how to set these settings at the database file level, see [Add Data or Log Files to a Database](/sql/relational-databases/databases/add-data-or-log-files-to-a-database).

   You can also configure the autogrow option when you create a database.

1. To view the current settings, run the following Transact-SQL command:

    ```sql
    sp_helpdb [ [ @dbname= ] 'name' ]
    ```

   You can also query the [sys.database_files](/sql/relational-databases/system-catalog-views/sys-database-files-transact-sql) catalog view for the current database, or the [sys.master_files](/sql/relational-databases/system-catalog-views/sys-master-files-transact-sql) catalog view for all databases on the instance. These views include the growth increment, whether the growth is a percentage, and the maximum file size. To check whether `AUTO_SHRINK` is turned on, query the `is_auto_shrink_on` column in [sys.databases](/sql/relational-databases/system-catalog-views/sys-databases-transact-sql).

1. Keep in mind that the autogrow settings are per file. Therefore, you have to set them in at least two places for each database (one for the primary data file and one for the primary log file). If you have multiple data and log files, you must set the options on each file. Depending on your environment, you might end up with different settings for each database file.

## What are the default autogrow settings?

In SQL Server 2016 (13.x) and later versions, the default `FILEGROWTH` value is 64 MB for both data and log files. Earlier versions use smaller or percentage-based defaults. For the default for each version, see [ALTER DATABASE (Transact-SQL) File and Filegroup options](/sql/t-sql/statements/alter-database-transact-sql-file-and-filegroup-options).

## What should I consider before turning on AUTO_SHRINK?

`AUTO_SHRINK` is a database option in SQL Server. When you enable this option for a database, a background task can shrink the database. This background task evaluates all databases that meet the criteria for shrinking, and then shrinks the data or log files.

Carefully evaluate setting this option for the databases in a SQL Server instance. Frequent grow and shrink operations can lead to various performance problems:

- If multiple databases undergo frequent shrink and grow operations, file system fragmentation can occur. Fragmentation can severely impact performance. This impact occurs whether you use the automatic settings or you manually grow and shrink the files frequently.

- After `AUTO_SHRINK` successfully shrinks the data or log file, a subsequent DML or DDL operation can slow down significantly if space is required and the files need to grow.

- The `AUTO_SHRINK` background task can use significant resources when many databases need shrinking.

- The `AUTO_SHRINK` background task has to acquire locks and other synchronization objects that can conflict with regular application activity.

Instead, set databases to the required size and pre-grow them. Leave the unused space in the database files if you think the application usage patterns need it again. For more information about shrinking files, see [Shrink a database](/sql/relational-databases/databases/shrink-a-database) and [DBCC SHRINKFILE](/sql/t-sql/database-console-commands/dbcc-shrinkfile-transact-sql).

## What should I consider before relying on autogrow?

Autogrow can affect transaction duration, other sessions, and the number of virtual log files (VLFs) in the transaction log:

- If you run a transaction that requires more log space than is available, and autogrow is turned on for the transaction log of that database, the time it takes the transaction to complete includes the time it takes the transaction log to grow by the configured amount. If the growth increment is large or another factor causes the growth to take a long time, the query in which you open the transaction might fail because of a timeout error. The same issue can result from an autogrow of the data portion of your database.

- If you run a large transaction that requires the log to grow, other transactions that require a write to the transaction log also have to wait until the grow operation completes.

- If you have many file growths in your log files, you might have an excessively large number of [virtual log files (VLFs)](/sql/relational-databases/sql-server-transaction-log-architecture-and-management-guide#transaction-log-physical-architecture). Many VLFs can degrade database startup, online operations, and other log-dependent features. To check the number of VLFs, query the [sys.dm_db_log_info](/sql/relational-databases/system-dynamic-management-views/sys-dm-db-log-info-transact-sql) dynamic management function.

If you grow your database by small increments, or if you grow it and then shrink it, you can end up with disk fragmentation. Disk fragmentation can cause performance issues in some circumstances. Small growth increments can also reduce the performance of your system.

> [!NOTE]
> If you combine the autogrow and autoshrink options, you might create unnecessary overhead. Ensure that the thresholds that trigger the grow and shrink operations don't cause frequent up and down size changes. For example, you might run a transaction that causes the transaction log to grow by 100 MB by the time it commits. Some time after that, autoshrink starts and shrinks the transaction log by 100 MB. Then, you run the same transaction and it causes the transaction log to grow by 100 MB again. In that example, you're creating unnecessary overhead and potentially creating fragmentation of the log file, either of which can negatively affect performance.

### How does instant file initialization affect autogrow?

[Instant file initialization](/sql/relational-databases/databases/database-instant-file-initialization) (IFI) speeds up data file autogrow operations because SQL Server doesn't zero out the new space. In SQL Server 2022 (16.x) and later versions, transaction log autogrowth events of up to 64 MB can also benefit from IFI. Without IFI, autogrow takes longer as the growth increment gets larger. For the requirements and limitations, see [Database instant file initialization](/sql/relational-databases/databases/database-instant-file-initialization).

## What are the best practices for autogrow and autoshrink?

- For a managed production system, consider autogrow to be merely a contingency for unexpected growth. Don't manage your data and log growth on a day-to-day basis by using autogrow.

- Use alerts or monitoring programs to monitor file sizes and grow files proactively. This approach helps you avoid fragmentation and permits you to shift these maintenance activities to non-peak hours.

- Have a trained database administrator (DBA) carefully evaluate autoshrink and autogrow. Don't leave them unmanaged.

- Make your autogrow increment large enough to avoid the performance penalties described earlier in this article. The exact value to use in your configuration setting, and the choice between a percentage growth and a specific MB size growth, depends on many factors in your environment. A general rule of thumb you can use for testing is to set your autogrow setting to about one-eighth the size of the file. For transaction log growth recommendations, see [Manage the size of the transaction log file](/sql/relational-databases/logs/manage-the-size-of-the-transaction-log-file#recommendations).

- Turn on the `MAXSIZE` setting for each file to prevent any one file from growing to a point where it uses up all available disk space.

- Keep the size of your transactions as small as possible to prevent unplanned file growth.

## Why do I still need to monitor disk space when autogrow is turned on?

- The autogrow setting can't grow the database size beyond the limits of the available disk space on the drives for which files are defined. Therefore, if you rely on the autogrow functionality to size your databases, you must still independently check your available hard disk space. The autogrow setting is also limited by the `MAXSIZE` parameter you select for each file. To reduce the possibility of running out of space, you can monitor the Performance Monitor counter **SQL Server: Databases Object: Data File(s) Size (KB)** and set up an alert when the database reaches a certain size.

- Unplanned growth of data or log files can take space that other applications expect to be available and might cause those other applications to experience problems.

- The growth increment of your transaction log must be large enough to stay ahead of the needs of your transaction units. Even with autogrow turned on, you can receive a message that the transaction log is full if it can't grow fast enough to satisfy the needs of your query. For more information, see [Troubleshoot a full transaction log (SQL Server error 9002)](/sql/relational-databases/logs/troubleshoot-a-full-transaction-log-sql-server-error-9002).

## How often does SQL Server check databases for autoshrink?

SQL Server doesn't constantly test for databases that have hit the configured threshold for autoshrink. Instead, it looks at the available databases and finds the first one that is configured to autoshrink. It checks that database and shrinks it if needed. Then, it waits several minutes before checking the next database that is configured for autoshrink.

In other words, SQL Server doesn't check all databases at once and shrink them all at once. It works through the databases in a round-robin fashion to stagger the load over a period of time. Therefore, depending on how many databases you have configured to autoshrink on a particular SQL Server instance, it might take several hours from the time the database hits the threshold until it actually shrinks.

## Related content

- [SQL Server Transaction Log Architecture and Management Guide](/sql/relational-databases/sql-server-transaction-log-architecture-and-management-guide)
- [DBCC SHRINKDATABASE](/sql/t-sql/database-console-commands/dbcc-shrinkdatabase-transact-sql)
- [Database files and filegroups](/sql/relational-databases/databases/database-files-and-filegroups)
