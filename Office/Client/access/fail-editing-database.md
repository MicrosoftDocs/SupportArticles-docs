---
title: Can't edit a database when data macro is added
description: Provides a workaround for an issue in which you can't edit a database in Office Access 2007 if the database was saved in Access 2010.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Access 2010
  - Microsoft Office Access 2007
search.appverid: MET150
ms.date: 3/31/2022
---
# You cannot edit a database that was saved in Access 2010 if you open the database in Office Access 2007

_Original KB number:_ &nbsp; 982277

## Symptoms

Consider the following scenario:

- You create and then save a database in Microsoft Office Access 2007.
- You open the database in Microsoft Access 2010, add a data macro to a table in the database, and then save the changes to the database.
- You open the database in Office Access 2007, and then try to edit the table.

In this scenario, you cannot edit the table. Additionally, you receive the following error message:

#### In Office Access 2007 together with the 2007 Microsoft Office system Service Pack 2 installed

> This database uses some features which may be incompatible with the current version of Microsoft Office Access.

#### In Office Access 2007 together with the 2007 Microsoft Office system Service Pack 1 installed or in the RTM release version of Office Access 2007

> Unrecognized database format '**path\file_name**'.

## Cause

This issue occurs because a new feature that is not supported in Office Access 2007 was added to the database in Access 2010.

## Workaround

To work around this issue, use one of the following methods.

### Method 1

Install Access 2010, and then edit the database.

### Method 2

To edit the database in Office Access 2007, follow these steps:

1. Open the database in Access 2010.
2. Delete the new feature, such as the data macro, from the database.
3. Create a new database in Access 2010, and then import all objects from the old database into the new database.
4. Save the new database in Access 2010, and then edit the new database in Office Access 2007.
