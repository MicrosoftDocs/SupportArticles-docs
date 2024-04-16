---
title: Issues when upgrading to SQL Server 2022
description: Provides workarounds for some of the most common issues when performing an upgrade to SQL Server 2022.
ms.date: 07/24/2023
ms.custom: sap:General Troubleshooting Information
ms.reviewer: joriel, jopilov, prmadhes, v-sidong
ms.author: prmadhes
author: prmadhes-msft
---
# Issues when upgrading to SQL Server 2022

_Applies to:_&nbsp; SQL Server 2022, SQL Server 2019, SQL Server 2017, SQL Server 2016

This article provides steps to troubleshoot and resolve the following common issues when performing an upgrade to SQL Server 2022.

## Issue 1: An error related to access violation dumps

An error related to access violation dumps occurs when you perform an upgrade to SQL Server 2022 in an Always On environment. The error message and associated log entries indicate a fatal exception generated during the upgrade process.

**Error message:**

> Exception Code: c0000005 EXCEPTION_ACCESS_VIOLATION

**Application event log:**

```output
Error: A user request from the session with SPID <SPID> generated a fatal exception. SQL Server is terminating this session.
Information: Windows Error Reporting - Fault bucket INVALID_REQUEST, type 0
```

**SQL Server error log:**

```output
Error: A user request from the session with SPID <SPID> generated a fatal exception. SQL Server is terminating this session. Contact Product Support Services with the dump produced in the log directory.
```

**Resolution:**

There's a known issue with [LIGHTWEIGHT_QUERY_PROFILING](/sql/t-sql/statements/alter-database-scoped-configuration-transact-sql#lightweight_query_profiling---on--off-) in SQL Server 2022.

This issue has been fixed in [Cumulative Update 4 for SQL Server 2022](../releases/sqlserver-2022/cumulativeupdate4.md#2306513) and [Cumulative Update 20 for SQL Server 2019](../releases/sqlserver-2019/cumulativeupdate20.md#2204764).

**Workaround:**

To work around this issue, disable `LIGHTWEIGHT_QUERY_PROFILING`. The [lightweight profiling](/sql/relational-databases/performance/query-profiling-infrastructure) can be disabled at the database level using the `LIGHTWEIGHT_QUERY_PROFILING` database scoped configuration: `ALTER DATABASE SCOPED CONFIGURATION SET LIGHTWEIGHT_QUERY_PROFILING = OFF;`.

## Issue 2: An error related to an inactive instance for SQL Server 2022

You're unable to upgrade to SQL Server 2022 due to an inactive instance for SQL Server 2022.

**Cause:**

This problem occurs when a previous installation of SQL Server fails, leaving behind a partially installed instance on the computer. The SQL Server setup program doesn't automatically roll back the installation if there's a failure. The partially installed instance doesn't include the edition of SQL Server you were trying to install, leading to subsequent installation failures when attempting to upgrade to the same version.

**Resolution:**

To resolve this issue, follow the steps mentioned in [Remove a partial installation of SQL Server](../database-engine/install/windows/remove-partial-installation.md).

## Issue 3: The failover cluster instance fails to come online

After upgrading SQL Server from an earlier version to 2022 on a [failover cluster instance](/sql/sql-server/failover-clusters/windows/always-on-failover-cluster-instances-sql-server) (FCI), you may encounter a situation where the instance fails to come online. When checking the FCI role on the cluster manager, you notice that the instance is unable to start.

**Possible cause:**

One possible cause of this issue is that the SQL Server instance might be in the script upgrade mode, which prevents it from starting. During the upgrade process, SQL Server goes through several steps to ensure a smooth transition, including executing upgrade scripts. If the instance is stuck in the script upgrade mode, it won't be able to come online.

**Workaround:**

To resolve the issue and bring the SQL Server instance online successfully, you can bypass the running upgrade script by following the steps in [Troubleshoot upgrade script failures when applying an update](../database-engine/install/windows/troubleshoot-upgrade-script-failures-apply-update.md).

> [!NOTE]
> The [-T902](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf902) parameter disables the upgrade script execution during startup.

## Issue 4: An error related to replication

An error related to replication occurs when you upgrade to SQL Server 2022 on machines that host the [distribution database](/sql/relational-databases/replication/distribution-database) in an availability group (AG).

> [!NOTE]
> This issue can also occur when you upgrade SQL Server from version 2016 SP2 CU3, SQL Server 2017 CU6, or later versions to SQL Server 2019. The fix for this issue is available in [Cumulative Update 21 for SQL Server 2019](../releases/sqlserver-2019/cumulativeupdate21.md).

**Error message:**

SQL setup completes but shows the error "There was an error executing the replication upgrade scripts" for the replication component. If you try to run a repair on an instance in this state, you'll receive the same error message.

**SQL Server error log:**

```output
Executing sp_vupgrade_replication.
Could not open distribution database <distribution_db_name> because it is offline or being recovered. Replication settings and system objects could not be upgraded. Be sure this database is available and run sp_vupgrade_replication again.
Error executing sp_vupgrade_replication.
Saving upgrade script status to 'SOFTWARE\Microsoft\MSSQLServer\Replication\Setup'.
```

**Cause:**

The error occurs when the distribution database is part of an AG, and an in-place upgrade is attempted.

**Resolution:**

The fix for this issue is available in [Cumulative Update 5 for SQL Server 2022](../releases/sqlserver-2022/cumulativeupdate5.md).

**Workaround:**

To work around this issue, follow these steps:

1. Remove the distribution database from the AG.
1. Proceed with the upgrade to SQL Server 2022.
1. After completing the upgrade, add the distribution database back to the AG.

## More information

- [Remove a partial installation of SQL server](../database-engine/install/windows/remove-partial-installation.md)
- [Uninstall an existing instance of SQL Server (Setup)](/sql/sql-server/install/uninstall-an-existing-instance-of-sql-server-setup)
- [Supported version and edition upgrades (SQL Server 2022)](/sql/database-engine/install-windows/supported-version-and-edition-upgrades-2022)
- [Upgrade availability group replicas](/sql/database-engine/availability-groups/windows/upgrading-always-on-availability-group-replica-instances)
- [Troubleshoot upgrade script failures when applying an update](../database-engine/install/windows/troubleshoot-upgrade-script-failures-apply-update.md)
- [Troubleshoot common SQL Server cumulative update (CU) installation issues](../database-engine/install/windows/sqlserver-patching-issues.md#errors-912-and-3417-and-wait-on-database-engine-recovery-handle-failed)
