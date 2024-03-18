---
title: Site names cannot contain certain reserved words when you create a new subsite
description: This article describes an issue where Site names cannot contain certain reserved words occurs when you try to create a new SharePoint Online subsite, and provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "Site names cannot contain certain reserved words" when you create a new SharePoint Online subsite

## Problem

When you try to create a new SharePoint Online subsite, you receive the following error message:

- Site names cannot contain certain reserved words and cannot begin with an underscore. Please enter a different name.

## Solution/Workaround

To work around this behavior, follow these guidelines:

- Use a different name for the site collection.

- Use a site name that doesn't begin with an underscore.

- Create a subsite from another site instead of from the root or parent site by using a path that isn't a reserved path. Reserved paths are listed in the "More Information" section of this article.

## More information

This issue occurs because certain paths are reserved in SharePoint Online when you create a subsite on the root or parent site collection. For Microsoft 365 subscriptions, the following paths are reserved, and users will encounter the error when a site is created at these locations

**For Microsoft 365 subscriptions:**

- /search

- /admin

- /wpresources

- /sites

- /teams

- /personal

- /portals

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
