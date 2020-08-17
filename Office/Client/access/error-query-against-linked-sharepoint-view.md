---
title: (Cannot update. Database or object is read-only) error in a query against a linked SharePoint view if there are unlinked lookup fields in Access
description: Discusses that you receive a (Cannot update. Database or object is read-only) error message if the underlying list includes lookup fields that are not linked to Access. Provides a workaround.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: troubleshoot
ms.custom: CSSTroubleshoot
ms.author: v-six
ms.reviewer: denniwil
appliesto:
- Access 2016
- Access 2010
- Access 2013
- Access for Office 365
- Access 2019
---

# Error (Cannot update. Database or object is read-only) in a query against a linked SharePoint view if there are unlinked lookup fields in Access

This article fixes an issue if the underlying list includes lookup fields that are not linked to Access.

_Original KB number:_ &nbsp; 3200677

## Symptoms

While working in Microsoft Access, you execute update queries against a linked Microsoft SharePoint view.

The underlying list that you are updating includes lookup fields that are not linked to Access because they are not included in the current view.

In this scenario, you receive an error message:

> Cannot update. Database or object is read-only.

## Cause

This problem occurs when you use the `ImportSharePointList` macro action. (For Access 2016 and Later) and `TransferSharePointList` (for Access versions before 2016) to link to a view of a SharePoint list in Access.

This macro creates linked tables in Access for each lookup column in the SharePoint view.

While the update query first checks that all lookup columns have linked tables in the database for the underlying list, it does not check exclusively for the lookups that are part of the current query.

In doing so, the database connection is severed and when there is a write operation, the query returns with a read-only object or database.

## Workaround

To work around this problem, use one of the following methods:

### Method 1

Link all the lookup columns in the underlying list to tables, to make them writable. To do this, follow these steps:

1. Link to the SharePoint list itself.
This ensures that all lookup tables for the underlying list are present within Access.
1. Delete the linked table for the SharePoint list in Access.
This will leave the linked tables for the lookup columns intact.
1. Link to the SharePoint view by using the `ImportSharePointList` macro action.

By using this workaround, Microsoft Access will now contain a linked table for the SharePoint view and also the linked tables for all the lookup columns in the underlying list. And not only the lookup columns that are included in the view.

This should solve the issue, if not, follow method 2.

### Method 2: Disable caching in Access 2010

To do this, follow these steps:

1. In Access, select **File** > **Options**.
1. Select **Current Database**.
1. Scroll down to the **Caching Web Service** area.
1. Locate the **Microsoft SharePoint tables**.
1. Select the **Never Cache** check box.

## More information

For more information about known issues that occur when you use SharePoint lists in Access, see [Access cache formats for SharePoint lists/document libraries](https://support.microsoft.com/help/3200688).

For more information about the `TransferSharePointList` macro, see [TransferSharePointList Macro Action](https://support.office.com/article/f4e107b1-5513-4868-a2d9-42be1d08e7fd?ui=en-us&rs=en-us&ad=us).
