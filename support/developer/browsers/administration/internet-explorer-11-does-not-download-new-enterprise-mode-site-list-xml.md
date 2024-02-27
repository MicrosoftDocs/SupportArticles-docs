---
title: Internet Explorer 11 doesn't download new Enterprise Mode site list XML file
description: This article provides a resolution for the problem where IE11 can't download a new Enterprise Mode site list XML file.
ms.date: 01/04/2021
ms.reviewer: 
ms.topic: troubleshooting
---
# Can't check for new Enterprise Mode site list XML file in Internet Explorer 11

[!INCLUDE [](../../../includes/browsers-important.md)]

This article helps you resolve the problem where IE11 can't download a new Enterprise Mode site list XML file.

_Applies to:_ &nbsp; Internet Explorer 11 on Windows Server 2012 R2, Internet Explorer 11 on Windows 8.1 Update, Internet Explorer 11 on Windows 10  
_Original KB number:_ &nbsp; 4046798

## Symptom

Consider the following scenario:

- You configured Enterprise Mode Site List for Internet Explorer 11.
- You have the site list XML file hosted on a web server.
- You later update the site list XML file on the web server to a newer version.

In this situation, you encounter the following symptoms:

- Internet Explorer continues to use the old version of the site list XML file and does not download the updated site list from the web server.
- Internet Explorer may take a very long time to download the updated XML file from the web server, or you have to clear the browser cache to download the updated list.  

## Cause

This issue occurs because Internet Explorer may retrieve the site list XML file from the cache. This is due to standard caching rules.  

## Resolution

To fix this issue, control the cache lifetime by specifying response headers that control the caching behavior of the resource. To do this, add a `Cache-Control:no-cache` response header to the content (the site list XML file). This will cause the content to be revalidated with the server every time that it's being referenced.  

## References  

For more information, see [Check for a new Enterprise Mode site list xml file](/internet-explorer/ie11-deploy-guide/check-for-new-enterprise-mode-site-list-xml-file).
