---
title: Everyone except external users group is removed on Microsoft 365
description: Works around an issue in which the Everyone except external users group is removed by a managed service account on private group sites.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "Everyone except external users" group is removed on Microsoft 365 private group website

## Symptoms

You notice that the `Everyone except external users` group is removed on a Microsoft 365 private group website after it is converted from a public group.

## Cause

This behavior is by design.

By default, the `Everyone except external users` claim is added to the Members group on public group sites. It will be removed if the group is changed to Private at the time of the conversion.

## Workaround

To work around this behavior, follow these steps:

1. Create a separate SharePoint permissions group.
2. Assign to the new group the same permissions role as that of the original group.
3. Add the `Everyone except external users` group to the new group.

After you make this change, the claim is removed from only the default Members group.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
