---
title: User information isn't updated in Microsoft Teams
description: Describes an issue in which Teams user information is not updated in Teams client. This behavior is by design. 
author: TobyTu
ms.author: kellybos
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.service: o365-proplus-itpro
localization_priority: Normal
ms.custom: 
- CI 124994
- CSSTroubleshoot
ms.reviewer: kellybos
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---

# User information isn't updated in Microsoft Teams

When Microsoft Teams users' attributes like display name, phone number, manager, or profile photo have been updated, the users still see the old information in the Teams client. This behavior is by design.

## More information

The Teams service caches general user information for up to three days. The Teams client also caches general user information locally. For data like display names and phone numbers, it can up to 28 days. For profile picture, it can up to 60 days.   This architecture is designed for capacity and performance optimization.
