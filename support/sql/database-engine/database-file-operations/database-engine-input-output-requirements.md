---
title: Database Engine Input/Output requirements
description: This article describes the SQL Server Database Engine Disk I/O requirements.
ms.date: 11/04/2022
ms.custom: sap:File, Filegroup, Database Operations or Corruption
---
# SQL Server Database Engine Disk Input/Output (I/O) requirements

This article describes the SQL Server Database Engine Disk Input/Output (I/O) requirements.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 967576

## Introduction

SQL Server requires that systems support guaranteed delivery to stable media, as outlined in the following download documents:

- [SQL Server I/O Reliability Program Requirements](https://download.microsoft.com/download/f/1/e/f1ecc20c-85ee-4d73-baba-f87200e8dbc2/sql_server_io_reliability_program_review_requirements.pdf)

- [SQL Server IO Reliability Program Review Requirements](https://download.microsoft.com/download/f/1/e/f1ecc20c-85ee-4d73-baba-f87200e8dbc2/sql_server_io_reliability_program_review_requirements.pdf)

This requirement includes, but is not limited to, the following conditions:

- Windows logo certification
- Write ordering
- Caching stability
- No data rewrites

Systems that meet these requirements support SQL Server database storage. Systems do not have to be listed on SQL Server storage solutions programs, but they must guarantee that the requirements are met.

SQL Server maintains the atomicity, consistency, isolation, and durability (ACID) property by using the Write-Ahead Logging (WAL) protocol.

> [!WARNING]
> The incorrect use of SQL Server with an improperly tested solution may result in data loss, including total database loss.

## Technical support

Microsoft will provide full support for SQL Server and SQL Server-based applications. However, issues that are caused by the I/O solution will be referred to the device manufacturer. Symptoms may include, but are not limited to, the following:

- Database corruption
- Backup corruption
- Unexpected data loss
- Missing transactions
- Unexpected I/O performance variances

To determine whether your hardware solution supports "guaranteed delivery to stable media" as outlined under the SQL Server Always-On program, check with your vendor. We also recommend that you contact your vendor to verify that you have correctly deployed and configured the solution for transactional database use.

It is a common troubleshooting practice for a Microsoft Support professional to ask you to disable nonessential jobs and to disable or remove third-party components, move database files, uninstall drivers, and perform similar actions. We always try to reduce the scope of the issue while we work to identify it. After an issue is identified as unrelated to the jobs or third-party products, those jobs or third-party products may be reintroduced to production.

For more information, see the following article:

- [Microsoft does not certify that third-party products will work with Microsoft SQL Server](https://support.microsoft.com/help/913945)

- [Overview of the Microsoft third-party storage software solutions support policy](https://support.microsoft.com/help/841696)

## More information

The following table provides links to additional information that is related to specific I/O configurations.

| SQL Server I/O Internals|<ul><li>[SQL Server 2000 I/O Basics](/previous-versions//cc966500(v=technet.10)) </li><li> [SQL Server I/O Basics, Chapter 2](/previous-versions/sql/sql-server-2005/administrator/cc917726(v=technet.10)) </li><li> [Writing Pages](/previous-versions/sql/sql-server-2008-r2/aa337560(v=sql.105)) </li><li> [Database Checkpoints (SQL Server)](/sql/relational-databases/logs/database-checkpoints-sql-server)</li></ul> |
|---|---|
| WAL|<ul><li> [Write-Ahead Transaction Log](/previous-versions/sql/sql-server-2008-r2/ms186259(v=sql.105)) </li><li> [ACID Properties](https://www.microsoft.com/download/details.aspx?id=51958) (atomicity, consistency, isolation, and durability)</li><li> [Description of logging and data storage algorithms that extend data reliability in SQL Server](https://support.microsoft.com/help/230785)</li></ul>|
| File System Features<br/>|<ul><li> SQL Server databases not supported on compressed volumes (except 2005 read-only files)</li><li> Decreased performance in some features of SQL Server when you use EFS to encrypt database files|
| I/O caching|<ul><li> [Information about using disk drive caches with SQL Server that every database administrator should know](https://support.microsoft.com/help/234656) </li><li> [Description of caching disk controllers in SQL Server](https://support.microsoft.com/help/86903/description-of-caching-disk-controllers-in-sql-server)</li></ul>|
| Physical layout and design<br/>|<ul><li> [Physical Database Storage Design](/previous-versions/sql/sql-server-2005/administrator/cc966414(v=technet.10)) </li><li> [Scalable Shared Databases Overview](/previous-versions/sql/sql-server-2008-r2/ms345392(v=sql.105))</li></ul> |
| Tempdb|<ul><li> [Microsoft SQL Server I/O subsystem requirements for the tempdb database](https://support.microsoft.com/help/917047)</li><li> [Working with tempdb in SQL Server 2005](/previous-versions/sql/sql-server-2005/administrator/cc966545(v=technet.10)) </li><li> [Optimizing tempdb Performance](/previous-versions/sql/sql-server-2008-r2/ms175527(v=sql.105)) </li><li> [Recommendations to reduce allocation contention in SQL Server tempdb database](https://support.microsoft.com/help/2154845) </li></ul>|
| Utilities|<ul><li> [How to use the SQLIOSim utility to simulate SQL Server activity on a disk subsystem](https://support.microsoft.com/help/231619)</li><li> [Diskspd](https://github.com/microsoft/diskspd) - A robust storage testing tool|
| Diagnostics<br/>| <ul><li>[Asynchronous disk I/O appears as synchronous on Windows](../../../windows/win32/asynchronous-disk-io-synchronous.md)</li><li> [SQL Server diagnostics added to detect unreported I/O problems due to stale reads or lost writes](diagnostics-for-unreported-io-problems.md) </li><li> [MSSQLSERVER error 823](/sql/relational-databases/errors-events/mssqlserver-823-database-engine-error)<ul> <li> [Recording for Resource-based Analysis](/previous-versions/windows/it-pro/windows-8.1-and-8/hh448202(v=win.10)) of [Windows Performance Recorder](/previous-versions/windows/it-pro/windows-8.1-and-8/hh448205(v=win.10)) </li></ul></ul> Xperf resources: <li>[MSSQLSERVER error 823](/sql/relational-databases/errors-events/mssqlserver-823-database-engine-error) </li>|
| NAS (Network Attached Storage)| [Description of support for network database files in SQL Server](https://support.microsoft.com/help/304261)|
| iSCSI| [Support for SQL Server on iSCSI technology components](/sql/relational-databases/sql-server-storage-guide#iscsi)|
| Mirroring and Always On availability groups| <ul><li>[Prerequisites, Restrictions, and Recommendations for Always On availability groups](/sql/database-engine/availability-groups/windows/prereqs-restrictions-recommendations-always-on-availability) <li>Requirements for SQL Server to support remote mirroring of user databases<br/>Database Mirroring:<ul><li> [Database Mirroring in SQL Server 2005](/previous-versions/sql/sql-server-2005/administrator/cc917680(v=technet.10)) </li><li> [Database Mirroring Best Practices and Performance Considerations](https://download.microsoft.com/download/4/7/a/47a548b9-249e-484c-abd7-29f31282b04d/dbm_best_pract.doc) </li></ul></ul> These white papers also apply to Microsoft SQL Server 2008 and later versions of SQL Server.|
|I/O affinity| [INF: Understanding How to Set the SQL Server I/O Affinity Option](https://support.microsoft.com/help/298402)|
  
