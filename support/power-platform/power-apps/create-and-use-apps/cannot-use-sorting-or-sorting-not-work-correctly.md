---
title: Can't use sorting or sorting doesn't work correctly
description: Fixes an issue in which you can't use sorting or sorting doesn't work correctly in a Power Apps model-driven app.
ms.reviewer: tapanm, moroch, dinusc
ms.custom: sap:Using grids and lists in model-driven apps
ms.date: 07/16/2024
author: fikaradz
ms.author: fikaradz
---
# Can't use sorting or sorting doesn't work correctly in a Power Apps model-driven app

This article helps solve an issue where you can't use sorting or sorting doesn't work correctly in a model-driven app in Microsoft Power Apps.

## Scenario 1: None of the columns are sortable in the grid

### Resolution

Sorting not available on all the columns is a strong indication that sorting is disabled on the grid control. Use the [Power Apps Monitor tool](/power-apps/maker/monitor-overview) to make sure the `enableSorting` grid property is set to `true`.

:::image type="content" source="media/cannot-use-sorting-or-sorting-not-work-correctly/enablesorting.png" alt-text="Screenshot of the enableFiltering grid property." lightbox="media/cannot-use-sorting-or-sorting-not-work-correctly/enablesorting.png":::

If sorting isn't enabled, update the respective grid property value.

## Scenario 2: Sorting doesn't seem to be correct after navigating to the grid or subgrid

### Resolution

If there's no [custom code](grid-issues.md#steps-to-perform-before-starting-troubleshooting) that alters the sorting, the default sorting should correspond to the **Sort by** setting in the current view.

:::image type="content" source="media/cannot-use-sorting-or-sorting-not-work-correctly/sort-by.png" alt-text="Screenshot of the Sort by setting in the current view." lightbox="media/cannot-use-sorting-or-sorting-not-work-correctly/sort-by.png":::

Make sure the view setting is set correctly and all the changes are saved and published.

## Scenario 3: Certain columns aren't sortable in grid. Respective column header menu options are missing or disabled

### Resolution

The most common reason why a certain field isn't sortable is that Dataverse doesn't support sorting on the underlying field type. Use the [Power Apps  tool](/power-apps/maker/monitor-overview) to ensure the sorting isn't disabled by Dataverse.

:::image type="content" source="media/cannot-use-sorting-or-sorting-not-work-correctly/disablesorting.png" alt-text="Screenshot of the disableSorting attribute." lightbox="media/cannot-use-sorting-or-sorting-not-work-correctly/disablesorting.png":::

If sorting is disabled (`"disableSorting": true`), this is a strong indication that the sorting isn't permitted on the data field (column). For more information about sortable columns, see [Types of columns](/power-apps/maker/data-platform/types-of-fields).

## Scenario 4: Column is sortable but the data isn't ordered correctly

### Troubleshooting step

1. Ensure the column is in the expected format (see the `dataType` and `Format` attributes in the image of scenario 3).

   > [!NOTE]
   > Data sorting is always performed based on the column type and format rather than the actual data. For example, sorting is always "alphabetical" on text type columns, even if all the data in these fields is numeric.

2. Check if the data is sorted (ordered) by more than one column. The presence of sorting icons on more than one column indicates multi-column sorting. In this case, the data sorting is performed on the first sorted column (which is not necessarily the leftmost column) and then on the second column. As shown in the following example, the data is sorted first by the **Full Name** column ascending and then by the **Company Name** column descending.

   :::image type="content" source="media/cannot-use-sorting-or-sorting-not-work-correctly/full-name-company-name-column.png" alt-text="Screenshot of the Full Name and Company Name columns." lightbox="media/cannot-use-sorting-or-sorting-not-work-correctly/full-name-company-name-column.png":::

   The multi-column sorting can be removed by reapplying the sorting on a column (without holding the <kbd>Shift</kbd> key down) or by refreshing the app.

3. The data ordering might be affected by [data customizers](/power-apps/developer/component-framework/customize-editable-grid-control).

   > [!NOTE]
   > Sorting (data ordering) is always applied to raw data, not enhanced data. A typical example is the case where raw numeric data is replaced by a user-friendly text, in which case the ordering is performed by the numeric data.
