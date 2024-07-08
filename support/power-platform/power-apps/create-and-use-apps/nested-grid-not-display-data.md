---
title: Nested grid doesn't display data
description: Solves an issue where a nested grid doesn't display data in a Power Apps model-driven app.
ms.reviewer: tapanm, moroch, dinusc
ms.custom: sap:Using grids and lists in model-driven apps
ms.date: 07/08/2024
author: fikaradz
ms.author: fikaradz
---
# A nested grid doesn't display data in a Power Apps model-driven app

This article provides troubleshooting steps for an issue where a [nested grid](/power-apps/maker/model-driven-apps/the-power-apps-grid-control) doesn't display any data in a Power Apps model-driven app.

## Cause

The most common issue is incorrect relationship used or incorrect view applied.

## Troubleshooting checklist

1. Make sure the nested grid is configured with a correct relationship.

   The [Child Items Parent Id](/power-apps/maker/model-driven-apps/the-power-apps-grid-control#configure-the-power-apps-grid-control) parameter must be set to a Lookup type field from the entity that's assigned to the parent grid (the **Accounts** in the following screenshot). The Lookup field should point to the nested grid entity. Make sure this is a standard Lookup type with a standard N:1 (many-to-one) relationship.

   :::image type="content" source="media/nested-grid-not-display-data/child-items-parent-id.png" alt-text="Screenshot that shows the Child Items Parent Id parameter in Power Apps grid control.":::

2. Check if the view that's assigned to the nested grid (the **My Active Accounts** in step 1) doesn't contain any unintended filters.

3. Use the [Power Apps Monitoring tool](/power-apps/maker/monitor-overview) to inspect the data for the nested grid.

   :::image type="content" source="media/nested-grid-not-display-data/nested-grid-data.png" alt-text="Screenshot that shows the inspected data for a nested grid." lightbox="media/nested-grid-not-display-data/nested-grid-data.png":::

   > [!NOTE]
   > The `childRecordsCount` attribute should display the number of records in the nested dataset. If that attribute shows **0**, this is a strong indication of an incorrect relationship specified, the presence of extra filters in the nested grid view, or no records in the nested dataset (`ChildItems`). If that number shows a greater than zero value and your nested grid still doesn't display any records, the issue is most likely with the extra filtering present in the nested grid view or with no related records to the row that's expanded from the parent grid. Check the `childViewFetchXML` and `ChildViewFields` and make sure all the filters are correct and all the column definitions match the ones specified in `childViewFetchXML`.
