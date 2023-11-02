---
title: SchemaMgr Store entries degrade performance 
description: Provides a resolution for the problem where you may experience a performance degradation issue in SQL Server.
ms.date: 09/10/2020
ms.custom: sap:Performance
---
# Many CMEMTHREAD waits when many SchemaMgr Store entries exist in SQL Server

This article helps you resolve the problem where you may experience a performance degradation issue in SQL Server.

_Original product version:_ &nbsp; Microsoft SQL Server 2017 on Windows, SQL Server 2014, SQL Server 2016, SQL Server 2012  
_Original KB number:_ &nbsp; 4488254

## Symptoms

You may experience performance degradation in SQL Server. When this issue occurs, you observe the following situation:

- There are millions of SchemaMgr Store entries in the memory cache. You can see the information by running the following T-SQL script:

    ```sql
    SELECT entries_count
    FROM sys.dm_os_memory_cache_counters
    where name = 'SchemaMgr Store'
    ```

- This issue can be accompanied by an increase in `CMEMTHREAD` waits and lock blocking, in which the locks `wait_resource` refers to a `COMPILE` lock type. You can see the information by running the following T-SQL script:

    ```sql
    select * from sys.dm_exec_requests where wait_type = 'CMEMTHREAD'
    select * from sys.dm_exec_requests where wait_resource like '%compile%'
    ```

## Cause

This issue occurs when the number of cached HOBT statistics hits an internal soft limit. When the limit is reached, the system tries to aggressively remove entries, which cause contention on the memory object that's storing the data.

## Resolution

To fix this issue, enable Trace Flag (TF) 8032.
