---
title: Excel or PowerPoint error This file cannot be saved because some properties are missing or invalid
description: Describes workaround for error This file cannot be saved because some properties are missing or invalid
author: helenclu
ms.reviewer: warrenr
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
  - CI 158345
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Microsoft Excel
  - Microsoft PowerPoint
ms.date: 03/31/2022
---

# Excel or PowerPoint error: “This file cannot be saved because some properties are missing or invalid”

## Symptoms

When you try to use **Save As** to save an Excel or PowerPoint file to a SharePoint or OneDrive location, you encounter the following error:

> This file cannot be saved because some properties are missing or invalid.

If you select **File** and then **Info**, you will see the required **lookup** property that the error refers to, but selecting **Show details** next to the property doesn’t do anything.

## Cause

The issue is a design limitation of Excel and PowerPoint.

## Workaround

Save the file to your device, then upload the document to SharePoint using the SharePoint web user interface. This will allow the **lookup** property to be set.  If you open the file later, **Show details** will allow you to set the property.