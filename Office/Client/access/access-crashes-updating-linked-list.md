---
title: Access crashes when updating a linked SharePoint list
description: Fixes an issue in which Access crashes when you update a linked SharePoint list and try to commit the record change.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: denniwil
appliesto: 
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
search.appverid: MET150
ms.date: 05/26/2025
---
# Access crashes when you update a linked SharePoint list

_Original KB number:_ &nbsp; 3200416

## Symptoms

When you update a linked SharePoint list in Microsoft Access, and then you try to commit the record change, Access crashes.

## Cause

This problem occurs because of an infinite loop condition that occurs when Access tries to validate a lookup column's bound value, and the physical order of the bound value is not also in logical order. This problem occurs if the **Use the cache format that is compatible with Microsoft Access 2010 and later** check box is not selected.

## Workaround

To work around this problem, select the **Use the cache format that is compatible with Microsoft Access 2010 and later** check box. To do this, follow these steps:

1. In Access, select **File** > **Options**.
2. Select **Current Database**.
3. Scroll down to the **Caching Web Service** area, and then locate the Microsoft SharePoint tables.
4. Make sure the **Use the cache format that is compatible with Microsoft Access 2010 and later** check box is selected.

## More Information

For more information about known issues that occur when you use SharePoint lists in Access, see [Access cache formats for SharePoint lists and document libraries](access-cache-formats.md).
