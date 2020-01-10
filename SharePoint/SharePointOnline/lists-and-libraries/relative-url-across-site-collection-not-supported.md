---
title: Relative URLs for content types across site collections is not supported
description: This article introduces that using relative URLs for content types across site collections is not supported.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
---

# Using relative URLs for content types across site collections is not supported

In Microsoft SharePoint Online, when you specify the **Document Template** for a site content type by using a URL of an existing document template, make sure that you use the URL of an existing site in the same site collection. A relative URL to a content type is not supported in the content type syndication scenario.

Specifically, under **Site Content Type** > **Advanced Settings** > **Document Template**, the URL (if any) has to be an URL of an existing content type on the same site collection.

![Enter the URL for Document Template in Site Content Type: Advanced Settings page](./media/relative-url-across-site-collection-not-supported/enter-url.png)
