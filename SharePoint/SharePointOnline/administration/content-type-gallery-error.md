---
title: Unexpected error in SharePoint admin center Content type gallery
description: Troubleshooting errors when accessing the Content type gallery.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sites\Hub Site
  - CSSTroubleshoot
  - CI 158890
ms.collection: SPO_Content
ms.author: meerak
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Unexpected error in SharePoint admin center Content type gallery

## Symptoms

When you access the Content type gallery in the SharePoint admin center, you receive one of the following error messages:

> An unexpected error has occurred. Please try again later.

> You need permission to access this site.

## Cause

There are many causes of this problem. The most common cause is that permissions for the user or administrator aren't configured or are configured incorrectly.

## Resolution  

To troubleshoot this problem, try the following steps.

**Note** The examples in this article use `contoso` as a placeholder. To navigate to the correct page, replace `contoso` with your organization’s SharePoint domain name.

1. Make sure that the user who is trying to access the Content type gallery is a Global or SharePoint administrator.  

1. If you’re still receiving the error message, go to `https://contoso.sharepoint.com/sites/contenttypehub/_layouts/15/mngsiteadmin.aspx` and verify that the following groups are added as administrators:
    - Company administrator
    - SharePoint service administrator  

1. Add the user as an individual administrator to `https://contoso.sharepoint.com/sites/contenttypehub/_layouts/15/mngsiteadmin.aspx`.
