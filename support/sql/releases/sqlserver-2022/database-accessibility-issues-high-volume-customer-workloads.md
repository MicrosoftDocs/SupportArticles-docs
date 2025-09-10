---
title: Database accessibility issues with high-volume customer workloads
description: Fixes an issue where high-volume customer workloads using Extensible Key Management (EKM) for encryption and key generation experience database accessibility issues.
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5023236
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2019 on Windows
ms.reviewer: mireks, vanto, rajat.jain, chrisbrower, arupp, v-cuichen
---
# FIX: Database accessibility issues with high-volume customer workloads that use EKM for encryption and key generation

## Symptoms

High-volume customer workloads that use [Extensible Key Management (EKM)](/sql/relational-databases/security/encryption/extensible-key-management-ekm) may experience intermittent database accessibility issues. These accessibility issues are caused by the frequent creation or rotation of the virtual log file (VLF) that requires access to Azure Key Vault (AKV). If AKV or supporting services such as Microsoft Entra ID aren't accessible during this creation or rotation, you can't perform the creation or rotation of the VLF. Additionally, it causes database accessibility issues.

VLFs can be created or rotated frequently when the transaction log files are small, or the automatic growth (autogrow) increment of the transaction log is small, instead of large enough to stay ahead of the needs of the workload transactions. For more information, see [Manage the size of the transaction log file](/sql/relational-databases/logs/manage-the-size-of-the-transaction-log-file).

You can monitor the size and the creation frequency of VLFs by using [sys.dm_db_log_info](/sql/relational-databases/system-dynamic-management-views/sys-dm-db-log-info-transact-sql).

## Resolution

This problem is fixed in the following cumulative updates for SQL Server:

- [Cumulative Update 1 for SQL Server 2022](cumulativeupdate1.md)
- [Cumulative Update 19 for SQL Server 2019](../sqlserver-2019/cumulativeupdate19.md)

This fix introduces a startup trace flag (TF) 15025. You can use TF 15025 to disable the AKV access that's required for a newly created VLF, which allows high-volume customer workloads to continue without interruption. Once this trace flag is enabled, SQL Server that uses EKM for encryption and key generation doesn't contact AKV during the creation or rotation of the VLF.

To check if the key in AKV is still in use or needs to be disabled, you must perform one of the following operations on the database:

- Take a backup (any type of backup) of the database or transaction log.
- Run `DBCC CHECKDB` against the encrypted database.
- Set the encrypted database to the `OFFLINE` state and then to the `ONLINE` state.
- Create a database snapshot of the encrypted database.

In any of the listed operations, SQL Server will contact AKV and check the key access during this operation if the key exists in AKV.

Even if you enable TF 15025, these operations will still reach AKV.

You can run the following Transact-SQL (T-SQL) statement to check the status of the key in a database:

```SQL
SELECT * FROM sys.dm_database_encryption_keys
```

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

- [Latest cumulative update for SQL Server 2022](build-versions.md)
- [Latest cumulative update for SQL Server 2019](../sqlserver-2019/build-versions.md)

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

- [Extensible Key Management (EKM)](/sql/relational-databases/security/encryption/extensible-key-management-ekm)
- [Manage the size of the transaction log file](/sql/relational-databases/logs/manage-the-size-of-the-transaction-log-file)
- [sys.dm_db_log_info (Transact-SQL)](/sql/relational-databases/system-dynamic-management-views/sys-dm-db-log-info-transact-sql)
- [sys.dm_database_encryption_keys (Transact-SQL)](/sql/relational-databases/system-dynamic-management-views/sys-dm-database-encryption-keys-transact-sql)
- [ALTER DATABASE SET options (Transact-SQL)](/sql/t-sql/statements/alter-database-transact-sql-set-options)
- Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates
