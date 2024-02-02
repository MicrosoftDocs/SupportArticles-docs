---
title: Create database permission is logged
description: This article provides more information on why a `CREATE DATABASE` event can be logged when server audit is specified on a SQL Server instance.
ms.date: 09/09/2020
ms.custom: sap:Administration and Management
ms.reviewer: nathansc
---
# Create database permission is logged to the Audit log when you run RESTORE VERIFYONLY

This article provides more information on why a `CREATE DATABASE` event can be logged when server audit is specified on a SQL Server instance.

_Original product version:_ &nbsp; Microsoft SQL Server 2014, SQL Server 2016, SQL Server 2017 on Linux, SQL Server 2017 on Windows  
_Original KB number:_ &nbsp; 4502458

## Symptoms

Assume that you set up a SQL Server audit to have a server audit specification that uses the `DATABASE_CHANGE_GROUP` event. When a user runs `RESTORE VERIFYONLY` on a database backup file, the `CREATE DATABASE` permission is logged to the Audit log.

## Cause

The `CREATE DATABASE` permission is required to run `RESTORE VERIFYONLY`. When that permission is checked, a corresponding event is logged to the Audit log for the `DATABASE_CHANGE_GROUP` audit specification.

## Workaround

To work around this issue, use a query such as the following to filter the Audit log records that are related to running `RESTORE VERIFYONLY`:

```sql
select * from fn_get_audit_file('C:\path\to\file.sqlaudit', default, default) where statement NOT LIKE '%RESTORE VERIFYONLY%'
```

## More information

- [RESTORE Statements - VERIFYONLY (Transact-SQL)](/sql/t-sql/statements/restore-statements-verifyonly-transact-sql)

- [GRANT Database Permissions (Transact-SQL)](/sql/t-sql/statements/grant-database-permissions-transact-sql).
