---
title: Symantec DLP interfering with Teams processes
ms.author: v-todmc
author: todmccoy
ms.date: 4/9/2020
audience: ITPro
ms.topic: article
manager: dcscontentpm
ms.service: msteams
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Teams
ms.custom: 
- CI 113425
- CSSTroubleshoot 
ms.reviewer: scapero
description: Describes a resolution to an issue where Symantec DLP interferes with Teams processes.
---

# Symantec DLP interferes with Teams processes

## Symptoms

Installing Symantec DLP creates operability issues with Microsoft Teams.

## Cause

Symantec DLP Endpoint agents can interfere with Teams processes, which can then lead to launch or exit failures. 

## Resolution

Exclude (whitelist) Teams.exe from the Symantec DLP's Endpoint agents as described in this [Symantec support article](https://support.symantec.com/us/en/article.TECH220322.html).

## More information

Still need help? Go to [Microsoft Community](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fanswers.microsoft.com%2F&data=02%7C01%7Cv-todmc%40microsoft.com%7C98910814456c474880f108d7cf62d97d%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637205895885805857&sdata=9%2FYStDGvrU5ZIYXB7guowmaPlKazab0U%2BTpiBIItDaQ%3D&reserved=0).
