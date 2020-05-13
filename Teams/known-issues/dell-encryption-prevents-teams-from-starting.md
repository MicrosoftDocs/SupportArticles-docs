---
title: Teams doesn't start with Dell Encryption
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
description: Describes a workaround for starting Teams when using Dell Encryption. 
---

# Dell Encryption prevents Teams from starting correctly 

## Problem

Dell Encryption (formerly Dell Data Protection Encryption) is known to corrupt Teams installations during the update process, leading to a permanent failure to start the application. 

## Solution

Exclude the Teams folder %LocalAppData%\Microsoft\Teams from the encryption policy.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
