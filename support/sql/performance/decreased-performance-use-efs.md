---
title: Decreased performance when using EFS to encrypt database files
description: Fixes the decreased performance issue in SQL Server when you use Encrypting File System to encrypt database files.
ms.date: 12/08/2021
ms.prod-support-area-path: Performance
author: cobibi
ms.author: v-yunhya
ms.prod: sql
---
# Decreased performance in SQL Server when you use EFS to encrypt database files

_Applies to:_ &nbsp; SQL Server

## Symptoms

When you use Encrypting File System (EFS) to encrypt database files in SQL Server, the performance of some SQL Server features is decreased. For example, the [read-ahead](/sql/relational-databases/reading-pages) and [checkpoint](/sql/relational-databases/logs/database-checkpoints-sql-server) features.

## Cause

This issue occurs because asynchronous I/O requests coming from SQL Server are turned into synchronous I/O operations on an EFS-encrypted database file. See [Asynchronous disk I/O appears as synchronous on Windows](/troubleshoot/windows/win32/asynchronous-disk-io-synchronous#ntfs-encryption). What this means is during the I/O operation, the worker thread waits until the I/O operation is completed. In asynchronous I/O the thread requesting the I/O and continues performing other tasks. When the thread is waits for the I/O operation, the SQL Server scheduler will be suspended until the current worker thread continues. Therefore, the worker threads that remain on the scheduler will be pending until the first worker thread continues the I/O operation.

> [!NOTE]
> Asynchronous I/O still appears to be synchronous because of the [New Technology File System (NTFS) compression](/windows/win32/asynchronous-disk-io-synchronous.md#compression). The file system driver will not access compressed files asynchronously. Instead, all operations are made synchronous.

## Workaround

SQL Server offers a rich set of encryption technologies - Transparent Data Encryption (TDE), Always Encrypted, and column-level encryption T-SQL functions. Instead of EFS, consider using these [encryption](/sql/relational-databases/security/encryption/sql-server-encryption) features.

If you want to use EFS, you can specify the [affinity mask](/sql/database-engine/configure-windows/affinity-input-output-mask-server-configuration-option) option. Then, I/O operation requests will be assigned to a separate scheduler. Although the I/O operations are still synchronous, the worker thread will continue instead of waiting for the I/O operation to complete.

> [!NOTE]
> When you use EFS to encrypt a database file, the whole database file is encrypted, regardless of the actual data and metadata that're contained in the database file. You can also use EFS in case of possible loss of physical media.
