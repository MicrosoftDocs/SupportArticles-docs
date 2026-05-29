---
title: Issues when upgrading to SQL Server 2022
description: Provides workarounds for common issues that can occur when you upgrade to SQL Server 2022, including access violation dumps, failed cluster instances, and replication errors.
ms.date: 05/20/2026
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: joriel, jopilov, prmadhes, v-sidong, v-shaywood
---
# Issues when upgrading to SQL Server 2022

_Applies to:_&nbsp; SQL Server 2022, SQL Server 2019, SQL Server 2017, SQL Server 2016

## Summary

This article describes common issues you can encounter when you upgrade to SQL Server 2022, and provides resolutions and workarounds for each. The scenarios covered include access violation dumps tied to lightweight query profiling, blocked upgrades caused by a partial SQL Server installation, failover cluster instances (FCI) that fail to come online after upgrade, and replication upgrade script errors when the distribution database is part of an Always On availability group (AG). Use this guide to troubleshoot a failed in-place upgrade to SQL Server 2022 and to get your SQL Server instance back online.

## Access violation dumps during upgrade in an Always On environment

This error occurs when you upgrade to SQL Server 2022 in an Always On environment. The error message and the associated log entries indicate a fatal exception generated during the upgrade process.

### Error message

> Exception Code: c0000005 EXCEPTION_ACCESS_VIOLATION

### Application event log

```output
Error: A user request from the session with SPID <SPID> generated a fatal exception. SQL Server is terminating this session.
Information: Windows Error Reporting - Fault bucket INVALID_REQUEST, type 0
```

### SQL Server error log

```output
Error: A user request from the session with SPID <SPID> generated a fatal exception. SQL Server is terminating this session. Contact Product Support Services with the dump produced in the log directory.
```

### Solution

This problem is a known issue with [LIGHTWEIGHT_QUERY_PROFILING](/sql/t-sql/statements/alter-database-scoped-configuration-transact-sql#lightweight_query_profiling---on--off-) in SQL Server 2022.

The problem is fixed in [Cumulative Update 4 for SQL Server 2022](../../../releases/sqlserver-2022/cumulativeupdate4.md) and [Cumulative Update 20 for SQL Server 2019](../../../releases/sqlserver-2019/cumulativeupdate20.md#2204764).

### Workaround

If you can't apply the cumulative update yet, turn off `LIGHTWEIGHT_QUERY_PROFILING`. [Lightweight profiling](/sql/relational-databases/performance/query-profiling-infrastructure) is turned off at the database level by using the `LIGHTWEIGHT_QUERY_PROFILING` database scoped configuration:

```sql
ALTER DATABASE SCOPED CONFIGURATION SET LIGHTWEIGHT_QUERY_PROFILING = OFF;
```

## Upgrade blocked by an inactive SQL Server 2022 instance

You can't upgrade to SQL Server 2022 because the computer has an inactive SQL Server 2022 instance.

### Cause

This problem occurs when a previous SQL Server installation fails and leaves a partially installed instance on the computer. The SQL Server setup program doesn't automatically roll back the installation when a failure occurs. The partially installed instance doesn't include the edition of SQL Server you were trying to install, which causes later installation attempts for the same version to fail.

### Solution

Follow the steps in [Remove a partial installation of SQL Server](../../../database-engine/install/windows/remove-partial-installation.md), and then restart the upgrade.

## Failover cluster instance fails to come online after upgrade

After you upgrade SQL Server from an earlier version to SQL Server 2022 on a [failover cluster instance](/sql/sql-server/failover-clusters/windows/always-on-failover-cluster-instances-sql-server) (FCI), the instance can fail to come online. In Failover Cluster Manager, the SQL Server role shows as failed and the instance doesn't start.

### Cause

The SQL Server instance is stuck in script upgrade mode, which prevents it from starting. During an upgrade, SQL Server runs upgrade scripts as part of the startup sequence. If one of those scripts fails or doesn't finish, the instance stays in script upgrade mode and can't come online.

### Workaround

To bring the SQL Server instance online, bypass the running upgrade script by following the steps in [Troubleshoot upgrade script failures when applying an update](../../../database-engine/install/windows/troubleshoot-upgrade-script-failures-apply-update.md).

> [!NOTE]
> The [-T902](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf902) trace flag turns off upgrade script execution during startup. Remove the trace flag after you fix the underlying upgrade script issue so that the pending upgrade steps can complete.

## Replication upgrade script error when the distribution database is in an availability group

A replication error occurs when you upgrade to SQL Server 2022 on a server that hosts the [distribution database](/sql/relational-databases/replication/distribution-database) in an availability group (AG).

> [!NOTE]
> This issue can also occur when you upgrade SQL Server from version 2016 SP2 CU3, SQL Server 2017 CU6, or later versions to SQL Server 2019. The fix for this issue is available in [Cumulative Update 21 for SQL Server 2019](../../../releases/sqlserver-2019/cumulativeupdate21.md).

### Error message

SQL Server setup completes but shows the error "There was an error executing the replication upgrade scripts" for the replication component. If you run a repair on an instance in this state, you get the same error message.

### SQL Server error log

```output
Executing sp_vupgrade_replication.
Could not open distribution database <distribution_db_name> because it is offline or being recovered. Replication settings and system objects could not be upgraded. Be sure this database is available and run sp_vupgrade_replication again.
Error executing sp_vupgrade_replication.
Saving upgrade script status to 'SOFTWARE\Microsoft\MSSQLServer\Replication\Setup'.
```

### Cause

The error occurs when the distribution database is part of an AG, and an in-place upgrade is attempted.

### Solution

The fix is available in [Cumulative Update 5 for SQL Server 2022](../../../releases/sqlserver-2022/cumulativeupdate5.md).

### Workaround

If you can't apply the cumulative update, use these steps:

1. Remove the distribution database from the AG.
1. Run the upgrade to SQL Server 2022.
1. After the upgrade finishes, add the distribution database back to the AG.

## Related content

- [Remove a partial installation of SQL Server](../../../database-engine/install/windows/remove-partial-installation.md)
- [Uninstall an existing instance of SQL Server (Setup)](/sql/sql-server/install/uninstall-an-existing-instance-of-sql-server-setup)
- [Supported version and edition upgrades (SQL Server 2022)](/sql/database-engine/install-windows/supported-version-and-edition-upgrades-2022)
- [Upgrade availability group replicas](/sql/database-engine/availability-groups/windows/upgrading-always-on-availability-group-replica-instances)
- [Troubleshoot upgrade script failures when applying an update](../../../database-engine/install/windows/troubleshoot-upgrade-script-failures-apply-update.md)
- [Troubleshoot common SQL Server cumulative update (CU) installation issues](../../../database-engine/install/windows/sqlserver-patching-issues.md#errors-912-and-3417-and-wait-on-database-engine-recovery-handle-failed)
