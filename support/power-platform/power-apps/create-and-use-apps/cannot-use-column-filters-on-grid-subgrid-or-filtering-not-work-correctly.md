---
title: Can't use column filters on a grid or subgrid, or filtering doesn't work correctly
description: Fixes an issue in which you can't use column filters on a grid or subgrid, or filtering doesn't work correctly in a Power Apps model-driven app.
ms.reviewer: tapanm, moroch, dinusc
ms.custom: sap:Using grids and lists in model-driven apps
ms.date: 07/04/2024
author: fikaradz
ms.author: fikaradz
---
# Can't use column filters on a grid or subgrid, or filtering doesn't work correctly

## Scenario 1: Column filtering isn't enabled on any of the columns

### Resolution

Make sure the `enableFiltering` grid property is set to "true". If it is set to "false", then check the grid control configuration to make sure the respective **Enable Filtering** property is enabled.

:::image type="content" source="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/enablesorting.png" alt-text="Screenshot that shows the enableFiltering grid property.":::

## Scenario 2: Column filtering options are missing or disabled on certain columns

After checking to ensure there's no [custom code](grid-issues.md#steps-to-perform-before-starting-troubleshooting) that affects filtering, use the [Power Apps Monitoring tool](/power-apps/maker/monitor-overview) to check the column type.

> [!NOTE]
> Dataverse doesn't support filtering on certain columns. For more information about searchable columns, see [Types of columns](/power-apps/maker/data-platform/types-of-fields). An example of a property type that doesn't support filtering:
> 
> :::image type="content" source="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/property-type-not-support-filtering.png" alt-text="Screenshot that shows an example of a property type that doesn't support filtering.":::

## Scenario 3: Column filtering is enabled but not applied correctly

The most common case for this issue is extra filters that are applied to the current view. Use the [Power Apps Monitoring tool](/power-apps/maker/monitor-overview) to inspect the fetchXML query (see Image 6). Review all the filters that are present in the query. Other filters can be present from:

1. [Quick find search](/power-apps/user/quick-find).
2. Jump bar filters.

   :::image type="content" source="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/jump-bar-filter.png" alt-text="Screenshot that shows a jump bar filter.":::

3. Relationships with the parent entity.

   :::image type="content" source="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/show-related-records.png" alt-text="Screenshot that shows the Show related records option.":::

4. Entity specific filters (for example, queues or activities).  

   :::image type="content" source="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/entity-specific-filter.png" alt-text="Screenshot that shows an entity specific filter.":::

The [Power Apps Monitoring tool](/power-apps/maker/monitor-overview) can be used to inspect grid-related filters (see the screenshots below) and compare them with the final fetchXML query (see Image 6 above). In the following screenshots, the "name like %Coffee%" or "name contains Coffee" grid column filter is used.

:::image type="content" source="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/grid-related-filter-1.png" alt-text="Screenshot that shows a grid-related filter that's inspected by the monitoring tool.":::

:::image type="content" source="media/cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly/grid-related-filter-2.png" alt-text="Screenshot that shows a grid-related filter.":::
