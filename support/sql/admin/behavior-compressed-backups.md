---
title: Behavior of compressed backups
description: This article describes the behavior of compressed backups when appending backups to an existing media set. 
ms.date: 09/19/2022
ms.custom: sap:Administration and Management
ms.reviewer: denzilr
ms.topic: article
ms.prod: sql
---
# Behavior of compressed backups when you append backups to an existing media set

This article introduces the behavior of compressed backups when you append backups to an existing media set.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2297053

## Summary

One of the main restrictions with compressed backups is that compressed and uncompressed backups can't co-exist in a media set. This restriction is documented in: [Backup Compression (SQL Server)](/previous-versions/sql/sql-server-2008/bb964719(v=sql.100)).

This article supplements that documentation and provides more information on the expected behavior of compressed backups in relation to Backup compression default server configuration setting.

## More information

When you append a compressed backup to an existing media, it inherits the compression setting from the media set. If you rely on the Backup compression's `sp_configure` setting and are appending to existing media sets, you may end up with a Backup in a different compression state than expected.

This is true only under the following circumstances:

- You append the Backup to an existing media set.
- You rely on the sp_configure `backup compression default` option and don't specify the Backup statement level `WITH COMPRESSION` option.

When a media set is created, information on whether this media set is for a compressed Backup or a normal Backup is written to the media header file.

Backups taken to an existing media set can coexist only if the compression setting of these backups is the same as that of the media set. The following three factors affect the behavior of compressed Backups:

- SQL Server's configuration option - [Backup compression default](/previous-versions/sql/sql-server-2008-r2/bb677250(v=sql.105))
- Backup Set Options - [COMPRESSION or NO_COMPRESSION](/sql/t-sql/statements/backup-transact-sql)
- Whether you are appending to an existing media set or writing the Backup to a new media set. For existing media, an additional factor to consider is whether the media set currently contains a compressed or an uncompressed Backup.

The following table summarizes the behavior of compressed backups based on the above three factors.

|Backup Statement| New MediaSet| Append to Media Set| Append to Media Set (uncompressed) |
|---|---|---|---|
| Backup Statement Options|| Existing Media Set has Compressed Backup| Exsting Media Set has uncompressed Backup |
| Backup statement level with `COMPRESSION` clause|Success Back up compressed|Success|Error|
| Backup statement level with `NO_COMPRESSION` clause|Success Backup - uncompressed|Error|Success|
| Back up statement without statement level compression clause|Success Compression depends on sp_configure `backup compression` setting|Success Backup will be compressed|Success Backup will be uncompressed|
  
As you can see from the above table, when we use the default compression setting at the server and append to an existing media set, the Backup will never fail due to a mismatch in compression settings. It works but inherits the setting in the header of the media set. , if you specify the `COMPRESSION` or `NO_COMPRESSION` options in your Backup statement, an error will be raised if there is a mismatch between the Backup stored in the media set and the current Backup being taken in terms of the compression setting.

> [!NOTE]
> You can find the current setting for `backup compression` default option by running `sp_configure` command in the SQL Server Management Studio. If you are appending to existing media you can get the header information using restore `headeronly` command. For more information, see the Examples section later in this article.

Examples: Here is a sample script to demonstrate the behavior for various cases. The behavior is the same whether the Backup is to a tape or a disk.

- Compression value is **0**.

    ```sql
    -- Note compression value, by default it should be 0
    sp_configure 'backup compression'
    -- Initial Backup completes successfully
    BACKUP DATABASE test TO DISK = N'E:\testbackup.bak' WITH FORMAT, INIT,
    NAME = N'testbackup-Full Database Backup', SKIP,NOUNLOAD, STATS = 10
    GO
    -- Check the backup and the header, and see the Compressed column value, it is 0
    restore headeronly from DISK = N'E:\testbackup.bak'
    -- Now backup using "with compression" and it will fail
    -- as backups ( compressed and non compressed cannot be mixed within the same media set )
    BACKUP DATABASE test TO DISK = N'E:\testbackup.bak' 
    WITH NAME = N'testbackup-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION, STATS = 10
    GO
    ```

    After executing the sql script, you may receive: [3098 and 3013 error messages](#3098-and-3013-error-messages)

- Turn on default Backup Compression at the server level.

    ```sql
    -- Turn on default backup Compression at the server level
    sp_configure 'backup compression',1 'backup compression',1
    go
    reconfigure
    go
    -- The sp_configure 'default compression' as this point is set to 1.
    -- Given that you may expect the backup to be compressed and it will be if it -- is a new media set
    -- However if you backup and append to the same media set,
    -- the backup works -- but results in an uncompressed backup
    BACKUP DATABASE test TO DISK = N'E:\testbackup.bak'
    WITH NAME = N'testbackup-Full Database Backup', SKIP,NOREWIND,NOUNLOAD, STATS = 10
    GO
    ```

    Processed two pages for database `test`, file _test_log_ on file 2.

    BACKUP DATABASE successfully processed 162 pages in 6.211 seconds (0.203 MB/sec).

- Check the Backup and media set header.

    ```sql
    -- Check the backup and meadia set header. You will see that though Server default is set to compressed, the backup given that it is appended to an existing media set inherits the compression setting of the media set itself
    -- You may expect this to have failed with the same error as when specifying the WITH COMPRESSION clause in the backup statement given that compressed and non compressed backups cannot co-exist in the media set.
    restore headeronly from DISK = N'E:\testbackup.bak'
    --If you create a new mediaset using the FORMAT option, then the current compression setting is inherited
    -- Create a new media set using FORMAT Or by specifying a new file
    BACKUP DATABASE test TO DISK = N'E:\testbackup.bak' WITH FORMAT, INIT, NAME = N'testbackup-Full Database Backup', SKIP,NOUNLOAD, STATS = 10
    GO
    -- Check the backup and meadia set header
    restore headeronly from DISK = N'E:\testbackup.bak'
    -- If you use the with INIT, the backup sets are overwritten but the media header is not
    -- Toggle the backup compression setting back to 0
    sp_configure 'backup compression',0
    go
    reconfigure
    go
    -- backup to the same media set with INIT
    BACKUP DATABASE test TO DISK = N'E:\testbackup.bak' WITH INIT,
    NAME = N'testbackup-Full Database Backup', SKIP,NOUNLOAD, STATS = 10
    GO
    -- Check the backup and media set header
    -- Note that even though we changed backup compression to 0, the old media header is preserved which has it as 1, and the backup goes as compressed
    restore headeronly from DISK = N'E:\testbackup.bak'
    ```

- Another limitation is that Compressed backups cannot oexist with NT Backups:

    ```sql
    -- Take an NT Backup
    -- You can verify the backup Header now, see it is not a SQL backup
    restore headeronly from DISK = N'E:\testbackup.bak'
    -- backup to the same media set with INIT and compression and you get the error message
    BACKUP DATABASE test TO TAPE = N'\\.\Tape0' WITH INIT, COMPRESSION,
    NAME = N'testbackup-Full Database Backup', SKIP,NOUNLOAD, STATS = 10
    GO
    ```

    After executing the sql script, you may receive: [3098 and 3013 error messages](#3098-and-3013-error-messages)

- Back up to the same media set without initializing and NO compression.

    ```sql
    -- backup to the same media set without initializing and NO compression and the backups ( NT and non-compressed backup) can co-exist
    BACKUP DATABASE test TO TAPE = N'\\.\Tape0'
    WITH NAME = N'testbackup-Full Database Backup', SKIP,NOUNLOAD, STATS = 10
    GO
    -- You can verify the backup Header now,see the SQL and the NT backup
    Restore headeronly from tape = N'\\.\Tape0'
    -- Forcing a Compressed backup on a tape with an NT backup results in the error below
    BACKUP DATABASE test TO TAPE = N'\\.\Tape0' with compression,
    NAME = N'testbackup1 Full Database Backup', SKIP,NOUNLOAD, STATS = 10
    GO
    ```

    After executing the sql script, you may receive: [3098 and 3013 error messages](#3098-and-3013-error-messages)

### 3098 and 3013 error messages

- 3098 error message

    > Msg 3098, Level 16, State 2, Line 1  
    > The backup cannot be performed because 'COMPRESSION' was requested after the media was formatted with an incompatible structure. To append to this media set, either omit 'COMPRESSION' or specify 'NO_COMPRESSION'. Alternatively, you can create a new media set by using WITH FORMAT in your BACKUP statement. If you use WITH FORMAT on an existing media set, all its backup sets will be overwritten.  

- 3013 error message

    >Msg 3013, Level 16, State 1, Line 1  
    BACKUP DATABASE is terminating abnormally.
