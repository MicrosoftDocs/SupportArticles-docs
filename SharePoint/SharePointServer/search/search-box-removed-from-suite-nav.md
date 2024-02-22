---
title: Search box removed for customers with search control in Suite Nav turned off
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint
ms.custom: 
  - CI 122435
  - CSSTroubleshoot
ms.reviewer: MS aliases for tech reviewers and CI requestor, without @microsoft.com.
description: Customers who switch off the search control in SharePoint Suite Navigation will no longer see the search box.
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

:::image type="content" source="media/search-box-removed-from-suite-nav/search-box-team-site.png" alt-text="Screenshot of the search box on team site page.":::

:::image type="content" source="media/search-box-removed-from-suite-nav/search-box-communication-site.png" alt-text="Screenshot of the search box on communication site page.":::

Starting on September 14, the Suite Navigation search box experience will no longer be provided as part of modern layout pages.
 
:::image type="content" source="media/search-box-removed-from-suite-nav/team-site-without-search-box.png" alt-text="Screenshot of a team site page without search box.":::

:::image type="content" source="media/search-box-removed-from-suite-nav/communication-site-without-search-box.png" alt-text="Screenshot of a communication site page without search box.":::

Note that future static layouts released in SharePoint will also have the search box disabled if the Suite Navigation search box experience is disabled. 

We recommend that you consider updating your training and documentation to direct users to go to the SharePoint Site's home page in order to search.


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).