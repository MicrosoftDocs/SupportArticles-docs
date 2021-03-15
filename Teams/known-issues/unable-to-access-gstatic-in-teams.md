---
title: Unable to access Google GSTATIC through Teams
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
description: Describes an issue where GSTATIC can't be accessed through Microsoft Teams. 
---

# Microsoft Teams requires access to Google GSTATIC

## Symptom

You are unable to access Google GSTATIC through Microsoft Teams. 

## Cause

Teams presently requires access (TCP port 443) to the Google **ssl.gstatic.com** service for all users; this is true even if you're not using GSTATIC. Teams will remove this requirement soon (early 2020).

## Resolution

Microsoft is researching this problem and will post more information when the information becomes available.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).