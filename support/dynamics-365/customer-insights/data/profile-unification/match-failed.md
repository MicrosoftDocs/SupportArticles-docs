---
title: Match failed error occurs
description: Provides a resolution for an issue where match failures occur in Microsoft Dynamics 365 Customer Insights - Data.
author: Scott-Stabbert
ms.author: sstabbert
ms.date: 11/27/2023
ms.reviewer: v-wendysmith, mhart
ms.custom: bap-template
---

# "Match failed" error occurs

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article can resolve issues if data unification fails due to a deduplication or matching rule failure.

## Symptoms

The following error message displays on the Deduplication rules or Matching rules card on the Data unification page.

> Match failed.

## Cause 1: Failed data refresh

If a data refresh fails, the data might be partially updated introducing inconsistencies in the dataset. The inconsistencies can lead to discrepancies in downstream operations.

### Resolution

To solve the issue, take the following steps:

1. Go to **Data** > **Data sources** and view the status of the data sources used in the data unification process.

1. If any data source failed or has not be updated recently, [refresh the data source.](/dynamics365/customer-insights/data/data-sources-manage#refresh-data-sources)

1. Rerun the [unification process.](/dynamics365/customer-insights/data/data-unification-review)

## Cause 2: Source table changes not reflected in Customer Insights - Data

If changes were made to a source table that weren't ingested into Customer Insights - Data, the data is out of synch.

### Resolution

To solve the issue, take the following steps:

1. View your source tables for any recent changes.

1. Go to **Data** > **Data sources** and view the data sources and the data reflected in Customer Insights - Data.

1. If the data is out of synch, [rerun the ingestion process or refresh the data.](/dynamics365/customer-insights/data/data-sources-manage)

1. Rerun the [unification process.](/dynamics365/customer-insights/data/data-unification-review)

## Cause 3: Missing data files or partition paths

If you encounter error messages indicating missing data files or partition paths for specific tables, investigate the cause.

### Resolution

To solve the issue, take the following steps:

1. Verify the required data files or partition paths exist and are accessible. If they are missing, troubleshoot the data ingestion pipeline or source system to ensure the data is correctly provided to Customer Insights - Data.

1. Rerun the [unification process.](/dynamics365/customer-insights/data/data-unification-review)

## Cause 3: Transient issue

Occasionally a transient issue may cause a processing failure.

### Resolution

Rerun the [unification process.](/dynamics365/customer-insights/data/data-unification-review)