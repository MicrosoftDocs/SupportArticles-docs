---
title: Delta Lake ingestion job failed to get version error
description: Resolves an issue with a Delta Lake version error in Dynamics 365 Customer Insights - Data.
ms.date: 08/22/2024
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.custom: sap:Data Ingestion\Connect to data in Delta format
---
# "Delta Lake ingestion job failed to get version" error

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article helps you resolve the "Delta Lake ingestion job failed to get version" error that might occur when you [connect to data stored in Delta format](/dynamics365/customer-insights/data/connect-delta-lake) in Microsoft Dynamics 365 Customer Insights - Data.

## Symptoms

A Delta data source in Dynamics 365 Customer Insights - Data attempts to connect to a table that is using a feature that requires a Databricks 'minReaderVersion' 3 or later. The following error message appears on the **Data sources** page:

> Delta Lake ingestion job failed to get version DataSourceId.

When you view the columns in the table, the error "Failed to save data source schema" appears.

## Resolution

Customer Insights - Data supports Databricks 'minReaderVersion' 2 or earlier. Remove the feature from your Databricks installation and return the 'minReaderVersion' to 2. Learn more: [Supported Databricks features and versions](/dynamics365/customer-insights/data/connect-delta-lake).
