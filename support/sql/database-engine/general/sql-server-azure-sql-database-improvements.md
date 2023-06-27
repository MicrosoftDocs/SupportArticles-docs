---
title: SQL Server Database improvements
description: This article describes how persisted structures in your SQL Server database can be validated as part of the upgrade compatibility level, and how any affected structures can be rebuilt after you upgrade the compatibility level.
ms.date: 02/17/2020
ms.custom: sap:Database Design and Development
---

# SQL Server and Azure SQL Database improvements in handling some data types and uncommon operations

This article introduces how persisted structures in your SQL Server database can be validated as part of the upgrade compatibility level, and how any affected structures can be rebuilt after you upgrade the compatibility level.

_Original product version:_ &nbsp; SQL Server 2017, SQL Server 2016  
_Original KB number:_ &nbsp; 4010261

The database engine in Microsoft SQL Server 2016 and Azure SQL Database includes improvements in data type conversions and several other operations. Most of these improvements offer increased precision when you work with floating-point types and also with classic datetime types.

These improvements are all available when you use a database compatibility level of at least 130. This means that for some (mostly uncommon) expressions, you can see different results for some input values after you upgrade the database to compatibility level 130 or a higher setting. These results may be reflected in:

- persisted structures in the database
- included table data that is subject to `CHECK` constraints
- persisted computed columns
- indexes referencing computed columns
- filtered indexes, and indexed views.

If you have a database that was created in an earlier version of SQL Server, we recommend you do additional validation after you upgrade to SQL Server 2016 or later, and before you change the database compatibility level.

If you find any of the persisted structures in your database are affected by these changes, we recommend you rebuild affected structures after you upgrade the database compatibility level. By doing this, you'll benefit from these improvements in SQL Server 2016 or later.

This article describes how persisted structures in your database can be validated as part of the upgrade to compatibility level 130 or a higher setting, and how any affected structures can be rebuilt after you change the compatibility level.

## Validation steps during an upgrade to database compatibility level

Starting in SQL Server 2016, both SQL Server and Azure SQL Database include improvements to the precision of the following operations:

- Uncommon data type conversions. These include the following:
  - Float/integer to/from datetime/smalldatetime
  - Real/float to/from numeric/money/smallmoney
  - Float to real
- Some cases of `DATEPART`/`DATEDIFF` and `DEGREES`
- `CONVERT` that uses a `NULL` style

To use these improvements to expression evaluation in your application, change the compatibility level of your databases to 130 (for SQL Server 2016) or 140 (for SQL Server 2017 and Azure SQL Database). For more information about all the changes and some examples that show the changes, see the [Appendix A](#appendix-a-changes-in-compatibility-level-130) section.

The following structures in the database may persist the results of an expression:

- Table data subject to `CHECK` constraints
- Persisted computed columns
- Indexes that use computed columns in the key or included columns
- Filtered indexes
- Indexed views

Consider the following scenario:

- You have a database that was created by an earlier version of SQL Server, or that was already created in SQL Server 2016 or a later version but at a compatibility level 120 or an earlier level.

- You use any expressions whose precision was improved as part of the definition of persisted structures in your database.

In this scenario, you may have persisted structures that are affected by the improvements in precision that are implemented by using compatibility level 130 or higher. If this is the case, we recommend that you validate the persisted structures and rebuild any structure that's affected.

If you have affected structures, and you don't rebuild them after changing the compatibility level, you may experience slightly different query results. The results depend on whether a particular index, computed column, or view is used, and whether data in a table could be considered a violation of a constraint.

> [!NOTE]
> Trace Flag 139 in SQL Server
>
> The global trace flag 139 is introduced in SQL Server 2016 CU3 and Service Pack (SP) 1 to force correct conversion semantics in the scope of DBCC check commands like `DBCC CHECKDB`, `DBCC CHECKTABLE`, and `DBCC CHECKCONSTRAINTS` when you analyze the improved precision and conversion logic introduced with compatibility level 130 on a database that has an earlier compatibility level.

> [!WARNING]
> Trace flag 139 isn't meant to be enabled continuously in a production environment, and should be used for the sole purpose of performing the database validation checks described in this article. Therefore, it should be disabled by using `dbcc traceoff (139, -1)` in the same session, after the validation checks are completed.

Trace flag 139 is supported starting in SQL Server 2016 CU3 and SQL Server 2016 SP1.

To upgrade the compatibility level, follow these steps:

1. Perform validation to identify any affected persisted structures:
   1. Enable trace flag 139 by running `DBCC TRACEON(139, -1)`.
   1. Run `DBCC CHECKDB/TABLE` and `CHECKCONSTRAINTS` commands.
   1. Disable trace flag 139 by running `DBCC TRACEOFF(139, -1)`.
1. Change the database compatibility level to 130 (for SQL Server 2016) or 140 (for SQL Server 2017 and Azure SQL Database).
1. Rebuild any structures that you identified in step 1.

> [!NOTE]
> Trace flags in Azure SQL Database
> Setting trace flags isn't supported in Azure SQL Database. Therefore, you must change the compatibility level before you perform validation:
>
> 1. Upgrade the database compatibility level to 140.
> 1. Validate to identify any impacted persisted structures.
> 1. Rebuild the structures that you identified in step 2.

- [Appendix A](#appendix-a-changes-in-compatibility-level-130) contains a detailed list of all the precision improvements and provides an example for each.

- [Appendix B](#appendix-b-steps-to-verify-and-update-persisted-structures) contains a detailed step-by-step process to do validation and to rebuild any affected structures.

- [Appendix C](#appendix-c-queries-to-identify-candidate-tables) and [Appendix D](#appendix-d-script-to-create-check-statements) contain scripts to help pinpoint potentially affected objects in the database. Therefore, you can scope your validations and generate corresponding scripts to run the checks. To most easily determine whether any persisted structures in your databases are affected by the precision improvements in compatibility level 130, run the script in [Appendix D](#appendix-d-script-to-create-check-statements) in order to generate the correct validation checks, and then run this script to do validation.

## Appendix A: Changes in compatibility level 130

This appendix provides detailed lists of the improvements to expression evaluation in compatibility level 130. Each change includes an associated example query. The queries can be used to show the differences between executing in a database that uses a pre-130 compatibility level as compared to a database that uses compatibility level 130.

The following tables list data type conversions and additional operations.

**Data type conversions**

|From| To |Change|Example query|Result for compatibility level < 130|Result for compatibility level = 130|
|--|---|---|---|---|---|
|`float`, `real`, `numeric`, `decimal`, `money`, or `smallmoney`|`datetime` or `smalldatetime`|Increase rounding precision. Previously, day and time were converted separately, and results were truncated before you combined them.|`DECLARE @f FLOAT = 1.2 DECLARE @d DATETIME = @f SELECT CAST(@d AS FLOAT)`|1.19999996141975|1.2|
|`datetime`|`bigint, int, or smallint`|A negative datetime whose time part is exactly a half-day or in a tick of a half-day is rounded incorrectly (the result is off by 1).|`DECLARE @h DATETIME = -0.5 SELECT @h, CAST(@h AS INT)`|0|-1|
|`datetime` or `smalldatetime`|`float, real, numeric, money, or smallmoney`|Improved precision for the last 8 bits of precision in some cases.|`DECLARE @p0 DATETIME = '1899-12-31 23:58:00.470' DECLARE @f FLOAT = CONVERT(FLOAT, @p0)  SELECT @f, CAST(@f AS VARBINARY(8))`|-0.00138344907407406, 0xBF56AA9B21D85800|-0.00138344907407407, 0xBF56AA9B21D8583B|
| `float`|`real`|Boundary checks are less strict.| `SELECT CAST (3.40282347000E+038 AS REAL)`|Arithmetic overflow|3.402823E+38|
|`numeric`, `money`, and `smallmoney`|`float`|When the input scale is zero, there's a rounding imprecision when you combine the four parts of numeric.|`DECLARE @n NUMERIC(38, 0)= 41538374868278625639929991208632320 DECLARE @f FLOAT = CAST(@n AS FLOAT) SELECT CONVERT(BINARY(8), @f)`|0x4720000000000000|0x4720000000000001|
|`numeric`, `money`, and `smallmoney`|`float`|When the input scale is nonzero, there's a rounding imprecision when you divide by 10^scale.|`DECLARE @n NUMERIC(18, 10) = 12345678.0123456781 DECLARE @f FLOAT = CAST(@n AS FLOAT) SELECT CAST(@f AS BINARY(8))`|0x41678C29C06522C4|0x41678C29C06522C3|
| `real` or `float`|numeric|Improved rounding precision in some cases.|`DECLARE @f float = 0.14999999999999999 SELECT CAST(@f AS numeric(1, 1))`|0.2|0.1|
| `real` or `float`|numeric|Improved precision when you round to more than 16 digits in some cases.|`DECLARE @v decimal(38, 18) = 1E-18 SELECT @v`|0.000000000000000000|0.000000000000000001|
| `real` or `float`|`money` or `smallmoney`|Improved accuracy when you convert large numbers in some cases.|`DECLARE @f float = 2SET @f = POWER(@f, 49) + POWER(@f, -2) SELECT CAST(@f AS money)`|562949953421312.2048|562949953421312.25|
| `(n)(var)char`| `numeric`|An input of more than 39 characters no longer necessarily triggers an arithmetic overflow.|`DECLARE @value nchar(100) = '1.11111111111111111111111111111111111111' SELECT CAST(@value AS decimal(2,1))`|Arithmetic overflow|1.1|
| `(n)(var)char`| `bit`|Supports leading spaces and signs.|`DECLARE @value nvarchar(100) = '1' SELECT CAST(@value AS bit)`|Conversion failed when converting the `nvarchar` value '1' to data type bit.|1|
| `datetime`| `time` or `datetime2`|Improved precision when you convert to date/time types with higher precision. Be aware that datetime values are stored as ticks that represent 1/300th of a second. The newer time and datetime2 types store a discrete number of digits, where the number of digits matches the precision.|`DECLARE @value datetime = '1900-01-01 00:00:00.003' SELECT CAST(@value AS time(7))`|00:00:00.0030000|00:00:00.0033333|
| `time` or `datetime2`| `datetime`|Improved rounding in some cases.|`DECLARE @value time(4) = '00:00:00.0045' SELECT CAST(@value AS datetime)`|1900-01-01 00:00:00.007|1900-01-01 00:00:00.003|

**Operation**

|Operation| Change |Example query| Result for compatibility level <130 |Result for compatibility level 130|
|---|---|---|---|---|
|Use the `RADIANS` or `DEGREES` built-in function that uses the numeric data type.|`DEGREES` divides by pi/180, where it previously multiplied by 180/pi. Similar for `RADIANS`.|`DECLARE @arg1 numeric = 1 SELECT DEGREES(@arg1)`|57.295779513082323000|57.295779513082322865|
|Numerical addition or subtraction when the scale of one operand is larger than the scale of the result.|Rounding always occurs after the addition or subtraction, while previously it could sometimes occur before.|`DECLARE @p1 numeric(38, 2) = -1.15  DECLARE @p2 numeric(38, 1) = 10  SELECT @p1 + @p2`|8.8|8.9|
|`CONVERT` with `NULL` style.|`CONVERT` with `NULL` style always returns `NULL` when the target type is numeric.|`SELECT CONVERT (SMALLINT, '0', NULL);`|0|`NULL`|
|`DATEPART` that uses the microseconds or nanoseconds option, with the datetime data type.|Value is no longer truncated at the millisecond level before converting to micro- or nanoseconds.|`DECLARE @dt DATETIME = '01-01-1900 00:00:00.003';  SELECT DATEPART(MICROSECOND, @dt);`|3000|3333|
|`DATEDIFF` that uses the microseconds or nanoseconds option, with the datetime data type.|Value is no longer truncated at the millisecond level before converting to micro- or nanoseconds.|`DECLARE @d1 DATETIME = '1900-01-01 00:00:00.003' DECLARE @d2 DATETIME = '1900-01-01 00:00:00.007'  SELECT DATEDIFF(MICROSECOND, @d1, @d2)`|3000|3333|
|Comparison between datetime and datetime2 values with nonzero values for milliseconds.|Datetime value is no longer truncated at the millisecond level when you run a comparison with a datetime2 value. This means that certain values that previously compared equal, no longer compare equal.|`DECLARE @d1 DATETIME = '1900-01-01 00:00:00.003'  DECLARE @d2 DATETIME2(3) = @d1 SELECT CAST(@d1 AS datetime2(7)), @d2SELECT CASE WHEN (@d1=@d2) THEN 'equal' ELSE 'unequal' END`  |1900-01-01 00:00:00.0030000, 1900-01-01 00:00:00.003 equal|1900-01-01 00:00:00.0033333, 1900-01-01 00:00:00.003    unequal|
|`ROUND` function that uses the `float` data type.|Rounding results differ.|`SELECT ROUND(CAST (-0.4175 AS FLOAT), 3)`|-0.418|-0.417|

## Appendix B: Steps to verify and update persisted structures

We recommend that you determine whether the database has any persisted structures that are affected by the changes in compatibility level 130, and that you rebuild any affected structures.

This applies only to persisted structures that were created in the database on an older version of SQL Server or by using a compatibility level that's lower than 130. The persisted structures that are potentially affected include the following:

- Table data subject to `CHECK` constraints
- Persisted computed columns
- Indexes that use computed columns in the key or included columns
- Filtered indexes
- Indexed views

In this situation, run the following procedure.

Step 1: Verify database compatibility level

1. Check the compatibility level of your database by using the procedure that's documented in [View or change the compatibility level of a database](https://msdn.microsoft.com/library/bb933794.aspx).
1. If the database compatibility level is lower than 130, we recommend that you perform the validation that's outlined in Step 2 before you increase the compatibility level to 130.

Step 2: Identify affected persisted structures

Determine whether the database contains any persisted structures that are affected by the improved precision and conversion logic in compatibility level 130 in either of the following manners:

- `DBCC CHECKDB WITH EXTENDED_LOGICAL_CHECKS`, which validates all structures in the database.
- `DBCC CHECKTABLE WITH EXTENDED_LOGICAL_CHECKS`, which validates the structures related to a single table.

The option `WITH EXTENDED_LOGICAL_CHECKS` is required to make sure that the persisted values are compared with computed values, and to flag cases in which there's a difference. Because these checks are extensive, the runtime of `DBCC` statements that use this option is longer than running `DBCC` statements without the option. Therefore, the recommendation for large databases is to use `DBCC CHECKTABLE` to pinpoint individual tables.

`DBCC CHECKCONSTRAINTS` can be used to validate `CHECK` constraints. This statement can be used either at the database or the table level.

`DBCC CHECK` statements should always be run during a maintenance window, because of the potential impact of the checks on the online workload.

**Database-level validation**

Validation at the database level is suitable for small and moderately sized databases. Use table-level validation for large databases.

`DBCC CHECKDB WITH EXTENDED_LOGICAL_CHECKS` is used to validate all persisted structures in the database.

`DBCC CHECKCONSTRAINTS` is used to validate all `CHECK` constraints in the database.

`DBCC CHECKCONSTRAINTS` is used to validate the integrity of constraints. Use the following script to validate the database:

```sql
USE [database_name]
GO
DBCC TRACEON(139, -1)
GO
DBCC CHECKCONSTRAINTS
GO
DBCC TRACEOFF(139, -1)
GO
```

The use of the trace flag makes sure that the checks are performed by using the improved precision and conversion logic that's in compatibility level 130, forcing the correct conversion semantics even when the database has a lower compatibility level.

If the `CHECKCONSTRAINTS` statement is finished and doesn't return a resultset, no additional action is needed.

If the statement does return a resultset, each line in the results indicates a violation of a constraint, and it also includes the values that violate the constraint.

- Save the names of the tables and constraints, together with the values that caused the violated (the `WHERE` column in the resultset).

The following example shows a table with a `CHECK` constraint, and a single row that satisfies the constraint under lower compatibility levels but that violates the constraint under compatibility level 130.

```sql
ALTER DATABASE CURRENT SET COMPATIBILITY_LEVEL=120
GO
CREATE TABLE dbo.table1
(
    c2 datetime,
    c3 datetime,
    c4 int,
    CONSTRAINT chk1 CHECK (c4= (DATEDIFF (ms, c2,c3)))
)
GO
INSERT dbo.table1 (c2, c3, c4) VALUES
(
    convert(datetime, '1900-01-01 00:00:00.997'),
    convert(datetime, '1900-01-01 00:00:01'), 3
)
GO
DBCC TRACEON(139, -1)
GO
DBCC CHECKCONSTRAINTS
GO
DBCC TRACEOFF(139, -1)
GO
```

The `CHECKCONSTRAINT` command returns the following results.

|Table| Constraint |Where|
|--|---|---|
|[dbo].[table1]|[chk1]|[c2] = '1900-01-01 00:00:00.997' AND [c3] = '1900-01-01 00:00:01.000' AND [c4] = '3'|

This result indicates that the constraint [chk1] is violated for the combination of column values in the 'Where.'

**DBCC CHECKDB WITH EXTENDED_LOGICAL_CHECKS**

`DBCC CHECKDB WITH EXTENDED_LOGICAL_CHECKS` validates all persisted structures in the database. This is the most convenient option because a single statement validates all structures in the database. However, this option isn't suitable for large databases because of the expected run-time of the statement.

Use the following script to validate the whole database:

```sql
USE [database_name]
GO
DBCC TRACEON(139, -1)
GO
DBCC CHECKDB WITH EXTENDED_LOGICAL_CHECKS, NO_INFOMSGS, TABLERESULTS
GO
DBCC TRACEOFF(139, -1)
GO
```

The use of the trace flag makes sure that the checks are performed by using the improved precision and conversion logic that's in compatibility level 130, forcing the correct conversion semantics even when the database has a lower compatibility level.

If the `CHECKDB` statement is completed successfully, no additional action is needed.

If the statement is finished with errors, follow these steps:

1. Save the results from the execution of the `DBCC` statement, found in the messages pane in SQL Server Management Studio (SSMS), to a file.
2. Verify that any of the reported errors are related to persisted structures

Table 1: Persisted structures and corresponding error messages for inconsistencies

|Structure type affected |Error messages observed| Take note of|
|---|---|---|
|Persisted computed columns|Msg 2537, Level 16 Table error: object ID <object_id> , index ID <index_id> , . The record check (valid computed column) failed. The values are .|object ID <object_id> and index ID <index_id>|
|Indexes referencing computed columns in the key or included columns    Filtered indexes |Msg 8951   Table error: table '<table_name>' (ID <object_id>). Data row does not have a matching index row in the index '<index_name>' (ID <index_id>)   And/or    Msg 8952 Table error: table '<table_name>' (ID <table_name>). Index row in index '' (ID <index_id>) does not match any data row. In addition, there may be secondary errors 8955 and/or 8956. This contains details about the exact rows impacted. These may be disregarded for this exercise.|object ID <object_id> and index ID <index_id>|
|Indexed views|Msg 8908  The indexed view '<view_name>' (object ID <object_id>) does not contain all rows that the view definition produces.  And/or   Msg 8907  The indexed view '<view_name>' (object ID <object_id>) contains rows that were not produced by the view definition.| object ID <object_id>|

After you complete database-level validation, go to Step 3.

**Object-level validation**

For larger databases, it's helpful to validate structures and constraints on one table or one view at a time to reduce size of maintenance windows, or to limit the extended logical checks only to potentially affected objects.

Use the queries in the [Appendix C](#appendix-c-queries-to-identify-candidate-tables) section to identify potentially affected tables. The script in the [Appendix D](#appendix-d-script-to-create-check-statements) section can be used to generate `CHECKTABLE` and `CHECKCONSTRAINTS` constraints based on the queries listed in the [Appendix C](#appendix-c-queries-to-identify-candidate-tables) section.

**DBCC CHECKCONSTRAINTS**

To validate the constraints related to a single table or view, use the following script:

```sql
USE [database_name]

GO

DBCC TRACEON(139, -1)

GO

DBCC CHECKCONSTRAINTS()

GO

DBCC TRACEOFF(139, -1)

GO
```

The use of the trace flag makes sure that the checks are performed by using the improved precision and conversion logic that's in compatibility level 130, forcing the improved semantics even when the database has a lower compatibility level.

If the `CHECKCONSTRAINTS` statement is finished and doesn't return a resultset, no additional action is needed.

If the statement does return a resultset, each line in the results indicates a violation of a constraint, and also provides the values that violate the constraint.

Save the names of the tables and constraints, together with the values that caused the violated (the `WHERE` column in the resultset).

**DBCC CHECKTABLE WITH EXTENDED_LOGICAL_CHECKS**

To validate the persisted structures related to a single table or view use the following script:

```sql
USE [database_name]

GO

DBCC TRACEON(139, -1)

GO

DBCC CHECKTABLE() WITH EXTENDED_LOGICAL_CHECKS, NO_INFOMSGS, TABLERESULTS

GO

DBCC TRACEOFF(139, -1)

GO
```

If the `CHECKTABLE` statement is completed successfully, no additional action is needed.

If the statement is finished with errors, follow these steps:

1. Save the results from the execution of the `DBCC` statement, found in the messages pane in SSMS, to a file.
1. Verify that any of the reported errors are related to persisted structures as listed in Table 1.
1. After you complete table-level validation, go on to Step 3.

Step 3: Upgrade to compatibility level 130

If the compatibility level of the database is already 130, you can skip this step.

The compatibility level of the database can be changed to 130 by using the following script:

```sql
USE [database_name]

GO

ALTER DATABASE CURRENT SET COMPATIBILITY_LEVEL=130

GO
```

> [!NOTE]
> Because there are query optimizer changes under compatibility level 130, we recommend that you enable the query store before you change compatibility level. For more information, see the **Keep performance stability during upgrade to newer SQL Server** section in [Query Store Usage Scenarios](https://msdn.microsoft.com/library/mt614796.aspx#Anchor_3).

Step 4: Update persisted structures

If no inconsistencies were found during the validation performed in Step 2, you are done with the upgrade and can skip this step.
If inconsistencies were found in Step 2, additional actions are required to remove the inconsistencies from the database. The actions required depend on the kind of structure that's affected.

> [!IMPORTANT]
> Do the repair actions in this step only after the database compatibility level is changed to 130.

**Back up your database (or databases)**

We recommend that you take a full database backup before you perform any of the actions that the following section describes. If you use Azure SQL Database, you don't have to take a backup yourself; you can always use the point-in-time restore functionality to go back in time in case anything goes wrong with any of the updates.

**CHECK constraints**

Correcting `CHECK` constraint violations requires modification of either the data in the table or the `CHECK` constraint itself.

From the name of the constraint (obtained in Step 2), you can obtain the constraint definition as follows:

```sql
SELECT definition FROM sys.check_constraints

WHERE object_id= OBJECT_ID(N'constraint_name')
```

To inspect the table rows that are affected, you can use the Where information that was previously returned by the `DBCC CHECKCONSTRAINTS` statement:

```sql
SELECT *

FROM [schema_name].[table_name]

WHERE Where_clause
```

You have to either update the affected rows or change the constraint definition to make sure the constraint isn't violated.

**Updating table data**

There's no hard rule stating how the data should be updated. Generally, for each different Where statement returned by `DBCC CHECKCONSTRAINTS`, you will run the following update statement:

```sql
UPDATE [schema_name].[table_name] SET new_column_values

WHERE Where_clause
```

Consider the following example table with a constraint and a row that violates the constraint in compatibility level 130:

```sql
ALTER DATABASE CURRENT SET COMPATIBILITY_LEVEL=120
GO
CREATE TABLE dbo.table1
(
c2 datetime,
c3 datetime,
c4 int,
CONSTRAINT chk1 CHECK (c4= (DATEDIFF (ms, c2, c3)))
)
GO
INSERT dbo.table1 (c2, c3, c4) VALUES
(convert(datetime, '1900-01-01 00:00:00.997'),
convert(datetime, '1900-01-01 00:00:01'), 3)
GO
```

In this example, the constraint is straightforward. Column `c4` must be equal to an expression involving `c2` and `c3`. To update the table, assign this value to `c4`:

```sql
ALTER DATABASE CURRENT SET COMPATIBILITY_LEVEL=130
GO
UPDATE dbo.table1 SET c4 = datediff (ms, c2,c3)
WHERE [c2] = '1900-01-01 00:00:00.997' AND [c3] = '1900-01-01 00:00:01.000' AND [c4] = '3'
GO
```

Notice that the `WHERE` clause used in the update statement corresponds to the Where information returned by `DBCC CHECKCONSTRAINTS`.

**Updating CHECK constraint**

To change a `CHECK` constraint, you have to drop and re-create it. We recommend doing both in the same transaction, just in case there are any issues with the updated constraint definition. You can use the following Transact-SQL:

```sql
BEGIN TRANSACTION

ALTER TABLE [schema_name].[table_name]

DROP CONSTRAINT [constraint_name]

ALTER TABLE [schema_name].[table_name]

ADD CONSTRAINT [constraint_name]

CHECK (new_constraint_definition)

COMMIT

GO

The following example updates the constraint chk1 in dbo.table1:

BEGIN TRANSACTION

ALTER TABLE dbo.table1

DROP CONSTRAINT chk1

ALTER TABLE dbo.table1

ADD CONSTRAINT chk1

CHECK (c4 <= DATEDIFF (ms, c2, c3))

COMMIT

GO
```

**Persisted computed columns**

The easiest way to update persisted computed columns is to update one of the columns that's referenced by the computed column. The new value for the column can be the same as the old value, such that the operation doesn't change any user data.

Follow these steps for every `object_id` related to inconsistencies in computed columns that you noted in Step 2.

1. Identify computed columns:
   - Run the following query to retrieve the table name and the names of persisted computed columns for the noted `object_id`:

     ```sql
     SELECT QUOTENAME(s.name) + N'.' + QUOTENAME(t.name) AS 'table',
     QUOTENAME(c1.name) AS 'persisted computed column',
     c1.column_id AS 'computed_column_id' ,
     definition AS 'computed_column_definition'
     FROM sys.tables t
     JOIN sys.computed_columns c1 ON t.object_id=c1.object_id
     AND c1.is_persisted=1
     JOIN sys.schemas s ON t.schema_id=s.schema_id
     WHERE t.object_id=object_id
     ```

1. Identify referenced columns:
  
  - Run the following query to identify columns referenced by the computed column. Make note of one of the referenced column names:
  
    ```sql
    SELECT QUOTENAME(s.name) + N'.' + QUOTENAME(o.name) AS 'referencing object',
    o.type_desc AS 'object type', referenced_minor_id AS 'referenced_column_id', c.name AS 'referenced_column_name'
    FROM sys.sql_expression_dependencies sed
    JOIN sys.computed_columns c1 ON sed.referencing_id=c1.object_id AND sed.referencing_minor_id=c1.column_id
    JOIN sys.objects o ON sed.referencing_id=o.object_id
    JOIN sys.schemas s ON o.schema_id=s.schema_id
    JOIN sys.columns c ON o.object_id=c.object_id AND sed.referenced_minor_id=c.column_id
    WHERE referencing_class=1 AND referenced_class=1 AND referencing_id=object_id AND referencing_minor_id=computed_column_id
    ```

1. Run an `UPDATE` statement involving one of the referenced columns to trigger an update of the computed column:
   - The following statement will trigger an update of the column that's referenced by the computed column and also trigger an update of the computed column.

      ```sql
      UPDATE [schema_name].[table_name]
      SET referenced_column_name=ISNULL(referenced_column_name, referenced_column_name)
      ```

   - The `ISNULL` expression in the statement is crafted in such a way that the value of the original column isn't changed, while still making sure that the computed column is updated by using DB compatibility level 130 expression evaluation logic.

   - Be aware that for very large tables, you may not want to update all rows in a single transaction. In such a case, that you can run the update in batches by adding a `WHERE` clause to the update statement that identifies a range of rows; based on the primary key, for example.

1. Identify indexes referencing the computed column.

    ```sql
    SELECT i.name AS [index name]
    FROM sys.index_columns ic JOIN sys.indexes i ON ic.object_id=i.object_id AND ic.index_id=i.index_id
    WHERE i.object_id=object_id AND ic.column_id=computed_column_id
    ```

This query identifies any indexes that reference the persisted computed column. Any such index has to be rebuilt. To do this, follow the steps in the following section.

**Indexes, filtered indexes, and indexed views**

Inconsistencies in indexes correspond to errors 8951 and 8952 (for tables) or 8907 and 8908 (for views) in the `DBCC CHECK` output from Step 2.

To repair these inconsistencies, run `DBCC CHECKTABLE` with `REPAIR_REBUILD`. This will repair the indexes structures without any data loss. However, the database must be in single-user mode and is therefore unavailable to other users while repair is occurring.

You can also manually rebuild affected indexes. This option should be used if the workload can't be taken offline, because index rebuild can be performed as an ONLINE operation (in supported editions of SQL Server).

**Rebuild indexes**

If setting the database in single-user mode isn't an option, you can individually rebuild indexes by using `ALTER INDEX REBUILD`, for each index identified in Step 2.

Use the following query to obtain the table and index names for a given `object_id` and `index_id`.

```sql
SELECT QUOTENAME(SCHEMA_NAME(o.schema_id)) + N'.' + QUOTENAME(o.name) AS 'table', i.name AS 'index_name'

FROM sys.objects o JOIN sys.indexes i ON o.object_id=i.object_id

WHERE o.object_id = object_id AND i.index_id = index_id
```

Use the following statement to rebuild the index:

```sql
ALTER INDEX index_name ON [schema_name].[table_name] REBUILD WITH (ONLINE=ON)
```

> [!NOTE]
> If you're using Standard, Web, or Express editions, online index build isn't supported. Therefore, the option `WITH (ONLINE=ON)` must be removed from the `ALTER INDEX` statement.

The following example shows rebuild of a filtered index:

```sql
ALTER DATABASE CURRENT SET COMPATIBILITY_LEVEL=120
GO
CREATE TABLE dbo.table2
(
    c2 datetime,
    c3 float
)
GO
INSERT dbo.table2 (c2,c3) VALUES ('1899-12-31 23:58:00.470', -0.00138344907407406)
GO
CREATE INDEX ix_1 ON dbo.table2(c2)
WHERE (c2=-0.00138344907407406)
GO
ALTER DATABASE CURRENT SET COMPATIBILITY_LEVEL=130GOALTER INDEX ix_1 ON [dbo].[table2] REBUILD WITH (ONLINE=ON)
GO
```

If you have regular maintenance plans, we recommend that you include this index rebuild as part of your scheduled maintenance.

**Repair by using DBCC**

For each (object_id) related to an index with inconsistencies that you noted in Step 2, run the following script to perform the repair. This script sets the database in single-user mode for the repair operation. In the worst case, the repair performs a full index rebuild.

```sql
USE [database_name]

GO

ALTER DATABASE CURRENT SET SINGLE_USER WITH ROLLBACK IMMEDIATE

GO

DBCC CHECKTABLE (object_id, REPAIR_REBUILD) WITH EXTENDED_LOGICAL_CHECKS, NO_INFOMSGS, TABLERESULTS

GO

ALTER DATABASE CURRENT SET MULTI_USER

GO
```

## Appendix C: Queries to identify candidate tables

The following scripts identify candidate tables that you may want to validate by using `DBCC CHECKTABLE WITH EXTENDED_LOGICAL_CHECKS`, based on the existence of persisted structures and constraints that use data types affected by the improvements in compatibility level 130.

The following set of queries list details about the tables and potentially affected structures that require additional validation.

**Indexed views**

The following query returns all indexed views referencing columns by using affected data types, or by using any of the affected built-in functions:

```sql
SELECT QUOTENAME(SCHEMA_NAME(o.schema_id)) + N'.' + QUOTENAME(o.name) AS 'view', QUOTENAME(i.name) AS 'index',QUOTENAME(sed.referenced_schema_name) + N'.' + QUOTENAME(sed.referenced_entity_name) AS 'referenced table', QUOTENAME(c.name) AS 'referenced column', t.name AS 'data type',

-- if the data type is numeric, integer, or money, the only cases that warrent additional checks

-- with DBCC is if the view definition contains a float or datetime value, or a conversion to such value

s.definition

FROM sys.sql_expression_dependencies sed

JOIN sys.objects o ON sed.referencing_id = o.object_id AND o.type=N'V'

JOIN sys.indexes i ON o.object_id=i.object_id

JOIN sys.sql_modules s ON s.object_id=o.object_id

JOIN sys.columns c ON sed.referenced_id=c.object_id AND sed.referenced_minor_id=c.column_idJOIN sys.types t ON c.system_type_id=t.system_type_id

WHERE referencing_class=1 AND referenced_class=1 AND (c.system_type_id IN

( 59 --real

, 62 --float

, 58 --smalldatetime

, 61 --datetime

, 60 --money

, 122 --smallmoney

, 106 --decimal

, 108 --numeric

, 56 --int

, 48 --tinyint

, 52 -- smallint

, 41 --time

, 127 --bigint

) OR s.[definition] LIKE '%DATEDIFF%'

OR s.[definition] LIKE '%CONVERT%'

OR s.[definition] LIKE '%CAST%'

OR s.[definition] LIKE '%DATEPART%'

OR s.[definition] LIKE '%DEGREES%')
```

**Persisted computed columns**

The following query returns all tables with computed columns referencing other columns by using affected data types, or by using any of the affected built-in functions, where either the column is persisted or referenced from an index.

```sql
SELECT QUOTENAME(sed.referenced_schema_name) + N'.' +

QUOTENAME(sed.referenced_entity_name) AS 'candidate table with computed column',

QUOTENAME(c1.name) AS 'computed column', c1.is_persisted,QUOTENAME(c2.name) AS 'referenced column', t.name AS 'data type',

-- if the data type is numeric, integer, or money, the only cases that warrent additional checks

-- with DBCC is if the column definition contains a float or datetime value, or a conversion to such value

c1.definition

FROM sys.sql_expression_dependencies sed

JOIN sys.computed_columns c1 ON sed.referencing_id=c1.object_id AND sed.referencing_minor_id=c1.column_id

JOIN sys.columns c2 ON sed.referenced_id=c2.object_id AND sed.referenced_minor_id=c2.column_id

JOIN sys.types t ON c2.system_type_id=t.system_type_idWHERE referencing_class=1 AND referenced_class=1

AND (c2.system_type_id IN

( 59 --real

, 62 --float

, 58 --smalldatetime

, 61 --datetime

, 60 --money

, 122 --smallmoney

, 106 --decimal

, 108 --numeric

, 56 --int

, 48 --tinyint

, 52 -- smallint

, 41 --time

, 127 --bigint

) OR c1.[definition] LIKE '%DATEDIFF%'

OR c1.[definition] LIKE '%CONVERT%'

OR c1.[definition] LIKE '%DATEPART%'

OR c1.[definition] LIKE '%DEGREES%')

AND (

-- the column is persisted

c1.is_persisted=1

-- OR the column is included in an index

OR EXISTS (SELECT 1 FROM sys.index_columns ic WHERE ic.object_id=c1.object_id AND ic.column_id=c1.column_id)

)

```

**Filtered indexes**

The following query returns all tables with filtered indexes that reference columns in the filter condition that have affected data types:

```sql
SELECT QUOTENAME(sed.referenced_schema_name) + N'.' +

QUOTENAME(sed.referenced_entity_name) AS 'candidate table with filtered index',

QUOTENAME(i.name) AS 'referencing index',

QUOTENAME(c.name) AS 'referenced column',

t.name AS 'data type',

-- if the data type is numeric, integer, or money, the only cases that warrent additional checks

-- with DBCC is where the filter condition contains a float or datetime value

i.filter_definition AS 'filter condition'

FROM sys.sql_expression_dependencies sed

JOIN sys.indexes i ON sed.referencing_id=i.object_id AND sed.referencing_minor_id=i.index_id

JOIN sys.columns c ON sed.referenced_id=c.object_id AND sed.referenced_minor_id=c.column_id

JOIN sys.types t ON c.system_type_id=t.system_type_id

WHERE referencing_class=7 AND referenced_class=1 AND i.has_filter=1

AND c.system_type_id IN ( 59 --real

, 62 --float

, 58 --smalldatetime

, 61 --datetime

, 60 --money

, 122 --smallmoney

, 106 --decimal

, 108 --numeric

, 56 --int

, 48 --tinyint

, 52 -- smallint

, 41 --time

, 127 --bigint

)
```

**Check constraints**

The following query lists all tables with check constraints that reference affected data types or built-in functions:

```sql
SELECT QUOTENAME(sed.referenced_schema_name) + N'.' +

QUOTENAME(sed.referenced_entity_name) AS 'candidate table with check constraint',

QUOTENAME(c.name) AS 'constraint_name', c.definition AS 'constraint_definition',

QUOTENAME(col.name) AS 'referenced column', t.name AS 'data type'

FROM sys.sql_expression_dependencies sed

JOIN sys.check_constraints c ON sed.referencing_id=c.object_id AND sed.referencing_class=1

JOIN sys.columns col ON sed.referenced_id=col.object_id AND sed.referenced_minor_id=col.column_id

JOIN sys.types t ON col.system_type_id=t.system_type_id

WHERE referencing_class=1 AND referenced_class=1 AND (col.system_type_id IN

( 59 --real

, 62 --float

, 58 --smalldatetime

, 61 --datetime

, 60 --money

, 122 --smallmoney

, 106 --decimal

, 108 --numeric

, 56 --int

, 48 --tinyint

, 52 -- smallint

, 41 --time

, 127 --bigint)

OR c.[definition] LIKE '%DATEDIFF%'

OR c.[definition] LIKE '%CONVERT%'

OR c.[definition] LIKE '%DATEPART%'

OR c.[definition] LIKE '%DEGREES%')
```

## Appendix D: Script to create CHECK* statements

The following script combines the queries from the previous appendix and simplifies the results by presenting a list of tables and views in the form of `CHECKCONSTRAINTS` and `CHECKTABLE` statements.

```sql
DECLARE @CRLF nvarchar(10) = CHAR(13) + CHAR(10);
DECLARE @sql nvarchar(max) = N'DBCC TRACEON(139,-1); ' + @CRLF ;

SELECT @sql += N'DBCC CHECKTABLE (N''' + object_for_checktable + N''') WITH EXTENDED_LOGICAL_CHECKS, NO_INFOMSGS, TABLERESULTS; ' + @CRLF
FROM
(

--indexed views
SELECT DISTINCT QUOTENAME(SCHEMA_NAME(o.schema_id)) + N'.' + QUOTENAME(o.name) AS 'object_for_checktable'
FROM sys.sql_expression_dependencies AS sed
 INNER JOIN sys.objects AS o ON sed.referencing_id = o.object_id AND o.type = N'V'
 INNER JOIN sys.indexes AS i ON o.object_id = i.object_id
 INNER JOIN sys.sql_modules AS s ON s.object_id = o.object_id
 INNER JOIN sys.columns AS c ON sed.referenced_id = c.object_id AND sed.referenced_minor_id = c.column_id
 INNER JOIN sys.types AS t ON c.system_type_id = t.system_type_id

WHERE referencing_class = 1 AND referenced_class=1 
 AND (c.system_type_id IN 
( 59 --real
 , 62 --float
 , 58 --smalldatetime
 , 61 --datetime
 , 60 --money
 , 122 --smallmoney
 , 106 --decimal
 , 108 --numeric
 , 56 --int
 , 48 --tinyint
 , 52 -- smallint
 , 41 --time
 , 127 --bigint
) OR s.[definition] LIKE N'%DATEDIFF%'
 OR s.[definition] LIKE N'%CONVERT%'
 OR s.[definition] LIKE N'%CAST%'
 OR s.[definition] LIKE N'%DATEPART%'
 OR s.[definition] LIKE N'%DEGREES%')

UNION

--persisted computed columns
SELECT DISTINCT QUOTENAME(sed.referenced_schema_name) + N'.' + QUOTENAME(sed.referenced_entity_name) AS 'object_for_checktable'
FROM sys.sql_expression_dependencies AS sed
INNER JOIN sys.computed_columns AS c1 ON sed.referencing_id = c1.object_id AND sed.referencing_minor_id = c1.column_id
INNER JOIN sys.columns AS c2 ON sed.referenced_id=c2.object_id AND sed.referenced_minor_id = c2.column_id
INNER JOIN sys.types AS t ON c2.system_type_id = t.system_type_id
WHERE referencing_class = 1 AND referenced_class = 1 
 AND (c2.system_type_id IN
( 59 --real
 , 62 --float
 , 58 --smalldatetime
 , 61 --datetime
 , 60 --money
 , 122 --smallmoney
 , 106 --decimal
 , 108 --numeric
 , 56 --int
 , 48 --tinyint
 , 52 -- smallint
 , 41 --time
 , 127 --bigint
) OR c1.[definition] LIKE N'%DATEDIFF%'
 OR c1.[definition] LIKE N'%CONVERT%'
 OR c1.[definition] LIKE N'%DATEPART%'
 OR c1.[definition] LIKE N'%DEGREES%')
AND (
-- the column is persisted
c1.is_persisted = 1 
-- OR the column is included in an index
OR EXISTS (SELECT 1 FROM sys.index_columns AS ic 
WHERE ic.object_id = c1.object_id AND ic.column_id=c1.column_id)
)

UNION

--indexed views
SELECT DISTINCT QUOTENAME(sed.referenced_schema_name) + N'.' + QUOTENAME(sed.referenced_entity_name) AS 'object_for_checktable'
FROM sys.sql_expression_dependencies AS sed 
INNER JOIN sys.indexes AS i ON sed.referencing_id = i.object_id AND sed.referencing_minor_id = i.index_id
INNER JOIN sys.columns AS c ON sed.referenced_id = c.object_id AND sed.referenced_minor_id = c.column_id 
INNER JOIN sys.types AS t ON c.system_type_id = t.system_type_id
WHERE referencing_class = 7 AND referenced_class = 1 AND i.has_filter = 1
AND c.system_type_id IN ( 
 59 --real
 , 62 --float
 , 58 --smalldatetime
 , 61 --datetime
 , 60 --money
 , 122 --smallmoney
 , 106 --decimal
 , 108 --numeric
 , 56 --int
 , 48 --tinyint
 , 52 -- smallint
 , 41 --time
 , 127 --bigint
)) AS a

SELECT @sql += N'DBCC CHECKCONSTRAINTS (N''' + object_for_checkconstraints + N'''); ' + @CRLF
FROM
(

SELECT DISTINCT QUOTENAME(sed.referenced_schema_name) + N'.' + QUOTENAME(sed.referenced_entity_name) AS 'object_for_checkconstraints'
FROM sys.sql_expression_dependencies AS sed 
INNER JOIN sys.check_constraints AS c ON sed.referencing_id = c.object_id AND sed.referencing_class = 1
INNER JOIN sys.columns AS col ON sed.referenced_id = col.object_id AND sed.referenced_minor_id = col.column_id
INNER JOIN sys.types AS t ON col.system_type_id = t.system_type_id
WHERE referencing_class = 1 AND referenced_class = 1 AND (col.system_type_id IN 
( 59 --real
 , 62 --float
 , 58 --smalldatetime
 , 61 --datetime
 , 60 --money
 , 122 --smallmoney
 , 106 --decimal
 , 108 --numeric
 , 56 --int
 , 48 --tinyint
 , 52 -- smallint
 , 41 --time
 , 127 --bigint
) OR c.[definition] LIKE N'%DATEDIFF%'
 OR c.[definition] LIKE N'%CONVERT%'
 OR c.[definition] LIKE N'%DATEPART%'
 OR c.[definition] LIKE N'%DEGREES%')
) a

SET @sql += N'DBCC TRACEOFF(139,-1);';

PRINT @sql;

--to run the script immediately, use the following command:
--EXECUTE sp_executesql @sql;
GO
```
