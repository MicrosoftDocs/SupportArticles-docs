---
title: User information isn't updated in Teams
description: Describes an issue in which Teams user information isn't updated in Teams client. This behavior is by design.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Admin\
  - CI124994
  - CI184321
  - CSSTroubleshoot
ms.reviewer: kellybos
appliesto: 
  - Classic Microsoft Teams
  - New Microsoft Teams
search.appverid: 
  - MET150
ms.date: 01/16/2025
---

# User information isn't updated in Teams

After user attributes are updated in Microsoft Teams, users continue to see the old information in the Teams client. User attributes include information such as display name, telephone number, manager, and profile photo.

This behavior is by design. 

Microsoft Teams has a caching scheme that's designed for capacity and performance optimization. The Teams service caches general user information for up to three days. The Teams client also caches general user information locally. Some data, such as display name and telephone number, can be cached for up to 28 days in the client. Profile photos can be cached for up to 60 days.

To clear the cache and receive updated information, sign out of Teams, and then sign back in. Or, manually [clear Teams cache](/microsoftteams/troubleshoot/teams-administration/clear-teams-cache).
