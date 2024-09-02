---
title: Delta Lake ingestion job failed to get version error
description: Resolves an issue about a Delta Lake version error in Dynamics 365 Customer Insights - Data.
ms.date: 09/02/2024
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.custom: sap:Data Ingestion\Connect to a Power Query data source
---
# "Delta Lake ingestion job failed to get version" error

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article helps you resolve the "Delta Lake ingestion job failed to get version" error that might occur when you [connect to data stored in Delta format](/dynamics365/customer-insights/data/connect-delta-lake) in Microsoft Dynamics 365 Customer Insights - Data.

## Symptoms

A Delta data source in Dynamics 365 Customer Insights - Data attempts to connect to a table that uses a feature that requires a Databricks `minReaderVersion` of `3` or later. In this case, the following error message appears on the **Data sources** page:

> Delta Lake ingestion job failed to get version \<DataSourceId>.

When you view the columns in the table, the "Failed to save data source schema" error appears.

## Cause

Dynamics 365 Customer Insights - Data supports Databricks features with a `minReaderVersion` of `2` or earlier. Databricks features that require Databricks reader version `3` or later aren't supported.

## Resolution

To solve this issue, remove the feature from your Databricks installation and revert the `minReaderVersion` to `2`. For more information, see [Supported Databricks features and versions](/dynamics365/customer-insights/data/connect-delta-lake#supported-databricks-features-and-versions).
