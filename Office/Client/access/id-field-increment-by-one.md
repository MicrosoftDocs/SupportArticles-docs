---
title: ID is increment every time you add field to table
description: Describes a problem in which the ID field is increment by one every time that a field is added to a new table in Datasheet view in Access 2007 or in Access 2010. Provides a workaround.
author: Cloud-Writer
manager: dcscontentpm
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: acckb12
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Access 2007
ms.date: 05/26/2025
---

# The ID field is increment by one every time that you add a field to a new table in Datasheet view in Access

## Symptoms

You create a new table in Datasheet view in Microsoft Office Access 2007 or a later version. Every time that you press ENTER to add a new field to the table, the ID field value is incremented by one. For example, if you add five fields to the first row of data before you save the table, the ID field value is incremented to 5.

## Workaround

To work around this problem, perform one of the following actions:

- Add a second row of data before you add a new field to the table.   
- Save the table before you add a new field to the table.   

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

### Steps to reproduce the problem

1. On the **Create** tab, click **Table**.   
2. In Datasheet view, type SampleData in the **Add New Field** box, and then press ENTER.   
3. Type SampleData2 in the **Add New Field** text box, and then press ENTER.   

The ID value is incremented to 2.
