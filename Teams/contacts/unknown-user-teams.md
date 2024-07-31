---
title: User appears as Unknown User in Teams
description: Describes a by-design behavior where a user appears as Unknown User in Teams when their account is deleted, or disabled and then re-enabled.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:Teams People & Presence\Contact Card
  - CI 192483
  - CSSTroubleshoot
ms.reviewer: sreeps,amgordon
appliesto: 
  - New Microsoft Teams
  - Classic Microsoft Teams
search.appverid: 
  - MET150
ms.date: 07/31/2024
---
# User appears as Unknown User in Teams

The following types of user accounts in your organization are displayed as **Unknown User** in Microsoft Teams:

- Deleted user accounts
- Disabled and then re-enabled user accounts

This behavior is by design.  

When a user account is deleted from your organization, the display name will appear as **Unknown User** permanently.

When a user account is disabled and then enabled again, the display name will temporarily appear as **Unknown User**. Typically, this behavior lasts for about two weeks before the display name updates automatically.  To speed up the update of the display name after re-enablement, the affected user can sign out of Teams and sign in again. Their display name will update after 72 hours.
