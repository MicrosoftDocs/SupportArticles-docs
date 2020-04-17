﻿---
title: Item not crawled error when you crawl a SharePoint 2016 or 2013 site
description: Fixes an issue in which you receive an "Item not crawled" error when you crawl a SharePoint 2016 or 2013 site.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-powershell
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Server 2016
- SharePoint Server 2013
---

# "Item not crawled" error when you crawl a site  

## Symptoms  

When you try to crawl a SharePoint 2016 or 2013 website, you receive the following error message:

**Item not crawled due to one of the following reasons: Preventive crawl rule; Specified content source hops/depth exceeded; URL has query string parameter; Required protocol handler not found; Preventive robots directive.**        

## Resolution  

To fix this issue, try the following methods in the given order. If one method doesn't fix the issue, try the next method.    

- Examine the crawl rules in the Search service application to make sure that there isn't an existing rule that prevents the site from being crawled. For more information about crawl rules, see [Manage crawl rules in SharePoint Server](https://technet.microsoft.com/library/jj219686.aspx).    
- If you use a Robots.txt file for the site, examine the **User-agent** and **Disallow** settings to make sure that they don't exclude the crawler from the site.    
- If the crawler uses TLS 1.2, make sure that the site supports TLS 1.2. For more information about TLS support, see [Enable TLS and SSL support in SharePoint](https://technet.microsoft.com/library/60913d6d-c069-4dfc-9399-71d5344da4e0%28v=office.16%29.aspx).    
- If the site is in a content source, examine the crawl settings in the content source. For example, examine the page depth and number of server hops.      

## References  

[Manage crawling in SharePoint Server](https://technet.microsoft.com/library/ee792876.aspx)

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
