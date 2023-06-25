---
title: Can't correctly translate character data
description: This article helps you work around a problem that causes incorrect translation of client data when using SQL Server ODBC driver.
ms.date: 11/03/2020
ms.custom: sap:MDAC and ADO
ms.reviewer: bartd, rajeevp
---
# You can't correctly translate character data from a client to a server by using the SQL Server ODBC driver if the client code page differs from the server code page

This article helps you work around a problem that causes incorrect translation of client data when using SQL Server ODBC driver.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 234748

## Symptoms

When using the MDAC 2.1 or later version of the SQL Server ODBC driver (version 3.70.0623 or later) or the OLEDB provider (version 7.01.0623 or later), under some circumstances you may experience translation of character data from the client code page to the server code page, even when `Autotranslation` is disabled for the connection.

## Cause

`Autotranslation` is not the only mechanism that can result in code page conversion. The SQL Server 7.0 ODBC driver and OLEDB provider introduce a new behavior when connecting to MSDE 1.0, SQL Server 7.0, or later versions of either. All SQL statements sent as a language event are converted to Unicode on the client before being sent to the server. The end effect is similar to an `Autotranslation` of all data flowing from the client to the server through a language event, regardless of the current `Autotranslation` setting for the connection. It will not introduce any difficulties except when trying to store non-translated character data from a code page other than SQL Server's code page.

## Workaround

Do not store code page X data in a code page Y SQL Server (for example, code page 950 data in a code page 1252 server). While this was possible in some circumstances with previous versions of SQL Server, it has always been unsupported. To a 1252 SQL Server, anything but a 1252 character is not valid character data. Non-Unicode character data from a different code page will not be sorted correctly, and in the case of dual-byte (DBCS) data, SQL Server will not recognize character boundaries correctly. It can cause significant problems.

The best choice for the SQL Server's code page is the code page of the clients that will be accessing the server.

The server and client may have different code pages, but you must ensure that Autotranslation is enabled on the client so that you get proper translation of data to and from the server's code page in all cases.

If your server must store data from multiple code pages, the supported solution is to store the data in Unicode columns (`NCHAR/NVARCHAR/NTEXT`).

If your situation requires that you store code page X data in a code page Y SQL Server, there are only two ways to do this reliably:

- Store the data in binary columns (`BINARY/VARBINARY/IMAGE`) columns.
- Write your application to use Remote Procedure Calls (RPCs) for all SQL statements that deal with character data. Data sent through an RPC event is not subject to the conversion. There is nothing at the driver or DSN level that you can do to change the type of events being sent. Whether a command is sent as a language or RPC event depends entirely on the APIs and syntax chosen by the programmer when the application is written.

## More information

Autotranslation (that is, the **Perform Translation for character data** checkboxes in newer ODBC applications) converts character data from the client code page to the server code page before sending the data to the server, using Unicode as a translation medium. However, the 3.7 SQL Server ODBC driver also converts all SQL statements sent as a language event to Unicode before placing them on the wire, which has an effect that is similar to Autotranslation but is not governed by the Autotranslation setting. In contrast, character data flowing from the server back to the clients respect the Autotranslation flag; if Autotranslation is turned off the data arrives at the client application with the same character codes as the data had on the server. Similarly, translation of data for client-to-server RPC events can be disabled by turning off Autotranslation. A simple script that demonstrates how the behavior affects language events follows. This example was run from Query Analyzer on a code page 1252 client connecting to a code page 437 server:

```sql
-- Turn Autotranslation off here.
 USE tempdb
 GO
 CREATE TABLE t1 (c1 int, c2 char(1))
 GO

-- Enter a yen character, using the keystroke ALT-0165.
 INSERT INTO t1 VALUES (1, '¥') 
 SELECT c1, c2, ASCII (c2) FROM t1
```

```console
c1 c2 
 ----------- ---- ----------- 
 1  157

(1 row(s) affected)
```

The following about the preceding example:

- Even though `Autotranslation` was off during this batch, the character code 165 (yen in code page 1252) was converted to 157 (yen in code page 437). This is because the ODBC driver converted the SQL string to Unicode before sending it the server, so the server was able to convert it to the appropriate character for storage in code page 437.
- When the client ran a SELECT to retrieve the data that had been stored, the character 157 arrived non-translated at the client (157 shows up as a box '' on a code page 1252 client). This is because the conversion discussed in this article only applies to data sent from the client to the server, not from the server to the client. The data was not translated because the `Autotranslation` setting is off.

```sql
-- Turn Autotranslation back on before running the following batch.
 INSERT INTO t1 VALUES (2, '¥')
 SELECT c1, c2, ASCII (c2) FROM t1
```

```console
c1 c2 
 ----------- ---- ----------- 
 1 ¥ 157
 2 ¥ 157

(2 row(s) affected)
```

In this case, turning `Autotranslation` back on had no effect on the translation from the client to the server (that is, the same correct translation from character code 165 to character code 157 happened), but it did have an effect on the data retrieved from the server. When the SELECT statement is run this time (with `Autotranslation` on), the yen symbols display correctly in the code page 1252 application because they have been translated from character code 157 back to character code 165 by the `Autotranslation` mechanism.

You will see this behavior (conversion of language events to Unicode on the client) when using any SQL Server ODBC driver version 3.70 or later and connecting to SQL Server 7.0 or later. It will not occur when using older ODBC drivers, or when using the 3.7 driver to connect to SQL Server 6.5 or earlier. In addition, if you are storing your data in Unicode columns (`NCHAR/NVARCHAR/NTEXT`) the conversion will not be an issue.

For more information about how character data is represented in SQL Server 2005, see [Character data is represented incorrectly when the code page of the client computer differs from the code page of the database in SQL Server 2005](https://support.microsoft.com/help/904803).
