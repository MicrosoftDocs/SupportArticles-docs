---
title: Remove a tentative meeting that's automatically added to your calendar
description: Discusses how to remove the tentative meeting that's automatically created in your Outlook calendar when you receive a meeting invitation.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 184834
ms.reviewer: gbratton, aruiz, meshel, tylewis, meerak, v-trisshores
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
search.appverid: MET150
ms.date: 01/30/2024
---

# Remove a tentative meeting that's automatically added to your calendar

When you receive a meeting invitation, Microsoft Outlook automatically adds the meeting to your calendar as a tentative meeting. If you delete the invitation, the tentative meeting remains in your calendar, and Outlook adds the following entry to the Application log:

```Output
Source: "Outlook"
Event ID: "64"
Level: "Information"
Description: "A meeting request has been deleted but the meeting will remain tentative on the calendar 
until the user either chooses a response or deletes the item directly from the calendar folder. Subject:
<meeting title> ..."
```

If you want to remove the tentative meeting from your calendar, or from the calendar of a mailbox for which you have delegate permissions, follow these steps:

1. Right-click the meeting in the calendar, and then select **Decline** or **Delete**.

2. Select any of the response options.
