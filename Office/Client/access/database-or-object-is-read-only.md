---
title: Cannot update. Database or object is read-only.
description: Discusses that you receive a Cannot update. Database or object is read-only error message if the underlying list includes lookup fields that are not linked to Access. Provides a workaround.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
ms.date: 03/31/2022
---

# "Cannot update. Database or object is read-only" in a query against a linked SharePoint view if there are unlinked lookup fields

## Symptoms

Consider the following scenario:

- You are working in Microsoft Access.
- You execute update queries against a linked Microsoft SharePoint view.
- The underlying list that you are updating includes lookup fields that are not linked to Access because they are not included in the current view.

In this scenario, you receive the following error message:

**Cannot update. Database or object is read-only.**

## Cause

This problem occurs when you use the ImportSharePointList macro action (as of Access 2016, previously known as TransferSharePointList) to link to a view of a SharePoint list in Access. This macro creates linked tables in Access for each lookup column in the SharePoint view. However, when the update query runs, it first checks that all lookup columns have linked tables in the database for the underlying list. The update query does not check exclusively for the lookups that are part of the current query.

## Workaround

To work around this problem, use one of the following methods:

### Method 1

Link all the lookup columns in the underlying list to tables. To do this, follow these steps:

1. Link to the SharePoint list itself. This makes sure that all lookup tables for the underlying list are present within Access.   
2. Delete the linked table for the SharePoint list in Access. (Leave the linked tables for the lookup columns.)   
3. Link to the SharePoint view by using the **ImportSharePointList** macro action.   

After you follow these steps, Access contains a linked table for the SharePoint view and linked tables for all the lookup columns in the underlying list instead of for only the lookup columns that are included in the view.

### Method 2

Disable caching in Access 2010. To do this, follow these steps:

1. In Access, select **File** > **Options**.   
2. Select **Current Database**.   
3. Scroll down to the **Caching Web Service** area, and then locate the Microsoft SharePoint tables.   
4. Select the **Never Cache** check box.   

## More Information

For more information about known issues that occur when you use SharePoint lists in Access, see [Access cache formats for SharePoint lists/document libraries](https://support.microsoft.com/help/3200688 ).

For more information about the TransferSharePointList macro, see [TransferSharePointList Macro Action](https://support.office.com/article/transfersharepointlist-macro-action-f4e107b1-5513-4868-a2d9-42be1d08e7fd).
