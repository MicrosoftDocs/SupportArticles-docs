---
title: An assertion failure occurs on a SQL Server mirror server  
description: This article provides a workaround for the assertion failure that can occur on a partner server when using SQL Server mirroring architecture.
ms.date: 11/14/2022
ms.custom: sap:Administration and Management
ms.reviewer: ramakoni1, v-jayaramanp
---

# Assertion failure on a mirror server when using SQL Server mirroring architecture

This article discusses a Microsoft SQL Server assertion failure that can occur on a partner server when using SQL Server mirroring architecture.

_Original product version:_ &nbsp; SQL Server 2014, SQL Server 2012, SQL Server 2008 R2, SQL Server 2008  
_Original KB number:_ &nbsp; 2729953

## Symptoms

In SQL Server mirroring architecture, you might encounter a SQL Server assertion check failure on the partner (mirror) server. In such a case, check the SQL Server error log for details. In the log, you will find an error message that resembles the following message. This error usually means that you must rebuild the mirror pair.

> SQL Server Assertion: File: loglock.cpp, line=834 Failed Assertion = 'result == LCK_OK' . This error may be timing related. If the error persists after re-running the statement, use DBCC CHECKDB to check the database for structural integrity, or restart the server to ensure in-memory data structures are not corrupted.
>
> Error: 3624, Severity: 20, State: 1.

Typically, an assertion failure is caused by a software bug or data corruption. To check for database corruption, consider running `DBCC CHECKDB`. If you agree to send dumps to Microsoft during setup, a minidump will be sent to Microsoft. An update might be available from Microsoft in the latest Service Pack or in a QFE from Technical Support.

> [!NOTE]
> When this issue occurs, a minidump file is generated in the SQL Server error log folder. This file has a name that resembles the *SQLDumpnnnn.mdmp* file name.

## Cause

This issue may occur in different scenarios. Each scenario has a different cause and resolution, and each scenario may cause the same error message and assertion failure.

> [!NOTE]
>
> - Although the error signature seems to be very specific, the actual error is caused by an assertion that failed. For example, the error could be caused by an assertion that performs a proactive check in the SQL Server code that validates *healthy* conditions to fail as cleanly as possible instead of causing a process-wide crash.
> - You can't easily determine the actual cause. Microsoft Customer Support Services usually determines the cause. It is usually done by collecting the principal database full backup file and the transaction log backups that cover the time of the issue. Additionally, a full process dump file of the mirror may be required to reproduce the problem in specific settings.

## Resolution

To resolve this issue, obtain the latest fix for your version of SQL Server. For more information, refer to the following table.

|Cause  |Knowledge Base article  |First fixed in  |
|---------|---------|---------|
|Different lock behavior between the primary and mirror     |  [2938828](https://support.microsoft.com/topic/kb2938828-fix-database-mirroring-hits-assert-and-mirroring-session-shows-suspended-state-in-sql-server-2012-or-sql-server-2014-dbadfab5-6679-6cb1-850b-40e9447fc4a3) FIX: Database mirroring hits assert, and mirroring session shows suspended state in SQL Server 2012 or SQL Server 2014       |   [2931693](https://support.microsoft.com/topic/kb2931693-cumulative-update-1-for-sql-server-2014-35643fd4-5930-2a14-9afd-5076b35abcf4) Cumulative Update 1 for SQL Server 2014, [2931078](https://support.microsoft.com/topic/kb2931078-cumulative-update-package-9-for-sql-server-2012-service-pack-1-b46a592f-77c0-5b1e-292a-333f787adf9c) Cumulative Update 9 for SQL Server 2012 SP1      |
|Bulk Insert / BCP with Check_Constraints OFF     |         |   SQL Server 2012      |
|Change of the encryption keys: Database master key, Server instance master key   |         |   SQL Server 2012      |

> [!NOTE]
> - In the preceding table, the last column lists only the first build that contains the fix. Because SQL Server builds are cumulative, later builds, such as SQL Server 2014 SP1 contains those fixes. However, those builds aren't listed in the table.
> - For more information about how to obtain the latest service pack for your version of SQL Server, see [Determine the version, edition, and update level](../../releases/download-and-install-latest-updates.md).
The BCP/Bulk Insert scenario is a common scenario that remains unfixed for SQL Server 2008 and SQL Server 2008 R2, and it's the most probable known cause of *lck_ok* assertions on those versions. The issue was first fixed in SQL Server 2012. The reason for not fixing this in the earlier versions is that it requires a re-architecture of SQL Server transaction log internals. Such a change can be included only with a major release of SQL Server.

## See also

[Assertion when you execute Bulk Insert or BCP](assertion-execute-bulk-insert-bcp.md)

