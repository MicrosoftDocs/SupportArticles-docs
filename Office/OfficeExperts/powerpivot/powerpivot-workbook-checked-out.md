---
title: The workbook must be checked out when run data refresh in PowerPivot 
author: AmandaAZ
ms.author: zakirh
manager: zakirh
audience: ITPro
ms.topic: article
ms.prod: office-perpetual-itpro
localization_priority: Normal
---

# "The workbook must be checked out before it can be replaced. You can save this file with another name." when you run a scheduled data refresh on a PowerPivot workbook

## Symptoms

When you run a scheduled data refresh on a PowerPivot workbook, you receive the following error:

**The workbook must be checked out before it can be replaced. You can save this file with another name.**

## Cause

The **Require documents to be check out before they can be edited** option under **Versioning Settings** in **Document Library Settings** is likely set to **Yes**.

## Resolution

PowerPivot doesn't check out documents when it makes its modification. To make the scheduled data refresh to work on the document library, set the **Require documents to be check out before they can be edited** option to **No**.
