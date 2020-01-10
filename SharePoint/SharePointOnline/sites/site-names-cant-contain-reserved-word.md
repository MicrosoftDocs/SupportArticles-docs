---
title: Site names cannot contain certain reserved words when you create a new subsite
description: This article describes an issue where Site names cannot contain certain reserved words occurs when you try to create a new SharePoint Online subsite, and provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- SharePoint Online
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

This issue occurs because certain paths are reserved in SharePoint Online when you create a subsite on the root or parent site collection. For Office 365 subscriptions (excluding Office 365 Small Business), the following paths are reserved, and users will encounter the error when a site is created at these locations

**For Office 365 subscriptions (excluding Office 365 Small Business):**

- /search

- /admin

- /wpresources

- /sites

- /teams

- /personal

- /portals

**In Office 365 Small Business:**

- /search

- /wpresources

- /sites

- /teams

- /personal

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
