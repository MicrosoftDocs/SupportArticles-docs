---
title: Resolve Data Unification Match Failures
description: Resolve the Match failed error in Dynamics 365 Customer Insights - Data caused by refresh failures, source table changes, or missing data files. Fix your unification process today.
ms.date: 03/30/2026
ms.reviewer: sstabbert, v-wendysmith, v-shaywood
ms.custom: sap:Data Unification\Match
---
# "Match failed" error occurs on the "Deduplication rules" or "Matching rules" page

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

## Summary

When you run data unification in Microsoft Dynamics 365 Customer Insights - Data, the process might fail with a "Match failed" error on the **Deduplication rules** or **Matching rules** page. This error can occur for several reasons, including a failed data refresh, source table changes that aren't reflected in Customer Insights - Data, missing data files or partition paths, resource limitations, or transient issues. This article walks through each cause and provides steps to resolve the match failure and successfully complete the unification process.

## Symptoms

The following error message appears on the **Deduplication rules** or **Matching rules** page.

> Match failed.

## Failed data refresh

If a data refresh fails, the data might be partially updated, causing inconsistencies in the dataset. The inconsistencies can lead to discrepancies in downstream operations.

### Solution

To solve the issue, take the following steps:

1. Go to **Data** > **Data sources** and view the status of the data sources used in the data unification process.

1. If any data source failed or hasn't been updated recently, [refresh the data source](/dynamics365/customer-insights/data/data-sources-manage#refresh-data-sources).

1. Rerun the [unification process](/dynamics365/customer-insights/data/data-unification-review).

## Source table changes aren't reflected in Customer Insights - Data

If you make changes to a source table that you don't ingest into Customer Insights - Data, the data is out of synchronization.

### Solution

To solve the issue, take the following steps:

1. Check your source tables for any recent changes.

1. Go to **Data** > **Data sources** and view the data sources and the data reflected in Customer Insights - Data.

1. If the data is out of synchronization, [rerun the ingestion process or refresh the data](/dynamics365/customer-insights/data/data-sources-manage).

1. Rerun the [unification process](/dynamics365/customer-insights/data/data-unification-review).

## Missing data files or partition paths

If you encounter error messages indicating data files or partition paths for specific tables are missing, investigate the cause.

### Solution

To solve the issue, take the following steps:

1. Verify that the required data files or partition paths exist and are accessible. If they're missing, troubleshoot the data ingestion pipeline or source system to ensure the data is correctly provided to Customer Insights - Data.

1. Rerun the [unification process](/dynamics365/customer-insights/data/data-unification-review).

## Match canceled after running for hours

If the match job was canceled after running for an extended period, the dataset might be too large for the allocated resources.

### Solution

To resolve the issue, reduce the complexity of your match rules or [contact support](/power-platform/admin/get-help-support) for scaling options. For more information, see [Data unification best practices](/dynamics365/customer-insights/data/data-unification-best-practices).

## Transient issues

Occasionally, a transient issue causes a processing failure.

### Solution

To resolve the issue, rerun the [unification process](/dynamics365/customer-insights/data/data-unification-review).
