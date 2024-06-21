---
title: Troubleshoot unification results
description: Provides troubleshooting steps for unexpected deduplication, match, or merge results in Microsoft Dynamics 365 Customer Insights - Data.
author: wu-allison
ms.author: allisonwu
ms.date: 06/20/2024
ms.reviewer: mhart
ms.custom: sap:Data Unification
---
# Troubleshoot deduplication, match, or merge results in Dynamics 365 Customer Insights - Data

When the [data unification process](/dynamics365/customer-insights/data/data-unification) runs, you might have questions about why specific records were or weren't unified.

This article provides several methods you can use to understand the unification process and troubleshoot unexpected results.

## Method 1: Use customer cards for validation

Select a customer card to view the full customer profile and verify which source records were deduplicated and matched.

In this example, the customer is a result of matching records from all the source tables except **posPurchases**. Additionally, there are records deduplicated in **eCommercePurchases** and **webReviews**.

:::image type="content" source="media/troubleshoot-unification-results/customer-card.png" alt-text="An example of a customer card.":::

## Method 2: Ensure the correct primary key is selected for tables

Selecting the wrong field as the table's [primary key]( /dynamics365/customer-insights/data/data-unification-map-tables#select-primary-key) in the **Customer data** step causes records with the same value for that field to be deduplicated and removed. Ensure the primary key column is that table's actual unique identifier and not a demographic field such as email.

## Method 3: Confirm match rules

Confirm that [deduplication rules](/dynamics365/customer-insights/data/data-unification-duplicates) and [match rules](/dynamics365/customer-insights/data/data-unification-match-tables) are set up correctly. Ensure the correct fields are compared and review the selected normalization patterns.

## Method 4: Verify "Include all records"

Make sure to select the **Include all records** checkbox in the **Matching rules** step. Not selecting the checkbox may cause records from that table that didn't match any other table to be dropped from the final customer profile output.

## Method 5: Check your source data

Confirm that the fields you think are matching contain the same characters. Look for hidden characters and characters that look similar but are different. These issues might be resolved by selecting a normalization pattern for each rule.

Double-check the accuracy and completeness of the data provided for the unification process and ensure all relevant records and information are present.

Cleaning and normalizing the data is essential to ensure reliable outcomes.

- To see source and output tables, see [View a list of tables](/dynamics365/customer-insights/data/tables#view-a-list-of-tables).
- The [data profiling](/dynamics365/customer-insights/data/data-sources#data-profiling) tool analyzes tables, provides insights into data skews, and removes corrupt records from the system.

> [!IMPORTANT]
>
> - Validate that no corrupt records are written to the table called "{Datasource}_{Table}_Corrupt." If corrupt records are present, they aren't processed by unification. For more information about how to resolve the corrupt records, see [Troubleshooting corrupt data](/troubleshoot/dynamics-365/customer-insights/data/data-ingestion/common-data-ingestion-errors).
> - If the columns being deduplicated or matched have low unique counts, they might be skipped by unification for performance reasons. If so, we recommend cleaning the data before ingesting it into Customer Insights - Data.

If there are issues with the source data, resolve them, rerun unification, and revalidate the results. If there are no problems with the source data, continue with the troubleshooting steps.

## Method 6: Examine the output tables

Each step of unification produces system-generated output tables that are available for troubleshooting purposes.

To troubleshoot an unexpected unification result, you can trace these output tables. For more information, see [Troubleshoot unification output tables](troubleshoot-unification-output-tables.md).
