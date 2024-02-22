---
title: New Outlook for Mac shows private event details in a shared calendar
description: Resolves an issue in which the new Outlook for Mac shows private event details in a shared calendar.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 172845
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: ntateishi, faisal.jeelani, tylewis, meerak, v-trisshores
appliesto: 
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 10/30/2023
---

# New Outlook for Mac shows private event details in a shared calendar

## Symptoms

Consider the following scenario:

1. User A shares their Microsoft Outlook calendar by granting either of the following calendar permissions to their entire organization:

   - Can view all details
   - Can edit

2. User B adds User A's shared calendar by using the new Outlook for Mac.

3. User A creates a private event in their shared calendar. User B doesn't have permissions to see the details of User A's private events.

In this scenario, User B might be able to see the details of the private event if they view User A's shared calendar in Outlook for Mac versions 16.60 to 16.69, inclusive. This issue occurs only in the new Outlook for Mac and is intermittent.

> [!NOTE]
> Mailbox delegates who have permission to see details of a private event are authorized to see details such as the title, description, attendees, and location.

## Resolution

Update the Outlook for Mac version that's used in your organization to 16.69.1 or a later version. For information about Outlook for Mac versions, see [Release history for Office for Mac](/officeupdates/update-history-office-for-mac#release-history-for-office-for-mac).
