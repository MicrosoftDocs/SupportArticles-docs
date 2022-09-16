---
title: User information isn't updated in Microsoft Teams
description: Describes an issue in which Teams user information is not updated in Teams client. This behavior is by design.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 124994
  - CSSTroubleshoot
ms.reviewer: kellybos
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 3/31/2022
---

# User information isn't updated in Microsoft Teams

After user attributes are updated in Microsoft Teams, users continue to see the old information in the Teams client. User attributes include information such as display name, telephone number, manager, and profile photo.

This behavior is by design. 

Teams has a caching scheme that is designed for capacity and performance optimization. The Teams service caches general user information for up to three days. The Teams client also caches general user information locally. Some data, such as display name and telephone number, can be cached up to 28 days in the client. Profile photos can be cached up to 60 days.

To clear the cache and receive updated information, sign out of Teams and sign back in, or manually [Clear Teams Cache](/microsoftteams/troubleshoot/teams-administration/clear-teams-cache)

