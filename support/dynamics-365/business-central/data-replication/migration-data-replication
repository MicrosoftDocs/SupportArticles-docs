---
title: Data replication troubleshooting
description: Troubleshooting article for data replication process in Business Central cloud migration
ms.author: jswymer 
ms.reviewer: jswymer 

ms.topic: troubleshooting 
ms.date: 01/02/2024
ms.custom: bap-template
---

# Troubleshoot data replication issues in cloud migration

This article explains how to fix errors that you might encounter when you run data replication during cloud migration.

## The Self-hosted Integration Runtime is offline

Resolution:

- Make sure that the machine hosting Integration Runtime stays online all the time.
- Shutting down the Integration Runtime host temporarily can be used to cancel an ongoing migration run, but if the host stays offline for too long, all cloud migration infrastructure might be automatically cleaned up, making resuming migrations impossible.
- Make sure to wait before replacing the source database, or restoring it from a backup, until the migration run has completed.

## A database operation failed with the following error: 'Invalid object name … '

Refer to previous issue.

## A database operation failed with the following error: 'Couldn't find stored procedure ' … '

Refer to previous issue.

## The specified row delimiter is incorrect. Can't detect a row after parse 100-MB data.

Cause:

This error usually happens for large tables when they're copied table to table. This error happens only if the migration source is a SQL Server database, when the whole table is large and a single field contains a large value. For example, images larger than 20 MB stored in table fields might cause this error.

Resolution:

The only reliable solution is to deploy the source database in Azure SQL, then set up cloud migration from the Azure SQL database instead of the on-premises SQL Server. However, you can try to redirect the failed tables to bulk copy path instead of full copy. For example, alter the on-premises stored procedure `'dbo.IsFullCopyTable'` by inserting a block like:

```sgl
IF @SqlTableName = '<failed SQL table name>'
    BEGIN
        SET @IsFullCopy = 0
        RETURN
    END
```

In many cases, though, this operation causes out of memory exceptions and timeouts in the on-premises SQL Server.

## Next steps

[Run data replication](migrate-data-replication-run.md)  