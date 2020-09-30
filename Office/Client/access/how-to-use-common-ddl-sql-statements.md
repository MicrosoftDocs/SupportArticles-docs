---
title: How to use common Data Definition Language (DDL) SQL statements for the Jet database engine
description: Describes how to use common DDL (Data Definition Language) SQL statements with the MFC database classes to work with an Access database in Visual C++.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Access for Office 365
- Access 2019
- Access 2016
- Access 2013
- Access 2010
- Access 2007
- Access 2003
ms.reviewer: mattn, johnya
---
# How to use common Data Definition Language (DDL) SQL statements for the Jet database engine

_Original KB number:_ &nbsp; 180841

## Summary

This article demonstrates some common DDL (Data Definition Language) SQL statements for the Microsoft Jet database engine.

## More information

Microsoft Jet provides a full set of Data Definition Language SQL statements, which can be used to create, modify, and delete tables, indexes, and relationships in a Microsoft Access database file. You can use this DDL with the MFC database classes to manipulate an Access database. This article lists some common examples of this category of SQL statements.

You can execute a single DDL statement in this article using the following syntax with the MFC DAO classes:

```c++
// Open database file.
CDaoDatabase db;
db.Open(_T("C:\\MyDatabase.mdb"));

// Set strSQL to desired DDL statement.
CString strSQL;
strSQL = _T("CREATE TABLE Simple (ID long)");

// Execute DDL statement.
try {
  db.Execute(strSQL, dbFailOnError);
} catch (CDaoException * e) {
  // Display errors (simple example).
  AfxMessageBox(e -> m_pErrorInfo -> m_strDescription,
    MB_ICONEXCLAMATION);
  e -> Delete();
}
```

You can execute the DDL statements in this article using the following syntax with the MFC ODBC classes:

```c++
// Open database file.
CDatabase db;
db.OpenEx(_T("DSN=MyAccessDB"), CDatabase::noOdbcDialog);

// Set strSQL to desired DDL statement.
CString strSQL;
strSQL = _T("CREATE TABLE Simple (ID long)");

// Execute DDL statement.
try {
  db.ExecuteSQL(strSQL);
} catch (CDBException * e) {
  // Display errors (simple example).
  AfxMessageBox(e -> m_strError,
    MB_ICONEXCLAMATION);
  e -> Delete();
}
```

### The CREATE TABLE DDL Statement

The following create table statement creates a test table with all of the DDL available to Microsoft Access data types:

```sql
CREATE TABLE TestAllTypes ( MyText TEXT(50), MyMemo MEMO, MyByte BYTE, MyInteger INTEGER, MyLong LONG, MyAutoNumber COUNTER, MySingle SINGLE, MyDouble DOUBLE, MyCurrency CURRENCY, MyReplicaID GUID, MyDateTime DATETIME, MyYesNo YESNO, MyOleObject LONGBINARY, MyBinary BINARY(50))
```

> [!NOTE]
> You cannot create "AutoNumber Replication," "HyperLink," or "Lookup" type fields using a Microsoft Access DDL SQL statement. These field types are not native Jet field types and can be created and used only by the Microsoft Access user interface. The MyBinary field above is a special fixed-length binary field, which cannot be created via the Microsoft Access user interface but can be created using a SQL DDL statement.

You can create a table with a single-field primary key with a single DDL statement. The following statement creates a table named TestPrimaryKey with a primary key on the MyID field named PK_MyID:

```sql
CREATE TABLE TestPrimaryKey ( MyID LONG CONSTRAINT PK_MyID PRIMARY KEY, FirstName TEXT(20), LastName TEXT(20))
```

### The ALTER TABLE DDL Statement

Microsoft Access DDL supports the ALTER TABLE DDL statement. This statement is useful when you need to remove or add a field to an existing table.

> [!NOTE]
> This statement won't let you alter an existing field in an Access table (for example, to change the field's data type).

The following DDL removes the column named MoreInfo from the table TooManyFields:

```sql
ALTER TABLE TooManyFields DROP COLUMN MoreInfo
```

The following DDL statement adds a column named ExtraInfo to a table named NotEnoughFields:

```sql
ALTER TABLE NotEnoughFields ADD COLUMN ExtraInfo Text(255)
```

The ALTER TABLE statement can also be used to create a relationship between two tables.

The following SQL statement creates two tables (Cars and Colors) and then creates a relationship between the Cars table and the Colors table on the ColorID field (each car can have only one color).

> [!NOTE]
> There are three separate DDL statements, which must be executed one at a time:

```sql
CREATE TABLE Cars ( CarID LONG, CarName TEXT(50), ColorID LONG ) CREATE TABLE Colors ( ColorID LONG CONSTRAINT PK_Colors PRIMARY KEY, ColorName TEXT(50)) ALTER TABLE Cars ADD CONSTRAINT MyColorIDRelationship FOREIGN KEY (ColorID) REFERENCES Colors (ColorID)
```

> [!NOTE]
> You cannot specify that you want "Cascade Updates" or "Cascade Deletes" with a relationship created using DDL. These features are available only when using the Microsoft DAO (Data Access Objects) interfaces via code or when using the Microsoft Access user interface.

### The CREATE INDEX DDL Statement

The CREATE INDEX DDL statement is used to create additional indexes on an existing table.

The following DDL statement adds a single-field, non-unique, ascending index named MyStateIndex to the field State in the table Addresses:

```sql
CREATE INDEX MyStateIndex
ON Addresses ( State ASC )
```

The following DDL statement adds a two-field, unique, ascending index named MyFullNameIndex to the fields FirstName and LastName in the table Addresses:

```sql
CREATE UNIQUE INDEX MyFullNameIndex
ON Addresses ( FirstName ASC, LastName ASC )
```

You can also specify an additional constraint of DISALLOW NULL using the CREATE TABLE DDL statement. Specifying DISALLOW NULL means that the index will prevent the insertion of fields with null values into any of the columns in the index.

The following DDL statement creates a single-field, unique, descending index named MySalaryIndex on the field Salary in the table HRInfo:

```sql
CREATE UNIQUE INDEX MySalaryIndex
ON HRInfo ( Salary DESC ) WITH DISALLOW NULL
```

This index enforces that every record must have a value for the Salary field.

### The DROP DDL Statement

The DROP DDL statement is used to delete existing tables or indexes.

The following DDL statement permanently deletes the table named TempTable:

```sql
DROP TABLE TempTable
```

The following DDL statement permanently deletes the index named MyUnusedIndex on the table OverIndexedTable:

```sql
DROP INDEX MyUnusedIndex ON OverIndexedTable
```

## References

For more information about the Microsoft Jet DDL syntax, see the "Microsoft Jet Database Engine Programmer's Guide, Second Edition," Chapter 3, "Data Definition and Integrity."
