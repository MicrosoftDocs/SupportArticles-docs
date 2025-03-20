---
title: Error 3853 When Using Incremental Statistics And Resumable Index Operations
description: This article helps you resolve SQL Server error 3853 that occurs when you use incremental statistics and resumable index operations concurrently.
ms.date: 03/19/2025
ms.custom: sap:File, Filegroup, Database Operations or Corruption
ms.reviewer: rtownsend
---

# SQL Server error 3853 when using incremental statistics and resumable index operations concurrently

## Applies to

- Microsoft SQL Server 2019
- Microsoft SQL Server 2017
- Microsoft SQL Server 2016

## Symptoms
 
When you run a [DBCC CHECKDB](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql) command, the following output might be generated:

```output
Corruption in database ID %I64d, object ID %ld possibly due to schema or catalog inconsistency. Run DBCC CHECKCATALOG.
```

You might also see the following error message in the SQL Server error log:

```output
Attribute (%ls) of row (%ls) in sys.%ls%ls does not have a matching row (%ls) in sys.%ls%ls.
Msg 3853, Level 16, State 1, Line 10
```

## Cause

The 3853 error is caused by orphaned records under the `sys.syssingleobjrefs` system table. The `stats_id` in `sys.stats` is still `2`, while it's `896002` in `syssingleobjrefs`. The issue occurs under the following scenarios:

- The source `object_id` is a partitioned table or index.
- Incremental statistics are in use for table or index.
- Index create or rebuild is performed using the **RESUMABLE** option.
- Incremental statistics are updated or the index is rebuilt online.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the [Applies to](#applies-to) section.  Microsoft has also confirmed that the issue is fixed in [Microsoft SQL Server 2022](https://www.microsoft.com/sql-server/sql-server-downloads).

## Resolution

If the issue occurs, try the following options:

- Contact the Microsoft Customer Support team to request assistance with correcting the metadata.
- Restore the database from the most recent valid backup.
- Create a new database and import the data from the corrupted database using data import or export tools or manual export-import methods.
- Upgrade to SQL Server 2022 where the issue has been fixed.

## Workaround

To avoid this issue, don't use incremental statistics and resumable index operations simultaneously.
