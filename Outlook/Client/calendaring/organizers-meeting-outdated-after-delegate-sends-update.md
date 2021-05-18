---
title: Organizer's meeting outdated after delegate sends update
description: Issue causes an organizer's meeting to remain outdated after a delegate sends an update on their behalf. 
ms.author: luche
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: article
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CSSTroubleshoot
ms.reviewer: Genli
appliesto:
- Outlook 2019
- Outlook 2016
- Outlook for Office 365
search.appverid: MET150
---
# Organizer's meeting remains outdated after a delegate sends an update on their behalf

_Original KB number:_ &nbsp; 4134851

## Symptoms

In Microsoft Outlook, you may experience some conditions that prevent an update to an occurrence of a recurring meeting.

Scenario 1

- A conference room is configured to automatically accept meetings.
- The conference room does not accept recurring meetings.
- A manager configures a delegate to the manager's calendar.
- The manager creates a recurring meeting and invites user attendees only.
- The delegate edits one occurrence of the recurring meeting, manually adding the conference room as an attendee.
- After the delegate sends the update, the conference room automatically accepts the request and sends an **Accepted** response.

In this scenario, when the delegate checks the meeting occurrence tracking status, the conference room response is displayed as **None**.

Scenario 2

- A manager grants another user delegate permission to the manager's calendar.
- The manager configures the delegated calendar so that the manager also receives copies of meeting requests and responses.
- A delegate creates a recurring meeting in the shared (manager's) calendar.
- The delegate includes themselves as an attendee to the recurring meeting.
- The delegate accepts their own invitation as an attendee.
- The delegate modifies the time of one instance of the recurring meeting, which creates a meeting recurrence exception, and then sends the update.
- The delegate accepts their own updated invitation as an attendee.
- The manager receives the delegate's **Accepted** response.

In this scenario, the manager's meeting exception time may revert to the original recurring meeting time.

## Cause

This issue occurs when Outlook processes the **Accepted** response before calendar synchronization is complete.

## Status

Microsoft is researching this problem and will post more information in this article when the information becomes available.
