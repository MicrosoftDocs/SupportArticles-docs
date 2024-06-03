---
title: Troubleshoot unification results
description: Provides troubleshooting steps for unexpected deduplication, match, or merge results for Microsoft Dynamics 365 Customer Insights - Data.
author: Allison-Wu
ms.author: allisonwu
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
To see source and output tables, see [View a list of tables](/dynamics365/customer-insights/data/tables#view-a-list-of-tables).
### Data profiling
The data profiling tool analyzes tables, providing insights into data skews, and removing corrupt records from the system.

Read more at [Data Profiling](/dynamics365/customer-insights/data/data-sources#data-profiling).

> [!IMPORTANT]
> - Validate that there are no corrupt records, which are written to the table called "Corrupt_[SourceEntityName]". If corrupt records are present, they do not get processed by unification. See how to resolve them at [Troubleshooting corrupt data](/troubleshoot/dynamics-365/customer-insights/data/data-ingestion/common-data-ingestion-errors).
> - If columns being deduplicated or matched on have a low unique count, it is possible they're being skipped by unification for performance reasons. If this is the case, we recommend trying to clean the data prior to ingesting into Customer Insights - Data.

**If there are issues with source data, please resolve them, rerun unification, and re-validate the results. If there are no problems with the source data, continue following the troubleshooting steps.**

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
This method is recommended.

For each of the output tables, configure an export to Azure Blob Storage. Refresh all exports, then the full tables will be written to blob storage.

See how to configure [Export to blob storage](/dynamics365/customer-insights/data/export-azure-blob-storage).

### Method 2: Download 100k records
Navigate to the "Tables" page in Customer Insights - Data. For each of the output tables, click the "Download" button, which downloads the top 100,000 records of the table. These many not contain the records involving your unexpected unification result.

:::image type="content" source="media/data-manager-tables-download.png" alt-text="Download table.":::

### Method 3: View Dataverse tables
If only the Customer table needs to be analyzed, then the most convenient viewing method is through Dataverse.

After each successful Merge run, the Customer gets written to Dataverse as the "CustomerProfile" table. 
Filtering can be applied to easily find relevant information to the unexpected unification result.

### Method 4: Configure a side process
By recreating the unification configuration on new tables that contain a small subset of problem records of the original tables, we can ensure that the [Download 100k records method](#method-2-download-100k-records) contains **all** output information.

> [!IMPORTANT]
> - This is the most advanced method, and requires knowing the exact source records that aren't being unified properly.
> - This method involves removing the original tables from unification, so it can be disruptive and will produce completely different customer profiles. **Therefore, we recommend only using this method for non-production instances.**

#### Datasources
Create new tables that only contain a small subset of problem records. Refresh the tables to ingest them into Customer Insights - Data.

#### Remove the original tables from unify
See how to [Remove a unified table](/dynamics365/customer-insights/data/data-unification-update#remove-a-unified-table). Downstream dependencies of the Customer table must first be removed.

> [!IMPORTANT]
> Take note of the original unification configuration so you may re-create it after troubleshooting.

#### Unify the problem tables
1. **Map**: Map the problem tables
2. **Deduplication**: Copy the original deduplication rules to the problem tables
3. **Match**: For each problem table
    - Copy the original matching rules
    - Enable "Include all records" for better visibility into the data
4. **Unified data view**: Keep the default configuration
5. **Run unification to generate the problem customer profiles**

#### Clean up
After all troubleshooting is complete, remember to recreate the original unification configuration.

If you need help restoring the previous state reach out to support.

## Step 3: Resolving unification results
Depending on where your unexpected result is, you may need to verify different output tables. 
See an [example of explaining a unification result](#example).

### Deduplication
To verify if deduplication is behaving as expected, cross check the following:
- Source data of problematic result
- Deduplication configuration

Make sure to consider all configurations such as:
- Normalization
- Precision
- Exceptions
- Merge preferences

See an overview of deduplication concepts at [Define deduplication rules](/dynamics365/customer-insights/data/data-unification-duplicates), and examples at [Deduplication concepts and scenarios](/dynamics365/customer-insights/data/data-unification-concepts-deduplication).

### Match
To verify if match is behaving as expected, cross check the following:
- Source data of problematic result
- Related Deduplication records
- Match configuration

Make sure to consider all configurations such as:
- Match order
- Enrichments
- Normalization
- Precision
- Exceptions
- Custom match conditions
- Merge preferences

See an overview of match concepts at [Define matching rules for data unification](/dynamics365/customer-insights/data/data-unification-match-tables).

### Merge
To verify if merge is behaving as expected, cross check the following:
- Source data of problematic result
- Related Deduplication records
- Related ConflationMatchPairs records
- Merge configuration

Make sure to consider all configurations such as:
- Excluded fields
- Clusters
- Merge preferences
- Grouped fields
- Custom ID generation.

See an overview of merge behavior at [Unify customer columns for data unification](/dynamics365/customer-insights/data/data-unification-merge-tables), and [Examples](/dynamics365/customer-insights/data/data-unification-merge-tables#example).

## Understanding output tables
### Deduplication tables
The Deduplication tables are the source tables deduplicated by the configured rules. If there are no configured rules, they're instead deduplicated by the columns referenced in match rules.

|Column    |Source|Type  |Description  |
|----------|------|------|-------------|
|PrimaryKey|Customer|String|The source primary key configured [here](/dynamics365/customer-insights/data/data-unification-map-tables#select-primary-key)|
|PrimaryKey_Alternate|System|String|Concatenated list of primary keys identified for a deduplication group|
|DeduplicationGroup ... DeduplicationGroup_N|System|String|The identifier for the group of similar records based on deduplication rules|
|Rule ... Rule_N|System|String|Which deduplication rule the deduplication group got matched on|
|Score ... Score_N|System|Double|The score returned for the deduplication rule|
|Deduplication_WinnerId|System|String|The winning primary key for the deduplication group|
|Other mapped fields|Source|Various|The remaining fields from the source table that are mapped|

### ConflationMatchPairs table
The ConflationMatchPairs table is the set of matched deduplicated records based off the configured rules.

|Column    |Source|Type  |Description  |
|----------|------|------|-------------|
|TrueObjectId|System|String| The temporary identifier for records matched across source tables|
|PrimaryKey ... PrimaryKey_N|Source|String|The source primary keys that were matched by a match rule|
|PrimaryKey_Alternate ... PrimaryKey_Alternate_N|System|String|The alternate keys for the matched source primary keys|
|ConflationMatchPairs_ModifiedOn|System|Date & time|The timestamp for the most recent change to this matched record|
|Other matched fields|Source|Various|The remaining fields from the source tables that are mapped|

### Customer table
The Customer table is the final set of customer profiles produced by merging the source columns from ConflationMatchPairs based off the unified fields configuration.

|Column    |Source|Type  |Description  |
|----------|------|------|-------------|
|CustomerId|System|String|The unique guid identifier of the profile|
|PrimaryKey ... PrimaryKey_N|Source|String|The source primary keys that were matched by a match rule|
|PrimaryKey_Alternate ... PrimaryKey_Alternate_N|System|String|The alternate keys for the matched source primary keys|
|Unified fields|Source|Various|The final fields that are determined by applying the unified field configuration to the source fields|

## Example

### Source tables
#### MyData_Contact
|ContactId|FirstName|LastName|Email|
|-|-|-|-|
|1||Thomson|monica.thomson@outlook.com|
|2|Monica|Smith|monica.thomson@outlook.com|

#### MyData_Referral
|Id|FirstName|LastName|EmailAddress|ReferralDate|
|-|-|-|-|-|
|100|Moni|Thomson|monica.thomson@outlook.com|January 1, 2024 12:00 AM|
|200|Monica|Smith|monica.thomson@outlook.com|December 24, 2020 12:00 AM|

### Deduplication table
#### Deduplication_MyData_Contact
If we deduplicate on **Email**:

|ContactId|ContactId_Alternate|Deduplication_GroupId|Rule|Score|Deduplication_WinnerId|FirstName|LastName|Email|
|-|-|-|-|-|-|-|-|-|
|1|1;2|guid()|DedupOnEmail|1.0|1||Thomson|monica.thomson@outlook.com|

#### Deduplication_MyData_Referral
If we deduplicate on **EmailAddress**:

|Id|Id_Alternate|Deduplication_GroupId|Rule|Score|Deduplication_WinnerId|FirstName|LastName|EmailAddress|ReferralDate|
|-|-|-|-|-|-|-|-|-|-|
|100|100;200|guid()|DedupOnEmailAddress|1.0|100|Moni|Thomson|monica.thomson@outlook.com|January 1, 2024 12:00 AM|


#### ConflationMatchPairs
If we match on **Contact.Email == Referral.Email**:

|TrueObjectId|Contact_ContactId|Contact_ContactId_Alternate|Referral_Id|Referral_Id_Alternate|ConflationMatchPairs_ModifiedOn|Contact_FirstName|Contact_LastName|Contact_Email|Referral_FirstName|Referral_LastName|Referral_EmailAddress|Referral_ReferralDate
|-|-|-|-|-|-|-|-|-|-|-|-|-|
|1__00|1|1;2|100|100;200|now()||Thomson|monica.thomson@outlook.com|Moni|Thomson|monica.thomson@outlook.com|January 1, 2024 12:00 AM


#### Customer
If we set up the unified fields such that:
- FirstName: We prioritize Contact.FirstName over Referral.FirstName
- LastName: We prioritize Contact.LastName over Referral.LastName
- Email: We prioritize Contact.Email over Referral.EmailAddress
- ReferralDate: We take Referral.ReferralDate

|CustomerId|Contact_ContactId|Contact_ContactId_Alternate|Referral_Id|Referral_Id_Alternate|FirstName|LastName|Email|ReferralDate|
|-|-|-|-|-|-|-|-|-|
|guid()|1|1;2|100|100;200|Moni|Thomson|monica.thomson@outlook.com|January 1, 2024 12:00 AM|