---
title: Format a date or time value to query a table
description: This article discusses how to query a date or time value from a SQL Server table by using a remote view or a SQL pass-through query in Visual FoxPro.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.topic: how-to
---
# Format a date or time value to query an SQL table in Visual FoxPro

This article introduces how to query a date or time value from a SQL Server table by using a remote view or a SQL pass-through query in Visual FoxPro.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 145817

## INTRODUCTION

In Visual FoxPro, you can format date type input data as {mm/dd/yy}. Or, if you type directly in a date field, you can format date type input data as mm/dd/yy. However, if you format the data as {mm/dd/yy} or as mm/dd/yy when you perform a remote query on an SQL table, you experience an ODBC error.

## More information

If you pass date values, time values, or `timestamp` values in a remote query to an SQL table, you have to format the data by using the following escape clauses:

- Date value: {d '**yyyy** - **mm** - **dd**'}. In this format, **yyyy** represents the year, **mm** represents the month, and **dd** represents the day.

- Time value: {t '**hh** : **mm** : **ss**'}. In this format, **hh** represents the hours, **mm** represents the minutes, and **ss** represents the seconds.

- Timestamp value: {ts '**yyyy** - **mm** - **dd** **hh** : **mm** : **ss**'}.

In a SQL pass-through query, you can use the following syntax to retrieve the value of a date field:

```sql
 =SQLEXEC( nConnHandle, "SELECT * FROM TITLES WHERE
 Titles.pubdate<{ts '1995-06-12 12:55:00'}", 'MyCursor')
```

You can use the following syntax to create a remote view that queries date and time information:

```sql
 CREATE SQL VIEW sqldate REMOTE CONNECTION sqldate AS SELECT * FROM ;
 dbo.titles WHERE Titles.pubdate<{ts '1985-06-12 12:55:00'}
```

In the View Designer, make sure that the date values, the time values, or the timestamp values are formatted the way that you want them in the Examples field of the Selection Criteria tab. When you save the view, the information in the Examples field is saved together with the view. If you open and then modify the view, the information in the Examples field is lost. If you do this, you must type the information again.

> [!NOTE]
> When you pass the field name as a parameter in a remote query instead of passing a value, you do not experience an ODBC error because Visual FoxPro performs a conversion.

## References

*ODBC 2.0 Programmer's Reference and SDK Guide*, pp.50-52, Microsoft Press.
