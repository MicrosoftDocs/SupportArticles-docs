---
title: Troubleshoot unification output tables
description: Provides troubleshooting steps for unification output tables for Microsoft Dynamics 365 Customer Insights - Data.
author: wu-allison
ms.author: allisonwu
ms.date: 06/13/2024
ms.reviewer: mhart
ms.custom: sap:Data Unification
---
# Troubleshoot unification output tables in Dynamics 365 Customer Insights - Data

## Introduction to output tables

Each step of the [data unification process](/dynamics365/customer-insights/data/data-unification#data-unification-process) produces system-generated output tables.

To troubleshoot an unexpected unification result, you can trace through these output tables:

|Step|Table|Description|
|----|-----|-----------|
|Deduplication|Deduplication_{Datasource}_{Table}|Deduplicated records for each source table|
|Match|ConflationMatchPairs|Matched records across source tables|
|Merge|Customer|The unified customer profiles|

For detailed descriptions of each output table, see [Understanding output tables](#understanding-output-tables).

## View output tables

|Method|Size|Deduplication|ConflationMatchPairs|Customer|
|------|------------|-------------|--------------------|--------|
|[Download 100k records](#method-1-download-100k-records)|Top 100k|✔|✔|✔|
|[Set up exports](#method-2-set-up-exports)|Full|✔|✔|✔|
|[Create a sandbox environment](#method-3-create-a-sandbox-environment)|Full|✔|✔|✔|

### Method 1: Download 100k records

If there are less than 100k records, you're recommended to use this method.

In Customer Insights - Data, open the **Tables** page. For each of the output tables, select **Download** to get the most recent 100,000 records of the table.

:::image type="content" source="media/troubleshoot-unification-output-tables/data-manager-tables-download.png" alt-text="Screenshot that shows how to download records of an output table.":::

To make sure this method contain all output information, see [Method 3: Create a sandbox environment](#method-3-create-a-sandbox-environment).

### Method 2: Set up exports

Use this method if there are more than 100k records.

For each of the output tables, [set up an export](/dynamics365/customer-insights/data/export-manage#set-up-a-new-export). It's recommended to [export to blob storage](/dynamics365/customer-insights/data/export-azure-blob-storage).

Refresh all exports, then the full tables are written to the configured location.

### Method 3: Create a sandbox environment

[Create a new sandbox environment](/dynamics365/customer-insights/data/create-environment) to recreate the unification configuration on tables that contain a subset of problem records of the original tables.

This step ensures that the [Method 1: Download 100k records](#method-1-download-100k-records) contains all output information.

#### Data sources

Create new tables that only contain a small subset of problem records, we recommend fewer than 100k records.

Refresh the tables to ingest them into Customer Insights - Data.

#### Unify the problem tables

1. Map the problem tables.
2. Copy the original deduplication rules to the problem tables.
3. For each problem table,
    - Copy the original matching rules.
    - Enable **Include all records** for better visibility into the data.
4. In the **Unified data view** step, keep the default configuration.
5. Run unification to generate the customer profiles.

## Resolve unification results

Depending on where your unexpected result is, you might need to verify different output tables.

See an [example of explaining a unification result](#an-example-of-a-unification-result).

### Deduplication

To verify if deduplication is behaving as expected, check:

- Source data of problematic result
- Deduplication configuration

Make sure to consider all configurations such as:

- Normalization
- Precision
- Exceptions
- Merge preferences

See an overview of deduplication concepts at [Define deduplication rules](/dynamics365/customer-insights/data/data-unification-duplicates), and an example at [Deduplication concepts and scenarios](/dynamics365/customer-insights/data/data-unification-concepts-deduplication).

### Match

To verify if match is behaving as expected, check:

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

To verify if merge is behaving as expected, check:

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

See an overview of merge behavior at [Unify customer columns for data unification](/dynamics365/customer-insights/data/data-unification-merge-tables), and [an example](/dynamics365/customer-insights/data/data-unification-merge-tables#example).

## Understanding output tables

### Deduplication tables

The *Deduplication* tables are the source tables deduplicated by the configured rules. If there are no configured rules, the source tables are deduplicated on the columns referenced in match rules.

|Column    |Source|Type  |Description  |
|----------|------|------|-------------|
|PrimaryKey|Source|String|The [configured source primary key](/dynamics365/customer-insights/data/data-unification-map-tables#select-primary-key).|
|PrimaryKey_Alternate|System|String|Concatenated list of primary keys identified for a deduplication group.|
|DeduplicationGroup ... DeduplicationGroup_N|System|String|The identifier for the group of similar records based on deduplication rules.|
|Rule ... Rule_N|System|String|Which deduplication rule the deduplication group got matched on.|
|Score ... Score_N|System|Double|The score returned for the deduplication rule.|
|Deduplication_WinnerId|System|String|The winning primary key for the deduplication group.|
|Other mapped fields|Source|Various|The remaining fields from the source table that are mapped.|

### ConflationMatchPairs table

The *ConflationMatchPairs* table is the set of matched deduplicated records based off the configured rules.

|Column    |Source|Type  |Description  |
|----------|------|------|-------------|
|TrueObjectId|System|String| The temporary identifier for records matched across source tables.|
|PrimaryKey ... PrimaryKey_N|Source|String|The source primary keys that were matched.|
|PrimaryKey_Alternate ... PrimaryKey_Alternate_N|System|String|The alternate keys for the matched source primary keys.|
|ConflationMatchPairs_ModifiedOn|System|Date & time|The timestamp for the most recent change to this matched record.|
|Other matched fields|Source|Various|The remaining fields from the source tables that are mapped.|

### Customer table

The *Customer* table is the final set of customer profiles produced by merging the source columns from *ConflationMatchPairs* based off the unified fields configuration.

|Column    |Source|Type  |Description  |
|----------|------|------|-------------|
|CustomerId|System|String|The unique guid identifier of the profile.|
|PrimaryKey ... PrimaryKey_N|Source|String|The source primary keys that were matched.|
|PrimaryKey_Alternate ... PrimaryKey_Alternate_N|System|String|The alternate keys for the matched source primary keys.|
|Unified fields|Source|Various|The final fields that are determined by applying the unified field configuration to the source fields.|

## An example of a unification result

### Source tables

**MyData_Contact**

|ContactId|FirstName|LastName|Email|
|-|-|-|-|
|1||Thomson|`monica.thomson@contoso.com`|
|2|Monica|Smith|`monica.thomson@contoso.com`|

**MyData_Referral**

|Id|FirstName|LastName|EmailAddress|ReferralDate|
|-|-|-|-|-|
|100|Moni|Thomson|`monica.thomson@contoso.com`|January 1, 2024 12:00 AM|
|200|Monica|Smith|`monica.thomson@contoso.com`|December 24, 2020 12:00 AM|

### Deduplication tables

**Deduplication_MyData_Contact**

If you deduplicate on `Email`:

|ContactId|ContactId_Alternate|Deduplication_GroupId|Rule|Score|Deduplication_WinnerId|FirstName|LastName|Email|
|-|-|-|-|-|-|-|-|-|
|1|1;2|guid()|DedupOnEmail|1.0|1||Thomson|`monica.thomson@contoso.com`|

**Deduplication_MyData_Referral**

If you deduplicate on `EmailAddress`:

|Id|Id_Alternate|Deduplication_GroupId|Rule|Score|Deduplication_WinnerId|FirstName|LastName|EmailAddress|ReferralDate|
|-|-|-|-|-|-|-|-|-|-|
|100|100;200|guid()|DedupOnEmailAddress|1.0|100|Moni|Thomson|`monica.thomson@contoso.com`|January 1, 2024 12:00 AM|

### ConflationMatchPairs table

If you match on `Contact.Email == Referral.Email`:

|TrueObjectId|Contact_ContactId|Contact_ContactId_Alternate|Referral_Id|Referral_Id_Alternate|ConflationMatchPairs_ModifiedOn|Contact_FirstName|Contact_LastName|Contact_Email|Referral_FirstName|Referral_LastName|Referral_EmailAddress|Referral_ReferralDate|
|-|-|-|-|-|-|-|-|-|-|-|-|-|
|1__00|1|1;2|100|100;200|now()||Thomson|`monica.thomson@contoso.com`|Moni|Thomson|`monica.thomson@contoso.com`|January 1, 2024 12:00 AM|

### Customer table

If you set up the unified fields such that:

- *FirstName*: `Contact.FirstName` is prioritized over `Referral.FirstName`.
- *LastName*: `Contact.LastName` is prioritized over `Referral.LastName`.
- *Email*: `Contact.Email` is prioritized over `Referral.EmailAddress`.
- *ReferralDate*: `Referral.ReferralDate` is taken.

|CustomerId|Contact_ContactId|Contact_ContactId_Alternate|Referral_Id|Referral_Id_Alternate|FirstName|LastName|Email|ReferralDate|
|-|-|-|-|-|-|-|-|-|
|guid()|1|1;2|100|100;200|Moni|Thomson|`monica.thomson@contoso.com`|January 1, 2024 12:00 AM|
