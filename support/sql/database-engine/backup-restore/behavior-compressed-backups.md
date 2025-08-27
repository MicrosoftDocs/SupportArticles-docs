---
title: Behavior of compressed backups
description: This article describes the behavior of compressed backups when appending backups to an existing media set. 
ms.date: 10/11/2020
ms.custom: sap:Database Backup and Restore
ms.reviewer: denzilr
---
# Behavior of compressed backups when you append backups to an existing media set

This article introduces the behavior of compressed backups when you append backups to an existing media set.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2297053

## Summary

One of the main restrictions with compressed backups is that compressed and uncompressed backups can't co-exist in a media set. This restriction is documented in [Backup Compression (SQL Server)](/sql/relational-databases/backup-restore/backup-compression-sql-server).

This article supplements that documentation, and provides more information on the expected behavior of compressed backups, in relation to [server configuration option](/sql/database-engine/configure-windows/server-configuration-options-sql-server) - [backup compression default](/sql/database-engine/configure-windows/view-or-configure-the-backup-compression-default-server-configuration-option).

## Symptoms

Consider the following scenario:

- You append a backup to an existing media set.
- You rely on the option `backup compression default` of the system stored procedure [sp_configure](/sql/relational-databases/system-stored-procedures/sp-configure-transact-sql), and don't specify the `WITH COMPRESSION` clause in the backup statement.

In this scenario, you notice that the backup is successful but may end up in a different compression state than expected.

## More information

When you append a backup to an existing media set, the backup inherits the compression setting from the media set.

When a media set is created, information on the compression setting of this media set is written to the media header file.

Backups taken to an existing media set can co-exist only if the compression setting of these backups is the same as that of the media set. The following three factors affect the behavior of compressed backups:

- SQL Server's configuration option - [Backup compression default](/previous-versions/sql/sql-server-2008-r2/bb677250(v=sql.105))

- Backup Set Options - [COMPRESSION or NO_COMPRESSION](/sql/t-sql/statements/backup-transact-sql)

- For existing media, an important factor to consider is whether the media set currently contains a compressed or an uncompressed backup.

The following table summarizes the behavior of compressed backups based on the three factors above:

|Backup statement| New media set| Append to an existing media set that has a compressed backup| Append to an existing media set that has an uncompressed backup |
|---|---|---|---|
|Statement level clause `WITH COMPRESSION`|The backup is successful and will be compressed|Success|Error|
|Statement level clause `WITH NO_COMPRESSION`|The backup is successful and will be uncompressed|Error|Success|
| Back up statement without statement level compression clause|The backup is successful, and the compression depends on the option `backup compression default` of the system stored procedure `sp_configure`|The backup is successful and will be compressed|The backup is successful and will be uncompressed|
  
As you can see from the table above, when you use the option `backup compression default` on the server and append the compressed backup to an existing media set, the backup will never fail due to a mismatch in compression settings. It works but inherits the setting in the header of the media set. However, if you specify the clause `WITH COMPRESSION` or `WITH NO_COMPRESSION` in your backup statement, an error will be raised if there's a mismatch between the backup stored in the media set and the current backup being taken, in terms of the compression setting.

> [!NOTE]
> You can find the current setting for the option `backup compression default` by running the system stored procedure `sp_configure` in SQL Server Management Studio. If you are appending a compressed backup to an existing media, you can get the header information by using the statement [RESTORE HEADERONLY](/sql/t-sql/statements/restore-statements-headeronly-transact-sql). For more information, see the [Examples](#examples) section.

### Examples

Here are some script examples to demonstrate the behavior for various cases. The behavior is the same whether the backup is to a tape or a disk.

- Example 1: When the value of the option `backup compression default` is `0`, use the statement level clause `WITH COMPRESSION` to append a backup to an existing media set that has an uncompressed backup setting:

    1. Check the compression value:

        ```sql
        -- The value of the option "backup compression default" is 0 by default
        sp_configure 'backup compression default'
        ```

    1. Create a new media set by using the clause `WITH FORMAT`:

        ```sql
        BACKUP DATABASE test TO DISK = N'E:\testbackup.bak'
        WITH FORMAT, INIT,
        NAME = N'testbackup-Full Database Backup', SKIP, NOUNLOAD, STATS = 10
        GO
        ```

    1. Check the backup and the header, and see that the compressed column value is **0**:

        ```sql
        RESTORE HEADERONLY FROM DISK = N'E:\testbackup.bak'
        ```

    1. Back up the database `test` by using the clause `WITH COMPRESSION`:

        ```sql
        -- The backup will fail as compressed and non compressed backups can't be mixed within the same media set
        BACKUP DATABASE test TO DISK = N'E:\testbackup.bak'
        WITH NAME = N'testbackup-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION, STATS = 10
        GO
        ```

        After executing the SQL script, you may receive [Error messages 3098 and 3013](#error-messages-3098-and-3013).

- Example 2: Append a backup to the same media set when setting the value of option `backup compression default` to `1`:

    1. Turn on `backup compression default` at the server level:

        ```sql
        -- The option "backup compression default" as this point is set to 1.
        sp_configure 'backup compression default', 1
        GO
        RECONFIGURE
        GO
        ```

    1. Append the backup to the same media set:

        ```sql
        -- Given that you may expect the backup to be compressed and it will be if it is a new media set.
        -- However, if you have a backup and append the backup to the same media set, 
        -- the backup works but results in an uncompressed backup.
        BACKUP DATABASE test TO DISK = N'E:\testbackup.bak'
        WITH NAME = N'testbackup-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
        GO
        ```

        After executing the SQL script, you can see the following output:

        ```Output
        Processed two pages for database `test`, file _test_log_ on file 2.
    
        BACKUP DATABASE successfully processed 162 pages in 6.211 seconds (0.203 MB/sec).
        ```

    1. Check the backup and media set header:

        ```sql
        -- Then, you will see that though Server default is set to compressed, the backup given that
        -- it is appended to an existing media set inherits the compression setting of the media set itself.
        -- You may expect this to have failed with the same error as when specifying the clause `WITH COMPRESSION`
        -- in the backup statement given that compressed and non compressed backups can't co-exist in the media set.
        RESTORE HEADERONLY FROM DISK = N'E:\testbackup.bak'
        ```

- Example 3: Set the value of the option `backup compression default` to `0`, and append a backup to an existing media set that has a compressed backup setting:

    1. Create a new media set by using the clause `WITH FORMAT`:

        ```sql
        -- If you create a new media set by using the FORMAT option, the current compression setting is inherited
        BACKUP DATABASE test TO DISK = N'E:\testbackup.bak'
        WITH FORMAT, INIT, NAME = N'testbackup-Full Database Backup', SKIP, NOUNLOAD, STATS = 10
        GO
        ```

    1. Check the backup and media set header:

        ```sql
        RESTORE HEADERONLY FROM DISK = N'E:\testbackup.bak'
        ```

    1. Set the option `backup compression default` back to `0`:

        ```sql
        sp_configure 'backup compression default', 0
        GO
        RECONFIGURE
        GO
        ```

    1. Back up the database `test` to the same media set by using the clause `WITH INIT`:

        ```sql
        -- If you use the clause "WITH INIT", the backup sets are overwritten but the media header is not
        BACKUP DATABASE test TO DISK = N'E:\testbackup.bak'
        WITH INIT, NAME = N'testbackup-Full Database Backup', SKIP, NOUNLOAD, STATS = 10
        GO
        ```

    1. Check the backup and media set header:

        ```sql
        -- Note that even though we changed backup compression default to 0, the old media header is preserved which has it as 1, and the backup goes as compressed
        RESTORE HEADERONLY FROM DISK = N'E:\testbackup.bak'
        ```

- Example 4: Compressed backups can't co-exist with NT backups that have an uncompressed setting:

    1. Take an NT backup and verify the backup header:

        ```sql
        -- You can see that it is not a SQL backup and the value of compressed is 0
        RESTORE HEADERONLY FROM TAPE = N'\\.\Tape0'
        ```

    1. Back up the database `test` to the same media set by using clauses `WITH INIT` and `WITH COMPRESSION`:

        ```sql
        BACKUP DATABASE test TO TAPE = N'\\.\Tape0'
        WITH INIT, COMPRESSION,
        NAME = N'testbackup-Full Database Backup', SKIP, NOUNLOAD, STATS = 10
        GO
        ```

        After executing the SQL script, you may receive [Error messages 3098 and 3013](#error-messages-3098-and-3013).

- Example 5: Non-compressed backups and NT backups that have an uncompressed setting can co-exist:

    1. Back up the database `test` to the same media set without initializing and no compression:

        ```sql
        --The backups ( NT and non-compressed backup) can co-exist
        BACKUP DATABASE test TO TAPE = N'\\.\Tape0'
        WITH NAME = N'testbackup-Full Database Backup', SKIP, NOUNLOAD, STATS = 10
        GO
        ```

    1. Verify the backup header, and see the SQL and the NT backup:

        ```sql
        RESTORE HEADERONLY FROM TAPE = N'\\.\Tape0'
        ```

    1. Force a compressed backup on a tape with an NT backup:

        ```sql
        BACKUP DATABASE test TO TAPE = N'\\.\Tape0'
        WITH COMPRESSION,
        NAME = N'testbackup1 Full Database Backup', SKIP, NOUNLOAD, STATS = 10
        GO
        ```

        After executing the SQL script, you may receive [Error messages 3098 and 3013](#error-messages-3098-and-3013).

### Error messages 3098 and 3013

- Error message 3098

    ```Output
    Msg 3098, Level 16, State 2, Line 1  
    The backup cannot be performed because 'COMPRESSION' was requested after the media was formatted with an incompatible structure.
    To append to this media set, either omit 'COMPRESSION' or specify 'NO_COMPRESSION'. Alternatively, you can create a new media set by using WITH FORMAT in your BACKUP statement.
    If you use WITH FORMAT on an existing media set, all its backup sets will be overwritten.  
    ```

- Error message 3013

    ```Output
    Msg 3013, Level 16, State 1, Line 1  
    BACKUP DATABASE is terminating abnormally.
    ```
