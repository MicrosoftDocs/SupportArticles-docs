---
title: Calendar item body disappears in Outlook online mode
description: Fixes an issue in which the body of a Calendar, Contacts, or Notes item disappears. This issue occurs if the item was edited in Outlook Web App, and you use Outlook 2010 or 2013 in online mode to view it.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: juntak, heleli, jasonsla
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 10/30/2023
---
# Calendar item body disappears in Outlook online mode in an Exchange Server 2013 environment

_Original KB number:_ &nbsp; 2975003

## Symptoms

Assume that you compose or edit a Calendar item by using Outlook Web App or an Exchange ActiveSync device and then save the item. When you open the item in Microsoft Outlook 2013 or Outlook 2010 in online mode, the body of the item disappears.

> [!NOTE]
>
> - This issue also occurs in Outlook Contacts and Notes.
> - This issue doesn't occur in Outlook Web App or Outlook in cached mode.

## Resolution

To resolve this issue, install [Cumulative Update 6 for Exchange Server 2013](https://support.microsoft.com/help/2961810).

## Cause

This issue occurs because Outlook in online mode cannot convert the content from the body of Calendar items, Contacts, or Notes so that it displays correctly.
