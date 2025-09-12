---
title: Grid filter for lookup column not showing any suggestions
description: The grid column filter for the lookup type field doesn't show any record suggestions or says no records found.
author: akshay-viz
ms.author: akmaloo
ms.reviewer: akmaloo
ms.date: 10/10/2024
ms.custom: sap:Using grids and lists in model-driven apps
---
# Grid filter for a lookup column shows no suggestions in a model-driven app

## Symptoms

When you try to [filter data on a lookup column](/power-apps/user/grid-filters#filtering-on-a-lookup-column), you don't see a list of values, or the filter results box says "No Records Found." For example, the filter on the **Parent Business** column doesn't show any results, as shown in the following screenshot.

:::image type="content" source="media/grid-filter-not-showing-any-suggestions/empty-filter-suggestions.png" alt-text="Screenshot of the Parent Business column that doesn't show any values.":::

## Cause 1

The records for this lookup field don't have their primary field populated. Therefore, the filter list is blank.

### Resolution

The records have to populate their primary field.

## Cause 2

The **Lookup View** for the entity that's associated with the column doesn't add the primary field as part of its view, as shown in the following screenshot.

:::image type="content" source="media/grid-filter-not-showing-any-suggestions/primary-field-absent.png" alt-text="Screenshot showing an entity that's associated with the column doesn't have the primary field." lightbox="media/grid-filter-not-showing-any-suggestions/primary-field-absent.png":::

### Resolution

Edit the **Lookup View** for the entity and add the primary field.

:::image type="content" source="media/grid-filter-not-showing-any-suggestions/add-column.png" alt-text="Screenshot of the Add Columns option that you can use to add the primary field for a Lookup View." lightbox="media/grid-filter-not-showing-any-suggestions/add-column.png":::

## More information

[Troubleshooting grid issues in Power Apps](grid-issues.md)
