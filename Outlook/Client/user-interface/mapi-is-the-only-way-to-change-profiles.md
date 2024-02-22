---
title: MAPI is the only way to change profiles
description: You can only use Extended MAPI to programmatically change profiles.
ms.date: 10/30/2023
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: danba, brijs, Andrei.Ghita, gbratton, dvespa
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
search.appverid: MET150
---
# MAPI is the only supported way to programmatically change profiles

_Original KB number:_ &nbsp; 266352

## Summary

The only supported way to modify MAPI profiles programmatically is through Extended MAPI. The values that are written into the registry by MAPI are not documented, and direct manipulation of these values through the registry application programming interfaces (APIs) is not supported.

## More information

The keys and values that make up a MAPI profile depend on the various providers that make up the profile. Because providers are not required to document the properties that they write or the relationship of the properties to one another, modifying these values directly can have unpredictable and adverse effects.
