---
title: Cross-domain iframe requests are blocked in SharePoint Online
description: Describes an issue in which cross-domain iframe requests are blocked in SharePoint Online.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Sites\Error 404: Site Unavailable
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Cross-domain `iframe` requests are blocked in SharePoint Online

## Problem

Cross-domain `iframe` requests to SharePoint Online organizations are blocked.

## Solution

This issue occurs when one of the following conditions is true:

- You're displaying SharePoint Online pages on an external site through an `iframe`.
- You're displaying SharePoint Online pages on a SharePoint Online site that uses a different domain through an `iframe`.

## More information

For more information about `iframing` SharePoint-OnPrem-hosted pages in applications, go to [`IFraming` SharePoint-OnPrem-hosted pages in apps](/archive/blogs/officeapps/iframing-sharepoint-hosted-pages-in-apps).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
