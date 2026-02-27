---
title: Match failed error in Dynamics 365 Customer Insights - Data
description: Provides a resolution for an issue where match failures occur in Microsoft Dynamics 365 Customer Insights - Data.
ms.date: 02/27/2026
ms.reviewer: sstabbert, v-wendysmith
ms.custom: sap:Data Unification\Match
---
# "Match failed" error occurs on the "Deduplication rules" or "Matching rules" page 

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article provides a resolution for an issue where data unification fails due to a deduplication or matching rule failure.

## Symptoms

The following error message appears on the **Deduplication rules** or **Matching rules** page.

> Match failed.

## Cause 1: Failed data refresh

If a data refresh fails, the data might be partially updated, causing inconsistencies in the dataset. The inconsistencies can lead to discrepancies in downstream operations.

### Resolution

To solve the issue, take the following steps:

1. Go to **Data** > **Data sources** and view the status of the data sources used in the data unification process.

1. If any data source failed or hasn't been updated recently, [refresh the data source](/dynamics365/customer-insights/data/data-sources-manage#refresh-data-sources).

1. Rerun the [unification process](/dynamics365/customer-insights/data/data-unification-review).

## Cause 2: Source table changes aren't reflected in Customer Insights - Data

If changes are made to a source table that isn't ingested into Customer Insights - Data, the data is out of synchronization.

### Resolution

To solve the issue, take the following steps:

1. View your source tables for any recent changes.

1. Go to **Data** > **Data sources** and view the data sources and the data reflected in Customer Insights - Data.

1. If the data is out of synchronization, [rerun the ingestion process or refresh the data](/dynamics365/customer-insights/data/data-sources-manage).

1. Rerun the [unification process](/dynamics365/customer-insights/data/data-unification-review).

## Cause 3: Missing data files or partition paths

If you encounter error messages indicating data files or partition paths for specific tables are missing, investigate the cause.

### Resolution

To solve the issue, take the following steps:

1. Verify that the required data files or partition paths exist and are accessible. If they're missing, troubleshoot the data ingestion pipeline or source system to ensure the data is correctly provided to Customer Insights - Data.

1. Rerun the [unification process](/dynamics365/customer-insights/data/data-unification-review).

## Cause 4: Match canceled after running for hours

If the match job failed because it was canceled, the dataset might be too large for the allocated resources.

### Resolution

Reduce the complexity of your match rules or [contact support](/power-platform/admin/get-help-support) for scaling. Learn more in [data unification best practices](/dynamics365/customer-insights/data/data-unification-best-practices).

## Cause 5: Transient issue

Occasionally, a transient issue might cause a processing failure.

### Resolution

To solve the issue, rerun the [unification process](/dynamics365/customer-insights/data/data-unification-review).
