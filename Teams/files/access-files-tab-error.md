---
title: Error when accessing the Files tab
description: Fixes an issue in which you can't access the Files tab in a Teams channel because the Microsoft 365 group associated with the team has no owner.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 149476
- CSSTroubleshoot
ms.reviewer: prbalusu
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---
# Error when selecting the Files tab on a Teams channel

## Symptoms

When you select the **Files** tab on a channel in Microsoft Teams, you receive the following error message:

> There was a problem reaching this app

:::image type="content" source="media/access-files-tab-error/access-file-error.png" alt-text="Screenshot of the error when selecting the Files tab.":::

## Cause

This error occurs if the Microsoft 365 group that's associated with the team doesn't have an owner.

## Resolution

**Note:** The following change must be done by a Microsoft 365 administrator in your organization.

Assign an owner to the Microsoft 365 group that's associated with the team. For more information, see [Assign a new owner to an orphaned group](https://support.microsoft.com/topic/assign-a-new-owner-to-an-orphaned-group-86bb3db6-8857-45d1-95c8-f6d540e45732).
