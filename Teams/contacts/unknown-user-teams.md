---
title: User appears as Unknown User in Teams
description: Describes a behavior in which a user appears as Unknown User in Teams if their account is deleted or disabled and re-enabled.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
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
- Disabled and re-enabled user accounts

This behavior is by design.  

If a user account is deleted from your organization, the display name will permanently appear as **Unknown User**.

If a user account is disabled and then enabled again, the display name will temporarily appear as **Unknown User**. Typically, this behavior lasts for about two weeks before the display name updates automatically. To force a quicker update of the display name after re-enablement, the affected user can sign out of Teams and sign in again. Their display name will then update after 72 hours.
