---
title: Item not crawled error when you crawl a SharePoint 2016 or 2013 site
description: Fixes an issue in which you receive an Item not crawled error when you crawl a SharePoint 2016 or 2013 site.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Search\Crawling
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2016
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# "Item not crawled" error when you crawl a site  

## Symptoms  

When you try to crawl a SharePoint 2016 or 2013 website, you receive the following error message:

**Item not crawled due to one of the following reasons: Preventive crawl rule; Specified content source hops/depth exceeded; URL has query string parameter; Required protocol handler not found; Preventive robots directive.**        

## Resolution  

To fix this issue, try the following methods in the given order. If one method doesn't fix the issue, try the next method.    

- Examine the crawl rules in the Search service application to make sure that there isn't an existing rule that prevents the site from being crawled. For more information about crawl rules, see [Manage crawl rules in SharePoint Server](/SharePoint/search/manage-crawl-rules).    
- If you use a Robots.txt file for the site, examine the **User-agent** and **Disallow** settings to make sure that they don't exclude the crawler from the site.    
- If the crawler uses TLS 1.2, make sure that the site supports TLS 1.2. For more information about TLS support, see [Enable TLS and SSL support in SharePoint](/SharePoint/security-for-sharepoint-server/enable-tls-and-ssl-support-in-sharepoint-2013).    
- If the site is in a content source, examine the crawl settings in the content source. For example, examine the page depth and number of server hops.      

## References  

[Manage crawling in SharePoint Server](/SharePoint/search/manage-crawling)

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
