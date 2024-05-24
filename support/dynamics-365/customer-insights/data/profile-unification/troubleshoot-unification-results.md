---
title: Troubleshoot unification results
description: Provides troubleshooting steps for unexpected deduplication, match, or merge results for Microsoft Dynamics 365 Customer Insights - Data.
author: Allison-Wu
ms.author: wu-allison
ms.date: 5/24/2024
ms.reviewer: v-wendysmith, mhart
ms.custom: sap:Data Unification\Troubleshoot unification results
---
# Troubleshooting deduplication, match, or merge results in Dynamics 365 Customer Insights - Data

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

## Overview
This article provides the steps to validate the results of deduplication, match, and merge in Microsoft Dynamics 365 Customer Insights - Data.

## Verify source data
Double-check the accuracy and completeness of the data provided for the unification process, ensuring that all relevant records and information are present. It's essential to clean and normalize the data to ensure reliable outcomes.

### Viewing tables
To see source and output tables, see [View a list of tables](https://learn.microsoft.com/en-us/dynamics365/customer-insights/data/tables#view-a-list-of-tables).
### Data profiling
The data profiling tool analyzes tables, providing insights into data skews, and removing corrupt records from the system.

Read more at [Data Profiling](https://learn.microsoft.com/en-us/dynamics365/customer-insights/data/data-sources#data-profiling).

> [!IMPORTANT]
      > Validate that there are no corrupt records, which are written to the table called "Corrupt_[SourceEntityName]". If corrupt records are present, they do not get processed by unification. See how to resolve them at [Troubleshooting corrupt data](https://learn.microsoft.com/en-us/troubleshoot/dynamics-365/customer-insights/data/data-ingestion/common-data-ingestion-errors).
      > If columns being deduplicated or matched on have a low unique count, it is possible they are being skipped by unification for performance reasons. If this is the case, we recommend trying to clean the data prior to ingesting into Customer Insights - Data.

**If there are issues with source data, please resolve them, rerun unification, and re-validate the results. If there are no problems with the source data, continue following the troubleshooting steps below.**

## Step 1: Introduction to output tables
Each step of unification produces system generated output tables that are available for troubleshooting purposes.
|Step|Table|Description|
|----|-----|-----------|
|Deduplication|Deduplication_DataSource_Table|Deduplicated records for each source table|
|Match|ConflationMatchPairs|Represents cross-source table matches|
|Merge|Customer|The final unified customer profile|

To debug an unexpected unification result, you can trace through these output tables.

For detailed descriptions of each output table, see [Understanding output tables](#understanding-output-tables).

## Step 2: Viewing output tables
|Method|Full/Partial|View type|Deduplication|ConflationMatchPairs|Customer|
|------|------------|---------|-------------|--------------------|--------|
|[Export to blob storage](#method-1-export-to-blob-storage)|Full|Download csv/parquet|:white_check_mark:|:white_check_mark:|:white_check_mark:|
|[Download 100k records](#method-2-download-100k-records)|Partial|Download csv|:white_check_mark:|:white_check_mark:|:white_check_mark:|
|[View Dataverse tables](#method-3-view-dataverse-tables)|Full|Dataverse table|||:white_check_mark:|
|[Configure a side process](#method-4-configure-a-side-process)|Full|Download csv|:white_check_mark:|:white_check_mark:|:white_check_mark:|

### Method 1: Export to blob storage
This is the recommended method to view all output tables. 

For each of the output tables, configure an export to Azure Blob Storage. After refreshing all exports, the full tables will be written to blob storage.

See how to configure [Export to blob storage](https://learn.microsoft.com/en-us/dynamics365/customer-insights/data/export-azure-blob-storage).

### Method 2: Download 100k records
Navigate to the "Tables" page in Customer Insights - Data. For each of the output tables, click the "Download" button, which downloads the top 100,000 records of the table. These may or may not contain the records involving your unexpected unification result.

:::image type="content" source="media/data-manager-tables-download.png" alt-text="Download table.":::

### Method 3: View Dataverse tables
If only the Customer table needs to be analyzed, then the most convenient viewing method is through Dataverse.

After each successful Merge run, the Customer gets written to Dataverse as the "CustomerProfile" table. 
Filtering on values can be leveraged to easily find relevant information to the unexpected unification result.

### Method 4: Configure a side process
By recreating the unification configuration on new tables that contain a small subset of problem records of the original tables, we can ensure that the [Download 100k records method](#method-2-download-100k-records) will contain **all** output information.

> [!IMPORTANT]
      > This is the most advanced method, and requires knowing the exact source records that aren't being unified properly.
      > This method involves removing the original tables from unification, so it can be disruptive and will produce completely different customer profiles. **Therefore, we recommend only using this method for non-production instances.**

#### Datasources
Create new tables that only contain a small subset of problem records. Refresh the tables to ingest them into Customer Insights - Data.

#### Remove the original tables from unify
See how to [Remove a unified table](https://learn.microsoft.com/en-us/dynamics365/customer-insights/data/data-unification-update#remove-a-unified-table). If there are downstream dependencies on the Customer table, then those must also be removed.

> [!IMPORTANT]
      > Take note of the original unification configuration so you may re-create it after troubleshooting.

#### Unify the problem tables
1. **Map**: Map the problem tables
2. **Deduplication**: Copy the original deduplication rules to the problem tables
3. **Match**: For each of the problem tables
    - Copy the original matching rules
    - Enable "Include all records" for better debugging
4. **Unified data view**: The default options work well.
5. **Run unification to generate the problem customer profiles**

#### Clean up
After all troubleshooting is complete, remember to recreate the original unification configuration.

If you need help restoring the previous state, please reach out to support.

## Step 3: Resolving unification results
Depending on where your unexpected result is, you may need to verify different output tables. 

### Deduplication
To verify if deduplication is behaving as expected, cross check the following:
- Source data of problematic result
- Deduplication configuration

Make sure to consider all configurations such as normalization, precision, exceptions, and merge preferences.

See an overview of deduplication concepts at [Define deduplication rules](https://learn.microsoft.com/en-us/dynamics365/customer-insights/data/data-unification-duplicates), and examples at [Deduplication concepts and scenarios](https://learn.microsoft.com/en-us/dynamics365/customer-insights/data/data-unification-concepts-deduplication).

### Match
To verify if match is behaving as expected, cross check the following:
- Source data of problematic result
- Related Deduplication records
- Match configuration

Make sure to consider all configurations such as match order, enrichments, normalization, precision, exceptions, custom match conditions, and merge preferences.

See an overview of match concepts at [Define matching rules for data unification](https://learn.microsoft.com/en-us/dynamics365/customer-insights/data/data-unification-match-tables).

### Merge
To verify if merge is behaving as expected, cross check the following:
- Source data of problematic result
- Related Deduplication records
- Related ConflationMatchPairs records
- Merge configuration

Make sure to consider all configurations such as excluded fields, clusters, merge preferences, grouped fields, and custom ID generation.

See an overview of merge behavior at [Unify customer columns for data unification](https://learn.microsoft.com/en-us/dynamics365/customer-insights/data/data-unification-merge-tables), and examples at [Example](https://learn.microsoft.com/en-us/dynamics365/customer-insights/data/data-unification-merge-tables).

## Understanding output tables
### Deduplication tables
The Deduplication tables are the source records deduplicated by the configured deduplication rules, otherwise by the columns involved in matching rules.

|Column    |Type  |Description  |
|----------|------|-------------|
|PrimaryKey|String|The configured primary key for the table.|
|PrimaryKey_Alternate|String|Concatenated list of alternate primary keys identified.|
|DeduplicationGroup ... DeduplicationGroup_N|String|The identifier for the group of similar records based on  a deduplication rule. It's used for system processing purposes. If there are no manual deduplication rules specified and system defined deduplication rules apply, you may not find this field in the deduplication output table.|
|Rule ... Rule_N|String|Which deduplication rules got applied by the matching algorithm.|
|Score ... Score_N|Double|The score returned by the matching algorithm for a rule.|
|Deduplication_WinnerId|String|The winning primary key for the deduplication group.|
|Other mapped fields|Various||

### ConflationMatchPairs table
The ConflationMatchPairs table is the set of matched source records.

|Column    |Type  |Description  |
|----------|------|-------------|
|TrueObjectId|String| The temporary identifier for matched records |
|PrimaryKey ... PrimaryKey_N|String||
|PrimaryKey_Alternate ... PrimaryKey_Alternate_N|String||
|ConflationMatchPairs_ModifiedOn|Date & time||
|Other mapped fields|Various||

### Customer table
The Customer table is the final set of customer profiles.

|Column    |Type  |Description  |
|----------|------|-------------|
|CustomerId|String| The unique guid identifier of the profile |
|PrimaryKey ... PrimaryKey_N|String||
|PrimaryKey_Alternate ... PrimaryKey_Alternate_N|String||
|Unified fields|Various||