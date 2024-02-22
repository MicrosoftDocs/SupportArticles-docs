---
title: ERR_INVALID_RESPONSE error when accessing SharePoint site
description: You receive a This site can't be reached error message and error code ERR_INVALID_RESPONSE when you try to access a SharePoint site from your browser or Microsoft Teams.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 144604
  - CI 147050
ms.author: luche
appliesto: 
  - SharePoint Online
  - Microsoft Teams
ms.date: 12/17/2023
---

# "This site can't be reached" and ERR_INVALID_RESPONSE error when accessing a SharePoint site

## Symptoms

When you try to access a SharePoint site through Microsoft Teams or your web browser, you  receive the following error message:

>This site can't be reached<br/>
>The webpage at (URL) might be temporarily down or it may have moved permanently to a new web address.<br/>
>ERR_INVALID_RESPONSE

## Cause

The homepage of the SharePoint site might have been deleted.

## Resolution

Check whether the homepage is in the recycle bin or site collection recycle bin. For more information about how to recover files from those locations, see [Restore items in the recycle bin that were deleted from SharePoint or Teams](https://support.microsoft.com/office/restore-items-in-the-recycle-bin-that-were-deleted-from-sharepoint-or-teams-6df466b6-55f2-4898-8d6e-c0dff851a0be).

If the homepage isn't in the recycle bin or site collection recycle bin, do either of the following.

**Make an existing page the homepage**

1. Go to the Site Pages library.

   Example Site Pages library URL:
   `https://contoso.sharepoint.com/SitePages/Forms/ByAuthor.aspx`

1. Select the three vertical dots after the name of the page that you want to use as the homepage.
1. Select **Make homepage**.

**Create a new homepage**

1. Go to the Site Pages library.
1. Select **New** > **Site page**.
1. Enter the page content.
1. Select **Save as draft** > **Publish**.
1. Go back to the Site Pages library, and select the three vertical dots after the page name.
1. Select **Make homepage**.
