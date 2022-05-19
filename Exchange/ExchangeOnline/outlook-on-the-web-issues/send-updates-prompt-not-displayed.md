---
title: Send updates prompt not displayed
description: This article talks about a behavior change in Outlook on the web when a meeting organizer adds users to or removes users from an existing meeting request.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 159761
ms.reviewer: alinastr, juforan, meshel
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook on the web
search.appverid: MET150
ms.date: 5/19/2022
---
# "Send updates" prompt not displayed when updating meetings

_Original KB number:_ &nbsp; 3197165

When a meeting organizer updates a meeting by adding or removing an attendee, the following notifications are no longer displayed in Microsoft Outlook or Outlook on the web:

- Send updates only to added or deleted attendees.
- Send updates to all attendees.

:::image type="content" source="media/send-updates-prompt-not-displayed/send-update.png" alt-text="Screenshot of the Send update to Attendees prompt with two options.":::

These options were removed from Outlook clients and the code logic was moved to the server. Now when the only change made to an existing meeting is an update to the attendee list, the server automatically sends a meeting update notification to the added or deleted attendees only.

This change affects clients that run Outlook for Windows with the new calendar sharing improvements enabled only. The notifications will continue to be displayed in Outlook for Windows when you edit meetings in your own calendar or when the calendar sharing improvements are disabled.

## More information

- For information about the new calendar sharing improvements in Outlook for Windows, see [Shared calendars updates in Outlook for Windows](https://support.microsoft.com/office/shared-calendars-updates-in-outlook-for-windows-7b856d16-840f-41cc-997d-a95dab7a6414).
- For information about the different types of updates, see [About meeting requests as informational updates and full updates](/office/client-developer/outlook/auxiliary/about-meeting-requests-as-informational-updates-and-full-updates).
- For the differences in calendar sharing among Outlook clients, see [Calendar sharing in Microsoft 365](https://support.microsoft.com/office/calendar-sharing-in-microsoft-365-b576ecc3-0945-4d75-85f1-5efafb8a37b4).
