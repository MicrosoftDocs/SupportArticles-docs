---
title: Excel files are updated without user interaction
description: Describes why Excel files are updated automatically when no changes are initiated by a user.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Excel for the web
ms.date: 03/31/2022
---

# Excel files are updated without user interaction

The first time that you use either Excel Online or a recent version of the Microsoft Excel application to open an Excel workbook that’s stored in the document library, you notice that some fields such as **Modified**, **Modified By**, and **Version** are updated even though you didn’t make the updates.

This behavior is by design. Excel applications have an internal calculation engine for each version. Excel workbooks contain information about the version of the calculation engine that was used to create them.

If a file was created in a version of Excel that’s older than the version that you’re using to open it, a recalculation is processed automatically the first time that you open the file. This recalculation updates the fields without user interaction.
