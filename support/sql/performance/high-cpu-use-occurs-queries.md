---
title: High CPU usage occurs in your queries that use Batch Sort
description: This article provides a resolution for the problem where high CPU usage occurs when you run queries in SQL Server.
ms.date: 12/16/2021
ms.prod-support-area-path: Performance
ms.prod: sql 
---
# High CPU usage occurs when you run queries that use optimized nested loops 

This article helps you resolve the problem where high CPU usage occurs when you run queries in SQL Server.

_Applies to:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2009160

## Symptoms

When you operate a Microsoft SQL Server that has a highly-concurrent workload, you may notice some performance issues in which queries. This behavior may exhibit as medium to high CPU usage or extreme memory-grant requests.

You may also experience other side effects, such as OOM conditions, memory pressure for plan cache eviction, or unexpected `RESOURCE_SEMAPHORE` waits.

Additionally, you may notice that query plans for queries that consume lots of CPU or memories have the **OPTIMIZED** attribute for a Nested Loops join operator set to **True**.

## Cause

This issue may occur in some cases where SQL Server query processor introduces an optional sort operation to improve performance. This operation is known as an Optimized Nested Loops or Batch Sort and the query optimizer determines when to best introduce it. In rare cases when the query touches only a small number of rows, but the setup cost for the sort operation may be significant, then the cost of the optimized nested loop may outweigh its benefits. Therefore, in those cases you may observe slower performance compared to what is expected.

## Resolution

To fix the issue, use trace flag 2340 to disable the optimization. Alternatively, to disable the optimization at the query level, apply the following query hint:

```sql
USE HINT (DISABLE_OPTIMIZED_NESTED_LOOP)
```

Before you use this trace flag, you can test your applications thoroughly to make sure that you get the expected performance benefits when you disable this optimization. This is because the sort optimization can be helpful when there is a large increase in the number of rows that are touched by the plan. See [DISABLE_OPTIMIZED_NESTED_LOOP](/sql/t-sql/queries/hints-transact-sql-query#:~:text=Azure%20SQL%20Database-,%27DISABLE_OPTIMIZED_NESTED_LOOP%27,-Instructs%20the%20query)

## More information

[Database Engine Service Startup Options](/sql/database-engine/configure-windows/database-engine-service-startup-options)

## Applies to
- SQL Server 2005 through SQL Server 2019
