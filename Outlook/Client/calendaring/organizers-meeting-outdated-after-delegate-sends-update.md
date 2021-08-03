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
- Outlook for Microsoft 365
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

## More information

This is a known limitation in Outlook 2019, Outlook 2016, and Outlook for Microsoft 365.

To avoid this issue, allow enough time for Outlook to complete the synchronization of the recurring meeting, before you create a meeting recurrence exception and send the update.

Additionally, this issue doesn't occur with shared calendars that sync using the new model in Outlook for Microsoft 365.

To determine if a shared calendar is the new model, see [Outlook calendar sharing updates](https://support.microsoft.com/office/outlook-calendar-sharing-updates-c3aec5d3-55ce-4cea-84b0-80aab6d8dc26).

For detailed technical changes about calendar sharing, see [Calendar sharing in Microsoft 365](https://support.microsoft.com/office/calendar-sharing-in-microsoft-365-b576ecc3-0945-4d75-85f1-5efafb8a37b4).