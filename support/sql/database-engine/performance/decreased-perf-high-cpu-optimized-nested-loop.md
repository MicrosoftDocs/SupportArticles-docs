---
title: High CPU or memory grants when using optimized nested loop or batch sort
description: Provides a resolution for high CPU and memory usage when you run queries with optimized nested loop or batch sort operators.
ms.date: 12/23/2021
ms.custom: sap:Performance
---
# High CPU or memory grants may occur with queries that use optimized nested loop or batch sort

This article helps you resolve the problem where high CPU usage occurs when you run queries in SQL Server.

_Applies to:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2009160

## Symptoms

When you operate Microsoft SQL Server that has a highly concurrent workload, you may notice some performance issues in queries. This behavior may exhibit as medium to high CPU usage or extreme memory grant requests.

You may also experience other side effects, such as OOM conditions, memory pressure for plan cache eviction, or unexpected `RESOURCE_SEMAPHORE` waits.

Additionally, you may notice that query plans for queries that consume lots of CPU or memories have the **OPTIMIZED** attribute for a Nested Loops join operator set to **True**.

## Cause

This issue may occur in some cases where SQL Server query processor introduces an optional sort operation to improve performance. This operation is known as an "Optimized Nested Loop" or "Batch Sort" and the query optimizer determines when to best introduce these operators. In rare cases, the query touches only a few rows, but the setup cost for the sort operation is so significant that the cost of the optimized nested loop outweighs its benefits. Therefore, in those cases you may observe slower performance compared to what is expected.

## Resolution

### Trace flag 2340

To fix the issue, use trace flag 2340 to disable the optimization. Trace flag 2340 instructs the query processor not to use a sort operation (batch sort) for optimized nested loop joins when generating a query plan. This affects the entire instance. 

Before you enable this trace flag, you can test your applications thoroughly to make sure that you get the expected performance benefits when you disable this optimization. This is because the sort optimization can be helpful when there is a large increase in the number of rows that are touched by the plan. 

For more information, see [DBCC TRACEON - Trace Flags (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#:~:text=2340,a%20sort%20operation).

### Modify code to use the DISABLE_OPTIMIZED_NESTED_LOOP hint

Alternatively, apply the following `DISABLE_OPTIMIZED_NESTED_LOOP` query hint to disable the optimization at the query level.

```sql
SELECT * FROM Person.Address  
WHERE City = 'SEATTLE' AND PostalCode = 98104
OPTION (USE HINT (DISABLE_OPTIMIZED_NESTED_LOOP)); 
```

For more information, see [DISABLE_OPTIMIZED_NESTED_LOOP](/sql/t-sql/queries/hints-transact-sql-query#:~:text=Azure%20SQL%20Database-,'DISABLE_OPTIMIZED_NESTED_LOOP',Instructs,-the%20query%20processor).

## More information

[Database Engine Service Startup Options](/sql/database-engine/configure-windows/database-engine-service-startup-options)

## Applies to

- SQL Server 2005 through SQL Server 2019
