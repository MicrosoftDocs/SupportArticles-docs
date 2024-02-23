---
title: Send updates prompt not displayed
description: Describes a behavior change in Outlook on the web that occurs when a meeting organizer adds or removes users in an existing meeting request.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 159761
ms.reviewer: alinastr, juforan, meshel, tylewis, v-six
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook on the web
search.appverid: MET150
ms.date: 10/30/2023
---

# "Send updates" prompt not displayed when updating meetings

> [!IMPORTANT]
> Based on user feedback, we have reintroduced the "Send updates" prompt in the latest versions of Outlook for Windows. The information in this article doesn't apply to Microsoft 365 Current Channel users running version 2305 (Build 16501.20000) or later.

When a meeting organizer updates a meeting by adding or removing attendees, the following notifications are no longer displayed in Microsoft Outlook:

- Send updates only to added or deleted attendees.
- Send updates to all attendees.

:::image type="content" source="media/send-updates-prompt-not-displayed/send-update.png" alt-text="Screenshot of the Send update to Attendees prompt with two options.":::

These options were removed from Outlook clients, and the code logic was moved to the server. Now, if an update to the attendee list is the only change that's made to an existing meeting, the server automatically sends a meeting update notification to only the added or deleted attendees.

This change affects only clients that run Outlook for Windows that has the new calendar sharing improvements enabled. The notifications will continue to be displayed in Outlook for Windows when you edit meetings in your own calendar or if the calendar sharing improvements are disabled.

## More information

- For information about the new calendar sharing improvements in Outlook for Windows, see [Shared calendars updates in Outlook for Windows](https://support.microsoft.com/office/shared-calendars-updates-in-outlook-for-windows-7b856d16-840f-41cc-997d-a95dab7a6414).
- For information about the different types of updates, see [About meeting requests as informational updates and full updates](/office/client-developer/outlook/auxiliary/about-meeting-requests-as-informational-updates-and-full-updates).
- For the differences in calendar sharing among Outlook clients, see [Calendar sharing in Microsoft 365](https://support.microsoft.com/office/calendar-sharing-in-microsoft-365-b576ecc3-0945-4d75-85f1-5efafb8a37b4).


