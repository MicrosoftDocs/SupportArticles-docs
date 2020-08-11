---
title: Top columns in an Excel spreadsheet pasted into PowerPoint are truncated by Surface Pro with docking station and external monitor 
ms.author: v-todmc
author: McCoyBot
manager: dcscontentpm
ms.date: 2/21/2020
audience: Admin
ms.topic: article
ms.prod: 
- excel
- powerpoint
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Excel
- PowerPoint
ms.custom: 
- CI 113893
- CSSTroubleshoot 
ms.reviewer: azali 
description: Resolution to an issue where the top of Excel columns is truncated when pasted in a PowerPoint presentation on a Surface Pro using a docking station and an external monitor.
---

# Top columns in an Excel spreadsheet pasted into a PowerPoint presentation cut-off 

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When editing an Excel spreadsheet embedded into PowerPoint on a Surface Pro attached to an external monitor when connected through a docking station, the source file is opened instead of the edit window.  

## Cause

This issue can occur when the scaling and layout of the monitor is different than that in the display setting.

## Resolution

This issue can be resolved by following the steps below:

1.    Open PowerPoint.
2.    Under **User Interface Options**, select **File**, then **Options**, then **General**, and then **Optimize for Compatibility**.
3.    Under **Display settings**, set the scale and layout of all monitors connected to the Surface Pro to **125**. 
