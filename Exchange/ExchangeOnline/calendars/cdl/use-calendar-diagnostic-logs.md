---
title: Use Calendar diagnostic logs to resolve calendar issues
description: Discusses how to use CDLs to resolve calendar issues in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
  - CI 1020
ms.reviewer: mburuiana, shanefe, meerak, v-trisshores
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 10/22/2024
---

# Use Calendar diagnostic logs to diagnose calendar issues

Calendar diagnostic logs (CDLs) contain important calendar-related event data. You can [get](./get-calendar-diagnostic-logs.md) and [analyze](./analyze-calendar-diagnostic-logs.md) the CDLs to diagnose calendar issues.

For example, a meeting organizer might have one of the following questions:

- Who canceled or deleted their meeting?
- Why doesn't their meeting appear in an attendee's calendar?
- Why doesn't an attendee response appear in the meeting organizer's calendar?
- Why were attendees inadvertently removed from a meeting?
- Why is a conference room double-booked?

**Note**: If a user reports a meeting issue to you, consider asking them to [provide you the ID](./get-meeting-id.md) of the meeting in question. The preferred way to get CDLs is by using the meeting ID.
