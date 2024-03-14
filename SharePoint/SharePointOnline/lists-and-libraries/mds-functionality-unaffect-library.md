---
title: Minimal Download Strategy doesn't work as expected for library
description: Minimal Download Strategy (MDS) doesn't work for SharePoint document library even it's Active for the site.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Minimal Download Strategy feature isn't used for a SharePoint Online list or library

## Problem

Consider the following scenario:

- You're using the classic view for a SharePoint Online list or library.
- The Minimal Download Strategy feature is Active for the site.

In this scenario, the Minimal Download Strategy (MDS) isn't used for the document library, and its functionality doesn't affect the library as expected.

## Solution

This is the expected behavior in SharePoint Online. This issue occurs because MDS isn't supported on lists and libraries that use the new experience. Therefore, MDS has been disabled on lists and libraries that use the classic experience so that there aren't unnecessary redirects between pages that use the classic experience and those that use the new experience.

## More information

For more information, see [Differences between the new and classic experiences for lists and libraries](https://support.office.com/article/differences-between-the-new-and-classic-experiences-for-lists-and-libraries-30e1aab0-a5cc-4363-b7f2-09e2ae07d4dc).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
