---
title: Bulk load operations can lead to large amounts of unused space
description: This article provides solutions for the issue where bulk load operations with a small batch size lead to much unused space
ms.date: 02/16/2023
ms.custom: sap:Administration and management
ms.reviewer: 
author: PiJoCoder
ms author: jopilov
ms.prod: sql
---

# Bulk load operations can lead to large amounts of unused space

## Symptoms:

You may observe high consistent growth of unused space for tables in your database(s) when you perform bulk load operations. For example, if you run the `sp_spaceused` command you may see that the unused space in the table is a large percentage of the reserved space (overall space allocated for the table). Here's an illustration:

```sql
exec sp_spaceused 'Sales.Customer'
```

|Table          |Reserved (KB)  |Data (KB)   |Index (KB)  | Unused (KB) |
|---------      |-------------  |---------   |---------   |--------     |
|Sales.Customer | 800000        |  50000     | 10000      | 740000      |

## Cause:

If you use Bulk load operation with small batch size, tables may allocate page [extents](/sql/relational-databases/pages-and-extents-architecture-guide#extents) that are barely used.
Bulk load operations with minimal logging help improve the performance of data load operations in indexes when data is pre-ordered or sequentially loaded. But the batchsize you use (BATCHSIZE in [BULK INSERT](/sql/t-sql/statements/bulk-insert-transact-sql) and -b option in [bcp utility](/sql/tools/bcp-utility)) plays a critical role to achieve faster performance combined with efficient space utilization in bulk load operations. Within the fast load context, each bulk load batch allocates one or more new extents, bypassing the allocation cache lookup for existing extent with available free space. Not looking for existing free space on extents and creating new ones optimizes insert performance. However, if you utilize smaller batchsize, for example 10 rows per batch, SQL Server reserves a new 64-KB extent for every 10 records batch, which is wasteful with most row sizes. The remaining pages in the extent are unused but reserved for the object. So this fast load optimization combined with a smaller batch size leads to inefficient space utilization.

The following [blog](/archive/blogs/sql_server_team/sql-server-2016-minimal-logging-and-impact-of-the-batchsize-in-bulk-load-operations) shows some empirical evidence to illustrate this behavior:

|Batch Size     |Reserved (KB)  |Data (KB)   |Index (KB)  | Unused (KB) | Percent(%) Unused |
|---------      |-------------  |---------   |---------   |--------     |------------       |
|10             | 6472          |  808       | 8          | 5656        |  87               |
|100            | 1352          |  168       | 8          | 1176        |  86               |
|1000           | 264           |  128       | 8          | 128         |  49               |


## Resolution:

There are a few options to consider in resolving this issue:

### Small number of inserts means no bulk load operations

If you have a relatively small number of rows to insert, then these aren't "bulk" inserts. In those cases of small batch sizes, using BULK INSERTS and the [minimal logging optimizations](/sql/relational-databases/import-export/prerequisites-for-minimal-logging-in-bulk-import) for bulk loading of data aren't applicable. So, don't use them.

#### Set the batchsize value for bulk load operation

For bulk load operations, choose a batchsize that is a multiple of the size of an extent (64 KB) and is based on the average row size. Such a batch size value would allow the rows to efficiently fill the space within the extent. For example, if the average row size is 25 bytes, you would divide 64 KB by 25 bytes per row to see how many rows you can pack in a batch size. In this case 64 KB = 65536 bytes / 25 bytes per row = 2730 rows. Thus, you can choose a batch size around this number, allowing for space for the header of each data page. You can test with batchsize = 2700 or batchsize = 2500. To find the average row size in your table, use following query. For heaps (tables with no clustered index) use 0 for the index_id parameter (the third parameter). For tables with clustered indexes, use 1 as in this example.

```sql
SELECT 
  index_type_desc,alloc_unit_type_desc, 
  avg_record_size_in_bytes, 
  max_record_size_in_bytes, 
  avg_page_space_used_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(N'AdventureWorks2016'), OBJECT_ID(N'Production.ProductDocument'), 1, NULL , 'DETAILED')
```

>[!NOTE]
> Be careful not to set the batchsize to too large of a value as this could cause burts of large I/O requests. For more information, see [I/O effect of exceedingly large batch size](#io-effect-of-exceedingly-large-batch-size).

### When batchsize change isn't an option for bulk load operation

If for some reason, you can't change the batchsize or use regular INSERTS, you can disable fast inserts (minimal logging) behavior using [trace flag 692](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf692). With fast inserts enabled by default after SQL Server 2016, each bulk load batch allocates new extent(s) and bypasses the lookup for available free space in existing pages. Therefore, bulk loads with small batch sizes can lead to an increase in unused space in objects. Trace flag 692 disables fast inserts while bulk loading data into a heap or clustered index and minimizes the unused space issue described here.
To enable the trace flag, you can either do it while SQL Server is online via this query

```sql
DBCC TRACEON(692,-1)
```

Or you can add -T692 as a SQL Server service startup parameter to enable the TF 692 automatically upon SQL Server service restart.


### I/O effect of exceedingly large batch size

It's important to remember that in minimal logging mode, SQL Server flushes data pages as soon as it commits the batch (sometimes referred to eager writes). This is because minimal logging means no individual log records are written to the transaction log, only extent allocations are logged. SQL Server writes the data pages filled with data to disk immediately. Thus if you choose too a large of a batch size, it can lead to write I/O bursts. If the I/O subsystem isn't capable of handling the write I/O bursts, it can adversely affect the performance of bulk load operation and all other transactions running on SQL Server instance at that time. In other words, there's a point of diminishing benefit with batch size: if you make it too large, the benefit decreases.

It's therefore important to choose a batchsize, which is a multiple of the size of an extent (64 KB) based on the average row size. Depending on the underlying disk I/O performance, you can choose a batchsize anywhere between the size of one extent (64 KB) to 64 extents (4 MB), to strike a balance between efficient space utilization and optimal bulk load performance.

