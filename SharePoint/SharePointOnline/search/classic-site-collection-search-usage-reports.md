---
title: Classic site collection search usage reports
description: This article provides information about usage and popularity reports in SharePoint Online.
author: helenclu
ms.author: luche
ms.custom: 
  - sap:Search\Site Usage Analytics
  - CI 109958
  - CSSTroubleshoot
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: wbaer
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Classic site collection search usage reports

## Introduction

Changes to usage and popularity reports in SharePoint Online help you identify usage trends, determine high and low activity periods, and top queries for individual site collections. Updates to usage reports include five reports that show historical usage information, top queries, abandoned queries, query rule usage, no result queries, and query volume trends for the past 31 days and past 12 months, aligned to the search insights available to Microsoft Search.

## View search usage reports for a site collection

1. From the desired site collection, select **Settings**, and then select **Site settings**.  If you don't see **Site settings**, select **Site information**, and then select **View all site settings**.
2. Under **Site Collection Administration**, select **Microsoft Search** > **Configure search settings** > **Insights**.
3. To retrieve a report, select the name link. Select by date for the past 31 days of usage, or past month for the past 12 months of usage.

### What's new and what's changed with search reports

- The top queries report has two new columns: click count, and Click Through Rate (CTR). For these two new columns, the values will be zero for the past 12 months reports for a couple of months.
- All reports on the search reports page exclude the result source column.
- The site collection search reports will be available for past 31 days instead of past 14 days.
- Usage data on the new search reports page may not exactly match the classic popularity reports due to improvements to search usage reporting with new capabilities.
- Only site collection admins can view search reports data.

## Understand search reports

**Number of Queries**

This report shows the number of search queries performed. Use this report to identify search query volume trends, and to determine times of high and low search activity.

**Top Queries by Day and by Month**

This report shows the most popular search queries. Use this report to understand what types of information visitors are seeking.

**Abandoned Queries by Day and by Month**

This report shows popular search queries that received low clickthrough. Use this report to identify search queries that might create user dissatisfaction and to improve the discoverability of content. Then, consider using query rules to improve the query's results.

**No Result Queries by Day and by Month** 

This report shows popular search queries that returned no results. Use this report to identify search queries that might create user dissatisfaction and to improve the discoverability of content. Then, consider using query rules to improve the query's results.

**Query Rule Usage by Day and by Month** 

This report shows how often query rules trigger, how many dictionary terms they use, and how often users click their promoted results. Use this report to see how useful your query rules and promoted results are to users.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
