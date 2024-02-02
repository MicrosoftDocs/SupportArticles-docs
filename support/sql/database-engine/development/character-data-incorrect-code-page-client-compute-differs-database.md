---
title: Character data is incorrect when the code page differs
description: Provides workarounds for problems that character data is represented incorrectly when the code page of the client computer differs from the code page of the database.
ms.date: 07/07/2023
ms.custom: sap:Database Design and Development
ms.reviewer: aartigoyle, jopilov, v-sidong
---
# Character data is represented incorrectly when the client computer's code page differs from the database's

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 904803

## Symptoms

Consider the following scenario:

- You use SQL Server Management Studio to query character data from a SQL Server database that uses a non-Unicode data type. For example, the SQL Server database uses the `char`, `varchar`, or `text` data type.

- The code page of the client computer differs from the code page of the database. The code page is associated with the collation of the database.

In this scenario, character data is represented incorrectly.

For example, you may experience one of the following problems:

- The character data is represented as a question mark (`?`). You may see this problem if you insert or update the character data as a non-Unicode data type before you query the character data. This problem occurs if you make this change by using SQL Server Management Studio on a client computer that has a different code page.

- The character data is represented as corrupted data. The character data of code page X is stored in a non-Unicode column of code page Y. Additionally, the character data isn't translated. This problem occurs when you query the character data by using SQL Server Management Studio.

  > [!NOTE]
  > When you query the character data by using SQL Server Management Studio, the character data is represented correctly if the **Perform translation for character data** setting (also known as the `Auto Translate` parameter) is disabled. The `Auto Translate` parameter is a parameter of the `ConnectionString` property for Microsoft OLE DB Provider for SQL Server and for Microsoft .NET Framework Data Provider for OLE DB.

## Cause

This problem occurs because the character data of code page X is stored in a non-Unicode column of code page Y, which is unsupported.

In SQL Server, when you use a string literal of a non-Unicode data type, the string literal is converted by using the database's default code page that's derived from the database's collation. Storing the character data of code page X in a column of code page Y may cause data loss or data corruption.

If the character data is represented as corrupted data, the data can only be correctly represented if you disable the `Auto Translate` parameter for Microsoft OLE DB Provider for SQL Server or Microsoft .NET Framework Data Provider for OLE DB.

> [!NOTE]
> SQL Server Management Studio uses Microsoft .NET Framework Data Provider for SQL Server to connect to the SQL Server database. This data provider doesn't support the `Auto Translate` parameter.

## Workaround

To work around this problem, use one of the following methods:

### Method 1: Use a Unicode data type instead of a non-Unicode data type

Change the columns to a Unicode data type to avoid all the problems caused by code page translation. For example, use the `nchar`, `nvarchar`, or `ntext` data type.

### Method 2: Use an appropriate collation for the database

If you must use a non-Unicode data type, always make sure that the code page of the database and the code page of any non-Unicode columns can store the non-Unicode data correctly. For example, if you want to store code page 949 (Korean) character data, use a Korean collation for the database. For example, use the `Korean_Wansung_CI_AS` collation for the database.

### Method 3: Use the "binary" or "varbinary" data type

If you want the database to directly store and retrieve the exact byte values of the characters that are handled without trying to perform appropriate code page translation, use the `binary` or `varbinary` data type.

### Method 4: Use a different tool to store and retrieve data and disable the "Auto Translate" parameter

> [!WARNING]
> We don't test or support storing the character data of code page X in a column of code page Y. This operation may cause linguistically incorrect query results, incorrect string matching or ordering, and unexpected code page translation (data corruption). We encourage you to use one of the other methods to work around this problem.

When you use Microsoft OLE DB Provider for SQL Server to connect to a database that has a different code page and you try to query character data from a non-Unicode data type column, make sure that you store the untranslated characters in the database.

> [!NOTE]
> The following example assumes that the code page of the client computer is Korean (CP949) and that the code page of the SQL Server database is English (CP1252). You must replace the placeholders in the code examples with values that are appropriate for your situation.

To work around this problem, follow these steps:

1. Manually convert the characters to raw data, and then insert the data into the database by using the code page of the database. To do this operation, use a code snippet that is similar to the following one:

   ```csharp
   string strsrc="가";string strsrc="가";
   string strtag=Encoding.GetEncoding(1252).GetString(Encoding.GetEncoding(949).GetBytes (strsrc));
   sql="insert into <tablename> (<column>,) values ('" + strtag + "')";
   // code for updating the database;
   ```

1. When you want to query the data, use Microsoft OLE DB Provider for SQL Server or Microsoft .NET Framework Data Provider for SQL Server to connect to the database, and then set the `Auto Translate` parameter to `False`. To do this operation, use a code snippet that's similar to the following one:

   ```csharp
   OleDbConnection conn=new OleDbConnection("Provider=SQLOLEDB;" +
   " Initial Catalog =<yourdatabase>;"+
   "User id=<youruserid>; Password=<yourpassword>;"+
   "Auto Translate=False");
   // code for representing the character data;
   ```

## More information

To reproduce the problem, follow these steps:

1. On the client computer that has Korean (CP949) as the default code page, start SQL Server Management Studio.

1. Connect to a database that has English (CP1252) as the default code page.

1. Create a table in the database by using the following query:

   ```sql
   CREATE TABLE tbTest (A char(20), NA nchar(10), Comment char(20))
   ```

1. Insert a Korean character into the database by using the following query:

   ```sql
   INSERT INTO tbTest (A,NA,Comment) VALUES('가',N'가','SQLServer/INSERT')
   ```

1. Create a select query to retrieve the data by using the following query:

   ```sql
   SELECT * FROM tbTest
   ```

You receive the following results. The value in column A is a question mark.

```output

A                    NA         Comment
-------------------- ---------- --------------------
?                    가          SQLServer/INSERT
```

## References

- [You can't correctly translate character data from a client to a server by using the SQL Server ODBC driver if the client code page differs from the server code page](../../connect/cannot-correctly-translate-character-data.md)

- [SQL Native Client Auto Translate](/sql/relational-databases/native-client/applications/using-connection-string-keywords-with-sql-server-native-client)

- [SQL OLEDB provider Auto Translate](/sql/ado/guide/appendixes/microsoft-ole-db-provider-for-sql-server)
