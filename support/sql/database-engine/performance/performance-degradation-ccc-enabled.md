---
title: Performance degradation when migrating SQL Server
description: Works around an issue where you migrate from SQL Server 2016 on Windows Server 2016 to SQL Server 2022 on Windows Server 2022 with common criteria compliance enabled.
ms.date: 01/24/2024
ms.custom: sap:Performance
ms.reviewer: prmadhes, v-sidong
---
# Performance degradation when migrating SQL Server

When migrating from SQL Server 2016 on Windows Server 2016 to SQL Server 2022 on Windows Server 2022, you notice a degradation in SQL Server performance.

## Cause

If all configurations match and look good, one possible reason for this issue is a common criteria compliance audit.

## Common criteria compliance

After enabling the common criteria compliance option, you might experience lock waiting and common criteria compliance audit overhead when multiple concurrent authentications use the same login.

After enabling this option, you might experience slow degradation in performance. In addition, you might see high `LCK_M_SCH_M` waits in performance statistics. `LCK_M_SCH_M` is a schema modification lock that prevents access to a table while a Data Definition Language (DDL) operation occurs. You'll also find blocked process records where a `LOGIN_STATS` table in the master database is waiting for a long time. This table is used to hold login statistics. When there are many logins and logouts, there can be contention in this table.

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

When you enable common criteria compliance, Residual Information Protection (RIP) is enabled. RIP is an additional security measure for memory. requires a memory allocation to be overwritten with a known pattern of bits before memory is reallocated to a new resource. So, with lots of logins and logouts, there's a performance degradation in memory because overwriting the memory allocation has to be done.

Keep in mind if you enable common criteria compliance, you can run into slowdowns from locking and memory. Make sure that your server can handle this well and that applications are designed to minimize the impact of high logins and logouts.

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
