---
title: Classic usage and popularity reports to be discontinued
description: This article contains information about changes to the SharePoint Online classic usage and popularity reports.
author: AnupamFrancis
ms.custom:
- CI 109958 
- CSSTroubleshoot 
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: anfra
appliesto:
- SharePoint Online
---

# Classic usage and popularity reports to be discontinued

## Introduction

Classic usage and popularity reports are in the process of being removed and will no longer be available after **August 7, 2020**. Instead, users will be able to find site usage data through the modern **Site Usage** report. The data that's represented in the modern **Site Usage** report includes data from both classic and modern sites. 

The popularity reports provide historical data for a period of three years about the usage of your sites, site collections, document libraries, folders, and items. To understand these reports better, review [View Popularity Trends and Most Popular Items](/sharepoint/view-popularity-trends-and-most-popular-items).

## What will happen to the existing data?

The data from the classic popularity reports will not be available after August 7, 2020. If it's required, you can download and save historical data from these reports before August 7, 2020. To learn more about downloading the classic usage reports in Excel, please refer to our [support article](/sharepoint/view-popularity-trends-and-most-popular-items).

>Note: This exercise will affect only the existing classic usage reports. The search reports available in the same location would not be affected as part of this exercise.

## Where can I find my data in the future?

Site usage data for classic sites will no longer be available in popularity reports starting on August 8, 2020. Instead, you can get site usage data from the modern **Site Usage** page. The modern **Site Usage** page will also start supporting the download of data in Excel before the classic reports are removed.

To get usage reports for individual items (list items, documents), you can use the [GetItemAnalytics Graph API](/graph/api/itemanalytics-get).

To see the page, select **Site settings** > **Popularity trends** > **Usage**. You can access usage data for the last 90 days.

Usage data on the modern **Site Usage** page may not exactly match the classic popularity reports. Learn more about the modern [Site Usage](https://support.office.com/article/2fa8ddc2-c4b3-4268-8d26-a772dc55779e) page.

In Office 365, modern site usage reports are supported for worldwide production environments and the reports are not supported for some special cloud deployments. Therefore, customers who use Gallatin (operated by 21Vianet), GCC High or DoD environments cannot access the modern site usage page or the GetItemAnalytics API.

## Have questions?

Please submit your feedback or questions to Message Center post 217998 (MC217998), in the Message Center.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).