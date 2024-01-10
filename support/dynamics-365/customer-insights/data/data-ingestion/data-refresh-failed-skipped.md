---
title: Data refresh fails and dataflow refresh is skipped
description: Solves an issue with the data refresh schedule for Power Query-based data sources in Dynamics 365 Customer Insights - Data.
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.date: 01/03/2024
---
# Data refresh fails and dataflow refresh is skipped

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article provides a resolution for an issue where the Power Query data source isn't refreshed successfully in Microsoft Dynamics 365 Customer Insights - Data.

## Symptoms

The Power Query data source processing status is **Completed with errors**, and you receive the following error message:

> System triggered refresh succeeded; however, dataflow refresh was skipped because the System refresh settings are not applicable for this datasource. If you want this datasource to be refreshed periodically, please configure the scheduled refresh through "Edit refresh settings" options.

## Cause

Dynamics 365 Customer Insights - Data has two refresh options: [system refresh](/dynamics365/customer-insights/data/schedule-refresh) and [data source refresh](/dynamics365/customer-insights/data/data-sources-manage#refresh-data-sources). Power Query-based refresh is set by the owner of each data source. System refresh is set by the administrator and controls the rest of the data sources and downstream processes.

The error message means that the system refresh in Customer Insights doesn't refresh Power Query data source, but only copies the previous state of the data source.

## Resolution

To solve this issue, [configure the refresh schedule for the Power Query data source by editing the data source settings](/dynamics365/customer-insights/data/schedule-refresh).
