---
title: Data refresh fails and dataflow refresh is skipped
description: Solves the issues with data refresh schedule for Power Query-based data sources in Dynamics 365 Customer Insights - Data.
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.date: 12/25/2023
---
# Data refresh fails and dataflow refresh is skipped

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article provides a resolution for an issue where the Power Query data source isn't refreshed successfully in Microsoft Dynamics 365 Customer Insights - Data.

## Symptoms

Power Query data source processing status is **Completed with errors** and you receive the following error message:

> System triggered refresh succeeded; however, dataflow refresh was skipped because the System refresh settings are not applicable for this datasource. If you want this datasource to be refreshed periodically, please configure the scheduled refresh through "Edit refresh settings" options.

## Cause

Dynamics 365 Customer Insights - Data has two refresh options: system refresh and data source refresh. Power Query-based refresh is set by the owner of each data source. System refresh is set by the administrator and controls the rest of data sources and downstream processes.

The error message means that the system refresh in Customer Insights doesn't refresh Power Query data sources and only copies the previous state of the data source.

## Resolution

To solve this issue, see [The refresh schedule for the Power Query data source is configured by editing the data source settings](/dynamics365/customer-insights/data/schedule-refresh).
