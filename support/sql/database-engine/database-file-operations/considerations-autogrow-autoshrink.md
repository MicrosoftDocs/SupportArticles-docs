---
title: Considerations for the autogrow and autoshrink
description: This article provides information regarding what happens when you select the autogrow and autoshrink for your environment.
ms.date: 10/10/2022
ms.custom: sap:Administration and Management
---

# Considerations for the autogrow and autoshrink settings in SQL Server

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 315512

## Summary

The default autogrow and autoshrink settings are appropriate on many SQL Server systems. However, there are environments where you may have to adjust the autogrow and autoshrink parameters. This article provides some background information to guide you when to select these settings for your environment.

Here are some things to consider if you decide to tune your autogrow and autoshrink parameters.

## How do I configure the settings

1. You can configure or modify the autogrow and autoshrink settings by using one of the following:

   - [SQL Server Management Studio](/sql/relational-databases/databases/database-properties-options-page)
   - An `ALTER DATABASE` statement

     - Use [File and Filegroup options](/sql/t-sql/statements/alter-database-transact-sql-file-and-filegroup-options) to modify auto growth settings
     - Use [SET options](/sql/t-sql/statements/alter-database-transact-sql-set-options) to configure `AUTO_SHRINK` settings.

   > [!NOTE]
   > For more information about how to set these settings at database file level, see [Add Data or Log Files to a Database](/sql/relational-databases/databases/add-data-or-log-files-to-a-database).

   You can also configure the autogrow option when you create a database.

   To view the current settings, run the following Transact-SQL command:

    ```sql
    sp_helpdb [ [ @dbname= ] 'name' ]
    ```

2. Keep in mind that the autogrow settings are per file. Therefore, you have to set them in at least two places for each database (one for the primary data file and one for the primary log file). If you have multiple data and/or log files, you must set the options on each file. Depending on your environment, you may end with different settings for each database file.

## Considerations for AUTO_SHRINK

`AUTO_SHRINK` is a database option in SQL Server. When you enable this option for a database, this database becomes eligible for shrinking by a background task. This background task evaluates all databases that satisfy the criteria for shrinking and shrink the data or log files.

You have to carefully evaluate setting this option for the databases in a SQL Server instance. Frequent grow and shrink operations can lead to various performance problems.

- If multiple databases undergo frequent shrink and grow operations, then this will easily lead to file system level fragmentation. This can have a severe impact on performance. This is true whether you use the automatic settings or whether you manually grow and shrink the files frequently.

- After `AUTO_SHRINK` successfully shrinks the data or log file, a subsequent DML or DDL operation can slow down significantly if space is required and the files need to grow.

- The `AUTO_SHRINK` background task can take up resources when there are many databases that need shrinking.

- The `AUTO_SHRINK` background task will need to acquire locks and other synchronization that can conflict with other regular application activity.

Consider setting databases to a required size and pre-grow them. Leave the unused space in the database files if you think the application usage patterns will need them again. This can prevent frequent shrink and growth of the database files.

## Considerations for AUTOGROW

- If you run a transaction that requires more log space than is available, and you have turned on the autogrow option for the transaction log of that database, then the time it takes the transaction to complete will include the time it takes the transaction log to grow by the configured amount. If the growth increment is large or there is some other factor that causes it to take a long time, the query in which you open the transaction might fail because of a timeout error. The same sort of issue can result from an autogrow of the data portion of your database.

- If you run a large transaction that requires the log to grow, other transactions that require a write to the transaction log will also have to wait until the grow operation completes.

- If you have many file growths in your log files, you may have an excessively large number of virtual log files (VLF). This can lead to performance problems with database startup/online operations, replication, mirroring, and change data capture (CDC). Additionally, this can sometimes cause performance problems with data modifications.

> [!NOTE]
> If you combine the autogrow and autoshrink options, you might create unnecessary overhead. Make sure that the thresholds that trigger the grow and shrink operations will not cause frequent up and down size changes. For example, you may run a transaction that causes the transaction log to grow by 100 MB by the time it commits. Some time after that the autoshrink starts and shrinks the transaction log by 100 MB. Then, you run the same transaction and it causes the transaction log to grow by 100 MB again. In that example, you are creating unnecessary overhead and potentially creating fragmentation of the log file, either of which can negatively affect performance.  

If you grow your database by small increments, or if you grow it and then shrink it, you can end up with disk fragmentation. Disk fragmentation can cause performance issues in some circumstances. A scenario of small growth increments can also reduce the performance on your system.  

In SQL Server, you can enable [instant file initialization](/sql/relational-databases/databases/database-instant-file-initialization). Instant file initialization speeds up file allocations only for data files. Instant file initialization does not apply to log files. For more information, see [Database Instant File Initialization](/sql/relational-databases/databases/database-instant-file-initialization).

## Best practices for autogrow and autoshrink

- For a managed production system, you must consider autogrow to be merely a contingency for unexpected growth. Do not manage your data and log growth on a day-to-day basis with autogrow.

- You can use alerts or monitoring programs to monitor file sizes and grow files proactively. This helps you avoid fragmentation and permits you to shift these maintenance activities to non-peak hours.

- Autoshrink and autogrow must be carefully evaluated by a trained Database Administrator (DBA); They must not be left unmanaged.

- Your autogrow increment must be large enough to avoid the performance penalties listed in the previous section. The exact value to use in your configuration setting and the choice between a percentage growth and a specific MB size growth depends on many factors in your environment. A general rule of thumb you can use for testing is to set your autogrow setting to about one-eight the size of the file.

- Turn on the `\<MAXSIZE>` setting for each file to prevent any one file from growing to a point where it uses up all available disk space.

- Keep the size of your transactions as small as possible to prevent unplanned file growth.

## Why do I have to worry about disk space if size settings are automatically controlled

- The autogrow setting can't grow the database size beyond the limits of the available disk space on the drives for which files are defined. Therefore, if you rely on the autogrow functionality to size your databases, you must still independently check your available hard disk space. The autogrow setting is also limited by the `MAXSIZE` parameter you select for each file. To reduce the possibility of running out of space, you can monitor the Performance Monitor counter SQL Server: Databases Object: Data File(s) Size (KB) and set up an alert when the database reaches a certain size.

- Unplanned growth of data or log files can take space that other applications expect to be available and might cause those other applications to experience problems.

- The growth increment of your transaction log must be large enough to stay ahead of the needs of your transaction units. Even with autogrow turned on, you can receive a message that the transaction log is full, if it can't grow fast enough to satisfy the needs of your query.

- SQL Server doesn't constantly test for databases that have hit the configured threshold for autoshrink. Instead, it looks at the available databases and finds the first one that is configured to autoshrink. It checks that database and shrinks that database if needed. Then, it waits several minutes before checking the next database that is configured for autoshrink. In other words, SQL Server doesn't check all databases at once and shrink them all at once. It will work through the databases in a round robin fashion to stagger out the load over a period of time. Therefore, depending on how many databases you have configured to autoshrink on a particular SQL Server instance, it might take several hours from the time the database hits the threshold until it actually shrinks.

## References

- [Troubleshoot a Full Transaction Log (SQL Server Error 9002)](/sql/relational-databases/logs/troubleshoot-a-full-transaction-log-sql-server-error-9002)

- [Database Instant File Initialization](/sql/relational-databases/databases/database-instant-file-initialization)

- [SQL Server Transaction Log Architecture and Management Guide](/sql/relational-databases/sql-server-transaction-log-architecture-and-management-guide)

- [Manage the size of the transaction log file](/sql/relational-databases/logs/manage-the-size-of-the-transaction-log-file)
