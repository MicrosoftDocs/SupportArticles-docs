---
title: Description of permanent temporary tables in Dexterity
description: Describes permanent temporary tables in Dexterity in Microsoft Dynamics GP. You may need this table when you have to pass the table's contents to a background procedure.
ms.reviewer: theley
ms.date: 03/13/2024
---
# Description of "permanent" temporary tables in Dexterity in Microsoft Dynamics GP

This article introduces the "permanent" temporary tables in Dexterity in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 921638

## Introduction

When you develop applications by using Dexterity in Microsoft Dynamics GP, sometimes, you must collate data from multiple tables into a single, temporary table. These standard Dexterity temporary tables are created when they are needed. (The standard temporary tables use the physical name of TEMP.) In addition, these tables only exist when their associated table buffer exists.

Sometimes, you need a *permanent* temporary table that exists even if the table buffer no longer exists. An example of when you need a *permanent* temporary table is when you have to pass the table's contents to a background procedure. Another example is when the table has to be accessed by Microsoft SQL Server by using a pass through SQL or a stored procedure.

## More information

To create a *permanent* temporary table, use a physical name that is numbered as **xx** 50000. To make sure that the table works as a temporary table and only shows data for the current application session, the table must be unique for each Company ID variable and User ID variable combination.

If the table is a system series table, the Company ID variable and the User ID variable must be the first two segments of all keys.

If the table is a company series table, the User ID variable must be the first segment of all keys. You no longer need the Company ID variable because the table is unique to the company database.

When you populate the table, make sure that you set the User ID field by using the User ID of globals variable. Then, make sure that the User ID field is set for your ranges.

The following code demonstrates the previous guidelines.

```console
range clear table TempTable;

clear table TempTable;
'User ID' of table TempTable = 'User ID' of globals;
range start table TempTable;

fill table TempTable;
'User ID' of table TempTable= 'User ID' of globals;
range end table TempTable;

fill window ScrollingWindow;
```
