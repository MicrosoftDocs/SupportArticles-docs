---
title: Error when accessing the Files tab
description: Fixes an issue in which you can't access the Files tab in a Teams channel because the Microsoft 365 group associated with the team doesn't have any owner.
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
# "There was a problem reaching this app" error when selecting the Files tab in a Teams channel

This error occurs if the Microsoft 365 group associated with the team doesn't have any owner.

## Resolution

**Note:** The following change must be performed by a Microsoft 365 administrator in your organization.

To resolve this error, assign an owner to the Microsoft 365 group that's associated with the team. For more information, see [Assign a new owner to an orphaned group](https://support.microsoft.com/topic/assign-a-new-owner-to-an-orphaned-group-86bb3db6-8857-45d1-95c8-f6d540e45732).
