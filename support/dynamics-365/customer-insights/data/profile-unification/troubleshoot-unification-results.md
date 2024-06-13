---
title: Troubleshoot unification results
description: Provides troubleshooting steps for unexpected deduplication, match, or merge results for Microsoft Dynamics 365 Customer Insights - Data.
author: wu-allison
ms.author: allisonwu
ms.date: 06/13/2024
ms.reviewer: mhart
ms.custom: sap:Data Unification
---
# Troubleshoot deduplication, match, or merge results in Dynamics 365 Customer Insights - Data

When the [unification process](/dynamics365/customer-insights/data/data-unification) runs, you might have questions as to why specific records were unified, or why specific records weren't unified.

This article provides several methods you can use to understand the unification process and troubleshoot unexpected results.

## Method 1: Use Customer cards for validation

Select a customer card to view the full customer profile and verify what source records were deduplicated and matched.

In this example, the customer is a result of matching records from all the source tables, except **posPurchases.** Additionally, there were records deduplicated in **eCommercePurchases,** and **webReviews.**

:::image type="content" source="media/troubleshoot-unification-results/customer-card.png" alt-text="An example of a customer card.":::

## Method 2: Ensure the correct primary key is selected for tables

Selecting the wrong field as the table's primary key in the Source fields step causes records with the same value for that field to be deduplicated and removed. Ensure the primary key column is the actual unique identifier for that table, and not a demographic field such as email.

## Method 3: Confirm match rules

Confirm deduplication and match rules are set up correctly. Make sure the correct fields are compared and review the selected normalization patterns.

## Method 4: Verify "Include all records"

A unchecked **Include all records** checkbox in the Matching rules step causes records from that table that weren't matched to any other table to be dropped from the final customer profile output.

## Method 5: Check your source data

Confirm fields you think matched do indeed contain the same characters. Look for hidden characters and characters that look similar but are different. These issues may be resolved with normalization patterns selected on each rule.

Double check the accuracy and completeness of the data provided for the unification process, ensuring that all relevant records and information are present.

It's essential to clean and normalize the data to ensure reliable outcomes.

- To see source and output tables, see [View a list of tables](/dynamics365/customer-insights/data/tables#view-a-list-of-tables).
- The [data profiling](/dynamics365/customer-insights/data/data-sources#data-profiling) tool analyzes tables, provides insights into data skews, and removes corrupt records from the system.

> [!IMPORTANT]
>
> - Validate that there are no corrupt records, which are written to the table called "{Datasource}_{Table}_Corrupt". If corrupt records are present, they don't get processed by unification. For more information about how to resolve the corrupt records, see [Troubleshooting corrupt data](/troubleshoot/dynamics-365/customer-insights/data/data-ingestion/common-data-ingestion-errors).
> - If columns being deduplicated or matched on have a low unique count, it's possible they're being skipped by unification for performance reasons. If this is the case, we recommend trying to clean the data prior to ingesting into Customer Insights - Data.

If there are issues with source data, resolve them, rerun unification, and re-validate the results. If there are no problems with the source data, continue following the troubleshooting steps.

## Method 6: Examine the output tables

Each step of unification produces system-generated output tables that are available for troubleshooting purposes.

To troubleshoot an unexpected unification result, you can trace through these output tables. For more information, see [troubleshoot unification output tables](troubleshoot-unification-output-tables.md).