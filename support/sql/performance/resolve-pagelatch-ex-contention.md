---
title: Resolve PAGELATCH_EX contention
description: This article describes how to resolve last-page insert PAGELATCH_EX contention in SQL Server.
ms.date: 02/17/2020
ms.prod-support-area-path: Performance
ms.prod: sql
---
# Resolve last-page insert PAGELATCH_EX contention in SQL Server

This article introduces how to resolve last-page insert PAGELATCH_EX contention in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4460004

## Symptoms

Consider the following scenarios:

- You have a column that includes sequential values, such as an Identity column or a DateTime column, that is being inserted through the **Getdate()** function.

- You have a clustered index that has the sequential column as a leading column.

    > [!NOTE]
    > The most common scenario is a clustered primary key on an Identity column. Less frequently, this issue can be observed for nonclustered indexes.

- Your application does frequent INSERT or UPDATE operations against the table.

- You have many CPUs on the system. Typically, the server has 16 CPUs or more. This allows multiple sessions to do the INSERT operations against the same table concurrently.

In this situation, you may experience a decrease in performance of your application. When you examine wait types in **sys.dm_exec_requests**, you observe waits on the **PAGELATCH_EX** wait type and many sessions that are waiting on this wait type.

Another issue occurs if you run the following diagnostic query on your system:

**select session_id, wait_type, wait_time, wait_resource from sys.dm_exec_requests where session_id > 50 and wait_type = 'pagelatch_ex'**

In this situation, you may get results that resemble the following.

|session_id |wait_type |wait_time |wait_resource |
|----------| ---------------------- |---------------| ------------------------|
| 60 |PAGELATCH_EX |100 |5:1:4144|
| 75 |PAGELATCH_EX| 123| 5:1:4144|
| 79| PAGELATCH_EX |401 |5:1:4144 |
|80 |PAGELATCH_EX |253 |5:1:4144 |
|81 |PAGELATCH_EX |312 |5:1:4144 |
|82 |PAGELATCH_EX |355 |5:1:4144 |
|84 |PAGELATCH_EX |312| 5:1:4144 |
|85 |PAGELATCH_EX |338 |5:1:4144 |
|87| PAGELATCH_EX |405| 5:1:4144 |
|88 |PAGELATCH_EX |111 |5:1:4144 |
|90 |PAGELATCH_EX |38 |5:1:4144 |
|92 |PAGELATCH_EX |115 |5:1:4144|
| 94| PAGELATCH_EX| 49 |5:1:4144|
| 101| PAGELATCH_EX |301 |5:1:4144 |
|102 |PAGELATCH_EX |45| 5:1:4144 |
|103 |PAGELATCH_EX |515 |5:1:4144 |
|105| PAGELATCH_EX |39| 5:1:4144|

You notice that multiple sessions are all waiting for the same resource that resembles the following:

database_id = 5, file_id = 1, database page_id = 4144

> [!NOTE]
> The database_id should be a user database (the ID number is greater than or equal to **5**). If the database_id is **2**, you may, instead, be experiencing the issue that is discussed in [Files, trace flags and updates on TEMPDB](/archive/blogs/sql_server_team/tempdb-files-and-trace-flags-and-updates-oh-my).

## Cause

**PAGELATCH** (latch on a data or index page) is a thread-synchronization mechanism. It is used to synchronize short-term physical access to database pages that are located in the Buffer cache.

**PAGELATCH** differs from a **PAGEIOLATCH**. The latter is used to synchronize physical access to pages when they are read from or written to disk.

Page latches are common in every system because they ensure physical page protection. A clustered index orders the data by the leading key column. For this reason, when you create the index on a sequential column, this causes all new data inserts to occur on the same page at the end of the index until that page is filled. However, under high load, the concurrent INSERT operations may cause contention on the last page of the B-tree. This contention can occur on clustered and nonclustered indexes. This is because the nonclustered index orders the leaf-level pages by the leading key. This issue is also known as last-page insert contention.

For more information, see [Diagnosing and Resolving Latch Contention on SQL Server](/sql/relational-databases/diagnose-resolve-latch-contention).

## Resolution

To resolve this contention, the overall strategy is to prevent all concurrent INSERT operations from accessing the same database page. Instead, make each INSERT operation access a different page and increase concurrency. Therefore, any of the following methods that organize the data by a column other than the sequential column achieves this goal.

In SQL Server 2019, a new index option (OPTIMIZE_FOR_SEQUENTIAL_KEY) was added that can help resolve this issue without using any of the following methods. See [Behind the Scenes on OPTIMIZE_FOR_SEQUENTIAL_KEY](https://techcommunity.microsoft.com/t5/SQL-Server/Behind-the-Scenes-on-OPTIMIZE-FOR-SEQUENTIAL-KEY/ba-p/806888) for more information.

### Method 1

Make the column that contains sequential values a nonclustered index, and then move the clustered index to another column. For example, for a primary key on an identity column, remove the clustered primary key, and then re-create it as a nonclustered primary key. This is the easiest method to do, and it directly achieves the goal.

For example, assume that you have the following table that was defined by using a clustered primary key on an Identity column.

```sql
CREATE TABLE Customers 
( CustomerID bigint identity(1,1) not null Primary Key CLUSTERED, 
CustomerLastName varchar (32) not null, 
CustomerFirstName varchar(32) not null )
```

To change this, you can remove the primary key index and redefine it.

```sql
ALTER TABLE Customers 
DROP CONSTRAINT PK__Customer__A4AE64B98819CFF6 
ALTER TABLE Customers 
add constraint pk_Cust1 
primary key NONCLUSTERED (CustomerID)
```

### Method 2

Reorder the clustered index definition in such a way that the leading column isn't the sequential column. This requires that the clustered index be a composite index. For example, in a customer table, you can make a **CustomerLastName** column be the leading column, followed by the **CustomerID**. We recommend that you thoroughly test this method to make sure that it meets performance requirements.

```sql
ALTER TABLE Customers 
add constraint pk_Cust1 
primary key clustered (CustomerLastName, CustomerID)
```

### Method 3

Add a nonsequential hash value as the leading index key. This will also spread out the inserts. A hash value is generated as a modulo that matches the number of CPUs on the system. For example, on a 16-CPU system, you can use a modulo of 16. This method spreads out the INSERT operations uniformly against multiple database pages.

```sql
CREATE TABLE Customers 
( CustomerID bigint identity(1,1) not null, 
CustomerLastName varchar (32) not null, 
CustomerFirstName varchar(32) not null ) 
go 
ALTER TABLE Customers 
ADD [HashValue] AS (CONVERT([tinyint], abs([CustomerID])%16)) PERSISTED NOT NULL 
go 
ALTER TABLE Customers 
ADD CONSTRAINT pk_table1 
PRIMARY KEY CLUSTERED (HashValue, CustomerID)
```

### Method 4

Use a GUID as the leading key column of an index to ensure the uniform distribution of inserts.

> [!NOTE]
> Although it achieves the goal, we don't recommend this method because it presents multiple challenges, including a large index key, frequent page splits, low page density, and so on.

### Method 5

Use table partitioning and a computed column that has a hash value to spread out the INSERT operations. Because this method uses table partitioning, it's usable only on Enterprise editions of SQL Server.

> [!NOTE]
> You can use Partitioned tables in SQL Server 2016 SP1 Standard Edition. For more information, see the description of "Table and index partitioning" in the article [Editions and supported features of SQL Server 2016](/sql/sql-server/editions-and-components-of-sql-server-2016?view=sql-server-2017#RDBMSSP&preserve-view=true).

The following is an example in a system that has 16 CPUs.

```sql
CREATE TABLE Customers 
( CustomerID bigint identity(1,1) not null, 
CustomerLastName varchar (32) not null, 
CustomerFirstName varchar(32) not null ) 
go 
ALTER TABLE Customers 
ADD [HashID] AS CONVERT(tinyint, ABS(CustomerID % 16)) PERSISTED NOT NULL) 
go 
CREATE PARTITION FUNCTION pf_hash (tinyint) AS RANGE LEFT FOR VALUES (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15) 
GO 
CREATE PARTITION SCHEME ps_hash AS PARTITION pf_hash ALL TO ([PRIMARY]) 
GO 
ALTER TABLE Customers 
DROP CONSTRAINT PK__Customer__A4AE64B98819CFF6 
CREATE UNIQUE CLUSTERED INDEX CIX_Hash 
ON Customers (CustomerID, HashID) ON ps_hash(HashID) 
GO
```

### Method 6

Alternatively, use In-Memory OLTP particularly if the latch contention is high. This technology eliminates the latch contention overall. However, you have to redesign and migrate the specific table(s) where page latch contention is observed to a memory-optimized table. You can use the [Memory Optimization Advisor](/sql/relational-databases/in-memory-oltp/memory-optimization-advisor?view=sql-server-2017&preserve-view=true) and [Transaction Performance Analysis Report](/sql/relational-databases/in-memory-oltp/determining-if-a-table-or-stored-procedure-should-be-ported-to-in-memory-oltp?view=sql-server-2017&preserve-view=true) to determine whether migration is possible and the effort involved to do the migration. For more information about how In-Memory OLTP eliminates latch contention, download and review the document in [In-Memory OLTP - Common Workload Patterns and Migration Considerations](/previous-versions/dn673538(v=msdn.10)).

## References

[PAGELATCH_EX waits and heavy inserts](/archive/blogs/blogdoezequiel/pagelatch_ex-waits-and-heavy-inserts)
