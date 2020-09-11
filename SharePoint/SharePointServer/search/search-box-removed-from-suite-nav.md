---
title: "Title goes here"
ms.author: v-todmc
author: mccoybot
manager: dcscontentpm
ms.date: xx/xx/xxxx
audience: Admin|ITPro|Developer
ms.topic: article
ms.service OR ms.prod: see https://docsmetadatatool.azurewebsites.net/allowlists
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- ADD PRODUCT
ms.custom: 
- CI ID
- CSSTroubleshoot 
ms.reviewer: MS aliases for tech reviewers and CI requestor, without "@microsoft.com".  
description: "How to resolve the error "Virus Found" in SharePoint Server 2013 when the antivirus scanner is unavailable ."
---

# Search box removed for customers with Suite Navigation search control turned off

## Summary

Effective September 14, 2020, static layout pages on modern Microsoft SharePoint sites will no longer display the search box for users who do not use the Suite Navigation search box experience in their organization or who have turned off the feature.

## More information

Searching from the home page of the SharePoint website is not affected. Such searches will continue to provide the same results.
After this change takes effect, the following static layout pages will no longer display the search box:

- **News** (/_layouts/15/news.aspx)
- **Planner** (/_layouts/15/planner.aspx)
- **Events** (/_layouts/15/events.aspx)
- **See-All** (/_layouts/15/seeall.aspx)

Before September 14, users who opted out of the Suite Navigation search box experience will continue to see a search box on their layout pages. For team sites, the search box appears over the navigation pane. For communication sites, it appears on the site header.

:::image type="content" source="media/search-box-removed-from-suite-nav/search-box-removed-from-suite-nav-1.png" alt-text="Team site search box.":::

:::image type="content" source="media/search-box-removed-from-suite-nav/search-box-removed-from-suite-nav-2.png" alt-text="Communication site search box.":::

Starting on September 14, the Suite Navigation search box experience will no longer be provided as part of modern layout pages.
 
:::image type="content" source="media/search-box-removed-from-suite-nav/search-box-removed-from-suite-nav-3.png" alt-text="Team site without search box.":::

:::image type="content" source="media/search-box-removed-from-suite-nav/search-box-removed-from-suite-nav-4.png" alt-text="Commmuniation site without search box.":::


We recommend that you consider updating your training and documentation to direct users to go to the SharePoint home page in order to search.


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).