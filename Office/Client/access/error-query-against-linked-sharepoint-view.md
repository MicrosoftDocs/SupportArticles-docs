---
title: (Cannot update. Database or object is read-only) error in a query against a linked SharePoint view if there are unlinked lookup fields in Access
description: Describes why you receive a (Cannot update. Database or object is read-only) error message if the underlying list includes lookup fields that aren't linked to Access. Provides a workaround.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
ms.reviewer: denniwil
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
ms.date: 05/26/2025
---

# Error (Cannot update. Database or object is read-only) in a query against a linked SharePoint view if there are unlinked lookup fields in Access

## Symptoms

While you work in Microsoft Access, you run update queries against a linked Microsoft SharePoint view. The underlying list that you're updating includes lookup fields that are **not linked** to Access because they aren't included in the current view.

In this scenario, you receive the following error message:


> Cannot update. Database or object is read-only.

## Cause

This problem occurs when you use the **`ImportSharePointList`** macro action. (For Access 2016 and later) or **`TransferSharePointList`** action (for Access versions earlier than 2016) to link to a view of a SharePoint list in Access. 

This macro creates linked tables in Access for each lookup column in the SharePoint view. 

Although the update query first checks that all lookup columns have linked tables in the database for the underlying list, it doesn't check exclusively for the lookups that are part of the current query.
Because of this condition, the database connection is severed. Therefore, the query returns a read-only object or database in a write operation.

## Workaround

To work around this problem, use one of the following methods.

### Method 1

Link all the lookup columns in the underlying list to tables to make them writable. To do this, follow these steps:

1. Link to the SharePoint list itself.
This makes sure that all lookup tables for the underlying list exist within Access.
1. Delete the linked table for the SharePoint list in Access. This leaves as intact the linked tables for the lookup columns.
1. Link to the SharePoint view by using the **`ImportSharePointList`** macro action.

After you implement this workaround, Microsoft Access will contain a linked table for the SharePoint view. It will also contain the linked tables for all the lookup columns in the underlying list, not only for the lookup columns that are included in the view.

If these steps do not resolve the issue, go to Method 2.

### Method 2: Disable caching in Access 2010.

To do this, follow these steps:

1. In Access, select **File** > **Options**.
1. Select **Current Database**.
1. Scroll down to the **Caching Web Service** area.
1. Locate the **Microsoft SharePoint tables**.
1. Select the **Never Cache** check box.

## More information

For more information about known issues that occur when you use SharePoint lists in Access, see [Access cache formats for SharePoint lists and document libraries](https://support.microsoft.com/help/3200688).

For more information about the **ImportSharePointList (TransferSharePointList)** macro, see [ImportSharePointList Macro Action](https://support.office.com/article/transfersharepointlist-macro-action-f4e107b1-5513-4868-a2d9-42be1d08e7fd?ui=en-us&rs=en-us&ad=us).## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
