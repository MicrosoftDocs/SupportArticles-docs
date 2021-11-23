---
title: Unexpected error in SharePoint admin center Content type gallery 
description: Troubleshooting errors when accessing the Content type gallery.
author: v-matthamer
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-solutions
ms.topic: article
ms.custom: 
- CSSTroubleshoot
- CI 158890
ms.collection: SPO_Content
ms.author: v-matthamer
appliesto:
- SharePoint Online
---

# Unexpected error in SharePoint admin center Content type gallery

## Symptoms

When accessing the Content type gallery in SharePoint admin center, you might encounter one of the following errors:

> An unexpected error has occurred. Please try again later.

> You need permission to access this site.

## Cause

There are many causes for this problem, but the most common cause is that permissions for the user or administrator aren't configured or are configured incorrectly.

## Resolution  

To troubleshoot this issue, try the following steps.

**Note** Examples in this article use `contoso` as a placeholder. Replace `contoso` with your organization’s SharePoint domain name to navigate to the correct page.

1. Make sure the user trying to access the Content type gallery is a Global or SharePoint administrator.  

1. If you’re still encountering the error message, go to `https://contoso.sharepoint.com/sites/contenttypehub/_layouts/15/mngsiteadmin.aspx` and verify the following groups are added as administrators:
    - Company administrator
    - SharePoint service administrator  

1. Add the user as an individual administrator to `https://contoso.sharepoint.com/sites/contenttypehub/_layouts/15/mngsiteadmin.aspx`.