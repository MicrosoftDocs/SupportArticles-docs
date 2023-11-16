---
title: Convert from Azure Data Lake data source to Delta Lake data source fails
description: Learn how to address issues when an update from a Data Lake data sources to a Delta Lake data source fails in Dynamics 365 Customer Insights - Data.
author: m-hartmann
ms.author: mhart
ms.reviewer: v-wendysmith, mhart
ms.date: 11/15/2023
---

# Fail to convert from Azure Data Lake data source to Delta Lake data source

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article can resolve issues if you tried to [convert an Azure Data Lake data source to a Delta Lake data source](/dynamics365/customer-insights/data-lake-to-delta-lake) and the process fails.

## Prerequisites

- Your organization has continued to stream the Data Lake Storage data through your pipeline.
- Your organization has maintained the Data Lake Storage manifests and schemas.

## Symptoms

An attempt to convert an Azure Data Lake data source to a Delta Lake data source didn't succeed.

## Resolution

To solve the issue, take the following steps:

1. Go to **Data** > **Data sources**.

1. Select the Azure Data Lake data source and then select **Revert to ADLS**.

   :::image type="content" source="media/revert-to-adls.png" alt-text="Dialog box to enter connection details for Delta Lake.":::

1. Confirm that you want to revert. The **Data sources** page opens showing the new data source in **Refreshing** status.

   > [!IMPORTANT]
   > Don't stop the refreshing process as it could negatively impact reverting the data source.

