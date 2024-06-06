---
title: Troubleshoot unification results
description: Provides troubleshooting steps for unexpected deduplication, match, or merge results for Microsoft Dynamics 365 Customer Insights - Data.
author: wu-allison
ms.author: allisonwu
ms.date: 5/24/2024
ms.reviewer: v-smithwendy, mhart
ms.custom: sap:Data Unification\Troubleshoot unification results
---
# Troubleshoot deduplication, match, or merge results in Dynamics 365 Customer Insights - Data

## Overview
When unification runs, you may have questions as to why specific records were unified, or why specific records weren't unified. 
 
This article provides several methods you can use to understand the unification process and troubleshoot unexpected results.

## Summary
Below is a list of approaches for investigating unexpected results. 
1.	Use Customer cards for validation

    Click a customer card to view the full customer profile and verify what source records were matched in the deduplication step, and what source records from different tables were then matched.

    In this example, the Customer is a result of matching the first 3 source entities, but not the last one "posPurchases".

    :::image type="content" source="media/customer-card.png" alt-text="Example Customer card.":::

1.	Ensure the correct Primary Key is selected for tables

    Selecting the wrong field as the table’s primary key in the Source fields step will cause all records with the same value for that field to be deduplicated and removed. Ensure the primary key column is the actual unique identifier for that table, and not a demographic field such as email.

1.	Check your source data

    Confirm fields you think should have matched do indeed contain the same characters. Look for hidden characters and characters that look similar but are actually different. These issues may be resolved with normalization patterns selected on each rule.

    See [verify source data](#verify-source-data) for guidance.

1.	Confirm match rules

    Confirm deduplication and match rules are set up correctly. Are the correct fields being compared? Are normalization patterns selected?

1.	Verify your use of “Include all records”

    A deselected ‘Include all records’ checkbox in the Matching rules step will cause all records from that table that were not matched to any other table to be dropped from the final customer profile output. 

1.	Examine the output tables

    Each step of unification produces system generated output tables that are available for troubleshooting purposes.

    To debug an unexpected unification result, you can trace through these output tables.

    See [troubleshoot unification output tables](/troubleshoot/dynamics-365/customer-insights/data/profile-unification/troubleshoot-unification-output-tables.md)


## Verify source data
Double-check the accuracy and completeness of the data provided for the unification process, ensuring that all relevant records and information are present.

It's essential to clean and normalize the data to ensure reliable outcomes.

### Viewing tables
To see source and output tables, see [View a list of tables](/dynamics365/customer-insights/data/tables#view-a-list-of-tables).
### Data profiling
The data profiling tool analyzes tables, providing insights into data skews, and removing corrupt records from the system.

Read more at [Data Profiling](/dynamics365/customer-insights/data/data-sources#data-profiling).

> [!IMPORTANT]
> - Validate that there are no corrupt records, which are written to the table called "{Datasource}_{Table}_Corrupt". If corrupt records are present, they do not get processed by unification. See how to resolve them at [Troubleshooting corrupt data](/troubleshoot/dynamics-365/customer-insights/data/data-ingestion/common-data-ingestion-errors).
> - If columns being deduplicated or matched on have a low unique count, it is possible they're being skipped by unification for performance reasons. If this is the case, we recommend trying to clean the data prior to ingesting into Customer Insights - Data.

**If there are issues with source data, please resolve them, rerun unification, and re-validate the results. If there are no problems with the source data, continue following the troubleshooting steps.**
