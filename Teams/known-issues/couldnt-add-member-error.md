---
title: We couldn't add member error when adding users to Teams
ms.author: luche
author: helenclu
ms.date: 4/8/2020
audience: ITPro
ms.topic: article
manager: dcscontentpm
ms.service: msteams
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Teams
ms.custom: 
- CI 113425
- CSSTroubleshoot 
ms.reviewer: scapero
description: Describes a workaround for adding members to Teams if you see the "We couldn't add member" error.
---

# Error "We couldn't add member" when adding users to Teams 

## Symptoms

When you add an internal or external member to Teams, you see the following error: 
"We couldn't add member. We ran into an issue. Please try again later." 
However, members can be added directly to Office 365 groups.

## Workaround

This issue occurs when the value **UsersPermissionToReadOtherUsersEnabled** is set to **False** in AAD. To correct the issue, change this setting to **True**.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
