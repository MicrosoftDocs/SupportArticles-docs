---
title: Modern Advanced Find doesn't work correctly in a model-driven app
description: Troubleshoots issues where the Modern Advanced Find feature doesn't work correctly in a Power Apps model-driven app.
ms.reviewer: tapanm, moroch, dinusc
ms.custom: sap:Using grids and lists in model-driven apps
ms.date: 07/12/2024
author: fikaradz
ms.author: fikaradz
---
# Modern Advanced Find doesn't work correctly in a model-driven app

This article provides troubleshooting steps for issues where the [Modern Advanced Find](/power-apps/user/advanced-find) feature doesn't work correctly in a model-driven app in Microsoft Power Apps.

## Scenario 1: Some filter conditions reappear again after being deleted

### Troubleshooting step

Check if the automatically reapplied filters are related to the page filters. Some entities (activities and queues) support the page filters (see the following screenshot). Those filters can't be removed from the **Modern Advanced Find** window.

:::image type="content" source="media/modern-advanced-find-not-work-correctly/entity-support-page-filters.png" alt-text="Screenshot of an entity example that supports the page filters." lightbox="media/modern-advanced-find-not-work-correctly/entity-support-page-filters.png":::

## Scenario 2: Some filter conditions aren't rendered correctly

### Troubleshooting step

[Modern Advanced Find](/power-apps/user/advanced-find) currently doesn't support the following conditions:

- The `Date` type fields used with standard operators. The `Date` type fields must be used with field-specific operators. For example, `on` should be `eq`, and `on-or-before` should be `lt`.
- The `in` type conditions. To ensure compatibility with Modern Advanced Find, the `in` type conditions should be replaced with several `eq`. For example,  `[city in "Redmond", "Washington" ]` should be replaced with `[city eq "Redmond" Or city eq "Washington"]`.

## Scenario 3: Unexpected data after applying Modern Advanced Find filters

### Troubleshooting step

1. Use the [Power Apps Monitor tool](/power-apps/maker/monitor-overview) to obtain the [fetchXML](/power-apps/developer/data-platform/use-fetchxml-construct-query) query and the `recordsCount` attribute.

   :::image type="content" source="media/grid-or-subgrid-not-display-all-records/maximum-number-of-rows.png" alt-text="Screenshot of the Maximum number of rows setting that can be used to define the page size for a subgrid.":::

   :::image type="content" source="media/grid-or-subgrid-displays-incorrect-content/gridchecker.png" alt-text="Screenshot that shows the recordsCount attribute." lightbox="media/grid-or-subgrid-displays-incorrect-content/gridchecker.png":::

1. Check all the filters in the fetchXML query and make sure they're all expected.

   :::image type="content" source="media/modern-advanced-find-not-work-correctly/all-filters-in-fetchxml-query.png" alt-text="Screenshot that shows an example of all the filters in a fetchXML query.":::

   If the fetchXML query contains extra filters, check for any extra filters that might be applied. For more information, see [Scenario 3: Column filtering is enabled but not applied correctly](cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly.md#scenario-3-column-filtering-is-enabled-but-not-applied-correctly).
