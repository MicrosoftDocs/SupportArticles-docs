---
title: Server Error in Application in SharePoint Online
description: This article describes an Server Error in Application error when you browse to a new site collection or subsite in SharePoint Online
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
appliesto:
- SharePoint Online
---

# "Server Error in '/' Application" when you browse to a new site collection or subsite

## Problem

When you create a new SharePoint Online site collection or subsite, and then when you try to access the site, you receive the following error message: 

```adoc
Server Error in '/' Application.

The resource cannot be found.

Description: HTTP 404. The resource you are looking for (or one of its dependencies) could have been removed, had its name changed, or is temporarily unavailable.  Please review the following URL and make sure that it is spelled correctly.
```

## Solution

To resolve this issue, create a site collection or subsite by using a string other than the reserved strings that are listed in the "More Information" section.

> [!NOTE]
> You may want to delete the unusable site that was created that has the reserved string. For more information, see Create or delete a site collection.

## More information

This issue occurs when a site collection or subsite is created that uses one of the following strings as the Web Site Address value when you create the site. The following strings are reserved and aren't supported as the URL path for the site: 

- **CON PRN AUX NUL COM1 COM2 COM3 COM4 COM5 COM6 COM7 COM8 COM9 LPT1 LPT2 LPT3 LPT4 LPT5 LPT6 LPT7 LPT8 LPT9**

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
