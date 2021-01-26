---
title: High CPU use occurs in your queries
description: This article provides a resolution for the problem where high CPU use occurs when you run queries in SQL Server.
ms.date: 01/14/2021
ms.prod-support-area-path: Performance
ms.prod: sql 
---
# High CPU use occurs when you run queries in SQL Server

This article helps you resolve the problem where high CPU use occurs when you run queries in SQL Server.

_Applies to:_ &nbsp; SQL Serve  
_Original KB number:_ &nbsp; 2009160

## Symptoms

When you operate a server that is running Microsoft SQL Server and that has a highly concurrent workload, you notice some performance issues in which queries contribute significantly to high CPU use or extreme memory grant requests.

You may also experience other side effects, such as OOM conditions, memory pressure for plan cache eviction, or unexpected `RESOURCE_SEMAPHORE` waits.

Additionally, you may notice that query plans for queries that consume lots of CPU or memories have the **OPTIMIZED** attribute for a Nested Loops join operator set to **True**.

## Cause

This issue occurs in some cases because SQL Server query processor introduces a sort operation for optimization, although it is not required. This operation is known as an Optimized Nested Loops or Batch Sort.

In these cases, the plan touches only a smaller number of rows, and the setup cost for the sort operation may outweigh its benefits. Therefore, it causes poor performance.

## Resolution

To fix the issue, use trace flag 2340 to disable the optimization. Alternatively, to disable the optimization at the query level, apply the following query hint:

```sql
USE HINT (DISABLE_OPTIMIZED_NESTED_LOOP)
```

Before you use this trace flag, you can test your applications thoroughly to make sure that you get the expected performance benefits when you disable this optimization. This is because the sort optimization can be helpful when there is a large increase in the number of rows that are touched by the plan.

## More information

[Database Engine Service Startup Options](/sql/database-engine/configure-windows/database-engine-service-startup-options)

## Applies to

- SQL Server 2019
- SQL Server 2017 on Windows (all editions)
- SQL Server 2017 on Linux (all editions)
- SQL Server 2016
- SQL Server 2014
- SQL Server 2012
- SQL Server 2010
- SQL Server 2008
- SQL Server 2008 Workgroup
- SQL Server 2008 Web
- SQL Server 2008 Express with Advanced Services
- SQL Server 2008 Express
- SQL Server 2008 Enterprise
- SQL Server 2008 Developer- SQL Server 2005
- SQL Server 2005 Standard Edition
- SQL Server 2005 Express Edition with Advanced Services
- SQL Server 2005 Express Edition
- SQL Server 2005 Evaluation Edition
- SQL Server 2005 Enterprise X64 Edition
- SQL Server 2005 Enterprise Edition
- SQL Server 2005 Developer Edition
