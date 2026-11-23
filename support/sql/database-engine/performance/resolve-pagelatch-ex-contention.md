---
title: Resolve PAGELATCH_EX Contention in SQL Server
description: Learn how to identify and resolve last-page insert PAGELATCH_EX contention in SQL Server by using OPTIMIZE_FOR_SEQUENTIAL_KEY, index redesign, or partitioning.
ms.author: jopilov
author: PiJoCoder
ms.reviewer: jopilov
ms.date: 11/11/2026
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ai-usage: ai-assisted
---
# Resolve last-page insert PAGELATCH_EX contention in SQL Server

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4460004

## Summary

This article explains how to identify and resolve last-page insert `PAGELATCH_EX` contention in SQL Server. This contention occurs when many concurrent sessions insert rows into an index that has a sequential leading key, such as an identity column, and all the sessions compete for the same page. It typically affects database administrators and developers who manage high-concurrency workloads on servers that have 16 or more CPUs. Use the diagnostic script and the resolution methods in this article to confirm the contention, find the affected index, and mitigate the contention to improve insert throughput.

## Symptoms

Consider the following scenarios:

- You have a column that includes sequential values such as an [Identity column](/sql/t-sql/statements/create-table-transact-sql-identity-property) or a DateTime column that is inserted through the **Getdate()** function.

- You have a [clustered index](/sql/relational-databases/indexes/clustered-and-nonclustered-indexes-described) that has the sequential column as a leading column.

    > [!NOTE]  
    > The most common scenario is a clustered primary key on an Identity column. Less frequently, you might observe this issue for nonclustered indexes.

- Your application frequently runs `INSERT` or `UPDATE` operations against the table.

- Your system has many CPUs. Typically, the server has 16 CPUs or more. This hardware configuration allows multiple sessions to concurrently run `INSERT` operations against the same table.

In this situation, you might experience a decrease in performance of your application. When you examine wait types in [sys.dm_exec_requests](/sql/relational-databases/system-dynamic-management-objects/sys-dm-exec-requests-transact-sql), you observe waits on the **PAGELATCH_EX** wait type and many sessions that are waiting on this wait type.

To check whether `PAGELATCH_EX` contention exists, run the following diagnostic query while the performance slowdown is occurring, such as during peak or heavy-insert periods. `sys.dm_exec_requests` returns only requests that are currently executing, so the query returns no rows if you run it when the system is idle or the contention isn't occurring.

```sql
SELECT session_id, wait_type, wait_time, wait_resource
FROM sys.dm_exec_requests
WHERE session_id > 50 AND wait_type = 'PAGELATCH_EX';
```

If contention is occurring, you might get results that resemble the following.

| session_id | wait_type | wait_time | wait_resource |
| --- | --- | --- | --- |
| 60 | PAGELATCH_EX | 100 | 5:1:4144 |
| 75 | PAGELATCH_EX | 123 | 5:1:4144 |
| 79 | PAGELATCH_EX | 401 | 5:1:4144 |
| 80 | PAGELATCH_EX | 253 | 5:1:4144 |
| 81 | PAGELATCH_EX | 312 | 5:1:4144 |
| 82 | PAGELATCH_EX | 355 | 5:1:4144 |
| 84 | PAGELATCH_EX | 312 | 5:1:4144 |
| 85 | PAGELATCH_EX | 338 | 5:1:4144 |
| 87 | PAGELATCH_EX | 405 | 5:1:4144 |
| 88 | PAGELATCH_EX | 111 | 5:1:4144 |
| 90 | PAGELATCH_EX | 38 | 5:1:4144 |
| 92 | PAGELATCH_EX | 115 | 5:1:4144 |
| 94 | PAGELATCH_EX | 49 | 5:1:4144 |
| 101 | PAGELATCH_EX | 301 | 5:1:4144 |
| 102 | PAGELATCH_EX | 45 | 5:1:4144 |
| 103 | PAGELATCH_EX | 515 | 5:1:4144 |
| 105 | PAGELATCH_EX | 39 | 5:1:4144 |

### Interpret the wait_resource value

In the previous results, multiple sessions are all waiting for the same resource. The `wait_resource` value uses the format `database_id:file_id:page_id`. In this example:

database_id = 5, file_id = 1, database page_id = 4144

> [!NOTE]  
> The database_id should be a user database (the ID number is greater than or equal to **5**). If the database_id is **2**, you might be experiencing the issue that's discussed in [Files, trace flags and updates on TEMPDB](/archive/blogs/sql_server_team/tempdb-files-and-trace-flags-and-updates-oh-my).

## PAGELATCH overview

**PAGELATCH** (latch on a data or index page) is a thread-synchronization mechanism. It's used to synchronize short-term physical access to database pages that are located in the Buffer cache. A **PAGELATCH_EX** indicates an exclusive latch was temporarily placed on a buffer page in memory.

**PAGELATCH** differs from a **PAGEIOLATCH**. The latter is used to synchronize physical access to pages when they're read from or written to disk. For more information about pages, see the [Pages and extents architecture guide](/sql/relational-databases/pages-and-extents-architecture-guide).

## Why last-page insert contention occurs

Page latches are common in every system because they ensure physical page protection. A clustered index orders the data by the leading key column. For this reason, when you create the index on a sequential column, all new data inserts occur on the same page at the end of the index until that page is filled. That means, that all  threads doing the inserts would attempt to place a page latch on the same page in memory.

However, under high load, the concurrent INSERT operations might cause contention on the last page of the B-tree. This contention can occur on clustered and nonclustered indexes. The reason is that nonclustered indexes order the leaf-level pages by the leading key. This issue is also known as last-page insert contention.

To resolve this contention, the overall strategy is to prevent all concurrent INSERT operations from accessing the same database page. Instead, make each INSERT operation access a different page and increase concurrency. Therefore, any of the methods described in this article that organize the data by a column other than the sequential column achieves this goal.

For more information, see [Diagnose and resolve latch contention on SQL Server](/sql/relational-databases/diagnose-resolve-latch-contention).

## Confirm PAGELATCH_EX contention and identify the contended resource

This T-SQL script helps you discover if there are `PAGELATCH_EX` waits on the system with multiple sessions (five or more) with significant wait time (10 ms or more). It also helps you discover which object and index the contention is on by using [sys.dm_exec_requests](/sql/relational-databases/system-dynamic-management-objects/sys-dm-exec-requests-transact-sql) together with one of the following:

- [DBCC PAGE](https://techcommunity.microsoft.com/t5/sql-server/how-to-use-dbcc-page/ba-p/383094) (all versions of SQL Server)
- [sys.fn_PageResCracker](/sql/relational-databases/system-functions/sys-fn-pagerescracker-transact-sql) and [sys.dm_db_page_info](/sql/relational-databases/system-dynamic-management-objects/sys-dm-db-page-info-transact-sql) (SQL Server 2019 and later versions)

> [!IMPORTANT]  
> Run the script while the slowdown or contention is occurring, such as during peak or heavy-insert periods. If you run it when the system is idle, it reports that no contention was found.

```sql
SET NOCOUNT ON
DECLARE @dbname SYSNAME, @dbid INT, @objectid INT, @indexid INT, @indexname SYSNAME, @sql VARCHAR(8000), @manul_identification VARCHAR(8000)

IF (CONVERT(INT, SERVERPROPERTY('ProductMajorVersion')) >= 15)
BEGIN

    DROP TABLE IF EXISTS #PageLatchEXContention

    SELECT DB_NAME(page_info.database_id) DbName, r.db_id DbId, page_info.[object_id] ObjectId, page_info.index_id IndexId
    INTO #PageLatchEXContention
    FROM sys.dm_exec_requests AS er
        CROSS APPLY sys.dm_exec_sql_text(er.sql_handle) AS st
        CROSS APPLY sys.fn_PageResCracker (er.page_resource) AS r
        CROSS APPLY sys.dm_db_page_info(r.[db_id], r.[file_id], r.page_id, 'DETAILED') AS page_info
    WHERE er.wait_type = 'PAGELATCH_EX' AND page_info.database_id not in (db_id('master'),db_id('msdb'), db_id('model'), db_id('tempdb'))
    GROUP BY DB_NAME(page_info.database_id), r.db_id, page_info.[object_id], page_info.index_id
    HAVING COUNT(er.session_id) > 5 AND Max (er.wait_time) > 10

    SELECT * FROM #PageLatchEXContention
    IF EXISTS (SELECT 1 FROM #PageLatchEXContention)
    BEGIN
        DECLARE optimize_for_seq_key_cursor CURSOR FOR
            SELECT DbName, DbId, ObjectId, IndexId FROM #PageLatchEXContention
            
        OPEN optimize_for_seq_key_cursor
        FETCH NEXT FROM optimize_for_seq_key_cursor into @dbname, @dbid, @objectid , @indexid
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SELECT 'Consider using below statement to enable OPTIMIZE_FOR_SEQUENTIAL_KEY for the indexes in the "' + @dbname + '" database' AS Recommendation
            SELECT @sql =  'select ''use ' + @dbname + '; ALTER INDEX '' + i.name + '' ON ' + OBJECT_NAME(@objectid, @dbid) + ' SET (OPTIMIZE_FOR_SEQUENTIAL_KEY = ON )'' AS Corrective_Action from #PageLatchEXContention pl JOIN ' + @dbname+'.sys.indexes i ON pl.ObjectID = i.object_id WHERE object_id = ' + CONVERT(VARCHAR, @objectid) + ' AND index_id = ' + CONVERT(VARCHAR, @indexid)

            EXECUTE (@sql)
            FETCH NEXT FROM optimize_for_seq_key_cursor INTO @dbname, @dbid, @objectid , @indexid

        END

        CLOSE optimize_for_seq_key_cursor
        DEALLOCATE optimize_for_seq_key_cursor
    
    END
    ELSE
        SELECT 'No PAGELATCH_EX contention found on user databases in SQL Server at this time'
END
ELSE
BEGIN
    
    IF OBJECT_ID('tempdb..#PageLatchEXContentionLegacy') IS NOT NULL
        DROP TABLE #PageLatchEXContentionLegacy
    
    SELECT 'dbcc traceon (3604); dbcc page(' + replace(wait_resource,':',',') + ',3); dbcc traceoff (3604)' TSQL_Command
    INTO #PageLatchEXContentionLegacy
    FROM sys.dm_exec_requests er
    WHERE er.wait_type = 'PAGELATCH_EX' AND er.database_id NOT IN (db_id('master'),db_id('msdb'), db_id('model'), db_id('tempdb'))
    GROUP BY wait_resource
    HAVING COUNT(er.session_id) > 5 AND Max (er.wait_time) > 10

    SELECT * FROM #PageLatchEXContentionLegacy
    
    IF EXISTS(SELECT 1 FROM #PageLatchEXContentionLegacy)
    BEGIN
        SELECT 'On SQL Server 2017 or lower versions, you can manually identify the object where contention is occurring using DBCC PAGE locate the m_objId = ??. Then SELECT OBJECT_NAME(object_id_identified) and locate indexes with sequential values in this object' AS Recommendation
        
        DECLARE get_command CURSOR FOR
            SELECT TSQL_Command from #PageLatchEXContentionLegacy

        OPEN get_command
        FETCH NEXT FROM get_command into @sql
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SELECT @sql AS Step1_Run_This_Command_To_Find_Object
            SELECT 'select OBJECT_NAME(object_id_identified)' AS Step2_Find_Object_Name_From_ID
            FETCH NEXT FROM get_command INTO @sql
        END

        CLOSE get_command
        DEALLOCATE get_command

        SELECT 'Follow https://learn.microsoft.com/troubleshoot/sql/database-engine/performance/resolve-pagelatch-ex-contention for resolution recommendations that fits your environment best' Step3_Apply_KB_article
        
    END
    ELSE
        SELECT 'No PAGELATCH_EX contention found on user databases in SQL Server at this time'

END
```

## Choose a method to resolve the contention

You can use one of the following methods to resolve the issue. Choose the one that best fits your circumstances.

- **Method 1:** Use the `OPTIMIZE_FOR_SEQUENTIAL_KEY` index option (SQL Server 2019 and later versions).
- **Methods 2 to 5:** Change the index design so that inserts don't all target the same last page.
- **Method 6:** Use table partitioning (Enterprise edition, or Standard edition in SQL Server 2016 SP1 and later versions).
- **Method 7:** Move the contended table to In-Memory OLTP.

### Method 1: Use OPTIMIZE_FOR_SEQUENTIAL_KEY index option (SQL Server 2019 and later versions)

In SQL Server 2019 (15.x), a new index option (`OPTIMIZE_FOR_SEQUENTIAL_KEY`) was added that can help resolve this issue without using any of the following methods. You can set the option when you create or alter an index. For more information, see [CREATE INDEX](/sql/t-sql/statements/create-index-transact-sql), [ALTER INDEX](/sql/t-sql/statements/alter-index-transact-sql), and [What's new in SQL Server 2019](/sql/sql-server/what-s-new-in-sql-server-2019).

For a deeper explanation of how the option works, see [Behind the Scenes on OPTIMIZE_FOR_SEQUENTIAL_KEY](https://techcommunity.microsoft.com/t5/SQL-Server/Behind-the-Scenes-on-OPTIMIZE-FOR-SEQUENTIAL-KEY/ba-p/806888).

### Method 2: Move primary key off identity column

Make the column that contains sequential values a nonclustered index, and then move the clustered index to another column. For example, for a primary key on an identity column, remove the clustered primary key, and then re-create it as a nonclustered primary key. This method is the easiest to follow and directly achieves the objective.

For example, assume that you have the following table that you defined by using a clustered primary key on an [Identity column](/sql/t-sql/statements/create-table-transact-sql-identity-property).

```sql
USE testdb;

CREATE TABLE Customers
( CustomerID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
CustomerLastName VARCHAR (32) NOT NULL,
CustomerFirstName VARCHAR(32) NOT NULL );
```

To change this design, remove the primary key index and redefine it.

```sql
USE testdb;

ALTER TABLE Customers
DROP CONSTRAINT PK__Customer__A4AE64B98819CFF6;

ALTER TABLE Customers
ADD CONSTRAINT pk_Cust1
PRIMARY KEY NONCLUSTERED (CustomerID)
```

### Method 3: Make the leading key a nonsequential column

Reorder the clustered index definition so that the leading column isn't the sequential column. This method requires that the clustered index is a composite index. For example, in a customer table, you can make a **CustomerLastName** column be the leading column, followed by the **CustomerID**. Thoroughly test this method to ensure that it meets performance requirements.

```sql
USE testdb;

ALTER TABLE Customers
ADD CONSTRAINT pk_Cust1
PRIMARY KEY CLUSTERED (CustomerLastName, CustomerID)
```

### Method 4: Add a new nonsequential value as a leading key

This method provides an example of adding a new nonsequential value to the table and using it as a leading index column. In this case, use a hash value as the leading index key. This technique also helps spread out the inserts. A hash value is generated as a modulo that matches the number of CPUs on the system. For example, on a 16-CPU system, you can use a modulo of 16. This method spreads out the `INSERT` operations uniformly across multiple database pages.

```sql
USE testdb;

CREATE TABLE Customers
( CustomerID BIGINT IDENTITY(1,1) NOT NULL,
CustomerLastName VARCHAR (32) NOT NULL,
CustomerFirstName VARCHAR(32) NOT NULL );

ALTER TABLE Customers
ADD [HashValue] AS (CONVERT([TINYINT], abs([CustomerID])%16)) PERSISTED NOT NULL;

ALTER TABLE Customers
ADD CONSTRAINT pk_table1
PRIMARY KEY CLUSTERED (HashValue, CustomerID);
```

### Method 5: Use a GUID as a leading key

Use a GUID as the leading key column of an index to ensure the uniform distribution of inserts.

> [!NOTE]  
> Although this method achieves the goal, it presents multiple challenges, including a large index key, frequent page splits, and low page density. We don't recommend this method.

### Method 6: Use table partitioning and a computed column with a hash value

Use [table partitioning](/sql/relational-databases/partitions/partitioned-tables-and-indexes) and a computed column that has a hash value to spread out the INSERT operations. Because this method uses table partitioning, it's available only in [editions of SQL Server that support partitioned tables](/sql/sql-server/editions-and-components-of-sql-server-2025#scalability-and-performance).

The following example uses a system that has 16 CPUs.

```sql
USE testdb;

CREATE TABLE Customers
( CustomerID BIGINT IDENTITY(1,1) NOT NULL,
CustomerLastName VARCHAR (32) NOT NULL,
CustomerFirstName VARCHAR(32) NOT NULL );

ALTER TABLE Customers
ADD [HashID] AS CONVERT(TINYINT, ABS(CustomerID % 16)) PERSISTED NOT NULL;

CREATE PARTITION FUNCTION pf_hash (TINYINT) AS RANGE LEFT FOR VALUES (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15) ;

CREATE PARTITION SCHEME ps_hash AS PARTITION pf_hash ALL TO ([PRIMARY]);

CREATE UNIQUE CLUSTERED INDEX CIX_Hash
ON Customers (CustomerID, HashID) ON ps_hash(HashID);
```

### Method 7: Switch to In-Memory OLTP

Alternatively, use [In-Memory OLTP](/sql/relational-databases/in-memory-oltp/overview-and-usage-scenarios), particularly if the latch contention is high. This technology eliminates the latch contention. However, you have to redesign and migrate the specific table or tables where page latch contention occurs to a memory-optimized table.

Use the [Memory Optimization Advisor](/sql/relational-databases/in-memory-oltp/memory-optimization-advisor) and the [Transaction Performance Analysis Report](/sql/relational-databases/in-memory-oltp/determining-if-a-table-or-stored-procedure-should-be-ported-to-in-memory-oltp) to determine whether migration is possible and what effort is required to do the migration.

For more information about how In-Memory OLTP eliminates latch contention, download and review the document in [In-Memory OLTP - Common Workload Patterns and Migration Considerations](/previous-versions/dn673538(v=msdn.10)).

## Related content

- [PAGELATCH_EX waits and heavy inserts](/archive/blogs/blogdoezequiel/pagelatch_ex-waits-and-heavy-inserts)
- [Index design guide](/sql/relational-databases/sql-server-index-design-guide)
- [sys.dm_os_wait_stats](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql)
- [sys.dm_db_index_physical_stats](/sql/relational-databases/system-dynamic-management-objects/sys-dm-db-index-physical-stats-transact-sql)
- [ALTER TABLE index_option](/sql/t-sql/statements/alter-table-index-option-transact-sql)
