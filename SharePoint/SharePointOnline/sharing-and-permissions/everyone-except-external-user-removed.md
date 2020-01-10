---
title: Everyone except external users group is removed on Office 365
description: Works around an issue in which the Everyone except external users group is removed by a managed service account on private group sites.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-online
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- SharePoint Online
- SharePoint Online MSIT
---

# "Everyone except external users" group is removed on Office 365 private group website

## Symptoms

You notice that the "Everyone except external users" group is removed on a Microsoft Office 365 private group website.

## Cause

This behavior is by design.

By default, the "Everyone except external users" claim is added to the Members and Visitors groups on public group sites. If this claim is added to either the Members or Visitors group on a private group site, it may be removed at any time by a managed service account.

## Workaround

To work around this behavior, follow these steps:

1. Create a separate SharePoint permissions group.
2. Assign to the new group the same permissions role as that of the original group.
3. Add the "Everyone except external users" group to the new group.

After you make this change, the claim is removed from only the default Members and Visitors groups. 
