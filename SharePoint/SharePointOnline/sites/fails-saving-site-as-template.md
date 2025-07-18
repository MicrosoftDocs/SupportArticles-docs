---
title: Unable to save a site as a template in SharePoint Online or SharePoint Server
description: A site contains apps that don't work in templates when saving it as a template in SharePoint Online or SharePoint Server
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Sites\Site Template
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server 2013
  - SharePoint Server 2016
  - SharePoint Server 2019
ms.date: 12/17/2023
---

# "Sorry, something went wrong" error when you try to save a site as a template in SharePoint Online or SharePoint Server

## Problem

When you try to save a site as a template in SharePoint Online, SharePoint Server 2013, 2016 or 2019, you receive the following error message:

```asciidoc
Sorry, something went wrong
Sorry, this site can't be saved as a template. It contains apps that don't work in templates: 
<name of app, or apps>
```

> [!NOTE]
> The ***name of app or apps*** placeholder represents the actual app name that appears in the error message.

## Solution/Workaround

To work around this issue, remove any affected apps that are listed in the error message, and then save the site as a template. If you want to use the app after you save the site as a template, you'll have to add it to the site again.

> [!NOTE]
> Use caution when you remove apps to make sure that you don't lose any data that's associated with the app.

## More information

This issue occurs if the site contains apps that can't be saved as part of the template.

For more information about how to remove an app from a site, go to [Remove an app from a site](https://support.office.com/article/remove-an-app-from-a-site-03198d1b-c33b-498d-9469-af641a587d6c?ocmsassetID=HA103022226&CorrelationId=f300e60d-751b-4426-9932-42283b1567c6&ui=en-US&rs=en-US&ad=US).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
