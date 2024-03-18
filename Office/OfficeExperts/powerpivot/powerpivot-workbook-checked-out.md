---
title: The workbook must be checked out when run data refresh in PowerPivot
description: Fixes an error that occurs when you run a scheduled data refresh on a PowerPivot workbook.
author: helenclu
ms.author: luche
ms.reviwer: zakirh
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Microsoft Excel
ms.date: 03/31/2022
---

# "The workbook must be checked out before it can be replaced. You can save this file with another name." when you run a scheduled data refresh on a PowerPivot workbook

This article was written by [Rick Andring](https://social.technet.microsoft.com/profile/Rick+A.+-+MSFT), Support Escalation Engineer.

## Symptoms

When you run a scheduled data refresh on a PowerPivot workbook, you receive the following error:

> The workbook must be checked out before it can be replaced. You can save this file with another name.

## Cause

The **Require documents to be check out before they can be edited** option under **Versioning Settings** in **Document Library Settings** is likely set to **Yes**.

## Resolution

PowerPivot doesn't check out documents when it makes its modification. To make the scheduled data refresh to work on the document library, set the **Require documents to be check out before they can be edited** option to **No**.
