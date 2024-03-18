---
title: Can't create PivotTable when field names contain similar characters
description: Describes and provides a workaround for an issue in which you cannot insert a PivotTable into a workbook in Excel 2013. This issue occurs when you select a source range in which the field names contain similar characters.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
ms.reviewer: xl15beta, diego
search.appverid: 
  - MET150
appliesto: 
  - Excel 2013
ms.date: 03/31/2022
---

# You cannot create a PivotTable in Excel 2013 when field names in a source range contain similar characters

## Symptoms

Consider the following scenario:

- You have two field names in a source range that have similar characters. For example, one field is named "Hello2World," and the other field is named "Hello<sup>2</sup>World." The "<sup>2</sup>" character corresponds to the "178" character in ASCII.  
- You try to create a PivotTable by selecting the source range in Microsoft Excel 2013.   
- You select the **Add this data to the Data Model** check box in the **Create PivotTable** dialog box.

In this scenario, you receive the following error message:

```adoc
We couldn't get data from the Data Model. Here's the error we got: 

The attribute with the name of Hello<sup>2</sup>World already exists in the '**Range**' dimension.
```

## Cause

This issue occurs because the data model cannot differentiate between the similar characters.

## Workaround

To work around this issue, change one field name to be distinct from the other.

## Status

This is a known issue in Excel 2013.
