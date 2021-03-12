---
title: "This site can't be reached" error when accessing SharePoint site
description: You get the error "This site can't be reached" and error code "ERR_INVALID_RESPONSE" when you try to access a SharePoint site from your browser or Microsoft Teams.
author: v-matham
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-matham
appliesto:
- SharePoint Online
- Microsoft Teams
---

# "This site can't be reached" error when accessing SharePoint site

## Symptoms

When you try to access a SharePoint site through Microsoft Teams or your browser, you get the error:

>This site can't be reached<br/>
>The webpage at (URL) might be temporarily down or it may have moved permanently to a new web address.<br/>
>ERR_INVALID_RESPONSE

## Cause

The homepage of the SharePoint site might have been deleted.

## Resolution

Check if the homepage is in the SharePoint Recycle bin or site collection recycle bin. For more information about recovering files from those locations, see [Restore items in the recycle bin that were deleted from SharePoint or Teams](https://support.microsoft.com/office/restore-items-in-the-recycle-bin-that-were-deleted-from-sharepoint-or-teams-6df466b6-55f2-4898-8d6e-c0dff851a0be).

If the homepage is not in the Recycle bin or site collection recycle bin, create a new homepage:

1. Go to the Site Pages library and select **New**.
1. Select **Site page** from the drop-down menu.
1. Create the page.
1. Select **Save as draft** and then **Publish**.
1. Go back to the Site Pages library, and select the three vertical dots after the page name.
1. Select **Make homepage**.