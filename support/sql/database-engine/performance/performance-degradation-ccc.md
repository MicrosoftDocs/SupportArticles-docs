---
title: Performance degradation when migrating SQL Server
description: This article provides workaround for the issue where you migrate from SQL Server 2016 on Windows Server 2016 to SQL Server 2022 on Windows Server 2022 with common criteria compliance enabled.
ms.date: 01/24/2024
ms.custom: sap:Performance
ms.reviewer: prmadhes, v-sidong
---
# Customer Scenario of Performance

When migrating from SQL Server 2016 on Windows Server 2016 to SQL Server 2022 on Windows Server 2022, you notice a degradation in SQL Server performance.

## Cause

If all configuration matches and looks well, one possible reason of this issue could be common criteria compliance audit.

## Common criteria compliance

After enabling the common criteria compliance option, you might notice lock waiting and common criteria compliance audit overhead when multiple concurrent authentications use the same login.

After enabling this option, a slow degrading might start. In performance statistics, you might see that there are high `LCK_M_SCH_M` waits which is a schema modification lock that prevents access to a table while a Data Definition Language (DDL) operation occurs. You'll also find blocked process records where a `LOGIN_STATS` table in the master database is waiting a lot. This table is used to hold login statistics. When there are many logins and outs, there can be contention in this table.

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

When you enable common criteria compliance, something called Residual Information Protection (RIP) is enabled. RIP is an additional security measure for memory and it makes it so that in memory a specific bit pattern must be present before memory can be reallocated(overwritten) to a new resource or login. So with lots of logins and outs, there's a performance hit in memory because overwriting the memory allocation has to be done.

Keep in mind if you enable common criteria compliance, you can run into slowdowns from locking and memory. Make sure that your server is able to handle this well and that applications are designed to minimize the impact of high logins and logouts.

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