---
title: Troubleshoot errors when updating data in query or form
description: Lists troubleshooting information about the Operation must use an updatable query or the This Recordset is not updateable errors when you update data in an Access form.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 05/26/2025
---
# How to troubleshoot errors that may occur when you update data in Access queries and forms

_Original KB number:_ &nbsp; 328828

> [!NOTE]
> Requires basic macro, coding, and interoperability skills. This article applies to a Microsoft Access database (.mdb and .accdb) and to a Microsoft Access project (.adp).

This article describes errors that may occur in Microsoft Access when you update data in queries and in forms. This article also describes the causes of the errors and how to troubleshoot those errors.

When you try to update data in a query or in a form, you may receive one of the following error messages:

> Operation must use an updatable query.

-or-

> This Recordset is not updateable.

## Troubleshooting information about problems that may occur when you update data in a query

- When the query is based on three or more tables and there is a many-to-one-to-many relationship, you cannot update the data directly in the query. You can update the data in a form or in a data access page. You can do this based on the query when the `RecordsetType` property of the form is set to **Dynaset**(Inconsistent Updates).
- When the query is a crosstab query, you cannot update the data in the query.
- When the query is a Microsoft SQL pass-through query, you cannot update the data in the query.
- When the query is calculating a sum, an average, a count, or other type of total on the values in a field, you cannot update data in the query. Also, you cannot update a query that references a field in the **Update To** row from a crosstab, a query, a select query, or a subquery that contains totals or aggregate functions. To work around this problem, use the Domain Aggregate function in the **Update To** row of an update query. You can reference fields from a crosstab query, a select query, or a subquery that contain totals or aggregate functions.
- When the query is a Union query, you cannot update data in the query.
- When the Unique Values property of the query is set to **Yes**, you cannot update data in the query. To work around this problem, set the Unique Values property of the query to **No**.
- When the query includes a linked ODBC table with no unique index or a Paradox table without a primary key, you cannot update data in the query. To work around this problem, add a primary key or a unique index to the linked table.
- When you do not have **Update Data** permissions for the query or the underlying table, you cannot update data. To resolve this problem, assign permissions to update the data.
- When the query includes more than one table or one query, and the tables or the queries are not joined by a join line in **Design** view, you cannot update data in the query. To resolve this problem, you must join the tables correctly so you can update them.
- When the field that you want to update is a calculated field, you cannot update data in the query.
- When the field that you try to update is read-only, the database is open as read-only, or the database is located on a read-only drive, you cannot update data in the query. To avoid this problem, do not open the database as read-only. If the database is located on a drive that is read-only, remove the read-only attribute from the drive or move the database to a drive that is not read-only.
- When the field in the record that you try to update is deleted or is locked by another user, you cannot update data in the query. A locked record can be updated as soon as the record is unlocked.
- When the query is based on tables with a one-to-many relationship, then the types of fields that you may not be able to modify are as follows:

  - Join field from the "one" side.
  - The "many" side join field does not appear in the datasheet.
  - Join field from the "many" side after you update data on the "one" side.
  - A blank field from the table on the "one" side of a one-to-many relationship with an outer join exists.
  - The whole unique key of the ODBC table is not the output.
  
  You can resolve any one of these problems if you take the correct action from the following list:

  - Enable cascading updates between the two tables.
  - Add the join field from the "many" side to your query so you can add new records.
  - Save the record. You can make changes to the "many" side join field.
  - Enter values in fields from the table on the "many" side. You can do this only when the joined field from the "one" side contains a value for that record.
  - Select all primary key fields of the ODBC tables to allow inserts to them.

## Troubleshooting information about problems that may occur when you update data in a form

- You cannot update data in a form if the form is based on a stored procedure with more than one table.

- You cannot update data in a form if the form is based on an ActiveX Data Objects (ADO) recordset. Access forms permit you to edit data from an ADO recordset if the ADO recordset is created by using a combination of the MSDataShape and the SQL Server OLEDB providers.
