---
title: Query must have at least one destination field error when you run a query
description: Discusses a problem in which you receive Query must have at least one destination field when you run an existing Access query. Provides a workaround.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
ms.date: 05/26/2025
---

# "Query must have at least one destination field" when you run an Access query

## Symptoms

When you run an existing Microsoft Access query, you receive the following error message:

```adoc
Query must have at least one destination field.
```

You do not see the expected query in Design View, and you see only "Select;" or "Select*;" in SQL View.

## Cause

This problem occurs when you run the OutputTo method because of an issue that affects reading the structure of queries that have been designed and saved only within SQL View.

## Workaround

To work around this problem, use one of the following methods:

- For each database that is affected by this problem, open the database in Access, click **Options** on the **File** menu, select **Current Database**, and then clear the **Track name AutoCorrect info** check box.
- Make sure that each query is opened and saved while in you are in Design View.

## Status

Microsoft has confirmed that this is a bug in the Microsoft products that are listed in the "Applies to" section.
