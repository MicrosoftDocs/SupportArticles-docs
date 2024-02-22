---
title: Relative and absolute URLs for content types across site collections is not supported
description: This article introduces that using relative and absolute URLs for content types across site collections is not supported.
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
  - SharePoint Server
ms.date: 12/17/2023
---

# Using relative and absolute URLs for content types across site collections is not supported

In Microsoft SharePoint Online and SharePoint Server, when you specify the **Document Template** for a site content type by using a URL of an existing document template, make sure that you use the URL of an existing site in the same site collection. A relative or absolute URL to a content type is not supported in the content type syndication scenario.

Specifically, under **Site Content Type** > **Advanced Settings** > **Document Template**, the URL (if any) has to be a URL of an existing content type on the same site collection.

:::image type="content" source="media/relative-url-across-site-collection-not-supported/enter-url.png" alt-text="Screenshot of Enter the URL for Document Template in Site Content Type option in Advanced Settings page.":::

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
