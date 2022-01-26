---
title: Iterate through a result set by using Transact-SQL
description: This article describes various methods that you can use to iterate through a result set by using Transact-SQL in SQL Server.
ms.date: 10/29/2020
ms.custom: sap:Administration and Management
ms.topic: how-to
ms.prod: sql
---
# Iterate through a result set by using Transact-SQL in SQL Server

This article describes various methods that you can use to iterate through a result set by using Transact-SQL in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 111401

## Summary

This article describes various methods that you can use to simulate a cursor-like FETCH-NEXT logic in a stored procedure, trigger, or Transact-SQL batch.

## Use Transact-SQL Statements to Iterate Through a Result Set

There are three methods you can use to iterate through a result set by using Transact-SQL statements.

One method is the use of temp tables. With this method, you create a snapshot of the initial `SELECT` statement and use it as a basis for cursoring. For example:

```SQL
/********** example 1 **********/
declare @au_id char( 11 )

set rowcount 0
select * into #mytemp from authors

set rowcount 1

select @au_id = au_id from #mytemp

while @@rowcount <> 0

begin
set rowcount 0
select * from #mytemp where au_id = @au_id
delete #mytemp where au_id = @au_id

set rowcount 1
select @au_id = au_id from #mytemp
end
set rowcount 0

```

A second method is to use the `min` function to walk a table one row at a time. This method catches new rows that were added after the stored procedure begins execution, provided that the new row has a unique identifier greater than the current row that is being processed in the query. For example:

```SQL
/********** example 2 **********/
declare @au_id char( 11 )

select @au_id = min( au_id ) from authors
while @au_id is not null

begin
select * from authors where au_id = @au_id
select @au_id = min( au_id ) from authors where au_id > @au_id
end
```

> [!NOTE]
> Both example 1 and 2 assume that a unique identifier exists for each row in the source table. In some cases, no unique identifier may exist. If that is the case, you can modify the temp table method to use a newly created key column. For example:

```SQL
/********** example 3 **********/
set rowcount 0
select NULL mykey, * into #mytemp from authors

set rowcount 1
update #mytemp set mykey = 1

while @@rowcount > 0
begin
set rowcount 0
select * from #mytemp where mykey = 1
delete #mytemp where mykey = 1
set rowcount 1
update #mytemp set mykey = 1
end
set rowcount 0
```

## References

[ROW_NUMBER (Transact-SQL)](/sql/t-sql/functions/row-number-transact-sql)
