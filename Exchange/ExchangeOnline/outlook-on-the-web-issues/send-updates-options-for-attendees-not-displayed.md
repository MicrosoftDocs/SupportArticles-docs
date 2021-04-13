---
title: Send updates options for attendees not shown
description: This article talks about a behavior change in Outlook on the web when a meeting organizer adds users to or removes users from an existing meeting request.
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: alinastr
appliesto:
- Exchange Online
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2016 Standard Edition
search.appverid: MET150
---
# Send updates options for attendees are not displayed in Outlook on the web

_Original KB number:_ &nbsp; 3197165

## More information

When a meeting organizer updates a meeting by adding or removing an attendee, the following notifications are no longer displayed in Outlook on the web:

- Send updates only to added or deleted attendees
- Send updates to all attendees

These options were removed from Outlook on the web, and the code logic was moved to the server. Therefore, the server makes the decision about whether to send the update to all attendees or only to attendees that are added or deleted.

> [!NOTE]
> This change affects only Outlook on the web. These notifications are displayed in Microsoft Outlook when a meeting organizer adds or removes attendees from an existing meeting request.

### Two kinds of updates

There are two kinds of updates: an update that requires a response and an informational update.

By default, updates are not sent to all recipients but only to the specific adjusted recipients (added or deleted attendees).

**Updates are sent to all recipients for single and recurrence meetings when one of the following items is changed:**

- Location field
- Message body
- Attachments

These updates are informational, and they do not require the recipient to process (accept/decline/tentative).

**Updates are sent to all recipients to be processed when one of the following changes occurs:**

- Start/end date or time changes
- Recurrence pattern changes
- Instance of a recurrence pattern changes
- Instance or series cancellations

These updates require a response, and they do require the recipient to process (accept/decline/tentative).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
