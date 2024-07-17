---
title: Nested grid doesn't display data in a model-driven app
description: Troubleshoots an issue where a nested grid doesn't display data in a Power Apps model-driven app.
ms.reviewer: tapanm, moroch, dinusc
ms.custom: sap:Using grids and lists in model-driven apps
ms.date: 07/17/2024
author: fikaradz
ms.author: fikaradz
---
# A nested grid doesn't display data in a Power Apps model-driven app

This article provides troubleshooting steps for an issue where a [nested grid](/power-apps/maker/model-driven-apps/the-power-apps-grid-control) doesn't display any data in a Power Apps model-driven app.

## Cause

The most common reason is using an incorrect relationship or applying an incorrect view.

## Troubleshooting checklist

1. Make sure the nested grid is configured with the correct relationship.

   The [Child Items Parent Id](/power-apps/maker/model-driven-apps/the-power-apps-grid-control#configure-the-power-apps-grid-control) parameter must be set to a lookup type field from the entity assigned to the parent grid (the **Accounts** in the following screenshot). The lookup field should point to the nested grid entity. Make sure it's a standard lookup type with a standard N:1 (many-to-one) relationship.

   :::image type="content" source="media/nested-grid-not-display-data/child-items-parent-id.png" alt-text="Screenshot that shows the Child Items Parent ID parameter in Power Apps grid control.":::

2. Check if the view assigned to the nested grid (the **My Active Accounts** in step 1) contains any unexpected filters.

3. Use the [Power Apps Monitor tool](/power-apps/maker/monitor-overview) to inspect the data for the nested grid.

   :::image type="content" source="media/nested-grid-not-display-data/nested-grid-data.png" alt-text="Screenshot that shows the inspected data for a nested grid." lightbox="media/nested-grid-not-display-data/nested-grid-data.png":::

   > [!NOTE]
   > The `childRecordsCount` attribute should display the number of records in the nested dataset. If that attribute shows `0`, it's a strong indication of an incorrect relationship specified, the presence of extra filters in the nested grid view, or no records in the nested dataset (`ChildItems`). If that number shows a value greater than zero, and your nested grid still doesn't display any records, the issue is most likely with the extra filtering in the nested grid view or there being no records related to the row expanded from the parent grid. Check the `childViewFetchXML` and `ChildViewFields` and make sure all the filters are correct and that all the column definitions match those specified in the `childViewFetchXML`.

## See also

[Troubleshooting grid issues in Power Apps](grid-issues.md)
