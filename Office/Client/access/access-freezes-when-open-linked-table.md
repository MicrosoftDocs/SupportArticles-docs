---
title: Access freezes when you open a linked table to a SharePoint list
description: Describes an issue in which Microsoft Access hangs when you open a linked table to a SharePoint list.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 11297
ms.reviewer: suesch, denniwil, v-lisalozano
search.appverid: 
  - MET150
appliesto: 
  - Access 2024
  - Access 2021
  - Access 2019
  - Access 2016
ms.date: 04/23/2026
---

# Access freezes when you open a linked table to a SharePoint list

## Symptoms

In a Microsoft Access desktop database, when you try to open a table that's linked to a SharePoint list, Access stops responding. 

## Cause

The issue occurs when the user who tries to open the existing linked table in Access doesn't have locally stored credentials for the SharePoint site that contains the list. A stored credential may be either a credential in Windows Credential Manager or a persistent cookie in Internet Explorer. 

## Resolution

To work around this issue, use one of the following methods.

### Method 1: Refresh the list

To refresh the list, follow these steps:

1. Open Windows Task Manager, select Microsoft Access, and then click **End task**.
2. Reopen the database.
3. Right-click the linked table in Access, and then select **More Options** > **Refresh List**.
4. Log on by using your credentials.

### Method 2: Programmatically relink the list

To relink the list, follow these steps:

1. Open Windows Task Manager, select Microsoft Access, and then click **End task**.
2. Reopen the database, and create a new module.
3. In VBA code, use the **RefreshLink** method of the TableDefs collection for the linked tables:

```vb
Public Function TableRelinkSample()
           CurrentDb.TableDefs("<TableName>").RefreshLink
     End Function
```

**Note** If you have multiple linked SharePoint lists, you have to call **RefreshLink** only one time for any one of the tables.

4. Call the **TableRelinkSample()** function from the AutoExec macro or other startup code in the database.

   [TableDef.RefreshLink Method (DAO)](https://msdn.microsoft.com/library/office/ff198349.aspx)
