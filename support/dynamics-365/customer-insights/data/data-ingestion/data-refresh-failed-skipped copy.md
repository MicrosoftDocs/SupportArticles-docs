---
title: Data ingestion from Azure Data Lake doesn't pick up latest data source folder
description: Troubleshoot issues with data ingestion from Azure Data Lake Storage.
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.date: 11/22/2023
---

# Data ingestion from Azure Data Lake doesn't pick up latest data source folder

## Symptoms

The data folder points to an older folder instead of picking up the latest folder while reading data.

## Resolution

Review your data folder path, select the most recent folder, and run a full refresh.

Customer Insights - Data also supports incremental ingestion for Azure Delta Lake Storage. For more information, see [Incremental refresh for Power Query and Data Lake Storage data sources](/dynamics365/customer-insights/data/incremental-refresh-data-sources).

When setting up incremental ingestion, make sure that the year, month, day, and hour folders are expected to be four and two digits respectively. Pay close attention at the manifest file to ensure that all the traits are placed correctly.
