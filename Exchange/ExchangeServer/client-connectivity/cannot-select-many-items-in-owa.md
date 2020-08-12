---
title: You have tried to select too many rows error
description: When you try to select many items in a folder in OWA, you receive an error that states you've tried to select too many rows.
ms.date: 08/10/2020
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: wduff, mhaque, timothyh
appliesto:
- Exchange Server 2010 Service Pack 1
search.appverid: MET150
---
# You have tried to select too many rows error when selecting many items in a folder in OWA

This article provides a resolution to solve the error message that occurs when selecting lots of items in Outlook Web App (OWA) in Microsoft Exchange Server 2010 Service Pack 1 (SP1).

_Original KB number:_ &nbsp; 2394261

## Symptoms

When you use OWA for Exchange Server 2010 SP1 and try to select a large number of items in a folder, you receive the following error:

> You've tried to select too many rows. Select fewer rows and try again.

## Cause

This behavior is by design.

## Resolution

Select a maximum of 40 items in a folder for any actions required, such as Copy To Folder or Move operations.

## More information

This problem does not occur in the original release version of Exchange Server 2010.

Microsoft regularly releases software updates to address specific problems. If Microsoft releases a software update to resolve this problem, this article will be updated with additional information.
