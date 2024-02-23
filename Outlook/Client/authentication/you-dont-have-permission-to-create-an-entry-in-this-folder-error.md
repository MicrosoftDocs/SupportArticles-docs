---
title: You don't have permission to create an entry in this folder
description: Describes a permissions issue that occurs when you try to create a new post in a public folder in Outlook 2010 and Outlook 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, gregmans, tsimon, laurentc, amkanade, doakm, randyto, gbratton, bobcool, sercast
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 10/30/2023
---
# You don't have permission to create an entry in this folder error even if you have permissions to the folder

_Original KB number:_ &nbsp; 983114

## Symptoms

Consider the following scenario:

- You have a Microsoft Outlook 2010 or Microsoft Outlook 2013 profile that has two Microsoft Exchange Server accounts. Both accounts have a public folders store.
- You create a folder that is visible to both accounts. One account does not have permissions to access the folder, and the other account does have permissions to access the folder.
- You use the account that does not have permissions to try to create a post in the folder, and then you receive the following error message:

  > You don't have permission to create an entry in this folder.

- In the same Outlook session, you use the account that does have permissions to try to create a post in the same folder.

In this scenario, you receive the same error message that was mentioned earlier.

## Cause

This issue occurs because the cache for Outlook is not emptied when you switch accounts in the same profile. Because the account that does not have permissions tried to access the folder, this account has ownership of the folder until you restart Outlook.

## Workaround

To work around this issue, exit Outlook, and then restart Outlook. This clears an internal cache that is used by Outlook for public folder access.

> [!NOTE]
> After you restart Outlook, make sure that the account that has the appropriate permissions is the first to try to access the folder.
