---
title: Query that typecasts a Unicode column
description: This article provides workarounds for the problem that occurs when a statement contains an "IN" or "Or" clause that's defined for a Unicode column and contains 'collate' to typecast the Unicode column to another binary collation.
ms.date: 09/07/2020
ms.custom: sap:Database Design and Development
ms.prod: sql
---
# SQL Server query that typecasts a Unicode column to a binary collation returns incorrect results

This article helps you resolve the problem that occurs when a statement contains an `IN` or `Or` clause that's defined for a Unicode column and contains `collate` to typecast the Unicode column to another binary collation.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 3053639

## Symptoms

You have a table in a SQL Server database in which the following conditions are true:

- The table contains a Unicode column. For example, the table has a nchar(5) column.
- Collation of the Unicode column is `Latin1_General_BIN`.
- The same Unicode column is part of an index. However, T-SQL statements that are run against this table may return incorrect results. This problem occurs when the following conditions are true:
- The T-SQL statement contains an `IN` or `Or` clause that's defined for the same Unicode column.
- The T-SQL statement contains `collate` to typecast the Unicode column to another binary collation.

Sample query:

```sql
CREATE TABLE [dbo].[Table_1]([Col1] [smallint] NOT NULL,
[Col2] [nchar](5),
[Col3] [nchar](5) COLLATE Latin1_General_BIN NOT NULL, -- Col3 , a Unicode Column with "Latin1_General_BIN" collation
CONSTRAINT [PK__Table_1] PRIMARY KEY CLUSTERED -- Primary Key on all the 3 columns
([Col1] ASC,
[Col2] ASC,
[Col3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

select * from Table_1 where Col1 = 1 and Col2 = '1' and Col3 collate Chinese_PRC_BIN IN (N'1' ,N'2')  -- This statement using "IN" and "collate" might give incorrect results.
go

select * from Table_1 where Col1 = 1 and Col2 = '1' and (Col3 collate Chinese_PRC_BIN = N'1' or Col3 collate Chinese_PRC_BIN = N'2') -- This statement using "OR" and "collate" might give incorrect results.
go
```

## Workaround

To work around this problem, make sure that the Unicode column (Col3 in the sample query in the [Symptoms](#symptoms) section) meets one of the following conditions:

- Is of the datatype char(5) or nvarchar(5).
- Is defined by using the same collation of `Chinese_PROC_BIN` for which collate is desired (be aware that `Chinese_PROC_BIN` is just an example; other binary collations also apply).
- Is of a collation other than `Latin1_General_BIN`.
- Is collated on CI collation. For example: `collate Chinese_PRC_90_CI_AI IN (N'1 ', N'2 ')`.
- Is compared with a constant that matches the column length. For example, `collate Chinese_PRC_BIN IN (N'1 ', N'2 ')`.
- Is not part of the Index, or a table scan is forced by using the `FORCESCAN` table hint.
- Functions such as `RTRIM` and `LTRIM` are used to force a table scan.

## More information

To reproduce this issue, run the following script:

```sql
CREATE DATABASE Test_DB
GO

use Test_DB
go

CREATE TABLE [dbo].[Table_1]([Col1] [smallint] NOT NULL,
[Col2] [nchar](5),
[Col3] [nchar](5) COLLATE Latin1_General_BIN NOT NULL, -- Col3 , a Unicode Column with "Latin1_General_BIN" collation

CONSTRAINT [PK__Table_1] PRIMARY KEY CLUSTERED -- Primary Key on all the 3 columns
([Col1] ASC,
[Col2] ASC,
[Col3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- Populate the table with a sample script as below

declare @x as int
declare @y as int

set @x=1
set @y=1

while (@x<=2)
begin
while (@y<=1000)
begin
insert into Table_1 values (@x,@y,@y)
set @y=@y+1
end
set @x=@x +1
end
go

select * from Table_1 where Col1 = 1 and Col2 = '1' and Col3 collate Chinese_PRC_BIN = N'1' -- Expected output of one row.
go

select * from Table_1 where Col1 = 1 and Col2 = '1' and Col3 collate Chinese_PRC_BIN in (N'1' ,N'2') -- No rows returned when output for Col3= N'1' is expected.
go

select * from Table_1 where Col1 = 1 and Col2 = '1' and (Col3 collate Chinese_PRC_BIN = N'1' or Col3 collate Chinese_PRC_BIN = N'2') -- No rows returned when output for Col3= N'1' is expected.
go
```

## Applies to

- SQL Server 2014 Business Intelligence
- SQL Server 2014 Developer
- SQL Server 2014 Enterprise
- SQL Server 2014 Enterprise Core
- SQL Server 2014 Express
- SQL Server 2014 Standard
- SQL Server 2014 Web
- SQL Server 2012 Business Intelligence
- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Express
- SQL Server 2012 Standard
- SQL Server 2012 Web
- SQL Server 2012 Enterprise Core
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Express
- SQL Server 2008 R2 Parallel Data Warehouse
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Web
- SQL Server 2008 R2 Workgroup
- SQL Server 2008 Developer
- SQL Server 2008 Enterprise
- SQL Server 2008 Express
- SQL Server 2008 Standard
- SQL Server 2008 Web
- SQL Server 2008 Workgroup
- SQL Server 2005 Developer Edition
- SQL Server 2005 Enterprise Edition
- SQL Server 2005 Express Edition
- SQL Server 2005 Standard Edition
- SQL Server 2005 Standard X64 Edition
- SQL Server 2005 Workgroup Edition
