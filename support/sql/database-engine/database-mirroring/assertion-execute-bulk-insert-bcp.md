---
title: Assertion when you execute Bulk Insert or BCP 
description: This article provides a workaround for the problem that occurs when you try to execute a BULK INSERT or BCP operation.
ms.date: 09/23/2022
ms.custom: sap:Administration and Management
ms.reviewer: nathansc
---
# SQL Server assertion error when you try to execute a Bulk Insert or BCP statement

This article helps you resolve the problem that occurs when you try to execute a `BULK INSERT` or `BCP` operation.

_Original product version:_ &nbsp; SQL Server 2008 R2 Enterprise, SQL Server 2008 Enterprise  
_Original KB number:_ &nbsp; 2700641

## Symptoms

Consider the following scenario:

- Server A and Server B are running Microsoft SQL Server 2008 or SQL Server 2008 R2.
- You set up database mirroring between Server A and Server B.
- You execute a `BULK INSERT` or `BCP` statement on the principal database.

    > [!NOTE]
    > By default, the `CHECK_CONSTRAINTS` option is set to **off** when you execute a `BULK INSERT` or `BCP` statement.

- The database mirroring is broken, and the database mirroring session enters the SUSPENDED state.

In this scenario, an assertion occurs on the mirror server. Therefore, a mini-dump file is created in the SQL Server log folder. Additionally, you see following error in the SQL Server error log on the mirror server:

> [!NOTE]
> You must reinitialize database mirroring to resolve this issue.

## Cause

This issue occurs because the lock compatibility information in the transaction log of the principal database isn't transferred to the mirror server.

## Workaround

To work around this issue, execute the `BULK INSERT` or `BCP` statement on the principal database by using the `CHECK_CONSTRAINTS` option.

> [!NOTE]
> The `CHECK_CONSTRAINTS` option causes slower performance. However, the lock assert on the mirror server doesn't occur.

## More information

During a `BULK INSERT` or `BCP` operation, a child transaction turns off the `CHECK_CONSTRAINTS` option. This child transaction uses a lock that is compatible with the parent transaction locks. The compatibility information is stored in the transaction log of the principal database. Therefore, the child transaction lock request is granted on the principal database.

However, this compatibility information isn't transferred to the mirror server. Therefore, the child transaction lock request is incompatible with the parent transaction locks on the mirror server. This scenario causes the assert on the mirror server.
