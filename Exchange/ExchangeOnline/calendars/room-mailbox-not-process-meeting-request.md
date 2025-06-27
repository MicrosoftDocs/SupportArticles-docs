---
title: Room mailbox doesn't process a meeting request
description: Describes a scenario in which meeting requests aren't processed by the room mailbox in Exchange Online when the meeting request is created directly in the calendar of the room.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: alinastr, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
  - Outlook 2019
search.appverid: MET150
ms.date: 01/24/2024
---
# Meeting request isn't processed by the room mailbox in Exchange Online

_Original KB number:_ &nbsp; 3191287

## Problem

A user has full access permissions to a room mailbox or editing permissions to the calendar of a room mailbox. When the user tries to create a meeting request directly in the calendar of the room mailbox, the room mailbox doesn't process the meeting request.

## Cause

This behavior is by design. The Resource Booking Assistant processes requests that are sent to the room. When a user who has editing permissions creates the meeting directly in the room's calendar, the room is the actual organizer of the meeting, and there's nothing to process.

## Workaround

For the room to process all meetings, create the meeting in the calendar of the user who wants to book the room (the user who has editing permissions) instead of creating the meeting directly in the calendar of the room mailbox.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
