---
title: Segments return no members
description: Learn how to identify the root cause when a segment has no members in Dynamics 365 Customer Insights.
author: ashwini-puranik
ms.author: aspuranik
ms.reviewer: mhart
ms.date: 03/08/2023
---

# Segments return no members

This article provides functional guidance to identify the root cause when a segment returns with no members. Use this troubleshooting guide when you expect the segment to return members but it doesn't.

## Prerequisites

- Segment refresh status is successful.
- Last refresh date is within one day.

## Symptoms

Segment runs and refreshes successfully but doesn't include any members.

## Resolution

Take the following steps to investigate the root cause of the issue.

### Validate basic logic for contradictory conditions/rules

Contradictory AND conditions or rules on same attribute always generate empty segments. For example, FirstName = Joe AND FirstName = Frank.

Review all the rules and conditions for broken logic. Consider more complex contradictions across multiple attributes too, which requires more knowledge of the dataset. For example, Status = 1 AND StatusDescription = Inactive, while a status value of 1 always means it's active.

### Break down complexity

When working with complex segments with multiple conditions or rules, reduce complexity and isolate the condition or rule responsible for the issue.

- Rebuild the segment from scratch. Add conditions and rules one by one. Run the segment after each step, until no members are returned anymore.
- Start from the complete segment and remove conditions and rules one by one. Run the segment after each change until it returns members.

### Missing data for the attribute/s used in Segment Rule or Condition

If the value of the attribute used in a segment rule or condition is missing for any reason, the segment likely returns no members. Check if the expected value exists.

- [Explore table data and attribute values](/dynamics365/customer-insights/entities#explore-a-specific-entitys-data). If available, review the 'Summary' of attributes you're interested in and ensure they aren't in *Missing* or *Error* state.

  > [!NOTE]
  > The summary isn't available for system-generated tables and optional for tables imported you own Azure Data Lake Storage

- Check if the source records aren't [rejected for being 'corrupt'](/dynamics365/customer-insights/data-sources#corrupt-data-sources).

- Check if a specific value exists in the table for a given attribute. Create a measure for that table, filtered on the attribute value. Use the *Count* option to see how many records contain the value of the filtering condition. Use the *First* option on the primary key or foreign key to find a reference record.

- To further explore the attribute values in the data, consider the following options:

  - [Download the .csv for a table on the table view](/dynamics365/customer-insights/entities) to validate the first 100,000 records.

  - Use the [Customer Insights Power BI connector](/dynamics365/customer-insights/export-power-bi) to explore the Customer Insights entity in Power BI.

    > [!NOTE]
    > All entities, especially source entities from an Azure Data Lake Storage data source, won't be available with this connector. It's also recommended to use on tables with less than 1 million rows.

  - Export data to Azure in a [Azure Blob Storage](/dynamics365/customer-insights/export-azure-blob-storage), [Azure Data Lake Storage](/dynamics365/customer-insights/export-azure-data-lake-storage-gen2), or [Azure Synapse Analytics](/dynamics365/customer-insights/export-azure-synapse-analytics), which can help with further investigations using Synapse Analytics, Power BI, or any other data exploration tool.

  - For Power Query data sources, create a new data source or separate reference query in the existing data source with the filtering condition for the missing attribute. Once refreshed, check if the new table contains any data.

### Issues with relationships between tables

If the relationship between the table used for segmentation and the unified customer table doesn't work, the segment returns no members.

- Check if the intended [relationship path](/dynamics365/customer-insights/relationships#relationship-paths) is used as several paths could be technically valid between your source table (with filter condition on attribute) and the *Customer* table. If there are several tables involved, inspect each relationship and validate if they're configured correctly with the right attributes.

- The attribute value evaluation is case-sensitive. For example, two tables are related through a common attribute *MembershipType*. If the attribute value is *GOLD* in one table and *gold* in the other table, it will not yield successful join and return no results. That's also true for GUIDs, which is easy to miss.

- Verify the data types of the attributes align across tables.

- The [deduplication process identifies a “winner” record during data unification](/dynamics365/customer-insights/review-unification#verify-output-entities-from-data-unification). Measures and segments created where the deduplicated profile source table in the relationship path, may use the “winner” record, leading to unexpected results.

Segment and measure evaluation happens by joining tables on the attributes defined in the relationships. For example, *MembershipMaster* has a relationship with the *Contact* table with *MembershipId* and *MembershipType* attributes. The *Contact* table has a relationship with the *Customer* table, containing unified customer profiles over the attribute *ContactId* and *ContactId (Source1_Contact)*.

:::image type="content" source="../media/relationship-diagram-segment-no-result.png" alt-text="Table relationship diagram example.":::

If the profile table (in this example *Contact*) is [deduplicated](/dynamics365/customer-insights/remove-duplicates), then the evaluation happens through the "winner" record because of the relationship.

:::image type="content" source="../media/data-example-segment-no-result.png" alt-text="Sample data for relationship diagram.":::

In this example, contact C1 (with Gold membership) and C2 (with Silver membership) have been unified with C2 being the winner. Hence when a segment is created to identify 'Gold' members, 'First Person' will not be the part of the segment because the relationship path is evaluated only with C2.
