---
title: Organizer's meeting outdated after delegate sends update
description: Issue causes an organizer's meeting to remain outdated after a delegate sends an update on their behalf.
ms.author: meerak
author: cloud-writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar\Other
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: jarrettr
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Organizer's meeting remains outdated after a delegate sends an update on their behalf

_Original KB number:_ &nbsp; 4134851

## Symptoms

In Microsoft Outlook, you experience some conditions that prevent changes to a single occurrence of a recurring meeting.

**Scenario 1**

- A conference room is configured to automatically accept meetings.
- The conference room does not accept recurring meetings.
- A manager configures a delegate to the manager's calendar.
- The manager creates a recurring meeting and invites user attendees only.
- The delegate edits one occurrence of the recurring meeting to manually add the conference room as an attendee.
- After the delegate sends the update, the conference room automatically accepts the request and sends an **Accepted** response.

In this scenario, when the delegate checks the meeting occurrence tracking status, the conference room response is displayed as **None**.

**Scenario 2**

- A manager grants another user delegate permission to the manager's calendar.
- The manager configures the delegated calendar so that the manager also receives copies of meeting requests and responses.
- A delegate creates a recurring meeting in the shared (manager's) calendar.
- The delegate includes themselves as an attendee to the recurring meeting.
- The delegate accepts their own invitation as an attendee.
- The delegate modifies the time of one instance of the recurring meeting to create a meeting recurrence exception, and then sends the update.
- The delegate accepts their own updated invitation as an attendee.
- The manager receives the delegate's **Accepted** response.

In this scenario, the manager's meeting exception time reverts to the original recurring meeting time.

## Cause

This issue occurs when Outlook processes the **Accepted** response before calendar synchronization is complete. This is a known limitation in Outlook 2019, Outlook 2016, and Outlook for Microsoft 365.

## Workaround

You might avoid this issue if you provide enough time for Outlook to complete the synchronization of the recurring meeting before you create an exception to the meeting recurrence and send an update for the exception.

## More information

The issue doesn't affect shared calendars that sync by using the [new model of calendar sharing in Outlook for Microsoft 365](https://support.microsoft.com/office/calendar-sharing-in-microsoft-365-b576ecc3-0945-4d75-85f1-5efafb8a37b4). The new model is available only for calendars that are shared between people who use Exchange Online. It's one of the calendar-sharing improvements that are based on the REST protocol. To determine whether your Outlook client is using the updated calendar sharing model, see [Outlook calendar sharing updates](https://support.microsoft.com/office/outlook-calendar-sharing-updates-c3aec5d3-55ce-4cea-84b0-80aab6d8dc26).
