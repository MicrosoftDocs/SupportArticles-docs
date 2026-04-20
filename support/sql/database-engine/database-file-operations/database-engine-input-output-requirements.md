---
title: Disk I/O Requirements for SQL Server Engine
description: SQL Server disk I/O requirements ensure data integrity through Write-Ahead Logging and ACID compliance. Learn about write ordering, caching, and stable media delivery.
ms.date: 04/16/2026
ms.topic: best-practice
ms.reviewer: jopilov, v-shaywood
ms.custom: sap:File, Filegroup, Database Operations or Corruption
---
# SQL Server Database Engine disk I/O requirements

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 967576

## Summary

Microsoft SQL Server requires that I/O subsystems support guaranteed delivery to stable media. This requirement covers write ordering, caching stability, and data integrity to maintain the atomicity, consistency, isolation, and durability (ACID) properties through the [Write-Ahead Logging (WAL)](/sql/relational-databases/sql-server-storage-guide#write-ahead-logging) protocol. Systems that don't meet these requirements can cause database corruption, backup corruption, unexpected data loss, or missing transactions.

This article describes the specific disk I/O requirements, technical support policies for I/O-related issues, and links to resources for various storage configurations.

## Introduction to I/O requirements

SQL Server requires that systems support guaranteed delivery to stable media, as outlined in the [SQL Server I/O Reliability Program Requirements](https://download.microsoft.com/download/f/1/e/f1ecc20c-85ee-4d73-baba-f87200e8dbc2/sql_server_io_reliability_program_review_requirements.pdf) document.

This requirement includes, but isn't limited to, the following conditions:

- [Windows Hardware Compatibility Program](/windows-hardware/design/compatibility/)
- Write ordering
- Caching stability
- No data rewrites

Systems that meet these requirements support SQL Server database storage. Systems don't have to be listed on SQL Server storage solutions programs, but they must guarantee that the requirements are met.

SQL Server maintains the ACID properties by using the WAL protocol.

> [!WARNING]
> Incorrect use of SQL Server by using an improperly tested solution can cause data loss, including total database loss.

## Technical support

Microsoft provides full support for SQL Server and SQL Server-based applications. However, the device manufacturer is responsible for support when the I/O solution causes problems. Symptoms include, but aren't limited to, the following items:

- Database corruption
- Backup corruption
- Unexpected data loss
- Missing transactions
- Unexpected I/O performance variances

To determine whether your hardware solution supports "guaranteed delivery to stable media," check with your vendor. Also, contact your vendor to verify that you correctly deployed and configured the solution for transactional database use.

A Microsoft Support professional might ask you to disable nonessential jobs and to disable or remove third-party components, move database files, uninstall drivers, and do similar actions. This troubleshooting practice always tries to reduce the scope of the issue while working to identify it. After an issue is identified as unrelated to the jobs or third-party products, you can reintroduce those jobs or third-party products to production.

For more information, see the following articles:

- [Microsoft does not certify that third-party products will work with Microsoft SQL Server](https://support.microsoft.com/help/913945)
- [Overview of the Microsoft third-party storage software solutions support policy](/previous-versions/troubleshoot/windows-server/3rd-party-storage-software-solutions-support)

## I/O configuration resources

The following table provides links to more information for specific I/O configurations.

| Configuration                               | Additional information                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| ------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| SQL Server I/O internals                    | <ul><li>[SQL Server I/O fundamentals](/sql/relational-databases/sql-server-storage-guide)</li><li>[Writing Pages](/sql/relational-databases/writing-pages)</li><li>[Database checkpoints (SQL Server)](/sql/relational-databases/logs/database-checkpoints-sql-server)</li></ul>                                                                                                                                                                                                                                                                                           |
| WAL                                         | <ul><li>[Write-Ahead Transaction Log](/sql/relational-databases/sql-server-transaction-log-architecture-and-management-guide#write-ahead-transaction-log)</li><li>[ACID Properties](/windows/win32/cossdk/acid-properties) (atomicity, consistency, isolation, and durability)</li><li>[Description of logging and data storage algorithms that extend data reliability in SQL Server](logging-data-storage-algorithms.md)</li></ul>                                                                                                                                       |
| File system features                        | <ul><li>SQL Server databases aren't supported on compressed volumes (except read-only files). For more information, see [Description of support for SQL Server databases on compressed volumes](support-databases-compressed-volumes.md).</li><li>[Decreased performance in SQL Server when you use EFS to encrypt database files](../performance/decreased-performance-use-efs.md)</li></ul>                                                                                                                                                                              |
| I/O caching                                 | <ul><li>[SQL Server I/O fundamentals](/sql/relational-databases/sql-server-storage-guide)</li></ul> **Note:** The presence of a UPS doesn't ensure safe write caching. Only battery-backed or capacitor-based hardware caching systems that persist writes across resets meet SQL Server’s durability requirements.                                                                                                                                                                                                                                                  |
| Physical layout and design                  | <ul><li>[Physical Database Storage Design](/previous-versions/sql/sql-server-2005/administrator/cc966414(v=technet.10))</li><li>[Scalable Shared Databases Overview](/previous-versions/sql/sql-server-2008-r2/ms345392(v=sql.105))</li></ul>                                                                                                                                                                                                                                                                                                                              |
| tempdb                                      | <ul><li>[Microsoft SQL Server I/O subsystem requirements for the tempdb database](io-subsystem-requirements-tempdb.md)</li><li>[tempdb database](/sql/relational-databases/databases/tempdb-database)</li><li>[Recommendations to reduce allocation contention in SQL Server tempdb database](../performance/recommendations-reduce-allocation-contention.md)</li></ul>                                                                                                                                                                                                    |
| Utilities                                   | <ul><li>[Use the SQLIOSim utility to simulate SQL Server activity on a disk subsystem](../../tools/sqliosim-utility-simulate-activity-disk-subsystem.md)</li><li>[Diskspd](https://github.com/microsoft/diskspd) - A robust storage testing tool</li></ul>                                                                                                                                                                                                                                                                                                              |
| Diagnostics                                 | <ul><li>[Asynchronous disk I/O appears as synchronous on Windows](/previous-versions/troubleshoot/windows/win32/asynchronous-disk-io-synchronous)</li><li>[SQL Server diagnostics detects unreported I/O problems due to stale reads or lost writes](diagnostics-for-unreported-io-problems.md)</li><li>[MSSQLSERVER error 823](/sql/relational-databases/errors-events/mssqlserver-823-database-engine-error)</li></ul>                                                                                                                                                   |
| NAS (Network Attached Storage)              | [Description of support for network database files in SQL Server](support-network-database-files.md)                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| iSCSI                                       | [Support for SQL Server on iSCSI technology components](/sql/relational-databases/sql-server-storage-guide#iscsi)                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| Mirroring and Always On availability groups | <ul><li>[Prerequisites, restrictions, and recommendations for Always On availability groups](/sql/database-engine/availability-groups/windows/prereqs-restrictions-recommendations-always-on-availability)</li></ul> Database Mirroring: <ul><li>[Database Mirroring (SQL Server)](/sql/database-engine/database-mirroring/database-mirroring-sql-server)</li><li>[Prerequisites, Restrictions, and Recommendations for Database Mirroring](/sql/database-engine/database-mirroring/prerequisites-restrictions-and-recommendations-for-database-mirroring)</li></ul> |
| I/O affinity                                | [Server configuration: affinity I/O mask](/sql/database-engine/configure-windows/affinity-input-output-mask-server-configuration-option)                                                                                                                                                                                                                                                                                                                                                                                                                                   |

## Related content

- [Troubleshoot slow SQL Server performance caused by I/O issues](../performance/troubleshoot-sql-io-performance.md)
- [Configure antivirus software to work with SQL Server](../security/antivirus-and-sql-server.md)
- [Performance and consistency issues when certain modules or filter drivers are loaded](../performance/performance-consistency-issues-filter-drivers-modules.md)
