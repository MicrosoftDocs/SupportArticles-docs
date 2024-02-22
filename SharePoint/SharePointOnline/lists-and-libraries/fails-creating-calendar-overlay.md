---
title: Unexpected error when creating a calendar overlay
description: Sorry, something went wrong or An unexpected error has occurred when creating a calendar overlay by using a calendar from a SharePoint Online subsite.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Error in SharePoint Online when you create a calendar overlay

## Problem

When you try to create a calendar overlay in Microsoft SharePoint Online by using a calendar from a SharePoint Online subsite, you receive the following error message: 

```adoc
Sorry, something went wrong

An unexpected error has occurred.
```

## Solution

To fix this issue, remove the ampersand (&) from the site that contains the calendar from which you want to create the calendar overlay. To do this, follow these steps:

1. Browse to the site that contains the ampersand in the URL.
1. Click the gear icon for the **Settings** menu, and then click **Site settings**.
1. In the **Look and Feel** section, click **Title, description, and logo**.
1. Remove the ampersand (&) from the **Web Site Address** field, and then click **OK**.
1. Create the calendar overlay by using the new URL.

> [!note]
> - To change the URL while at the root level of a classic or Modern site, you must change the site address. For more information, see [Change a site address](/sharepoint/change-site-address). (Note that navigation on a Modern site is not shown by default.)
> - The title, description, and logo settings page can be accessed directly by browsing to `https://contoso.sharepoint.com/web1/_layouts/15/prjsetng.aspx` (where "contoso" is your website).


## More information

This issue occurs when the site that contains the calendar that you're creating the calendar overlay from contains an ampersand (&) in the URL.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).