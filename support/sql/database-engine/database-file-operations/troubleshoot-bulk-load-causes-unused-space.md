---
title: Bulk load operations can leave large amounts of unused space
description: Learn how to resolve the issue of excessive unused space in bulk load operations that have a small batch size.
ms.date: 02/27/2023
ms.custom: sap:Administration and management
ms.reviewer: jopilov
author: padmajayaraman
ms author: v-jayaramanp
ms.prod: sql
---

# Excessive unused space after running bulk load operations

## Symptoms

You might observe consistently high growth of unused space for tables in your databases when you run bulk load operations. For example, if you run the `sp_spaceused` command, the unused space in the table occupies a large percentage of the reserved space (overall space allocated for the table).

```sql
EXEC sp_spaceused 'Sales.Customer'
```

Here's an example.

| Table          | Reserved (KB) | Data (KB) | Index (KB) | Unused (KB) |
| -------------- | ------------- | --------- | ---------- | ----------- |
| Sales.Customer | 800000        | 50000     | 10000      | 740000      |

## Cause

If you use bulk load operation that have a small batch size, tables might allocate page [extents](/sql/relational-databases/pages-and-extents-architecture-guide#extents) that are barely used.

Running bulk load operations that use minimal logging can help improve the performance of data load operations in indexes if the data is pre-ordered or sequentially loaded. But the batch size that you use (`BATCHSIZE` in [BULK INSERT](/sql/t-sql/statements/bulk-insert-transact-sql) and `-b` option in [bcp utility](/sql/tools/bcp-utility)) in these operations plays a critical role in achieving faster performance and efficient space usage. Each bulk load batch allocates one or more new extents. This bypasses the allocation cache lookup for existing extents that have available free space. You can optimize insert performance by creating extents instead of seeking free space on existing extents. However, if you use a smaller batch size (for example, 10 rows per batch), SQL Server reserves a new 64-KB extent for every batch of 10 records. This is wasteful for most row sizes. The remaining pages in the extent are unused but reserved for the object. Therefore, this fast load optimization combined with a smaller batch size causes inefficient space usage.

The following table from [the MSSQL Tiger Team blog site](/archive/blogs/sql_server_team/sql-server-2016-minimal-logging-and-impact-of-the-batchsize-in-bulk-load-operations) shows some empirical evidence to illustrate this behavior.

| Batch size  | Reserved (KB)  | Data (KB)  | Index size (KB)  | Unused (KB)  | Percent (%) unused |
| ----------  | -------------  | ---------  | ---------------  | -----------  | ------------------ |
| 10          | 6472           | 808        | 8                | 5656         | 87                 |
| 100         | 1352           | 168        | 8                | 1176         | 86                 |
| 1000        | 264            | 128        | 8                | 128          | 49                 |

## Resolution

To resolve this issue, consider the following guidelines.

### Small number of inserts means no bulk load operations

If you have a relatively small number of rows to insert, then these aren't "bulk" inserts. In cases of small batch sizes, we recommend that you don't use `BULK INSERTS` and the [minimal logging optimizations](/sql/relational-databases/import-export/prerequisites-for-minimal-logging-in-bulk-import) for bulk loading of data.

### Setting the batch size value for bulk load operation

For bulk load operations, choose a batch size that's a multiple of the size of an extent (64 KB) and is based on the average row size. Such a batch size value would allow the rows to efficiently fill the space within the extent. For example, if the average row size is 25 bytes, you would divide 64 KB by 25 bytes per row to determine how many rows you can pack into a batch size. In this case, 64 KB = 65536 bytes divided by 25 bytes per row provide 2,730 rows. Therefore, you can choose a batch size around this number, allowing space for the header of each data page. You can test this by using batch sizes of 2,700 or 2,500. To find the average row size in your table, use the following query. For heaps (tables that have no clustered index), use **0** for the [index_ID](/sql/relational-databases/system-dynamic-management-views/sys-dm-db-index-physical-stats-transact-sql?view=sql-server-ver16&preserve-view=true) parameter (the third parameter). For tables that have clustered indexes, use **1**, as shown in the following example.

```sql
SELECT 
  index_type_desc,alloc_unit_type_desc, 
  avg_record_size_in_bytes, 
  max_record_size_in_bytes, 
  avg_page_space_used_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(N'AdventureWorks2016'), OBJECT_ID(N'Production.ProductDocument'), 1, NULL , 'DETAILED')
```

> [!NOTE]
> Be careful not to set the batch size to a large value because doing this could cause bursts of large I/O requests. For more information, see [I/O effect of exceedingly large batch sizes](#io-effect-of-exceedingly-large-batch-sizes).

### If batch size configuration isn't an option for bulk load operation

If, for some reason, you can't change the batch size or use regular `INSERTS`, you can disable the fast inserts (minimal logging) behavior by using [trace flag 692](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf692) (TF 692). If you have fast inserts enabled by default after SQL Server 2016, each bulk load batch allocates new extents and bypasses the lookup for available free space in existing pages. Therefore, bulk load operations that have small batch sizes can cause an increase in unused space in objects. TF 692 disables fast inserts while loading bulk data into a heap or clustered index. This minimizes the unused space issue that is described in the [Symptoms](#symptoms) section.

You can enable the trace flag while SQL Server is online by using the following query:

```sql
DBCC TRACEON(692,-1)
```

Alternatively, you can add `-T692` as a SQL Server service startup parameter to enable TF 692 automatically upon SQL Server service restart.

### I/O effect of exceedingly large batch sizes

Remember that in minimal logging mode, SQL Server flushes data pages as soon as it commits the batch (also known as _eager writes_). This is because minimal logging means that no individual log records are written to the transaction log, only extent allocations are logged. To ensure data isn't lost in the event of an outage, SQL Server writes the data pages that are filled with data to disk immediately. Therefore, if you choose a large batch size, this can cause write I/O bursts. If the I/O subsystem can't handle the write I/O bursts, this can adversely affect the performance of bulk load operation and all other transactions that are running on the SQL Server instance at that time. In other words, there's a point of diminishing benefit regarding batch size: if you choose too large a batch size, the benefit decreases.

Therefore, it's important to choose a batch size that's a multiple of the size of an extent (64 KB) based on the average row size. Depending on the underlying disk I/O performance, you can choose a batch size that's anywhere between the size of one extent (64 KB) and 64 extents (4 MB). This range strikes a balance between efficient space utilization and optimal bulk load performance.
