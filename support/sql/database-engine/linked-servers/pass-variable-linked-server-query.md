---
title: Pass a variable to a linked server query
description: This article describes how to pass a variable to a linked server query.
ms.date: 10/29/2020
ms.custom: sap:Administration and Management
ms.topic: how-to
---
# Pass a variable to a linked server query

This article describes how to pass a variable to a linked server query.

_Original product version:_ &nbsp; SQL Server Books Online  
_Original KB number:_ &nbsp; 314520

## Summary

When you query a linked server, you frequently perform a pass-through query that uses the `OPENQUERY`, `OPENROWSET`, or `OPENDATASOURCE` statement. You can view the examples in SQL Server Books Online to see how to do this by using pre-defined Transact-SQL strings, but there are no examples of how to pass a variable to these functions. This article provides three examples of how to pass a variable to a linked server query.

To pass a variable to one of the pass-through functions, you must build a dynamic query.

Any data that includes quotes needs particular handling.

## Pass basic values

When the basic Transact-SQL statement is known, but you have to pass in one or more specific values, use code that is similar to the following sample:

```sql
DECLARE @TSQL varchar(8000), @VAR char(2)
SELECT @VAR = 'CA'
SELECT @TSQL = 'SELECT * FROM OPENQUERY(MyLinkedServer,''SELECT * FROM pubs.dbo.authors WHERE state = ''''' + @VAR + ''''''')'
EXEC (@TSQL)
```

## Pass the whole query

When you have to pass in the whole Transact-SQL query or the name of the linked server (or both), use code that is similar to the following sample:

```sql
DECLARE @OPENQUERY nvarchar(4000), @TSQL nvarchar(4000), @LinkedServer nvarchar(4000)
SET @LinkedServer = 'MyLinkedServer'
SET @OPENQUERY = 'SELECT * FROM OPENQUERY('+ @LinkedServer + ','''
SET @TSQL = 'SELECT au_lname, au_id FROM pubs..authors'')'
EXEC (@OPENQUERY+@TSQL)

```

### Use the Sp_executesql stored procedure

To avoid the multi-layered quotes, use code that is similar to the following sample:

```sql
DECLARE @VAR char(2)
SELECT @VAR = 'CA'
EXEC MyLinkedServer.master.dbo.sp_executesql
N'SELECT * FROM pubs.dbo.authors WHERE state = @state',
N'@state char(2)',
@VAR
```

## See Also

For more information, see the following topics:

- [OPENROWSET (Transact-SQL)](/sql/t-sql/functions/openrowset-transact-sql)
- [OPENQUERY (Transact- SQL)](/sql/t-sql/functions/openquery-transact-sql)
- [OPENDATASOURCE (Transact-SQL)](/sql/t-sql/functions/opendatasource-transact-sql)
- [sp_executesql (Transact-SQL)](/sql/relational-databases/system-stored-procedures/sp-executesql-transact-sql)
