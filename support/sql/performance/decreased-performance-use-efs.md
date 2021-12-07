---
title: Decreased performance when using EFS to encrypt database files
description: Fixes the decreased performance issue in SQL Server when you use Encrypting File System to encrypt database files.
ms.date: 11/27/2021
ms.prod-support-area-path: Connection issues
author: cobibi
ms.author: v-yunhya
ms.prod: sql
---
# Decreased performance in SQL Server when you use EFS to encrypt database files

_Applies to:_ &nbsp; SQL Server

## Symptoms

When you use Encrypting File System (EFS) to encrypt database files in SQL Server, the performance of some SQL Server features is decreased. For example, the [read-ahead](/sql/relational-databases/reading-pages) and [checkpoint](/sql/relational-databases/logs/database-checkpoints-sql-server) features.

## Cause

This issue occurs because of a synchronous I/O operation on an EFS encrypted database file. During the I/O operation, the worker thread waits until the I/O operation is completed. Additionally, the SQL Server scheduler will be suspended until the current worker thread continues. Therefore, the worker threads that remain on the scheduler will be pending until the first worker thread continues the I/O operation.

> [!NOTE]
> Asynchronous I/O still appears to be synchronous because of the [New Technology File System (NTFS) compression](/windows/win32/asynchronous-disk-io-synchronous.md#compression). The file system driver will not access compressed files asynchronously. Instead, all operations are made synchronous.

## Workaround

To work around this issue, use the [encryption](/sql/relational-databases/security/encryption/sql-server-encryption) features of SQL Server, or host the EFS encrypted database files on a separate instance.

If you want to use EFS, you can specify the [affinity mask](/sql/database-engine/configure-windows/affinity-input-output-mask-server-configuration-option) option. Then, I/O operation requests will be assigned to a separate scheduler. Although the I/O operations are still synchronous, the worker thread will continue instead of waiting for the I/O operation to complete.

> [!NOTE]
> When you use EFS to encrypt a database file, the whole database file is encrypted, regardless of the actual data and metadata that're contained in the database file. You can also use EFS in case of possible loss of physical media.
