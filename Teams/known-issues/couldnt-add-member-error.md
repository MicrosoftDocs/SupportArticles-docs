---
title: We couldn't add member error when adding users to Teams
ms.author: v-todmc
author: todmccoy
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

Still need help? Go to [Microsoft Community](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fanswers.microsoft.com%2F&data=02%7C01%7Cv-todmc%40microsoft.com%7C98910814456c474880f108d7cf62d97d%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637205895885805857&sdata=9%2FYStDGvrU5ZIYXB7guowmaPlKazab0U%2BTpiBIItDaQ%3D&reserved=0).