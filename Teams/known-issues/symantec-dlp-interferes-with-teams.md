---
title: Symantec DLP interfering with Teams processes
ms.author: luche
author: helenclu
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

Exclude Teams.exe from the Symantec DLP's Endpoint agents as described in this [Symantec support article](https://support.symantec.com/us/en/article.TECH220322.html).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
