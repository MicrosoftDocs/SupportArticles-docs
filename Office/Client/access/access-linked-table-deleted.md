---
title: Access linked table to SQL Server database returns Deleted
description: Describes an issue in which an Access linked table that's connected to a SQL Server database returns.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Access for Microsoft 365
  - Access LTSC 2021
  - Access 2019
  - Access 2016
  - Access 2013
ms.date: 03/31/2022
---

# Access linked table to SQL Server database returns "#Deleted"

## Symptom

A Microsoft Access-linked table that contains one or more **datetime** or **datetime2** columns and that’s connected to a Microsoft SQL Server database and has a compatibility level of 130 or larger (the compatibility level for SQL Server 2016) returns **#Deleted** in the results.

When you try to commit record changes to the linked table, you may also receive the following **"Write Conflict"** message:

> This record has been changed by another user since you started editing it.

## Cause

The issue occurs because the **datetime** or **datetime2** columns contain fractional seconds values. How fractional seconds are handled for **datetime2** types was changed starting in Microsoft SQL Server 2016. For more information about the change, see the following articles:

- [datetime2 (Transact-SQL)](/sql/t-sql/data-types/datetime2-transact-sql?view=sql-server-2017&preserve-view=true)
- [SQL Server and Azure SQL database improvements in handling some data types and uncommon operations](https://support.microsoft.com/help/4010261)

> [!NOTE]
> The **datetime** data type is also affected by the change to **datetime2**, because the SQL Server ODBC driver converts **datetime** to **datetime2** when it sends data to the server.

## Resolution

Access is introducing a new and improved **Date & Time Extended** data type beginning in Microsoft 365 Apps Version 2010.

To improve syntax compatibility with SQL, and to increase the accuracy and level of detail in records that include dates and times, Microsoft is implementing the **DateTime2** data type in Access. This data type will include a larger date range (0001-01-01 through 9999-12-31) that has better time precision (nanoseconds, instead of seconds). To enable the **DateTime2** data type, select **New field** > **Date & Time Extended**. For more information, see [Using the Date/Time Extended data type](https://support.microsoft.com/office/using-the-date-time-extended-data-type-708c32da-a052-4cc2-9850-9851042e0024).

> [!NOTE]
> The **Date & Time Extended** data type isn't compatible with previous versions of Microsoft Access. As a result, if the data type is implemented within a local Access table and the Access database is used with a previous version that doesn't include this feature, you can't open the database.

You can enable or disable the **Date & Time Extended** data type for linking and importing operations by using the **Current Database** Access option **Support Date Time Extended (DateTime2) Data Type for Linked/lmported Tables**. For more information, see [Set user options for the current database](https://support.microsoft.com/office/set-user-options-for-the-current-database-29b6b7be-4c3b-43a7-b8f0-5e1c68f5adce).

For earlier versions of Access, use one of the following methods to work around this issue:

- Change the compatibility level of the SQL Server database to 120 (the compatibility level for SQL Server 2014) or less.
- Make sure that the **datetime** and **DateTime2** columns aren't part of the primary key.
- Add a new column to the table using either **timestamp** or **rowversion** data type.
- Remove fractional seconds from the **datetime** column(s) using an **UPDATE** statement.
- Change the data type from **datetime** to **smalldatetime**. **Note**: This will round values to the nearest minute.
- If editing data isn't necessary, you may create a query and change the **RecordsetType** property to **Snapshot** which will return a read-only recordset that’s not affected by this issue.

> [!NOTE]
> Use the Linked Table Manager in Access to refesh the linked table(s) when any design changes are made on the SQL Server.
