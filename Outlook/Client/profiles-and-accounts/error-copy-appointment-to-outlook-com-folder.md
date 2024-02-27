---
title: Cannot move the items error when you copy an appointment to an Outlook.com folder
description: Provides a summary of issues related to copying or moving appointments into an Outlook.com-based calendar folder from a calendar folder that's based in another account type (Exchange, IMAP, POP).
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: billja, aruiz, gbratton
appliesto: 
  - Outlook 2013
search.appverid: MET150
ms.date: 01/30/2024
---
# Error when you copy an appointment to an Outlook.com calendar folder: Cannot move the items

_Original KB number:_ &nbsp;2877849

## Summary

When you try to copy an appointment or meeting from another store to an `Outlook.com` folder, you receive the following error:

> Cannot move the items. You cannot move one occurrence of an appointment series to a different folder. To move a recurring appointment, you must move the original appointment or copy the single occurrence and move the copy.

## More information

If you copy appointments to a calendar folder on an `Outlook.com` account, the behavior will vary, depending on the following factors:

- Whether you're moving or copying the appointment
- The current view

The following table summarizes what occurs when you move or copy appointments to an EAS-based store.

|Action|Calendar View<br/>Nonrecurring Appointment|Calendar View<br/>Recurring Appointment instance|List View<br/>Recurring Appointment master|
|---|---|---|---|
| Drag Calendar to Calendar|Copies item and syncs to server|Copies item and syncs to server|Not applicable|
| Drag Calendar to Hotmail Calendar folder|Moves item and syncs to server|Outlook disallows with error "Cannot move"<br/>|Moves item and syncs to server|
| Right-click drag and *copy* to Hotmail Calendar folder|Copies locally but doesn't sync to server<br/>|Copies locally but doesn't sync to server<br/>|Nothing happens<br/>|
| Right-click drag and *move* to Hotmail Calendar folder|Moves item and syncs to server|Outlook disallows with error "Cannot move"<br/>|Moves item and syncs to server|
