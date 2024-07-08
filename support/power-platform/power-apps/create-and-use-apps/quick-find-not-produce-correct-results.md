---
title: Quick Find doesn't return correct results in a model-driven app
description: Solves an issue where the Quick Find feature doesn't return correct results in a Power Apps model-driven app.
ms.reviewer: tapanm, moroch, dinusc
ms.custom: sap:Using grids and lists in model-driven apps
ms.date: 07/08/2024
author: fikaradz
ms.author: fikaradz
---
# Quick Find doesn't return correct results in a model-driven app

This article provides troubleshooting steps for an issue where a [quick find search](/power-apps/user/quick-find) doesn't return correct results in a Power Apps model-driven app.

## Troubleshooting checklist

1. Use the [Power Apps Monitoring tool](/power-apps/maker/monitor-overview) to inspect the [fetchXML](/power-apps/developer/data-platform/use-fetchxml-construct-query) query that is generated based on a [quick find search](/power-apps/user/quick-find).

   :::image type="content" source="media/grid-or-subgrid-not-display-all-records/maximum-number-of-rows.png" alt-text="Screenshot that shows an example of a quick find search.":::

2. Check the `recordsCount` attribute in the fetchXML query.

   :::image type="content" source="media/grid-or-subgrid-displays-incorrect-content/gridchecker.png" alt-text="Screenshot that shows a fetchXML query that contains the recordsCount attribute." lightbox="media/grid-or-subgrid-displays-incorrect-content/gridchecker.png":::

3. The Quick Find filter is marked with the `isquickfindfields` attribute.

   :::image type="content" source="media/quick-find-not-produce-correct-results/isquickfindfields.png" alt-text="Screenshot that shows a fetchXML query that contains the isquickfindfields attribute.":::

   If the columns from the `isquickfindfields` filters aren't correct, this is a strong indication that the [Use quick find view of an entity for searching on grids and subgrids](/power-platform/admin/settings-features#search) setting for your organization isn't set correctly.

   - If the setting is turned off, the search will be performed on all the searchable columns. For more information, see [Types of columns](/power-apps/maker/data-platform/types-of-fields).
   - If the setting is enabled, the search will be performed based on entity's quick find view. Also note that the entity's quick find view might also contain a filter that will also be applied on a search. You should be able to see that filter in the inspected fetchXML data query.

## More information

- [About quick find queries](/power-apps/developer/data-platform/quick-find)
- [Best Practices for Dynamics 365 CRM Quick Find View](https://community.dynamics.com/blogs/post/?postid=0ffbe287-8d5e-488f-a50d-737c7c5c0732)
