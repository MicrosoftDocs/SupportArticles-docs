---
title: How to include or exclude Teams from antivirus or DLP applications
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 9/9/2019
ms.audience: Admin
ms.topic: article
ms.service: msteams
localization_priority: Normal
search.appverid:
- SPO160
- MET150
ms.assetid: 
appliesto:
- Teams
ms.custom: 
- CI 106370
- CSSTroubleshoot
ms.reviewer: davidsle
description: How to add Teams to antivirus or DLP to allow Teams to start correctly.
---

# How to include or exclude Teams from antivirus or DLP applications

## Summary

Antivirus and data loss prevention (DLP) applications can interfere with the Microsoft Teams app, and it can prevent the application from starting correctly. ITPRO and Security customers can include or approve the Teams app when they use antivirus or DLP in PC clients. This action specifically helps enhance performance and mitigate the effect on security. 

## More information

To prevent any interference of Teams, add the following items to the "exclusion list" process in the Antivirus Software.

- %userprofile%\AppData\Local\Microsoft\Teams\current\teams.exe
- %userprofile%\AppData\Local\Microsoft\Teams\update.exe
- %userprofile%\AppData\Local\Microsoft\Teams\stage\squirrel.exe

Or, you can add the items to the "safe" ("allowlisted") programs list in the DLP application. (The method to accomplish this varies. For specific instructions, contact the application manufacturer.)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
