---
title: Insert or delete rows very slow if custom sort on many named columns
description: Describes an issue in which it takes a very long time to insert or delete rows after you perform a custom sort on many named columns. This issue occurs in Excel 2013.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
localization_priority: Normal
ms.reviewer: chadmat, jenl
search.appverid: 
  - MET150
appliesto: 
  - Excel 2013
ms.date: 03/31/2022
---

# Excel 2013 takes a very long time to insert or delete rows after a custom sort on many named columns

## Symptoms

You try to insert or delete rows in a Microsoft Excel 2013 worksheet. You do this after you sort a range that contains defined names that refer to whole columns. In this scenario, it takes a very long time to insert or delete rows.

## Cause

This issue occurs because of the defined names. There are over one million rows per column in Excel 2013. If you refer to the whole column, all rows of the column are loaded into memory when you perform an operation on the column. Therefore, you encounter a performance issue when you insert or delete rows after sorting.

## Workaround

To work around this issue, create a dynamic defined name on ranges instead of naming the whole column.

For more information about how to create a dynamic defined range in Excel, click the following article number to view the article in the Microsoft Knowledge Base:

[830287](https://support.microsoft.com/help/830287) How to create a dynamic defined range in an Excel worksheet
