---
title: Performance degradation with common criteria compliance enabled
description: Works around an issue where a performance degradation occurs when common criteria compliance is enabled in SQL Server.
ms.date: 01/24/2024
ms.custom: sap:Performance
ms.reviewer: prmadhes, v-sidong
---
# Performance degradation in SQL Server with common criteria compliance enabled

## Symptoms

When you have the common criteria compliance configuration option enabled on SQL Server, you might notice a degradation in SQL Server performance.

## Common criteria compliance

After enabling the common criteria compliance option in SQL Server, you might experience lock waiting and common criteria compliance audit overhead when multiple concurrent authentications use the same login.

After enabling this option, you might experience slow degradation in performance. In addition, you might see high `LCK_M_SCH_M` waits in performance statistics. `LCK_M_SCH_M` is a schema modification lock that prevents access to a table while a Data Definition Language (DDL) operation occurs. You'll also find blocked process records where a `LOGIN_STATS` table in the master database is waiting for a long time. This table is used to hold login statistics. When there are many logins and logouts, there can be contention in this table.

To understand why a `LCK_M_SCH_M` wait event occurs, run the following commands:

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

When you enable common criteria compliance, Residual Information Protection (RIP) is enabled. RIP is an additional security measure for memory. It requires a memory allocation to be overwritten with a known pattern of bits before memory is reallocated to a new resource. So, with lots of logins and logouts, there's a performance degradation in memory because overwriting the memory allocation has to be done.

## Workaround

If common criteria compliance isn't a strict requirement, consider disabling it to reduce the auditing overhead and improve performance. To disable the option, run the following commands:

```sql
sp_configure 'common criteria compliance enabled', 0
GO
RECONFIGURE
GO
```

## More information

[Common Criteria Compliance Enabled Server Configuration](/sql/database-engine/configure-windows/common-criteria-compliance-enabled-server-configuration-option)
