---
title: Directives in Robots.txt aren't recognized
description: Describes an issue that occurs when you use the SharePoint Server search engine to crawl various sites.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Search\Crawling
  - CSSTroubleshoot
ms.reviewer: yvand
appliesto: 
  - SharePoint Server 2010
  - SharePoint Server 2013
search.appverid: MET150
ms.date: 12/17/2023
---
# The SharePoint Server crawler ignores directives in Robots.txt

_Original KB number:_ &nbsp; 3019711

## Symptoms

Consider the following scenario:

- You use the Microsoft SharePoint Server 2013 or SharePoint Server 2010 search engine to crawl various sites.
- For those sites, you want to use directives in the Robots.txt file to define the paths that the search engine can crawl.
- You set the following directive for the default user-agent of the crawler:

    User-Agent: Mozilla/4.0 (compatible; MSIE 4.01; Windows NT; MS Search 6.0 Robot)

In this scenario, the SharePoint Server crawler doesn't apply the directive.

## Cause

This issue occurs because the SharePoint Server crawl engine doesn't recognize its default user-agent in the directive.

## Resolution

To resolve this issue, use the following directive in the Robots.txt file:

User-Agent: MS Search 6.0 Robot
