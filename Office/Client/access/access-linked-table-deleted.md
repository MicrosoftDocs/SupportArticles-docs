---
title: Access linked table to SQL Server database returns Deleted
description: Describes an issue in which an Access linked table that's connected to a SQL Server database returns.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Access for Office 365
- Access 2019
- Access 2016
- Access 2013
---

# Access linked table to SQL Server database returns #Deleted

## Symptom

You have a Microsoft Access linked table that’s connected to a Microsoft SQL Server database. The compatibility level of the database is 130 (the compatibility level for SQL Server 2016) or higher, and the table that’s linked contains one or more datetime or datetime2 columns.

In this scenario, the linked table returns **#Deleted** in the results. You may also experience a **Write Conflict** stating "This record has been changed by another user since you started editing it" when attempting to commit record changes to the linked table.

## Cause

The issue occurs when the datetime or datetime2 columns contain specific fractional seconds values because the way that fractional seconds are handled for datetime2 types changed starting with SQL Server 2016.
For more information about the changes, see the following articles: 

- [datetime2 (Transact-SQL)](https://docs.microsoft.com/sql/t-sql/data-types/datetime2-transact-sql?view=sql-server-2017)    
- [SQL Server and Azure SQL database improvements in handling some data types and uncommon operations](https://support.microsoft.com/help/4010261)

## Workaround

Microsoft is aware of this issue. Until the issue is resolved, use one of the following methods to work around this issue: 

- Change the compatibility level of the database to 120 (the compatibility level for SQL Server 2014) or lower.    
- Remove fractional seconds from the datetime columns.    
- Make sure that the datetime columns aren’t part of the primary key. Add a timestamp column to the table, and then use the Linked Table Manager in Access to refresh the linked table.    
- If editing data isn't requested, create a query and change the **RecordsetType** property to **Snapshot**.

