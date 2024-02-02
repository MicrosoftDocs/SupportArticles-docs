---
title: Transaction log file grows for databases with In-Memory OLTP in SQL Server 2022
description: Troubleshoots the issue where transaction log file grows continuously for databases with In-Memory OLTP enabled in SQL Server 2022.
ms.date: 06/29/2023
ms.custom: sap:Database Design and Development
ms.reviewer: jopilov, sureshka, v-sidong
author: prmadhes-msft
ms.author: prmadhes
---
# Transaction log file grows for databases with In-Memory OLTP in SQL Server 2022

## Symptoms

When your databases have the [In-Memory OLTP](/sql/relational-databases/in-memory-oltp/overview-and-usage-scenarios) feature enabled in [SQL Server 2022](/sql/sql-server/what-s-new-in-sql-server-2022), you notice the transaction log file grows continuously. In addition, the SQL Server error log might have messages like `Close thread is falling behind: 4 checkpoints outstanding`.

If you restart the SQL Server instance, you might notice the database takes a long time to complete the database recovery process.

## Troubleshoot the issue with sys.databases and sys.dm_db_xtp_checkpoint_stats

- When you use the catalog view [sys.databases](/sql/relational-databases/system-catalog-views/sys-databases-transact-sql) to gather information and troubleshoot this issue, the column `log_reuse_wait_desc` shows `XTP_CHECKPOINT` as the reason for long truncation. This value indicates that the transaction log is waiting for an In-Memory OLTP (formerly known as Hekaton) checkpoint to occur. It suggests a delay in checkpointing operations, potentially impacting performance or log file growth.

- When you use the SQL Server dynamic management view (DMV) [sys.dm_db_xtp_checkpoint_stats](/sql/relational-databases/system-dynamic-management-views/sys-dm-db-xtp-checkpoint-stats-transact-sql) to gather information and troubleshoot this issue, the column `outstanding_checkpoint_count` shows a nonzero value for an extended period of time. It indicates that checkpoints aren't occurring efficiently, potentially affecting performance and log file growth.

## Cause

SQL Server 2022 introduced new capabilities that improve memory management in large memory servers to reduce out-of-memory conditions. A known issue in this change can sometimes lead to the behavior described in the **Symptoms** section.

## Resolution

To solve the issue, follow these steps:

1. Add *-T9810* as the startup parameter for the SQL Server instance.
1. Restart the instance.
1. Issue a checkpoint, take a log backup, observe `log_reuse_wait_desc`, and shrink the log if needed to reclaim space.

## More information

The [trace flag 9810](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf9810) disables the In-Memory OLTP engine from reclaiming Thread Local Storage (TLS) memory, reverting to the behavior of SQL Server 2019.
