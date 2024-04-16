---
title: Exchange server returned 203 error in mailbox alert
description: The Exchange.server returned 203 error occur in Microsoft Dynamics 365 mailbox alert.
ms.reviewer: 
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Exchange server returned 203 error in Dynamics 365 mailbox alert

This article introduces a warning (Exchange.server returned 203 error) that can normally be ignored in Microsoft Dynamics 365 mailbox alert.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4504933

## Symptoms

When viewing the Alerts section of a mailbox record in Microsoft Dynamics 365, you see the following warning alert:

> Appointments, contacts, and tasks for the mailbox [Mailbox Name] couldn't be synchronized. The owner of the associated email server profile [Profile Name] has been notified. The system will try again later.
>
> Email Server Error Code: Exchange.server returned 203 error.

## Cause

This message can normally be ignored and does not impact synchronization. Microsoft is working on a fix to make this warning less likely to appear. There are still some scenarios were this may appear. One example is when a non-organizer is trying to update required attendees on an appointment.

## More information

If this warning appears but you are not seeing any issues with synchronization, this warning can normally be ignored. As mentioned in the Cause section, Microsoft is working on a fix to reduce how often this appears and it should not impact synchronization.
