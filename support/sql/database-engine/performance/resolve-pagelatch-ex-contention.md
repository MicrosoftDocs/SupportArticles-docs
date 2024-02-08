---
title: Resolve PAGELATCH_EX contention
description: This article describes how to resolve last-page insert PAGELATCH_EX contention in SQL Server.
ms.author: jopilov
author: PiJoCoder
ms.reviewer: jopilov
ms.date: 06/15/2023
ms.custom: sap:Performance
---
# Resolve last-page insert PAGELATCH_EX contention in SQL Server

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4460004

This article introduces how to resolve last-page insert `PAGELATCH_EX` contention in SQL Server.

## Symptoms

Consider the following scenarios:

- You have a column that includes sequential values such as an Identity column or a DateTime column that is inserted through the **Getdate()** function.

- You have a clustered index that has the sequential column as a leading column.

    > [!NOTE]  
    > The most common scenario is a clustered primary key on an Identity column. Less frequently, this issue can be observed for nonclustered indexes.

- Your application does frequent INSERT or UPDATE operations against the table.

- You have many CPUs on the system. Typically, the server has 16 CPUs or more. This hardware configuration allows multiple sessions to do the INSERT operations against the same table concurrently.

In this situation, you may experience a decrease in performance of your application. When you examine wait types in `sys.dm_exec_requests`, you observe waits on the **PAGELATCH_EX** wait type and many sessions that are waiting on this wait type.

Another issue occurs if you run the following diagnostic query on your system:

**select session_id, wait_type, wait_time, wait_resource from `sys.dm_exec_requests` where session_id > 50 and wait_type = 'pagelatch_ex'**

In this situation, you may get results that resemble the following.

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

You notice that multiple sessions are all waiting for the same resource that resembles the following pattern:

database_id = 5, file_id = 1, database page_id = 4144

> [!NOTE]  
> The database_id should be a user database (the ID number is greater than or equal to **5**). If the database_id is **2**, you may, instead, be experiencing the issue that is discussed in [Files, trace flags and updates on TEMPDB](/archive/blogs/sql_server_team/tempdb-files-and-trace-flags-and-updates-oh-my).

## Cause

**PAGELATCH** (latch on a data or index page) is a thread-synchronization mechanism. It's used to synchronize short-term physical access to database pages that are located in the Buffer cache.

**PAGELATCH** differs from a **PAGEIOLATCH**. The latter is used to synchronize physical access to pages when they're read from or written to disk.

Page latches are common in every system because they ensure physical page protection. A clustered index orders the data by the leading key column. For this reason, when you create the index on a sequential column,  all new data inserts occur on the same page at the end of the index until that page is filled. However, under high load, the concurrent INSERT operations may cause contention on the last page of the B-tree. This contention can occur on clustered and nonclustered indexes. The reason is that nonclustered indexes order the leaf-level pages by the leading key. This issue is also known as last-page insert contention.

For more information, see [Diagnosing and Resolving Latch Contention on SQL Server](/sql/relational-databases/diagnose-resolve-latch-contention).

## Resolution

You can choose one of following two options to resolve the problem.

### Option 1: Execute the steps directly in a notebook via Azure Data Studio

[!INCLUDE [Install Azure Data Studio note](../../../includes/azure/install-azure-data-studio-note.md)]

> [!div class="nextstepaction"]
> [Open Notebook in Azure Data Studio](azuredatastudio://microsoft.notebook/open?url=https://raw.githubusercontent.com/microsoft/mssql-support/master/sample-scripts/DOCs-to-Notebooks/T-shooting_PagelatchEX_LastPageInsert.ipynb)

### Option 2: Follow the steps manually

To resolve this contention, the overall strategy is to prevent all concurrent INSERT operations from accessing the same database page. Instead, make each INSERT operation access a different page and increase concurrency. Therefore, any of the following methods that organize the data by a column other than the sequential column achieves this goal.

#### 1. Confirm the contention on PAGELATCH_EX and identify the contention resource

This T-SQL script helps you discover if there are `PAGELATCH_EX` waits on the system with multiple sessions (5 or more) with significant wait time (10 ms or more). It also helps you discover which object and index the contention is on using [sys.dm_exec_requests](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql) and [DBCC PAGE](https://techcommunity.microsoft.com/t5/sql-server/how-to-use-dbcc-page/ba-p/383094) or [sys.fn_PageResCracker](/sql/relational-databases/system-functions/sys-fn-pagerescracker-transact-sql) and [sys.dm_db_page_info](/sql/relational-databases/system-dynamic-management-views/sys-dm-db-page-info-transact-sql) (SQL Server 2019 only).

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
        SELECT 'No PAGELATCH_EX contention found on user databases on in SQL Server at this time'
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

        SELECT 'Follow https://learn.microsoft.com/troubleshoot/sql/performance/resolve-pagelatch-ex-contention for resolution recommendations that fits your environment best' Step3_Apply_KB_article
        
    END
    ELSE
        SELECT 'No PAGELATCH_EX contention found on user databases on in SQL Server at this time'

END
```

#### 2. Choose a method to resolve the issue

You can use one of the following methods to resolve the issue. Choose the one that best fits your circumstances.

##### Method 1: Use OPTIMIZE_FOR_SEQUENTIAL_KEY index option (SQL Server 2019 only)

In SQL Server 2019, a new index option (`OPTIMIZE_FOR_SEQUENTIAL_KEY`) was added that can help resolve this issue without using any of the following methods. See [Behind the Scenes on OPTIMIZE_FOR_SEQUENTIAL_KEY](https://techcommunity.microsoft.com/t5/SQL-Server/Behind-the-Scenes-on-OPTIMIZE-FOR-SEQUENTIAL-KEY/ba-p/806888) for more information.

##### Method 2: Move primary key off identity column

Make the column that contains sequential values a nonclustered index, and then move the clustered index to another column. For example, for a primary key on an identity column, remove the clustered primary key, and then re-create it as a nonclustered primary key. This method is the easiest follow and directly achieves the objective.

For example, assume that you have the following table that was defined by using a clustered primary key on an Identity column.

```sql
USE testdb;

CREATE TABLE Customers
( CustomerID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
CustomerLastName VARCHAR (32) NOT NULL,
CustomerFirstName VARCHAR(32) NOT NULL );
```

To change this design, you can remove the primary key index and redefine it.

```sql
USE testdb;

ALTER TABLE Customers
DROP CONSTRAINT PK__Customer__A4AE64B98819CFF6;

ALTER TABLE Customers
ADD CONSTRAINT pk_Cust1
PRIMARY KEY NONCLUSTERED (CustomerID)
```

##### Method 3: Make the leading key a non-sequential column

Reorder the clustered index definition in such a way that the leading column isn't the sequential column. This method requires that the clustered index is a composite index. For example, in a customer table, you can make a **CustomerLastName** column be the leading column, followed by the **CustomerID**. We recommend that you thoroughly test this method to make sure that it meets performance requirements.

```sql
USE testdb;

ALTER TABLE Customers
ADD CONSTRAINT pk_Cust1
PRIMARY KEY CLUSTERED (CustomerLastName, CustomerID)
```

##### Method 4: Add a non-sequential value as a leading key

Add a nonsequential hash value as the leading index key. This technique also helps spread out the inserts. A hash value is generated as a modulo that matches the number of CPUs on the system. For example, on a 16-CPU system, you can use a modulo of 16. This method spreads out the INSERT operations uniformly against multiple database pages.

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

##### Method 5: Use a GUID as a leading key

Use a GUID as the leading key column of an index to ensure the uniform distribution of inserts.

> [!NOTE]  
> Although it achieves the goal, we don't recommend this method because it presents multiple challenges, including a large index key, frequent page splits, low page density, and so on.

##### Method 6: Use table partitioning and a computed column with a hash value

Use table partitioning and a computed column that has a hash value to spread out the INSERT operations. Because this method uses table partitioning, it's usable only on Enterprise editions of SQL Server.

> [!NOTE]  
> You can use Partitioned tables in SQL Server 2016 SP1 Standard Edition. For more information, see the description of "Table and index partitioning" in the article [Editions and supported features of SQL Server 2016](/sql/sql-server/editions-and-components-of-sql-server-2016?view=sql-server-2017#RDBMSSP&preserve-view=true).

The following is an example in a system that has 16 CPUs.

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

##### Method 7: Switch to In-Memory OLTP

Alternatively, use In-Memory OLTP particularly if the latch contention is high. This technology eliminates the latch contention overall. However, you have to redesign and migrate the specific table(s), where page latch contention is observed, to a memory-optimized table. You can use the [Memory Optimization Advisor](/sql/relational-databases/in-memory-oltp/memory-optimization-advisor?view=sql-server-2017&preserve-view=true) and [Transaction Performance Analysis Report](/sql/relational-databases/in-memory-oltp/determining-if-a-table-or-stored-procedure-should-be-ported-to-in-memory-oltp?view=sql-server-2017&preserve-view=true) to determine whether migration is possible and what the effort would be to do the migration. For more information about how In-Memory OLTP eliminates latch contention, download and review the document in [In-Memory OLTP - Common Workload Patterns and Migration Considerations](/previous-versions/dn673538(v=msdn.10)).

## References

[PAGELATCH_EX waits and heavy inserts](/archive/blogs/blogdoezequiel/pagelatch_ex-waits-and-heavy-inserts)
