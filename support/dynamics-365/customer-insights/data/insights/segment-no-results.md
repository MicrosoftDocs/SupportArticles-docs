---
title: Segments return no members
description: Learn how to find out why a segment has no members in Dynamics 365 Customer Insights - Data.
author: ashwini-puranik
ms.author: aspuranik
ms.reviewer: mhart, jimsonc
ms.date: 09/25/2023
---
# Segments return no or zero members

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article provides a resolution for an issue where a [segment](/dynamics365/customer-insights/segments) doesn't return any members as expected.

## Prerequisites

- The segment refresh status is successful.
- The segment is newly created or edited, or data import or unification rules or business definition of data have changed.

If the segment was previously successful and had members but is showing zero members and there has been no other change as specified above, please open a support ticket.

## Symptoms

A segment runs and refreshes successfully but doesn't include any members.

## Resolution

You can take the following steps to investigate the root cause and fix the issue.

### Validate basic logic for contradictory conditions or rules

Contradictory `AND` conditions or rules on the same attribute always generate empty segments. For example, `FirstName = Joe` `AND` `FirstName = Frank`.

Review all the rules and conditions for broken logic. Consider more complex contradictions across multiple attributes too (this requires more knowledge of the dataset). For example, `Status = 1` `AND` `StatusDescription = Inactive`, while a status value of **1** always means it's active.

The set operations (`Union`, `Intersect`, and `Except` are used to combine two rules) are applied on the `CustomerId` returned by each rule. So depending on the expected outcome, verify if the `CustomerId` is part (or not) of the result of each rule evaluation.

#### Break down complexity

When working with complex segments with multiple conditions or rules, reduce complexity and isolate the condition or rule responsible for the issue.

- Start from the complete segment and remove conditions and rules one by one. Run the segment after each change until it returns members.
- Build a new segment from scratch and add conditions and rules one by one from the segment that’s yielding no members. Run the segment after each step of adding conditions or rules until no members are returned anymore.

#### Missing data for the attribute(s) used in a segment rule or condition

If the value of the attribute used in a segment rule or condition is missing for any reason, the segment likely returns no members. Check if the expected value exists.

- [Explore table data and attribute values](/dynamics365/customer-insights/entities#explore-a-specific-entitys-data). If available, review the **Summary** column of the attributes you're interested in and ensure they aren't in a **Missing** or **Error** state.

  > [!NOTE]
  > The summary isn't available for system-generated tables and optional for the tables imported from your own Azure Data Lake Storage.

- Check if the source records aren't [rejected for being corrupt](/dynamics365/customer-insights/data-sources-manage#corrupt-data-sources).

- Check if a specific value exists in the table for a given attribute. Create a measure for that table, filtered on the attribute value. Use the **Count** option to see how many records contain the value of the filtering condition. Use the **First** option on the primary key or foreign key to find a reference record.

- To further explore the attribute values in the data, consider the following options:

  - Download the `.csv` file for a table on the table view to validate the first 100,000 records.

  - Use the [Power BI connector](/dynamics365/customer-insights/export-power-bi) to explore the entity in Power BI.

    > [!NOTE]
    > All entities, especially source entities from an Azure Data Lake Storage data source, won't be available with this connector. It's also recommended to use it on tables with less than 1 million rows.

  - Export data to Azure in [Azure Blob Storage](/dynamics365/customer-insights/export-azure-blob-storage), [Azure Data Lake Storage](/dynamics365/customer-insights/export-azure-data-lake-storage-gen2), or [Azure Synapse Analytics](/dynamics365/customer-insights/export-azure-synapse-analytics). Exports can help with further investigations using Synapse Analytics, Power BI, or any other data exploration tool.

  - For Power Query data sources, create a new data source or separate reference query in the existing data source with the filtering condition for the missing attribute. Once refreshed, check if the new table contains any data.

#### Issues with relationships between tables

If the relationship between the table used for segmentation and the unified customer table doesn't work due to the reasons stated below, the segment returns no members.

- Check if the intended [relationship path](/dynamics365/customer-insights/relationships#relationship-paths) is used, as several paths could be technically valid between your source table (with a filtering condition on the attributes) and the *Customer* table. If there are several tables involved, inspect each relationship and validate if they're configured correctly with the right attributes.

- The attribute value evaluation is case-sensitive. For example, two tables are related through a common attribute, `MembershipType`. If the attribute value is **GOLD** in one table and **gold** in the other, it will not yield a successful join and return no results. The same logic applies to `GUIDs`, which are easy to miss.

- Verify that the data types of the attributes align across tables.

- The [deduplication process identifies a "winner" record during data unification](/dynamics365/customer-insights/review-unification#verify-output-tables-from-data-unification). Measures and segments created with the deduplicated profile source table in the relationship path may use the "winner" record, leading to unexpected results.

Segment and measure evaluation happens by joining tables on the attributes defined in the relationships. For example, `MembershipMaster` has a relationship with the *Contact* table, with `MembershipId` and `MembershipType` attributes. The *Contact* table has a relationship with the *Customer* table, containing unified customer profiles over the attributes `ContactId` and `ContactId (Source1_Contact)`. For details about the table relationship, see the screenshot below:

:::image type="content" source="media/segment-no-results/relationship-diagram-segment-no-result.png" alt-text="Screenshot shows a diagram example about the table relationship.":::

If the profile table (in this example, the *Contact* table) is [deduplicated](/dynamics365/customer-insights/remove-duplicates), then the evaluation happens through the "winner" record because of the relationship.

:::image type="content" source="media/segment-no-results/data-example-segment-no-result.png" alt-text="Screenshot shows sample data for the relationship diagram.":::

In this example, contact C1 (with "Gold" membership) and C2 (with "Silver" membership) have been unified with C2 being the winner. Hence, when a segment is created to identify the "Gold" members, "First Person" won't be part of the segment because the relationship path is evaluated only with C2.
