---
title: Decreased performance when using EFS to encrypt database files
description: Provides workarounds for the decreased performance issue in SQL Server when you use Encrypting File System to encrypt database files.
ms.date: 12/08/2021
ms.custom: sap:Performance
author: HaiyingYu
ms.author: haiyingyu
---
# Decreased performance in SQL Server when you use EFS to encrypt database files

_Applies to:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 922121

## Symptoms

When you use Encrypting File System (EFS) to encrypt database files in SQL Server, the performance of some SQL Server features is decreased. For example, the [read-ahead](/sql/relational-databases/reading-pages) and [checkpoint](/sql/relational-databases/logs/database-checkpoints-sql-server) features.

## Cause

This issue occurs because asynchronous I/O requests from SQL Server are converted to synchronous I/O operations on an EFS-encrypted database file. See [Asynchronous disk I/O appears as synchronous on Windows](../../../windows/win32/asynchronous-disk-io-synchronous.md#ntfs-encryption) for more information. During the I/O operation, the worker thread waits until the I/O operation is complete. When the thread waits for the I/O operation, the SQL Server scheduler will be suspended until the current worker thread continues. Therefore, the worker threads that remain on the scheduler will be pending until the first worker thread continues the I/O operation. However, for asynchronous I/O, the thread requests the I/O and continues performing other tasks.

> [!NOTE]
> Asynchronous I/O still appears to be synchronous because of the [New Technology File System (NTFS) compression](../../../windows/win32/asynchronous-disk-io-synchronous.md#compression). The file system driver will not access compressed files asynchronously. Instead, all operations are made synchronous.

## Workaround

SQL Server offers many encryption technologies, such as [Transparent Data Encryption (TDE)](/sql/relational-databases/security/encryption/transparent-data-encryption), [Always Encrypted](/sql/relational-databases/security/encryption/always-encrypted-database-engine), and [column-level encryption Transact-SQL functions](/sql/t-sql/functions/cryptographic-functions-transact-sql). Consider using these [encryption](/sql/relational-databases/security/encryption/sql-server-encryption) features instead of EFS.

> [!NOTE]
> When you use EFS to encrypt a database file, the whole database file is encrypted, regardless of the actual data and metadata that're contained in the database file. You can also use EFS in case of possible loss of physical media.

## References

[Configure a Secure File System](/sql/sql-server/install/security-considerations-for-a-sql-server-installation)
