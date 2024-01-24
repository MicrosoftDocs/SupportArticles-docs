---
title: Customer scenario of performance
description: This article provides workaround for the problem where you migrate from SQL Server 2016 on Windows Server 2016 to SQL Server 2022 on Windows Server 2022.
ms.date: 09/25/2020
ms.custom: sap:Performance
ms.reviewer: 
---
# Customer Scenario of Performance

SQL Server Performance Degradation in load testing of migration from SQL Server 2016 on Windows Server 2016 to SQL Server 2022 on Windows Server 2022.

## Cause

In case all configuration is matching and looking well than one possible reason could be Common Criteria Compliance (CCC) audit.

## Common criteria compliance

After enabling this you may notice lock waiting and CCC audit overhead when multiple concurrent authentications leverage the same login.
After enabling this slowly degrading may start. In performance statistics, you may found that there were high LCK_M_SCH_M waits which is a schema modification lock that prevents access to a table while a DDL operation occurs. you will also found blocked process records where a LOGIN_STATS table in the master database was waiting a lot. This table is used to hold login statistics. When there are a lot of logins and outs there can be contention in this table.

```sql
CREATE EVENT SESSION [CreateDumpOnLCKMSCHM] ON SERVER
ADD EVENT sqlos.wait_info(
    ACTION(package0.callstack,sqlserver.create_dump_all_threads)
    WHERE (([opcode]=('Begin')) AND ([wait_type]=('LCK_M_SCH_M'))))
ADD TARGET package0.event_file(SET filename=N'CreateDumpOnLCKMSCHM',max_file_size=(128))
GO

ALTER EVENT SESSION [TestCreateDump] ON SERVER
STATE = START
GO

WHILE ((SELECT COUNT(1) FROM sys.dm_server_memory_dumps) < 5)
BEGIN
       WAITFOR DELAY '00:00:00.100'

END

ALTER EVENT SESSION [CreateDumpOnLCKMSCHM] ON SERVER
STATE = STOP
```

When you enable Common Criteria compliance, something called Residual Information Protection (RIP) is enabled. RIP is an additional security measure for memory and it makes it so that in memory a specific bit pattern must be present before memory can be reallocated(overwritten) to a new resource or login. So with lots of logins and outs, there is a performance hit in memory because overwriting the memory allocation has to be done.
Keep in mind if you enable Common Criteria compliance, you can run into slowdowns from locking and memory. Make sure that your server is able to handle this well and that applications are designed to minimize the impact of high logins\logouts.

## Workaround

If CCC is not a strict requirement, consider disabling it to reduce the auditing overhead and improve performance.

```sql
sp_configure 'common criteria compliance enabled', 0
GO
RECONFIGURE
GO
```
