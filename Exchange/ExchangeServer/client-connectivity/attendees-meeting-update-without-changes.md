---
title: attendees get a meeting update without changes
description: Describes an issue in which attendees receive a meeting request that includes the No Response Required option.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: jmartin, v-six
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Online
ms.date: 01/24/2024
---
# Attendees receive a meeting update after the event reminder is triggered

_Original KB number:_ &nbsp; 3108249

## Symptoms  

After the reminder for an event is triggered, attendees receive a meeting update without any changes. Additionally, attendees receive a meeting request in their Inbox that includes the **No Response Required** option.

## Cause

The organizer of the meeting performed an action on the iOS 9.x device that sent a change for the appointment to Exchange. A new behavior was introduced in version 16 of the Exchange ActiveSync (EAS) protocol in which Exchange sends meeting updates when an EAS client sends a change for the appointment.

## Status

Microsoft is researching this issue and will post more information in this article when the information becomes available. Customers who experience this issue should contact Apple for help.

## Workaround

You can work around this issue by using [Microsoft Outlook for iOS](https://itunes.apple.com/us/app/microsoft-outlook/id951937596?mt=8).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-information-disclaimer.md)]
