---
title: Index outside bounds of array error
description: Describes and provides a workaround for an issue in which you receive an error message in SQL Server 2012 when you try to import data from multiple tables of a database to an Excel 2013 workbook.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Editing\Data\ImportExport
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel 2013
  - SQL Server 2012 Enterprise
  - SQL Server 2012 Standard
  - Power BI for Microsoft 365
ms.date: 05/26/2025
---

# "Index was outside the bounds of the array" error when you import data from multiple tables in a SQL Server database to an Excel 2013 workbook

## Symptoms

Consider the following scenario in which you try to import data from a Microsoft SQL Server 2012 database to a Microsoft Excel 2013 workbook: 

- You start the Data Connection Wizard to create a connection from the SQL Server database to the workbook.   
- You select multiple tables from the database.   
- You select how you want to view the imported data in the workbook. For example, you select to create a table, a PivotTable report, or a PivotChart report. 
  
In this scenario, you receive the following error message:

> We couldn't get data from the Data Model. Here's the error we got: Index was outside the bounds of the array.

## Cause

This issue occurs when one of the selected table names ends with a string that matches a schema name in the database. The Data Connection Wizard only uses the table names instead of the fully qualified table names when you import data from multiple tables. 

Note This issue does not occur when you use the Data Connection Wizard to import data from a single table. In this situation, the Data Connection Wizard uses the fully qualified table name.

## Workaround

To work around this issue, use one of the following methods:

- Use the Data Connection Wizard to import data from one table at a time.   
- Make sure that none of your table names end with a string that matches a schema name, and then import data from multiple tables.   
- After you receive the error message that is mentioned in the "Symptoms" section, follow these steps to import data from multiple tables:
  1. Click **Properties** in the Import Data dialog box.   
  2. Click the **Definition** tab.   
  3. In the Command Text box, change the table names to fully qualified table names by using the following format:
  Database.Schema.TableName
