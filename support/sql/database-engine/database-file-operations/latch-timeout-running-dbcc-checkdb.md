---
title: Error when you run the DBCC CHECKDB statement
description: This article describes a problem where you receive an error message when you try to run the DBCC CHECKDB statement on a database that contains a large table in SQL Server.
ms.date: 10/11/2022
ms.custom: sap:Administration and Management
ms.reviewer: keithelm
---
# "Timeout occurred while waiting for latch" error when running `DBCC CHECKDB` statement on a database

This article introduces a problem where you receive an error message when you try to run the `DBCC CHECKDB` statement on a database that contains a large table in SQL Server.

_Original product version:_ &nbsp; SQL Server 2012, SQL Server 2008  
_Original KB number:_ &nbsp; 919155

## Symptoms

Consider the following scenario:

- You have a database that contains one or more very large tables.
- The tables are typically several hundred gigabytes (GB) in size.
- You run the `DBCC CHECKDB` statement on the database in SQL Server.

In this scenario, an error message that resembles the following is written to the SQL Server error log:

> \<DateTime> spid65 Timeout occurred while waiting for latch: class 'DBCC_MULTIOBJECT_SCANNER', id 000000002201DED0, type 4, Task 0x000000000C80BEB8 : 6, waittime 300, flags 0xa, owning task 0x0000000005A0AC58. Continuing to wait.

However, the `DBCC CHECKDB` statement will complete successfully. You can safely ignore the error message.

## Cause

This issue occurs because a time-out occurs when SQL Server traverses the Index Allocation Map (IAM) chains. The latch that is mentioned in the error message is used to prevent other threads from accessing a list. This list is being built by a thread that traverses the IAM chains for all indexes that are associated with a given table. If the table is large enough that traversing these IAM chains takes more than 5 minutes, you may experience the latch time-out. Additionally, this issue is typically worse when disk I/O is slow.

## Status

This behavior is by design.

## Applies to

- SQL Server 2008 Developer
- SQL Server 2008 Enterprise
- SQL Server 2008 Express
- SQL Server 2008 Express with Advanced Services
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Express
- SQL Server 2008 R2 Express with Advanced Services
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Standard Edition for Small Business
- SQL Server 2008 R2 Web
- SQL Server 2008 R2 Workgroup
- SQL Server 2008 Standard
- SQL Server 2008 Web
- SQL Server 2008 Workgroup
- SQL Server 2012 Business Intelligence
- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Express
- SQL Server 2012 Standard
- SQL Server 2012 Web
- SQL Server 2012 Enterprise Core
