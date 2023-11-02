---
title: Error 701 there is insufficient memory to run this query
description: Provides resolutions for the error 701 that occurs when executing a large batch of operations in SQL Server.
ms.date: 08/07/2023
ms.custom: sap:Performance
ms.reviewer: ramakoni, v-sidong
---
# SQL Server reports 701 "There is insufficient memory to run this query" when executing large batches

The article discusses the 701 error that can occur when you execute a large batch of operations in SQL Server. For other causes of 701 error, see [MSSQLSERVER_701](/sql/relational-databases/errors-events/mssqlserver-701-database-engine-error).

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2001221

## Symptoms

In SQL Server, when you execute a large batch of remote procedure calls (RPC) (for example, tens of thousands of inserts in a single [batch](/previous-versions/sql/sql-server-2008-r2/ms175502(v=sql.105))), the operation might fail with the following errors reported in SQL Server error log:

```Output
2020-07-04 13:30:45.78 spid56 Error: 701, Severity: 17, State: 193. 
2020-07-04 13:30:45.78 spid56 There is insufficient system memory to run this query.
```

If you check the output of [DBCC MEMORYSTATUS](dbcc-memorystatus-monitor-memory-usage.md) that's automatically logged to the error log on 701 error messages, you'll find entries like the following ones:

```Output
2020-07-04 13:30:45.74 spid56       Failed allocate pages: FAIL_PAGE_ALLOCATION 1 
2020-07-04 13:30:45.76 spid58      
Memory Manager 
VM Reserved = 1657936 KB 
VM Committed = 66072 KB 
AWE Allocated = 2351104 KB              ==>  ~2.2 GB 
Reserved Memory = 1024 KB 
Reserved Memory In Use = 0 KB 

2020-07-04 13:30:45.76 spid56       
USERSTORE_SXC (Total) 

VM Reserved = 0 KB 
VM Committed = 0 KB 
AWE Allocated = 0 KB 
SM Reserved = 0 KB 
SM Committed = 0 KB 
SinglePage Allocator = 1127848 KB       ==>   ~1.07 GB 
MultiPage Allocator = 0 KB 

2020-07-04 13:30:45.78 spid56      Error: 701, Severity: 17, State: 193. 
2020-07-04 13:30:45.78 spid56      There is insufficient system memory to run this query. 
```

> [!NOTE]
> Note the large allocations for the cache `USERSTORE_SXC`.

Additionally, if you query the [sys.dm_os_memory_clerks](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-memory-clerks-transact-sql) dynamic management view (DMV) while the batch is getting executed, the `single_pages_kb` column for the `USERSTORE_SXC` cache shows a continuous growth over a period that generates the 701 error.

For an example of an application that could potentially exhibit this behavior, see [More information](#more-information).

## Cause

The amount of memory allocated to store a request in SQL Server depends on:

- The batch size (number of RPCs per request).
- The number of parameters.
- The type of parameters.

For certain types of parameters (for example, [sql_variant](/sql/t-sql/data-types/sql-variant-transact-sql)), SQL Server can save the requests in memory in a potentially inefficient manner. When a client sends a large batch of requests that use these types of parameters, multiple RPCs can be sent in one request. In this scenario, the server accumulates the whole request in memory before it's executed. This could potentially lead to the 701 error discussed in [Symptoms](#symptoms).

The issue is far more prevalent in older versions of SQL Server (especially when using `sql_variant` data type). SQL Server 2008 and later versions have some design enhancements that reduce the amount of memory used in certain cases and are more efficient overall.

## Resolution

To solve the error, use one of the following methods:

- Reduce batch sizes.
- Change parameter types. For example, replace `sql_variant` with other types.

The `USERSTORE_SXC` cache is used for connection management level allocations, such as RPC parameters and the memory that is associated with prepared handles. When a client sends a request containing a large batch of RPC calls, each potentially using a large number of certain types of parameters like `sql_variant`, it could result in excessive allocations from this cache, thereby exhausting all the available memory.

The application should also be monitored to make sure that you're closing prepared handles in a timely manner. When you don't close these handles, it will prevent SQL Server from releasing memory for the associated objects on the server side.

## More information

To reproduce the problem discussed in this article, create an application by using the following code and notice that the `USERSTORE_SXC` cache grows and shrinks as the program is executed.

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace RPCBatching
{
    class Program
    {
        static void Main(string[] args)
        {
            DataTable t = new DataTable();
            t.Columns.Add("a", typeof(int));

            for(int i=0;i<100000;i++)
                t.Rows.Add(1);

            // pre-create the table with "CREATE TABLE t (a sql_Variant)" in a database named as test
            using (SqlConnection conn = new SqlConnection("server=tcp:localhost; integrated security=true; database=test"))
            {
               conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(null, conn);
                da.InsertCommand = new SqlCommand("INSERT INTO t VALUES (@a)", conn);
                da.InsertCommand.Parameters.Add("@a", SqlDbType.Variant, 0, "a");
                da.InsertCommand.UpdatedRowSource = UpdateRowSource.None;
                da.UpdateBatchSize = 100000;
                da.InsertCommand.CommandTimeout = 12000;
                da.Update(t);
            }
        }
    }
}
```
