---
title: Can't use column filters on a grid or subgrid, or filtering doesn't work correctly
description: Provides troubleshooting steps for an issue where you can't use column filters on a grid or subgrid, or filtering doesn't work correctly in a Power Apps model-driven app.
ms.reviewer: tapanm, moroch, dinusc
ms.custom: sap:Using grids and lists in model-driven apps
ms.date: 07/04/2024
author: fikaradz
ms.author: fikaradz
---
# Can't use column filters on a grid or subgrid, or filtering doesn't work correctly in a model-driven app

This article provides troubleshooting steps for different scenarios where you can't use column filters on a grid or subgrid, or filtering doesn't work correctly in a Power Apps model-driven app.

## Scenario 1: Column filtering isn't enabled on any of the columns

### Troubleshooting step

Make sure the `enableFiltering` grid property is set to "true". If it's set to "false", check the grid control configuration to make sure the respective **Enable Filtering** property is enabled.

:::image type="content" source="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/enablefiltering.png" alt-text="Screenshot that shows the enableFiltering grid property." lightbox="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/enablefiltering.png":::

## Scenario 2: Column filtering options are missing or disabled on certain columns

### Troubleshooting step

After checking to ensure there's no [custom code](grid-issues.md#steps-to-perform-before-starting-troubleshooting) that affects filtering, use the [Power Apps Monitor tool](/power-apps/maker/monitor-overview) to check the column type.

> [!NOTE]
> Dataverse doesn't support filtering on certain columns. For more information about searchable columns, see [Types of columns](/power-apps/maker/data-platform/types-of-fields). Here's an example of a property type that doesn't support filtering:
> 
> :::image type="content" source="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/property-type-not-support-filtering.png" alt-text="Screenshot that shows an example of a property type that doesn't support filtering." lightbox="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/property-type-not-support-filtering.png":::

## Scenario 3: Column filtering is enabled but not applied correctly

### Troubleshooting step

The most common cause is extra filters are applied to the current view. Use the [Power Apps Monitor tool](/power-apps/maker/monitor-overview) to inspect the fetchXML query (see Image 6) and check all the filters that are shown in the query. Additionally, other filters can be found in:

- [A quick find search](/power-apps/user/quick-find).
- A jump bar filter.

  :::image type="content" source="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/jump-bar-filter.png" alt-text="Screenshot that shows a jump bar filter." lightbox="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/jump-bar-filter.png":::

- Relationships with the parent entity.

  :::image type="content" source="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/show-related-records.png" alt-text="Screenshot that shows the Show related records option.":::

- An entity specific filter (for example, a queues or activity).  

  :::image type="content" source="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/entity-specific-filter.png" alt-text="Screenshot that shows an entity specific filter.":::

- A grid-related filter.

  You can use the [Power Apps Monitor tool](/power-apps/maker/monitor-overview) to inspect grid-related filters (see the following screenshots) and compare them with the final fetchXML query (see Image 6 above). In the following screenshots, the "name like %Coffee%" or "name contains Coffee" grid column filter is used.

  :::image type="content" source="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/grid-related-filter-1.png" alt-text="Screenshot that shows a grid-related filter that's inspected by the monitoring tool." lightbox="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/grid-related-filter-1.png":::

  :::image type="content" source="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/grid-related-filter-2.png" alt-text="Screenshot that shows a grid-related filter.":::
